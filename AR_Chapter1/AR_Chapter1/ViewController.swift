//
//  ViewController.swift
//  AR_Chapter1
//
//  Created by jiao qing on 18/1/16.
//  Copyright © 2016 jiao qing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        CheckHardWare.camera()
        CheckHardWare.magnetometer()
        CheckHardWare.audio()
    }

 

}

