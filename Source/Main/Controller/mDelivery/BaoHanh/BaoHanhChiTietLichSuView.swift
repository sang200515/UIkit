//
//  BaoHanhChiTietLichSuView.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import MapKit
import DLRadioButton
import GoogleMaps


class BaoHanhChiTietLichSuView: UIView {

    var RADIO_CHOSSEN_NHAN:Bool = false
    var RADIO_CHOSSEN_GIAO:Bool = false
    var RADIO_CHOSSEN_KHAC:Bool = false
    var listRadio1: [DLRadioButton] = []
    var radioCompany:DLRadioButton!
    var radioMarket:DLRadioButton!
    var radioKhac:DLRadioButton!
    var companyButton: SearchTextField!
    var company2Button: SearchTextField!
    
    var viewThuKho:UIView!
    var scrollView:UIScrollView!
    var txtName:UILabel!
    var txtShop:UILabel!
    var txtLoTrinh:UILabel!
    var txtDiemBatDau:UILabel!
    var txtDiemDen:UILabel!
    //var txtXemBanDo:UILabel!
    //var btnDoiLoTrinh:UIButton!
    var txtThongTinBaoHanh:UILabel!
    var txtTongPHBNhan:UILabel!
    var txtTongPHBGiao:UILabel!
    var txtChiTietPHBNhan:UILabel!
    var txtChiTietPHBGiao:UILabel!
    var txtGhiChu:UILabel!
    var edtGhiChu:UITextField!
    var mapKit:MKMapView!
    var edtThuKhoCode:UITextField!
    var viewBottom:UIView!
    var btnXacNhan:UIButton!
    
    var viewLine:UIView!
    var viewLine2:UIView!
    
    var viewLine3:UIView!
    var viewLine4:UIView!
    
    var viewChuKy:UIView!
    var viewImageSign:UIImageView!
    var imageSinging:UIImageView!
    var viewImagePic:UIView!
    var viewCMNDTruocButton3:UIImageView!
    var viewGoogleMap:UIView!
    
    var mapView:GMSMapView!
    var mCamera:GMSCameraPosition!
    
    
    var viewImageSignThuKho:UIView!
    var imageSingingThuKho:UIImageView!
    
    var txtThoiGian:UILabel!
    var txtDoDai:UILabel!
    
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
        txtLoTrinh.text = "Lộ trình giao - nhận :"
        
