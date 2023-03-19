//
//  SearchShopViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 03/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit

class SearchShopViewController: UIViewController {
    private var warehouses: [ItemShop] = []
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var selectShop: ((ItemShop) -> (Void))?
    var sku: String = ""
    var amount: Int = 0
    var keySearch: String = ""
    var filteredWarehouses: [ItemShop] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        keySearch = ""
        setupTableView()
        APIManager.searchShop() { (results) in
            self.warehouses = results
            self.tableView.reloadData()
        }
    }
    @objc private func search(textField: UITextField) {
        if let key = textField.text {
            keySearch = key
            filteredWarehouses = warehouses.filter { (warehouse: ItemShop) -> Bool in
                return warehouse.code.lowercased().contains(self.keySearch.lowercased()) || warehouse.name.lowercased().contains(self.keySearch.lowercased())
            }
            tableView.reloadData()
        }
    }
    func setupTableView() {
        
        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.clipsToBounds = true
        self.view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        headerView.heightAnchor.constraint(equalToConstant: Common.Size(s: 40)).isActive = true
        
        let icClose = UIImageView()
        icClose.image = #imageLiteral(resourceName: "ItemClose")
        icClose.contentMode = .scaleAspectFit
        headerView.addSubview(icClose)
        icClose.translatesAutoresizingMaskIntoConstraints = false
        
        icClose.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        icClose.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        icClose.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        icClose.widthAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 1/2).isActive = true
        
        let tapFromDate = UITapGestureRecognizer(target: self, action: #selector(self.actionBack))
        icClose.addGestureRecognizer(tapFromDate)
        icClose.isUserInteractionEnabled = true
        
        
        let searchField = UITextField(frame: CGRect(x: 30, y: 20, width: UIScreen.main.bounds.size.width, height: 35))
        searchField.placeholder = "Bạn cần tìm?"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 5
        searchField.tintColor = .black
        searchField.layer.cornerRadius = 5
        searchField.layer.borderWidth = 0.5
        searchField.layer.borderColor = UIColor.lightGray.cgColor
        
        searchField.leftViewMode = .always
        let searchImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let searchImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        let search = UIImage(named: "search", in: Bundle(for: YNSearch.self), compatibleWith: nil)
        searchImageView.image = search
        searchImageViewWrapper.addSubview(searchImageView)
        searchField.leftView = searchImageViewWrapper
        searchField.addTarget(self, action: #selector(search(textField:)), for: .editingChanged)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(searchField)
        searchField.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        searchField.topAnchor.constraint(equalTo: headerView.topAnchor, constant: Common.Size(s: 10)).isActive = true
        searchField.rightAnchor.constraint(equalTo: icClose.leftAnchor, constant: Common.Size(s: -10)).isActive = true
        searchField.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        searchField.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Common.Size(s: -10)).isActive = true
        
        
        tableView.register(ItemShopCell.self, forCellReuseIdentifier: "ItemShopCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.estimatedRowHeight = 70
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableFooterView = UIView()
    }
    @objc func actionBack() {
        self.dismiss(animated: true, completion: nil)
    }
}
extension SearchShopViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.keySearch != "" {
            return filteredWarehouses.count
        }
        return warehouses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ItemShopCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemShopCell")
        
        let item: ItemShop
        if self.keySearch != "" {
            item = filteredWarehouses[indexPath.row]
        } else {
            item = warehouses[indexPath.row]
        }
        
        cell.setUpCell(item: item)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Common.Size(s: 45)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item: ItemShop
        if self.keySearch != "" {
            item = filteredWarehouses[indexPath.row]
        } else {
            item = warehouses[indexPath.row]
        }
        selectShop?(item)
        self.dismiss(animated: true, completion: nil)
        
    }
}

class ItemShopCell: UITableViewCell {

    var lblTradingCode = UILabel()
    var lblMoneyValue = UILabel()
    var lblAmount = UILabel()

    func setUpCell(item: ItemShop){

        lblTradingCode.frame =  CGRect(x: Common.Size(s: 15), y: Common.Size(s: 5), width: UIScreen.main.bounds.width - Common.Size(s: 60), height: Common.Size(s: 15))
        lblTradingCode.text = "\(item.name)"
        lblTradingCode.textColor = UIColor.black
        lblTradingCode.font = UIFont.boldSystemFont(ofSize: 13)
        lblTradingCode.numberOfLines = 1
        self.addSubview(lblTradingCode)

        lblMoneyValue.frame =  CGRect(x: lblTradingCode.frame.origin.x , y: lblTradingCode.frame.origin.y + lblTradingCode.frame.size.height, width: lblTradingCode.frame.size.width, height: Common.Size(s: 15))
        lblMoneyValue.text = "Mã shop: \(item.code)"
        lblMoneyValue.textColor = UIColor.black
        lblMoneyValue.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lblMoneyValue)

    }
}
