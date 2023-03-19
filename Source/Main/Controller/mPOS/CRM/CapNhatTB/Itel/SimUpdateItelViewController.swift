//
//  SimUpdateItelViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 9/14/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DLRadioButton
//import EPSignature
class SimUpdateItelViewController: UIViewController,UITextFieldDelegate {
    
    // MARK: - Properties
    
    
    var scrollView:UIScrollView!
    var viewImageCMNDFront:UIView!
    var imgViewImageCMNDFront:UIImageView!
    
    var viewImageCMNDBehind:UIView!
    var imgViewImageCMNDBehind:UIImageView!
    
    var viewImageAvarta:UIView!
    var imgViewAvarta:UIImageView!
    
    var viewImageSign:UIView!
    var imgViewSign: UIImageView!
    var viewInfo:UIView!
    var viewUpload:UIView!
    var tfUserName:UITextField!
    var radioMale:DLRadioButton!
    var radioFemale:DLRadioButton!
    var gender:Int = -1
    var tfBirthday:UITextField!
    var tfAddress:UITextField!
    var tfProvince:SearchTextField!
    var tfDistrict:SearchTextField!
    var tfPrecinct:SearchTextField!
    var tfNation:SearchTextField!
    var tfCMND:UITextField!
    
    var radioPassport:DLRadioButton!
    var radioCMND:DLRadioButton!
    var radioCanCuoc:DLRadioButton!
    var tfPlaceCreateCMND:SearchTextField!
    var typeKichHoat:Int = 1
  
    var tfNgayCap:UITextField!
    var tfSDT:UITextField!
    var posImageUpload:Int = 0
    var imagePicker = UIImagePickerController()
    
