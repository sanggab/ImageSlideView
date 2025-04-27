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

public struct ImageCropView: UIViewControllerRepresentable {
    
    @Binding var image: UIImage
    
    public func makeUIViewController(context: Context) -> UIViewController {
        var config: Mantis.Config = .init()
        config.cropShapeType = .rect
        config.presetFixedRatioType = .alwaysUsingOnePresetFixedRatio(ratio: 4.0 / 3.0)
        let cropViewController: Mantis.CropViewController = Mantis.cropViewController(image: image, config: config)
        cropViewController.delegate = context.coordinator
        return cropViewController
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image)
    }
    
    public class Coordinator: NSObject, CropViewControllerDelegate {
        @Binding private var image: UIImage
        
        public init(image: Binding<UIImage>) {
            self._image = image
        }
        
        public func cropViewControllerDidCrop(_ cropViewController: Mantis.CropViewController, cropped: UIImage, transformation: Mantis.Transformation, cropInfo: Mantis.CropInfo) {
            self.image = cropped
            cropViewController.dismiss(animated: true)
        }
        
        public func cropViewControllerDidFailToCrop(_ cropViewController: Mantis.CropViewController, original: UIImage) {
            
        }
        
        public func cropViewControllerDidCancel(_ cropViewController: Mantis.CropViewController, original: UIImage) {
            cropViewController.dismiss(animated: true)
        }
        
        public func cropViewControllerDidBeginResize(_ cropViewController: Mantis.CropViewController) {
            
        }
        
        public func cropViewControllerDidEndResize(_ cropViewController: Mantis.CropViewController, original: UIImage, cropInfo: Mantis.CropInfo) {
            
        }
    }
}
