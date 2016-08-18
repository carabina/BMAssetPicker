//
//  BMAssetMacros.swift
//  Pods
//
//  Created by BrikerMan on 16/8/18.
//
//

import UIKit
import Photos

typealias BMAlbum = (collection:PHAssetCollection, asstes:PHFetchResult)

var BMAssetBundle: NSBundle { get {
    let podBundle = NSBundle(forClass: BMAlbumsListVC.self)
    if let bundleURL = podBundle.URLForResource("BMAssetPicker", withExtension: "bundle") {
        if let bundle = NSBundle(URL: bundleURL) {
            return bundle
        }else {
            assertionFailure("Could not load the bundle")
        }
    }else {
        assertionFailure("Could not create a path to the bundle")
    }
    return NSBundle() }
}

var BMAlbumListThumbnailSize: CGSize { get {
    let width = 70 * UIScreen.mainScreen().scale
    return CGSize(width: width, height: width) }
}

