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
    
    @IBOutlet weak var coverImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.grayColor()
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
        updateUI()
    }
    
    func updateUI() {
        if BMAssetManager.selectedAssets.contains(asset!) {
            coverImage.layer.borderColor = UIColor ( red: 0.9452, green: 0.0, blue: 1.0, alpha: 1.0 ).CGColor
            coverImage.layer.borderWidth = 3
        } else {
            coverImage.layer.borderColor = UIColor.clearColor().CGColor
            coverImage.layer.borderWidth = 0
            
        }
    }
}
