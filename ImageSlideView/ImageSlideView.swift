//
//  ImageSlideView.swift
//  UIComponentsShared
//
//  Created by Gab on 4/25/25.
//  Copyright © 2025 com.yeoboya.siso. All rights reserved.
//

import SwiftUI

public struct ImageSlideView: View {
    
//    public let
    @State private var selection: Int = 0
    @State private var cropImage: [UIImage] = []
    let image: [UIImage]
    
    public init(
        image: [UIImage]
    ) {
//        self.selection = selection
//        self.cropImage = cropImage
        self.image = image
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
                ForEach(0..<image.count, id: \.self) { data in
                    Image(uiImage: image[data])
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
                        }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .padding(.top, -50)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}


#Preview {
    ImageSlideView(image: [
        UIImage(named: "도화가3")!,
        UIImage(named: "도화가4")!
    ])
}
