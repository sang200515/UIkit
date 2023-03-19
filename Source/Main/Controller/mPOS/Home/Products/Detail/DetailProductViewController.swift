//
//  DetailProductViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import MIBadgeButton_Swift
class DetailProductViewController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    
    var sku : String!
    var loading:NVActivityIndicatorView!
    var loadingView:UIView!
    var tabBarTemp: UITabBarController!
    var product:Product!
    var isCompare:Bool = true
    var btCartIcon:MIBadgeButton!
    convenience init(sku: String) {
        self.init()
    }
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let sum = Cache.carts.count
        if(sum > 0){
            btCartIcon.badgeString = "\(sum)"
            btCartIcon.badgeTextColor = UIColor.white
            btCartIcon.badgeEdgeInsets = UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 5)
        }else{
            btCartIcon.badgeString = ""
        }
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(sendTabCompare), name: Notification.Name("sendTabCompare"), object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("sendTabCompare viewWillDisappear")
        NotificationCenter.default.removeObserver(self, name: Notification.Name("sendTabCompare"), object: nil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chi tiết"
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(DetailProductViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        self.tabBar.tintColor = UIColor(netHex:0x00955E)
        let btRightIcon = UIButton.init(type: .custom)
        btRightIcon.setImage(#imageLiteral(resourceName: "home"), for: UIControl.State.normal)
        btRightIcon.imageView?.contentMode = .scaleAspectFit
        btRightIcon.addTarget(self, action: #selector(DetailProductViewController.actionHome), for: UIControl.Event.touchUpInside)
        btRightIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        let barRight = UIBarButtonItem(customView: btRightIcon)
        //        self.navigationItem.rightBarButtonItem = barRight
        
        btCartIcon  = MIBadgeButton.init(type: .custom)
        btCartIcon.setImage(#imageLiteral(resourceName: "cart"), for: UIControl.State.normal)
        btCartIcon.imageView?.contentMode = .scaleAspectFit
        btCartIcon.addTarget(self, action: #selector(DetailProductViewController.actionCart), for: UIControl.Event.touchUpInside)
        btCartIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        let barCart = UIBarButtonItem(customView: btCartIcon)
        self.navigationItem.rightBarButtonItems = [barCart,barRight]
        
        self.view.backgroundColor = UIColor.white
        sku = Cache.sku
        self.delegate = self
        let tabProduct = TabProductViewController()
        let tabProductBarItem = UITabBarItem(title: "Sản phẩm", image: #imageLiteral(resourceName: "phone"), selectedImage: #imageLiteral(resourceName: "phone_select"))
        tabProduct.tabBarItem = tabProductBarItem
        
        // Create Tab two
        let tabSameProduct = TabSameProductViewController()
        let tabSameProductBarItem = UITabBarItem(title: "Cùng giá", image: #imageLiteral(resourceName: "cunggia"), selectedImage: #imageLiteral(resourceName: "cunggia_select"))
        
        tabSameProduct.tabBarItem = tabSameProductBarItem
        
        
        let tabCompare = TabCompareViewController()
        let tabCompareBarItem = UITabBarItem(title: "So sánh", image: #imageLiteral(resourceName: "sosanh"), selectedImage: #imageLiteral(resourceName: "sosanh_select"))
        
        tabCompare.tabBarItem = tabCompareBarItem
        
        let tabInstallment = TabInstallmentViewController()
        let tabInstallmentBarItem = UITabBarItem(title: "Trả góp", image: #imageLiteral(resourceName: "tragop"), selectedImage: #imageLiteral(resourceName: "tragop_select"))
        
        tabInstallment.tabBarItem = tabInstallmentBarItem
        
        self.viewControllers = [tabProduct, tabSameProduct,tabCompare,tabInstallment]
        
        tabBarTemp  = self
    }
    // MARK: - Selectors
    

    @objc func sendTabCompare(notification:Notification) -> Void {
        print("sendTabCompare notification")
        tabBarTemp.selectedIndex = 2
        
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func actionCart() {
        let newViewController = CartViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func actionHome(){
        _ = self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}
