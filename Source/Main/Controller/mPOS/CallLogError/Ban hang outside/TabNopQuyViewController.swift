//
//  TabNopQuyViewController.swift
//  fptshop
//
//  Created by Apple on 4/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog

class TabNopQuyViewController: UIViewController {
    
    var parentNavigationController : UINavigationController?
    var tableView: UITableView!
    var listNapTien = [NapTienBHOutside]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - Common.Size(s: 80) - UIApplication.shared.statusBarFrame.height))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NopQuyBHOutsideCell.self, forCellReuseIdentifier: "nopQuyBHOutsideCell")
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy dữ liệu ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.parentNavigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        self.listNapTien.removeAll()
        
        MPOSAPIManager.sp_mpos_FRT_SP_OutSide_ls_naptien(userID: "\(Cache.user?.UserName ?? "")", MaShop: "\(Cache.user?.ShopCode ?? "")") { (arrayNapTien, error) in
            
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                
                if error.isEmpty {
                    if arrayNapTien.count > 0 {
                        for item in arrayNapTien {
                            self.listNapTien.append(item)
                        }
                        debugPrint("listNapTien.count: \(self.listNapTien.count)")
                    } else {
                        TableViewHelper.EmptyMessage(message: "Không có lịch sử nạp tiền.\n:/", viewController: self.tableView)
                    }
                    self.tableView.reloadData()
                } else {
                    let popup = PopupDialog(title: "Thông báo", message: "\(error)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    }
                    let buttonOne = CancelButton(title: "OK") {
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                }
            }
        }
    }

}
extension TabNopQuyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listNapTien.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = NopQuyBHOutsideCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "nopQuyBHOutsideCell")
        let item:NapTienBHOutside = listNapTien[indexPath.row]
        cell.setUpCell(item: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:90);
    }
}

