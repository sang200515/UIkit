//
//  MayCuEcomMainViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 6/12/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class MayCuEcomMainViewController: UIViewController, CAPSPageMenuDelegate {

    var pageMenu : CAPSPageMenu?
    var indexMenu:Int = 0
    var controller1 : WillUpdateMayCuViewController!
    var controller2 : DidUpdateMayCuViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Cập nhật hình ảnh SP cũ"
        
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
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func refresh() {
        self.view.subviews.forEach({$0.removeFromSuperview()})
        self.setUpView()
    }

    func setUpView() {
        var controllerArray : [UIViewController] = []
        controller1 = WillUpdateMayCuViewController()
        controller1.title = "Chưa cập nhật"
        controller1.parentNavigationController = self.navigationController
        controllerArray.append(controller1)
        
        controller2 = DidUpdateMayCuViewController()
        controller2.parentNavigationController = self.navigationController
        controller2.title = "Đã cập nhật"
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

class UpdateImageOldDeviceCell: UITableViewCell {
    
    var lbProductID: UILabel!
    var lbProductName: UILabel!
    var lbCreateDate: UILabel!
    var lbStatusValue: UILabel!
    var lbImeiText: UILabel!
    var estimateCellHeight: CGFloat = 0
    
    func setUpCell(item: MayCuECom) {
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let lbMaSP = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: (self.frame.width - Common.Size(s: 30))/3, height: Common.Size(s: 20)))
        lbMaSP.text = "Mã SP:"
        lbMaSP.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbMaSP)
        
        lbProductID = UILabel(frame: CGRect(x: lbMaSP.frame.origin.x + lbMaSP.frame.width, y: lbMaSP.frame.origin.y, width: (self.frame.width - Common.Size(s: 30)) * 2/3, height: Common.Size(s: 20)))
        lbProductID.text = "\(item.Sku)"
        lbProductID.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbProductID)
        
        let lbTenSP = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbProductID.frame.origin.y + lbProductID.frame.height + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
        lbTenSP.text = "Tên SP:"
        lbTenSP.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbTenSP)
        
        lbProductName = UILabel(frame: CGRect(x: lbTenSP.frame.origin.x + lbTenSP.frame.width, y: lbTenSP.frame.origin.y, width: lbProductID.frame.width, height: Common.Size(s: 20)))
        lbProductName.text = "\(item.ItemName)"
        lbProductName.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbProductName)
        
        let lbProductNameHeight: CGFloat = lbProductName.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbProductName.optimalHeight + Common.Size(s: 5)
        lbProductName.numberOfLines = 0
        lbProductName.frame = CGRect(x: lbProductName.frame.origin.x, y: lbProductName.frame.origin.y, width: lbProductName.frame.width, height: lbProductNameHeight)
        
        let lbImei = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbProductName.frame.origin.y + lbProductNameHeight + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
        lbImei.text = "Imei:"
        lbImei.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbImei)
        
        lbImeiText = UILabel(frame: CGRect(x: lbImei.frame.origin.x + lbImei.frame.width, y: lbImei.frame.origin.y, width: lbProductID.frame.width, height: Common.Size(s: 20)))
        lbImeiText.text = "\(item.Imei)"
        lbImeiText.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbImeiText)
        
        let lbNgayTao = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbImeiText.frame.origin.y + lbImeiText.frame.height + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
        lbNgayTao.text = "Ngày tạo:"
        lbNgayTao.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbNgayTao)
        
        lbCreateDate = UILabel(frame: CGRect(x: lbNgayTao.frame.origin.x + lbNgayTao.frame.width, y: lbNgayTao.frame.origin.y, width: lbProductID.frame.width, height: Common.Size(s: 20)))
        lbCreateDate.text = "\(item.CreateDate)"
        lbCreateDate.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbCreateDate)
        
        let lbTinhTrang = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
        lbTinhTrang.text = "Tình trạng:"
        lbTinhTrang.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbTinhTrang)
        
        lbStatusValue = UILabel(frame: CGRect(x: lbTinhTrang.frame.origin.x + lbTinhTrang.frame.width, y: lbTinhTrang.frame.origin.y, width: lbProductID.frame.width, height: Common.Size(s: 20)))
        lbStatusValue.text = "\(item.Status)"
        lbStatusValue.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbStatusValue)
        
        if lbStatusValue.text == "Chưa cập nhập" {
            lbStatusValue.textColor = UIColor(red: 214/255, green: 48/255, blue: 49/255, alpha: 1)
        } else {
            lbStatusValue.textColor = UIColor(red: 9/255, green: 132/255, blue: 227/255, alpha: 1)
        }
        
        let line = UIView(frame: CGRect(x: Common.Size(s: 5), y: lbStatusValue.frame.origin.y + lbStatusValue.frame.height + Common.Size(s: 5), width: self.frame.width - Common.Size(s: 10), height: 1))
        line.backgroundColor = .lightGray
        self.addSubview(line)
        
        estimateCellHeight = line.frame.origin.y + line.frame.height + Common.Size(s: 10)
    }
}
