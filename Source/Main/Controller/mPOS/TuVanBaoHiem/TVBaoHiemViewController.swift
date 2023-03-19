//
//  TVBaoHiemViewController.swift
//  fptshop
//
//  Created by Apple on 9/23/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DLRadioButton

class TVBaoHiemViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var radioNam:DLRadioButton!
    var radioNu:DLRadioButton!
    var tfUserName: UITextField!
    var tfPhone: UITextField!
    var tfAddress: UITextField!
    var tfNote: UITextField!
    var btnConfirm: UIButton!
//    var genderType = 1
 
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Thông tin khách hàng"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        self.hideKeyboardWhenTappedAround()
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: viewRightNav)
        let btHistoryIcon = UIButton.init(type: .custom)
        btHistoryIcon.setImage(#imageLiteral(resourceName: "icon_history"), for: UIControl.State.normal)
        btHistoryIcon.imageView?.contentMode = .scaleAspectFit
        btHistoryIcon.addTarget(self, action: #selector(actionGoHistory), for: UIControl.Event.touchUpInside)
        btHistoryIcon.frame = CGRect(x: 15, y: 0, width: Common.Size(s:35), height: Common.Size(s:40))
        viewRightNav.addSubview(btHistoryIcon)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lbName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbName.text = "Tên khách hàng"
        lbName.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbName)
        
        tfUserName = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbName.frame.origin.y + lbName.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfUserName.borderStyle = .roundedRect
        tfUserName.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(tfUserName)
        
        let lbGender = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfUserName.frame.origin.y + tfUserName.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbGender.text = "Giới tính"
        lbGender.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbGender)
        
        radioNam = createRadioButtonGender(CGRect(x: Common.Size(s: 15), y: lbGender.frame.origin.y + lbGender.frame.height + Common.Size(s: 5), width: (self.view.frame.size.width - Common.Size(s: 30))/2, height: 15), title: "Nam", color: UIColor.black)
        scrollView.addSubview(radioNam)
        
        radioNu = createRadioButtonGender(CGRect(x: radioNam.frame.origin.x + radioNam.frame.size.width ,y: radioNam.frame.origin.y, width: radioNam.frame.size.width, height: radioNam.frame.size.height), title: "Nữ", color: UIColor.black)
        scrollView.addSubview(radioNu)
        
        
        let lbSdt = UILabel(frame: CGRect(x: Common.Size(s: 15), y: radioNu.frame.origin.y + radioNu.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbSdt.text = "Số điện thoại"
        lbSdt.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSdt)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbSdt.frame.origin.y + lbSdt.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfPhone.borderStyle = .roundedRect
        tfPhone.font = UIFont.systemFont(ofSize: 14)
        tfPhone.keyboardType = .numberPad
        scrollView.addSubview(tfPhone)
        
        let lbDiaChi = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfPhone.frame.origin.y + tfPhone.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbDiaChi.text = "Địa chỉ"
        lbDiaChi.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbDiaChi)
        
        tfAddress = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbDiaChi.frame.origin.y + lbDiaChi.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfAddress.borderStyle = .roundedRect
        tfAddress.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(tfAddress)
        
        let lbGhiChu = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfAddress.frame.origin.y + tfAddress.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbGhiChu.text = "Ghi chú"
        lbGhiChu.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbGhiChu)
        
        tfNote = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbGhiChu.frame.origin.y + lbGhiChu.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfNote.borderStyle = .roundedRect
        tfNote.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(tfNote)
        
        btnConfirm = UIButton(frame: CGRect(x: Common.Size(s: 15), y: tfNote.frame.origin.y + tfNote.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnConfirm.setTitle("XÁC NHẬN", for: .normal)
        btnConfirm.backgroundColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        btnConfirm.layer.cornerRadius = 5
        btnConfirm.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        scrollView.addSubview(btnConfirm)
        
        scrollViewHeight = btnConfirm.frame.origin.y + btnConfirm.frame.height + ((navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)

    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func confirm() {
        
        guard let fullName = self.tfUserName.text, !fullName.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập tên khách hàng!")
            return
        }
        
        guard let sdt = self.tfPhone.text, !sdt.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập số điện thoại!")
            return
        }
        
        if (sdt.count != 10) || (sdt.hasPrefix("00")){
            self.showAlert(title: "Thông báo", message: "Số điện thoại không hợp lệ!")
            return
        }
        
        guard let address = self.tfAddress.text, !address.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập địa chỉ!")
            return
        }
        
        var gender = ""
        if self.radioNam.isSelected == true {
            gender = "M"
        } else if self.radioNu.isSelected == true {
            gender = "F"
        } else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn giới tính!")
            return
        }
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.mpos_FRT_SP_BH_insert_thongtinKH(fullname: fullName, gender: gender, phonenumber: sdt, address: address, note: self.tfNote.text ?? "", handler: { (statusCode, msg, err) in
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if statusCode == 1 {
                            let alertVC = UIAlertController(title: "Thông báo", message: "\(msg)", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
                                self.navigationController?.popViewController(animated: true)
                            })
                            alertVC.addAction(action)
                            self.present(alertVC, animated: true, completion: nil)
                        } else {
                            self.showAlert(title: "Thông báo", message: "\(msg)")
                        }
                    } else {
                        self.showAlert(title: "Thông báo", message: "\(err)")
                    }

                }
            })
        }
    }
    
    @objc func actionGoHistory() {
        let vc = HistoryTVBaohiemViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func createRadioButtonGender(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 13);
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    @objc fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioNam.isSelected = false
            radioNu.isSelected = false
            switch temp {
            case "Nam":
                radioNam.isSelected = true
                break
            case "Nữ":
                radioNu.isSelected = true
                break
                
            default:
                break
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}
