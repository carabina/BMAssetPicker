//
//  PHAssetCollection+BMAssetPicker.swift
//  Pods
//
//  Created by BrikerMan on 16/8/18.
//
//

import UIKit
import Photos

extension PHAssetCollectionSubtype {
    var collectionType: PHAssetCollectionType {
        get {
            return (self.rawValue >= PHAssetCollectionSubtype.SmartAlbumGeneric.rawValue) ? PHAssetCollectionType.SmartAlbum : PHAssetCollectionType.Album;
        }
    }
}