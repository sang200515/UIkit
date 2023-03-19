//
//  HistoryInstallRecordsViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 11/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ItemHistoryInstallCell"
class HistoryInstallRecordsViewController: UITableViewController {

    // MARK: - Properties
    private var items = [InstallationReceiptData](){
        didSet { tableView.reloadData() }
    }
    private var lstTemp = [InstallationReceiptData]()
  
    private var cellHeight: CGFloat = 200
    private let searchBar = UISearchBar()
    // MARK: - Lifecycle
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInstallationReceiptList()
        configureUI()
        tableView.dataSource = self
        tableView.delegate = self
    }
    // MARK: - API
    let receiptStatus = ""
    func fetchInstallationReceiptList(){
        refreshControl?.beginRefreshing()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) { [self] in

        MPOSAPIMangerV2.shared.fetchInstallationReceiptList() {[weak self] result in
            guard let self = self else {return}
            WaitingNetworkResponseAlert.DismissWaitingAlert {

            self.refreshControl?.endRefreshing()
            switch result {
            case .success(let data):
                if data.success {
                    self.items = data.data
                    self.lstTemp = data.data
                    
                }
                
            case .failure(let error):
                self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
                
            }
        }
        }
    }
    }
    
    func fetchInstallationReceiptDetailByReceiptId(with receiptId: Int,receiptStatus:String){
        MPOSAPIMangerV2.shared.fetchInstallationReceiptDetailByReceiptId(receiptId: receiptId) {[weak self] result in
            guard let self = self else {return}
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                switch result {
                case .success(let data):
                  
                    if data.success{
                        let type = data.data.masterData[0].deviceType
                        switch type{
                        case "laptop":
                            let newViewController = DetailInstallLaptopHistoryViewController(item: data)
                            newViewController.receiptStatus = receiptStatus
                            newViewController.receiptID = receiptId
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        case "mobile":
                            let newViewController = DetailInstallMobileHistoryViewController(item: data)
                            newViewController.receiptStatus = receiptStatus
                            newViewController.receiptID = receiptId
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        default:
                            break
                        }
                    }
                
          
                case .failure(let error):
                    self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
                    
                }
            }
        }
    }
    
    // MARK: - Selectors
    @objc func handleRefresh(){
        fetchInstallationReceiptList()
    }
    @objc func handleSearchBar(){
        search(shouldShow: true)

        searchBar.becomeFirstResponder()
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        searchBar.sizeToFit()
        searchBar.delegate = self
        showSearchBarButton(shouldShow: true)
        
        
        view.backgroundColor = .white
        navigationItem.title = "Lịch sử giao dịch"
        tableView.register(UINib(nibName: "ItemHistoryInstallCell", bundle: nil), forCellReuseIdentifier: "ItemHistoryInstallCell")
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    func showSearchBarButton(shouldShow :Bool){
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleSearchBar))
        }else{
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func search(shouldShow: Bool){
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
        
//        if shouldShow {
//            navigationItem.titleView = searchBar
//        }else{
//            navigationItem.titleView = nil
//        }
    }


}
// MARK: - TraCocEcomMainViewController
extension HistoryInstallRecordsViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
        items.removeAll()
        items = lstTemp
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        if searchText.count > 0 {
            if (!searchText.hasPrefix("01") && !searchText.hasPrefix("00") && searchText.hasPrefix("0")){
                // search phone
                items.removeAll()
                items = self.lstTemp.filter { "\($0.phoneNumber)".contains(searchText) }
            }else{
                items.removeAll()
                items = self.lstTemp.filter { "\($0.imei)".contains(searchText) }
            }
        }else {
            items.removeAll()
            items = lstTemp
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            if (!searchText.hasPrefix("01") && !searchText.hasPrefix("00") && searchText.hasPrefix("0") ){
                // search phone
                items.removeAll()
                items = self.lstTemp.filter { "\($0.phoneNumber)".contains(searchText) }
            }else{
                items.removeAll()
                items = self.lstTemp.filter { "\($0.imei)".contains(searchText) }
            }
        }else {
            items.removeAll()
            items = lstTemp
        }
    
    }
}


    // MARK: - UITableViewDataSource
