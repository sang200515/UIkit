//
//  ListPaymentPeriodViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/30/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
import PopupDialog
class ListPaymentPeriodViewController: UIViewController,UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate{

    var thuHoBill:ThuHoBill?
    var tableView: UITableView = UITableView()
    var items: [ItemDetailPayoo] = []
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
        btBackIcon.addTarget(self, action: #selector(ListPaymentPeriodViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        self.title = "Kỳ thanh toán"
        self.view.backgroundColor = .white
        
        items = thuHoBill!.ListDetailPayoo
        
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemDetailPayooTableViewCell.self, forCellReuseIdentifier: "ItemDetailPayooTableViewCell")
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
        let cell = ItemDetailPayooTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemDetailPayooTableViewCell")
        let item:ItemDetailPayoo = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        cell.accessoryType = .checkmark
//        if item.IsCheck == "true" {
            cell.accessoryType = .checkmark
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
//        } else {
//             cell.accessoryType = .none
//            tableView.deselectRow(at: indexPath, animated: false)
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:75);
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension ListPaymentPeriodViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         items[indexPath.row].IsCheck = "true"
        self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        items[indexPath.row].IsCheck = "false"
        self.tableView.reloadData()
    }
}
class ItemDetailPayooTableViewCell: UITableViewCell {
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
