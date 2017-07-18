//
//  CameraViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 17.06.17.
//
// based on code by https://github.com/adarshvcdev/ios-custom-camera-swift3
//

import Foundation
import AVFoundation
import UIKit

class CameraViewController: UIViewController {
    
    //MARK: - VARIABLES & OUTLETS
    
    @IBOutlet weak var cameraScreen: UIImageView!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    
    let captureSession = AVCaptureSession()
    let finalImage = AVCaptureStillImageOutput()
    
    var previewLayer : AVCaptureVideoPreviewLayer?
    var motherController : InformationViewController!
    var actualDevice : AVCaptureDevice?
    
    //MARK: - METHODS

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the takePhotoButton
        
        // Set Quality of Session to High
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        // Check if the actual device has a camera
        if let devices = AVCaptureDevice.devices() as? [AVCaptureDevice] {
            for device in devices {
                if device.hasMediaType(AVMediaTypeVideo) {
                    if device.position == AVCaptureDevicePosition.back {
                        actualDevice = device
                        if actualDevice != nil {
                            beginSession()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func pressCameraButton(_ sender: Any) {
        if let videoConnection = finalImage.connection(withMediaType: AVMediaTypeVideo) {
       finalImage.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (CMSampleBuffer, Error) in
            if let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(CMSampleBuffer) {
                
                if let cameraImage = UIImage(data: imageData) {
                    
                    self.motherController.treeImageView.image = cameraImage
                    
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
    }
    
    func beginSession() {
        do{
            try captureSession.addInput(AVCaptureDeviceInput(device: actualDevice))
                finalImage.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
            
            if captureSession.canAddOutput(finalImage){
                captureSession.addOutput(finalImage)
            }
        }
        catch{
            
        }
        
        guard let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) else {
            return
        }
        
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
        self.view.layer.addSublayer(previewLayer)
        previewLayer.frame = self.cameraScreen.frame
        captureSession.startRunning()
        
        self.view.addSubview(cameraScreen)
        self.view.addSubview(buttonView)
        self.buttonView.addSubview(takePhotoButton)

    }

    @IBAction func changeButtonImage(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.setImage(UIImage(named: "cameraButton_clicked"), for: UIControlState.normal)
            sender.tag = 1
            print("black")
        } else {
          sender.setImage(UIImage(named: "CameraButton_normal"), for: UIControlState.normal)
            sender.tag = 0
            print("grey")

        }
        
    }
    
    
}
