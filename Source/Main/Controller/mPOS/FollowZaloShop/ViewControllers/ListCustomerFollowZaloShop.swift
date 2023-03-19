//
//  ListCustomerFollowZaloShop.swift
//  fptshop
//
//  Created by KhanhNguyen on 10/20/20.
//  Copyright © 2020 Duong Hoang Minh. All rights reserved.
//

import UIKit

class ListCustomerFollowZaloShopScreen: BaseController {
    
    let tableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var listCustomerFollowItesm: [ListCustomerFollowZaloModel] = []
    
    private var isSearched: Bool = false
    
    let searchListCustomer = UISearchBar()
    
    override func setupViews() {
        super.setupViews()
        self.title = "Danh sách KH Follow Zalo Shop"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        tableView.register(ListCustomerFollowZaloTableViewCell.self, forCellReuseIdentifier: ListCustomerFollowZaloTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.fill()
    }
    
    override func getData() {
        super.getData()
        getListCustomerFollow()
    }
    
    func getListCustomerFollow() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            FollowZaloShopAPIManager.shared.getListCustomerFollow("30808", completion: { [weak self](result) in
                guard let strongSelf = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    strongSelf.listCustomerFollowItesm = result ?? []
                    strongSelf.tableView.reloadData()
                }
            }) {[weak self] (error) in
                guard let strongSelf = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    strongSelf.showAlertOneButton(title: "Thông báo", with: error ?? "", titleButton: "Đồng ý")
                }
            }
        }
    }
    
    @objc fileprivate func showSearchBar() {
        let textfieldInsideSearchBar = searchListCustomer.value(forKey: "searchField") as? UITextField
        textfieldInsideSearchBar?.textColor = .black
        searchListCustomer.showsCancelButton = true
        searchListCustomer.tintColor = Constants.COLORS.light_green
        searchListCustomer.placeholder = "Kiếm tên khách hàng"
        searchListCustomer.delegate = self
        searchListCustomer.isHidden = false
        searchListCustomer.alpha = 0
        navigationItem.titleView = searchListCustomer
        
        UIView.animate(withDuration: 0.5, animations: {
            self.searchListCustomer.alpha = 1
        }, completion: { finished in
            self.searchListCustomer.becomeFirstResponder()
        })
    }
    
    private func hideSearchBar() {
        searchListCustomer.alpha = 0
        self.navigationItem.titleView = nil
        self.navigationItem.title = "Phạt"
    }
}

extension ListCustomerFollowZaloShopScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearched = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearched = false
        hideSearchBar()
    }
}

extension ListCustomerFollowZaloShopScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCustomerFollowItesm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCustomerFollowZaloTableViewCell.identifier, for: indexPath) as? ListCustomerFollowZaloTableViewCell else {return UITableViewCell()}
        let item = listCustomerFollowItesm[indexPath.row]
        cell.setupCellGetData(item.senderName, iamgeURL: item.avatar ?? "", createDate: item.createdate)
        cell.listCustomerFollowZaloCellDelegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension ListCustomerFollowZaloShopScreen: UITableViewDelegate {
    
}

extension ListCustomerFollowZaloShopScreen: ListCustomerFollowZalotableViewCellDelegate {
    func selecteScanQRCode() {
        // Selected Scan QR Code
        let scanVC = ScanCustomerQRCodeZaloScreen()
        self.navigationController?.pushViewController(scanVC, animated: true)
    }
    
    func selecteEditProfile() {
        // Selected edit profile
        print("Edit profile")
    }
}
