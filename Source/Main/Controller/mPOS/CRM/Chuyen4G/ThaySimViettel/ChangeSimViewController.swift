//
//  ChangeSimViewController.swift
//  fptshop
//
//  Created by Apple on 4/16/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DLRadioButton
//import EPSignature
import DropDown
import Presentr
import AVFoundation
import PopupDialog

class ChangeSimViewController: UIViewController, EPSignatureDelegate {
    
    var scrollView: UIScrollView!
    var tfFullName: UITextField!
    var tfAddress: UITextField!
    var tfBirthDate: UITextField!
    var tfCMND: UITextField!
    //    var lbNoiCapCMNDValue: UILabel!
    var lbNoiCapCMNDValue: SearchTextField!
    var lbNgayCapCMND: UILabel!
    var tfPhoneNumber: UITextField!
    var tf3PhoneNumberNearest: UITextField!
    var tfSerial: UITextField!
    var tfOTP: UITextField!
    var lbGenderText:UILabel!
    var radioMan:DLRadioButton!
    var radioWoman:DLRadioButton!
    var genderType:Int = -1
    var imagePicker = UIImagePickerController()
    var posImageUpload:Int = -1
    var imageCMNDView: UIView!
    
    var viewImageCMNDTruoc:UIView!
    var imgViewCMNDTruoc: UIImageView!
    var viewCMNDTruoc:UIView!
    
    var viewImageCMNDSau:UIView!
    var imgViewCMNDSau: UIImageView!
    var viewCMNDSau:UIView!
    
    var viewImageSign:UIView!
    var imgViewSign: UIImageView!
    var btnUpdateChangeSim: UIButton!
    
    var lbChooseSimType: UILabel!
    var scrollViewHeight: CGFloat = 0
    var phone = ""
    var cmndNumber = ""
    var isSimThuong = false
    var isTraSau = "N"
    var sim: SimThuong?
    var isEsim: Int = 0
    var oldSerial = ""
    var newSerial = ""
    var simSerial: EsimSeri?
    var provinceID = ""
    var isOtp = 0
    var otpString = ""
    var itemsSearchShop:[SearchTextFieldItem] = []
    ////add
    var nearestPhoneView = UIView()
    var serialView = UIView()
    var otpView = UIView()
    
    let dropMenuSimType = DropDown();
    //    let dropMenuProvinces = DropDown();
    
    var selectedSimType: ReasonCodes!
    var selectedProvince: Province!
    var listProvinces = [Province]()
    var listReasonCode = [ReasonCodes]()
    var provincesTitle: [String] = []
    var arrContacts: [String] = ["", "", ""]
    var isNormalIsdn = false
    var arrsimType: [String] = []
    var customerInfo: SimCustomer?
    var strBase64CMNDTruoc = ""
    var strBase64CMNDSau = ""
    var strBase64Sign = ""
    
    var dateString1 = ""
    let presenter: Presentr = {
        let dynamicType = PresentationType.dynamic(center: ModalCenterPosition.center)
        let customPresenter = Presentr(presentationType: dynamicType)
        customPresenter.backgroundOpacity = 0.3
        customPresenter.roundCorners = true
        customPresenter.dismissOnSwipe = false
        customPresenter.dismissAnimated = false
        customPresenter.backgroundTap = .noAction
        return customPresenter
    }()
    
