//
//  SearchContactViewControllerV2.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/4/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class SearchContactViewControllerV2: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var barClose : UIBarButtonItem!
    
    var tableView: UITableView = UITableView()
    var items: [ItemContact] = []
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCandies = [ItemContact]()
    
    var parentNavigationController : UINavigationController?
    var parentTabBarController: UITabBarController?
    var ind:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00579c)
        self.title = "Tra cứu danh bạ"
        self.navigationController?.navigationBar.isTranslucent = true
        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(SearchContactViewControllerV2.actionClose), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Nhập từ khoá tìm..."
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .red
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
                textfield.textColor = UIColor(netHex:0x00579c)
                textfield.tintColor = UIColor(netHex:0x00579c)
                if let backgroundview = textfield.subviews.first {
                    // Background color
                    backgroundview.backgroundColor = UIColor.white
                    // Rounded corner
                    backgroundview.layer.cornerRadius = 5;
                    backgroundview.clipsToBounds = true;
                }
                if let navigationbar = self.navigationController?.navigationBar {
                    navigationbar.barTintColor = UIColor(patternImage: Common.imageLayerForGradientBackground(searchBar: (self.searchController.searchBar)))
                }
            }
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
        
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemProvinceCell.self, forCellReuseIdentifier: "ItemProvinceCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        TableViewHelper.EmptyMessage(message: "Bạn vui lòng nhập từ khoá để tra cứu.", viewController: self.tableView)
        self.view.addSubview(tableView)
        self.tableView.allowsSelection = true
        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["Tên", "Shop", "SĐT" , "Email"]
        searchController.searchBar.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.tableView.addGestureRecognizer(gesture)
        self.hideKeyboardWhenTappedAround()
        
        
//        let currentTimeInMiliseconds = getCurrentMillis()
//        let defaults = UserDefaults.standard
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang cập nhật danh bạ nhân viên..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            //DBManager.sharedInstance.deleteAllFromDatabase()
             DBManager.sharedInstance.deleteFromDbObject()
            APIManager.searchContacts(keyWords: "") { (results, err) in
                debugPrint("COUNT \(results.count)")
                DBManager.sharedInstance.addListData(objects: results)
//                let currentTimeInMiliseconds2 = self.getCurrentMillis()
//                defaults.set(currentTimeInMiliseconds2, forKey: "CacheTimeContact")
//                debugPrint("COUNT TIEM  \((currentTimeInMiliseconds2 - currentTimeInMiliseconds))")
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                }
            }
        }
        
