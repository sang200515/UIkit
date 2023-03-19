//
//  BaoHanhChiTietOnClickView.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit

class BaoHanhChiTietOnClickView: UIView {

    var tableView: UITableView  =   UITableView()
    var scrollView:UIScrollView!
    var txtName:UILabel!
    var txtShop:UILabel!
    var txtLoTrinh:UILabel!
    var viewLine3:UIView!
    var lbKHGiao:UILabel!
    var lbTenPhuKien:UILabel!
    var lbSeriNo:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(netHex:0xffffff)
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height + 100 + Common.Size(s:30))
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
        
        
        txtLoTrinh = UILabel(frame: CGRect(x: 20, y: txtShop.frame.origin.y +  txtShop.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - 40, height: sizeNameString.height))
        txtLoTrinh.textAlignment = .left
        txtLoTrinh.textColor = UIColor(netHex:0x000000)
        txtLoTrinh.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        txtLoTrinh.text = ""
        
        viewLine3  = UIView(frame: CGRect(x: 0,y: txtLoTrinh.frame.origin.y + txtLoTrinh.frame.size.height + 1 ,width:UIScreen.main.bounds.size.width , height: 1))
        viewLine3.backgroundColor = UIColor(netHex:0xe7e7e7)
        
        
        
        
        
        
        
        lbKHGiao = UILabel(frame: CGRect(x: 0, y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 3 , height: Common.Size(s:30)))
        lbKHGiao.textAlignment = .center
        lbKHGiao.textColor = UIColor.white
        lbKHGiao.backgroundColor = UIColor(netHex:0x007adf)
        lbKHGiao.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbKHGiao.text = "Số phiếu BH"
        lbKHGiao.numberOfLines = 1;
        lbKHGiao.layer.borderWidth = 0.25
        lbKHGiao.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        ///////lbtextNCC
        
        lbTenPhuKien = UILabel(frame: CGRect(x: lbKHGiao.frame.size.width , y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 3 , height: Common.Size(s:30)))
        lbTenPhuKien.textAlignment = .center
        lbTenPhuKien.textColor = UIColor.white
        lbTenPhuKien.backgroundColor = UIColor(netHex:0x007adf)
        lbTenPhuKien.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbTenPhuKien.text = "Tên SP"
        lbTenPhuKien.numberOfLines = 1;
        lbTenPhuKien.layer.borderWidth = 0.25
        lbTenPhuKien.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        lbSeriNo = UILabel(frame: CGRect(x: lbTenPhuKien.frame.origin.x + frame.size.width / 3 , y: viewLine3.frame.size.height + viewLine3.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 3 , height: Common.Size(s:30)))
        lbSeriNo.textAlignment = .center
        lbSeriNo.textColor = UIColor.white
        lbSeriNo.backgroundColor = UIColor(netHex:0x007adf)
        lbSeriNo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbSeriNo.text = "Imei"
        lbSeriNo.numberOfLines = 1;
        lbSeriNo.layer.borderWidth = 0.25
        lbSeriNo.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        
        
        tableView.frame = CGRect(x: 0, y: lbSeriNo.frame.origin.y + lbSeriNo.frame.size.height , width: frame.size.width, height: frame.size.height -  Common.Size(s:20) * 10)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(netHex:0xffffff)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: tableView.frame.size.height + 100)
        
        
        addSubview(scrollView)
        scrollView.addSubview(txtName)
        scrollView.addSubview(txtShop)
        scrollView.addSubview(txtLoTrinh)
        scrollView.addSubview(viewLine3)
        scrollView.addSubview(lbSeriNo)
        scrollView.addSubview(lbTenPhuKien)
        scrollView.addSubview(lbKHGiao)
        
        scrollView.addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
}

