//
//  ReceiverUpdateViewController.swift
//  fptshop
//
//  Created by Apple on 5/10/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ReceiverUpdateViewController: UIViewController,CAPSPageMenuDelegate {
    
    var receiverPhone = ""
    var receiverShopName = ""
    var receiverFullName = ""
    var listShopPhongBan:[BillLoadShopPhongBan] = []
    var listQuanHuyen:[BillLoadQuanHuyen] = []
    var listTinhTp:[BillLoadTinhThanhPho] = []
    
    var receiveObj:BillLoadDiaChiNhan?
    
    var pageMenu : CAPSPageMenu?
    var indexMenu:Int = 0
    
    var controller1 : OldShopPBReceiveViewController!
    var controller2 : NewShopPBReceiveViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        self.title = "Cập nhật thông tin người nhận"
        self.view.backgroundColor = UIColor.white
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(CardViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            mCallLogApiManager.Bill__LoadShopPhongBan(handler: { (resultsShopPB, err) in
                    if resultsShopPB.count > 0 {
                        for item in resultsShopPB {
                            self.listShopPhongBan.append(item)
                        }
                    } else {
                        debugPrint("Không lấy được list ShopPB!")
                }
                mCallLogApiManager.Bill__LoadQuanHuyen(handler: { (resultsQuanHuyen, err) in
                    if resultsQuanHuyen.count > 0 {
                        for item in resultsQuanHuyen {
                            self.listQuanHuyen.append(item)
                        }
                    } else {
                         debugPrint("Không lấy được list quan huyen!")
                    }
                    
                    mCallLogApiManager.Bill__LoadTinhThanhPho(handler: { (resultsTinh, err) in
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            if resultsTinh.count > 0 {
                                for item in resultsTinh {
                                    self.listTinhTp.append(item)
                                }
                            } else {
                                debugPrint("Không lấy được list tinh tp!")
                            }
                            self.setUpView()
                        }
                    })
                })
            })
        }
        
    }
    
    func setUpView() {
        var controllerArray : [UIViewController] = []
        controller1 = OldShopPBReceiveViewController()
        controller1.title = "Shop/PB nhận"
        controller1.parentNavigationController = self.navigationController
        controller1.receiverPhone = self.receiverPhone
        controller1.receiverShopName = self.receiverShopName
        controller1.receiverFullName = self.receiverFullName
        controller1.listShopPhongBan = self.listShopPhongBan
        controller1.listQuanHuyen = self.listQuanHuyen
        controller1.listTinhTp = self.listTinhTp
        controller1.receiveObj = self.receiveObj
        controllerArray.append(controller1)
        
        controller2 = NewShopPBReceiveViewController()
        controller2.parentNavigationController = self.navigationController
        controller2.title = "Shop/PB nhận mới"
        controller2.listQuanHuyen = self.listQuanHuyen
        controller2.listTinhTp = self.listTinhTp
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
    
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        indexMenu = index
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }

}
