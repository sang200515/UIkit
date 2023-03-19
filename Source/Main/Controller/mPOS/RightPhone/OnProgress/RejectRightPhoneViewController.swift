//
//  RejectRightPhoneViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/8/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class RejectRightPhoneViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate {
    
    
    var scrollView:UIScrollView!
    var tfOTP:UITextField!
    var tfNote:UITextView!
    var detailRPAll:DetailRPAll?
    var itemRPOnProgress:ItemRPOnProgress?
    override func viewDidLoad() {
        self.title = "Huỷ Phiếu ĐK từ người bán"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(RejectRightPhoneViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        
        let label = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
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
        lblNameProduct.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        lblNameProduct.text = "Tên SP: \(self.detailRPAll!.ItemName)"
        viewProduct.addSubview(lblNameProduct)
        
        
        let lblImei = UILabel(frame: CGRect(x: Common.Size(s:10), y:lblNameProduct.frame.size.height + lblNameProduct.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblImei.textAlignment = .left
        lblImei.textColor = UIColor(netHex:0x00955E)
        lblImei.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        lblImei.text = "Imei: \(self.detailRPAll!.IMEI)"
        viewProduct.addSubview(lblImei)
        
        
        
        
        let lblColorProduct = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblImei.frame.size.height + lblImei.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblColorProduct.textAlignment = .left
        lblColorProduct.textColor = UIColor.black
        lblColorProduct.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblColorProduct.text = "Màu sắc: \(self.detailRPAll!.color)"
        viewProduct.addSubview(lblColorProduct)
        
        
        let lblBranch = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblImei.frame.size.height + lblImei.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblBranch.textAlignment = .right
        lblBranch.textColor = UIColor.black
        lblBranch.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBranch.text = "Hãng: \(self.detailRPAll!.manufacturer)"
        viewProduct.addSubview(lblBranch)
        
        
        
        
        
        let lblMemory = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblColorProduct.frame.size.height + lblColorProduct.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblMemory.textAlignment = .left
        lblMemory.textColor = UIColor.black
        lblMemory.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblMemory.text = "Memory: \(self.detailRPAll!.memory)"
        viewProduct.addSubview(lblMemory)
        
        let lblPrice = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblColorProduct.frame.size.height + lblColorProduct.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPrice.textAlignment = .right
        lblPrice.textColor = UIColor.black
        lblPrice.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPrice.text = "Giá: \(Common.convertCurrencyFloat(value: self.detailRPAll!.Sale_price))"
        viewProduct.addSubview(lblPrice)
        
        
        
        viewProduct.frame.size.height = lblMemory.frame.size.height + lblMemory.frame.origin.y + Common.Size(s: 10)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y:viewProduct.frame.size.height + viewProduct.frame.origin.y , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN KHÁCH HÀNG"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        let viewCustomer = UIView()
        viewCustomer.frame = CGRect(x: 0, y: label1.frame.size.height + label1.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewCustomer.backgroundColor = UIColor.white
        scrollView.addSubview(viewCustomer)
        
        let lblHoTen = UILabel(frame: CGRect(x: Common.Size(s:10), y:  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblHoTen.textAlignment = .left
        lblHoTen.textColor = UIColor.black
        lblHoTen.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblHoTen.text = "Họ tên"
        viewCustomer.addSubview(lblHoTen)
        
        let lblHoTenValue = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblHoTenValue.textAlignment = .right
        lblHoTenValue.textColor = UIColor.black
        lblHoTenValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblHoTenValue.text = "\(self.detailRPAll!.Sale_Name)"
        viewCustomer.addSubview(lblHoTenValue)
        
        
        let lblSDT = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblHoTen.frame.size.height + lblHoTen.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSDT.textAlignment = .left
        lblSDT.textColor = UIColor.black
        lblSDT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSDT.text = "SĐT"
        viewCustomer.addSubview(lblSDT)
        
        let lblSDTValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblHoTen.frame.size.height + lblHoTen.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSDTValue.textAlignment = .right
        lblSDTValue.textColor = UIColor.black
        lblSDTValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSDTValue.text = "\(self.detailRPAll!.Sale_phone)"
        viewCustomer.addSubview(lblSDTValue)
        
        
        let lblEmail = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblSDT.frame.size.height + lblSDT.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblEmail.textAlignment = .left
        lblEmail.textColor = UIColor.black
        lblEmail.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblEmail.text = "Email"
        viewCustomer.addSubview(lblEmail)
        
        let lblEmailValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblSDT.frame.size.height + lblSDT.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblEmailValue.textAlignment = .right
        lblEmailValue.textColor = UIColor.black
        lblEmailValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblEmailValue.text = "\(self.detailRPAll!.Sale_mail)"
        viewCustomer.addSubview(lblEmailValue)
        
        
        let lblShopResgistry = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblEmail.frame.size.height + lblEmail.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblShopResgistry.textAlignment = .left
        lblShopResgistry.textColor = UIColor.black
        lblShopResgistry.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblShopResgistry.text = "Shop ĐK"
        viewCustomer.addSubview(lblShopResgistry)
        
        let lblShopResgistryValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblEmail.frame.size.height + lblEmail.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblShopResgistryValue.textAlignment = .right
        lblShopResgistryValue.textColor = UIColor.black
        lblShopResgistryValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblShopResgistryValue.text = "\(self.detailRPAll!.TenShop)"
        viewCustomer.addSubview(lblShopResgistryValue)
        
        let lblDateResgistry = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblShopResgistry.frame.size.height + lblShopResgistry.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblDateResgistry.textAlignment = .left
        lblDateResgistry.textColor = UIColor.black
        lblDateResgistry.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDateResgistry.text = "Ngày ĐK"
        viewCustomer.addSubview(lblDateResgistry)
        
        let lblDateResgistryValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblShopResgistry.frame.size.height + lblShopResgistry.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblDateResgistryValue.textAlignment = .right
        lblDateResgistryValue.textColor = UIColor.black
        lblDateResgistryValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDateResgistryValue.text = "\(self.detailRPAll!.Rcheck_date)"
        viewCustomer.addSubview(lblDateResgistryValue)
        
        
        let lblEmployerResgister = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblDateResgistry.frame.size.height + lblDateResgistry.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblEmployerResgister.textAlignment = .left
        lblEmployerResgister.textColor = UIColor.black
        lblEmployerResgister.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblEmployerResgister.text = "NV ĐK"
        viewCustomer.addSubview(lblEmployerResgister)
        
        let lblEmployerResgisterValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblDateResgistry.frame.size.height + lblDateResgistry.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblEmployerResgisterValue.textAlignment = .right
        lblEmployerResgisterValue.textColor = UIColor.black
        lblEmployerResgisterValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblEmployerResgisterValue.text = "\(self.detailRPAll!.TenNVRcheck)"
        viewCustomer.addSubview(lblEmployerResgisterValue)
        
        
        let lblOTPTitle = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblEmployerResgister.frame.size.height + lblEmployerResgister.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblOTPTitle.textAlignment = .left
        lblOTPTitle.textColor = UIColor.black
        lblOTPTitle.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblOTPTitle.text = "Nhập OTP SMS"
        viewCustomer.addSubview(lblOTPTitle)
        
        
        
        tfOTP = UITextField(frame: CGRect(x: Common.Size(s:10), y: lblOTPTitle.frame.origin.y + lblOTPTitle.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:160) , height: Common.Size(s:40)));
        tfOTP.placeholder = "Nhập OTP KH"
        tfOTP.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfOTP.borderStyle = UITextField.BorderStyle.roundedRect
        tfOTP.autocorrectionType = UITextAutocorrectionType.no
        tfOTP.keyboardType = UIKeyboardType.numberPad
        tfOTP.returnKeyType = UIReturnKeyType.done
        tfOTP.clearButtonMode = UITextField.ViewMode.whileEditing
        tfOTP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfOTP.delegate = self
        viewCustomer.addSubview(tfOTP)
        
        let btOTP = UIButton()
        btOTP.frame = CGRect(x:tfOTP.frame.size.width + tfOTP.frame.origin.x + Common.Size(s:10) , y: tfOTP.frame.origin.y , width: scrollView.frame.size.width  - Common.Size(s:200), height: Common.Size(s:40) )
        btOTP.backgroundColor = UIColor(netHex:0x00955E)
        btOTP.setTitle("Gửi OTP", for: .normal)
        btOTP.addTarget(self, action: #selector(actionOTP), for: .touchUpInside)
        btOTP.layer.borderWidth = 0.5
        btOTP.layer.borderColor = UIColor.white.cgColor
        btOTP.layer.cornerRadius = 3
        viewCustomer.addSubview(btOTP)
        
        
        
        let lblNote = UILabel(frame: CGRect(x: Common.Size(s:10), y: tfOTP.frame.size.height + tfOTP.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNote.textAlignment = .left
        lblNote.textColor = UIColor.black
        lblNote.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNote.text = "Ghi chú"
        viewCustomer.addSubview(lblNote)
        
        
        tfNote = UITextView(frame: CGRect(x: lblNote.frame.origin.x , y: lblNote.frame.origin.y  + lblNote.frame.size.height + Common.Size(s:10), width: lblNote.frame.size.width, height: tfOTP.frame.size.height * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        tfNote.layer.borderWidth = 0.5
        tfNote.layer.borderColor = borderColor.cgColor
        tfNote.layer.cornerRadius = 5.0
//        tfNote.delegate = self
        tfNote.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        viewCustomer.addSubview(tfNote)
        tfNote.text = "\(self.detailRPAll!.Note)"
        
        let btReject = UIButton()
        btReject.frame = CGRect(x: Common.Size(s:10), y:tfNote.frame.size.height + tfNote.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width  - Common.Size(s:30), height: Common.Size(s:40) * 1.2)
        btReject.backgroundColor = UIColor(netHex:0x00955E)
        btReject.setTitle("Hủy", for: .normal)
        btReject.addTarget(self, action: #selector(actionReject), for: .touchUpInside)
        btReject.layer.borderWidth = 0.5
        btReject.layer.borderColor = UIColor.white.cgColor
        btReject.layer.cornerRadius = 3
        viewCustomer.addSubview(btReject)
        
        viewCustomer.frame.size.height = btReject.frame.size.height + btReject.frame.origin.y + Common.Size(s: 10)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewCustomer.frame.origin.y + viewCustomer.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
    }
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func actionOTP(){
    
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gửi mã OTP ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_FRT_SP_SK_Send_OTP(sdt: "\(self.itemRPOnProgress!.phoneBuyer)",docentry:"\(self.itemRPOnProgress!.docentry)") { (p_status,p_message, err) in
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
    @objc func actionReject(){
        if(self.tfOTP.text! == ""){
            let popup = PopupDialog(title: "THÔNG BÁO", message: "Vui lòng nhập OTP KH", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        
        let popup = PopupDialog(title: "THÔNG BÁO", message: "Bạn có chắc chắn muốn huỷ giao dịch này ?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        let buttonOne = CancelButton(title: "Có") {
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra thông tin..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            MPOSAPIManager.mpos_FRT_SP_SK_cance_order(Docentry:"\(self.itemRPOnProgress!.docentry)",Note:"\(self.tfNote.text!)",otp:"\(self.tfOTP.text!)",Type: "1",phone:"\(self.detailRPAll!.Sale_phone)",imei:"\(self.detailRPAll!.IMEI)",price: Int(self.detailRPAll!.Sale_price),name:"\(self.detailRPAll!.Sale_Name)",mail:"\(self.detailRPAll!.Sale_mail)", handler: { (result, message, error) in
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when) {
                    if(error.count <= 0){
                        let popup = PopupDialog(title: "THÔNG BÁO", message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                      _ = self.navigationController?.popToRootViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                            let nc = NotificationCenter.default
                            nc.post(name: Notification.Name("rightPhoneTabNotification"), object: nil)
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                        
                    }else{
                        let popup = PopupDialog(title: "THÔNG BÁO", message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                    
                }
                
            })
        }
        let buttonTow = DestructiveButton(title: "Không") {
        }
        popup.addButtons([buttonTow,buttonOne])
        self.present(popup, animated: true, completion: nil)
    }
}
