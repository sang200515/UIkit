//
//  CreateReceiveMoneyViettelPayViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/24/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
//import EPSignature
class CreateReceiveMoneyViettelPayViewController: UIViewController,UITextFieldDelegate,EPSignatureDelegate{
    
    var imagePicker = UIImagePickerController()
    var scrollView:UIScrollView!
    var posImageUpload:Int = 0
    //--
    var tfPhone: UITextField!
    var tfCode: UITextField!
    var tfMoney: UITextField!
    var viewFacade: UIView!
    var imgViewFacade:UIImageView!
    var viewImages:UIView!
    var viewImage1:UIView!
    var imgViewImage1:UIImageView!
    var btPay:UIButton!
    var imgUpload1: UIImage!
    var imgUpload2: UIImage!
    var tfCMND:UITextField!
    var tfDiaChi:UITextField!
    
    var imgViewSignature: UIImageView!
    var viewImageSign:UIView!
    var viewSign:UIView!
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.blue
        self.title = "Nhận tiền"
        self.initNavigationBar()
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(CreateReceiveMoneyViettelPayViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        self.view.backgroundColor = .white
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = .white
        self.view.addSubview(scrollView)
        
        let lbTextPhone = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone.textAlignment = .left
        lbTextPhone.textColor = UIColor.black
        lbTextPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone.text = "SĐT người nhận"
        scrollView.addSubview(lbTextPhone)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhone.frame.origin.y + lbTextPhone.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhone.autocorrectionType = UITextAutocorrectionType.no
        tfPhone.keyboardType = UIKeyboardType.numberPad
        tfPhone.returnKeyType = UIReturnKeyType.done
        tfPhone.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhone.delegate = self
        scrollView.addSubview(tfPhone)
        
        let lbTextCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhone.frame.origin.y + tfPhone.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMND.textAlignment = .left
        lbTextCMND.textColor = UIColor.black
        lbTextCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMND.text = "CMND người nhận"
        scrollView.addSubview(lbTextCMND)
        
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextCMND.frame.origin.y + lbTextCMND.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfCMND.placeholder = "Nhập CMND người nhận"
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        scrollView.addSubview(tfCMND)
        
        let lbTextDiaChi = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfCMND.frame.origin.y + tfCMND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextDiaChi.textAlignment = .left
        lbTextDiaChi.textColor = UIColor.black
        lbTextDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextDiaChi.text = "Địa Chỉ"
        scrollView.addSubview(lbTextDiaChi)
        
        tfDiaChi = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextDiaChi.frame.origin.y + lbTextDiaChi.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfDiaChi.placeholder = "Nhập địa chỉ người nhận"
        tfDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDiaChi.borderStyle = UITextField.BorderStyle.roundedRect
        tfDiaChi.autocorrectionType = UITextAutocorrectionType.no
        tfDiaChi.keyboardType = UIKeyboardType.default
        tfDiaChi.returnKeyType = UIReturnKeyType.done
        tfDiaChi.clearButtonMode = UITextField.ViewMode.whileEditing
        tfDiaChi.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDiaChi.delegate = self
        scrollView.addSubview(tfDiaChi)
        
        let lbTextCode = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfDiaChi.frame.origin.y + tfDiaChi.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCode.textAlignment = .left
        lbTextCode.textColor = UIColor.black
        lbTextCode.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCode.text = "Mã nhận tiền"
        scrollView.addSubview(lbTextCode)
        
        tfCode = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextCode.frame.origin.y + lbTextCode.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfCode.placeholder = "Nhập mã nhận tiền"
        tfCode.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCode.borderStyle = UITextField.BorderStyle.roundedRect
        tfCode.autocorrectionType = UITextAutocorrectionType.no
        tfCode.keyboardType = UIKeyboardType.numberPad
        tfCode.returnKeyType = UIReturnKeyType.done
        tfCode.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCode.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCode.delegate = self
        scrollView.addSubview(tfCode)
        
        let lbTextMoney = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfCode.frame.origin.y + tfCode.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextMoney.textAlignment = .left
        lbTextMoney.textColor = UIColor.black
        lbTextMoney.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextMoney.text = "Số tiền"
        scrollView.addSubview(lbTextMoney)
        
        tfMoney = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextMoney.frame.origin.y + lbTextMoney.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfMoney.placeholder = "Nhập số tiền"
        tfMoney.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfMoney.borderStyle = UITextField.BorderStyle.roundedRect
        tfMoney.autocorrectionType = UITextAutocorrectionType.no
        tfMoney.keyboardType = UIKeyboardType.numberPad
        tfMoney.returnKeyType = UIReturnKeyType.done
        tfMoney.clearButtonMode = UITextField.ViewMode.whileEditing
        tfMoney.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfMoney.delegate = self
        scrollView.addSubview(tfMoney)
        tfMoney.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
//        viewFacade = UIView(frame: CGRect(x: 0, y: tfMoney.frame.origin.y + tfMoney.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width, height: 0))
//        viewFacade.clipsToBounds = true
//        scrollView.addSubview(viewFacade)
//
//        let lbTextFacade = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
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
//        let tapShowFacade = UITapGestureRecognizer(target: self, action: #selector(self.tapShowFacade))
//        viewFacade.isUserInteractionEnabled = true
//        viewFacade.addGestureRecognizer(tapShowFacade)
//
//        viewImages = UIView(frame: CGRect(x: 0, y: viewFacade.frame.origin.y + viewFacade.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width, height: 0))
//        viewImages.clipsToBounds = true
//        scrollView.addSubview(viewImages)
//
//        viewImage1 = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: 0))
//        viewImage1.clipsToBounds = true
//        viewImages.addSubview(viewImage1)
//
//
//        imgViewImage1 = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: Common.Size(s:5), width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
//        imgViewImage1.image = UIImage(named:"CMNDmatsau")
//        imgViewImage1.contentMode = .scaleAspectFit
//        viewImage1.addSubview(imgViewImage1)
//        viewImage1.frame.size.height = imgViewImage1.frame.origin.y + imgViewImage1.frame.size.height
//        viewImage1.tag = 2
//        let tapShowImage = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImage))
//        viewImage1.isUserInteractionEnabled = true
//        viewImage1.addGestureRecognizer(tapShowImage)
//        viewImages.frame.size.height = viewImage1.frame.origin.y + viewImage1.frame.size.height
        
        
//        viewSign = UIView(frame: CGRect(x: Common.Size(s:20), y: tfMoney.frame.origin.y + tfMoney.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: 0))
//        viewSign.clipsToBounds = true
//
//        scrollView.addSubview(viewSign)
//
//        let lbTextSign = UILabel(frame: CGRect(x: 0, y: 0, width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: Common.Size(s:20)))
//        lbTextSign.textAlignment = .left
//        lbTextSign.textColor = UIColor(netHex:0x47B054)
//        lbTextSign.font = UIFont.systemFont(ofSize: Common.Size(s:18))
//        lbTextSign.text = "Chữ ký"
//        lbTextSign.sizeToFit()
//        viewSign.addSubview(lbTextSign)
//
//        viewImageSign = UIView(frame: CGRect(x:0, y: lbTextSign.frame.origin.y + lbTextSign.frame.size.height + Common.Size(s:5), width: viewSign.frame.size.width, height: Common.Size(s:60)))
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
//        viewSign.frame.size.height = viewImageSign.frame.origin.y + viewImageSign.frame.size.height
//
//        let tapShowSign = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSign))
//        viewSign.isUserInteractionEnabled = true
//        viewSign.addGestureRecognizer(tapShowSign)
        
        btPay = UIButton()
        btPay.frame = CGRect(x: Common.Size(s:15), y: tfMoney.frame.origin.y + tfMoney.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:40))
        btPay.backgroundColor = UIColor(netHex:0x04AB6E)
        btPay.setTitle("LẤY THÔNG TIN", for: .normal)
        btPay.addTarget(self, action: #selector(actionSave), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        scrollView.addSubview(btPay)
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btPay.frame.origin.y + btPay.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:45))
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s),\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
        }else{
            textField.text = ""
        }
    }
    
    @objc func actionSave(sender: UIButton!){
        
        let phone = tfPhone.text!
        if(phone.isEmpty){
            Toast.init(text: "SĐT người nhận không được để trống").show()
            //tfPhone.becomeFirstResponder()
            return
            
        }
        if (phone.hasPrefix("01") && phone.count == 11){

        }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){

        }else{
            Toast.init(text: "SĐT không hợp lệ").show()
            return
        }
        let code = tfCode.text!
        if(code.isEmpty){
            Toast.init(text: "Mã nhận tiền không được để trống").show()
           // tfCode.becomeFirstResponder()
            return
        }
        var moneyString:String = tfMoney.text!
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        if(moneyString == ""){
            moneyString = "0"
        }
        let moneyInt = Int(moneyString)!
        if(moneyInt <= 0){
            Toast.init(text: "Bạn phải nhập số tiền").show()
           // tfMoney.becomeFirstResponder()
            return
        }
        if(self.tfCMND.text! == ""){
            Toast.init(text: "Vui lòng nhập cmnd!!!").show()
            return
        }
        
        
        let dateFormatter : DateFormatter = DateFormatter()
        let dateFormatter2 : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        dateFormatter2.dateFormat = "dd/MM/yyyy"
        let date = Date()
        let date2 = Date()
        let dateString = dateFormatter.string(from: date)
        let dateString2 = dateFormatter2.string(from: date2)
        
        var money = tfMoney.text!
        money = money.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin  ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.getTransInfoEx(order_id:"frt-gettransinfo-\(dateString)",trans_date:dateString,receipt_code:code,amount:moneyString,receiver_msisdn:phone) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
                    
                    let detail = InitTransferDetail(docentry: Int(results.status)!
                        , TransactionCode:""
                        , trans_id_viettel:"\(results.trans_id)"
                        , billcode:""
                        , amount: Int(results.amount)!
                        , cust_fee: 0
                        , receiver_name:"\(results.nameReceiver)"
                        , receiver_msisdn:"\(results.msisdnReceiver)"
                        , receiver_id_number:"\(self.tfCMND.text!)"
                        , sender_name:"\(results.nameSender)"
                        , sender_msisdn:"\(results.msisdnSender)"
                        , sender_id_number:""
                        , CMND_mattruoc:""
                        , CMND_matsau:""
                        , Note:""
                        , receiver_address:"", NgayGiaoDich: dateString2)
                    let vc = InfoReceiveMoneyViettelPayViewController()
                    vc.detail = detail
                    vc.manhantien = self.tfCode.text!
                    vc.base64cmndt = ""
                    vc.base64cmnds = ""
                    vc.receiver_id_number = self.tfCMND.text!
                    vc.receiver_address = self.tfDiaChi.text!
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
        //
