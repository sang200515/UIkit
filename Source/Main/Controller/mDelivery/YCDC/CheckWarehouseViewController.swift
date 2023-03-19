//
//  CheckWarehouseViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 19/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit

class CheckWarehouseViewController: UIViewController {
    private var warehouses: [ItemWarehouse] = []
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var selectWarehouse: ((ItemWarehouse) -> (Void))?
    var sku: String = ""
    var amount: Int = 0
    var keySearch: String = ""
    var filteredWarehouses: [ItemWarehouse] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        keySearch = ""
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(self.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        self.navigationItem.title = "Danh sách kho"
        
        let searchField = UITextField(frame: CGRect(x: 30, y: 20, width: UIScreen.main.bounds.size.width, height: 35))
         searchField.placeholder = "Bạn cần tìm?"
         searchField.backgroundColor = .white
         searchField.layer.cornerRadius = 5
         searchField.tintColor = .black

         searchField.leftViewMode = .always
         let searchImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
         let searchImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
         let search = UIImage(named: "search", in: Bundle(for: YNSearch.self), compatibleWith: nil)
         searchImageView.image = search
         searchImageViewWrapper.addSubview(searchImageView)
         searchField.leftView = searchImageViewWrapper
         searchField.addTarget(self, action: #selector(search(textField:)), for: .editingChanged)
         self.navigationItem.titleView = searchField
        

        setupTableView()
        APIManager.checkWhs(itemCode: sku, quantity: amount) { (results) in
            self.warehouses = results
            self.tableView.reloadData()
        }
    }
    @objc private func search(textField: UITextField) {
        if let key = textField.text {
            keySearch = key
            filteredWarehouses = warehouses.filter { (warehouse: ItemWarehouse) -> Bool in
                return warehouse.shopCode.lowercased().contains(self.keySearch.lowercased()) || warehouse.shopName.lowercased().contains(self.keySearch.lowercased()) || warehouse.whsCode.lowercased().contains(self.keySearch.lowercased()) || warehouse.whsName.lowercased().contains(self.keySearch.lowercased())
            }
            tableView.reloadData()
        }
    }
    func setupTableView() {
        tableView.register(WarehouseCell.self, forCellReuseIdentifier: "WarehouseCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.estimatedRowHeight = 70
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableFooterView = UIView()
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension CheckWarehouseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.keySearch != "" {
            return filteredWarehouses.count
        }
        return warehouses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WarehouseCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "WarehouseCell")
        
        let item: ItemWarehouse
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
        let item: ItemWarehouse
        if self.keySearch != "" {
            item = filteredWarehouses[indexPath.row]
        } else {
            item = warehouses[indexPath.row]
        }
        selectWarehouse?(item)
        self.navigationController?.popViewController(animated: true)
    }
}

class WarehouseCell: UITableViewCell {
    
    var lblTradingCode = UILabel()
    var lblMoneyValue = UILabel()
    var lblAmount = UILabel()
    
    func setUpCell(item: ItemWarehouse){
    
        lblTradingCode.frame =  CGRect(x: Common.Size(s: 15), y: Common.Size(s: 5), width: UIScreen.main.bounds.width - Common.Size(s: 60), height: Common.Size(s: 15))
        lblTradingCode.text = "\(item.shopCode) - \(item.shopName)"
        lblTradingCode.textColor = UIColor.black
        lblTradingCode.font = UIFont.boldSystemFont(ofSize: 13)
        lblTradingCode.numberOfLines = 1
        self.addSubview(lblTradingCode)
        
        lblMoneyValue.frame =  CGRect(x: lblTradingCode.frame.origin.x , y: lblTradingCode.frame.origin.y + lblTradingCode.frame.size.height, width: lblTradingCode.frame.size.width, height: Common.Size(s: 15))
        lblMoneyValue.text = "Kho: \(item.whsName)"
        lblMoneyValue.textColor = UIColor.black
        lblMoneyValue.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lblMoneyValue)
        
        lblAmount.frame =  CGRect(x: lblTradingCode.frame.origin.x + lblTradingCode.frame.size.width, y: Common.Size(s: 5), width: Common.Size(s: 30), height: Common.Size(s: 35))
        lblAmount.text = "\(item.qty_Available)"
        lblAmount.textAlignment = .center
        lblAmount.textColor = UIColor(netHex:0x00955E)
        lblAmount.font = UIFont.boldSystemFont(ofSize: 21)
        lblAmount.numberOfLines = 1
        self.addSubview(lblAmount)
        
    }
}
