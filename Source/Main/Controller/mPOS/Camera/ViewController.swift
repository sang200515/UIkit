//
//  ViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/14/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   let player:DLGPlayerViewController = DLGPlayerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        player.url = "rtsp://admin:frt2012;;@115.78.15.6:9250/Streaming/Channels/101/"
        player.view.translatesAutoresizingMaskIntoConstraints = true
        player.view.frame = self.view.frame
        player.autoplay = true
        player.repeat = true
        player.preventFromScreenLock = true
        player.restorePlayAfterAppEnterForeground = true
        self.view.addSubview(player.view)
        player.play()
        print("Status \(player.status)")
    }
    
}

