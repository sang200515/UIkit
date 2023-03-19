//
//  ChooseNCCThuHoServiceViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 8/3/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ChooseNCCThuHoServiceViewController: UIViewController {
    
    var items = [ThuHoProvider]()
    var arrFilter = [ThuHoProvider]()
    var btnBack: UIBarButtonItem!
    var tfSearch: UITextField!
    var tableView: UITableView = UITableView()
    var itemThuHoService:ThuHoService?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Nhà cung cấp"
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btnBack = UIBarButtonItem(customView: btBackIcon)
        self.navigationItem.leftBarButtonItems = [btnBack]
        
        tfSearch = UITextField(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 5), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfSearch.textAlignment = .center
        tfSearch.placeholder = "Nhập nội dung tìm kiếm"
        tfSearch.borderStyle = .roundedRect
        tfSearch.backgroundColor = .white
        tfSearch.clearButtonMode = .whileEditing
        tfSearch.returnKeyType = .done
        self.view.addSubview(tfSearch)
        tfSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let tableViewHeight:CGFloat = self.view.frame.height - (self.self.navigationController?.navigationBar.frame.height ?? 0) - UIApplication.shared.statusBarFrame.height
        
        tableView.frame = CGRect(x: 0, y: tfSearch.frame.origin.y + tfSearch.frame.height + Common.Size(s: 5), width: self.view.frame.size.width, height: tableViewHeight - (tfSearch.frame.origin.y + tfSearch.frame.height + Common.Size(s: 10)))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ThuHoNccCell.self, forCellReuseIdentifier: "thuHoNccCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        TableViewHelper.EmptyMessage(message: "", viewController: self.tableView)
        self.view.addSubview(tableView)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let key = textField.text ?? ""
        if key.count > 0 {
            arrFilter = items.filter({($0.PaymentBillProviderName.localizedCaseInsensitiveContains(key))})
        } else {
            arrFilter = items
        }
        self.tableView.reloadData()
    }
}

extension ChooseNCCThuHoServiceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = self.tfSearch.text ?? ""
        if !(key.isEmpty) {
            return arrFilter.count
        } else {
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ThuHoNccCell = tableView.dequeueReusableCell(withIdentifier: "thuHoNccCell", for: indexPath) as! ThuHoNccCell
        var item: ThuHoProvider
        let key = self.tfSearch.text ?? ""
        if !(key.isEmpty) {
            item = arrFilter[indexPath.row]
        } else {
            item = items[indexPath.row]
        }
        cell.setUpCell(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = self.tfSearch.text ?? ""
        var item: ThuHoProvider
        if !(key.isEmpty) {
            item = arrFilter[indexPath.row]
        } else {
            item = items[indexPath.row]
        }
        
        if item.PaymentBillProviderCode == "100000" {
            let vc = DKUyQuyenViettelViewController()
            vc.thuHoProvider = item
            vc.thuHoService = self.itemThuHoService ?? ThuHoService(PaymentBillServiceName: "", ListProvider: [])
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = ThuHoViewController()
            vc.thuHoProvider = item
            vc.thuHoService = self.itemThuHoService ?? ThuHoService(PaymentBillServiceName: "", ListProvider: [])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Common.Size(s: 40)
    }
}

class ThuHoNccCell: UITableViewCell {
    func setUpCell(item: ThuHoProvider) {
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let imgIcon = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: self.frame.height/2 - Common.Size(s: 13), width: Common.Size(s: 25), height: Common.Size(s: 25)))
        imgIcon.image = #imageLiteral(resourceName: "ic_location_large")
        imgIcon.contentMode = .scaleAspectFit
        self.addSubview(imgIcon)
        
        let lbName = UILabel(frame: CGRect(x: imgIcon.frame.origin.x + imgIcon.frame.width + Common.Size(s: 3), y: 0, width: self.frame.width - imgIcon.frame.origin.x - imgIcon.frame.width - Common.Size(s: 3), height: self.frame.height))
        lbName.text = "\(item.PaymentBillProviderName)"
        lbName.font = UIFont.boldSystemFont(ofSize: 15)
        self.addSubview(lbName)
    }
}
