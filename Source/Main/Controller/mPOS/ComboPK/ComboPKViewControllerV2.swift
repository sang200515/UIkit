//
//  ComboPKViewControllerV2.swift
//  fptshop
//
//  Created by tan on 4/30/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import AVFoundation
class ComboPKViewControllerV2: UIViewController,UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate,UISearchControllerDelegate{
    
    var barClose : UIBarButtonItem!
    
    
    var tfSPGoiY:UITextField!
    var tfGiaSanPham:UITextField!
    var tableView: UITableView = UITableView()
    var scrollView:UIScrollView!
    var listSP:[ComboPK_Search_TableView] = []
    
    var viewTuVan:UIView!
    
    var lblTongTienCacMonValue:UILabel!
    var lblTongThanhToanValue:UILabel!
    var lblTietKiemSauKhiGiamValue:UILabel!
    var lblBuThemSoVoiMonChinhValue:UILabel!
    
    var lblCauTuVan:UILabel!
    
    var viewTuVan2:UIView!
    var lblTuVan1Value:UILabel!
    var lblTuVan2Value:UILabel!
    var lblTuVan3Value:UILabel!
    var lblTuVan4Value:UILabel!
    
    var lblTuVan3:UILabel!
    var lblTietKiemSauKhiGiam:UILabel!
    
    var btNext:UIButton!
    
    var tableViewSearchSP: UITableView = UITableView()
    var lblTitleSPGoiY:UILabel!
    var lblTitleSPChinh:UILabel!
    var tfSPChinh:UITextField!
    
    
    var searchController: UISearchController!
    
