//
//  MyPhamTableViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 2/17/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class MyPhamTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var listPermisstionID = [PermissionHashCode]()
    var reportCaseMP: [ReportCaseMyPham] = [];
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tableView.backgroundColor = UIColor.white
        tableView.register(UINib(nibName: "ReportSectionTableViewCell", bundle: nil), forCellReuseIdentifier: "cell");
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView();
        self.view.addSubview(tableView)
        
        self.GetReportPermission();
        self.GetShopInfo();
        
        if(reportCaseMP.count <= 0){
            let emptyView = Bundle.main.loadNibNamed("EmptyDataView", owner: nil, options: nil)![0] as! UIView;
            emptyView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height);
            self.view.addSubview(emptyView);
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportCaseMP.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReportSectionTableViewCell;
        
        cell.imgvCellIcon.image = UIImage(named: reportCaseMP[indexPath.row].caseIcon);
        cell.lblCellLabel.text = reportCaseMP[indexPath.row].caseName;
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch reportCaseMP[indexPath.row] {
        case .GetMyPhamShop:
            let vc = ShopMyPhamViewController()
            self.navigationController?.pushViewController(vc, animated: true);
            
        case .GetMyPhamSaleman:
            let vc = MyPhamSalemanViewController()
            self.navigationController?.pushViewController(vc, animated: true);
            
        case .GetDSRealtimeMyPham:
            let vc = FBeautyReportViewController()
            self.navigationController?.pushViewController(vc, animated: true);
        case .GetMyPhamSalemanNew:
            let vc = MyPhamSalemanNewViewController()
            self.navigationController?.pushViewController(vc, animated: true);
//        default:
//            break
        }
    }
    
    func GetReportPermission(){
        let reportSections = mSMApiManager.GetReportSections(userCode: "\(Cache.user?.UserName ?? "")", token: "\(Cache.user?.Token ?? "")").Data
        
        if(reportSections != nil){
            if(reportSections!.count > 0){
                let permissions = reportSections![0].Permissions
                self.listPermisstionID = permissions
                self.reportCaseMP = ReportCaseMyPham.MapPermissionMypham(permissions: permissions);
            }
            self.tableView.reloadData();
        }
    }
    
    func GetShopInfo(){
        mSMApiManager.GetShopInfo { (rs, err) in
            if err.count <= 0 {
                if rs.count > 0 {
                    Cache.ShopInfo = rs[0]
                }
            } else {
                let alertVC = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert);
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                    alertVC.dismiss(animated: true, completion: nil);
                })
                alertVC.addAction(okAction);
                self.present(alertVC, animated: true, completion: nil);
            }
        }
    }
}
