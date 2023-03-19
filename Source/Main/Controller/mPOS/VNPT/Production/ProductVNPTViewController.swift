//
//  ProductBonusScopeViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore
import MIBadgeButton_Swift
import PopupDialog
import KeychainSwift
import AVFoundation
class ProductVNPTViewController: UITabBarController, UITabBarControllerDelegate,SearchVNPTDelegate,ActionHandleFilter {
    func pushViewOld(_ product: ProductOld) {

    }
    

    var btCartIcon:MIBadgeButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = UIScreen.main.bounds.size.width
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(ProductVNPTViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        //---
        
        let searchField = UITextField(frame: CGRect(x: 30, y: 20, width: width, height: 35))
        searchField.placeholder = "Sản phẩm cần tìm?"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 5
        
        searchField.leftViewMode = .always
        let searchImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let searchImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        let search = UIImage(named: "search", in: Bundle(for: YNSearch.self), compatibleWith: nil)
        searchImageView.image = search
        searchImageViewWrapper.addSubview(searchImageView)
        searchField.leftView = searchImageViewWrapper
        
        searchField.rightViewMode = .always
        let searchImageRight = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        let searchImageViewRight = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let scan = UIImage(named: "scan_barcode")
        searchImageViewRight.image = scan
        searchImageRight.addSubview(searchImageViewRight)
        searchField.rightView = searchImageRight
        let gestureSearchImageRight = UITapGestureRecognizer(target: self, action:  #selector(self.actionScan))
        searchImageRight.addGestureRecognizer(gestureSearchImageRight)
        self.navigationItem.titleView = searchField
        searchField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        //        searchField.isUserInteractionEnabled = false
        //---
        
        //---
        let viewFilter = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        
        let btFilterIcon = UIButton.init(type: .custom)
        btFilterIcon.setImage(#imageLiteral(resourceName: "Filter"), for: UIControl.State.normal)
        btFilterIcon.imageView?.contentMode = .scaleAspectFit
        btFilterIcon.addTarget(self, action: #selector(actionFilter), for: UIControl.Event.touchUpInside)
        btFilterIcon.frame = CGRect(x: 5, y: 0, width: 30, height: 50)
        viewFilter.addSubview(btFilterIcon)
        //---
        
        //---
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.rightBarButtonItems  = [UIBarButtonItem(customView: viewRightNav),UIBarButtonItem(customView: viewFilter)]
        btCartIcon = MIBadgeButton.init(type: .custom)
        btCartIcon.setImage(#imageLiteral(resourceName: "cart"), for: UIControl.State.normal)
        btCartIcon.imageView?.contentMode = .scaleAspectFit
        btCartIcon.addTarget(self, action: #selector(actionCart), for: UIControl.Event.touchUpInside)
        btCartIcon.frame = CGRect(x: -5, y: 0, width: 50, height: 45)
        viewRightNav.addSubview(btCartIcon)
        //---
        
        //        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //        navigationItem.backBarButtonItem = backButton
        self.view.backgroundColor = UIColor.white
        self.delegate = self
        self.tabBar.tintColor = UIColor(netHex:0x00955E)
        
        self.title = "Sản phẩm"
        
        //        self.automaticallyAdjustsScrollViewInsets = false
        let tabProduct = TabPhoneVNPTViewController()
        tabProduct.parentTabBarController = tabBarController
        tabProduct.parentNavigationController = navigationController
        let tabProductBarItem = UITabBarItem(title: "Điện thoại", image: #imageLiteral(resourceName: "phone"), selectedImage: #imageLiteral(resourceName: "phone_select"))
        tabProduct.tabBarItem = tabProductBarItem
        
        // Create Tab two
        let tabSameProduct = TabTabletVNPTViewController()
        tabSameProduct.parentTabBarController = tabBarController
        tabSameProduct.parentNavigationController = navigationController
        let tabSameProductBarItem = UITabBarItem(title: "Tablet", image: #imageLiteral(resourceName: "tablet"), selectedImage: #imageLiteral(resourceName: "tablet_select"))
        tabSameProduct.tabBarItem = tabSameProductBarItem
        
        
        let tabCompare = TabLaptopVNPTViewController()
        tabCompare.parentTabBarController = tabBarController
        tabCompare.parentNavigationController = navigationController
        let tabCompareBarItem = UITabBarItem(title: "Laptop", image: #imageLiteral(resourceName: "laptop"), selectedImage: #imageLiteral(resourceName: "laptop_select"))
        
        tabCompare.tabBarItem = tabCompareBarItem
        
        let tabApple = TabAppleVNPTViewController()
        tabApple.parentTabBarController = tabBarController
        tabApple.parentNavigationController = navigationController
        let tabAppleBarItem = UITabBarItem(title: "Apple", image: #imageLiteral(resourceName: "apple"), selectedImage: #imageLiteral(resourceName: "apple_select"))
        
        tabApple.tabBarItem = tabAppleBarItem
        
        self.viewControllers = [tabProduct, tabSameProduct,tabCompare,tabApple]
    }
    override func viewWillAppear(_ animated: Bool) {
        let sum = Cache.cartsVNPT.count
        if(sum > 0){
            btCartIcon.badgeString = "\(sum)"
            btCartIcon.badgeTextColor = UIColor.white
            btCartIcon.badgeEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 0, right: 12)
        }else{
            btCartIcon.badgeString = ""
        }
    }
    func pushViewFilter(_ sort: String, _ sortPriceFrom: Float, _ sortPriceTo: Float, _ sortGroupName: String, _ sortManafacture: String, _ u_ng_code:String, _ inventory:String) {
        let newViewController = ProductsFilterVNPTViewController()
        newViewController.sortBonus = sort
        newViewController.sortPriceFrom = sortPriceFrom
        newViewController.sortPriceTo = sortPriceTo
        newViewController.sortGroup = sortGroupName
        newViewController.sortManafacture = sortManafacture
        newViewController.u_ng_code = u_ng_code
        newViewController.inventory = inventory
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func actionFilter() {
        let newViewController = FilterViewController()
        newViewController.handleFilterDelegate = self
        let nav1 = UINavigationController()
        nav1.viewControllers = [newViewController]
        self.present(nav1, animated: true, completion: nil)
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func actionScan() {
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { text in
            self.actionSearchProduct(sku: text)
        }
        self.present(viewController, animated: false, completion: nil)
    }
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        Cache.searchOld = false
        textField.endEditing(true)
        let newViewController = SearchProdutionVNPTViewController()
        newViewController.delegateSearchView = self
        self.navigationController?.pushViewController(newViewController, animated: false)
    }
    @objc func actionCart() {
        let newViewController = CartVNPTViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func searchScanSuccess(text: String) {
        actionSearchProduct(sku: text)
    }
    
    func searchActionCart() {
        let newViewController = CartVNPTViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func pushView(_ product: Product) {
        if (product.manSerNum == "Y"){
            Cache.sku = product.sku
            let newViewController = DetailProductVNPTViewController()
            newViewController.product = product
            newViewController.isCompare = false
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }else{
            let newViewController = DetailAccessoriesVNPTViewController()
            newViewController.product = product
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
  

    func actionSearchProduct(sku:String) {
        let newViewController = LoadingViewController()
        //        newViewController.content = "Đang tìm mã \(sku)"
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.tabBarController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        //
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            //             nc.post(name: Notification.Name("dismissLoading"), object: nil)
            ProductAPIManager.searchProduct(keyword: sku,handler: { (success , error) in
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    if(success.count > 0){
                        if (success[0].manSerNum == "Y"){
                            Cache.sku = sku
                            Cache.model_id = success[0].model_id
                            let newViewController = DetailProductVNPTViewController()
                            newViewController.isCompare = false
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }else{
                            let newViewController = DetailAccessoriesVNPTViewController()
                            newViewController.product = success[0]
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: error, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                    
                }
            })
        }
        
    }
}
