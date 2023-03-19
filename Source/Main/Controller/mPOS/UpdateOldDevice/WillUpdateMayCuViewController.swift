//
//  WillUpdateMayCuViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 6/12/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog

class WillUpdateMayCuViewController: UIViewController {
    var parentNavigationController : UINavigationController?
    var tableView: UITableView!
    var cellHeight: CGFloat = 0
    var listMayCuEcom = [MayCuECom]()
    var filterSP = [MayCuECom]()
    var tfSearch: UITextField!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isTranslucent = false
        self.loadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
        self.loadData()
        NotificationCenter.default.addObserver(self, selector: #selector(clearSearch), name: NSNotification.Name.init("didEnter_mayCuEcom"), object: nil)
    }
    
    func loadData() {
        MPOSAPIManager.Maycu_Ecom_GetListProduct(status: "1") { (rs, err) in
            if err.count <= 0 {
                if rs.count > 0 {
                    self.listMayCuEcom = rs
                    self.filterSP = rs
                    if self.tableView != nil {
                        self.tableView.reloadData()
                    } else {
                        self.setUpTableView()
                    }
                } else {
                    let popup = PopupDialog(title: "Thông báo", message: "Không có danh sách cập nhật ảnh SP cũ chưa cập nhật!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
            } else {
                let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
        }
    }
    
    func setUpTableView() {
        
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
        tableView.register(UpdateImageOldDeviceCell.self, forCellReuseIdentifier: "updateImageOldDeviceCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.separatorColor = .black
        tableView.showsVerticalScrollIndicator = false
        self.view.addSubview(tableView)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let keyString:String = textField.text!
        if keyString.isEmpty {
            filterSP = self.listMayCuEcom
        } else {
            filterSP = listMayCuEcom.filter({
                ($0.Imei.localizedCaseInsensitiveContains(keyString)) || ($0.ItemName.localizedCaseInsensitiveContains(keyString)) || ($0.Sku.localizedCaseInsensitiveContains(keyString))
            })
        }
        tableView.reloadData()
    }
    
    @objc func clearSearch() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.loadData()
    }
}

extension WillUpdateMayCuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterSP.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UpdateImageOldDeviceCell = tableView.dequeueReusableCell(withIdentifier: "updateImageOldDeviceCell", for: indexPath) as! UpdateImageOldDeviceCell
        
        let key = tfSearch.text ?? ""
        if !(key.isEmpty) {
            let item = filterSP[indexPath.row]
            cell.setUpCell(item: item)
        }else{
            let item = listMayCuEcom[indexPath.row]
            cell.setUpCell(item: item)
        }
        cellHeight = cell.estimateCellHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item:MayCuECom?
        let key = tfSearch.text ?? ""
        if !(key.isEmpty) {
            item = filterSP[indexPath.row]
        }else{
            item = listMayCuEcom[indexPath.row]
        }
        
        let vc = DetailUpdateOldDeviceViewController()
        vc.itemMayCuEcom = item!
        vc.parentNavigationController = self.parentNavigationController
        self.tfSearch.text = ""
        self.view.endEditing(true)
        parentNavigationController?.pushViewController(vc, animated: true)
    }
}
