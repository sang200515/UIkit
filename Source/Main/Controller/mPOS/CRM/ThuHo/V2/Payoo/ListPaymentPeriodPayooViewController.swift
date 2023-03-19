//
//  ListPaymentPeriodPayooViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/10/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import PopupDialog
protocol ListPaymentPeriodPayooViewControllerDelegate: NSObjectProtocol {
    func returnSelectListPayment(item:[ItemDetailPayoo])
}
class ListPaymentPeriodPayooViewController: UIViewController,UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate{
    
    var thuHoBill:ThuHoBill?
    var tableView: UITableView = UITableView()
    var items: [ItemDetailPayoo] = []
    var ListDetailPayooSelect: [ItemDetailPayoo] = []
    var delegate:ListPaymentPeriodPayooViewControllerDelegate?
    var idCheck:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(ListPaymentPeriodPayooViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        self.title = "Kỳ thanh toán"
        self.view.backgroundColor = .white
        
        for item in thuHoBill!.ListDetailPayoo {
            if(thuHoBill!.PaymentRule == 2 && item.IsCheck == "true"){
                    idCheck = item.ID
            }
            var check = true
            for it in ListDetailPayooSelect {
                if(it.ID == item.ID){
                    check = false
                    break
                }
            }
            if(!check){
                item.IsCheck = "true"
                items.append(item)
            }else{
                item.IsCheck = "false"
                items.append(item)
            }
            
        }
        debugPrint("AAA \(idCheck)")
        //        items = thuHoBill!.ListDetailPayoo
        
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height  - self.navigationController!.navigationBar.frame.size.height - UIApplication.shared.statusBarFrame.height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemDetailPayoo2TableViewCell.self, forCellReuseIdentifier: "ItemDetailPayoo2TableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.allowsMultipleSelection = true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemDetailPayoo2TableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemDetailPayoo2TableViewCell")
        let item:ItemDetailPayoo = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        cell.accessoryType = .checkmark
        if item.IsCheck == "true" {
            cell.accessoryType = .checkmark
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        } else {
            cell.accessoryType = .none
            tableView.deselectRow(at: indexPath, animated: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:75);
    }
    @objc func actionBack() {
        if(thuHoBill!.PaymentRule == 1){
            if(ListDetailPayooSelect.count == thuHoBill!.ListDetailPayoo.count){
                self.navigationController?.popViewController(animated: true)
                delegate?.returnSelectListPayment(item: ListDetailPayooSelect)
            }else{
                let popup = PopupDialog(title: "Thông báo", message: "Bạn cần phải thanh toán tất cả các kỳ.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                }
                
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
        }else if(thuHoBill!.PaymentRule == 2){
            var check = false
            for it in ListDetailPayooSelect {
                if(it.ID == idCheck){
                    check = true
                    break
                }
            }
            if(check){
                if(ListDetailPayooSelect.count == thuHoBill!.ListDetailPayoo.count){
                    self.navigationController?.popViewController(animated: true)
                    delegate?.returnSelectListPayment(item: ListDetailPayooSelect)
                }else if(ListDetailPayooSelect.count == 1){
                    self.navigationController?.popViewController(animated: true)
                    delegate?.returnSelectListPayment(item: ListDetailPayooSelect)
                }else{
                    let popup = PopupDialog(title: "Thông báo", message: "Bạn cần phải thanh toán kỳ cũ nhất hoặc thanh toán tất cả các kỳ.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                    }
                    
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
            }else{
                let popup = PopupDialog(title: "Thông báo", message: "Bạn cần phải thanh toán kỳ cũ nhất hoặc thanh toán tất cả các kỳ.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                }
                
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
        }else if(thuHoBill!.PaymentRule == 3){
            if(ListDetailPayooSelect.count > 0){
                self.navigationController?.popViewController(animated: true)
                delegate?.returnSelectListPayment(item: ListDetailPayooSelect)
            }else{
                let popup = PopupDialog(title: "Thông báo", message: "Bạn phải thanh toán ít nhất 1 kỳ.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                }
                
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
        }else if(thuHoBill!.PaymentRule == 5){
            if(ListDetailPayooSelect.count > 0){
                self.navigationController?.popViewController(animated: true)
                delegate?.returnSelectListPayment(item: ListDetailPayooSelect)
            }else{
                let popup = PopupDialog(title: "Thông báo", message: "Bạn phải thanh toán ít nhất 1 kỳ.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
extension ListPaymentPeriodPayooViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(thuHoBill!.PaymentRule != 1){
            items[indexPath.row].IsCheck = "true"
            ListDetailPayooSelect.removeAll()
            for it in items {
                if(it.IsCheck == "true"){
                    ListDetailPayooSelect.append(it)
                }
            }
            self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if(thuHoBill!.PaymentRule != 1){
            items[indexPath.row].IsCheck = "false"
            ListDetailPayooSelect.removeAll()
            for it in items {
                if(it.IsCheck == "true"){
                    ListDetailPayooSelect.append(it)
                }
            }
            self.tableView.reloadData()
        }
    }
}
class ItemDetailPayoo2TableViewCell: UITableViewCell {
    var address: UILabel!
    var name: UILabel!
    var dateCreate: UILabel!
    var numMPOS: UILabel!
    var numPOS: UILabel!
    var status: UILabel!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        name = UILabel()
        name.textColor = UIColor.black
        name.numberOfLines = 1
        name.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(name)
        
        address = UILabel()
        address.textColor = UIColor.gray
        address.numberOfLines = 1
        address.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(address)
        
        numMPOS = UILabel()
        numMPOS.textColor = UIColor.black
        numMPOS.numberOfLines = 1
        numMPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(numMPOS)
        
        numPOS = UILabel()
        numPOS.textColor = UIColor.black
        numPOS.numberOfLines = 1
        numPOS.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(numPOS)
    }
    
    func setup(so:ItemDetailPayoo){
        
        name.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        name.text = "Kỳ thanh toán tháng \(so.Month)"
        
        address.frame = CGRect(x:name.frame.origin.x ,y: name.frame.origin.y + name.frame.size.height +  Common.Size(s:5),width: name.frame.size.width ,height: Common.Size(s:13))
        address.text = "Mã HĐ: \(so.BillID)"
        
        let line1 = UIView(frame: CGRect(x: address.frame.origin.x, y:address.frame.origin.y + address.frame.size.height + Common.Size(s:5), width: 1, height: Common.Size(s:16)))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line1)
        
        let line2 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width/2 + Common.Size(s:10), y:line1.frame.origin.y, width: 1, height: Common.Size(s:16)))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line2)
        
        numMPOS.frame = CGRect(x:line1.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/2 - Common.Size(s:10),height:line1.frame.size.height)
        numMPOS.text = "Số tiền: \(Common.convertCurrency(value: so.TotalAmount))"
        
        numPOS.frame = CGRect(x:line2.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/2 - Common.Size(s:10),height:line1.frame.size.height)
        numPOS.text = "Phí thu: \(Common.convertCurrency(value: so.PaymentFee))"
        
    }
    
}

