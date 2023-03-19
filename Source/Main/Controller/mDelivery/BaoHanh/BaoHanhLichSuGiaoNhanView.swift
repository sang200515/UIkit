//
//  BaoHanhLichSuGiaoNhanView.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaoHanhLichSuGiaoNhanView: UIView {
   var loadingView:NVActivityIndicatorView!
    var lbViewBot3:UILabel!
    var lbViewBot2:UILabel!
    var lbViewBot4:UILabel!
    var lbViewBot5:UILabel!
    var lbViewBot6:UILabel!
    var tableView: UITableView  =   UITableView()
    var scrollView:UIScrollView!
    var txtName:UILabel!
    var txtShop:UILabel!
    var txtLoTrinh:UILabel!
    var viewLine3:UIView!
    var valueNgayLoTrinh:UITextField!
    var btnNgayLoTrinh:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(netHex:0xffffff)
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width + (frame.size.width / 5) * 2, height: UIScreen.main.bounds.size.height + 100 + Common.Size(s:30))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = true
        
        
        let titleName = "2599-Nguyen Van A"
        let sizeNameString: CGSize = titleName.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:13))])
        txtName = UILabel(frame: CGRect(x: 20, y: Common.Size(s:5), width: UIScreen.main.bounds.size.width, height: sizeNameString.height))
        txtName.textAlignment = .left
        txtName.textColor = UIColor(netHex:0x000000)
        txtName.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        txtName.text = titleName
        
        txtShop = UILabel(frame: CGRect(x: 20, y: txtName.frame.origin.y +  txtName.frame.size.height + Common.Size(s:5), width: UIScreen.main.bounds.size.width, height: sizeNameString.height))
        txtShop.textAlignment = .left
        txtShop.textColor = UIColor(netHex:0x000000)
        txtShop.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        txtShop.text = ""
        
        
        txtLoTrinh = UILabel(frame: CGRect(x: 20, y: txtShop.frame.origin.y +  txtShop.frame.size.height + Common.Size(s:10), width: (UIScreen.main.bounds.size.width - 40) / 2, height: sizeNameString.height))
        txtLoTrinh.textAlignment = .left
        txtLoTrinh.textColor = UIColor(netHex:0x000000)
        txtLoTrinh.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        txtLoTrinh.text = "Ngày giao nhận :"
        
        
        valueNgayLoTrinh = UITextField(frame: CGRect(x: txtLoTrinh.frame.size.width + txtLoTrinh.frame.origin.x + Common.Size(s:5), y: txtShop.frame.origin.y +  txtShop.frame.size.height + Common.Size(s:10), width: (UIScreen.main.bounds.size.width - 40) / 2, height: sizeNameString.height))
        valueNgayLoTrinh.textAlignment = .left
        valueNgayLoTrinh.textColor = UIColor(netHex:0x007adf)
        valueNgayLoTrinh.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        valueNgayLoTrinh.text = "22/04/2018"
        
        btnNgayLoTrinh = UIButton(frame: CGRect(x: txtLoTrinh.frame.size.width + txtLoTrinh.frame.origin.x + Common.Size(s:5), y: txtShop.frame.origin.y +  txtShop.frame.size.height + Common.Size(s:10), width: (UIScreen.main.bounds.size.width - 40) / 2, height: sizeNameString.height ))
        btnNgayLoTrinh.backgroundColor = UIColor(netHex:0xEF4A40)
        //btnHoanTat.layer.cornerRadius = 20
        btnNgayLoTrinh.layer.borderWidth = 0.5
        btnNgayLoTrinh.layer.borderColor = UIColor.white.cgColor
        btnNgayLoTrinh.layer.cornerRadius = 5.0
        btnNgayLoTrinh.setTitle("22/04/2018",for: .normal)
        btnNgayLoTrinh.setTitleColor(UIColor.white, for: .normal)
        
        
        viewLine3  = UIView(frame: CGRect(x: 0,y: txtLoTrinh.frame.origin.y + txtLoTrinh.frame.size.height + 1 ,width:UIScreen.main.bounds.size.width  + (frame.size.width / 5) * 2 , height: 1))
        viewLine3.backgroundColor = UIColor(netHex:0xe7e7e7)
        
        
        
        
        
        
        
        let lbKHGiao = UILabel(frame: CGRect(x: 0, y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 5 - Common.Size(s:30) , height: Common.Size(s:30)))
        lbKHGiao.textAlignment = .center
        lbKHGiao.textColor = UIColor.white
        lbKHGiao.backgroundColor = UIColor(netHex:0x007adf)
        lbKHGiao.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbKHGiao.text = "STT"
        lbKHGiao.numberOfLines = 1;
        lbKHGiao.layer.borderWidth = 0.25
        lbKHGiao.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        ///////lbtextNCC
        
        let lbTenPhuKien = UILabel(frame: CGRect(x: lbKHGiao.frame.size.width , y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 5 + Common.Size(s:30), height: Common.Size(s:30)))
        lbTenPhuKien.textAlignment = .center
        lbTenPhuKien.textColor = UIColor.white
        lbTenPhuKien.backgroundColor = UIColor(netHex:0x007adf)
        lbTenPhuKien.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbTenPhuKien.text = "Địa điểm"
        lbTenPhuKien.numberOfLines = 1;
        lbTenPhuKien.layer.borderWidth = 0.25
        lbTenPhuKien.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        let lbSeriNo = UILabel(frame: CGRect(x: lbTenPhuKien.frame.origin.x + frame.size.width / 5 + Common.Size(s:30), y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 5 , height: Common.Size(s:30)))
        lbSeriNo.textAlignment = .center
        lbSeriNo.textColor = UIColor.white
        lbSeriNo.backgroundColor = UIColor(netHex:0x007adf)
        lbSeriNo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbSeriNo.text = "SL giao"
        lbSeriNo.numberOfLines = 1;
        lbSeriNo.layer.borderWidth = 0.25
        lbSeriNo.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        let lbSLNhan = UILabel(frame: CGRect(x: lbSeriNo.frame.origin.x + frame.size.width / 5, y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 5 , height: Common.Size(s:30)))
        lbSLNhan.textAlignment = .center
        lbSLNhan.textColor = UIColor.white
        lbSLNhan.backgroundColor = UIColor(netHex:0x007adf)
        lbSLNhan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbSLNhan.text = "SL nhận"
        lbSLNhan.numberOfLines = 1;
        lbSLNhan.layer.borderWidth = 0.25
        lbSLNhan.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
