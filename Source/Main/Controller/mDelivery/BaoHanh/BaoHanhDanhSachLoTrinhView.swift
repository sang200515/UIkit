//
//  BaoHanhDanhSachLoTrinhView.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaoHanhDanhSachLoTrinhView: UIView {

    var loadingView:NVActivityIndicatorView!
    var lbViewBot5:UILabel!
    var lbViewBot6:UILabel!
    var lbViewBot3:UILabel!
    var tableView: UITableView  =   UITableView()
    var scrollView:UIScrollView!
    var txtName:UILabel!
    var txtShop:UILabel!
    var txtLoTrinh:UILabel!
    var viewLine3:UIView!
    var valueNgayLoTrinh:UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(netHex:0xffffff)
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width + (UIScreen.main.bounds.size.width / 5) * 2, height: UIScreen.main.bounds.size.height + 100 + Common.Size(s:30))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        
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
        txtLoTrinh.text = "Ngày lộ trình :"
        
        valueNgayLoTrinh = UITextField(frame: CGRect(x: txtLoTrinh.frame.size.width + txtLoTrinh.frame.origin.x + Common.Size(s:5), y: txtShop.frame.origin.y +  txtShop.frame.size.height + Common.Size(s:10), width: (UIScreen.main.bounds.size.width - 40) / 2, height: sizeNameString.height))
        valueNgayLoTrinh.textAlignment = .left
        valueNgayLoTrinh.textColor = UIColor(netHex:0x007adf)
        valueNgayLoTrinh.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        valueNgayLoTrinh.text = "22/04/2018"
        
        
        viewLine3  = UIView(frame: CGRect(x: 0,y: txtLoTrinh.frame.origin.y + txtLoTrinh.frame.size.height + 1 ,width:UIScreen.main.bounds.size.width  + (frame.size.width / 5) * 2, height: 1))
        viewLine3.backgroundColor = UIColor(netHex:0xe7e7e7)
        
        
        
        
        
        
        
        let lbKHGiao = UILabel(frame: CGRect(x: 0, y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 4 - 20 , height: Common.Size(s:30)))
        lbKHGiao.textAlignment = .center
        lbKHGiao.textColor = UIColor.white
        lbKHGiao.backgroundColor = UIColor(netHex:0x007adf)
        lbKHGiao.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbKHGiao.text = "STT"
        lbKHGiao.numberOfLines = 1;
        lbKHGiao.layer.borderWidth = 0.25
        lbKHGiao.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        ///////lbtextNCC
        
        let lbTenPhuKien = UILabel(frame: CGRect(x: lbKHGiao.frame.size.width , y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 4 + 20, height: Common.Size(s:30)))
        lbTenPhuKien.textAlignment = .center
        lbTenPhuKien.textColor = UIColor.white
        lbTenPhuKien.backgroundColor = UIColor(netHex:0x007adf)
        lbTenPhuKien.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbTenPhuKien.text = "Địa điểm"
        lbTenPhuKien.numberOfLines = 1;
        lbTenPhuKien.layer.borderWidth = 0.25
        lbTenPhuKien.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        let lbSLGiao = UILabel(frame: CGRect(x: lbTenPhuKien.frame.origin.x + lbTenPhuKien.frame.size.width , y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 5 , height: Common.Size(s:30)))
        lbSLGiao.textAlignment = .center
        lbSLGiao.textColor = UIColor.white
        lbSLGiao.backgroundColor = UIColor(netHex:0x007adf)
        lbSLGiao.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbSLGiao.text = "SL Giao"
        lbSLGiao.numberOfLines = 1;
        lbSLGiao.layer.borderWidth = 0.25
        lbSLGiao.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        let lbSLNhan = UILabel(frame: CGRect(x: lbSLGiao.frame.origin.x + lbSLGiao.frame.size.width , y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 5 , height: Common.Size(s:30)))
        lbSLNhan.textAlignment = .center
        lbSLNhan.textColor = UIColor.white
        lbSLNhan.backgroundColor = UIColor(netHex:0x007adf)
        lbSLNhan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbSLNhan.text = "SL Nhan"
        lbSLNhan.numberOfLines = 1;
        lbSLNhan.layer.borderWidth = 0.25
        lbSLNhan.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        
        
        
        
        let lbSeriNo = UILabel(frame: CGRect(x: lbSLNhan.frame.origin.x + lbSLGiao.frame.size.width , y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 4 , height: Common.Size(s:30)))
        lbSeriNo.textAlignment = .center
        lbSeriNo.textColor = UIColor.white
        lbSeriNo.backgroundColor = UIColor(netHex:0x007adf)
        lbSeriNo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbSeriNo.text = "Độ dài km"
        lbSeriNo.numberOfLines = 1;
        lbSeriNo.layer.borderWidth = 0.25
        lbSeriNo.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        let lbCheckin = UILabel(frame: CGRect(x: lbSeriNo.frame.origin.x + frame.size.width / 4 , y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 4 , height: Common.Size(s:30)))
        lbCheckin.textAlignment = .center
        lbCheckin.textColor = UIColor.white
        lbCheckin.backgroundColor = UIColor(netHex:0x007adf)
        lbCheckin.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbCheckin.text = "Checkin"
        lbCheckin.numberOfLines = 1;
        lbCheckin.layer.borderWidth = 0.25
        lbCheckin.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        tableView.frame = CGRect(x: 0, y: lbSeriNo.frame.origin.y + lbSeriNo.frame.size.height , width: frame.size.width + (frame.size.width / 5) * 2, height: frame.size.height -  Common.Size(s:20) * 10)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(netHex:0xffffff)
        
        
        let lbViewBot1 = UILabel(frame: CGRect(x: 0, y: tableView.frame.size.height + tableView.frame.origin.y , width: frame.size.width / 4 - 20 , height: Common.Size(s:30)))
        lbViewBot1.textAlignment = .center
        lbViewBot1.textColor = UIColor.white
        lbViewBot1.backgroundColor = UIColor(netHex:0x007adf)
        lbViewBot1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbViewBot1.text = ""
        lbViewBot1.numberOfLines = 1;
        //lbViewBot1.layer.borderWidth = 0.25
        //lbViewBot1.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        ///////lbtextNCC
        
        let lbViewBot2 = UILabel(frame: CGRect(x: lbKHGiao.frame.size.width , y: lbViewBot1.frame.origin.y , width: frame.size.width / 4 + 20, height: Common.Size(s:30)))
        lbViewBot2.textAlignment = .center
        lbViewBot2.textColor = UIColor.white
        lbViewBot2.backgroundColor = UIColor(netHex:0x007adf)
        lbViewBot2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbViewBot2.text = "Tổng :"
        lbViewBot2.numberOfLines = 1;
        //lbViewBot2.layer.borderWidth = 0.25
        //lbViewBot2.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        lbViewBot5 = UILabel(frame: CGRect(x: lbSLGiao.frame.origin.x , y:  lbViewBot1.frame.origin.y  , width: lbSLGiao.frame.size.width , height: Common.Size(s:30)))
        lbViewBot5.textAlignment = .center
        lbViewBot5.textColor = UIColor.white
        lbViewBot5.backgroundColor = UIColor(netHex:0x007adf)
        lbViewBot5.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbViewBot5.text = ""
        lbViewBot5.numberOfLines = 1;
        lbViewBot5.layer.borderWidth = 0.25
        lbViewBot5.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        lbViewBot6 = UILabel(frame: CGRect(x: lbSLNhan.frame.origin.x , y:  lbViewBot1.frame.origin.y  , width: lbSLNhan.frame.size.width  , height: Common.Size(s:30)))
        lbViewBot6.textAlignment = .center
        lbViewBot6.textColor = UIColor.white
        lbViewBot6.backgroundColor = UIColor(netHex:0x007adf)
        lbViewBot6.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbViewBot6.text = ""
        lbViewBot6.numberOfLines = 1;
        lbViewBot6.layer.borderWidth = 0.25
        lbViewBot6.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        
        lbViewBot3 = UILabel(frame: CGRect(x: lbViewBot6.frame.origin.x + lbViewBot6.frame.size.width , y:  lbViewBot1.frame.origin.y  , width: frame.size.width / 4 , height: Common.Size(s:30)))
        lbViewBot3.textAlignment = .center
        lbViewBot3.textColor = UIColor.white
        lbViewBot3.backgroundColor = UIColor(netHex:0x007adf)
        lbViewBot3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbViewBot3.text = ""
        lbViewBot3.numberOfLines = 1;
        lbViewBot3.layer.borderWidth = 0.25
        lbViewBot3.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
     
        
        let lbViewBot4 = UILabel(frame: CGRect(x: lbViewBot3.frame.origin.x + frame.size.width / 4 , y: lbViewBot1.frame.origin.y  , width: frame.size.width / 4 , height: Common.Size(s:30)))
        lbViewBot4.textAlignment = .center
        lbViewBot4.textColor = UIColor.white
        lbViewBot4.backgroundColor = UIColor(netHex:0x007adf)
        lbViewBot4.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbViewBot4.text = ""
        lbViewBot4.numberOfLines = 1;
        lbViewBot4.layer.borderWidth = 0.25
        lbViewBot4.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        
        
        
        let frameLoading = CGRect(x: (UIScreen.main.bounds.size.width - Common.Size(s:50)) / 2, y: (UIScreen.main.bounds.size.height - Common.Size(s:50)) / 2, width: Common.Size(s:50), height: Common.Size(s:50))
        loadingView = NVActivityIndicatorView(frame: frameLoading,
                                              type: .ballClipRotateMultiple)
      
        loadingView.color = UIColor(netHex:0x007adf)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width + (UIScreen.main.bounds.size.width / 5) * 2, height: txtName.frame.size.height + txtShop.frame.size.height + txtLoTrinh.frame.size.height + tableView.frame.size.height + lbViewBot4.frame.size.height + 100)
        
      
        
        addSubview(scrollView)
        scrollView.addSubview(txtName)
        scrollView.addSubview(txtShop)
        scrollView.addSubview(txtLoTrinh)
        scrollView.addSubview(viewLine3)
        scrollView.addSubview(lbSeriNo)
        scrollView.addSubview(lbTenPhuKien)
        scrollView.addSubview(lbKHGiao)
        scrollView.addSubview(lbCheckin)
        scrollView.addSubview(valueNgayLoTrinh)
        scrollView.addSubview(lbSLGiao)
        scrollView.addSubview(lbSLNhan)
        scrollView.addSubview(lbViewBot1)
        scrollView.addSubview(lbViewBot2)
        scrollView.addSubview(lbViewBot3)
        scrollView.addSubview(lbViewBot4)
        scrollView.addSubview(lbViewBot5)
        scrollView.addSubview(lbViewBot6)
        
        scrollView.addSubview(tableView)
        scrollView.addSubview(loadingView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
}



