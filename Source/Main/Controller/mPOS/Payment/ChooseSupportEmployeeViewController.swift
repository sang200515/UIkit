//
//  ChooseSupportEmployeeViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import Toaster
protocol ChooseSupportEmployeeViewControllerDelegate: NSObjectProtocol {
    
    func  supportEmployee(is_sale_MDMH:String,is_sale_software: String)
    
}

class ChooseSupportEmployeeViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate{
    
    weak var delegate: ChooseSupportEmployeeViewControllerDelegate?
    var scrollView:UIScrollView!
    
    var supportMDMHButton: SearchTextField!
    var supportSoftwareButton: SearchTextField!
    
    var listSupport:[SupportEmployee] = []
    var is_sale_MDMH:String = ""
    var is_sale_software:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Nhân viên hỗ trợ"
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x47B054)
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lbTextMDMH = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextMDMH.textAlignment = .left
        lbTextMDMH.textColor = UIColor.black
        lbTextMDMH.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextMDMH.text = "Nhân viên dán màn hình"
        scrollView.addSubview(lbTextMDMH)
        
        supportMDMHButton = SearchTextField(frame: CGRect(x: lbTextMDMH.frame.origin.x, y: lbTextMDMH.frame.origin.y + lbTextMDMH.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        supportMDMHButton.placeholder = "Chọn NV dán màn hình"
        supportMDMHButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        supportMDMHButton.borderStyle = UITextField.BorderStyle.roundedRect
        supportMDMHButton.autocorrectionType = UITextAutocorrectionType.no
        supportMDMHButton.keyboardType = UIKeyboardType.default
        supportMDMHButton.returnKeyType = UIReturnKeyType.done
        supportMDMHButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        supportMDMHButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        supportMDMHButton.delegate = self
        scrollView.addSubview(supportMDMHButton)
        
        supportMDMHButton.startVisible = true
        supportMDMHButton.theme.bgColor = UIColor.white
        supportMDMHButton.theme.fontColor = UIColor.black
        supportMDMHButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        supportMDMHButton.theme.cellHeight = Common.Size(s:40)
        supportMDMHButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        supportMDMHButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.supportMDMHButton.text = item.title
            let obj =  self.listSupport.filter{ $0.EmployeeName == "\(item.title)" }.first
            if let id = obj?.EmployeeCode {
                self.is_sale_MDMH = id
            }
        }
        
        let lbTextSoftware = UILabel(frame: CGRect(x: Common.Size(s:15), y: supportMDMHButton.frame.origin.y + supportMDMHButton.frame.size.height + Common.Size(s:15), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoftware.textAlignment = .left
        lbTextSoftware.textColor = UIColor.black
        lbTextSoftware.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoftware.text = "Nhân viên cài ứng dụng"
        scrollView.addSubview(lbTextSoftware)
        
        supportSoftwareButton = SearchTextField(frame: CGRect(x: lbTextMDMH.frame.origin.x, y: lbTextSoftware.frame.origin.y + lbTextSoftware.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        supportSoftwareButton.placeholder = "Chọn NV cài ứng dụng"
        supportSoftwareButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        supportSoftwareButton.borderStyle = UITextField.BorderStyle.roundedRect
        supportSoftwareButton.autocorrectionType = UITextAutocorrectionType.no
        supportSoftwareButton.keyboardType = UIKeyboardType.default
        supportSoftwareButton.returnKeyType = UIReturnKeyType.done
        supportSoftwareButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        supportSoftwareButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        supportSoftwareButton.delegate = self
        scrollView.addSubview(supportSoftwareButton)
        
        supportSoftwareButton.startVisible = true
        supportSoftwareButton.theme.bgColor = UIColor.white
        supportSoftwareButton.theme.fontColor = UIColor.black
        supportSoftwareButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        supportSoftwareButton.theme.cellHeight = Common.Size(s:40)
        supportSoftwareButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        supportSoftwareButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.supportSoftwareButton.text = item.title
            let obj =  self.listSupport.filter{ $0.EmployeeName == "\(item.title)" }.first
            if let id = obj?.EmployeeCode {
                self.is_sale_software = id
            }
        }
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: lbTextSoftware.frame.origin.x, y: supportSoftwareButton.frame.origin.y + supportSoftwareButton.frame.size.height + Common.Size(s:20), width: supportSoftwareButton.frame.size.width, height: supportSoftwareButton.frame.size.height * 1.2)
        btPay.backgroundColor = UIColor(netHex:0xEF4A40)
        btPay.setTitle("XÁC NHẬN", for: .normal)
        btPay.addTarget(self, action: #selector(actionPay), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        scrollView.addSubview(btPay)
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin nhân viên..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.sp_mpos_FRT_SP_innovation_loadDS_nhanvien { (results, err) in
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    var listCom: [String] = []
                    self.listSupport = results
                    for item in results {
                        listCom.append("\(item.EmployeeName)")
                    }
                    self.supportMDMHButton.filterStrings(listCom)
                    self.supportSoftwareButton.filterStrings(listCom)
                }else{
                    let alertController = UIAlertController(title: "Thông báo", message: "Không tìm thấy thông tin nhân viên!", preferredStyle: .alert)
                    let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        _ = self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                    alertController.addAction(confirmAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func actionPay(sender: UIButton!) {
        self.delegate?.supportEmployee(is_sale_MDMH: self.is_sale_MDMH, is_sale_software: is_sale_software)
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}
