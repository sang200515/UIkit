//
//  TabNotInstalledViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/18/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class TabNotInstalledViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    var tableView: UITableView  =   UITableView()
    var items: [VinaGame_LoadDSDonHang] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
        self.navigationController?.title = "Chưa cài đặt"
        
        tableView.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemVNGTableViewCell.self, forCellReuseIdentifier: "ItemVNGTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        
        self.view.addSubview(tableView)
    }
    override func viewWillAppear(_ animated: Bool) {
        MPOSAPIManager.VinaGame_GetListDH(UserID: "\(Cache.user!.UserName)", MaShop: "\(Cache.user!.ShopCode)") { (results, err) in
            self.items = results
            if(results.count <= 0){
                TableViewHelper.EmptyMessage(message: "Không có đơn hàng.\n:/", viewController: self.tableView)
            }else{
                TableViewHelper.removeEmptyMessage(viewController: self.tableView)
            }
            self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item:VinaGame_LoadDSDonHang = items[indexPath.row]
        let newViewController = AppsVNGViewController()
        newViewController.so = item
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemVNGTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemVNGTableViewCell")
        let item:VinaGame_LoadDSDonHang = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:75);
    }
}
class ItemVNGTableViewCell: UITableViewCell {
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
        address.textAlignment = .right
        address.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(address)
        
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
        
        status = UILabel()
        status.numberOfLines = 1
        status.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(status)
    }
    
    func setup(so:VinaGame_LoadDSDonHang){
        
        name.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width * 3/5 - Common.Size(s:10) ,height: Common.Size(s:16))
        name.text = "\(so.CardName)"
        
        address.frame = CGRect(x:name.frame.origin.x + name.frame.size.width,y: name.frame.origin.y,width: UIScreen.main.bounds.size.width * 2/5 - Common.Size(s:10) ,height: Common.Size(s:16))
        address.text = "\(so.NgayTao)"
        
        let line1 = UIView(frame: CGRect(x: name.frame.origin.x, y:name.frame.origin.y + name.frame.size.height + Common.Size(s:5), width: 1, height: Common.Size(s:16)))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line1)
        
        let line2 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width/2 + Common.Size(s:10), y:line1.frame.origin.y, width: 1, height: Common.Size(s:16)))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line2)
        
        let line3 = UIView(frame: CGRect(x: line1.frame.origin.x, y:line1.frame.origin.y + line1.frame.size.height + Common.Size(s: 5), width: 1, height: Common.Size(s:16)))
        line3.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line3)
        
        numMPOS.frame = CGRect(x:line1.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/2,height:line1.frame.size.height)
        numMPOS.text = "mPOS: \(so.SOMPOS)"
        
        numPOS.frame = CGRect(x: line2.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/2,height:line1.frame.size.height)
        numPOS.text = "POS: \(so.SO_POS)"
        
        let statusText: String = "\(so.U_Imei)"
        status.frame = CGRect(x:line3.frame.origin.x + Common.Size(s:5),y: line3.frame.origin.y ,width: name.frame.size.width,height:line1.frame.size.height)
        status.text = "\(statusText)"
    }
    
}
