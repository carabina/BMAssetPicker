//
//  BMAlbumsListVC.swift
//  Pods
//
//  Created by BrikerMan on 16/8/18.
//
//

import UIKit
import Photos
import SnapKit

class BMAlbumsListVC: UIViewController {
    
    weak var picker : BMAssetPicker!
    var albums:[BMAlbum] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        automaticallyAdjustsScrollViewInsets = false
        title = "相册"
        view.backgroundColor = UIColor.whiteColor()
        
        let tableView = UITableView()
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.rowHeight  = 90
        tableView.separatorStyle = .None
        tableView.clipsToBounds  = false
        
        self.view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0))
        }
        
        let albumCell = UINib(nibName: "BMAssetAlbumListTableViewCell", bundle: BMAssetBundle)
        tableView.registerNib(albumCell, forCellReuseIdentifier: "BMAssetAlbumListTableViewCell")
        
        
        let navLeftButton = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.cancelAction))
        self.navigationItem.leftBarButtonItem = navLeftButton
            
        
    }
    
    
    func cancelAction() {
        picker.cancelButtonPressed()
    }
}

extension BMAlbumsListVC: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BMAssetAlbumListTableViewCell") as! BMAssetAlbumListTableViewCell
        cell.blind(albums[indexPath.row])
        return cell
    }
}

extension BMAlbumsListVC: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = BMAssetsListViewController(nibName: "BMAssetsListViewController", bundle: BMAssetBundle)
        vc.album = albums[indexPath.row]
        vc.delegate = self.picker
        self.navigationController?.pushViewController(vc, animated: true)
    }
}