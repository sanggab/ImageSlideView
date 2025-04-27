//
//  ImageSlideView.swift
//  UIComponentsShared
//
//  Created by Gab on 4/25/25.
//  Copyright © 2025 com.yeoboya.siso. All rights reserved.
//

import SwiftUI

public enum ImageSlideDataType {
    case data
    case image
//    case url
}

public struct ImageSlideView<DataType: Sendable>: View {
    
//    public let
    @State private var selection: Int = 0
    @State private var cropImage: [UIImage] = []
    @State private var isPresented: Bool = false
//    @State private var selectedImage:
    let image: [DataType]
    
    let dataType: ImageSlideDataType
    
    public init(
        image: [DataType],
        dataType: ImageSlideDataType
    ) {
        self.image = image
        self.dataType = dataType
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
//                UIComponentsSharedAsset.Icons.icoArrowLeft.swiftUIImage
//                    .resizable()
//                    .renderingMode(.template)
//                    .foregroundStyle(.grayFF1)
//                    .frame(width: 32, height: 32)
                
                Text("뒤로가기")
                
                Spacer()
                
                Text("\(selection + 1)/\(image.count)")
//                    .font(.m24)
                    .foregroundStyle(.white)
                
                Spacer()
                
                Text("완료")
//                    .font(.m24)
//                    .foregroundStyle(.org400)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 20)
            .frame(height: 50)
            
            TabView(selection: $selection) {
                ForEach(0..<image.count, id: \.self) { index in
                    getImage(index: index)
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
                                    isPresented = true
                                }
                        }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .padding(.top, -50)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
//        .fullScreenCover(isPresented: $isPresented) {
//            ImageCropView(image: image[selection])
//        }
    }
    
    @ViewBuilder
    func getImage(index: Int) -> some View {
        switch dataType {
        case .data:
            if let data = image[index] as? Data, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                EmptyView()
            }
        case .image:
            if let image = image[index] as? UIImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                EmptyView()
            }
//        case .url:
//            if let urlString = image[index] as? String,
//            let url = URL(string: urlString) {
//                
//            } else {
//                EmptyView()
//            }
        }
    }
}


#Preview {
    ImageSlideView<UIImage>(image: [
        UIImage(named: "도화가3")!,
        UIImage(named: "도화가4")!
    ], dataType: .image)
}
