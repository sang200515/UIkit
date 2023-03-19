//
//  TabInstalledViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/18/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class TabInstalledViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    var tableView: UITableView  =   UITableView()
    var items: [VinaGame_LoadDSDonHangInstalled] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
        self.title = "Đã cài đặt"
        tableView.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height -  (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemVNGInstalledTableViewCell.self, forCellReuseIdentifier: "ItemVNGInstalledTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        
        self.view.addSubview(tableView)
    }
    override func viewWillAppear(_ animated: Bool) {
        MPOSAPIManager.VinaGame_GetListDHIntalled(UserID: "\(Cache.user!.UserName)", MaShop: "\(Cache.user!.ShopCode)") { (results, err) in
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
        //        let item:VinaGame_LoadDSDonHang = items[indexPath.row]
        //        let newViewController = DetailSOViewController()
        //        newViewController.so = item
        //        newViewController.indexRow = indexPath.row
        //        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemVNGInstalledTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemVNGInstalledTableViewCell")
        let item:VinaGame_LoadDSDonHangInstalled = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:180);
    }
}
class ItemVNGInstalledTableViewCell: UITableViewCell {
    var address: UILabel!
    var name: UILabel!
    var numMPOS: UILabel!
    var numPOS: UILabel!
    var status: UILabel!
    var dateInstall: UILabel!
    var app1: UILabel!
    var app2: UILabel!
    var app3: UILabel!
    var app4: UILabel!
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
        
        
        dateInstall = UILabel()
        dateInstall.textColor = UIColor.gray
        dateInstall.numberOfLines = 1
        dateInstall.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(dateInstall)
        
        app1 = UILabel()
        app1.textColor = UIColor.black
        app1.numberOfLines = 1
        app1.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(app1)
        
        app2 = UILabel()
        app2.textColor = UIColor.black
        app2.numberOfLines = 1
        app2.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(app2)
        
        app3 = UILabel()
        app3.textColor = UIColor.black
        app3.numberOfLines = 1
        app3.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(app3)
        
        app4 = UILabel()
        app4.textColor = UIColor.black
        app4.numberOfLines = 1
        app4.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(app4)
        
    }
    
    func setup(so:VinaGame_LoadDSDonHangInstalled){
        
        name.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width * 3/5 - Common.Size(s:10) ,height: Common.Size(s:16))
        name.text = "\(so.cardname)"
        
        address.frame = CGRect(x:name.frame.origin.x + name.frame.size.width,y: name.frame.origin.y,width: UIScreen.main.bounds.size.width * 2/5 - Common.Size(s:10) ,height: Common.Size(s:16))
        address.text = "\(so.NgayHoanTatDH)"
        
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
        numPOS.text = "POS: \(so.SOPOS)"
        
        let statusText: String = "\(so.IMEI)"
        status.frame = CGRect(x:line3.frame.origin.x + Common.Size(s:5),y: line3.frame.origin.y ,width: name.frame.size.width,height:line1.frame.size.height)
        status.text = "\(statusText)"
        
        let line4 = UIView(frame: CGRect(x: line1.frame.origin.x, y:line3.frame.origin.y + line3.frame.size.height + Common.Size(s: 5), width: 1, height: Common.Size(s:16)))
        line4.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line4)
        
    
        
        dateInstall.frame = CGRect(x:line4.frame.origin.x + Common.Size(s:5),y: line4.frame.origin.y ,width: name.frame.size.width,height:line4.frame.size.height)
        dateInstall.text = "Cài đặt: \(so.NgayCai)"
     
            let formattedString1 = NSMutableAttributedString()
            let formattedString2 = NSMutableAttributedString()
            let formattedString3 = NSMutableAttributedString()
            let formattedString4 = NSMutableAttributedString()
        app1.frame = CGRect(x:line4.frame.origin.x,y: line4.frame.origin.y + line4.frame.size.height + Common.Size(s: 5) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 20),height:line4.frame.size.height)
//        app1.text = "TT Zalo: \(so.TrangThai_zalo)"
        formattedString1
            .normal("TT Zalo: ").bold("\(so.TrangThai_zalo)")
        app1.attributedText = formattedString1
        
        app2.frame = CGRect(x:line4.frame.origin.x,y: app1.frame.origin.y + app1.frame.size.height + Common.Size(s: 5) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 20),height:line4.frame.size.height)
//        app2.text = "TT Zing: \(so.TrangThai_zing)"
        formattedString2
            .normal("TT Zing: ").bold("\(so.TrangThai_zing)")
        app2.attributedText = formattedString2
        
        app3.frame = CGRect(x:line4.frame.origin.x,y: app2.frame.origin.y + app2.frame.size.height + Common.Size(s: 5) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 20),height:line4.frame.size.height)
//        app3.text = "TT Báo mới: \(so.TrangThai_baomoi)"
        formattedString3
            .normal("TT Báo mới: ").bold("\(so.TrangThai_baomoi)")
        app3.attributedText = formattedString3
        
        app4.frame = CGRect(x:line4.frame.origin.x,y: app3.frame.origin.y + app3.frame.size.height + Common.Size(s: 5) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 20),height:line4.frame.size.height)
//        app4.text = "TT Labankey: \(so.TrangThai_labankey)"
        formattedString4
            .normal("TT Labankey: ").bold("\(so.TrangThai_labankey)")
        app4.attributedText = formattedString4
    }
    
}
