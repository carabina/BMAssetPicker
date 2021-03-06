//
//  BMImagePicker.swift
//  Pods
//
//  Created by BrikerMan on 16/8/18.
//
//

import UIKit
import Photos
import PhotosUI

protocol BMAssetPickerPickDelegate: class {
    func pickerDidSelectAsset(asset:PHAsset)
    func pickerDidDeselectAsset(asset:PHAsset)
    func pickerDidFinishSelect()
}

public class BMAssetPicker: UIViewController {
    
    var assetCollectionSubtypes = [PHAssetCollectionSubtype]()
    var albums:[BMAlbum] = []
    
    var selectionClosure: ((asset: PHAsset) -> Void)?
    var deselectionClosure: ((asset: PHAsset) -> Void)?
    var cancelClosure: ((assets: [PHAsset]) -> Void)?
    var finishClosure: ((assets: [PHAsset]) -> Void)?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        initAssetCollectionSubtypes()
        view.backgroundColor = UIColor.whiteColor()
        BMAssetPicker.authorize { (authorized) in
            if authorized {
                self.fetchAssetCollections()
                self.addBaseController()
            } else {
                
            }
        }
    }
    
    func cancelButtonPressed() {
        cancelClosure?(assets:BMAssetManager.selectedAssets)
        BMAssetManager.selectedAssets.removeAll()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func doneButtonPressed() {
        finishClosure?(assets:BMAssetManager.selectedAssets)
        BMAssetManager.selectedAssets.removeAll()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func addBaseController() {
        let vc  = BMAlbumsListVC()
        vc.albums = self.albums
        vc.picker = self
        
        let nav = UINavigationController(rootViewController: vc)
        nav.view.frame = self.view.frame
        self.addChildViewController(nav)
        self.view.addSubview(nav.view)
    }
    
    
    func initAssetCollectionSubtypes() {
        assetCollectionSubtypes = [PHAssetCollectionSubtype.SmartAlbumUserLibrary,
                                   PHAssetCollectionSubtype.AlbumMyPhotoStream,
                                   PHAssetCollectionSubtype.SmartAlbumRecentlyAdded,
                                   PHAssetCollectionSubtype.SmartAlbumFavorites,
                                   PHAssetCollectionSubtype.SmartAlbumPanoramas,
                                   PHAssetCollectionSubtype.SmartAlbumVideos,
                                   PHAssetCollectionSubtype.SmartAlbumSlomoVideos,
                                   PHAssetCollectionSubtype.SmartAlbumTimelapses,
                                   PHAssetCollectionSubtype.SmartAlbumBursts,
                                   PHAssetCollectionSubtype.SmartAlbumAllHidden,
                                   PHAssetCollectionSubtype.SmartAlbumGeneric,
                                   PHAssetCollectionSubtype.AlbumRegular,
                                   PHAssetCollectionSubtype.AlbumSyncedAlbum,
                                   PHAssetCollectionSubtype.AlbumSyncedEvent,
                                   PHAssetCollectionSubtype.AlbumSyncedFaces,
                                   PHAssetCollectionSubtype.AlbumImported,
                                   PHAssetCollectionSubtype.AlbumCloudShared]
        
        if #available(iOS 9, *) {
            assetCollectionSubtypes.insert(PHAssetCollectionSubtype.SmartAlbumSelfPortraits, atIndex: 4)
            assetCollectionSubtypes.insert(PHAssetCollectionSubtype.SmartAlbumScreenshots,   atIndex: 10)
        }
    }
    
    func fetchAssetCollections() {
        for subType in self.assetCollectionSubtypes {
            let type   = subType.collectionType
            let result = PHAssetCollection.fetchAssetCollectionsWithType(type, subtype: subType, options: nil)
            
            // 从 PHFetchResult 获取相册的 PHAssetCollection
            for i in 0..<result.count {
                // PHFetchResult 可能包含 PHAsset 或者 PHAssetCollection，此时我们需要的是 PHAssetCollection
                if let collection = result[i] as? PHAssetCollection {
                    
                    let fetchOptions = PHFetchOptions()
                    fetchOptions.sortDescriptors = [
                        NSSortDescriptor(key: "creationDate", ascending: false)
                    ]
                    fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.Image.rawValue)
                    
                    // 获取相册里面具体的资源列表
                    let result = PHAsset.fetchAssetsInAssetCollection(collection, options: fetchOptions)
                    if result.count != 0 {
                        albums.append((collection,result))
                    }
                    
                    
                } else {
                    "Fetch collection not PHCollection: \(result[i])"
                }
            }
        }
    }
    
    public class func authorize(status: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus(), completion: (authorized: Bool) -> Void) {
        switch status {
        case .Authorized:
            // We are authorized. Run block
            completion(authorized: true)
        case .NotDetermined:
            // Ask user for permission
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.authorize(status, completion: completion)
                })
            })
        default: ()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            completion(authorized: false)
        })
        }
    }
}

extension BMAssetPicker: BMAssetPickerPickDelegate {
    func pickerDidFinishSelect() {
        self.doneButtonPressed()
    }
    
    
    func pickerDidSelectAsset(asset: PHAsset) {
        self.selectionClosure?(asset: asset)
    }
    
    
    func pickerDidDeselectAsset(asset: PHAsset) {
        self.deselectionClosure?(asset: asset)
    }
}