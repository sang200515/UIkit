//
//  TabLichSuViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 10/24/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import MIBadgeButton_Swift
class RightPhoneViewController:  UITabBarController, UITabBarControllerDelegate{
      var btCartIcon:MIBadgeButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.delegate = self
        self.tabBar.tintColor = UIColor(netHex:0x00955E)
        
        self.title = "RightPhone"
        
        _ = UIScreen.main.bounds.size.width
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(RightPhoneViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        //---
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        
        btCartIcon = MIBadgeButton.init(type: .custom)
        btCartIcon.setImage(#imageLiteral(resourceName: "Search"), for: UIControl.State.normal)
        btCartIcon.imageView?.contentMode = .scaleAspectFit
        btCartIcon.addTarget(self, action: #selector(RightPhoneViewController.actionCart), for: UIControl.Event.touchUpInside)
        btCartIcon.frame = CGRect(x: -5, y: 0, width: 50, height: 45)
        viewRightNav.addSubview(btCartIcon)
        //---
        let viewCreateRCheck = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        
        let btCreateRcheckIcon = UIButton.init(type: .custom)
        btCreateRcheckIcon.setImage(#imageLiteral(resourceName: "add"), for: UIControl.State.normal)
        btCreateRcheckIcon.imageView?.contentMode = .scaleAspectFit
        btCreateRcheckIcon.addTarget(self, action: #selector(RightPhoneViewController.actionCreateRcheck), for: UIControl.Event.touchUpInside)
        btCreateRcheckIcon.frame = CGRect(x: 5, y: 0, width: 30, height: 50)
        viewCreateRCheck.addSubview(btCreateRcheckIcon)
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: viewRightNav)
          self.navigationItem.rightBarButtonItems  = [UIBarButtonItem(customView: viewRightNav),UIBarButtonItem(customView: viewCreateRCheck)]
        
        let tabLichSuMuaHang = RPListCompleteProgressViewController()
        tabLichSuMuaHang.parentTabBarController = tabBarController
        tabLichSuMuaHang.parentNavigationController = self.navigationController
        let tabProductBarItem = UITabBarItem(title: "Đã xử lý", image: #imageLiteral(resourceName: "so-mpos"), selectedImage: #imageLiteral(resourceName: "so-mpos"))
        tabLichSuMuaHang.tabBarItem = tabProductBarItem
        
        // Create Tab two
        let tabHoSoXL = RPListOnProgressViewController()
        tabHoSoXL.parentTabBarController = tabBarController
        tabHoSoXL.parentNavigationController = self.navigationController
        let tabSameProductBarItem = UITabBarItem(title: "Chờ xử lý", image: #imageLiteral(resourceName: "Ecom"), selectedImage: #imageLiteral(resourceName: "Ecom"))
        tabHoSoXL.tabBarItem = tabSameProductBarItem
        

        
        self.viewControllers = [tabHoSoXL,tabLichSuMuaHang]
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func actionCart() {
        let newViewController = SearchItemCompleteRPViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func actionCreateRcheck(){
            let newViewController = CreateRcheckViewController()
          self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
