//
//  BMAssetPickerManager.swift
//  Pods
//
//  Created by BrikerMan on 16/8/18.
//
//

import Foundation
import Photos

public let BMAssetManager = BMAssetPickerManager.shared

public class BMAssetPickerManager {
    static let shared = BMAssetPickerManager()
    
    var selectedAssets: [PHAsset] = []
    
    public var tintColor = UIColor.blueColor()
}



