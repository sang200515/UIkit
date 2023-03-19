//
//  DetailSimCRMViewControllerV2.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import DLRadioButton
import DropDown
//import EPSignature
import Toaster
import AVFoundation
class DetailSimCRMViewControllerV2: UIViewController,UITextFieldDelegate,EPSignatureDelegate,DialogCustomersDelegate,ScanBarcodeViewControllerDelegate{
    var isSkipAI:Bool  = false
    var simActive:SimActive?
    var listSimBook: [SimActive]?
    var scrollView:UIScrollView!
    
    // quoc tich
    var nationalButton: SearchTextField!
    var listNationality:[National] = []
    var selectNational:String = ""
    
    // thong tin khach hang
    var tfUserName:UITextField!
    var radioMale:DLRadioButton!
    var radioFemale:DLRadioButton!
    var gender:Int = -1
    var tfBirthday:UITextField!
    var tfAddress:UITextField!
    var cityButton: SearchTextField!
    var selectProvice:String = ""
    var selectDistrict:String = ""
    var selectPrecinct:String = ""
    var districtButton: SearchTextField!
    var wardsButton: SearchTextField!
    var listProvices:[Province] = []
    var listDistricts:[District] = []
    var listPrecincts:[Precinct] = []
    
    var radioPassport:DLRadioButton!
    var radioCMND:DLRadioButton!
    var radioCanCuoc:DLRadioButton!
    
    var typeKichHoat:Int = -1
    var tfCMND:UITextField!
    var tfCrateDate:UITextField!
    var tfCreateAddress:SearchTextField!
    var selectAddressCMND:String = ""
    
    var tfNumSO:UITextField!
    
    var amountButton: UIButton!
    var tfSerialSim:UITextField!
    
    var viewSimInfoMore:UIView!
    var heightSimInfoMore:CGFloat = 0.0
    var lbSimInfoMore:UILabel!
    
    var viewImageUpload:UIView!
    
    var imgViewSignature: UIImageView!
    var viewImageSign:UIView!
    var viewSign:UIView!
    
    var btPay:UIButton!
    
    var viewImageCMNDTruoc:UIView!
    var imgViewCMNDTruoc: UIImageView!
    var viewCMNDTruoc:UIView!
    
    var viewCMNDSau:UIView!
    var viewImageCMNDSau:UIView!
    var imgViewCMNDSau: UIImageView!
    
    var viewAvatar:UIView!
    var viewImageAvatar:UIView!
    var imgViewAvatar: UIImageView!
    
    var posImageUpload:Int = -1
    var viewCustomerInfoCMND:UIView!
    var viewCustomerInfoPassport:UIView!
    
    var tfPassport:UITextField!
    var tfCrateDatePassport:UITextField!
    var tfPalaceCreatePassport:UITextField!
    var tfVisa:UITextField!
    
    var viewInfoBottom:UIView!
    var viewCustomerInfo:UIView!
    
