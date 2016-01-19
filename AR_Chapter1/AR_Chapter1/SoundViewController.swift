//
//  SoundViewController.swift
//  AR_Chapter1
//
//  Created by jiao qing on 19/1/16.
//  Copyright © 2016 jiao qing. All rights reserved.
//

import UIKit
import AVFoundation


class SoundViewController: UIViewController, AVAudioRecorderDelegate {
    var audioPlayer = AVAudioPlayer()
    var recorder : AVAudioRecorder?
    var fileUrl : NSURL?
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
    }
    
    @IBAction func startBtnDidClicked(sender: AnyObject) {
        recorder?.record()
    }
    @IBAction func stopBtnDidClicked(sender: AnyObject) {
        recorder?.stop()
    }
    @IBAction func playBtnDidClicked(sender: AnyObject) {
        playSound()
    }
    
    func playSound(){
        do{
            //            if let path = NSBundle.mainBundle().pathForResource("007", ofType: "mp3"){
            //                fileUrl = NSURL(fileURLWithPath: path)
            //            }
            try audioPlayer = AVAudioPlayer(contentsOfURL: fileUrl!)
        }catch{
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    
    func setupRecorder(){
        let recordSettings = [
            AVFormatIDKey: NSNumber(unsignedInt:kAudioFormatAppleIMA4),
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 12800,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        
        do{
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.setActive(true)
            getFileURL()
            
            try  recorder = AVAudioRecorder(URL: fileUrl!, settings: recordSettings)
            recorder?.delegate = self
            recorder?.meteringEnabled = true
            recorder?.prepareToRecord()
        }catch{
        }
    }
    
    func getFileURL() -> NSURL {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        fileUrl = documentsURL.URLByAppendingPathComponent("JQ.caf")
        return fileUrl!
    }
}
