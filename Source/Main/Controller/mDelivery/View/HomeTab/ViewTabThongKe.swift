//
//  ViewTabThongKe.swift
//  NewmDelivery
//
//  Created by sumi on 4/23/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
//import UIDropDown

class ViewTabThongKe: UIView {
    
    var tableViewMainThongKe: UITableView  =   UITableView()
    //var spinnerLoai: UIDropDown!
    var edtThoiGianFrom:UITextField!
    var edtThoiGianTo:UITextField!
    var edtSearch:UITextField!
    var scrollView:UIScrollView!
    
    var imageTenKH:UIImageView!
    var viewLine1:UIView!
    var viewLine2:UIView!
    var labelThuKho:UILabel!
    var companyButton2:SearchTextField!
    
    var labelTinhTrang:UILabel!
    
    
    var labelSoDHPhanCong:UILabel!
    var labelSoDHKhongDung:UILabel!
    var labelSoDHTre:UILabel!
    var labelTongINC:UILabel!
    var labelTongPhat:UILabel!
    
    var labelValueSoDHPhanCong:UILabel!
    var labelValueSoDHKhongDung:UILabel!
    var labelValueSoDHTre:UILabel!
    var labelValueTongINC:UILabel!
    var labelValueTongPhat:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        //scrollView.backgroundColor = UIColor.black
       
        
        
        edtThoiGianFrom = UITextField(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s: 10), width: UIScreen.main.bounds.size.width / 4 , height:  Common.Size(s:20)));
        edtThoiGianFrom.placeholder = "16/03/2018"
        edtThoiGianFrom.textAlignment = .center
        edtThoiGianFrom.font = UIFont.systemFont(ofSize:  Common.Size(s:13))
        edtThoiGianFrom.borderStyle = UITextField.BorderStyle.roundedRect
        edtThoiGianFrom.autocorrectionType = UITextAutocorrectionType.no
        edtThoiGianFrom.keyboardType = UIKeyboardType.default
        edtThoiGianFrom.returnKeyType = UIReturnKeyType.done
        edtThoiGianFrom.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtThoiGianFrom.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtThoiGianFrom.text = "17/03/2018"
        
        
        
        edtThoiGianTo = UITextField(frame: CGRect(x: edtThoiGianFrom.frame.origin.x + edtThoiGianFrom.frame.size.width + Common.Size(s: 5), y: Common.Size(s: 10), width: UIScreen.main.bounds.size.width / 4 , height:  Common.Size(s:20)));
        edtThoiGianTo.placeholder = "17/03/2018"
        edtThoiGianTo.textAlignment = .center
        edtThoiGianTo.font = UIFont.systemFont(ofSize:  Common.Size(s:13))
        edtThoiGianTo.borderStyle = UITextField.BorderStyle.roundedRect
        edtThoiGianTo.autocorrectionType = UITextAutocorrectionType.no
        edtThoiGianTo.keyboardType = UIKeyboardType.default
        edtThoiGianTo.returnKeyType = UIReturnKeyType.done
        edtThoiGianTo.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtThoiGianTo.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtThoiGianTo.text = "17/03/2018"
        
        
        
        edtSearch = UITextField(frame: CGRect(x: edtThoiGianFrom.frame.origin.x  , y: edtThoiGianTo.frame.origin.y  , width: UIScreen.main.bounds.size.width  - Common.Size(s:40), height: Common.Size(s:20)));
        edtSearch.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtSearch.borderStyle = UITextField.BorderStyle.roundedRect
        edtSearch.placeholder = "Nhập mã Ecom hoặc POS"
        edtSearch.autocorrectionType = UITextAutocorrectionType.no
        edtSearch.keyboardType = UIKeyboardType.default
        edtSearch.returnKeyType = UIReturnKeyType.done
        edtSearch.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtSearch.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        //edtSearch.text = "Nhập mã Ecom hoặc POS"
        
        ////
        ////leftView
        edtSearch.rightViewMode = UITextField.ViewMode.always
        imageTenKH = UIImageView(frame: CGRect(x: edtSearch.frame.size.height/4, y: edtSearch.frame.size.height/4, width: edtSearch.frame.size.height/2, height: edtSearch.frame.size.height/2))
        imageTenKH.image = UIImage(named: "SearchIC")
        imageTenKH.contentMode = UIView.ContentMode.scaleAspectFit
        let rightViewTenKH = UIView()
        rightViewTenKH.addSubview(imageTenKH)
        rightViewTenKH.frame = CGRect(x: 0, y: 0, width: edtSearch.frame.size.height, height: edtSearch.frame.size.height)
        edtSearch.rightView = rightViewTenKH
        
        
        viewLine1 = UIView()
       
        viewLine1.backgroundColor = UIColor.gray
        viewLine1.frame = CGRect(x: 0, y: edtSearch.frame.origin.y + edtSearch.frame.size.height + Common.Size(s: 10), width: UIScreen.main.bounds.size.width, height: Common.Size(s:0.5))
        

        
        labelThuKho = UILabel(frame: CGRect(x: Common.Size(s: 20) , y: viewLine1.frame.origin.y + viewLine1.frame.size.height +  Common.Size(s:5) , width: viewLine1.frame.size.width / 5, height: Common.Size(s:20)))
        labelThuKho.textAlignment = .left
        labelThuKho.textColor = UIColor.black
        labelThuKho.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelThuKho.text = "Nhân viên:"
        
        companyButton2 = SearchTextField(frame: CGRect(x: labelThuKho.frame.origin.x + labelThuKho.frame.size.width + Common.Size(s: 5), y: labelThuKho.frame.origin.y , width: viewLine1.frame.size.width - Common.Size(s:40) -  viewLine1.frame.size.width / 5  , height: Common.Size(s:20) ));
        
        
        //companyButton2.placeholder = "5387-Phan Thi Ngoc Huyen"
        companyButton2.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton2.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton2.autocorrectionType = UITextAutocorrectionType.no
        companyButton2.keyboardType = UIKeyboardType.default
        companyButton2.returnKeyType = UIReturnKeyType.done
        companyButton2.clearButtonMode = UITextField.ViewMode.whileEditing;
        companyButton2.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        companyButton2.startVisible = true
        companyButton2.theme.bgColor = UIColor.white
        companyButton2.theme.fontColor = UIColor.black
        companyButton2.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton2.theme.cellHeight = Common.Size(s:40)
        
        labelTinhTrang = UILabel(frame: CGRect(x: Common.Size(s: 20) , y: labelThuKho.frame.origin.y + labelThuKho.frame.size.height +  Common.Size(s:5) , width: viewLine1.frame.size.width / 5, height: Common.Size(s:20)))
        labelTinhTrang.textAlignment = .left
        labelTinhTrang.textColor = UIColor.black
        labelTinhTrang.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelTinhTrang.text = "Tình trạng:"
        
        
