//
//  BMAssetsListCollectionViewCell.swift
//  Pods
//
//  Created by BrikerMan on 16/8/18.
//
//

import UIKit
import Photos

class BMAssetsListCollectionViewCell: UICollectionViewCell {
    
    var asset: PHAsset?
    var assetSelected = false
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var selectedIndex: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedView.layer.cornerRadius = 10
        selectedView.layer.borderWidth  = 1
        selectedView.layer.borderColor  = UIColor.whiteColor().CGColor
        selectedView.hidden = true
    }
    
    
    func blind(asset: PHAsset) {
        let scale   = UIScreen.mainScreen().scale
        let newSize = CGSize(width: coverImage.frame.size.width * scale, height: coverImage.frame.size.height * scale)
        
        self.asset = asset
        let options = PHImageRequestOptions()
        options.deliveryMode = .Opportunistic
        PHImageManager.defaultManager().requestImageForAsset(asset,
                                                             targetSize: newSize,
                                                             contentMode: .AspectFill,
                                                             options: options)
        { (result, info) -> Void in
            self.coverImage.image = result
            print(result?.size)
        }
        updateUI(animated: false)
    }
    
    func updateUI(animated animated: Bool = true) {
        if BMAssetManager.selectedAssets.contains(asset!) {
            coverImage.layer.borderColor = BMAssetManager.tintColor.CGColor
            coverImage.layer.borderWidth = 2
            selectedView.hidden = false
            assetSelected = true
            let index = (BMAssetManager.selectedAssets.bm_lastIndexOf(asset!)  ?? 0) + 1
            selectedIndex.text  = "\(index)"
        } else {
            coverImage.layer.borderColor = UIColor.clearColor().CGColor
            coverImage.layer.borderWidth = 0
            selectedView.hidden = true
            assetSelected = false
        }
        
        if !animated {
            return
        }
        
        UIView.animateWithDuration(0.1) { 
            self.mainView.transform = CGAffineTransformMakeScale(0.9, 0.9)
        }
        
        UIView.animateWithDuration(0.1, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { 
            self.mainView.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
    }
}
