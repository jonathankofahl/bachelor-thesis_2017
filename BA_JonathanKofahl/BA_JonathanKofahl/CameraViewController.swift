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
   
    let captureSession = AVCaptureSession()
    let finalImage = AVCaptureStillImageOutput()
    
    var previewLayer : AVCaptureVideoPreviewLayer?
    var motherController : InformationViewController!
    var actualDevice : AVCaptureDevice?
    
    //MARK: - METHODS

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        previewLayer.frame = self.view.layer.frame
        captureSession.startRunning()
        
        self.view.addSubview(cameraScreen)
        self.view.addSubview(takePhotoButton)
        
    }

}
