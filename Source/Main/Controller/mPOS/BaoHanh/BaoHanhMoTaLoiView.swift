//
//  BaoHanhMoTaLoiView.swift
//  mPOS
//
//  Created by sumi on 1/5/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit

class BaoHanhMoTaLoiView: UIView {
    
    var ImageChuKyKHImage:UIImageView!
    var ImageChuKyKH:UIView!
    var viewChuKyKH:UIView!
    
    var ImageChuKyNVImage:UIImageView!
    var ImageChuKyNV:UIView!
    var viewChuKyNV:UIView!
    
    var ImageChuKyManagerImage:UIImageView!
    var ImageChuKyManager:UIView!
    var viewChuKyManager:UIView!
    
    
    var btnHoanTat:UIButton!
    var tableView: UITableView  =   UITableView()
    var edtImei:UITextField!
    var scrollView:UIScrollView!
    var edtMoTaLoi:UITextField!
    var edtDDTinhTrang:UITextField!
    var lbKNgayDuKienTra:UILabel!
    var txtTitleDetails:UILabel!
    
    var viewImageNV:UIView!
    var viewImageNVMore:UIView!
    var viewImageNV2:UIView!
    var viewImageNV3:UIView!
    var viewImageNV4:UIView!
    var viewImageNV5:UIView!
    var viewImageNV6:UIView!
    var viewCMNDTruocButton:UIImageView!
    var viewCMNDTruocButton2:UIImageView!
    var viewCMNDTruocButton3:UIImageView!
    var viewCMNDTruocButton4:UIImageView!
    var viewCMNDTruocButton5:UIImageView!
    var viewCMNDTruocButton6:UIImageView!
    
    var lbCMNDTruocButton:UILabel!
    var lbCMNDTruocButton2:UILabel!
    var lbCMNDTruocButton3:UILabel!
    var lbCMNDTruocButton4:UILabel!
    var lbCMNDTruocButton5:UILabel!
    var lbCMNDTruocButton6:UILabel!
    
