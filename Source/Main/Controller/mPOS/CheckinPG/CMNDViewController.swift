//
//  CMNDViewController.swift
//  CheckIn
//
//  Created by Apple on 1/17/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class CMNDViewController: UIViewController {
    var tfCMND: UITextField!
    var imgList: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Check in PG"
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "LSCC.png"), style: .plain, target: self, action: #selector(showListHistory))
        //
        let lblCmnd = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:15), width: self.view.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:50)))
        lblCmnd.text = "CMND"
        lblCmnd.font = UIFont.systemFont(ofSize: 17)
        self.view.addSubview(lblCmnd)
        
        //
        tfCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblCmnd.frame.origin.y + lblCmnd.frame.height, width: self.view.frame.width - (2 * Common.Size(s:15)), height: Common.Size(s:35)))
        tfCMND.borderStyle = .roundedRect
        tfCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        self.view.addSubview(tfCMND)
        
        tfCMND.keyboardType = .decimalPad
        tfCMND.returnKeyType = .default
        tfCMND.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tfCMND.text = ""
    }
    
    @objc func showListHistory() {
        let historyVC = HistoryCheckInViewController()
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == tfCMND){
            textField.resignFirstResponder()
            self.getEmployeeInfo()
        }
        
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    func getEmployeeInfo() {
        guard let cmnd = tfCMND.text, !cmnd.isEmpty else {
            showAlert(title: "Thông báo", message: "Bạn chưa nhập CMND!")
            return
        }
        guard (cmnd.count == 9) || (cmnd.count == 12) else {
            showAlert(title: "Thông báo", message: "CMND không hợp lệ!")
            return
        }
        if self.isNumber(string: cmnd) == false {
            showAlert(title: "Thông báo", message: "CMND không hợp lệ!")
            return
        }
        self.tfCMND.resignFirstResponder()
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            CRMAPIManager.PG_loadinfopg(personalid: "\(cmnd)") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs.count > 0 {
                            let vc = CheckInViewController()
                            vc.pgInfo = rs[0]
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "PG không tồn tại, bạn vui lòng báo với ngành hàng kiểm tra lại thông tin PG", preferredStyle: .alert)
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
        
    }
    
    func isNumber(string: String) -> Bool{
        let numberCharacters = NSCharacterSet.decimalDigits.inverted
        if !string.isEmpty && string.rangeOfCharacter(from: numberCharacters) == nil {
            debugPrint("numstring right")
            return true
        } else {
            return false
        }
    }
}
