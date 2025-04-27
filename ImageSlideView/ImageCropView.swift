////
////  ImageCropView.swift
////  UIComponentsShared
////
////  Created by Gab on 4/25/25.
////  Copyright © 2025 com.yeoboya.siso. All rights reserved.
////
//
//import SwiftUI
//import Mantis
//
//public struct ImageCropView: UIViewControllerRepresentable {
//    
//    @Binding var image: UIImage
//    
//    func makeUIViewController(context: Context) -> UIViewController {
//        var config = Mantis.Config()
//        config.cropViewConfig.cropShapeType = cropShapeType
//        config.presetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 4.0 / 3.0)
//        let cropViewController = Mantis.cropViewController(image: <#T##UIImage#>, config: <#T##Config#>)
//        cropViewController.delegate = context.coordinator
//        return cropViewController
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        
//    }
//}