extension HistoryInstallRecordsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ItemHistoryInstallCell
        cell.bindCell(item: items[indexPath.row])
        
//        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        fetchInstallationReceiptDetailByReceiptId(with: item.id,receiptStatus:item.receiptStatus)
    }
  
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {


            // delete
            let delete = UIContextualAction(style: .destructive, title: "Huỷ") {[weak self] (action, view, completionHandler)  in
                guard let self = self else  { return }
              completionHandler(true)
                if self.items[indexPath.row].deletButton{
                    let popup = PopupVC()
                    popup.onOKAction = {
                        completionHandler(true)
                        let id = self.items[indexPath.row].id
                        MPOSAPIMangerV2.shared.deleteInstallationReceipt(receiptId: String(id)) {[weak self] result in
                              guard let self = self else {return}
                              WaitingNetworkResponseAlert.DismissWaitingAlert {
                                  switch result {
                                  case .success(let data):
                                      if data.success {
                                          if self.items.count > 0 {
                                              self.showPopUp(data.Message, "Thông báo", buttonTitle: "OK")
                                              self.items.remove(at: indexPath.row)
                                              self.fetchInstallationReceiptList()
                                              self.updateUI()

                                          }
                                      }else {
                                          self.showPopUp("Bạn chỉ được phép hủy giao dịch khi đang ở trạng thái tạo phiếu!", "Thông báo", buttonTitle: "OK")

                                      }

                                  case .failure(let error):
                                      self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")

                                  }
                              }
                          }

                    }
                    popup.dataPopup.isShowClose = true
                    popup.dataPopup.content = "Bạn có chắc muốn huỷ giao dịch này."
                    popup.dataPopup.titleButton = "XÁC NHẬN"
                    popup.modalPresentationStyle = .overCurrentContext
                    popup.modalTransitionStyle = .crossDissolve
                    self.present(popup, animated: true, completion: nil)
                }
                //can delete
                else {
                    print("oke1")

                        let popup = PopupVC()
                        popup.onOKAction = {
                            completionHandler(true)

                        }
                        popup.dataPopup.isShowClose = true
                        popup.dataPopup.content = "Bạn chỉ được phép huỷ phiếu giao dịch khi đang ở trạng thái tạo phiếu!"
                        popup.dataPopup.titleButton = "XÁC NHẬN"
                        popup.dataPopup.isShowClose = false
                        popup.modalPresentationStyle = .overCurrentContext
                        popup.modalTransitionStyle = .crossDissolve
                        self.present(popup, animated: true, completion: nil)
                }


            }
            // swipe
            let swipe = UISwipeActionsConfiguration(actions: [delete])


            swipe.performsFirstActionWithFullSwipe = false
            return swipe

        return nil

      }
    func updateUI(){
        self.tableView.reloadData()
    }
//    override  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
//    -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Huyr") { (_, _, completionHandler) in
//
//            if(self.items.count > 0){
//                self.items.remove(at: indexPath.row)
//            }
//            self.tableView.reloadData()
//            completionHandler(true)
//            print("delete")
//        }
//
//        deleteAction.backgroundColor = .systemRed
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
//        return configuration
//    }
    
}

//API return Device
//        MPOSAPIMangerV2.shared.returnDeviceReceipt(receiptId: 436,signatureBase64: "asdasdasda") {[weak self] result in
//              guard let self = self else {return}
//              WaitingNetworkResponseAlert.DismissWaitingAlert {
//                  switch result {
//                  case .success(let data):
//                      if data.success {
//                          print("thanhf co")
//
//                      }
//
//                  case .failure(let error):
//                      self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
//
//                  }
//              }
//          }
