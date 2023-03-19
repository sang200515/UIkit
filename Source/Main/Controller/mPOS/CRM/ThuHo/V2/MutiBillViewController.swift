//
//  MutiBillViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 2/20/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class MutiBillViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    var tableView: UITableView  =   UITableView()
    var items: [ItemMutiBill] = []
    var parentNavigationController : UINavigationController?
    //----
    var thuHoBill:ThuHoBill?
    var thuHoService: ThuHoService?
    var thuHoProvider: ThuHoProvider?
    var contractCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
        self.title = "Chọn hoá đơn"
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(MutiBillViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        tableView.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemMutiBillTableViewCell.self, forCellReuseIdentifier: "ItemMutiBillTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        
        items = thuHoBill!.ListMutiBill
        
        if(items.count <= 0){
            TableViewHelper.EmptyMessage(message: "Không có hoá đơn.\n:/", viewController: self.tableView)
        }else{
            TableViewHelper.removeEmptyMessage(viewController: self.tableView)
        }
        self.tableView.reloadData()
        
        self.view.addSubview(tableView)
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item:ItemMutiBill = items[indexPath.row]
        actionCheckKMVC(MoneyAmount: item.MoneyAmount)
    }
    
    func actionCheckKMVC(MoneyAmount: String){

        let newViewController = LoadingViewController()
        newViewController.content = "Đang tìm thông tin hợp đồng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.GetBillV2(WarehouseCode: "\(Cache.user!.ShopCode)", ProviderCode: "\(thuHoProvider!.PaymentBillProviderCode)", ServiceCode: "\(thuHoProvider!.PaymentBillServiceCode)", PartnerUserCode: "\(thuHoProvider!.PartnerUserCode)", CustomerID: "\(contractCode)", AgribankProviderCode: "\(thuHoProvider!.AgriBankProviderCode)", MomenyAmountReturnCode25: "\(MoneyAmount)") { (result, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(result != nil){
                    if(result!.ReturnCode == "3" || result!.ReturnCode == "4" || result!.ReturnCode == "-1" || result!.ReturnCode == "-9") {
                        let popup = PopupDialog(title: "Thông báo", message: "\(result!.Description)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        }
                        let buttonOne = CancelButton(title: "OK") {
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }else if(result!.ReturnCode == "0"){
                        if("\(self.thuHoProvider!.AgriBankProviderCode)" != ""){
                            
                        }else{
                            if(result!.ListDetailPayoo.count > 0){
                                let vc = DetailBillViewController()
                                vc.thuHoBill = result
                                vc.thuHoService = self.thuHoService
                                vc.thuHoProvider = self.thuHoProvider
                                vc.contractCode = self.contractCode
                                vc.parentNavigationController = self.navigationController
                                self.navigationController?.pushViewController(vc, animated: true)
                            }else{
                                let popup = PopupDialog(title: "Thông báo", message: "Chưa hỗ trợ loại hợp đồng này.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }
                        }
                    }else if(result!.ReturnCode == "-25") {
                        let popup = PopupDialog(title: "Thông báo", message: "\(result!.Description)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        }
                        let buttonOne = DefaultButton(title: "Đồng ý") {
                            let vc = MutiBillViewController()
                            vc.thuHoBill = result
                            vc.thuHoService = self.thuHoService
                            vc.thuHoProvider = self.thuHoProvider
                            vc.contractCode = self.contractCode
                            vc.parentNavigationController = self.navigationController
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        let buttonTwo = CancelButton(title: "Huỷ") {
                        }
                        popup.addButtons([buttonTwo,buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }else{
                    let popup = PopupDialog(title: "Thông báo", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
        let cell = ItemMutiBillTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemMutiBillTableViewCell")
        let item:ItemMutiBill = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:75);
    }
}
class ItemMutiBillTableViewCell: UITableViewCell {
    var address: UILabel!
    var name: UILabel!
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
        name.textColor = UIColor(netHex:0x00955E)
        name.numberOfLines = 1
        name.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(name)
        
        address = UILabel()
        address.textColor = UIColor.gray
        address.numberOfLines = 1
        address.textAlignment = .left
        address.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(address)
        
        numMPOS = UILabel()
        numMPOS.textColor = UIColor.gray
        numMPOS.numberOfLines = 1
        numMPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(numMPOS)
        
    }
    
    func setup(so:ItemMutiBill){
        
        name.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width  - Common.Size(s:20) ,height: Common.Size(s:16))
        name.text = "Hoá đơn: \(so.CustomerIDMutiBill)"
        
        address.frame = CGRect(x:name.frame.origin.x ,y: name.frame.origin.y + name.frame.size.height + Common.Size(s: 5),width: name.frame.size.width ,height: Common.Size(s:16))
        address.text = "Số tiền: 0đ"
        if(!so.MoneyAmount.isEmpty){
            if let sum = Int(so.MoneyAmount) {
                address.text = "Số tiền: \(Common.convertCurrency(value: sum))"
            }
        }
        
        
        numMPOS.frame = CGRect(x:name.frame.origin.x ,y: address.frame.origin.y + address.frame.size.height + Common.Size(s: 5),width: name.frame.size.width,height:name.frame.size.height)
        numMPOS.text = "Loại: \(so.Title)"
        
    }
    
}
