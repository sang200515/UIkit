//
//  UpdateTransferMoneyViettelPayViewController.swift
//  fptshop
//
//  Created by tan on 6/27/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
//import EPSignature
class UpdateTransferMoneyViettelPayViewController: UIViewController,UITextFieldDelegate,EPSignatureDelegate {
    
    var scrollView:UIScrollView!
    var viewTTNC:UIView!
    var viewTTNN:UIView!
    var viewDiaChi:UIView!
    var viewTTCT:UIView!
    var viewRadioHTCT:UIView!
    var viewFee:UIView!
    
    var tfHoTenTTNC:UITextField!
    var tfPhoneTTNC:UITextField!
    var tfCMNDTTNC:UITextField!
    
    var tfHoTenTTNN:UITextField!
    var tfPhoneTTNN:UITextField!
    var tfCMNDTTNN:UITextField!
    var tfCode:UITextField!
    
    var tfMoney:UITextField!
    
    var tfDiaChi:UITextField!
    var tfTinhTP:SearchTextField!
    var tfQuanHuyen:SearchTextField!
    var tfPhuongXa:SearchTextField!
    
    var tfFee:UITextField!
    var tfTongTien:UITextField!
    
    var viewFacade: UIView!
    var imgViewFacade:UIImageView!
    var viewImages:UIView!
    var viewImage1:UIView!
    var imgViewImage1:UIImageView!
    var posImageUpload:Int = 0
    var imagePicker = UIImagePickerController()
    
    var label2:UILabel!
    var label3:UILabel!
    

    var typeNT :Int = -1
    var typeCT:Int = -1
    var btGetFee:UIButton!
    var lblHTCT:UILabel!
    var heightViewDiaChi:CGFloat = 0.0
    var heightViewRadio:CGFloat = 0.0
    var heightViewFee:CGFloat = 0.0
    var listProvices:[Province] = []
    var listDistricts:[District] = []
    var listPrecincts:[Precinct] = []
    
    var selectProvice:String = ""
    var selectDistrict:String = ""
    var selectPrecinct:String = ""
    
    var imgUpload1: UIImage!
    var imgUpload2: UIImage!
    var btUpdate:UIButton!
    
