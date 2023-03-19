//
//  SearchInfoStudentsScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SearchInfoStudentScreen: BaseController {
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Nhập số CMND/Căn cước/SĐT"
        searchBar.delegate = self
        return searchBar
    }()
    
    private var leftConstraint: NSLayoutConstraint!
    private var searchStudentText: String = ""
    private var data: [ListStudentInfoSearchItem.Data] = []
    private var dataFiltered: [ListStudentInfoSearchItem.Data] = []
    private var isSearched: Bool = false
    
    let tableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func setupViews() {
        super.setupViews()
        self.title = "Lịch sử"
        searchStudent(searchStudentText)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListStudentInfoSearchCell.self, forCellReuseIdentifier: ListStudentInfoSearchCell.identifier)
        self.view.addSubview(tableView)
        tableView.fill()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataByUser()
    }
    
    private func createAlert(_ id: Int) {
        let alert = UIAlertController(title: "Thông báo", message: "Bạn có muốn thực hiện huỷ voucher này?", preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: { (action) in
            self.cancelVoucer(id)
        }))
        alert.addAction(UIAlertAction(title: "Từ chối", style: .cancel, handler: { (action) in
            
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupSearchBar(){
        
        // Expandable area.
        let expandableView = ExpandableView()
        navigationItem.titleView = expandableView
        // Search button.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(toggle))
        
        // Search bar.
        expandableView.addSubview(searchBar)
        leftConstraint = searchBar.leftAnchor.constraint(equalTo: expandableView.leftAnchor)
        leftConstraint.isActive = false
        searchBar.rightAnchor.constraint(equalTo: expandableView.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: expandableView.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: expandableView.bottomAnchor).isActive = true
        
        // Remove search bar border.
        searchBar.layer.borderColor = UIColor.init(white: 0, alpha: 0.1).cgColor
        searchBar.layer.borderWidth = 1
        searchBar.makeCorner(corner: 20)
        // Match background color.
        searchBar.barTintColor = .white
        
        //Set text and placeholder
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.textColor = UIColor.black
        textFieldInsideUISearchBar?.font = UIFont.mediumCustomFont(ofSize: 13)
        
        let labelInsideUISearchBar = textFieldInsideUISearchBar!.value(forKey: "placeholderLabel") as? UILabel
        labelInsideUISearchBar?.textColor = .lightGray
        labelInsideUISearchBar?.font = UIFont.mediumCustomFont(ofSize: 12)
    }
    
    @objc func toggle() {
        let isOpen = leftConstraint.isActive == true
        // Inactivating the left constraint closes the expandable header.
        if isOpen {
            leftConstraint.isActive = false
            navigationItem.leftBarButtonItem?.customView?.alpha = 0
        } else {
            leftConstraint.isActive = true
            
        }
        // Animate change to visible.
        UIView.animate(withDuration: 0.5, animations: {
            self.navigationController?.view.layoutIfNeeded()
        })
        
        UIView.animate(withDuration: 0.5, animations: {
            self.navigationItem.titleView?.alpha = isOpen ? 0 : 1
            self.navigationItem.leftBarButtonItem?.customView?.alpha = isOpen ? 1 : 0
        },  completion: { (finished: Bool) in
            if !isOpen {
                self.navigationItem.leftBarButtonItem = nil
                UIView.animate(withDuration: 0.5, animations: {
                    self.navigationController?.view.layoutIfNeeded()
                })
            }
        })
        if isOpen == false {
            self.isSearched = true
            tableView.reloadData()
        } else {
            self.isSearched = false
            self.searchBar.endEditing(true)
            self.dataFiltered.removeAll()
            self.searchBar.text = ""
            self.fetchDataByUser()
            tableView.reloadData()
        }
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            return
        }
        
        if query != searchStudentText {
            searchStudentText = query
            self.searchStudent(searchStudentText)
        }
    }
    
    override func getData() {
        super.getData()
        fetchDataByUser()
    }
    
    private func fetchDataByUser() {
        guard let user = UserDefaults.standard.getUsernameEmployee() else {return}
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.backToSchool_TimKiemStudentByUser(user: user) {[weak self] (success, data, msg) in
                guard let strongSelf = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if success == true {
                        if let data = data {
                            strongSelf.data = data
                            strongSelf.tableView.reloadData()
                        } else {
                            strongSelf.showAlertOneButton(title: "Thông báo", with: msg ?? "", titleButton: "Đồng ý")
                            
                        }
                    } else {
                        strongSelf.showAlertOneButton(title: "Thông báo", with: msg ?? "", titleButton: "Đồng ý")
                        
                    }
                }
                strongSelf.tableView.reloadData()
            }
        }
        
    }
    
    private func cancelVoucer(_ id: Int) {
        guard let user = UserDefaults.standard.getUsernameEmployee() else {return}
        let params: [String:Any] = [
            "Id_BackToSchool": id,
            "User": user,
            "LyDoHuy": "huy"
        ]
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.backToSchool_cancelVoucherByUser(params: params) {[weak self] (success, data, message) in
                guard let strongSelf = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if success == true {
                        if let dataResponse = data {
                            if dataResponse.result == 1 {
                                if !strongSelf.isSearched {
                                    strongSelf.showAlertOneButton(title: "Thông báo", with: dataResponse.msg ?? "", titleButton: "Đồng ý") {
                                        strongSelf.fetchDataByUser()
                                        strongSelf.tableView.reloadData()
                                    }
                                } else {
                                    strongSelf.showAlertOneButton(title: "Thông báo", with: dataResponse.msg ?? "", titleButton: "Đồng ý") {
                                        strongSelf.dataFiltered.removeAll()
                                        strongSelf.fetchDataByUser()
                                        strongSelf.tableView.reloadData()
                                    }
                                }
                            } else {
                                strongSelf.showAlertOneButton(title: "Thông báo", with: dataResponse.msg ?? "", titleButton: "Đồng ý")
                                
                            }
                        }
                    } else {
                        strongSelf.showAlertOneButton(title: "Thông báo", with: message ?? "", titleButton: "Đồng ý")
                    }
                }
            }
        }
    }
    
    private func searchStudent(_ text: String) {
        if text == "" {
            return
        }
        
        let txt = text.stripped
        
        MPOSAPIManager.backToSchool_TimKiemStudent(keySearch: txt) {[weak self] (success, data, msg) in
            guard let strongSelf = self else {return}
            if success == true {
                if let data = data {
                    strongSelf.dataFiltered = data
                    strongSelf.tableView.reloadData()
                } else {
                    strongSelf.showAlertOneButton(title: "Thông báo", with: msg ?? "", titleButton: "Đồng ý")
                }
            } else {
                strongSelf.showAlertOneButton(title: "Thông báo", with: msg ?? "", titleButton: "Đồng ý")
            }
            strongSelf.tableView.reloadData()
        }
    }
    
    private func cancelVoucher(_ idBackToSchool: Int) {
        
    }
}

