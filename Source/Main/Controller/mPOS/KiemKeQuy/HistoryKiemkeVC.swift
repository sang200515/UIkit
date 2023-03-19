//
//  HistoryKiemkeVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 07/09/2021.
//  Copyright © 2021 Duong Hoang Minh. All rights reserved.
//

import UIKit

class HistoryKiemkeVC: BaseController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listData = [SearchKiemKeDetail]()
    var shop: ItemShop?
    let refresh = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LỊCH SỬ KIỂM KÊ"
        let button = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "Filter"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(onFilter), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HistorykiemKeCell", bundle: nil), forCellReuseIdentifier: "HistorykiemKeCell")
        searchKiemke(docEntry: nil, from: Common.gettimeWith(format: "dd/MM/yyyy"), to: Common.gettimeWith(format: "dd/MM/yyyy"), shopCode: "\(self.shop!.code)", status: "")
        refresh.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.refreshControl = refresh
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    @objc func onRefresh() {
        refresh.endRefreshing()
        searchKiemke(docEntry: nil, from: Common.gettimeWith(format: "dd/MM/yyyy"), to: Common.gettimeWith(format: "dd/MM/yyyy"), shopCode: "\(self.shop!.code)", status: "")
    }
    func searchKiemke(docEntry: Int?,from: String,to:String,shopCode: String,status: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            KiemkequyApiManager.shared.getSearchKiemke(docentry: docEntry, from: from, to: to, shopCode: shopCode, status: status) {[weak self] result, msgErr in
                guard let self = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if msgErr != "" {
                        self.showPopUp(msgErr, "Thông báo", buttonTitle: "OK", handleOk: nil)
                    } else {
                        self.listData = result?.data ?? []
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    @objc func onFilter() {
        let popup = SearchKiemkePopup()
        popup.modalPresentationStyle = .overCurrentContext
        popup.modalTransitionStyle = .crossDissolve
        popup.onSearchs = { [weak self] (from,to,state,number,shop) in
            guard let self = self else {return}
            self.showLoading()
            KiemkequyApiManager.shared.getSearchKiemke(docentry: Int(number) ?? nil, from: from, to: to, shopCode: shop != "" ? shop : "\(self.shop!.code)", status: state) {[weak self] result, msgErr in
                guard let self = self else {return}
                self.stopLoading()
                if msgErr != "" {
                    self.showPopUp(msgErr, "Thông báo", buttonTitle: "OK", handleOk: nil)
                } else {
                    self.listData = result?.data ?? []
                    self.tableView.reloadData()
                }
                
            }
            
        }
        self.present(popup, animated: true, completion: nil)
    }
    
}

extension HistoryKiemkeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistorykiemKeCell", for: indexPath) as! HistorykiemKeCell
        cell.bindCell(item:listData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = KiemkeVC()
        vc.currentState = .review
        vc.shopItem = self.shop
        vc.reviewItem = listData[indexPath.row]
        vc.onreload = {
            self.searchKiemke(docEntry: nil, from: Common.gettimeWith(format: "dd/MM/yyyy"), to: Common.gettimeWith(format: "dd/MM/yyyy"), shopCode: "\(self.shop!.code)", status: "")
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
