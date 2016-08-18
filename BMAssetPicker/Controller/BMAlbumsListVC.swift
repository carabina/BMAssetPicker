//
//  BMAlbumsListVC.swift
//  Pods
//
//  Created by BrikerMan on 16/8/18.
//
//

import UIKit
import Photos


class BMAlbumsListVC: UIViewController {

    weak var picker: BMAssetPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()
        fetchAssetCollections()
    }

    
    func fetchAssetCollections() {
        var fetchResults = [PHFetchResult]()
        for subType in picker.assetCollectionSubtypes {
            let type   = subType.collectionType
            let result = PHAssetCollection.fetchAssetCollectionsWithType(type, subtype: subType, options: nil)
            fetchResults.append(result)
            print(result)
        }
    }
   
}