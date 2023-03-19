//
//  BaoHanhTaoPhieuTimSPView.swift
//  mPOS
//
//  Created by sumi on 1/10/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit

class BaoHanhTaoPhieuTimSPView: UIView {
    var viewInfo:UIView!
    var viewTable:UIView!
    var scrollView:UIScrollView!
    
    var edtSDT:UITextField!
    
    
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
        lbSDT.text = "Tên sản phẩm"
        
        
        ///sdt
        
        edtSDT = UITextField(frame: CGRect(x: 15 , y: lbSDT.frame.origin.y + lbSDT.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtSDT.placeholder = "Tìm theo tên sản phẩm"
        edtSDT.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtSDT.borderStyle = UITextField.BorderStyle.roundedRect
        edtSDT.autocorrectionType = UITextAutocorrectionType.no
        edtSDT.keyboardType = UIKeyboardType.default
        edtSDT.returnKeyType = UIReturnKeyType.done
        edtSDT.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtSDT.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        
        /////
        
        btnTimKiem = UIButton(frame: CGRect(x:edtSDT.frame.origin.x, y: edtSDT.frame.origin.y + edtSDT.frame.size.height + Common.Size(s:10) , width: edtSDT.frame.size.width  , height: Common.Size(s:40)));
        btnTimKiem.backgroundColor = UIColor(netHex:0xEF4A40)
        //btnHoanTat.layer.cornerRadius = 20
        btnTimKiem.layer.borderWidth = 0.5
        btnTimKiem.layer.borderColor = UIColor.white.cgColor
        btnTimKiem.layer.cornerRadius = 5.0
        btnTimKiem.setTitle("Tìm kiếm",for: .normal)
        btnTimKiem.setTitleColor(UIColor.white, for: .normal)
        
        viewInfo = UIView(frame: CGRect(x:0,y: 0,width:UIScreen.main.bounds.size.width , height: (lbSDT.frame.size.height + edtSDT.frame.size.height) * 3 ))
        viewInfo.backgroundColor = UIColor(netHex:0xffffff)
        viewInfo.layer.borderWidth = 0.5
        viewInfo.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        addSubview(scrollView)
        scrollView.addSubview(viewInfo)
        viewInfo.addSubview(lbSDT)
        
        viewInfo.addSubview(edtSDT)
        
        viewInfo.addSubview(btnTimKiem)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
}
