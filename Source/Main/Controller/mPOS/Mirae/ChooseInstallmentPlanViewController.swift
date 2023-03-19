//
//  ChooseInstallmentPlanViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 6/9/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
protocol ChooseInstallmentPlanViewControllerDelegate: NSObjectProtocol {
    func returnInstallmentPlan(item:LaiSuatMirae,ind:Int)
}
class ChooseInstallmentPlanViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    weak var delegate:ChooseInstallmentPlanViewControllerDelegate?
    var barClose : UIBarButtonItem!
    
    var tableView: UITableView = UITableView()
    var items: [LaiSuatMirae]?
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCandies = [LaiSuatMirae]()
    
    var parentNavigationController : UINavigationController?
    var parentTabBarController: UITabBarController?
    var ind:Int!
    var cellHeight:CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00579c)
        self.title = "Chọn Gói Trả Góp"
        self.navigationController?.navigationBar.isTranslucent = true
        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "ic_cancel"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(ChooseInstallmentPlanViewController.actionClose), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Tìm gói trả góp"
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
        
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - Common.Size(s:20))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemInstallmentPlanCell.self, forCellReuseIdentifier: "ItemInstallmentPlanCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        TableViewHelper.EmptyMessage(message: "", viewController: self.tableView)
        self.view.addSubview(tableView)
        
        // Setup the Scope Bar
        searchController.searchBar.delegate = self
        
        self.tableView.reloadData()
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
        return items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ItemInstallmentPlanCell = tableView.dequeueReusableCell(withIdentifier: "ItemInstallmentPlanCell", for: indexPath) as! ItemInstallmentPlanCell
        var candy: LaiSuatMirae! = nil
        if isFiltering() {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = items![indexPath.row]
        }
        cell.setup(so: candy)
        cell.selectionStyle = .none
        self.cellHeight = cell.estimateCellHeight
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        var item:LaiSuatMirae! = nil
        if isFiltering() {
            item = filteredCandies[indexPath.row]
        } else {
            item = items![indexPath.row]
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
        delegate?.returnInstallmentPlan(item:item,ind:ind)
    }
    
    // MARK: - Private instance methods
    
    func filterContentForSearchText(_ searchText: String, scope: String = "") {
        filteredCandies = items!.filter({( candy : LaiSuatMirae) -> Bool in
            let doesCategoryMatch = (scope == "") || (candy.Name == scope)
            
            if searchBarIsEmpty() {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && candy.Name.lowercased().contains(searchText.lowercased())
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
        return cellHeight
    }
}
extension ChooseInstallmentPlanViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: "")
    }
}

extension ChooseInstallmentPlanViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!, scope: "")
    }
}
class ItemInstallmentPlanCell: UITableViewCell {
    var type: UILabel!
    var name: UILabel!
    var detail: UILabel!
    var estimateCellHeight: CGFloat = 0
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        name = UILabel()
        name.textColor = UIColor.black
     
        name.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(name)
        
        detail = UILabel()
        detail.textColor = .red
        detail.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(detail)
        
    }
    
    func setup(so:LaiSuatMirae){
        name.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:5),width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:40))
        name.text = "\(so.Name)"
        let nameTextHeight:CGFloat = name.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : name.optimalHeight
        name.numberOfLines = 0
        name.frame = CGRect(x: name.frame.origin.x, y: name.frame.origin.y, width: name.frame.width, height: nameTextHeight)
        
        detail.frame = CGRect(x: Common.Size(s:10),y: name.frame.size.height + name.frame.origin.y + Common.Size(s:5),width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:40))
        detail.text = "\(so.mota)"
        let detailTextHeight:CGFloat = detail.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : detail.optimalHeight
        detail.numberOfLines = 0
        detail.frame = CGRect(x: detail.frame.origin.x, y: detail.frame.origin.y, width: detail.frame.width, height: detailTextHeight)
        
        self.estimateCellHeight = detail.frame.origin.y + detail.frame.size.height + Common.Size(s: 15)
    }
}
