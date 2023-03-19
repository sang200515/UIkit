//
//  RegisterRightPhoneViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/8/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import DLRadioButton

class RegisterRightPhoneViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    var scrollView:UIScrollView!
    var switchNotResgistry:UISwitch!
    var switchResgistry:UISwitch!
    var viewMore:UIView!
    var imagePicker = UIImagePickerController()
    //--
    var viewInfoCMNDFront:UIView!
    var viewImageCMNDFront:UIView!
    var imgViewCMNDFront: UIImageView!
    var viewCMNDFront:UIView!
    //--
    
    //--
    var viewInfoCMNDBehind:UIView!
    var viewImageCMNDBehind:UIView!
    var imgViewCMNDBehind: UIImageView!
    var viewCMNDBehind:UIView!
    //--
    
    var viewInfoNP:UIView!
    var viewImageNP:UIView!
    var imgViewNP: UIImageView!
    var viewNP:UIView!
    //--
    var viewInfoLeftDevide:UIView!
    var viewImageLeftDevide:UIView!
    var imgViewLeftDevide: UIImageView!
    var viewLeftDevide:UIView!
    //
    //--
     var viewInfoRightDevide:UIView!
     var viewImageRightDevide:UIView!
     var imgViewRightDevide: UIImageView!
     var viewRightDevide:UIView!
     //
    //--
    var viewInfoBroken:UIView!
    var viewImageBroken:UIView!
    var imgViewBroken: UIImageView!
    var viewBroken:UIView!
    //
    //--
    var viewInfoSignDoc:UIView!
    var viewImageSignDoc:UIView!
    var imgViewSignDoc: UIImageView!
    var viewSignDoc:UIView!
    //
    //--
    var viewInfoAvarta:UIView!
    var viewImageAvarta:UIView!
    var imgViewAvarta: UIImageView!
    var viewAvarta:UIView!
    //
    
    var posImageUpload:Int = -1
    var viewUpload:UIView!
    var btConfirm:UIButton!
    var heightUploadView:CGFloat = 0.0
    
    var detailRPRcheck:DetailRPRcheck?
    var  lblPrintConfirmText:UILabel!
    
    var radionNotResgistry:DLRadioButton!
    var radioResistry:DLRadioButton!
    var genderType:Int = -1
    var itemRPOnProgress:ItemRPOnProgress?
    
    var urlFrontCMND:String = ""
    var urlBehindCMND:String = ""
    var urlLeft:String = ""
    var urlRight:String = ""
    var urlBroken:String = ""
    var urlSign:String = ""
    var urlAvarta:String = ""
    var urlNP:String = ""
    
    var selectType:Int = 0
    var tfCustomerName:UITextField!
    var tfCustomerPhone:UITextField!
    var tfCustomerMail:UITextField!
    var tfPriceRecomment:UITextField!
    var viewFooter:UIView!
    var tfOTP:UITextField!
    var tfDevideStatus:UITextView!
    var tfAccessoriesDescription:UITextField!
 
    var tfCMND:UITextField!
    var tfDateCMND:UITextField!
    var tfPlaceCMND:SearchTextField!
    var tfAddressCMND:UITextField!
    var tfHome:UITextField!
    var tfHomePhone:UITextField!
    var lstProvince:[ProvinceRightPhone] = []
    var selectProvince:String = ""
    override func viewDidLoad() {
        self.title = "Cập nhật thông tin"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(RegisterRightPhoneViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.clipsToBounds = true
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let label = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label.text = "THÔNG TIN SẢN PHẨM"
        label.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label)
        
        let viewProduct = UIView()
        viewProduct.frame = CGRect(x: 0, y: label.frame.size.height + label.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewProduct.backgroundColor = UIColor.white
        scrollView.addSubview(viewProduct)
        
        let lblMposNum = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblMposNum.textAlignment = .left
        lblMposNum.textColor = UIColor.black
        lblMposNum.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lblMposNum.text = "Số Mpos: \(self.itemRPOnProgress?.docentry ?? 0)"
        viewProduct.addSubview(lblMposNum)
        
        let lblNameProduct = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblMposNum.frame.size.height + lblMposNum.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNameProduct.textAlignment = .left
        lblNameProduct.textColor = UIColor.black
        lblNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lblNameProduct.text = "Tên SP: \(self.detailRPRcheck!.ItemName)"
        viewProduct.addSubview(lblNameProduct)
        
        
        let lblImei = UILabel(frame: CGRect(x: Common.Size(s:10), y:lblNameProduct.frame.size.height + lblNameProduct.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblImei.textAlignment = .left
        lblImei.textColor = UIColor(netHex:0x00955E)
        lblImei.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        lblImei.text = "Imei: \(self.detailRPRcheck!.IMEI)"
        viewProduct.addSubview(lblImei)
        
        
        
        
        let lblColorProduct = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblImei.frame.size.height + lblImei.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblColorProduct.textAlignment = .left
        lblColorProduct.textColor = UIColor.black
        lblColorProduct.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblColorProduct.text = "Màu sắc: \(self.detailRPRcheck!.color)"
        viewProduct.addSubview(lblColorProduct)
        
        
        let lblBranch = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblImei.frame.size.height + lblImei.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblBranch.textAlignment = .right
        lblBranch.textColor = UIColor.black
        lblBranch.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBranch.text = "Hãng: \(self.detailRPRcheck!.manufacturer)"
        viewProduct.addSubview(lblBranch)
        
        let lblMemory = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblColorProduct.frame.size.height + lblColorProduct.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblMemory.textAlignment = .left
        lblMemory.textColor = UIColor.black
        lblMemory.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblMemory.text = "Memory: \(self.detailRPRcheck!.memory)"
        viewProduct.addSubview(lblMemory)
        
        viewProduct.frame.size.height = lblMemory.frame.size.height + lblMemory.frame.origin.y + Common.Size(s: 10)
        
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y:viewProduct.frame.size.height + viewProduct.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN KHÁCH HÀNG"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        
        
        let viewCustomer = UIView()
        viewCustomer.frame = CGRect(x: 0, y: label1.frame.size.height + label1.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewCustomer.backgroundColor = UIColor.white
        scrollView.addSubview(viewCustomer)
        
        
        
        let lblCustomerName = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblCustomerName.textAlignment = .left
        lblCustomerName.textColor = UIColor.black
        lblCustomerName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblCustomerName.text = "Họ tên(*)"
        viewCustomer.addSubview(lblCustomerName)
        
        tfCustomerName = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblCustomerName.frame.origin.y + lblCustomerName.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfCustomerName.placeholder = "Nhập tên KH"
        tfCustomerName.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCustomerName.borderStyle = UITextField.BorderStyle.roundedRect
        tfCustomerName.autocorrectionType = UITextAutocorrectionType.no
        tfCustomerName.keyboardType = UIKeyboardType.default
        tfCustomerName.returnKeyType = UIReturnKeyType.done
        tfCustomerName.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCustomerName.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCustomerName.delegate = self
        viewCustomer.addSubview(tfCustomerName)
        tfCustomerName.text = self.detailRPRcheck!.Sale_Name
        
        let lblCustomerPhone = UILabel(frame: CGRect(x: Common.Size(s:10), y: tfCustomerName.frame.size.height + tfCustomerName.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblCustomerPhone.textAlignment = .left
        lblCustomerPhone.textColor = UIColor.black
        lblCustomerPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblCustomerPhone.text = "SĐT(*)"
        viewCustomer.addSubview(lblCustomerPhone)
        
        
        tfCustomerPhone = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblCustomerPhone.frame.origin.y + lblCustomerPhone.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfCustomerPhone.placeholder = "Nhập SĐT KH"
        tfCustomerPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCustomerPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfCustomerPhone.autocorrectionType = UITextAutocorrectionType.no
        tfCustomerPhone.keyboardType = UIKeyboardType.numberPad
        tfCustomerPhone.returnKeyType = UIReturnKeyType.done
        tfCustomerPhone.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCustomerPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCustomerPhone.delegate = self
        viewCustomer.addSubview(tfCustomerPhone)
        tfCustomerPhone.text = self.detailRPRcheck!.Sale_phone
        
        let lblCustomerMail = UILabel(frame: CGRect(x: Common.Size(s:10), y: tfCustomerPhone.frame.size.height + tfCustomerPhone.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblCustomerMail.textAlignment = .left
        lblCustomerMail.textColor = UIColor.black
        lblCustomerMail.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblCustomerMail.text = "Mail"
        viewCustomer.addSubview(lblCustomerMail)
        
        
        tfCustomerMail = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblCustomerMail.frame.origin.y + lblCustomerMail.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfCustomerMail.placeholder = "Nhập Mail KH"
        tfCustomerMail.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCustomerMail.borderStyle = UITextField.BorderStyle.roundedRect
        tfCustomerMail.autocorrectionType = UITextAutocorrectionType.no
        tfCustomerMail.keyboardType = UIKeyboardType.default
        tfCustomerMail.returnKeyType = UIReturnKeyType.done
        tfCustomerMail.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCustomerMail.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCustomerMail.delegate = self
        viewCustomer.addSubview(tfCustomerMail)
        tfCustomerMail.text = self.detailRPRcheck!.Sale_mail

        
        
        
        
        radionNotResgistry = createRadioButtonLoaiThueBao(CGRect(x: tfCustomerMail.frame.origin.x,y:tfCustomerMail.frame.origin.y + tfCustomerMail.frame.size.height + Common.Size(s:10) , width: tfCustomerMail.frame.size.width/2, height: 0), title: "Không đăng ký bán", color: UIColor.black);
        radionNotResgistry.clipsToBounds = true
        viewCustomer.addSubview(radionNotResgistry)
        
        radioResistry = createRadioButtonLoaiThueBao(CGRect(x: radionNotResgistry.frame.origin.x + radionNotResgistry.frame.size.width + Common.Size(s:5) ,y:radionNotResgistry.frame.origin.y, width: radionNotResgistry.frame.size.width, height: 0), title: "Đăng ký bán", color: UIColor.black);
        radioResistry.clipsToBounds = true
        viewCustomer.addSubview(radioResistry)
        
        //radionNotResgistry.isSelected = true
        viewCustomer.frame.size.height = radionNotResgistry.frame.size.height + radionNotResgistry.frame.origin.y + Common.Size(s: 10)
        
        
        
        viewMore = UIView()
        viewMore.frame = CGRect(x: 0, y: viewCustomer.frame.origin.y + viewCustomer.frame.size.height + Common.Size(s: 10) , width: scrollView.frame.size.width, height: 0)
        viewMore.backgroundColor = UIColor.white
        viewMore.clipsToBounds = true
        scrollView.addSubview(viewMore)
        
        
        
        let lblCustomerCMND = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblCustomerCMND.textAlignment = .left
        lblCustomerCMND.textColor = UIColor.black
        lblCustomerCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblCustomerCMND.text = "CMND(*)"
        viewMore.addSubview(lblCustomerCMND)
        
        
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblCustomerCMND.frame.origin.y + lblCustomerCMND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        if Cache.RP_cmndNumber.isEmpty {
            tfCMND.placeholder = "Nhập CMND KH"
        } else {
            tfCMND.text = "\(Cache.RP_cmndNumber)"
        }
        viewMore.addSubview(tfCMND)
        
        let lblDateCMND = UILabel(frame: CGRect(x: Common.Size(s:10), y: tfCMND.frame.size.height + tfCMND.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblDateCMND.textAlignment = .left
        lblDateCMND.textColor = UIColor.black
        lblDateCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDateCMND.text = "Ngày cấp CMND(*)"
        viewMore.addSubview(lblDateCMND)
        
        
        tfDateCMND = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblDateCMND.frame.origin.y + lblDateCMND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
//        tfDateCMND.placeholder = "Nhập ngày cấp cmnd KH"
        tfDateCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDateCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfDateCMND.autocorrectionType = UITextAutocorrectionType.no
        tfDateCMND.keyboardType = UIKeyboardType.numberPad
        tfDateCMND.returnKeyType = UIReturnKeyType.done
        tfDateCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfDateCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDateCMND.delegate = self
        if Cache.RP_ngayCapCMND.isEmpty {
            tfDateCMND.placeholder = "Nhập ngày cấp cmnd KH"
        } else {
            tfDateCMND.text = "\(Cache.RP_ngayCapCMND)"
        }
        viewMore.addSubview(tfDateCMND)
        tfDateCMND.addTarget(self, action: #selector(RegisterRightPhoneViewController.textFieldDidEndEditing), for: .editingDidEnd)
        
        let lblPlaceCMND = UILabel(frame: CGRect(x: Common.Size(s:10), y: tfDateCMND.frame.size.height + tfDateCMND.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPlaceCMND.textAlignment = .left
        lblPlaceCMND.textColor = UIColor.black
        lblPlaceCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPlaceCMND.text = "Nơi cấp CMND(*)"
        viewMore.addSubview(lblPlaceCMND)
        
        
        tfPlaceCMND = SearchTextField(frame: CGRect(x: Common.Size(s:10), y: lblPlaceCMND.frame.origin.y + lblPlaceCMND.frame.size.height + Common.Size(s:10), width: tfDateCMND.frame.size.width , height: tfDateCMND.frame.size.height ));
//        tfPlaceCMND.placeholder = "Chọn nơi cấp cmnd"
        tfPlaceCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPlaceCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfPlaceCMND.autocorrectionType = UITextAutocorrectionType.no
        tfPlaceCMND.keyboardType = UIKeyboardType.default
        tfPlaceCMND.returnKeyType = UIReturnKeyType.done
        tfPlaceCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPlaceCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPlaceCMND.delegate = self
        if Cache.RP_noiCapCMND.isEmpty {
            tfPlaceCMND.placeholder = "Chọn nơi cấp cmnd"
        } else {
            tfPlaceCMND.text = "\(Cache.RP_noiCapCMND)"
        }
        viewMore.addSubview(tfPlaceCMND)
        
        // Start visible - Default: false
        tfPlaceCMND.startVisible = true
        tfPlaceCMND.theme.bgColor = UIColor.white
        tfPlaceCMND.theme.fontColor = UIColor.black
        tfPlaceCMND.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPlaceCMND.theme.cellHeight = Common.Size(s:40)
        tfPlaceCMND.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        tfPlaceCMND.leftViewMode = UITextField.ViewMode.always
        tfPlaceCMND.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfPlaceCMND.text = item.title
            let obj =  self.lstProvince.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectProvince = "\(obj)"
            }
            self.tfPlaceCMND.becomeFirstResponder()
              }
        
        let lblAddressCMND = UILabel(frame: CGRect(x: Common.Size(s:10), y: tfPlaceCMND.frame.size.height + tfPlaceCMND.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblAddressCMND.textAlignment = .left
        lblAddressCMND.textColor = UIColor.black
        lblAddressCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblAddressCMND.text = "Địa chỉ trên CMND(*)"
        viewMore.addSubview(lblAddressCMND)
        
        
        tfAddressCMND = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblAddressCMND.frame.origin.y + lblAddressCMND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
//        tfAddressCMND.placeholder = "Nhập địa chỉ trên cmnd KH"
        tfAddressCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfAddressCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfAddressCMND.autocorrectionType = UITextAutocorrectionType.no
        tfAddressCMND.keyboardType = UIKeyboardType.default
        tfAddressCMND.returnKeyType = UIReturnKeyType.done
        tfAddressCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfAddressCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfAddressCMND.delegate = self
        if Cache.RP_cmndAddress.isEmpty {
            tfAddressCMND.placeholder = "Nhập địa chỉ trên cmnd KH"
        } else {
            tfAddressCMND.text = "\(Cache.RP_cmndAddress)"
        }
        viewMore.addSubview(tfAddressCMND)
        
        
        let lblHome = UILabel(frame: CGRect(x: Common.Size(s:10), y: tfAddressCMND.frame.size.height + tfAddressCMND.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblHome.textAlignment = .left
        lblHome.textColor = UIColor.black
        lblHome.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblHome.text = "Địa chỉ hiện nay(*)"
        viewMore.addSubview(lblHome)
        
        
        tfHome = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblHome.frame.origin.y + lblAddressCMND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
//        tfHome.placeholder = "Nhập địa chỉ ở hiện nay của KH"
        tfHome.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHome.borderStyle = UITextField.BorderStyle.roundedRect
        tfHome.autocorrectionType = UITextAutocorrectionType.no
        tfHome.keyboardType = UIKeyboardType.default
        tfHome.returnKeyType = UIReturnKeyType.done
        tfHome.clearButtonMode = UITextField.ViewMode.whileEditing
        tfHome.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHome.delegate = self
        if Cache.RP_addressHome.isEmpty {
            tfHome.placeholder = "Nhập địa chỉ ở hiện nay của KH"
        } else {
            tfHome.text = "\(Cache.RP_addressHome)"
        }
        viewMore.addSubview(tfHome)
        
        let lblHomePhone = UILabel(frame: CGRect(x: Common.Size(s:10), y: tfHome.frame.size.height + tfHome.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblHomePhone.textAlignment = .left
        lblHomePhone.textColor = UIColor.black
        lblHomePhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblHomePhone.text = "Số điện thoại nhà của KH"
        viewMore.addSubview(lblHomePhone)
        
        
        tfHomePhone = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblHomePhone.frame.origin.y + lblHomePhone.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
//        tfHomePhone.placeholder = "Nhập số điện thoại nhà của KH"
        tfHomePhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHomePhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfHomePhone.autocorrectionType = UITextAutocorrectionType.no
        tfHomePhone.keyboardType = UIKeyboardType.numberPad
        tfHomePhone.returnKeyType = UIReturnKeyType.done
        tfHomePhone.clearButtonMode = UITextField.ViewMode.whileEditing
        tfHomePhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHomePhone.delegate = self
        if Cache.RP_phoneNumber.isEmpty {
            tfHomePhone.placeholder = "Nhập số điện thoại nhà của KH"
        } else {
            tfHomePhone.text = "\(Cache.RP_phoneNumber)"
        }
        viewMore.addSubview(tfHomePhone)
        
        
        let lblDevideStatus = UILabel(frame: CGRect(x: Common.Size(s:10), y: tfHomePhone.frame.size.height + tfHomePhone.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblDevideStatus.textAlignment = .left
        lblDevideStatus.textColor = UIColor.black
        lblDevideStatus.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDevideStatus.text = "Mô tả tình trạng máy(*)"
        viewMore.addSubview(lblDevideStatus)
        
        tfDevideStatus = UITextView(frame: CGRect(x: Common.Size(s:10) , y: lblDevideStatus.frame.origin.y  + lblDevideStatus.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 40) * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        tfDevideStatus.layer.borderWidth = 0.5
        tfDevideStatus.layer.borderColor = borderColor.cgColor
        tfDevideStatus.layer.cornerRadius = 5.0
        //        tfNote.delegate = self
        tfDevideStatus.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfDevideStatus.text = "\(Cache.RP_deviceStatus)"
        viewMore.addSubview(tfDevideStatus)
        
        
        
        
        
        let lblAccessoriesDescription = UILabel(frame: CGRect(x: Common.Size(s:10), y: tfDevideStatus.frame.size.height + tfDevideStatus.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblAccessoriesDescription.textAlignment = .left
        lblAccessoriesDescription.textColor = UIColor.black
        lblAccessoriesDescription.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblAccessoriesDescription.text = "Mô tả phụ kiện(*)"
        viewMore.addSubview(lblAccessoriesDescription)
        
        tfAccessoriesDescription = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblAccessoriesDescription.frame.origin.y + lblAccessoriesDescription.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        
        tfAccessoriesDescription.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfAccessoriesDescription.borderStyle = UITextField.BorderStyle.roundedRect
        tfAccessoriesDescription.autocorrectionType = UITextAutocorrectionType.no
        tfAccessoriesDescription.keyboardType = UIKeyboardType.default
        tfAccessoriesDescription.returnKeyType = UIReturnKeyType.done
        tfAccessoriesDescription.clearButtonMode = UITextField.ViewMode.whileEditing
        tfAccessoriesDescription.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfAccessoriesDescription.delegate = self
        tfAccessoriesDescription.text = "\(Cache.RP_accessoriesStatus)"
        viewMore.addSubview(tfAccessoriesDescription)
        
        let lblOTPTitle = UILabel(frame: CGRect(x: Common.Size(s:10), y: tfAccessoriesDescription.frame.size.height + tfAccessoriesDescription.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblOTPTitle.textAlignment = .left
        lblOTPTitle.textColor = UIColor.black
        lblOTPTitle.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblOTPTitle.text = "Nhập OTP SMS(*)"
        viewMore.addSubview(lblOTPTitle)
        
        
        
        tfOTP = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblOTPTitle.frame.origin.y + lblOTPTitle.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:160) , height: Common.Size(s:40)));
//        tfOTP.placeholder = "Nhập OTP KH"
        tfOTP.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfOTP.borderStyle = UITextField.BorderStyle.roundedRect
        tfOTP.autocorrectionType = UITextAutocorrectionType.no
        tfOTP.keyboardType = UIKeyboardType.numberPad
        tfOTP.returnKeyType = UIReturnKeyType.done
        tfOTP.clearButtonMode = UITextField.ViewMode.whileEditing
        tfOTP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfOTP.delegate = self
        if Cache.RP_otpSMS.isEmpty {
            tfOTP.placeholder = "Nhập OTP KH"
        } else {
            tfOTP.text = "\(Cache.RP_otpSMS)"
        }
        viewMore.addSubview(tfOTP)
        
        let btOTP = UIButton()
        btOTP.frame = CGRect(x:tfOTP.frame.size.width + tfOTP.frame.origin.x + Common.Size(s:10), y: tfOTP.frame.origin.y , width: scrollView.frame.size.width  - Common.Size(s:200), height: Common.Size(s:40) )
        btOTP.backgroundColor = UIColor(netHex:0x00955E)
        btOTP.setTitle("Gửi OTP", for: .normal)
        btOTP.addTarget(self, action: #selector(actionOTP), for: .touchUpInside)
        btOTP.layer.borderWidth = 0.5
        btOTP.layer.borderColor = UIColor.white.cgColor
        btOTP.layer.cornerRadius = 3
        viewMore.addSubview(btOTP)
        
        let lblPriceRecomment = UILabel(frame: CGRect(x: Common.Size(s:10), y:  tfOTP.frame.size.height + tfOTP.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPriceRecomment.textAlignment = .left
        lblPriceRecomment.textColor = UIColor.black
        lblPriceRecomment.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPriceRecomment.text = "Giá bán đề xuất(*)"
        viewMore.addSubview(lblPriceRecomment)
        
        tfPriceRecomment = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblPriceRecomment.frame.origin.y + lblPriceRecomment.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        
        tfPriceRecomment.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPriceRecomment.borderStyle = UITextField.BorderStyle.roundedRect
        tfPriceRecomment.autocorrectionType = UITextAutocorrectionType.no
        tfPriceRecomment.keyboardType = UIKeyboardType.numberPad
        tfPriceRecomment.returnKeyType = UIReturnKeyType.done
        tfPriceRecomment.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPriceRecomment.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPriceRecomment.delegate = self
        tfPriceRecomment.text = "\(Cache.RP_suggestedPrice)"
        viewMore.addSubview(tfPriceRecomment)
        tfPriceRecomment.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
        
        
        
        
        viewUpload = UIView(frame: CGRect(x: 0, y: tfPriceRecomment.frame.origin.y + tfPriceRecomment.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width, height: Common.Size(s:100) ))
        viewUpload.backgroundColor = UIColor.white
        viewMore.addSubview(viewUpload)
        
        //---CMND TRUOC
        viewInfoCMNDFront = UIView(frame: CGRect(x:0,y:Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDFront.clipsToBounds = true
        viewUpload.addSubview(viewInfoCMNDFront)
        
        let lbTextCMNDFront = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDFront.textAlignment = .left
        lbTextCMNDFront.textColor = UIColor.black
        lbTextCMNDFront.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDFront.text = "Ảnh CMND mặt trước"
        viewInfoCMNDFront.addSubview(lbTextCMNDFront)
        
        viewImageCMNDFront = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextCMNDFront.frame.origin.y + lbTextCMNDFront.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageCMNDFront.layer.borderWidth = 0.5
        viewImageCMNDFront.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDFront.layer.cornerRadius = 3.0
        viewInfoCMNDFront.addSubview(viewImageCMNDFront)
        
        let viewCMNDFrontButton = UIImageView(frame: CGRect(x: viewImageCMNDFront.frame.size.width/2 - (viewImageCMNDFront.frame.size.height * 2/3)/2, y: 0, width: viewImageCMNDFront.frame.size.height * 2/3, height: viewImageCMNDFront.frame.size.height * 2/3))
        viewCMNDFrontButton.image = UIImage(named:"AddImage")
        viewCMNDFrontButton.contentMode = .scaleAspectFit
        viewImageCMNDFront.addSubview(viewCMNDFrontButton)
        
        
        let lbCMNDFrontButton = UILabel(frame: CGRect(x: 0, y: viewCMNDFrontButton.frame.size.height + viewCMNDFrontButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageCMNDFront.frame.size.height/3))
        lbCMNDFrontButton.textAlignment = .center
        lbCMNDFrontButton.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDFrontButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDFrontButton.text = "Thêm hình ảnh"
        viewImageCMNDFront.addSubview(lbCMNDFrontButton)
        viewInfoCMNDFront.frame.size.height = viewImageCMNDFront.frame.size.height + viewImageCMNDFront.frame.origin.y
        
        let tapShowCMNDFront = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDFront))
        viewInfoCMNDFront.isUserInteractionEnabled = true
        viewInfoCMNDFront.addGestureRecognizer(tapShowCMNDFront)
        
        
        
        
        //---------
        
        //---CMND SAU
        viewInfoCMNDBehind = UIView(frame: CGRect(x:0,y:viewInfoCMNDFront.frame.size.height + viewInfoCMNDFront.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDBehind.clipsToBounds = true
        viewUpload.addSubview(viewInfoCMNDBehind)
        
        let lbTextMSDT = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextMSDT.textAlignment = .left
        lbTextMSDT.textColor = UIColor.black
        lbTextMSDT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextMSDT.text = "Ảnh CMND mặt sau"
        viewInfoCMNDBehind.addSubview(lbTextMSDT)
        
        viewImageCMNDBehind = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextMSDT.frame.origin.y + lbTextMSDT.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageCMNDBehind.layer.borderWidth = 0.5
        viewImageCMNDBehind.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDBehind.layer.cornerRadius = 3.0
        viewInfoCMNDBehind.addSubview(viewImageCMNDBehind)
        
        let viewMSDTButton = UIImageView(frame: CGRect(x: viewImageCMNDBehind.frame.size.width/2 - (viewImageCMNDBehind.frame.size.height * 2/3)/2, y: 0, width: viewImageCMNDBehind.frame.size.height * 2/3, height: viewImageCMNDBehind.frame.size.height * 2/3))
        viewMSDTButton.image = UIImage(named:"AddImage")
        viewMSDTButton.contentMode = .scaleAspectFit
        viewImageCMNDBehind.addSubview(viewMSDTButton)
        
        let lbMSDTButton = UILabel(frame: CGRect(x: 0, y: viewMSDTButton.frame.size.height + viewMSDTButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageCMNDBehind.frame.size.height/3))
        lbMSDTButton.textAlignment = .center
        lbMSDTButton.textColor = UIColor(netHex:0xc2c2c2)
        lbMSDTButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbMSDTButton.text = "Thêm hình ảnh"
        viewImageCMNDBehind.addSubview(lbMSDTButton)
        viewInfoCMNDBehind.frame.size.height = viewImageCMNDBehind.frame.size.height + viewImageCMNDBehind.frame.origin.y
        
        let tapShowMSDT = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDBehind))
        viewImageCMNDBehind.isUserInteractionEnabled = true
        viewImageCMNDBehind.addGestureRecognizer(tapShowMSDT)
        
        //Anh suon trai may
        viewInfoLeftDevide = UIView(frame: CGRect(x:0,y:viewInfoCMNDBehind.frame.size.height + viewInfoCMNDBehind.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoLeftDevide.clipsToBounds = true
        viewUpload.addSubview(viewInfoLeftDevide)
        
        let lbTextLeftDevide = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextLeftDevide.textAlignment = .left
        lbTextLeftDevide.textColor = UIColor.black
        lbTextLeftDevide.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextLeftDevide.text = "Ảnh sườn trái máy"
        viewInfoLeftDevide.addSubview(lbTextLeftDevide)
        
        viewImageLeftDevide = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextLeftDevide.frame.origin.y + lbTextLeftDevide.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageLeftDevide.layer.borderWidth = 0.5
        viewImageLeftDevide.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageLeftDevide.layer.cornerRadius = 3.0
        viewInfoLeftDevide.addSubview(viewImageLeftDevide)
        
        let viewLeftDevideButton = UIImageView(frame: CGRect(x: viewImageLeftDevide.frame.size.width/2 - (viewImageLeftDevide.frame.size.height * 2/3)/2, y: 0, width: viewImageLeftDevide.frame.size.height * 2/3, height: viewImageLeftDevide.frame.size.height * 2/3))
        viewLeftDevideButton.image = UIImage(named:"AddImage")
        viewLeftDevideButton.contentMode = .scaleAspectFit
        viewImageLeftDevide.addSubview(viewLeftDevideButton)
        
        let lbLeftDevideButton = UILabel(frame: CGRect(x: 0, y: viewLeftDevideButton.frame.size.height + viewLeftDevideButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageLeftDevide.frame.size.height/3))
        lbLeftDevideButton.textAlignment = .center
        lbLeftDevideButton.textColor = UIColor(netHex:0xc2c2c2)
        lbLeftDevideButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLeftDevideButton.text = "Thêm hình ảnh"
        viewImageLeftDevide.addSubview(lbLeftDevideButton)
        viewInfoLeftDevide.frame.size.height = viewImageLeftDevide.frame.size.height + viewImageLeftDevide.frame.origin.y
        
        let tapShowLeftDevide = UITapGestureRecognizer(target: self, action: #selector(self.tapShowLeftDevide))
        viewImageLeftDevide.isUserInteractionEnabled = true
        viewImageLeftDevide.addGestureRecognizer(tapShowLeftDevide)
        //Anh suon phai may
        viewInfoRightDevide = UIView(frame: CGRect(x:0,y:viewInfoLeftDevide.frame.size.height + viewInfoLeftDevide.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoRightDevide.clipsToBounds = true
        viewUpload.addSubview(viewInfoRightDevide)
        
        let lbTextRightDevide = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextRightDevide.textAlignment = .left
        lbTextRightDevide.textColor = UIColor.black
        lbTextRightDevide.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextRightDevide.text = "Ảnh sườn phải máy"
        viewInfoRightDevide.addSubview(lbTextRightDevide)
        
        viewImageRightDevide = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextRightDevide.frame.origin.y + lbTextRightDevide.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageRightDevide.layer.borderWidth = 0.5
        viewImageRightDevide.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageRightDevide.layer.cornerRadius = 3.0
        viewInfoRightDevide.addSubview(viewImageRightDevide)
        
        let viewRightDevideButton = UIImageView(frame: CGRect(x: viewImageLeftDevide.frame.size.width/2 - (viewImageLeftDevide.frame.size.height * 2/3)/2, y: 0, width: viewImageLeftDevide.frame.size.height * 2/3, height: viewImageLeftDevide.frame.size.height * 2/3))
        viewRightDevideButton.image = UIImage(named:"AddImage")
        viewRightDevideButton.contentMode = .scaleAspectFit
        viewImageRightDevide.addSubview(viewRightDevideButton)
        
        let lbRightDevideButton = UILabel(frame: CGRect(x: 0, y: viewRightDevideButton.frame.size.height + viewRightDevideButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageRightDevide.frame.size.height/3))
        lbRightDevideButton.textAlignment = .center
        lbRightDevideButton.textColor = UIColor(netHex:0xc2c2c2)
        lbRightDevideButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbRightDevideButton.text = "Thêm hình ảnh"
        viewImageRightDevide.addSubview(lbRightDevideButton)
        viewInfoRightDevide.frame.size.height = viewImageRightDevide.frame.size.height + viewImageRightDevide.frame.origin.y
        
        let tapShowRightDevide = UITapGestureRecognizer(target: self, action: #selector(self.tapShowRightDevide))
        viewImageRightDevide.isUserInteractionEnabled = true
        viewImageRightDevide.addGestureRecognizer(tapShowRightDevide)
        //vi tri moc tray xuoc
        viewInfoBroken = UIView(frame: CGRect(x:0,y:viewInfoRightDevide.frame.size.height + viewInfoRightDevide.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoBroken.clipsToBounds = true
        viewUpload.addSubview(viewInfoBroken)
        
        let lbTextBroken = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextBroken.textAlignment = .left
        lbTextBroken.textColor = UIColor.black
        lbTextBroken.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextBroken.text = "Vị trí móp trầy xước"
        viewInfoBroken.addSubview(lbTextBroken)
        
        viewImageBroken = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextBroken.frame.origin.y + lbTextBroken.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageBroken.layer.borderWidth = 0.5
        viewImageBroken.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageBroken.layer.cornerRadius = 3.0
        viewInfoBroken.addSubview(viewImageBroken)
        
        let viewBrokenButton = UIImageView(frame: CGRect(x: viewImageBroken.frame.size.width/2 - (viewImageBroken.frame.size.height * 2/3)/2, y: 0, width: viewImageBroken.frame.size.height * 2/3, height: viewImageBroken.frame.size.height * 2/3))
        viewBrokenButton.image = UIImage(named:"AddImage")
        viewBrokenButton.contentMode = .scaleAspectFit
        viewImageBroken.addSubview(viewBrokenButton)
        
        let lbBrokenButton = UILabel(frame: CGRect(x: 0, y: viewBrokenButton.frame.size.height + viewBrokenButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageBroken.frame.size.height/3))
        lbBrokenButton.textAlignment = .center
        lbBrokenButton.textColor = UIColor(netHex:0xc2c2c2)
        lbBrokenButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbBrokenButton.text = "Thêm hình ảnh"
        viewImageBroken.addSubview(lbBrokenButton)
        viewInfoBroken.frame.size.height = viewImageBroken.frame.size.height + viewImageBroken.frame.origin.y
        
        let tapShowBroken = UITapGestureRecognizer(target: self, action: #selector(self.tapShowBroken))
        viewImageBroken.isUserInteractionEnabled = true
        viewImageBroken.addGestureRecognizer(tapShowBroken)
        //hinh anh bien ban ky
        viewInfoSignDoc = UIView(frame: CGRect(x:0,y:viewInfoBroken.frame.size.height + viewInfoBroken.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 0))
        viewInfoSignDoc.clipsToBounds = true
        viewUpload.addSubview(viewInfoSignDoc)
        
        let lbTextSignDoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSignDoc.textAlignment = .left
        lbTextSignDoc.textColor = UIColor.black
        lbTextSignDoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSignDoc.text = "Ảnh ký biên bản"
        viewInfoSignDoc.addSubview(lbTextSignDoc)
        
        viewImageSignDoc = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSignDoc.frame.origin.y + lbTextSignDoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSignDoc.layer.borderWidth = 0.5
        viewImageSignDoc.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSignDoc.layer.cornerRadius = 3.0
        viewInfoSignDoc.addSubview(viewImageSignDoc)
        
        let viewSignDocButton = UIImageView(frame: CGRect(x: viewImageSignDoc.frame.size.width/2 - (viewImageSignDoc.frame.size.height * 2/3)/2, y: 0, width: viewImageSignDoc.frame.size.height * 2/3, height: viewImageSignDoc.frame.size.height * 2/3))
        viewSignDocButton.image = UIImage(named:"AddImage")
        viewSignDocButton.contentMode = .scaleAspectFit
        viewImageSignDoc.addSubview(viewSignDocButton)
        
        let lbSignDocButton = UILabel(frame: CGRect(x: 0, y: viewSignDocButton.frame.size.height + viewSignDocButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSignDoc.frame.size.height/3))
        lbSignDocButton.textAlignment = .center
        lbSignDocButton.textColor = UIColor(netHex:0xc2c2c2)
        lbSignDocButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSignDocButton.text = "Thêm hình ảnh"
        viewImageSignDoc.addSubview(lbSignDocButton)
        viewInfoSignDoc.frame.size.height = viewImageSignDoc.frame.size.height + viewImageSignDoc.frame.origin.y
        viewInfoSignDoc.frame.size.height = 0
        let tapShowSignDoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSignDoc))
        viewImageSignDoc.isUserInteractionEnabled = true
        viewImageSignDoc.addGestureRecognizer(tapShowSignDoc)
        //anh chan dung kh
        viewInfoAvarta = UIView(frame: CGRect(x:0,y:viewInfoSignDoc.frame.size.height + viewInfoSignDoc.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoAvarta.clipsToBounds = true
        viewUpload.addSubview(viewInfoAvarta)
        
        let lbTextAvarta = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextAvarta.textAlignment = .left
        lbTextAvarta.textColor = UIColor.black
        lbTextAvarta.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextAvarta.text = "Ảnh chân dung khách hàng"
        viewInfoAvarta.addSubview(lbTextAvarta)
        
        viewImageAvarta = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextAvarta.frame.origin.y + lbTextAvarta.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageAvarta.layer.borderWidth = 0.5
        viewImageAvarta.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageAvarta.layer.cornerRadius = 3.0
        viewInfoAvarta.addSubview(viewImageAvarta)
        
        let viewAvartaButton = UIImageView(frame: CGRect(x: viewImageAvarta.frame.size.width/2 - (viewImageAvarta.frame.size.height * 2/3)/2, y: 0, width: viewImageAvarta.frame.size.height * 2/3, height: viewImageAvarta.frame.size.height * 2/3))
        viewAvartaButton.image = UIImage(named:"AddImage")
        viewAvartaButton.contentMode = .scaleAspectFit
        viewImageAvarta.addSubview(viewAvartaButton)
        
        let lbAvartaButton = UILabel(frame: CGRect(x: 0, y: viewAvartaButton.frame.size.height + viewAvartaButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSignDoc.frame.size.height/3))
        lbAvartaButton.textAlignment = .center
        lbAvartaButton.textColor = UIColor(netHex:0xc2c2c2)
        lbAvartaButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbAvartaButton.text = "Thêm hình ảnh"
        viewImageAvarta.addSubview(lbAvartaButton)
        viewInfoAvarta.frame.size.height = viewImageAvarta.frame.size.height + viewImageAvarta.frame.origin.y
        
        let tapShowAvarta = UITapGestureRecognizer(target: self, action: #selector(self.tapShowAvarta))
        viewImageAvarta.isUserInteractionEnabled = true
        viewImageAvarta.addGestureRecognizer(tapShowAvarta)
        //---anh niem phong hop
        viewInfoNP = UIView(frame: CGRect(x:0,y:viewInfoAvarta.frame.size.height + viewInfoAvarta.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoNP.clipsToBounds = true
        viewUpload.addSubview(viewInfoNP)
        
        let lbTextNP = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextNP.textAlignment = .left
        lbTextNP.textColor = UIColor.black
        lbTextNP.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextNP.text = "Ảnh tem niêm phong hộp"
        viewInfoNP.addSubview(lbTextNP)
        
        viewImageNP = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextNP.frame.origin.y + lbTextNP.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageNP.layer.borderWidth = 0.5
        viewImageNP.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageNP.layer.cornerRadius = 3.0
        viewInfoNP.addSubview(viewImageNP)
        
        let viewNPButton = UIImageView(frame: CGRect(x: viewImageNP.frame.size.width/2 - (viewImageNP.frame.size.height * 2/3)/2, y: 0, width: viewImageNP.frame.size.height * 2/3, height: viewImageNP.frame.size.height * 2/3))
        viewNPButton.image = UIImage(named:"AddImage")
        viewNPButton.contentMode = .scaleAspectFit
        viewImageNP.addSubview(viewNPButton)
        
        let lbNPButton = UILabel(frame: CGRect(x: 0, y: viewNPButton.frame.size.height + viewNPButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageNP.frame.size.height/3))
        lbNPButton.textAlignment = .center
        lbNPButton.textColor = UIColor(netHex:0xc2c2c2)
        lbNPButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbNPButton.text = "Thêm hình ảnh"
        viewImageNP.addSubview(lbNPButton)
        viewInfoNP.frame.size.height = viewImageNP.frame.size.height + viewImageNP.frame.origin.y
        
        let tapShowNP = UITapGestureRecognizer(target: self, action: #selector(self.tapShowNP))
        viewImageNP.isUserInteractionEnabled = true
        viewImageNP.addGestureRecognizer(tapShowNP)
        
        viewUpload.frame.size.height = viewInfoNP.frame.size.height  + viewInfoNP.frame.origin.y + Common.Size(s:10)
        viewMore.frame.size.height = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:10)
        heightUploadView = viewMore.frame.size.height
        viewMore.frame.size.height = 0
        
        viewFooter = UIView()
        viewFooter.frame = CGRect(x: 0, y: viewMore.frame.size.height + viewMore.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewFooter.backgroundColor = UIColor.white
        
        scrollView.addSubview(viewFooter)
        
        lblPrintConfirmText = UILabel(frame: CGRect(x: Common.Size(s:10), y:  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPrintConfirmText.textAlignment = .left
        lblPrintConfirmText.textColor = UIColor.red
        lblPrintConfirmText.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPrintConfirmText.text = "Bạn vui lòng về POS để in xác nhận cho khách và thu 100.000Đ lệ phí nhé"
        viewFooter.addSubview(lblPrintConfirmText)
        
        let lblPrintConfirmTextHeight:CGFloat = lblPrintConfirmText.optimalHeight < Common.Size(s: 14) ? Common.Size(s: 14) : lblPrintConfirmText.optimalHeight
        lblPrintConfirmText.numberOfLines = 0
        lblPrintConfirmText.frame = CGRect(x: lblPrintConfirmText.frame.origin.x, y: lblPrintConfirmText.frame.origin.y, width: lblPrintConfirmText.frame.width, height: lblPrintConfirmTextHeight)
        
        btConfirm = UIButton()
        btConfirm.frame = CGRect(x: Common.Size(s:10), y:lblPrintConfirmText.frame.size.height + lblPrintConfirmText.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width  - Common.Size(s:30), height: Common.Size(s:40) * 1.2)
        btConfirm.backgroundColor = UIColor(netHex:0x00955E)
        btConfirm.setTitle("Hoàn tất", for: .normal)
        btConfirm.addTarget(self, action: #selector(actionComplete), for: .touchUpInside)
        btConfirm.layer.borderWidth = 0.5
        btConfirm.layer.borderColor = UIColor.white.cgColor
        btConfirm.layer.cornerRadius = 3
        viewFooter.addSubview(btConfirm)
        viewFooter.frame.size.height = btConfirm.frame.size.height + btConfirm.frame.origin.y + Common.Size(s:10)
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewFooter.frame.origin.y + viewFooter.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        
        MPOSAPIManager.mpos_FRT_SP_SK_load_tinh(handler: { (results, err) in
            if(results.count > 0){
                self.lstProvince = results
                var list:[String] = []
                for item in results {
                    list.append(item.Text)
                }
                self.tfPlaceCMND.filterStrings(list)
            }else{
                
            }
        })
//        if(self.detailRPRcheck!.is_rightphone == "N"){
//            self.selectType = 1
//
//            radioResistry.isSelected = true
//            radionNotResgistry.isSelected = false
//           radionNotResgistry.isUserInteractionEnabled = false
//
//            viewMore.frame.size.height = heightUploadView
//            viewFooter.frame.origin.y = viewMore.frame.size.height + viewMore.frame.origin.y + Common.Size(s:10)
//            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewFooter.frame.origin.y + viewFooter.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30))
//        }
        self.selectType = 1
        
        radioResistry.isSelected = true
        radionNotResgistry.isSelected = false
        radionNotResgistry.isUserInteractionEnabled = false
        
        viewMore.frame.size.height = heightUploadView
        viewFooter.frame.origin.y = viewMore.frame.size.height + viewMore.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewFooter.frame.origin.y + viewFooter.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30))
        
    }
    @objc func backButton(){
        Cache.RP_cmndNumber = tfCMND.text ?? ""
        Cache.RP_ngayCapCMND = tfDateCMND.text ?? ""
        Cache.RP_noiCapCMND = tfPlaceCMND.text ?? ""
        Cache.RP_cmndAddress = tfAddressCMND.text ?? ""
        Cache.RP_addressHome = tfHome.text ?? ""
        Cache.RP_phoneNumber = tfHomePhone.text ?? ""
        Cache.RP_deviceStatus = tfDevideStatus.text ?? ""
        Cache.RP_accessoriesStatus = tfAccessoriesDescription.text ?? ""
        Cache.RP_otpSMS = tfOTP.text ?? ""
        Cache.RP_suggestedPrice = tfPriceRecomment.text ?? ""
        
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func actionOTP(){
        if(self.tfCustomerPhone.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập SĐT KH !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                self.tfCustomerPhone.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gửi mã OTP ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_FRT_SP_SK_Send_OTP(sdt: "\(self.tfCustomerPhone.text!)",docentry:"\(self.itemRPOnProgress!.docentry)") { (p_status,p_message, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(p_status == 1){
                        let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        })
                        self.present(alert, animated: true)
                    }
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc func actionComplete(){
        if(self.tfCustomerName.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập họ tên KH !", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//                self.tfCustomerName.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfCustomerPhone.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập SĐT KH !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//                self.tfCustomerPhone.becomeFirstResponder()
            })
            self.present(alert, animated: true)
            return
        }
        
        if(self.selectType == 0){
            //if check ko dang ky ban
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra giao dịch..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            MPOSAPIManager.mpos_FRT_SP_SK_confirm_rcheck(name: "\(self.tfCustomerName.text!)",mail:"\(self.tfCustomerMail.text!)",phone:"\(self.tfCustomerPhone.text!)",docentry:"\(self.itemRPOnProgress!.docentry)") { (p_status,p_message, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        if(p_status == 1){
                            let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//                                Cache.RP_cmndNumber = ""
//                                Cache.RP_ngayCapCMND = ""
//                                Cache.RP_noiCapCMND = ""
//                                Cache.RP_cmndAddress = ""
//                                Cache.RP_addressHome = ""
//                                Cache.RP_phoneNumber = ""
//                                Cache.RP_deviceStatus = ""
//                                Cache.RP_accessoriesStatus = ""
//                                Cache.RP_otpSMS = ""
//                                Cache.RP_suggestedPrice = ""
                                
                                self.navigationController?.popViewController(animated: true)
                            })
                            self.present(alert, animated: true)
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            })
                            self.present(alert, animated: true)
                        }
                        
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        })
                        self.present(alert, animated: true)
                    }
                }
            }
            
        }else{
            //if check dang ky ban
            guard let cmndNumber = self.tfCMND.text, !cmndNumber.isEmpty else {
                let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập CMND KH !", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                })
                self.present(alert, animated: true)
                return
            }
            
            if (cmndNumber.count != 9) && (cmndNumber.count != 12) {
                let alert = UIAlertController(title: "Thông báo", message: "CMND KH không hợp lệ!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                })
                self.present(alert, animated: true)
                return
            }
            
            if(self.tfPlaceCMND.text! == "" && self.selectProvince == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Chưa chọn nơi cấp CMND KH !", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                })
                self.present(alert, animated: true)
                return
            }
            if(self.tfDateCMND.text! == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập ngày cấp CMND KH !", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                })
                self.present(alert, animated: true)
                return
            }
            if(self.tfAddressCMND.text! == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập địa chỉ trên CMND !", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                })
                self.present(alert, animated: true)
                return
            }
            if(self.tfHome.text! == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập địa chỉ hiện nay !", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                })
                self.present(alert, animated: true)
                return
            }
            
//            guard let sdt = self.tfHomePhone.text, !sdt.isEmpty else {
//                let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập SĐT nhà KH !", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//                })
//                self.present(alert, animated: true)
//                return
//            }
            
            if(self.tfHomePhone.text! != ""){
                if (self.tfHomePhone.text!.hasPrefix("01")) || (self.tfHomePhone.text!.count != 10) {
                    let alert = UIAlertController(title: "Thông báo", message: "SĐT nhà KH không hợp lệ!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    })
                    self.present(alert, animated: true)
                    return
                }
            }
    
            
            
            if(self.tfDevideStatus.text! == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập mô tả tình trạng máy !", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                })
                self.present(alert, animated: true)
                return
            }
            if(self.tfAccessoriesDescription.text! == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập mô tả phụ kiện !", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                })
                self.present(alert, animated: true)
                return
            }
            if(self.tfOTP.text! == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập OTP SMS !", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                })
                self.present(alert, animated: true)
                return
            }
            if(self.tfPriceRecomment.text! == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Chưa nhập giá bán đề xuất !", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                })
                self.present(alert, animated: true)
                return
            }
            
            if (self.urlFrontCMND.isEmpty) || (self.urlBehindCMND.isEmpty) || (self.urlLeft.isEmpty) || (self.urlRight.isEmpty) || (self.urlBroken.isEmpty)  || (self.urlAvarta.isEmpty) || (self.urlNP.isEmpty) {
                
                let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa cung cấp đủ hình ảnh !", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                })
                self.present(alert, animated: true)
                return
            }
            
            let xml = "<data><item CMND_mattruoc=\"\(self.urlFrontCMND)\" CMND_matsau=\"\(self.urlBehindCMND)\" anh_trai_dt=\"\(self.urlLeft)\"  anh_phai_dt =\"\(self.urlRight)\" anh_hu =\"\(self.urlBroken)\" anh_chan_dung =\"\(self.urlAvarta)\" anh_bien_ban =\"\(self.urlSign)\" anh_niem_phong=\"\(self.urlNP)\"/></data>"
            
            let money = tfPriceRecomment.text!.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra giao dịch..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            MPOSAPIManager.mpos_FRT_SP_SK_Rcheck_insert(name:"\(self.tfCustomerName.text!)",mail:"\(self.tfCustomerMail.text!)",phone:"\(self.tfCustomerPhone.text!)",docentry:"\(self.itemRPOnProgress!.docentry)",price:"\(money)",xml_pic:xml,mota_dienthoai:"\(self.tfDevideStatus.text!)",mota_phukien:"\(self.tfAccessoriesDescription.text!)",CMND:"\(self.tfCMND.text!)",NgayCapCMND:"\(self.tfDateCMND.text!)",NoiCapCMND: "\(self.selectProvince)",DiaChiThuongTru:"\(self.tfAddressCMND.text!)",DiaChiHienTai:"\(self.tfHome.text!)",SDT_home:"\(self.tfHomePhone.text!)",OTP:"\(self.tfOTP.text!)",imei:"\(self.detailRPRcheck!.IMEI)") { (p_status,p_message, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        if(p_status == 1){
                            let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                Cache.RP_cmndNumber = ""
                                Cache.RP_ngayCapCMND = ""
                                Cache.RP_noiCapCMND = ""
                                Cache.RP_cmndAddress = ""
                                Cache.RP_addressHome = ""
                                Cache.RP_phoneNumber = ""
                                Cache.RP_deviceStatus = ""
                                Cache.RP_accessoriesStatus = ""
                                Cache.RP_otpSMS = ""
                                Cache.RP_suggestedPrice = ""
                                
                                _ = self.navigationController?.popToRootViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                                let nc = NotificationCenter.default
                                nc.post(name: Notification.Name("rightPhoneTabNotification"), object: nil)
                            })
                            self.present(alert, animated: true)
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            })
                            self.present(alert, animated: true)
                        }
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        })
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
    fileprivate func createRadioButtonLoaiThueBao(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:13));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(RegisterRightPhoneViewController.logSelectedButtonLoaiThueBao), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonLoaiThueBao(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radionNotResgistry.isSelected = false
            radioResistry.isSelected = false
            switch temp {
            case "Không đăng ký bán":
                self.selectType = 0
                
                
                radionNotResgistry.isSelected = true
                viewMore.frame.size.height = 0
                viewFooter.frame.origin.y = viewMore.frame.size.height + viewMore.frame.origin.y + Common.Size(s:10)
                scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewFooter.frame.origin.y + viewFooter.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30))
                
                break
            case "Đăng ký bán":
                self.selectType = 1
                
                radioResistry.isSelected = true
                
                viewMore.frame.size.height = heightUploadView
                viewFooter.frame.origin.y = viewMore.frame.size.height + viewMore.frame.origin.y + Common.Size(s:10)
                scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewFooter.frame.origin.y + viewFooter.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30))
                break
            default:
                
                break
            }
        }
    }
    
    
    func uploadImageV2(type:String,image:UIImage){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang upload hình ảnh..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        
        let nc = NotificationCenter.default
        
        if let imageData:NSData = image.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
            let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
            
            MPOSAPIManager.mpos_FRT_Image_SKTelink(Base64:"\(strBase64)",docentry: self.itemRPOnProgress!.docentry,Type:"\(type)") { (result, err) in
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    
                    if(err.count <= 0){
                        if(type == "1"){
                            self.urlFrontCMND = result
                        }
                        if(type == "2"){
                            self.urlBehindCMND = result
                        }
                        if(type == "3"){
                            self.urlLeft = result
                        }
                        if(type == "4"){
                            self.urlRight = result
                        }
                        if(type == "5"){
                            self.urlBroken = result
                        }
                        if(type == "6"){
                            
                            self.urlAvarta = result
                        }
                        if(type == "7"){
                            self.urlSign = result
                        }
                        if(type == "8"){
                            self.urlNP = result
                        }
                  
                        
                        
                        
                    }else{
                        let title = "THÔNG BÁO(1)"
                        let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
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
    
    @objc func tapShowCMNDFront(sender:UITapGestureRecognizer) {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowCMNDBehind(sender:UITapGestureRecognizer) {
        self.posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowLeftDevide(sender:UITapGestureRecognizer) {
        self.posImageUpload = 3
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc func tapShowRightDevide(sender:UITapGestureRecognizer) {
        self.posImageUpload = 4
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowBroken(sender:UITapGestureRecognizer) {
        self.posImageUpload = 5
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowSignDoc(sender:UITapGestureRecognizer) {
         self.posImageUpload = 6
         self.thisIsTheFunctionWeAreCalling()
     }
    @objc func tapShowAvarta(sender:UITapGestureRecognizer) {
         self.posImageUpload = 7
         self.thisIsTheFunctionWeAreCalling()
     }
    @objc  func tapShowNP(sender:UITapGestureRecognizer) {
        self.posImageUpload = 8
        self.thisIsTheFunctionWeAreCalling()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if(textField == tfDateCMND){
               guard var number = textField.text else {
                   return true
               }
               // If user try to delete, remove the char manually
               if string == "" {
                   number.remove(at: number.index(number.startIndex, offsetBy: range.location))
               }
               // Remove all mask characters
               number = number.replacingOccurrences(of: "/", with: "")
               number = number.replacingOccurrences(of: "D", with: "")
               number = number.replacingOccurrences(of: "M", with: "")
               number = number.replacingOccurrences(of: "Y", with: "")
               
               // Set the position of the cursor
               var cursorPosition = number.count+1
               if string == "" {
                   //if it's delete, just take the position given by the delegate
                   cursorPosition = range.location
               } else {
                   // If not, take into account the slash
                   if cursorPosition > 2 && cursorPosition < 5 {
                       cursorPosition += 1
                   } else if cursorPosition > 4 {
                       cursorPosition += 2
                   }
               }
               // Stop editing if we have rich the max numbers
               if number.count == 8 { return false }
               // Readd all mask char
               number += string
               while number.count < 8 {
                   if number.count < 2 {
                       number += "D"
                   } else if number.count < 4 {
                       number += "M"
                   } else {
                       number += "Y"
                   }
               }
               number.insert("/", at: number.index(number.startIndex, offsetBy: 4))
               number.insert("/", at: number.index(number.startIndex, offsetBy: 2))
               
               // Some styling
               let enteredTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
               let maskTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
               
               let partOne = NSMutableAttributedString(string: String(number.prefix(cursorPosition)), attributes: enteredTextAttribute)
               let partTwo = NSMutableAttributedString(string: String(number.suffix(number.count-cursorPosition)), attributes: maskTextAttribute)
               
               let combination = NSMutableAttributedString()
               
               combination.append(partOne)
               combination.append(partTwo)
               
               textField.attributedText = combination
               textField.setCursor(position: cursorPosition)
               return false
               
            
           }
              return true
    
       }
       
       @objc func textFieldDidEndEditing(_ textField: UITextField) {
           if(textField == tfDateCMND){
               if let text = textField.text, text != "" && text != "DD/MM/YYYY" {
                   // Do something with your value
               } else {
                   textField.text = ""
               }
           }
        
       }
    
    @objc func textFieldDidChangeMoney(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s).\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
            self.tfPriceRecomment.text = str
        }else{
            textField.text = ""
            self.tfPriceRecomment.text = ""
        }
        
    }
    
    
    func imageCMNDFront(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDFront.frame.size.width / sca
        viewImageCMNDFront.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDFront  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDFront.frame.size.width, height: heightImage))
        imgViewCMNDFront.contentMode = .scaleAspectFit
        imgViewCMNDFront.image = image
        viewImageCMNDFront.addSubview(imgViewCMNDFront)
        viewImageCMNDFront.frame.size.height = imgViewCMNDFront.frame.size.height + imgViewCMNDFront.frame.origin.y
        viewInfoCMNDFront.frame.size.height = viewImageCMNDFront.frame.size.height + viewImageCMNDFront.frame.origin.y
        
        viewInfoCMNDBehind.frame.origin.y = viewInfoCMNDFront.frame.size.height + viewInfoCMNDFront.frame.origin.y + Common.Size(s:10)
        viewInfoLeftDevide.frame.origin.y = viewInfoCMNDBehind.frame.size.height + viewInfoCMNDBehind.frame.origin.y + Common.Size(s:10)
        viewInfoRightDevide.frame.origin.y = viewInfoLeftDevide.frame.size.height + viewInfoLeftDevide.frame.origin.y + Common.Size(s:10)
        viewInfoBroken.frame.origin.y = viewInfoRightDevide.frame.size.height + viewInfoRightDevide.frame.origin.y + Common.Size(s:10)
        viewInfoSignDoc.frame.origin.y = viewInfoBroken.frame.size.height + viewInfoBroken.frame.origin.y + Common.Size(s: 10)
        viewInfoAvarta.frame.origin.y = viewInfoSignDoc.frame.size.height + viewInfoSignDoc.frame.origin.y + Common.Size(s: 10)
        viewInfoNP.frame.origin.y = viewInfoAvarta.frame.size.height + viewInfoAvarta.frame.origin.y + Common.Size(s:10)
        
        
        viewUpload.frame.size.height = viewInfoNP.frame.size.height + viewInfoNP.frame.origin.y
        viewMore.frame.size.height = viewUpload.frame.size.height + viewUpload.frame.origin.y
        viewFooter.frame.origin.y = viewMore.frame.size.height + viewMore.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewFooter.frame.origin.y + viewFooter.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "1", image: self.imgViewCMNDFront.image!)
            
        }
        
    }
    func imageCMNDBehind(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDBehind.frame.size.width / sca
        viewImageCMNDBehind.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDBehind  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDBehind.frame.size.width, height: heightImage))
        imgViewCMNDBehind.contentMode = .scaleAspectFit
        imgViewCMNDBehind.image = image
        viewImageCMNDBehind.addSubview(imgViewCMNDBehind)
        viewImageCMNDBehind.frame.size.height = imgViewCMNDBehind.frame.size.height + imgViewCMNDBehind.frame.origin.y
        viewInfoCMNDBehind.frame.size.height = viewImageCMNDBehind.frame.size.height + viewImageCMNDBehind.frame.origin.y
        
     
        viewInfoLeftDevide.frame.origin.y = viewInfoCMNDBehind.frame.size.height + viewInfoCMNDBehind.frame.origin.y + Common.Size(s:10)
        viewInfoRightDevide.frame.origin.y = viewInfoLeftDevide.frame.size.height + viewInfoLeftDevide.frame.origin.y + Common.Size(s:10)
        viewInfoBroken.frame.origin.y = viewInfoRightDevide.frame.size.height + viewInfoRightDevide.frame.origin.y + Common.Size(s:10)
        viewInfoSignDoc.frame.origin.y = viewInfoBroken.frame.size.height + viewInfoBroken.frame.origin.y + Common.Size(s: 10)
        viewInfoAvarta.frame.origin.y = viewInfoSignDoc.frame.size.height + viewInfoSignDoc.frame.origin.y + Common.Size(s: 10)
        viewInfoNP.frame.origin.y = viewInfoAvarta.frame.size.height + viewInfoAvarta.frame.origin.y + Common.Size(s:10)
        
        
        viewUpload.frame.size.height = viewInfoNP.frame.size.height + viewInfoNP.frame.origin.y
        viewMore.frame.size.height = viewUpload.frame.size.height + viewUpload.frame.origin.y
        
        viewFooter.frame.origin.y = viewMore.frame.size.height + viewMore.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewFooter.frame.origin.y + viewFooter.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
        
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "2", image: self.imgViewCMNDBehind.image!)
            
        }
        
    }
    func imageLeftDevide(image:UIImage){
         let sca:CGFloat = image.size.width / image.size.height
         let heightImage:CGFloat = viewImageLeftDevide.frame.size.width / sca
         viewImageLeftDevide.subviews.forEach { $0.removeFromSuperview() }
         imgViewLeftDevide  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageLeftDevide.frame.size.width, height: heightImage))
         imgViewLeftDevide.contentMode = .scaleAspectFit
         imgViewLeftDevide.image = image
         viewImageLeftDevide.addSubview(imgViewLeftDevide)
         viewImageLeftDevide.frame.size.height = imgViewLeftDevide.frame.size.height + imgViewLeftDevide.frame.origin.y
         viewInfoLeftDevide.frame.size.height = viewImageLeftDevide.frame.size.height + viewImageLeftDevide.frame.origin.y
         
     viewInfoRightDevide.frame.origin.y = viewInfoLeftDevide.frame.size.height + viewInfoLeftDevide.frame.origin.y + Common.Size(s:10)
       viewInfoBroken.frame.origin.y = viewInfoRightDevide.frame.size.height + viewInfoRightDevide.frame.origin.y + Common.Size(s:10)
       viewInfoSignDoc.frame.origin.y = viewInfoBroken.frame.size.height + viewInfoBroken.frame.origin.y + Common.Size(s: 10)
       viewInfoAvarta.frame.origin.y = viewInfoSignDoc.frame.size.height + viewInfoSignDoc.frame.origin.y + Common.Size(s: 10)
       viewInfoNP.frame.origin.y = viewInfoAvarta.frame.size.height + viewInfoAvarta.frame.origin.y + Common.Size(s:10)
         
         
         viewUpload.frame.size.height = viewInfoNP.frame.size.height + viewInfoNP.frame.origin.y
         viewMore.frame.size.height = viewUpload.frame.size.height + viewUpload.frame.origin.y
         
         viewFooter.frame.origin.y = viewMore.frame.size.height + viewMore.frame.origin.y + Common.Size(s:10)
         scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewFooter.frame.origin.y + viewFooter.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
         
         
         let when = DispatchTime.now() + 0.3
         DispatchQueue.main.asyncAfter(deadline: when) {
             self.uploadImageV2(type: "3", image: self.imgViewLeftDevide.image!)
             
         }
         
     }
    func imageRightDevide(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageRightDevide.frame.size.width / sca
        viewImageRightDevide.subviews.forEach { $0.removeFromSuperview() }
        imgViewRightDevide  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageRightDevide.frame.size.width, height: heightImage))
        imgViewRightDevide.contentMode = .scaleAspectFit
        imgViewRightDevide.image = image
        viewImageRightDevide.addSubview(imgViewRightDevide)
        viewImageRightDevide.frame.size.height = imgViewRightDevide.frame.size.height + imgViewRightDevide.frame.origin.y
        viewInfoRightDevide.frame.size.height = viewImageRightDevide.frame.size.height + viewImageRightDevide.frame.origin.y
        
        
        viewInfoBroken.frame.origin.y = viewInfoRightDevide.frame.size.height + viewInfoRightDevide.frame.origin.y + Common.Size(s:10)
              viewInfoSignDoc.frame.origin.y = viewInfoBroken.frame.size.height + viewInfoBroken.frame.origin.y + Common.Size(s: 10)
              viewInfoAvarta.frame.origin.y = viewInfoSignDoc.frame.size.height + viewInfoSignDoc.frame.origin.y + Common.Size(s: 10)
              viewInfoNP.frame.origin.y = viewInfoAvarta.frame.size.height + viewInfoAvarta.frame.origin.y + Common.Size(s:10)
        
        
        viewUpload.frame.size.height = viewInfoNP.frame.size.height + viewInfoNP.frame.origin.y
        viewMore.frame.size.height = viewUpload.frame.size.height + viewUpload.frame.origin.y
        
        viewFooter.frame.origin.y = viewMore.frame.size.height + viewMore.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewFooter.frame.origin.y + viewFooter.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
        
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "4", image: self.imgViewRightDevide.image!)
            
        }
        
    }
    
    func imageBroken(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageLeftDevide.frame.size.width / sca
        viewImageBroken.subviews.forEach { $0.removeFromSuperview() }
        imgViewBroken  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageBroken.frame.size.width, height: heightImage))
        imgViewBroken.contentMode = .scaleAspectFit
        imgViewBroken.image = image
        viewImageBroken.addSubview(imgViewBroken)
        viewImageBroken.frame.size.height = imgViewBroken.frame.size.height + imgViewBroken.frame.origin.y
        viewInfoBroken.frame.size.height = viewImageBroken.frame.size.height + viewImageBroken.frame.origin.y
        
        
     viewInfoSignDoc.frame.origin.y = viewInfoBroken.frame.size.height + viewInfoBroken.frame.origin.y + Common.Size(s: 10)
        viewInfoAvarta.frame.origin.y = viewInfoSignDoc.frame.size.height + viewInfoSignDoc.frame.origin.y + Common.Size(s: 10)
        viewInfoNP.frame.origin.y = viewInfoAvarta.frame.size.height + viewInfoAvarta.frame.origin.y + Common.Size(s:10)
        
        
        viewUpload.frame.size.height = viewInfoNP.frame.size.height + viewInfoNP.frame.origin.y
        viewMore.frame.size.height = viewUpload.frame.size.height + viewUpload.frame.origin.y
        
        viewFooter.frame.origin.y = viewMore.frame.size.height + viewMore.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewFooter.frame.origin.y + viewFooter.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
        
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "5", image: self.imgViewBroken.image!)
            
        }
        
    }
    
    func imageSignDoc(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSignDoc.frame.size.width / sca
        viewImageSignDoc.subviews.forEach { $0.removeFromSuperview() }
        imgViewSignDoc  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSignDoc.frame.size.width, height: heightImage))
        imgViewSignDoc.contentMode = .scaleAspectFit
        imgViewSignDoc.image = image
        viewImageSignDoc.addSubview(imgViewSignDoc)
        viewImageSignDoc.frame.size.height = imgViewSignDoc.frame.size.height + imgViewSignDoc.frame.origin.y
        viewInfoSignDoc.frame.size.height = viewImageSignDoc.frame.size.height + viewImageSignDoc.frame.origin.y
        
        
        viewInfoAvarta.frame.origin.y = viewInfoSignDoc.frame.size.height + viewInfoSignDoc.frame.origin.y + Common.Size(s: 10)
        viewInfoNP.frame.origin.y = viewInfoAvarta.frame.size.height + viewInfoAvarta.frame.origin.y + Common.Size(s:10)
        
        
        viewUpload.frame.size.height = viewInfoNP.frame.size.height + viewInfoNP.frame.origin.y
        viewMore.frame.size.height = viewUpload.frame.size.height + viewUpload.frame.origin.y
        
        viewFooter.frame.origin.y = viewMore.frame.size.height + viewMore.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewFooter.frame.origin.y + viewFooter.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
        
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "7", image: self.imgViewSignDoc.image!)
            
        }
        
    }
    func imageAvarta(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageAvarta.frame.size.width / sca
        viewImageAvarta.subviews.forEach { $0.removeFromSuperview() }
        imgViewAvarta  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageAvarta.frame.size.width, height: heightImage))
        imgViewAvarta.contentMode = .scaleAspectFit
        imgViewAvarta.image = image
        viewImageAvarta.addSubview(imgViewAvarta)
        viewImageAvarta.frame.size.height = imgViewAvarta.frame.size.height + imgViewAvarta.frame.origin.y
        viewInfoAvarta.frame.size.height = viewImageAvarta.frame.size.height + viewImageAvarta.frame.origin.y
        
        
        viewInfoNP.frame.origin.y = viewInfoAvarta.frame.size.height + viewInfoAvarta.frame.origin.y + Common.Size(s:10)
        
        
        viewUpload.frame.size.height = viewInfoNP.frame.size.height + viewInfoNP.frame.origin.y
        viewMore.frame.size.height = viewUpload.frame.size.height + viewUpload.frame.origin.y
        
        viewFooter.frame.origin.y = viewMore.frame.size.height + viewMore.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewFooter.frame.origin.y + viewFooter.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
        
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "6", image: self.imgViewAvarta.image!)
            
        }
        
    }
    
    func imageNP(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageNP.frame.size.width / sca
        viewImageNP.subviews.forEach { $0.removeFromSuperview() }
        imgViewNP  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageNP.frame.size.width, height: heightImage))
        imgViewNP.contentMode = .scaleAspectFit
        imgViewNP.image = image
        viewImageNP.addSubview(imgViewNP)
        viewImageNP.frame.size.height = imgViewNP.frame.size.height + imgViewNP.frame.origin.y
        viewInfoNP.frame.size.height = viewImageNP.frame.size.height + viewImageNP.frame.origin.y
        
        
        
        viewUpload.frame.size.height = viewInfoNP.frame.size.height + viewInfoNP.frame.origin.y
        viewMore.frame.size.height = viewUpload.frame.size.height + viewUpload.frame.origin.y
        viewFooter.frame.origin.y = viewMore.frame.size.height + viewMore.frame.origin.y + Common.Size(s:10)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewFooter.frame.origin.y + viewFooter.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:30))
        
        
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "8", image: self.imgViewNP.image!)
            
        }
    }
}
extension RegisterRightPhoneViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        //self.openCamera()
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
        
        if (self.posImageUpload == 1){
            self.imageCMNDFront(image: image)
        }else if (self.posImageUpload == 2){
            self.imageCMNDBehind(image: image)
        }else if(self.posImageUpload == 3){
            self.imageLeftDevide(image: image)
        }else if(self.posImageUpload == 4){
            self.imageRightDevide(image: image)
        }else if(self.posImageUpload == 5){
            self.imageBroken(image: image)
        }else if(self.posImageUpload == 6){
            self.imageSignDoc(image: image)
        }else if(self.posImageUpload == 7){
            self.imageAvarta(image: image)
        }else if(self.posImageUpload == 8){
            self.imageNP(image: image)
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
