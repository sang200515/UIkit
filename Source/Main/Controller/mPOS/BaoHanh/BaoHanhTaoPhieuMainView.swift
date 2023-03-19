//
//  BaoHanhTaoPhieuMainView.swift
//  mPOS
//
//  Created by sumi on 12/14/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit

class BaoHanhTaoPhieuMainView: UIView , UIGestureRecognizerDelegate {
    
    var viewContent:UIView!
    var viewThongTin:UIView!
    var viewPhuKien:UIView!
    var viewTTHang:UIView!
    var viewMoTaLoi:UIView!
    var lbThongTin:UILabel!
    var lbPhuKien:UILabel!
    var lbMoTaLoi:UILabel!
    var lbTTHang:UILabel!
    var scrollView:UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        viewThongTin = UIView(frame: CGRect(x:0,y: 0,width:UIScreen.main.bounds.size.width / 4, height: 50 ))
        viewThongTin.backgroundColor = UIColor(netHex:0xffffff)
        viewThongTin.layer.borderWidth = 0.5
        viewThongTin.layer.borderColor = UIColor(netHex:0x000000).cgColor
        
        
        let strTitle = "Thông tin chung "
        let sizeStrTitle: CGSize = strTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:13))])
        lbThongTin = UILabel(frame: CGRect(x: 0, y: (viewThongTin.frame.size.height - sizeStrTitle.height) / 2 , width: viewThongTin.frame.size.width , height: Common.Size(s:13)))
        lbThongTin.textAlignment = .center
        lbThongTin.textColor = UIColor.black
        lbThongTin.font = UIFont.systemFont(ofSize: Common.Size(s:9))
        lbThongTin.text = strTitle
        
        viewThongTin.addSubview(lbThongTin)
        
        
        viewPhuKien = UIView(frame: CGRect(x:viewThongTin.frame.origin.x + viewThongTin.frame.size.width,y: viewThongTin.frame.origin.y ,width:UIScreen.main.bounds.size.width / 4, height: 50 ))
        viewPhuKien.backgroundColor = UIColor(netHex:0x47B054)
        viewPhuKien.layer.borderWidth = 0.5
        viewPhuKien.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        lbPhuKien = UILabel(frame: CGRect(x: Common.Size(s:5), y: (viewThongTin.frame.size.height - sizeStrTitle.height) / 2 , width: viewThongTin.frame.size.width , height: Common.Size(s:13)))
        lbPhuKien.textAlignment = .left
        lbPhuKien.textColor = UIColor.white
        lbPhuKien.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbPhuKien.text = "PK kèm theo"
        
        viewPhuKien.addSubview(lbPhuKien)
        
        
        viewMoTaLoi = UIView(frame: CGRect(x:viewPhuKien.frame.origin.x + viewPhuKien.frame.size.width,y: viewThongTin.frame.origin.y ,width:UIScreen.main.bounds.size.width / 3, height: 50 ))
        viewMoTaLoi.backgroundColor = UIColor(netHex:0x47B054)
        viewMoTaLoi.layer.borderWidth = 0.5
        viewMoTaLoi.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        lbMoTaLoi = UILabel(frame: CGRect(x: 0, y: (viewThongTin.frame.size.height - sizeStrTitle.height) / 2 , width: viewThongTin.frame.size.width , height: Common.Size(s:13)))
        lbMoTaLoi.textAlignment = .center
        lbMoTaLoi.textColor = UIColor.white
        lbMoTaLoi.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbMoTaLoi.text = "Mô tả lỗi"
        
        viewMoTaLoi.addSubview(lbMoTaLoi)
        
        viewTTHang = UIView(frame: CGRect(x:viewMoTaLoi.frame.origin.x + viewPhuKien.frame.size.width,y: viewThongTin.frame.origin.y ,width:UIScreen.main.bounds.size.width / 3, height: 50 ))
        viewTTHang.backgroundColor = UIColor(netHex:0x47B054)
        viewTTHang.layer.borderWidth = 0.5
        viewTTHang.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        lbTTHang = UILabel(frame: CGRect(x: Common.Size(s:5), y: (viewThongTin.frame.size.height - sizeStrTitle.height) / 2 , width: viewThongTin.frame.size.width , height: Common.Size(s:13)))
        lbTTHang.textAlignment = .left
        lbTTHang.textColor = UIColor.white
        lbTTHang.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTTHang.text = "TTin đến hãng"
        
        viewTTHang.addSubview(lbTTHang)
        
        
        
        
        addSubview(viewThongTin)
        addSubview(viewPhuKien)
        addSubview(viewMoTaLoi)
        addSubview(viewTTHang)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    
    
    
}
