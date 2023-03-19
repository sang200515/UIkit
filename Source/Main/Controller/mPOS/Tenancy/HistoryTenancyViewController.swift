//
//  HistoryTenancyViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/21/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import ActionSheetPicker_3_0
class HistoryTenancyViewController:UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate{

    var items: [RequestPaymentHistory] = []
    var tableView: UITableView = UITableView()
    var tfFromDate: UITextField!
    var tfSearch: UITextField!
    var valueFromDate:String = ""
    var filteredCandies = [RequestPaymentHistory]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.title = "Lịch sử"
        navigationController?.navigationBar.isTranslucent = false
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(HistoryTenancyViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        let viewHeader: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: Common.Size(s: 50)))
        self.view.addSubview(viewHeader)
        
        tfFromDate = UITextField(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 7.5), width: (viewHeader.frame.size.width - Common.Size(s: 30)) * 2/5, height: Common.Size(s:35)))
        tfFromDate.placeholder = "Chọn ngày"
        tfFromDate.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfFromDate.borderStyle = UITextField.BorderStyle.roundedRect
        tfFromDate.autocorrectionType = UITextAutocorrectionType.no
        tfFromDate.keyboardType = UIKeyboardType.default
        tfFromDate.returnKeyType = UIReturnKeyType.done
        tfFromDate.clearButtonMode = UITextField.ViewMode.whileEditing
        tfFromDate.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfFromDate.delegate = self
        tfFromDate.isUserInteractionEnabled = false
        viewHeader.addSubview(tfFromDate)
        
        let viewFromDate: UIView = UIView(frame: tfFromDate.frame)
        self.view.addSubview(viewFromDate)
        
        let viewFromDateImage: UIImageView = UIImageView(frame: CGRect(x: viewFromDate.frame.size.width - viewFromDate.frame.size.height, y: viewFromDate.frame.size.height/4, width: viewFromDate.frame.size.height, height: viewFromDate.frame.size.height/2))
        viewFromDateImage.image = UIImage(named:"Calender2")
        viewFromDateImage.contentMode = .scaleAspectFit
        viewFromDate.addSubview(viewFromDateImage)
        
        let tapFromDate = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFromDate(_:)))
        viewFromDate.addGestureRecognizer(tapFromDate)
        
        tfSearch  = UITextField(frame: CGRect(x: tfFromDate.frame.size.width + tfFromDate.frame.origin.x + Common.Size(s: 10), y: tfFromDate.frame.origin.y, width: (viewHeader.frame.size.width - Common.Size(s: 30)) * 3/5, height: Common.Size(s:35)))
        tfSearch.placeholder = "Tìm theo người tạo"
        tfSearch.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSearch.borderStyle = UITextField.BorderStyle.roundedRect
        tfSearch.autocorrectionType = UITextAutocorrectionType.no
        tfSearch.keyboardType = UIKeyboardType.default
        tfSearch.returnKeyType = UIReturnKeyType.done
        tfSearch.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSearch.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSearch.delegate = self
        viewHeader.addSubview(tfSearch)
        tfSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        tableView.frame = CGRect(x: 0, y:viewHeader.frame.origin.y + viewHeader.frame.size.height, width: viewHeader.frame.size.width, height: self.view.frame.size.height - viewHeader.frame.size.height - viewHeader.frame.origin.y - (self.navigationController?.navigationBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemHistoryTenancyTableViewCell.self, forCellReuseIdentifier: "ItemHistoryTenancyTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        valueFromDate = formatter.string(from: date)
        tfFromDate.text = valueFromDate
        loadData()
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        let keyString:String = textField.text!
        filteredCandies = items.filter({( candy : RequestPaymentHistory) -> Bool in
            return candy.CreateBy.lowercased().contains(keyString.lowercased())
        })
        tableView.reloadData()
    }
    func loadData(){
        let nc = NotificationCenter.default
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tải thông tin lịch sử..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        MPOSAPIManager.sp_FRT_Web_BrowserPaymentRequest_GetHistory(Date: valueFromDate) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results.count > 0){
                        self.items = results
                        TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                    }else{
                        self.items = results
                        TableViewHelper.EmptyMessage(message: "Không tìm thấy lịch sử.\n:/", viewController: self.tableView)
                    }
                    self.tableView.reloadData()
                }else{
                    let errorAlert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                        alert -> Void in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(errorAlert, animated: true, completion: nil)
                }
            }
        }
    }
    @objc func handleTapFromDate(_ sender: UITapGestureRecognizer? = nil) {
        let datePicker = ActionSheetDatePicker(title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strDate = dateFormatter.string(from: value as! Date)
            self.tfFromDate.text = "\(strDate)"
            self.tfSearch.text = ""
            self.tfSearch.resignFirstResponder()
            self.valueFromDate = strDate
            self.loadData()
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        datePicker?.show()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(tfSearch.text!.count > 0){
            return filteredCandies.count
        }else{
           return items.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemHistoryTenancyTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemHistoryTenancyTableViewCell")
        if(tfSearch.text!.count > 0){
            let item:RequestPaymentHistory = filteredCandies[indexPath.row]
             cell.setup(so: item)
        }else{
            let item:RequestPaymentHistory = items[indexPath.row]
             cell.setup(so: item)
        }
        cell.selectionStyle = .none
        return cell
    }
    @objc func tapDetected(sender:UITapGestureRecognizer) {
        items.remove(at: sender.view!.tag)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:143);
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
class ItemHistoryTenancyTableViewCell: UITableViewCell {
    var address: UILabel!
    var name: UILabel!
    var numMPOS: UILabel!
    var lbPhone: UILabel!
    var lbAddress: UILabel!
    var lbUser: UILabel!
    var lbStatus: UILabel!
    var line: UIView!
    var lineFooter: UIView!
    
    var valueName: UILabel!
    var valuePhone: UILabel!
    var valueAddress: UILabel!
    var valueUser: UILabel!
    var valueStatus: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        name = UILabel()
        name.textColor = UIColor(netHex:0x04AB6E)
        name.numberOfLines = 1
        name.textAlignment = .left
        name.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(name)
       
        address = UILabel()
        address.textColor = UIColor.black
        address.numberOfLines = 1
        address.textAlignment = .right
        address.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(address)
        
        line = UIView()
        line.backgroundColor = .lightGray
        contentView.addSubview(line)
        
        numMPOS = UILabel()
        numMPOS.textColor = UIColor.gray
        numMPOS.numberOfLines = 1
        numMPOS.textAlignment = .left
        numMPOS.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(numMPOS)
        
        lbPhone = UILabel()
        lbPhone.textColor = UIColor.gray
        lbPhone.numberOfLines = 1
        lbPhone.textAlignment = .left
        lbPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(lbPhone)
        
        lbAddress = UILabel()
        lbAddress.textColor = UIColor.gray
        lbAddress.numberOfLines = 1
        lbAddress.textAlignment = .left
        lbAddress.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(lbAddress)
        
        lbUser = UILabel()
        lbUser.textColor = UIColor.gray
        lbUser.numberOfLines = 1
        lbUser.textAlignment = .left
        lbUser.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(lbUser)
        
        lbStatus = UILabel()
        lbStatus.textColor = UIColor.gray
        lbStatus.numberOfLines = 1
        lbStatus.textAlignment = .left
        lbStatus.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(lbStatus)
        
        valueName = UILabel()
        valueName.textColor = UIColor.black
        valueName.numberOfLines = 1
        valueName.textAlignment = .left
        valueName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(valueName)
        
        valuePhone = UILabel()
        valuePhone.textColor = UIColor.black
        valuePhone.numberOfLines = 1
        valuePhone.textAlignment = .left
        valuePhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(valuePhone)
        
        valueAddress = UILabel()
        valueAddress.textColor = UIColor.black
        valueAddress.numberOfLines = 1
        valueAddress.textAlignment = .left
        valueAddress.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(valueAddress)
        
        valueUser = UILabel()
        valueUser.textColor = UIColor.black
        valueUser.numberOfLines = 1
        valueUser.textAlignment = .left
        valueUser.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(valueUser)
        
        valueStatus = UILabel()
        valueStatus.textColor = UIColor.black
        valueStatus.numberOfLines = 1
        valueStatus.textAlignment = .left
        valueStatus.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(valueStatus)
        
        lineFooter = UIView()
        lineFooter.backgroundColor = UIColor(netHex: 0xEEEEEE)
        contentView.addSubview(lineFooter)
    }
    
    func setup(so:RequestPaymentHistory){

        name.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: (UIScreen.main.bounds.size.width - Common.Size(s:20))/2,height: Common.Size(s:15))
        name.text = "Số HĐ: \(so.SoHopDong)"

        address.frame = CGRect(x:name.frame.origin.x + name.frame.size.width,y: name.frame.origin.y,width: name.frame.size.width,height: name.frame.size.height)
        address.text = "\(so.CreateDate)"
        
        line.frame = CGRect(x: Common.Size(s:10),y: name.frame.origin.y + name.frame.size.height +  Common.Size(s:5) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20),height: Common.Size(s:0.5))
        
        numMPOS.frame = CGRect(x: name.frame.origin.x,y: line.frame.origin.y + line.frame.size.height + Common.Size(s:5),width: UIScreen.main.bounds.size.width * 2.5/10,height: Common.Size(s:15))
        numMPOS.text = "Tên chủ nhà:"
        
        valueName.frame = CGRect(x: numMPOS.frame.origin.x + numMPOS.frame.size.width ,y: numMPOS.frame.origin.y,width: UIScreen.main.bounds.size.width * 7.5/10 - Common.Size(s:20),height: Common.Size(s:15))
        valueName.text = "\(so.TenChuNha)"
        
        lbPhone.frame = CGRect(x: name.frame.origin.x,y: numMPOS.frame.origin.y + numMPOS.frame.size.height + Common.Size(s:5),width: UIScreen.main.bounds.size.width * 2.5/10,height: Common.Size(s:15))
        lbPhone.text = "SĐT:"
        
        valuePhone.frame = CGRect(x: numMPOS.frame.origin.x + numMPOS.frame.size.width ,y: lbPhone.frame.origin.y,width: UIScreen.main.bounds.size.width * 7.5/10 - Common.Size(s:20),height: Common.Size(s:15))
        valuePhone.text = "\(so.SDT)"
        
        lbAddress.frame = CGRect(x: name.frame.origin.x,y: lbPhone.frame.origin.y + lbPhone.frame.size.height + Common.Size(s:5),width: UIScreen.main.bounds.size.width * 2.5/10,height: Common.Size(s:15))
        lbAddress.text = "Địa chỉ:"
        
        valueAddress.frame = CGRect(x: numMPOS.frame.origin.x + numMPOS.frame.size.width ,y: lbAddress.frame.origin.y,width: UIScreen.main.bounds.size.width * 7.5/10 - Common.Size(s:20),height: Common.Size(s:15))
        valueAddress.text = "\(so.DiaChiShop)"
        
        lbUser.frame = CGRect(x: name.frame.origin.x,y: lbAddress.frame.origin.y + lbAddress.frame.size.height + Common.Size(s:5),width: UIScreen.main.bounds.size.width * 2.5/10,height: Common.Size(s:15))
        lbUser.text = "Người tạo:"
        
        valueUser.frame = CGRect(x: numMPOS.frame.origin.x + numMPOS.frame.size.width ,y: lbUser.frame.origin.y,width: UIScreen.main.bounds.size.width * 7.5/10 - Common.Size(s:20),height: Common.Size(s:15))
        valueUser.text = "\(so.CreateBy)"
        
        lbStatus.frame = CGRect(x: name.frame.origin.x,y: lbUser.frame.origin.y + lbUser.frame.size.height + Common.Size(s:5),width: UIScreen.main.bounds.size.width * 2.5/10,height: Common.Size(s:15))
        lbStatus.text = "Trạng thái:"
        
        valueStatus.frame = CGRect(x: numMPOS.frame.origin.x + numMPOS.frame.size.width ,y: lbStatus.frame.origin.y,width: UIScreen.main.bounds.size.width * 7.5/10 - Common.Size(s:20),height: Common.Size(s:15))
        valueStatus.text = "\(so.Status)"
        if(so.Status == "Đã lưu"){
            valueStatus.textColor = UIColor(netHex: 0x0064B0)
        }else if(so.Status == "Hoàn tất"){
            valueStatus.textColor = UIColor(netHex: 0xD0021B)
        }else{
            valueStatus.textColor = UIColor(netHex: 0x04AB6 )
        }
        
        lineFooter.frame = CGRect(x: 0,y: lbStatus.frame.origin.y + lbStatus.frame.size.height +  Common.Size(s:10) ,width: UIScreen.main.bounds.size.width,height: Common.Size(s: 3))

        
    }
    
}