    private let calendar: AVCalendarViewController = AVCalendarViewController.calendar
    private var selectedDate: AVDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "THAY SIM"
        
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        
        let backView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:50))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: backView)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        backView.addSubview(btBackIcon)
        
        if self.sim?.payType == "1" {
            self.isTraSau = "Y"
        }
        
        
        self.listReasonCode.removeAll()
        MPOSAPIManager.VTGetReasonCodes(UserId: "\(Cache.user?.UserName ?? "")", MaShop: "\(Cache.user?.ShopCode ?? "")", is_trasau: self.isTraSau, is_otp: "\(self.isOtp)") { (results, message) in
            
            if results.count > 0 {
                for item in results {
                    self.listReasonCode.append(item)
                }
            } else {
                debugPrint("k co ds reason codes")
            }
            
            if self.customerInfo != nil {
                self.setUpView(item: self.customerInfo!)
            } else {
                self.customerInfo = SimCustomer(custId: "", custType: "", name: "", address: "", birthDate: "", sex: "", district: "", precinct: "", province: "")
                self.setUpView(item: self.customerInfo!)
                
                self.tfFullName.isEnabled = true
                self.tfAddress.isEnabled = true
                self.tfCMND.isEnabled = true
                self.tfBirthDate.isEnabled = true
                
                if self.phone != "" {
                    self.tfPhoneNumber.text = self.phone
                    self.tfPhoneNumber.isEnabled = false
                } else {
                    self.tfPhoneNumber.isEnabled = true
                }
            }
        }
        
        
    }
    
    func setUpView(item: SimCustomer) {
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let customerInfoView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Common.Size(s: 40)))
        customerInfoView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        scrollView.addSubview(customerInfoView)
        
        let lbCustomerInfo = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: customerInfoView.frame.width, height: customerInfoView.frame.height))
        lbCustomerInfo.text = "THÔNG TIN KHÁCH HÀNG"
        lbCustomerInfo.textColor = UIColor.black
        lbCustomerInfo.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        customerInfoView.addSubview(lbCustomerInfo)
        
        let lblName = UILabel(frame: CGRect(x: Common.Size(s:15), y: customerInfoView.frame.origin.y + customerInfoView.frame.height + Common.Size(s: 15), width: scrollView.frame.width - (Common.Size(s:30)), height: Common.Size(s:20)))
        lblName.text = "Họ tên"
        lblName.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lblName)
        
        tfFullName = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblName.frame.origin.y + lblName.frame.height + Common.Size(s:5), width: scrollView.frame.width - (Common.Size(s:30)), height: Common.Size(s:35)))
        tfFullName.text = item.name
        tfFullName.isEnabled = false
        tfFullName.borderStyle = .roundedRect
        tfFullName.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfFullName.returnKeyType = UIReturnKeyType.done
        tfFullName.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfFullName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        scrollView.addSubview(tfFullName)
        
        
        /// dia chi
        let lbAddress = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfFullName.frame.origin.y + tfFullName.frame.height + Common.Size(s:10), width: self.view.frame.width - (Common.Size(s:30 + Common.Size(s: 15))), height: Common.Size(s:20)))
        lbAddress.text = "Địa chỉ"
        lbAddress.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lbAddress)
        
        tfAddress = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbAddress.frame.origin.y + lbAddress.frame.height + Common.Size(s:5), width: tfFullName.frame.width, height: Common.Size(s:35)))
        tfAddress.borderStyle = .roundedRect
        tfAddress.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfAddress.returnKeyType = UIReturnKeyType.done
        tfAddress.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfAddress.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfAddress.text = item.address
        tfAddress.isEnabled = false
        scrollView.addSubview(tfAddress)
        
        /// Ngay sinh
        let lbNgaySinh = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfAddress.frame.origin.y + tfAddress.frame.height + Common.Size(s:10), width: self.view.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:20)))
        lbNgaySinh.text = "Ngày sinh"
        lbNgaySinh.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lbNgaySinh)
        
        tfBirthDate = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbNgaySinh.frame.origin.y + lbNgaySinh.frame.height + Common.Size(s:5), width: tfFullName.frame.width, height: Common.Size(s:35)))
        tfBirthDate.borderStyle = .roundedRect
        tfBirthDate.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfBirthDate.returnKeyType = UIReturnKeyType.done
        tfBirthDate.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfBirthDate.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        let dateFormatter = ISO8601DateFormatter()
        if let dateInLocal = dateFormatter.date(from: "\(item.birthDate)") {
            let dateNormalFormatter = DateFormatter()
            dateNormalFormatter.dateFormat = "dd/MM/yyyy"
            let dateString = dateNormalFormatter.string(from: dateInLocal)
            debugPrint(dateString)
            tfBirthDate.text = dateString
            tfBirthDate.isEnabled = false
        } else {
            tfBirthDate.text = ""
            tfBirthDate.isEnabled = true
            tfBirthDate.placeholder = "Nhập ngày sinh dd/MM/yyyy"
        }
        
        scrollView.addSubview(tfBirthDate)
        
        // choose gioi tinh
        
        let lbGenderText = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfBirthDate.frame.origin.y + tfBirthDate.frame.size.height + Common.Size(s:10), width: tfBirthDate.frame.size.width, height: Common.Size(s:25)))
        lbGenderText.textAlignment = .left
        lbGenderText.textColor = UIColor.black
        lbGenderText.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbGenderText.text = "Giới tính"
        scrollView.addSubview(lbGenderText)
        
        radioMan = createRadioButtonGender(CGRect(x: lbGenderText.frame.origin.x,y:lbGenderText.frame.origin.y + lbGenderText.frame.size.height + Common.Size(s:5) , width: lbGenderText.frame.size.width/3, height: Common.Size(s:15)), title: "Nam", color: UIColor.black);
        scrollView.addSubview(radioMan)
        
        radioWoman = createRadioButtonGender(CGRect(x: radioMan.frame.origin.x + radioMan.frame.size.width ,y:radioMan.frame.origin.y, width: radioMan.frame.size.width, height: radioMan.frame.size.height), title: "Nữ", color: UIColor.black);
        scrollView.addSubview(radioWoman)
        
        if (item.sex == "M"){
            radioMan.isSelected = true
            genderType = 0
        }else if (item.sex == "F"){
            radioWoman.isSelected = true
            genderType = 1
        }else{
            radioMan.isSelected = false
            radioWoman.isSelected = false
            genderType = -1
        }
        
        let lbCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: radioMan.frame.origin.y + radioMan.frame.height + Common.Size(s:10), width: scrollView.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:20)))
        lbCMND.text = "CMND"
        lbCMND.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lbCMND)
        
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbCMND.frame.origin.y + lbCMND.frame.height + Common.Size(s:5), width: tfFullName.frame.width, height: Common.Size(s:35)))
        tfCMND.borderStyle = .roundedRect
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.text = self.cmndNumber
        tfCMND.isEnabled = false
        scrollView.addSubview(tfCMND)
        
        for item in listProvinces {
            self.provincesTitle.append(item.Text)
        }
        
        let lbNoiCap = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfCMND.frame.origin.y + tfCMND.frame.height + Common.Size(s:10), width: self.view.frame.width - (Common.Size(s:30)), height: Common.Size(s:20)))
        lbNoiCap.text = "Nơi cấp"
        lbNoiCap.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lbNoiCap)
        
        
        lbNoiCapCMNDValue = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lbNoiCap.frame.origin.y + lbNoiCap.frame.height + Common.Size(s:5), width: tfFullName.frame.width, height: Common.Size(s:35)))
        lbNoiCapCMNDValue.borderStyle = .roundedRect
        lbNoiCapCMNDValue.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        scrollView.addSubview(lbNoiCapCMNDValue)
        
        for value in self.listProvinces {
            itemsSearchShop.append(SearchTextFieldItem(title: value.Text))
        }
        
        lbNoiCapCMNDValue.filterItems(itemsSearchShop)
        lbNoiCapCMNDValue.comparisonOptions = [.caseInsensitive]
        lbNoiCapCMNDValue.clearButtonMode = UITextField.ViewMode.whileEditing
        lbNoiCapCMNDValue.theme = SearchTextFieldTheme(cellHeight: 40, bgColor: UIColor (red: 230/255, green: 230/255, blue: 230/255, alpha: 1), borderColor: UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0), separatorColor: UIColor.clear, font: UIFont.systemFont(ofSize: 13), fontColor: UIColor.black)
        lbNoiCapCMNDValue.startVisible = true
        lbNoiCapCMNDValue.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        //        if self.provinceID == "" {
        //            if provincesTitle.count > 0 {
        //                self.lbNoiCapCMNDValue.text = " \(provincesTitle[0])"
        //            }
        //
        //        } else {
        //            for province in listProvinces {
        //                if province.Value == self.provinceID {
        //                    self.lbNoiCapCMNDValue.text = " \(province.Text)"
        //                }
        //            }
        //        }
        //----
        
        
        //        let tapShowDropMenuProvince = UITapGestureRecognizer(target: self, action: #selector(showDropMenuProvince))
        //        lbNoiCapCMNDValue.isUserInteractionEnabled = true
        //        lbNoiCapCMNDValue.addGestureRecognizer(tapShowDropMenuProvince)
        
        /// ngay cap cmnd
        let lbNgayCap = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbNoiCapCMNDValue.frame.origin.y + lbNoiCapCMNDValue.frame.height + Common.Size(s:10), width: self.view.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:20)))
        lbNgayCap.text = "Ngày cấp"
        lbNgayCap.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lbNgayCap)
        
        lbNgayCapCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbNgayCap.frame.origin.y + lbNgayCap.frame.height + Common.Size(s:5), width: tfFullName.frame.width, height: Common.Size(s:35)))
        lbNgayCapCMND.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbNgayCapCMND.text = "Chọn ngày cấp CMND"
        lbNgayCapCMND.textColor = UIColor.lightGray
        lbNgayCapCMND.layer.borderWidth = 1
        lbNgayCapCMND.layer.borderColor = UIColor.lightGray.cgColor
        lbNgayCapCMND.layer.cornerRadius = 3
        scrollView.addSubview(lbNgayCapCMND)
        
        let tapShowCalendar = UITapGestureRecognizer(target: self, action: #selector(showCalendar))
        lbNgayCapCMND.isUserInteractionEnabled = true
        lbNgayCapCMND.addGestureRecognizer(tapShowCalendar)
        
        let simInfoView = UIView(frame: CGRect(x: 0, y: lbNgayCapCMND.frame.origin.y + lbNgayCapCMND.frame.height + Common.Size(s: 15), width: self.view.frame.width, height: Common.Size(s: 40)))
        simInfoView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        scrollView.addSubview(simInfoView)
        
        let lbSimInfo = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: simInfoView.frame.width, height: customerInfoView.frame.height))
        lbSimInfo.text = "THÔNG TIN SIM"
        lbSimInfo.textColor = UIColor.black
        lbSimInfo.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        simInfoView.addSubview(lbSimInfo)
        
        /// so thue bao
        let lbPhone = UILabel(frame: CGRect(x: Common.Size(s:15), y: simInfoView.frame.origin.y + simInfoView.frame.height + Common.Size(s:15), width: self.view.frame.width - (Common.Size(s:30)), height: Common.Size(s:20)))
        lbPhone.text = "Số thuê bao"
        lbPhone.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lbPhone)
        
        tfPhoneNumber = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbPhone.frame.origin.y + lbPhone.frame.height + Common.Size(s: 5), width: tfFullName.frame.width, height: Common.Size(s:35)))
        tfPhoneNumber.borderStyle = .roundedRect
        tfPhoneNumber.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfPhoneNumber.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneNumber.keyboardType = UIKeyboardType.numberPad
        tfPhoneNumber.returnKeyType = UIReturnKeyType.done
        tfPhoneNumber.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhoneNumber.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneNumber.text = self.phone
        tfPhoneNumber.isEnabled = false
        scrollView.addSubview(tfPhoneNumber)
        
        
        for reasonCode in listReasonCode {
            self.arrsimType.append(reasonCode.Name)
        }
        ///show arrsimtype
        let lbHinhThucDoiSim = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhoneNumber.frame.origin.y + tfPhoneNumber.frame.height + Common.Size(s:10), width: self.view.frame.width - (Common.Size(s:30)), height: Common.Size(s:20)))
        lbHinhThucDoiSim.text = "Hình thức đổi sim"
        lbHinhThucDoiSim.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lbHinhThucDoiSim)
        
        lbChooseSimType = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbHinhThucDoiSim.frame.origin.y + lbHinhThucDoiSim.frame.height + Common.Size(s: 5), width: self.view.frame.width - (Common.Size(s:30)), height: Common.Size(s:35)))
        lbChooseSimType.layer.cornerRadius = 3
        lbChooseSimType.layer.borderColor = UIColor.lightGray.cgColor
        lbChooseSimType.layer.borderWidth = 1
        lbChooseSimType.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        //        lbChooseSimType.text = arrsimType[0]
        scrollView.addSubview(lbChooseSimType)
        
        
        
        let tapShowDropMenu = UITapGestureRecognizer(target: self, action: #selector(showDropMenuSimType))
        lbChooseSimType.isUserInteractionEnabled = true
        lbChooseSimType.addGestureRecognizer(tapShowDropMenu)
        
        
        
        ////Serial
        serialView.frame = CGRect(x: Common.Size(s:15), y: lbChooseSimType.frame.origin.y + lbChooseSimType.frame.height + Common.Size(s:10), width: self.view.frame.width - (Common.Size(s:30)), height: Common.Size(s:50))
        scrollView.addSubview(serialView)
        
        let lbSerial = UILabel(frame: CGRect(x: 0, y: 0, width: serialView.frame.width, height: Common.Size(s:20)))
        lbSerial.text = "Serial"
        lbSerial.font = UIFont.systemFont(ofSize: 15)
        serialView.addSubview(lbSerial)
        
        tfSerial = UITextField(frame: CGRect(x: 0, y: lbSerial.frame.origin.y + lbSerial.frame.height + Common.Size(s: 5), width: serialView.frame.width, height: Common.Size(s:35)))
        tfSerial.borderStyle = .roundedRect
        tfSerial.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfSerial.autocorrectionType = UITextAutocorrectionType.no
        tfSerial.keyboardType = UIKeyboardType.numberPad
        tfSerial.returnKeyType = UIReturnKeyType.done
        tfSerial.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfSerial.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        serialView.addSubview(tfSerial)
        
        
        let scanImgView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        let scanImg = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        //        let scan = UIImage(named: "scan_barcode")
        scanImg.image = #imageLiteral(resourceName: "barcode")
        scanImgView.addSubview(scanImg)
        tfSerial.rightViewMode = .always
        tfSerial.rightView = scanImgView
        
        
        let gestureSearchImageRight = UITapGestureRecognizer(target: self, action:  #selector(self.actionScan))
        scanImgView.addGestureRecognizer(gestureSearchImageRight)
        tfSerial.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        
        serialView.frame = CGRect(x: serialView.frame.origin.x, y: serialView.frame.origin.y, width: serialView.frame.width, height: tfSerial.frame.origin.y + tfSerial.frame.height)
        
        
        /// 3 so thue bao gan nhat
        nearestPhoneView.frame = CGRect(x: Common.Size(s:15), y: serialView.frame.origin.y + serialView.frame.height + Common.Size(s:15), width: self.view.frame.width - (Common.Size(s:30)), height: Common.Size(s:50))
        scrollView.addSubview(nearestPhoneView)
        
        let lb3Phone = UILabel(frame: CGRect(x: 0, y: 0, width: nearestPhoneView.frame.width, height: Common.Size(s:20)))
        lb3Phone.text = "3 số thuê bao liên hệ gần nhất"
        lb3Phone.font = UIFont.systemFont(ofSize: 15)
        nearestPhoneView.addSubview(lb3Phone)
        
        tf3PhoneNumberNearest = UITextField(frame: CGRect(x: 0, y: lb3Phone.frame.origin.y + lb3Phone.frame.height + Common.Size(s: 5), width: tfFullName.frame.width, height: Common.Size(s:35)))
        tf3PhoneNumberNearest.borderStyle = .roundedRect
        tf3PhoneNumberNearest.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        //        tf3PhoneNumberNearest.autocorrectionType = UITextAutocorrectionType.no
        //        tf3PhoneNumberNearest.keyboardType = UIKeyboardType.numberPad
        tf3PhoneNumberNearest.returnKeyType = UIReturnKeyType.done
        tf3PhoneNumberNearest.clearButtonMode = UITextField.ViewMode.whileEditing;
        tf3PhoneNumberNearest.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tf3PhoneNumberNearest.placeholder = "3 số thuê bao liên hệ gần nhất"
        nearestPhoneView.addSubview(tf3PhoneNumberNearest)
        
        let lbNotePhone = UILabel(frame: CGRect(x: Common.Size(s:15), y: tf3PhoneNumberNearest.frame.origin.y + tf3PhoneNumberNearest.frame.height + Common.Size(s:10), width: self.view.frame.width - (Common.Size(s:30)), height: Common.Size(s:20)))
        lbNotePhone.text = "Lưu ý: Mỗi số thuê bao cách nhau dấu chấm phẩy."
        lbNotePhone.font = UIFont.italicSystemFont(ofSize: 12)
        lbNotePhone.textColor = UIColor.lightGray
        nearestPhoneView.addSubview(lbNotePhone)
        
        nearestPhoneView.frame = CGRect(x: nearestPhoneView.frame.origin.x, y: nearestPhoneView.frame.origin.y, width: nearestPhoneView.frame.width, height: lbNotePhone.frame.origin.y + lbNotePhone.frame.height)
        
        
        if self.sim?.normalIsdn == "false" {//sim so dep
//            nearestPhoneView.isHidden = false
            
            ///IMage
            imageCMNDView = UIView(frame: CGRect(x: 0, y: nearestPhoneView.frame.origin.y + nearestPhoneView.frame.height + Common.Size(s: 15), width: self.view.frame.width, height: Common.Size(s: 240)))
            imageCMNDView.backgroundColor = UIColor.white
            scrollView.addSubview(imageCMNDView)
            
        } else {//sim thuong
            nearestPhoneView.isHidden = true

            ///IMage
            imageCMNDView = UIView(frame: CGRect(x: 0, y: serialView.frame.origin.y + serialView.frame.height + Common.Size(s: 15), width: self.view.frame.width, height: Common.Size(s: 240)))
            imageCMNDView.backgroundColor = UIColor.white
            scrollView.addSubview(imageCMNDView)
        }
        
        let cmndHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: imageCMNDView.frame.width, height: Common.Size(s: 40)))
        cmndHeaderView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        imageCMNDView.addSubview(cmndHeaderView)
        
        let lbCMNDImage = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: imageCMNDView.frame.width, height: Common.Size(s: 40)))
        lbCMNDImage.text = "HÌNH ẢNH CMND"
        lbCMNDImage.textColor = UIColor.black
        lbCMNDImage.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        cmndHeaderView.addSubview(lbCMNDImage)
        
        /////chup CMND mat truoc
        viewImageCMNDTruoc = UIView(frame: CGRect(x:Common.Size(s:15), y: cmndHeaderView.frame.origin.y + cmndHeaderView.frame.size.height + Common.Size(s:15), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:150)))
        viewImageCMNDTruoc.layer.borderWidth = 0.5
        viewImageCMNDTruoc.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDTruoc.layer.cornerRadius = 3.0
        imageCMNDView.addSubview(viewImageCMNDTruoc)
        
        let viewCMNDTruocButton = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDTruoc.frame.width, height: viewImageCMNDTruoc.frame.height))
        viewCMNDTruocButton.image = #imageLiteral(resourceName: "CMNDmatrc")
        viewCMNDTruocButton.contentMode = .scaleAspectFit
        viewImageCMNDTruoc.addSubview(viewCMNDTruocButton)
        
        
        let tapShowCMNDTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDTruoc))
        viewImageCMNDTruoc.isUserInteractionEnabled = true
        viewImageCMNDTruoc.addGestureRecognizer(tapShowCMNDTruoc)
        
        
        //// chup CMND mat sau
        
        viewImageCMNDSau = UIView(frame: CGRect(x:Common.Size(s:15), y: viewImageCMNDTruoc.frame.origin.y + viewImageCMNDTruoc.frame.size.height + Common.Size(s:15), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:150)))
        viewImageCMNDSau.layer.borderWidth = 0.5
        viewImageCMNDSau.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDSau.layer.cornerRadius = 3.0
        imageCMNDView.addSubview(viewImageCMNDSau)
        
        let viewCMNDSauButton = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDSau.frame.width, height: viewImageCMNDSau.frame.height))
        viewCMNDSauButton.image = #imageLiteral(resourceName: "CMNDmatsau")
        viewCMNDSauButton.contentMode = .scaleAspectFit
        viewImageCMNDSau.addSubview(viewCMNDSauButton)
        
        
        let tapShowCMNDSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDSau))
        viewImageCMNDSau.isUserInteractionEnabled = true
        viewImageCMNDSau.addGestureRecognizer(tapShowCMNDSau)
        
        ///chu ky kh
        let signView = UIView(frame: CGRect(x: 0, y: viewImageCMNDSau.frame.origin.y + viewImageCMNDSau.frame.height + Common.Size(s: 15), width: self.view.frame.width, height: Common.Size(s: 40)))
        signView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        imageCMNDView.addSubview(signView)
        
        let lbTextSign = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: signView.frame.size.width, height: signView.frame.size.height))
        lbTextSign.textAlignment = .left
        lbTextSign.textColor = UIColor.black
        lbTextSign.text = "CHỮ KÝ KHÁCH HÀNG"
        signView.addSubview(lbTextSign)
        
        viewImageSign = UIView(frame: CGRect(x:Common.Size(s:15), y: signView.frame.origin.y + signView.frame.size.height + Common.Size(s:15), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:150)))
        viewImageSign.layer.borderWidth = 0.5
        viewImageSign.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSign.layer.cornerRadius = 3.0
        imageCMNDView.addSubview(viewImageSign)
        
        let viewSignButton = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSign.frame.width, height: viewImageSign.frame.height))
        viewSignButton.image = #imageLiteral(resourceName: "Chuky")
        viewSignButton.contentMode = .scaleAspectFit
        viewImageSign.addSubview(viewSignButton)
        
        
        let tapShowSignature = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSignature))
        viewImageSign.isUserInteractionEnabled = true
        viewImageSign.addGestureRecognizer(tapShowSignature)
        
        imageCMNDView.frame = CGRect(x: imageCMNDView.frame.origin.x, y: imageCMNDView.frame.origin.y, width: imageCMNDView.frame.width, height: viewImageSign.frame.origin.y + viewImageSign.frame.height + Common.Size(s: 15))
        ////btn update sim
        
        btnUpdateChangeSim = UIButton()
        btnUpdateChangeSim.frame = CGRect(x: Common.Size(s:15), y: imageCMNDView.frame.origin.y + imageCMNDView.frame.size.height + Common.Size(s:10), width: self.view.frame.size.width - Common.Size(s:30),height: Common.Size(s:40))
        btnUpdateChangeSim.backgroundColor = UIColor(red: 34/255, green: 134/255, blue: 70/255, alpha: 1)
        btnUpdateChangeSim.setTitle("CẬP NHẬT", for: .normal)
        btnUpdateChangeSim.addTarget(self, action: #selector(actionUpdateChangeSim), for: .touchUpInside)
        btnUpdateChangeSim.layer.borderWidth = 0.5
        btnUpdateChangeSim.layer.borderColor = UIColor.white.cgColor
        btnUpdateChangeSim.layer.cornerRadius = 3
        scrollView.addSubview(btnUpdateChangeSim)
        btnUpdateChangeSim.clipsToBounds = true
        
        scrollViewHeight = btnUpdateChangeSim.frame.origin.y + btnUpdateChangeSim.frame.height + Common.Size(s: 100)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        //set up value noi cap CMND
        lbNoiCapCMNDValue.itemSelectionHandler = { items, itemPosition in
            self.lbNoiCapCMNDValue.text = items[itemPosition].title
        }
    }
    
    @objc func actionScan() {
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            self.tfSerial.text = code
        }
        self.present(viewController, animated: false, completion: nil)
    }
    
    fileprivate func createRadioButtonGender(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:12));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    @objc fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioMan.isSelected = false
            radioWoman.isSelected = false
            switch temp {
            case "Nam":
                genderType = 0
                Cache.genderType = 0
                radioMan.isSelected = true
                break
            case "Nữ":
                genderType = 1
                Cache.genderType = 1
                radioWoman.isSelected = true
                break
            default:
                genderType = -1
                Cache.genderType = -1
                break
            }
        }
    }
    
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func actionUpdateChangeSim() {
        debugPrint("self.isTraSau:\(self.isTraSau)")
        
        if self.sim?.normalIsdn == "true"{
            self.isNormalIsdn = true
            self.arrContacts = ["", "", ""]
        } else {
            self.isNormalIsdn = false
            
            guard let contactNumbers = tf3PhoneNumberNearest.text, !contactNumbers.isEmpty else {
                self.showMessage(title: "Thông báo", message: "Bạn chưa nhập 3 số thuê bao liên hệ gần nhất!")
                return
            }
            
            arrContacts = contactNumbers.components(separatedBy: ";")
            
            if arrContacts.count < 3{
                self.showMessage(title: "Thông báo", message: "Bạn chưa nhập đủ 3 số thuê bao!")
                return
                
            }else if arrContacts.count > 3{
                self.showMessage(title: "Thông báo", message: "Chỉ nhập đủ 3 số thuê bao!")
                return
                
            } else if arrContacts.count == 3 {
                for sdt in arrContacts {
                    if (sdt.count != 10) || !(sdt.hasPrefix("0")) || !(sdt.isNumber()) {
                        self.showMessage(title: "Thông báo", message: "3 số thuê bao không hợp lệ!")
                        return
                    }
                }
            }
        }
        
        if self.lbChooseSimType.text == nil {
            self.showMessage(title: "Thông báo", message: "Bạn chưa chọn hình thức đổi sim!")
            return
        }
        
        if self.selectedSimType.is_esim == "Y"{
            self.isEsim = 1
            
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.sp_mpos_FRT_SP_Esim_getSeri(SDT: self.tfPhoneNumber.text ?? "", ItemCode: "", SoMpos: "") { (arrEsimSerial, error) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if error.count <= 0 {
                            if arrEsimSerial.count > 0 {
                                if arrEsimSerial[0].p_status == 1 {
                                    self.newSerial = arrEsimSerial[0].seri
                                    self.handleUpDateChangeSim(strBase64CMNDTruoc: self.strBase64CMNDTruoc, strBase64CMNDSau: self.strBase64CMNDSau, strBase64Sign: self.strBase64Sign)
                                } else {
                                    self.showMessage(title: "Thông báo", message: "\(arrEsimSerial[0].p_messagess)")
                                }
                                
                            } else {
                                self.showMessage(title: "Thông báo", message: "Get serial esim thất bại!")
                            }
                        } else {
                            self.showMessage(title: "Thông báo", message: "\(error)")
                        }
                    }
                }
            }
        } else {
            self.isEsim = 0
            self.newSerial = self.tfSerial.text ?? ""
            
            self.handleUpDateChangeSim(strBase64CMNDTruoc: self.strBase64CMNDTruoc, strBase64CMNDSau: self.strBase64CMNDSau, strBase64Sign: self.strBase64Sign)
        }
    }
    
    func handleUpDateChangeSim(strBase64CMNDTruoc: String, strBase64CMNDSau: String, strBase64Sign: String) {
        
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang cập nhật...") {
            MPOSAPIManager.VTChangeSimErp(FullName: self.tfFullName.text ?? "", BirthDay: self.tfBirthDate.text ?? "", Gender: "\(self.genderType)", Address: self.tfAddress.text ?? "", DateCreateCMND: self.lbNgayCapCMND.text ?? "", PalaceCreateCMND: self.lbNoiCapCMNDValue.text ?? "", is_esim: "\(self.isEsim)", is_trasau: self.isTraSau, Provider: "Viettel", Isdn: self.tfPhoneNumber.text ?? "", normalIsdn: self.isNormalIsdn, idNo: "\(self.tfCMND.text ?? "")", otpCode: self.otpString, reasonCode: "\(self.selectedSimType.Code)", oldSerial: self.sim?.serial ?? "", newSerial: "\(self.newSerial)", isdnContact1: self.arrContacts[0], isdnContact2: self.arrContacts[1], isdnContact3: self.arrContacts[2], ShopCode: "\(Cache.user?.ShopCode ?? "")", UserCode: "\(Cache.user?.UserName ?? "")", Images: "\(strBase64CMNDTruoc),\(strBase64CMNDSau),\(strBase64Sign)") { (success, message) in
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if (success){
                        debugPrint("seriEsimY: \(self.newSerial)")
                        if self.selectedSimType.is_esim == "Y" {//la esim
                            self.getQRcode(phoneNumber: self.phone, SOMPOS: "", SeriSim: self.newSerial)
                            
                        } else {
                            let alertVC = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                for vc in self.navigationController?.viewControllers ?? [] {
                                    if vc is ChonNhaMangThaySimViewController {
                                        self.navigationController?.popToViewController(vc, animated: true)
                                    }
                                }
                            })
                            alertVC.addAction(action)
                            self.present(alertVC, animated: true, completion: nil)
                        }
                    } else {
                        let fullMessage = "ShopCode: \(Cache.user?.ShopCode ?? "")\nSerial: \(self.newSerial)\n\(message)"
                        self.showMessage(title: "Thông báo", message: fullMessage)
                    }
                }
            }
        }
    }
    
    func getQRcode(phoneNumber:String,SOMPOS:String,SeriSim:String){
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.sp_mpos_FRT_SP_ESIM_getqrcode(SDT:
            phoneNumber,SOMPOS: SOMPOS,SeriSim: SeriSim) { (results, err) in
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    
                    if (err.count <= 0){
                        results[0].sdt = phoneNumber
                        let newViewController = QRCodeEsimViettelViewController()
                        newViewController.esimQRCode = results[0]
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }else{
                        
                        let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                            
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func imageCMNDTruoc(image:UIImage){
        //        let sca:CGFloat = image.size.width / image.size.height
        //        let heightImage:CGFloat = viewImageCMNDTruoc.frame.size.width / sca
        let heightImage:CGFloat = Common.Size(s: 150)
        viewImageCMNDTruoc.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDTruoc  = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: heightImage))
        imgViewCMNDTruoc.contentMode = .scaleAspectFit
        imgViewCMNDTruoc.image = image
        viewImageCMNDTruoc.addSubview(imgViewCMNDTruoc)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btnUpdateChangeSim.frame.origin.y + btnUpdateChangeSim.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 40))
        let imageCMNDTruoc:UIImage = self.resizeImageWidth(image: imgViewCMNDTruoc.image!,newWidth: Common.resizeImageWith)!
        let imageDataCMNDTruoc:NSData = (imageCMNDTruoc.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
        self.strBase64CMNDTruoc = imageDataCMNDTruoc.base64EncodedString(options: .endLineWithLineFeed)
    }
    
    func imageCMNDSau(image:UIImage){
        let heightImage:CGFloat = Common.Size(s: 150)
        viewImageCMNDSau.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDSau  = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: heightImage))
        imgViewCMNDSau.contentMode = .scaleAspectFit
        imgViewCMNDSau.image = image
        viewImageCMNDSau.addSubview(imgViewCMNDSau)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btnUpdateChangeSim.frame.origin.y + btnUpdateChangeSim.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 40))
        let imageCMNDSau:UIImage = self.resizeImageWidth(image: imgViewCMNDSau.image!,newWidth: Common.resizeImageWith)!
        let imageDataSau:NSData = (imageCMNDSau.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
        self.strBase64CMNDSau = imageDataSau.base64EncodedString(options: .endLineWithLineFeed)
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
    
    @objc func tapShowCMNDTruoc(sender:UITapGestureRecognizer) {
        self.posImageUpload = 4
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowCMNDSau(sender:UITapGestureRecognizer) {
        self.posImageUpload = 5
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc func tapShowSignature(sender:UITapGestureRecognizer) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
//        let nav = UINavigationController(rootViewController: signatureVC)
//        present(nav, animated: true, completion: nil)
         self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    func epSignature(_: EPSignatureViewController, didCancel error : NSError) {
        print("User canceled")
        _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        
        //        let width = viewImageSign.frame.size.width - Common.Size(s:10)
        //
        //        let sca:CGFloat = boundingRect.size.width / boundingRect.size.height
        //        let heightImage:CGFloat = width / sca
        let heightImage:CGFloat = Common.Size(s: 150)
        viewImageSign.subviews.forEach { $0.removeFromSuperview() }
        imgViewSign  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDTruoc.frame.size.width, height: heightImage))
        imgViewSign.contentMode = .scaleAspectFit
        imgViewSign.image = cropImage(image: signatureImage, toRect: boundingRect)
        viewImageSign.addSubview(imgViewSign)
        viewImageSign.frame.size.height = imgViewSign.frame.size.height + imgViewSign.frame.origin.y
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btnUpdateChangeSim.frame.origin.y + btnUpdateChangeSim.frame.size.height + Common.Size(s: 15) + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height  + Common.Size(s: 20))
        
        let imageSign:UIImage = self.resizeImage(image: imgViewSign.image!,newHeight: 80)!
        let imageDataSign:NSData = (imageSign.jpegData(compressionQuality: 0.75) as NSData?)!
        self.strBase64Sign = imageDataSign.base64EncodedString(options: .endLineWithLineFeed)
        
        _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
        
    }
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    
    func showMessage(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func showDropMenuSimType() {
        
        DropDown.setupDefaultAppearance();
        
        dropMenuSimType.dismissMode = .onTap
        dropMenuSimType.direction = .any
        
        dropMenuSimType.anchorView = lbChooseSimType;
        DropDown.startListeningToKeyboard();
        
        dropMenuSimType.dataSource = arrsimType;
        dropMenuSimType.selectRow(0);
        
        self.dropMenuSimType.show()
        
        dropMenuSimType.selectionAction = { [weak self] (index, item) in
            self?.listReasonCode.forEach{
                if($0.Name == item){
                    self?.selectedSimType = $0
                    self?.lbChooseSimType.text = " \($0.Name)"
                    
                    //                show serial
                    if $0.is_esim == "Y" {
                        self!.serialView.isHidden = true
                        
                        if self?.nearestPhoneView.isHidden == true {
                            
                            self!.imageCMNDView.frame.origin.y = self!.lbChooseSimType.frame.origin.y + self!.lbChooseSimType.frame.height + Common.Size(s:15)
                            self!.btnUpdateChangeSim.frame.origin.y = self!.imageCMNDView.frame.origin.y + self!.imageCMNDView.frame.height + Common.Size(s:20)
                            
                            
                        } else {
                            self!.nearestPhoneView.frame.origin.y = self!.lbChooseSimType.frame.origin.y + self!.lbChooseSimType.frame.height + Common.Size(s:15)
                            
                            self!.imageCMNDView.frame.origin.y = self!.nearestPhoneView.frame.origin.y + self!.nearestPhoneView.frame.height + Common.Size(s:15)
                            
                            self!.btnUpdateChangeSim.frame.origin.y = self!.imageCMNDView.frame.origin.y + self!.imageCMNDView.frame.height + Common.Size(s:20)
                        }
                        
                    } else {
                        self!.serialView.isHidden = false
                        
                        if self?.nearestPhoneView.isHidden == true {
                            
                            self!.imageCMNDView.frame.origin.y = self!.serialView.frame.origin.y + self!.serialView.frame.height + Common.Size(s:15)
                            
                            self!.btnUpdateChangeSim.frame.origin.y = self!.imageCMNDView.frame.origin.y + self!.imageCMNDView.frame.height + Common.Size(s:20)
                        } else {
                            self!.nearestPhoneView.frame.origin.y = self!.serialView.frame.origin.y + self!.serialView.frame.height + Common.Size(s:15)
                            
                            self!.imageCMNDView.frame.origin.y = self!.nearestPhoneView.frame.origin.y + self!.nearestPhoneView.frame.height + Common.Size(s:15)
                            
                            self!.btnUpdateChangeSim.frame.origin.y = self!.imageCMNDView.frame.origin.y + self!.imageCMNDView.frame.height + Common.Size(s:20)
                        }
                    }
                }
            }
        }
    }
    
    @objc func showCalendar() {
//        let calendarVC = CalendarViewController()
//        self.customPresentViewController(presenter, viewController: calendarVC, animated: true)
//        calendarVC.delegate = self
        
        calendar.dateStyleComponents = CalendarComponentStyle(backgroundColor: UIColor(netHex: 0x594166),
                                                              textColor: .white,
                                                              highlightColor: UIColor(netHex: 0x7ec0c4).withAlphaComponent(0.5))
        calendar.yearStyleComponents = CalendarComponentStyle(backgroundColor: UIColor(netHex: 0x594166),
                                                              textColor: .black, highlightColor: .white)
        calendar.monthStyleComponents = CalendarComponentStyle(backgroundColor: UIColor(netHex: 0x2f3c5f),
                                                               textColor: .black,
                                                               highlightColor: UIColor.white)
        calendar.subscriber = { [weak self] (date) in guard let checkedSelf = self else { return }
            if date != nil {
                checkedSelf.selectedDate = date
                let selectedDate = Date(timeIntervalSince1970: TimeInterval(date?.doubleVal ?? 0))
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let str = dateFormatter.string(from: selectedDate)
                self?.dateString1 = str
                self?.lbNgayCapCMND.text = " \(str)"
                self?.lbNgayCapCMND.textColor = UIColor.black
            }
        }
        calendar.preSelectedDate = selectedDate
        self.present(calendar, animated: false, completion: nil)
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
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.endEditing(true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.endEditing(true)
    }
}

//extension ChangeSimViewController: CalendarViewControllerDelegate {
//    func getDate(dateString: String) {
//        let strFormat = dateString.replace("-", withString: "/")
//        self.dateString1 = strFormat
//        self.lbNgayCapCMND.text = " \(strFormat)"
//        self.lbNgayCapCMND.textColor = UIColor.black
//    }
//}



extension ChangeSimViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        // image is our desired image
        if (self.posImageUpload == 4){
            self.imageCMNDTruoc(image: image)
        }else if (self.posImageUpload == 5){
            self.imageCMNDSau(image: image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
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
    
}