    var imgViewSignature: UIImageView!
    var viewImageSign:UIView!
    var viewSign:UIView!
    var transferDetail:TransferDetails?
    
    
    override func viewDidLoad() {
        self.title = "Cập nhật thông tin"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(UpdateTransferMoneyViettelPayViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN NGƯỜI CHUYỂN"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        viewTTNC = UIView()
        viewTTNC.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewTTNC.backgroundColor = UIColor.white
        scrollView.addSubview(viewTTNC)
        
        let lbHoTenTTNC = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHoTenTTNC.textAlignment = .left
        lbHoTenTTNC.textColor = UIColor.black
        lbHoTenTTNC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHoTenTTNC.text = "Họ tên"
        viewTTNC.addSubview(lbHoTenTTNC)
        
        tfHoTenTTNC = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbHoTenTTNC.frame.origin.y + lbHoTenTTNC.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfHoTenTTNC.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHoTenTTNC.borderStyle = UITextField.BorderStyle.roundedRect
        tfHoTenTTNC.autocorrectionType = UITextAutocorrectionType.no
        tfHoTenTTNC.keyboardType = UIKeyboardType.default
        tfHoTenTTNC.returnKeyType = UIReturnKeyType.done
        tfHoTenTTNC.clearButtonMode = UITextField.ViewMode.whileEditing
        tfHoTenTTNC.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHoTenTTNC.delegate = self
        tfHoTenTTNC.text = self.transferDetail!.sender_name
        viewTTNC.addSubview(tfHoTenTTNC)
        
        let lbTextPhoneTTNC = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfHoTenTTNC.frame.origin.y + tfHoTenTTNC.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhoneTTNC.textAlignment = .left
        lbTextPhoneTTNC.textColor = UIColor.black
        lbTextPhoneTTNC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhoneTTNC.text = "Số điện thoại"
        viewTTNC.addSubview(lbTextPhoneTTNC)
        
        tfPhoneTTNC = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhoneTTNC.frame.origin.y + lbTextPhoneTTNC.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfPhoneTTNC.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhoneTTNC.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhoneTTNC.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneTTNC.keyboardType = UIKeyboardType.numberPad
        tfPhoneTTNC.returnKeyType = UIReturnKeyType.done
        tfPhoneTTNC.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhoneTTNC.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneTTNC.delegate = self
        tfPhoneTTNC.text = self.transferDetail!.sender_msisdn
        viewTTNC.addSubview(tfPhoneTTNC)
        
        let lbCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhoneTTNC.frame.origin.y + tfPhoneTTNC.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbCMND.textAlignment = .left
        lbCMND.textColor = UIColor.black
        lbCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMND.text = "CMND/Căn Cước"
        viewTTNC.addSubview(lbCMND)
        
        tfCMNDTTNC = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbCMND.frame.origin.y + lbCMND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfCMNDTTNC.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMNDTTNC.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMNDTTNC.autocorrectionType = UITextAutocorrectionType.no
        tfCMNDTTNC.keyboardType = UIKeyboardType.numberPad
        tfCMNDTTNC.returnKeyType = UIReturnKeyType.done
        tfCMNDTTNC.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCMNDTTNC.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMNDTTNC.delegate = self
        tfCMNDTTNC.text = self.transferDetail!.sender_id_number
        viewTTNC.addSubview(tfCMNDTTNC)
        viewTTNC.frame.size.height = tfCMNDTTNC.frame.origin.y + tfCMNDTTNC.frame.size.height + Common.Size(s: 10)
        
//        viewFacade = UIView(frame: CGRect(x: 0, y: viewTTNC.frame.origin.y + viewTTNC.frame.size.height , width: scrollView.frame.size.width, height: 0))
//        viewFacade.clipsToBounds = true
//        viewFacade.backgroundColor = .white
//        scrollView.addSubview(viewFacade)
//
//        let lbTextFacade = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s:15), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
//        lbTextFacade.textAlignment = .left
//        lbTextFacade.textColor = UIColor.black
//        lbTextFacade.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbTextFacade.text = "Hình ảnh CMND"
//        lbTextFacade.sizeToFit()
//        viewFacade.addSubview(lbTextFacade)
//
//        imgViewFacade = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: lbTextFacade.frame.origin.y + lbTextFacade.frame.size.height + Common.Size(s:5), width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
//        imgViewFacade.image = UIImage(named:"CMNDmatrc")
//        imgViewFacade.contentMode = .scaleAspectFit
//        viewFacade.addSubview(imgViewFacade)
//        viewFacade.frame.size.height = imgViewFacade.frame.origin.y + imgViewFacade.frame.size.height
//
//        let tapShowFacade = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDT))
//        viewFacade.isUserInteractionEnabled = true
//        viewFacade.addGestureRecognizer(tapShowFacade)
//
//        viewImages = UIView(frame: CGRect(x: 0, y: viewFacade.frame.origin.y + viewFacade.frame.size.height , width: scrollView.frame.size.width, height: 0))
//        viewImages.clipsToBounds = true
//        viewImages.backgroundColor = .white
//        scrollView.addSubview(viewImages)
//
//        viewImage1 = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: 0))
//        viewImage1.clipsToBounds = true
//        viewImages.addSubview(viewImage1)
//
//
//        imgViewImage1 = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: Common.Size(s:10), width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
//        imgViewImage1.image = UIImage(named:"CMNDmatsau")
//        imgViewImage1.contentMode = .scaleAspectFit
//        viewImage1.addSubview(imgViewImage1)
//        viewImage1.frame.size.height = imgViewImage1.frame.origin.y + imgViewImage1.frame.size.height
//        viewImage1.tag = 2
//        let tapShowImage = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDS))
//        viewImage1.isUserInteractionEnabled = true
//        viewImage1.addGestureRecognizer(tapShowImage)
//        viewImages.frame.size.height = viewImage1.frame.origin.y + viewImage1.frame.size.height + Common.Size(s:10)
        
        label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTTNC.frame.origin.y + viewTTNC.frame.size.height , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "THÔNG TIN NGƯỜI NHẬN"
        
        label2.clipsToBounds = true
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
        viewTTNN = UIView()
        viewTTNN.frame = CGRect(x: 0, y:label2.frame.origin.y + label2.frame.size.height , width: scrollView.frame.size.width, height: 0)
        viewTTNN.backgroundColor = UIColor.white
        viewTTNN.clipsToBounds = true
        scrollView.addSubview(viewTTNN)
        
        
        let lbHoTenTTNN = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHoTenTTNN.textAlignment = .left
        lbHoTenTTNN.textColor = UIColor.black
        lbHoTenTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHoTenTTNN.text = "Họ tên"
        viewTTNN.addSubview(lbHoTenTTNN)
        
        tfHoTenTTNN = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbHoTenTTNN.frame.origin.y + lbHoTenTTNN.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfHoTenTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHoTenTTNN.borderStyle = UITextField.BorderStyle.roundedRect
        tfHoTenTTNN.autocorrectionType = UITextAutocorrectionType.no
        tfHoTenTTNN.keyboardType = UIKeyboardType.default
        tfHoTenTTNN.returnKeyType = UIReturnKeyType.done
        tfHoTenTTNN.clearButtonMode = UITextField.ViewMode.whileEditing
        tfHoTenTTNN.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHoTenTTNN.delegate = self
        tfHoTenTTNN.text = self.transferDetail!.receiver_name
        viewTTNN.addSubview(tfHoTenTTNN)
        
        let lbTextPhoneTTNN = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfHoTenTTNN.frame.origin.y + tfHoTenTTNN.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhoneTTNN.textAlignment = .left
        lbTextPhoneTTNN.textColor = UIColor.black
        lbTextPhoneTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhoneTTNN.text = "Số điện thoại"
        viewTTNN.addSubview(lbTextPhoneTTNN)
        
        tfPhoneTTNN = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhoneTTNN.frame.origin.y + lbTextPhoneTTNN.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfPhoneTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhoneTTNN.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhoneTTNN.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneTTNN.keyboardType = UIKeyboardType.numberPad
        tfPhoneTTNN.returnKeyType = UIReturnKeyType.done
        tfPhoneTTNN.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhoneTTNN.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneTTNN.delegate = self
        tfPhoneTTNN.text = self.transferDetail!.receiver_msisdn
        viewTTNN.addSubview(tfPhoneTTNN)
        
        let lbCMNDTTNN = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhoneTTNN.frame.origin.y + tfPhoneTTNN.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbCMNDTTNN.textAlignment = .left
        lbCMNDTTNN.textColor = UIColor.black
        lbCMNDTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTTNN.text = "CMND/Căn Cước"
        viewTTNN.addSubview(lbCMNDTTNN)
        
        tfCMNDTTNN = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbCMNDTTNN.frame.origin.y + lbCMNDTTNN.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfCMNDTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMNDTTNN.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMNDTTNN.autocorrectionType = UITextAutocorrectionType.no
        tfCMNDTTNN.keyboardType = UIKeyboardType.numberPad
        tfCMNDTTNN.returnKeyType = UIReturnKeyType.done
        tfCMNDTTNN.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCMNDTTNN.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMNDTTNN.delegate = self
        tfCMNDTTNN.text = self.transferDetail!.receiver_id_number
        viewTTNN.addSubview(tfCMNDTTNN)
        
        viewTTNN.frame.size.height = tfCMNDTTNN.frame.origin.y + tfCMNDTTNN.frame.size.height + Common.Size(s:10)
        
        viewDiaChi = UIView()
        viewDiaChi.frame = CGRect(x: 0, y: viewTTNN.frame.origin.y + viewTTNN.frame.size.height , width: scrollView.frame.size.width, height: 0)
        viewDiaChi.backgroundColor = UIColor.white
        viewDiaChi.clipsToBounds = true
        scrollView.addSubview(viewDiaChi)
        
        let lblThanhPho = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblThanhPho.textAlignment = .left
        lblThanhPho.textColor = UIColor.black
        lblThanhPho.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblThanhPho.text = "Thành Phố"
        viewDiaChi.addSubview(lblThanhPho)
        
        
        
        tfTinhTP = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblThanhPho.frame.origin.y + lblThanhPho.frame.size.height + Common.Size(s:10) , width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tfTinhTP.placeholder = "Vui lòng chọn Thành Phố"
        tfTinhTP.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTinhTP.borderStyle = UITextField.BorderStyle.roundedRect
        tfTinhTP.autocorrectionType = UITextAutocorrectionType.no
        tfTinhTP.keyboardType = UIKeyboardType.default
        tfTinhTP.returnKeyType = UIReturnKeyType.done
        tfTinhTP.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTinhTP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTinhTP.delegate = self
        viewDiaChi.addSubview(tfTinhTP)
        
        // Start visible - Default: false
        tfTinhTP.startVisible = true
        tfTinhTP.theme.bgColor = UIColor.white
        tfTinhTP.theme.fontColor = UIColor.black
        tfTinhTP.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTinhTP.theme.cellHeight = Common.Size(s:40)
        tfTinhTP.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        tfTinhTP.leftViewMode = UITextField.ViewMode.always
        
        
        tfTinhTP.itemSelectionHandler = { filteredResults, itemPosition in
            //Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfTinhTP.text = item.title
            
            self.selectDistrict = ""
            self.tfQuanHuyen.text = ""
            
            self.selectPrecinct = ""
            self.tfPhuongXa.text = ""
            self.listDistricts.removeAll()
            self.listPrecincts.removeAll()
            
            let obj =  self.listProvices.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectProvice = "\(obj)"
                MPOSAPIManager.GetDistricts(MaCodeTinh: "\(self.selectProvice)", NhaMang: "Viettel", handler: { (results, error) in
                    self.listDistricts = results
                    var listDistrictTemp:[String] = []
                    for item in results {
                        listDistrictTemp.append(item.Text)
                    }
                    self.tfQuanHuyen.filterStrings(listDistrictTemp)
                   // self.tfQuanHuyen.becomeFirstResponder()
                })
            }
        }
        
        let lblQuanHuyen = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfTinhTP.frame.origin.y + tfTinhTP.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblQuanHuyen.textAlignment = .left
        lblQuanHuyen.textColor = UIColor.black
        lblQuanHuyen.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblQuanHuyen.text = "Quận Huyện"
        viewDiaChi.addSubview(lblQuanHuyen)
        
        
        tfQuanHuyen = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblQuanHuyen.frame.origin.y + lblQuanHuyen.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tfQuanHuyen.placeholder = "Vui lòng chọn Quận Huyện"
        tfQuanHuyen.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfQuanHuyen.borderStyle = UITextField.BorderStyle.roundedRect
        tfQuanHuyen.autocorrectionType = UITextAutocorrectionType.no
        tfQuanHuyen.keyboardType = UIKeyboardType.default
        tfQuanHuyen.returnKeyType = UIReturnKeyType.done
        tfQuanHuyen.clearButtonMode = UITextField.ViewMode.whileEditing
        tfQuanHuyen.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfQuanHuyen.delegate = self
        viewDiaChi.addSubview(tfQuanHuyen)
        
        // Start visible - Default: false
        tfQuanHuyen.startVisible = true
        tfQuanHuyen.theme.bgColor = UIColor.white
        tfQuanHuyen.theme.fontColor = UIColor.black
        tfQuanHuyen.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfQuanHuyen.theme.cellHeight = Common.Size(s:40)
        tfQuanHuyen.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        tfQuanHuyen.leftViewMode = UITextField.ViewMode.always
        
        
        tfQuanHuyen.itemSelectionHandler = { filteredResults, itemPosition in
            //Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfQuanHuyen.text = item.title
            
            
            self.selectPrecinct = ""
            self.tfPhuongXa.text = ""
            
            self.listPrecincts.removeAll()
            
            let obj =  self.listDistricts.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectDistrict = "\(obj)"
                MPOSAPIManager.GetPrecincts(MaCodeHUyen:  "\(obj)", MaCodeTinh: "\(self.selectProvice)", NhaMang: "Viettel", handler: { (results, error) in
                    self.listPrecincts = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Text)
                    }
                    self.tfPhuongXa.filterStrings(list)
                   // self.tfPhuongXa.becomeFirstResponder()
                })
            }
        }
        
        let lblPhuongXa = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfQuanHuyen.frame.origin.y + tfQuanHuyen.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPhuongXa.textAlignment = .left
        lblPhuongXa.textColor = UIColor.black
        lblPhuongXa.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPhuongXa.text = "Phường Xã"
        viewDiaChi.addSubview(lblPhuongXa)
        
        tfPhuongXa = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblPhuongXa.frame.origin.y + lblPhuongXa.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tfPhuongXa.placeholder = "Vui lòng chọn Phường Xã"
        tfPhuongXa.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhuongXa.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhuongXa.autocorrectionType = UITextAutocorrectionType.no
        tfPhuongXa.keyboardType = UIKeyboardType.default
        tfPhuongXa.returnKeyType = UIReturnKeyType.done
        tfPhuongXa.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhuongXa.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhuongXa.delegate = self
        viewDiaChi.addSubview(tfPhuongXa)
        
        // Start visible - Default: false
        tfPhuongXa.startVisible = true
        tfPhuongXa.theme.bgColor = UIColor.white
        tfPhuongXa.theme.fontColor = UIColor.black
        tfPhuongXa.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhuongXa.theme.cellHeight = Common.Size(s:40)
        tfPhuongXa.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        tfPhuongXa.leftViewMode = UITextField.ViewMode.always
        
        
        tfPhuongXa.itemSelectionHandler = { filteredResults, itemPosition in
            //Just in case you need the item position
            
            let item = filteredResults[itemPosition]
            self.tfPhuongXa.text = item.title
            let obj =  self.listPrecincts.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectPrecinct = "\(obj)"
                self.tfDiaChi.becomeFirstResponder()
            }
        }
        
        let lblDiaChi = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhuongXa.frame.origin.y + tfPhuongXa.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblDiaChi.textAlignment = .left
        lblDiaChi.textColor = UIColor.black
        lblDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDiaChi.text = "Địa chỉ"
        viewDiaChi.addSubview(lblDiaChi)
        
        tfDiaChi = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblDiaChi.frame.origin.y + lblDiaChi.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDiaChi.borderStyle = UITextField.BorderStyle.roundedRect
        tfDiaChi.autocorrectionType = UITextAutocorrectionType.no
        tfDiaChi.keyboardType = UIKeyboardType.default
        tfDiaChi.returnKeyType = UIReturnKeyType.done
        tfDiaChi.clearButtonMode = UITextField.ViewMode.whileEditing
        tfDiaChi.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDiaChi.delegate = self
        tfDiaChi.text = self.transferDetail!.receiver_address
        viewDiaChi.addSubview(tfDiaChi)
        
        let lblCode = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfDiaChi.frame.origin.y + tfDiaChi.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblCode.textAlignment = .left
        lblCode.textColor = UIColor.black
        lblCode.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblCode.text = "Mã code (Mã nhận tiền)"
        viewDiaChi.addSubview(lblCode)
        
        tfCode = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblCode.frame.origin.y + lblCode.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfCode.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCode.borderStyle = UITextField.BorderStyle.roundedRect
        tfCode.autocorrectionType = UITextAutocorrectionType.no
        tfCode.keyboardType = UIKeyboardType.numberPad
        tfCode.returnKeyType = UIReturnKeyType.done
        tfCode.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCode.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCode.delegate = self
        viewDiaChi.addSubview(tfCode)
        
        
        viewDiaChi.frame.size.height = tfCode.frame.origin.y + tfCode.frame.size.height + Common.Size(s:10)
        heightViewDiaChi = viewDiaChi.frame.size.height
        
        //