    var lbHinhAnhDinhKem:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y:0, width: self.frame.size.width, height: self.frame.size.height - 50))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        let lbImei = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbImei.textAlignment = .left
        lbImei.textColor = UIColor.black
        lbImei.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbImei.text = "Nhập imei (*)"
        
        edtImei = UITextField(frame: CGRect(x: 15 , y: lbImei.frame.origin.y + lbImei.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtImei.placeholder = "Nhập imei"
        edtImei.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtImei.borderStyle = UITextField.BorderStyle.roundedRect
        edtImei.autocorrectionType = UITextAutocorrectionType.no
        edtImei.keyboardType = UIKeyboardType.default
        edtImei.returnKeyType = UIReturnKeyType.done
        edtImei.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtImei.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtImei.isEnabled = false
        
        //////////
        let lbMoTa = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtImei.frame.size.height + edtImei.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbMoTa.textAlignment = .left
        lbMoTa.textColor = UIColor.black
        lbMoTa.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbMoTa.text = "Mô tả lỗi(*)"
        
        
        edtMoTaLoi = UITextField(frame: CGRect(x: 15 , y: lbMoTa.frame.origin.y + lbMoTa.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40) * 2));
        edtMoTaLoi.placeholder = "Mô tả lỗi"
        edtMoTaLoi.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtMoTaLoi.borderStyle = UITextField.BorderStyle.roundedRect
        edtMoTaLoi.autocorrectionType = UITextAutocorrectionType.no
        edtMoTaLoi.keyboardType = UIKeyboardType.default
        edtMoTaLoi.returnKeyType = UIReturnKeyType.done
        edtMoTaLoi.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtMoTaLoi.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        let lbTinhTrang = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtMoTaLoi.frame.size.height + edtMoTaLoi.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTinhTrang.textAlignment = .left
        lbTinhTrang.textColor = UIColor.black
        lbTinhTrang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTinhTrang.text = "Tình trạng sản phẩm (*)"
        
        
        let lbKHGiao = UILabel(frame: CGRect(x: 0, y: lbTinhTrang.frame.size.height + lbTinhTrang.frame.origin.y + Common.Size(s:5) , width: frame.size.width / 7 , height: Common.Size(s:30)))
        lbKHGiao.textAlignment = .center
        lbKHGiao.textColor = UIColor.white
        lbKHGiao.backgroundColor = UIColor(netHex:0x47B054)
        lbKHGiao.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbKHGiao.text = "STT"
        lbKHGiao.numberOfLines = 1;
        lbKHGiao.layer.borderWidth = 0.25
        lbKHGiao.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        ///////lbtextNCC
        
        let lbTenPhuKien = UILabel(frame: CGRect(x: frame.size.width / 7, y: lbKHGiao.frame.origin.y, width: (UIScreen.main.bounds.size.width / 7)   , height: Common.Size(s:30)))
        lbTenPhuKien.textAlignment = .center
        lbTenPhuKien.textColor = UIColor.white
        lbTenPhuKien.backgroundColor = UIColor(netHex:0x47B054)
        lbTenPhuKien.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbTenPhuKien.text = "KH Giao"
        lbTenPhuKien.numberOfLines = 1;
        lbTenPhuKien.layer.borderWidth = 0.25
        lbTenPhuKien.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        let lbSeriNo = UILabel(frame: CGRect(x: lbTenPhuKien.frame.size.width + lbTenPhuKien.frame.origin.x , y: lbKHGiao.frame.origin.y, width: frame.size.width - (lbTenPhuKien.frame.size.width + lbKHGiao.frame.size.width) , height: Common.Size(s:30)))
        lbSeriNo.textAlignment = .center
        lbSeriNo.textColor = UIColor.white
        lbSeriNo.backgroundColor = UIColor(netHex:0x47B054)
        lbSeriNo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbSeriNo.text = "Tình trạng"
        lbSeriNo.numberOfLines = 1;
        lbSeriNo.layer.borderWidth = 0.25
        lbSeriNo.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        
        tableView.frame = CGRect(x: 0, y: lbSeriNo.frame.origin.y + lbSeriNo.frame.size.height , width: frame.size.width, height: (lbKHGiao.frame.size.height * 7))
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(netHex:0xffffff)
        
        
        let lbDDTinhTrang = UILabel(frame: CGRect(x: Common.Size(s:15), y: tableView.frame.size.height + tableView.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbDDTinhTrang.textAlignment = .left
        lbDDTinhTrang.textColor = UIColor.black
        lbDDTinhTrang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbDDTinhTrang.text = "Diễn giải tình trạng sản phẩm (*)"
        
        
        edtDDTinhTrang = UITextField(frame: CGRect(x: 15 , y: lbDDTinhTrang.frame.origin.y + lbDDTinhTrang.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40) * 2));
        edtDDTinhTrang.placeholder = "Nhập diễn giải tình trạng sản phẩm"
        edtDDTinhTrang.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtDDTinhTrang.borderStyle = UITextField.BorderStyle.roundedRect
        edtDDTinhTrang.autocorrectionType = UITextAutocorrectionType.no
        edtDDTinhTrang.keyboardType = UIKeyboardType.default
        edtDDTinhTrang.returnKeyType = UIReturnKeyType.done
        edtDDTinhTrang.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtDDTinhTrang.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        lbKNgayDuKienTra = UILabel(frame: CGRect(x: 0, y: edtDDTinhTrang.frame.origin.y + edtDDTinhTrang.frame.size.height, width: frame.size.width - Common.Size(s:10)  , height: Common.Size(s:30)))
        
        lbKNgayDuKienTra.textAlignment = .right
        lbKNgayDuKienTra.textColor = UIColor.red
        lbKNgayDuKienTra.backgroundColor = UIColor(netHex:0xffffff)
        lbKNgayDuKienTra.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbKNgayDuKienTra.text = "Ngày dự kiến trả : 22/09/2017"
        lbKNgayDuKienTra.numberOfLines = 1;
        
        
        
        viewChuKyKH = UIView(frame: CGRect(x: 0,y: lbKNgayDuKienTra.frame.origin.y +  lbKNgayDuKienTra.frame.size.height + Common.Size(s: 20) ,width:UIScreen.main.bounds.size.width , height: Common.Size(s: 120) * 2))
        viewChuKyKH.backgroundColor = UIColor(netHex:0xffffff)
        
        let lbTextChuKyKH = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 14)))
        lbTextChuKyKH.textAlignment = .left
        lbTextChuKyKH.textColor = UIColor.black
        lbTextChuKyKH.font = UIFont.systemFont(ofSize: Common.Size(s: 11))
        lbTextChuKyKH.text = "Chữ ký của khách hàng"
        viewChuKyKH.addSubview(lbTextChuKyKH)
        
        ImageChuKyKH = UIView(frame: CGRect(x:Common.Size(s: 15), y: lbTextChuKyKH.frame.origin.y + lbTextChuKyKH.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 100) * 2) )
        ImageChuKyKH.layer.borderWidth = 0.5
        ImageChuKyKH.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        ImageChuKyKH.layer.cornerRadius = 3.0
        viewChuKyKH.addSubview(ImageChuKyKH)
        
        ImageChuKyKHImage = UIImageView(frame: CGRect(x: ImageChuKyKH.frame.size.width/2 - (ImageChuKyKH.frame.size.height * 2/3)/2, y: 0, width: ImageChuKyKH.frame.size.height * 2/3, height: ImageChuKyKH.frame.size.height * 2/3))
        //ImageChuKyKHImage.image = UIImage(named:"Add Image-51")
        ImageChuKyKHImage.contentMode = .scaleAspectFit
        ImageChuKyKH.addSubview(ImageChuKyKHImage)
        
        ///////add
        viewChuKyNV = UIView(frame: CGRect(x: 0,y: viewChuKyKH.frame.origin.y +  viewChuKyKH.frame.size.height + Common.Size(s: 20) ,width:UIScreen.main.bounds.size.width , height: Common.Size(s: 120) * 2))
        viewChuKyNV.backgroundColor = UIColor(netHex:0xffffff)
        
        let lbTextChuKyNV = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 14)))
        lbTextChuKyNV.textAlignment = .left
        lbTextChuKyNV.textColor = UIColor.black
        lbTextChuKyNV.font = UIFont.systemFont(ofSize: Common.Size(s: 11))
        lbTextChuKyNV.text = "Chữ ký của nhân viên"
        viewChuKyNV.addSubview(lbTextChuKyNV)
        
        ImageChuKyNV = UIView(frame: CGRect(x:Common.Size(s: 15), y: lbTextChuKyNV.frame.origin.y + lbTextChuKyNV.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 100) * 2) )
        ImageChuKyNV.layer.borderWidth = 0.5
        ImageChuKyNV.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        ImageChuKyNV.layer.cornerRadius = 3.0
        viewChuKyNV.addSubview(ImageChuKyNV)
        
        ImageChuKyNVImage = UIImageView(frame: CGRect(x: ImageChuKyKH.frame.size.width/2 - (ImageChuKyKH.frame.size.height * 2/3)/2, y: 0, width: ImageChuKyKH.frame.size.height * 2/3, height: ImageChuKyKH.frame.size.height * 2/3))
        //ImageChuKyNVImage.image = UIImage(named:"Add Image-51")
        ImageChuKyNVImage.contentMode = .scaleAspectFit
        ImageChuKyNV.addSubview(ImageChuKyNVImage)
        
        
        
        ///
        viewChuKyManager = UIView(frame: CGRect(x: 0,y: viewChuKyNV.frame.origin.y +  viewChuKyNV.frame.size.height + Common.Size(s: 20) ,width:UIScreen.main.bounds.size.width , height: Common.Size(s: 120) * 2))
        viewChuKyManager.backgroundColor = UIColor(netHex:0xffffff)
        
        let lbTextChuKyManager = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 14)))
        lbTextChuKyManager.textAlignment = .left
        lbTextChuKyManager.textColor = UIColor.black
        lbTextChuKyManager.font = UIFont.systemFont(ofSize: Common.Size(s: 11))
        lbTextChuKyManager.text = "Chữ ký của quản lý"
        viewChuKyManager.addSubview(lbTextChuKyManager)
        
        ImageChuKyManager = UIView(frame: CGRect(x:Common.Size(s: 15), y: lbTextChuKyManager.frame.origin.y + lbTextChuKyManager.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 100) * 2) )
        ImageChuKyManager.layer.borderWidth = 0.5
        ImageChuKyManager.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        ImageChuKyManager.layer.cornerRadius = 3.0
        viewChuKyManager.addSubview(ImageChuKyManager)
        
        ImageChuKyManagerImage = UIImageView(frame: CGRect(x: ImageChuKyManager.frame.size.width/2 - (ImageChuKyManager.frame.size.height * 2/3)/2, y: 0, width: ImageChuKyManager.frame.size.height * 2/3, height: ImageChuKyKH.frame.size.height * 2/3))
        //ImageChuKyManagerImage.image = UIImage(named:"Add Image-51")
        ImageChuKyManagerImage.contentMode = .scaleAspectFit
        viewChuKyManager.addSubview(ImageChuKyManagerImage)
        
        //////
        
        
        
        
        
        lbHinhAnhDinhKem = UILabel(frame: CGRect(x: Common.Size(s:15), y: viewChuKyManager.frame.size.height + viewChuKyManager.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHinhAnhDinhKem.textAlignment = .left
        lbHinhAnhDinhKem.textColor = UIColor.black
        lbHinhAnhDinhKem.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHinhAnhDinhKem.text = "Hình ảnh đính kèm (*)"
        
        viewImageNV = UIView(frame: CGRect(x:Common.Size(s:15), y: lbHinhAnhDinhKem.frame.origin.y + lbHinhAnhDinhKem.frame.size.height + Common.Size(s:5), width: lbHinhAnhDinhKem.frame.size.width, height: Common.Size(s:110)))
        viewImageNV.layer.borderWidth = 0.5
        viewImageNV.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageNV.layer.cornerRadius = 3.0
        
        
        viewCMNDTruocButton = UIImageView(frame: CGRect(x: viewImageNV.frame.size.width/2 - (viewImageNV.frame.size.height * 2/3)/2, y: 0, width: viewImageNV.frame.size.height * 2/3, height: viewImageNV.frame.size.height * 2/3))
        viewCMNDTruocButton.image = #imageLiteral(resourceName: "AddImage51")
        viewCMNDTruocButton.contentMode = .scaleAspectFit
        viewImageNV.addSubview(viewCMNDTruocButton)
        
        lbCMNDTruocButton = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: viewImageNV.frame.size.width, height: viewImageNV.frame.size.height/3))
        lbCMNDTruocButton.textAlignment = .center
        lbCMNDTruocButton.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDTruocButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTruocButton.text = "Chọn hình ảnh"
        viewImageNV.addSubview(lbCMNDTruocButton)
        
        ///////imageview hidden////
        viewImageNVMore = UIView(frame: CGRect(x:Common.Size(s:15), y: viewImageNV.frame.origin.y + viewImageNV.frame.size.height + Common.Size(s:5), width: lbHinhAnhDinhKem.frame.size.width, height: 0))
        
        
        viewImageNV2 = UIView(frame: CGRect(x: 0 , y: 0, width: lbHinhAnhDinhKem.frame.size.width, height: Common.Size(s:110)))
        viewImageNV2.layer.borderWidth = 0.5
        viewImageNV2.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageNV2.layer.cornerRadius = 3.0
        
        
        viewCMNDTruocButton2 = UIImageView(frame: CGRect(x: viewImageNV2.frame.size.width/2 - (viewImageNV2.frame.size.height * 2/3)/2, y: 0, width: viewImageNV2.frame.size.height * 2/3, height: viewImageNV2.frame.size.height * 2/3))
        viewCMNDTruocButton2.image = #imageLiteral(resourceName: "AddImage51")
        viewCMNDTruocButton2.contentMode = .scaleAspectFit
        viewImageNV2.addSubview(viewCMNDTruocButton2)
        
        lbCMNDTruocButton2 = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton2.frame.size.height + viewCMNDTruocButton2.frame.origin.y, width: viewImageNV2.frame.size.width, height: viewImageNV2.frame.size.height/3))
        lbCMNDTruocButton2.textAlignment = .center
        lbCMNDTruocButton2.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDTruocButton2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTruocButton2.text = "Chọn hình ảnh"
        viewImageNV2.addSubview(lbCMNDTruocButton2)
        
        
        
        
        
        
        viewImageNV3 = UIView(frame: CGRect(x: 0 , y: viewImageNV2.frame.origin.y + viewImageNV2.frame.size.height + Common.Size(s:5), width: lbHinhAnhDinhKem.frame.size.width, height: Common.Size(s:110)))
        viewImageNV3.layer.borderWidth = 0.5
        viewImageNV3.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageNV3.layer.cornerRadius = 3.0
        
        
        viewCMNDTruocButton3 = UIImageView(frame: CGRect(x: viewImageNV3.frame.size.width/2 - (viewImageNV3.frame.size.height * 2/3)/2, y: 0, width: viewImageNV3.frame.size.height * 2/3, height: viewImageNV3.frame.size.height * 2/3))
        viewCMNDTruocButton3.image = #imageLiteral(resourceName: "AddImage51")
        viewCMNDTruocButton3.contentMode = .scaleAspectFit
        viewImageNV3.addSubview(viewCMNDTruocButton3)
        
        lbCMNDTruocButton3 = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: viewImageNV3.frame.size.width, height: viewImageNV3.frame.size.height/3))
        lbCMNDTruocButton3.textAlignment = .center
        lbCMNDTruocButton3.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDTruocButton3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTruocButton3.text = "Chọn hình ảnh"
        viewImageNV3.addSubview(lbCMNDTruocButton3)
        
        
        
        ////
        viewImageNV4 = UIView(frame: CGRect(x: 0 , y: viewImageNV3.frame.origin.y + viewImageNV3.frame.size.height + Common.Size(s:5), width: lbHinhAnhDinhKem.frame.size.width, height: Common.Size(s:110)))
        viewImageNV4.layer.borderWidth = 0.5
        viewImageNV4.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageNV4.layer.cornerRadius = 3.0
        
        
        viewCMNDTruocButton4 = UIImageView(frame: CGRect(x: viewImageNV4.frame.size.width/2 - (viewImageNV4.frame.size.height * 2/3)/2, y: 0, width: viewImageNV4.frame.size.height * 2/3, height: viewImageNV4.frame.size.height * 2/3))
        viewCMNDTruocButton4.image = #imageLiteral(resourceName: "AddImage51")
        viewCMNDTruocButton4.contentMode = .scaleAspectFit
        viewImageNV4.addSubview(viewCMNDTruocButton4)
        
        lbCMNDTruocButton4 = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: viewImageNV4.frame.size.width, height: viewImageNV3.frame.size.height/3))
        lbCMNDTruocButton4.textAlignment = .center
        lbCMNDTruocButton4.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDTruocButton4.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTruocButton4.text = "Chọn hình ảnh"
        viewImageNV4.addSubview(lbCMNDTruocButton4)
        
        
        
        viewImageNV5 = UIView(frame: CGRect(x: 0 , y: viewImageNV4.frame.origin.y + viewImageNV4.frame.size.height + Common.Size(s:5), width: lbHinhAnhDinhKem.frame.size.width, height: Common.Size(s:110)))
        viewImageNV5.layer.borderWidth = 0.5
        viewImageNV5.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageNV5.layer.cornerRadius = 3.0
        
        
        viewCMNDTruocButton5 = UIImageView(frame: CGRect(x: viewImageNV5.frame.size.width/2 - (viewImageNV5.frame.size.height * 2/3)/2, y: 0, width: viewImageNV5.frame.size.height * 2/3, height: viewImageNV5.frame.size.height * 2/3))
        viewCMNDTruocButton5.image = #imageLiteral(resourceName: "AddImage51")
        viewCMNDTruocButton5.contentMode = .scaleAspectFit
        viewImageNV5.addSubview(viewCMNDTruocButton5)
        
        lbCMNDTruocButton5 = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: viewImageNV5.frame.size.width, height: viewImageNV5.frame.size.height/3))
        lbCMNDTruocButton5.textAlignment = .center
        lbCMNDTruocButton5.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDTruocButton5.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTruocButton5.text = "Chọn hình ảnh"
        viewImageNV5.addSubview(lbCMNDTruocButton5)
        
        viewImageNV6 = UIView(frame: CGRect(x: 0 , y: viewImageNV5.frame.origin.y + viewImageNV5.frame.size.height + Common.Size(s:5), width: lbHinhAnhDinhKem.frame.size.width, height: Common.Size(s:110)))
        viewImageNV6.layer.borderWidth = 0.5
        viewImageNV6.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageNV6.layer.cornerRadius = 3.0
        
        
        viewCMNDTruocButton6 = UIImageView(frame: CGRect(x: viewImageNV6.frame.size.width/2 - (viewImageNV6.frame.size.height * 2/3)/2, y: 0, width: viewImageNV6.frame.size.height * 2/3, height: viewImageNV6.frame.size.height * 2/3))
        viewCMNDTruocButton6.image = #imageLiteral(resourceName: "AddImage51")
        viewCMNDTruocButton6.contentMode = .scaleAspectFit
        viewImageNV6.addSubview(viewCMNDTruocButton6)
        
        lbCMNDTruocButton6 = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: viewImageNV6.frame.size.width, height: viewImageNV6.frame.size.height/3))
        lbCMNDTruocButton6.textAlignment = .center
        lbCMNDTruocButton6.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDTruocButton6.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTruocButton6.text = "Chọn hình ảnh"
        viewImageNV6.addSubview(lbCMNDTruocButton6)
        
        
        /////
        
        let strTitleDetails = "Upload thêm hình: "
        let sizeStrTitleDetails: CGSize = strTitleDetails.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:12))])
        txtTitleDetails = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width - 20 - sizeStrTitleDetails.width, y: viewImageNVMore.frame.origin.y + viewImageNVMore.frame.size.height + Common.Size(s:5), width: sizeStrTitleDetails.width, height: sizeStrTitleDetails.height))
        txtTitleDetails.textAlignment = .left
        txtTitleDetails.textColor = UIColor.red
        txtTitleDetails.font = UIFont.italicSystemFont(ofSize: Common.Size(s:12))
        
        let textRange = NSMakeRange(0, strTitleDetails.count)
        let attributedText = NSMutableAttributedString(string: strTitleDetails)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        // Add other attributes if needed
        txtTitleDetails.attributedText = attributedText
        
        
        //////
        
        
        
        
        
        
        
        
        
        
        
        btnHoanTat = UIButton(frame: CGRect(x:Common.Size(s:15) , y: txtTitleDetails.frame.origin.y + txtTitleDetails.frame.size.height + Common.Size(s:10) , width: viewImageNV3.frame.size.width  , height: Common.Size(s:40)));
        btnHoanTat.backgroundColor = UIColor(netHex:0xEF4A40)
        //btnHoanTat.layer.cornerRadius = 20
        btnHoanTat.layer.borderWidth = 0.5
        btnHoanTat.layer.borderColor = UIColor.white.cgColor
        btnHoanTat.layer.cornerRadius = 5.0
        btnHoanTat.setTitle("Hoàn tất",for: .normal)
        btnHoanTat.setTitleColor(UIColor.white, for: .normal)
        
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btnHoanTat.frame.origin.y + btnHoanTat.frame.size.height + 300)
        //        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: lbImei.frame.size.height + edtImei.frame.size.height + lbMoTa.frame.size.height + edtMoTaLoi.frame.size.height + lbTinhTrang.frame.size.height + lbKHGiao.frame.size.height + lbSeriNo.frame.size.height + lbTenPhuKien.frame.size.height + tableView.frame.size.height + lbDDTinhTrang.frame.size.height + edtDDTinhTrang.frame.size.height + lbKNgayDuKienTra.frame.size.height + lbHinhAnhDinhKem.frame.size.height + viewImageNV.frame.size.height + txtTitleDetails.frame.size.height + btnHoanTat.frame.size.height + 300)
        
        
        addSubview(scrollView)
        
        scrollView.addSubview(lbImei)
        scrollView.addSubview(edtImei)
        scrollView.addSubview(lbMoTa)
        scrollView.addSubview(edtMoTaLoi)
        scrollView.addSubview(lbTinhTrang)
        scrollView.addSubview(lbKHGiao)
        scrollView.addSubview(lbSeriNo)
        scrollView.addSubview(lbTenPhuKien)
        scrollView.addSubview(tableView)
        scrollView.addSubview(lbDDTinhTrang)
        scrollView.addSubview(edtDDTinhTrang)
        scrollView.addSubview(lbKNgayDuKienTra)
        scrollView.addSubview(lbHinhAnhDinhKem)
        scrollView.addSubview(viewImageNV)
        scrollView.addSubview(viewImageNVMore)
        
        viewImageNVMore.addSubview(viewImageNV2)
        viewImageNVMore.addSubview(viewImageNV3)
        viewImageNVMore.addSubview(viewImageNV4)
        viewImageNVMore.addSubview(viewImageNV5)
        viewImageNVMore.addSubview(viewImageNV6)
        scrollView.addSubview(txtTitleDetails)
        scrollView.addSubview(viewChuKyKH)
        scrollView.addSubview(viewChuKyNV)
        scrollView.addSubview(viewChuKyManager)
        scrollView.addSubview(btnHoanTat)
        
        viewChuKyNV.frame.origin.y = viewChuKyKH.frame.origin.y +  viewChuKyKH.frame.size.height + Common.Size(s: 10)
        viewChuKyManager.frame.origin.y = viewChuKyNV.frame.origin.y +  viewChuKyNV.frame.size.height + Common.Size(s: 10)
        lbHinhAnhDinhKem.frame.origin.y = viewChuKyManager.frame.origin.y +  viewChuKyManager.frame.size.height + Common.Size(s: 10)
        viewImageNV.frame.origin.y = lbHinhAnhDinhKem.frame.origin.y +  lbHinhAnhDinhKem.frame.size.height + Common.Size(s: 5)
        viewImageNVMore.frame.origin.y = viewImageNV.frame.origin.y +  viewImageNV.frame.size.height + Common.Size(s: 5)
        txtTitleDetails.frame.origin.y = viewImageNVMore.frame.origin.y +  viewImageNVMore.frame.size.height + Common.Size(s: 5)
        
        btnHoanTat.frame.origin.y = txtTitleDetails.frame.origin.y +  txtTitleDetails.frame.size.height + Common.Size(s: 5)
        scrollView.contentSize  = CGSize(width:UIScreen.main.bounds.size.width, height:btnHoanTat.frame.origin.y +  btnHoanTat.frame.size.height + Common.Size(s: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
}
