//
//  ImageSlideViewApp.swift
//  ImageSlideView
//
//  Created by 심상갑 on 4/27/25.
//

import SwiftUI

@main
struct ImageSlideViewApp: App {
    var body: some Scene {
        WindowGroup {
            ImageSlideView<UIImage>(image: [
                UIImage(named: "도화가3")!,
                UIImage(named: "도화가4")!
            ], dataType: .image)
//            ImageSlideView<String>(image: [
//                "https://blog.kakaocdn.net/dn/ccQnmC/btrqbGYaDhI/BIYbAn8lfuHr9PHH3KFUgk/img.png",
//                "https://upload3.inven.co.kr/upload/2023/06/17/bbs/i13155390803.webp?MW=360"
//            ], dataType: .url)
        }
    }
}
