//
//  VNGViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/18/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class VNGViewController:UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.title = "Cài đặt VNG"
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(VNGViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        let tabHome = TabNotInstalledViewController()
        let tabHomeBarItem = UITabBarItem(title: "Chưa cài đặt", image: #imageLiteral(resourceName: "ChuaCaiDat"), selectedImage: #imageLiteral(resourceName: "ChuaCaiDat"))
        tabHome.tabBarItem = tabHomeBarItem
        
        let tabActivity = TabInstalledViewController()
        let tabActivityBarItem = UITabBarItem(title: "Đã cài đặt", image: #imageLiteral(resourceName: "DaCaiDat"), selectedImage: #imageLiteral(resourceName: "DaCaiDat"))
        tabActivity.tabBarItem = tabActivityBarItem
        
        let controllers = [tabHome,tabActivity]
        self.viewControllers = controllers
        
         self.tabBar.tintColor = UIColor(netHex:0x00955E)
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
