//
//  BMAssetsListViewController.swift
//  Pods
//
//  Created by BrikerMan on 16/8/18.
//
//

import UIKit

class BMAssetsListViewController: UIViewController {

    var album:BMAlbum!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
    }

    
    
}


