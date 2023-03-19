//
//  HistoryChangeSimItelVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 06/10/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftUI
import PopupDialog

class HistoryChangeSimItelVC: UIViewController {

    
    @IBOutlet weak var phonetxt: UITextField!
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var toDate: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var listSimHistory: [SimHistoryItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromDate.text = Common.gettimeWith(format: "dd/MM/yyyy")
        toDate.text = Common.gettimeWith(format: "dd/MM/yyyy")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HistoryChangeItelCell", bundle: nil), forCellReuseIdentifier: "HistoryChangeItelCell")
        searchChangeOrders()
    }
    func searchChangeOrders() {
        ProgressView.shared.show()
        MPOSAPIManager.VTGetChangeSimHistory(fromdate: fromDate.text ?? "", toDate: toDate.text ?? "", UserName: "\(Cache.user?.UserName ?? "")", ShopCode: "\(Cache.user?.ShopCode ?? "")", IsdnOrSerial: self.phonetxt.text ?? "", handler: { (results, message) in
                ProgressView.shared.hide()
                    self.listSimHistory = results
                    
                    if message.count <= 0 {
                        if(results.count <= 0){
                            TableViewHelper.EmptyMessage(message: "Không có dữ liệu.\n:/", viewController: self.tableView)
                        }else{
                            TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                        }
                        self.tableView.reloadData()
                    } else {
                        let alertVC = UIAlertController(title: "Thông báo", message: "\(message)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default) { (_) in
                            self.tableView.reloadData()
                        }
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                
            })
    }

    @IBAction func onSearch() {
        searchChangeOrders()
    }
    
    func getQRcode(phoneNumber:String,SOMPOS:String,SeriSim:String){
        
        ProgressView.shared.show()
            MPOSAPIManager.sp_mpos_FRT_SP_ESIM_getqrcode(SDT:
            phoneNumber,SOMPOS: SOMPOS,SeriSim: SeriSim) { (results, err) in
                ProgressView.shared.hide()
                    
                    if (err.count <= 0){
                        if results.count > 0 {
                            results[0].sdt = phoneNumber
                            let newViewController = QRCodeEsimViettelViewController()
                            newViewController.esimQRCode = results[0]
                            newViewController.isFromHistory = true
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        } else {
                            let popup = PopupDialog(title: "Thông báo", message: "API Error\nGet QRCode Esim Fail!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                            }
                            let buttonOne = CancelButton(title: "OK") {}
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                        
                    }else{
                        
                        let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                            
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                
            }
        
    }
}

extension HistoryChangeSimItelVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSimHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryChangeItelCell") as! HistoryChangeItelCell
        let item = listSimHistory[indexPath.row]
        cell.bindCell(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let simHistory = listSimHistory[indexPath.row]
        if simHistory.LoaiSim == "ESIM" {
            self.getQRcode(phoneNumber: simHistory.Phonenumber, SOMPOS: "", SeriSim: simHistory.SeriSim_New)
        }
    }
}
