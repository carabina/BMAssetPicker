//
//  BMAssetsListViewController.swift
//  Pods
//
//  Created by BrikerMan on 16/8/18.
//
//

import UIKit
import Photos

class BMAssetsListViewController: UIViewController {

    var album:BMAlbum!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        let cellNib = UINib(nibName: "BMAssetsListCollectionViewCell", bundle: BMAssetBundle)
        collectionView.registerNib(cellNib, forCellWithReuseIdentifier: "BMAssetsListCollectionViewCell")
        
    }

    
    
}

extension BMAssetsListViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.album.asstes.count
    }
   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BMAssetsListCollectionViewCell", forIndexPath: indexPath) as! BMAssetsListCollectionViewCell
        cell.blind(self.album.asstes[indexPath.row] as! PHAsset)
        return cell
    }

}


extension BMAssetsListViewController: UICollectionViewDelegate {
    
}

extension BMAssetsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let ScreenWidth = UIScreen.mainScreen().bounds.width
        let cellWidth   = (ScreenWidth - 3 * 2)/4
        return CGSize(width: cellWidth, height: cellWidth)
    }
}