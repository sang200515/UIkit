//
//  BaoHanhThongTinChungView.swift
//  mPOS
//
//  Created by sumi on 12/14/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import DLRadioButton


class BaoHanhThongTinChungView: UIView {
    
    var radioMarket:DLRadioButton!
    var isChoose:Bool = false
    var listRadio1: [DLRadioButton] = []
    var hinhthucBHButton: SearchTextField!
    var loaiBHButton: SearchTextField!
    var scrollView:UIScrollView!
    var edtImei:UITextField!
    var imageImei:UIImageView!
    var imageBHButton:UIImageView!
    var edtMaSp:UITextField!
    var txtTitleDetails:UILabel!
    var txtTitleScan:UILabel!
    var txtChonMaSP:UILabel!
    var edtTenSp:UITextView!
    var edtHanBH:UITextField!
    var edtHinhThucBH:UITextField!
    
    
    var viewContent:UIView!
    var edtImei2:UITextField!
    var edtHinhThucBH2:UITextField!
    
    var edtTTBHHang:UITextField!
    var edtTTBHFRT:UITextField!
    
    var txtXemThongTinSP:UILabel!
    
    
    var viewLogo:UIView!
    var viewBottom:UIView!
    
    var edtTenLienHe:UITextField!
    var edtSDTLienHe:UITextField!
    var edtSDTLienHeKhac:UITextField!
    
    var edtMailLienHe:UITextField!
    
    var edtDiaChiLienHe:UITextField!
    var edtGhiChuLienHe:UITextField!
    
    var btnHoanTat:UIButton!
    var lbGhiChuLienHe :UILabel!
    var lbSoDHvalue :UILabel!
    var lbDiaChiFRT:UILabel!
    var lbLoaiDHValue :UILabel!
    var lbShopValue:UILabel!
    var lbNgayMuaValue:UILabel!
    
    var imageViewLogoKnox:UIImageView!
    var imageViewLogoFPT:UIImageView!
    var imageViewLogoSamsung:UIImageView!
    var imageViewApple:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        
        
        let lbImei = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbImei.textAlignment = .left
        lbImei.textColor = UIColor.black
        lbImei.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbImei.text = "Nhập imei (*)"
        
        
        ///sdt
        
