//
//  ThongTinDenHangView.swift
//  mPOS
//
//  Created by sumi on 1/11/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit

class ThongTinDenHangView: UIView {
    
    var edtKetLuan:UITextField!
    var edtCacBuocKiemTra:UITextField!
    var edtMaLinhKien:UITextField!
    var scrollView:UIScrollView!
    var edtGhiChuLienHe:UITextField!
    var btnHoanTat:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.backgroundColor = UIColor.red
        
        let lbImei = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbImei.textAlignment = .left
        lbImei.textColor = UIColor.black
        lbImei.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbImei.text = "Các bước kiểm tra (*)"
        
        ///sdt
        edtCacBuocKiemTra = UITextField(frame: CGRect(x: 15 , y: lbImei.frame.origin.y + lbImei.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtCacBuocKiemTra.placeholder = "Các bước kiểm tra"
        edtCacBuocKiemTra.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtCacBuocKiemTra.borderStyle = UITextField.BorderStyle.roundedRect
        edtCacBuocKiemTra.autocorrectionType = UITextAutocorrectionType.no
        edtCacBuocKiemTra.keyboardType = UIKeyboardType.default
        edtCacBuocKiemTra.returnKeyType = UIReturnKeyType.done
        edtCacBuocKiemTra.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtCacBuocKiemTra.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        ////////
        let lbKetLuan = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtCacBuocKiemTra.frame.size.height + edtCacBuocKiemTra.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbKetLuan.textAlignment = .left
        lbKetLuan.textColor = UIColor.black
        lbKetLuan.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbKetLuan.text = "Kết luận (*)"
        
        edtKetLuan = UITextField(frame: CGRect(x: 15 , y: lbKetLuan.frame.origin.y + lbKetLuan.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtKetLuan.placeholder = "Kết luận"
        edtKetLuan.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtKetLuan.borderStyle = UITextField.BorderStyle.roundedRect
        edtKetLuan.autocorrectionType = UITextAutocorrectionType.no
        edtKetLuan.keyboardType = UIKeyboardType.default
        edtKetLuan.returnKeyType = UIReturnKeyType.done
        edtKetLuan.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtKetLuan.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        //////
        let lbMaLinhKien = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtKetLuan.frame.size.height + edtKetLuan.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbMaLinhKien.textAlignment = .left
        lbMaLinhKien.textColor = UIColor.black
        lbMaLinhKien.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbMaLinhKien.text = "Mã linh kiện / PPID (*)"
        
        edtMaLinhKien = UITextField(frame: CGRect(x: 15 , y: lbMaLinhKien.frame.origin.y + lbMaLinhKien.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtMaLinhKien.placeholder = "Mã linh kiện"
        edtMaLinhKien.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtMaLinhKien.borderStyle = UITextField.BorderStyle.roundedRect
        edtMaLinhKien.autocorrectionType = UITextAutocorrectionType.no
        edtMaLinhKien.keyboardType = UIKeyboardType.default
        edtMaLinhKien.returnKeyType = UIReturnKeyType.done
        edtMaLinhKien.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtMaLinhKien.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        let lbGhiChu = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtMaLinhKien.frame.size.height + edtMaLinhKien.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbGhiChu.textAlignment = .left
        lbGhiChu.textColor = UIColor.black
        lbGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbGhiChu.text = "Ghi chú (*)"
        
        edtGhiChuLienHe = UITextField(frame: CGRect(x: 15 , y: lbGhiChu.frame.origin.y + lbGhiChu.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40) * 2));
        edtGhiChuLienHe.placeholder = "Nhập ghi chú"
        edtGhiChuLienHe.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtGhiChuLienHe.borderStyle = UITextField.BorderStyle.roundedRect
        edtGhiChuLienHe.autocorrectionType = UITextAutocorrectionType.no
        edtGhiChuLienHe.keyboardType = UIKeyboardType.default
        edtGhiChuLienHe.returnKeyType = UIReturnKeyType.done
        edtGhiChuLienHe.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtGhiChuLienHe.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        btnHoanTat = UIButton(frame: CGRect(x:edtGhiChuLienHe.frame.origin.x, y: edtGhiChuLienHe.frame.origin.y + edtGhiChuLienHe.frame.size.height + Common.Size(s:10) , width: edtGhiChuLienHe.frame.size.width  , height: Common.Size(s:40)));
        btnHoanTat.backgroundColor = UIColor(netHex:0xEF4A40)
        //btnHoanTat.layer.cornerRadius = 20
        btnHoanTat.layer.borderWidth = 0.5
        btnHoanTat.layer.borderColor = UIColor.white.cgColor
        btnHoanTat.layer.cornerRadius = 5.0
        btnHoanTat.setTitle("Hoàn tất",for: .normal)
        btnHoanTat.setTitleColor(UIColor.white, for: .normal)
        
        
        
        
        
        addSubview(lbImei)
        addSubview(edtCacBuocKiemTra)
        addSubview(lbKetLuan)
        addSubview(lbMaLinhKien)
        addSubview(edtMaLinhKien)
        addSubview(edtKetLuan)
        addSubview(lbGhiChu)
        addSubview(edtGhiChuLienHe)
        addSubview(btnHoanTat)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
}