//        spinnerLoai = UIDropDown(frame: CGRect(x: companyButton2.frame.origin.x, y: labelTinhTrang.frame.origin.y , width: companyButton2.frame.size.width , height: companyButton2.frame.size.height))
//        spinnerLoai.placeholder = "Tất cả"
//        spinnerLoai.rowBackgroundColor = UIColor.white
//        spinnerLoai.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        
       
        
        
        viewLine2 = UIView()
        
        viewLine2.backgroundColor = UIColor.gray
        viewLine2.frame = CGRect(x: 0, y: labelTinhTrang.frame.origin.y + labelTinhTrang.frame.size.height + Common.Size(s: 10), width: UIScreen.main.bounds.size.width, height: Common.Size(s:0.5))
        
        
        labelSoDHPhanCong = UILabel(frame: CGRect(x: Common.Size(s: 20) , y: viewLine2.frame.origin.y + viewLine2.frame.size.height +  Common.Size(s:5) , width: viewLine1.frame.size.width / 2 + Common.Size(s: 40), height: Common.Size(s:30)))
        labelSoDHPhanCong.textAlignment = .left
        labelSoDHPhanCong.textColor = UIColor.black
        labelSoDHPhanCong.layer.borderWidth = 0.5
        labelSoDHPhanCong.layer.borderColor = UIColor.gray.cgColor
        labelSoDHPhanCong.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        labelSoDHPhanCong.text = " Số đơn hàng được phân công"
        
        labelSoDHKhongDung = UILabel(frame: CGRect(x: Common.Size(s: 20) , y: labelSoDHPhanCong.frame.origin.y + labelSoDHPhanCong.frame.size.height  , width: viewLine1.frame.size.width / 2 + Common.Size(s: 40), height: Common.Size(s:30)))
        labelSoDHKhongDung.textAlignment = .left
        labelSoDHKhongDung.layer.borderWidth = 0.5
        labelSoDHKhongDung.layer.borderColor = UIColor.gray.cgColor
        labelSoDHKhongDung.textColor = UIColor.black
        labelSoDHKhongDung.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        labelSoDHKhongDung.text = " Số đơn hàng không dùng mDelivery"
        
        labelSoDHTre = UILabel(frame: CGRect(x: Common.Size(s: 20) , y: labelSoDHKhongDung.frame.origin.y + labelSoDHKhongDung.frame.size.height  , width: viewLine1.frame.size.width / 2 + Common.Size(s: 40), height: Common.Size(s:30)))
        labelSoDHTre.textAlignment = .left
        labelSoDHTre.textColor = UIColor.black
        labelSoDHTre.layer.borderWidth = 0.5
        labelSoDHTre.layer.borderColor = UIColor.gray.cgColor
        labelSoDHTre.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        labelSoDHTre.text = " Số đơn hàng trễ hẹn"
        
        labelTongINC = UILabel(frame: CGRect(x: Common.Size(s: 20) , y: labelSoDHTre.frame.origin.y + labelSoDHTre.frame.size.height , width: viewLine1.frame.size.width / 2 + Common.Size(s: 40), height: Common.Size(s:30)))
        labelTongINC.textAlignment = .left
        labelTongINC.textColor = UIColor.black
        labelTongINC.layer.borderWidth = 0.5
        labelTongINC.layer.borderColor = UIColor.gray.cgColor
        labelTongINC.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        labelTongINC.text = " Tổng INC"
        
        labelTongPhat = UILabel(frame: CGRect(x: Common.Size(s: 20) , y: labelTongINC.frame.origin.y + labelTongINC.frame.size.height  , width: viewLine1.frame.size.width / 2 + Common.Size(s: 40), height: Common.Size(s:30)))
        labelTongPhat.textAlignment = .left
        labelTongPhat.layer.borderWidth = 0.5
        labelTongPhat.layer.borderColor = UIColor.gray.cgColor
        labelTongPhat.textColor = UIColor.black
        labelTongPhat.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        labelTongPhat.text = " Tổng phạt"
        
        
        
        
        labelValueSoDHPhanCong = UILabel(frame: CGRect(x:labelSoDHPhanCong.frame.size.width + labelSoDHPhanCong.frame.origin.x , y: viewLine2.frame.origin.y + viewLine2.frame.size.height +  Common.Size(s:5) , width: viewLine1.frame.size.width - (viewLine1.frame.size.width / 2 + Common.Size(s: 40)) - Common.Size(s: 40), height: Common.Size(s:30)))
        labelValueSoDHPhanCong.textAlignment = .center
        labelValueSoDHPhanCong.textColor = UIColor.black
        labelValueSoDHPhanCong.layer.borderWidth = 0.5
        labelValueSoDHPhanCong.layer.borderColor = UIColor.gray.cgColor
        labelValueSoDHPhanCong.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        labelValueSoDHPhanCong.text = "20"
        
        labelValueSoDHKhongDung = UILabel(frame: CGRect(x:labelValueSoDHPhanCong.frame.origin.x , y: labelSoDHPhanCong.frame.origin.y + labelSoDHPhanCong.frame.size.height  , width: viewLine1.frame.size.width - (viewLine1.frame.size.width / 2 + Common.Size(s: 40)) - Common.Size(s: 40), height: Common.Size(s:30)))
        labelValueSoDHKhongDung.textAlignment = .center
        labelValueSoDHKhongDung.layer.borderWidth = 0.5
        labelValueSoDHKhongDung.layer.borderColor = UIColor.gray.cgColor
        labelValueSoDHKhongDung.textColor = UIColor.black
        labelValueSoDHKhongDung.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        labelValueSoDHKhongDung.text = "20"
        
        labelValueSoDHTre = UILabel(frame: CGRect(x: labelValueSoDHPhanCong.frame.origin.x , y: labelSoDHKhongDung.frame.origin.y + labelSoDHKhongDung.frame.size.height  , width: viewLine1.frame.size.width - (viewLine1.frame.size.width / 2 + Common.Size(s: 40)) - Common.Size(s: 40), height: Common.Size(s:30)))
        labelValueSoDHTre.textAlignment = .center
        labelValueSoDHTre.textColor = UIColor.black
        labelValueSoDHTre.layer.borderWidth = 0.5
        labelValueSoDHTre.layer.borderColor = UIColor.gray.cgColor
        labelValueSoDHTre.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        labelValueSoDHTre.text = "20"
        
        labelValueTongINC = UILabel(frame: CGRect(x:labelValueSoDHPhanCong.frame.origin.x , y: labelSoDHTre.frame.origin.y + labelSoDHTre.frame.size.height , width: viewLine1.frame.size.width - (viewLine1.frame.size.width / 2 + Common.Size(s: 40)) - Common.Size(s: 40), height: Common.Size(s:30)))
        labelValueTongINC.textAlignment = .center
        labelValueTongINC.textColor = UIColor.black
        labelValueTongINC.layer.borderWidth = 0.5
        labelValueTongINC.layer.borderColor = UIColor.gray.cgColor
        labelValueTongINC.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        labelValueTongINC.text = "10.000"
        
        labelValueTongPhat = UILabel(frame: CGRect(x: labelValueSoDHPhanCong.frame.origin.x , y: labelTongINC.frame.origin.y + labelTongINC.frame.size.height  , width: viewLine1.frame.size.width - (viewLine1.frame.size.width / 2 + Common.Size(s: 40)) - Common.Size(s: 40), height: Common.Size(s:30)))
        labelValueTongPhat.textAlignment = .center
        labelValueTongPhat.layer.borderWidth = 0.5
        labelValueTongPhat.layer.borderColor = UIColor.gray.cgColor
        labelValueTongPhat.textColor = UIColor.black
        labelValueTongPhat.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        labelValueTongPhat.text = "10.000"
        
        
        let viewLine3 = UIView()
        
        viewLine3.backgroundColor = UIColor.gray
        viewLine3.frame = CGRect(x: 0, y: labelValueTongPhat.frame.origin.y + labelValueTongPhat.frame.size.height + Common.Size(s: 15), width: UIScreen.main.bounds.size.width, height: Common.Size(s:0.5))
        
        
        ///////lbtextNCC
        
        let lbDHEcom = UILabel(frame: CGRect(x: 0, y: viewLine3.frame.origin.y + viewLine3.frame.size.height + 5, width: frame.size.width / 4, height: Common.Size(s:16) + 15))
        lbDHEcom.textAlignment = .center
        lbDHEcom.textColor = UIColor.white
        lbDHEcom.backgroundColor = UIColor(netHex:0x4781ff)
        lbDHEcom.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        lbDHEcom.text = "ĐH Ecom"
        lbDHEcom.numberOfLines = 1;
        
        ///////lbtextNCC
        let lbTinhDungHan = UILabel(frame: CGRect(x: lbDHEcom.frame.width, y: lbDHEcom.frame.origin.y , width: frame.size.width / 4, height: Common.Size(s:16) + 15))
        lbTinhDungHan.textAlignment = .center
        lbTinhDungHan.textColor = UIColor.white
        lbTinhDungHan.backgroundColor = UIColor(netHex:0x4781ff)
        lbTinhDungHan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        lbTinhDungHan.text = "Tính đúng hạn"
        lbTinhDungHan.numberOfLines = 1;
        
        ///////lbtextTinhTrang
        let lbTinhTrangSD = UILabel(frame: CGRect(x: lbTinhDungHan.frame.width + lbTinhDungHan.frame.origin.x, y: lbDHEcom.frame.origin.y, width: frame.size.width / 4, height: Common.Size(s:16) + 15))
        lbTinhTrangSD.textAlignment = .center
        lbTinhTrangSD.textColor = UIColor.white
        lbTinhTrangSD.backgroundColor = UIColor(netHex:0x4781ff)
        lbTinhTrangSD.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        lbTinhTrangSD.text = "Tình trạng SD mDelivery"
        lbTinhTrangSD.numberOfLines = 2;
        
        
        ///////lbtextINC
        let lbINC = UILabel(frame: CGRect(x: lbTinhTrangSD.frame.width + lbTinhTrangSD.frame.origin.x, y: lbTinhTrangSD.frame.origin.y , width: frame.size.width / 4, height: Common.Size(s:16) + 15))
        lbINC.textAlignment = .center
        lbINC.textColor = UIColor.white
        lbINC.backgroundColor = UIColor(netHex:0x4781ff)
        lbINC.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        lbINC.text = "INC"
        lbINC.numberOfLines = 2;
        
        
        tableViewMainThongKe.frame = CGRect(x: 0, y: lbINC.frame.origin.y + lbINC.frame.size.height , width: UIScreen.main.bounds.size.width  , height: 200);
        tableViewMainThongKe.tableFooterView = UIView()
        tableViewMainThongKe.backgroundColor = UIColor(netHex:0xffffff)
        
        addSubview(scrollView)
        //scrollView.addSubview(edtThoiGianFrom)
        //scrollView.addSubview(edtThoiGianTo)
        scrollView.addSubview(edtSearch)
        scrollView.addSubview(viewLine1)
        scrollView.addSubview(labelThuKho)
        scrollView.addSubview(companyButton2)
        scrollView.addSubview(labelTinhTrang)
        scrollView.addSubview(viewLine2)
        
        scrollView.addSubview(labelSoDHPhanCong)
        scrollView.addSubview(labelSoDHKhongDung)
        scrollView.addSubview(labelSoDHTre)
        scrollView.addSubview(labelTongPhat)
        scrollView.addSubview(labelTongINC)
        
        scrollView.addSubview(labelValueSoDHPhanCong)
        scrollView.addSubview(labelValueSoDHKhongDung)
        scrollView.addSubview(labelValueSoDHTre)
        scrollView.addSubview(labelValueTongPhat)
        scrollView.addSubview(labelValueTongINC)
        scrollView.addSubview(lbDHEcom)
        scrollView.addSubview(lbINC)
        scrollView.addSubview(lbTinhDungHan)
        scrollView.addSubview(lbTinhTrangSD)
        scrollView.addSubview(viewLine3)
        //scrollView.addSubview(spinnerLoai)
        scrollView.addSubview(tableViewMainThongKe)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }

}