        viewLine3  = UIView(frame: CGRect(x: 0,y: txtLoTrinh.frame.origin.y + txtLoTrinh.frame.size.height + 1 ,width:UIScreen.main.bounds.size.width , height: 1))
        viewLine3.backgroundColor = UIColor(netHex:0xe7e7e7)
        
        
        let titleLoTrinh = "Điểm bắt đầu :"
        let sizeLoTrinhString: CGSize = titleLoTrinh.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:13))])
        txtDiemBatDau = UILabel(frame: CGRect(x: 20, y: viewLine3.frame.origin.y +  viewLine3.frame.size.height + Common.Size(s:10), width: sizeLoTrinhString.width, height: sizeNameString.height))
        txtDiemBatDau.textAlignment = .left
        txtDiemBatDau.textColor = UIColor(netHex:0x000000)
        txtDiemBatDau.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        txtDiemBatDau.text = "Điểm bắt đầu"
        
        companyButton = SearchTextField(frame: CGRect(x: 20, y: txtDiemBatDau.frame.origin.y +  txtDiemBatDau.frame.size.height + Common.Size(s:5), width: UIScreen.main.bounds.size.width - 40, height: Common.Size(s:30)))
        
        companyButton.placeholder = "điểm bắt đầu"
        companyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton.autocorrectionType = UITextAutocorrectionType.no
        companyButton.keyboardType = UIKeyboardType.default
        companyButton.returnKeyType = UIReturnKeyType.done
        companyButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        companyButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        companyButton.startVisible = true
        companyButton.theme.bgColor = UIColor.white
        companyButton.theme.fontColor = UIColor.black
        companyButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.theme.cellHeight = Common.Size(s:40)
        companyButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        companyButton.isUserInteractionEnabled = false
        
        
        
        
        txtDiemDen = UILabel(frame: CGRect(x: 20, y: companyButton.frame.origin.y +  companyButton.frame.size.height + Common.Size(s:5), width: UIScreen.main.bounds.size.width, height: sizeNameString.height))
        txtDiemDen.textAlignment = .left
        txtDiemDen.textColor = UIColor(netHex:0x000000)
        txtDiemDen.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        txtDiemDen.text = "Điểm đến"
        
        
        
        company2Button = SearchTextField(frame: CGRect(x: 20, y: txtDiemDen.frame.origin.y +  txtDiemDen.frame.size.height + Common.Size(s:5), width: UIScreen.main.bounds.size.width - 40, height: Common.Size(s:30)))
        
        company2Button.placeholder = "điểm bắt đầu"
        company2Button.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        company2Button.borderStyle = UITextField.BorderStyle.roundedRect
        company2Button.autocorrectionType = UITextAutocorrectionType.no
        company2Button.keyboardType = UIKeyboardType.default
        company2Button.returnKeyType = UIReturnKeyType.done
        company2Button.clearButtonMode = UITextField.ViewMode.whileEditing;
        company2Button.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        company2Button.startVisible = true
        company2Button.theme.bgColor = UIColor.white
        company2Button.theme.fontColor = UIColor.black
        company2Button.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        company2Button.theme.cellHeight = Common.Size(s:40)
        company2Button.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        company2Button.isUserInteractionEnabled = false
        
        
        
        
        viewLine4  = UIView(frame: CGRect(x: 0,y: company2Button.frame.origin.y + company2Button.frame.size.height + Common.Size(s:5) ,width:UIScreen.main.bounds.size.width , height: 1))
        viewLine4.backgroundColor = UIColor(netHex:0xe7e7e7)
        
        
        viewBottom = UIView(frame: CGRect(x: 0,y: viewLine4.frame.origin.y + viewLine4.frame.size.height + Common.Size(s:10) ,width:UIScreen.main.bounds.size.width , height: Common.Size(s:30)  + sizeNameString.height * 16 + Common.Size(s:40)))
        viewBottom.backgroundColor = .white
        //        viewBottom.layer.borderWidth = 0.5
        //        viewBottom.layer.borderColor = UIColor(netHex:0x000000).cgColor
        
        
        
        
        
        
        txtThongTinBaoHanh = UILabel(frame: CGRect(x: 20, y: 0, width: UIScreen.main.bounds.size.width, height: sizeNameString.height))
        txtThongTinBaoHanh.textAlignment = .left
        txtThongTinBaoHanh.textColor = UIColor(netHex:0x000000)
        txtThongTinBaoHanh.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        txtThongTinBaoHanh.text = "Thông tin bảo hành :"
        
        viewLine  = UIView(frame: CGRect(x: 0,y: txtThongTinBaoHanh.frame.origin.y + txtThongTinBaoHanh.frame.size.height + 1 ,width:UIScreen.main.bounds.size.width , height: 1))
        viewLine.backgroundColor = UIColor(netHex:0xe7e7e7)
        
        txtTongPHBNhan = UILabel(frame: CGRect(x: 20, y: viewLine.frame.origin.y +  viewLine.frame.size.height + Common.Size(s:5), width: UIScreen.main.bounds.size.width / 2, height: sizeNameString.height))
        txtTongPHBNhan.textAlignment = .left
        txtTongPHBNhan.textColor = UIColor(netHex:0x000000)
        txtTongPHBNhan.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        txtTongPHBNhan.text = "Tổng số PBH nhận   50"
        
        txtChiTietPHBNhan = UILabel(frame: CGRect(x: txtTongPHBNhan.frame.origin.x + txtTongPHBNhan.frame.size.width + 10, y: viewLine.frame.origin.y +  viewLine.frame.size.height + Common.Size(s:5), width: UIScreen.main.bounds.size.width / 2 , height: sizeNameString.height))
        txtChiTietPHBNhan.textAlignment = .left
        txtChiTietPHBNhan.textColor = UIColor.red
        txtChiTietPHBNhan.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        txtChiTietPHBNhan.text = "Chi Tiết"
        txtChiTietPHBNhan.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        
        txtTongPHBGiao = UILabel(frame: CGRect(x: 20, y: txtTongPHBNhan.frame.origin.y +  txtTongPHBNhan.frame.size.height + Common.Size(s:5), width: UIScreen.main.bounds.size.width / 2 , height: sizeNameString.height))
        txtTongPHBGiao.textAlignment = .left
        txtTongPHBGiao.textColor = UIColor(netHex:0x000000)
        txtTongPHBGiao.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        txtTongPHBGiao.text = "Tổng số PBH giao    30"
        
        
        txtChiTietPHBGiao = UILabel(frame: CGRect(x: txtTongPHBNhan.frame.origin.x + txtTongPHBNhan.frame.size.width + 10, y: txtTongPHBGiao.frame.origin.y , width: UIScreen.main.bounds.size.width / 2 , height: sizeNameString.height))
        txtChiTietPHBGiao.textAlignment = .left
        txtChiTietPHBGiao.textColor = UIColor.red
        txtChiTietPHBGiao.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        txtChiTietPHBGiao.text = "Chi Tiết"
        txtChiTietPHBGiao.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        
        
        /************************************************************************/
        txtThoiGian = UILabel(frame: CGRect(x: 20, y: txtChiTietPHBGiao.frame.origin.y +  txtChiTietPHBGiao.frame.size.height + Common.Size(s:5), width: UIScreen.main.bounds.size.width  , height: sizeNameString.height))
        txtThoiGian.textAlignment = .left
        txtThoiGian.textColor = UIColor(netHex:0x000000)
        txtThoiGian.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        txtThoiGian.text = "Thời gian"
        
        txtDoDai = UILabel(frame: CGRect(x: 20, y: txtThoiGian.frame.origin.y +  txtThoiGian.frame.size.height + Common.Size(s:5), width: UIScreen.main.bounds.size.width  , height: sizeNameString.height))
        txtDoDai.textAlignment = .left
        txtDoDai.textColor = UIColor(netHex:0x000000)
        txtDoDai.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        txtDoDai.text = "Độ dài"
        
        
        /************************************************************************/
        
        //////radiobutton
        radioCompany = createRadioButtonPayType(CGRect(x: Common.Size(s:10) ,y: txtDoDai.frame.size.height + txtDoDai.frame.origin.y + Common.Size(s:10) , width: frame.size.width / 3, height: Common.Size(s:20)), title: "Nhận hàng", color: UIColor.black);
        //radioCompany.backgroundColor = UIColor(netHex:0x30789e)
        radioCompany.tag = 1
        radioCompany.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        radioCompany.setTitleColor(UIColor.black, for: UIControl.State.normal)
        radioCompany.isSelected = false
        radioCompany.isIconSquare = true
        
        
        radioMarket = createRadioButtonPayType(CGRect(x: radioCompany.frame.width, y: txtDoDai.frame.size.height + txtDoDai.frame.origin.y + Common.Size(s:10), width: frame.size.width / 3, height: Common.Size(s:20)), title: "Giao hàng", color: UIColor.black);
        //radioMarket.backgroundColor = UIColor(netHex:0x30789e)
        radioMarket.isSelected = false
        radioMarket.isIconSquare = true
        radioMarket.setTitleColor(UIColor.black, for: UIControl.State.normal)
        radioMarket.tag = 2
        radioMarket.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        
        
        
        
        radioKhac = createRadioButtonPayType(CGRect(x: radioMarket.frame.width + radioMarket.frame.origin.x, y: txtDoDai.frame.size.height + txtDoDai.frame.origin.y + Common.Size(s:10), width: frame.size.width / 3, height: Common.Size(s:20)), title: "Khác", color: UIColor.black);
        //radioMarket.backgroundColor = UIColor(netHex:0x30789e)
        radioKhac.isSelected = false
        radioKhac.isIconSquare = true
        radioKhac.setTitleColor(UIColor.black, for: UIControl.State.normal)
        radioKhac.tag = 3
        radioKhac.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        
        
        listRadio1.append(radioMarket)
        listRadio1.append(radioCompany)
        listRadio1.append(radioKhac)
        
        viewLine2  = UIView(frame: CGRect(x: 0,y: radioMarket.frame.origin.y +  radioMarket.frame.size.height + Common.Size(s:10) ,width:UIScreen.main.bounds.size.width , height: 1))
        viewLine2.backgroundColor = UIColor(netHex:0xe7e7e7)
        
        
        ///chu ky thu kho 18/09
        viewThuKho = UIView(frame: CGRect(x: 0,y: radioMarket.frame.origin.y +  radioMarket.frame.size.height + Common.Size(s:20) ,width:UIScreen.main.bounds.size.width , height: 330))
        viewThuKho.backgroundColor = UIColor(netHex:0xffffff)
        
        let lbTextThuKhoCode = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextThuKhoCode.textAlignment = .left
        lbTextThuKhoCode.textColor = UIColor.black
        lbTextThuKhoCode.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextThuKhoCode.text = "Mã inside:"
        viewThuKho.addSubview(lbTextThuKhoCode)
        
        
        edtThuKhoCode = UITextField(frame: CGRect(x: Common.Size(s:15)   , y: lbTextThuKhoCode.frame.size.height + lbTextThuKhoCode.frame.origin.y + Common.Size(s:5) , width: lbTextThuKhoCode.frame.size.width  , height: Common.Size(s:30)));
        edtThuKhoCode.placeholder = "Nhập mã inside :"
        edtThuKhoCode.tag = 1
        edtThuKhoCode.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        edtThuKhoCode.borderStyle = UITextField.BorderStyle.roundedRect
        edtThuKhoCode.autocorrectionType = UITextAutocorrectionType.no
        edtThuKhoCode.tag = 1
        edtThuKhoCode.keyboardType = UIKeyboardType.default
        edtThuKhoCode.returnKeyType = UIReturnKeyType.done
        edtThuKhoCode.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtThuKhoCode.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        viewThuKho.addSubview(edtThuKhoCode)
        
        
        
        let lbTextSignThuKho = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtThuKhoCode.frame.origin.y + edtThuKhoCode.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSignThuKho.textAlignment = .left
        lbTextSignThuKho.textColor = UIColor.black
        lbTextSignThuKho.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextSignThuKho.text = "Chữ ký của nv thủ kho shop"
        viewThuKho.addSubview(lbTextSignThuKho)
        
        viewImageSignThuKho = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSignThuKho.frame.origin.y + lbTextSignThuKho.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:100) * 2) )
        viewImageSignThuKho.layer.borderWidth = 0.5
        viewImageSignThuKho.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSignThuKho.layer.cornerRadius = 3.0
        viewThuKho.addSubview(viewImageSignThuKho)
        
        imageSingingThuKho = UIImageView(frame: CGRect(x: viewImageSignThuKho.frame.size.width/2 - (viewImageSignThuKho.frame.size.height * 2/3)/2, y: 0, width: viewImageSignThuKho.frame.size.height * 2/3, height: viewImageSignThuKho.frame.size.height * 2/3))
        imageSingingThuKho.contentMode = .scaleAspectFit
        viewImageSignThuKho.addSubview(imageSingingThuKho)
        
        
        ///////////Chu ky
        viewChuKy = UIView(frame: CGRect(x: 0,y: radioMarket.frame.origin.y +  radioMarket.frame.size.height + Common.Size(s:20) ,width:UIScreen.main.bounds.size.width , height: 500))
        viewChuKy.backgroundColor = UIColor(netHex:0xffffff)
        
        let lbTextSign = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSign.textAlignment = .left
        lbTextSign.textColor = UIColor.black
        lbTextSign.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextSign.text = "Chữ ký của nv Giao/Nhận hãng"
        viewChuKy.addSubview(lbTextSign)
        
        viewImageSign = UIImageView(frame: CGRect(x:Common.Size(s:15), y: lbTextSign.frame.origin.y + lbTextSign.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:100) * 2) )
        viewImageSign.layer.borderWidth = 0.5
        viewImageSign.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSign.layer.cornerRadius = 3.0
        viewImageSign.image = UIImage(named:"Add Image-51")
        viewImageSign.contentMode = .scaleAspectFit
        viewChuKy.addSubview(viewImageSign)
        
        let lbTextImage = UILabel(frame: CGRect(x: Common.Size(s:15), y: viewImageSign.frame.size.height + viewImageSign.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextImage.textAlignment = .left
        lbTextImage.textColor = UIColor.black
        lbTextImage.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextImage.text = "Hình ảnh biên bản bàn giao"
        viewChuKy.addSubview(lbTextImage)
        
        viewImagePic = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextImage.frame.origin.y + lbTextImage.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:100) * 1.5) )
        viewImagePic.layer.borderWidth = 0.5
        viewImagePic.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImagePic.layer.cornerRadius = 3.0
        viewChuKy.addSubview(viewImagePic)
        
        viewCMNDTruocButton3 = UIImageView(frame: CGRect(x: viewImagePic.frame.size.width/2 - (viewImagePic.frame.size.height * 2/3)/2, y: 0, width: viewImagePic.frame.size.height , height: viewImagePic.frame.size.height ))
        viewCMNDTruocButton3.image = UIImage(named:"Add Image-51")
        viewCMNDTruocButton3.contentMode = .scaleToFill
        viewImagePic.addSubview(viewCMNDTruocButton3)
        
        ///////////
        
        txtGhiChu = UILabel(frame: CGRect(x: 20, y: viewChuKy.frame.origin.y +  viewChuKy.frame.size.height + Common.Size(s:5), width: UIScreen.main.bounds.size.width, height: sizeNameString.height))
        txtGhiChu.textAlignment = .left
        txtGhiChu.textColor = UIColor(netHex:0x000000)
        txtGhiChu.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        txtGhiChu.text = "Ghi chú:"
        
        
        
        edtGhiChu = UITextField(frame: CGRect(x: txtGhiChu.frame.origin.x   , y: txtGhiChu.frame.size.height + txtGhiChu.frame.origin.y + Common.Size(s:5) , width: txtGhiChu.frame.size.width - 40 , height: Common.Size(s:50)));
        edtGhiChu.placeholder = "Nhập ghi chú (nếu có) :"
        edtGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        edtGhiChu.borderStyle = UITextField.BorderStyle.roundedRect
        edtGhiChu.autocorrectionType = UITextAutocorrectionType.no
        edtGhiChu.tag = 1
        edtGhiChu.keyboardType = UIKeyboardType.default
        edtGhiChu.returnKeyType = UIReturnKeyType.done
        edtGhiChu.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtGhiChu.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtGhiChu.isUserInteractionEnabled = false
        
        
        btnXacNhan = UIButton(frame: CGRect(x:(UIScreen.main.bounds.size.width - txtLoTrinh.frame.size.width / 2) / 2, y: edtGhiChu.frame.size.height + edtGhiChu.frame.origin.y + Common.Size(s:10) , width: txtLoTrinh.frame.size.width / 2  , height: Common.Size(s:30)));
        btnXacNhan.backgroundColor = UIColor(netHex:0xEF4A40)
        //btnHoanTat.layer.cornerRadius = 20
        btnXacNhan.layer.borderWidth = 0.5
        btnXacNhan.layer.borderColor = UIColor.white.cgColor
        btnXacNhan.layer.cornerRadius = 5.0
        btnXacNhan.setTitle("Xác nhận",for: .normal)
        btnXacNhan.setTitleColor(UIColor.white, for: .normal)
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btnXacNhan.frame.origin.y + viewChuKy.frame.size.height + 100)
        viewBottom.frame.size.height = btnXacNhan.frame.origin.y + btnXacNhan.frame.size.height + viewChuKy.frame.size.height + sizeNameString.height
        
        addSubview(scrollView)
        scrollView.addSubview(txtName)
        scrollView.addSubview(txtShop)
        scrollView.addSubview(txtLoTrinh)
        scrollView.addSubview(txtDiemBatDau)
        scrollView.addSubview(companyButton)
        scrollView.addSubview(company2Button)
        scrollView.addSubview(txtDiemDen)
        scrollView.addSubview(viewLine3)
        
        
        scrollView.addSubview(viewLine4)
        scrollView.addSubview(viewBottom)
        
        viewBottom.addSubview(viewLine)
        viewBottom.addSubview(txtThongTinBaoHanh)
        viewBottom.addSubview(txtTongPHBGiao)
        viewBottom.addSubview(txtChiTietPHBNhan)
        viewBottom.addSubview(txtChiTietPHBGiao)
        
        viewBottom.addSubview(txtDoDai)
        viewBottom.addSubview(txtThoiGian)
        
        viewBottom.addSubview(txtTongPHBNhan)
        viewBottom.addSubview(radioMarket)
        viewBottom.addSubview(radioCompany)
        viewBottom.addSubview(radioKhac)
        viewBottom.addSubview(viewChuKy)
        viewBottom.addSubview(viewThuKho)
        viewBottom.addSubview(txtGhiChu)
        viewBottom.addSubview(edtGhiChu)
        //viewBottom.addSubview(btnXacNhan)
        viewBottom.addSubview(viewLine2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    fileprivate func createRadioButtonPayType(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:13));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(UIColor.white, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.isMultipleSelectionEnabled = true
        radioButton.isIconSquare = false;
        radioButton.isSelected = false;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(self.logSelectedButtonBonus), for: UIControl.Event.touchUpInside);
        
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonBonus(_ radioButton : DLRadioButton) {
        if (radioButton.isMultipleSelectionEnabled) {
            let tag = radioButton.tag
            print("\(RADIO_CHOSSEN_NHAN)-\(RADIO_CHOSSEN_GIAO)-\(RADIO_CHOSSEN_KHAC)")
            if (tag == 1){
                RADIO_CHOSSEN_NHAN = !RADIO_CHOSSEN_NHAN
                if(RADIO_CHOSSEN_KHAC == true)
                {
                    radioKhac.isSelected = true
                    RADIO_CHOSSEN_KHAC = false
                }
            }
            else if (tag == 2){
                RADIO_CHOSSEN_GIAO = !RADIO_CHOSSEN_GIAO
                if(RADIO_CHOSSEN_KHAC == true)
                {
                    radioKhac.isSelected = true
                    RADIO_CHOSSEN_KHAC = false
                }
            }
            else if (tag == 3)
            {
                RADIO_CHOSSEN_KHAC = !RADIO_CHOSSEN_KHAC
                
                
                if(RADIO_CHOSSEN_GIAO == true)
                {
                    radioMarket.isSelected = true
                    RADIO_CHOSSEN_GIAO = false
                }
                if(RADIO_CHOSSEN_NHAN == true)
                {
                    radioCompany.isSelected = true
                    RADIO_CHOSSEN_NHAN = false
                }
                
                
            }
            
            print("\(RADIO_CHOSSEN_NHAN)-\(RADIO_CHOSSEN_GIAO)-\(RADIO_CHOSSEN_KHAC)")
        }
    }
    
    
}





