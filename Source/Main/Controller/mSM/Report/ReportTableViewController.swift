//
//  ReportTableViewController.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 22/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ReportTableViewController: UITableViewController {
    
    var reportCase: [ReportCase] = [];
//    var comboPKReportCases: [ReportCase] = []
    var listPermisstionID = [PermissionHashCode]()
    override func viewDidLoad() {
        super.viewDidLoad();
        tableView.register(UINib(nibName: "ReportSectionTableViewCell", bundle: nil), forCellReuseIdentifier: "cell");
        
        self.GetReportPermission();
        self.GetShopInfo();
        
        if(reportCase.count <= 0){
            let emptyView = Bundle.main.loadNibNamed("EmptyDataView", owner: nil, options: nil)![0] as! UIView;
            emptyView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height);
            self.view.addSubview(emptyView);
        }
        self.tableView.tableFooterView = UIView();
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportCase.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReportSectionTableViewCell;
        
        cell.imgvCellIcon.image = UIImage(named: reportCase[indexPath.row].caseIcon);
        cell.lblCellLabel.text = reportCase[indexPath.row].caseName;
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch reportCase[indexPath.row] {
        case .GetHealthReport,
             .GetTargetReport,
             .GetUpgradeLoan,
             .GetUnpaidLoan:
            let shopListVC = ShopListViewController();
            shopListVC.reportCase = reportCase[indexPath.row];
            self.navigationController?.pushViewController(shopListVC, animated: true);
            break;
        case .GetOpenedAccount,
             .GetInstallmentRate,
             .GetTrafficReport:
            let reportListVC = ReportListTableViewController();
            reportListVC.reportSection = reportCase[indexPath.row];
            self.navigationController?.pushViewController(reportListVC, animated: true);
            
        case .GetComboPKRealtime,
             .GetDSMayRealtime,
             .GetLuyKeSLMay,
             .GetSLSim,
             .GetLuyKeSLSim,
             .GetSLiphone14,
             .GetTraCoc,
             .GetSLLaiGopThuHo,
             .GetKhaiThacKMCRM,
             .GetVirus,
             .GetBHMR,
             .GetVirusLuyKe,
             .GetBHMRLuyKe,
             .GetVeMayBayRealtime,
             .GetVeMayBayLuyKe,
             .GetTyLePKRealtime,
             .GetPKIphoneRealtime,
             .GetRealtimeAppleComboPK,
             .GetRealTimeHanghot,
             .GetLuyKeHot,
             .BaoHiemXe,
             .BaoHanhVang,
             .GetDailyGiaDung,
             .GetRealTimeGiaDung:
            let reportListVC = ReportListTableViewController();
            reportListVC.reportSection = reportCase[indexPath.row];
            reportListVC.listPermisstionID = self.listPermisstionID
            self.navigationController?.pushViewController(reportListVC, animated: true);

        case .GetTraGop:
            let reportListVC = ListTraGopViewController();
            reportListVC.listPermisstionID = self.listPermisstionID
            self.navigationController?.pushViewController(reportListVC, animated: true);
            
        case .GetFFiends:
            let reportListVC = ReportListTableViewController();
            reportListVC.reportSection = reportCase[indexPath.row];
            reportListVC.listPermisstionID = self.listPermisstionID
            self.navigationController?.pushViewController(reportListVC, animated: true);
            
        case .GetASMAgreementReport:
            let reportVC = DatePickerViewController();
            reportVC.reportSection = reportCase[indexPath.row];
            self.navigationController?.pushViewController(reportVC, animated: true);
        case .GetViolationMember:
            let selectMemberVC = EmployeeSelectViewController();
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
                let employees = mSMApiManager.GetViolationMember(userCode: "").Data;
                if(employees != nil){
                    if(employees!.count > 0){
                        selectMemberVC.employees = employees!;
                    }
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    selectMemberVC.reportCase = self.reportCase[indexPath.row];
                    self.navigationController?.pushViewController(selectMemberVC, animated: true);
                }
            }
            
        case .GetVisitorCounting:
            let vc = DetailVisitorReportVC2()
            self.navigationController?.pushViewController(vc, animated: true);
        case .GetVisitorTheoDoiShop:
            let vc = ShopVisitorDetailViewController()
            self.navigationController?.pushViewController(vc, animated: true);
            
        case .CheckListShopASM:
            let vc = DetailCheckListShopASMViewController()
            self.navigationController?.pushViewController(vc, animated: true);
            
        case .GetZoneSalesRealtime:
            let vc = DSVungRealtimeViewController()
            self.navigationController?.pushViewController(vc, animated: true);
            
        case .GetDSRealtimeMatKinh:
            let vc = DSRealtimeMatKinhViewController()
            self.navigationController?.pushViewController(vc, animated: true);
            
        case .GetDSRealtimeDongHo:
            let vc = DSRealtimeDongHoShopViewController()
            self.navigationController?.pushViewController(vc, animated: true);
            
        case .GetBCDSRealtimeDongHo:
            let vc = DSRealtimeDongHoViewController()
            self.navigationController?.pushViewController(vc, animated: true);
        case .GetKhaiThacMayKemPK:
            let vc = KhaiThacMayKemPKViewController()
            self.navigationController?.pushViewController(vc, animated: true);
        case .GetRealtimeShopKhaiThacMayKemPK:
            let vc = RealtimeShopKTMayKemPKViewController()
            self.navigationController?.pushViewController(vc, animated: true);
        default:
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
                
                let reportDetailsVC = ReportCollectionViewController();
                let data = self.reportCase[indexPath.row].reportData;
                let reportHeader = self.reportCase[indexPath.row].reportHeader;
                
                reportDetailsVC.cellData = data;
                reportDetailsVC.header = reportHeader;
                reportDetailsVC.reportSection = self.reportCase[indexPath.row];
                
                WaitingNetworkResponseAlert.DismissWaitingAlert(completion: {
                    self.navigationController?.pushViewController(reportDetailsVC, animated: true);
                });
            }
        }
        
    }
    
    func GetReportPermission(){
        let reportSections = mSMApiManager.GetReportSections(userCode: "\(Cache.user?.UserName ?? "")", token: "\(Cache.user?.Token ?? "")").Data
        
        if(reportSections != nil){
            if(reportSections!.count > 0){
                let permissions = reportSections![0].Permissions
                self.listPermisstionID = permissions
                self.reportCase = ReportCase.MapPermission(permissions: permissions);
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
