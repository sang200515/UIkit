//
//  OrdersViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore
import MIBadgeButton_Swift
class OrdersViewController: UITabBarController, UITabBarControllerDelegate {
    var btCartIcon:MIBadgeButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.delegate = self
        self.tabBar.tintColor = UIColor(netHex:0x00955E)
        
        let tabProduct = OrderMPOSViewController()
        tabProduct.parentTabBarController = tabBarController
        let tabProductBarItem = UITabBarItem(title: "mPOS", image: #imageLiteral(resourceName: "so-mpos"), selectedImage: #imageLiteral(resourceName: "so-mpos"))
        tabProduct.tabBarItem = tabProductBarItem
        
        let tabCardProduct = HistoryTheCaoSOMViewController()
        tabCardProduct.isTopup = false
        let tabCardProductBarItem = UITabBarItem(title: "Thẻ nạp", image: #imageLiteral(resourceName: "so-card"), selectedImage: #imageLiteral(resourceName: "so-card"))
        tabCardProduct.tabBarItem = tabCardProductBarItem
        
        let tabTopUpProduct = HistoryTheCaoSOMViewController()
        tabTopUpProduct.isTopup = true
        let tabTopUpProductBarItem = UITabBarItem(title: "Bắn tiền", image: #imageLiteral(resourceName: "so-card"), selectedImage: #imageLiteral(resourceName: "so-card"))
        tabTopUpProduct.tabBarItem = tabTopUpProductBarItem
        
        let tabThuHoProduct = HistoryThuHoSOMViewController()
        let tabThuHoProductBarItem = UITabBarItem(title: "Thu hộ", image: #imageLiteral(resourceName: "so-thuho"), selectedImage: #imageLiteral(resourceName: "so-thuho"))
        tabThuHoProduct.tabBarItem = tabThuHoProductBarItem
        
//        self.viewControllers = [tabProduct, tabCardProduct, tabTopUpProduct, tabThuHoProduct]
        self.viewControllers = [UINavigationController(rootViewController: tabProduct), UINavigationController(rootViewController: tabCardProduct), UINavigationController(rootViewController: tabTopUpProduct), UINavigationController(rootViewController: tabThuHoProduct)]
    }
}
