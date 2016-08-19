//
//  BMAssetPickerManager.swift
//  Pods
//
//  Created by BrikerMan on 16/8/18.
//
//

import Foundation
import Photos

let BMAssetManager = BMAssetPickerManager.shared

class BMAssetPickerManager {
    static let shared = BMAssetPickerManager()
    
    var selectedAssets: Set<PHAsset> = []
}