extension SearchInfoStudentScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearched = true
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.75)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearched = false
        tableView.reloadData()
    }
}

extension SearchInfoStudentScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isSearched {
            return data.count
        } else {
            return dataFiltered.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListStudentInfoSearchCell.identifier, for: indexPath) as! ListStudentInfoSearchCell
        if !isSearched {
            let item = data[indexPath.row]
            cell.getDataStudentInfo(item.hoTen ?? "", typeStudent: item.loaiSinhVienText ?? "", phoneNumber: item.sDT ?? "", identity: item.cMND ?? "", percentDiscount: item.phanTramGiamGia ?? 0.00, statusVoucher: item.tinhTrangVoucher ?? "")
            cell.selectionStyle = .none
        } else {
            let item = dataFiltered[indexPath.row]
            cell.getDataStudentInfo(item.hoTen ?? "", typeStudent: item.loaiSinhVienText ?? "", phoneNumber: item.sDT ?? "", identity: item.cMND ?? "", percentDiscount: item.phanTramGiamGia ?? 0.00, statusVoucher: item.tinhTrangVoucher ?? "")
            cell.selectionStyle = .none
        }
        
        return cell
    }
}

extension SearchInfoStudentScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if !isSearched {
            let item = data[indexPath.row]
            let editAction = UITableViewRowAction(style: .normal, title: "Huỷ") { (rowAction, indexPath) in
                self.createAlert(item.idBackToSchool ?? 0)
            }
            editAction.backgroundColor = .red
            return [editAction]
            
        } else {
            let item = dataFiltered[indexPath.row]
            let editAction = UITableViewRowAction(style: .normal, title: "Huỷ") { (rowAction, indexPath) in
                self.createAlert(item.idBackToSchool ?? 0)
            }
            editAction.backgroundColor = .red
            return [editAction]
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isSearched {
            let item = data[indexPath.row]
            if item.loaiSinhVien == 0 {
                let newVC = DetailStudentInfoScreen()
                newVC.getIdBackToSchool(item.idBackToSchool ?? 0)
                self.navigationController?.pushViewController(newVC, animated: true)
            } else if item.loaiSinhVien == 1 || item.loaiSinhVien == 2 {
                let newVC = DetailInfoStudentFPTScreen()
                newVC.getiD_BackToSchool(item.idBackToSchool ?? 0)
                self.navigationController?.pushViewController(newVC, animated: true)
            }
        } else {
            let item = dataFiltered[indexPath.row]
            if item.loaiSinhVien == 0 {
                let newVC = DetailStudentInfoScreen()
                newVC.getIdBackToSchool(item.idBackToSchool ?? 0)
                self.navigationController?.pushViewController(newVC, animated: true)
            } else if item.loaiSinhVien == 1 || item.loaiSinhVien == 2 {
                let newVC = DetailInfoStudentFPTScreen()
                newVC.getiD_BackToSchool(item.idBackToSchool ?? 0)
                self.navigationController?.pushViewController(newVC, animated: true)
            }
        }
    }
}

class ExpandableView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
}
