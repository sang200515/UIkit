//
//  ListCustomerFollowZaloShop.swift
//  fptshop
//
//  Created by KhanhNguyen on 10/20/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListCustomerFollowZaloShopScreen: BaseController {
    
    let tableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ListCustomerFollowZaloShopScreen.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = Constants.COLORS.light_green
        
        return refreshControl
    }()
    
    private var listCustomerFollowItems: [ListCustomerFollowZaloModel] = []
    private var listCustomerFollowItemsAfterSearched: [ListCustomerFollowZaloModel] = []
    
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
        tableView.addSubview(refreshControl)
    }
    
    override func getData() {
        super.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        listCustomerFollowItems.removeAll()
        tableView.reloadData()
        getListCustomerFollow()
    }
    
    func getListCustomerFollow() {
        guard let shopCode = Cache.user?.ShopCode else {return}
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            FollowZaloShopAPIManager.shared.getListCustomerFollow(shopCode, completion: { [weak self](result) in
                guard let strongSelf = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    strongSelf.listCustomerFollowItems = result ?? []
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
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        getListCustomerFollow()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    private func hideSearchBar() {
        searchListCustomer.alpha = 0
        self.navigationItem.titleView = nil
        self.navigationItem.title = "Danh sách KH Follow Zalo Shop"
    }
}

extension ListCustomerFollowZaloShopScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearched = true
        let itemsSearched = listCustomerFollowItems.filter{$0.senderName?.range(of: searchText, options: .caseInsensitive) != nil}
        if itemsSearched.isEmpty {
            listCustomerFollowItemsAfterSearched = listCustomerFollowItems
        } else {
            listCustomerFollowItemsAfterSearched = itemsSearched
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearched = false
        hideSearchBar()
        tableView.reloadData()
    }
}

extension ListCustomerFollowZaloShopScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearched {
            return listCustomerFollowItemsAfterSearched.count
        } else {
            return listCustomerFollowItems.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCustomerFollowZaloTableViewCell.identifier, for: indexPath) as? ListCustomerFollowZaloTableViewCell else {return UITableViewCell()}
        if isSearched {
            let item = listCustomerFollowItemsAfterSearched[indexPath.row]
            cell.setupCellGetData(item.senderName ?? "", iamgeURL: item.avatar ?? "", createDate: item.createdate ?? "")
        } else {
            let item = listCustomerFollowItems[indexPath.row]
            cell.setupCellGetData(item.senderName ?? "", iamgeURL: item.avatar ?? "", createDate: item.createdate ?? "")
        }
        cell.listCustomerFollowZaloCellDelegate = self
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension ListCustomerFollowZaloShopScreen: UITableViewDelegate {
    
}

extension ListCustomerFollowZaloShopScreen: ListCustomerFollowZalotableViewCellDelegate {
    func selecteScanQRCode(cell: ListCustomerFollowZaloTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let item = listCustomerFollowItems[indexPath.row]
        
        let scanVC = ScanCustomerQRCodeZaloScreen()
        scanVC.getSenderID(item.senderId ?? "")
        scanVC.getURLImage(item.avatar ?? "")
        scanVC.getUserNameZalo(item.senderName ?? "")
        scanVC.getCreateDate(item.createdate ?? "")
        self.navigationController?.pushViewController(scanVC, animated: true)
    }
    
    func selecteEditProfile(cell: ListCustomerFollowZaloTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let item = listCustomerFollowItems[indexPath.row]
        
        let infoCustomerDetail = InfoCustomerFollowZaloScreen()
        infoCustomerDetail.loadImgAvatar(item.avatar ?? "")
        infoCustomerDetail.getNameCustomer(item.senderName ?? "")
        infoCustomerDetail.getSenderID(item.senderId ?? "")
        infoCustomerDetail.getCreateDate(item.createdate ?? "")
        self.navigationController?.pushViewController(infoCustomerDetail, animated: true)
        
    }
}