//        if let imageDataCMNDT:NSData = imgViewFacade.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
//            let strBase64CMNDT = imageDataCMNDT.base64EncodedString(options: .endLineWithLineFeed)
//            if let imageDataCMNDS:NSData = imgViewImage1.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
//                let strBase64CMNDS = imageDataCMNDS.base64EncodedString(options: .endLineWithLineFeed)
//
//
//
//
//
//                MPOSAPIManager.getTransInfoEx(order_id:"frt-gettransinfo-\(dateString)",trans_date:dateString,receipt_code:code,amount:moneyString,receiver_msisdn:phone) { (results, err) in
//                    let when = DispatchTime.now() + 0.5
//                    DispatchQueue.main.asyncAfter(deadline: when) {
//                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
//                        if(err.count <= 0){
//
//
//                            let detail = InitTransferDetail(docentry: Int(results.status)!
//                                , TransactionCode:""
//                                , trans_id_viettel:""
//                                , billcode:""
//                                , amount: Int(results.amount)!
//                                , cust_fee: 0
//                                , receiver_name:"\(results.nameReceiver)"
//                                , receiver_msisdn:"\(results.msisdnReceiver)"
//                                , receiver_id_number:"\(self.tfCMND.text!)"
//                                , sender_name:"\(results.nameSender)"
//                                , sender_msisdn:"\(results.msisdnSender)"
//                                , sender_id_number:""
//                                , CMND_mattruoc:""
//                                , CMND_matsau:""
//                                , Note:""
//                                , receiver_address:"", NgayGiaoDich: dateString2)
//                            let vc = InfoReceiveMoneyViettelPayViewController()
//                            vc.detail = detail
//                            vc.manhantien = self.tfCode.text!
//                            vc.base64cmndt = strBase64CMNDT
//                            vc.base64cmnds = strBase64CMNDS
//                            vc.receiver_id_number = self.tfCMND.text!
//                            self.navigationController?.pushViewController(vc, animated: true)
//
//
//                        }else{
//                            let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
//
//                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                            })
//                            self.present(alert, animated: true)
//                        }
//                    }
//                }
//
//
//
//            }
//
//
//
//        }
        //
        
     
        
        
        
        
        
 
    }
    @objc func tapShowImage(_ sender: UITapGestureRecognizer) {
        posImageUpload = sender.view!.tag
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc func tapShowFacade() {
        posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowSign(sender:UITapGestureRecognizer) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
//        let nav = UINavigationController(rootViewController: signatureVC)
//        present(nav, animated: true, completion: nil)
        self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    
    @objc func actionBack(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    func image1(image:UIImage){
        imgUpload1 = image
        
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewFacade.frame.size.width / sca
        imgViewFacade.image = image
        imgViewFacade.frame.size.height = heightImage
        viewFacade.frame.size.height = imgViewFacade.frame.origin.y + imgViewFacade.frame.size.height
        viewImages.frame.origin.y = viewFacade.frame.origin.y + viewFacade.frame.size.height + Common.Size(s:10)
        btPay.frame.origin.y = viewImages.frame.origin.y + viewImages.frame.size.height + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btPay.frame.size.height + btPay.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height  + Common.Size(s:20))
    }
    func image2(image:UIImage){
        imgUpload2 = image
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewFacade.frame.size.width / sca
        imgViewImage1.image = image
        imgViewImage1.frame.size.height = heightImage
        viewImage1.frame.size.height = imgViewImage1.frame.origin.y + imgViewImage1.frame.size.height
        viewImages.frame.size.height = viewImage1.frame.size.height + viewImage1.frame.origin.y
        btPay.frame.origin.y = viewImages.frame.origin.y + viewImages.frame.size.height + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btPay.frame.size.height + btPay.frame.origin.y + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height  + Common.Size(s:20))
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
        
        
        
        self.btPay.frame.origin.y = self.viewSign.frame.size.height + self.viewSign.frame.origin.y + Common.Size(s:10)
        
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btPay.frame.origin.y + btPay.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
        
        _ = self.navigationController?.popViewController(animated: true)
           self.dismiss(animated: true, completion: nil)
        
    }
    
}
extension CreateReceiveMoneyViettelPayViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
