//
//  BMAssetAlbumListTableViewCell.swift
//  Pods
//
//  Created by BrikerMan on 16/8/18.
//
//

import UIKit
import Photos

class BMAssetAlbumListTableViewCell: UITableViewCell {
    
    var collection: PHAssetCollection!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageCountLabel: UILabel!
    
    @IBOutlet weak var imageView0: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView1.hidden = true
        imageView2.hidden = true
    }

    func blind(album:BMAlbum) {
        self.collection = album.collection
        self.nameLabel.text = collection.localizedTitle
        self.imageCountLabel.text = "\(album.asstes.count)"
        
        self.imageView0.image = nil
        self.imageView1.image = nil
        self.imageView2.image = nil
        
        self.imageView1.hidden = true
        self.imageView2.hidden = true
        
        
        album.asstes.enumerateObjectsUsingBlock { (object, idx, stop) in
            if let asset = object as? PHAsset {
                let imageSize = BMAlbumListThumbnailSize
                let imageContentMode: PHImageContentMode = .AspectFill
                switch idx {
                case 0:
                    PHCachingImageManager.defaultManager().requestImageForAsset(asset, targetSize: imageSize, contentMode: imageContentMode, options: nil) { (result, _) in
                        self.imageView0.image = result
                    }
                case 1:
                    PHCachingImageManager.defaultManager().requestImageForAsset(asset, targetSize: imageSize, contentMode: imageContentMode, options: nil) { (result, _) in
                        self.imageView1.image = result
                        self.imageView1.hidden = false
                    }
                case 2:
                    PHCachingImageManager.defaultManager().requestImageForAsset(asset, targetSize: imageSize, contentMode: imageContentMode, options: nil) { (result, _) in
                        self.imageView2.image  = result
                        self.imageView2.hidden = false
                    }
                    
                default:
                    // Stop enumeration
                    stop.initialize(true)
                }
            }
        }
    }
    
}
