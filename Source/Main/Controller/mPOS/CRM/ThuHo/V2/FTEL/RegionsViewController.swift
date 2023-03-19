//
//  RegionsViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

protocol RegionsViewControllerDelegate: NSObjectProtocol {
    func returnLocation(item:GetFtelLocationsResult,ind:Int)
}

class RegionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var delegate:RegionsViewControllerDelegate?
    var barClose : UIBarButtonItem!
    
    var tableView: UITableView = UITableView()
    var items: [GetFtelLocationsResult] = []
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCandies = [GetFtelLocationsResult]()
    
    var parentNavigationController : UINavigationController?
    var parentTabBarController: UITabBarController?
    var ind:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00579c)
        self.title = "Vùng/Miền"
        self.navigationController?.navigationBar.isTranslucent = true
        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "Close"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(RegionsViewController.actionClose), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Tìm vùng/miền"
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .red
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
                textfield.textColor = UIColor(netHex:0x00955E)
                textfield.tintColor = UIColor(netHex:0x00955E)
                if let backgroundview = textfield.subviews.first {
                    // Background color
                    backgroundview.backgroundColor = UIColor.white
                    // Rounded corner
                    backgroundview.layer.cornerRadius = 5;
                    backgroundview.clipsToBounds = true;
                }
                if let navigationbar = self.navigationController?.navigationBar {
                    navigationbar.barTintColor = UIColor(netHex:0x00955E)
                }
            }
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
        
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemThuHoLocationCell.self, forCellReuseIdentifier: "ItemThuHoLocationCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        TableViewHelper.EmptyMessage(message: "", viewController: self.tableView)
        self.view.addSubview(tableView)
        
        // Setup the Scope Bar
        searchController.searchBar.delegate = self
        
       
        MPOSAPIManager.GetFtelLocationsV2(MaNV: "\(Cache.user!.UserName)", MaShop: "\(Cache.user!.ShopCode)") { (results, err) in
            self.items = results
            self.tableView.reloadData()
        }
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
        navigationController?.popViewController(animated: false)
        dismiss(animated: false, completion: nil)
    }
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredCandies.count
        }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ItemThuHoLocationCell = tableView.dequeueReusableCell(withIdentifier: "ItemThuHoLocationCell", for: indexPath) as! ItemThuHoLocationCell
        var candy: GetFtelLocationsResult! = nil
        if isFiltering() {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = items[indexPath.row]
        }
        cell.setup(so: candy)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        var item:GetFtelLocationsResult! = nil
        if isFiltering() {
            item = filteredCandies[indexPath.row]
        } else {
            item = items[indexPath.row]
        }
        
        if(searchController.isActive){
            searchController.dismiss(animated: false, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.navigationController?.popViewController(animated: false)
                self.dismiss(animated: false, completion: nil)
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.navigationController?.popViewController(animated: false)
                self.dismiss(animated: false, completion: nil)
            }
        }
        delegate?.returnLocation(item:item,ind:ind)
    }
    
    // MARK: - Private instance methods
    
    func filterContentForSearchText(_ searchText: String, scope: String = "") {
        filteredCandies = items.filter({( candy : GetFtelLocationsResult) -> Bool in
            let doesCategoryMatch = (scope == "") || (candy.ProvinceName == scope)
            
            if searchBarIsEmpty() {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && candy.ProvinceName.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:40);
    }
}
extension RegionsViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: "")
    }
}

extension RegionsViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!, scope: "")
    }
}
class ItemThuHoLocationCell: UITableViewCell {
    var type: UILabel!
    var name: UILabel!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        name = UILabel()
        name.textColor = UIColor.black
        name.numberOfLines = 1
        name.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(name)
        
    }
    
    func setup(so:GetFtelLocationsResult){
        name.frame = CGRect(x: Common.Size(s:10),y: 0,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:40))
        name.text = "\(so.ProvinceName)"
    }
}