        edtImei = UITextField(frame: CGRect(x: 15 , y: lbImei.frame.origin.y + lbImei.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtImei.placeholder = "Nhập imei"
        edtImei.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtImei.borderStyle = UITextField.BorderStyle.roundedRect
        edtImei.autocorrectionType = UITextAutocorrectionType.no
        edtImei.keyboardType = UIKeyboardType.default
        edtImei.returnKeyType = UIReturnKeyType.done
        edtImei.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtImei.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        //////////
        
        ////rightview Spinner NCC
        edtImei.rightViewMode = UITextField.ViewMode.always
        
        imageImei = UIImageView(frame: CGRect(x: edtImei.frame.size.height/4, y: edtImei.frame.size.height/4, width: edtImei.frame.size.height/2, height: edtImei.frame.size.height/2))
        imageImei.image = #imageLiteral(resourceName: "search_baohanh_black")
        imageImei.contentMode = UIView.ContentMode.scaleAspectFit
        let rightViewImei = UIView()
        rightViewImei.addSubview(imageImei)
        rightViewImei.frame = CGRect(x: 0, y: 0, width: edtImei.frame.size.height, height: edtImei.frame.size.height)
        edtImei.rightView = rightViewImei
        
        
        let strTitleDetails = "Xem thêm"
        let sizeStrTitleDetails: CGSize = strTitleDetails.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:12))])
        txtTitleDetails = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width - 20 - sizeStrTitleDetails.width, y: edtImei.frame.origin.y + edtImei.frame.size.height + Common.Size(s:10), width: sizeStrTitleDetails.width, height: sizeStrTitleDetails.height))
        txtTitleDetails.textAlignment = .left
        txtTitleDetails.textColor = UIColor.red
        txtTitleDetails.font = UIFont.italicSystemFont(ofSize: Common.Size(s:12))
        
        let textRange = NSMakeRange(0, strTitleDetails.count)
        let attributedText = NSMutableAttributedString(string: strTitleDetails)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        // Add other attributes if needed
        txtTitleDetails.attributedText = attributedText
        
        
        let strTitleScan = "Quét mã"
        txtTitleScan = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width - 20 - sizeStrTitleDetails.width * 2, y: txtTitleDetails.frame.origin.y , width: sizeStrTitleDetails.width, height: sizeStrTitleDetails.height))
        txtTitleScan.textAlignment = .left
        txtTitleScan.textColor = UIColor.red
        txtTitleScan.font = UIFont.italicSystemFont(ofSize: Common.Size(s:12))
        let textRange6 = NSMakeRange(0, strTitleScan.count)
        let attributedText6 = NSMutableAttributedString(string: strTitleScan)
        attributedText6.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange6)
        // Add other attributes if needed
        
        txtTitleScan.attributedText = attributedText6
        
        
        
        let strTitle = "Thông tin bảo hành: "
        let sizeStrTitle: CGSize = strTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:13))])
        let txtTitle = UILabel(frame: CGRect(x: edtImei.frame.origin.x, y: txtTitleDetails.frame.origin.y + txtTitleDetails.frame.size.height + Common.Size(s:5), width: UIScreen.main.bounds.size.width , height: sizeStrTitle.height))
        txtTitle.textAlignment = .left
        txtTitle.textColor = UIColor(netHex:0x000000)
        txtTitle.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        txtTitle.text = strTitle
        
        
        
        let lbLoaiBH = UILabel(frame: CGRect(x: Common.Size(s:15), y: txtTitle.frame.size.height + txtTitle.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbLoaiBH.textAlignment = .left
        lbLoaiBH.textColor = UIColor.black
        lbLoaiBH.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLoaiBH.text = "Loại BH (*)"
        
        
        loaiBHButton = SearchTextField(frame: CGRect(x: 15, y: lbLoaiBH.frame.origin.y + lbLoaiBH.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40) ));
        
        loaiBHButton.placeholder = "Chọn loại bảo hành"
        loaiBHButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        loaiBHButton.borderStyle = UITextField.BorderStyle.roundedRect
        loaiBHButton.autocorrectionType = UITextAutocorrectionType.no
        loaiBHButton.keyboardType = UIKeyboardType.default
        loaiBHButton.returnKeyType = UIReturnKeyType.done
        loaiBHButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        loaiBHButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        loaiBHButton.startVisible = true
        loaiBHButton.theme.bgColor = UIColor.white
        loaiBHButton.theme.fontColor = UIColor.black
        loaiBHButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        loaiBHButton.theme.cellHeight = Common.Size(s:40)
        loaiBHButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        
        let lbHinhThucBH = UILabel(frame: CGRect(x: Common.Size(s:15), y: loaiBHButton.frame.size.height + loaiBHButton.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHinhThucBH.textAlignment = .left
        lbHinhThucBH.textColor = UIColor.black
        lbHinhThucBH.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHinhThucBH.text = "Hình thức BH (*)"
        
        
        
        hinhthucBHButton = SearchTextField(frame: CGRect(x: 15, y: lbHinhThucBH.frame.origin.y + lbHinhThucBH.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40) ));
        
        hinhthucBHButton.placeholder = "Chọn hình thức bảo hành"
        hinhthucBHButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        hinhthucBHButton.borderStyle = UITextField.BorderStyle.roundedRect
        hinhthucBHButton.autocorrectionType = UITextAutocorrectionType.no
        hinhthucBHButton.keyboardType = UIKeyboardType.default
        hinhthucBHButton.returnKeyType = UIReturnKeyType.done
        hinhthucBHButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        hinhthucBHButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        hinhthucBHButton.startVisible = true
        hinhthucBHButton.theme.bgColor = UIColor.white
        hinhthucBHButton.theme.fontColor = UIColor.black
        hinhthucBHButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        hinhthucBHButton.theme.cellHeight = Common.Size(s:40)
        hinhthucBHButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        hinhthucBHButton.rightViewMode = UITextField.ViewMode.always
        
        
        imageBHButton = UIImageView(frame: CGRect(x: hinhthucBHButton.frame.size.width + hinhthucBHButton.frame.origin.x - (hinhthucBHButton.frame.size.height / 2) - 15 , y: hinhthucBHButton.frame.origin.y + (hinhthucBHButton.frame.size.height / 4), width: hinhthucBHButton.frame.size.height/2, height: hinhthucBHButton.frame.size.height/2))
        imageBHButton.image = #imageLiteral(resourceName: "search_baohanh_black")
        imageBHButton.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        
        
        
        let txtSP = UILabel(frame: CGRect(x: edtImei.frame.origin.x, y: hinhthucBHButton.frame.origin.y + hinhthucBHButton.frame.size.height + Common.Size(s:5), width: UIScreen.main.bounds.size.width , height: sizeStrTitle.height))
        txtSP.textAlignment = .left
        txtSP.textColor = UIColor(netHex:0x000000)
        txtSP.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        txtSP.text = "Sản phẩm :"
        
        let lbMaSP = UILabel(frame: CGRect(x: Common.Size(s:15), y: txtSP.frame.origin.y + txtSP.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbMaSP.textAlignment = .left
        lbMaSP.textColor = UIColor.black
        lbMaSP.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbMaSP.text = "Mã sp (*)"
        
        
        
        edtMaSp = UITextField(frame: CGRect(x: 15 , y: lbMaSP.frame.origin.y + lbMaSP.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtMaSp.placeholder = "Nhập mã sp"
        edtMaSp.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtMaSp.borderStyle = UITextField.BorderStyle.roundedRect
        edtMaSp.autocorrectionType = UITextAutocorrectionType.no
        edtMaSp.keyboardType = UIKeyboardType.default
        edtMaSp.isEnabled = false
        edtMaSp.returnKeyType = UIReturnKeyType.done
        edtMaSp.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtMaSp.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        let strTitleDetails2 = "Chọn"
        let sizeStrTitleDetails2: CGSize = strTitleDetails2.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:12))])
        txtChonMaSP = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width - 20 - sizeStrTitleDetails2.width, y: edtMaSp.frame.origin.y + edtMaSp.frame.size.height + Common.Size(s:10), width: sizeStrTitleDetails2.width, height: sizeStrTitleDetails2.height))
        txtChonMaSP.textAlignment = .left
        txtChonMaSP.textColor = UIColor.red
        txtChonMaSP.font = UIFont.italicSystemFont(ofSize: Common.Size(s:12))
        let textRange2 = NSMakeRange(0, strTitleDetails2.count)
        let attributedText2 = NSMutableAttributedString(string: strTitleDetails2)
        attributedText2.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange2)
        // Add other attributes if needed
        txtChonMaSP.attributedText = attributedText2
        
        
        
        radioMarket = createRadioButtonPayType(CGRect(x: edtMaSp.frame.origin.x, y: txtChonMaSP.frame.origin.y , width: frame.size.width / 2, height: Common.Size(s:20)), title: "Hỏng phụ kiện", color: UIColor.black);
        radioMarket.setTitleColor(UIColor.black, for: UIControl.State.normal)
        radioMarket.tag = 1
        radioMarket.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        listRadio1.append(radioMarket)
        
        
        
        let lbTenSp = UILabel(frame: CGRect(x: Common.Size(s:15), y: radioMarket.frame.origin.y + radioMarket.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTenSp.textAlignment = .left
        lbTenSp.textColor = UIColor.black
        lbTenSp.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTenSp.text = "Tên sp (*)"
        
        
        edtTenSp = UITextView(frame: CGRect(x: 15 , y: lbTenSp.frame.origin.y + lbTenSp.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:70)));
        
        edtTenSp.layer.cornerRadius = 5.0
        edtTenSp.layer.borderWidth = 1
        edtTenSp.layer.borderColor = UIColor(netHex:0xd3d3d3).cgColor
        edtTenSp.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        //edtTenSp.borderStyle = UITextBorderStyle.roundedRect
        edtTenSp.autocorrectionType = UITextAutocorrectionType.no
        edtTenSp.keyboardType = UIKeyboardType.default
        edtTenSp.returnKeyType = UIReturnKeyType.done
        edtTenSp.isEditable = false
        //edtTenSp.clearButtonMode = UITextFieldViewMode.whileEditing;
        //edtTenSp.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        //edtTenSp.isEnabled = false
        
        let lbHanBH = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtTenSp.frame.origin.y + edtTenSp.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHanBH.textAlignment = .left
        lbHanBH.textColor = UIColor.black
        lbHanBH.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHanBH.text = "Hạn BH (*)"
        
        
        edtHanBH = UITextField(frame: CGRect(x: 15 , y: lbHanBH.frame.origin.y + lbHanBH.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtHanBH.placeholder = "Nhập hạn bảo hành"
        edtHanBH.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtHanBH.borderStyle = UITextField.BorderStyle.roundedRect
        edtHanBH.autocorrectionType = UITextAutocorrectionType.no
        edtHanBH.keyboardType = UIKeyboardType.default
        edtHanBH.returnKeyType = UIReturnKeyType.done
        edtHanBH.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtHanBH.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtHanBH.isEnabled = false
        
        
        
        
        /////////////////////////////////////
        let lbImei2 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbImei2.textAlignment = .left
        lbImei2.textColor = UIColor.black
        lbImei2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbImei2.text = "Imei 2"
        
        
        edtImei2 = UITextField(frame: CGRect(x: 15 , y: lbImei2.frame.origin.y + lbImei2.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtImei2.placeholder = "Imei 2"
        edtImei2.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtImei2.borderStyle = UITextField.BorderStyle.roundedRect
        edtImei2.autocorrectionType = UITextAutocorrectionType.no
        edtImei2.keyboardType = UIKeyboardType.default
        edtImei2.returnKeyType = UIReturnKeyType.done
        edtImei2.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtImei2.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtImei2.isEnabled = false
        
        let lbHinhThucBH2 = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtImei2.frame.origin.y + edtImei2.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHinhThucBH2.textAlignment = .left
        lbHinhThucBH2.textColor = UIColor.black
        lbHinhThucBH2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHinhThucBH2.text = "Hình Thức BG"
        
        
        edtHinhThucBH2 = UITextField(frame: CGRect(x: 15 , y: lbHinhThucBH2.frame.origin.y + lbHinhThucBH2.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtHinhThucBH2.placeholder = "Hình Thức BG"
        edtHinhThucBH2.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtHinhThucBH2.borderStyle = UITextField.BorderStyle.roundedRect
        edtHinhThucBH2.autocorrectionType = UITextAutocorrectionType.no
        edtHinhThucBH2.keyboardType = UIKeyboardType.default
        edtHinhThucBH2.returnKeyType = UIReturnKeyType.done
        edtHinhThucBH2.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtHinhThucBH2.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtHinhThucBH2.isEnabled = false
        
        let lbTTBHHang = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtHinhThucBH2.frame.origin.y + edtHinhThucBH2.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTTBHHang.textAlignment = .left
        lbTTBHHang.textColor = UIColor.black
        lbTTBHHang.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTTBHHang.text = "TTBH Hãng"
        
        
        edtTTBHHang = UITextField(frame: CGRect(x: 15 , y: lbTTBHHang.frame.origin.y + lbTTBHHang.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtTTBHHang.placeholder = ""
        edtTTBHHang.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtTTBHHang.borderStyle = UITextField.BorderStyle.roundedRect
        edtTTBHHang.autocorrectionType = UITextAutocorrectionType.no
        edtTTBHHang.keyboardType = UIKeyboardType.default
        edtTTBHHang.returnKeyType = UIReturnKeyType.done
        edtTTBHHang.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtTTBHHang.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtTTBHHang.isEnabled = false
        
        
        let lbTTBHFRT = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtTTBHHang.frame.origin.y + edtTTBHHang.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTTBHFRT.textAlignment = .left
        lbTTBHFRT.textColor = UIColor.black
        lbTTBHFRT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTTBHFRT.text = "TTBH FRT"
        
        
        edtTTBHFRT = UITextField(frame: CGRect(x: 15 , y: lbTTBHFRT.frame.origin.y + lbTTBHFRT.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtTTBHFRT.placeholder = "Địa chỉ TTBH FRT"
        edtTTBHFRT.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtTTBHFRT.borderStyle = UITextField.BorderStyle.roundedRect
        edtTTBHFRT.autocorrectionType = UITextAutocorrectionType.no
        edtTTBHFRT.keyboardType = UIKeyboardType.default
        edtTTBHFRT.returnKeyType = UIReturnKeyType.done
        edtTTBHFRT.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtTTBHFRT.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtTTBHFRT.isEnabled = false
        
        
        lbDiaChiFRT = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtTTBHFRT.frame.origin.y + edtTTBHFRT.frame.size.height + Common.Size(s:5), width: edtTTBHFRT.frame.size.width , height: Common.Size(s:24)))
        lbDiaChiFRT.textAlignment = .left
        lbDiaChiFRT.textColor = UIColor.darkGray
        lbDiaChiFRT.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        lbDiaChiFRT.text = ""
        lbDiaChiFRT.numberOfLines = 2
        lbDiaChiFRT.lineBreakMode = .byWordWrapping
        

        let lbSoDH = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbDiaChiFRT.frame.origin.y + lbDiaChiFRT.frame.size.height + Common.Size(s:5), width: (scrollView.frame.size.width - Common.Size(s:30)) / 4, height: Common.Size(s:14)))
        lbSoDH.textAlignment = .left
        lbSoDH.textColor = UIColor.black
        lbSoDH.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoDH.text = "Số ĐH:"
        
        lbSoDHvalue = UILabel(frame: CGRect(x: Common.Size(s:15) + lbSoDH.frame.size.width , y: lbSoDH.frame.origin.y , width: (scrollView.frame.size.width - Common.Size(s:30)) / 4, height: Common.Size(s:14)))
        lbSoDHvalue.textAlignment = .left
        lbSoDHvalue.textColor = UIColor.red
        lbSoDHvalue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbSoDHvalue.text = "324324"
        
        let lbLoaiDH = UILabel(frame: CGRect(x:  lbSoDHvalue.frame.origin.x  + lbSoDH.frame.size.width , y: lbSoDHvalue.frame.origin.y , width: (scrollView.frame.size.width - Common.Size(s:50)) / 4, height: Common.Size(s:14)))
        lbLoaiDH.textAlignment = .left
        lbLoaiDH.textColor = UIColor.black
        lbLoaiDH.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLoaiDH.text = "Loại ĐH:"
        
        lbLoaiDHValue = UILabel(frame: CGRect(x:  lbLoaiDH.frame.origin.x  + lbLoaiDH.frame.size.width - Common.Size(s:18), y: lbLoaiDH.frame.origin.y, width: (scrollView.frame.size.width - Common.Size(s:30)) / 4, height: Common.Size(s:30)))
        lbLoaiDHValue.textAlignment = .left
        lbLoaiDHValue.textColor = UIColor.red
        lbLoaiDHValue.lineBreakMode = .byWordWrapping
        lbLoaiDHValue.numberOfLines = 0
        lbLoaiDHValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbLoaiDHValue.text = "trả góp"
        
        
        //////
        let lbNgayMua = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbLoaiDHValue.frame.origin.y + lbLoaiDHValue.frame.size.height + Common.Size(s:5), width: (scrollView.frame.size.width - Common.Size(s:30)) / 4, height: Common.Size(s:14)))
        lbNgayMua.textAlignment = .left
        lbNgayMua.textColor = UIColor.black
        lbNgayMua.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbNgayMua.text = "Ngày mua:"
        
        lbNgayMuaValue = UILabel(frame: CGRect(x: Common.Size(s:15) + lbSoDH.frame.size.width , y: lbNgayMua.frame.origin.y , width: (scrollView.frame.size.width - Common.Size(s:30)) / 4, height: Common.Size(s:14)))
        lbNgayMuaValue.textAlignment = .left
        lbNgayMuaValue.textColor = UIColor.red
        lbNgayMuaValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbNgayMuaValue.text = "14/12/2017"
        
        let lbShop = UILabel(frame: CGRect(x:  lbSoDHvalue.frame.origin.x  + lbSoDH.frame.size.width , y: lbNgayMuaValue.frame.origin.y , width: (scrollView.frame.size.width - Common.Size(s:50)) / 4, height: Common.Size(s:14)))
        lbShop.textAlignment = .left
        lbShop.textColor = UIColor.black
        lbShop.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbShop.text = "Shop:"
        
        lbShopValue = UILabel(frame: CGRect(x:  lbLoaiDH.frame.origin.x  + lbLoaiDH.frame.size.width - Common.Size(s:18) , y: lbShop.frame.origin.y, width: (scrollView.frame.size.width - Common.Size(s:30)) / 4, height: Common.Size(s:35)))
        lbShopValue.textAlignment = .left
        lbShopValue.textColor = UIColor.red
        //lbShopValue.backgroundColor = UIColor.yellow
        lbShopValue.lineBreakMode = .byWordWrapping
        lbShopValue.numberOfLines = 0
        lbShopValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbShopValue.text = "305"
        
        
        
        viewContent = UIView(frame: CGRect(x:0,y: edtHanBH.frame.origin.y + edtHanBH.frame.size.height + Common.Size(s:5) ,width:UIScreen.main.bounds.size.width , height: (lbImei2.frame.size.height + edtImei2.frame.size.height) * 5.5 + Common.Size(s:15)  ))
        viewContent.backgroundColor = UIColor(netHex:0xffffff)
        
        
        
        
        let strTitleDetails3 = "Xem thêm thông tin SP:"
        let sizeStrTitleDetails3: CGSize = strTitleDetails3.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:12))])
        txtXemThongTinSP = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width - 20 - sizeStrTitleDetails3.width, y: viewContent.frame.origin.y + viewContent.frame.size.height + Common.Size(s:10), width: sizeStrTitleDetails3.width, height: sizeStrTitleDetails.height))
        txtXemThongTinSP.textAlignment = .left
        txtXemThongTinSP.textColor = UIColor.red
        txtXemThongTinSP.font = UIFont.italicSystemFont(ofSize: Common.Size(s:12))
        
        let textRange3 = NSMakeRange(0, strTitleDetails3.count)
        let attributedText3 = NSMutableAttributedString(string: strTitleDetails3)
        attributedText3.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange3)
        // Add other attributes if needed
        txtXemThongTinSP.attributedText = attributedText3
        
        
        
        viewLogo = UIView(frame: CGRect(x: txtTitle.frame.origin.x,y: txtXemThongTinSP.frame.origin.y + txtXemThongTinSP.frame.size.height + Common.Size(s:5) ,width:UIScreen.main.bounds.size.width - Common.Size(s:30), height: (lbImei2.frame.size.height + edtImei2.frame.size.height) * 2  ))
        viewLogo.backgroundColor = UIColor(netHex:0xffffff)
        
        viewLogo.layer.borderWidth = 0.5
        viewLogo.layer.borderColor = UIColor(netHex:0x000000).cgColor
        
        imageViewLogoFPT = UIImageView(frame: CGRect(x: 0, y: 0, width: viewLogo.frame.width / 2, height: viewLogo.frame.height))
        imageViewLogoFPT.image = #imageLiteral(resourceName: "FPT_VIP")
        imageViewLogoFPT.contentMode = UIView.ContentMode.scaleAspectFit
        
        imageViewLogoKnox = UIImageView(frame: CGRect(x: 0, y: 0, width: viewLogo.frame.width / 2, height: viewLogo.frame.height))
        imageViewLogoKnox.image = #imageLiteral(resourceName: "Knox_Lock")
        imageViewLogoKnox.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        imageViewLogoSamsung = UIImageView(frame: CGRect(x: imageViewLogoFPT.frame.size.width, y: 0, width: viewLogo.frame.width / 2, height: viewLogo.frame.height))
        imageViewLogoSamsung.image = #imageLiteral(resourceName: "Samsung_Vip")
        imageViewLogoSamsung.contentMode = UIView.ContentMode.scaleAspectFit
        
        imageViewApple = UIImageView(frame: CGRect(x: imageViewLogoFPT.frame.size.width, y: 0, width: viewLogo.frame.width / 2, height: viewLogo.frame.height))
        imageViewApple.image = #imageLiteral(resourceName: "Apple_Vip")
        imageViewApple.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        ///////
        let strLienHe = "Thông tin liên hệ: "
        let sizeStrLienHe: CGSize = strLienHe.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:13))])
        let txtLienHe = UILabel(frame: CGRect(x: edtImei.frame.origin.x, y: 0, width: UIScreen.main.bounds.size.width , height: sizeStrLienHe.height))
        txtLienHe.textAlignment = .left
        txtLienHe.textColor = UIColor(netHex:0x000000)
        txtLienHe.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        txtLienHe.text = strLienHe
        
        
        
        let lbTenLienHe = UILabel(frame: CGRect(x: Common.Size(s:15), y: txtLienHe.frame.size.height + txtLienHe.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTenLienHe.textAlignment = .left
        lbTenLienHe.textColor = UIColor.black
        lbTenLienHe.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTenLienHe.text = "Tên (*)"
        
        
        edtTenLienHe = UITextField(frame: CGRect(x: 15 , y: lbTenLienHe.frame.origin.y + lbTenLienHe.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtTenLienHe.placeholder = "Tên khách hàng"
        edtTenLienHe.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtTenLienHe.borderStyle = UITextField.BorderStyle.roundedRect
        edtTenLienHe.autocorrectionType = UITextAutocorrectionType.no
        edtTenLienHe.keyboardType = UIKeyboardType.default
        edtTenLienHe.returnKeyType = UIReturnKeyType.done
        edtTenLienHe.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtTenLienHe.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        //edtTenLienHe.isEnabled = false
        
        
        let lbSDTLienHe = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtTenLienHe.frame.size.height + edtTenLienHe.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSDTLienHe.textAlignment = .left
        lbSDTLienHe.textColor = UIColor.black
        lbSDTLienHe.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSDTLienHe.text = "SDT (*)"
        
        
        edtSDTLienHe = UITextField(frame: CGRect(x: 15 , y: lbSDTLienHe.frame.origin.y + lbSDTLienHe.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtSDTLienHe.placeholder = "SDT khách hàng"
        edtSDTLienHe.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtSDTLienHe.borderStyle = UITextField.BorderStyle.roundedRect
        edtSDTLienHe.autocorrectionType = UITextAutocorrectionType.no
        edtSDTLienHe.keyboardType = UIKeyboardType.numberPad
        edtSDTLienHe.returnKeyType = UIReturnKeyType.done
        edtSDTLienHe.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtSDTLienHe.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        //edtSDTLienHe.isEnabled = false
        /////////
        let lbSDTLienHeKhac = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtSDTLienHe.frame.size.height + edtSDTLienHe.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSDTLienHeKhac.textAlignment = .left
        lbSDTLienHeKhac.textColor = UIColor.black
        lbSDTLienHeKhac.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSDTLienHeKhac.text = "SĐT khác"
        
        
        edtSDTLienHeKhac = UITextField(frame: CGRect(x: 15 , y: lbSDTLienHeKhac.frame.origin.y + lbSDTLienHeKhac.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtSDTLienHeKhac.placeholder = "SDT đang lắp trên máy đi BH"
        edtSDTLienHeKhac.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtSDTLienHeKhac.borderStyle = UITextField.BorderStyle.roundedRect
        edtSDTLienHeKhac.autocorrectionType = UITextAutocorrectionType.no
        edtSDTLienHeKhac.keyboardType = UIKeyboardType.numberPad
        edtSDTLienHeKhac.returnKeyType = UIReturnKeyType.done
        edtSDTLienHeKhac.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtSDTLienHeKhac.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        /////////
        let lbEmailLienHe = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtSDTLienHeKhac.frame.size.height + edtSDTLienHeKhac.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbEmailLienHe.textAlignment = .left
        lbEmailLienHe.textColor = UIColor.black
        lbEmailLienHe.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbEmailLienHe.text = "Email (*)"
        
        
        edtMailLienHe = UITextField(frame: CGRect(x: 15 , y: lbEmailLienHe.frame.origin.y + lbEmailLienHe.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtMailLienHe.placeholder = "Email khách hàng"
        edtMailLienHe.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtMailLienHe.borderStyle = UITextField.BorderStyle.roundedRect
        edtMailLienHe.autocorrectionType = UITextAutocorrectionType.no
        edtMailLienHe.keyboardType = UIKeyboardType.default
        edtMailLienHe.returnKeyType = UIReturnKeyType.done
        edtMailLienHe.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtMailLienHe.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        ////////
        
        let lbDiaChiLienHe = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtMailLienHe.frame.size.height + edtMailLienHe.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbDiaChiLienHe.textAlignment = .left
        lbDiaChiLienHe.textColor = UIColor.black
        lbDiaChiLienHe.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbDiaChiLienHe.text = "Địa chỉ(*)"
        
        
        edtDiaChiLienHe = UITextField(frame: CGRect(x: 15 , y: lbDiaChiLienHe.frame.origin.y + lbDiaChiLienHe.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtDiaChiLienHe.placeholder = "Địa chỉ khách hàng"
        edtDiaChiLienHe.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtDiaChiLienHe.borderStyle = UITextField.BorderStyle.roundedRect
        edtDiaChiLienHe.autocorrectionType = UITextAutocorrectionType.no
        edtDiaChiLienHe.keyboardType = UIKeyboardType.default
        edtDiaChiLienHe.returnKeyType = UIReturnKeyType.done
        edtDiaChiLienHe.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtDiaChiLienHe.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        
        lbGhiChuLienHe = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtDiaChiLienHe.frame.size.height + edtDiaChiLienHe.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbGhiChuLienHe.textAlignment = .left
        lbGhiChuLienHe.textColor = UIColor.black
        lbGhiChuLienHe.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbGhiChuLienHe.text = "Ghi Chú (*)"
        
        
        edtGhiChuLienHe = UITextField(frame: CGRect(x: 15 , y: lbGhiChuLienHe.frame.origin.y + lbGhiChuLienHe.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40) * 2));
        edtGhiChuLienHe.placeholder = "Ghi chú"
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
        btnHoanTat.setTitle("Tiếp tục",for: .normal)
        btnHoanTat.setTitleColor(UIColor.white, for: .normal)
        
        viewBottom = UIView(frame: CGRect(x:0,y: txtXemThongTinSP.frame.origin.y + txtXemThongTinSP.frame.size.height + Common.Size(s:5) ,width:UIScreen.main.bounds.size.width , height: (lbImei2.frame.size.height + edtImei2.frame.size.height) * 8  ))
        viewBottom.backgroundColor = UIColor(netHex:0xffffff)
        
        
        imageViewLogoFPT.isHidden = true
        imageViewLogoSamsung.isHidden = true
        imageViewApple.isHidden = true
        imageViewLogoKnox.isHidden = true
        
        addSubview(scrollView)
        scrollView.addSubview(lbLoaiBH)
        scrollView.addSubview(edtImei)
        scrollView.addSubview(txtTitleDetails)
        scrollView.addSubview(txtTitleScan)
        scrollView.addSubview(txtTitle)
        scrollView.addSubview(lbImei)
        scrollView.addSubview(loaiBHButton)
        scrollView.addSubview(lbHinhThucBH)
        
        scrollView.addSubview(hinhthucBHButton)
        scrollView.addSubview(imageBHButton)
        scrollView.addSubview(txtSP)
        scrollView.addSubview(edtMaSp)
        scrollView.addSubview(lbMaSP)
        scrollView.addSubview(txtChonMaSP)
        scrollView.addSubview(radioMarket)
        scrollView.addSubview(lbTenSp)
        scrollView.addSubview(edtTenSp)
        scrollView.addSubview(lbHanBH)
        scrollView.addSubview(edtHanBH)
        scrollView.addSubview(viewContent)
        viewContent.addSubview(lbImei2)
        viewContent.addSubview(edtImei2)
        viewContent.addSubview(lbHinhThucBH2)
        viewContent.addSubview(edtHinhThucBH2)
        
        viewContent.addSubview(lbTTBHHang)
        viewContent.addSubview(edtTTBHHang)
        viewContent.addSubview(lbTTBHFRT)
        viewContent.addSubview(edtTTBHFRT)
        viewContent.addSubview(lbSoDH)
        viewContent.addSubview(lbDiaChiFRT)
        viewContent.addSubview(lbSoDHvalue)
        viewContent.addSubview(lbLoaiDH)
        viewContent.addSubview(lbLoaiDHValue)
        
        viewContent.addSubview(lbNgayMua)
        viewContent.addSubview(lbNgayMuaValue)
        viewContent.addSubview(lbShop)
        viewContent.addSubview(lbShopValue)
        
        scrollView.addSubview(txtXemThongTinSP)
        scrollView.addSubview(viewLogo)
        scrollView.addSubview(viewBottom)
        viewBottom.addSubview(txtLienHe)
        viewBottom.addSubview(lbTenLienHe)
        viewBottom.addSubview(edtTenLienHe)
        viewBottom.addSubview(edtSDTLienHe)
        viewBottom.addSubview(lbSDTLienHe)
        viewBottom.addSubview(edtSDTLienHeKhac)
        viewBottom.addSubview(lbSDTLienHeKhac)
        
        viewBottom.addSubview(edtMailLienHe)
        viewBottom.addSubview(lbEmailLienHe)
        
        
        viewBottom.addSubview(lbDiaChiLienHe)
        viewBottom.addSubview(edtDiaChiLienHe)
        viewBottom.addSubview(lbGhiChuLienHe)
        viewBottom.addSubview(edtGhiChuLienHe)
        viewBottom.addSubview(btnHoanTat)
        
        viewBottom.frame.size.height = btnHoanTat.frame.origin.y + btnHoanTat.frame.size.height
        
        viewLogo.addSubview(imageViewLogoFPT)
        viewLogo.addSubview(imageViewLogoSamsung)
        viewLogo.addSubview(imageViewApple)
        viewLogo.addSubview(imageViewLogoKnox)
        //        viewContent.backgroundColor = .yellow
        
        //scrollView.contentSize = btnHoanTat.frame.origin.y + 300
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewBottom.frame.origin.y + viewBottom.frame.size.height + Common.Size(s: 20))
        //        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: lbLoaiBH.frame.size.height + edtImei.frame.size.height + txtTitleDetails.frame.size.height + txtTitle.frame.size.height + lbImei.frame.size.height + loaiBHButton.frame.size.height + lbHinhThucBH.frame.size.height + hinhthucBHButton.frame.size.height + txtSP.frame.size.height + edtMaSp.frame.size.height + lbMaSP.frame.size.height + txtChonMaSP.frame.size.height + radioMarket.frame.size.height + lbTenSp.frame.size.height + edtTenSp.frame.size.height + lbHanBH.frame.size.height + edtHanBH.frame.size.height + viewContent.frame.size.height + viewLogo.frame.size.height + viewBottom.frame.size.height + 300)
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
        
        radioButton.isIconSquare = true;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(self.logSelectedButtonBonus), for: UIControl.Event.touchUpInside);
        
        
        return radioButton;
    }
    
    
    @objc @IBAction fileprivate func logSelectedButtonBonus(_ radioButton : DLRadioButton) {
        
        
        
        if(isChoose == false)
        {
            radioButton.isSelected = true
            isChoose = true
        }
        else
        {
            radioButton.isSelected = false
            isChoose = false
        }
        
        print("selected \(radioButton.isSelected)")
        
        
        
    }
}
