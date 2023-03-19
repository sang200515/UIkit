//
//  MayDemoBHMainViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 5/12/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class MayDemoBHMainViewController: UIViewController, CAPSPageMenuDelegate {
    var pageMenu : CAPSPageMenu?
    var indexMenu:Int = 0
    
    var controller1 : TabSPDemoWillUpdateViewController!
    var controller2 : TabSPDemoDidUpdateViewController!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Cập nhật sản phẩm demo"
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        self.setUpView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name.init("didEnter_mayDemoBH"), object: nil)
    }
    
    func setUpView() {
        var controllerArray : [UIViewController] = []
        controller1 = TabSPDemoWillUpdateViewController()
        controller1.title = "Chưa cập nhật"
        controller1.parentNavigationController = self.navigationController
        controllerArray.append(controller1)
        
        controller2 = TabSPDemoDidUpdateViewController()
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
    
    @objc func refresh() {
        self.view.subviews.forEach({$0.removeFromSuperview()})
        self.setUpView()
    }
    
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        indexMenu = index
    }
    @objc func actionBack() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

class MayDemoBHCell: UITableViewCell {
    var lbProductID: UILabel!
    var lbProductName: UILabel!
    var lbImeiText: UILabel!
    var lbCreateDate: UILabel!
    var lbStatusValue: UILabel!
    var lbTimeUpdateText: UILabel!
    var lbUserUpdateText: UILabel!
    var lbIDPhieuBHText: UILabel!
    var estimateCellHeight: CGFloat = 0
    
