//
//  TabTheCaoBHOutsideViewController.swift
//  fptshop
//
//  Created by Apple on 4/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog

class TabTheCaoBHOutsideViewController: UIViewController {
    
    var parentNavigationController : UINavigationController?
    var tableView: UITableView!
    var listTheCao = [TheCaoOutside]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - Common.Size(s: 80) - UIApplication.shared.statusBarFrame.height))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemSOOutsideCardTableViewCell.self, forCellReuseIdentifier: "ItemSOOutsideCardTableViewCell")
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
        self.listTheCao.removeAll()
        MPOSAPIManager.sp_mpos_FRT_SP_OutSide_LS_TheCao(userID: "\(Cache.user?.UserName ?? "")", MaShop: "\(Cache.user?.ShopCode ?? "")") { (arrayTheCao, error) in

            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)

                if error.isEmpty {
                    if arrayTheCao.count > 0 {
                        for item in arrayTheCao {
                            self.listTheCao.append(item)
                        }
                        debugPrint(self.listTheCao.count)
                    } else {
                        TableViewHelper.EmptyMessage(message: "Không có lịch sử thẻ cào\n:/", viewController: self.tableView)
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

extension TabTheCaoBHOutsideViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listTheCao.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemSOOutsideCardTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemSOOutsideCardTableViewCell")
        let card:TheCaoOutside = listTheCao[indexPath.row]
        cell.setupTheCaoOutsideCell(item: card)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:90);
    }
}
