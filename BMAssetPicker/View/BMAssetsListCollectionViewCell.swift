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
    
    @IBOutlet weak var coverImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.grayColor()
    }
    
    
    func blind(asset: PHAsset) {
        let scale   = UIScreen.mainScreen().scale
        let newSize = CGSize(width: coverImage.frame.size.width * scale, height: coverImage.frame.size.height * scale)
        
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
    }
}
