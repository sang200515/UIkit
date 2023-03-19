//
//  SimUpdateVNMViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 8/5/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import DLRadioButton
//import EPSignature
struct CustomerVNM{
    var code:String
    var value:String
    
    init(code:String,value:String){
        self.code = code
        self.value = value
    }
}
class SimUpdateVNMViewController: UIViewController,UITextFieldDelegate,EPSignatureDelegate {
    
    var scrollView:UIScrollView!
    var viewUpload:UIView!
    var viewInfoCustomer:UIView!
    var vỉewAvartaSign:UIView!
    var viewOTP:UIView!
    
    var viewImageCMNDFront:UIView!
    var imgViewImageCMNDFront:UIImageView!
    
    var viewImageCMNDBehind:UIView!
    var imgViewImageCMNDBehind:UIImageView!
    
    var viewImageAvarta:UIView!
    var imgViewAvarta:UIImageView!
    
    var viewImageSign:UIView!
    var imgViewSign: UIImageView!
    
    
    var btCreateOrder:UIButton!
    var btUpdate:UIButton!
    var lbTextThongTinKH:UILabel!
    var tfHoKhachHang:UITextField!
    var tfTenKhachHang:UITextField!
    var lbGenderText:UILabel!
    var radioMan:DLRadioButton!
    var radioWoman:DLRadioButton!
    var genderType:Int = -1
    var lblBirthday:UILabel!
    var tfUserBirthday:UITextField!
    var lblDiaChi:UILabel!
    var tfDiaChi:UITextField!
    var lblPhuongXa:UILabel!
    var tfPhuongXa:UITextField!
    var lblQuanHuyen:UILabel!
    
    var lblTinhThanhPho:UILabel!
    
    var lblCMND:UILabel!
    var tfCMND:UITextField!
    var lblNgayCap:UILabel!
    var tfNgayCap:UITextField!
    var lblNoiCap:UILabel!
    var lblQuocTich:UILabel!
    var tfQuocTich:UITextField!
    
    
    
    var listProvices:[Province] = []
    var listDistricts:[District] = []
    var listPrecincts:[Precinct] = []
    
    
    var selectProvice:String = ""
    var selectDistrict:String = ""
    var selectPrecinct:String = ""
    var selectAddressCMND:String = ""
    
    var tfCreateAddress:SearchTextField!
    var cityButton: SearchTextField!
    var districtButton: SearchTextField!
    var wardsButton: SearchTextField!
    
