//
//  CheckSBDViewController.swift
//  fptshop
//
//  Created by Apple on 6/26/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CheckSBDViewController: UIViewController {
    
    var tfSBDText: UITextField!
    var btnCheck: UIButton!
    var lblDetail: UILabel!
    var phone = ""
    var isFromSearch = true
    var isFromModule:Bool = false

    var tracocItem: CustomerTraCoc?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tân sinh viên 2022"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        let lblSBD = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:15), width: self.view.frame.width - Common.Size(s:30), height: Common.Size(s:20)))
        lblSBD.text = "Số báo danh:"
        lblSBD.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(lblSBD)
        
        tfSBDText = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblSBD.frame.origin.y + lblSBD.frame.height + Common.Size(s:5), width: self.view.frame.width - Common.Size(s:30), height: Common.Size(s:35)))
        tfSBDText.borderStyle = .roundedRect
        tfSBDText.text = "34003552"
        tfSBDText.clearButtonMode = UITextField.ViewMode.whileEditing
        self.view.addSubview(tfSBDText)
        
        btnCheck = UIButton(frame: CGRect(x: Common.Size(s:15), y: tfSBDText.frame.origin.y + tfSBDText.frame.height + Common.Size(s:15), width: self.view.frame.width - Common.Size(s:30), height: Common.Size(s:40)))
        btnCheck.setTitle("KIỂM TRA", for: .normal)
        btnCheck.layer.cornerRadius = 5
        btnCheck.backgroundColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        btnCheck.addTarget(self, action: #selector(checkSoBaoDanh), for: .touchUpInside)
        
        lblDetail = UILabel(frame: CGRect(x: Common.Size(s:15), y: btnCheck.frame.origin.y + btnCheck.frame.height + Common.Size(s:15), width: self.view.frame.width - Common.Size(s:30), height: 70))
        lblDetail.text = "Ghi chú thông tin Sinh viên:\n\(tracocItem?.u_Desc ?? "...")"
        lblDetail.font = UIFont.systemFont(ofSize: 16)
        lblDetail.numberOfLines = 0
        lblDetail.textColor = Constants.COLORS.main_red_my_info
        self.view.addSubview(lblDetail)
        self.view.addSubview(btnCheck)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.tfSBDText != nil {
            self.tfSBDText.text = ""
        }
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func checkSoBaoDanh() {
        guard let sbd = self.tfSBDText.text, !sbd.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập số báo danh!")
            return
        }
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.BackToSchool_CheckSBD(SoBaoDanh: sbd, handler: { (success, errorMsg, result, err) in
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if success == "1" {
                        if result != nil {
                            if result?.Result == 0 {
                                self.showAlert(title: "Thông báo", message: errorMsg)
                            } else {
                                let newViewController = BackToSchoolNewVC()
                                newViewController.tracocItem = self.tracocItem
                                newViewController.isNewStudent = true
                                newViewController.phone = self.phone
                                newViewController.isFromSearch = self.isFromSearch
                                newViewController.isFromModule = self.isFromModule
                                newViewController.idBTS = result?.ID_BackToSchool ?? 0
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                            
                        } else {
                            debugPrint("Không lấy được data")
                        }
                    } else {
                        self.showAlert(title: "Thông báo", message: errorMsg)
                    }
                }
            })
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
}
