//
//  DKUyQuyenViettelViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 8/11/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DKUyQuyenViettelViewController: UIViewController {

    var tfSdt: UITextField!
    var thuHoService: ThuHoService?
    var thuHoProvider: ThuHoProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Truy vấn nợ cước viễn thông"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        let lbSdt = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:8), width: self.view.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:50)))
        lbSdt.text = "SĐT khách hàng"
        lbSdt.font = UIFont.systemFont(ofSize: 17)
        self.view.addSubview(lbSdt)
        
        tfSdt = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbSdt.frame.origin.y + lbSdt.frame.height, width: self.view.frame.width - Common.Size(s:30), height: Common.Size(s:35)))
        tfSdt.borderStyle = .roundedRect
        tfSdt.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSdt.keyboardType = .decimalPad
        tfSdt.returnKeyType = .default
        self.view.addSubview(tfSdt)
        
        let btnDangKy = UIButton(frame: CGRect(x: Common.Size(s:15), y: tfSdt.frame.origin.y + tfSdt.frame.height +  Common.Size(s:15), width: self.view.frame.width - Common.Size(s:30), height: Common.Size(s:40)))
        btnDangKy.backgroundColor = UIColor(netHex: 0x109e59)
        btnDangKy.setTitle("TRUY VẤN", for: .normal)
        btnDangKy.layer.cornerRadius = 8
        btnDangKy.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.view.addSubview(btnDangKy)
        btnDangKy.addTarget(self, action: #selector(registerPhone), for: .touchUpInside)
    }
    
    @objc func registerPhone() {
        guard let sdt = tfSdt.text, !sdt.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập Số điện thoại!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard sdt.count == 10, (sdt.isNumber() == true) else {
            let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại không hợp lệ!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        self.actionTruyVanNoCuocViettel(ServiceCode: "\(self.thuHoProvider?.PaymentBillProviderCode ?? "100000")", BillingCode: sdt, isDKUyQuyen: false)
    }
    
    func confirmOTP(ServiceCode: String, BillingCode: String, otpNum: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.ViettelPay_ConfirmAuthority(ServiceCode: "\(ServiceCode)", BillingCode: "\(BillingCode)", Otp: "\(otpNum)") { (rsConfirmOTP, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if rsConfirmOTP != nil {
                        if rsConfirmOTP?.error_code == "00"{
                            self.actionTruyVanNoCuocViettel(ServiceCode: "\(ServiceCode)", BillingCode: "\(BillingCode)", isDKUyQuyen: true)
                            
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Error \(rsConfirmOTP?.error_code ?? ""): \(rsConfirmOTP?.error_msg ?? "Xác nhận OTP thất bại!")", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "API Error!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func actionTruyVanNoCuocViettel(ServiceCode: String, BillingCode: String, isDKUyQuyen: Bool) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.ViettelPay_GetPayTeleCharge(ServiceCode: "\(ServiceCode)", BillingCode: "\(BillingCode)") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if rs != nil {
                        if rs?.error_code == "00" {
                            let vc = DetailViettelTraSauInfoViewController()
                            vc.itemViettelTSPayTeleCharge = rs
                            vc.thuHoService = self.thuHoService
                            vc.thuHoProvider = self.thuHoProvider
                            vc.isDKUyQuyen = isDKUyQuyen
                            self.navigationController?.pushViewController(vc, animated: true)

                        } else if rs?.error_code == "K1015"{
                            let alert = UIAlertController(title: "Thông báo", message: "Error \(rs?.error_code ?? ""): \(rs?.error_msg ?? "Truy vấn thất bại!")", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                self.actionDangKyUyQuyen(ServiceCode: "\(ServiceCode)", sdt: "\(BillingCode)")
                            }
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)

                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Error \(rs?.error_code ?? ""): \(rs?.error_msg ?? "")\nThuê bao không được phép thanh toán!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default) { (_) in
//                                let vc = PaymentViettelTraSauViewController()
//                                vc.thuHoService = self.thuHoService
//                                vc.thuHoProvider = self.thuHoProvider
//                                vc.itemViettelTSPayTeleCharge = GetPayTeleChargeViettelTS(order_id: rs?.order_id ?? "", trans_id: rs?.trans_id ?? "", trans_date: "", service_code: ServiceCode, billing_code: BillingCode, amount: rs?.amount ?? "", error_code: rs?.error_code ?? "", error_msg: rs?.error_msg ?? "", subID: rs?.subID ?? "", payment_order_id: rs?.payment_order_id ?? "", original_trans_id: rs?.original_trans_id ?? "", payer_msisdn: BillingCode, sompos: "\(rs?.sompos ?? "0")")
//                                vc.totalCash = "0"
//                                vc.totalCredict = "0"
//                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "API Error!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func actionDangKyUyQuyen(ServiceCode: String, sdt: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.ViettelPay_RegisterAuthority(ServiceCode: "\(ServiceCode)", BillingCode: sdt, Msisdn: sdt) { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if rs != nil {
                        if rs?.error_code == "00" {
                            self.showInputDialog(title: "Xác nhận", subtitle: "Nhập mã OTP khách hàng uỷ quyền!", actionTitle1: "Gửi lại OTP", actionTitle2: "Xác nhận", inputPlaceholder: "", inputKeyboardType: .numberPad, actionHandler1: { (action1) in
                                self.registerPhone()

                            }) { (otpNum) in
                                self.confirmOTP(ServiceCode: "\(self.thuHoProvider?.PaymentBillProviderCode ?? "100000")", BillingCode: sdt, otpNum: otpNum ?? "")
                            }
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Error \(rs?.error_code ?? ""): \(rs?.error_msg ?? "Đăng ký uỷ quyền thất bại!")", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }

                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "API Error!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showInputDialog(title:String? = nil,
                         subtitle:String? = nil,
                         actionTitle1:String?,
                         actionTitle2:String?,
                         inputPlaceholder:String? = nil,
                         inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                         actionHandler1: ((_ text: String?) -> Void)? = nil,
                         actionHandler2: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: actionTitle1, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler1?(nil)
                return
            }
            actionHandler1?(textField.text)
        }))
        
        alert.addAction(UIAlertAction(title: actionTitle2, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler2?(nil)
                return
            }
            actionHandler2?(textField.text)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
