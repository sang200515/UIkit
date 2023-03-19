//
//  CameraViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 5/14/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class CameraViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    var tableView: UITableView  =   UITableView()
    var items: [CameraShop] = []
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCandies = [CameraShop]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.initNavigationBar()
        self.title = "Camera"
        self.navigationController?.navigationBar.isTranslucent = true
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
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
        searchController.searchBar.delegate = self
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(CameraViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        tableView.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemCameraShopTableViewCell.self, forCellReuseIdentifier: "ItemCameraShopTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        
        self.view.addSubview(tableView)
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tải danh sách shop..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.sp_mpos_FRT_SP_Camera_listShopByUser { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                self.items = results
                if(results.count <= 0){
                    TableViewHelper.EmptyMessage(message: "Không có shop.\n:/", viewController: self.tableView)
                }else{
                    TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                }
                self.tableView.reloadData()
            }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if isFiltering() {
            let item:CameraShop = filteredCandies[indexPath.row]
            let newViewController = DetailCameraViewControllerV2()
            newViewController.cameraShop = item
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            let item:CameraShop = items[indexPath.row]
            let newViewController = DetailCameraViewControllerV2()
            newViewController.cameraShop = item
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredCandies.count
        }
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemCameraShopTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemCameraShopTableViewCell")
        if isFiltering() {
            let item:CameraShop = filteredCandies[indexPath.row]
            cell.setup(so: item)
        }else{
             let item:CameraShop = items[indexPath.row]
            cell.setup(so: item)
        }
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:40);
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCandies = items.filter({( candy : CameraShop) -> Bool in
            print("\(searchText.lowercased()) \(candy.WarehouseName.lowercased())")
            return candy.WarehouseName.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}
extension CameraViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension CameraViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        //let searchBar = searchController.searchBar
        filterContentForSearchText(searchController.searchBar.text!, scope: "")
    }
}
class ItemCameraShopTableViewCell: UITableViewCell {
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
        name.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(name)
        
    }
    
    func setup(so:CameraShop){
        
        name.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:20))
        name.text = "\(so.WarehouseName)"
    }
    
}
