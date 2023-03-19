//
//  ListCustomerInfoViewController.swift
//  fptshop
//
//  Created by Apple on 4/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Toaster


class ListCustomerInfoViewController: UIViewController {
    
    var tableView: UITableView!
    var cellHeight:CGFloat = 0
    var listCustomerInfo = [SimCustomer]()
    var phone = ""
    var cmndNumber = ""
    var listProvinces = [Province]()
    var sim: SimThuong?
    var customerInfo: SimCustomer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chọn thông tin khách hàng"
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        //
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 45)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(tableView)
        tableView.register(EsimCustomerCell.self, forCellReuseIdentifier: "eSimCustomerCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    
    func showMessage(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
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
            //            textField.keyboardType = inputKeyboardType
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
    
    func getOPT(sdt: String, info: SimCustomer) {
        ProgressView.shared.show()
            MPOSAPIManager.VTSendOTPErp(isdn: sdt, handler: { (success, message, err) in
                ProgressView.shared.hide()
                    if success {
                        
                        self.showInputDialog(title: "Xác nhận", subtitle: "Nhập mã OTP được gửi về máy khách hàng", actionTitle1: "Gửi lại OTP", actionTitle2: "Xác nhận", inputPlaceholder: "Nhập mã OTP", inputKeyboardType: .default, actionHandler1: { (_) in
                            self.getOPT(sdt: sdt, info: info)
                            
                        }, actionHandler2: { (otpString) in
                            if otpString == "" {
                                Toast(text: "Bạn chưa nhập OTP!").show()
                                return
                            }
                            ProgressView.shared.show()
                            MPOSAPIManager.VTGetSimInfoByPhoneNumber(isdn: sdt, handler: { (results, message) in
                                    
                                    ProgressView.shared.hide()
                                        if results != nil {
                                            let newViewController = ChangeSimViewController()
                                            newViewController.customerInfo = info
                                            newViewController.provinceID = info.province
                                            newViewController.phone = sdt
                                            newViewController.cmndNumber = self.cmndNumber
                                            newViewController.listProvinces = self.listProvinces
                                            newViewController.sim = results
                                            newViewController.isOtp = 0
                                            newViewController.otpString = otpString ?? ""
                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                        } else {
                                            self.showMessage(title: "Thông báo", message: message)
                                        }
                                    
                                })
                                ////--------
                                
                            
                        })
                    } else {
                        self.showMessage(title: "Thông báo", message: message)
                    }
                
            })
        
    }
}



extension ListCustomerInfoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if listCustomerInfo.count > 1 {
            return listCustomerInfo.count - 1
        } else {
            return listCustomerInfo.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EsimCustomerCell = tableView.dequeueReusableCell(withIdentifier: "eSimCustomerCell", for: indexPath) as! EsimCustomerCell
        
        cell.subviews.forEach({$0.removeFromSuperview()})
        customerInfo = listCustomerInfo[indexPath.row]
        cellHeight = cell.estimateCellHeight
        cell.setUpCell(item: customerInfo!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customerInfo = listCustomerInfo[indexPath.row]
        let alertVC = UIAlertController(title: "Thông báo", message: "Để cập nhật Sim, số TB của bạn phải còn nguyên vẹn trên máy!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Lấy OTP", style: .default) { (_) in
            self.getOPT(sdt: self.phone, info: self.customerInfo!)
        }
        let cancel = UIAlertAction(title: "Hủy", style: .default, handler: nil)
        alertVC.addAction(cancel)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
        
        
    }
    
}

class EsimCustomerCell: UITableViewCell {
    
    var lbCustomerName: UILabel!
    var lblAddressText: UILabel!
    var lblBirthDate: UILabel!
    
    var estimateCellHeight: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    func setUpCell(item: SimCustomer) {
        let lblName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 8, width: (self.contentView.frame.width - 15)/3, height: 15))
        lblName.text = "Họ tên:"
        lblName.font = UIFont.systemFont(ofSize: 13)
        lblName.textColor = UIColor.lightGray
        self.addSubview(lblName)
        
        lbCustomerName = UILabel(frame: CGRect(x: lblName.frame.width, y: lblName.frame.origin.y, width: self.contentView.frame.width - lblName.frame.width - Common.Size(s: 15), height: Common.Size(s: 15)))
        lbCustomerName.font = UIFont.boldSystemFont(ofSize: 13)
        lbCustomerName.text = "\(item.name)"
        self.addSubview(lbCustomerName)
        
        //
        let lblAddress = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbCustomerName.frame.origin.y + lbCustomerName.frame.height + 5, width: lblName.frame.width, height: Common.Size(s: 15)))
        lblAddress.text = "Địa chỉ:"
        lblAddress.font = UIFont.systemFont(ofSize: 13)
        lblAddress.textColor = UIColor.lightGray
        self.addSubview(lblAddress)
        
        lblAddressText = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: lblAddress.frame.origin.y, width: lbCustomerName.frame.width, height: Common.Size(s: 15)))
        lblAddressText.text = "\(item.address)"
        lblAddressText.font = UIFont.systemFont(ofSize: 13)
        lblAddressText.frame = CGRect(x: lblAddressText.frame.origin.x, y: lblAddressText.frame.origin.y, width: lblAddressText.frame.width, height: lblAddressText.optimalHeight)
        lblAddressText.numberOfLines = 0
        self.addSubview(lblAddressText)
        //
        let lblAddressTextHeight = lblAddressText.optimalHeight == 0 ? Common.Size(s: 15) : lblAddressText.optimalHeight
        
        let lblNgaySinh = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblAddressText.frame.origin.y + lblAddressTextHeight + 5, width: lblName.frame.width, height: Common.Size(s: 15)))
        lblNgaySinh.text = "Ngày sinh:"
        lblNgaySinh.font = UIFont.systemFont(ofSize: 13)
        lblNgaySinh.textColor = UIColor.lightGray
        self.addSubview(lblNgaySinh)
        
        lblBirthDate = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: lblNgaySinh.frame.origin.y, width: lbCustomerName.frame.width, height: Common.Size(s: 15)))
        
        let dateFormatter = ISO8601DateFormatter()
        if let dateInLocal = dateFormatter.date(from: "\(item.birthDate)") {
            let dateNormalFormatter = DateFormatter()
            dateNormalFormatter.dateFormat = "dd/MM/yyyy"
            let dateString = dateNormalFormatter.string(from: dateInLocal)
            debugPrint(dateString)
            lblBirthDate.text = dateString
        }
        
        lblBirthDate.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lblBirthDate)
        
        
        
        estimateCellHeight = lblBirthDate.frame.origin.y + lblBirthDate.frame.height + Common.Size(s: 30)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
    }
}
