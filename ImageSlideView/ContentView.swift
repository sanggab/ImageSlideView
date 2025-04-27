//
//  ContentView.swift
//  ImageSlideView
//
//  Created by 심상갑 on 4/27/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    @State private var images: [UIImage] = []
    
    var body: some View {
        Text("열어")
            .onTapGesture {
                isPresented = true
            }
        
        ScrollView {
            ForEach(images, id: \.self) { image in
                Image(uiImage: image)
            }
        }
        .fullScreenCover(isPresented: $isPresented) {
            ImageSlideView(isPresented: $isPresented,
                           item: [
                "https://blog.kakaocdn.net/dn/ccQnmC/btrqbGYaDhI/BIYbAn8lfuHr9PHH3KFUgk/img.png",
                "https://upload3.inven.co.kr/upload/2023/06/17/bbs/i13155390803.webp?MW=360"
            ])
            .onCompleted { items in
                print("\(#function) items: \(items)")
                self.images = items
            }
        }
    }
}

#Preview {
    ContentView()
}
