//
//  ShowShopListVisitorViewController.swift
//  fptshop
//
//  Created by Apple on 7/31/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol ShowShopListVisitorViewControllerDelegate: AnyObject {
    func chooseShop(shop: Shop)
}

class ShowShopListVisitorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var shopList: [Shop] = [];
    var tableView: UITableView!
    var filterShop: [Shop] = []
    
    lazy var searchBar:UISearchBar = UISearchBar()
    var searchActive : Bool = false
    
    weak var delegate:ShowShopListVisitorViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
//        self.navigationItem.hidesBackButton = true
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        self.navigationItem.titleView = searchBar
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)

        self.GetShopList()
        tableView = UITableView(frame: CGRect(x: 0, y: Common.Size(s: 15), width: self.view.frame.width, height: self.view.frame.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filterShop.count
        } else {
            return shopList.count;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        
        let font = cell?.textLabel?.font;
        cell!.textLabel!.font = font?.withSize(13);
        
        
        if searchActive {
            cell!.textLabel!.text = "\(filterShop[indexPath.row].ShopCode!) - \(filterShop[indexPath.row].ShopName!)";
        } else {
            cell!.textLabel!.text = "\(shopList[indexPath.row].ShopCode!) - \(shopList[indexPath.row].ShopName!)";
        }
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchActive {
            let shop = self.filterShop[indexPath.row]
            self.delegate?.chooseShop(shop: shop)
            self.navigationController?.popViewController(animated: true)
        } else {
            let shop = self.shopList[indexPath.row]
            self.delegate?.chooseShop(shop: shop)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func GetShopList(){
        let username = (Cache.user?.UserName)!;
        let shopList = mSMApiManager.GetShopByUser(username: username).Data;
        
        if(shopList != nil){
            self.shopList = shopList!;
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filterShop = self.shopList.filter({ (item) -> Bool in
            return (item.ShopName?.lowercased().contains(searchText.lowercased()) ?? false) || (item.ShopCode?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        if filterShop.count == 0 {
            searchActive = false
        } else {
            searchActive = true
        }
        tableView.reloadData()
    }

}

extension ShowShopListVisitorViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchBar.text ?? "")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.searchBar.endEditing(true)
    }
}
