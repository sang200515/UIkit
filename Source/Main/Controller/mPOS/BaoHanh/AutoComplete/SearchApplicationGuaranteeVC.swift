//
//  SearchApplicationGuaranteeVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 22/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit


class SearchApplicationGuaranteeVC: BaseController {
    
    lazy var searchBar:UISearchBar = UISearchBar()
    @IBOutlet weak var tableView: UITableView!
    
    var listSearch = [GRTHistoryItem]()
    var filterList = [GRTHistoryItem]()
    let cellIdentifier = "GuaranteeAutoCompleteCellTableViewCell"
    var refresh = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.navigationController?.navigationBar.isTranslucent = true
        self.view.backgroundColor = .white
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Nhập số phiếu"
        
        
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.font = UIFont.systemFont(ofSize: 13)
            searchBar.searchTextField.clearButtonMode = .whileEditing
            let placeholderLabel = searchBar.searchTextField.value(forKey: "placeholderLabel") as? UILabel
            placeholderLabel?.font = UIFont.italicSystemFont(ofSize: 13.0)
        } else {
            // Fallback on earlier versions
            let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideUISearchBar?.font = UIFont.systemFont(ofSize: 13)
            let placeholderLabel = textFieldInsideUISearchBar?.value(forKey: "placeholderLabel") as? UILabel
            placeholderLabel?.font = UIFont.italicSystemFont(ofSize: 13.0)
        }
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        self.navigationItem.titleView = searchBar
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
        self.searchBar.addDoneButtonOnKeyboard()
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:30))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:30), height: Common.Size(s:40))
        viewLeftNav.addSubview(btBackIcon)
        refresh.addTarget(self, action: #selector(refreshed), for: .valueChanged)
        self.tableView.refreshControl = refresh
        getListSearh()
    }
    
    @objc func refreshed() {
        refresh.endRefreshing()
        getListSearh()
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getListSearh() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            GuaranteeAutoApiManager.shared.getListGRT { [weak self] Response, err in
                guard let self = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err == "" && Response.count == 0 {
                        self.showPopup(with: "Không có phiếu test máy", completion: nil)
                        self.listSearch = []
                        self.filterList = []
                    } else {
                        if err != "" {
                            self.showPopup(with: err, completion: nil)
                            self.listSearch = []
                            self.filterList = []
                        } else {
                            self.listSearch = Response
                            self.filterList = Response
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

}

extension SearchApplicationGuaranteeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GuaranteeAutoCompleteCellTableViewCell
        let item = filterList[indexPath.row]
        cell.bindCell(item: item, isSearch: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = filterList[indexPath.row]
        let newPopup = GRTPopupView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        newPopup.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        newPopup.onSaves = { [weak self] (isOK, errStr) in
            guard let self = self else {return}
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                GuaranteeAutoApiManager.shared.saveDeleteTest(grtItem: item, isOK: isOK) { result, err in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if err != "" {
                            self.showPopup(with: err, completion: nil)
                        } else {
                            var title = result?.resultStr ?? ""
                            title = result?.result == 1 ? "\(title) phiếu \(item.maPhieuBH)" : title
                            self.showPopup(with: title) {
                                if result?.result == 1 {
                                    self.getListSearh()
                                }
                            }
                        }
                    }
                }
            }
        }
        self.view.addSubview(newPopup)
    }
}

extension SearchApplicationGuaranteeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: "\(searchBar.text ?? "")")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(key: "\(searchBar.text ?? "")")
    }
    
    func search(key:String){
        if key.count > 0 {
            filterList = listSearch.filter({"\($0.maPhieuBH)".lowercased().contains(key.lowercased())})
        } else {
            filterList = listSearch
        }
        tableView.reloadData()
    }
}
