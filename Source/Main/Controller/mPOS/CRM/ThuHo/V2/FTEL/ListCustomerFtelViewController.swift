//
//  ListCustomerFtelViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class ListCustomerFtelViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    var tableView: UITableView  =  UITableView()
    var items: [GetListCustomerResult] = []
    var parentNavigationController : UINavigationController?
    var parentTabBarController: UITabBarController?
    var province:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chưa xác nhận"
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(ListCustomerFtelViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        tableView.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height -  (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemCustomerFtelTableViewCell.self, forCellReuseIdentifier: "ItemCustomerFtelTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        self.view.addSubview(tableView)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item:GetListCustomerResult = items[indexPath.row]
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.GetAgumentFtelV2(MaKHFtel: "\(item.Contract)", MaShop: "\(Cache.user!.ShopCode)", Province: "\(province)") { (result, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    let vc = DetailCustomerFtelViewController()
                    vc.ftelBillCustomer = result
                    vc.Contract = "\(item.Contract)"
                    vc.phone = "\(item.Phone)"
                    vc.address = "\(item.Address)"
                    vc.parentNavigationController = self.navigationController
                    vc.province = self.province
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemCustomerFtelTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemCustomerFtelTableViewCell")
        let item:GetListCustomerResult = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:90);
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
class ItemCustomerFtelTableViewCell: UITableViewCell {
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
        
        dateCreate = UILabel()
        dateCreate.textColor = UIColor.gray
        dateCreate.numberOfLines = 1
        dateCreate.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(dateCreate)
        
        
        numMPOS = UILabel()
        numMPOS.textColor = UIColor.gray
        numMPOS.numberOfLines = 1
        numMPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(numMPOS)
        
        numPOS = UILabel()
        numPOS.textColor = UIColor.gray
        numPOS.numberOfLines = 1
        numPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(numPOS)
        
    }
    
    func setup(so:GetListCustomerResult){
        name.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        name.text = "\(so.FullName)"
        
        address.frame = CGRect(x:name.frame.origin.x ,y: name.frame.origin.y + name.frame.size.height +  Common.Size(s:5),width: name.frame.size.width ,height: Common.Size(s:13))
        address.text = "\(so.Address)"
        
        dateCreate.frame = CGRect(x:address.frame.origin.x ,y: address.frame.origin.y + address.frame.size.height +  Common.Size(s:5) ,width: address.frame.size.width ,height: Common.Size(s:13))
        dateCreate.text = "SĐT: \(so.Phone)"
        if(so.Phone == ""){
            dateCreate.text = "SĐT: Chưa cập nhật"
        }
        let line1 = UIView(frame: CGRect(x: dateCreate.frame.origin.x, y:dateCreate.frame.origin.y + dateCreate.frame.size.height + Common.Size(s:5), width: 1, height: Common.Size(s:16)))
        line1.backgroundColor = UIColor(netHex:0x00955E)
        contentView.addSubview(line1)
        
        let line2 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width/3 + Common.Size(s:10), y:line1.frame.origin.y, width: 1, height: Common.Size(s:16)))
        line2.backgroundColor = UIColor(netHex:0x00955E)
        contentView.addSubview(line2)

        numMPOS.frame = CGRect(x:line1.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/3,height:line1.frame.size.height)
        numMPOS.text = "\(so.Contract)"
        
        numPOS.frame = CGRect(x:line2.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/2,height:line1.frame.size.height)
        numPOS.text = "\(so.DebtMessage)"
        if(so.DebtMessage != "Đã thanh toán"){
            numPOS.textColor =  UIColor.red
        }else{
            numPOS.textColor =  UIColor(netHex:0x00955E)
        }
        
    }
    
}


