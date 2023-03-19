//
//  SearchProductViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 18/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit

class SearchProductViewController: UIViewController {
    private var productsSearch: [Product] = []
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var selectProduct: ((Product) -> (Void))?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(self.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        self.navigationItem.title = "Sản phẩm"
        safeArea = view.layoutMarginsGuide
        self.definesPresentationContext = true
        setupTableView()
        
       let searchField = UITextField(frame: CGRect(x: 30, y: 20, width: UIScreen.main.bounds.size.width, height: 35))
        searchField.placeholder = "Bạn cần tìm sản phẩm?"
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
    }
    @objc private func search(textField: UITextField) {
        if let key = textField.text {
            if(key.count == 0){
                self.productsSearch = []
                self.tableView.reloadData()
            }else{
                ProductAPIManager.searchProduct(keyword: "\(key)",inventory: 0) { (results, err) in
                    self.productsSearch = results
                    self.tableView.reloadData()
                }
            }
        }
    }
    func setupTableView() {
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.tableFooterView = UIView()
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension SearchProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsSearch.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProductCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ProductCell")
        cell.setUpCell(item: productsSearch[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = productsSearch[indexPath.row]
        selectProduct?(product)
        self.navigationController?.popViewController(animated: true)
    }
}

class ProductCell: UITableViewCell {
    
    var lblTradingCode = UILabel()
    var lblMoneyValue = UILabel()
    
    func setUpCell(item: Product){
    
        lblTradingCode.frame =  CGRect(x: Common.Size(s: 15), y: Common.Size(s: 5), width: UIScreen.main.bounds.width - Common.Size(s: 30), height: Common.Size(s: 15))
        lblTradingCode.text = "\(item.name)"
        lblTradingCode.textColor = UIColor.black
        lblTradingCode.font = UIFont.boldSystemFont(ofSize: 13)
        lblTradingCode.numberOfLines = 1
        self.addSubview(lblTradingCode)
        
        lblMoneyValue.frame =  CGRect(x: lblTradingCode.frame.origin.x , y: lblTradingCode.frame.origin.y + lblTradingCode.frame.size.height, width: lblTradingCode.frame.size.width, height: Common.Size(s: 15))
        lblMoneyValue.text = "Giá: \(Common.convertCurrencyFloatV2(value: item.price))"
        lblMoneyValue.textColor = UIColor.red
        lblMoneyValue.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lblMoneyValue)
    }
}
