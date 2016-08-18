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
        self.presentViewController(vc, animated: true, completion: nil)
    }

}