    var topConstraint: NSLayoutConstraint!
    var barReloadRight : UIBarButtonItem!
    var isBarcodeSPChinh:Bool = false
    var lblTongInc:UILabel!
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00579c)
        self.title = "Tư Vấn ComboPK"
        self.navigationController?.navigationBar.isTranslucent = true
        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(ComboPKViewControllerV2.actionClose), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        
        
        let btRightIcon = UIButton.init(type: .custom)
        btRightIcon.setImage(#imageLiteral(resourceName: "ReloadPO"), for: UIControl.State.normal)
        btRightIcon.imageView?.contentMode = .scaleAspectFit
        btRightIcon.addTarget(self, action: #selector(ComboPKViewControllerV2.reloadData), for: UIControl.Event.touchUpInside)
        btRightIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barReloadRight = UIBarButtonItem(customView: btRightIcon)
        
        
        
        
        self.navigationItem.rightBarButtonItems = [barReloadRight]
        
        
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        
        self.view.addSubview(scrollView)
        
        
        Cache.comboPKSP = nil
        
        lblTitleSPChinh = UILabel(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 5), width: self.view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTitleSPChinh.textAlignment = .left
        lblTitleSPChinh.textColor = UIColor.black
        lblTitleSPChinh.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTitleSPChinh.text = "Sản Phẩm Chính"
        scrollView.addSubview(lblTitleSPChinh)
        
        tfSPChinh = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblTitleSPChinh.frame.origin.y + lblTitleSPChinh.frame.size.height + Common.Size(s:5), width: self.view.frame.size.width - Common.Size(s:80) , height: Common.Size(s:30)));
        tfSPChinh.placeholder = "Nhập Giá / Tên / Mã sản phẩm chính"
        tfSPChinh.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        tfSPChinh.borderStyle = UITextField.BorderStyle.roundedRect
        tfSPChinh.autocorrectionType = UITextAutocorrectionType.no
        tfSPChinh.keyboardType = UIKeyboardType.default
        tfSPChinh.returnKeyType = UIReturnKeyType.done
        tfSPChinh.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSPChinh.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSPChinh.delegate = self
        scrollView.addSubview(tfSPChinh)
        
        
        let tapSearchSPChinh = UITapGestureRecognizer(target: self, action: #selector(self.tapSearchSPChinh))
        tfSPChinh.isUserInteractionEnabled = true
        tfSPChinh.addGestureRecognizer(tapSearchSPChinh)
        
        let btnScan = UIImageView(frame:CGRect(x: tfSPChinh.frame.size.width + tfSPChinh.frame.origin.x + Common.Size(s: 10) , y:  tfSPChinh.frame.origin.y, width: Common.Size(s:25), height: tfSPChinh.frame.size.height));
        btnScan.image = #imageLiteral(resourceName: "scan_barcode_1")
        btnScan.contentMode = .scaleAspectFit
        
        
        let tapBarcodeSPChinh = UITapGestureRecognizer(target: self, action: #selector(actionIntentBarcodeSPChinh))
        btnScan.addGestureRecognizer(tapBarcodeSPChinh)
        btnScan.isUserInteractionEnabled = true
        scrollView.addSubview(btnScan)
        
        
        lblTitleSPGoiY = UILabel(frame: CGRect(x: Common.Size(s: 10), y:tfSPChinh.frame.size.height + tfSPChinh.frame.origin.y + Common.Size(s: 5), width: self.view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTitleSPGoiY.textAlignment = .left
        lblTitleSPGoiY.textColor = UIColor.black
        lblTitleSPGoiY.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTitleSPGoiY.text = "Sản Phẩm Gợi Ý"
        scrollView.addSubview(lblTitleSPGoiY)
        
        tfSPGoiY = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblTitleSPGoiY.frame.origin.y + lblTitleSPGoiY.frame.size.height + Common.Size(s:5), width: self.view.frame.size.width - Common.Size(s:80) , height: Common.Size(s:30)));
        tfSPGoiY.placeholder = "Nhập Tên / Mã Sản Phẩm"
        tfSPGoiY.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        tfSPGoiY.borderStyle = UITextField.BorderStyle.roundedRect
        tfSPGoiY.autocorrectionType = UITextAutocorrectionType.no
        tfSPGoiY.keyboardType = UIKeyboardType.default
        tfSPGoiY.returnKeyType = UIReturnKeyType.done
        tfSPGoiY.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSPGoiY.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSPGoiY.delegate = self
        scrollView.addSubview(tfSPGoiY)
        
        
        let btnScan2 = UIImageView(frame:CGRect(x: tfSPGoiY.frame.size.width + tfSPGoiY.frame.origin.x + Common.Size(s: 10) , y:  tfSPGoiY.frame.origin.y, width: Common.Size(s:25), height: tfSPGoiY.frame.size.height));
        btnScan2.image = #imageLiteral(resourceName: "scan_barcode_1")
        btnScan2.contentMode = .scaleAspectFit
        scrollView.addSubview(btnScan2)
        
        let tapBarcodeSPPhu = UITapGestureRecognizer(target: self, action: #selector(actionIntentBarcodeSPPhu))
        btnScan2.addGestureRecognizer(tapBarcodeSPPhu)
        btnScan2.isUserInteractionEnabled = true
        
        
        let tapSearchSPPhu = UITapGestureRecognizer(target: self, action: #selector(self.tapSearchSPPhu))
        tfSPGoiY.isUserInteractionEnabled = true
        tfSPGoiY.addGestureRecognizer(tapSearchSPPhu)
        
        tableView.frame = CGRect(x: Common.Size(s: 10), y: tfSPGoiY.frame.origin.y + tfSPGoiY.frame.size.height + Common.Size(s: 10) , width: scrollView.frame.size.width - Common.Size(s:20), height: Common.Size(s: 350) )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemComboPKTableViewCell.self, forCellReuseIdentifier: "ItemComboPKTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        TableViewHelper.EmptyMessage(message: "Vui lòng thêm sản phẩm !.", viewController: self.tableView)
        
        scrollView.addSubview(tableView)
        navigationController?.navigationBar.isTranslucent = false
        
        lblTongInc = UILabel(frame: CGRect(x: Common.Size(s: 10), y:tableView.frame.size.height + tableView.frame.origin.y + Common.Size(s: 10), width: self.view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTongInc.textAlignment = .right
        lblTongInc.textColor = UIColor.red
        lblTongInc.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lblTongInc.text = ""
        scrollView.addSubview(lblTongInc)
        
        viewTuVan = UIView()
        viewTuVan.frame = CGRect(x: 0, y: lblTongInc.frame.origin.y + lblTongInc.frame.size.height + Common.Size(s: 10) , width: scrollView.frame.size.width , height: Common.Size(s: 80))
        
        viewTuVan.backgroundColor = UIColor.white
        
        scrollView.addSubview(viewTuVan)
        
        let lblTongTienCacMon = UILabel(frame: CGRect(x: Common.Size(s: 10), y:  Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:150), height: Common.Size(s:14)))
        lblTongTienCacMon.textAlignment = .left
        lblTongTienCacMon.textColor = UIColor.black
        lblTongTienCacMon.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        lblTongTienCacMon.text = "Tổng Tiền Các Món:"
        viewTuVan.addSubview(lblTongTienCacMon)
        
        lblTongTienCacMonValue = UILabel(frame: CGRect(x: lblTongTienCacMon.frame.origin.x + lblTongTienCacMon.frame.size.width + Common.Size(s: 10), y: Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTongTienCacMonValue.textAlignment = .left
        lblTongTienCacMonValue.textColor = UIColor(netHex: 0x00CC66)
        lblTongTienCacMonValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        
        viewTuVan.addSubview(lblTongTienCacMonValue)
        
        let lblTongTienThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lblTongTienCacMon.frame.size.height + lblTongTienCacMon.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:150), height: Common.Size(s:14)))
        lblTongTienThanhToan.textAlignment = .left
        lblTongTienThanhToan.textColor = UIColor.black
        lblTongTienThanhToan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        lblTongTienThanhToan.text = "Tổng Tiền Thanh Toán:"
        viewTuVan.addSubview(lblTongTienThanhToan)
        
        lblTongThanhToanValue = UILabel(frame: CGRect(x: lblTongTienThanhToan.frame.origin.x + lblTongTienThanhToan.frame.size.width + Common.Size(s: 10), y: lblTongTienCacMon.frame.size.height + lblTongTienCacMon.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTongThanhToanValue.textAlignment = .left
        lblTongThanhToanValue.textColor = UIColor(netHex: 0x00CCFF)
        lblTongThanhToanValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        
        viewTuVan.addSubview(lblTongThanhToanValue)
        
        lblTietKiemSauKhiGiam = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lblTongTienThanhToan.frame.size.height + lblTongTienThanhToan.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:150), height: Common.Size(s:14)))
        lblTietKiemSauKhiGiam.textAlignment = .left
        lblTietKiemSauKhiGiam.textColor = UIColor.black
        lblTietKiemSauKhiGiam.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        lblTietKiemSauKhiGiam.text = "Tiết Kiệm Sau Khi Giảm X%:"
        viewTuVan.addSubview(lblTietKiemSauKhiGiam)
        
        let strNumber: NSString = "Tiết Kiệm Sau Khi Giảm X% :" as NSString // you must set your
        let range = (strNumber).range(of: "X%")
        let attribute = NSMutableAttributedString.init(string: strNumber as String)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        
        lblTietKiemSauKhiGiam.attributedText = attribute
        
        lblTietKiemSauKhiGiamValue = UILabel(frame: CGRect(x: lblTietKiemSauKhiGiam.frame.origin.x + lblTietKiemSauKhiGiam.frame.size.width + Common.Size(s: 10), y:  lblTongTienThanhToan.frame.size.height + lblTongTienThanhToan.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTietKiemSauKhiGiamValue.textAlignment = .left
        lblTietKiemSauKhiGiamValue.textColor = UIColor.red
        lblTietKiemSauKhiGiamValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        
        viewTuVan.addSubview(lblTietKiemSauKhiGiamValue)
        
        
        let lblBuThemMonChinh = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lblTietKiemSauKhiGiam.frame.size.height + lblTietKiemSauKhiGiam.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:150), height: Common.Size(s:14)))
        lblBuThemMonChinh.textAlignment = .left
        lblBuThemMonChinh.textColor = UIColor.black
        lblBuThemMonChinh.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        lblBuThemMonChinh.text = "Bù Thêm So Với Món Chính:"
        
        viewTuVan.addSubview(lblBuThemMonChinh)
        
        lblBuThemSoVoiMonChinhValue = UILabel(frame: CGRect(x: lblBuThemMonChinh.frame.origin.x + lblBuThemMonChinh.frame.size.width + Common.Size(s: 10), y: lblTietKiemSauKhiGiam.frame.size.height + lblTietKiemSauKhiGiam.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblBuThemSoVoiMonChinhValue.textAlignment = .left
        lblBuThemSoVoiMonChinhValue.textColor = UIColor.red
        lblBuThemSoVoiMonChinhValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        
        viewTuVan.addSubview(lblBuThemSoVoiMonChinhValue)
        
        
        lblCauTuVan = UILabel(frame: CGRect(x: Common.Size(s: 10), y: viewTuVan.frame.size.height + viewTuVan.frame.origin.y +  Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblCauTuVan.textAlignment = .left
        lblCauTuVan.textColor = UIColor.black
        lblCauTuVan.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lblCauTuVan.text = "Câu Tư Vấn :"
        scrollView.addSubview(lblCauTuVan)
        
        viewTuVan2 = UIView()
        viewTuVan2.frame = CGRect(x: 0, y: lblCauTuVan.frame.origin.y + lblCauTuVan.frame.size.height + Common.Size(s: 5) , width: scrollView.frame.size.width, height: Common.Size(s: 230))
        
        viewTuVan2.backgroundColor = UIColor.white
        
        scrollView.addSubview(viewTuVan2)
        
        let lblTuVan1 = UILabel(frame: CGRect(x: Common.Size(s: 10), y:  Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:150), height: Common.Size(s:14)))
        lblTuVan1.textAlignment = .left
        lblTuVan1.textColor = UIColor.black
        lblTuVan1.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        
        let strNumber2: NSString = "Anh/Chị đã mua Món chính với giá" as NSString // you must set your
        let range2 = (strNumber2).range(of: "Món chính")
        let attribute2 = NSMutableAttributedString.init(string: strNumber2 as String)
        attribute2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range2)
        
        lblTuVan1.attributedText = attribute2
        
        viewTuVan2.addSubview(lblTuVan1)
        
        lblTuVan1Value = UILabel(frame: CGRect(x: lblTuVan1.frame.origin.x + lblTuVan1.frame.size.width + Common.Size(s: 5), y: Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTuVan1Value.textAlignment = .left
        lblTuVan1Value.textColor = UIColor.black
        lblTuVan1Value.textColor = UIColor(netHex: 0x00CC66)
        lblTuVan1Value.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        viewTuVan2.addSubview(lblTuVan1Value)
        
        let lblTuVan2 = UILabel(frame: CGRect(x: Common.Size(s: 10), y:  lblTuVan1.frame.size.height + lblTuVan1.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:29)))
        lblTuVan2.textAlignment = .left
        
        lblTuVan2.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        
        lblTuVan2.numberOfLines = 0
        lblTuVan2.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        lblTuVan2.minimumScaleFactor = 0.8
        lblTuVan2.textColor = UIColor(netHex: 0x3399FF)
        lblTuVan2.text = "Vì bên em đang có CTKM Combo Càng mua càng rẻ ^^ "
        viewTuVan2.addSubview(lblTuVan2)
        
        lblTuVan3 = UILabel(frame: CGRect(x: Common.Size(s: 10), y:  lblTuVan2.frame.size.height + lblTuVan2.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:110), height: Common.Size(s:60)))
        lblTuVan3.textAlignment = .left
        lblTuVan3.textColor = UIColor.black
        lblTuVan3.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        lblTuVan3.text = "Em sẽ lấy cho anh/chị X món phụ kiện hữu ích cho điện thoại bao gồm các món (tư vấn công dụng từng món cho khách) mà chỉ cần bỏ thêm"
        
        let strNumber3: NSString = "Em sẽ lấy cho anh/chị X món phụ kiện hữu ích cho điện thoại bao gồm các món (tư vấn công dụng từng món cho khách) mà chỉ cần bỏ thêm" as NSString // you must set your
        let range3 = (strNumber3).range(of: "X")
        let attribute3 = NSMutableAttributedString.init(string: strNumber3 as String)
        attribute3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range3)
        
        lblTuVan3.attributedText = attribute3
        
        lblTuVan3.numberOfLines = 0
        lblTuVan3.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        lblTuVan3.minimumScaleFactor = 0.8
        
        viewTuVan2.addSubview(lblTuVan3)
        
        lblTuVan2Value = UILabel(frame: CGRect(x: lblTuVan3.frame.origin.x + lblTuVan3.frame.size.width + Common.Size(s: 5), y: lblTuVan2.frame.size.height + lblTuVan2.frame.origin.y + Common.Size(s: 30), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTuVan2Value.textAlignment = .left
        lblTuVan2Value.textColor = UIColor.black
        lblTuVan2Value.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        viewTuVan2.addSubview(lblTuVan2Value)
        
        let lblTuVan4 = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lblTuVan3.frame.size.height + lblTuVan3.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:150), height: Common.Size(s:14)))
        lblTuVan4.textAlignment = .left
        lblTuVan4.textColor = UIColor.black
        lblTuVan4.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        lblTuVan4.text = "Tính ra mình tiết kiệm được:"
        viewTuVan2.addSubview(lblTuVan4)
        
        lblTuVan3Value = UILabel(frame: CGRect(x: lblTuVan4.frame.origin.x + lblTuVan4.frame.size.width + Common.Size(s: 5), y: lblTuVan3.frame.size.height + lblTuVan3.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTuVan3Value.textAlignment = .left
        lblTuVan3Value.textColor = UIColor.red
        lblTuVan3Value.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        viewTuVan2.addSubview(lblTuVan3Value)
        
        
        let lblTuVan5 = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lblTuVan4.frame.size.height + lblTuVan4.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:150), height: Common.Size(s:14)))
        lblTuVan5.textAlignment = .left
        lblTuVan5.textColor = UIColor.red
        lblTuVan5.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        lblTuVan5.text = "So với giá ban đầu là:"
        viewTuVan2.addSubview(lblTuVan5)
        
        lblTuVan4Value = UILabel(frame: CGRect(x: lblTuVan5.frame.origin.x + lblTuVan5.frame.size.width + Common.Size(s: 5), y: lblTuVan4.frame.size.height + lblTuVan4.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTuVan4Value.textAlignment = .left
        lblTuVan4Value.textColor = UIColor.black
        lblTuVan4Value.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        viewTuVan2.addSubview(lblTuVan4Value)
        
        
        btNext = UIButton(frame: CGRect(x: Common.Size(s: 10), y: lblTuVan5.frame.size.height + lblTuVan5.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 30)))
        btNext.layer.cornerRadius = 5
        btNext.setTitle("Tạo Đơn Hàng",for: .normal)
        btNext.titleLabel?.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        btNext.backgroundColor = UIColor.init(netHex:0x00955E)
        viewTuVan2.addSubview(btNext)
        btNext.addTarget(self, action:#selector(self.payAction), for: .touchUpInside)
        
        
        
        
        scrollView.contentSize = CGSize(width:self.view.frame.size.width, height: viewTuVan2.frame.origin.y + viewTuVan2.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 20))
        
        
        
        let currentTimeInMiliseconds = getCurrentMillis()
        let defaults = UserDefaults.standard
        let CacheTimeContact = defaults.integer(forKey: "CacheTimeSearchPK")
        if(CacheTimeContact > 0){
            if(currentTimeInMiliseconds - Int64(CacheTimeContact) < 86400000){ //1 day
                
            }else{
                let newViewController = LoadingViewController()
                newViewController.content = "Đang cập nhật danh sách phụ kiện..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    DBMangerComboPK.sharedInstance.deleteFromDb()
                    MPOSAPIManager.sp_mpos_FRT_SP_combopk_searchsp(keyword: "") { (results, err) in
                        if(results.count > 0){
                            debugPrint("COUNT \(results.count)")
                            DBMangerComboPK.sharedInstance.addListData(objects: results)
                            let currentTimeInMiliseconds2 = self.getCurrentMillis()
                            defaults.set(currentTimeInMiliseconds2, forKey: "CacheTimeSearchPK")
                            debugPrint("COUNT TIEM  \((currentTimeInMiliseconds2 - currentTimeInMiliseconds))")
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                
                            }
                        }
                    
                    }
                    
                }
            }
        }else{
            let newViewController = LoadingViewController()
            newViewController.content = "Đang cập nhật danh sách phụ kiện..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                DBMangerComboPK.sharedInstance.deleteFromDb()
                MPOSAPIManager.sp_mpos_FRT_SP_combopk_searchsp(keyword: "") { (results, err) in
                    if(results.count > 0){
                        debugPrint("COUNT \(results.count)")
                        DBMangerComboPK.sharedInstance.addListData(objects: results)
                        let currentTimeInMiliseconds2 = self.getCurrentMillis()
                        defaults.set(currentTimeInMiliseconds2, forKey: "CacheTimeSearchPK")
                        debugPrint("COUNT TIEM  \((currentTimeInMiliseconds2 - currentTimeInMiliseconds))")
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        }
                    }
                  
                }
            }
        }
        
        
        
        
    }
    @objc func reloadData(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang cập nhật danh sách phụ kiện..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            DBMangerComboPK.sharedInstance.deleteFromDb()
            MPOSAPIManager.sp_mpos_FRT_SP_combopk_searchsp(keyword: "") { (results, err) in
                if(results.count > 0){
                    debugPrint("COUNT \(results.count)")
                    DBMangerComboPK.sharedInstance.addListData(objects: results)
                    //                let currentTimeInMiliseconds2 = self.getCurrentMillis()
                    //                defaults.set(currentTimeInMiliseconds2, forKey: "CacheTimeSearchPK")
                    //                debugPrint("COUNT TIEM  \((currentTimeInMiliseconds2 - currentTimeInMiliseconds))")
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        
                    }
                }
               
            }
            
        }
        
    }
    @objc func actionIntentBarcodeSPChinh(){
        self.isBarcodeSPChinh = true
        
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            self.updateWithCode(code: code)
        }
        self.present(viewController, animated: false, completion: nil)
        
    }
    @objc func actionIntentBarcodeSPPhu(){
        self.isBarcodeSPChinh = false
        
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            self.updateWithCode(code: code)
        }
        self.present(viewController, animated: false, completion: nil)
    }
    func updateWithCode(code: String) {
        let item:[ComboPK_SearchSP] = DBMangerComboPK.sharedInstance.searchSku(key: code)
        var isSameProduct:Bool = false
        for item in listSP{
            if(item.Sku == code){
                isSameProduct = true
                break
            }
        }
        if(isSameProduct == true){
            let title = "Thông Báo"
            let message = "Mã sản phẩm này đã được chọn, vui lòng chọn sản phẩm khác !!!"
            let image = UIImage(named: "pexels-photo-103290")
            // Create the dialog
            let popup = PopupDialog(title: title, message: message, image: image)
            let buttonTwo = DefaultButton(title: "OK") {
                print("OK click!")
                self.dismiss(animated: true, completion: nil)
            }
            popup.addButtons([buttonTwo])
            // Present dialog
            self.present(popup, animated: true, completion: nil)
            return
        }
        if(item.count == 0){
            let title = "Thông Báo"
            let message = "Không tìm thấy sản phẩm !!!"
            let image = UIImage(named: "pexels-photo-103290")
            // Create the dialog
            let popup = PopupDialog(title: title, message: message, image: image)
            let buttonTwo = DefaultButton(title: "OK") {
                print("OK click!")
                self.dismiss(animated: true, completion: nil)
            }
            popup.addButtons([buttonTwo])
            // Present dialog
            self.present(popup, animated: true, completion: nil)
            return
        }
        if(isBarcodeSPChinh == false){
            let comboPK:ComboPK_Search_TableView = ComboPK_Search_TableView(Name:item[0].Name
                , Price:item[0].Price
                , Sku: item[0].Sku
                , BonusScopeBoom: item[0].BonusScopeBoom
                , Sl: item[0].Sl
                , linkAnh: item[0].linkAnh
                , isSPChinh: "N"
                ,id: item[0].id
                ,brandID: item[0].brandID
                , brandName: item[0].brandName
                , typeId: item[0].typeId
                , typeName: item[0].typeName
                , priceMarket: item[0].priceMarket
                , priceBeforeTax: item[0].priceBeforeTax
                , iconUrl: item[0].iconUrl
                ,imageUrl: item[0].imageUrl
                , promotion: item[0].promotion
                , includeInfo: item[0].includeInfo
                , hightlightsDes: item[0].hightlightsDes
                , labelName: item[0].labelName
                , urlLabelPicture: item[0].urlLabelPicture
                , isRecurring: item[0].isRecurring
                , manSerNum: item[0].manSerNum
                ,  qlSerial: item[0].qlSerial
                ,  LableProduct: item[0].LableProduct
                , hotSticker: item[0].hotSticker
                , is_NK: item[0].is_NK
                , is_ExtendedWar: item[0].is_ExtendedWar
                ,skuBH: item[0].skuBH
                ,nameBH: item[0].nameBH
                ,brandGoiBH: item[0].brandGoiBH
                , isPickGoiBH: item[0].isPickGoiBH
                , amountGoiBH: item[0].amountGoiBH
                ,itemCodeGoiBH: item[0].itemCodeGoiBH
                ,itemNameGoiBH: item[0].itemNameGoiBH
                ,priceSauKM: item[0].priceSauKM
                ,role2: item[0].role2)
            self.listSP.append(comboPK)
            
        }else{
            var isSPChinh:Bool = false
            for item in self.listSP{
                if(item.isSPChinh == "Y"){
                    isSPChinh = true
                }
            }
            if(isSPChinh == true){
                let title = "Thông Báo"
                let message = "Chỉ được thêm một sản phẩm chính !!!"
                let image = UIImage(named: "pexels-photo-103290")
                // Create the dialog
                let popup = PopupDialog(title: title, message: message, image: image)
                let buttonTwo = DefaultButton(title: "OK") {
                    print("OK click!")
                    self.dismiss(animated: true, completion: nil)
                }
                popup.addButtons([buttonTwo])
                // Present dialog
                self.present(popup, animated: true, completion: nil)
                return
            }
            
            let comboPK:ComboPK_Search_TableView = ComboPK_Search_TableView(Name:item[0].Name
                , Price:item[0].Price
                , Sku: item[0].Sku
                , BonusScopeBoom: item[0].BonusScopeBoom
                , Sl: item[0].Sl
                , linkAnh: item[0].linkAnh
                , isSPChinh: "Y"
                ,id: item[0].id
                ,brandID: item[0].brandID
                , brandName: item[0].brandName
                , typeId: item[0].typeId
                , typeName: item[0].typeName
                , priceMarket: item[0].priceMarket
                , priceBeforeTax: item[0].priceBeforeTax
                , iconUrl: item[0].iconUrl
                ,imageUrl: item[0].imageUrl
                , promotion: item[0].promotion
                , includeInfo: item[0].includeInfo
                , hightlightsDes: item[0].hightlightsDes
                , labelName: item[0].labelName
                , urlLabelPicture: item[0].urlLabelPicture
                , isRecurring: item[0].isRecurring
                , manSerNum: item[0].manSerNum
                ,  qlSerial: item[0].qlSerial
                ,  LableProduct: item[0].LableProduct
                , hotSticker: item[0].hotSticker
                , is_NK: item[0].is_NK
                , is_ExtendedWar: item[0].is_ExtendedWar
                , skuBH: item[0].skuBH
                ,nameBH: item[0].nameBH
                , brandGoiBH: item[0].brandGoiBH
                , isPickGoiBH: item[0].isPickGoiBH
                , amountGoiBH: item[0].amountGoiBH
                ,itemCodeGoiBH: item[0].itemCodeGoiBH
                ,itemNameGoiBH: item[0].itemNameGoiBH
                ,priceSauKM: item[0].priceSauKM
                ,role2: item[0].role2)
            self.listSP.append(comboPK)
            
        }
        self.tableView.reloadData()
        self.getSanPhamGoiY()
    }
    @objc func tapSearchSPChinh(){
        var isSPChinh:Bool = false
        for item in self.listSP{
            if(item.isSPChinh == "Y"){
                isSPChinh = true
            }
        }
        if(isSPChinh == true){
            let title = "Thông Báo"
            let message = "Chỉ được thêm một sản phẩm chính !!!"
            let image = UIImage(named: "pexels-photo-103290")
            // Create the dialog
            let popup = PopupDialog(title: title, message: message, image: image)
            let buttonTwo = DefaultButton(title: "OK") {
                print("OK click!")
                self.dismiss(animated: true, completion: nil)
            }
            popup.addButtons([buttonTwo])
            // Present dialog
            self.present(popup, animated: true, completion: nil)
            return
        }
        let newViewController = SearchPKViewController()
        newViewController.isSPChinh = "Y"
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func tapSearchSPPhu(){
        let newViewController = SearchPKViewController()
        newViewController.isSPChinh = "N"
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func payAction(){
        if(Cache.carts.count > 0){
            Cache.carts.removeAll()
            Cache.itemsPromotion.removeAll()
        }
        for item in listSP{
            if(item.Sku != ""){
                let pro = Product(model_id:"",id: item.id, name: item.Name, brandID: item.brandID, brandName: item.brandName, typeId: item.typeId, typeName: item.typeName, sku: item.Sku, price: Float(item.Price), priceMarket: item.priceMarket, priceBeforeTax: item.priceBeforeTax, iconUrl: item.linkAnh, imageUrl: item.imageUrl, promotion: item.promotion, includeInfo: item.includeInfo, hightlightsDes: item.hightlightsDes, labelName: item.labelName, urlLabelPicture: item.urlLabelPicture, isRecurring: item.isRecurring, manSerNum: item.manSerNum, bonusScopeBoom: item.BonusScopeBoom, qlSerial: item.qlSerial,inventory: 0, LableProduct: item.LableProduct,p_matkinh:"",ecomColorValue:"",ecomColorName:"", ecom_itemname_web: "",price_special:0,price_online_pos: 0, price_online: 0, hotSticker: item.hotSticker, is_NK: item.is_NK, is_ExtendedWar: item.is_ExtendedWar,skuBH: item.skuBH ,nameBH: item.nameBH as! [String],brandGoiBH: item.brandGoiBH as! [String],isPickGoiBH: item.isPickGoiBH,amountGoiBH:item.amountGoiBH,itemCodeGoiBH:item.itemCodeGoiBH,itemNameGoiBH:item.itemNameGoiBH,priceSauKM: 0,role2: [] as! [String])
                let cart = Cart(sku: item.Sku, product: pro,quantity: 1,color:"",inStock: -1, imei: "",price: Float(item.Price), priceBT: 0, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                Cache.carts.append(cart)
                
            }
            
        }
        let newViewController = CartViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
     
        if(Cache.comboPKSP != nil){
            var isSameProduct:Bool = false
            for item in listSP{
                if(Cache.comboPKSP?.Sku != ""){
                    if(item.Sku == Cache.comboPKSP?.Sku){
                        isSameProduct = true
                        break
                    }
                }
                
            }
            if(isSameProduct == true){
                let title = "Thông Báo"
                let message = "Mã sản phẩm này đã được chọn, vui lòng chọn sản phẩm khác !!!"
                let image = UIImage(named: "pexels-photo-103290")
                // Create the dialog
                let popup = PopupDialog(title: title, message: message, image: image)
                let buttonTwo = DefaultButton(title: "OK") {
                    print("OK click!")
                    self.dismiss(animated: true, completion: nil)
                }
                popup.addButtons([buttonTwo])
                // Present dialog
                self.present(popup, animated: true, completion: nil)
                return
            }
            listSP.append(Cache.comboPKSP!)
            self.tableView.reloadData()
            self.getSanPhamGoiY()
            Cache.comboPKSP = nil
            
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listSP.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemComboPKTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemComboPKTableViewCell")
        let item:ComboPK_Search_TableView = self.listSP[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return Common.Size(s:80);
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
            
            let item:ComboPK_Search_TableView = self.listSP[indexPath.row]
            if let index = self.listSP.firstIndex(of: item) {
                self.listSP.remove(at: index)
                self.getSanPhamGoiY()
            }
            self.tableView.reloadData()
        }
        
    }
    
    func getCurrentMillis()->Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    
    
    @objc func backButton(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func getSanPhamGoiY(){
        var tongtien:Int = 0
        var tienspchinh:Int = 0
        var sovoibandau:Int = 0
        var countSP:Int = 0
        
        var rs:String = "<line>"
        print(self.listSP.count)
        for item in self.listSP{
            // print(item.Price)
            tongtien = item.Price + tongtien
            print(tongtien)
            var is_spchinh:String = ""
            if(item.isSPChinh == "Y"){
                tienspchinh = item.Price
                is_spchinh = "Y"
            }else{
                is_spchinh = "N"
                countSP = countSP + 1
            }
            
            rs = rs + "<item itemcode=\"\(item.Sku)\" price=\"\(item.Price)\" is_spchinh=\"\(is_spchinh)\"/>"
            
            
        }
        rs = rs + "</line>"
        print(rs)
        sovoibandau = tongtien - tienspchinh
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin combo PK..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.sp_mpos_FRT_SP_comboPK_calculator(price: "\(tongtien)",priceadd:"0",xmllistsp:"\(rs)") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.lblTongTienCacMonValue.text = "\(Common.convertCurrencyV2(value: tongtien)) VNĐ"
                    self.lblTongThanhToanValue.text =  "\(Common.convertCurrencyV2(value: (results?.thongtinTV[0].ThanhTienSauKM)!)) VNĐ"
                    self.lblTietKiemSauKhiGiamValue.text = "\(Common.convertCurrencyV2(value: (tongtien - (results?.thongtinTV[0].ThanhTienSauKM)!))) VNĐ"
                    //
                    let strNumber: NSString = "Tiết Kiệm Sau Khi Giảm \(results!.thongtinTV[0].PTGiamGia)% :" as NSString // you must set your
                    let range = (strNumber).range(of: "\(results!.thongtinTV[0].PTGiamGia)%")
                    let attribute = NSMutableAttributedString.init(string: strNumber as String)
                    attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
                    
                    self.lblTietKiemSauKhiGiam.attributedText = attribute
                    
                    //
                    let strNumber3: NSString = "Em sẽ lấy cho anh/chị \(countSP) món phụ kiện hữu ích cho điện thoại bao gồm các món (tư vấn công dụng từng món cho khách) mà chỉ cần bỏ thêm" as NSString // you must set your
                    let range3 = (strNumber3).range(of: "\(countSP)")
                    let attribute3 = NSMutableAttributedString.init(string: strNumber3 as String)
                    attribute3.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range3)
                    
                    self.lblTuVan3.attributedText = attribute3
                    //
                    
                    self.lblBuThemSoVoiMonChinhValue.text = "\(Common.convertCurrencyV2(value: (results?.thongtinTV[0].SoTienTraThem)!)) VNĐ"
                    //cau tu van
                    self.lblTuVan1Value.text = "\(Common.convertCurrencyV2(value: tienspchinh)) VNĐ"
                    self.lblTuVan2Value.text = "\(Common.convertCurrencyV2(value: (results?.thongtinTV[0].SoTienTraThem)!)) VNĐ"
                    self.lblTuVan3Value.text = "\(Common.convertCurrencyV2(value: (tongtien - (results?.thongtinTV[0].ThanhTienSauKM)!))) VNĐ"
                    self.lblTuVan4Value.text = "\(Common.convertCurrencyV2(value: sovoibandau)) VNĐ"
                    //tinh tong inc
                    //                    var tongInc:Int = 0
                    //                    for item in self.listSP{
                    //                        if(item.BonusScopeBoom != ""){
                    //                              tongInc = Int(String(item.BonusScopeBoom.filter { "0"..."9" ~= $0 }))! + tongInc
                    //                        }
                    //
                    //                    }
                    
                    self.lblTongInc.text = "Tổng Inc: \((results?.thongtinTV[0].DiemThuong)!)"
                    
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    
    
    
    
    
    @objc func actionClose(){
        //        self.dismiss(animated: false, completion: nil)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    //    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    //        self.view.removeConstraint(self.topConstraint)
    //        if #available(iOS 11.0, *) {
    //            self.topConstraint = self.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
    //        } else {
    //            self.topConstraint = self.view.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor)
    //        }
    //        self.topConstraint.isActive = true
    //
    //        self.searchController.searchBar.alpha = 0
    //        UIView.animate(withDuration: 0.3, animations: {
    //            self.view.layoutIfNeeded()
    //            self.tfSPChinh.alpha = 0
    //            self.searchController.searchBar.alpha = 1
    //        }) { (_) in
    //            self.searchController.isActive = true
    //        }
    //        return false
    //    }
    
    //    func didPresentSearchController(_ searchController: UISearchController) {
    //        searchController.searchBar.becomeFirstResponder()
    //    }
    //
    //    func didDismissSearchController(_ searchController: UISearchController) {
    //        self.view.removeConstraint(self.topConstraint)
    //        self.topConstraint = self.view.topAnchor.constraint(equalTo: self.view.centerYAnchor)
    //        self.topConstraint.isActive = true
    //
    //        self.tfSPChinh.alpha = 0
    //        UIView.animate(withDuration: 0.3, animations: {
    //            self.view.layoutIfNeeded()
    //            self.tfSPChinh.alpha = 1
    //            self.searchController.searchBar.alpha = 0
    //        })
    //    }
    
    
    
}



class ItemComboPKTableViewCell: UITableViewCell {
    var stt:UILabel!
    var tensp:UILabel!
    var tonkho:UILabel!
    var gia:UILabel!
    var diemthuong:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        
        tensp = UILabel()
        tensp.textColor = UIColor.black
        tensp.font = tensp.font.withSize(14)
        //tenSP.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        
        tensp.numberOfLines = 0
        tensp.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        tensp.minimumScaleFactor = 0.8
        
        contentView.addSubview(tensp)
        
        tonkho = UILabel()
        tonkho.textColor = UIColor.black
        tonkho.numberOfLines = 1
        tonkho.font = tonkho.font.withSize(13)
        //sl.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(tonkho)
        
        
        
        gia = UILabel()
        gia.textColor = UIColor.black
        gia.numberOfLines = 1
        gia.font = tonkho.font.withSize(13)
        //sl.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(gia)
        
        diemthuong = UILabel()
        diemthuong.textColor = UIColor.black
        diemthuong.numberOfLines = 1
        diemthuong.font = diemthuong.font.withSize(13)
        //sl.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(diemthuong)
        
    }
    var so1:ComboPK_Search_TableView?
    func setup(so:ComboPK_Search_TableView){
        so1 = so
        
        
        tensp.frame = CGRect(x: Common.Size(s: 10),y: Common.Size(s:5) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 10) ,height: Common.Size(s:50))
        
        tensp.text = so.Name
        
        tonkho.frame = CGRect(x: Common.Size(s: 10),y: tensp.frame.size.height + tensp.frame.origin.y + Common.Size(s: 5) ,width:  Common.Size(s: 80) ,height: Common.Size(s:16))
        
        tonkho.text = "Tồn Kho: \(so.Sl)"
        
        
        
        gia.frame = CGRect(x: tonkho.frame.origin.x + tonkho.frame.size.width,y: tensp.frame.size.height + tensp.frame.origin.y + Common.Size(s: 5) ,width: Common.Size(s: 90) ,height: Common.Size(s:16))
        
        gia.text = "Giá: \(Common.convertCurrencyV2(value: so.Price))"
        
        diemthuong.frame = CGRect(x: gia.frame.origin.x + gia.frame.size.width,y: tensp.frame.size.height + tensp.frame.origin.y + Common.Size(s: 5) ,width:  Common.Size(s: 100) ,height: Common.Size(s:16))
        
        diemthuong.text = "Inc: \(so.BonusScopeBoom)"
        if(so.isSPChinh == "Y"){
            tensp.textColor = UIColor.red
            tonkho.textColor = UIColor.red
            gia.textColor = UIColor.red
            diemthuong.textColor = UIColor.red
            
        }
        
        
    }
    
    
}

