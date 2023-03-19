//
//  InputOTPUpdateTBViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 8/4/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit

class InputOTPUpdateTBViewController: UIViewController {
    // MARK: - Properties
    
    private var tfPhone:UITextField!
    private var btCreateOrder:UIButton!
    var typeSim = ""
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        self.title = "Cập nhật thông tin thuê bao"
        view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(InputOTPVNMViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
        //right menu icon
        let btRightIcon = UIButton.init(type: .custom)
        
        btRightIcon.setImage(#imageLiteral(resourceName: "update"),for: UIControl.State.normal)
        btRightIcon.imageView?.contentMode = .scaleAspectFit
        btRightIcon.addTarget(self, action: #selector(loadHistoryUpdatePhone), for: UIControl.Event.touchUpInside)
        btRightIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barRight = UIBarButtonItem(customView: btRightIcon)
        
        self.navigationItem.rightBarButtonItem = barRight
        
        
        
        
        let lbTextPhone =  UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone.textAlignment = .left
        lbTextPhone.textColor = UIColor.black
        lbTextPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone.text = "Số điện thoại"
        view.addSubview(lbTextPhone)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhone.frame.origin.y + lbTextPhone.frame.size.height + Common.Size(s:5), width: view.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfPhone.placeholder = "Nhập số điện thoại khách hàng"
        tfPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhone.autocorrectionType = UITextAutocorrectionType.no
        tfPhone.keyboardType = UIKeyboardType.numberPad
        tfPhone.returnKeyType = UIReturnKeyType.done
        tfPhone.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        view.addSubview(tfPhone)
  
        
        btCreateOrder = UIButton()
        btCreateOrder.frame = CGRect(x: tfPhone.frame.origin.x, y: tfPhone.frame.origin.y + tfPhone.frame.size.height + Common.Size(s:20), width: view.frame.size.width - Common.Size(s:30),height: Common.Size(s:40))
        btCreateOrder.backgroundColor = UIColor(netHex:0x00955E)
        btCreateOrder.setTitle("Kiểm tra", for: .normal)
        btCreateOrder.addTarget(self, action: #selector(actionSendOTP), for: .touchUpInside)
        btCreateOrder.layer.borderWidth = 0.5
        btCreateOrder.layer.borderColor = UIColor.white.cgColor
        btCreateOrder.layer.cornerRadius = 3
        view.addSubview(btCreateOrder)
        btCreateOrder.clipsToBounds = true
    }
    
    // MARK: - API
    
    // MARK: - Selectors
    
    
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func loadHistoryUpdatePhone(){
        if typeSim == "VNM" {
            let newViewController = HistoryUpdateVNMViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        } else if typeSim == "Itel" {
            let newViewController = HistoryUpdateItelViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    @objc func actionSendOTP(){
        guard let sdt = tfPhone.text else {
            return
        }
        
        if (sdt=="") {
           
            self.showPopUp("Vui lòng nhập số điện thoại khách hàng", "Thông báo", buttonTitle: "OK")
            return
        }
        
        if (sdt.hasPrefix("01") && sdt.count == 11){
            
        }else if (sdt.hasPrefix("0") && !sdt.hasPrefix("01") && sdt.count == 10){
            
        }else{
            
            self.showPopUp("Số điện thoại nhập sai định dạng!!!", "Thông báo", buttonTitle: "OK")
            return
        }
        if typeSim == "VNM" {
            checkOTPVNM(sdt:sdt)
        }else if typeSim == "Itel" {
            checkOTPItel(sdt:sdt)
        }
        
        
    }
    
    func checkOTPVNM(sdt:String){
        self.tfPhone.resignFirstResponder()
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gửi mã OTP..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.SendOTPInfoActiveSim(isdn: sdt) {[weak self] (results, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if (results?.code==0){
                        
                        MPOSAPIManager.getInfoActiveSimbyPhone(sdt: sdt) { (results, err) in
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                
                                if(err.count <= 0){
                                    if(results.count > 0){
                                        let vc = SimUpdateVNMViewController()
                                        
                                        results[0].sdt = sdt
                                        vc.infoActiveSimByPhone = results[0]
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }else{
                                        let infoActiveSim = InfoActiveSimbyPhone(Address: "", FullName: "", FirstName: "", LastName: "", Birthday: "", DateCreateCMND: "", CMND: "", PalaceCreateCMND: "", ProvinceCode: "", Gender: 0, DistrictCode: "", Updateby: "", Updatedate: "", MaShop: "", URL_FileCMNDMatTruoc: "", URL_FileCMNDMatSau: "", URL_FileKH_TaiShop: "", PrecinctCode: "", Provider: "", SeriSIM: "", SoHopDong: 0, idNoiCapCMND: "", otp: "", sdt: "\(sdt)")
                                        let vc = SimUpdateVNMViewController()
                                        vc.infoActiveSimByPhone = infoActiveSim
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }
                                    
                                }else{
                                    self.showPopUp(err, "Thông báo", buttonTitle: "OK")
                                }
                            }
                        }
                    }else{
                        if(results?.message==""){
                            
                  
                            self.showPopUp(results?.otpActiveData?.status ?? "", "Thông báo", buttonTitle: "OK")
                            
                        }else{
                            
                            
                            self.showPopUp(results?.message ?? "", "Thông báo", buttonTitle: "OK")
                            
                        }
                    }
                }else{
                
                    self.showPopUp(err, "Thông báo", buttonTitle: "OK")
                }
                
            }
        }
    }
    
    func checkOTPItel(sdt:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gửi mã OTP..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        CRMAPIManager.Itel_SendOTPUpdate(isdn: sdt) { [weak self] (result, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(result == "DS01"){
                    let controller = SimUpdateItelViewController()
                    controller.sdt = sdt
                    self.navigationController?.pushViewController(controller, animated: true)
                }else{
                 
                    self.showPopUp(err, "Thông báo", buttonTitle: "OK")

                    
                }
                
            }
        }
    }
    
    // MARK: - Helpers
    

}
