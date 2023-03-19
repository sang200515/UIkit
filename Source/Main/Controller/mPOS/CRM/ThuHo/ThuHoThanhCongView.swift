//
//  ThuHoThanhCong.swift
//  mPOS
//
//  Created by sumi on 11/28/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
class ThuHoThanhCongView: UIView {
    var lbPhiCaThe:UILabel!
    var lbTenKH:UILabel!
    var lbSdtKH:UILabel!
    var lbMaGD:UILabel!
    var lbTienCuoc:UILabel!
    var lbPhiThuHo:UILabel!
    var lbLoaiGD:UILabel!
    var lbNhaCC:UILabel!
    var lbTongTien:UILabel!
    
    var lbSoPOS:UILabel!
    var scrollView:UIScrollView!
    var viewHinhThucTT:UIView!
    
    var lbViewTop:UILabel!
    var lbViewCenter:UILabel!
    var viewTop:UIView!
    
    var viewBottom:UIView!
    var lbTitle:UILabel!
    var btnPrint:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView = UIScrollView(frame: CGRect(x: 0,y: 0 ,width:UIScreen.main.bounds.size.width , height:  UIScreen.main.bounds.size.height - Common.Size(s:50) ))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        let strTitle = "Tên khách hàng"
        let sizestrTitle: CGSize = strTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:13))])
        lbTenKH = UILabel(frame: CGRect(x:  Common.Size(s:10), y: Common.Size(s:5), width: UIScreen.main.bounds.size.width - Common.Size(s:20), height: sizestrTitle.height))
        lbTenKH.textAlignment = .left
        lbTenKH.backgroundColor = UIColor.white
        lbTenKH.textColor = UIColor.black
        lbTenKH.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbTenKH.text = "200.000 VNĐ"
        
        let strTitle2 = "Thanh toán thành công"
        let sizestrTitle2: CGSize = strTitle2.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:15))])
        lbTitle = UILabel(frame: CGRect(x: (UIScreen.main.bounds.size.width - sizestrTitle2.width)  / 2, y: Common.Size(s:10) , width: UIScreen.main.bounds.size.width - Common.Size(s:20), height: sizestrTitle.height))
        lbTitle.textAlignment = .left
        lbTitle.backgroundColor = UIColor.white
        lbTitle.textColor = UIColor.red
        lbTitle.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        lbTitle.text = "Thanh toán thành công"
        
        
        lbSdtKH = UILabel(frame: CGRect(x:  Common.Size(s:10), y: lbTenKH.frame.origin.y + lbTenKH.frame.size.height + Common.Size(s:10) , width: UIScreen.main.bounds.size.width - Common.Size(s:20), height: sizestrTitle.height))
        lbSdtKH.textAlignment = .left
        lbSdtKH.backgroundColor = UIColor.white
        lbSdtKH.textColor = UIColor.black
        lbSdtKH.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbSdtKH.text = "200.000 VNĐ"
        
        
        lbMaGD = UILabel(frame: CGRect(x:  Common.Size(s:10), y: Common.Size(s:5) , width: UIScreen.main.bounds.size.width - Common.Size(s:20), height: sizestrTitle.height))
        lbMaGD.textAlignment = .left
        lbMaGD.backgroundColor = UIColor.white
        lbMaGD.textColor = UIColor.black
        lbMaGD.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        lbMaGD.text = "200.000 VNĐ"
        
        
        lbLoaiGD = UILabel(frame: CGRect(x:  Common.Size(s:10), y: lbMaGD.frame.origin.y + lbMaGD.frame.size.height + Common.Size(s:10) , width: UIScreen.main.bounds.size.width - Common.Size(s:20), height: sizestrTitle.height))
        lbLoaiGD.textAlignment = .left
        lbLoaiGD.backgroundColor = UIColor.white
        lbLoaiGD.textColor = UIColor.black
        lbLoaiGD.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        lbLoaiGD.text = "200.000 VNĐ"
        
        
        lbNhaCC = UILabel(frame: CGRect(x:  Common.Size(s:10), y: lbLoaiGD.frame.origin.y + lbLoaiGD.frame.size.height + Common.Size(s:10) , width: UIScreen.main.bounds.size.width - Common.Size(s:20), height: sizestrTitle.height))
        lbNhaCC.textAlignment = .left
        lbNhaCC.backgroundColor = UIColor.white
        lbNhaCC.textColor = UIColor.black
        lbNhaCC.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        lbNhaCC.text = "200.000 VNĐ"
        
        lbSoPOS = UILabel(frame: CGRect(x:  Common.Size(s:10), y: lbNhaCC.frame.origin.y + lbNhaCC.frame.size.height + Common.Size(s:10) , width: UIScreen.main.bounds.size.width - Common.Size(s:20), height: sizestrTitle.height))
        lbSoPOS.textAlignment = .left
        lbSoPOS.backgroundColor = UIColor.white
        lbSoPOS.textColor = UIColor.black
        lbSoPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        lbSoPOS.text = "200.000 VNĐ"
        
        lbTienCuoc = UILabel(frame: CGRect(x:  Common.Size(s:10), y: lbSdtKH.frame.origin.y + lbSdtKH.frame.size.height + Common.Size(s:10) , width: UIScreen.main.bounds.size.width - Common.Size(s:20), height: sizestrTitle.height))
        lbTienCuoc.textAlignment = .left
        lbTienCuoc.backgroundColor = UIColor.white
        lbTienCuoc.textColor = UIColor.black
        lbTienCuoc.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbTienCuoc.text = "200.000 VNĐ"
        
        
        lbPhiThuHo = UILabel(frame: CGRect(x:  Common.Size(s:10), y: lbTienCuoc.frame.origin.y + lbTienCuoc.frame.size.height + Common.Size(s:10) , width: UIScreen.main.bounds.size.width - Common.Size(s:20), height: sizestrTitle.height))
        lbPhiThuHo.textAlignment = .left
        lbPhiThuHo.backgroundColor = UIColor.white
        lbPhiThuHo.textColor = UIColor.black
        lbPhiThuHo.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbPhiThuHo.text = "200.000 VNĐ"
        
        
        lbPhiCaThe = UILabel(frame: CGRect(x:  Common.Size(s:10), y: lbPhiThuHo.frame.origin.y + lbTienCuoc.frame.size.height + Common.Size(s:10) , width: UIScreen.main.bounds.size.width - Common.Size(s:20), height: sizestrTitle.height))
        lbPhiCaThe.textAlignment = .left
        lbPhiCaThe.backgroundColor = UIColor.white
        lbPhiCaThe.textColor = UIColor.black
        lbPhiCaThe.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbPhiCaThe.text = "200.000 VNĐ"
        
        
        lbTongTien = UILabel(frame: CGRect(x:  Common.Size(s:10), y: Common.Size(s:5) , width: UIScreen.main.bounds.size.width - Common.Size(s:20), height: sizestrTitle.height))
        lbTongTien.textAlignment = .left
        lbTongTien.backgroundColor = UIColor.white
        lbTongTien.textColor = UIColor.black
        lbTongTien.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        lbTongTien.text = "200.000 VNĐ"
        
        
        lbViewTop = UILabel(frame: CGRect(x:  Common.Size(s:10), y: lbTitle.frame.origin.y + lbTitle.frame.size.height + Common.Size(s:10) , width: UIScreen.main.bounds.size.width - Common.Size(s:20), height: sizestrTitle.height))
        lbViewTop.textAlignment = .left
        lbViewTop.backgroundColor = UIColor.white
        lbViewTop.textColor = UIColor(netHex:0x3bb54a)
        lbViewTop.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        lbViewTop.text = "Thông Tin Giao Dịch"
        
        viewTop = UIView(frame: CGRect(x:5,y:lbViewTop.frame.origin.y + (lbViewTop.frame.size.height ) + Common.Size(s:5) ,width:UIScreen.main.bounds.size.width - 10, height: lbTenKH.frame.size.height * 4 + Common.Size(s:40) ))
        viewTop.backgroundColor = .white
        viewTop.layer.borderWidth = 0.5
        viewTop.layer.borderColor = UIColor(netHex:0x000000).cgColor
        
        
        
        lbViewCenter = UILabel(frame: CGRect(x:  Common.Size(s:10), y: viewTop.frame.origin.y + viewTop.frame.size.height + Common.Size(s:10) , width: UIScreen.main.bounds.size.width - Common.Size(s:20), height: sizestrTitle.height))
        lbViewCenter.textAlignment = .left
        lbViewCenter.backgroundColor = UIColor.white
        lbViewCenter.textColor = UIColor(netHex:0x3bb54a)
        lbViewCenter.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        lbViewCenter.text = "Thông Tin Thanh Toán"
        
        viewHinhThucTT = UIView(frame: CGRect(x:5,y:lbViewCenter.frame.origin.y + (lbViewCenter.frame.size.height ) + Common.Size(s:10) ,width:UIScreen.main.bounds.size.width - 10, height: lbTenKH.frame.size.height * 5 + Common.Size(s:50) ))
        viewHinhThucTT.backgroundColor = .white
        viewHinhThucTT.layer.borderWidth = 0.5
        viewHinhThucTT.layer.borderColor = UIColor(netHex:0x000000).cgColor
        
        
        viewBottom = UIView(frame: CGRect(x:5,y:viewHinhThucTT.frame.origin.y + (viewHinhThucTT.frame.size.height ) + Common.Size(s:10) ,width:UIScreen.main.bounds.size.width - 10, height: lbTenKH.frame.size.height + Common.Size(s:10) * 2 ))
        viewBottom.backgroundColor = .white
        viewBottom.layer.borderWidth = 0.5
        viewBottom.layer.borderColor = UIColor(netHex:0x000000).cgColor
        
        let lbTitleIn =  UILabel(frame: CGRect(x: Common.Size(s:15), y: viewBottom.frame.origin.y + viewBottom.frame.size.height + Common.Size(s: 20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTitleIn.textAlignment = .center
        lbTitleIn.textColor = UIColor.red
        lbTitleIn.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitleIn.text = "(Chỉ in phiếu khi cần thiết)"
        scrollView.addSubview(lbTitleIn)
        
        btnPrint = UIButton(frame: CGRect(x:(UIScreen.main.bounds.size.width - (UIScreen.main.bounds.size.width - 30)) / 2, y: lbTitleIn.frame.origin.y + lbTitleIn.frame.size.height + Common.Size(s: 5), width: (UIScreen.main.bounds.size.width - 30)  , height: Common.Size(s:40)));
        //        btnPrint = UIButton(frame:CGRect(x:0,y: lbTongTien.frame.origin.y + lbTongTien.frame.size.height + Common.Size(s: 5),width: viewBottom.frame. ,height:Common.Size(s: 35)))
        btnPrint.backgroundColor = UIColor(netHex:0x47B054)
        btnPrint.layer.borderWidth = 0.5
        btnPrint.layer.borderColor = UIColor.white.cgColor
        btnPrint.layer.cornerRadius = 5.0
        btnPrint.setTitleColor(UIColor.white, for: .normal)
        btnPrint.setTitle("In phiếu", for: .normal)
        btnPrint.isHidden = false
        
        addSubview(scrollView)
        scrollView.addSubview(lbViewTop)
        scrollView.addSubview(lbViewCenter)
        scrollView.addSubview(viewHinhThucTT)
        scrollView.addSubview(viewTop)
        viewTop.addSubview(lbMaGD)
        viewTop.addSubview(lbLoaiGD)
        viewTop.addSubview(lbNhaCC)
        viewTop.addSubview(lbSoPOS)
        
        viewHinhThucTT.addSubview(lbTenKH)
        viewHinhThucTT.addSubview(lbSdtKH)
        
        viewHinhThucTT.addSubview(lbTienCuoc)
        viewHinhThucTT.addSubview(lbPhiThuHo)
        viewHinhThucTT.addSubview(lbPhiCaThe)
        
        scrollView.addSubview(lbTitle)
        scrollView.addSubview(viewBottom)
        viewBottom.addSubview(lbTongTien)
        scrollView.addSubview(btnPrint)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btnPrint.frame.origin.y + btnPrint.frame.size.height + 30)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
}

