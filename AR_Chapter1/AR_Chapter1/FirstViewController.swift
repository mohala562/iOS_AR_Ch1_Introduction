//
//  FirstViewController.swift
//  AR_Chapter1
//
//  Created by jiao qing on 19/1/16.
//  Copyright © 2016 jiao qing. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

class FirstViewController: UIViewController, UIAccelerometerDelegate, CLLocationManagerDelegate {
    let mManager =  CMMotionManager()
    let locationMg = CLLocationManager()
    
    @IBOutlet weak var xL: UILabel!
    @IBOutlet weak var yL: UILabel!
    @IBOutlet weak var zL: UILabel!
    
    @IBOutlet weak var xProgessView: UIProgressView!
    @IBOutlet weak var yProgessView: UIProgressView!
    @IBOutlet weak var zProgessView: UIProgressView!
    
    @IBOutlet weak var imageView: UIImageView!
    var previousMeterData : CMAcceleration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "splash.jpg")
        
        locationMg.delegate = self
        locationMg.headingFilter = 5
        if CLLocationManager.locationServicesEnabled() && CLLocationManager.headingAvailable() {
            locationMg.startUpdatingHeading()
            locationMg.startUpdatingLocation()
        }
        
//        if mManager.accelerometerAvailable{
//            mManager.startAccelerometerUpdates()
//            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateAcceleraoMeter", userInfo: nil, repeats: true)
//        }
        
//        if mManager.gyroAvailable{
//            mManager.startGyroUpdates()
//            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateGyoMeter", userInfo: nil, repeats: true)
//        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if newHeading.headingAccuracy > 0 {
            let mh = newHeading.magneticHeading
         //   let th = newHeading.trueHeading
            print("heading is \(mh)")
            let heading = -1 * M_PI * mh / 180
            imageView.transform = CGAffineTransformMakeRotation(CGFloat(heading))
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func updateAcceleraoMeter(){
        if let data = mManager.accelerometerData{
            self.xL.text = "X : \(data.acceleration.x)"
            self.yL.text = "Y : \(data.acceleration.y)"
            self.zL.text = "Z : \(data.acceleration.z)"
            self.xProgessView.progress = abs(Float(data.acceleration.x))
            self.yProgessView.progress = abs(Float(data.acceleration.y))
            self.zProgessView.progress = abs(Float(data.acceleration.z))
            
            if previousMeterData == nil{
                previousMeterData = data.acceleration
            }
            if previousMeterData!.x - data.acceleration.x > 0.1 && previousMeterData!.y - data.acceleration.y > 0.1{
                print("shake now")
            }
            
            previousMeterData = data.acceleration
        }
    }
    
    func updateGyoMeter(){
        if let data = mManager.gyroData{
            self.xL.text = "X : \(data.rotationRate.x)"
            self.yL.text = "Y : \(data.rotationRate.y)"
            self.zL.text = "Z : \(data.rotationRate.z)"
            self.xProgessView.progress = abs(Float(data.rotationRate.x))
            self.yProgessView.progress = abs(Float(data.rotationRate.y))
            self.zProgessView.progress = abs(Float(data.rotationRate.z))
        }
    }
}
