//
//  UIViewController+BMAssetPicker.swift
//  Pods
//
//  Created by BrikerMan on 16/8/18.
//
//

import Foundation
import Photos

public extension UIViewController {
    func bm_presentImagePickerController(imagePicker: BMAssetPicker, animated: Bool, select: ((asset: PHAsset) -> Void)?, deselect: ((asset: PHAsset) -> Void)?, cancel: (([PHAsset]) -> Void)?, finish: (([PHAsset]) -> Void)?, completion: (() -> Void)?) {
        
        // Set blocks
        imagePicker.selectionClosure = select
        imagePicker.deselectionClosure = deselect
        imagePicker.cancelClosure = cancel
        imagePicker.finishClosure = finish
        
        // Present
        self.presentViewController(imagePicker, animated: animated, completion: completion)
    }
}