    var listProvices:[Province] = []
    var listDistricts:[District] = []
    var listPrecincts:[Precinct] = []
    
    
    var selectProvice:String = ""
    var selectDistrict:String = ""
    var selectPrecinct:String = ""
    var selectAddressCMND:String = ""
    var labelTitleCMND:UILabel!
    var btCreateOrder:UIButton!
    var viewOTP:UIView!
    var tfMaOTP:UITextField!
    var listNationality = [National]()
    var selectNational:String = ""
    var sdt:String?
    var hasAddress = false
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.title = "Cập nhật TB Itel"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
        
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
        

        
        let lbTextImageCMNDFront = Common.tileLabel(x: Common.Size(s: 15), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20), title: "CMND mặt trước (*)", fontSize: Common.Size(s:12))
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
        
        
        let lbTextImageCMNDBehind = Common.tileLabel(x: Common.Size(s: 15), y: Common.Size(s: 10), width:  scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20), title: "CMND mặt sau (*)", fontSize: Common.Size(s:12))
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
        
        viewInfo = UIView()
        viewInfo.frame = CGRect(x: 0, y: viewUpload.frame.size.height + viewUpload.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewInfo.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.addSubview(viewInfo)
        
        let labelInfoCustomer = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0 , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelInfoCustomer.text = "THÔNG TIN KHÁCH HÀNG"
        labelInfoCustomer.textColor = UIColor(netHex:0x00955E)
        labelInfoCustomer.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewInfo.addSubview(labelInfoCustomer)
        
        let viewInfoCustomer = UIView(frame: CGRect(x: 0, y: labelInfoCustomer.frame.size.height + labelInfoCustomer.frame.origin.y, width: scrollView.frame.size.width, height: 100))
        viewInfoCustomer.backgroundColor = .white
        viewInfo.addSubview(viewInfoCustomer)
        
        
        let lblUsername = Common.tileLabel(x: Common.Size(s: 15), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Nhập họ tên hàng", fontSize: Common.Size(s:12))
         viewInfoCustomer.addSubview(lblUsername)
        
        
        tfUserName = Common.inputTextTextField(x: lblUsername.frame.origin.x, y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:40), placeholder: "Nhập họ tên khách hàng", fontSize: Common.Size(s:15), isNumber: false)
        viewInfoCustomer.addSubview(tfUserName)
        
        let lbGender = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfUserName.frame.size.height + tfUserName.frame.origin.y + Common.Size(s:13), width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: Common.Size(s:20)))
        lbGender.textAlignment = .left
        lbGender.textColor = .black
        lbGender.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbGender.text = "Giới tính:"
        lbGender.sizeToFit()
        viewInfoCustomer.addSubview(lbGender)
        
        radioMale = createRadioButton(CGRect(x: lbGender.frame.origin.x + lbGender.frame.size.width + Common.Size(s:20), y: tfUserName.frame.origin.y + tfUserName.frame.size.height, width: (tfUserName.frame.size.width + tfUserName.frame.origin.x - lbGender.frame.size.width - lbGender.frame.origin.x - Common.Size(s:20))/2 - Common.Size(s:10), height: Common.Size(s:30) + lbGender.frame.size.height), title: "Nam", color: UIColor.black);
        viewInfoCustomer.addSubview(radioMale)
        
        radioFemale = createRadioButton(CGRect(x: radioMale.frame.origin.x + radioMale.frame.size.width, y: radioMale.frame.origin.y , width: radioMale.frame.size.width,height: radioMale.frame.size.height), title: "Nữ", color: UIColor.black);
        viewInfoCustomer.addSubview(radioFemale)
        
        // input ngay sinh
  
        
        let lblBirthday = Common.tileLabel(x: lblUsername.frame.origin.x, y: radioMale.frame.origin.y + radioMale.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Nhập ngày sinh khách hàng", fontSize: Common.Size(s:12))
          viewInfoCustomer.addSubview(lblBirthday)
        
        
        tfBirthday = UITextField(frame: CGRect(x: lblUsername.frame.origin.x, y: lblBirthday.frame.origin.y + lblBirthday.frame.size.height + Common.Size(s:10), width: lblUsername.frame.size.width  , height: Common.Size(s:40)));
        tfBirthday.placeholder = "Ngày sinh"
        
        tfBirthday.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfBirthday.borderStyle = UITextField.BorderStyle.roundedRect
        tfBirthday.autocorrectionType = UITextAutocorrectionType.no
        tfBirthday.keyboardType = UIKeyboardType.numbersAndPunctuation
        tfBirthday.returnKeyType = UIReturnKeyType.done
        tfBirthday.clearButtonMode = UITextField.ViewMode.whileEditing
        tfBirthday.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center

        viewInfoCustomer.addSubview(tfBirthday)
        
     
        
        let lblAddress = Common.tileLabel(x: lblUsername.frame.origin.x, y: tfBirthday.frame.origin.y + tfBirthday.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height:  Common.Size(s:14), title: "Nhập số nhà & tên đường", fontSize: Common.Size(s:12))
        viewInfoCustomer.addSubview(lblAddress)
        
        
        
        tfAddress = Common.inputTextTextField(x: lblUsername.frame.origin.x, y: lblAddress.frame.origin.y + lblAddress.frame.size.height + Common.Size(s:10), width: lblUsername.frame.size.width, height: Common.Size(s:40), placeholder: "Nhập số nhà & tên đường", fontSize: Common.Size(s:15), isNumber: false)
        viewInfoCustomer.addSubview(tfAddress)
        
  
        
        let lblProvince = Common.tileLabel(x: lblUsername.frame.origin.x, y: tfAddress.frame.origin.y + tfAddress.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Chọn tỉnh/thành phố", fontSize: Common.Size(s:12))
        viewInfoCustomer.addSubview(lblProvince)
        
        
        tfProvince = Common.inputSearchTextField(x: lblUsername.frame.origin.x, y: lblProvince.frame.origin.y + lblProvince.frame.size.height + Common.Size(s:10), width: lblUsername.frame.size.width, height: Common.Size(s:40), isNumber: false)
        viewInfoCustomer.addSubview(tfProvince)
        
        let lblDistrict = Common.tileLabel(x: lblUsername.frame.origin.x, y: tfProvince.frame.origin.y + tfProvince.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Chọn quận huyện", fontSize: Common.Size(s:12))
         viewInfoCustomer.addSubview(lblDistrict)

        tfDistrict = Common.inputSearchTextField(x: lblUsername.frame.origin.x, y: lblDistrict.frame.origin.y + lblDistrict.frame.size.height + Common.Size(s:10), width: lblUsername.frame.size.width, height: Common.Size(s:40) , isNumber: false)
        viewInfoCustomer.addSubview(tfDistrict)
        
        let lblPrecinct = Common.tileLabel(x: lblUsername.frame.origin.x, y: tfDistrict.frame.origin.y + tfDistrict.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Nhập phường xã", fontSize: Common.Size(s:12))
        viewInfoCustomer.addSubview(lblPrecinct)
        
        
        tfPrecinct = Common.inputSearchTextField(x: lblUsername.frame.origin.x, y: lblPrecinct.frame.origin.y + lblPrecinct.frame.size.height + Common.Size(s:10), width: lblUsername.frame.size.width , height: Common.Size(s:40) , isNumber: false)
        viewInfoCustomer.addSubview(tfPrecinct)
        
        
        let lblNation = Common.tileLabel(x: lblUsername.frame.origin.x, y: tfPrecinct.frame.origin.y + tfPrecinct.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Quốc gia", fontSize: Common.Size(s:12))
        viewInfoCustomer.addSubview(lblNation)
 
        
        
        tfNation = Common.inputSearchTextField(x: lblUsername.frame.origin.x, y:lblNation.frame.origin.y + lblNation.frame.size.height + Common.Size(s:10), width: lblUsername.frame.size.width, height: Common.Size(s:40), isNumber: false)
        viewInfoCustomer.addSubview(tfNation)
        
        viewInfoCustomer.frame.size.height = tfNation.frame.size.height + tfNation.frame.origin.y + Common.Size(s:10)
        
        
        let labelLoaiGiayTo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewInfoCustomer.frame.size.height + viewInfoCustomer.frame.origin.y , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelLoaiGiayTo.text = "LOẠI GIẤY TỜ"
        labelLoaiGiayTo.textColor = UIColor(netHex:0x00955E)
        labelLoaiGiayTo.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewInfo.addSubview(labelLoaiGiayTo)
        
        let viewInfoLoaiGiayTo = UIView(frame: CGRect(x: 0, y: labelLoaiGiayTo.frame.size.height + labelLoaiGiayTo.frame.origin.y, width: scrollView.frame.size.width, height: 100))
        viewInfoLoaiGiayTo.backgroundColor = .white
        viewInfo.addSubview(viewInfoLoaiGiayTo)
        
        radioPassport = createRadioButton2(CGRect(x: lblUsername.frame.origin.x, y: Common.Size(s:10), width: lblUsername.frame.size.width/3, height: Common.Size(s:20)), title: "Passport", color: UIColor.black);
        viewInfoLoaiGiayTo.addSubview(radioPassport)
        
        radioCMND = createRadioButton2(CGRect(x: radioPassport.frame.origin.x + radioPassport.frame.size.width, y: Common.Size(s:10), width: lblUsername.frame.size.width/3, height: Common.Size(s:20)), title: "CMND", color: UIColor.black);
        viewInfoLoaiGiayTo.addSubview(radioCMND)
        
        radioCanCuoc = createRadioButton2(CGRect(x: radioCMND.frame.origin.x + radioCMND.frame.size.width, y: radioCMND.frame.origin.y , width: radioCMND.frame.size.width, height: radioCMND.frame.size.height), title: "Căn cước", color: UIColor.black);
        viewInfoLoaiGiayTo.addSubview(radioCanCuoc)
        
     
        
        labelTitleCMND = Common.tileLabel(x: Common.Size(s: 15), y: radioPassport.frame.size.height + radioPassport.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Số CMND/Căn Cước", fontSize: Common.Size(s:12))
        viewInfoLoaiGiayTo.addSubview(labelTitleCMND)
        
        radioCMND.isSelected = true
        
    
        
        tfCMND = Common.inputTextTextField(x: lblUsername.frame.origin.x, y: labelTitleCMND.frame.origin.y + labelTitleCMND.frame.size.height + Common.Size(s:10), width: lblUsername.frame.size.width, height: Common.Size(s:40), placeholder: "Số CMND/Căn Cước", fontSize: Common.Size(s:15), isNumber: true)
        
        viewInfoLoaiGiayTo.addSubview(tfCMND)
        
        let labelNgayCap =  UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfCMND.frame.size.height + tfCMND.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        labelNgayCap.textAlignment = .left
        labelNgayCap.textColor = UIColor.black
        labelNgayCap.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        labelNgayCap.text = "Ngày cấp"
        viewInfoLoaiGiayTo.addSubview(labelNgayCap)
        
        
        tfNgayCap = UITextField(frame: CGRect(x: lblUsername.frame.origin.x, y: labelNgayCap.frame.origin.y + labelNgayCap.frame.size.height + Common.Size(s:10), width: lblUsername.frame.size.width  , height: Common.Size(s:40)));
        tfNgayCap.placeholder = "Vui lòng nhập ngày cấp"
        
        tfNgayCap.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNgayCap.borderStyle = UITextField.BorderStyle.roundedRect
        tfNgayCap.autocorrectionType = UITextAutocorrectionType.no
        
        tfNgayCap.keyboardType = UIKeyboardType.default
        tfNgayCap.returnKeyType = UIReturnKeyType.done
        tfNgayCap.clearButtonMode = UITextField.ViewMode.whileEditing
        tfNgayCap.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfNgayCap.delegate = self
        viewInfoLoaiGiayTo.addSubview(tfNgayCap)
        

        
        let lablePlaceCreateCMND = Common.tileLabel(x: lblUsername.frame.origin.x, y: tfNgayCap.frame.origin.y + tfNgayCap.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Chọn nơi cấp", fontSize: Common.Size(s:12))
        viewInfoLoaiGiayTo.addSubview(lablePlaceCreateCMND)
        
    
        
        tfPlaceCreateCMND = Common.inputSearchTextField(x: lblUsername.frame.origin.x, y: lablePlaceCreateCMND.frame.origin.y + lablePlaceCreateCMND.frame.size.height + Common.Size(s:10), width:  lblUsername.frame.size.width , height: Common.Size(s:40), isNumber:false)
        viewInfoLoaiGiayTo.addSubview(tfPlaceCreateCMND)
     
        
        viewInfoLoaiGiayTo.frame.size.height = tfPlaceCreateCMND.frame.size.height + tfPlaceCreateCMND.frame.origin.y + Common.Size(s:10)
        
        
        let labeThongTinSim = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewInfoLoaiGiayTo.frame.size.height + viewInfoLoaiGiayTo.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labeThongTinSim.text = "THÔNG TIN THUÊ BAO"
        labeThongTinSim.textColor = UIColor(netHex:0x00955E)
        labeThongTinSim.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewInfo.addSubview(labeThongTinSim)
        
        
        let viewInfoThongTinSim = UIView(frame: CGRect(x: 0, y: labeThongTinSim.frame.size.height + labeThongTinSim.frame.origin.y, width: scrollView.frame.size.width, height: 100))
           viewInfoThongTinSim.backgroundColor = .white
           viewInfo.addSubview(viewInfoThongTinSim)
        
 
        
        let labelSDT = Common.tileLabel(x: lblUsername.frame.origin.x, y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Số điện thoại", fontSize: Common.Size(s:12))
        viewInfoThongTinSim.addSubview(labelSDT)
        
        
        tfSDT = Common.inputTextTextField(x: lblUsername.frame.origin.x, y: labelSDT.frame.origin.y + labelSDT.frame.size.height + Common.Size(s:10), width: lblUsername.frame.size.width, height: Common.Size(s:40), placeholder: "SĐT", fontSize: Common.Size(s:15), isNumber: true)
        tfSDT.text = sdt ?? ""
        viewInfoThongTinSim.addSubview(tfSDT)
        
        viewInfoThongTinSim.frame.size.height = tfSDT.frame.size.height  + tfSDT.frame.origin.y + Common.Size(s:10)
        
        
        let labelTitleAvarta = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewInfoThongTinSim.frame.size.height + viewInfoThongTinSim.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelTitleAvarta.text = "CHỤP CHÂN DUNG KHÁCH HÀNG"
        labelTitleAvarta.textColor = UIColor(netHex:0x00955E)
        labelTitleAvarta.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewInfo.addSubview(labelTitleAvarta)
        
        
        
        viewImageAvarta = UIView(frame: CGRect(x: 0, y: labelTitleAvarta.frame.size.height + labelTitleAvarta.frame.origin.y , width: scrollView.frame.size.width, height: 0))
        viewImageAvarta.clipsToBounds = true
        viewImageAvarta.backgroundColor = .white
        viewInfo.addSubview(viewImageAvarta)
        
        
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
        
    
        
        viewImageSign = UIView(frame: CGRect(x:0, y: viewImageAvarta.frame.origin.y + viewImageAvarta.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s:150)))
        viewImageSign.layer.borderWidth = 0.5
        viewImageSign.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSign.layer.cornerRadius = 3.0
        viewImageSign.backgroundColor = .white
        viewInfo.addSubview(viewImageSign)
        
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
        viewInfo.addSubview(viewOTP)
        
        
        let lblMaOTP = Common.tileLabel(x: lblUsername.frame.origin.x, y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Mã OTP", fontSize: Common.Size(s:12))
        viewOTP.addSubview(lblMaOTP)
        

        
        tfMaOTP = Common.inputTextTextField(x: lblUsername.frame.origin.x, y: lblMaOTP.frame.origin.y + lblMaOTP.frame.size.height + Common.Size(s:10), width: lblUsername.frame.size.width, height: Common.Size(s:40), placeholder: "", fontSize: Common.Size(s:15), isNumber: true)
        viewOTP.addSubview(tfMaOTP)
        
        viewOTP.frame.size.height = tfMaOTP.frame.size.height  + tfMaOTP.frame.origin.y + Common.Size(s:10)
        
        btCreateOrder = UIButton()
        btCreateOrder.frame = CGRect(x: lblUsername.frame.origin.x, y: viewOTP.frame.origin.y + viewOTP.frame.size.height + Common.Size(s:20), width: view.frame.size.width - Common.Size(s:30),height: Common.Size(s:40))
        btCreateOrder.backgroundColor = UIColor(netHex:0x00955E)
        btCreateOrder.setTitle("Cập nhật", for: .normal)
        btCreateOrder.addTarget(self, action: #selector(actionUpdate), for: .touchUpInside)
        btCreateOrder.layer.borderWidth = 0.5
        btCreateOrder.layer.borderColor = UIColor.white.cgColor
        btCreateOrder.layer.cornerRadius = 3
        viewInfo.addSubview(btCreateOrder)
        btCreateOrder.clipsToBounds = true
        
        
        viewInfo.frame.size.height = btCreateOrder.frame.size.height + btCreateOrder.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfo.frame.origin.y + viewInfo.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        fetchProvinces()
        fetchNation()
        handleClickItemProvince()
        handleClickItemDistrict()
        handleClickPrecinct()
        handleClickProvinceCMND()
        
        
    }
    
    
    // MARK: - API
    
    func SaveAPI(){
        guard let nameCustomer = tfUserName.text else{return}
        if(nameCustomer == ""){
            showDialog(message: "Vui lòng nhập tên khách hàng!")
            return
        }
        guard let birthday = tfBirthday.text else{return}
        if(birthday == ""){
            showDialog(message: "Vui lòng nhập ngày sinh KH!")
            return
        }
        guard let address = tfAddress.text else {return}
        if(address == ""){
            showDialog(message: "Vui lòng nhập địa chỉ KH!")
            return
        }
        guard let phoneNumber = tfSDT.text else {return}
        if(phoneNumber == ""){
            showDialog(message: "Vui lòng nhập số điện thoại!")
            return
        }
        
        if imgViewAvarta.image == UIImage(named:"UploadImage") {
            showDialog(message: "Vui lòng chụp ảnh khách hàng!")
            return
        }
        
        if imgViewSign == nil {
            showDialog(message: "Vui lòng nhập chữ ký!")
            return
        }
        
        var Passport = ""
        if typeKichHoat == 3 {
            Passport = tfCMND.text!
        }
        
        
    
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang cập nhật thông tin khách hàng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        let imageSign:UIImage = self.resizeImage(image: imgViewSign.image!,newHeight: 500)!
        let imageCMNDTruoc:UIImage = self.resizeImageWidth(image: imgViewImageCMNDFront.image!,newWidth: Common.resizeImageWith)!
        let imageCMNDSau:UIImage = self.resizeImageWidth(image: imgViewImageCMNDBehind.image!,newWidth: Common.resizeImageWith)!
        if let imageDataCMNDTruoc:NSData = imageCMNDTruoc.jpegData(compressionQuality: Common.resizeImageValue) as NSData?{
            
            let strBase64CMNDMatTruoc = imageDataCMNDTruoc.base64EncodedString(options: .endLineWithLineFeed)
            
            if let imageDataCMNDSau:NSData = imageCMNDSau.jpegData(compressionQuality: Common.resizeImageValue) as NSData?{
                let strBase64CMNDMatSau = imageDataCMNDSau.base64EncodedString(options: .endLineWithLineFeed)
                
                let imageAvatar:UIImage = self.resizeImageWidth(image: imgViewAvarta.image!,newWidth: Common.resizeImageWith)!
                if let imageDataChanDung:NSData = imageAvatar.jpegData(compressionQuality: Common.resizeImageValue) as NSData?{
                    
                    let strBase64ChanDung = imageDataChanDung.base64EncodedString(options: .endLineWithLineFeed)
                    
                    if let imageDataChuKy:NSData = imageSign.pngData() as NSData?{
                        let srtBase64ChuKy = imageDataChuKy.base64EncodedString(options: .endLineWithLineFeed)
                        

                        var newAddress = ""
                        if !hasAddress {
                            newAddress = "\(self.tfPrecinct.text ?? ""), \(self.tfDistrict.text ?? ""), \(self.tfProvince.text ?? "")".uppercased()
                        } else {
                            newAddress = tfAddress.text ?? ""
                        }
                        CRMAPIManager.UpdateCustomerResult_HDItelecom(p_NgaySinh_KH:tfBirthday.text!,
                                                                      p_CMND_KH:tfCMND.text!,
                                                                      p_NoiCapCMND_KH:tfPlaceCreateCMND.text!,
                                                                      p_HopDongSo:"",
                                                                      p_TenKH:tfUserName.text! ,
                                                                      p_QuocGia_KH:tfNation.text!,
                                                                      p_ChuKy:srtBase64ChuKy,
                                                                      p_SoDTLienHe:tfSDT.text!,
                                                                      p_NoiThuongTru_KH: newAddress,
                            p_GioiTinh_KH:"\(self.gender)",
                            p_NgayCapCMND_KH:tfNgayCap.text!,
                            handler: { (imageInfo, err) in
                            
                            if (err.count<=0){

                             
                                CRMAPIManager.Itel_UpdateSubscriberInfo(Image1: strBase64CMNDMatTruoc,
                                                                        Image2: strBase64CMNDMatSau,
                                                                        Image3: strBase64ChanDung,
                                                                        Image4: imageInfo!.ResultImage,
                                                                        Image5:"",
                                                                        Image6:"",
                                                                        Msisdn: self.tfSDT.text!,
                                                                        FullName: self.tfUserName.text!,
                                                                        Birthday: self.tfBirthday.text!,
                                                                        IdNumber: self.tfCMND.text!,
                                                                        Address: newAddress,
                                                                        Gender: "\(self.gender)",
                                                                        NationalityId: self.selectNational,
                                                                        LoaiGT: "\(self.typeKichHoat)",
                                                                        NoiCap: self.selectAddressCMND,
                                                                        LoaiKH: "4",
                                                                        SoVisa: "",
                                                                        SoVisaHH: "",
                                                                        MaXacThuc: self.tfMaOTP.text!,
                                                                        PlaceDate: self.tfNgayCap.text!,
                                                                        CusUse: "1",
                                                                        ProvinceCode: "\(self.selectProvice)",
                                DistrictCode: "\(self.selectDistrict)",
                                PrecinctCode: "\(self.selectPrecinct)",
                                Passport:Passport) { ( errCode, err) in
                                    let when = DispatchTime.now() + 0.5
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                        
                                        if(errCode=="SUCCESS"){
                                            let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                                                _ = self.navigationController?.popViewController(animated: true)
                                                    self.dismiss(animated: true, completion: nil)
                                            })
                                            self.present(alert, animated: true)
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
                MPOSAPIManager.GetinfoCustomerByImageIDCard(Image_CMND: strBase64CMNDTruoc, NhaMang: "Itelecom",Type:"1", handler: { (results, err) in
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            if(results.count > 0){
                                let item = results[0]
                                self.tfCMND.text = "\(item.CMND)"
                                
                                self.tfBirthday.text = "\(item.Birthday)"
                                self.tfNgayCap.text = "\(item.DateCreateCMND)"
                                self.hasAddress = item.Address == "" ? false : true
                                self.tfAddress.text = "\(item.Address)"
                                self.tfUserName.text = "\(item.FullName)"
                                
                                
                                
                                
                                let palaceCreateCMND = item.PalaceCreateCMND
                                let obj =  self.listProvices.filter{ $0.Value == "\(palaceCreateCMND)" }.first
                                if let _ = obj?.Value {
                                    self.tfPlaceCreateCMND.text = obj?.Text
                                    self.selectAddressCMND = (obj?.Value)!
                                }
                                let Provices = item.ProvinceCode
                                let obj2 =  self.listProvices.filter{ $0.Value == "\(Provices)" }.first
                                if let _ = obj2?.Value {
                                    self.tfProvince.text = obj2?.Text
                                    self.selectProvice = (obj2?.Value)!
                                }
                                let District = item.DistrictCode
                                MPOSAPIManager.GetDistricts(MaCodeTinh: "\(self.selectProvice)", NhaMang: "Itelecom", handler: { (results, error) in
                                    
                                    self.listDistricts = results
                                    var listDistrictTemp:[String] = []
                                    for item in results {
                                        listDistrictTemp.append(item.Text)
                                    }
                                    self.tfDistrict.filterStrings(listDistrictTemp)
                                    
                                    
                                    
                                    let obj3 =  self.listDistricts.filter{ $0.Value == "\(District)" }.first
                                    if let _ = obj3?.Value {
                                        
                                        
                                        self.tfDistrict.text = obj3?.Text
                                        self.selectDistrict = (obj3?.Value)!
                                        
                                        
                                        let Precinct = item.PrecinctCode
                                        MPOSAPIManager.GetPrecincts(MaCodeHUyen:  "\(self.selectDistrict)", MaCodeTinh: "\(self.selectProvice)", NhaMang: "Itelecom", handler: { (results, error) in
                                            
                                            self.listPrecincts = results
                                            var list:[String] = []
                                            for item in results {
                                                list.append(item.Text)
                                            }
                                            self.tfPrecinct.filterStrings(list)
                                            
                                            
                                            
                                            let obj4 =  self.listPrecincts.filter{ $0.Value == "\(Precinct)" }.first
                                            if let _ = obj4?.Value {
                                                
                                                self.tfPrecinct.text = obj4?.Text
                                                self.selectPrecinct = (obj4?.Value)!
                                                
                                            }
                                            
                                        })
                                        
                                        
                                    }
                                })
                                
                                if (item.Gender == 0){
                                    self.radioMale.isSelected = true
                                    self.gender = 0
                                }else if (item.Gender == 1){
                                    self.radioFemale.isSelected = true
                                    self.gender = 1
                                }
                                if(self.tfPlaceCreateCMND.text == "" ){
                                    let obj =  self.listProvices.filter{ $0.Text == "\(palaceCreateCMND)" }.first
                                    if let _ = obj?.Text {
                                        self.tfPlaceCreateCMND.text = obj?.Text
                                        self.selectAddressCMND = (obj?.Value)!
                                    }
                                }
                                if(self.tfProvince.text == "" ){
                                    let obj2 =  self.listProvices.filter{ $0.Text == "\(Provices)" }.first
                                    if let _ = obj2?.Text {
                                        self.tfProvince.text = obj2?.Text
                                        self.selectProvice = (obj2?.Value)!
                                    }
                                }
                                if(self.tfDistrict.text == ""){
                                    let obj3 =  self.listDistricts.filter{ $0.Text == "\(District)" }.first
                                    if let _ = obj3?.Text {
                                        
                                        self.tfDistrict.text = obj3?.Text
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
                MPOSAPIManager.GetinfoCustomerByImageIDCardSau(Image_CMND: strBase64CMNDSau, NhaMang: "Itelecom",Type:"2", handler: { (results, err) in
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            self.tfNgayCap.text = "\(results[0].issue_date)"
                            let obj =  self.listProvices.filter{ $0.Value == "\(results[0].issue_loc)" }.first
                            if let _ = obj?.Value {
                                self.tfPlaceCreateCMND.text = obj?.Text
                                self.selectAddressCMND = (obj?.Value)!
                            }
                        }else{
                            
                        }
                    }
                })
                
            }
            
        }

    }
    func fetchNation(){
        MPOSAPIManager.SearchNationality(Nhamang: "Itelecom", handler: { (results, error) in
            
            DispatchQueue.main.async(execute: { () -> Void in
                self.listNationality = results
                var list:[String] = []
                for item in results {
                    list.append(item.Name)
                }
                self.tfNation.filterStrings(list)
                let obj =  self.listNationality.filter{ $0.Code == "232" }.first
                if let obj1 = obj?.Name {
                    self.tfNation.text = obj1
                    self.selectNational = "\(obj!.Code)"
                }
            })
            
        })
    }
    func fetchProvinces(){
        MPOSAPIManager.GetProvinces(NhaMang: "Itelecom", handler: { (results, error) in
            
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.listProvices.removeAll()
                self.listProvices = results
                
                var list:[String] = []
                for item in self.listProvices {
                    list.append(item.Text)
                }
                self.tfProvince.filterStrings(list)
                self.tfPlaceCreateCMND.filterStrings(list)
                
            }
        })
        
    }
    
    
    func fetchDistrict(MaCodeTinh:String){
        MPOSAPIManager.GetDistricts(MaCodeTinh: "\(MaCodeTinh)", NhaMang: "Itelecom", handler: { (results, error) in
            self.listDistricts.removeAll()
            self.listDistricts = results
            var listDistrictTemp:[String] = []
            for item in results {
                listDistrictTemp.append(item.Text)
            }
            self.tfDistrict.filterStrings(listDistrictTemp)
        })
    }
    
    func fetchPrecincts(MaCodeHUyen:String, MaCodeTinh:String){
        MPOSAPIManager.GetPrecincts(MaCodeHUyen:  "\(MaCodeHUyen)", MaCodeTinh: "\(MaCodeTinh)", NhaMang: "Itelecom", handler: { (results, error) in
            self.listPrecincts.removeAll()
            self.listPrecincts = results
            var list:[String] = []
            for item in results {
                list.append(item.Text)
            }
            self.tfPrecinct.filterStrings(list)
        })
    }
    
  
    
    
    
    // MARK: - Selectors
    func handleClickItemProvince(){
        tfProvince.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfProvince.text = item.title
            
            self.selectDistrict = ""
            self.tfDistrict.text = ""
            
            self.selectPrecinct = ""
            self.tfPrecinct.text = ""
            
            let obj =  self.listProvices.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectProvice = "\(obj)"
                self.fetchDistrict(MaCodeTinh: obj)
            }
        }
    }
    func handleClickProvinceCMND(){
        tfPlaceCreateCMND.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfPlaceCreateCMND.text = item.title
            self.selectDistrict = item.title
 
            
            let obj =  self.listProvices.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectAddressCMND = "\(obj)"
      
            }
        }
      }
    
    func handleClickItemDistrict(){
        tfDistrict.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfDistrict.text = item.title
            let obj =  self.listDistricts.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectDistrict = "\(obj)"
                self.selectPrecinct = ""
                self.tfPrecinct.text = ""
                
                self.fetchPrecincts(MaCodeHUyen: "\(obj)", MaCodeTinh:"\(self.selectProvice)")
          
            }
        }
    }
    
    func handleClickPrecinct(){
        tfPrecinct.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfPrecinct.text = item.title
            let obj =  self.listPrecincts.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectPrecinct = "\(obj)"
            }
        }
    }
    
    func handleClickNation(){
        tfNation.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfNation.text = item.title
            //            self.selectNational = "\(item.title)"
            
            let obj =  self.listNationality.filter{ $0.Name == "\(item.title)" }.first
            if let obj = obj?.Code {
                self.selectNational = "\(obj)"
         
                
            }
        }
    }
    
    
    
    
    @objc func actionBack(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
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
    @objc func actionUpdate(){
        if imgViewImageCMNDFront.image == UIImage(named:"UploadImage") {
            showDialog(message: "Vui lòng chụp ảnh CMND mặt trước!")
            return
        }
        if imgViewImageCMNDBehind.image == UIImage(named:"UploadImage") {
            showDialog(message: "Vui lòng chụp ảnh CMND mặt sau!")
            return
        }
        
        if(selectProvice == ""){
            showDialog(message: "Vui lòng chọn tỉnh thành!")
            return
        }
        if(selectDistrict == ""){
            showDialog(message: "Vui lòng chọn nơi cấp!")
            return
        }
        if(selectPrecinct == ""){
            showDialog(message: "Vui lòng chọn phường xã!")
            return
        }
        
        SaveAPI()
    }
    

    
    
    // MARK: - Helpers
    
    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
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
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage? {
            
            let scale = newHeight / image.size.height
            let newWidth = image.size.width * scale
            UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
            
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage
        }
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    
    fileprivate func createRadioButton(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(self.logSelectedButton), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButton(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioMale.isSelected = false
            radioFemale.isSelected = false
            switch temp {
            case "Nam":
                gender = 0
                radioMale.isSelected = true
                break
            case "Nữ":
                gender = 1
                radioFemale.isSelected = true
                break
            default:
                gender = 1
                radioMale.isSelected = true
                break
            }
        }
    }
    fileprivate func createRadioButton2(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(self.logSelectedButton2), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButton2(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioCMND.isSelected = false
            radioCanCuoc.isSelected = false
            radioPassport.isSelected = false
            switch temp {
            case "CMND":
                typeKichHoat = 1
                radioCMND.isSelected = true
                labelTitleCMND.text = "Số CMND"
                tfCMND.placeholder = "Số CMND"
                tfCMND.keyboardType = UIKeyboardType.numberPad
                if(tfPlaceCreateCMND != nil){
                    tfPlaceCreateCMND.text = ""
                    tfPlaceCreateCMND.isUserInteractionEnabled = true
                }
                break
            case "Căn cước":
                typeKichHoat = 45
                radioCanCuoc.isSelected = true
                labelTitleCMND.text = "Số căn cước"
                tfCMND.placeholder = "Số căn cước"
                tfCMND.keyboardType = UIKeyboardType.numberPad
                if(tfPlaceCreateCMND != nil){
                    tfPlaceCreateCMND.text = ""
                    tfPlaceCreateCMND.isUserInteractionEnabled = true
                }
                break
            case "Passport":
                typeKichHoat = 3
                labelTitleCMND.text = "Số passport/cmnd"
                tfCMND.placeholder = "Số passport/cmnd"
                tfCMND.keyboardType = UIKeyboardType.default
                radioPassport.isSelected = true
                if(tfPlaceCreateCMND != nil){
                    tfPlaceCreateCMND.text = ""
                    if (tfPlaceCreateCMND.text!.count <= 0 ){
                        tfPlaceCreateCMND.text = "Cục xuất nhập cảnh"
                    }
                    tfPlaceCreateCMND.isUserInteractionEnabled = false
                }
                break
            default:
                typeKichHoat = 1
                radioCMND.isSelected = true
                labelTitleCMND.text = "Số CMND"
                tfCMND.placeholder = "Số CMND"
                break
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
    func reloadUI(){
        viewImageCMNDBehind.frame.origin.y = viewImageCMNDFront.frame.size.height + viewImageCMNDFront.frame.origin.y
        viewUpload.frame.size.height = viewImageCMNDBehind.frame.size.height + viewImageCMNDBehind.frame.origin.y + Common.Size(s: 10)
        viewInfo.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y
        viewImageSign.frame.origin.y = viewImageAvarta.frame.size.height + viewImageAvarta.frame.origin.y
        viewOTP.frame.origin.y = viewImageSign.frame.size.height + viewImageSign.frame.origin.y
        btCreateOrder.frame.origin.y = viewOTP.frame.size.height + viewOTP.frame.origin.y
        
        viewInfo.frame.size.height = btCreateOrder.frame.size.height + btCreateOrder.frame.origin.y + Common.Size(s: 10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfo.frame.origin.y + viewInfo.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
}
extension SimUpdateItelViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
extension SimUpdateItelViewController:EPSignatureDelegate{
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
        imgViewSign  = UIImageView(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:5), width: width - Common.Size(s: 30), height: heightImage))
        //        imgViewSignature.backgroundColor = .red
        imgViewSign.contentMode = .scaleAspectFit
        viewImageSign.addSubview(imgViewSign)
        imgViewSign.image = cropImage(image: signatureImage, toRect: boundingRect)
        
        viewImageSign.frame.size.height = imgViewSign.frame.size.height + imgViewSign.frame.origin.y + Common.Size(s:5)
        
        self.reloadUI()
        
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
  
    
    
}
