//
//  ViewController.swift
//  Flashlight
//
//  Created by Zachary Frew on 7/2/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var isOn = false
    
    @IBOutlet weak var buttonText: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var rightGesture = UISwipeGestureRecognizer(target: self, action:#selector(self.respondToSwipeGesture))
        rightGesture.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightGesture)
        
        let leftGesture = UISwipeGestureRecognizer(target: self, action:#selector(self.respondToSwipeGesture))
        leftGesture.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(leftGesture)
    }
    
    @objc func respondToSwipeGesture(gesture: UISwipeGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch (swipeGesture.direction) {
            case .right:
                view.backgroundColor = UIColor.white
                buttonText.setTitle("Off", for: .normal)
                buttonText.setTitleColor(UIColor.black, for: .normal)
                isOn = true
                toggleFlashLight()
                toggleStatusBar()
                
            case .left:
                view.backgroundColor = UIColor.black
                buttonText.setTitle("On", for: .normal)
                buttonText.setTitleColor(UIColor.white, for: .normal)
                isOn = false
                toggleFlashLight()
                toggleStatusBar()
                
            default:
                break
            }
        }
    }

    @IBAction func buttonTapped(_ sender: Any) {

        if isOn == false {
            view.backgroundColor = UIColor.white
            buttonText.setTitle("Off", for: .normal)
            buttonText.setTitleColor(UIColor.black, for: .normal)
            isOn = true
            toggleFlashLight()
            toggleStatusBar()
        } else if isOn == true {
            view.backgroundColor = UIColor.black
            buttonText.setTitle("On", for: .normal)
            buttonText.setTitleColor(UIColor.white, for: .normal)
            isOn = false
            toggleFlashLight()
            toggleStatusBar()
        }
    }
    
    func toggleFlashLight() {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        if let device = device, device.hasTorch {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                    device.torchMode = AVCaptureDevice.TorchMode.off
                } else {
                    do {
                        try device.setTorchModeOn(level: 1.0)
                    } catch {
                        print(error)
                    }
                }
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    func toggleStatusBar() {
        var statusBarStyle = UIStatusBarStyle.default
        if statusBarStyle == .default {
            statusBarStyle = .lightContent
        } else {
            statusBarStyle = .default
        }
    }

}
