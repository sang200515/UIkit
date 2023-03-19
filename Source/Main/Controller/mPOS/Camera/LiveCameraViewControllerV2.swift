//
//  LiveCameraViewControllerV2.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/14/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class LiveCameraViewControllerV2: UIViewController{
    var cameraDetail:CameraDetail!
    var viewLive:UIView!
    let player:DLGPlayerViewController = DLGPlayerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.initNavigationBar()
        self.title = "\(cameraDetail.TenCamera)"
        self.view.backgroundColor = .white
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(LiveCameraViewControllerV2.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        viewLive = UIView(frame: CGRect(x: 0, y:self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height, width: self.view.frame.size.width, height: self.view.frame.size.height -  (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height)))
        viewLive.backgroundColor = .red
        self.view.addSubview(viewLive)
        
        player.url = "\(cameraDetail.LinkCamera)"
        player.view.translatesAutoresizingMaskIntoConstraints = true
        player.view.frame =  CGRect(origin: .zero, size: CGSize(width: self.viewLive.frame.size.width, height: self.viewLive.frame.size.height))
        player.autoplay = true
        player.repeat = true
        player.preventFromScreenLock = true
        player.restorePlayAfterAppEnterForeground = true
        self.viewLive.addSubview(player.view)
        player.play()
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
