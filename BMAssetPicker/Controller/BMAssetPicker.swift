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

public class BMAssetPicker: UIViewController {
    
    var assetCollectionSubtypes = [PHAssetCollectionSubtype]()
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        initAssetCollectionSubtypes()
        
        BMAssetPicker.authorize { (authorized) in
            if authorized {
                self.addBaseController()
            } else {
                
            }
        }
    }
    
    
    func checkAuthorizationStatus() {
        
    }
    
    
    func addBaseController() {
        let vc  = BMAlbumsListVC()
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
            assetCollectionSubtypes.insert(PHAssetCollectionSubtype.SmartAlbumScreenshots, atIndex: 10)
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

