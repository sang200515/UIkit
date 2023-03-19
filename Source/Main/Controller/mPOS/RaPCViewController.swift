//
//  RaPCViewController.swift
//  fptshop
//
//  Created by Sang Truong on 11/30/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class RaPCViewController: UIViewController {

    let searchBar = UISearchBar()
    
    var filterList:[DataPC] = []
    var listDataPc:[DataPC] = []
    let startOfMonth = Date().startOfMonth()
    let endOfMonth = Date().endOfMonth()
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "dd/MM/yyyy"
        configureUI()
        refreshControl.attributedTitle = NSAttributedString(string: "Kéo xuống để tải dữ liệu mới nhất")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        loadSearchItems(shopCode: "30808", status: "", from: Common.gettimeWith(format: "dd/MM/yyyy"), to: Common.gettimeWith(format: "dd/MM/yyyy"), itemcode: "")Cache .user!.shopCode
        
        loadSearchItems(shopCode: Cache.user!.ShopCode, status: "", from: Common.gettimeWith(format: "\(formatter.string(from: startOfMonth))"), to: "\(formatter.string(from: endOfMonth))", itemcode: "")
    }
    
    @objc func refresh() {
        refreshControl.endRefreshing()
        loadSearchItems(shopCode: Cache.user!.ShopCode, status: "", from: Common.gettimeWith(format: Common.gettimeWith(format: "\(formatter.string(from: startOfMonth))")), to: Common.gettimeWith(format: "\(formatter.string(from: endOfMonth))"), itemcode: "")
    }

    @objc func handleShowSearchBar() {
        searchBar.becomeFirstResponder()
        search(shouldShow: true)
    }
    
    func loadSearchItems(shopCode:String,status:String,from:String,to:String,itemcode:String) {
        ProgressView.shared.show()
        Provider.shared.laprapPCAPService.getListPC(shopCode: shopCode, status: status, from: from, to: to, itemCode: itemcode, success: { [weak self] result in
            ProgressView.shared.hide()
            guard let self = self, let response = result else { return }
            if response.message?.message_Code == 200  {
                self.listDataPc = response.data
                self.filterList = response.data
                self.tableView.reloadData()
            } else {
                self.showAlertOneButton(title: "Thông báo", with: response.message?.message_Desc ?? "", titleButton: "OK")
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    @objc func handleFilter() {
        let popup = SearchPCpopup()
        popup.modalPresentationStyle = .overCurrentContext
        popup.modalTransitionStyle = .crossDissolve
        popup.onSearch = { [weak self] (shop,state,from,to) in
            guard let self = self else {return}
            self.loadSearchItems(shopCode: shop, status: state, from: from, to: to, itemcode: "")
        }
        self.present(popup, animated: true, completion: nil)
    }

    // MARK: - Helper Functions
    
    func configureUI() {
        view.backgroundColor = .white
        searchBar.sizeToFit()
        searchBar.delegate = self
        navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255,
                                                 blue: 250/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "DANH SÁCH PC LẮP RÁP"
        showSearchBarButton(shouldShow: true)
        
        //tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RaPCCell", bundle: nil), forCellReuseIdentifier: "RaPCCell")
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 0
        if shouldShow {
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(image: UIImage(named: "Filter"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleFilter)),
                space,
                UIBarButtonItem(barButtonSystemItem: .search,
                                                                    target: self,
                                                                    action: #selector(handleShowSearchBar))
            ]
        } else {
            navigationItem.rightBarButtonItems = []
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
}

extension RaPCViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Search bar editing did begin..")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("Search bar editing did end..")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterList = listDataPc
        self.tableView.reloadData()
        search(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            filterList = listDataPc.filter({$0.shopCode.stripingDiacritics.lowercased().contains(searchText.lowercased()) ||  $0.docEntry.stripingDiacritics.lowercased().contains(searchText.lowercased()) || $0.itemCode.stripingDiacritics.lowercased().contains(searchText.lowercased())})
        } else {
            filterList = listDataPc
        }
        tableView.reloadData()
    }
}

extension RaPCViewController: UITableViewDelegate,UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RaPCCell", for: indexPath) as! RaPCCell
        cell.bindCell(item: filterList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = LapRapDetailViewController()
        vc.pcItem = filterList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
  
        if filterList[indexPath.row].status == "1" || filterList[indexPath.row].status == "2" {
            
            // delete
            let delete = UIContextualAction(style: .destructive, title: "Huỷ") { (action, view, completionHandler) in
             
              completionHandler(true)
                
                let refreshAlert = UIAlertController(title: "Thông báo", message: "Bạn có muốn hủy số phiếu \(self.filterList[indexPath.row].docEntry) ?", preferredStyle: .alert)

                refreshAlert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive, handler: { (action: UIAlertAction!) in
                      print("Handle Ok logic here")
                    if self.filterList[indexPath.row].status == "1" || self.filterList[indexPath.row].status == "2" {
                        ProgressView.shared.show()
                        Provider.shared.laprapPCAPService.updateStatePCBuild(doc_request: self.filterList[indexPath.row].docEntry_Request, doc_header: self.filterList[indexPath.row].docEntry, status: "4", update_by_code: Cache.user!.UserName, update_by_name: Cache.user!.EmployeeName, success: { [weak self] result in
                            ProgressView.shared.hide()
                            guard let self = self,let response = result else {return}
                            if response.message?.message_Code == 200 {
                                self.showPopUp(response.message?.message_Desc ?? "", "Thông báo", buttonTitle: "OK") {
                                    self.navigationController?.popViewController(animated: true)
                                }
                            } else {
                                self.showPopUp(response.message?.message_Desc ?? "", "Thông báo", buttonTitle: "OK", handleOk: nil)
                            }
                        }, failure: { [weak self] error in
                            self?.showPopUp(error.localizedDescription, "Thông báo", buttonTitle: "OK")
                        })
                    }else{
                        
                     }
                    tableView.reloadData()
                }))

                refreshAlert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: { (action: UIAlertAction!) in
                }))

                self.present(refreshAlert, animated: true, completion: nil)
            }
            // swipe
            let swipe = UISwipeActionsConfiguration(actions: [delete])
            
         
            swipe.performsFirstActionWithFullSwipe = false
            return swipe
        }

        return nil
      }

    
}

