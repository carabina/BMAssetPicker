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
    
    weak var delegate: BMAssetPickerPickDelegate?
    
    var album:BMAlbum!
    
    var doneButton: UIBarButtonItem!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    func selectFinishedButtonPressed() {
        delegate?.pickerDidFinishSelect()
    }
    
    
    /**
     取消选择 Asset 时更新数字
     */
    func updateSelectedCellsIndex() {
        for cell in collectionView.visibleCells() {
            if let cell = cell as? BMAssetsListCollectionViewCell where cell.assetSelected {
                cell.updateUI(animated: false)
            }
        }
    }
    
    
    func setupView() {
        title = album.collection.localizedTitle
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.whiteColor()
        let cellNib = UINib(nibName: "BMAssetsListCollectionViewCell", bundle: BMAssetBundle)
        collectionView.registerNib(cellNib, forCellWithReuseIdentifier: "BMAssetsListCollectionViewCell")
        
        doneButton = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.selectFinishedButtonPressed))
        self.navigationItem.rightBarButtonItem = doneButton
        
        doneButton.enabled = !BMAssetManager.selectedAssets.isEmpty
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
            // Remove From Selected List
            delegate?.pickerDidDeselectAsset(asset)
            BMAssetManager.selectedAssets.bm_removeObject(asset)
            updateSelectedCellsIndex()
        } else {
            // Add to Selected List
            delegate?.pickerDidSelectAsset(asset)
            BMAssetManager.selectedAssets.append(asset)
        }
        
        cell.updateUI()
        doneButton.enabled = !BMAssetManager.selectedAssets.isEmpty
    }
}

extension BMAssetsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let ScreenWidth = UIScreen.mainScreen().bounds.width
        let cellWidth   = (ScreenWidth - 2 * 2)/3
        return CGSize(width: cellWidth, height: cellWidth)
    }
}