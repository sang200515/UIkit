//
//  MposSOHistoryMainViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 7/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class MposSOHistoryMainViewController: UIViewController, CAPSPageMenuDelegate {

    var pageMenu : CAPSPageMenu?
    var indexMenu:Int = 0
    var controller1 : DetailMposSOInfoViewController!
    var controller2 : PaymentTypeMposSOViewController!
    var so: SOHeader?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Lịch sử đơn hàng \(so?.DocEntry ?? 0)"
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        self.setUpView()
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name.init("didEnter_mayCuEcom"), object: nil)
    }
    
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        indexMenu = index
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func refresh() {
        self.view.subviews.forEach({$0.removeFromSuperview()})
        self.setUpView()
    }

    func setUpView() {
        var controllerArray : [UIViewController] = []
        controller1 = DetailMposSOInfoViewController()
        controller1.title = "THÔNG TIN ĐH"
        controller1.so = self.so
        controller1.parentNavigationController = self.navigationController
        controllerArray.append(controller1)
        
        controller2 = PaymentTypeMposSOViewController()
        controller2.parentNavigationController = self.navigationController
        controller2.title = "HÌNH THỨC TT"
        controller2.so = self.so
        controllerArray.append(controller2)
        
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
        pageMenu?.view.subviews
            .map { $0 as? UIScrollView }
            .forEach { $0?.isScrollEnabled = false }
        self.view.addSubview(pageMenu!.view)
    }
}
