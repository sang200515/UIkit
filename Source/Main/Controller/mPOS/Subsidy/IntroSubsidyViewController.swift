//
//  IntroSubsidyViewController.swift
//  mPOS
//
//  Created by MinhDH on 4/23/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import PopupDialog
class IntroSubsidyViewController: UIViewController,UITextFieldDelegate{
    var scrollView:UIScrollView!
    
    var tfCMND:UITextField!
    var tfStatus:UITextField!
    
    override func viewDidLoad() {
        self.title = "Tư vấn Subsidy"
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(IntroSubsidyViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)

        navigationController?.navigationBar.isTranslucent = false
        
        let lbUserInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: 0))
        lbUserInfo.textAlignment = .center
        lbUserInfo.textColor = UIColor(netHex:0x47B054)
        lbUserInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbUserInfo.text = "TƯ VẤN SUBSIDY"
        scrollView.addSubview(lbUserInfo)
        
        let lbTextCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbUserInfo.frame.size.height + lbUserInfo.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMND.textAlignment = .left
        lbTextCMND.textColor = UIColor.black
        lbTextCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMND.text = "Tiền cước đã chi tiêu trong 1 tháng:"
        scrollView.addSubview(lbTextCMND)
        
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextCMND.frame.origin.y + lbTextCMND.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:40)));
        tfCMND.placeholder = "Nhập số tiền cước"
        tfCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMND.autocorrectionType = UITextAutocorrectionType.no
        tfCMND.keyboardType = UIKeyboardType.numberPad
        tfCMND.returnKeyType = UIReturnKeyType.done
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMND.delegate = self
        tfCMND.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        scrollView.addSubview(tfCMND)
        
        let lbTextStatus = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfCMND.frame.size.height + tfCMND.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextStatus.textAlignment = .left
        lbTextStatus.textColor = UIColor.black
        lbTextStatus.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextStatus.text = "Địa chỉ khách hàng:"
        scrollView.addSubview(lbTextStatus)
        
        tfStatus = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextStatus.frame.size.height + lbTextStatus.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)))
        tfStatus.placeholder = "Nhập địa chỉ khách hàng"
        tfStatus.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfStatus.borderStyle = UITextField.BorderStyle.roundedRect
        tfStatus.autocorrectionType = UITextAutocorrectionType.no
        tfStatus.keyboardType = UIKeyboardType.default
        tfStatus.returnKeyType = UIReturnKeyType.done
        tfStatus.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfStatus.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfStatus.delegate = self
        tfStatus.textAlignment = .left
        tfStatus.autocapitalizationType = .words
        scrollView.addSubview(tfStatus)
        
        
        tfStatus.text = "\(Cache.user!.Address)"
        
        tfStatus.isEnabled = false
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: tfStatus.frame.origin.x, y: tfStatus.frame.origin.y + tfStatus.frame.size.height + Common.Size(s:20), width: tfStatus.frame.size.width, height: tfStatus.frame.size.height * 1.2)
        btPay.backgroundColor = UIColor(netHex:0xEF4A40)
        btPay.setTitle("Tư vấn", for: .normal)
        btPay.addTarget(self, action: #selector(actionPay), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        scrollView.addSubview(btPay)
        self.hideKeyboardWhenTappedAround()
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
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
        }else{
            textField.text = ""
        }
        
    }
    @objc func actionPay(sender: UIButton!) {
        var money = tfCMND.text!
        money = money.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        let address = tfStatus.text!
        if(address.isEmpty || money.isEmpty){
            Toast(text: "Bạn phải nhập thông tin khách hàng!").show()
            return
        }
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.sp_mpos_Get_SSD_GoiCuoc_for_MPOS(tienChiTieu: "\(money)", Provider: "\(address)") { (results, err) in
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    let viewController = PackageSubsidyViewController()
                    viewController.listSSD = results
                    viewController.money = Float(money)!
                    self.navigationController?.pushViewController(viewController, animated: true)
                }else{
                    let popup = PopupDialog(title: "THÔNG BÁO", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
