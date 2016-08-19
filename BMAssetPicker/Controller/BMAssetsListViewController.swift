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
    weak var delegate: BMAssetPickerPickDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.whiteColor()
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
        let asset = self.album.asstes[indexPath.row] as! PHAsset
        cell.blind(asset)
        return cell
    }

}


extension BMAssetsListViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell  = collectionView.cellForItemAtIndexPath(indexPath) as! BMAssetsListCollectionViewCell
        let asset = cell.asset!
        if BMAssetManager.selectedAssets.contains(asset) {
            delegate?.pickerDidDeselectAsset(asset)
            BMAssetManager.selectedAssets.remove(asset)
        } else {
            delegate?.pickerDidSelectAsset(asset)
            BMAssetManager.selectedAssets.insert(asset)
        }
        cell.updateUI()
    }
}

extension BMAssetsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let ScreenWidth = UIScreen.mainScreen().bounds.width
        let cellWidth   = (ScreenWidth - 3 * 2)/4
        return CGSize(width: cellWidth, height: cellWidth)
    }
}