    var lbTextCMNDTruoc:UILabel!
    var viewCMNDTruocButton:UIImageView!
    var lbCMNDTruocButton:UILabel!
    let lstTypeCustomer:[CustomerVNM] = [CustomerVNM(code:"CN01",value:"Cho bản thân"),
                                         CustomerVNM(code:"CN02",value:"Cho người được giám hộ"),
                                         CustomerVNM(code:"CN03",value:"Cho thiết bị thuộc cá nhân"),
                                         CustomerVNM(code:"TC01",value:"Cho các cá nhân thuộc tổ chức"),
                                         CustomerVNM(code:"TC02",value:"Cho thiết bị thuộc tổ chức")]
    let lstTypeIndentify:[CustomerVNM] = [CustomerVNM(code:"01",value:"Chứng minh thư"),
                                          CustomerVNM(code:"02",value:"Hộ chiếu"),
                                          CustomerVNM(code:"03",value:"Thẻ căn cước")]
    var selectLoaiTB:String = ""
    var selectTypeCustomer:String = ""
    var selectTypeIndentify:String = ""
    var tfTypeCustomer:SearchTextField!
    var tfTypeIndentify:SearchTextField!
    var radioTraTruoc:DLRadioButton!
    var radioTraSau:DLRadioButton!
    var infoActiveSimByPhone:InfoActiveSimbyPhone?
    var tfMaOTP:UITextField!
    var labelTitleAvarta:UILabel!
    var labelTitleSign:UILabel!
    var labelInfoCustomer:UILabel!
    var posImageUpload:Int = 0
    var imagePicker = UIImagePickerController()
    var imgViewSignature: UIImageView!
    override func viewDidLoad() {
        self.title = "Cập nhật thông tin thuê bao"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(SimUpdateVNMViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
        //right menu icon
        let btRightIcon = UIButton.init(type: .custom)
        
        btRightIcon.setImage(#imageLiteral(resourceName: "update"),for: UIControl.State.normal)
        btRightIcon.imageView?.contentMode = .scaleAspectFit
        btRightIcon.addTarget(self, action: #selector(SimUpdateVNMViewController.loadHistoryUpdatePhone), for: UIControl.Event.touchUpInside)
        btRightIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barRight = UIBarButtonItem(customView: btRightIcon)
        
        self.navigationItem.rightBarButtonItem = barRight
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        
        let label = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label.text = "HÌNH ẢNH CMND/CĂN CƯỚC KHÁCH HÀNG"
        label.textColor = UIColor(netHex:0x00955E)
        label.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label)
        
        
        viewUpload = UIView()
        viewUpload.frame = CGRect(x: 0, y: label.frame.size.height + label.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewUpload.backgroundColor = UIColor.white
        scrollView.addSubview(viewUpload)
        
        viewImageCMNDFront = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: 0))
        viewImageCMNDFront.clipsToBounds = true
        viewUpload.addSubview(viewImageCMNDFront)
        
        let lbTextImageCMNDFront = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbTextImageCMNDFront.textAlignment = .left
        lbTextImageCMNDFront.textColor = UIColor.black
        lbTextImageCMNDFront.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextImageCMNDFront.text = "CMND mặt trước (*)"
        lbTextImageCMNDFront.sizeToFit()
        viewImageCMNDFront.addSubview(lbTextImageCMNDFront)
        
        imgViewImageCMNDFront = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: lbTextImageCMNDFront.frame.origin.y + lbTextImageCMNDFront.frame.size.height + Common.Size(s:5), width: viewImageCMNDFront.frame.size.width - Common.Size(s:30), height: (viewImageCMNDFront.frame.size.width - Common.Size(s:30)) / 2.6))
        imgViewImageCMNDFront.image = UIImage(named:"UploadImage")
        imgViewImageCMNDFront.contentMode = .scaleAspectFit
        viewImageCMNDFront.addSubview(imgViewImageCMNDFront)
        viewImageCMNDFront.frame.size.height = imgViewImageCMNDFront.frame.origin.y + imgViewImageCMNDFront.frame.size.height
        viewImageCMNDFront.tag = 1
        let tapShowImageCMNDFront = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImageCMNDFront))
        viewImageCMNDFront.isUserInteractionEnabled = true
        viewImageCMNDFront.addGestureRecognizer(tapShowImageCMNDFront)
        
        
        viewImageCMNDBehind = UIView(frame: CGRect(x: 0, y: viewImageCMNDFront.frame.size.height + viewImageCMNDFront.frame.origin.y, width: scrollView.frame.size.width, height: 0))
        viewImageCMNDBehind.clipsToBounds = true
        viewUpload.addSubview(viewImageCMNDBehind)
        
        let lbTextImageCMNDBehind = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbTextImageCMNDBehind.textAlignment = .left
        lbTextImageCMNDBehind.textColor = UIColor.black
        lbTextImageCMNDBehind.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextImageCMNDBehind.text = "CMND mặt sau (*)"
        lbTextImageCMNDBehind.sizeToFit()
        viewImageCMNDBehind.addSubview(lbTextImageCMNDBehind)
        
        imgViewImageCMNDBehind = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: lbTextImageCMNDBehind.frame.origin.y + lbTextImageCMNDBehind.frame.size.height + Common.Size(s:5), width: viewImageCMNDFront.frame.size.width - Common.Size(s:30), height: (viewImageCMNDFront.frame.size.width - Common.Size(s:30)) / 2.6))
        imgViewImageCMNDBehind.image = UIImage(named:"UploadImage")
        imgViewImageCMNDBehind.contentMode = .scaleAspectFit
        viewImageCMNDBehind.addSubview(imgViewImageCMNDBehind)
        viewImageCMNDBehind.frame.size.height = imgViewImageCMNDBehind.frame.origin.y + imgViewImageCMNDBehind.frame.size.height
        viewImageCMNDBehind.tag = 1
        let tapShowImageCMNDBehind = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImageBehind))
        viewImageCMNDBehind.isUserInteractionEnabled = true
        viewImageCMNDBehind.addGestureRecognizer(tapShowImageCMNDBehind)
        
        viewUpload.frame.size.height = viewImageCMNDBehind.frame.size.height + viewImageCMNDBehind.frame.origin.y + Common.Size(s: 10)
        
        
        labelInfoCustomer = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewUpload.frame.size.height + viewUpload.frame.origin.y , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelInfoCustomer.text = "THÔNG TIN KHÁCH HÀNG"
        labelInfoCustomer.textColor = UIColor(netHex:0x00955E)
        labelInfoCustomer.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(labelInfoCustomer)
        
        
        viewInfoCustomer = UIView()
        viewInfoCustomer.frame = CGRect(x: 0, y: labelInfoCustomer.frame.size.height + labelInfoCustomer.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewInfoCustomer.backgroundColor = UIColor.white
        scrollView.addSubview(viewInfoCustomer)
        
        
        
        let lblNhapHo =  UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNhapHo.textAlignment = .left
        lblNhapHo.textColor = UIColor.black
        lblNhapHo.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNhapHo.text = "Nhập họ khách hàng"
        viewInfoCustomer.addSubview(lblNhapHo)
        
        
        
        tfHoKhachHang = UITextField(frame: CGRect(x: lblNhapHo.frame.origin.x, y: lblNhapHo.frame.origin.y + lblNhapHo.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfHoKhachHang.placeholder = "Nhập họ VD: Trần"
        tfHoKhachHang.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHoKhachHang.borderStyle = UITextField.BorderStyle.roundedRect
        tfHoKhachHang.autocorrectionType = UITextAutocorrectionType.no
        tfHoKhachHang.keyboardType = UIKeyboardType.default
        tfHoKhachHang.returnKeyType = UIReturnKeyType.done
        tfHoKhachHang.clearButtonMode = UITextField.ViewMode.whileEditing
        tfHoKhachHang.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHoKhachHang.delegate = self
        //tfUserName.addTarget(self, action: #selector(textFieldDidChangeName(_:)), for: .editingChanged)
        tfHoKhachHang.text = Cache.name
        viewInfoCustomer.addSubview(tfHoKhachHang)
        
        tfHoKhachHang.leftViewMode = UITextField.ViewMode.always
        let imageUserHo = UIImageView(frame: CGRect(x: tfHoKhachHang.frame.size.height/4, y: tfHoKhachHang.frame.size.height/4, width: tfHoKhachHang.frame.size.height/2, height: tfHoKhachHang.frame.size.height/2))
        imageUserHo.image = UIImage(named: "User-50")
        imageUserHo.contentMode = UIView.ContentMode.scaleAspectFit
        let leftViewUserHo = UIView()
        leftViewUserHo.addSubview(imageUserHo)
        leftViewUserHo.frame = CGRect(x: 0, y: 0, width: tfHoKhachHang.frame.size.height, height: tfHoKhachHang.frame.size.height)
        tfHoKhachHang.leftView = leftViewUserHo
        //input ten khach hang
        let lblNhapTen =  UILabel(frame: CGRect(x: lblNhapHo.frame.origin.x, y: tfHoKhachHang.frame.origin.y + tfHoKhachHang.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNhapTen.textAlignment = .left
        lblNhapTen.textColor = UIColor.black
        lblNhapTen.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNhapTen.text = "Nhập tên khách hàng"
        viewInfoCustomer.addSubview(lblNhapTen)
        
        
        
        tfTenKhachHang = UITextField(frame: CGRect(x: lblNhapHo.frame.origin.x, y: lblNhapTen.frame.origin.y + lblNhapTen.frame.size.height + Common.Size(s:10), width: tfHoKhachHang.frame.size.width , height: Common.Size(s:40)));
        tfTenKhachHang.placeholder = "Nhập tên VD: Thị Kim Phương"
        tfTenKhachHang.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTenKhachHang.borderStyle = UITextField.BorderStyle.roundedRect
        tfTenKhachHang.autocorrectionType = UITextAutocorrectionType.no
        tfTenKhachHang.keyboardType = UIKeyboardType.default
        tfTenKhachHang.returnKeyType = UIReturnKeyType.done
        tfTenKhachHang.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTenKhachHang.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTenKhachHang.delegate = self
        //tfUserName.addTarget(self, action: #selector(textFieldDidChangeName(_:)), for: .editingChanged)
        tfTenKhachHang.text = Cache.name
        viewInfoCustomer.addSubview(tfTenKhachHang)
        
        tfTenKhachHang.leftViewMode = UITextField.ViewMode.always
        let imageUserTen = UIImageView(frame: CGRect(x: tfTenKhachHang.frame.size.height/4, y: tfTenKhachHang.frame.size.height/4, width: tfTenKhachHang.frame.size.height/2, height: tfTenKhachHang.frame.size.height/2))
        imageUserTen.image = UIImage(named: "User-50")
        imageUserTen.contentMode = UIView.ContentMode.scaleAspectFit
        let leftViewUserTen = UIView()
        leftViewUserTen.addSubview(imageUserTen)
        leftViewUserTen.frame = CGRect(x: 0, y: 0, width: tfTenKhachHang.frame.size.height, height: tfTenKhachHang.frame.size.height)
        tfTenKhachHang.leftView = leftViewUserTen
        
        
        // choose gioi tinh
        
        let lbGenderText = UILabel(frame: CGRect(x: lblNhapHo.frame.origin.x, y: tfTenKhachHang.frame.origin.y + tfTenKhachHang.frame.size.height + Common.Size(s:10), width: tfTenKhachHang.frame.size.width, height: Common.Size(s:25)))
        lbGenderText.textAlignment = .left
        lbGenderText.textColor = UIColor.black
        lbGenderText.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbGenderText.text = "Giới tính"
        viewInfoCustomer.addSubview(lbGenderText)
        
        radioMan = createRadioButtonGender(CGRect(x: lbGenderText.frame.origin.x,y:lbGenderText.frame.origin.y + lbGenderText.frame.size.height + Common.Size(s:5) , width: lbGenderText.frame.size.width/3, height: Common.Size(s:20)), title: "Nam", color: UIColor.black);
        viewInfoCustomer.addSubview(radioMan)
        
        radioWoman = createRadioButtonGender(CGRect(x: radioMan.frame.origin.x + radioMan.frame.size.width ,y:radioMan.frame.origin.y, width: radioMan.frame.size.width, height: radioMan.frame.size.height), title: "Nữ", color: UIColor.black);
        viewInfoCustomer.addSubview(radioWoman)
        
        if (Cache.genderType == 1){
            radioMan.isSelected = true
            genderType = 1
        }else if (Cache.genderType == 0){
            radioWoman.isSelected = true
            genderType = 0
        }else{
            radioMan.isSelected = false
            radioWoman.isSelected = false
            genderType = -1
        }
        // input ngay sinh
        lblBirthday =  UILabel(frame: CGRect(x: lblNhapHo.frame.origin.x, y: radioMan.frame.origin.y + radioMan.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblBirthday.textAlignment = .left
        lblBirthday.textColor = UIColor.black
        lblBirthday.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBirthday.text = "Nhập ngày sinh khách hàng"
        viewInfoCustomer.addSubview(lblBirthday)
        
        
        
        tfUserBirthday = UITextField(frame: CGRect(x: lblNhapHo.frame.origin.x, y: lblBirthday.frame.origin.y + lblBirthday.frame.size.height + Common.Size(s:10), width: tfHoKhachHang.frame.size.width  , height: Common.Size(s:40)));
        tfUserBirthday.placeholder = "Ngày sinh"
        
        tfUserBirthday.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfUserBirthday.borderStyle = UITextField.BorderStyle.roundedRect
        tfUserBirthday.autocorrectionType = UITextAutocorrectionType.no
        tfUserBirthday.keyboardType = UIKeyboardType.numbersAndPunctuation
        tfUserBirthday.returnKeyType = UIReturnKeyType.done
        tfUserBirthday.clearButtonMode = UITextField.ViewMode.whileEditing
        tfUserBirthday.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfUserBirthday.delegate = self
        viewInfoCustomer.addSubview(tfUserBirthday)
        //tfUserBirthday.addTarget(self, action: #selector(textFieldDidChangeBirthday(_:)), for: .editingChanged)
        tfUserBirthday.text = Cache.vlBirthday
        
        tfUserBirthday.leftViewMode = UITextField.ViewMode.always
        let imageBirthday = UIImageView(frame: CGRect(x: tfUserBirthday.frame.size.height/4, y: tfUserBirthday.frame.size.height/4, width: tfUserBirthday.frame.size.height/2, height: tfUserBirthday.frame.size.height/2))
        imageBirthday.image = UIImage(named: "Gift Card-50")
        imageBirthday.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewBirthday = UIView()
        leftViewBirthday.addSubview(imageBirthday)
        leftViewBirthday.frame = CGRect(x: 0, y: 0, width: tfUserBirthday.frame.size.height, height: tfUserBirthday.frame.size.height)
        tfUserBirthday.leftView = leftViewBirthday
        //input Dia Chi khach hang
        lblDiaChi =  UILabel(frame: CGRect(x: lblNhapHo.frame.origin.x, y: tfUserBirthday.frame.origin.y + tfUserBirthday.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblDiaChi.textAlignment = .left
        lblDiaChi.textColor = UIColor.black
        lblDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDiaChi.text = "Nhập địa chỉ khách hàng"
        viewInfoCustomer.addSubview(lblDiaChi)
        
        tfDiaChi = UITextField(frame: CGRect(x: lblNhapHo.frame.origin.x, y: lblDiaChi.frame.origin.y + lblDiaChi.frame.size.height + Common.Size(s:10), width: tfHoKhachHang.frame.size.width  , height: Common.Size(s:40)));
        tfDiaChi.placeholder = "Địa chỉ"
        
        tfDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDiaChi.borderStyle = UITextField.BorderStyle.roundedRect
        tfDiaChi.autocorrectionType = UITextAutocorrectionType.no
        tfDiaChi.keyboardType = UIKeyboardType.default
        tfDiaChi.returnKeyType = UIReturnKeyType.done
        tfDiaChi.clearButtonMode = UITextField.ViewMode.whileEditing
        tfDiaChi.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDiaChi.delegate = self
        viewInfoCustomer.addSubview(tfDiaChi)
        //tfUserBirthday.addTarget(self, action: #selector(textFieldDidChangeBirthday(_:)), for: .editingChanged)
        tfDiaChi.text = Cache.vlBirthday
        
        tfDiaChi.leftViewMode = UITextField.ViewMode.always
        let imageDiaChi = UIImageView(frame: CGRect(x: tfDiaChi.frame.size.height/4, y: tfDiaChi.frame.size.height/4, width: tfDiaChi.frame.size.height/2, height: tfDiaChi.frame.size.height/2))
        imageDiaChi.image = UIImage(named: "Home-50-2")
        imageDiaChi.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewDiaChi = UIView()
        leftViewDiaChi.addSubview(imageDiaChi)
        leftViewDiaChi.frame = CGRect(x: 0, y: 0, width: tfDiaChi.frame.size.height, height: tfDiaChi.frame.size.height)
        tfDiaChi.leftView = leftViewDiaChi
        
        //input tinh thanh pho
        lblTinhThanhPho =  UILabel(frame: CGRect(x: lblNhapHo.frame.origin.x, y: tfDiaChi.frame.origin.y + tfDiaChi.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTinhThanhPho.textAlignment = .left
        lblTinhThanhPho.textColor = UIColor.black
        lblTinhThanhPho.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTinhThanhPho.text = "Nhập Tỉnh/Thành Phố"
        viewInfoCustomer.addSubview(lblTinhThanhPho)
        
        cityButton = SearchTextField(frame: CGRect(x: lblNhapHo.frame.origin.x, y: lblTinhThanhPho.frame.origin.y + lblTinhThanhPho.frame.size.height + Common.Size(s:10), width: tfHoKhachHang.frame.size.width  , height: Common.Size(s:40) ));
        
        cityButton.placeholder = "Tỉnh/Thành phố"
        cityButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        cityButton.borderStyle = UITextField.BorderStyle.roundedRect
        cityButton.autocorrectionType = UITextAutocorrectionType.no
        cityButton.keyboardType = UIKeyboardType.default
        cityButton.returnKeyType = UIReturnKeyType.done
        cityButton.clearButtonMode = UITextField.ViewMode.whileEditing
        cityButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        cityButton.delegate = self
        viewInfoCustomer.addSubview(cityButton)
        
        // Start visible - Default: false
        cityButton.startVisible = true
        cityButton.theme.bgColor = UIColor.white
        cityButton.theme.fontColor = UIColor.black
        cityButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        cityButton.theme.cellHeight = Common.Size(s:40)
        cityButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        cityButton.leftViewMode = UITextField.ViewMode.always
        let imageButton = UIImageView(frame: CGRect(x: tfHoKhachHang.frame.size.height/4, y: tfHoKhachHang.frame.size.height/4, width: tfHoKhachHang.frame.size.height/2, height: tfHoKhachHang.frame.size.height/2))
        imageButton.image = UIImage(named: "City-50")
        imageButton.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewCityButton = UIView()
        leftViewCityButton.addSubview(imageButton)
        leftViewCityButton.frame = CGRect(x: 0, y: 0, width: cityButton.frame.size.height, height: cityButton.frame.size.height)
        cityButton.leftView = leftViewCityButton
        
        cityButton.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.cityButton.text = item.title
            
            self.selectDistrict = ""
            self.districtButton.text = ""
            
            self.selectPrecinct = ""
            self.wardsButton.text = ""
            
            let obj =  self.listProvices.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectProvice = "\(obj)"
                MPOSAPIManager.GetDistricts(MaCodeTinh: "\(obj)", NhaMang: "Vietnammobile", handler: { (results, error) in
                    self.listDistricts = results
                    var listDistrictTemp:[String] = []
                    for item in results {
                        listDistrictTemp.append(item.Text)
                    }
                    self.districtButton.filterStrings(listDistrictTemp)
                })
            }
        }
        
        //input Quan Huyen
        lblQuanHuyen =  UILabel(frame: CGRect(x: lblNhapHo.frame.origin.x, y: cityButton.frame.origin.y + cityButton.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblQuanHuyen.textAlignment = .left
        lblQuanHuyen.textColor = UIColor.black
        lblQuanHuyen.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblQuanHuyen.text = "Nhập quận/huyện"
        viewInfoCustomer.addSubview(lblQuanHuyen)
        
        districtButton = SearchTextField(frame: CGRect(x: lblNhapHo.frame.origin.x, y: lblQuanHuyen.frame.origin.y + lblQuanHuyen.frame.size.height + Common.Size(s:10),  width: tfHoKhachHang.frame.size.width , height: Common.Size(s:40)));
        districtButton.placeholder = "Quận/Huyện"
        districtButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        districtButton.borderStyle = UITextField.BorderStyle.roundedRect
        districtButton.autocorrectionType = UITextAutocorrectionType.no
        districtButton.keyboardType = UIKeyboardType.default
        districtButton.returnKeyType = UIReturnKeyType.done
        districtButton.clearButtonMode = UITextField.ViewMode.whileEditing
        districtButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        districtButton.delegate = self
        viewInfoCustomer.addSubview(districtButton)
        
        // Start visible - Default: false
        districtButton.startVisible = true
        districtButton.theme.bgColor = UIColor.white
        districtButton.theme.fontColor = UIColor.black
        districtButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        districtButton.theme.cellHeight = Common.Size(s:40)
        districtButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        districtButton.leftViewMode = UITextField.ViewMode.always
        let imageButtonDistrict = UIImageView(frame: CGRect(x: tfHoKhachHang.frame.size.height/4, y: tfHoKhachHang.frame.size.height/4, width: tfHoKhachHang.frame.size.height/2, height: tfHoKhachHang.frame.size.height/2))
        imageButtonDistrict.image = UIImage(named: "German House-50")
        imageButtonDistrict.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewDistrictButton = UIView()
        leftViewDistrictButton.addSubview(imageButtonDistrict)
        leftViewDistrictButton.frame = CGRect(x: 0, y: 0, width: districtButton.frame.size.height, height: districtButton.frame.size.height)
        districtButton.leftView = leftViewDistrictButton
        
        districtButton.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.districtButton.text = item.title
            let obj =  self.listDistricts.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectDistrict = "\(obj)"
                self.selectPrecinct = ""
                self.wardsButton.text = ""
            }
        }
        
        //input phuong xa
        lblPhuongXa =  UILabel(frame: CGRect(x: lblNhapHo.frame.origin.x, y: districtButton.frame.origin.y + districtButton.frame.size.height + Common.Size(s:20), width: tfHoKhachHang.frame.size.width , height: Common.Size(s:14)))
        lblPhuongXa.textAlignment = .left
        lblPhuongXa.textColor = UIColor.black
        lblPhuongXa.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPhuongXa.text = "Nhập phường/xã"
        viewInfoCustomer.addSubview(lblPhuongXa)
        
        wardsButton = SearchTextField(frame: CGRect(x: lblNhapHo.frame.origin.x, y: lblPhuongXa.frame.origin.y + lblPhuongXa.frame.size.height + Common.Size(s:10), width: tfHoKhachHang.frame.size.width, height: Common.Size(s:40) ));
        wardsButton.placeholder = "Phường/Xã"
        wardsButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        wardsButton.borderStyle = UITextField.BorderStyle.roundedRect
        wardsButton.autocorrectionType = UITextAutocorrectionType.no
        wardsButton.keyboardType = UIKeyboardType.default
        wardsButton.returnKeyType = UIReturnKeyType.done
        wardsButton.clearButtonMode = UITextField.ViewMode.whileEditing
        wardsButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        wardsButton.delegate = self
        viewInfoCustomer.addSubview(wardsButton)
        
        // Start visible - Default: false
        wardsButton.startVisible = true
        wardsButton.theme.bgColor = UIColor.white
        wardsButton.theme.fontColor = UIColor.black
        wardsButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        wardsButton.theme.cellHeight = Common.Size(s:40)
        wardsButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        wardsButton.leftViewMode = UITextField.ViewMode.always
        let imageButtonWards = UIImageView(frame: CGRect(x: tfTenKhachHang.frame.size.height/4, y: tfTenKhachHang.frame.size.height/4, width: tfTenKhachHang.frame.size.height/2, height: tfTenKhachHang.frame.size.height/2))
        imageButtonWards.image = UIImage(named: "Visit-50")
        imageButtonWards.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewWardsButton = UIView()
        leftViewWardsButton.addSubview(imageButtonWards)
        leftViewWardsButton.frame = CGRect(x: 0, y: 0, width: wardsButton.frame.size.height, height: wardsButton.frame.size.height)
        wardsButton.leftView = leftViewWardsButton
        wardsButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.wardsButton.text = item.title
            let obj =  self.listPrecincts.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectPrecinct = "\(obj)"
            }
        }
        
        
        
        //input so cmnd
        lblCMND =  UILabel(frame: CGRect(x: lblNhapHo.frame.origin.x, y: wardsButton.frame.origin.y + wardsButton.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblCMND.textAlignment = .left
        lblCMND.textColor = UIColor.black
        lblCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblCMND.text = "Nhập CMND/Căn Cước"
        viewInfoCustomer.addSubview(lblCMND)
        
        
        tfCMND = UITextField(frame: CGRect(x: lblNhapHo.frame.origin.x, y: lblCMND.frame.origin.y + lblCMND.frame.size.height + Common.Size(s:10), width: tfHoKhachHang.frame.size.width  , height: Common.Size(s:40)));
        tfCMND.placeholder = "Số CMND/Căn Cước"
        
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        viewInfoCustomer.addSubview(tfCMND)
        //tfUserBirthday.addTarget(self, action: #selector(textFieldDidChangeBirthday(_:)), for: .editingChanged)
        tfCMND.text = Cache.vlBirthday
        
        
        //input ngay cap cmnd
        lblNgayCap =  UILabel(frame: CGRect(x: lblNhapHo.frame.origin.x, y: tfCMND.frame.origin.y + tfCMND.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNgayCap.textAlignment = .left
        lblNgayCap.textColor = UIColor.black
        lblNgayCap.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNgayCap.text = "Ngày Cấp CMND/Căn Cước"
        viewInfoCustomer.addSubview(lblNgayCap)
        
        tfNgayCap = UITextField(frame: CGRect(x: lblNhapHo.frame.origin.x, y: lblNgayCap.frame.origin.y + lblNgayCap.frame.size.height + Common.Size(s:10), width: tfHoKhachHang.frame.size.width , height: Common.Size(s:40)));
        tfNgayCap.placeholder = "Ngày Cấp"
        
        tfNgayCap.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNgayCap.borderStyle = UITextField.BorderStyle.roundedRect
        tfNgayCap.autocorrectionType = UITextAutocorrectionType.no
        tfNgayCap.keyboardType = UIKeyboardType.numbersAndPunctuation
        tfNgayCap.returnKeyType = UIReturnKeyType.done
        tfNgayCap.clearButtonMode = UITextField.ViewMode.whileEditing
        tfNgayCap.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfNgayCap.delegate = self
        viewInfoCustomer.addSubview(tfNgayCap)
        //tfUserBirthday.addTarget(self, action: #selector(textFieldDidChangeBirthday(_:)), for: .editingChanged)
        tfNgayCap.text = Cache.vlBirthday
        
        //input Noi Cap cmnd
        lblNoiCap =  UILabel(frame: CGRect(x: lblNhapHo.frame.origin.x, y: tfNgayCap.frame.origin.y + tfNgayCap.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNoiCap.textAlignment = .left
        lblNoiCap.textColor = UIColor.black
        lblNoiCap.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNoiCap.text = "Nơi Cấp CMND/Căn Cước"
        viewInfoCustomer.addSubview(lblNoiCap)
        
        tfCreateAddress = SearchTextField(frame: CGRect(x: lblNhapHo.frame.origin.x, y: lblNoiCap.frame.origin.y + lblNoiCap.frame.size.height + Common.Size(s:10), width: tfHoKhachHang.frame.size.width  , height: Common.Size(s:40)));
        
        tfCreateAddress.placeholder = "Chọn nơi cấp CMND"
        tfCreateAddress.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCreateAddress.borderStyle = UITextField.BorderStyle.roundedRect
        tfCreateAddress.autocorrectionType = UITextAutocorrectionType.no
        tfCreateAddress.keyboardType = UIKeyboardType.default
        tfCreateAddress.returnKeyType = UIReturnKeyType.done
        tfCreateAddress.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCreateAddress.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCreateAddress.delegate = self
        viewInfoCustomer.addSubview(tfCreateAddress)
        
        tfCreateAddress.startVisible = true
        tfCreateAddress.theme.bgColor = UIColor.white
        tfCreateAddress.theme.fontColor = UIColor.black
        tfCreateAddress.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCreateAddress.theme.cellHeight = Common.Size(s:40)
        tfCreateAddress.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        
        tfCreateAddress.leftViewMode = UITextField.ViewMode.always
        let imageNoiCapCMND = UIImageView(frame: CGRect(x: tfCreateAddress.frame.size.height/4, y: tfCreateAddress.frame.size.height/4, width: tfCreateAddress.frame.size.height/2, height: tfCreateAddress.frame.size.height/2))
        imageNoiCapCMND.image = UIImage(named: "Home-50-1")
        imageNoiCapCMND.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewNoiCapCMND = UIView()
        leftViewNoiCapCMND.addSubview(imageNoiCapCMND)
        leftViewNoiCapCMND.frame = CGRect(x: 0, y: 0, width: tfCreateAddress.frame.size.height, height: tfCreateAddress.frame.size.height)
        tfCreateAddress.leftView = leftViewNoiCapCMND
        
        
        
        tfCreateAddress.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfCreateAddress.text = item.title
            let obj =  self.listProvices.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectAddressCMND = "\(obj)"
            }
        }
        
        //
        let lblTitleLoaiKH =  UILabel(frame: CGRect(x: lblNhapHo.frame.origin.x, y: tfCreateAddress.frame.origin.y + tfCreateAddress.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTitleLoaiKH.textAlignment = .left
        lblTitleLoaiKH.textColor = UIColor.black
        lblTitleLoaiKH.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTitleLoaiKH.text = "Loại KH"
        viewInfoCustomer.addSubview(lblTitleLoaiKH)
        
        tfTypeCustomer = SearchTextField(frame: CGRect(x: lblNhapHo.frame.origin.x, y: lblTitleLoaiKH.frame.origin.y + lblTitleLoaiKH.frame.size.height + Common.Size(s:10), width: tfHoKhachHang.frame.size.width , height: Common.Size(s:40) ));
        
        
        tfTypeCustomer.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTypeCustomer.borderStyle = UITextField.BorderStyle.roundedRect
        tfTypeCustomer.autocorrectionType = UITextAutocorrectionType.no
        tfTypeCustomer.keyboardType = UIKeyboardType.default
        tfTypeCustomer.returnKeyType = UIReturnKeyType.done
        tfTypeCustomer.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTypeCustomer.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTypeCustomer.delegate = self
        viewInfoCustomer.addSubview(tfTypeCustomer)
        
        // Start visible - Default: false
        tfTypeCustomer.startVisible = true
        tfTypeCustomer.theme.bgColor = UIColor.white
        tfTypeCustomer.theme.fontColor = UIColor.black
        tfTypeCustomer.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTypeCustomer.theme.cellHeight = Common.Size(s:40)
        tfTypeCustomer.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        tfTypeCustomer.leftViewMode = UITextField.ViewMode.always
        
        
        
        var listTypeCustomerTemp:[String] = []
        for item in lstTypeCustomer {
            listTypeCustomerTemp.append(item.value)
        }
        tfTypeCustomer.filterStrings(listTypeCustomerTemp)
        tfTypeCustomer.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfTypeCustomer.text = item.title
            let obj =  self.lstTypeCustomer.filter{ $0.value == "\(item.title)" }.first
            if let obj = obj?.code {
                self.selectTypeCustomer = "\(obj)"
                
            }
            
        }
        
        let lblTitleTypeIdentify =  UILabel(frame: CGRect(x: lblNhapHo.frame.origin.x, y: tfTypeCustomer.frame.origin.y + tfTypeCustomer.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTitleTypeIdentify.textAlignment = .left
        lblTitleTypeIdentify.textColor = UIColor.black
        lblTitleTypeIdentify.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTitleTypeIdentify.text = "Loại giấy tờ"
        viewInfoCustomer.addSubview(lblTitleTypeIdentify)
        
        
        tfTypeIndentify = SearchTextField(frame: CGRect(x: lblNhapHo.frame.origin.x, y: lblTitleTypeIdentify.frame.origin.y + lblTitleTypeIdentify.frame.size.height + Common.Size(s:10), width: tfHoKhachHang.frame.size.width  , height: Common.Size(s:40) ));
        
        
        tfTypeIndentify.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTypeIndentify.borderStyle = UITextField.BorderStyle.roundedRect
        tfTypeIndentify.autocorrectionType = UITextAutocorrectionType.no
        tfTypeIndentify.keyboardType = UIKeyboardType.default
        tfTypeIndentify.returnKeyType = UIReturnKeyType.done
        tfTypeIndentify.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTypeIndentify.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTypeIndentify.delegate = self
        viewInfoCustomer.addSubview(tfTypeIndentify)
        
        // Start visible - Default: false
        tfTypeIndentify.startVisible = true
        tfTypeIndentify.theme.bgColor = UIColor.white
        tfTypeIndentify.theme.fontColor = UIColor.black
        tfTypeIndentify.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTypeIndentify.theme.cellHeight = Common.Size(s:40)
        tfTypeIndentify.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        tfTypeIndentify.leftViewMode = UITextField.ViewMode.always
        
        
        
        var listTypeIndentifyTemp:[String] = []
        for item in lstTypeIndentify {
            listTypeIndentifyTemp.append(item.value)
        }
        tfTypeIndentify.filterStrings(listTypeIndentifyTemp)
        tfTypeIndentify.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfTypeIndentify.text = item.title
            let obj =  self.lstTypeIndentify.filter{ $0.value == "\(item.title)" }.first
            if let obj = obj?.code {
                self.selectTypeIndentify = "\(obj)"
                
            }
            
        }
        
        let lblTitleLoaiThueBao =  UILabel(frame: CGRect(x: lblNhapHo.frame.origin.x, y: tfTypeIndentify.frame.origin.y + tfTypeIndentify.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTitleLoaiThueBao.textAlignment = .left
        lblTitleLoaiThueBao.textColor = UIColor.black
        lblTitleLoaiThueBao.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTitleLoaiThueBao.text = "Loại thuê bao"
        viewInfoCustomer.addSubview(lblTitleLoaiThueBao)
        
        
        radioTraTruoc = createRadioButtonLoaiThueBao(CGRect(x: lblTitleLoaiThueBao.frame.origin.x,y:lblTitleLoaiThueBao.frame.origin.y + lblTitleLoaiThueBao.frame.size.height + Common.Size(s:5) , width: lblTitleLoaiThueBao.frame.size.width/3, height: Common.Size(s:20)), title: "Trả trước", color: UIColor.black);
        viewInfoCustomer.addSubview(radioTraTruoc)
        
        radioTraSau = createRadioButtonLoaiThueBao(CGRect(x: radioTraTruoc.frame.origin.x + radioTraTruoc.frame.size.width ,y:radioTraTruoc.frame.origin.y, width: radioTraTruoc.frame.size.width, height: radioTraTruoc.frame.size.height), title: "Trả sau", color: UIColor.black);
        viewInfoCustomer.addSubview(radioTraSau)
        
        radioTraTruoc.isSelected = true
        self.selectLoaiTB = "TT"
        
        //input Quoc Tich
        lblQuocTich =  UILabel(frame: CGRect(x: lblNhapHo.frame.origin.x, y: radioTraSau.frame.origin.y + radioTraSau.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblQuocTich.textAlignment = .left
        lblQuocTich.textColor = UIColor.black
        lblQuocTich.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblQuocTich.text = "Quốc Tịch"
        viewInfoCustomer.addSubview(lblQuocTich)
        
        
        tfQuocTich = UITextField(frame: CGRect(x: lblNhapHo.frame.origin.x, y: lblQuocTich.frame.origin.y + lblQuocTich.frame.size.height + Common.Size(s:10), width: tfHoKhachHang.frame.size.width  , height: Common.Size(s:40)));
        tfQuocTich.placeholder = "Vui lòng nhập quốc tịch"
        
        tfQuocTich.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfQuocTich.borderStyle = UITextField.BorderStyle.roundedRect
        tfQuocTich.autocorrectionType = UITextAutocorrectionType.no
        tfQuocTich.keyboardType = UIKeyboardType.default
        tfQuocTich.returnKeyType = UIReturnKeyType.done
        tfQuocTich.clearButtonMode = UITextField.ViewMode.whileEditing
        tfQuocTich.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfQuocTich.delegate = self
        viewInfoCustomer.addSubview(tfQuocTich)
        tfQuocTich.text = "Việt Nam"
        tfQuocTich.isUserInteractionEnabled = false
        tfQuocTich.isEnabled = false
        
        viewInfoCustomer.frame.size.height = tfQuocTich.frame.size.height + tfQuocTich.frame.origin.y + Common.Size(s: 10)
        
        
        
        
        
        labelTitleAvarta = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewInfoCustomer.frame.size.height + viewInfoCustomer.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelTitleAvarta.text = "CHỤP CHÂN DUNG KHÁCH HÀNG"
        labelTitleAvarta.textColor = UIColor(netHex:0x00955E)
        labelTitleAvarta.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(labelTitleAvarta)
        
        
        viewImageAvarta = UIView(frame: CGRect(x: 0, y: labelTitleAvarta.frame.size.height + labelTitleAvarta.frame.origin.y , width: scrollView.frame.size.width, height: 0))
        viewImageAvarta.clipsToBounds = true
        viewImageAvarta.backgroundColor = .white
        scrollView.addSubview(viewImageAvarta)
        
        
        imgViewAvarta = UIImageView(frame: CGRect(x:Common.Size(s: 15), y:  Common.Size(s:5), width: viewImageAvarta.frame.size.width - Common.Size(s:30), height: (viewImageCMNDFront.frame.size.width - Common.Size(s:30)) / 2.6))
        imgViewAvarta.image = UIImage(named:"UploadImage")
        imgViewAvarta.contentMode = .scaleAspectFit
        viewImageAvarta.addSubview(imgViewAvarta)
        imgViewAvarta.frame.size.height = imgViewAvarta.frame.origin.y + imgViewAvarta.frame.size.height
        imgViewAvarta.tag = 1
        let tapShowImageAvarta = UITapGestureRecognizer(target: self, action: #selector(self.tapShowAvarta))
        viewImageAvarta.isUserInteractionEnabled = true
        viewImageAvarta.addGestureRecognizer(tapShowImageAvarta)
        
        viewImageAvarta.frame.size.height = imgViewAvarta.frame.size.height + imgViewAvarta.frame.origin.y + Common.Size(s:10)
        
        
        
        labelTitleSign = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewImageAvarta.frame.size.height + viewImageAvarta.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelTitleSign.text = "CHỮ KÝ KHÁCH HÀNG"
        labelTitleSign.textColor = UIColor(netHex:0x00955E)
        labelTitleSign.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(labelTitleSign)
        
        
        
        
        viewImageSign = UIView(frame: CGRect(x:0, y: labelTitleSign.frame.origin.y + labelTitleSign.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s:150)))
        viewImageSign.layer.borderWidth = 0.5
        viewImageSign.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSign.layer.cornerRadius = 3.0
        viewImageSign.backgroundColor = .white
        scrollView.addSubview(viewImageSign)
        
        let viewSignButton =  UIImageView(frame: CGRect(x:Common.Size(s: 15), y:  Common.Size(s:5), width: viewImageSign.frame.size.width - Common.Size(s:30), height: (viewImageCMNDFront.frame.size.width - Common.Size(s:30)) / 2.6))
        viewSignButton.image = #imageLiteral(resourceName: "Chuky")
        viewSignButton.contentMode = .scaleAspectFit
        viewSignButton.tag = 1
        viewImageSign.addSubview(viewSignButton)
        
        
        let tapShowSignature = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSignature))
        viewImageSign.isUserInteractionEnabled = true
        viewImageSign.addGestureRecognizer(tapShowSignature)
        
        viewImageSign.frame.size.height = viewSignButton.frame.size.height + viewSignButton.frame.origin.y + Common.Size(s:10)
        
        
        viewOTP = UIView()
        viewOTP.frame = CGRect(x: 0, y: viewImageSign.frame.size.height + viewImageSign.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewOTP.backgroundColor = UIColor.white
        scrollView.addSubview(viewOTP)
        
        
        let lblMaOTP =  UILabel(frame: CGRect(x: lblNhapHo.frame.origin.x, y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblMaOTP.textAlignment = .left
        lblMaOTP.textColor = UIColor.black
        lblMaOTP.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblMaOTP.text = "Mã OTP"
        viewOTP.addSubview(lblMaOTP)
        
        
        tfMaOTP = UITextField(frame: CGRect(x: lblNhapHo.frame.origin.x, y: lblMaOTP.frame.origin.y + lblMaOTP.frame.size.height + Common.Size(s:10), width: tfHoKhachHang.frame.size.width  , height: Common.Size(s:40)));
        
        
        tfMaOTP.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfMaOTP.borderStyle = UITextField.BorderStyle.roundedRect
        tfMaOTP.autocorrectionType = UITextAutocorrectionType.no
        tfMaOTP.keyboardType = UIKeyboardType.numberPad
        tfMaOTP.returnKeyType = UIReturnKeyType.done
        tfMaOTP.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfMaOTP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfMaOTP.delegate = self
        viewOTP.addSubview(tfMaOTP)
        
        
        
        
        let btCreateOrder = UIButton()
        btCreateOrder.frame = CGRect(x: lblNhapHo.frame.origin.x, y: tfMaOTP.frame.origin.y + tfMaOTP.frame.size.height + Common.Size(s:20), width: view.frame.size.width - Common.Size(s:30),height: Common.Size(s:40))
        btCreateOrder.backgroundColor = UIColor(netHex:0x00955E)
        btCreateOrder.setTitle("Đăng ký", for: .normal)
        btCreateOrder.addTarget(self, action: #selector(actionCheckUpdate), for: .touchUpInside)
        btCreateOrder.layer.borderWidth = 0.5
        btCreateOrder.layer.borderColor = UIColor.white.cgColor
        btCreateOrder.layer.cornerRadius = 3
        viewOTP.addSubview(btCreateOrder)
        btCreateOrder.clipsToBounds = true
        
        viewOTP.frame.size.height = btCreateOrder.frame.size.height + btCreateOrder.frame.origin.y + Common.Size(s:10)
        
        
        
        
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewOTP.frame.origin.y + viewOTP.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        self.tfTenKhachHang.text = self.infoActiveSimByPhone?.LastName ?? ""
        self.tfHoKhachHang.text = self.infoActiveSimByPhone?.FirstName ?? ""
        self.tfUserBirthday.text = self.infoActiveSimByPhone?.Birthday ?? ""
        
        if (self.infoActiveSimByPhone?.Gender == 1){
            self.radioMan.isSelected = true
            //   genderType = 1
        }else if (self.infoActiveSimByPhone?.Gender == 0){
            self.radioWoman.isSelected = true
            //  genderType = 0
        }else{
            self.radioMan.isSelected = false
            self.radioWoman.isSelected = false
            //  genderType = -1
        }
        self.tfCMND.text = self.infoActiveSimByPhone?.CMND ?? ""
        self.tfNgayCap.text = self.infoActiveSimByPhone?.DateCreateCMND ?? ""
        self.tfDiaChi.text = self.infoActiveSimByPhone?.Address ?? ""
       
        //phuong xa
        self.wardsButton.text = self.infoActiveSimByPhone?.PrecinctCode ?? ""
        self.selectPrecinct = "\(self.infoActiveSimByPhone?.PrecinctCode ?? "")"
        
        self.actionLoadProvince()

    }
 
    func reloadUI(){
        viewImageCMNDBehind.frame.origin.y = viewImageCMNDFront.frame.size.height + viewImageCMNDFront.frame.origin.y
        viewUpload.frame.size.height =  viewImageCMNDBehind.frame.size.height + viewImageCMNDBehind.frame.origin.y + Common.Size(s: 10)
        labelInfoCustomer.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y
        viewInfoCustomer.frame.origin.y = labelInfoCustomer.frame.size.height + labelInfoCustomer.frame.origin.y
        labelTitleAvarta.frame.origin.y = viewInfoCustomer.frame.size.height + viewInfoCustomer.frame.origin.y
        viewImageAvarta.frame.origin.y = labelTitleAvarta.frame.size.height + labelTitleAvarta.frame.origin.y
        labelTitleSign.frame.origin.y = viewImageAvarta.frame.size.height + viewImageAvarta.frame.origin.y
        viewImageSign.frame.origin.y = labelTitleSign.frame.size.height + labelTitleSign.frame.origin.y
        viewOTP.frame.origin.y = viewImageSign.frame.size.height + viewImageSign.frame.origin.y
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewOTP.frame.origin.y + viewOTP.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    @objc func tapShowImageCMNDFront(){
        posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowImageBehind(){
        posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowAvarta(){
        posImageUpload = 3
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowSignature(){
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
        
        self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func loadHistoryUpdatePhone(){
        let newViewController = HistoryUpdateVNMViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    fileprivate func createRadioButtonLoaiThueBao(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:14));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(SimUpdateVNMViewController.logSelectedButtonLoaiThueBao), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    @objc @IBAction fileprivate func logSelectedButtonLoaiThueBao(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioTraTruoc.isSelected = false
            radioTraSau.isSelected = false
            switch temp {
            case "Trả trước":
                selectLoaiTB = "TT"
                
                radioTraTruoc.isSelected = true
                
                break
            case "Trả sau":
                selectLoaiTB = "TS"
                
                radioTraSau.isSelected = true
                break
            default:
                
                break
            }
        }
    }
    
    fileprivate func createRadioButtonGender(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:14));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(SimUpdateVNMViewController.logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioMan.isSelected = false
            radioWoman.isSelected = false
            switch temp {
            case "Nam":
                genderType = 1
                Cache.genderType = 1
                radioMan.isSelected = true
                break
            case "Nữ":
                genderType = 0
                Cache.genderType = 0
                radioWoman.isSelected = true
                break
            default:
                genderType = -1
                Cache.genderType = -1
                break
            }
        }
    }
    
    
    func actionLoadProvince(){
        
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin tỉnh thành..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.GetProvinces(NhaMang: "Vietnammobile", handler: { (results, error) in
            
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                self.listProvices = results
                var list:[String] = []
                for item in results {
                    list.append(item.Text)
                }
                self.cityButton.filterStrings(list)
                self.tfCreateAddress.filterStrings(list)
                
                if let palaceCreateCMND = self.infoActiveSimByPhone?.PalaceCreateCMND {
                    let obj =  self.listProvices.filter{ $0.Text == "\(palaceCreateCMND)" }.first
                    if let _ = obj?.Text {
                        self.tfCreateAddress.text = obj?.Text
                        self.selectAddressCMND = (obj?.Value)!
                    }
                }
                if(self.tfCreateAddress.text==""){
                    if let palaceCreateCMND = self.infoActiveSimByPhone?.PalaceCreateCMND {
                        let obj =  self.listProvices.filter{ $0.Value == "\(palaceCreateCMND)" }.first
                        if let _ = obj?.Text {
                            self.tfCreateAddress.text = obj?.Text
                            self.selectAddressCMND = (obj?.Value)!
                        }
                    }
                }
                
                guard let provinceCode = self.infoActiveSimByPhone?.ProvinceCode else {return}
                
                
                let obj =  self.listProvices.filter{ $0.Text == "\(provinceCode)" }.first
                if (obj?.Text) != nil {
                    
                    self.cityButton.text = obj?.Text
                    self.selectProvice = "\(obj!.Value)"
                    
                    //quan huyen
                    if let districtCode = self.infoActiveSimByPhone?.DistrictCode {
                        MPOSAPIManager.GetDistricts(MaCodeTinh: "\(self.selectProvice)", NhaMang: "\(self.infoActiveSimByPhone!.Provider)", handler: { (results, error) in
                            
                            self.listDistricts = results
                            var listDistrictTemp:[String] = []
                            for item in results {
                                listDistrictTemp.append(item.Text)
                            }
                            self.districtButton.filterStrings(listDistrictTemp)
                            
                            //let obj =  results.filter{ $0.Value == "\(districtCode)" }.first
                            let obj =  results.filter{ $0.Text == "\(districtCode)" }.first
                            if let _ = obj?.Text {
                                // self.districtButton.text = obj1
                                self.districtButton.text = obj?.Text
                                self.selectDistrict = "\(obj!.Value)"
                            }
                        })
                    }
                }
                
                
                // case value
                if(self.cityButton.text == ""){
                    let obj =  self.listProvices.filter{ $0.Value == "\(provinceCode)" }.first
                    if let _ = obj?.Text {
                        //self.cityButton.text = obj1
                        self.cityButton.text = obj?.Text
                        self.selectProvice = "\(obj!.Value)"
                        
                        //quan huyen
                        if let districtCode = self.infoActiveSimByPhone?.DistrictCode {
                            MPOSAPIManager.GetDistricts(MaCodeTinh: "\(self.selectProvice)", NhaMang: "\(self.infoActiveSimByPhone!.Provider)", handler: { (results, error) in
                                
                                self.listDistricts = results
                                var listDistrictTemp:[String] = []
                                for item in results {
                                    listDistrictTemp.append(item.Text)
                                }
                                self.districtButton.filterStrings(listDistrictTemp)
                                
                                //let obj =  results.filter{ $0.Value == "\(districtCode)" }.first
                                let obj =  results.filter{ $0.Text == "\(districtCode)" }.first
                                if let _ = obj?.Text {
                                    // self.districtButton.text = obj1
                                    self.districtButton.text = obj?.Text
                                    self.selectDistrict = "\(obj!.Value)"
                                    
                                    
                                    
                                }
                                if(self.districtButton.text == ""){
                                    let obj =  results.filter{ $0.Value == "\(districtCode)" }.first
                                    if let _ = obj?.Text {
                                        // self.districtButton.text = obj1
                                        self.districtButton.text = obj?.Text
                                        self.selectDistrict = "\(obj!.Value)"
                                        
                                        
                                        
                                    }
                                }
                            })
                        }
                    }
                }
                
                
                
                
            }
        })
    }
    
    
    func loadAPICMND(){
        if(imgViewImageCMNDFront.image != nil){
            let imageCMNDTruoc:UIImage = self.resizeImageWidth(image: imgViewImageCMNDFront.image!,newWidth: Common.resizeImageWith)!
            if let imageDataCMNDTruoc:NSData =  imageCMNDTruoc.jpegData(compressionQuality: Common.resizeImageValue) as NSData?{
                let strBase64CMNDTruoc = imageDataCMNDTruoc.base64EncodedString(options: .endLineWithLineFeed)
                
                let newViewController = LoadingViewController()
                newViewController.content = "Đang nhận dạng CMND mặt trước..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                MPOSAPIManager.GetinfoCustomerByImageIDCard(Image_CMND: strBase64CMNDTruoc, NhaMang: "Vietnammobile",Type:"1", handler: { (results, err) in
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            if(results.count > 0){
                                let item = results[0]
                                self.tfCMND.text = "\(item.CMND)"
                            
                                self.tfUserBirthday.text = "\(item.Birthday)"
                                self.tfNgayCap.text = "\(item.DateCreateCMND)"
                                self.tfDiaChi.text = "\(item.Address)"
                                self.tfHoKhachHang.text = "\(item.LastName)"
                                self.tfTenKhachHang.text = "\(item.FirstName)"

                            
                                
                                
                                let palaceCreateCMND = item.PalaceCreateCMND
                                let obj =  self.listProvices.filter{ $0.Value == "\(palaceCreateCMND)" }.first
                                if let _ = obj?.Value {
                                    self.tfCreateAddress.text = obj?.Text
                                    self.selectAddressCMND = (obj?.Value)!
                                }
                                let Provices = item.ProvinceCode
                                let obj2 =  self.listProvices.filter{ $0.Value == "\(Provices)" }.first
                                if let _ = obj2?.Value {
                                    self.cityButton.text = obj2?.Text
                                    self.selectProvice = (obj2?.Value)!
                                }
                                let District = item.DistrictCode
                                MPOSAPIManager.GetDistricts(MaCodeTinh: "\(self.selectProvice)", NhaMang: "Vietnammobile", handler: { (results, error) in
                                    
                                    self.listDistricts = results
                                    var listDistrictTemp:[String] = []
                                    for item in results {
                                        listDistrictTemp.append(item.Text)
                                    }
                                    self.districtButton.filterStrings(listDistrictTemp)
                                    
                                    
                                    
                                    let obj3 =  self.listDistricts.filter{ $0.Value == "\(District)" }.first
                                    if let _ = obj3?.Value {
                                        
                                        
                                        self.districtButton.text = obj3?.Text
                                        self.selectDistrict = (obj3?.Value)!
                                        
                                        
                                        let Precinct = item.PrecinctCode
                                        MPOSAPIManager.GetPrecincts(MaCodeHUyen:  "\(self.selectDistrict)", MaCodeTinh: "\(self.selectProvice)", NhaMang: "Vietnammobile", handler: { (results, error) in
                                            
                                            self.listPrecincts = results
                                            var list:[String] = []
                                            for item in results {
                                                list.append(item.Text)
                                            }
                                            self.wardsButton.filterStrings(list)
                                            
                                            
                                            
                                            let obj4 =  self.listPrecincts.filter{ $0.Value == "\(Precinct)" }.first
                                            if let _ = obj4?.Value {
                                                
                                                self.wardsButton.text = obj4?.Text
                                                self.selectPrecinct = (obj4?.Value)!
                                                
                                            }
                                            
                                        })
                                        
                                        
                                    }
                                })

                                if (item.Gender == 0){
                                    self.radioWoman.isSelected = true
                                    self.genderType = 0
                                }else if (item.Gender == 1){
                                    self.radioMan.isSelected = true
                                    self.genderType = 1
                                }
                                if(self.tfCreateAddress.text == "" ){
                                    let obj =  self.listProvices.filter{ $0.Text == "\(palaceCreateCMND)" }.first
                                    if let _ = obj?.Text {
                                        self.tfCreateAddress.text = obj?.Text
                                        self.selectAddressCMND = (obj?.Value)!
                                    }
                                }
                                if(self.cityButton.text == "" ){
                                    let obj2 =  self.listProvices.filter{ $0.Text == "\(Provices)" }.first
                                    if let _ = obj2?.Text {
                                        self.cityButton.text = obj2?.Text
                                        self.selectProvice = (obj2?.Value)!
                                    }
                                }
                                if(self.districtButton.text == ""){
                                    let obj3 =  self.listDistricts.filter{ $0.Text == "\(District)" }.first
                                    if let _ = obj3?.Text {
                                        
                                        self.districtButton.text = obj3?.Text
                                        self.selectDistrict = (obj3?.Value)!
                                        
                                    }
                                }
               
     
                            }
                        }else{
                            
                        }
                    }
                })
            }
        }
    }
    func loadAPICMNDSau(){
        
        if(imgViewImageCMNDBehind.image != nil){
            let imageCMNDSau:UIImage = self.resizeImageWidth(image: imgViewImageCMNDBehind.image!,newWidth: Common.resizeImageWith)!
            if let imageDataCMNDSau:NSData =  imageCMNDSau.jpegData(compressionQuality: Common.resizeImageValue) as NSData?{
                let strBase64CMNDSau = imageDataCMNDSau.base64EncodedString(options: .endLineWithLineFeed)
                
                let newViewController = LoadingViewController()
                newViewController.content = "Đang nhận dạng CMND mặt sau..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                MPOSAPIManager.GetinfoCustomerByImageIDCardSau(Image_CMND: strBase64CMNDSau, NhaMang: "Vietnammobile",Type:"2", handler: { (results, err) in
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            self.tfNgayCap.text = "\(results[0].issue_date)"
                            let obj =  self.listProvices.filter{ $0.Value == "\(results[0].issue_loc)" }.first
                            if let _ = obj?.Value {
                                self.tfCreateAddress.text = obj?.Text
                                self.selectAddressCMND = (obj?.Value)!
                            }
                        }else{
                            
                        }
                    }
                })
                
            }
            
        }
        
    }
    
    
    
    @objc func actionCheckUpdate(){

      
        
        let firstname = tfHoKhachHang.text!
        if (firstname.count==0) {
            self.showDialog(message: "Chưa nhập họ khách hàng!!!")
            // tfHoKhachHang.becomeFirstResponder()
            return
        }
        let lastname = tfTenKhachHang.text!
        if (lastname.count == 0 ) {
            self.showDialog(message: "Chưa nhập tên khách hàng!!!")
            tfTenKhachHang.becomeFirstResponder()
            return
        }
        let fullname = firstname+" "+lastname
        
        
        let birthday = tfUserBirthday.text!
        if (birthday.count==0) {
            self.showDialog(message: "Chưa nhập ngày sinh khách hàng!!!")
            return
        }
        if (!checkDate(stringDate: birthday)){
            self.showDialog(message: "Ngày sinh sai định dạng!")
            return
        }
        let cmndCheck = tfCMND.text!
        if (cmndCheck.count == 0) {
            self.showDialog(message: "Chưa nhập cmnd khách hàng!!!")
            return
        }
        let address = tfDiaChi.text!
        if (address.count == 0) {
            self.showDialog(message: "Chưa nhập địa chỉ khách hàng!!!")
            return
        }
        
        if (cmndCheck.count == 9 || cmndCheck.count == 12){
            
        }else{
            self.showDialog(message: "CMND nhập sai định dạng")
            return
        }
        if(self.selectProvice == "" || cityButton.text==""){
            self.showDialog(message: "Bạn phải chọn tỉnh thành phố")
            return
        }
        if(self.selectDistrict == "" || districtButton.text==""){
            self.showDialog(message: "Bạn phải chọn quận huyện")
            return
        }
        if(wardsButton.text==""){
            self.showDialog(message: "Bạn phải nhập phường xã")
            return
        }
        let ngaycap = tfNgayCap.text!
        if (ngaycap.count==0) {
            self.showDialog(message: "Chưa nhập ngày cấp cmnd khách hàng!!!")
            return
        }
        if (!checkDate(stringDate: ngaycap)){
            self.showDialog(message: "Ngày cấp cmnd sai định dạng!")
            return
        }
        
        let noicap = tfCreateAddress.text!
        if (noicap.count == 0 || selectAddressCMND=="") {
            self.showDialog(message: "Chưa chọn nơi cấp cmnd khách hàng!!!")
            return
        }
        
        
        
        if(imgViewImageCMNDFront == nil){
            self.showDialog(message: "Chưa có hình mặt trước CMND")
            return
        }
        if(imgViewImageCMNDBehind == nil){
            self.showDialog(message: "Chưa có hình mặt sau CMND")
            return
        }
        if(imgViewAvarta == nil){
            self.showDialog(message: "Chưa có hình chân dung khách hàng")
            return
        }
        let otp = tfMaOTP.text!
        if (otp.count == 0) {
            self.showDialog(message: "Vui lòng nhập mã OTP")
            return
        }
        
        if(self.genderType == -1){
            
            self.showDialog(message: "Chưa chọn giới tính")
            return
        }
        
        self.infoActiveSimByPhone?.FullName = fullname
        self.infoActiveSimByPhone?.Birthday = birthday
        self.infoActiveSimByPhone?.FirstName = firstname
        self.infoActiveSimByPhone?.LastName = lastname
        self.infoActiveSimByPhone?.Gender = genderType
        self.infoActiveSimByPhone?.CMND = cmndCheck
        self.infoActiveSimByPhone?.DateCreateCMND = ngaycap
        self.infoActiveSimByPhone?.PalaceCreateCMND = noicap
        self.infoActiveSimByPhone?.idNoiCapCMND = self.selectAddressCMND
        self.infoActiveSimByPhone?.ProvinceCode = "\(self.selectProvice)"
        self.infoActiveSimByPhone?.DistrictCode = "\(self.selectDistrict)"
        self.infoActiveSimByPhone?.PrecinctCode = wardsButton.text!
        self.infoActiveSimByPhone?.otp = tfMaOTP.text!
        self.infoActiveSimByPhone?.Address = address
       
        
        
        actionSaveInfo()
        
    }
    
    func actionSaveInfo(){
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang cập nhật thông tin khách hàng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        let imageSign:UIImage = self.resizeImage(image: imgViewSignature.image!,newHeight: 500)!
        let imageCMNDTruoc:UIImage = self.resizeImageWidth(image: imgViewImageCMNDFront.image!,newWidth: Common.resizeImageWith)!
        if let imageDataCMNDTruoc:NSData = imageCMNDTruoc.jpegData(compressionQuality: Common.resizeImageValue) as NSData?{
            
            let strBase64CMNDMatTruoc = imageDataCMNDTruoc.base64EncodedString(options: .endLineWithLineFeed)
            
            if let imageDataCMNDSau:NSData = imgViewImageCMNDBehind.image!.jpegData(compressionQuality: Common.resizeImageValue) as NSData?{
                let strBase64CMNDMatSau = imageDataCMNDSau.base64EncodedString(options: .endLineWithLineFeed)
                
                let imageAvatar:UIImage = self.resizeImageWidth(image: imgViewAvarta.image!,newWidth: Common.resizeImageWith)!
                if let imageDataChanDung:NSData = imageAvatar.jpegData(compressionQuality: Common.resizeImageValue) as NSData?{
                    
                    let strBase64ChanDung = imageDataChanDung.base64EncodedString(options: .endLineWithLineFeed)
                    
                    if let imageDataChuKy:NSData = imageSign.pngData() as NSData?{
                        let srtBase64ChuKy = imageDataChuKy.base64EncodedString(options: .endLineWithLineFeed)
                        
                        var p_HopDong:String = ""
                        var SeriSim:String = ""
                        if(self.infoActiveSimByPhone != nil){
                            if(self.infoActiveSimByPhone?.SoHopDong != 0){
                                p_HopDong = "\(self.infoActiveSimByPhone?.SoHopDong ?? 0)"
                                
                            }else{
                                p_HopDong = "000000"
                            }
                            if(self.infoActiveSimByPhone?.SeriSIM != ""){
                                SeriSim = (self.infoActiveSimByPhone?.SeriSIM)!
                                
                            }else{
                                SeriSim = ""
                            }
                        }else{
                            p_HopDong = "000000"
                            SeriSim = ""
                        }
                        
                        
                      
                        
                        MPOSAPIManager.AutoCreateImageActiveSimVietnamobile(p_HopDongSo:p_HopDong, p_TenKH: self.infoActiveSimByPhone?.FullName ?? "", p_CMND_KH: self.infoActiveSimByPhone?.CMND ?? "", p_NgayCapCMND_KH: self.infoActiveSimByPhone?.DateCreateCMND ?? "", p_NoiCapCMND_KH: self.infoActiveSimByPhone?.PalaceCreateCMND ?? "", p_NgaySinh_KH: self.infoActiveSimByPhone?.Birthday ?? "", p_GioiTinh_KH: "\(self.genderType)", p_QuocGia_KH: "Vietnam", p_NoiThuongTru_KH: self.infoActiveSimByPhone?.Address ?? "", p_ChuKy: srtBase64ChuKy, p_SoThueBao_Line1: self.infoActiveSimByPhone?.sdt ?? "", p_SoICCID_Line1: SeriSim, handler: { (imageInfo, err) in
                            
                            if (err.count<=0){

                                let imagesAll = "\(strBase64CMNDMatTruoc),\(strBase64CMNDMatSau),\(imageInfo!.ResultImage),\(strBase64ChanDung)"
                                MPOSAPIManager.updateInfoVNM(address: self.infoActiveSimByPhone?.Address ?? "",
                                                         companyName:"",
                                                         dateOfIssue: self.infoActiveSimByPhone?.DateCreateCMND ?? "",
                                                         // district: self.districtButton.text!,
                                    district: "\(self.selectDistrict)",
                                    dob: self.infoActiveSimByPhone?.Birthday ?? "",
                                    firstName: self.infoActiveSimByPhone?.FirstName ?? "",
                                    fullName: self.infoActiveSimByPhone?.FullName ?? "",
                                    lastName: self.infoActiveSimByPhone?.LastName ?? "",
                                    gender: "\(self.genderType)",
                                    idCard: self.infoActiveSimByPhone?.CMND ?? "",
                                    placeOfIssue: self.tfCreateAddress.text!,
                                    //placeOfIssue: "\(self.selectAddressCMND)",
                                    //province: self.cityButton.text!,
                                    province: "\(self.selectProvice)",
                                    mdn: self.infoActiveSimByPhone?.sdt ?? "",
                                    taxCode: "",
                                    images: imagesAll,
                                    otp: self.infoActiveSimByPhone?.otp ?? "",
                                    userCode: "\(Cache.user!.UserName)",
                                    employeeName: "\(Cache.user!.EmployeeName)",
                                    shopCode: "\(Cache.user!.ShopCode)",
                                    shopName: "\(Cache.user!.ShopName)",
                                shopAddress: "\(Cache.user!.Address)",sub_use_type:"\(self.selectTypeCustomer)",type_card:"\(self.selectTypeIndentify)",sub_payment_type:"\(self.selectLoaiTB)") { (results, err) in
                                    let when = DispatchTime.now() + 0.5
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                        
                                        let data = results
                                        if(err==""){
                                            if (data?.code == 0){
                                             
                                                self.showDialog(message: data?.message ?? "")
                                            }else{
                                                if(data?.message==""){
                                         
                                                    self.showDialog(message: data?.data ?? "")
                                                }else{
                                                 
                                                    self.showDialog(message: data?.dataResultInfoUpdateSim?.message ?? "")
                                                }
                                            }
                                        }else{
                                        
                                            
                                            self.showDialog(message: err)
                                        }
                                    }
                                }
                            }else{
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    self.showDialog(message: "Tạo phiếu thông tin khách hàng thất bại")
                                }
                            }
                        })
                    }
                }
            }
        }
    }
    
    
    
    func imageCMNDTruoc(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDFront.frame.size.width / sca
        viewImageCMNDFront.subviews.forEach { $0.removeFromSuperview() }
        imgViewImageCMNDFront  = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewImageCMNDFront.frame.size.width - Common.Size(s:30), height: heightImage))
        imgViewImageCMNDFront.contentMode = .scaleAspectFit
        imgViewImageCMNDFront.image = image
        viewImageCMNDFront.addSubview(imgViewImageCMNDFront)
        viewImageCMNDFront.frame.size.height = imgViewImageCMNDFront.frame.size.height + imgViewImageCMNDFront.frame.origin.y
        reloadUI()
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.loadAPICMND()
        }
        
    }
    func imageCMNDSau(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDBehind.frame.size.width / sca
        viewImageCMNDBehind.subviews.forEach { $0.removeFromSuperview() }
        imgViewImageCMNDBehind  = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewImageCMNDBehind.frame.size.width - Common.Size(s: 30), height: heightImage))
        imgViewImageCMNDBehind.contentMode = .scaleAspectFit
        imgViewImageCMNDBehind.image = image
        viewImageCMNDBehind.addSubview(imgViewImageCMNDBehind)
        viewImageCMNDBehind.frame.size.height = imgViewImageCMNDBehind.frame.size.height + imgViewImageCMNDBehind.frame.origin.y
        
        reloadUI()
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.loadAPICMNDSau()
        }
    }
    func imageAvatar(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageAvarta.frame.size.width / sca
        viewImageAvarta.subviews.forEach { $0.removeFromSuperview() }
        imgViewAvarta  = UIImageView(frame: CGRect(x: Common.Size(s:15), y: 5, width: viewImageAvarta.frame.size.width - Common.Size(s:30), height: heightImage))
        imgViewAvarta.contentMode = .scaleAspectFit
        imgViewAvarta.image = image
        viewImageAvarta.addSubview(imgViewAvarta)
        viewImageAvarta.frame.size.height = imgViewAvarta.frame.size.height + imgViewAvarta.frame.origin.y
        reloadUI()
        
    }
    
    func epSignature(_: EPSignatureViewController, didCancel error : NSError) {
        print("User canceled")
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        print(signatureImage)
        print(boundingRect)
        
        let width = viewImageSign.frame.size.width - Common.Size(s:10)
        
        let sca:CGFloat = boundingRect.size.width / boundingRect.size.height
        let heightImage:CGFloat = width / sca
        
        viewImageSign.subviews.forEach { $0.removeFromSuperview() }
        imgViewSignature  = UIImageView(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:5), width: width - Common.Size(s: 30), height: heightImage))
        //        imgViewSignature.backgroundColor = .red
        imgViewSignature.contentMode = .scaleAspectFit
        viewImageSign.addSubview(imgViewSignature)
        imgViewSignature.image = cropImage(image: signatureImage, toRect: boundingRect)
        
        viewImageSign.frame.size.height = imgViewSignature.frame.size.height + imgViewSignature.frame.origin.y + Common.Size(s:5)
        
        self.reloadUI()
        
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    
    @objc func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage? {
         
         let scale = newHeight / image.size.height
         let newWidth = image.size.width * scale
         UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
         image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
         
         let newImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         
         return newImage
     }
     
     
     func resizeImageWidth(image: UIImage, newWidth: CGFloat) -> UIImage? {
         
         
         let scale = newWidth / image.size.width
         let newHeight = image.size.height * scale
         
         
         UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
         image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
         
         let newImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         
         return newImage
     }
    
    func checkDate(stringDate:String) -> Bool{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy"
        
        if let _ = dateFormatterGet.date(from: stringDate) {
            return true
        } else {
            return false
        }
    }
    
}
extension SimUpdateVNMViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        let alert = UIAlertController(title: "Chọn hình ảnh", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Chụp ảnh", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Thư viện", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Huỷ", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            //            alert.popoverPresentationController?.sourceView = sender
            //            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: - Open the camera
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        //        image is our desired image
        if (self.posImageUpload == 1){
            self.imageCMNDTruoc(image: image)
        }else if (self.posImageUpload == 2){
            self.imageCMNDSau(image: image)
        } else if (self.posImageUpload == 3){
            self.imageAvatar(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
