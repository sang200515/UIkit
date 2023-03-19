//
//  BaoHanhPKKemTheoView.swift
//  mPOS
//
//  Created by sumi on 12/15/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit

class BaoHanhPKKemTheoView: UIView {
    
    var imageCheck:UIImageView!
    var btnTiepTuc:UIButton!
    var lbKNgayDuKienTra:UILabel!
    var lbKHGiao:UILabel!
    var lbTenPhuKien:UILabel!
    var lbSoLuong:UILabel!
    var lbCompareLine2:UILabel!
    var lbTTKHGiao:UILabel!
    var lbSeriNo:UILabel!
    var tableView: UITableView  =   UITableView()
    var scrollView:UIScrollView!
    
    var scrollViewTableView:UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        
        
        //////////next row///////
        
        
        
        
        
        
        
        
        
        
        lbKHGiao = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width / 7 , height: Common.Size(s:30)))
        lbKHGiao.textAlignment = .center
        lbKHGiao.textColor = UIColor.white
        lbKHGiao.backgroundColor = UIColor(netHex:0x47B054)
        lbKHGiao.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbKHGiao.text = "KH Giao"
        lbKHGiao.numberOfLines = 1;
        lbKHGiao.layer.borderWidth = 0.25
        lbKHGiao.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        ///////lbtextNCC
        
        lbTenPhuKien = UILabel(frame: CGRect(x: frame.size.width / 7, y: 0, width: (UIScreen.main.bounds.size.width / 6) + (UIScreen.main.bounds.size.width / 6)  , height: Common.Size(s:30)))
        lbTenPhuKien.textAlignment = .center
        lbTenPhuKien.textColor = UIColor.white
        lbTenPhuKien.backgroundColor = UIColor(netHex:0x47B054)
        lbTenPhuKien.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbTenPhuKien.text = "Tên Pk"
        lbTenPhuKien.numberOfLines = 1;
        lbTenPhuKien.layer.borderWidth = 0.25
        lbTenPhuKien.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        //////////next row///////
        
        
        
        lbSoLuong = UILabel(frame: CGRect(x: lbTenPhuKien.frame.size.width + lbTenPhuKien.frame.origin.x, y: 0, width: frame.size.width / 7, height: Common.Size(s:30)))
        lbSoLuong.textAlignment = .center
        lbSoLuong.textColor = UIColor.white
        lbSoLuong.backgroundColor = UIColor(netHex:0x47B054)
        lbSoLuong.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbSoLuong.text = "SL"
        lbSoLuong.numberOfLines = 1;
        lbSoLuong.layer.borderWidth = 0.25
        lbSoLuong.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        
        lbTTKHGiao = UILabel(frame: CGRect(x: lbSoLuong.frame.size.width + lbSoLuong.frame.origin.x, y: 0, width:  frame.size.width / 6 , height: Common.Size(s:30)))
        lbTTKHGiao.textAlignment = .center
        lbTTKHGiao.textColor = UIColor.white
        lbTTKHGiao.backgroundColor = UIColor(netHex:0x47B054)
        lbTTKHGiao.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbTTKHGiao.text = "Tình trạng"
        lbTTKHGiao.numberOfLines = 1;
        lbTTKHGiao.layer.borderWidth = 0.25
        lbTTKHGiao.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        lbSeriNo = UILabel(frame: CGRect(x: lbTTKHGiao.frame.size.width + lbTTKHGiao.frame.origin.x , y: 0, width: frame.size.width - (lbTTKHGiao.frame.size.width + lbSoLuong.frame.size.width + lbTenPhuKien.frame.size.width + lbKHGiao.frame.size.width) , height: Common.Size(s:30)))
        lbSeriNo.textAlignment = .center
        lbSeriNo.textColor = UIColor.white
        lbSeriNo.backgroundColor = UIColor(netHex:0x47B054)
        lbSeriNo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbSeriNo.text = "Serial No"
        lbSeriNo.numberOfLines = 1;
        lbSeriNo.layer.borderWidth = 0.25
        lbSeriNo.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        
        tableView.frame = CGRect(x: 0, y: lbSeriNo.frame.origin.y + lbSeriNo.frame.size.height , width: frame.size.width, height: (lbKHGiao.frame.size.height * 10))
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(netHex:0xffffff)
        
        
        
        
        lbKNgayDuKienTra = UILabel(frame: CGRect(x: 0, y: tableView.frame.origin.y + tableView.frame.size.height, width: frame.size.width - Common.Size(s:10)  , height: Common.Size(s:30)))
        
        lbKNgayDuKienTra.textAlignment = .right
        lbKNgayDuKienTra.textColor = UIColor.red
        lbKNgayDuKienTra.backgroundColor = UIColor(netHex:0xffffff)
        lbKNgayDuKienTra.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbKNgayDuKienTra.text = "Ngày dự kiến trả : 22/09/2017"
        lbKNgayDuKienTra.numberOfLines = 1;
        //lbKNgayDuKienTra.layer.borderWidth = 0.5
        //lbKNgayDuKienTra.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        btnTiepTuc = UIButton(frame: CGRect(x: (UIScreen.main.bounds.size.width - (UIScreen.main.bounds.size.width -  Common.Size(s:30))) / 2, y: lbKNgayDuKienTra.frame.origin.y + lbKNgayDuKienTra.frame.size.height + Common.Size(s:10) , width: UIScreen.main.bounds.size.width -  Common.Size(s:30)  , height: Common.Size(s:40)));
        btnTiepTuc.backgroundColor = UIColor(netHex:0xEF4A40)
        //btnHoanTat.layer.cornerRadius = 20
        btnTiepTuc.layer.borderWidth = 0.5
        btnTiepTuc.layer.borderColor = UIColor.white.cgColor
        btnTiepTuc.layer.cornerRadius = 5.0
        btnTiepTuc.setTitle("Tiếp tục",for: .normal)
        btnTiepTuc.setTitleColor(UIColor.white, for: .normal)
        
        
        addSubview(scrollView)
        
        scrollView.addSubview(tableView)
        //scrollView.addSubview(viewCheck)
        scrollView.addSubview(lbKHGiao)
        scrollView.addSubview(lbTenPhuKien)
        scrollView.addSubview(lbSoLuong)
        scrollView.addSubview(lbTTKHGiao)
        scrollView.addSubview(lbSeriNo)
        scrollView.addSubview(tableView)
        scrollView.addSubview(lbKNgayDuKienTra)
        scrollView.addSubview(btnTiepTuc)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    
}

