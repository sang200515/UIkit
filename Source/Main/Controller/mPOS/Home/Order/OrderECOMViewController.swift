//
//  OrderECOMViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class OrderECOMViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
    var tableView: UITableView  =   UITableView()
    var items: [EcomSOHeader] = []
    var parentNavigationController : UINavigationController?
    var parentTabBarController: UITabBarController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Đơn hàng Ecom"
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        MPOSAPIManager.getEcomSOHeader(userCode: "\(Cache.user!.UserName)", shopCode: "\(Cache.user!.ShopCode)") { (results, err) in
            if(results.count > 0){
                
                self.items = results
                self.setupUI(list: results)
            }else{
                
            }
        }
    }
    func setupUI(list: [EcomSOHeader]){
        tableView.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - (UIApplication.shared.statusBarFrame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemEcomSOTableViewCell.self, forCellReuseIdentifier: "ItemEcomSOTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        
        self.view.addSubview(tableView)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //        let item:EcomSOHeader = items[indexPath.row]
        //        let newViewController = DetailEcomSOViewController()
        //        newViewController.so = item
        //        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemEcomSOTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemEcomSOTableViewCell")
        let item:EcomSOHeader = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:90);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
class ItemEcomSOTableViewCell: UITableViewCell {
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
        name.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        contentView.addSubview(name)
        
        address = UILabel()
        address.textColor = UIColor.gray
        address.numberOfLines = 1
        address.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(address)
        
        dateCreate = UILabel()
        dateCreate.textColor = UIColor.gray
        dateCreate.numberOfLines = 1
        dateCreate.font = UIFont.systemFont(ofSize: Common.Size(s:13))
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
        
        status = UILabel()
        status.numberOfLines = 1
        status.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(status)
    }
    
    func setup(so:EcomSOHeader){
        
        //        let sizeTitle = promotion.TenSanPham_Tang.height(withConstrainedWidth: bounds.width - Common.Size(s:20) - (icon.frame.origin.x + icon.frame.size.width), font: UIFont.boldSystemFont(ofSize: Common.Size(s:16)))
        name.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        name.text = "\(so.TenKH)"
        
        address.frame = CGRect(x:name.frame.origin.x ,y: name.frame.origin.y + name.frame.size.height +  Common.Size(s:5),width: name.frame.size.width ,height: Common.Size(s:13))
        address.text = "\(so.SDT)"
        
        dateCreate.frame = CGRect(x:address.frame.origin.x ,y: address.frame.origin.y + address.frame.size.height +  Common.Size(s:5) ,width: address.frame.size.width ,height: Common.Size(s:13))
        if let theDate = Date(jsonDate: "\(so.NgayTao)") {
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "EEEE, dd/MM/YYYY hh:ss"
            let dateString = dayTimePeriodFormatter.string(from: theDate)
            dateCreate.text = "\(dateString)"
        } else {
            dateCreate.text = "Không xác định"
            
        }
        let line1 = UIView(frame: CGRect(x: dateCreate.frame.origin.x, y:dateCreate.frame.origin.y + dateCreate.frame.size.height + Common.Size(s:5), width: 1, height: Common.Size(s:16)))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line1)
        
        let line2 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width/3 + Common.Size(s:10), y:line1.frame.origin.y, width: 1, height: Common.Size(s:16)))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line2)
        
        let line3 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width*2/3 + Common.Size(s:10), y:line1.frame.origin.y, width: 1, height: Common.Size(s:16)))
        line3.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line3)
        
        numMPOS.frame = CGRect(x:line1.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/3,height:line1.frame.size.height)
        numMPOS.text = "POS: \(so.DocEntry)"
        
        numPOS.frame = CGRect(x:line2.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/3,height:line1.frame.size.height)
        numPOS.text = "ECOM: \(so.U_NumECom)"
        
        var statusText: String = ""
        if (so.TinhTrang == "F"){
            statusText = "Hoàn tất"
            status.textColor = UIColor(netHex:0x4DB748)
        }else if (so.TinhTrang == "C"){
            statusText = "Hủy"
            status.textColor = UIColor(netHex:0xff0000)
        }else if (so.TinhTrang == "D"){
            statusText = "Đã thu cọc"
            status.textColor = UIColor(netHex:0x0000ff)
        }else if (so.TinhTrang == "T"){
            statusText = "Đã trả hàng"
            status.textColor = UIColor(netHex:0xF37022)
        }else{
            statusText = "Đang xử lý"
            status.textColor = UIColor(netHex:0x000000)
        }
        
        status.frame = CGRect(x:line3.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/3,height:line1.frame.size.height)
        status.text = "\(statusText)"
    }
    
    
}
