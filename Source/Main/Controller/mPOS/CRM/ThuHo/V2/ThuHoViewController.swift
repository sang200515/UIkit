//
//  ThuHoViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import Toaster
import PopupDialog
import WebKit
class ThuHoViewController: UIViewController, UITextFieldDelegate {
    
    var scrollView:UIScrollView!
    var tfContractCode:UITextField!
    var tfTransactionType:UITextField!
    var tfSupplier:UITextField!

    var thuHoService: ThuHoService?
    var thuHoProvider: ThuHoProvider?
    var webView:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        self.title = "Thu hộ"
        self.view.backgroundColor = .white
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(ThuHoViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
       
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height - ((navigationController?.navigationBar.frame.size.height ?? 0) + UIApplication.shared.statusBarFrame.height))
        
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lbLoaiDV = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:15), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbLoaiDV.text = "Loại dịch vụ"
        lbLoaiDV.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lbLoaiDV)
        
        tfTransactionType = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbLoaiDV.frame.origin.y + lbLoaiDV.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfTransactionType.text = self.thuHoService?.PaymentBillServiceName ?? ""
        tfTransactionType.font = UIFont.systemFont(ofSize: 15)
        tfTransactionType.isEnabled = false
        tfTransactionType.borderStyle = .roundedRect
        scrollView.addSubview(tfTransactionType)
        
        let lbNCC = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfTransactionType.frame.origin.y + tfTransactionType.frame.size.height + Common.Size(s:8), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbNCC.text = "Nhà cung cấp"
        lbNCC.font = UIFont.systemFont(ofSize: 15)
        scrollView.addSubview(lbNCC)
        
        tfSupplier = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbNCC.frame.origin.y + lbNCC.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfSupplier.text = self.thuHoProvider?.PaymentBillProviderName ?? ""
        tfSupplier.font = UIFont.systemFont(ofSize: 15)
        tfSupplier.isEnabled = false
        tfSupplier.borderStyle = .roundedRect
        scrollView.addSubview(tfSupplier)
        
        tfContractCode = UITextField(frame: CGRect(x: Common.Size(s:15), y: tfSupplier.frame.origin.y + tfSupplier.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfContractCode.placeholder = "Nhập số hợp đồng"
        tfContractCode.font = UIFont.systemFont(ofSize: 15)
        tfContractCode.borderStyle = .roundedRect
        scrollView.addSubview(tfContractCode)
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: Common.Size(s:15), y: tfContractCode.frame.origin.y + tfContractCode.frame.size.height + Common.Size(s:30), width: tfSupplier.frame.size.width, height: tfSupplier.frame.size.height * 1.1)
        btPay.backgroundColor = UIColor(netHex:0x00955E)
        btPay.setTitle("TRA CỨU HOÁ ĐƠN", for: .normal)
        btPay.addTarget(self, action: #selector(actionTraCuuHoaDon), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        
        scrollView.addSubview(btPay)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s: 10))
        
        self.webView = WKWebView(frame: CGRect(x: 0 , y: btPay.frame.size.height + btPay.frame.origin.y + Common.Size(s: 15) , width: self.view.frame.size.width , height: self.view.frame.size.height - (btPay.frame.size.height + btPay.frame.origin.y + Common.Size(s: 15))))
        self.webView.backgroundColor = .white
        self.view.addSubview(self.webView)

        if self.thuHoProvider?.PaymentBillProviderID == "83" {
            let strContent = "<h3 style='font-family: Times New Roman;'>** Giao dịch n&agrave;y chỉ được huỷ trong v&ograve;ng<span style='color: #ff0000;'> 15 ph&uacute;t</span> kể từ khi ho&agrave;n tất, vui l&ograve;ng kiểm tra kỹ th&ocirc;ng tin với kh&aacute;ch trước khi chọn thanh to&aacute;n **</h3>" + "<p><h3 style='font-family: Times New Roman;'><strong>** Hiện tại FPTShop đ&atilde; c&oacute; b&aacute;n <span style='color: #ff0000;'>V&Eacute; M&Aacute;Y BAY</span>, Anh/chị nắm th&ocirc;ng tin để tư vấn cho kh&aacute;ch</strong> h&agrave;ng nh&eacute;! **</h3></p>"
            
            self.webView.loadHTMLString("\(strContent)", baseURL: nil)
        } else {
            MPOSAPIManager.mpos_FRT_SP_Mirae_noteforsale(type:"3") { (result, err) in
                if(result.count > 0){
                    self.webView.loadHTMLString(Common.shared.headerString + result, baseURL: nil)

                }
            }
        }
    }
    
    @objc func actionTraCuuHoaDon(sender: UIButton!){
        let contractCode = tfContractCode.text!
        if(contractCode.isEmpty){
            Toast.init(text: "Bạn chưa nhập mã hợp đồng!").show()
            return
        }
        if(thuHoService == nil){
            Toast.init(text: "Bạn chưa chọn loại dịch vụ!").show()
            return
        }
        if(thuHoProvider == nil){
            Toast.init(text: "Bạn chưa chọn nhà cung cấp!").show()
            return
        }
        
        //    PartnerUserCode    PartnerUserName
        //    0051                  SMARTPAY
        //    PartnerUserCode    PartnerUserName
        //    0006                  PAYOO
        //    PartnerUserCode    PartnerUserName
        //    0041                  VIETTEL
        
        if self.thuHoProvider?.PartnerUserCode.trim() == "0051" { //SMARTPAY
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.THSmartPay_CheckInfo(contractNo: contractCode, providerCode: "\(self.thuHoProvider?.PaymentBillProviderCode ?? "")") { (rs, rsCode, msg, err) in
                    
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if err.count <= 0 {
                            if rs != nil {
                                if rs?.contractNo == "" {
                                    let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "Truy vấn hoá đơn thất bại!")", preferredStyle: .alert)
                                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                    alert.addAction(action)
                                    self.present(alert, animated: true, completion: nil)
                                } else {
                                    let vc = DetailBillViewController()
                                    vc.thuHoService = self.thuHoService
                                    vc.thuHoProvider = self.thuHoProvider
                                    vc.contractCode = contractCode
                                    vc.itemThuHoSmartpayCheckInfo = rs
                                    vc.thuHoBill = ThuHoBill(RandomString: "", IsOffline: 0, ReturnCode: "", Description: "", PaymentFeeType: 0, PercentFee: 0, ConstantFee: 0, MinFee: 0, MaxFee: 0, PaymentRule: 0, CustomerInfo: "", CustomerName: "", BusinessName: "", BusinessOrderNo: "", FlyInfo: "", TenNCCEcom: "", PaymentRange: "", TotalAmount: 0, PaymentFee: 0, ListMutiBill: [], IDCardNo: "", CompanyName: "", AgriTransactionCode: "", ListDetailAgribank: [], ListDetailPayoo: [])
                                    vc.parentNavigationController = self.navigationController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            } else {
                                let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "Truy vấn hoá đơn thất bại!")", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            }
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        } else {
            self.traCuuThuHo(contractCode: contractCode)
        }
    }
    
    func traCuuThuHo(contractCode: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.GetBillV2(WarehouseCode: "\(Cache.user?.ShopCode ?? "")", ProviderCode: "\(self.thuHoProvider?.PaymentBillProviderCode ?? "")", ServiceCode: "\(self.thuHoProvider?.PaymentBillServiceCode ?? "")", PartnerUserCode: "\(self.thuHoProvider?.PartnerUserCode ?? "")", CustomerID: "\(contractCode)", AgribankProviderCode: "\(self.thuHoProvider?.AgriBankProviderCode ?? "")", MomenyAmountReturnCode25: "") { (result, err) in
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if(result != nil){
                        if(result!.ReturnCode == "3" || result!.ReturnCode == "4" || result!.ReturnCode == "-1" || result!.ReturnCode == "-9") {
                            let popup = PopupDialog(title: "Thông báo", message: "\(result!.Description) \rHĐ: \(contractCode) \r\nDV: \(self.thuHoService!.PaymentBillServiceName) \nShop: \(Cache.user!.ShopCode) \rNV: \(Cache.user!.UserName)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            }
                            let buttonOne = CancelButton(title: "OK") {
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)

                        }else if(result!.ReturnCode == "0"){
                            if("\(self.thuHoProvider!.AgriBankProviderCode)" != ""){

                            } else{
                                if(result!.ListDetailPayoo.count > 0) { //PAYOO
                                    let vc = DetailBillViewController()
                                    vc.thuHoBill = result
                                    vc.thuHoService = self.thuHoService
                                    vc.thuHoProvider = self.thuHoProvider
                                    vc.contractCode = contractCode
                                    vc.parentNavigationController = self.navigationController
                                    self.navigationController?.pushViewController(vc, animated: true)
                                    
                                } else{
                                    let popup = PopupDialog(title: "Thông báo", message: "Chưa hỗ trợ loại hợp đồng này.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                }
                            }
                        }else if(result!.ReturnCode == "-25") {
                            let popup = PopupDialog(title: "Thông báo", message: "\(result!.Description)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            }
                            let buttonOne = DefaultButton(title: "Đồng ý") {
                                let vc = MutiBillViewController()
                                vc.thuHoBill = result
                                vc.thuHoService = self.thuHoService
                                vc.thuHoProvider = self.thuHoProvider
                                vc.contractCode = contractCode
                                vc.parentNavigationController = self.navigationController
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                            let buttonTwo = CancelButton(title: "Huỷ") {
                            }
                            popup.addButtons([buttonTwo,buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }else{
                        let popup = PopupDialog(title: "Thông báo", message: "\(err) \rHĐ: \(contractCode) \r\nDV: \(self.thuHoService!.PaymentBillServiceName) \nShop: \(Cache.user!.ShopCode) \rNV: \(Cache.user!.UserName)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

