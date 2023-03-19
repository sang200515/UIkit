//
//  ListTraGopViewController.swift
//  fptshop
//
//  Created by Apple on 8/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListTraGopViewController: UIViewController {
    
    var tableView: UITableView!
    var listPermisstionID = [PermissionHashCode]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "BC Trả Góp"
        self.view.backgroundColor = UIColor.white
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tableView.register(UINib(nibName: "ReportSectionTableViewCell", bundle: nil), forCellReuseIdentifier: "cell");
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
}

extension ListTraGopViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReportSectionTableViewCell;
        
        if indexPath.row == 0 {
            cell.imgvCellIcon.image = UIImage(named: "ic_report_details");
            cell.lblCellLabel.text = "BC Luỹ Kế Trả Góp"
        } else {
            cell.imgvCellIcon.image = UIImage(named: "ic_report_realtime");
            cell.lblCellLabel.text = "BC Trả Góp Realtime"
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVC = BCTraGopTypeViewViewController()
        if indexPath.row == 0 {
            newVC.isRealtime = false
        } else {
            newVC.isRealtime = true
        }
        newVC.listPermisstionID = self.listPermisstionID
        self.navigationController?.pushViewController(newVC, animated: true)
    }
}
