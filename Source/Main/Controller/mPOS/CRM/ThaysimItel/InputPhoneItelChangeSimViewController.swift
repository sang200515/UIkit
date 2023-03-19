//
//  InputPhoneItelChangeSimViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 10/1/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
class InputPhoneItelChangeSimViewController: UIViewController {
    
    // MARK: - Properties
//    var isEsim = false
    private var tfPhone: UITextField!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        self.title = "KIỂM TRA THÔNG TIN SIM"
        self.navigationItem.setHidesBackButton(true, animated:true)
        configureNavigationItem()
        configureUI()
    }
    
    // MARK: - API
    
    func getOTPAPI(){
        guard let phone = tfPhone.text else {return}
        
        ProgressView.shared.show()
        CRMAPIManager.Itel_GetChangeSimFee(PhoneNumber: "\(phone)",isEsim:
            "0") { (rs, errCode, errMessage, err) in
                ProgressView.shared.hide()
                    if err.count <= 0 {
                        if rs != nil {
                            self.showAlertOneButton(title: "Thông báo", with: rs?.p_messages ?? "", titleButton: "OK") {
                                let controller = SwapItelVC()
                                controller.itemItelFee = rs
                                controller.phoneNum = phone
                                self.navigationController?.pushViewController(controller, animated: true)
                            }
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Error \(errCode): \(errMessage)", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .default) { _ in
                                self.navigationController?.popViewController(animated: true)
                            }
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                        let action = UIAlertAction(title: "OK", style: .default) { _ in
                            self.navigationController?.popViewController(animated: true)
                        }
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                
            }
        
    }
    
    // MARK: - Selectors
    @objc func handleBack(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSendOTP(){
        getOTPAPI()
    }
    
    // MARK: - Helpers
    func configureNavigationItem(){
        //left menu icon
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
    }
    
    func configureUI(){
        view.backgroundColor = .white
        
        let lbTextPhone = Common.tileLabel(x: Common.Size(s:15), y: Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14), title: "Số điện thoại",fontSize: Common.Size(s:12))
        view.addSubview(lbTextPhone)
        
        tfPhone = Common.inputTextTextField(x: Common.Size(s:15), y: lbTextPhone.frame.origin.y + lbTextPhone.frame.size.height + Common.Size(s:5), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:40), placeholder: "Nhập số điện thoại khách hàng", fontSize: Common.Size(s:15), isNumber: true)
        view.addSubview(tfPhone)
        
        
        let btCreateOrder = Common.buttonAction(x: tfPhone.frame.origin.x, y: tfPhone.frame.origin.y + tfPhone.frame.size.height + Common.Size(s:20), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:40),title:"TRA CỨU")
        btCreateOrder.addTarget(self, action: #selector(handleSendOTP), for: .touchUpInside)
        view.addSubview(btCreateOrder)
    }
    @objc func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    
}
