//
//  YCDCViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 18/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class YCDCViewController: UIViewController,CAPSPageMenuDelegate {
    var xinHangViewController:TaoYCDCViewController!
    var danhSachXinHangViewController:DanhSachYCDCViewController!
    var pageMenu: CAPSPageMenu!
    var searchField:UITextField!
    var icRefresh:UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "YCĐC"
        self.view.backgroundColor = .white
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(self.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        icRefresh = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(self.refresh))
        self.navigationItem.rightBarButtonItem = icRefresh
        

        var controllerArray : [UIViewController] = []
        xinHangViewController = TaoYCDCViewController()
        xinHangViewController.title = "Xin hàng"
        xinHangViewController.parentNavigationController = self.navigationController
        controllerArray.append(xinHangViewController)
        
        danhSachXinHangViewController = DanhSachYCDCViewController()
        danhSachXinHangViewController.title = "DS Xin hàng"
        danhSachXinHangViewController.parentNavigationController = self.navigationController
        controllerArray.append(danhSachXinHangViewController)
        
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .scrollMenuBackgroundColor(UIColor.white),
            .viewBackgroundColor(UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)),
            .bottomMenuHairlineColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 0.1)),
            .selectionIndicatorColor(UIColor(netHex:0x00955E)),
            .menuMargin(Common.Size(s: 10)),
            .menuHeight(Common.Size(s: 40)),
            .selectedMenuItemLabelColor(UIColor(netHex:0x00955E)),
            .unselectedMenuItemLabelColor(UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)),
            .menuItemFont(UIFont.boldSystemFont(ofSize: Common.Size(s: 14))),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorRoundEdges(true),
            .selectionIndicatorHeight(2.0),
            .menuItemSeparatorPercentageHeight(0.0)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: parameters)
    
        pageMenu?.view.subviews
            .map { $0 as? UIScrollView }
            .forEach { $0?.isScrollEnabled = false }
        self.view.addSubview(pageMenu!.view)
        pageMenu.delegate = self
        
        searchField = UITextField(frame: CGRect(x: 30, y: 20, width: UIScreen.main.bounds.size.width, height: 35))
        searchField.placeholder = "Bạn cần tìm?"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 5

        searchField.leftViewMode = .always
        let searchImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let searchImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        let search = UIImage(named: "search", in: Bundle(for: YNSearch.self), compatibleWith: nil)
        searchImageView.image = search
        searchImageViewWrapper.addSubview(searchImageView)
        searchField.leftView = searchImageViewWrapper
        searchField.addTarget(self, action: #selector(search(textField:)), for: .editingChanged)
        
    }
    @objc func refresh() {
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("refreshYCDC"), object: nil)
    }
    
    
    @objc private func search(textField: UITextField) {
        if let key = textField.text {
            let myDict = [ "key": key]
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("seachYCDC"), object: myDict)
        }
    }
    func willMoveToPage(_ controller: UIViewController, index: Int){
        if(index == 1){
            self.navigationItem.titleView = searchField
            self.navigationItem.rightBarButtonItem = nil
        }else{
            searchField.text = ""
            self.navigationItem.titleView = nil
            self.navigationItem.rightBarButtonItem = icRefresh
        }
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