//        viewSign = UIView(frame: CGRect(x: 0, y: viewDiaChi.frame.origin.y + viewDiaChi.frame.size.height, width: scrollView.frame.size.width , height: 0))
//        viewSign.clipsToBounds = true
//        viewSign.backgroundColor = .white
//        scrollView.addSubview(viewSign)
//
//        let lbTextSign = UILabel(frame: CGRect(x:  Common.Size(s:20), y: 0, width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: Common.Size(s:20)))
//        lbTextSign.textAlignment = .left
//        lbTextSign.textColor = UIColor(netHex:0x47B054)
//        lbTextSign.font = UIFont.systemFont(ofSize: Common.Size(s:18))
//        lbTextSign.text = "Chữ ký"
//        lbTextSign.sizeToFit()
//        viewSign.addSubview(lbTextSign)
//
//        viewImageSign = UIView(frame: CGRect(x: Common.Size(s:20), y: lbTextSign.frame.origin.y + lbTextSign.frame.size.height + Common.Size(s:5), width: viewSign.frame.size.width - Common.Size(s: 40), height: Common.Size(s:60)))
//        viewImageSign.layer.borderWidth = 0.5
//        viewImageSign.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
//        viewImageSign.layer.cornerRadius = 3.0
//        viewSign.addSubview(viewImageSign)
//
//        let VS23 = viewImageSign.frame.size.height * 2/3
//        let xViewVS  = viewImageSign.frame.size.width/2 - VS23/2
//        let viewSignButton = UIImageView(frame: CGRect(x: xViewVS, y: 0, width: viewImageSign.frame.size.height * 2/3, height: viewImageSign.frame.size.height * 2/3))
//        viewSignButton.image = UIImage(named:"Sign Up-50")
//        viewSignButton.contentMode = .scaleAspectFit
//        viewImageSign.addSubview(viewSignButton)
//
//        let lbSignButton = UILabel(frame: CGRect(x: 0, y: viewSignButton.frame.size.height + viewSignButton.frame.origin.y, width: viewImageSign.frame.size.width, height: viewImageSign.frame.size.height/3))
//        lbSignButton.textAlignment = .center
//        lbSignButton.textColor = UIColor(netHex:0xc2c2c2)
//        lbSignButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbSignButton.text = "Thêm chữ ký"
//        viewImageSign.addSubview(lbSignButton)
//
//        viewSign.frame.size.height = viewImageSign.frame.origin.y + viewImageSign.frame.size.height + Common.Size(s:10)
//
//        let tapShowSign = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSign))
//        viewSign.isUserInteractionEnabled = true
//        viewSign.addGestureRecognizer(tapShowSign)
        
        btGetFee = UIButton()
        btGetFee.frame = CGRect(x: Common.Size(s:15), y: viewDiaChi.frame.size.height + viewDiaChi.frame.origin.y  , width: tfDiaChi.frame.size.width, height: tfDiaChi.frame.size.height * 1.2)
        btGetFee.backgroundColor = UIColor(netHex:0x00955E)
        btGetFee.setTitle("Cập nhật", for: .normal)
        btGetFee.addTarget(self, action: #selector(actionGetInfo), for: .touchUpInside)
        btGetFee.layer.borderWidth = 0.5
        btGetFee.layer.borderColor = UIColor.white.cgColor
        btGetFee.layer.cornerRadius = 3
        scrollView.addSubview(btGetFee)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btGetFee.frame.origin.y + btGetFee.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:45))
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin  ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.GetProvinces(NhaMang: "Viettel") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listProvices = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Text)
                    }
                    self.tfTinhTP.filterStrings(list)
                    //
                    let obj =  self.listProvices.filter{ $0.Value == "\(self.transferDetail!.receiver_province)" }.first
                    if let obj1 = obj?.Text {
                        self.tfTinhTP.text = obj1
                        self.selectProvice = "\(obj!.Value)"
                        
                        MPOSAPIManager.GetDistricts(MaCodeTinh: "\(self.selectProvice)", NhaMang: "Viettel", handler: { (results, error) in
                            self.listDistricts.removeAll()
                            self.listDistricts = results
                            var listDistrictTemp:[String] = []
                            for item in results {
                                listDistrictTemp.append(item.Text)
                            }
                            self.tfQuanHuyen.filterStrings(listDistrictTemp)
                            
                            let objDistrict =  self.listDistricts.filter{ $0.Value == "\(self.transferDetail!.receiver_district)" }.first
                            if let objNameDistrict = objDistrict?.Text {
                                self.tfQuanHuyen.text = objNameDistrict
                                self.selectDistrict = "\(objDistrict!.Value)"
                                
                            }
                            
                            
                            MPOSAPIManager.GetPrecincts(MaCodeHUyen:  "\(self.selectDistrict)", MaCodeTinh: "\(self.selectProvice)", NhaMang: "Viettel", handler: { (resultsPhuongXa, error) in
                                self.listPrecincts.removeAll()
                                self.listPrecincts = resultsPhuongXa
                                var list:[String] = []
                                for item in resultsPhuongXa {
                                    list.append(item.Text)
                                }
                                self.tfPhuongXa.filterStrings(list)
                                
                                
                                let objPrecinct =  self.listPrecincts.filter{ $0.Value == "\(self.transferDetail!.receiver_precinct)" }.first
                                if let objNamePrecinct = objPrecinct?.Text {
                                    self.tfPhuongXa.text = objNamePrecinct
                                    self.selectPrecinct = "\(objPrecinct!.Value)"
                                    
                                }
                                
                                
                            })
                            
                        })
                        
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
    @objc func actionGetInfo(){
        if(self.tfHoTenTTNC.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập họ tên người chuyển !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfPhoneTTNC.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số điện thoại người chuyển !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        let phone = tfPhoneTTNC.text!
        if (phone.hasPrefix("01") && phone.count == 11){
            
        }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
            
        }else{
            let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại người chuyển tiền không hợp lệ!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfCMNDTTNC.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập CMND người chuyển !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        if (self.tfCMNDTTNC.text!.count < 9 || self.tfCMNDTTNC.text!.count > 12){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập đúng số cmnd người chuyển", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfHoTenTTNN.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập họ tên người nhận !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        if(self.tfPhoneTTNN.text! == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số điện thoại người nhận !", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        let phone2 = tfPhoneTTNN.text!
        if (phone2.hasPrefix("01") && phone2.count == 11){
            
        }else if (phone2.hasPrefix("0") && !phone2.hasPrefix("01") && phone2.count == 10){
            
        }else{
            let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại người nhận không hợp lệ!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        let code = tfCode.text!
        if(code.isEmpty){
            
            let alert = UIAlertController(title: "Thông báo", message: "Mã nhận tiền không được để trống", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            tfCode.becomeFirstResponder()
            return
        }
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin  ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.getTransInfoEx(order_id:"frt-gettransinfo-\(dateString)",trans_date:dateString,receipt_code:code,amount:"\(self.transferDetail!.amount)",receiver_msisdn:"\(self.transferDetail!.receiver_msisdn)") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
                    
                    //self.actionInit()
                    self.actionUpdate(original_order_id: "\(self.transferDetail!.docentry)")
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func actionInit(){
        let dateFormatter : DateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        
        let date = Date()
        
        let dateString = dateFormatter.string(from: date)
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang xác nhận thông tin  ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.initTransfer(trans_date: dateString,receiver_msisdn: self.tfPhoneTTNN.text!,receiver_id_number: "\(self.tfCMNDTTNN.text!)",receipt_code: "\(self.tfCode.text!)",amount: "\(self.transferDetail!.amount)",image_cmtmt: "",image_cmtms: "",receiver_address:"\(self.tfDiaChi.text!)",image_pnt:"",init_type:"1") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.actionUpdate(original_order_id: "\(results.original_order_id)")
                    
                    //                    let alert = UIAlertController(title: "Thông báo", message: results.error_msg, preferredStyle: .alert)
                    //
                    //                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    //
                    //                    })
                    //                    self.present(alert, animated: true)
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func actionUpdate(original_order_id:String){
  
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang cập nhật thông tin  ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.editTransfer(original_order_id:"\(self.transferDetail!.docentry)",original_trans_id:"\(self.transferDetail!.trans_id_viettel)",service_code:"TRANSFER",transfer_type:"\(self.transferDetail!.transfer_type)",sender_name:"\(self.tfHoTenTTNC.text!)",sender_msisdn:"\(self.tfPhoneTTNC.text!)",sender_id_number:"\(self.tfCMNDTTNC.text!)",receiver_name:"\(self.tfHoTenTTNN.text!)",receiver_msisdn:"\(self.tfPhoneTTNN.text!)",receiver_id_number:"\(self.tfCMNDTTNN.text!)",receiver_province:"\(self.selectProvice)",receiver_district:"\(self.selectDistrict)",receiver_precinct:"\(self.selectPrecinct)",receiver_address:"\(self.tfDiaChi.text!)",image_pct:"") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
           
                    let alert = UIAlertController(title: "Thông báo", message: results.error_msg, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        _ = self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    })
                    self.present(alert, animated: true)
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func tapShowCMNDS() {
        posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc func tapShowCMNDT() {
        posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    
    func image1(image:UIImage){
        imgUpload1 = image
        
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewFacade.frame.size.width / sca
        imgViewFacade.image = image
        imgViewFacade.frame.size.height = heightImage
        viewFacade.frame.size.height = imgViewFacade.frame.origin.y + imgViewFacade.frame.size.height
        viewImages.frame.origin.y = viewFacade.frame.origin.y + viewFacade.frame.size.height
        
        label2.frame.origin.y = viewImages.frame.origin.y + viewImages.frame.size.height
        viewTTNN.frame.origin.y  = label2.frame.origin.y + label2.frame.size.height
        viewDiaChi.frame.origin.y  =  viewTTNN.frame.origin.y + viewTTNN.frame.size.height
        
       
        self.btGetFee.frame.origin.y = self.viewDiaChi.frame.size.height + self.viewDiaChi.frame.origin.y + Common.Size(s:10)
        
    
        
        
          scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btGetFee.frame.origin.y + btGetFee.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:45))
    }
    func image2(image:UIImage){
        imgUpload2 = image
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewImage1.frame.size.width / sca
        imgViewImage1.image = image
        imgViewImage1.frame.size.height = heightImage
        viewImage1.frame.size.height = imgViewImage1.frame.origin.y + imgViewImage1.frame.size.height
        viewImages.frame.size.height = viewImage1.frame.size.height + viewImage1.frame.origin.y
        label2.frame.origin.y = viewImages.frame.origin.y + viewImages.frame.size.height
        viewTTNN.frame.origin.y  = label2.frame.origin.y + label2.frame.size.height
        viewDiaChi.frame.origin.y  =  viewTTNN.frame.origin.y + viewTTNN.frame.size.height
        
    
        self.btGetFee.frame.origin.y = self.viewDiaChi.frame.size.height + self.viewDiaChi.frame.origin.y + Common.Size(s:10)
        
 
        
        
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btGetFee.frame.origin.y + btGetFee.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:45))
    }
    
    @objc func tapShowSign(sender:UITapGestureRecognizer) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
//        let nav = UINavigationController(rootViewController: signatureVC)
//        present(nav, animated: true, completion: nil)
        self.navigationController?.pushViewController(signatureVC, animated: true)
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
        
        
        
        self.btGetFee.frame.origin.y = self.viewSign.frame.size.height + self.viewSign.frame.origin.y + Common.Size(s:10)
        
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btGetFee.frame.origin.y + btGetFee.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
        
        _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
        
    }
}
extension UpdateTransferMoneyViettelPayViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
        
        // image is our desired image
        if (self.posImageUpload == 1){
            self.image1(image: image)
        }else if (self.posImageUpload == 2){
            self.image2(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
