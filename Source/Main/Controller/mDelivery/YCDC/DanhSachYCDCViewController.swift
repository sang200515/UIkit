//
//  DanhSachYCDCViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 18/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class DanhSachYCDCViewController: UIViewController {
    
    var tableView: UITableView!
    var list: [BodyYCDC] = []
    var parentNavigationController: UINavigationController?
    
    var filteredYCDC: [BodyYCDC] = []
    var keySearch:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let tableViewHeight:CGFloat = self.view.frame.height - Common.Size(s: 70) - (self.parentNavigationController?.navigationBar.frame.height ?? 0 + UIApplication.shared.statusBarFrame.height)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: tableViewHeight))
        self.view.addSubview(tableView)
        tableView.register(YCDCCell.self, forCellReuseIdentifier: "YCDCCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(searchYCDC), name: Notification.Name("seachYCDC"), object: nil)
    }
    @objc func searchYCDC(notification:Notification) -> Void {
        let dict = notification.object as! NSDictionary
        if let key = dict["key"] as? String{
            print("KEY \(key)")
            self.keySearch = key
            filteredYCDC = list.filter { (ycdc: BodyYCDC) -> Bool in
                return ycdc.docEntry.lowercased().contains(self.keySearch.lowercased()) || ycdc.u_ShpRec.lowercased().contains(self.keySearch.lowercased()) || ycdc.u_ShpCod.lowercased().contains(self.keySearch.lowercased())
            }
            tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        keySearch = ""
        if(tableView != nil){
            var dayComponent    = DateComponents()
            dayComponent.day    = -7
            let theCalendar     = Calendar.current
            let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())
            
            APIManager.searchYCDC(fromDate: formatDate2(date: nextDate!), toDate: formatDate2(date:Date())) { (results) in
                self.list = results.filter {
                    $0.shpCod == "\(Cache.user!.ShopCode)"
                }
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
}
extension DanhSachYCDCViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.keySearch != "" {
            return filteredYCDC.count
        }
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = YCDCCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "YCDCCell")
        cell.selectionStyle = .none
        let ycdc: BodyYCDC
        if self.keySearch != "" {
            ycdc = filteredYCDC[indexPath.row]
        } else {
            ycdc = list[indexPath.row]
        }
        cell.setUpCell(item: ycdc)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Common.Size(s: 175)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item: BodyYCDC
        if self.keySearch != "" {
            item = filteredYCDC[indexPath.row]
        } else {
            item = list[indexPath.row]
        }
        let newViewController = ChiTietYCDCViewController()
        newViewController.headerItem = item
        newViewController.parentNavigationController = parentNavigationController
        newViewController.onCancelYCDC =  { [weak self] (result) in
            if(result){
                var dayComponent    = DateComponents()
                dayComponent.day    = -7
                let theCalendar     = Calendar.current
                let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())
                
                APIManager.searchYCDC(fromDate: formatDate2(date: nextDate!), toDate: formatDate2(date:Date())) { (results) in
                    self?.list = results.filter {
                        $0.shpCod == "\(Cache.user!.ShopCode)"
                    }
                    self?.tableView.reloadData()
                }
            }
        }
        self.parentNavigationController?.pushViewController(newViewController, animated: true)
    }
}

class YCDCCell: UITableViewCell {
    