    var isVietNam:Bool = true
    var imagePicker = UIImagePickerController()
    var lblSoNha:UILabel!
    var tfSoNha:UITextField!
    var lblTenDuong:UILabel!
    var tfTenDuong:UITextField!
    var lblApThon:UILabel!
    var tfApThon:UITextField!
    var lblWarningInfo:UILabel!
    var lblNoteSoNha:UILabel!
    var lblNoteTenDuong:UILabel!
    var lblNoteApThon:UILabel!
    var lblTo:UILabel!
    var tfTo:UITextField!
    var lblNoteTo:UILabel!
    var lan:Int = 0
    var hasAddress = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        if(Int(simActive!.POSSODocNum)! < 0){
            self.title = "\(0)"
        }else{
            self.title = "\(simActive!.POSSODocNum)"
        }
        if scrollView == nil {
            scrollView = UIScrollView(frame: UIScreen.main.bounds)
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height + (UIApplication.shared.statusBarFrame.height))
            scrollView.backgroundColor = UIColor.white
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = false
            self.view.addSubview(scrollView)
        }
        
        let lbImageInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:20)))
        lbImageInfo.textAlignment = .left
        lbImageInfo.textColor = UIColor(netHex:0x47B054)
        lbImageInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbImageInfo.text = "HÌNH ẢNH"
        scrollView.addSubview(lbImageInfo)
        
        viewCMNDTruoc = UIView(frame: CGRect(x: Common.Size(s:20), y: lbImageInfo.frame.origin.y + lbImageInfo.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: 0))
        viewCMNDTruoc.clipsToBounds = true
        scrollView.addSubview(viewCMNDTruoc)
        
        let lbTextCMNDTruoc = UILabel(frame: CGRect(x: 0, y: 0, width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: Common.Size(s:20)))
        lbTextCMNDTruoc.textAlignment = .left
        lbTextCMNDTruoc.textColor = UIColor(netHex:0x47B054)
        lbTextCMNDTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:18))
        lbTextCMNDTruoc.text = "Mặt trước chứng minh nhân dân"
        lbTextCMNDTruoc.sizeToFit()
        viewCMNDTruoc.addSubview(lbTextCMNDTruoc)
        
        viewImageCMNDTruoc = UIView(frame: CGRect(x:0, y: lbTextCMNDTruoc.frame.origin.y + lbTextCMNDTruoc.frame.size.height + Common.Size(s:5), width: viewCMNDTruoc.frame.size.width, height: Common.Size(s:60)))
        viewImageCMNDTruoc.layer.borderWidth = 0.5
        viewImageCMNDTruoc.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDTruoc.layer.cornerRadius = 3.0
        viewCMNDTruoc.addSubview(viewImageCMNDTruoc)
        
        let tapShowCMNDTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDTruoc))
        viewCMNDTruoc.isUserInteractionEnabled = true
        viewCMNDTruoc.addGestureRecognizer(tapShowCMNDTruoc)
        
        
        let MT23 = viewImageCMNDTruoc.frame.size.height * 2/3
        let xViewMT = viewImageCMNDTruoc.frame.size.width/2 - MT23/2
        let viewCMNDTruocButton = UIImageView(frame: CGRect(x:xViewMT , y: 0, width: viewImageCMNDTruoc.frame.size.height * 2/3, height: viewImageCMNDTruoc.frame.size.height * 2/3))
        
        viewCMNDTruocButton.image = UIImage(named:"AddImage")
        viewCMNDTruocButton.contentMode = .scaleAspectFit
        viewImageCMNDTruoc.addSubview(viewCMNDTruocButton)
        
        let lbCMNDTruocButton = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: viewImageCMNDTruoc.frame.size.width, height: viewImageCMNDTruoc.frame.size.height/3))
        lbCMNDTruocButton.textAlignment = .center
        lbCMNDTruocButton.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDTruocButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTruocButton.text = "Thêm hình ảnh"
        viewImageCMNDTruoc.addSubview(lbCMNDTruocButton)
        
        viewCMNDTruoc.frame.size.height = viewImageCMNDTruoc.frame.origin.y + viewImageCMNDTruoc.frame.size.height
        //sau
        
        viewCMNDSau = UIView(frame: CGRect(x: Common.Size(s:20), y: viewCMNDTruoc.frame.origin.y + viewCMNDTruoc.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: 0))
        viewCMNDSau.clipsToBounds = true
        scrollView.addSubview(viewCMNDSau)
        
        let lbTextCMNDSau = UILabel(frame: CGRect(x: 0, y: 0, width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: Common.Size(s:20)))
        lbTextCMNDSau.textAlignment = .left
        lbTextCMNDSau.textColor = UIColor(netHex:0x47B054)
        lbTextCMNDSau.font = UIFont.systemFont(ofSize: Common.Size(s:18))
        lbTextCMNDSau.text = "Mặt sau chứng minh nhân dân"
        lbTextCMNDSau.sizeToFit()
        viewCMNDSau.addSubview(lbTextCMNDSau)
        
        viewImageCMNDSau = UIView(frame: CGRect(x:0, y: lbTextCMNDSau.frame.origin.y + lbTextCMNDSau.frame.size.height + Common.Size(s:5), width: viewCMNDSau.frame.size.width, height: Common.Size(s:60)))
        viewImageCMNDSau.layer.borderWidth = 0.5
        viewImageCMNDSau.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDSau.layer.cornerRadius = 3.0
        viewCMNDSau.addSubview(viewImageCMNDSau)
        
        
        let MS23 = viewImageCMNDSau.frame.size.height * 2/3
        let xViewMS = viewImageCMNDSau.frame.size.width/2 - MS23/2
        let viewCMNDSauButton = UIImageView(frame: CGRect(x: xViewMS, y: 0, width: viewImageCMNDSau.frame.size.height * 2/3, height: viewImageCMNDSau.frame.size.height * 2/3))
        viewCMNDSauButton.image = UIImage(named:"AddImage")
        viewCMNDSauButton.contentMode = .scaleAspectFit
        viewImageCMNDSau.addSubview(viewCMNDSauButton)
        
        let lbCMNDSauButton = UILabel(frame: CGRect(x: 0, y: viewCMNDSauButton.frame.size.height + viewCMNDSauButton.frame.origin.y, width: viewImageCMNDSau.frame.size.width, height: viewImageCMNDSau.frame.size.height/3))
        lbCMNDSauButton.textAlignment = .center
        lbCMNDSauButton.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDSauButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDSauButton.text = "Thêm hình ảnh"
        viewImageCMNDSau.addSubview(lbCMNDSauButton)
        
        viewCMNDSau.frame.size.height = viewImageCMNDSau.frame.origin.y + viewImageCMNDSau.frame.size.height
        
        let tapShowCMNDSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDSau))
        viewCMNDSau.isUserInteractionEnabled = true
        viewCMNDSau.addGestureRecognizer(tapShowCMNDSau)
        
        
        viewCustomerInfo = UIView(frame:CGRect(x: 0, y: viewCMNDSau.frame.origin.y + viewCMNDSau.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width , height: Common.Size(s:80)))
        //        viewCustomerInfo.backgroundColor = .red
        viewCustomerInfo.clipsToBounds = true
        scrollView.addSubview(viewCustomerInfo)
        
        
        let lbUserInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y:0, width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:20)))
        lbUserInfo.textAlignment = .left
        lbUserInfo.textColor = UIColor(netHex:0x47B054)
        lbUserInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbUserInfo.text = "THÔNG TIN KHÁCH HÀNG"
        viewCustomerInfo.addSubview(lbUserInfo)
        
        //input name info
        tfUserName = UITextField(frame: CGRect(x: lbUserInfo.frame.origin.x, y: lbUserInfo.frame.origin.y + lbUserInfo.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfUserName.placeholder = "Họ tên khách hàng"
        tfUserName.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfUserName.borderStyle = UITextField.BorderStyle.roundedRect
        tfUserName.autocorrectionType = UITextAutocorrectionType.no
        tfUserName.keyboardType = UIKeyboardType.default
        tfUserName.returnKeyType = UIReturnKeyType.done
        tfUserName.clearButtonMode = UITextField.ViewMode.whileEditing
        tfUserName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfUserName.delegate = self
        viewCustomerInfo.addSubview(tfUserName)
        
        tfUserName.leftViewMode = UITextField.ViewMode.always
        let imageUser = UIImageView(frame: CGRect(x: tfUserName.frame.size.height/4, y: tfUserName.frame.size.height/4, width: tfUserName.frame.size.height/2, height: tfUserName.frame.size.height/2))
        imageUser.image = UIImage(named: "User-501")
        imageUser.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewUser = UIView()
        leftViewUser.addSubview(imageUser)
        leftViewUser.frame = CGRect(x: 0, y: 0, width: tfUserName.frame.size.height, height: tfUserName.frame.size.height)
        tfUserName.leftView = leftViewUser
        
        if let fullName = simActive?.FullName {
            tfUserName.text = fullName
        }
        //------------
        let lbGender = UILabel(frame: CGRect(x: Common.Size(s:20), y: tfUserName.frame.size.height + tfUserName.frame.origin.y + Common.Size(s:15), width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: Common.Size(s:20)))
        lbGender.textAlignment = .left
        lbGender.textColor = UIColor(netHex:0x47B054)
        lbGender.font = UIFont.systemFont(ofSize: Common.Size(s:18))
        lbGender.text = "Giới tính:"
        lbGender.sizeToFit()
        viewCustomerInfo.addSubview(lbGender)
        
        radioMale = createRadioButton(CGRect(x: lbGender.frame.origin.x + lbGender.frame.size.width + Common.Size(s:20), y: tfUserName.frame.origin.y + tfUserName.frame.size.height, width: (tfUserName.frame.size.width + tfUserName.frame.origin.x - lbGender.frame.size.width - lbGender.frame.origin.x - Common.Size(s:20))/2 - Common.Size(s:10), height: Common.Size(s:30) + lbGender.frame.size.height), title: "Nam", color: UIColor.black);
        viewCustomerInfo.addSubview(radioMale)
        
        radioFemale = createRadioButton(CGRect(x: radioMale.frame.origin.x + radioMale.frame.size.width, y: radioMale.frame.origin.y , width: radioMale.frame.size.width,height: radioMale.frame.size.height), title: "Nữ", color: UIColor.black);
        viewCustomerInfo.addSubview(radioFemale)
        
        
        if let genderIn = simActive?.Gender {
            if (genderIn == 0){
                radioMale.isSelected = true
                gender = 1
            }else if (genderIn == 1){
                radioFemale.isSelected = true
                gender = 2
            }
        }
        
        //input birthday info
        tfBirthday = UITextField(frame: CGRect(x: tfUserName.frame.origin.x, y: lbGender.frame.origin.y + lbGender.frame.size.height + Common.Size(s:15), width: tfUserName.frame.size.width , height: tfUserName.frame.size.height ));
        tfBirthday.placeholder = "Ngày sinh (dd/MM/yyyy)"
        tfBirthday.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfBirthday.borderStyle = UITextField.BorderStyle.roundedRect
        tfBirthday.autocorrectionType = UITextAutocorrectionType.no
        tfBirthday.keyboardType = UIKeyboardType.default
        tfBirthday.returnKeyType = UIReturnKeyType.done
        tfBirthday.clearButtonMode = UITextField.ViewMode.whileEditing
        tfBirthday.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfBirthday.delegate = self
        //                tfBirthday.addTarget(self, action: #selector(textFieldBirthday(_:)), for: .editingDidBegin)
        viewCustomerInfo.addSubview(tfBirthday)
        
        tfBirthday.leftViewMode = UITextField.ViewMode.always
        let imageBifthday = UIImageView(frame: CGRect(x: tfUserName.frame.size.height/4, y: tfUserName.frame.size.height/4, width: tfUserName.frame.size.height/2, height: tfUserName.frame.size.height/2))
        imageBifthday.image = UIImage(named: "Gift Card-50")
        imageBifthday.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewBirthday = UIView()
        leftViewBirthday.addSubview(imageBifthday)
        leftViewBirthday.frame = CGRect(x: 0, y: 0, width: tfUserName.frame.size.height, height: tfUserName.frame.size.height)
        tfBirthday.leftView = leftViewBirthday
        
        
        if let birthday = simActive?.Birthday {
            tfBirthday.text = birthday
        }
        //-------------------
        
  
        
        
        lblSoNha = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: tfBirthday.frame.size.height + tfBirthday.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSoNha.textAlignment = .left
        lblSoNha.textColor = UIColor.black
        lblSoNha.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSoNha.text = "Số Nhà"
        viewCustomerInfo.addSubview(lblSoNha)
        
        tfSoNha = UITextField(frame: CGRect(x: tfUserName.frame.origin.x, y: lblSoNha.frame.origin.y + lblSoNha.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width , height: Common.Size(s:40)));
        tfSoNha.placeholder = "Số nhà!"
        tfSoNha.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSoNha.borderStyle = UITextField.BorderStyle.roundedRect
        tfSoNha.autocorrectionType = UITextAutocorrectionType.no
        tfSoNha.keyboardType = UIKeyboardType.default
        tfSoNha.returnKeyType = UIReturnKeyType.done
        tfSoNha.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSoNha.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSoNha.delegate = self
        viewCustomerInfo.addSubview(tfSoNha)
        
        lblNoteSoNha = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: tfSoNha.frame.size.height + tfSoNha.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:30)))
        lblNoteSoNha.textAlignment = .left
        lblNoteSoNha.textColor = .red
        lblNoteSoNha.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNoteSoNha.numberOfLines = 0
        lblNoteSoNha.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        lblNoteSoNha.minimumScaleFactor = 0.8
        lblNoteSoNha.text = "Nhập đúng thông tin SỐ NHÀ của khách hàng. Nếu không có để trống."
        viewCustomerInfo.addSubview(lblNoteSoNha)
        
        lblTenDuong = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lblNoteSoNha.frame.size.height + lblNoteSoNha.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTenDuong.textAlignment = .left
        lblTenDuong.textColor = UIColor.black
        lblTenDuong.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTenDuong.text = "Tên đường"
        viewCustomerInfo.addSubview(lblTenDuong)
        
        tfTenDuong = UITextField(frame: CGRect(x: tfUserName.frame.origin.x, y: lblTenDuong.frame.origin.y + lblTenDuong.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width , height: Common.Size(s:40)));
        tfTenDuong.placeholder = "Tên đường"
        tfTenDuong.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTenDuong.borderStyle = UITextField.BorderStyle.roundedRect
        tfTenDuong.autocorrectionType = UITextAutocorrectionType.no
        tfTenDuong.keyboardType = UIKeyboardType.default
        tfTenDuong.returnKeyType = UIReturnKeyType.done
        tfTenDuong.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTenDuong.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTenDuong.delegate = self
        viewCustomerInfo.addSubview(tfTenDuong)
        
        lblNoteTenDuong = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: tfTenDuong.frame.size.height + tfTenDuong.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:30)))
        lblNoteTenDuong.textAlignment = .left
        lblNoteTenDuong.textColor = .red
        lblNoteTenDuong.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNoteTenDuong.numberOfLines = 0
        lblNoteTenDuong.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        lblNoteTenDuong.minimumScaleFactor = 0.8
        lblNoteTenDuong.text = "Nhập đúng thông tin TÊN ĐƯỜNG của khách hàng. Nếu không có để trống."
        viewCustomerInfo.addSubview(lblNoteTenDuong)
        //vinaphone
        lblTo = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lblNoteTenDuong.frame.size.height + lblNoteTenDuong.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTo.textAlignment = .left
        lblTo.textColor = UIColor.black
        lblTo.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTo.text = "Tổ"
        viewCustomerInfo.addSubview(lblTo)
        
        tfTo = UITextField(frame: CGRect(x: tfUserName.frame.origin.x, y: lblTo.frame.origin.y + lblTo.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width , height: Common.Size(s:40)));
        tfTo.placeholder = "Nhập thông tin tổ"
        tfTo.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTo.borderStyle = UITextField.BorderStyle.roundedRect
        tfTo.autocorrectionType = UITextAutocorrectionType.no
        tfTo.keyboardType = UIKeyboardType.default
        tfTo.returnKeyType = UIReturnKeyType.done
        tfTo.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTo.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTo.delegate = self
        viewCustomerInfo.addSubview(tfTo)
        
        lblNoteTo = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: tfTo.frame.size.height + tfTo.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:30)))
        lblNoteTo.textAlignment = .left
        lblNoteTo.textColor = .red
        lblNoteTo.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNoteTo.numberOfLines = 0
        lblNoteTo.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        lblNoteTo.minimumScaleFactor = 0.8
        lblNoteTo.text = "Nhập đúng thông tin TỔ của khách hàng. Nếu không có để trống."
        viewCustomerInfo.addSubview(lblNoteTo)
        //
        
        lblApThon = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: lblNoteTo.frame.size.height + lblNoteTo.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblApThon.textAlignment = .left
        lblApThon.textColor = UIColor.black
        lblApThon.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblApThon.text = "Ấp/Thôn/Xóm/Khu Phố"
        viewCustomerInfo.addSubview(lblApThon)
        
        tfApThon = UITextField(frame: CGRect(x: tfUserName.frame.origin.x, y: lblApThon.frame.origin.y + lblApThon.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width , height: Common.Size(s:40)));
        tfApThon.placeholder = "Ấp/Thôn/Xóm/Khu Phố"
        tfApThon.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfApThon.borderStyle = UITextField.BorderStyle.roundedRect
        tfApThon.autocorrectionType = UITextAutocorrectionType.no
        tfApThon.keyboardType = UIKeyboardType.default
        tfApThon.returnKeyType = UIReturnKeyType.done
        tfApThon.clearButtonMode = UITextField.ViewMode.whileEditing
        tfApThon.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfApThon.delegate = self
        viewCustomerInfo.addSubview(tfApThon)
        
        lblNoteApThon = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: tfApThon.frame.size.height + tfApThon.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:50)))
        lblNoteApThon.textAlignment = .left
        lblNoteApThon.textColor = .red
        lblNoteApThon.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNoteApThon.numberOfLines = 0
        lblNoteApThon.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        lblNoteApThon.minimumScaleFactor = 0.8
        lblNoteApThon.text = "Nhập đúng thông tin ẤP hoặc THÔN hoặc XÓM hoặc KHU PHỐ (nếu có) của khách hàng. Nếu không có để trống."
        viewCustomerInfo.addSubview(lblNoteApThon)
        
        
        //address
        tfAddress = UITextField(frame: CGRect(x: tfBirthday.frame.origin.x, y: lblNoteApThon.frame.origin.y + lblNoteApThon.frame.size.height, width: tfBirthday.frame.size.width , height: 0 ));
        tfAddress.placeholder = "Nhập số nhà & tên đường"
        tfAddress.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfAddress.borderStyle = UITextField.BorderStyle.roundedRect
        tfAddress.autocorrectionType = UITextAutocorrectionType.no
        tfAddress.keyboardType = UIKeyboardType.default
        tfAddress.returnKeyType = UIReturnKeyType.done
        tfAddress.clearButtonMode = UITextField.ViewMode.whileEditing
        tfAddress.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfAddress.delegate = self
        //        tfUserName.addTarget(self, action: #selector(textFieldDidChangeName(_:)), for: .editingChanged)
        viewCustomerInfo.addSubview(tfAddress)
        //--------------------
        if("\(self.simActive!.Provider)" != "Mobifone" && "\(self.simActive!.Provider)" != "Vinaphone"){
       
            
            lblSoNha.frame.origin.y = tfBirthday.frame.size.height + tfBirthday.frame.origin.y
            lblSoNha.frame.size.height = 0
            tfSoNha.frame.origin.y = lblSoNha.frame.origin.y + lblSoNha.frame.size.height
            tfSoNha.frame.size.height = 0
            lblNoteSoNha.frame.origin.y = tfSoNha.frame.size.height + tfSoNha.frame.origin.y
            lblNoteSoNha.frame.size.height = 0
            lblTenDuong.frame.size.height = 0
            lblTenDuong.frame.origin.y = lblNoteSoNha.frame.origin.y + lblNoteSoNha.frame.size.height
            tfTenDuong.frame.size.height = 0
            tfTenDuong.frame.origin.y = lblTenDuong.frame.origin.y + lblTenDuong.frame.size.height
            lblNoteTenDuong.frame.origin.y = tfTenDuong.frame.size.height + tfTenDuong.frame.origin.y
            lblNoteTenDuong.frame.size.height = 0
            //
            lblTo.frame.size.height = 0
            lblTo.frame.origin.y = lblNoteTenDuong.frame.origin.y + lblNoteTenDuong.frame.size.height
            tfTo.frame.size.height = 0
            tfTo.frame.origin.y = lblTo.frame.origin.y + lblTo.frame.size.height
            lblNoteTo.frame.origin.y = tfTo.frame.size.height + tfTo.frame.origin.y
            lblNoteTo.frame.size.height = 0
            
      
            //
            lblApThon.frame.size.height = 0
            lblApThon.frame.origin.y = lblNoteTo.frame.origin.y + lblNoteTo.frame.size.height
            tfApThon.frame.size.height = 0
            tfApThon.frame.origin.y = lblApThon.frame.origin.y + lblApThon.frame.size.height
            lblNoteApThon.frame.origin.y = tfApThon.frame.size.height + tfApThon.frame.origin.y
            lblNoteApThon.frame.size.height = 0
            
            tfAddress.frame.size.height = tfBirthday.frame.size.height
            tfAddress.frame.origin.y = lblNoteApThon.frame.size.height + lblNoteApThon.frame.origin.y + Common.Size(s:10)
            
            tfAddress.leftViewMode = UITextField.ViewMode.always
            let imageAddress = UIImageView(frame: CGRect(x: tfAddress.frame.size.height/4, y: tfAddress.frame.size.height/4, width: tfAddress.frame.size.height/2, height: tfAddress.frame.size.height/2))
            imageAddress.image = UIImage(named: "Home-50-1")
            imageAddress.contentMode = UIView.ContentMode.scaleAspectFit
            
            let leftViewAddress = UIView()
            leftViewAddress.addSubview(imageAddress)
            leftViewAddress.frame = CGRect(x: 0, y: 0, width: tfUserName.frame.size.height, height: tfUserName.frame.size.height)
            tfAddress.leftView = leftViewAddress
            
            if let address = simActive?.Address {
                tfAddress.text = address
            }
            
        }else if(self.simActive!.Provider == "Mobifone"){
        
            
            lblSoNha.frame.origin.y = tfBirthday.frame.size.height + tfBirthday.frame.origin.y + Common.Size(s: 10)
            tfSoNha.frame.origin.y = lblSoNha.frame.origin.y + lblSoNha.frame.size.height + Common.Size(s: 10)
            lblNoteSoNha.frame.origin.y = tfSoNha.frame.size.height + tfSoNha.frame.origin.y + Common.Size(s: 10)
            lblTenDuong.frame.origin.y = lblNoteSoNha.frame.origin.y + lblNoteSoNha.frame.size.height + Common.Size(s: 10)
            tfTenDuong.frame.origin.y = lblTenDuong.frame.origin.y + lblTenDuong.frame.size.height + Common.Size(s: 10)
            lblNoteTenDuong.frame.origin.y = tfTenDuong.frame.size.height + tfTenDuong.frame.origin.y + Common.Size(s: 10)
            lblTo.frame.origin.y = lblNoteTenDuong.frame.origin.y + lblNoteTenDuong.frame.size.height + Common.Size(s: 10)
            tfTo.frame.origin.y = lblTo.frame.origin.y + lblTo.frame.size.height + Common.Size(s: 10)
            lblNoteTo.frame.origin.y = tfTo.frame.size.height + tfTo.frame.origin.y + Common.Size(s:10)
              lblApThon.frame.origin.y = lblNoteTo.frame.origin.y + lblNoteTo.frame.size.height + Common.Size(s:10)
               tfApThon.frame.origin.y = lblApThon.frame.origin.y + lblApThon.frame.size.height + Common.Size(s:10)
               lblNoteApThon.frame.origin.y = tfApThon.frame.size.height + tfApThon.frame.origin.y + Common.Size(s:10)
               tfAddress.frame.origin.y = lblNoteApThon.frame.size.height + lblNoteApThon.frame.origin.y + Common.Size(s:10)
        }else if(self.simActive!.Provider == "Vinaphone"){
            lblApThon.frame.size.height = 0
            lblApThon.frame.origin.y = lblNoteTo.frame.origin.y + lblNoteTo.frame.size.height
            tfApThon.frame.size.height = 0
            tfApThon.frame.origin.y = lblApThon.frame.origin.y + lblApThon.frame.size.height
            lblNoteApThon.frame.origin.y = tfApThon.frame.size.height + tfApThon.frame.origin.y
            lblNoteApThon.frame.size.height = 0
            
            tfAddress.frame.size.height = 0
            tfAddress.frame.origin.y = lblNoteApThon.frame.size.height + lblNoteApThon.frame.origin.y + Common.Size(s:10)
            
          
        }
        //address
        cityButton = SearchTextField(frame: CGRect(x: tfAddress.frame.origin.x, y: tfAddress.frame.origin.y + tfAddress.frame.size.height + Common.Size(s:10), width: tfBirthday.frame.size.width , height: tfBirthday.frame.size.height ));
        
        cityButton.placeholder = "Tỉnh/Thành phố"
        cityButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        cityButton.borderStyle = UITextField.BorderStyle.roundedRect
        cityButton.autocorrectionType = UITextAutocorrectionType.no
        cityButton.keyboardType = UIKeyboardType.default
        cityButton.returnKeyType = UIReturnKeyType.done
        cityButton.clearButtonMode = UITextField.ViewMode.whileEditing
        cityButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        cityButton.delegate = self
        viewCustomerInfo.addSubview(cityButton)
        
        // Start visible - Default: false
        cityButton.startVisible = true
        cityButton.theme.bgColor = UIColor.white
        cityButton.theme.fontColor = UIColor.black
        cityButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        cityButton.theme.cellHeight = Common.Size(s:40)
        cityButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        cityButton.leftViewMode = UITextField.ViewMode.always
        let imageButton = UIImageView(frame: CGRect(x: tfUserName.frame.size.height/4, y: tfUserName.frame.size.height/4, width: tfUserName.frame.size.height/2, height: tfUserName.frame.size.height/2))
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
                MPOSAPIManager.GetDistricts(MaCodeTinh: "\(obj)", NhaMang: "\(self.simActive!.Provider)", handler: { (results, error) in
                    self.listDistricts = results
                    var listDistrictTemp:[String] = []
                    for item in results {
                        listDistrictTemp.append(item.Text)
                    }
                    self.districtButton.filterStrings(listDistrictTemp)
                })
            }
        }
        //-----------------
        districtButton = SearchTextField(frame: CGRect(x: tfUserName.frame.origin.x, y: cityButton.frame.origin.y + cityButton.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width , height: tfUserName.frame.size.height ));
        districtButton.placeholder = "Quận/Huyện"
        districtButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        districtButton.borderStyle = UITextField.BorderStyle.roundedRect
        districtButton.autocorrectionType = UITextAutocorrectionType.no
        districtButton.keyboardType = UIKeyboardType.default
        districtButton.returnKeyType = UIReturnKeyType.done
        districtButton.clearButtonMode = UITextField.ViewMode.whileEditing
        districtButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        districtButton.delegate = self
        viewCustomerInfo.addSubview(districtButton)
        
        // Start visible - Default: false
        districtButton.startVisible = true
        districtButton.theme.bgColor = UIColor.white
        districtButton.theme.fontColor = UIColor.black
        districtButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        districtButton.theme.cellHeight = Common.Size(s:40)
        districtButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        districtButton.leftViewMode = UITextField.ViewMode.always
        let imageButtonDistrict = UIImageView(frame: CGRect(x: tfUserName.frame.size.height/4, y: tfUserName.frame.size.height/4, width: tfUserName.frame.size.height/2, height: tfUserName.frame.size.height/2))
        imageButtonDistrict.image = UIImage(named: "German House-50")
        imageButtonDistrict.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewDistrictButton = UIView()
        leftViewDistrictButton.addSubview(imageButtonDistrict)
        leftViewDistrictButton.frame = CGRect(x: 0, y: 0, width: cityButton.frame.size.height, height: cityButton.frame.size.height)
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
                MPOSAPIManager.GetPrecincts(MaCodeHUyen:  "\(obj)", MaCodeTinh: "\(self.selectProvice)", NhaMang: "\(self.simActive!.Provider)", handler: { (results, error) in
                    self.listPrecincts = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Text)
                    }
                    self.wardsButton.filterStrings(list)
                })
            }
        }
        //---------------
        wardsButton = SearchTextField(frame: CGRect(x: tfUserName.frame.origin.x, y: districtButton.frame.origin.y + districtButton.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width , height: tfUserName.frame.size.height ));
        wardsButton.placeholder = "Phường/Xã"
        wardsButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        wardsButton.borderStyle = UITextField.BorderStyle.roundedRect
        wardsButton.autocorrectionType = UITextAutocorrectionType.no
        wardsButton.keyboardType = UIKeyboardType.default
        wardsButton.returnKeyType = UIReturnKeyType.done
        wardsButton.clearButtonMode = UITextField.ViewMode.whileEditing
        wardsButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        wardsButton.delegate = self
        viewCustomerInfo.addSubview(wardsButton)
        
        // Start visible - Default: false
        wardsButton.startVisible = true
        wardsButton.theme.bgColor = UIColor.white
        wardsButton.theme.fontColor = UIColor.black
        wardsButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        wardsButton.theme.cellHeight = Common.Size(s:40)
        wardsButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        wardsButton.leftViewMode = UITextField.ViewMode.always
        let imageButtonWards = UIImageView(frame: CGRect(x: tfUserName.frame.size.height/4, y: tfUserName.frame.size.height/4, width: tfUserName.frame.size.height/2, height: tfUserName.frame.size.height/2))
        imageButtonWards.image = UIImage(named: "Visit-50")
        imageButtonWards.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewWardsButton = UIView()
        leftViewWardsButton.addSubview(imageButtonWards)
        leftViewWardsButton.frame = CGRect(x: 0, y: 0, width: cityButton.frame.size.height, height: cityButton.frame.size.height)
        wardsButton.leftView = leftViewWardsButton
        wardsButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.wardsButton.text = item.title
            let obj =  self.listPrecincts.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectPrecinct = "\(obj)"
            }
        }
        //-------
        //National
        nationalButton = SearchTextField(frame: CGRect(x: Common.Size(s:20), y: wardsButton.frame.origin.y + wardsButton.frame.size.height + Common.Size(s:10), width: wardsButton.frame.size.width , height: wardsButton.frame.size.height));
        nationalButton.placeholder = "Quốc tịch"
        nationalButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        nationalButton.borderStyle = UITextField.BorderStyle.roundedRect
        nationalButton.autocorrectionType = UITextAutocorrectionType.no
        nationalButton.keyboardType = UIKeyboardType.default
        nationalButton.returnKeyType = UIReturnKeyType.done
        nationalButton.clearButtonMode = UITextField.ViewMode.whileEditing
        nationalButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        nationalButton.delegate = self
        viewCustomerInfo.addSubview(nationalButton)
        
        // Start visible - Default: false
        nationalButton.startVisible = true
        nationalButton.theme.bgColor = UIColor.white
        nationalButton.theme.fontColor = UIColor.black
        nationalButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        nationalButton.theme.cellHeight = Common.Size(s:40)
        nationalButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        
        nationalButton.leftViewMode = UITextField.ViewMode.always
        let imageNationalButton = UIImageView(frame: CGRect(x: nationalButton.frame.size.height/4, y: nationalButton.frame.size.height/4, width: nationalButton.frame.size.height/2, height: nationalButton.frame.size.height/2))
        imageNationalButton.image = UIImage(named: "City-50")
        imageNationalButton.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewNationalButton = UIView()
        leftViewNationalButton.addSubview(imageNationalButton)
        leftViewNationalButton.frame = CGRect(x: 0, y: 0, width: nationalButton.frame.size.height, height: nationalButton.frame.size.height)
        nationalButton.leftView = leftViewNationalButton
        
        
        nationalButton.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.nationalButton.text = item.title
            //            self.selectNational = "\(item.title)"
            
            let obj =  self.listNationality.filter{ $0.Name == "\(item.title)" }.first
            if let obj = obj?.Code {
                self.selectNational = "\(obj)"
                if("\(self.simActive!.Provider)" == "Mobifone"){
                    if (self.selectNational == "VNM"){
                        self.isVietNam = true
                        self.showCMND()
                    }else{
                        self.isVietNam = false
                        self.showPassort()
                    }
                    
                }else if ("\(self.simActive!.Provider)" == "Vinaphone"){
                    
                    if (self.selectNational == "232"){
                        self.isVietNam = true
                        self.showCMND()
                    }else{
                        self.isVietNam = false
                        self.showPassort()
                    }
                }else if ("\(self.simActive!.Provider)" == "Viettel"){
                    if (self.selectNational == "232"){
                        self.isVietNam = true
                        self.showCMND()
                    }else{
                        self.isVietNam = false
                        self.showPassort()
                    }
                }else if ("\(self.simActive!.Provider)" == "Vietnammobile"){
                    if (self.selectNational == "232"){
                        self.isVietNam = true
                        self.showCMND()
                    }else{
                        self.isVietNam = false
                        self.showPassort()
                    }
                }else if ("\(self.simActive!.Provider)" == "Itelecom"){
                    if (self.selectNational == "232"){
                        self.isVietNam = true
                        self.showCMND()
                    }else{
                        self.isVietNam = false
                        self.showPassort()
                    }
                }
                
            }
        }
        
        if let nationality = self.simActive?.Nationality {
            MPOSAPIManager.SearchNationality(Nhamang: "\(simActive!.Provider)", handler: { (results, error) in
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.listNationality = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Name)
                    }
                    self.nationalButton.filterStrings(list)
                    let obj =  self.listNationality.filter{ $0.Code == "\(nationality)" }.first
                    if let obj1 = obj?.Name {
                        self.nationalButton.text = obj1
                        self.selectNational = "\(obj!.Code)"
                    }
                })
                
            })
        }else{
            MPOSAPIManager.SearchNationality(Nhamang: "\(simActive!.Provider)", handler: { (results, error) in
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.listNationality = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Name)
                    }
                    self.nationalButton.filterStrings(list)
                })
                
            })
        }
        //----------------
        
        lblWarningInfo = UILabel(frame: CGRect(x: tfUserName.frame.origin.x, y: nationalButton.frame.size.height + nationalButton.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:30)))
        lblWarningInfo.textAlignment = .left
        lblWarningInfo.textColor = UIColor.red
        lblWarningInfo.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblWarningInfo.text = "Lưu ý: Nhập chính xác thông tin của khách hàng. Nếu nhập sai, sim sẽ bị khóa. Phát sinh khiếu nại."
        
        lblWarningInfo.numberOfLines = 0
        lblWarningInfo.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        lblWarningInfo.minimumScaleFactor = 0.8
        
        viewCustomerInfo.addSubview(lblWarningInfo)
        
        let lbCMNDInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y: lblWarningInfo.frame.size.height + lblWarningInfo.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:20)))
        lbCMNDInfo.textAlignment = .left
        lbCMNDInfo.textColor = UIColor(netHex:0x47B054)
        lbCMNDInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbCMNDInfo.text = "LOẠI GIẤY TỜ"
        viewCustomerInfo.addSubview(lbCMNDInfo)
        
        //--------
        let viewCustomerInfoType:UIView = UIView(frame:CGRect(x: 0, y: lbCMNDInfo.frame.origin.y + lbCMNDInfo.frame.size.height, width: UIScreen.main.bounds.size.width , height: Common.Size(s:40)))
        //        viewCustomerInfoType.backgroundColor = .red
        viewCustomerInfo.addSubview(viewCustomerInfoType)
        
        radioPassport = createRadioButton2(CGRect(x: lbCMNDInfo.frame.origin.x, y: Common.Size(s:10), width: lbCMNDInfo.frame.size.width/3, height: Common.Size(s:20)), title: "Passport", color: UIColor.black);
        viewCustomerInfoType.addSubview(radioPassport)
        
        radioCMND = createRadioButton2(CGRect(x: radioPassport.frame.origin.x + radioPassport.frame.size.width, y: Common.Size(s:10), width: lbCMNDInfo.frame.size.width/3, height: Common.Size(s:20)), title: "CMND", color: UIColor.black);
        viewCustomerInfoType.addSubview(radioCMND)
        
        radioCanCuoc = createRadioButton2(CGRect(x: radioCMND.frame.origin.x + radioCMND.frame.size.width, y: radioCMND.frame.origin.y , width: radioCMND.frame.size.width, height: radioCMND.frame.size.height), title: "Căn cước", color: UIColor.black);
        viewCustomerInfoType.addSubview(radioCanCuoc)
        //-------------
        viewCustomerInfoPassport = UIView(frame:CGRect(x: 0, y: viewCustomerInfoType.frame.size.height + viewCustomerInfoType.frame.origin.y, width: UIScreen.main.bounds.size.width , height: Common.Size(s:80)))
        //        viewCustomerInfoPassport.backgroundColor = .red
        viewCustomerInfo.addSubview(viewCustomerInfoPassport)
        //input cmnd
        tfPassport = UITextField(frame: CGRect(x: Common.Size(s:20), y: 0, width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfPassport.placeholder = "Số passport"
        tfPassport.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPassport.borderStyle = UITextField.BorderStyle.roundedRect
        tfPassport.autocorrectionType = UITextAutocorrectionType.no
        tfPassport.keyboardType = UIKeyboardType.default
        tfPassport.returnKeyType = UIReturnKeyType.done
        tfPassport.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPassport.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPassport.delegate = self
        viewCustomerInfoPassport.addSubview(tfPassport)
        
        tfPassport.leftViewMode = UITextField.ViewMode.always
        let imagePassport = UIImageView(frame: CGRect(x: tfPassport.frame.size.height/4, y: tfPassport.frame.size.height/4, width: tfPassport.frame.size.height/2, height: tfPassport.frame.size.height/2))
        imagePassport.image = UIImage(named: "Counter-50")
        imagePassport.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewPassport = UIView()
        leftViewPassport.addSubview(imagePassport)
        leftViewPassport.frame = CGRect(x: 0, y: 0, width: tfPassport.frame.size.height, height: tfPassport.frame.size.height)
        tfPassport.leftView = leftViewPassport
        
        if let passport = simActive?.Passport {
            tfPassport.text = passport
        }
        //--------------
        tfCrateDatePassport = UITextField(frame: CGRect(x: tfPassport.frame.origin.x, y: tfPassport.frame.origin.y + tfPassport.frame.size.height + Common.Size(s:10), width: tfPassport.frame.size.width , height: tfPassport.frame.size.height ));
        tfCrateDatePassport.placeholder = "Ngày cấp (dd/MM/yyyy)"
        tfCrateDatePassport.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCrateDatePassport.borderStyle = UITextField.BorderStyle.roundedRect
        tfCrateDatePassport.autocorrectionType = UITextAutocorrectionType.no
        tfCrateDatePassport.keyboardType = UIKeyboardType.default
        tfCrateDatePassport.returnKeyType = UIReturnKeyType.done
        tfCrateDatePassport.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCrateDatePassport.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCrateDatePassport.delegate = self
        viewCustomerInfoPassport.addSubview(tfCrateDatePassport)
        tfCrateDatePassport.leftViewMode = UITextField.ViewMode.always
        let imageCreateDatePassport = UIImageView(frame: CGRect(x: tfPassport.frame.size.height/4, y: tfPassport.frame.size.height/4, width: tfPassport.frame.size.height/2, height: tfPassport.frame.size.height/2))
        imageCreateDatePassport.image = UIImage(named: "Calendar-50")
        imageCreateDatePassport.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewCreateDatePassport = UIView()
        leftViewCreateDatePassport.addSubview(imageCreateDatePassport)
        leftViewCreateDatePassport.frame = CGRect(x: 0, y: 0, width: tfPassport.frame.size.height, height: tfPassport.frame.size.height)
        tfCrateDatePassport.leftView = leftViewCreateDatePassport
        
        //CHUA
        //        if let dayGrantPassport = simActive?.DayGrantPassport{
        //            tfCrateDatePassport.text = dayGrantPassport
        //        }
        //-------------
        tfPalaceCreatePassport = UITextField(frame: CGRect(x: tfCrateDatePassport.frame.origin.x, y: tfCrateDatePassport.frame.origin.y + tfCrateDatePassport.frame.size.height + Common.Size(s:10), width: tfCrateDatePassport.frame.size.width , height: tfCrateDatePassport.frame.size.height ));
        tfPalaceCreatePassport.placeholder = "Nơi cấp passport"
        tfPalaceCreatePassport.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPalaceCreatePassport.borderStyle = UITextField.BorderStyle.roundedRect
        tfPalaceCreatePassport.autocorrectionType = UITextAutocorrectionType.no
        tfPalaceCreatePassport.keyboardType = UIKeyboardType.default
        tfPalaceCreatePassport.returnKeyType = UIReturnKeyType.done
        tfPalaceCreatePassport.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPalaceCreatePassport.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPalaceCreatePassport.delegate = self
        viewCustomerInfoPassport.addSubview(tfPalaceCreatePassport)
        tfPalaceCreatePassport.leftViewMode = UITextField.ViewMode.always
        let imagePalaceCreatePassport = UIImageView(frame: CGRect(x: tfPassport.frame.size.height/4, y: tfPassport.frame.size.height/4, width: tfPassport.frame.size.height/2, height: tfPassport.frame.size.height/2))
        imagePalaceCreatePassport.image = UIImage(named: "Visit-50")
        imagePalaceCreatePassport.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewPalaceCreatePassport = UIView()
        leftViewPalaceCreatePassport.addSubview(imagePalaceCreatePassport)
        leftViewPalaceCreatePassport.frame = CGRect(x: 0, y: 0, width: tfPassport.frame.size.height, height: tfPassport.frame.size.height)
        tfPalaceCreatePassport.leftView = leftViewPalaceCreatePassport
        
        //CHUA
        if let noiCapPassport = simActive?.NoiCapPassport{
            tfPalaceCreatePassport.text = noiCapPassport
        }
        
        //-----------------
        //-------------
        tfVisa = UITextField(frame: CGRect(x: tfPalaceCreatePassport.frame.origin.x, y: tfPalaceCreatePassport.frame.origin.y + tfPalaceCreatePassport.frame.size.height + Common.Size(s:10), width: tfPalaceCreatePassport.frame.size.width , height: tfPalaceCreatePassport.frame.size.height ));
        tfVisa.placeholder = "Số VISA"
        tfVisa.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfVisa.borderStyle = UITextField.BorderStyle.roundedRect
        tfVisa.autocorrectionType = UITextAutocorrectionType.no
        tfVisa.keyboardType = UIKeyboardType.default
        tfVisa.returnKeyType = UIReturnKeyType.done
        tfVisa.clearButtonMode = UITextField.ViewMode.whileEditing
        tfVisa.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfVisa.delegate = self
        viewCustomerInfoPassport.addSubview(tfVisa)
        tfVisa.leftViewMode = UITextField.ViewMode.always
        let imageVisa = UIImageView(frame: CGRect(x: tfPassport.frame.size.height/4, y: tfPassport.frame.size.height/4, width: tfPassport.frame.size.height/2, height: tfPassport.frame.size.height/2))
        imageVisa.image = UIImage(named: "Counter-50")
        imageVisa.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewVisa = UIView()
        leftViewVisa.addSubview(imageVisa)
        leftViewVisa.frame = CGRect(x: 0, y: 0, width: tfPassport.frame.size.height, height: tfPassport.frame.size.height)
        tfVisa.leftView = leftViewVisa
        
        //CHUA
        if let soVisa = simActive?.SoVisa{
            tfVisa.text = soVisa
        }
        viewCustomerInfoPassport.frame.size.height = tfVisa.frame.size.height + tfVisa.frame.origin.y
        
        //-------------
        viewCustomerInfoCMND = UIView(frame:CGRect(x: 0, y: viewCustomerInfoType.frame.size.height + viewCustomerInfoType.frame.origin.y, width: UIScreen.main.bounds.size.width , height: Common.Size(s:80)))
        //                viewCustomerInfoCMND.backgroundColor = .red
        viewCustomerInfo.addSubview(viewCustomerInfoCMND)
        
        
        //input cmnd
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:20), y: 0, width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        //        tfCMND.placeholder = "Số CMND/Căn cước"
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        viewCustomerInfoCMND.addSubview(tfCMND)
        
        tfCMND.leftViewMode = UITextField.ViewMode.always
        let imagePhone = UIImageView(frame: CGRect(x: tfCMND.frame.size.height/4, y: tfCMND.frame.size.height/4, width: tfCMND.frame.size.height/2, height: tfCMND.frame.size.height/2))
        imagePhone.image = UIImage(named: "Counter-50")
        imagePhone.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewPhone = UIView()
        leftViewPhone.addSubview(imagePhone)
        leftViewPhone.frame = CGRect(x: 0, y: 0, width: tfCMND.frame.size.height, height: tfCMND.frame.size.height)
        tfCMND.leftView = leftViewPhone
        
        
        //OKOKO
        //-------------
        //create date
        tfCrateDate = UITextField(frame: CGRect(x: tfCMND.frame.origin.x, y: tfCMND.frame.origin.y + tfCMND.frame.size.height + Common.Size(s:10), width: tfCMND.frame.size.width , height: tfCMND.frame.size.height ));
        tfCrateDate.placeholder = "Ngày cấp (dd/MM/yyyy)"
        tfCrateDate.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCrateDate.borderStyle = UITextField.BorderStyle.roundedRect
        tfCrateDate.autocorrectionType = UITextAutocorrectionType.no
        tfCrateDate.keyboardType = UIKeyboardType.default
        tfCrateDate.returnKeyType = UIReturnKeyType.done
        tfCrateDate.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCrateDate.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCrateDate.delegate = self
        viewCustomerInfoCMND.addSubview(tfCrateDate)
        tfCrateDate.leftViewMode = UITextField.ViewMode.always
        let imageCreateDate = UIImageView(frame: CGRect(x: tfUserName.frame.size.height/4, y: tfUserName.frame.size.height/4, width: tfCMND.frame.size.height/2, height: tfUserName.frame.size.height/2))
        imageCreateDate.image = UIImage(named: "Calendar-50")
        imageCreateDate.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewCreateDate = UIView()
        leftViewCreateDate.addSubview(imageCreateDate)
        leftViewCreateDate.frame = CGRect(x: 0, y: 0, width: tfUserName.frame.size.height, height: tfUserName.frame.size.height)
        tfCrateDate.leftView = leftViewCreateDate
        if let dateCreateCMND = simActive?.DateCreateCMND {
            tfCrateDate.text = dateCreateCMND
        }
        //----------
        //create address
        tfCreateAddress = SearchTextField(frame: CGRect(x: tfCMND.frame.origin.x, y: tfCrateDate.frame.origin.y + tfCrateDate.frame.size.height + Common.Size(s:10), width: tfCMND.frame.size.width , height: tfCMND.frame.size.height ));
        tfCreateAddress.placeholder = "Nơi cấp"
        tfCreateAddress.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCreateAddress.borderStyle = UITextField.BorderStyle.roundedRect
        tfCreateAddress.autocorrectionType = UITextAutocorrectionType.no
        tfCreateAddress.keyboardType = UIKeyboardType.default
        tfCreateAddress.returnKeyType = UIReturnKeyType.done
        tfCreateAddress.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCreateAddress.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCreateAddress.delegate = self
        viewCustomerInfoCMND.addSubview(tfCreateAddress)
        
        tfCreateAddress.startVisible = true
        tfCreateAddress.theme.bgColor = UIColor.white
        tfCreateAddress.theme.fontColor = UIColor.black
        tfCreateAddress.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCreateAddress.theme.cellHeight = Common.Size(s:40)
        tfCreateAddress.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        tfCreateAddress.leftViewMode = UITextField.ViewMode.always
        let imageCreateAddress = UIImageView(frame: CGRect(x: tfUserName.frame.size.height/4, y: tfUserName.frame.size.height/4, width: tfCMND.frame.size.height/2, height: tfUserName.frame.size.height/2))
        imageCreateAddress.image = UIImage(named: "Address-50")
        imageCreateAddress.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewCreateAddress = UIView()
        leftViewCreateAddress.addSubview(imageCreateAddress)
        leftViewCreateAddress.frame = CGRect(x: 0, y: 0, width: tfUserName.frame.size.height, height: tfUserName.frame.size.height)
        tfCreateAddress.leftView = leftViewCreateAddress
        
        tfCreateAddress.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfCreateAddress.text = item.title
            let obj =  self.listProvices.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectAddressCMND = "\(obj)"
            }
        }
        viewCustomerInfoCMND.frame.size.height = tfCreateAddress.frame.size.height + tfCreateAddress.frame.origin.y
        
        
        
        viewCustomerInfo.frame.size.height = viewCustomerInfoCMND.frame.size.height + viewCustomerInfoCMND.frame.origin.y + Common.Size(s: 10)
        
        //-------
        //---------
        if let provinceCode = self.simActive?.ProvinceCode {
            
            MPOSAPIManager.GetProvinces(NhaMang: "\(simActive!.Provider)", handler: { (results, error) in
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.listProvices = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Text)
                    }
                    self.cityButton.filterStrings(list)
                    self.tfCreateAddress.filterStrings(list)
                    
                    if let palaceCreateCMND = self.simActive?.PalaceCreateCMND {
                        let obj =  self.listProvices.filter{ $0.Text == "\(palaceCreateCMND)" }.first
                        if let _ = obj?.Text {
                            self.tfCreateAddress.text = obj?.Text
                            self.selectAddressCMND = (obj?.Value)!
                        }
                    }
                    
                    let obj =  self.listProvices.filter{ $0.Value == "\(provinceCode)" }.first
                    if let obj1 = obj?.Text {
                        self.cityButton.text = obj1
                        self.selectProvice = "\(obj!.Value)"
                        
                        //quan huyen
                        if let districtCode = self.simActive?.DistrictCode {
                            MPOSAPIManager.GetDistricts(MaCodeTinh: "\(self.selectProvice)", NhaMang: "\(self.simActive!.Provider)", handler: { (results, error) in
                                
                                self.listDistricts = results
                                var listDistrictTemp:[String] = []
                                for item in results {
                                    listDistrictTemp.append(item.Text)
                                }
                                self.districtButton.filterStrings(listDistrictTemp)
                                
                                let obj =  results.filter{ $0.Value == "\(districtCode)" }.first
                                if let obj1 = obj?.Text {
                                    self.districtButton.text = obj1
                                    self.selectDistrict = "\(obj!.Value)"
                                    
                                    //phuong xa
                                    if let precinctCode = self.simActive?.PrecinctCode {
                                        
                                        MPOSAPIManager.GetPrecincts(MaCodeHUyen:  "\(self.selectDistrict)", MaCodeTinh: "\(self.selectProvice)", NhaMang: "\(self.simActive!.Provider)", handler: { (results, error) in
                                            
                                            self.listPrecincts = results
                                            var list:[String] = []
                                            for item in results {
                                                list.append(item.Text)
                                            }
                                            self.wardsButton.filterStrings(list)
                                            
                                            let obj =  results.filter{ $0.Value == "\(precinctCode)" }.first
                                            if let obj1 = obj?.Text {
                                                self.wardsButton.text = obj1
                                                self.selectPrecinct = "\(obj!.Value)"
                                                
                                            }
                                            
                                        })
                                        
                                    }
                                }
                            })
                        }
                    }
                })
            })
        }else{
            MPOSAPIManager.GetProvinces(NhaMang: "\(simActive!.Provider)", handler: { (results, error) in
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.listProvices = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Text)
                    }
                    self.cityButton.filterStrings(list)
                    self.tfCreateAddress.filterStrings(list)
                })
            })
            
        }
        //--------
        
        viewInfoBottom = UIView(frame: CGRect(x:0,y:viewCustomerInfo.frame.origin.y + viewCustomerInfo.frame.size.height,width:scrollView.frame.size.width,height:80))
        
        scrollView.addSubview(viewInfoBottom)
        
        let lbSubscribers = UILabel(frame: CGRect(x: Common.Size(s:20), y: 0, width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:20)))
        lbSubscribers.textAlignment = .left
        lbSubscribers.textColor = UIColor(netHex:0x47B054)
        lbSubscribers.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbSubscribers.text = "THÔNG TIN THUÊ BAO"
        viewInfoBottom.addSubview(lbSubscribers)
        
        //serial sim
        tfNumSO = UITextField(frame: CGRect(x: tfCMND.frame.origin.x, y: lbSubscribers.frame.origin.y + lbSubscribers.frame.size.height + Common.Size(s:10), width: tfCMND.frame.size.width , height: tfCMND.frame.size.height ));
        tfNumSO.placeholder = "Số đơn hàng"
        tfNumSO.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNumSO.borderStyle = UITextField.BorderStyle.roundedRect
        tfNumSO.autocorrectionType = UITextAutocorrectionType.no
        tfNumSO.keyboardType = UIKeyboardType.default
        tfNumSO.returnKeyType = UIReturnKeyType.done
        tfNumSO.clearButtonMode = UITextField.ViewMode.whileEditing
        tfNumSO.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfNumSO.delegate = self
        viewInfoBottom.addSubview(tfNumSO)
        
        tfNumSO.leftViewMode = UITextField.ViewMode.always
        let imageNumSO = UIImageView(frame: CGRect(x: tfUserName.frame.size.height/4, y: tfUserName.frame.size.height/4, width: tfCMND.frame.size.height/2, height: tfUserName.frame.size.height/2))
        imageNumSO.image = UIImage(named: "Barcode-50")
        imageNumSO.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewNumSO = UIView()
        leftViewNumSO.addSubview(imageNumSO)
        leftViewNumSO.frame = CGRect(x: 0, y: 0, width: tfUserName.frame.size.height, height: tfUserName.frame.size.height)
        tfNumSO.leftView = leftViewNumSO
        
        if let id = simActive?.ID {
            if(id < 0){
                tfNumSO.text = "\(0)"
            }else{
                tfNumSO.text = "\(id)"
            }
            
        }
        //-----------------
        amountButton = NiceButton(frame: CGRect(x: tfNumSO.frame.origin.x, y: tfNumSO.frame.origin.y + tfNumSO.frame.size.height + Common.Size(s:10), width: tfNumSO.frame.size.width , height: tfNumSO.frame.size.height ))
        amountButton.contentHorizontalAlignment = .left
        amountButton.tintColor = UIColor.red
        amountButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        amountButton.setTitleColor(UIColor.black ,for: .normal)
        amountButton.layer.borderWidth = 0.5
        amountButton.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        amountButton.layer.cornerRadius = 3.0
        viewInfoBottom.addSubview(amountButton)
        
        //        amountButton.setImage(image: UIImage(named: "SIM Card-50-1"), inFrame: CGRect(x: tfUserName.frame.size.height/4, y: tfUserName.frame.size.height/4, width: tfCMND.frame.size.height/2, height: tfUserName.frame.size.height/2), for: .normal)
        amountButton.setImage(UIImage(named: "SIM Card-50-1"), for: .normal)
        amountButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        amountButton.isUserInteractionEnabled = false
        
        if let phonenumber = simActive?.Phonenumber {
            amountButton.setTitle("\(phonenumber)", for: .normal)
        }
        tfSerialSim = UITextField(frame: CGRect(x: tfCMND.frame.origin.x, y: amountButton.frame.origin.y + amountButton.frame.size.height + Common.Size(s:10), width: tfCMND.frame.size.width - Common.Size(s:50), height: tfCMND.frame.size.height ));
        tfSerialSim.placeholder = "Số serial SIM"
        tfSerialSim.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSerialSim.borderStyle = UITextField.BorderStyle.roundedRect
        tfSerialSim.autocorrectionType = UITextAutocorrectionType.no
        tfSerialSim.keyboardType = UIKeyboardType.numberPad
        tfSerialSim.returnKeyType = UIReturnKeyType.done
        tfSerialSim.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSerialSim.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSerialSim.delegate = self
        //        tfUserName.addTarget(self, action: #selector(textFieldDidChangeName(_:)), for: .editingChanged)
        viewInfoBottom.addSubview(tfSerialSim)
        
        tfSerialSim.leftViewMode = UITextField.ViewMode.always
        let imageSerialSim = UIImageView(frame: CGRect(x: tfUserName.frame.size.height/4, y: tfUserName.frame.size.height/4, width: tfCMND.frame.size.height/2, height: tfUserName.frame.size.height/2))
        imageSerialSim.image = UIImage(named: "SIM Card Chip-50")
        imageSerialSim.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewSerialSim = UIView()
        leftViewSerialSim.addSubview(imageSerialSim)
        leftViewSerialSim.frame = CGRect(x: 0, y: 0, width: tfUserName.frame.size.height, height: tfUserName.frame.size.height)
        tfSerialSim.leftView = leftViewSerialSim
        
        if let seriSIM = simActive?.SeriSIM {
            tfSerialSim.text = seriSIM
        }
        
        let btnScan = UIImageView(frame:CGRect(x: tfSerialSim.frame.size.width + tfSerialSim.frame.origin.x + Common.Size(s: 10) , y:  tfSerialSim.frame.origin.y, width: Common.Size(s:25), height: tfSerialSim.frame.size.height));
        btnScan.image = #imageLiteral(resourceName: "scan_barcode_1")
        btnScan.contentMode = .scaleAspectFit
        viewInfoBottom.addSubview(btnScan)
        
        let tapScan = UITapGestureRecognizer(target: self, action: #selector(actionScan(_:)))
        btnScan.isUserInteractionEnabled = true
        btnScan.addGestureRecognizer(tapScan)
        
        //---------
        
        let lbSimInfo = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfSerialSim.frame.origin.y + tfSerialSim.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbSimInfo.textAlignment = .left
        lbSimInfo.textColor = UIColor(netHex:0x47B054)
        lbSimInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbSimInfo.text = "THÔNG TIN SIM"
        viewInfoBottom.addSubview(lbSimInfo)
        
        lbSimInfoMore = UILabel(frame: CGRect(x: (scrollView.frame.size.width - Common.Size(s:40))/2, y: lbSimInfo.frame.origin.y, width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: lbSimInfo.frame.size.height))
        lbSimInfoMore.textAlignment = .right
        lbSimInfoMore.textColor = UIColor(netHex:0x47B054)
        lbSimInfoMore.backgroundColor = UIColor.clear
        lbSimInfoMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Chi tiết", attributes: underlineAttribute)
        lbSimInfoMore.attributedText = underlineAttributedString
        viewInfoBottom.addSubview(lbSimInfoMore)
        
        let tapShow = UITapGestureRecognizer(target: self, action: #selector(self.tapShowDetail))
        lbSimInfoMore.isUserInteractionEnabled = true
        lbSimInfoMore.addGestureRecognizer(tapShow)
        
        viewSimInfoMore = UIView(frame: CGRect(x: 0, y: lbSimInfo.frame.origin.y + lbSimInfo.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width, height: 0))
        viewInfoBottom.addSubview(viewSimInfoMore)
        
        let lbSupplier = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:5), width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: Common.Size(s:20)))
        lbSupplier.textAlignment = .left
        lbSupplier.textColor = UIColor(netHex:0x47B054)
        lbSupplier.font = UIFont.systemFont(ofSize: Common.Size(s:18))
        lbSupplier.text = "Nhà mạng:"
        lbSupplier.sizeToFit()
        viewSimInfoMore.addSubview(lbSupplier)
        
        let lbNameSupplier = UILabel(frame: CGRect(x:lbSupplier.frame.size.width + lbSupplier.frame.origin.x + Common.Size(s:5), y:lbSupplier.frame.origin.y + Common.Size(s:2), width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: Common.Size(s:30) + lbSupplier.frame.size.height))
        lbNameSupplier.textAlignment = .left
        lbNameSupplier.textColor = UIColor.black
        lbNameSupplier.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbNameSupplier.sizeToFit()
        viewSimInfoMore.addSubview(lbNameSupplier)
        
        if let nhaMang = simActive?.Provider {
            lbNameSupplier.text = nhaMang
            lbNameSupplier.sizeToFit()
        }
        
        let lbPackage = UILabel(frame: CGRect(x: Common.Size(s:20), y: lbSupplier.frame.size.height + lbSupplier.frame.origin.y + Common.Size(s:15), width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: Common.Size(s:20)))
        lbPackage.textAlignment = .left
        lbPackage.textColor = UIColor(netHex:0x47B054)
        lbPackage.font = UIFont.systemFont(ofSize: Common.Size(s:18))
        lbPackage.text = "Gói cước:"
        lbPackage.sizeToFit()
        viewSimInfoMore.addSubview(lbPackage)
        
        let lbNamePackage = UILabel(frame: CGRect(x:lbNameSupplier.frame.origin.x, y: lbPackage.frame.origin.y + Common.Size(s:2), width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: Common.Size(s:30)))
        lbNamePackage.textAlignment = .left
        lbNamePackage.textColor = UIColor.black
        lbNamePackage.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbNamePackage.text = "VinaphoneNormal"
        lbNamePackage.sizeToFit()
        viewSimInfoMore.addSubview(lbNamePackage)
        
        
        if let goiCuoc = simActive?.GoiCuoc {
            lbNamePackage.text = goiCuoc
        }
        
        let lbTitleSimName = UILabel(frame: CGRect(x: Common.Size(s:20), y: lbPackage.frame.size.height + lbPackage.frame.origin.y + Common.Size(s:15), width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: Common.Size(s:20)))
        lbTitleSimName.textAlignment = .left
        lbTitleSimName.textColor = UIColor(netHex:0x47B054)
        lbTitleSimName.font = UIFont.systemFont(ofSize: Common.Size(s:18))
        lbTitleSimName.text = "Tên sim:"
        lbTitleSimName.sizeToFit()
        viewSimInfoMore.addSubview(lbTitleSimName)
        
        let lbSimName = UILabel(frame: CGRect(x:lbNameSupplier.frame.origin.x, y: lbTitleSimName.frame.origin.y + Common.Size(s:2), width: (scrollView.frame.size.width - Common.Size(s:40)) - lbNameSupplier.frame.origin.x, height: lbTitleSimName.frame.size.height))
        lbSimName.textAlignment = .left
        lbSimName.textColor = UIColor.black
        lbSimName.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbSimName.text = "Sim FPT"
        viewSimInfoMore.addSubview(lbSimName)
        
        if let productName = simActive?.ProductName {
            lbSimName.text = productName
        }
        
        heightSimInfoMore = lbTitleSimName.frame.size.height + lbTitleSimName.frame.origin.y
        viewSimInfoMore.clipsToBounds = true
        
        //image upload
        viewImageUpload = UIView(frame: CGRect(x: 0, y: viewSimInfoMore.frame.origin.y + viewSimInfoMore.frame.size.height, width: scrollView.frame.size.width, height: 80))
        viewInfoBottom.addSubview(viewImageUpload)
        
        //avarta
        viewAvatar = UIView(frame: CGRect(x: Common.Size(s:20), y: 0, width: scrollView.frame.size.width - Common.Size(s:40), height: 0))
        viewAvatar.clipsToBounds = true
        viewImageUpload.addSubview(viewAvatar)
        
        let lbTextAvatar = UILabel(frame: CGRect(x: 0, y: 0, width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: Common.Size(s:20)))
        lbTextAvatar.textAlignment = .left
        lbTextAvatar.textColor = UIColor(netHex:0x47B054)
        lbTextAvatar.font = UIFont.systemFont(ofSize: Common.Size(s:18))
        lbTextAvatar.text = "Hình chân dung khách hàng"
        lbTextAvatar.sizeToFit()
        viewAvatar.addSubview(lbTextAvatar)
        
        viewImageAvatar = UIView(frame: CGRect(x:0, y: lbTextAvatar.frame.origin.y + lbTextAvatar.frame.size.height + Common.Size(s:5), width: viewAvatar.frame.size.width, height: Common.Size(s:60)))
        viewImageAvatar.layer.borderWidth = 0.5
        viewImageAvatar.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageAvatar.layer.cornerRadius = 3.0
        viewAvatar.addSubview(viewImageAvatar)
        
        let tapShowAvatar = UITapGestureRecognizer(target: self, action: #selector(self.tapShowAvatar))
        viewAvatar.isUserInteractionEnabled = true
        viewAvatar.addGestureRecognizer(tapShowAvatar)
        
        
        let AV23 = viewImageAvatar.frame.size.height * 2/3
        let xViewAV = viewImageAvatar.frame.size.width/2 - AV23/2
        
        let viewAvatarButton = UIImageView(frame: CGRect(x: xViewAV, y: 0, width: viewImageAvatar.frame.size.height * 2/3, height: viewImageAvatar.frame.size.height * 2/3))
        
        viewAvatarButton.image = UIImage(named:"AddImage")
        viewAvatarButton.contentMode = .scaleAspectFit
        viewImageAvatar.addSubview(viewAvatarButton)
        
        let lbAvatarButton = UILabel(frame: CGRect(x: 0, y: viewAvatarButton.frame.size.height + viewAvatarButton.frame.origin.y, width: viewImageAvatar.frame.size.width, height: viewImageAvatar.frame.size.height/3))
        lbAvatarButton.textAlignment = .center
        lbAvatarButton.textColor = UIColor(netHex:0xc2c2c2)
        lbAvatarButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbAvatarButton.text = "Thêm hình ảnh"
        viewImageAvatar.addSubview(lbAvatarButton)
        
        viewAvatar.frame.size.height = viewImageAvatar.frame.origin.y + viewImageAvatar.frame.size.height
        
        //sign
        viewSign = UIView(frame: CGRect(x: Common.Size(s:20), y: viewAvatar.frame.origin.y + viewAvatar.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: 0))
        viewSign.clipsToBounds = true
        viewImageUpload.addSubview(viewSign)
        
        let lbTextSign = UILabel(frame: CGRect(x: 0, y: 0, width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: Common.Size(s:20)))
        lbTextSign.textAlignment = .left
        lbTextSign.textColor = UIColor(netHex:0x47B054)
        lbTextSign.font = UIFont.systemFont(ofSize: Common.Size(s:18))
        lbTextSign.text = "Chữ ký"
        lbTextSign.sizeToFit()
        viewSign.addSubview(lbTextSign)
        
        viewImageSign = UIView(frame: CGRect(x:0, y: lbTextSign.frame.origin.y + lbTextSign.frame.size.height + Common.Size(s:5), width: viewSign.frame.size.width, height: Common.Size(s:60)))
        viewImageSign.layer.borderWidth = 0.5
        viewImageSign.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSign.layer.cornerRadius = 3.0
        viewSign.addSubview(viewImageSign)
        
        let VS23 = viewImageSign.frame.size.height * 2/3
        let xViewVS  = viewImageSign.frame.size.width/2 - VS23/2
        let viewSignButton = UIImageView(frame: CGRect(x: xViewVS, y: 0, width: viewImageSign.frame.size.height * 2/3, height: viewImageSign.frame.size.height * 2/3))
        viewSignButton.image = UIImage(named:"Sign Up-50")
        viewSignButton.contentMode = .scaleAspectFit
        viewImageSign.addSubview(viewSignButton)
        
        let lbSignButton = UILabel(frame: CGRect(x: 0, y: viewSignButton.frame.size.height + viewSignButton.frame.origin.y, width: viewImageSign.frame.size.width, height: viewImageSign.frame.size.height/3))
        lbSignButton.textAlignment = .center
        lbSignButton.textColor = UIColor(netHex:0xc2c2c2)
        lbSignButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSignButton.text = "Thêm chữ ký"
        viewImageSign.addSubview(lbSignButton)
        
        viewSign.frame.size.height = viewImageSign.frame.origin.y + viewImageSign.frame.size.height
        
        let tapShowSign = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSign))
        viewSign.isUserInteractionEnabled = true
        viewSign.addGestureRecognizer(tapShowSign)
        
        btPay = UIButton()
        btPay.frame = CGRect(x: tfCMND.frame.origin.x, y: viewSign.frame.origin.y + viewSign.frame.size.height + Common.Size(s:20), width: tfCMND.frame.size.width, height: tfCMND.frame.size.height * 1.2)
        btPay.backgroundColor = UIColor(netHex:0xEF4A40)
        btPay.setTitle("Lưu & Kích hoạt", for: .normal)
        btPay.addTarget(self, action: #selector(actionPopUp), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        
        viewImageUpload.addSubview(btPay)
        
        
        viewImageUpload.frame.size.height = btPay.frame.origin.y + btPay.frame.size.height
        viewInfoBottom.frame.size.height = viewImageUpload.frame.origin.y + viewImageUpload.frame.size.height
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBottom.frame.origin.y + viewInfoBottom.frame.size.height + Common.Size(s: 20) + (self.navigationController?.navigationBar.frame.size.height)! + (UIApplication.shared.statusBarFrame.height))
        
        
        if let loaiGiayTo = simActive?.LoaiGiayTo {
            
            if(loaiGiayTo == 1){
                radioCMND.isSelected = true
                typeKichHoat = 1
                tfCMND.placeholder = "Số CMND"
                tfCMND.keyboardType = UIKeyboardType.numberPad
                radioPassport.isHidden = false
                if let cmnd = simActive?.CMND {
                    tfCMND.text = cmnd
                }
                self.showCMND()
            }else if(loaiGiayTo == 2){
                radioCanCuoc.isSelected = true
                typeKichHoat = 2
                tfCMND.placeholder = "Số căn cước"
                tfCMND.keyboardType = UIKeyboardType.numberPad
                radioPassport.isHidden = false
                if let cmnd = simActive?.CMND {
                    tfCMND.text = cmnd
                }
                self.showCMND()
            }else if(loaiGiayTo == 3){
                typeKichHoat = 3
                tfCMND.keyboardType = UIKeyboardType.default
                if("\(self.simActive!.Provider)" == "Mobifone" || "\(self.simActive!.Provider)" == "mobifone"){
                    if ("\(self.simActive!.Nationality)" == "VNM"){
                        self.isVietNam = true
                        radioPassport.isSelected = true
                        tfCMND.placeholder = "Số passport/cmnd"
                        tfCreateAddress.text = "\(self.simActive!.NoiCapPassport)"
                        tfCreateAddress.isUserInteractionEnabled = false
                        radioPassport.isHidden = false
                        viewCustomerInfoCMND.isHidden = false
                        viewCustomerInfoPassport.isHidden = true
                        
                        if let passport = simActive?.Passport {
                            tfCMND.text = passport
                        }
                        if let dayGrantPassport = simActive?.DayGrantPassport {
                            tfCrateDate.text = dayGrantPassport
                        }
                        if(viewInfoBottom != nil){
                            viewCustomerInfo.frame.size.height = viewCustomerInfoCMND.frame.size.height + viewCustomerInfoCMND.frame.origin.y + Common.Size(s: 10)
                            viewInfoBottom.frame.origin.y = viewCustomerInfo.frame.origin.y + viewCustomerInfo.frame.size.height
                            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBottom.frame.origin.y + viewInfoBottom.frame.size.height + Common.Size(s: 20) + (self.navigationController?.navigationBar.frame.size.height)! + (UIApplication.shared.statusBarFrame.height))
                        }
                        
                    }else{
                        self.isVietNam = false
                        tfCMND.placeholder = "Số passport"
                        radioCMND.isHidden = true
                        radioCanCuoc.isHidden = true
                        self.showPassort()
                    }
                    
                }else if ("\(self.simActive!.Provider)" == "Vinaphone" || "\(self.simActive!.Provider)" == "vinaphone"){
                    
                    if ("\(self.simActive!.Nationality)" == "232"){
                        self.isVietNam = true
                        radioPassport.isSelected = true
                        tfCMND.placeholder = "Số passport/cmnd"
                        tfCreateAddress.text = "\(self.simActive!.NoiCapPassport)"
                        tfCreateAddress.isUserInteractionEnabled = false
                        radioPassport.isHidden = false
                        viewCustomerInfoCMND.isHidden = false
                        viewCustomerInfoPassport.isHidden = true
                        if let passport = simActive?.Passport {
                            tfCMND.text = passport
                        }
                        if let dayGrantPassport = simActive?.DayGrantPassport {
                            tfCrateDate.text = dayGrantPassport
                        }
                        if(viewInfoBottom != nil){
                            viewCustomerInfo.frame.size.height = viewCustomerInfoCMND.frame.size.height + viewCustomerInfoCMND.frame.origin.y + Common.Size(s: 10)
                            viewInfoBottom.frame.origin.y = viewCustomerInfo.frame.origin.y + viewCustomerInfo.frame.size.height
                            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBottom.frame.origin.y + viewInfoBottom.frame.size.height + Common.Size(s: 20) + (self.navigationController?.navigationBar.frame.size.height)! + (UIApplication.shared.statusBarFrame.height))
                        }
                        
                    }else{
                        self.isVietNam = false
                        tfCMND.placeholder = "Số passport"
                        radioCMND.isHidden = true
                        radioCanCuoc.isHidden = true
                        self.showPassort()
                    }
                }else if ("\(self.simActive!.Provider)" == "Viettel" || "\(self.simActive!.Provider)" == "viettel"){
                    if ("\(self.simActive!.Nationality)" == "232"){
                        self.isVietNam = true
                        radioPassport.isSelected = true
                        tfCMND.placeholder = "Số passport/cmnd"
                        tfCreateAddress.text = "\(self.simActive!.NoiCapPassport)"
                        tfCreateAddress.isUserInteractionEnabled = false
                        radioPassport.isHidden = false
                        viewCustomerInfoCMND.isHidden = false
                        viewCustomerInfoPassport.isHidden = true
                        if let passport = simActive?.Passport {
                            tfCMND.text = passport
                        }
                        if let dayGrantPassport = simActive?.DayGrantPassport {
                            tfCrateDate.text = dayGrantPassport
                        }
                        if(viewInfoBottom != nil){
                            viewCustomerInfo.frame.size.height = viewCustomerInfoCMND.frame.size.height + viewCustomerInfoCMND.frame.origin.y + Common.Size(s: 10)
                            viewInfoBottom.frame.origin.y = viewCustomerInfo.frame.origin.y + viewCustomerInfo.frame.size.height
                            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBottom.frame.origin.y + viewInfoBottom.frame.size.height + Common.Size(s: 20) + (self.navigationController?.navigationBar.frame.size.height)! + (UIApplication.shared.statusBarFrame.height))
                        }
                    }else{
                        self.isVietNam = false
                        tfCMND.placeholder = "Số passport"
                        radioCMND.isHidden = true
                        radioCanCuoc.isHidden = true
                        self.showPassort()
                    }
                    
                }else if ("\(self.simActive!.Provider)" == "Vietnammobile" || "\(self.simActive!.Provider)" == "vietnammobile" ){
                    if ("\(self.simActive!.Nationality)" == "232"){
                        self.isVietNam = true
                        radioPassport.isSelected = true
                        tfCMND.placeholder = "Số passport/cmnd"
                        tfCreateAddress.text = "\(self.simActive!.NoiCapPassport)"
                        
                        tfCreateAddress.isUserInteractionEnabled = false
                        radioPassport.isHidden = false
                        viewCustomerInfoCMND.isHidden = false
                        viewCustomerInfoPassport.isHidden = true
                        if let passport = simActive?.Passport {
                            tfCMND.text = passport
                        }
                        if let dayGrantPassport = simActive?.DayGrantPassport {
                            tfCrateDate.text = dayGrantPassport
                        }
                        if(viewInfoBottom != nil){
                            viewCustomerInfo.frame.size.height = viewCustomerInfoCMND.frame.size.height + viewCustomerInfoCMND.frame.origin.y + Common.Size(s: 10)
                            viewInfoBottom.frame.origin.y = viewCustomerInfo.frame.origin.y + viewCustomerInfo.frame.size.height
                            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBottom.frame.origin.y + viewInfoBottom.frame.size.height + Common.Size(s: 20) + (self.navigationController?.navigationBar.frame.size.height)! + (UIApplication.shared.statusBarFrame.height))
                        }
                    }else{
                        self.isVietNam = false
                        tfCMND.placeholder = "Số passport"
                        radioCMND.isHidden = true
                        radioCanCuoc.isHidden = true
                        self.showPassort()
                    }
                    
                }else if ("\(self.simActive!.Provider)" == "Itelecom" ){
                    if ("\(self.simActive!.Nationality)" == "232"){
                        self.isVietNam = true
                        radioPassport.isSelected = true
                        tfCMND.placeholder = "Số passport/cmnd"
                        tfCreateAddress.text = "\(self.simActive!.NoiCapPassport)"
                        
                        tfCreateAddress.isUserInteractionEnabled = false
                        radioPassport.isHidden = false
                        viewCustomerInfoCMND.isHidden = false
                        viewCustomerInfoPassport.isHidden = true
                        if let passport = simActive?.Passport {
                            tfCMND.text = passport
                        }
                        if let dayGrantPassport = simActive?.DayGrantPassport {
                            tfCrateDate.text = dayGrantPassport
                        }
                        if(viewInfoBottom != nil){
                            viewCustomerInfo.frame.size.height = viewCustomerInfoCMND.frame.size.height + viewCustomerInfoCMND.frame.origin.y + Common.Size(s: 10)
                            viewInfoBottom.frame.origin.y = viewCustomerInfo.frame.origin.y + viewCustomerInfo.frame.size.height
                            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBottom.frame.origin.y + viewInfoBottom.frame.size.height + Common.Size(s: 20) + (self.navigationController?.navigationBar.frame.size.height)! + (UIApplication.shared.statusBarFrame.height))
                        }
                    }else{
                        self.isVietNam = false
                        tfCMND.placeholder = "Số passport"
                        radioCMND.isHidden = true
                        radioCanCuoc.isHidden = true
                        self.showPassort()
                    }
                    
                }
            }
        }
    }
    func loadAPICMND(){
        if(imgViewCMNDTruoc.image != nil){
            let imageCMNDTruoc:UIImage = self.resizeImageWidth(image: imgViewCMNDTruoc.image!,newWidth: Common.resizeImageWith)!
            if let imageDataCMNDTruoc:NSData =  imageCMNDTruoc.jpegData(compressionQuality: Common.resizeImageValue) as NSData?{
                let strBase64CMNDTruoc = imageDataCMNDTruoc.base64EncodedString(options: .endLineWithLineFeed)
                
                let newViewController = LoadingViewController()
                newViewController.content = "Đang nhận dạng CMND mặt trước, vui lòng chờ..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                MPOSAPIManager.GetinfoCustomerByImageIDCard(Image_CMND: strBase64CMNDTruoc, NhaMang: "\(simActive!.Provider)",Type:"1", handler: { (results, err) in
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            if(results.count > 0){
                                let item = results[0]
                                self.tfCMND.text = "\(item.CMND)"
                                self.tfUserName.text = "\(item.FullName)"
                                self.tfBirthday.text = "\(item.Birthday)"
                                self.tfCrateDate.text = "\(item.DateCreateCMND)"
                                self.hasAddress = item.Address == "" ? false : true
                                if(self.simActive!.Provider != "Vinaphone" && self.simActive!.Provider != "Mobifone" && self.simActive!.Provider != "mobifone"){
                                    self.tfAddress.text = "\(item.Address)"
                                }
                            
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
                                MPOSAPIManager.GetDistricts(MaCodeTinh: "\(self.selectProvice)", NhaMang: "\(self.simActive!.Provider)", handler: { (results, error) in
                                    
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
                                        MPOSAPIManager.GetPrecincts(MaCodeHUyen:  "\(self.selectDistrict)", MaCodeTinh: "\(self.selectProvice)", NhaMang: "\(self.simActive!.Provider)", handler: { (results, error) in
                                            
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
                                    self.radioMale.isSelected = true
                                    self.gender = 1
                                }else if (item.Gender == 1){
                                    self.radioFemale.isSelected = true
                                    self.gender = 2
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
        
        if(imgViewCMNDSau.image != nil){
            let imageCMNDSau:UIImage = self.resizeImageWidth(image: imgViewCMNDSau.image!,newWidth: Common.resizeImageWith)!
            if let imageDataCMNDSau:NSData =  imageCMNDSau.jpegData(compressionQuality: Common.resizeImageValue) as NSData?{
                let strBase64CMNDSau = imageDataCMNDSau.base64EncodedString(options: .endLineWithLineFeed)
                
                let newViewController = LoadingViewController()
                newViewController.content = "Đang nhận dạng CMND mặt sau, vui lòng chờ..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                MPOSAPIManager.GetinfoCustomerByImageIDCardSau(Image_CMND: strBase64CMNDSau, NhaMang: "\(simActive!.Provider)",Type:"2", handler: { (results, err) in
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            self.tfCrateDate.text = "\(results[0].issue_date)"
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
    @objc func actionScan(_: UITapGestureRecognizer){
       
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            if(!code.isEmpty){
                self.tfSerialSim.text = code
            }
        }
        self.present(viewController, animated: false, completion: nil)
        
    }
    func scanSuccess(_ viewController: ScanBarcodeViewController, scan: String) {
        self.tfSerialSim.text = scan
    }
    func showPassort(){
        radioPassport.isHidden = false
        radioPassport.isSelected = true
        radioCMND.isSelected = false
        radioCanCuoc.isSelected = false
        radioCMND.isHidden = true
        radioCanCuoc.isHidden = true
        typeKichHoat = 3
        tfCMND.placeholder = "Số passport"
        tfCMND.keyboardType = UIKeyboardType.default
        viewCustomerInfoCMND.isHidden = true
        viewCustomerInfoPassport.isHidden = false
        if let dayGrantPassport = simActive?.DayGrantPassport {
            tfCrateDate.text = dayGrantPassport
        }
        if(viewInfoBottom != nil){
            
            viewCustomerInfo.frame.size.height = viewCustomerInfoPassport.frame.size.height + viewCustomerInfoPassport.frame.origin.y + Common.Size(s: 10)
            viewInfoBottom.frame.origin.y = viewCustomerInfo.frame.origin.y + viewCustomerInfo.frame.size.height
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBottom.frame.origin.y + viewInfoBottom.frame.size.height + Common.Size(s: 20) + (self.navigationController?.navigationBar.frame.size.height)! + (UIApplication.shared.statusBarFrame.height))
        }
    }
    func showCMND(){
        tfCMND.keyboardType = UIKeyboardType.phonePad
        if let loaiGiayTo = simActive?.LoaiGiayTo {
            
            if(loaiGiayTo == 1){
                radioCMND.isHidden = false
                radioCanCuoc.isHidden = false
                radioPassport.isHidden = false
                radioCMND.isSelected = true
                radioPassport.isSelected = false
                radioCanCuoc.isSelected = false
                typeKichHoat = 1
                tfCMND.placeholder = "Số CMND"
                
                //                radioCMND.frame.origin.x = Common.Size(s: 20)
                //                radioCanCuoc.frame.origin.x = radioCMND.frame.origin.x + radioCMND.frame.size.width
                viewCustomerInfoCMND.isHidden = false
                viewCustomerInfoPassport.isHidden = true
            }else if(loaiGiayTo == 2){
                radioCMND.isHidden = false
                radioCanCuoc.isHidden = false
                radioPassport.isHidden = false
                radioCanCuoc.isSelected = true
                radioPassport.isSelected = false
                radioCMND.isSelected = false
                typeKichHoat = 2
                tfCMND.placeholder = "Số căn cước"
                
                //                radioCMND.frame.origin.x = Common.Size(s: 20)
                //                radioCanCuoc.frame.origin.x = radioCMND.frame.origin.x + radioCMND.frame.size.width
                viewCustomerInfoCMND.isHidden = false
                viewCustomerInfoPassport.isHidden = true
            }else if(loaiGiayTo == 3){
                radioCMND.isHidden = false
                radioCanCuoc.isHidden = false
                radioPassport.isHidden = false
                radioCanCuoc.isSelected = false
                radioPassport.isSelected = true
                radioCMND.isSelected = false
                typeKichHoat = 3
                tfCMND.placeholder = "Số passport"
                radioCMND.frame.origin.x = Common.Size(s: 20)
                radioCanCuoc.frame.origin.x = radioCMND.frame.origin.x + radioCMND.frame.size.width
                viewCustomerInfoCMND.isHidden = false
                viewCustomerInfoPassport.isHidden = true
            }
        }
        if(viewInfoBottom != nil){
            viewCustomerInfo.frame.size.height = viewCustomerInfoCMND.frame.size.height + viewCustomerInfoCMND.frame.origin.y + Common.Size(s: 10)
            viewInfoBottom.frame.origin.y = viewCustomerInfo.frame.origin.y + viewCustomerInfo.frame.size.height
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBottom.frame.origin.y + viewInfoBottom.frame.size.height + Common.Size(s: 20) + (self.navigationController?.navigationBar.frame.size.height)! + (UIApplication.shared.statusBarFrame.height))
        }
        
    }
    
    @objc func tapShowSign(sender:UITapGestureRecognizer) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
        // let nav = UINavigationController(rootViewController: signatureVC)
        //present(nav, animated: true, completion: nil)
        self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    
    @objc func tapShowCMNDTruoc(sender:UITapGestureRecognizer) {
        self.posImageUpload = 1
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
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
    @objc func tapShowCMNDSau(sender:UITapGestureRecognizer) {
        self.posImageUpload = 2
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
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
    @objc func tapShowAvatar(sender:UITapGestureRecognizer) {
        self.posImageUpload = 3
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
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
    @objc func tapShowDetail(sender:UITapGestureRecognizer) {
        if (viewSimInfoMore.frame.size.height == heightSimInfoMore){
            viewSimInfoMore.frame.size.height = 0
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: "Chi tiết", attributes: underlineAttribute)
            lbSimInfoMore.attributedText = underlineAttributedString
            viewImageUpload.frame.origin.y = viewSimInfoMore.frame.origin.y + viewSimInfoMore.frame.size.height + Common.Size(s:5)
        }else{
            viewSimInfoMore.frame.size.height = heightSimInfoMore
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: "Ẩn chi tiết", attributes: underlineAttribute)
            lbSimInfoMore.attributedText = underlineAttributedString
            viewImageUpload.frame.origin.y = viewSimInfoMore.frame.origin.y + viewSimInfoMore.frame.size.height + Common.Size(s:15)
        }
        
        //        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewImageUpload.frame.origin.y + viewImageUpload.frame.size.height + Common.Size(s: 20))
        
        viewInfoBottom.frame.size.height = viewImageUpload.frame.origin.y + viewImageUpload.frame.size.height
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBottom.frame.origin.y + viewInfoBottom.frame.size.height + Common.Size(s: 20) + (self.navigationController?.navigationBar.frame.size.height)! + (UIApplication.shared.statusBarFrame.height))
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
                tfCMND.placeholder = "Số CMND"
                tfCMND.keyboardType = UIKeyboardType.numberPad
                if(tfCreateAddress != nil){
                    tfCreateAddress.text = ""
                    tfCreateAddress.isUserInteractionEnabled = true
                }
                break
            case "Căn cước":
                typeKichHoat = 2
                radioCanCuoc.isSelected = true
                tfCMND.placeholder = "Số căn cước"
                tfCMND.keyboardType = UIKeyboardType.numberPad
                if(tfCreateAddress != nil){
                    tfCreateAddress.text = ""
                    tfCreateAddress.isUserInteractionEnabled = true
                }
                break
            case "Passport":
                typeKichHoat = 3
                tfCMND.placeholder = "Số passport/cmnd"
                tfCMND.keyboardType = UIKeyboardType.default
                radioPassport.isSelected = true
                if(tfCreateAddress != nil){
                    tfCreateAddress.text = "\(self.simActive!.NoiCapPassport)"
                    if (tfCreateAddress.text!.count <= 0 ){
                        tfCreateAddress.text = "Cục xuất nhập cảnh"
                    }
                    tfCreateAddress.isUserInteractionEnabled = false
                }
                break
            default:
                typeKichHoat = 1
                radioCMND.isSelected = true
                tfCMND.placeholder = "Số CMND"
                break
            }
        }
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
                gender = 1
                radioMale.isSelected = true
                break
            case "Nữ":
                gender = 2
                radioFemale.isSelected = true
                break
            default:
                gender = 1
                radioMale.isSelected = true
                break
            }
        }
    }
    func imageCMNDTruoc(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDTruoc.frame.size.width / sca
        viewImageCMNDTruoc.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDTruoc  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDTruoc.frame.size.width, height: heightImage))
        //        imgViewCMNDTruoc.backgroundColor = .red
        imgViewCMNDTruoc.contentMode = .scaleAspectFit
        imgViewCMNDTruoc.image = image
        
        viewImageCMNDTruoc.addSubview(imgViewCMNDTruoc)
        
        viewImageCMNDTruoc.frame.size.height = imgViewCMNDTruoc.frame.size.height + imgViewCMNDTruoc.frame.origin.y
        viewCMNDTruoc.frame.size.height = viewImageCMNDTruoc.frame.origin.y + viewImageCMNDTruoc.frame.size.height
        
        viewCMNDSau.frame.origin.y = viewCMNDTruoc.frame.origin.y + viewCMNDTruoc.frame.size.height + Common.Size(s:10)
        
        
        
        //        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewImageUpload.frame.origin.y + viewImageUpload.frame.size.height + Common.Size(s: 20))
        
        viewCustomerInfo.frame.origin.y = viewCMNDSau.frame.size.height + viewCMNDSau.frame.origin.y + Common.Size(s:10)
        viewInfoBottom.frame.origin.y = viewCustomerInfo.frame.origin.y + viewCustomerInfo.frame.size.height
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBottom.frame.origin.y + viewInfoBottom.frame.size.height + Common.Size(s: 20) + (self.navigationController?.navigationBar.frame.size.height)! + (UIApplication.shared.statusBarFrame.height))
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.loadAPICMND()
        }
    }
    
    func imageCMNDSau(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDSau.frame.size.width / sca
        viewImageCMNDSau.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDSau  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDSau.frame.size.width, height: heightImage))
        //        imgViewCMNDTruoc.backgroundColor = .red
        imgViewCMNDSau.contentMode = .scaleAspectFit
        imgViewCMNDSau.image = image
        viewImageCMNDSau.addSubview(imgViewCMNDSau)
        
        viewImageCMNDSau.frame.size.height = imgViewCMNDSau.frame.size.height + imgViewCMNDSau.frame.origin.y
        viewCMNDSau.frame.size.height = viewImageCMNDSau.frame.origin.y + viewImageCMNDSau.frame.size.height
        
        
        viewCustomerInfo.frame.origin.y = viewCMNDSau.frame.size.height + viewCMNDSau.frame.origin.y + Common.Size(s:10)
        viewInfoBottom.frame.origin.y = viewCustomerInfo.frame.origin.y + viewCustomerInfo.frame.size.height
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBottom.frame.origin.y + viewInfoBottom.frame.size.height + Common.Size(s: 20) + (self.navigationController?.navigationBar.frame.size.height)! + (UIApplication.shared.statusBarFrame.height))
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.loadAPICMNDSau()
        }
    }
    func imageAvatar(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageAvatar.frame.size.width / sca
        viewImageAvatar.subviews.forEach { $0.removeFromSuperview() }
        imgViewAvatar  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageAvatar.frame.size.width, height: heightImage))
        //        imgViewCMNDTruoc.backgroundColor = .red
        imgViewAvatar.contentMode = .scaleAspectFit
        imgViewAvatar.image = image
        viewImageAvatar.addSubview(imgViewAvatar)
        
        viewImageAvatar.frame.size.height = imgViewAvatar.frame.size.height + imgViewAvatar.frame.origin.y
        viewAvatar.frame.size.height = viewImageAvatar.frame.origin.y + viewImageAvatar.frame.size.height
        
        viewSign.frame.origin.y = viewAvatar.frame.origin.y + viewAvatar.frame.size.height + Common.Size(s:10)
        
        btPay.frame.origin.y = viewSign.frame.origin.y + viewSign.frame.size.height + Common.Size(s:20)
        
        viewImageUpload.frame.size.height = btPay.frame.origin.y + btPay.frame.size.height
        
        //        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewImageUpload.frame.origin.y + viewImageUpload.frame.size.height + Common.Size(s: 20))
        viewInfoBottom.frame.size.height = viewImageUpload.frame.origin.y + viewImageUpload.frame.size.height
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBottom.frame.origin.y + viewInfoBottom.frame.size.height + Common.Size(s: 20) + (self.navigationController?.navigationBar.frame.size.height)! + (UIApplication.shared.statusBarFrame.height))
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
    func epSignature(_: EPSignatureViewController, didCancel error : NSError) {
        print("User canceled")
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        
        let width = viewImageSign.frame.size.width - Common.Size(s:10)
        
        let sca:CGFloat = boundingRect.size.width / boundingRect.size.height
        let heightImage:CGFloat = width / sca
        
        viewImageSign.subviews.forEach { $0.removeFromSuperview() }
        imgViewSignature  = UIImageView(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: width, height: heightImage))
        //        imgViewSignature.backgroundColor = .red
        imgViewSignature.contentMode = .scaleAspectFit
        viewImageSign.addSubview(imgViewSignature)
        imgViewSignature.image = cropImage(image: signatureImage, toRect: boundingRect)
        
        viewImageSign.frame.size.height = imgViewSignature.frame.size.height + imgViewSignature.frame.origin.y + Common.Size(s:5)
        viewSign.frame.size.height = viewImageSign.frame.origin.y + viewImageSign.frame.size.height
        
        btPay.frame.origin.y = viewSign.frame.origin.y + viewSign.frame.size.height + Common.Size(s:20)
        
        viewImageUpload.frame.size.height = btPay.frame.origin.y + btPay.frame.size.height
        
        viewInfoBottom.frame.size.height = viewImageUpload.frame.origin.y + viewImageUpload.frame.size.height
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBottom.frame.origin.y + viewInfoBottom.frame.size.height + Common.Size(s: 20) + (self.navigationController?.navigationBar.frame.size.height)! + (UIApplication.shared.statusBarFrame.height))
        //        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewImageUpload.frame.origin.y + viewImageUpload.frame.size.height + Common.Size(s: 20))
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func actionPopUp(sender: UIButton!) {
        let alert = UIAlertController(title: "Thông báo", message: "Bạn chắc chắn đã dùng CMND của khách hàng để kích hoạt SIM ?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Không", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Có", style: UIAlertAction.Style.destructive, handler:{(alert: UIAlertAction!) in
            self.actionPay()
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func actionPay() {
        
        let name = tfUserName.text!
        if (name.count == 0){
            Toast(text: "Tên không được để trống!").show()
            return
        }
        var gt:String = "Nam"
        if (gender == -1){
            Toast(text: "Bạn chưa chọn giới tính").show()
            return
        }else if (gender == 1){
            gt = "Nam"
        }else{
            gt = "Nữ"
        }
        let birthday = tfBirthday.text!
        if (birthday.count == 0){
            Toast(text: "Ngày sinh không được để trống!").show()
            return
        }
        if (!checkDate(stringDate: birthday)){
            Toast(text: "Ngày sinh sai định dạng!").show()
            return
        }
        var address = ""
        var addressVT:String = ""
        
        if("\(self.simActive!.Provider)" != "Mobifone"){
            addressVT = tfAddress.text!
            if("\(self.simActive!.Provider)" != "Vinaphone"){
                if (addressVT.count <= 3){
                    Toast(text: "Địa chỉ không được để trống").show()
                    return
                }
            }
           
        }else{
            addressVT = "\(tfSoNha.text!),\(tfTenDuong.text!),\(tfApThon.text!)"
            if(self.tfSoNha.text! == "" && self.tfTenDuong.text! == "" && self.tfApThon.text! == ""){
                Toast(text: "Vui lòng nhập một trong các mục Số nhà - Tên đường - Ấp/thôn/xóm/khu phố").show()
                return
            }
            
        }
        if (selectProvice == "" && (simActive!.Provider != "Vinaphone" || simActive!.Provider != "vinaphone")){
            Toast(text: "Tỉnh/Thành phố không được để trống").show()
            return
        }
        if (selectDistrict == "" && (simActive!.Provider != "Vinaphone" || simActive!.Provider != "vinaphone")){
            Toast(text: "Quận/Huyện không được để trống").show()
            return
        }
        if (simActive!.Provider == "Vietnammobile"){
            let wa = wardsButton!.text
            if (wa != ""){
                selectPrecinct = wa!
            }else{
                selectPrecinct = "MINHDH"
            }
        }
        if (simActive!.Provider == "Itelecom"){
            let wa = wardsButton!.text
            if (wa != ""){
                selectPrecinct = wa!
            }else{
                selectPrecinct = "MINHDH"
            }
        }
        //        if (selectPrecinct == "" && (simActive!.Provider != "Vinaphone" || simActive!.Provider != "vinaphone")){
        //            Toast(text: "Phường/Xã không được để trống").show()
        //            return
        //        }
        if(self.wardsButton.text == ""){
            Toast(text: "Phường/Xã không được để trống").show()
            return
        }
        var nationalText = nationalButton.text!
        if (nationalText.count <= 0){
            Toast(text: "Quốc tịch không được để trống").show()
            return
        }
        
        let numSO = self.tfNumSO.text!
        if (numSO.count <= 0){
            Toast(text: "Số đơn hàng không được để trống").show()
            return
        }
        
        //cmnd
        var valueCMND:String = ""
        var valueDateCMND:String = ""
        var valueAddressCMND:String = ""
        //can cuoc
        var valueCanCuoc:String = ""
        var valueDateCanCuoc:String = ""
        var valueAddressCanCuoc:String = ""
        //passport VN
        var valuePassport:String = ""
        var valueDatePassport:String = ""
        var valueAddressPassport:String = ""
        var valueVisa:String = ""
        
        if (typeKichHoat == -1){
            Toast(text: "Bạn chưa chọn loại giấy tờ").show()
            return
        }else if(typeKichHoat == 1){
            //CMND
            let cmnd = tfCMND.text!
            if (cmnd.count <= 5){
                Toast(text: "Số CMND không hợp lệ!").show()
                return
            }
            valueCMND = cmnd
            
            let createDate = tfCrateDate.text!
            if (createDate.count == 0){
                Toast(text: "Ngày cấp không được để trống!").show()
                return
            }
            if (!checkDate(stringDate: createDate)){
                Toast(text: "Ngày cấp CMND sai định dạng!").show()
                return
            }
            valueDateCMND = createDate
            
            let createAddress = tfCreateAddress.text!
            if (createAddress.count <= 0){
                Toast(text: "Nơi cấp không được để trống").show()
                return
            }
            valueAddressCMND = createAddress
            
        }else if(typeKichHoat == 2){
            //Can cuoc
            let canCuoc = tfCMND.text!
            if (canCuoc.count <= 5){
                Toast(text: "Số căn cước không hợp lệ!").show()
                return
            }
            valueCanCuoc = canCuoc
            
            let createDate = tfCrateDate.text!
            if (createDate.count == 0){
                Toast(text: "Ngày cấp không được để trống!").show()
                return
            }
            if (!checkDate(stringDate: createDate)){
                Toast(text: "Ngày cấp căn cước sai định dạng!").show()
                return
            }
            valueDateCanCuoc = createDate
            
            let createAddress = tfCreateAddress.text!
            if (createAddress.count <= 0){
                Toast(text: "Nơi cấp không được để trống").show()
                return
            }
            valueAddressCanCuoc = createAddress
            if(self.selectAddressCMND != "CDD"){
                if(self.simActive!.Provider == "Vinaphone"){
                    Toast(text: "Bạn phải chọn đúng nơi cấp thẻ căn cước: Cục ĐKQL cư trú và DLQG về cư dân").show()
                    return
                }
                
            }
        }else if(typeKichHoat == 3){
            //Passport
            if (self.isVietNam){
                let canCuoc = tfCMND.text!
                if (canCuoc.count <= 5){
                    Toast(text: "Số căn cước không hợp lệ!").show()
                    return
                }
                valuePassport = canCuoc
                
                let createDate = tfCrateDate.text!
                if (createDate.count == 0){
                    Toast(text: "Ngày cấp không được để trống!").show()
                    return
                }
                if (!checkDate(stringDate: createDate)){
                    Toast(text: "Ngày cấp căn cước sai định dạng!").show()
                    return
                }
                valueDatePassport = createDate
                
                let createAddress = tfCreateAddress.text!
                if (createAddress.count <= 0){
                    Toast(text: "Nơi cấp không được để trống").show()
                    return
                }
                valueAddressPassport = createAddress
                let visa = tfVisa.text!
                valueVisa = visa
            }else{
                let passport = tfPassport.text!
                if (passport.count <= 5){
                    Toast(text: "Số passport không hợp lệ!").show()
                    return
                }
                valuePassport = passport
                
                let createDatePassport = tfCrateDatePassport.text!
                if (createDatePassport.count == 0){
                    Toast(text: "Ngày cấp không được để trống!").show()
                    return
                }
                if (!checkDate(stringDate: createDatePassport)){
                    Toast(text: "Ngày cấp passport sai định dạng!").show()
                    return
                }
                valueDatePassport = createDatePassport
                
                let palaceCreatePassport = tfPalaceCreatePassport.text!
                if (palaceCreatePassport.count <= 0){
                    Toast(text: "Nơi cấp không được để trống").show()
                    return
                }
                valueAddressPassport = palaceCreatePassport
                let visa = tfVisa.text!
                valueVisa = visa
            }
        }
        print("valueCMND: \(valueCMND); valueDateCMND: \(valueDateCMND); valueAddressCMND: \(valueAddressCMND) | valueCanCuoc: \(valueCanCuoc); valueDateCanCuoc: \(valueDateCanCuoc); valueAddressCanCuoc: \(valueAddressCanCuoc) | valuePassport: \(valuePassport); valueDatePassport: \(valueDatePassport); valueAddressPassport: \(valueAddressPassport); valueVisa: \(valueVisa)")
        
        
        let phoneNum = amountButton.titleLabel!.text
        if ((phoneNum?.count)! <= 3){
            Toast(text: "Sim không được để trống").show()
            return
        }
        
        let serialSim = tfSerialSim.text!
        if (serialSim.count <= 5){
            Toast(text: "Serisim không được để trống").show()
            return
        }
        
        if (imgViewSignature == nil){
            Toast(text: "Khách hàng chưa ký tên").show()
            return
        }
        if (imgViewAvatar == nil){
            Toast(text: "Chưa có hình ảnh khách hàng").show()
            return
        }
        if (imgViewCMNDTruoc == nil){
            Toast(text: "Chưa có CMND mặt trước").show()
            return
        }
        if (imgViewCMNDSau == nil){
            Toast(text: "Chưa có CMND mặt sau").show()
            return
        }
        address =  "\(addressVT), \(wardsButton.text!), \(districtButton.text!), \(cityButton.text!)"
        
        //        if (address.characters.count > 50){
        //            Toast(text: "Địa chỉ quá dài, chỉ nhập số nhà và tên đường!").show()
        //            return
        //        }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin kích hoạt..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        var heightValue:CGFloat = 0.0
        
        if (simActive!.Provider == "Viettel"){
            heightValue = 90 * 6
            //            heightValue = 90
        }else if (simActive!.Provider == "Vinaphone"){
            heightValue = 70 * 8
            //             heightValue = 70
        }else {
            heightValue = 70 * 8
            //             heightValue = 70
        }
        
        let imageSign:UIImage = self.resizeImage(image: imgViewSignature.image!,newHeight: heightValue)!
        
        if let imageDataSign:NSData = imageSign.pngData() as NSData?{
            
            //base chữ ký
            let strBase64Sign = imageDataSign.base64EncodedString(options: .endLineWithLineFeed)
            
            let imageCMNDTruoc:UIImage = self.resizeImageWidth(image: imgViewCMNDTruoc.image!,newWidth: Common.resizeImageWith)!
            if let imageDataCMNDTruoc:NSData = imageCMNDTruoc.jpegData(compressionQuality: Common.resizeImageValue)  as NSData?{
                //base cmnd truoc
                let strBase64CMNDTruoc = imageDataCMNDTruoc.base64EncodedString(options: .endLineWithLineFeed)
                
                let imageCMNDSau:UIImage = self.resizeImageWidth(image: imgViewCMNDSau.image!,newWidth: Common.resizeImageWith)!
                if let imageDataCMNDSau:NSData = imageCMNDSau.jpegData(compressionQuality: Common.resizeImageValue)  as NSData?{
                    //base cmnd sau
                    let strBase64CMNDSau = imageDataCMNDSau.base64EncodedString(options: .endLineWithLineFeed)
                    
                    
                    let imageAvatar:UIImage = self.resizeImageWidth(image: imgViewAvatar.image!,newWidth: Common.resizeImageWith)!
                    if let imageDataAvatar:NSData = imageAvatar.jpegData(compressionQuality: Common.resizeImageValue) as NSData?{
                        //base avatar
                        let strBase64Avatar = imageDataAvatar.base64EncodedString(options: .endLineWithLineFeed)
                        
                        if (simActive!.Provider == "Viettel"){
                            var inputCMND = ""
                            var inputDateCMND = ""
                            var inputAddressCMND = ""
                            var inputAddressPassport = ""
                            var inputSoVisa = ""
                            if (typeKichHoat == 1){
                                inputCMND = valueCMND
                                inputDateCMND = valueDateCMND
                                inputAddressCMND = valueAddressCMND
                            }else if (typeKichHoat == 2){
                                inputCMND = valueCanCuoc
                                inputDateCMND = valueDateCanCuoc
                                inputAddressCMND = valueAddressCanCuoc
                            }else{
                                inputCMND = valuePassport
                                inputDateCMND = valueDatePassport
                                inputAddressPassport = valueAddressPassport
                                inputAddressCMND = valueAddressPassport
                                inputSoVisa = valueVisa
                            }
                            
                            MPOSAPIManager.getListCustomersViettel(idNo: "\(inputCMND)") { (results, err) in
                                if(err.count <= 0){
                                    let custID:String = ""
                                    if(results.count > 0){
                                        
                                        var gtInt:String = "0"
                                        if (self.gender == 1){
                                            gtInt = "0"
                                        }else{
                                            gtInt = "1"
                                        }
                                        
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                        let when = DispatchTime.now() + 0.5
                                        DispatchQueue.main.asyncAfter(deadline: when) {
                                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                            
                                            let inputSim = InputSimViettel(p_Duong: "\(addressVT)", p_Phuong: "\(self.wardsButton.text!)", p_Quan: "\(self.districtButton.text!)", p_Tinh: "\(self.cityButton.text!)", p_QuocTich: "\(nationalText)", ChuKy: strBase64Sign, p_SoPhieuYeuCau: "00001", p_TenKH: name, p_NgaySinh_KH: birthday, p_GioiTinh_KH: gt, p_SoCMND_KH: inputCMND, p_NoiCap_CMND_KH: inputAddressCMND, p_NgayCap_CMND_KH: inputDateCMND, p_DiaChi_CMND_KH: inputAddressCMND, p_GoiCuocDK_Line1: "\(self.simActive!.GoiCuoc)", p_SoThueBao_Line1: phoneNum!, p_SoSerialSim_Imei_Line1: serialSim, p_Visa: inputSoVisa,strBase64CMNDTruoc:strBase64CMNDTruoc,strBase64CMNDSau:strBase64CMNDSau,strBase64Avatar:strBase64Avatar,simActive:self.simActive!,Nationality:self.selectNational,ProvinceCode:self.selectProvice,DistrictCode:self.selectDistrict,PrecinctCode:self.selectPrecinct,contractNo:"\(numSO)",LoaiGiayTo:"\(self.typeKichHoat)",Passport:"\(valuePassport)",DayGrantPassport:"\(valueDatePassport)",NoiCapPassport:inputAddressPassport,gtInt:gtInt)
                                            
                                            let newViewController = DialogCustomersViewController()
                                            newViewController.listSession = results
                                            newViewController.inputSim = inputSim
                                            newViewController.delegate = self
                                            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                                            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                                            self.present(newViewController, animated: true, completion: nil)
                                        }
                                    }else{
                                        
                                        //                                        if(results.count == 1){
                                        //                                            custID = results[0].custId
                                        //                                        }
                                        var gt:String = "0"
                                        if (self.gender == 1){
                                            gt = "0"
                                        }else{
                                            gt = "1"
                                        }
                                        
                                        MPOSAPIManager.AutoCreateImageActiveSimViettelHD(p_MaKH: custID, p_SoNha: "", p_Duong: "\(addressVT)",p_Phuong:"\(self.wardsButton.text!)", p_Quan: "\(self.districtButton.text!)", p_Tinh: "\(self.cityButton.text!)", p_QuocTich: "\(nationalText)", ChuKy: strBase64Sign, p_SoPhieuYeuCau: "00001", p_TenKH: name, p_DT_LienHe_KH: "", p_NgaySinh_KH: birthday, p_GioiTinh_KH: gt, p_SoCMND_KH: inputCMND, p_NoiCap_CMND_KH: inputAddressCMND, p_NgayCap_CMND_KH: inputDateCMND, p_DiaChi_CMND_KH: inputAddressCMND, p_GoiCuocDK_Line1: "\(self.simActive!.GoiCuoc)", p_SoThueBao_Line1: phoneNum!, p_SoSerialSim_Imei_Line1: serialSim,p_Visa: inputSoVisa, handler: { (imageInfo, err) in
                                            if (err.count<=0){
                                                var gt:String = "0"
                                                if (self.gender == 1){
                                                    gt = "0"
                                                }else{
                                                    gt = "1"
                                                }
                                                let imagesAll = "\(strBase64CMNDTruoc),\(strBase64CMNDSau),\(imageInfo!.ResultImage),\(strBase64Avatar)"
                                                var byPassValidateAI:String = ""
                                                if(self.isSkipAI == true){
                                                    byPassValidateAI = "1"
                                                }
                                             
                                                MPOSAPIManager.ActiveSim(Provider: "\(self.simActive!.Provider)", Phonenumber: phoneNum!, Imei: "", SeriSIM: serialSim, IMSI: "", FullName: name, Birthday: birthday, Gender: gt, Address: addressVT, CMND: inputCMND, DateCreateCMND: inputDateCMND, PalaceCreateCMND: inputAddressCMND, Nationality: self.selectNational, ProvinceCode: self.selectProvice, DistrictCode: self.selectDistrict, PrecinctCode: self.selectPrecinct, contractNo: "\(numSO)", Note: "", ShopCode: "\(Cache.user!.ShopCode)", UserCode: "\(Cache.user!.UserName)", Images: imagesAll,ID: "\(self.simActive!.ID)",GoiCuoc: "\(self.simActive!.GoiCuoc)",ProductCode: "\(self.simActive!.ProductCode)",LoaiGiayTo:"\(self.typeKichHoat)",Passport:"\(valuePassport)",DayGrantPassport:"\(valueDatePassport)",SOPOS:"\(self.simActive!.POSSODocNum)",NgayHetHanGiayTo:"", TenShop: "\(self.simActive!.TenShop)", DiaChiShop: "\(self.simActive!.DiaChiShop)", TenNhanVien: "\(self.simActive!.TenNhanVien)", NoiCapPassport: inputAddressPassport, SoVisa: inputSoVisa, CustId: custID,SSD: "\(self.simActive!.SSD)",IsEsim: 0, Home:self.tfSoNha.text!,StreetName:self.tfTenDuong.text!,StreetBlockName:self.tfApThon.text!,byPassValidateAI: byPassValidateAI, lan: "", ocr_confirm: "", handler: { (status, data) in
                                                    
                                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                                    let when = DispatchTime.now() + 0.5
                                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                                        if (status){
                                                            let alert = UIAlertController(title: "Thành công", message: "\(data)", preferredStyle: UIAlertController.Style.alert)
                                                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                                                                (alert: UIAlertAction!) -> Void in
                                                                _ = self.navigationController?.popViewController(animated: true)
                                                                self.dismiss(animated: true, completion: nil)
                                                            }))
                                                            self.present(alert, animated: true, completion: nil)
                                                        }else{
                                                            var data1 = ""
                                                            if let ip = Cache.ShopInfo?.IPPublic {
                                                                data1 =  "\(self.simActive!.Provider) - \(phoneNum!) - \(serialSim) - \(Cache.user!.UserName) - \(Cache.user!.ShopCode) - \(ip)"
                                                            }else{
                                                                data1 = "\(self.simActive!.Provider) - \(phoneNum!) - \(serialSim) - \(Cache.user!.UserName) - \(Cache.user!.ShopCode) - NO IP"
                                                            }
                                                            let alert = UIAlertController(title: "Thất bại", message: "[\(data1)] - \(data)", preferredStyle: UIAlertController.Style.alert)
                                                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                                                                (alert: UIAlertAction!) -> Void in
                                                                self.isSkipAI = true
                                                            
                                                            }))
                                                            
                                                            alert.addAction(UIAlertAction(title: "Báo lỗi", style: UIAlertAction.Style.destructive, handler:{(alert: UIAlertAction!) in
                                                                let newViewController = CreateCallLogErrorViewController()
                                                                newViewController.msgAPI = data
                                                                self.navigationController?.pushViewController(newViewController, animated: true)
                                                                
                                                            }))
                                                            self.present(alert, animated: true, completion: nil)
                                                        }
                                                    }
                                                })
                                            }else{
                                                print("err \(err)")
                                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                                let when = DispatchTime.now() + 0.5
                                                DispatchQueue.main.asyncAfter(deadline: when) {
                                                    Toast(text: "Tạo phiếu thông tin khách hàng thất bại").show()
                                                }
                                            }
                                        })
                                        
                                    }
                                    
                                }else{
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let when = DispatchTime.now() + 0.5
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        Toast(text: "Tìm thông tin khách hàng thất bại").show()
                                    }
                                }
                            }
                 
                        }else  if (simActive!.Provider == "Vinaphone"){
                            var gt:String = "0"
                            var lanString:String = ""
                            if(lan > 0){
                                lanString = "\(lan)"
                            }
                            if (gender == 1){
                                gt = "0"
                            }else{
                                gt = "1"
                            }
                            
                            var inputCMND = ""
                            var inputDateCMND = ""
                            var inputAddressCMND = ""
                            var inputAddressPassport = ""
                            var inputSoVisa = ""
                            if (typeKichHoat == 1){
                                inputCMND = valueCMND
                                inputDateCMND = valueDateCMND
                                inputAddressCMND = self.selectAddressCMND
                            }else if (typeKichHoat == 2){
                                inputCMND = valueCanCuoc
                                inputDateCMND = valueDateCanCuoc
                                inputAddressCMND = self.selectAddressCMND
                            }else{
                                inputCMND = valuePassport
                                inputDateCMND = valueDatePassport
                                inputAddressCMND = valueAddressPassport
                                inputAddressPassport = valueAddressPassport
                                inputSoVisa = valueVisa
                            }
                            
                            MPOSAPIManager.AutoCreateImageActiveSimVNPhone(p_HopDongSo: "\(self.simActive!.POSSODocNum)", p_ShopDangKy: "\(Cache.user!.ShopName)", p_TenKH: name, p_SoDTLienHe: phoneNum!, p_NgaySinh: birthday, p_GioiTinh: gt, p_QuocTich: nationalText, p_SoCMND: inputCMND, p_NgayCap: inputDateCMND, p_NoiCap: inputAddressCMND, p_DiaChiThuongChu: address, p_SoThueBao_Line1: phoneNum!, p_Serial_Line1: serialSim, p_GoiCuoc_Line1: "\(self.simActive!.GoiCuoc)", p_ChuKy: strBase64Sign,p_SoNha:"\(self.tfSoNha.text!)",p_Duong:"\(self.tfTenDuong.text!)",p_To:"\(self.tfTo.text!)",p_Phuong:"\(self.wardsButton.text!)", p_Quan: "\(self.districtButton.text!)", p_Tinh: "\(self.cityButton.text!)",p_Email:"", handler: { (imageInfo, err) in
                                
                                if (err.count<=0){
                                    var gt:String = "0"
                                    if (self.gender == 1){
                                        gt = "0"
                                    }else{
                                        gt = "1"
                                    }
                                    
                                    print(imageInfo!.ResultImage)
                                    
                                    let imagesAll = "\(strBase64CMNDTruoc),\(strBase64CMNDSau),\(imageInfo!.ResultImage),\(strBase64Avatar)"
                                    
                                    MPOSAPIManager.ActiveSim(Provider: "\(self.simActive!.Provider)", Phonenumber: phoneNum!, Imei: "", SeriSIM: serialSim, IMSI: "", FullName: name, Birthday: birthday, Gender: gt, Address: address, CMND: inputCMND, DateCreateCMND: inputDateCMND, PalaceCreateCMND: inputAddressCMND, Nationality: self.selectNational, ProvinceCode: "\(self.cityButton.text!)", DistrictCode: "\(self.districtButton.text!)", PrecinctCode: "\(self.wardsButton.text!)", contractNo: "\(numSO)", Note: "", ShopCode: "\(Cache.user!.ShopCode)", UserCode: "\(Cache.user!.UserName)", Images: imagesAll,ID: "\(self.simActive!.ID)",GoiCuoc: "\(self.simActive!.GoiCuoc)",ProductCode: "\(self.simActive!.ProductCode)",LoaiGiayTo:"\(self.typeKichHoat)",Passport:"\(valuePassport)",DayGrantPassport:"\(valueDatePassport)",SOPOS:"\(self.simActive!.POSSODocNum)",NgayHetHanGiayTo:"", TenShop: "\(self.simActive!.TenShop)", DiaChiShop: "\(self.simActive!.DiaChiShop)", TenNhanVien: "\(self.simActive!.TenNhanVien)",NoiCapPassport: inputAddressPassport, SoVisa: inputSoVisa, CustId: "",SSD: "\(self.simActive!.SSD)",IsEsim: 0,Home:self.tfSoNha.text!,StreetName:self.tfTenDuong.text!,StreetBlockName:self.tfApThon.text!,byPassValidateAI: "", lan: lanString, ocr_confirm: "", handler: { (status, data) in
                                        
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                        let when = DispatchTime.now() + 0.5
                                        DispatchQueue.main.asyncAfter(deadline: when) {
                                            if (status){
                                                let alert = UIAlertController(title: "Thành công", message: "\(data)", preferredStyle: UIAlertController.Style.alert)
                                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                                                    (alert: UIAlertAction!) -> Void in
                                                    _ = self.navigationController?.popViewController(animated: true)
                                                    self.dismiss(animated: true, completion: nil)
                                                }))
                                                self.present(alert, animated: true, completion: nil)
                                            }else{
                                             
                                                self.lan = self.lan + 1
                                                
                                                var data1 = ""
                                                if let ip = Cache.ShopInfo?.IPPublic {
                                                    data1 =  "\(self.simActive!.Provider) - \(phoneNum!) - \(serialSim) - \(Cache.user!.UserName) - \(Cache.user!.ShopCode) - \(ip)"
                                                }else{
                                                    data1 = "\(self.simActive!.Provider) - \(phoneNum!) - \(serialSim) - \(Cache.user!.UserName) - \(Cache.user!.ShopCode) - NO IP"
                                                }
                                                
                                                let alert = UIAlertController(title: "Thất bại", message: "[\(data1)] - \(data)", preferredStyle: UIAlertController.Style.alert)
                                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                                alert.addAction(UIAlertAction(title: "Báo lỗi", style: UIAlertAction.Style.destructive, handler:{(alert: UIAlertAction!) in
                                                    let newViewController = CreateCallLogErrorViewController()
                                                    newViewController.msgAPI = data
                                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                                    
                                                }))
                                                self.present(alert, animated: true, completion: nil)
                                            }
                                        }
                                    })
                                    
                                    //                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    //                                    let when = DispatchTime.now() + 0.5
                                    //                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                    //                                        //TODO Toast(text: "Tạo phiếu thông tin khách hàng thất bại").show()
                                    //                                    }
                                    
                                }else{
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let when = DispatchTime.now() + 0.5
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        Toast(text: "Tạo phiếu thông tin khách hàng thất bại").show()
                                    }
                                }
                            })
                        }else if (simActive!.Provider == "Mobifone"){
                            // Mobifone
                            var gt:String = "0"
                            if (gender == 1){
                                gt = "0"
                            }else{
                                gt = "1"
                            }
                            
                            var inputCMND = ""
                            var inputDateCMND = ""
                            var inputAddressCMND = ""
                            var inputAddressCMNDPhieu = ""
                            var inputAddressPassport = ""
                            var inputSoVisa = ""
                            if (typeKichHoat == 1){
                                inputCMND = valueCMND
                                inputDateCMND = valueDateCMND
                                inputAddressCMND = self.selectAddressCMND
                                inputAddressCMNDPhieu = valueAddressCMND
                            }else if (typeKichHoat == 2){
                                inputCMND = valueCanCuoc
                                inputDateCMND = valueDateCanCuoc
                                inputAddressCMND = self.selectAddressCMND
                                inputAddressCMNDPhieu = valueAddressCanCuoc
                            }else{
                                inputCMND = valuePassport
                                inputDateCMND = valueDatePassport
                                inputAddressCMND = valueAddressPassport
                                inputAddressPassport = valueAddressPassport
                                inputSoVisa = valueVisa
                            }
                            var qt:String = ""
                            if(!self.isVietNam){
                                qt = nationalText
                            }
                            MPOSAPIManager.checkGoiCuocVNMobile(phoneNumber: "\(phoneNum!)", cmnd: inputCMND, productCode: "\(self.simActive!.ProductCode)", goiCuoc: "\(self.simActive!.GoiCuoc)", userId: "\(Cache.user!.UserName)", maShop: "\(Cache.user!.ShopCode)", nhaMang: simActive!.Provider, handler: { (status, err) in
                                if (status){
                                    
                                    MPOSAPIManager.AutoCreateImageActiveSimMobiPhone(p_HopDongSo: "\(self.simActive!.POSSODocNum)", p_ShopDangKy: "\(Cache.user!.ShopName)", p_TenKH: name, p_SoDTLienHe: phoneNum!, p_NgaySinh: birthday, p_GioiTinh: gt, p_QuocGia: qt, p_SoCMND: inputCMND, p_NgayCap: inputDateCMND, p_NoiCap: inputAddressCMNDPhieu, p_DiaChiThuongChu: address, p_SoThueBao_Line1: phoneNum!, p_Serial_Line1: serialSim, p_GoiCuoc_Line1: "\(self.simActive!.GoiCuoc)", p_ChuKy: strBase64Sign, handler: { (imageInfo, err) in
                                        if (err.count<=0){
                                            
                                            let imagesAll = "\(strBase64CMNDTruoc),\(strBase64CMNDSau),\(imageInfo!.ResultImage),\(strBase64Avatar)"
                                            
                                            MPOSAPIManager.ActiveSim(Provider: "\(self.simActive!.Provider)", Phonenumber: phoneNum!, Imei: "", SeriSIM: serialSim, IMSI: "", FullName: name, Birthday: birthday, Gender: gt, Address: address, CMND: inputCMND, DateCreateCMND: inputDateCMND, PalaceCreateCMND: inputAddressCMND, Nationality: self.selectNational, ProvinceCode: self.selectProvice, DistrictCode: self.selectDistrict, PrecinctCode: self.selectPrecinct, contractNo: "\(numSO)", Note: "", ShopCode: "\(Cache.user!.ShopCode)", UserCode: "\(Cache.user!.UserName)", Images: imagesAll,ID: "\(self.simActive!.ID)",GoiCuoc: "\(self.simActive!.GoiCuoc)",ProductCode: "\(self.simActive!.ProductCode)",LoaiGiayTo:"\(self.typeKichHoat)",Passport:"\(valuePassport)",DayGrantPassport:"\(valueDatePassport)",SOPOS:"\(self.simActive!.POSSODocNum)",NgayHetHanGiayTo:"", TenShop: "\(self.simActive!.TenShop)", DiaChiShop: "\(self.simActive!.DiaChiShop)", TenNhanVien: "\(self.simActive!.TenNhanVien)",NoiCapPassport: inputAddressPassport, SoVisa: inputSoVisa, CustId: "",SSD: "\(self.simActive!.SSD)",IsEsim: 0,Home:self.tfSoNha.text!,StreetName:self.tfTenDuong.text!,StreetBlockName:self.tfApThon.text!,byPassValidateAI: "", lan: "", ocr_confirm:
                                                "", handler: { (status, data) in
                                                
                                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                                let when = DispatchTime.now() + 0.5
                                                DispatchQueue.main.asyncAfter(deadline: when) {
                                                    if (status){
                                                        let alert = UIAlertController(title: "Thành công", message: "\(data)", preferredStyle: UIAlertController.Style.alert)
                                                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                                                            (alert: UIAlertAction!) -> Void in
                                                            _ = self.navigationController?.popViewController(animated: true)
                                                            self.dismiss(animated: true, completion: nil)
                                                        }))
                                                        self.present(alert, animated: true, completion: nil)
                                                    }else{
                                                        var data1 = ""
                                                        if let ip = Cache.ShopInfo?.IPPublic {
                                                            data1 =  "\(self.simActive!.Provider) - \(phoneNum!) - \(serialSim) - \(Cache.user!.UserName) - \(Cache.user!.ShopCode) - \(ip)"
                                                        }else{
                                                            data1 = "\(self.simActive!.Provider) - \(phoneNum!) - \(serialSim) - \(Cache.user!.UserName) - \(Cache.user!.ShopCode) - NO IP"
                                                        }
                                                        
                                                        let alert = UIAlertController(title: "Thất bại", message: "[\(data1)] - \(data)", preferredStyle: UIAlertController.Style.alert)
                                                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                                        alert.addAction(UIAlertAction(title: "Báo lỗi", style: UIAlertAction.Style.destructive, handler:{(alert: UIAlertAction!) in
                                                            let newViewController = CreateCallLogErrorViewController()
                                                            newViewController.msgAPI = data
                                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                                            
                                                        }))
                                                        self.present(alert, animated: true, completion: nil)
                                                    }
                                                }
                                            })
                                            
                                        }else{
                                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                            let when = DispatchTime.now() + 0.5
                                            DispatchQueue.main.asyncAfter(deadline: when) {
                                                Toast(text: "Tạo phiếu thông tin khách hàng thất bại").show()
                                            }
                                        }
                                    })
                                }else{
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let when = DispatchTime.now() + 0.5
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        Toast(text: err).show()
                                    }
                                }
                            })
                        }else if (simActive!.Provider == "Itelecom"){
                            var inputCMND = ""
                            var inputDateCMND = ""
                            var inputAddressCMND = ""
                            var inputAddressPassport = ""
                            var inputSoVisa = ""
                            if (typeKichHoat == 1){
                                inputCMND = valueCMND
                                inputDateCMND = valueDateCMND
                                inputAddressCMND = self.selectAddressCMND
                            }else if (typeKichHoat == 2){
                                inputCMND = valueCanCuoc
                                inputDateCMND = valueDateCanCuoc
                                inputAddressCMND = self.selectAddressCMND
                            }else{
                                inputCMND = valuePassport
                                inputDateCMND = valueDatePassport
                                inputAddressCMND = valueAddressPassport
                                inputAddressPassport = valueAddressPassport
                                inputSoVisa = valueVisa
                            }
                            var gt:String = "0"
                            if (self.gender == 1){
                                gt = "0"
                            }else{
                                gt = "1"
                            }
                            if (nationalText == "Vietnam"){
                                nationalText = ""
                            }
                            var newAddress = ""
                            if !hasAddress {
                                newAddress = "\(wardsButton.text!), \(districtButton.text!), \(cityButton.text!)".uppercased()
                            } else {
                                newAddress = tfAddress.text ?? ""
                            }
                            MPOSAPIManager.CustomerResult_HDItel(p_HopDongSo:"\(self.simActive!.POSSODocNum)", p_TenKH: name, p_CMND_KH: inputCMND, p_NgayCapCMND_KH: inputDateCMND, p_NoiCapCMND_KH: self.tfCreateAddress.text!, p_NgaySinh_KH: birthday, p_GioiTinh_KH: gt, p_QuocGia_KH: "\(nationalText)", p_NoiThuongTru_KH: newAddress, p_ChuKy: strBase64Sign, p_SoThueBao_Line1: phoneNum!, p_SoICCID_Line1: serialSim,p_GoiCuoc_Line1: "\(self.simActive!.GoiCuoc)",p_SoDTLienHe: phoneNum!, handler: { (imageInfo, err) in
                                
                                if (err.count<=0){
                                    
                                    let imagesAll = "\(strBase64CMNDTruoc),\(strBase64CMNDSau),\(imageInfo!.ResultImage),\(strBase64Avatar)"
                                    if (nationalText == ""){
                                        nationalText = "Vietnam"
                                    }
                                    
                                    MPOSAPIManager.ActiveSim(Provider: "\(self.simActive!.Provider)", Phonenumber: phoneNum!, Imei: "", SeriSIM: serialSim, IMSI: "", FullName: name, Birthday: birthday, Gender: gt, Address: newAddress, CMND: inputCMND, DateCreateCMND: inputDateCMND, PalaceCreateCMND: inputAddressCMND, Nationality: self.selectNational, ProvinceCode: self.selectProvice, DistrictCode: self.selectDistrict, PrecinctCode: self.selectPrecinct, contractNo: "\(numSO)", Note: "", ShopCode: "\(Cache.user!.ShopCode)", UserCode: "\(Cache.user!.UserName)", Images: imagesAll,ID: "\(self.simActive!.ID)",GoiCuoc: "\(self.simActive!.GoiCuoc)",ProductCode: "\(self.simActive!.ProductCode)",LoaiGiayTo:"\(self.typeKichHoat)",Passport:"\(valuePassport)",DayGrantPassport:"\(valueDatePassport)",SOPOS:"\(self.simActive!.POSSODocNum)",NgayHetHanGiayTo:"", TenShop: "\(self.simActive!.TenShop)", DiaChiShop: "\(self.simActive!.DiaChiShop)", TenNhanVien: "\(self.simActive!.TenNhanVien)",NoiCapPassport: inputAddressPassport, SoVisa: inputSoVisa, CustId: "",SSD: "\(self.simActive!.SSD)",IsEsim: 0,Home:self.tfSoNha.text!,StreetName:self.tfTenDuong.text!,StreetBlockName:self.tfApThon.text!,byPassValidateAI: "", lan: "",ocr_confirm:"", handler: { (status, data) in
                                        
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                        let when = DispatchTime.now() + 0.5
                                        DispatchQueue.main.asyncAfter(deadline: when) {
                                            if (status){
                                                let alert = UIAlertController(title: "Thành công", message: "\(data)", preferredStyle: UIAlertController.Style.alert)
                                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                                                    (alert: UIAlertAction!) -> Void in
                                                    _ = self.navigationController?.popViewController(animated: true)
                                                    self.dismiss(animated: true, completion: nil)
                                                }))
                                                self.present(alert, animated: true, completion: nil)
                                            }else{
                                                var data1 = ""
                                                if let ip = Cache.ShopInfo?.IPPublic {
                                                    data1 =  "\(self.simActive!.Provider) - \(phoneNum!) - \(serialSim) - \(Cache.user!.UserName) - \(Cache.user!.ShopCode) - \(ip)"
                                                }else{
                                                    data1 = "\(self.simActive!.Provider) - \(phoneNum!) - \(serialSim) - \(Cache.user!.UserName) - \(Cache.user!.ShopCode) - NO IP"
                                                }
                                                
                                                let alert = UIAlertController(title: "Thất bại", message: "[\(data1)] - \(data)", preferredStyle: UIAlertController.Style.alert)
                                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                                alert.addAction(UIAlertAction(title: "Báo lỗi", style: UIAlertAction.Style.destructive, handler:{(alert: UIAlertAction!) in
                                                    let newViewController = CreateCallLogErrorViewController()
                                                    newViewController.msgAPI = data
                                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                                    
                                                }))
                                                self.present(alert, animated: true, completion: nil)
                                            }
                                        }
                                    })
                                    
                                }else{
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let when = DispatchTime.now() + 0.5
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        Toast(text: "Tạo phiếu thông tin khách hàng thất bại").show()
                                    }
                                }
                            })
                            
                        }else if (simActive!.Provider == "Vietnammobile"||simActive!.Provider == "VietnamMobile"){
                            
                            var inputCMND = ""
                            var inputDateCMND = ""
                            var inputAddressCMND = ""
                            var inputAddressPassport = ""
                            var inputSoVisa = ""
                            if (typeKichHoat == 1){
                                inputCMND = valueCMND
                                inputDateCMND = valueDateCMND
                                inputAddressCMND = valueAddressCMND
                            }else if (typeKichHoat == 2){
                                inputCMND = valueCanCuoc
                                inputDateCMND = valueDateCanCuoc
                                inputAddressCMND = valueAddressCanCuoc
                            }else{
                                inputCMND = valuePassport
                                inputDateCMND = valueDatePassport
                                inputAddressPassport = valueAddressPassport
                                inputAddressCMND = valueAddressPassport
                                inputSoVisa = valueVisa
                            }
                            var gt:String = "0"
                            if (self.gender == 1){
                                gt = "0"
                            }else{
                                gt = "1"
                            }
                            if (nationalText == "Vietnam"){
                                nationalText = ""
                            }
                            
                            MPOSAPIManager.checkGoiCuocVNMobile(phoneNumber: "\(phoneNum!)", cmnd: inputCMND, productCode: "\(self.simActive!.ProductCode)", goiCuoc: "\(self.simActive!.GoiCuoc)", userId: "\(Cache.user!.UserName)", maShop: "\(Cache.user!.ShopCode)", nhaMang: simActive!.Provider, handler: { (status, err) in
                                if (status){
                                    MPOSAPIManager.AutoCreateImageActiveSimVietnamobile(p_HopDongSo:"\(self.simActive!.POSSODocNum)", p_TenKH: name, p_CMND_KH: inputCMND, p_NgayCapCMND_KH: inputDateCMND, p_NoiCapCMND_KH: inputAddressCMND, p_NgaySinh_KH: birthday, p_GioiTinh_KH: gt, p_QuocGia_KH: "\(nationalText)", p_NoiThuongTru_KH: "\(address)", p_ChuKy: strBase64Sign, p_SoThueBao_Line1: phoneNum!, p_SoICCID_Line1: serialSim, handler: { (imageInfo, err) in
                                        
                                        if (err.count<=0){
                                            
                                            let imagesAll = "\(strBase64CMNDTruoc),\(strBase64CMNDSau),\(imageInfo!.ResultImage),\(strBase64Avatar)"
                                            if (nationalText == ""){
                                                nationalText = "Vietnam"
                                            }
                                            var ocr_confirm:String = ""
                                            if(self.isSkipAI == true){
                                                ocr_confirm = "1"
                                            }
                                            
                                            MPOSAPIManager.ActiveSim(Provider: "\(self.simActive!.Provider)", Phonenumber: phoneNum!, Imei: "", SeriSIM: serialSim, IMSI: "", FullName: name, Birthday: birthday, Gender: gt, Address: address, CMND: inputCMND, DateCreateCMND: inputDateCMND, PalaceCreateCMND: inputAddressCMND, Nationality: nationalText, ProvinceCode: self.selectProvice, DistrictCode: self.selectDistrict, PrecinctCode: self.selectPrecinct, contractNo: "\(numSO)", Note: "", ShopCode: "\(Cache.user!.ShopCode)", UserCode: "\(Cache.user!.UserName)", Images: imagesAll,ID: "\(self.simActive!.ID)",GoiCuoc: "\(self.simActive!.GoiCuoc)",ProductCode: "\(self.simActive!.ProductCode)",LoaiGiayTo:"\(self.typeKichHoat)",Passport:"\(valuePassport)",DayGrantPassport:"\(valueDatePassport)",SOPOS:"\(self.simActive!.POSSODocNum)",NgayHetHanGiayTo:"", TenShop: "\(self.simActive!.TenShop)", DiaChiShop: "\(self.simActive!.DiaChiShop)", TenNhanVien: "\(self.simActive!.TenNhanVien)",NoiCapPassport: inputAddressPassport, SoVisa: inputSoVisa, CustId: "",SSD: "\(self.simActive!.SSD)",IsEsim: 0,Home:self.tfSoNha.text!,StreetName:self.tfTenDuong.text!,StreetBlockName:self.tfApThon.text!,byPassValidateAI: "", lan: "", ocr_confirm: "\(ocr_confirm)", handler: { (status, data) in
                                                
                                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                                let when = DispatchTime.now() + 0.5
                                                DispatchQueue.main.asyncAfter(deadline: when) {
                                                    if (status){
                                                        let alert = UIAlertController(title: "Thành công", message: "\(data)", preferredStyle: UIAlertController.Style.alert)
                                                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                                                            (alert: UIAlertAction!) -> Void in
                                                            _ = self.navigationController?.popViewController(animated: true)
                                                            self.dismiss(animated: true, completion: nil)
                                                        }))
                                                        self.present(alert, animated: true, completion: nil)
                                                    }else{
                                                        var data1 = ""
                                                        if let ip = Cache.ShopInfo?.IPPublic {
                                                            data1 =  "\(self.simActive!.Provider) - \(phoneNum!) - \(serialSim) - \(Cache.user!.UserName) - \(Cache.user!.ShopCode) - \(ip)"
                                                        }else{
                                                            data1 = "\(self.simActive!.Provider) - \(phoneNum!) - \(serialSim) - \(Cache.user!.UserName) - \(Cache.user!.ShopCode) - NO IP"
                                                        }
                                                        
                                                        let alert = UIAlertController(title: "Thất bại", message: "[\(data1)] - \(data)", preferredStyle: UIAlertController.Style.alert)
                                                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                                                            (alert: UIAlertAction!) -> Void in
                                                            self.isSkipAI = true
                                                            
                                                        }))
                                                        alert.addAction(UIAlertAction(title: "Báo lỗi", style: UIAlertAction.Style.destructive, handler:{(alert: UIAlertAction!) in
                                                            let newViewController = CreateCallLogErrorViewController()
                                                            newViewController.msgAPI = data
                                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                                            
                                                        }))
                                                        self.present(alert, animated: true, completion: nil)
                                                    }
                                                }
                                            })
                                            
                                        }else{
                                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                            let when = DispatchTime.now() + 0.5
                                            DispatchQueue.main.asyncAfter(deadline: when) {
                                                Toast(text: "Tạo phiếu thông tin khách hàng thất bại").show()
                                            }
                                        }
                                    })
                                }else{
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    let when = DispatchTime.now() + 0.5
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        Toast(text: err).show()
                                    }
                                }
                            })
                            
                        }   }
                }
            }
            
        }else{
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                Toast(text: "Tạo chữ ký không thành công").show()
            }
        }
    }
    
    func selectCustomerViettel(client: ClientViettel, inputSim: InputSimViettel) {
        print("selectCustomerViettel \(client)")
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra thông tin kích hoạt..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            MPOSAPIManager.AutoCreateImageActiveSimViettelHD(p_MaKH: client.custId, p_SoNha: "", p_Duong: "\(inputSim.p_Duong)",p_Phuong:"\(inputSim.p_Phuong)", p_Quan: "\(inputSim.p_Quan)", p_Tinh: "\(inputSim.p_Tinh)", p_QuocTich: "\(inputSim.p_QuocTich)", ChuKy: "\(inputSim.ChuKy)", p_SoPhieuYeuCau: "\(inputSim.p_SoPhieuYeuCau)", p_TenKH: "\(inputSim.p_TenKH)", p_DT_LienHe_KH: "", p_NgaySinh_KH: "\(inputSim.p_NgaySinh_KH)", p_GioiTinh_KH: "\(inputSim.p_GioiTinh_KH)", p_SoCMND_KH: "\(inputSim.p_SoCMND_KH)", p_NoiCap_CMND_KH: "\(inputSim.p_NoiCap_CMND_KH)", p_NgayCap_CMND_KH: "\(inputSim.p_NgayCap_CMND_KH)", p_DiaChi_CMND_KH: "\(inputSim.p_DiaChi_CMND_KH)", p_GoiCuocDK_Line1: "\(inputSim.p_GoiCuocDK_Line1)", p_SoThueBao_Line1: "\(inputSim.p_SoThueBao_Line1)", p_SoSerialSim_Imei_Line1: "\(inputSim.p_SoSerialSim_Imei_Line1)",p_Visa: "\(inputSim.p_Visa)", handler: { (imageInfo, err) in
                if (err.count<=0){
                    
                    let imagesAll = "\(inputSim.strBase64CMNDTruoc),\(inputSim.strBase64CMNDSau),\(imageInfo!.ResultImage),\(inputSim.strBase64Avatar)"
                    var byPassValidateAI:String = ""
                    if(self.isSkipAI == true){
                        byPassValidateAI = "1"
                    }
                 
                    
                    MPOSAPIManager.ActiveSim(Provider: "\(inputSim.simActive.Provider)", Phonenumber: "\(inputSim.p_SoThueBao_Line1)", Imei: "", SeriSIM: "\(inputSim.p_SoSerialSim_Imei_Line1)", IMSI: "", FullName: "\(inputSim.p_TenKH)", Birthday: "\(inputSim.p_NgaySinh_KH)", Gender: "\(inputSim.gtInt)", Address: "\(inputSim.p_Duong)", CMND: "\(inputSim.p_SoCMND_KH)", DateCreateCMND: "\(inputSim.p_NgayCap_CMND_KH)", PalaceCreateCMND: "\(inputSim.p_DiaChi_CMND_KH)", Nationality: inputSim.Nationality, ProvinceCode: inputSim.ProvinceCode, DistrictCode: inputSim.DistrictCode, PrecinctCode: inputSim.PrecinctCode, contractNo: inputSim.contractNo, Note: "", ShopCode: "\(Cache.user!.ShopCode)", UserCode: "\(Cache.user!.UserName)", Images: imagesAll,ID: "\(inputSim.simActive.ID)",GoiCuoc: "\(inputSim.p_GoiCuocDK_Line1)",ProductCode: "\(inputSim.simActive.ProductCode)",LoaiGiayTo: inputSim.LoaiGiayTo,Passport:inputSim.Passport,DayGrantPassport:inputSim.DayGrantPassport,SOPOS:"\(inputSim.simActive.POSSODocNum)",NgayHetHanGiayTo:"", TenShop: "\(inputSim.simActive.TenShop)", DiaChiShop: "\(inputSim.simActive.DiaChiShop)", TenNhanVien: "\(inputSim.simActive.TenNhanVien)", NoiCapPassport: inputSim.NoiCapPassport, SoVisa: "\(inputSim.p_Visa)", CustId: client.custId,SSD: "\(self.simActive!.SSD)",IsEsim: 0,Home:self.tfSoNha.text!,StreetName:self.tfTenDuong.text!,StreetBlockName:self.tfApThon.text!,byPassValidateAI: byPassValidateAI, lan: "", ocr_confirm: "", handler: { (status, data) in
                        
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            if (status){
                                let alert = UIAlertController(title: "Thành công", message: "\(data)", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                                    (alert: UIAlertAction!) -> Void in
                                    _ = self.navigationController?.popViewController(animated: true)
                                    self.dismiss(animated: true, completion: nil)
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }else{
                                var data1 = ""
                                if let ip = Cache.ShopInfo?.IPPublic {
                                    data1 =  "\(inputSim.simActive.Provider) - \(inputSim.p_SoThueBao_Line1) - \(inputSim.p_SoSerialSim_Imei_Line1) - \(Cache.user!.UserName) - \(Cache.user!.ShopCode) - \(ip)"
                                }else{
                                    data1 = "\(self.simActive!.Provider) -  \(inputSim.p_SoThueBao_Line1) - \(inputSim.p_SoSerialSim_Imei_Line1) - \(Cache.user!.UserName) - \(Cache.user!.ShopCode) - NO IP"
                                }
                                let alert = UIAlertController(title: "Thất bại", message: "[\(data1)] - \(data)", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                                    (alert: UIAlertAction!) -> Void in
                                    self.isSkipAI = true
                                    
                                }))
                                
                                alert.addAction(UIAlertAction(title: "Báo lỗi", style: UIAlertAction.Style.destructive, handler:{(alert: UIAlertAction!) in
                                    let newViewController = CreateCallLogErrorViewController()
                                    newViewController.msgAPI = data
                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                    
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    })
                    
                }else{
                    print("err \(err)")
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        Toast(text: "Tạo phiếu thông tin khách hàng thất bại").show()
                    }
                }
            })
            
        }
    }
    func createCustomerViettel(inputSim:InputSimViettel) {
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra thông tin kích hoạt..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            MPOSAPIManager.AutoCreateImageActiveSimViettelHD(p_MaKH: "", p_SoNha: "", p_Duong: "\(inputSim.p_Duong)",p_Phuong:"\(inputSim.p_Phuong)", p_Quan: "\(inputSim.p_Quan)", p_Tinh: "\(inputSim.p_Tinh)", p_QuocTich: "\(inputSim.p_QuocTich)", ChuKy: "\(inputSim.ChuKy)", p_SoPhieuYeuCau: "\(inputSim.p_SoPhieuYeuCau)", p_TenKH: "\(inputSim.p_TenKH)", p_DT_LienHe_KH: "", p_NgaySinh_KH: "\(inputSim.p_NgaySinh_KH)", p_GioiTinh_KH: "\(inputSim.p_GioiTinh_KH)", p_SoCMND_KH: "\(inputSim.p_SoCMND_KH)", p_NoiCap_CMND_KH: "\(inputSim.p_NoiCap_CMND_KH)", p_NgayCap_CMND_KH: "\(inputSim.p_NgayCap_CMND_KH)", p_DiaChi_CMND_KH: "\(inputSim.p_DiaChi_CMND_KH)", p_GoiCuocDK_Line1: "\(inputSim.p_GoiCuocDK_Line1)", p_SoThueBao_Line1: "\(inputSim.p_SoThueBao_Line1)", p_SoSerialSim_Imei_Line1: "\(inputSim.p_SoSerialSim_Imei_Line1)",p_Visa: "\(inputSim.p_Visa)", handler: { (imageInfo, err) in
                if (err.count<=0){
                    
                    let imagesAll = "\(inputSim.strBase64CMNDTruoc),\(inputSim.strBase64CMNDSau),\(imageInfo!.ResultImage),\(inputSim.strBase64Avatar)"
                    var byPassValidateAI:String = ""
                    if(self.isSkipAI == true){
                        byPassValidateAI = "1"
                    }
                    MPOSAPIManager.ActiveSim(Provider: "\(inputSim.simActive.Provider)", Phonenumber: "\(inputSim.p_SoThueBao_Line1)", Imei: "", SeriSIM: "\(inputSim.p_SoSerialSim_Imei_Line1)", IMSI: "", FullName: "\(inputSim.p_TenKH)", Birthday: "\(inputSim.p_NgaySinh_KH)", Gender: "\(inputSim.gtInt)", Address: "\(inputSim.p_Duong)", CMND: "\(inputSim.p_SoCMND_KH)", DateCreateCMND: "\(inputSim.p_NgayCap_CMND_KH)", PalaceCreateCMND: "\(inputSim.p_DiaChi_CMND_KH)", Nationality: inputSim.Nationality, ProvinceCode: inputSim.ProvinceCode, DistrictCode: inputSim.DistrictCode, PrecinctCode: inputSim.PrecinctCode, contractNo: inputSim.contractNo, Note: "", ShopCode: "\(Cache.user!.ShopCode)", UserCode: "\(Cache.user!.UserName)", Images: imagesAll,ID: "\(inputSim.simActive.ID)",GoiCuoc: "\(inputSim.p_GoiCuocDK_Line1)",ProductCode: "\(inputSim.simActive.ProductCode)",LoaiGiayTo: inputSim.LoaiGiayTo,Passport:inputSim.Passport,DayGrantPassport:inputSim.DayGrantPassport,SOPOS:"\(inputSim.simActive.POSSODocNum)",NgayHetHanGiayTo:"", TenShop: "\(inputSim.simActive.TenShop)", DiaChiShop: "\(inputSim.simActive.DiaChiShop)", TenNhanVien: "\(inputSim.simActive.TenNhanVien)", NoiCapPassport: inputSim.NoiCapPassport, SoVisa: "\(inputSim.p_Visa)", CustId: "", SSD: "\(self.simActive!.SSD)",IsEsim: 0,Home:self.tfSoNha.text!,StreetName:self.tfTenDuong.text!,StreetBlockName:self.tfApThon.text!,byPassValidateAI: byPassValidateAI, lan: "", ocr_confirm: "", handler: { (status, data) in
                        
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            if (status){
                                let alert = UIAlertController(title: "Thành công", message: "\(data)", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                                    (alert: UIAlertAction!) -> Void in
                                    _ = self.navigationController?.popViewController(animated: true)
                                    self.dismiss(animated: true, completion: nil)
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }else{
                                var data1 = ""
                                if let ip = Cache.ShopInfo?.IPPublic {
                                    data1 =  "\(inputSim.simActive.Provider) - \(inputSim.p_SoThueBao_Line1) - \(inputSim.p_SoSerialSim_Imei_Line1) - \(Cache.user!.UserName) - \(Cache.user!.ShopCode) - \(ip)"
                                }else{
                                    data1 = "\(self.simActive!.Provider) -  \(inputSim.p_SoThueBao_Line1) - \(inputSim.p_SoSerialSim_Imei_Line1) - \(Cache.user!.UserName) - \(Cache.user!.ShopCode) - NO IP"
                                }
                                let alert = UIAlertController(title: "Thất bại", message: "[\(data1)] - \(data)", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                                    (alert: UIAlertAction!) -> Void in
                                    self.isSkipAI = true
                                    
                                }))
                                
                                alert.addAction(UIAlertAction(title: "Báo lỗi", style: UIAlertAction.Style.destructive, handler:{(alert: UIAlertAction!) in
                                    let newViewController = CreateCallLogErrorViewController()
                                    newViewController.msgAPI = data
                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                    
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    })
                    
                }else{
                    print("err \(err)")
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        Toast(text: "Tạo phiếu thông tin khách hàng thất bại").show()
                    }
                }
            })
            
        }
    }
    func cancelCustomerViettel() {
        print("cancelCustomerViettel")
    }
}
extension DetailSimCRMViewControllerV2:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        if (self.posImageUpload == 1){
            self.imageCMNDTruoc(image: image)
        }else if (self.posImageUpload == 2){
            self.imageCMNDSau(image: image)
        }else if (self.posImageUpload == 3){
            self.imageAvatar(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