//        let CacheTimeContact = defaults.integer(forKey: "CacheTimeContact")
//        if(CacheTimeContact > 0){
//            if(currentTimeInMiliseconds - Int64(CacheTimeContact) < 259200000){ //3 day
//
//            }else{
//                let newViewController = LoadingViewController()
//                newViewController.content = "Đang cập nhật danh bạ nhân viên..."
//                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//                self.navigationController?.present(newViewController, animated: true, completion: nil)
//                let nc = NotificationCenter.default
//                let when = DispatchTime.now() + 0.5
//                DispatchQueue.main.asyncAfter(deadline: when) {
//                   // DBManager.sharedInstance.deleteAllFromDatabase()
//                    DBManager.sharedInstance.deleteFromDbObject()
//                    APIManager.searchContacts(keyWords: "") { (results, err) in
//                        debugPrint("COUNT \(results.count)")
//                        DBManager.sharedInstance.addListData(objects: results)
//                        let currentTimeInMiliseconds2 = self.getCurrentMillis()
//                        defaults.set(currentTimeInMiliseconds2, forKey: "CacheTimeContact")
//                        debugPrint("COUNT TIEM  \((currentTimeInMiliseconds2 - currentTimeInMiliseconds))")
//                        let when = DispatchTime.now() + 0.5
//                        DispatchQueue.main.asyncAfter(deadline: when) {
//                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
//                        }
//                    }
//
//                }
//            }
//        }else{
//            let newViewController = LoadingViewController()
//            newViewController.content = "Đang cập nhật danh bạ nhân viên..."
//            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//            self.navigationController?.present(newViewController, animated: true, completion: nil)
//            let nc = NotificationCenter.default
//            let when = DispatchTime.now() + 0.5
//            DispatchQueue.main.asyncAfter(deadline: when) {
//                //DBManager.sharedInstance.deleteAllFromDatabase()
//                 DBManager.sharedInstance.deleteFromDbObject()
//                APIManager.searchContacts(keyWords: "") { (results, err) in
//                    debugPrint("COUNT \(results.count)")
//                    DBManager.sharedInstance.addListData(objects: results)
//                    let currentTimeInMiliseconds2 = self.getCurrentMillis()
//                    defaults.set(currentTimeInMiliseconds2, forKey: "CacheTimeContact")
//                    debugPrint("COUNT TIEM  \((currentTimeInMiliseconds2 - currentTimeInMiliseconds))")
//                    let when = DispatchTime.now() + 0.5
//                    DispatchQueue.main.asyncAfter(deadline: when) {
//                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
//                    }
//                }
//            }
//        }
        
        
    }
    func getCurrentMillis()->Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    @objc func checkAction(sender : UITapGestureRecognizer) {
        navigationController?.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
    }
    @objc func actionClose(){
        //        self.dismiss(animated: false, completion: nil)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:90);
    }
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //
    //    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ItemProvinceCell = tableView.dequeueReusableCell(withIdentifier: "ItemProvinceCell", for: indexPath as IndexPath) as! ItemProvinceCell
        let candy: ItemContact! = items[indexPath.row]
        cell.selectionStyle = .none
        cell.setup(so: candy)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item:ItemContact! = items[indexPath.row]
        if(item != nil && item.Phone != ""){
            if let url = URL(string: "tel://\(item.Phone)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    // MARK: - Private instance methods
    
    func filterContentForSearchText(_ searchText: String, scope: String = "Tên") {
        if(searchText.count > 0){
            let searchText =  searchText.folding(options: .diacriticInsensitive, locale: nil)
            if (scope == "Tên"){
                items = DBManager.sharedInstance.searchName(key: "\(searchText.uppercased())")
                tableView.reloadData()
            }else if (scope == "Shop"){
                items = DBManager.sharedInstance.searchShop(key: "\(searchText.uppercased())")
                tableView.reloadData()
            }else if (scope == "SĐT"){
                items = DBManager.sharedInstance.searchPhone(key: "\(searchText.uppercased())")
                tableView.reloadData()
            }else if (scope == "Email"){
                items = DBManager.sharedInstance.searchEmail(key: "\(searchText.uppercased())")
                tableView.reloadData()
            }
            if(self.items.count <= 0){
                TableViewHelper.EmptyMessage(message: "Không tìm thấy từ khoá cần tìm.\r\nVui lòng kiểm tra lại.", viewController: self.tableView)
            }else{
                TableViewHelper.removeEmptyMessage(viewController: self.tableView)
            }
            self.tableView.reloadData()
        }else{
            self.items = []
            TableViewHelper.EmptyMessage(message: "Bạn vui lòng nhập từ khoá để tra cứu.", viewController: self.tableView)
            self.tableView.reloadData()
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        // 1
        let shareAction = UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "Gọi" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            let item:ItemContact! = self.items[indexPath.row]
            if(item != nil && item.Phone != ""){
                if let url = URL(string: "tel://\(item.Phone)"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
        })
        shareAction.backgroundColor = UIColor(netHex:0x00579c)
        
        return [shareAction]
    }
    
}



extension SearchContactViewControllerV2: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension SearchContactViewControllerV2: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}


class ItemProvinceCell: UITableViewCell {
    var address: UILabel!
    var name: UILabel!
    var dateCreate: UILabel!
    var numMPOS: UILabel!
    var numPOS: UILabel!
    var status: UILabel!
    var statusShift: UILabel!
    var iconPhone = UIImageView()
    var so:ItemContact!
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
        //        numMPOS.textColor = UIColor.gray
        numMPOS.numberOfLines = 1
        numMPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(numMPOS)
        
        contentView.addSubview(iconPhone)
        numPOS = UILabel()
        //        numPOS.textColor = UIColor.gray
        numPOS.numberOfLines = 1
        numPOS.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(numPOS)
        
        status = UILabel()
        status.numberOfLines = 1
        status.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(status)
        
        statusShift = UILabel()
        statusShift.numberOfLines = 1
        statusShift.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(statusShift)
    }
    
    func setup(so:ItemContact){
        self.so = so
        
        name.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        name.text = "\(so.EmployeeName)"
        
        address.frame = CGRect(x:name.frame.origin.x ,y: name.frame.origin.y + name.frame.size.height +  Common.Size(s:5),width: UIScreen.main.bounds.size.width * 2/3, height: Common.Size(s:13))
        address.text = "\(so.JobtitleName)"
        
        dateCreate.frame = CGRect(x:address.frame.origin.x ,y: address.frame.origin.y + address.frame.size.height +  Common.Size(s:5) ,width: address.frame.size.width ,height: Common.Size(s:13))
        dateCreate.text = "\(so.WarehouseName)"
        let line1 = UIView(frame: CGRect(x: dateCreate.frame.origin.x, y:dateCreate.frame.origin.y + dateCreate.frame.size.height + Common.Size(s:5), width: 1, height: Common.Size(s:16)))
        line1.backgroundColor = UIColor(netHex:0x00955E)
        contentView.addSubview(line1)
        
        let line2 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width/2 + Common.Size(s:10), y:line1.frame.origin.y, width: 1, height: Common.Size(s:16)))
        line2.backgroundColor = UIColor.white
        contentView.addSubview(line2)
        
        //---
        statusShift.frame = CGRect(x: address.frame.origin.x + address.frame.width, y:address.frame.origin.y, width: UIScreen.main.bounds.size.width - address.frame.width - Common.Size(s:20), height: address.frame.height)
        statusShift.text = so.IsShift
        
        if so.IsShift == "Trong ca" {
            statusShift.textColor = UIColor(red: 51/255, green: 204/255, blue: 51/255, alpha: 1)
        } else {
            statusShift.textColor = UIColor(red: 230/255, green: 0/255, blue: 0/255, alpha: 1)
        }
        
        //---
        
        numMPOS.frame = CGRect(x:line1.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: UIScreen.main.bounds.size.width/2 - Common.Size(s: 20),height:line1.frame.size.height)
        numMPOS.text = "\(so.Email)"
        
        iconPhone.frame =  CGRect(x: line2.frame.origin.x + Common.Size(s:5), y: line1.frame.origin.y, width: line1.frame.size.height, height: line1.frame.size.height)
        iconPhone.image = #imageLiteral(resourceName: "Phone-50")
        iconPhone.contentMode = .scaleAspectFit
        
        numPOS.frame = CGRect(x:iconPhone.frame.origin.x + iconPhone.frame.size.width + Common.Size(s:10),y: line1.frame.origin.y ,width: UIScreen.main.bounds.size.width/2 - Common.Size(s: 20),height:line1.frame.size.height)
        //        numPOS.text = "SĐT: \(so.Phone)"
        numPOS.textColor = .blue
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "\(so.Phone)", attributes: underlineAttribute)
        numPOS.attributedText = underlineAttributedString
        
        let line3 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width*2/3 + Common.Size(s:10), y:Common.Size(s:10), width: 1, height: Common.Size(s:16)))
        line3.backgroundColor = UIColor(netHex:0x00955E)
        line3.isHidden = true
        contentView.addSubview(line3)
        
        status.frame = CGRect(x:line3.frame.origin.x + Common.Size(s:5),y: line3.frame.origin.y ,width: name.frame.size.width/3,height:line3.frame.size.height)
        status.text = ""
        
        if (so.IPPhone.isEmpty) || (so.IPPhone == "") {
            line3.isHidden = true
            status.text = ""
        } else {
            line3.isHidden = false
            status.text = "IP: \(so.IPPhone)"
        }
    }
}