    var lblSOYCDC = UILabel()
    var lblDate = UILabel()
    var viewCell = UIView()
    var line = UIView()
    var lbTextShop = UILabel()
    var lbShop = UILabel()
    var lbTextShopIn = UILabel()
    var lbShopIn = UILabel()
    var lbTextSender = UILabel()
    var lbSender = UILabel()
    var lbTextApprovedBy = UILabel()
    var lbApprovedBy = UILabel()
    var lbTextStatus = UILabel()
    var lbStatus = UILabel()
    var lbTextNote = UILabel()
    var lbNote = UILabel()
    func setUpCell(item: BodyYCDC){
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = .clear
        viewCell.frame =  CGRect(x: Common.Size(s: 5), y: Common.Size(s: 2.5), width: UIScreen.main.bounds.width - Common.Size(s: 10), height: Common.Size(s: 170))
        viewCell.backgroundColor = .white
        viewCell.layer.cornerRadius = 5
        self.addSubview(viewCell)
    
        lblSOYCDC.frame =  CGRect(x: Common.Size(s: 10), y: Common.Size(s: 5), width: viewCell.frame.size.width/2 - Common.Size(s: 10), height: Common.Size(s: 20))
        lblSOYCDC.text = "Số YCDC: \(item.docEntry)"
        lblSOYCDC.textColor = UIColor(netHex:0x00955E)
        lblSOYCDC.font = UIFont.boldSystemFont(ofSize: 15)
        lblSOYCDC.numberOfLines = 1
        viewCell.addSubview(lblSOYCDC)

        lblDate.frame =  CGRect(x: lblSOYCDC.frame.origin.x + lblSOYCDC.frame.size.width, y: lblSOYCDC.frame.origin.y , width: lblSOYCDC.frame.size.width, height: lblSOYCDC.frame.size.height)
        lblDate.text = "\(item.createDate)"
        lblDate.textColor = UIColor.black
        lblDate.textAlignment = .right
        lblDate.font = UIFont.systemFont(ofSize: 13)
        viewCell.addSubview(lblDate)
        
        line.frame = CGRect(x: 0, y: lblSOYCDC.frame.origin.y + lblSOYCDC.frame.size.height +  Common.Size(s: 5) , width: viewCell.frame.size.width, height: 0.5)
        line.backgroundColor = UIColor(netHex: 0xEEEEEE)
        viewCell.addSubview(line)
        
        lbTextShop.frame = CGRect(x: Common.Size(s:10), y: line.frame.origin.y + line.frame.size.height + Common.Size(s:5), width: viewCell.frame.width/5, height: Common.Size(s:20))
        lbTextShop.textAlignment = .left
        lbTextShop.textColor = UIColor.black
        lbTextShop.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextShop.text = "Shop xuất:"
        lbTextShop.sizeToFit()
        viewCell.addSubview(lbTextShop)
        lbTextShop.frame.origin.y = line.frame.origin.y + line.frame.size.height + Common.Size(s:5) + Common.Size(s:20)/2 - lbTextShop.frame.height/2
        
        lbShop.frame = CGRect(x: lbTextShop.frame.origin.x + lbTextShop.frame.size.width + Common.Size(s:5), y: line.frame.origin.y + line.frame.size.height + Common.Size(s:5), width: viewCell.frame.size.width - (lbTextShop.frame.origin.x + lbTextShop.frame.size.width + Common.Size(s:15)), height: Common.Size(s:20))
        lbShop.textAlignment = .right
        lbShop.textColor = UIColor.black
        lbShop.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbShop.text = "\(item.u_ShpRec)"
        viewCell.addSubview(lbShop)
        
        lbTextShopIn.frame = CGRect(x: Common.Size(s:10), y: lbShop.frame.origin.y + lbShop.frame.size.height, width: viewCell.frame.width/5, height: Common.Size(s:20))
        lbTextShopIn.textAlignment = .left
        lbTextShopIn.textColor = UIColor.black
        lbTextShopIn.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextShopIn.text = "Shop nhận:"
        lbTextShopIn.sizeToFit()
        viewCell.addSubview(lbTextShopIn)
        lbTextShopIn.frame.origin.y = lbShop.frame.origin.y + lbShop.frame.size.height + Common.Size(s:20)/2 - lbTextShopIn.frame.height/2
        
        lbShopIn.frame = CGRect(x: lbShop.frame.origin.x, y: lbShop.frame.origin.y + lbShop.frame.size.height, width: lbShop.frame.size.width, height: Common.Size(s:20))
        lbShopIn.textAlignment = .right
        lbShopIn.textColor = UIColor.black
        lbShopIn.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbShopIn.text = "\(item.u_ShpCod)"
        viewCell.addSubview(lbShopIn)
        
        
        lbTextSender.frame = CGRect(x: Common.Size(s:10), y: lbShopIn.frame.origin.y + lbShopIn.frame.size.height, width: viewCell.frame.width/5, height: Common.Size(s:20))
        lbTextSender.textAlignment = .left
        lbTextSender.textColor = UIColor.black
        lbTextSender.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextSender.text = "Người gửi:"
        lbTextSender.sizeToFit()
        viewCell.addSubview(lbTextSender)
        lbTextSender.frame.origin.y = lbShopIn.frame.origin.y + lbShopIn.frame.size.height + Common.Size(s:20)/2 - lbTextSender.frame.height/2
        
        lbSender.frame = CGRect(x: lbShop.frame.origin.x, y: lbShopIn.frame.origin.y + lbShopIn.frame.size.height, width: lbShop.frame.size.width, height: Common.Size(s:20))
        lbSender.textAlignment = .right
        lbSender.textColor = UIColor.black
        lbSender.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbSender.text = "\(item.createBy)"
        viewCell.addSubview(lbSender)
        
        lbTextApprovedBy.frame = CGRect(x: Common.Size(s:10), y: lbSender.frame.origin.y + lbSender.frame.size.height, width: viewCell.frame.width/5, height: Common.Size(s:20))
        lbTextApprovedBy.textAlignment = .left
        lbTextApprovedBy.textColor = UIColor.black
        lbTextApprovedBy.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextApprovedBy.text = "Người duyệt:"
        lbTextApprovedBy.sizeToFit()
        viewCell.addSubview(lbTextApprovedBy)
        lbTextApprovedBy.frame.origin.y = lbSender.frame.origin.y + lbSender.frame.size.height + Common.Size(s:20)/2 - lbTextApprovedBy.frame.height/2
        
        lbApprovedBy.frame = CGRect(x: lbShop.frame.origin.x, y: lbSender.frame.origin.y + lbSender.frame.size.height, width: lbShop.frame.size.width, height: Common.Size(s:20))
        lbApprovedBy.textAlignment = .right
        lbApprovedBy.textColor = UIColor.black
        lbApprovedBy.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbApprovedBy.text = "\(item.updateBy)"
        viewCell.addSubview(lbApprovedBy)
        
        lbTextStatus.frame = CGRect(x: Common.Size(s:10), y: lbApprovedBy.frame.origin.y + lbApprovedBy.frame.size.height, width: viewCell.frame.width/5, height: Common.Size(s:20))
        lbTextStatus.textAlignment = .left
        lbTextStatus.textColor = UIColor.black
        lbTextStatus.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextStatus.text = "Trạng thái:"
        lbTextStatus.sizeToFit()
        viewCell.addSubview(lbTextStatus)
        lbTextStatus.frame.origin.y = lbApprovedBy.frame.origin.y + lbApprovedBy.frame.size.height + Common.Size(s:20)/2 - lbTextStatus.frame.height/2
        
        lbStatus.frame = CGRect(x: lbShop.frame.origin.x, y: lbApprovedBy.frame.origin.y + lbApprovedBy.frame.size.height, width: lbShop.frame.size.width, height: Common.Size(s:20))
        lbStatus.textAlignment = .right
        lbStatus.textColor = UIColor.black
        lbStatus.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbStatus.text = "\(item.statusName)"
        viewCell.addSubview(lbStatus)
        
        if(item.statusCode == "O"){
            lbStatus.textColor = UIColor.blue
        }else  if(item.statusCode == "D"){
            lbStatus.textColor = UIColor.green
        }else  if(item.statusCode == "H"){
            lbStatus.textColor = UIColor.red
        }
        
        lbTextNote.frame = CGRect(x: Common.Size(s:10), y: lbStatus.frame.origin.y + lbStatus.frame.size.height, width: viewCell.frame.width/5, height: Common.Size(s:27))
        lbTextNote.textAlignment = .left
        lbTextNote.textColor = UIColor.black
        lbTextNote.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextNote.text = "Ghi chú:"
        lbTextNote.sizeToFit()
        viewCell.addSubview(lbTextNote)
        lbTextNote.frame.origin.y = lbStatus.frame.origin.y + lbStatus.frame.size.height + Common.Size(s:27)/2 - lbTextNote.frame.height/2
        
        lbNote.frame = CGRect(x: lbShop.frame.origin.x, y: lbStatus.frame.origin.y + lbStatus.frame.size.height, width: lbShop.frame.size.width, height: Common.Size(s:27))
        lbNote.textAlignment = .right
        lbNote.textColor = UIColor.black
        lbNote.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbNote.text = "\(item.remarks)"
        lbNote.numberOfLines = 2
        viewCell.addSubview(lbNote)
        
    }
}
func formatDate(date:String) -> String{
    if(date != ""){
        let deFormatter = DateFormatter()
        deFormatter.timeZone = TimeZone(abbreviation: "UTC")
        deFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let startTime = deFormatter.date(from: date)
        deFormatter.dateFormat = "dd/MM/yyyy - HH:mm"
        if(startTime != nil){
            return deFormatter.string(from: startTime!)
        }
        return ""
    }
    return ""
}
func formatDate2(date:Date) -> String{
    let deFormatter = DateFormatter()
    deFormatter.dateFormat = "yyyy-MM-dd"
    return deFormatter.string(from: date)
}
