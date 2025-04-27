//
//  ImageSlideView.swift
//  UIComponentsShared
//
//  Created by Gab on 4/25/25.
//  Copyright © 2025 com.yeoboya.siso. All rights reserved.
//

import SwiftUI
import Mantis

public enum ImageSlideDataType {
    case data
    case image
    case url
}

public struct ImageSlideView<DataType: Sendable>: View {
    
    @State private var selection: Int = 0
    @State private var cropImage: [UIImage] = []
    @State private var showCropVC: Bool = false
    
    @Binding private var isPresented: Bool
    
    private let originalImage: [DataType]
    
    private var onCompleteClosure: (([UIImage]) -> Void)?
    
    public init(
        isPresented: Binding<Bool>,
        item: [DataType]
    ) {
        self._isPresented = isPresented
        self.originalImage = item
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
//                UIComponentsSharedAsset.Icons.icoArrowLeft.swiftUIImage
//                    .resizable()
//                    .renderingMode(.template)
//                    .foregroundStyle(.grayFF1)
//                    .frame(width: 32, height: 32)
                
                Button {
                    isPresented = false
                } label: {
                    Text("뒤로가기")
                }
                
                Spacer()
                
                Text(getCount())
//                    .font(.m24)
                    .foregroundStyle(.white)
                
                Spacer()
                
                Button {
                    onCompleteClosure?(cropImage)
                    isPresented = false
                } label: {
                    Text("완료")
                }

            }
            .padding(.horizontal, 20)
            .frame(height: 50)
            
            TabView(selection: $selection) {
                Group {
                    ForEach(0..<cropImage.count, id: \.self) { index in
                        Image(uiImage: cropImage[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay(alignment: .bottom) {
                                Text("수정하기")
                                    .foregroundStyle(.mint)
                                    .padding(.all, 5)
                                    .background {
                                        Capsule()
                                            .fill(.yellow)
                                    }
                                    .padding(.bottom, 25)
                                    .onTapGesture {
                                        showCropVC = true
                                    }
                            }
                    }
                }
                .padding(.top, -50)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .fullScreenCover(isPresented: $showCropVC) {
            ImageCropView(image: $cropImage[selection])
        }
        .task {
            do {
                let cropImages: [UIImage] = try await self.originalImage.asyncMap { item in
                    return try await getUIImage(item: item)
                }
                self.cropImage = cropImages
            } catch {
                print("getUIImage error: \(error)")
            }
        }
    }
    
    @MainActor
    func getUIImage(item: DataType) async throws -> UIImage {
        switch item {
        case let imageData as Data:
            if let image = UIImage(data: imageData) {
                return image
            } else {
                return .init()
            }
        case let oriImage as UIImage:
            return oriImage
        case let urlString as String:
            if let url = URL(string: urlString) {
                let (data , _) = try await URLSession.shared.data(from: url)
                
                if let image = UIImage(data: data) {
                    return image
                } else {
                    return .init()
                }
            } else {
                return .init()
            }
        default:
            return .init()
        }
    }
    
    func getCount() -> String {
        if cropImage.count > 0 {
            return "\(selection + 1)/\(cropImage.count)"
        } else {
            return "0/0"
        }
    }
    
    func onCompleted(_ items: @escaping (([UIImage]) -> Void)) -> ImageSlideView<DataType> {
        var view: ImageSlideView<DataType> = self
        view.onCompleteClosure = items
        return view
    }
}


#Preview {
    ImageSlideView(isPresented: .constant(false), item: [
        "https://blog.kakaocdn.net/dn/ccQnmC/btrqbGYaDhI/BIYbAn8lfuHr9PHH3KFUgk/img.png",
        "https://upload3.inven.co.kr/upload/2023/06/17/bbs/i13155390803.webp?MW=360"
//        UIImage(named: "도화가3")!,
//        UIImage(named: "도화가4")!
    ])
}

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}
