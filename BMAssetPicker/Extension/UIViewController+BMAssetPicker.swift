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
    /**
     Present a given image picker with closures, any of the closures can be nil.
     
     - parameter imagePicker: a BSImagePickerViewController to present
     - parameter animated: To animate the presentation or not
     - parameter select: Closure to call when user selects an asset or nil
     - parameter deselect: Closure to call when user deselects an asset or nil
     - parameter cancel: Closure to call when user cancels or nil
     - parameter finish: Closure to call when user finishes or nil
     - parameter completion: presentation completed closure or nil
     */
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