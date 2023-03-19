//
//  ReportMainViewController.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 22/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ReportMainViewController: UIViewController {

    @IBOutlet weak var btnFShopLogin: UIButton!;
    @IBOutlet weak var btnTimekeeping: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    @IBAction func ShowReports() {
        let reportSections = mSMApiManager.GetReportSections(userCode: "\(Cache.user?.UserName ?? "")", token: "\(Cache.user?.Token ?? "")")
        if(reportSections.Error == "" && reportSections.Data != nil){
            let reportTableViewController = ReportTableViewController();
            if((reportSections.Data?.count)! > 0){
                let permissions = reportSections.Data![0].Permissions
                reportTableViewController.reportCase = ReportCase.MapPermission(permissions: permissions);
            }
            else{
                reportTableViewController.reportCase = [];
            }
            self.tabBarController?.navigationController?.pushViewController(reportTableViewController, animated: true);
        }
    }
    
    @IBAction func TimekeepingTapped(_ sender: Any) {
        let shiftList = GetUserCheckList();
        let shopInfo = GetShopInfo();
        if(shiftList.count > 0){
            if(shopInfo[0].IPPublic != ""){
                
            }
        }
        else{
            btnTimekeeping.isHidden = true;
        }
    }
    
    func GetUserCheckList() -> [UserShift]{
        var shiftList: [UserShift]!;
        let userID = (Cache.user?.Id)!;
        let data = mSMApiManager.GetUserShiftList(userID: "\(userID)").Data;
        
        if(data != nil){
            shiftList = data!;
        }
        return shiftList;
    }
    
    func GetShopInfo() -> [ShopInfo] {
        var shopInfo: [ShopInfo]!
        mSMApiManager.GetShopInfo { (rs, err) in
            if err.count <= 0 {
                if rs.count > 0 {
                    Cache.ShopInfo = rs[0]
                    shopInfo = rs
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
        return shopInfo
    }
}
