//
//  TabSPDemoWillUpdateViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 5/12/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class TabSPDemoWillUpdateViewController: UIViewController {
    var parentNavigationController : UINavigationController?
    var tableView: UITableView!
    var cellHeight:CGFloat = 0
    var listSp = [ProductDemoBH]()
    var filterSP = [ProductDemoBH]()
    var tfSearch: UITextField!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isTranslucent = false
        MPOSAPIManager.Products_Demo_Warranty_ListProduct(status: "P") { (rs, err) in
            if err.count <= 0 {
                if rs.count > 0 {
                    self.listSp = rs
                    if self.tableView != nil {
                        self.tableView.reloadData()
                    } else {
                        self.view.subviews.forEach({$0.removeFromSuperview()})
                        self.setUpView()
                    }
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: "Không có danh sách sản phẩm!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func setUpView() {
        tfSearch = UITextField(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Common.Size(s: 35)))
        tfSearch.textAlignment = .center
        tfSearch.placeholder = "Tìm kiếm theo IMEI"
        tfSearch.borderStyle = .bezel
        tfSearch.backgroundColor = .white
        tfSearch.clearButtonMode = .whileEditing
        tfSearch.returnKeyType = .done
        self.view.addSubview(tfSearch)
        tfSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let tableViewHeight:CGFloat = self.view.frame.height - Common.Size(s: 70) - (self.parentNavigationController?.navigationBar.frame.height ?? 0 + UIApplication.shared.statusBarFrame.height)
        
        tableView = UITableView(frame: CGRect(x: 0, y: tfSearch.frame.origin.y + tfSearch.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: tableViewHeight - (tfSearch.frame.origin.y + tfSearch.frame.height + Common.Size(s: 5))))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MayDemoBHCell.self, forCellReuseIdentifier: "mayDemoBHCell")
        tableView.tableFooterView = UIView()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let keyString:String = textField.text!
        filterSP = listSp.filter({
            ($0.imei.localizedCaseInsensitiveContains(keyString)) || ($0.item_name.localizedCaseInsensitiveContains(keyString))
        })
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Chưa cập nhật"
        self.view.backgroundColor = .white
        self.setUpView()
        
        MPOSAPIManager.Products_Demo_Warranty_ListProduct(status: "P") { (rs, err) in
            if err.count <= 0 {
                if rs.count > 0 {
                    self.listSp = rs
                    self.tableView.reloadData()
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: "Không có danh sách sản phẩm!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(clearSearch), name: NSNotification.Name.init("didEnter_mayDemoBH"), object: nil)
    }
    
    @objc func clearSearch() {
        self.navigationController?.navigationBar.isTranslucent = false
        MPOSAPIManager.Products_Demo_Warranty_ListProduct(status: "P") { (rs, err) in
            if err.count <= 0 {
                if rs.count > 0 {
                    self.listSp = rs
                    if self.tableView != nil {
                        self.tableView.reloadData()
                    } else {
                        self.view.subviews.forEach({$0.removeFromSuperview()})
                        self.setUpView()
                    }
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: "Không có danh sách sản phẩm!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

extension TabSPDemoWillUpdateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = tfSearch.text ?? ""
        if !(key.isEmpty) {
            return filterSP.count
        }else{
           return listSp.count
        }
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MayDemoBHCell = tableView.dequeueReusableCell(withIdentifier: "mayDemoBHCell", for: indexPath) as! MayDemoBHCell
        let key = tfSearch.text ?? ""
        if !(key.isEmpty) {
            let item = filterSP[indexPath.row]
            cell.setUpCell(item: item)
        }else{
            let item = listSp[indexPath.row]
            cell.setUpCell(item: item)
        }
        cellHeight = cell.estimateCellHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item:ProductDemoBH?
        let key = tfSearch.text ?? ""
        if !(key.isEmpty) {
            item = filterSP[indexPath.row]
        }else{
            item = listSp[indexPath.row]
        }
        
        let vc = DetailMayDemoBHViewController()
        vc.itemProductDemo = item!
        vc.parentNavigationController = self.parentNavigationController
        self.tfSearch.text = ""
        self.view.endEditing(true)
        parentNavigationController?.pushViewController(vc, animated: true)
    }
}