//        let lbLoai = UILabel(frame: CGRect(x: lbSLNhan.frame.origin.x + frame.size.width / 5 , y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 5 , height: Common.Size(s:30)))
//        lbLoai.textAlignment = .center
//        lbLoai.textColor = UIColor.white
//        lbLoai.backgroundColor = UIColor(netHex:0x007adf)
//        lbLoai.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
//        lbLoai.text = "Loại"
//        lbLoai.numberOfLines = 1;
//        lbLoai.layer.borderWidth = 0.25
//        lbLoai.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        
        let lbCheckin = UILabel(frame: CGRect(x: lbSLNhan.frame.origin.x + frame.size.width / 5 , y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 5 , height: Common.Size(s:30)))
        lbCheckin.textAlignment = .center
        lbCheckin.textColor = UIColor.white
        lbCheckin.backgroundColor = UIColor(netHex:0x007adf)
        lbCheckin.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbCheckin.text = "Loại"
        lbCheckin.numberOfLines = 1;
        lbCheckin.layer.borderWidth = 0.25
        lbCheckin.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        let lbNgay = UILabel(frame: CGRect(x: lbCheckin.frame.origin.x + frame.size.width / 5 , y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 5 , height: Common.Size(s:30)))
        lbNgay.textAlignment = .center
        lbNgay.textColor = UIColor.white
        lbNgay.backgroundColor = UIColor(netHex:0x007adf)
        lbNgay.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbNgay.text = "Checkin"
        lbNgay.numberOfLines = 1;
        lbNgay.layer.borderWidth = 0.25
        lbNgay.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        let lbKm = UILabel(frame: CGRect(x: lbNgay.frame.origin.x + frame.size.width / 5 , y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 5 , height: Common.Size(s:30)))
        lbKm.textAlignment = .center
        lbKm.textColor = UIColor.white
        lbKm.backgroundColor = UIColor(netHex:0x007adf)
        lbKm.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbKm.text = "Km"
        lbKm.numberOfLines = 1;
        lbKm.layer.borderWidth = 0.25
        lbKm.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        
        
        let lbXem = UILabel(frame: CGRect(x: lbNgay.frame.origin.x + frame.size.width / 6 , y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 6 , height: Common.Size(s:30)))
        lbXem.textAlignment = .center
        lbXem.textColor = UIColor.white
        lbXem.backgroundColor = UIColor(netHex:0x007adf)
        lbXem.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbXem.text = "Xem"
        lbXem.numberOfLines = 1;
        lbXem.layer.borderWidth = 0.25
        lbXem.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        tableView.frame = CGRect(x: 0, y: lbSeriNo.frame.origin.y + lbSeriNo.frame.size.height , width: frame.size.width + (UIScreen.main.bounds.size.width / 5) * 2, height: frame.size.height -  Common.Size(s:20) * 10)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(netHex:0xffffff)
        
        
        
        let lbViewBot1 = UILabel(frame: CGRect(x: 0, y: tableView.frame.size.height + tableView.frame.origin.y , width: lbKHGiao.frame.size.width + lbTenPhuKien.frame.size.width , height: Common.Size(s:30)))
        lbViewBot1.textAlignment = .center
        lbViewBot1.textColor = UIColor.white
        lbViewBot1.backgroundColor = UIColor(netHex:0x007adf)
        lbViewBot1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbViewBot1.text = "Tổng"
        lbViewBot1.numberOfLines = 1;
        //lbViewBot1.layer.borderWidth = 0.25
        //lbViewBot1.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        ///////lbtextNCC
        
        lbViewBot2 = UILabel(frame: CGRect(x: lbViewBot1.frame.size.width + lbViewBot1.frame.origin.x + 1, y: lbViewBot1.frame.origin.y , width: lbSeriNo.frame.size.width - 1, height: Common.Size(s:30)))
        lbViewBot2.textAlignment = .center
        lbViewBot2.textColor = UIColor.white
        lbViewBot2.backgroundColor = UIColor(netHex:0x007adf)
        lbViewBot2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbViewBot2.text = "SKG"
        lbViewBot2.numberOfLines = 1;
        //lbViewBot2.layer.borderWidth = 0.25
        //lbViewBot2.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        lbViewBot5 = UILabel(frame: CGRect(x: lbViewBot2.frame.origin.x + lbViewBot2.frame.size.width , y:  lbViewBot1.frame.origin.y  , width: lbSeriNo.frame.size.width , height: Common.Size(s:30)))
        lbViewBot5.textAlignment = .center
        lbViewBot5.textColor = UIColor.white
        lbViewBot5.backgroundColor = UIColor(netHex:0x007adf)
        lbViewBot5.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbViewBot5.text = "SKN"
        lbViewBot5.numberOfLines = 1;
        lbViewBot5.layer.borderWidth = 0.25
        lbViewBot5.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        lbViewBot6 = UILabel(frame: CGRect(x: lbViewBot5.frame.origin.x + lbViewBot5.frame.size.width , y:  lbViewBot1.frame.origin.y  , width: lbCheckin.frame.size.width + lbNgay.frame.size.width , height: Common.Size(s:30)))
        lbViewBot6.textAlignment = .center
        lbViewBot6.textColor = UIColor.white
        lbViewBot6.backgroundColor = UIColor(netHex:0x007adf)
        lbViewBot6.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbViewBot6.text = ""
        lbViewBot6.numberOfLines = 1;
        lbViewBot6.layer.borderWidth = 0.25
        lbViewBot6.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        
        lbViewBot3 = UILabel(frame: CGRect(x: lbViewBot6.frame.origin.x + lbViewBot6.frame.size.width , y:  lbViewBot1.frame.origin.y  , width: lbKm.frame.size.width  , height: Common.Size(s:30)))
        lbViewBot3.textAlignment = .center
        lbViewBot3.textColor = UIColor.white
        lbViewBot3.backgroundColor = UIColor(netHex:0x007adf)
        lbViewBot3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbViewBot3.text = ""
        lbViewBot3.numberOfLines = 1;
        lbViewBot3.layer.borderWidth = 0.25
        lbViewBot3.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
   
        
        
        
        
        
        let frameLoading = CGRect(x: (UIScreen.main.bounds.size.width - Common.Size(s:50)) / 2, y: (UIScreen.main.bounds.size.height - Common.Size(s:50)) / 2, width: Common.Size(s:50), height: Common.Size(s:50))
        loadingView = NVActivityIndicatorView(frame: frameLoading,
                                              type: .ballClipRotateMultiple)
        
        loadingView.color = UIColor(netHex:0x007adf)
        
        
        
        
        
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width + (UIScreen.main.bounds.size.width / 5) * 2, height: txtName.frame.size.height + txtShop.frame.size.height + txtLoTrinh.frame.size.height + tableView.frame.size.height + 100)
        
        
        addSubview(scrollView)
        scrollView.addSubview(valueNgayLoTrinh)
        scrollView.addSubview(txtName)
        scrollView.addSubview(txtShop)
        scrollView.addSubview(txtLoTrinh)
        scrollView.addSubview(viewLine3)
        scrollView.addSubview(lbSeriNo)
        //scrollView.addSubview(lbLoai)
        scrollView.addSubview(lbSLNhan)
        scrollView.addSubview(lbTenPhuKien)
        scrollView.addSubview(lbKHGiao)
        scrollView.addSubview(lbCheckin)
        scrollView.addSubview(lbNgay)
        scrollView.addSubview(lbKm)
        scrollView.addSubview(tableView)
        scrollView.addSubview(valueNgayLoTrinh)
        scrollView.addSubview(lbViewBot1)
        scrollView.addSubview(lbViewBot2)
        scrollView.addSubview(lbViewBot3)
        scrollView.addSubview(lbViewBot5)
        scrollView.addSubview(lbViewBot6)
         scrollView.addSubview(loadingView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
}




