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
        }
    }
}
