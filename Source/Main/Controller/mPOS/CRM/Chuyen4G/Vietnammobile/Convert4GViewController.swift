//
//  Convert4GViewController.swift
//  mPOS
//
//  Created by tan on 7/9/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

class Convert4GViewController: UIViewController,UITextFieldDelegate,ScanImeiConvert4GViewControllerDelegate {
    var scrollView:UIScrollView!
    var tfSerialSim:UITextField!
    var tfMaOTP:UITextField!
    var btnConfirm:UIButton!
    var phone:String?
    
    override func viewDidLoad() {
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        
        
        let lbTitleSeriSim =  UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTitleSeriSim.textAlignment = .left
        lbTitleSeriSim.textColor = UIColor.black
        lbTitleSeriSim.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTitleSeriSim.text = "Seri Sim 4G"
        scrollView.addSubview(lbTitleSeriSim)
        
        
        tfSerialSim = UITextField(frame: CGRect(x: lbTitleSeriSim.frame.origin.x, y: lbTitleSeriSim.frame.origin.y + lbTitleSeriSim.frame.size.height + Common.Size(s:10), width: lbTitleSeriSim.frame.size.width - Common.Size(s:50), height: Common.Size(s:40) ));
        tfSerialSim.placeholder = "Số serial SIM"
        tfSerialSim.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSerialSim.borderStyle = UITextField.BorderStyle.roundedRect
        tfSerialSim.autocorrectionType = UITextAutocorrectionType.no
        tfSerialSim.keyboardType = UIKeyboardType.numberPad
        tfSerialSim.returnKeyType = UIReturnKeyType.done
        tfSerialSim.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfSerialSim.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSerialSim.delegate = self
        //        tfUserName.addTarget(self, action: #selector(textFieldDidChangeName(_:)), for: .editingChanged)
        scrollView.addSubview(tfSerialSim)
        
        tfSerialSim.leftViewMode = UITextField.ViewMode.always
        
        
        
        let btnScan = UIImageView(frame:CGRect(x: tfSerialSim.frame.size.width + tfSerialSim.frame.origin.x + Common.Size(s: 10) , y:  tfSerialSim.frame.origin.y, width: Common.Size(s:25), height: tfSerialSim.frame.size.height));
        btnScan.image = #imageLiteral(resourceName: "scan_barcode_1")
        btnScan.contentMode = .scaleAspectFit
        scrollView.addSubview(btnScan)
        
        let tapScan = UITapGestureRecognizer(target: self, action: #selector(actionScan(_:)))
        btnScan.isUserInteractionEnabled = true
        btnScan.addGestureRecognizer(tapScan)
        
        
        // input ma otp
        let lblMaOTP =  UILabel(frame: CGRect(x: lbTitleSeriSim.frame.origin.x, y: tfSerialSim.frame.origin.y + tfSerialSim.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblMaOTP.textAlignment = .left
        lblMaOTP.textColor = UIColor.black
        lblMaOTP.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblMaOTP.text = "Mã OTP"
        scrollView.addSubview(lblMaOTP)
        
        
        tfMaOTP = UITextField(frame: CGRect(x: lblMaOTP.frame.origin.x, y: lblMaOTP.frame.origin.y + lblMaOTP.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)));
        tfMaOTP.placeholder = "Vui lòng nhập mã OTP"
        
        tfMaOTP.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfMaOTP.borderStyle = UITextField.BorderStyle.roundedRect
        tfMaOTP.autocorrectionType = UITextAutocorrectionType.no
        tfMaOTP.keyboardType = UIKeyboardType.default
        tfMaOTP.returnKeyType = UIReturnKeyType.done
        tfMaOTP.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfMaOTP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfMaOTP.delegate = self
        scrollView.addSubview(tfMaOTP)
        
        
        btnConfirm = UIButton()
        btnConfirm.frame = CGRect(x: tfMaOTP.frame.origin.x, y: tfMaOTP.frame.origin.y + tfMaOTP.frame.size.height + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:30),height: Common.Size(s:40))
        btnConfirm.backgroundColor = UIColor(netHex:0xEF4A40)
        btnConfirm.setTitle("Kiểm tra", for: .normal)
        btnConfirm.addTarget(self, action: #selector(actionConfirm), for: .touchUpInside)
        btnConfirm.layer.borderWidth = 0.5
        btnConfirm.layer.borderColor = UIColor.white.cgColor
        btnConfirm.layer.cornerRadius = 3
        scrollView.addSubview(btnConfirm)
        btnConfirm.clipsToBounds = true
    }
    
    func scanSuccess(_ viewController: ScanImeiConvert4GViewController, scan: String){
        print("VOUCHER_KG \(scan)")
        if(scan != "SELECT_SERI_SIM_4G"){
            tfSerialSim.text = scan
        }else{
            tfSerialSim.text = ""
        }
    }
    
    
    @objc func actionScan(_: UITapGestureRecognizer){
        let newViewController = ScanImeiConvert4GViewController()
        newViewController.delegate = self
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func actionConfirm(){
        self.hideKeyBoard()
        if(tfSerialSim.text == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Nhập số Seri Sim!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        if(tfMaOTP.text == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Nhập mã OTP!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            
            return
        }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gửi mã OTP..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.ChangeSim4G(sdt:phone!,iccid:tfSerialSim.text!,otp:tfMaOTP.text!) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if (results.Success == true){
                    if(results.change4GResultData?.code == 0){
                        let popup = PopupDialog(title: "Thông báo", message: results.change4GResultData?.message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                            
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }else{
                        let popup = PopupDialog(title: "Thông báo", message: results.Message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                            
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                    
                    
                }else{
                    if(results.Message != ""){
                        let popup = PopupDialog(title: "Thông báo", message: results.Message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                        }
                        let buttonOne = CancelButton(title: "OK") {
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                        
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
    func hideKeyBoard(){
        self.tfSerialSim.resignFirstResponder()
        self.tfMaOTP.resignFirstResponder()
    }
}