    func setUpCell(item: ProductDemoBH) {
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let lbMaSP = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: (self.frame.width - Common.Size(s: 30))/3 + Common.Size(s: 10), height: Common.Size(s: 20)))
        lbMaSP.text = "Mã SP:"
        lbMaSP.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbMaSP)
        
        lbProductID = UILabel(frame: CGRect(x: lbMaSP.frame.origin.x + lbMaSP.frame.width, y: lbMaSP.frame.origin.y, width: ((self.frame.width - Common.Size(s: 30)) * 2/3) - Common.Size(s: 10), height: Common.Size(s: 20)))
        lbProductID.text = "\(item.item_code)"
        lbProductID.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbProductID)
        
        let lbTenSP = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbProductID.frame.origin.y + lbProductID.frame.height + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
        lbTenSP.text = "Tên SP:"
        lbTenSP.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbTenSP)
        
        lbProductName = UILabel(frame: CGRect(x: lbTenSP.frame.origin.x + lbTenSP.frame.width, y: lbTenSP.frame.origin.y, width: lbProductID.frame.width, height: Common.Size(s: 20)))
        lbProductName.text = "\(item.item_name)"
        lbProductName.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbProductName)
        
        let lbProductNameHeight: CGFloat = lbProductName.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbProductName.optimalHeight + Common.Size(s: 5)
        lbProductName.numberOfLines = 0
        lbProductName.frame = CGRect(x: lbProductName.frame.origin.x, y: lbProductName.frame.origin.y, width: lbProductName.frame.width, height: lbProductNameHeight)
        
        let lbImei = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbProductName.frame.origin.y + lbProductNameHeight + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
        lbImei.text = "IMEI:"
        lbImei.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbImei)
        
        lbImeiText = UILabel(frame: CGRect(x: lbImei.frame.origin.x + lbImei.frame.width, y: lbImei.frame.origin.y, width: lbProductID.frame.width, height: Common.Size(s: 20)))
        lbImeiText.text = "\(item.imei)"
        lbImeiText.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbImeiText)
        
        let lbNgayTao = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbImeiText.frame.origin.y + lbImeiText.frame.height + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
        lbNgayTao.text = "Ngày tạo:"
        lbNgayTao.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbNgayTao)
        
        lbCreateDate = UILabel(frame: CGRect(x: lbNgayTao.frame.origin.x + lbNgayTao.frame.width, y: lbNgayTao.frame.origin.y, width: lbProductID.frame.width, height: Common.Size(s: 20)))
        lbCreateDate.text = "\(item.create_datetime)"
        lbCreateDate.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbCreateDate)
        
        let lbTinhTrang = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
        lbTinhTrang.text = "Tình trạng:"
        lbTinhTrang.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbTinhTrang)
        
        lbStatusValue = UILabel(frame: CGRect(x: lbTinhTrang.frame.origin.x + lbTinhTrang.frame.width, y: lbTinhTrang.frame.origin.y, width: lbProductID.frame.width, height: Common.Size(s: 20)))
        lbStatusValue.text = "\(item.status_name)"
        lbStatusValue.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbStatusValue)
        
        if item.status_code == "P" { //chua cap nhat
            lbStatusValue.textColor = UIColor(red: 214/255, green: 48/255, blue: 49/255, alpha: 1)
        } else {
            lbStatusValue.textColor = UIColor(red: 9/255, green: 132/255, blue: 227/255, alpha: 1)
            
            let lbTimeUpdate = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
            lbTimeUpdate.text = "Ngày cập nhật:"
            lbTimeUpdate.font = UIFont.boldSystemFont(ofSize: 14)
            self.addSubview(lbTimeUpdate)
            
            lbTimeUpdateText = UILabel(frame: CGRect(x: lbTimeUpdate.frame.origin.x + lbTimeUpdate.frame.width, y: lbTimeUpdate.frame.origin.y, width: lbProductID.frame.width, height: Common.Size(s: 20)))
            lbTimeUpdateText.text = "\(item.update_datetime)"
            lbTimeUpdateText.font = UIFont.systemFont(ofSize: 14)
            self.addSubview(lbTimeUpdateText)
            
            let lbUserUpdate = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTimeUpdateText.frame.origin.y + lbTimeUpdateText.frame.height + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
            lbUserUpdate.text = "Người cập nhật:"
            lbUserUpdate.font = UIFont.boldSystemFont(ofSize: 14)
            self.addSubview(lbUserUpdate)
            
            lbUserUpdateText = UILabel(frame: CGRect(x: lbUserUpdate.frame.origin.x + lbUserUpdate.frame.width, y: lbUserUpdate.frame.origin.y, width: lbProductID.frame.width, height: Common.Size(s: 20)))
            lbUserUpdateText.text = "\(item.emp_update)"
            lbUserUpdateText.font = UIFont.systemFont(ofSize: 14)
            self.addSubview(lbUserUpdateText)
            
            let lbUserUpdateTextHeight: CGFloat = lbUserUpdateText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbUserUpdateText.optimalHeight + Common.Size(s: 5)
            lbUserUpdateText.numberOfLines = 0
            lbUserUpdateText.frame = CGRect(x: lbUserUpdateText.frame.origin.x, y: lbUserUpdateText.frame.origin.y, width: lbUserUpdateText.frame.width, height: lbUserUpdateTextHeight)
            
            let lbIDPhieuBH = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbUserUpdateText.frame.origin.y + lbUserUpdateTextHeight + Common.Size(s: 5), width: lbMaSP.frame.width, height: Common.Size(s: 20)))
            lbIDPhieuBH.text = "Số phiếu BH:"
            lbIDPhieuBH.font = UIFont.boldSystemFont(ofSize: 14)
            self.addSubview(lbIDPhieuBH)
            
            lbIDPhieuBHText = UILabel(frame: CGRect(x: lbIDPhieuBH.frame.origin.x + lbIDPhieuBH.frame.width, y: lbIDPhieuBH.frame.origin.y, width: lbProductID.frame.width, height: Common.Size(s: 20)))
            lbIDPhieuBHText.text = "\(item.warranty_code)"
            lbIDPhieuBHText.font = UIFont.systemFont(ofSize: 14)
            self.addSubview(lbIDPhieuBHText)
            
            lbTinhTrang.frame = CGRect(x: lbTinhTrang.frame.origin.x, y: lbIDPhieuBHText.frame.origin.y + lbIDPhieuBHText.frame.height + Common.Size(s: 5), width: lbTinhTrang.frame.width, height: lbTinhTrang.frame.height)
            lbStatusValue.frame = CGRect(x: lbTinhTrang.frame.origin.x + lbTinhTrang.frame.width, y: lbTinhTrang.frame.origin.y, width: lbStatusValue.frame.width, height: lbStatusValue.frame.height)
        }
        
        let line = UIView(frame: CGRect(x: Common.Size(s: 5), y: lbStatusValue.frame.origin.y + lbStatusValue.frame.height + Common.Size(s: 5), width: self.frame.width - Common.Size(s: 10), height: 1))
        line.backgroundColor = .lightGray
        self.addSubview(line)
        estimateCellHeight = line.frame.origin.y + line.frame.height + Common.Size(s: 5)
    }
}
