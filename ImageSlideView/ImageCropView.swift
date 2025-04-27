//
//  ImageCropView.swift
//  UIComponentsShared
//
//  Created by Gab on 4/25/25.
//  Copyright © 2025 com.yeoboya.siso. All rights reserved.
//

import SwiftUI
import Mantis
import Kingfisher

struct ImageCropView: UIViewControllerRepresentable {
    
    var image: UIImage
    
    func makeUIViewController(context: Context) -> UIViewController {
        var config = Mantis.Config()
        config.cropShapeType = .rect
        config.presetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 4.0 / 3.0)
//        let image = UIImage
        let cropViewController = Mantis.cropViewController(image: image, config: config)
        cropViewController.delegate = context.coordinator
        return cropViewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, CropViewControllerDelegate {
        func cropViewControllerDidCrop(_ cropViewController: Mantis.CropViewController, cropped: UIImage, transformation: Mantis.Transformation, cropInfo: Mantis.CropInfo) {
            print("\(#function) cropViewController: \(cropViewController)")
            print("\(#function) cropped: \(cropped)")
            print("\(#function) transformation: \(transformation)")
            print("\(#function) cropInfo: \(cropInfo)")
            cropViewController.dismiss(animated: true)
        }
        
        func cropViewControllerDidFailToCrop(_ cropViewController: Mantis.CropViewController, original: UIImage) {
            print("\(#function) original: \(original)")
        }
        
        func cropViewControllerDidCancel(_ cropViewController: Mantis.CropViewController, original: UIImage) {
            print("\(#function) original: \(original)")
            cropViewController.dismiss(animated: true)
        }
        
        func cropViewControllerDidBeginResize(_ cropViewController: Mantis.CropViewController) {
            print("\(#function) cropViewController: \(cropViewController)")
        }
        
        func cropViewControllerDidEndResize(_ cropViewController: Mantis.CropViewController, original: UIImage, cropInfo: Mantis.CropInfo) {
            print("\(#function) cropViewController: \(cropViewController)")
            print("\(#function) original: \(original)")
            print("\(#function) cropInfo: \(cropInfo)")
//            cropViewController.dismiss(animated: true)
        }
        
        
    }
}
