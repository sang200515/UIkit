//
//  RejectPaymentRPViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/16/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import DLRadioButton
import PopupDialog
class RejectPaymentRPViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    var scrollView:UIScrollView!
    var detailAfterSaleRP:DetailAfterSaleRP?
    var itemRPOnProgress:ItemRPOnProgress?
    var tfNote:UITextView!
    var radRejectBuy:DLRadioButton!
    var radRejectSell:DLRadioButton!
    var tfOTP:UITextField!
    var selectType:String = ""
    
    override func viewDidLoad() {
        self.title = "Huỷ thanh toán"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(RejectPaymentRPViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let lblImei = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblImei.textAlignment = .left
        lblImei.textColor = UIColor(netHex:0x00955E)
        lblImei.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        lblImei.text = "Imei: \(self.detailAfterSaleRP!.IMEI)"
        scrollView.addSubview(lblImei)
        
        let lblDate = UILabel(frame: CGRect(x: Common.Size(s:10), y:lblImei.frame.size.height + lblImei.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblDate.textAlignment = .left
        lblDate.textColor = UIColor(netHex:0x00955E)
        lblDate.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lblDate)
        lblDate.text = "Ngày: \(self.detailAfterSaleRP!.NgayDang)"
        let label = UILabel(frame: CGRect(x: Common.Size(s: 15), y:lblDate.frame.size.height + lblDate.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label.text = "THÔNG TIN KHÁCH HÀNG"
        label.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label)
        
        let viewCustomer = UIView()
        viewCustomer.frame = CGRect(x: 0, y: label.frame.size.height + label.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewCustomer.backgroundColor = UIColor.white
        scrollView.addSubview(viewCustomer)
        
        
        let lblSeller = UILabel(frame: CGRect(x: Common.Size(s:10), y:   Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblSeller.textAlignment = .left
        lblSeller.textColor = UIColor.black
        lblSeller.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSeller.text = "Họ tên người bán"
        viewCustomer.addSubview(lblSeller)
        
        let lblSellerValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblSeller.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblSellerValue.textAlignment = .right
        lblSellerValue.textColor = UIColor.black
        lblSellerValue.text = "\(self.detailAfterSaleRP!.Sale_Name)"
        lblSellerValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
         viewCustomer.addSubview(lblSellerValue)
        let lblSellerPhone = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblSeller.frame.origin.y + lblSeller.frame.size.height + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSellerPhone.textAlignment = .left
        lblSellerPhone.textColor = UIColor.black
        lblSellerPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSellerPhone.text = "SĐT người bán"
        viewCustomer.addSubview(lblSellerPhone)
        
        let lblSellerPhoneValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblSellerPhone.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:14)))
        lblSellerPhoneValue.textAlignment = .right
        lblSellerPhoneValue.textColor = UIColor.black
        lblSellerPhoneValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSellerPhoneValue.text = "\(self.detailAfterSaleRP!.Sale_phone)"
        viewCustomer.addSubview(lblSellerPhoneValue)
        
        let lblBuyer = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblSellerPhone.frame.size.height + lblSellerPhone.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblBuyer.textAlignment = .left
        lblBuyer.textColor = UIColor.black
        lblBuyer.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBuyer.text = "Họ tên người mua"
        viewCustomer.addSubview(lblBuyer)
        
        let lblBuyerValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblBuyer.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblBuyerValue.textAlignment = .right
        lblBuyerValue.textColor = UIColor.black
        lblBuyerValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        viewCustomer.addSubview(lblBuyerValue)
        lblBuyerValue.text = "\(self.detailAfterSaleRP!.Buy_Name)"
        
        let lblBuyerPhone = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblBuyer.frame.size.height + lblBuyer.frame.origin.y +   Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblBuyerPhone.textAlignment = .left
        lblBuyerPhone.textColor = UIColor.black
        lblBuyerPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBuyerPhone.text = "SĐT người mua"
        viewCustomer.addSubview(lblBuyerPhone)
        
        let lblBuyerPhoneValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblBuyerPhone.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblBuyerPhoneValue.textAlignment = .right
        lblBuyerPhoneValue.textColor = UIColor.black
        lblBuyerPhoneValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblBuyerPhoneValue.text = "\(self.detailAfterSaleRP!.Buy_phone)"
        viewCustomer.addSubview(lblBuyerPhoneValue)
        
        viewCustomer.frame.size.height = lblBuyerPhone.frame.origin.y + lblBuyerPhone.frame.size.height + Common.Size(s:10)
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y:viewCustomer.frame.size.height + viewCustomer.frame.origin.y +  Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN SẢN PHẨM"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        
        let viewProduct = UIView()
        viewProduct.frame = CGRect(x: 0, y: label1.frame.size.height + label1.frame.origin.y  , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewProduct.backgroundColor = UIColor.white
        scrollView.addSubview(viewProduct)
        
        let lblItemName = UILabel(frame: CGRect(x: Common.Size(s:10), y:  Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblItemName.textAlignment = .left
        lblItemName.textColor = UIColor.black
        lblItemName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblItemName.text = "Tên SP"
        viewProduct.addSubview(lblItemName)
        
        let lblItemNameValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblItemName.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblItemNameValue.textAlignment = .right
        lblItemNameValue.textColor = UIColor.black
        lblItemNameValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblItemNameValue.text = self.itemRPOnProgress!.nameProduct
        viewProduct.addSubview(lblItemNameValue)
        
        let lblManufacturer = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblItemName.frame.size.height + lblItemName.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblManufacturer.textAlignment = .left
        lblManufacturer.textColor = UIColor.black
        lblManufacturer.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblManufacturer.text = "Hãng"
        viewProduct.addSubview(lblManufacturer)
        
        let lblManufacturerValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblManufacturer.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:14)))
        lblManufacturerValue.textAlignment = .right
        lblManufacturerValue.textColor = UIColor.black
        lblManufacturerValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblManufacturerValue.text = self.detailAfterSaleRP!.manufacturer
        viewProduct.addSubview(lblManufacturerValue)
        
        
        let lblItemColor = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblManufacturer.frame.size.height + lblManufacturer.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblItemColor.textAlignment = .left
        lblItemColor.textColor = UIColor.black
        lblItemColor.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblItemColor.text = "Màu"
        viewProduct.addSubview(lblItemColor)
        
        let lblItemColorValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblItemColor.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblItemColorValue.textAlignment = .right
        lblItemColorValue.textColor = UIColor.black
        lblItemColorValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblItemColorValue.text = self.detailAfterSaleRP!.color
        viewProduct.addSubview(lblItemColorValue)
        
        let lblMemory = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblItemColor.frame.size.height + lblItemColor.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblMemory.textAlignment = .left
        lblMemory.textColor = UIColor.black
        lblMemory.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblMemory.text = "Memory"
        viewProduct.addSubview(lblMemory)
        
        let lblMemoryValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblMemory.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30) , height: Common.Size(s:14)))
        lblMemoryValue.textAlignment = .right
        lblMemoryValue.textColor = UIColor.black
        lblMemoryValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblMemoryValue.text = self.detailAfterSaleRP!.memory
        viewProduct.addSubview(lblMemoryValue)
        
        let lblDepositCash = UILabel(frame: CGRect(x: Common.Size(s:10), y:  lblMemory.frame.size.height + lblMemory.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblDepositCash.textAlignment = .left
        lblDepositCash.textColor = UIColor.black
        lblDepositCash.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDepositCash.text = "Số tiền cọc"
        viewProduct.addSubview(lblDepositCash)
        
        let lblDepositCashValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:   lblDepositCash.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s:14)))
        lblDepositCashValue.textAlignment = .right
        lblDepositCashValue.textColor = UIColor.black
        lblDepositCashValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDepositCashValue.text = "\(Common.convertCurrencyFloat(value: self.detailAfterSaleRP!.Sotiencoc))"
        viewProduct.addSubview(lblDepositCashValue)
        
        
