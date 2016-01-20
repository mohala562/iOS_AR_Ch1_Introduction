//
//  Cocos2DViewController.swift
//  AR_Chapter1
//
//  Created by jiao qing on 20/1/16.
//  Copyright © 2016 jiao qing. All rights reserved.
//

import UIKit

class Cocos2DViewController: UIViewController {
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.sourceType = .Camera
        imagePicker.showsCameraControls = false
        imagePicker.toolbarHidden = true
        imagePicker.navigationBarHidden = true
        //imagePicker.delegate = self
        imagePicker.allowsEditing = false
 
        cameraView.addSubview(imagePicker.view)
    }
 

}
