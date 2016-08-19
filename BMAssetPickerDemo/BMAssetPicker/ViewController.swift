//
//  ViewController.swift
//  BMAssetPicker
//
//  Created by Eliyar Eziz on 08/18/2016.
//  Copyright (c) 2016 Eliyar Eziz. All rights reserved.
//

import UIKit
import BMAssetPicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func onPresentButtonPressed(sender: AnyObject) {
        let vc = BMAssetPicker()
        bm_presentImagePickerController(vc, animated: true, select: { (asset) in
                print("******* 选择Asset ******* \n \(asset)")
            }, deselect: { (asset) in
                print("******* 取消选择Asset ******* \n  \(asset)")
            }, cancel: { (assets) in
                print("******* 取消 ******* \n \(assets)")
            }, finish: { (assets) in
                print("******* 完成 ******* \n \(assets)")
            }, completion: nil)
    }

}

