//
//  ImeiBookViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit

class ImeiBookViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate{
    
    //var scrollView:UIScrollView!
    var listImeiBook:[ImeiBook] = []
    var viewTableImeiBook:UITableView  =   UITableView()
    var sku:String?
    var listImeiBookFilter:[GroupImeiBook] = []
    
    override func viewDidLoad() {
        
        navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = .white
        self.title = "Danh Sách Imei"
        //        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: CGFloat((navigationController?.navigationBar.frame.size.height)!) + CGFloat(UIApplication.shared.statusBarFrame.height), width: self.view.frame.size.width, height: self.view.frame.size.height - Cache.tabBarHeight))
        //        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        //        scrollView.backgroundColor = UIColor.white
        //        self.view.addSubview(scrollView)
        
        
//        let newViewController = LoadingViewController()
//        newViewController.content = "Đang lấy danh sách imei..."
//        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.navigationController?.present(newViewController, animated: true, completion: nil)
//        let nc = NotificationCenter.default
        
        MPOSAPIManager.getListImeiBook(itemCode: self.sku!) { (results, err) in
//            let when = DispatchTime.now() + 0.5
//            DispatchQueue.main.asyncAfter(deadline: when) {
//                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
                    
                    var pos: [String:[ImeiBook]] = [:]
                    for item in results {
                        if var val:[ImeiBook] = pos["\(item.ItemCode)"] {
                            val.append(item)
                            pos.updateValue(val, forKey: "\(item.ItemCode)")
                        } else {
                            var arr: [ImeiBook] = []
                            arr.append(item)
                            pos.updateValue(arr, forKey: "\(item.ItemCode)")
                        }
                    }
                    
                    
                    self.parseImei(pos: pos)
                    self.setupUI(list: self.listImeiBookFilter)
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    })
                    self.present(alert, animated: true)
                    
                }
//            }
        }
    }
    func parseImei(pos: [String:[ImeiBook]]){
        for item in pos{
            
            let groupImei:GroupImeiBook = GroupImeiBook(ItemCode: "",listImeiBook:[],IsExpand:true)
            groupImei.ItemCode = item.key
            
            
            for imei in item.value{
                let imeiBook:ImeiBook = ImeiBook(ItemCode: "", WhsCode: "", DistNumber: "", Quantity: 0, SL_book: 0,STT:0)
                imeiBook.ItemCode = imei.ItemCode
                imeiBook.WhsCode = imei.WhsCode
                imeiBook.DistNumber = imei.DistNumber
                imeiBook.Quantity = imei.Quantity
                imeiBook.SL_book = imei.SL_book
                let index = item.value.firstIndex(of: imei)
                imeiBook.STT = index! + 1
                groupImei.listImeiBook.append(imeiBook)
            }
            self.listImeiBookFilter.append(groupImei)
        }
        
        
    }
    
    func setupUI(list: [GroupImeiBook]){
        
        
        viewTableImeiBook.frame = CGRect(x: CGFloat(0), y:0, width: self.view.frame.size.width, height: self.view.frame.size.height )
        viewTableImeiBook.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        viewTableImeiBook.dataSource = self
        viewTableImeiBook.delegate = self
        viewTableImeiBook.register(ItemImeiBookTableViewCell.self, forCellReuseIdentifier: "ItemImeiBookTableViewCell")
        viewTableImeiBook.tableFooterView = UIView()
        viewTableImeiBook.backgroundColor = UIColor.white
        
        //scrollView.addSubview(viewTableImeiBook)
        //navigationController?.navigationBar.isTranslucent = false
        self.view.addSubview(viewTableImeiBook)
        
        //        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTableImeiBook.frame.origin.y + viewTableImeiBook.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UIButton()
        if(self.listImeiBookFilter.count > 0){
            
            
            label.setTitle(" \(self.listImeiBookFilter[section].ItemCode)", for: .normal)
        }
        
        label.setTitleColor( UIColor.white, for: .normal)
        //label.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        label.backgroundColor = UIColor(netHex:0x47B054)
        label.contentHorizontalAlignment = .left
        
        
        label.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        
        label.tag = section
        return label
    }
    
    @objc func handleExpandClose(button: UIButton) {
        print("Trying to expand and close section...")
        
        let section = button.tag
        
        // we'll try to close the section first by deleting the rows
        var indexPaths = [IndexPath]()
        for row in self.listImeiBookFilter[section].listImeiBook.indices {
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = self.listImeiBookFilter[section].IsExpand
        self.listImeiBookFilter[section].IsExpand = !isExpanded
        
        //button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        
        if isExpanded {
            self.viewTableImeiBook.deleteRows(at: indexPaths, with: .fade)
        } else {
            self.viewTableImeiBook.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listImeiBookFilter.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if(self.listImeiBookFilter.count > 0){
            if !self.listImeiBookFilter[section].IsExpand {
                return 0
            }
            return self.listImeiBookFilter[section].listImeiBook.count
        }else{
            return 0
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemImeiBookTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemImeiBookTableViewCell")
        
        let item:ImeiBook = self.listImeiBookFilter[indexPath.section].listImeiBook[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:60);
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
}

class ItemImeiBookTableViewCell: UITableViewCell {
    var imei: UILabel!
    var Quantity: UILabel!
    var SL_book: UILabel!
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        imei = UILabel()
        imei.textColor = UIColor.black
        imei.numberOfLines = 1
        imei.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        contentView.addSubview(imei)
        
        Quantity = UILabel()
        Quantity.textColor = UIColor.black
        Quantity.numberOfLines = 1
        // Quantity.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        Quantity.font = Quantity.font.withSize(15)
        contentView.addSubview(Quantity)
        
        SL_book = UILabel()
        SL_book.textColor = UIColor.black
        SL_book.numberOfLines = 1
        SL_book.font = SL_book.font.withSize(15)
        //  SL_book.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        contentView.addSubview(SL_book)
        
        
    }
    var so1:ImeiBook?
    func setup(so:ImeiBook){
        so1 = so
        
        imei.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:30))
        imei.text = "\(so.STT). \(so.DistNumber)."
        
        
        Quantity.frame = CGRect(x:Common.Size(s:10) ,y: imei.frame.origin.y + imei.frame.size.height,width: imei.frame.size.width ,height: Common.Size(s:20))
        Quantity.text = "Sl: \(so.Quantity)"
        
        SL_book.frame = CGRect(x:Quantity.frame.origin.x + Common.Size(s:100) ,y: imei.frame.origin.y + imei.frame.size.height,width: Quantity.frame.size.width ,height: Common.Size(s:20))
        SL_book.text =  "SL book: \(so.SL_book)"

    }
}
