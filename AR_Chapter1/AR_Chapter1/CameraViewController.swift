//
//  CameraViewController.swift
//  AR_Chapter1
//
//  Created by jiao qing on 19/1/16.
//  Copyright © 2016 jiao qing. All rights reserved.
//

import UIKit
import MobileCoreServices
import ImageIO
import AVFoundation

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var videoPreview: UIView!
    
    let session = AVCaptureSession()
    let stillImageOutPut = AVCaptureStillImageOutput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCaptureMovie()
        stillImageOutPut.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
        session.addOutput(stillImageOutPut)
    }
    
    @IBAction func startBtnDidClicked(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .Camera
       // imagePicker.mediaTypes = [kUTTypeMovie as String]
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func stopBtnDidClicked(sender: AnyObject) {
        captureScreen()
    }
    
    @IBAction func playBtnDidClicked(sender: AnyObject) {
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        session.stopRunning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        session.startRunning()
    }
    
    func captureScreen(){
        var videoCoonection : AVCaptureConnection?
        
        for connection in stillImageOutPut.connections{
            let connectionAV = connection as! AVCaptureConnection
            for port in connectionAV.inputPorts{
                let portAV = port as! AVCaptureInputPort
                if portAV.mediaType == AVMediaTypeVideo {
                    videoCoonection = connectionAV
                    break
                }
            }
            if videoCoonection != nil{
                break
            }
        }
        
        stillImageOutPut.captureStillImageAsynchronouslyFromConnection(videoCoonection){
            (imageSampleBuffer : CMSampleBuffer!, _) in
            let imageDataJpeg = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageSampleBuffer)
            self.imageView.image = UIImage(data: imageDataJpeg)
        }
    }
    
    func setCaptureMovie(){
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = videoPreview.bounds
        videoPreview.layer.addSublayer(previewLayer)
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do{
            let input = try AVCaptureDeviceInput(device: device)
            session.addInput(input)
        }catch{}
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = image
    }
    
}
