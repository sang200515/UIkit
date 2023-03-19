//
//  SearchVendorViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class SearchVendorViewController: UIViewController,UITextFieldDelegate {
    
    var scrollView:UIScrollView!
    var companyButton: SearchTextField!
    var listCompany:[SearchVendor] = []
    var vendorCode:String  = ""
    var tfBank:UITextField!
    var lbStatus,lbTextStatus:UILabel!
    override func viewDidLoad() {
        self.title = "Tra cứu Doanh nghiệp"
        super.viewDidLoad()
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lbTextCompany = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCompany.textAlignment = .left
        lbTextCompany.textColor = UIColor.black
        lbTextCompany.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCompany.text = "Chọn doanh nghiệp (*)"
        scrollView.addSubview(lbTextCompany)
        
        companyButton = SearchTextField(frame: CGRect(x: lbTextCompany.frame.origin.x, y: lbTextCompany.frame.origin.y + lbTextCompany.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        companyButton.placeholder = "Chọn tên doanh nghiệp"
        companyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton.autocorrectionType = UITextAutocorrectionType.no
        companyButton.keyboardType = UIKeyboardType.default
        companyButton.returnKeyType = UIReturnKeyType.done
        companyButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        companyButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        companyButton.delegate = self
        scrollView.addSubview(companyButton)
        
        companyButton.startVisible = true
        companyButton.theme.bgColor = UIColor.white
        companyButton.theme.fontColor = UIColor.black
        companyButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.theme.cellHeight = Common.Size(s:40)
        companyButton.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        
        
        let btSaveCustomer = UIButton()
        btSaveCustomer.frame = CGRect(x: companyButton.frame.origin.x, y: companyButton.frame.size.height + companyButton.frame.origin.y + Common.Size(s:20), width: companyButton.frame.size.width, height: companyButton.frame.size.height * 1.2)
        btSaveCustomer.backgroundColor = UIColor(netHex:0xEF4A40)
        btSaveCustomer.setTitle("Tra cứu Doanh nghiệp", for: .normal)
        btSaveCustomer.addTarget(self, action: #selector(actionSaveCustomer), for: .touchUpInside)
        btSaveCustomer.layer.borderWidth = 0.5
        btSaveCustomer.layer.borderColor = UIColor.white.cgColor
        btSaveCustomer.layer.cornerRadius = 3
        scrollView.addSubview(btSaveCustomer)
        
        
        lbTextStatus = UILabel(frame: CGRect(x: Common.Size(s:15), y: btSaveCustomer.frame.size.height + btSaveCustomer.frame.origin.y + Common.Size(s:20), width: scrollView.frame.size.width/2 - Common.Size(s:30), height: Common.Size(s:16)))
        lbTextStatus.textAlignment = .left
        lbTextStatus.textColor = UIColor.black
        lbTextStatus.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTextStatus.text = "Kết quả tìm được:"
        lbTextStatus.numberOfLines = 2
        scrollView.addSubview(lbTextStatus)
        lbTextStatus.isHidden = true
        
        let sizeContent = "".height(withConstrainedWidth: scrollView.frame.size.width - Common.Size(s:30), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
        
        lbStatus = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTextStatus.frame.size.height + lbTextStatus.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: sizeContent))
        lbStatus.textAlignment = .left
        lbStatus.textColor = UIColor.black
        lbStatus.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbStatus.text = ""
        lbStatus.numberOfLines = 10
        scrollView.addSubview(lbStatus)
        lbStatus.isHidden = true
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: lbStatus.frame.origin.y + lbStatus.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 20))
        
        companyButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.companyButton.text = item.title
            let obj =  self.listCompany.filter{ $0.Name == "\(item.title)" }.first
            if let id = obj?.Code {
                self.vendorCode = "\(id)"
            }
        }
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin doanh nghiệp..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_sp_getVendors_All(handler: { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count<=0){
                    var listCom: [String] = []
                    self.listCompany = results
                    for item in results {
                        listCom.append("\(item.Name)")
                    }
                    self.companyButton.filterStrings(listCom)
                }else{
                    
                }
            }
        })
    }
    @objc func actionSaveCustomer(){
        
        let company = self.vendorCode
        if (company.count == 0){
            let alert = UIAlertController(title: "Thông báo", message: "Doanh nghiệp không được để trống!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông doanh nghiệp..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_sp_SearchVendor(vendor: "\(vendorCode)", handler: { (result, err) in
            
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.lbTextStatus.isHidden = false
                    self.lbStatus.isHidden = false
                    let result1 = result.replacingOccurrences(of: "\\r\\n", with: "\r\n", options: .literal, range: nil)
                    let sizeContent = result1.height(withConstrainedWidth: self.scrollView.frame.size.width - Common.Size(s:30), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
                    self.lbStatus.frame.size.height = sizeContent
                    self.lbStatus.text = result1
                    self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.lbStatus.frame.origin.y + self.lbStatus.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 20))
                }else{
                    self.lbTextStatus.isHidden = true
                    self.lbStatus.isHidden = true
                    let sizeContent = result.height(withConstrainedWidth: self.scrollView.frame.size.width - Common.Size(s:30), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
                    self.lbStatus.frame.size.height = sizeContent
                    self.lbStatus.text = result
                    self.lbStatus.numberOfLines = 10
                    self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.lbStatus.frame.origin.y + self.lbStatus.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 20))
                    
                    let title = "THÔNG BÁO"
                    let message = err
                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
                
            }
        })
    }
}

