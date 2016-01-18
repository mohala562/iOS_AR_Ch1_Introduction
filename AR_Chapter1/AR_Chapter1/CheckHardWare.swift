//
//  CheckHardWare.swift
//  AR_Chapter1
//
//  Created by jiao qing on 18/1/16.
//  Copyright © 2016 jiao qing. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation
import MobileCoreServices
import CoreMotion


class CheckHardWare: NSObject {
    
    static func camera(){
        let videoDevices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        
        var frontOk = false
        var backOk = false
        for device in videoDevices{
            let device = device as! AVCaptureDevice
            if device.position == .Front {
                frontOk = true
            }else if device.position == .Back {
                backOk = true
            }
        }
        
        if !(frontOk && backOk) {
            showMessage("Camera")
        }
    }
    
    static func magnetometer(){
        let mmAvailable = CLLocationManager.headingAvailable()
        
        if !mmAvailable {
            showMessage("MagenetMeter")
        }
    }
    
    static func audio(){
        let audioSession = AVAudioSession.sharedInstance().inputAvailable
        if !audioSession {
            showMessage("Audio")
        }
    }
    
    static func video(){
        let picker = UIImagePickerController()
        
        if let sourceTypes = UIImagePickerController.availableMediaTypesForSourceType(picker.sourceType) {
            if !sourceTypes.contains(kUTTypeMovie as String){
                showMessage("Video")
            }
        }
    }
    
    static func gyroscope(){
        let motion = CMMotionManager()
        let ava = motion.gyroAvailable
        if !ava{
            showMessage("Gyroscope")
        }
    }
    
    static func showMessage(title : String){
        let alert = UIAlertView(title: title, message: "Not Available", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    
}