//        radRejectSell = createRadioButtonGender(CGRect(x: lblDepositCash.frame.origin.x,y:lblDepositCash.frame.origin.y + lblDepositCash.frame.size.height + Common.Size(s:5) , width: lblDepositCash.frame.size.width/3, height: Common.Size(s:20)), title: "Huỷ bán", color: UIColor.black);
//        viewProduct.addSubview(radRejectSell)
//
//        radRejectBuy = createRadioButtonGender(CGRect(x: radRejectSell.frame.origin.x + radRejectSell.frame.size.width ,y:radRejectSell.frame.origin.y, width: radRejectSell.frame.size.width, height: radRejectSell.frame.size.height), title: "Huỷ mua", color: UIColor.black);
//        viewProduct.addSubview(radRejectBuy)
        
        
        let lblOTPTitle = UILabel(frame: CGRect(x: Common.Size(s:10), y: lblDepositCash.frame.size.height + lblDepositCash.frame.origin.y +  Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblOTPTitle.textAlignment = .left
        lblOTPTitle.textColor = UIColor.black
        lblOTPTitle.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblOTPTitle.text = "Nhập OTP SMS"
        viewProduct.addSubview(lblOTPTitle)
        
        
        
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
        viewProduct.addSubview(tfOTP)
        
        let btOTP = UIButton()
        btOTP.frame = CGRect(x:tfOTP.frame.size.width + tfOTP.frame.origin.x + Common.Size(s:10), y: tfOTP.frame.origin.y , width: scrollView.frame.size.width  - Common.Size(s:200), height: Common.Size(s:40) )
        btOTP.backgroundColor = UIColor(netHex:0x00955E)
        btOTP.setTitle("Gửi OTP", for: .normal)
        btOTP.addTarget(self, action: #selector(actionOTP), for: .touchUpInside)
        btOTP.layer.borderWidth = 0.5
        btOTP.layer.borderColor = UIColor.white.cgColor
        btOTP.layer.cornerRadius = 3
        viewProduct.addSubview(btOTP)
        
        
        let lblNoteTitle = UILabel(frame: CGRect(x: Common.Size(s:10), y:   tfOTP.frame.size.height + tfOTP.frame.origin.y + Common.Size(s: 10), width: scrollView.frame.size.width , height: Common.Size(s:14)))
        lblNoteTitle.textAlignment = .left
        lblNoteTitle.textColor = UIColor.black
        lblNoteTitle.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNoteTitle.text = "Ghi chú"
        viewProduct.addSubview(lblNoteTitle)
        
        
        tfNote = UITextView(frame: CGRect(x: lblNoteTitle.frame.origin.x , y: lblNoteTitle.frame.origin.y  + lblNoteTitle.frame.size.height + Common.Size(s:10), width: lblNoteTitle.frame.size.width - Common.Size(s: 30), height: tfOTP.frame.size.height * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        tfNote.layer.borderWidth = 0.5
        tfNote.layer.borderColor = borderColor.cgColor
        tfNote.layer.cornerRadius = 5.0
        tfNote.delegate = self
        tfNote.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        viewProduct.addSubview(tfNote)
        
        let btReject = UIButton()
        btReject.frame = CGRect(x: Common.Size(s:10), y:tfNote.frame.size.height + tfNote.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width  - Common.Size(s:30), height: Common.Size(s:40) * 1.2)
        btReject.backgroundColor = UIColor(netHex:0x00955E)
        btReject.setTitle("Hủy", for: .normal)
        btReject.addTarget(self, action: #selector(actionReject), for: .touchUpInside)
        btReject.layer.borderWidth = 0.5
        btReject.layer.borderColor = UIColor.white.cgColor
        btReject.layer.cornerRadius = 3
        viewProduct.addSubview(btReject)
        
        viewProduct.frame.size.height = btReject.frame.origin.y + btReject.frame.size.height + Common.Size(s: 10)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewProduct.frame.origin.y + viewProduct.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
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
        
        
        MPOSAPIManager.mpos_FRT_SP_SK_Send_OTP(sdt: "\(self.detailAfterSaleRP!.Buy_phone)",docentry:"\(self.itemRPOnProgress!.docentry)") { (p_status,p_message, err) in
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
    fileprivate func createRadioButtonGender(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(RejectPaymentRPViewController.logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radRejectBuy.isSelected = false
            radRejectSell.isSelected = false
            switch temp {
            case "Huỷ bán":
                self.selectType = "3"
                radRejectSell.isSelected = true
                break
            case "Huỷ mua":
                self.selectType = "2"
                radRejectBuy.isSelected = true
                break
            default:
                
                break
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
            
            MPOSAPIManager.mpos_FRT_SP_SK_cance_order(Docentry:"\(self.itemRPOnProgress!.docentry)",Note:"\(self.tfNote.text!)",otp:"\(self.tfOTP.text!)",Type: "2",phone:"\(self.detailAfterSaleRP!.Buy_phone)",imei:"\(self.detailAfterSaleRP!.IMEI)",price: Int(self.detailAfterSaleRP!.Sale_price),name:"\(self.detailAfterSaleRP!.Buy_Name)",mail:"\(self.detailAfterSaleRP!.Buy_mail)", handler: { (result, message, error) in
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
