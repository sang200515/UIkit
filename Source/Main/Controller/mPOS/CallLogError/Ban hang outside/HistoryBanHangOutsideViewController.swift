//
//  HistoryBanHangOutsideViewController.swift
//  fptshop
//
//  Created by Apple on 4/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HistoryBanHangOutsideViewController: UIViewController , CAPSPageMenuDelegate{
    
    var pageMenu : CAPSPageMenu?
    var indexMenu:Int = 0
    
    var controller1 : TabNopQuyViewController!
    var controller2 : TabTheCaoBHOutsideViewController!
    var controller3 : TabThuHoBHOutsideViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.hidesBackButton = true
        self.title = "Lịch sử bán hàng outside"
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        
        var controllerArray : [UIViewController] = []
        controller1  = TabNopQuyViewController()
        controller1.title = "Nộp quỹ"
        controller1.parentNavigationController = self.navigationController
        controllerArray.append(controller1)
        
        controller2 = TabTheCaoBHOutsideViewController()
        controller2.parentNavigationController = self.navigationController
        controller2.title = "Thẻ cào"
        controllerArray.append(controller2)
        
        controller3 = TabThuHoBHOutsideViewController()
        controller3.parentNavigationController = self.navigationController
        controller3.title = "Thu hộ"
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
            .menuItemFont(UIFont.boldSystemFont(ofSize: Common.Size(s: 13))),
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

class NopQuyBHOutsideCell: UITableViewCell {
    
    var lblTradingCode: UILabel!
    var lblTradingTime: UILabel!
    var lblShopName: UILabel!
    var lblMoneyValue: UILabel!
    
    func setUpCell(item: NapTienBHOutside){
        
        let lblMaGiaoDich = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 5), width: self.frame.width/3, height: Common.Size(s: 20)))
        lblMaGiaoDich.text = "Mã giao dịch:"
        lblMaGiaoDich.textColor = UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1)
        lblMaGiaoDich.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lblMaGiaoDich)
        
        lblTradingCode = UILabel(frame: CGRect(x: lblMaGiaoDich.frame.origin.x + lblMaGiaoDich.frame.width, y: lblMaGiaoDich.frame.origin.y, width: self.frame.width - lblMaGiaoDich.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lblTradingCode.text = "\(item.NV_Thu)"
        lblTradingCode.textColor = UIColor.black
        lblTradingCode.font = UIFont.boldSystemFont(ofSize: 15)
        self.addSubview(lblTradingCode)
        
        let lblNgay = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblMaGiaoDich.frame.origin.y + lblMaGiaoDich.frame.height, width: lblMaGiaoDich.frame.width, height: Common.Size(s: 20)))
        lblNgay.text = "Ngày:"
        lblNgay.textColor = UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1)
        lblNgay.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lblNgay)
        
        lblTradingTime = UILabel(frame: CGRect(x: lblTradingCode.frame.origin.x , y: lblNgay.frame.origin.y, width: lblTradingCode.frame.width, height: Common.Size(s: 20)))

        lblTradingTime.text = "\(item.Ngay)"
        lblTradingTime.textColor = UIColor.black
        lblTradingTime.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(lblTradingTime)
        
        let lblShop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblNgay.frame.origin.y + lblNgay.frame.height, width: lblMaGiaoDich.frame.width, height: Common.Size(s: 20)))
        lblShop.text = "Shop:"
        lblShop.textColor = UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1)
        lblShop.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lblShop)
        
        lblShopName = UILabel(frame: CGRect(x: lblTradingTime.frame.origin.x , y: lblShop.frame.origin.y, width: lblTradingCode.frame.width, height: Common.Size(s: 20)))
        lblShopName.text = "\(item.ShopDong)"
        lblShopName.textColor = UIColor.black
        lblShopName.font = UIFont.systemFont(ofSize: 15)
        lblShopName.numberOfLines = 0
        self.addSubview(lblShopName)
        
        let lblShopHeight = lblShopName.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lblShopName.optimalHeight
        
        let lblMoney = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblShop.frame.origin.y + lblShopHeight, width: lblMaGiaoDich.frame.width, height: Common.Size(s: 20)))
        lblMoney.text = "Số tiền:"
        lblMoney.textColor = UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1)
        lblMoney.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lblMoney)
        
        lblMoneyValue = UILabel(frame: CGRect(x: lblTradingTime.frame.origin.x , y: lblMoney.frame.origin.y, width: lblMoney.frame.width, height: Common.Size(s: 20)))
        lblMoneyValue.text = "\(Common.convertCurrency(value: item.TongTien))"
        lblMoneyValue.textColor = UIColor.red
        lblMoneyValue.font = UIFont.boldSystemFont(ofSize: 15)
        self.addSubview(lblMoneyValue)
    }
}
