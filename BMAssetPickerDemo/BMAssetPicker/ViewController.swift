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
                print("selected \(asset)")
            }, deselect: { (asset) in
                print("deselect \(asset)")
            }, cancel: { (assets) in
                
            }, finish: { (assets) in
                
            }, completion: nil)
    }

}

