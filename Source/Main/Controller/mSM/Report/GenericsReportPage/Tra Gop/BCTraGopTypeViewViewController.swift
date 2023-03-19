//
//  BCTraGopTypeViewViewController.swift
//  fptshop
//
//  Created by Apple on 8/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class BCTraGopTypeViewViewController: UIViewController {
    
    var tableView: UITableView!
    var listPermisstionID = [PermissionHashCode]()
    var cellTitle:[String] = []
    var isRealtime = false
    var comboPKType = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "BC Trả Góp"
        self.view.backgroundColor = UIColor.white
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        if isRealtime {
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_TRA_GOP_VUNG {
                    cellTitle.append("Báo cáo trả góp realtime theo vùng")
                }
                if permission == PermissionHashCode.BC_TRA_GOP_KHUVUC {
                    cellTitle.append("Báo cáo trả góp realtime theo khu vực")
                }
                if permission == PermissionHashCode.BC_TRA_GOP_SHOP {
                    cellTitle.append("Báo cáo trả góp realtime theo shop")
                }
            }
            
        } else {
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_TRA_GOP_VUNG {
                    cellTitle.append("Báo cáo luỹ kế trả góp theo vùng")
                }
                if permission == PermissionHashCode.BC_TRA_GOP_KHUVUC {
                    cellTitle.append("Báo cáo luỹ kế trả góp theo khu vực")
                }
                if permission == PermissionHashCode.BC_TRA_GOP_SHOP {
                    cellTitle.append("Báo cáo luỹ kế trả góp theo shop")
                }
            }
        }
    }
}

extension BCTraGopTypeViewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let title = cellTitle[indexPath.row]
        cell.textLabel?.text = title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = cellTitle[indexPath.row]
        if isRealtime {
            if title == "Báo cáo trả góp realtime theo vùng" {
                self.comboPKType = "TraGopRealtimeVung"
                
            } else if title == "Báo cáo trả góp realtime theo khu vực"{
                self.comboPKType = "TraGopRealtimeKhuvuc"
                
            } else if title == "Báo cáo trả góp realtime theo shop" {
                self.comboPKType = "TraGopRealtimeShop"
            }

        } else {
            if title == "Báo cáo luỹ kế trả góp theo vùng" {
                self.comboPKType = "TyLeTraGopVung"
                
            } else if title == "Báo cáo luỹ kế trả góp theo khu vực"{
                self.comboPKType = "TyLeTraGopKhuvuc"
                
            } else if title == "Báo cáo luỹ kế trả góp theo shop" {
                self.comboPKType = "TyLeTraGopShop"
            }
        }
        
        let newVC = DetailTraGopViewController()
        newVC.isRealtime = self.isRealtime
        newVC.comboPKType = self.comboPKType
        newVC.reportName = title
        self.navigationController?.pushViewController(newVC, animated: true)
    }
}
