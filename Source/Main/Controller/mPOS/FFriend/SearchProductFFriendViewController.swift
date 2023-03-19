//
//  SearchProductFFriendViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/13/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore
import MIBadgeButton_Swift
class SearchProductFFriendViewController: UITabBarController, UITabBarControllerDelegate,SearchDelegate {
    
    var parentNavigationController : UINavigationController?
    var parentTabBarController: UITabBarController?
    
    func searchScanSuccess(text: String) {
        print("AAA \(text)" )
        //         actionSearchProduct(sku: text)
    }
    
    func searchActionCart() {
        let newViewController = CartViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func pushView(_ product: Product) {
        if (product.manSerNum == "Y"){
            let newViewController = DetailProductNewViewController()
            newViewController.sku = product.sku
            newViewController.model_id = product.model_id
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            let newViewController = DetailAccessoriesFFriendViewController()
            newViewController.product = product
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
    func pushViewOld(_ product: ProductOld) {
        let newViewController = DetailProductOldViewController()
        newViewController.product = product
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    var btCartIcon:MIBadgeButton!
    
    var ocfdFFriend:OCRDFFriend?
  //  var typeOrder:Int = 0 // 0:GOP 1:THANG
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //        navigationItem.backBarButtonItem = backButton
        self.view.backgroundColor = UIColor.white
        self.delegate = self
        self.tabBar.tintColor = UIColor(netHex:0x00955E)
        
        self.title = "Máy đổi trả"
        
        let width = UIScreen.main.bounds.size.width
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(ProductOldViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        let searchField = UITextField(frame: CGRect(x: 30, y: 20, width: width, height: 35))
        searchField.placeholder = "Bạn cần tìm sản phẩm?"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 5
        
        searchField.leftViewMode = .always
        let searchImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let searchImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        let search = UIImage(named: "search", in: Bundle(for: YNSearch.self), compatibleWith: nil)
        searchImageView.image = search
        searchImageViewWrapper.addSubview(searchImageView)
        searchField.leftView = searchImageViewWrapper
        
        self.navigationItem.titleView = searchField
        searchField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        //        searchField.isUserInteractionEnabled = false
        //---
        //---
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: viewRightNav)
        btCartIcon = MIBadgeButton.init(type: .custom)
        btCartIcon.setImage(#imageLiteral(resourceName: "cart"), for: UIControl.State.normal)
        btCartIcon.imageView?.contentMode = .scaleAspectFit
        btCartIcon.addTarget(self, action: #selector(ProductOldViewController.actionCart), for: UIControl.Event.touchUpInside)
        btCartIcon.frame = CGRect(x: -5, y: 0, width: 50, height: 45)
        viewRightNav.addSubview(btCartIcon)
        //---
        
        let tabProduct = TabProductNewViewController()
        let tabProductBarItem = UITabBarItem(title: "Máy mới", image: #imageLiteral(resourceName: "phone"), selectedImage: #imageLiteral(resourceName: "phone_select"))
        tabProduct.tabBarItem = tabProductBarItem
        
        // Create Tab two
        let tabSameProduct = TabProductOldViewController()
        let tabSameProductBarItem = UITabBarItem(title: "Đã sử dụng", image: #imageLiteral(resourceName: "doitra"), selectedImage: #imageLiteral(resourceName: "doitra"))
        tabSameProduct.tabBarItem = tabSameProductBarItem
        
        self.viewControllers = [tabProduct, tabSameProduct]
    }
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.endEditing(true)
        let newViewController = SearchViewController()
        newViewController.isFFriend = true
        newViewController.delegateSearchView = self
        self.navigationController?.pushViewController(newViewController, animated: false)
    }
    
    @objc func actionCart() {
        let newViewController = CartViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let sum = Cache.carts.count
        if(sum > 0){
            btCartIcon.badgeString = "\(sum)"
            btCartIcon.badgeTextColor = UIColor.white
            btCartIcon.badgeEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 0, right: 12)
        }else{
            btCartIcon.badgeString = ""
        }
        
    }
}
