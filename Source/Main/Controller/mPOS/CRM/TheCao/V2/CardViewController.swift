//
//  CardViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/20/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class CardViewController: UIViewController,UITextFieldDelegate,CAPSPageMenuDelegate{
    var pageMenu : CAPSPageMenu?
    var indexMenu:Int = 0
    var is_Mobifone_Msale = false
    var mobifone_phone = ""
    var mobifoneMsale_Package: MobifoneMsalePackage?
    
    var controller1 : TabCodeCardViewController!
    var controller3 : TabTopupCardViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if is_Mobifone_Msale {
            indexMenu = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        self.title = "Thẻ cào"
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(CardViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---

        var controllerArray : [UIViewController] = []
        controller1  = TabCodeCardViewController()
        controller1.title = "Mã thẻ"
        controller1.parentNavigationController = self.navigationController
        controllerArray.append(controller1)
        
        controller3 = TabTopupCardViewController()
        controller3.parentNavigationController = self.navigationController
        controller3.title = "Topup"
        controllerArray.append(controller3)
        
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
        pageMenu?.delegate = self
        if is_Mobifone_Msale {
            controller3.is_Mobifone_Msale = true
            controller3.mobifone_phone = self.mobifone_phone
            controller3.mobifoneMsale_Package = self.mobifoneMsale_Package
            pageMenu?.moveToPage(1)
        }
        pageMenu?.view.subviews
            .map { $0 as? UIScrollView }
            .forEach { $0?.isScrollEnabled = false }
        self.view.addSubview(pageMenu!.view)
        
    }
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        indexMenu = index
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "didEnterTopup_MobifoneMsale"), object: self, userInfo: nil))
    }
}

