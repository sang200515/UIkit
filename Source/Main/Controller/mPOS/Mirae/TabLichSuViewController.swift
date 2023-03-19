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
class TabLichSuViewController:  UITabBarController, UITabBarControllerDelegate{
      var btCartIcon:MIBadgeButton!
    let tabDHEcom = UITabBarItem(title: "ĐH ECOM", image: #imageLiteral(resourceName: "Ecom"), selectedImage: #imageLiteral(resourceName: "Ecom"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.delegate = self
        self.tabBar.tintColor = UIColor(netHex:0x00955E)
        
        
        _ = UIScreen.main.bounds.size.width
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(TabLichSuViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        //---
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: viewRightNav)
        btCartIcon = MIBadgeButton.init(type: .custom)
        btCartIcon.setImage(#imageLiteral(resourceName: "Search"), for: UIControl.State.normal)
        btCartIcon.imageView?.contentMode = .scaleAspectFit
        btCartIcon.addTarget(self, action: #selector(TabLichSuViewController.actionCart), for: UIControl.Event.touchUpInside)
        btCartIcon.frame = CGRect(x: -5, y: 0, width: 50, height: 45)
        viewRightNav.addSubview(btCartIcon)
        //---
        
        let tabLichSuMuaHang = LichSuMuaHangMiraeViewController()
        tabLichSuMuaHang.parentTabBarController = tabBarController
        tabLichSuMuaHang.parentNavigationController = self.navigationController
        let tabProductBarItem = UITabBarItem(title: "LS mua hàng", image: #imageLiteral(resourceName: "so-mpos"), selectedImage: #imageLiteral(resourceName: "so-mpos"))
        tabLichSuMuaHang.tabBarItem = tabProductBarItem
        
        // Create Tab two
        let tabHoSoXL = HoSoCanXuLyMiraaViewController()
        tabHoSoXL.parentTabBarController = tabBarController
        tabHoSoXL.parentNavigationController = self.navigationController
        let tabSameProductBarItem = UITabBarItem(title: "HS cần xử lý", image: #imageLiteral(resourceName: "Ecom"), selectedImage: #imageLiteral(resourceName: "Ecom"))
        tabHoSoXL.tabBarItem = tabSameProductBarItem
        
        self.viewControllers = [tabLichSuMuaHang, tabHoSoXL]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = PARTNERID == "FPT" ? "Lịch sử" : "Lịch sử thuê máy"
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func actionCart() {
        let newViewController = SearchLichSuMiraeViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if item == tabDHEcom {
//            btCartIcon.isHidden = true
//        } else {
//            btCartIcon.isHidden = false
//        }
    }
}
