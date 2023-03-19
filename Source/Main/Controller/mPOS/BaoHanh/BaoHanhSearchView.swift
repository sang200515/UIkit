//
//  BaoHanhSearch.swift
//  mPOS
//
//  Created by sumi on 12/15/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit

class BaoHanhSearchView: UIView {
    
    var viewInfo:UIView!
    var viewTable:UIView!
    var scrollView:UIScrollView!
    
    var edtSDT:UITextField!
    var edtImei:UITextField!
    var edtSONum:UITextField!
    var edtHoaDonDo:UITextField!
    
    var btnTimKiem:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.backgroundColor = .white
        
        
        let lbSDT = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSDT.textAlignment = .left
        lbSDT.textColor = UIColor.black
        lbSDT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSDT.text = "Số điện thoại"
        
        
        ///sdt
        
        edtSDT = UITextField(frame: CGRect(x: 15 , y: lbSDT.frame.origin.y + lbSDT.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtSDT.placeholder = "Tìm theo số điện thoại"
        edtSDT.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtSDT.borderStyle = UITextField.BorderStyle.roundedRect
        edtSDT.autocorrectionType = UITextAutocorrectionType.no
        edtSDT.keyboardType = UIKeyboardType.default
        edtSDT.returnKeyType = UIReturnKeyType.done
        edtSDT.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtSDT.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        
        
        let lbImei = UILabel(frame: CGRect(x: Common.Size(s:15), y:edtSDT.frame.origin.y + edtSDT.frame.size.height + Common.Size(s:5) , width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbImei.textAlignment = .left
        lbImei.textColor = UIColor.black
        lbImei.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbImei.text = "Nhập imei"
        
        
        ///sdt
        
        edtImei = UITextField(frame: CGRect(x: 15 , y: lbImei.frame.origin.y + lbImei.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtImei.placeholder = "Tìm theo imei"
        edtImei.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtImei.borderStyle = UITextField.BorderStyle.roundedRect
        edtImei.autocorrectionType = UITextAutocorrectionType.no
        edtImei.keyboardType = UIKeyboardType.default
        edtImei.returnKeyType = UIReturnKeyType.done
        edtImei.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtImei.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        ///////
        
        let lbSONum = UILabel(frame: CGRect(x: Common.Size(s:15), y:edtImei.frame.origin.y + edtImei.frame.size.height + Common.Size(s:5) , width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSONum.textAlignment = .left
        lbSONum.textColor = UIColor.black
        lbSONum.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSONum.text = "Nhập số SO"
        
        
        ///sdt
        
        edtSONum = UITextField(frame: CGRect(x: 15 , y: lbSONum.frame.origin.y + lbSONum.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtSONum.placeholder = "Tìm theo số SO"
        edtSONum.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtSONum.borderStyle = UITextField.BorderStyle.roundedRect
        edtSONum.autocorrectionType = UITextAutocorrectionType.no
        edtSONum.keyboardType = UIKeyboardType.default
        edtSONum.returnKeyType = UIReturnKeyType.done
        edtSONum.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtSONum.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        
        let lbHoaDonDo = UILabel(frame: CGRect(x: Common.Size(s:15), y:edtSONum.frame.origin.y + edtSONum.frame.size.height + Common.Size(s:5) , width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHoaDonDo.textAlignment = .left
        lbHoaDonDo.textColor = UIColor.black
        lbHoaDonDo.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHoaDonDo.text = "Hóa đơn đỏ"
        
        
        ///sdt
        
        edtHoaDonDo = UITextField(frame: CGRect(x: 15 , y: lbHoaDonDo.frame.origin.y + lbHoaDonDo.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtHoaDonDo.placeholder = "Tìm theo số Hóa đơn đỏ"
        edtHoaDonDo.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtHoaDonDo.borderStyle = UITextField.BorderStyle.roundedRect
        edtHoaDonDo.autocorrectionType = UITextAutocorrectionType.no
        edtHoaDonDo.keyboardType = UIKeyboardType.default
        edtHoaDonDo.returnKeyType = UIReturnKeyType.done
        edtHoaDonDo.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtHoaDonDo.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        
        
        /////
        
        btnTimKiem = UIButton(frame: CGRect(x:edtHoaDonDo.frame.origin.x, y: edtHoaDonDo.frame.origin.y + edtHoaDonDo.frame.size.height + Common.Size(s:10) , width: edtHoaDonDo.frame.size.width  , height: Common.Size(s:40)));
        btnTimKiem.backgroundColor = UIColor(netHex:0xEF4A40)
        //btnHoanTat.layer.cornerRadius = 20
        btnTimKiem.layer.borderWidth = 0.5
        btnTimKiem.layer.borderColor = UIColor.white.cgColor
        btnTimKiem.layer.cornerRadius = 5.0
        btnTimKiem.setTitle("Tìm kiếm",for: .normal)
        btnTimKiem.setTitleColor(UIColor.white, for: .normal)
        
        viewInfo = UIView(frame: CGRect(x:0,y: 0,width:UIScreen.main.bounds.size.width , height: (lbHoaDonDo.frame.size.height + edtHoaDonDo.frame.size.height) * 6 ))
        viewInfo.backgroundColor = UIColor(netHex:0xffffff)
        viewInfo.layer.borderWidth = 0.5
        viewInfo.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        addSubview(scrollView)
        scrollView.addSubview(viewInfo)
        viewInfo.addSubview(lbSDT)
        viewInfo.addSubview(lbImei)
        viewInfo.addSubview(lbHoaDonDo)
        viewInfo.addSubview(lbSONum)
        viewInfo.addSubview(edtSDT)
        viewInfo.addSubview(edtImei)
        viewInfo.addSubview(edtHoaDonDo)
        viewInfo.addSubview(edtSONum)
        viewInfo.addSubview(btnTimKiem)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
}
