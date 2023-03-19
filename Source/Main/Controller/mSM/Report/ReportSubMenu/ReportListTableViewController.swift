//
//  ShopHealthTableViewController.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 06/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ReportListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tbvSections: UITableView!
    var cellTitle: [String] = [];
    var screenSection: Int = 0;
    var reportSection: ReportCase!;
    var reportList: [ReportHealth]!;
    var listPermisstionID = [PermissionHashCode]()
    var listComboPKRealtimePermisstion = [PermissionHashCode]()
    let reportCollectionVC = ReportCollectionViewController();
    var comboPKType = ""
    
    var listDoanhNghiep = [DoanhNghiep]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitle.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ReportSectionTableViewCell;
        
        cell.imgvCellIcon.image = UIImage(named: "ic_report_realtime");
        cell.lblCellLabel.text = cellTitle[indexPath.row];
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            
            //Health first screen
            if(self.screenSection == 0){
                switch indexPath.row{
                case 0:
                    let reportHeader = ["STT","Tên chỉ tiêu","Mục tiêu","Thực hiện","TBN còn phải bán","So với kỳ trước","Tình trạng"];
                    
                    let reportData = mSMApiManager.GetHealthReport(shopCode: (Cache.selectedShopCode), type: "A", level: "", id: "").Data;
                    
                    if(reportData != nil){
                        self.reportCollectionVC.header = reportHeader;
                        self.reportCollectionVC.cellData = self.ProcessHealthData(data: reportData!, id: "A");
                        self.reportCollectionVC.reportSection = ReportCase.GetHealthReport;
                    }
                    
                    WaitingNetworkResponseAlert.DismissWaitingAlert(completion: {
                        self.navigationController?.pushViewController(self.reportCollectionVC, animated: true);
                    });
                    break;
                case 1:
                    let newListVC = ReportListTableViewController();
                    let reportList = mSMApiManager.GetHealthReport(shopCode: (Cache.selectedShopCode), type: "C", level: "", id: "").Data;
                    
                    newListVC.screenSection = 1;
                    if(reportList != nil){
                        reportList?.forEach{ report in
                            newListVC.cellTitle.append(report.TenChiTieu!);
                        }
                        newListVC.reportList = reportList;
                    }
                    else{
                        newListVC.reportList = [];
                    }
                    WaitingNetworkResponseAlert.DismissWaitingAlert(completion: {
                        self.navigationController?.pushViewController(newListVC, animated: true);
                    });
                    break;
                default:
                    break;
                }
            }
                
                //Health Second list screen
                //Setup data and header to view
            else if(self.screenSection == 1){
                let data = mSMApiManager.GetHealthReport(shopCode: (Cache.selectedShopCode), type: "C", level: "2", id: self.reportList[indexPath.row].Id ?? "").Data ?? []
                
                if(self.reportList.count > 0){
                    if(self.reportList[indexPath.row].Id! == "C.4" || self.reportList[indexPath.row].Id! == "C.5"){
                        self.reportCollectionVC.header = ["STT","Tên sản phẩm","Số lượng","Giá trị", "Vòng quay"];
                        self.reportCollectionVC.cellData = self.ProcessHealthData(data: data, id: self.reportList[indexPath.row].Id!);
                    }
                    else if(self.reportList[indexPath.row].Id! == "C.2" ){
                        self.reportCollectionVC.header = ["STT","Tên chỉ tiêu","Thực hiện DSPK", "Thực hiện SLPK"," Tỉ Trọng Phụ Kiện","SLPK/SLM","DSPK so với kỳ trước"];
                        self.reportCollectionVC.cellData = self.ProcessHealthData(data: data, id: self.reportList[indexPath.row].Id!);
                    }
                    else if(self.reportList[indexPath.row].Id! == "C.9" ){
                        self.reportCollectionVC.header = ["STT","Tên nhân viên","SL SSD","SL Samsung", "Tỉ lệ 1", "Doanh thu SSD","Doanh thu Samsung","Tỉ lệ 2"];
                        self.reportCollectionVC.cellData = self.ProcessHealthData(data: data, id: self.reportList[indexPath.row].Id!);
                    }
                    else if(self.reportList[indexPath.row].Id! == "C.8" ){
                        self.reportCollectionVC.header = ["STT","Link"];
                        self.reportCollectionVC.cellData = self.ProcessHealthData(data: data, id: self.reportList[indexPath.row].Id!);
                    }
                    else if(self.reportList[indexPath.row].Id! == "C.10" ){
                        self.reportCollectionVC.header = ["STT","Tên chỉ tiêu","Mục tiêu","Tỉ trọng TG","TB giá trị ĐH trả góp mục tiêu","TB giá trị ĐH trả góp thực hiện","Tình Trạng"];
                        self.reportCollectionVC.cellData = self.ProcessHealthData(data: data, id: self.reportList[indexPath.row].Id!);
                    }
                    else if(self.reportList[indexPath.row].Id! == "C.11" ){
                        self.reportCollectionVC.header = ["STT","Tên chỉ tiêu","SL Sim","SL Máy\n(ĐTDD+MTB)>2M ","Tỉ lệ khai thác","So với kỳ trước","Tình trạng"];
                        self.reportCollectionVC.cellData = self.ProcessHealthData(data: data, id: self.reportList[indexPath.row].Id!);
                    }
                    else if(self.reportList[indexPath.row].Id! == "C.12" ){
                        let listKhaiThacComboLuyKe = mSMApiManager.KhaiThacCombo_LuyKe().Data ?? []
                        self.reportCollectionVC.header = ["STT","Tên Shop","Mã NV","Tên NV", "SL Máy_3M", "Số CB Kèm Máy", "Số Máy Chưa Kèm CB"];
                        self.reportCollectionVC.cellData = self.getKhaiThacComboLuyKe(data: listKhaiThacComboLuyKe)
                        self.reportCollectionVC.isBCKhaiThacCombo = true
                    }
                    else{
                        self.reportCollectionVC.header = ["STT","Tên chỉ tiêu","Mục tiêu","Thực hiện","TBN còn phải bán","So với kỳ trước","TT"];
                        self.reportCollectionVC.cellData = self.ProcessHealthData(data: data, id: self.reportList[indexPath.row].Id!);
                    }
                }
                
                self.reportCollectionVC.reportSection = ReportCase.GetHealthReport;
                
                WaitingNetworkResponseAlert.DismissWaitingAlert(completion: {
                    self.navigationController?.pushViewController(self.reportCollectionVC, animated: true);
                });
            }
                
                //Opened Account Area and Zone
            else if(self.screenSection == 2){
                
                let date = Date();
                let calendar = Calendar.current;
                let username = (Cache.user?.UserName)!;
                var cellData: [[String]] = [];
                
                switch self.reportSection.unsafelyUnwrapped{
                case .GetOpenedAccount(let type):
                    if(indexPath.row == 0){
                        let tempData = mSMApiManager.GetOpenedAccountPending(day: "\(calendar.component(.day, from: date))", month: "\(calendar.component(.month, from: date))", year: "\(calendar.component(.year, from: date))", username: username, type: type).Data;
                        var header = [String]()
                        if(type == "2"){
                            header = ["STT", "Tên khu vực", "SL thông tin khách", "SL ngân hàng thẩm định"];
                            if(tempData != nil){
                                var counter = 0;
                                tempData!.forEach{ data in
                                    counter += 1;
                                    cellData.append([
                                        "\(counter)",
                                        "\(data.TenKhuVuc!)",
                                        "\(data.ReqPending_CustInfo!)",
                                        "\(data.ReqPending_AppraisalBank!)"
//                                        "\(data.ReqPending!)"
                                    ]);
                                }
                            }else{
                                cellData = [];
                            }
                            
                        } else if(type == "3"){
                            header = ["STT", "Tên vùng", "SL thông tin khách", "SL ngân hàng thẩm định"];
                            if(tempData != nil){
                                var counter = 0;
                                tempData!.forEach{ data in
                                    counter += 1;
                                    cellData.append([
                                        "\(counter)",
                                        "\(data.TenVungMien!)",
                                        "\(data.ReqPending_CustInfo!)",
                                        "\(data.ReqPending_AppraisalBank!)"
//                                        "\(data.ReqPending!)"
                                    ]);
                                }
                            }
                            else{
                                cellData = [];
                            }
                        }
                        
                        self.reportCollectionVC.cellData = cellData;
                        self.reportCollectionVC.header = header;
                        self.reportCollectionVC.reportSection = self.reportSection;
                    }
                    else if(indexPath.row == 1){
                        let tempData = mSMApiManager.GetOpenedAccountCompleted(day: "\(calendar.component(.day, from: date))", month: "\(calendar.component(.month, from: date))", year: "\(calendar.component(.year, from: date))", username: username, type: type).Data;
                        var header = [String]()
                        if(type == "2"){
                            header = ["STT", "Tên khu vực", "Được cấp thẻ", "Không được cấp thẻ"];
                            if(tempData != nil){
                                var counter = 0;
                                tempData!.forEach{ data in
                                    counter += 1;
                                    cellData.append([
                                        "\(counter)",
                                        "\(data.TenKhuVuc!)",
                                        "\(data.ReqComplete_Allow!)",
                                        "\(data.ReqComplete_NotAllow!)",
//                                        "\(data.ReqComplete!)"
                                    ]);
                                }
                            }else{
                                cellData = [];
                            }
                            
                        }
                        else if(type == "3"){
                            header = ["STT", "Tên vùng", "Được cấp thẻ", "Không được cấp thẻ"];
                            if(tempData != nil){
                                var counter = 0;
                                tempData!.forEach{ data in
                                    counter += 1;
                                    cellData.append([
                                        "\(counter)",
                                        "\(data.TenVungMien!)",
                                        "\(data.ReqComplete_Allow!)",
                                        "\(data.ReqComplete_NotAllow!)"
//                                        "\(data.ReqComplete!)"
                                    ]);
                                }
                            }
                            else{
                                cellData = [];
                            }
                        }
                        
                        self.reportCollectionVC.cellData = cellData;
                        self.reportCollectionVC.header = header;
                        self.reportCollectionVC.reportSection = self.reportSection;
                    }
                    break;
                default:
                    break;
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.navigationController?.pushViewController(self.reportCollectionVC, animated: true);
                }
            }
                
                //Opened Account Shop
            else if(self.screenSection == 3){
                let date = Date();
                let calendar = Calendar.current;
                let username = (Cache.user?.UserName)!;
                var cellData: [[String]] = [];
                var header: [String] = [];
                
                switch self.reportSection.unsafelyUnwrapped{
                case .GetOpenedAccount(let type):
                    //Open FFriends shop pending
                    if(indexPath.row == 0){
                        let tempData = mSMApiManager.GetOpenedAccountPending(day: "\(calendar.component(.day, from: date))", month: "\(calendar.component(.month, from: date))", year: "\(calendar.component(.year, from: date))", username: username, type: type).Data;
                        header = ["STT", "Tên shop", "SL thông tin khách", "SL ngân hàng thẩm định"];
                        if(tempData != nil){
                            var counter = 0;
                            tempData!.forEach{ data in
                                counter += 1;
                                cellData.append([
                                    "\(counter)",
                                    "\(data.TenShop!)",
                                    "\(data.ReqPending_CustInfo!)",
                                    "\(data.ReqPending_AppraisalBank!)"
//                                    "\(data.ReqPending!)"
                                ]);
                            }
                        }
                        else{
                            cellData = [];
                        }
                        
                        self.reportCollectionVC.cellData = cellData;
                        self.reportCollectionVC.header = header;
                        self.reportCollectionVC.reportSection = self.reportSection;
                    }
                        //Open FFriends shop completed
                    else if(indexPath.row == 1){
                        let tempData = mSMApiManager.GetOpenedAccountCompleted(day: "\(calendar.component(.day, from: date))", month: "\(calendar.component(.month, from: date))", year: "\(calendar.component(.year, from: date))", username: username, type: type).Data;
                        header = ["STT", "Tên shop", "Được cấp thẻ", "Không được cấp thẻ"];
                        if(tempData != nil){
                            var counter = 0;
                            tempData!.forEach{ data in
                                counter += 1;
                                cellData.append([
                                    "\(counter)",
                                    "\(data.TenShop!)",
                                    "\(data.ReqComplete_Allow!)",
                                    "\(data.ReqComplete_NotAllow!)"
//                                    "\(data.ReqComplete!)"
                                ]);
                            }
                        }
                        else{
                            cellData = [];
                        }
                        
                        self.reportCollectionVC.cellData = cellData;
                        self.reportCollectionVC.header = header;
                        self.reportCollectionVC.reportSection = self.reportSection;
                    }
                        //Open account shop pending details
                    else if(indexPath.row == 2){
                        let shopCode = (Cache.user?.ShopCode)!;
                        let tempData = mSMApiManager.GetOpenedAccountPendingDetails(reportDate: "\(calendar.component(.day, from: date))", reportMonth: "\(calendar.component(.month, from: date))", reportYear: "\(calendar.component(.year, from: date))", shopCode: shopCode).Data;
                        var header: [String]!;
                        header = ["STT", "Tên khách hàng", "Bước pending", "Số callLog"];
                        if(tempData != nil){
                            var counter = 0;
                            tempData!.forEach{ data in
                                counter += 1;
                                cellData.append([
                                    "\(counter)",
                                    "\(data.TenShop!)",
                                    "\(data.ReqComplete_Allow!)",
                                    "\(data.ReqComplete_NotAllow!)"
//                                    "\(data.ReqComplete!)"
                                ]);
                            }
                        }
                        else{
                            cellData = [];
                        }
                        
                        self.reportCollectionVC.cellData = cellData;
                        self.reportCollectionVC.header = header;
                        self.reportCollectionVC.reportSection = self.reportSection;
                    }
                    else{
                        let shopCode = (Cache.user?.ShopCode)!;
                        let tempData = mSMApiManager.GetOpenedAccountCompletedDetails(reportDate: "\(calendar.component(.day, from: date))", reportMonth: "\(calendar.component(.month, from: date))", reportYear: "\(calendar.component(.year, from: date))", shopCode: shopCode).Data;
                        var header: [String]!;
                        header = ["STT", "Tên khách hàng", "Kết quả", "Số callLog"];
                        if(tempData != nil){
                            var counter = 0;
                            tempData!.forEach{ data in
                                counter += 1;
                                cellData.append([
                                    "\(counter)",
                                    "\(data.TenShop!)",
                                    "\(data.ReqComplete_Allow!)",
                                    "\(data.ReqComplete_NotAllow!)"
//                                    "\(data.ReqComplete!)"
                                ]);
                            }
                        }
                        else{
                            cellData = [];
                        }
                        self.reportCollectionVC.cellData = cellData;
                        self.reportCollectionVC.header = header;
                        self.reportCollectionVC.reportSection = self.reportSection;
                    }
                    break;
                default:
                    break;
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.navigationController?.pushViewController(self.reportCollectionVC, animated: true);
                }
            }
                //Installment Rate
            else if(self.screenSection == 4){
                let reportDetailVC = DetailTyLeThanhCongTGViewController()
                switch indexPath.row{
                case 0:
                    reportDetailVC.type = "1"
                case 1:
                    reportDetailVC.type = "2"
                case 2:
                    reportDetailVC.type = "3"
                default:
                    break
                }
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
            }
            else if(self.screenSection == 5){
                let data = mSMApiManager.GetTrafficReport(username: "\((Cache.user?.UserName ?? ""))", type: "\(indexPath.row + 1)").Data ?? []
                self.reportCollectionVC.cellData = [[String]]()
                
                if(indexPath.row == 0 || indexPath.row == 1){
                    self.reportCollectionVC.header = ["STT", "Name", "Date_D", "ShopCounting", "Traffic_D", "Traffic_D-1", "Rate D/D-1", "Rate D/Average_LastMonth", "SO_D", "Rate SO_D/Traffic_D"];
                    data.forEach{ item in
                        self.reportCollectionVC.cellData.append([
                            "\(item.STT!)",
                            "\(item.Name!)",
                            "\(Common.GetDateStringFrom(jsonStr: item.Date_D!))",
                            "\(item.ShopCounting!)",
                            "\(item.Traffic_D!)",
                            "\(item.Traffic_D_Minus_1!)",
                            "\(item.Rate_D!)",
                            "\(item.Rate_Medium!)",
                            "\(item.SO!)",
                            "\(item.Rate_SO_Traffic!)"
                        ]);
                    }
                    
                } else{
                    self.reportCollectionVC.header = ["STT", "Name", "Date_D", "Traffic_D", "Traffic_D-1", "Rate D/D-1", "Rate D/Average_LastMonth", "SO_D", "Rate SO_D/Traffic_D"];
                    data.forEach{ item in
                        self.reportCollectionVC.cellData.append([
                            "\(item.STT!)",
                            "\(item.Name!)",
                            "\(Common.GetDateStringFrom(jsonStr: item.Date_D!))",
                            "\(item.Traffic_D!)",
                            "\(item.Traffic_D_Minus_1!)",
                            "\(item.Rate_D!)",
                            "\(item.Rate_Medium!)",
                            "\(item.SO!)",
                            "\(item.Rate_SO_Traffic!)"
                        ]);
                    }
                }
                self.reportCollectionVC.reportSection = self.reportSection;
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.navigationController?.pushViewController(self.reportCollectionVC, animated: true);
                }
            }
                // Bao cao Combo PK Realtime
            else if (self.screenSection == 6) {
                
                //--------
                //                let username = (Cache.user?.UserName)!;
                //                let token = (Cache.user?.Token)!
                /////get
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "BC CB PK Realtime Vùng" {
                    self.comboPKType = "ComboPKRealtimeVung"
                    
                } else if cell?.lblCellLabel.text == "BC CB PK Realtime Khu vực"{
                    self.comboPKType = "ComboPKRealtimeKhuVuc"
                    
                } else if cell?.lblCellLabel.text == "BC CB PK Realtime Shop" {
                    self.comboPKType = "ComboPKRealtimeShop"
                }
                
                debugPrint("combo type: \(self.comboPKType)")
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.reportCollectionVC.reportSection = self.reportSection;
                    self.reportCollectionVC.comboPKType = self.comboPKType
                    self.navigationController?.pushViewController(self.reportCollectionVC, animated: true);
                }
                
            }
                
                // Bao cao FFriends
            else if (self.screenSection == 7) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "BC Callog Pending" {
                    self.comboPKType = "FFriendCallogPending"
                    
                } else if cell?.lblCellLabel.text == "BC Tỷ lệ duyệt trong tháng"{
                    self.comboPKType = "FFriendTLDuyetTrongThang"
                    
                } else if cell?.lblCellLabel.text == "BC Tỷ lệ duyệt theo từng tháng" {
                    self.comboPKType = "FFriendTLDuyetTheoTungThang"
                    self.reportCollectionVC.isHasVendorView = true
                }
                
                debugPrint("combo type: \(self.comboPKType)")
                
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.reportCollectionVC.reportSection = self.reportSection;
                    self.reportCollectionVC.comboPKType = self.comboPKType
                    self.reportCollectionVC.listDoanhNghiep = self.listDoanhNghiep
                    self.navigationController?.pushViewController(self.reportCollectionVC, animated: true);
                }
            }
                
                // bc DSMay realtime
            else if (self.screenSection == 8) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "Doanh Số máy Vùng Realtime" {
                    self.comboPKType = "DSMayRealtimeVung"
                } else if cell?.lblCellLabel.text == "Doanh Số máy Khu Vực Realtime"{
                    self.comboPKType = "DSMayRealtimeKhuVuc"
                } else if cell?.lblCellLabel.text == "Doanh Số máy Shop Realtime" {
                    self.comboPKType = "DSMayRealtimeShop"
                }
                
                debugPrint("combo type: \(self.comboPKType)")
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = DetailDSMayRealtimeViewControllerV2()
                    reportDetailVC.reportSection = self.reportSection;
                    reportDetailVC.comboPKType = self.comboPKType
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
            }
                
                // bc LUY KE DSMay
            else if (self.screenSection == 9) {
                debugPrint("ReportSection: \(String(describing: self.reportSection))")
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "Báo cáo lũy kế sl máy vùng" {
                    self.comboPKType = "LuyKeSLMayVung"
                    
                } else if cell?.lblCellLabel.text == "Báo cáo lũy kế sl máy khu vực"{
                    self.comboPKType = "LuyKeSLMayKhuVuc"
                    
                } else if cell?.lblCellLabel.text == "Báo cáo lũy kế sl máy shop" {
                    self.comboPKType = "LuyKeSLMayShop"
                }
                
                debugPrint("combo type: \(self.comboPKType)")
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = DetailDSMayRealtimeViewControllerV2()
                    reportDetailVC.reportSection = self.reportSection;
                    reportDetailVC.comboPKType = self.comboPKType
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
                
            }
            else if (self.screenSection == 10 ) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "Báo cáo số lượng sim vùng" {
                    self.comboPKType = "ReportSLSIMVung"
                } else if cell?.lblCellLabel.text == "Báo cáo số lượng sim khu vực"{
                    self.comboPKType = "ReportSLSIMKhuvuc"
                } else if cell?.lblCellLabel.text == "Báo cáo số lượng sim shop" {
                    self.comboPKType = "ReportSLSIMShop"
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = DetailReportSimViewController()
                    reportDetailVC.reportSection = self.reportSection;
                    reportDetailVC.comboPKType = self.comboPKType
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
            }  else if (self.screenSection == 11 ) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell

                if cell?.lblCellLabel.text == "Báo cáo tỷ lệ sim theo vùng" {
                    self.comboPKType = "TyLeSLSIMVung"
                } else if cell?.lblCellLabel.text == "Báo cáo tỷ lệ sim theo khu vực"{
                    self.comboPKType = "TyLeSLSIMKhuvuc"
                } else if cell?.lblCellLabel.text == "Báo cáo tỷ lệ sim theo shop" {
                    self.comboPKType = "TyLeSLSIMShop"
                }

                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = DetailReportSimViewController()
                    reportDetailVC.reportSection = self.reportSection;
                    reportDetailVC.comboPKType = self.comboPKType
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }

            }

            else if (self.screenSection == 14 ) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "Báo cáo theo dõi số cọc vùng" {
                    self.comboPKType = "TraCocVung"
                } else if cell?.lblCellLabel.text == "Báo cáo theo dõi số cọc khu vực"{
                    self.comboPKType = "TraCocKhuVuc"
                } else if cell?.lblCellLabel.text == "Báo cáo theo dõi số cọc theo shop" {
                    self.comboPKType = "TraCocShop"
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = DetailTraCocViewController()
                    reportDetailVC.reportSection = self.reportSection;
                    reportDetailVC.comboPKType = self.comboPKType
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
            }
                
            else if (self.screenSection == 15 ) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "Luỹ kế SL-Lãi gộp thu hộ vùng" {
                    self.comboPKType = "BCSL_LaiGopThuHoVung"
                } else if cell?.lblCellLabel.text == "Luỹ kế SL-Lãi gộp thu hộ khu vực"{
                    self.comboPKType = "BCSL_LaiGopThuHoKhuVuc"
                } else if cell?.lblCellLabel.text == "Luỹ kế SL-Lãi gộp thu hộ shop" {
                    self.comboPKType = "BCSL_LaiGopThuHoShop"
                }
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = LuyKeSLLaiGopThuHoViewController()
                    reportDetailVC.reportSection = self.reportSection;
                    reportDetailVC.comboPKType = self.comboPKType
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
            }
                
            else if (self.screenSection == 16 ) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "Luỹ kế Khai thác KH Thu hộ - Theo Vùng" {
                    self.comboPKType = "ReportKhaiThacKMCRMVung"
                } else if cell?.lblCellLabel.text == "Luỹ kế Khai thác KH Thu hộ - Theo Khu Vực"{
                    self.comboPKType = "ReportKhaiThacKMCRMKhuvuc"
                } else if cell?.lblCellLabel.text == "Luỹ kế Khai thác KH Thu hộ - Theo Shop" {
                    self.comboPKType = "ReportKhaiThacKMCRMShop"
                }
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = DetailKhaiThacKMCRMViewController()
                    reportDetailVC.reportSection = self.reportSection;
                    reportDetailVC.comboPKType = self.comboPKType
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
            }
            else if (self.screenSection == 17 ) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "BC Realtime PM Diệt Virus Eset Vùng" {
                    self.comboPKType = "VirusVung"
                } else if cell?.lblCellLabel.text == "BC Realtime PM Diệt Virus Eset Khu Vực"{
                    self.comboPKType = "VirusASM"
                } else if cell?.lblCellLabel.text == "BC Realtime PM Diệt Virus Eset Shop" {
                    self.comboPKType = "VirusShop"
                }
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = VirusRealtimeViewController()
                    reportDetailVC.reportSection = self.reportSection;
                    reportDetailVC.type = self.comboPKType
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
            }
                
            else if (self.screenSection == 18 ) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "BC Realtime Gói GHBH Theo Vùng" {
                    self.comboPKType = "BHMRVung"
                } else if cell?.lblCellLabel.text == "BC Realtime Gói GHBH Theo Khu Vực"{
                    self.comboPKType = "BHMRASM"
                } else if cell?.lblCellLabel.text == "BC Realtime Gói GHBH Theo Shop" {
                    self.comboPKType = "BHMRShop"
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = BHMR_NewTestViewController()
                    reportDetailVC.reportSection = self.reportSection;
                    reportDetailVC.type = self.comboPKType
                    reportDetailVC.isRealtime = true
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
            }
            else if (self.screenSection == 19 ) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "BC Luỹ Kế Tháng PM Diệt Virus Eset Vùng" {
                    self.comboPKType = "VirusVung"
                } else if cell?.lblCellLabel.text == "BC Luỹ Kế Tháng PM Diệt Virus Eset Khu Vực"{
                    self.comboPKType = "VirusASM"
                } else if cell?.lblCellLabel.text == "BC Luỹ Kế Tháng PM Diệt Virus Eset Shop" {
                    self.comboPKType = "VirusShop"
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = VirusLuyKeViewController()
                    reportDetailVC.reportSection = self.reportSection;
                    reportDetailVC.type = self.comboPKType
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
            }
            else if (self.screenSection == 20 ) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "BC Luỹ Kế Tháng Gói GHBH Theo Vùng" {
                    self.comboPKType = "BHMRVung"
                } else if cell?.lblCellLabel.text == "BC Luỹ Kế Tháng Gói GHBH Theo Khu Vực"{
                    self.comboPKType = "BHMRASM"
                } else if cell?.lblCellLabel.text == "BC Luỹ Kế Tháng Gói GHBH Theo Shop" {
                    self.comboPKType = "BHMRShop"
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = BHMR_NewTestViewController()
                    reportDetailVC.reportSection = self.reportSection;
                    reportDetailVC.type = self.comboPKType
                    reportDetailVC.isRealtime = false
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
            }
                
            else if (self.screenSection == 21 ) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "BC Realtime Vé Máy Bay Vùng" {
                    self.comboPKType = "VeMayBayVung"
                } else if cell?.lblCellLabel.text == "BC Realtime Vé Máy Bay Khu Vực"{
                    self.comboPKType = "VeMayBayASM"
                } else if cell?.lblCellLabel.text == "BC Realtime Vé Máy Bay Shop" {
                    self.comboPKType = "VeMayBayShop"
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = VeMayBayReportViewController()
                    reportDetailVC.reportSection = self.reportSection;
                    reportDetailVC.type = self.comboPKType
                    reportDetailVC.isRealtime = true
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
                
            } else if (self.screenSection == 22 ) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                if cell?.lblCellLabel.text == "BC Luỹ Kế Vé Máy Bay Vùng" {
                    self.comboPKType = "VeMayBayVung"
                } else if cell?.lblCellLabel.text == "BC Luỹ Kế Vé Máy Bay Khu Vực"{
                    self.comboPKType = "VeMayBayASM"
                } else if cell?.lblCellLabel.text == "BC Luỹ Kế Vé Máy Bay Shop" {
                    self.comboPKType = "VeMayBayShop"
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = VeMayBayReportViewController()
                    reportDetailVC.reportSection = self.reportSection;
                    reportDetailVC.type = self.comboPKType
                    reportDetailVC.isRealtime = false
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
                
            } else if (self.screenSection == 23) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "Báo cáo realtime tỷ trọng PK Vùng" {
                    self.comboPKType = "TLPK_Vung"
                } else if cell?.lblCellLabel.text == "Báo cáo realtime tỷ trọng PK khu vực"{
                    self.comboPKType = "TLPK_KV"
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = TyLePKRealtimeViewController()
                    reportDetailVC.type = self.comboPKType
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
                
            } else if (self.screenSection == 24) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "Báo cáo Realtime Non IPhone Vùng" {
                    self.comboPKType = "PKIPhone_Vung"
                } else if cell?.lblCellLabel.text == "Báo cáo Realtime Non IPhone Khu vực"{
                    self.comboPKType = "PKIPhone_KV"
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = DoanhSoPK_IPhoneRealtimeViewController()
                    reportDetailVC.type = self.comboPKType
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
                
            } else if (self.screenSection == 25) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                
                if cell?.lblCellLabel.text == "Báo cáo theo Model" {
                    self.comboPKType = "Apple_Model"
                } else if cell?.lblCellLabel.text == "Báo cáo theo vùng"{
                    self.comboPKType = "Apple_Vung"
                } else if cell?.lblCellLabel.text == "Báo cáo theo khu vực"{
                    self.comboPKType = "Apple_KV"
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    //PUSH APPLE
                    let reportDetailVC = BCAppleRealtimePKViewController()
                    reportDetailVC.type = self.comboPKType
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }
            } else if self.screenSection == 26 || self.screenSection == 27 {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let vc =  HanghotReportViewcontroller()
                    if cell?.lblCellLabel.text == "Báo cáo hàng hot theo shop" {
                        vc.type = .realtimeshop
                    } else if cell?.lblCellLabel.text == "Báo cáo hàng hot theo vùng"{
                        vc.type = .realtimeVung
                    } else if cell?.lblCellLabel.text == "Báo cáo hàng hot theo khu vực"{
                        vc.type = .realtimeKhuvuc
                    } else if cell?.lblCellLabel.text == "Báo cáo luỹ kế hàng hot khu vực"{
                        vc.type = .luykeASM
                    } else if cell?.lblCellLabel.text == "Báo cáo luỹ kế hàng hot vùng"{
                        vc.type = .luykeVung
                    } else if cell?.lblCellLabel.text == "Báo cáo luỹ kế hàng hot shop"{
                        vc.type = .luykeShop
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if self.screenSection == 28 {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let vc =  BaoHanhVangViewController()
                    if cell?.lblCellLabel.text == "Bảo hành theo vùng" {
                        vc.type = .vangVung
                    } else if cell?.lblCellLabel.text == "Bảo hành theo khu vực"{
                        vc.type = .vangKhuvuc
                    } else if cell?.lblCellLabel.text == "Bảo hành theo shop"{
                        vc.type = .vangShop
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if  self.screenSection == 29 {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let vc =  BaoHiemXeViewController()
                    if cell?.lblCellLabel.text == "Báo cáo BH theo vùng"{
                        vc.type = .xeVung
                    } else if cell?.lblCellLabel.text == "Báo cáo BH theo khu vực"{
                        vc.type = .xeKhuVuc
                    } else if cell?.lblCellLabel.text == "Báo cáo BH theo Shop"{
                        vc.type = .xeShop
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if self.screenSection == 30 || self.screenSection == 31 {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let vc =  GiaDungReportViewController()
                    if cell?.lblCellLabel.text == "Báo cáo luỹ kế gia dụng theo shop" {
                        vc.type = .dailyShop
                    } else if cell?.lblCellLabel.text == "Báo cáo luỹ kế gia dụng theo vùng"{
                        vc.type = .dailyVung
                    } else if cell?.lblCellLabel.text == "Báo cáo luỹ kế gia dụng theo khu vực"{
                        vc.type = .dailyKhuvuc
                    } else if cell?.lblCellLabel.text == "Báo cáo realtime gia dụng theo khu vực"{
                        vc.type = .realtimeKhuvuc
                    } else if cell?.lblCellLabel.text == "Báo cáo realtime gia dụng theo vùng"{
                        vc.type = .realtimeVung
                    } else if cell?.lblCellLabel.text == "Báo cáo realtime gia dụng theo shop"{
                        vc.type = .realtimeShop
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if (self.screenSection == 32 ) {
                let cell = tableView.cellForRow(at: indexPath) as? ReportSectionTableViewCell

                if cell?.lblCellLabel.text == "Tỷ lệ khai thác combo iphone theo vùng" {
                    self.comboPKType = "SLIphoneVung"
                } else if cell?.lblCellLabel.text == "Tỷ lệ khai thác combo iphone theo khu vực"{
                    self.comboPKType = "SLIphoneKhuVuc"
                } else if cell?.lblCellLabel.text == "Tỷ lệ khai thác combo iphone theo shop" {
                    self.comboPKType = "SLIphoneShop"
                }
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let reportDetailVC = DetailReportiphone14()
                    reportDetailVC.reportSection = self.reportSection;
                    reportDetailVC.comboPKType = self.comboPKType
                    self.navigationController?.pushViewController(reportDetailVC, animated: true);
                }

            }
        }
    }
    
    func getListDoanhNghiep() {
        let userCode = Cache.user?.UserName
        let data = mSMApiManager.getListDoanhNghiep(username: userCode ?? "").Data
        if data != nil {
            self.listDoanhNghiep = data ?? []
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        if(reportSection != nil){
            self.SetupView();
        }
        tbvSections.register(UINib(nibName: "ReportSectionTableViewCell", bundle: nil), forCellReuseIdentifier: "cell");
        tbvSections.tableFooterView = UIView()
        tbvSections.delegate = self;
        tbvSections.dataSource = self;
        self.getListDoanhNghiep()
    }
    
    func SetupView(){
        switch reportSection.unsafelyUnwrapped{
        case .GetHealthReport:
            self.screenSection = 0;
            self.cellTitle = [
                "Cam kết của ASM xuyên suốt năm",
                "Bộ chỉ số sức khoẻ shop"
            ];
        case .GetOpenedAccount(let type):
            if(type == "1"){
                self.cellTitle = [
                    "Báo Cáo mở tài khoản FFriends pending",
                    "Báo Cáo mở tài khoản FFriends hoàn tất",
                    "Chi tiết mở tài khoản pending",
                    "Chi tiết kết quả mở tài khoản"]
                self.screenSection = 3;
            }
            else{
                self.cellTitle = [
                    "Báo Cáo mở tài khoản FFriends pending",
                    "Báo Cáo mở tài khoản FFriends hoàn tất"
                ]
                self.screenSection = 2;
            }
            break;
        case .GetInstallmentRate:
            self.cellTitle = [
                "Báo cáo tỷ lệ thành công theo vùng",
                "Báo cáo tỷ lệ thành công theo shop",
                "BC tỷ lệ thành công theo nhà trả góp"
            ]
            self.screenSection = 4;
            break;
            
        case .GetTrafficReport:
            self.cellTitle = [
                "Báo cáo traffic theo vùng",
                "Báo cáo trafic theo khu vực",
                "Báo cáo traffic theo shop"
            ]
            self.screenSection = 5;
            break;
            
        case .GetComboPKRealtime:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_COMBO_PK_VUNG_REALTIME {
                    cellTitle.append("BC CB PK Realtime Vùng")
                }
                if permission == PermissionHashCode.BC_COMBO_PK_KHUVUC_REALTIME {
                    cellTitle.append("BC CB PK Realtime Khu vực")
                }
                if permission == PermissionHashCode.BC_COMBO_PK_SHOP_REALTIME {
                    cellTitle.append("BC CB PK Realtime Shop")
                }
            }
            self.screenSection = 6;
            break;
            
        case .GetFFiends:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_CALLOG_PENDING {
                    cellTitle.append("BC Callog Pending")
                }
                if permission == PermissionHashCode.BC_TL_DUYET_TRONG_THANG {
                    cellTitle.append("BC Tỷ lệ duyệt trong tháng")
                }
                if permission == PermissionHashCode.BC_TL_DUYET_THEO_TUNG_THANG {
                    cellTitle.append("BC Tỷ lệ duyệt theo từng tháng")
                }
            }
            self.screenSection = 7;
            break;
            
        case .GetDSMayRealtime:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_LIST_DS_REALTIME_SLMAY_VUNG {
                    cellTitle.append("Doanh Số máy Vùng Realtime")
                }
                if permission == PermissionHashCode.BC_LIST_DS_REALTIME_SLMAY_KHUVUC {
                    cellTitle.append("Doanh Số máy Khu Vực Realtime")
                }
                if permission == PermissionHashCode.BC_LIST_DS_REALTIME_SLMAY_SHOP {
                    cellTitle.append("Doanh Số máy Shop Realtime")
                }
            }
            self.screenSection = 8;
            break;
            
        case .GetLuyKeSLMay:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_LUY_KE_SLMAY_VUNG {
                    cellTitle.append("Báo cáo lũy kế sl máy vùng")
                }
                if permission == PermissionHashCode.BC_LUY_KE_SLMAY_KHUVUC {
                    cellTitle.append("Báo cáo lũy kế sl máy khu vực")
                }
                if permission == PermissionHashCode.BC_LUY_KE_SLMAY_SHOP {
                    cellTitle.append("Báo cáo lũy kế sl máy shop")
                }
            }
            self.screenSection = 9;
            break;
            
        case .GetSLSim:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_SL_SIM_VUNG {
                    cellTitle.append("Báo cáo số lượng sim vùng")
                }
                if permission == PermissionHashCode.BC_SL_SIM_KHUVUC {
                    cellTitle.append("Báo cáo số lượng sim khu vực")
                }
                if permission == PermissionHashCode.BC_SL_SIM_SHOP {
                    cellTitle.append("Báo cáo số lượng sim shop")
                }
            }
            
            self.screenSection = 10;
            break;
            
        case .GetLuyKeSLSim:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_TY_LE_SL_SIM_VUNG {
                    cellTitle.append("Báo cáo tỷ lệ sim theo vùng")
                }
                if permission == PermissionHashCode.BC_TY_LE_SL_SIM_KHUVUC {
                    cellTitle.append("Báo cáo tỷ lệ sim theo khu vực")
                }
                if permission == PermissionHashCode.BC_TY_LE_SL_SIM_SHOP {
                    cellTitle.append("Báo cáo tỷ lệ sim theo shop")
                }
            }
            self.screenSection = 11;
            break;
            
        case .GetTraCoc:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_THEO_DOI_SO_COC_VUNG {
                    cellTitle.append("Báo cáo theo dõi số cọc vùng")
                }
                if permission == PermissionHashCode.BC_THEO_DOI_SO_COC_KHUVUC {
                    cellTitle.append("Báo cáo theo dõi số cọc khu vực")
                }
                if permission == PermissionHashCode.BC_THEO_DOI_SO_COC_SHOP {
                    cellTitle.append("Báo cáo theo dõi số cọc shop")
                }
            }
            self.screenSection = 14;
            break;
            
        case .GetSLLaiGopThuHo:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_LUYKE_SL_LAIGOP_THUHO_VUNG {
                    cellTitle.append("Luỹ kế SL-Lãi gộp thu hộ vùng")
                }
                if permission == PermissionHashCode.BC_LUYKE_SL_LAIGOP_THUHO_KHUVUC {
                    cellTitle.append("Luỹ kế SL-Lãi gộp thu hộ khu vực")
                }
                if permission == PermissionHashCode.BC_LUYKE_SL_LAIGOP_THUHO_SHOP {
                    cellTitle.append("Luỹ kế SL-Lãi gộp thu hộ shop")
                }
            }
            self.screenSection = 15;
            break;
            
        case .GetKhaiThacKMCRM:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_KHAITHAC_KM_CRM_VUNG {
                    cellTitle.append("Luỹ kế Khai thác KH Thu hộ - Theo Vùng")
                }
                if permission == PermissionHashCode.BC_KHAITHAC_KM_CRM_KHUVUC {
                    cellTitle.append("Luỹ kế Khai thác KH Thu hộ - Theo Khu Vực")
                }
                if permission == PermissionHashCode.BC_KHAITHAC_KM_CRM_SHOP {
                    cellTitle.append("Luỹ kế Khai thác KH Thu hộ - Theo Shop")
                }
            }
            self.screenSection = 16;
            break;
            
        case .GetVirus:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.REALTIME_VIRUS_VUNG {
                    cellTitle.append("BC Realtime PM Diệt Virus Eset Vùng")
                }
                if permission == PermissionHashCode.REALTIME_VIRUS_ASM {
                    cellTitle.append("BC Realtime PM Diệt Virus Eset Khu Vực")
                }
                if permission == PermissionHashCode.REALTIME_VIRUS_SHOP {
                    cellTitle.append("BC Realtime PM Diệt Virus Eset Shop")
                }
            }
            self.screenSection = 17;
            break;
            
        case .GetBHMR:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.REALTIME_BHMR_VUNG {
                    cellTitle.append("BC Realtime Gói GHBH Theo Vùng")
                }
                if permission == PermissionHashCode.REALTIME_BHMR_ASM {
                    cellTitle.append("BC Realtime Gói GHBH Theo Khu Vực")
                }
                if permission == PermissionHashCode.REALTIME_BHMR_SHOP {
                    cellTitle.append("BC Realtime Gói GHBH Theo Shop")
                }
            }
            self.screenSection = 18;
            break;
            
        case .GetVirusLuyKe:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.LUYKE_VIRUS_VUNG {
                    cellTitle.append("BC Luỹ Kế Tháng PM Diệt Virus Eset Vùng")
                }
                if permission == PermissionHashCode.LUYKE_VIRUS_ASM {
                    cellTitle.append("BC Luỹ Kế Tháng PM Diệt Virus Eset Khu Vực")
                }
                if permission == PermissionHashCode.LUYKE_VIRUS_SHOP {
                    cellTitle.append("BC Luỹ Kế Tháng PM Diệt Virus Eset Shop")
                }
            }
            self.screenSection = 19;
            break;
        case .GetBHMRLuyKe:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.LUYKE_BHMR_VUNG {
                    cellTitle.append("BC Luỹ Kế Tháng Gói GHBH Theo Vùng")
                }
                if permission == PermissionHashCode.LUYKE_BHMR_ASM {
                    cellTitle.append("BC Luỹ Kế Tháng Gói GHBH Theo Khu Vực")
                }
                if permission == PermissionHashCode.LUYKE_BHMR_SHOP {
                    cellTitle.append("BC Luỹ Kế Tháng Gói GHBH Theo Shop")
                }
            }
            self.screenSection = 20;
            break;
            
        case .GetVeMayBayRealtime:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.REALTIME_VEMAYBAY_VUNG {
                    cellTitle.append("BC Realtime Vé Máy Bay Vùng")
                }
                if permission == PermissionHashCode.REALTIME_VEMAYBAY_KHUVUC {
                    cellTitle.append("BC Realtime Vé Máy Bay Khu Vực")
                }
                if permission == PermissionHashCode.REALTIME_VEMAYBAY_SHOP {
                    cellTitle.append("BC Realtime Vé Máy Bay Shop")
                }
            }
            self.screenSection = 21;
            break;
            
        case .GetVeMayBayLuyKe:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.LUYKE_VEMAYBAY_VUNG {
                    cellTitle.append("BC Luỹ Kế Vé Máy Bay Vùng")
                }
                if permission == PermissionHashCode.LUYKE_VEMAYBAY_ASM {
                    cellTitle.append("BC Luỹ Kế Vé Máy Bay Khu Vực")
                }
                if permission == PermissionHashCode.LUYKE_VEMAYBAY_SHOP {
                    cellTitle.append("BC Luỹ Kế Vé Máy Bay Shop")
                }
            }
            self.screenSection = 22;
            break;
            
        case .GetTyLePKRealtime:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.TYLE_PHUKIEN_REALTIME_VUNG {
                    cellTitle.append("Báo cáo realtime tỷ trọng PK Vùng")
                }
                if permission == PermissionHashCode.TYLE_PHUKIEN_REALTIME_KV {
                    cellTitle.append("Báo cáo realtime tỷ trọng PK khu vực")
                }
            }
            self.screenSection = 23;
            break;
            
        case .GetPKIphoneRealtime:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.PK_IPHONE_REALTIME_VUNG {
                    cellTitle.append("Báo cáo Realtime Non IPhone Vùng")
                }
                if permission == PermissionHashCode.PK_IPHONE_REALTIME_KV {
                    cellTitle.append("Báo cáo Realtime Non IPhone Khu vực")
                }
            }
            self.screenSection = 24;
            break;
            
        case .GetRealtimeAppleComboPK:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_APPLE_MODEL {
                    cellTitle.append("Báo cáo theo Model")
                }
                if permission == PermissionHashCode.BC_APPLE_VUNG {
                    cellTitle.append("Báo cáo theo vùng")
                }
                if permission == PermissionHashCode.BC_APPLE_KV {
                    cellTitle.append("Báo cáo theo khu vực")
                }
            }
            self.screenSection = 25;
            break;
        case .GetRealTimeHanghot:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_REALTIME_HOT_SHOP {
                    cellTitle.append("Báo cáo hàng hot theo shop")
                }
                if permission == PermissionHashCode.BC_REALTIME_HOT_VUNG {
                    cellTitle.append("Báo cáo hàng hot theo vùng")
                }
                if permission == PermissionHashCode.BC_REALTIME_HOT_KHUVUC {
                    cellTitle.append("Báo cáo hàng hot theo khu vực")
                }
            }
            self.screenSection = 26;
            break;
        case .GetLuyKeHot:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_LUYKE_HOT_ASM {
                    cellTitle.append("Báo cáo luỹ kế hàng hot khu vực")
                }
                if permission == PermissionHashCode.BC_LUYKE_HOT_VUNG {
                    cellTitle.append("Báo cáo luỹ kế hàng hot vùng")
                }
                if permission == PermissionHashCode.BC_LUYKE_HOT_SHOP {
                    cellTitle.append("Báo cáo luỹ kế hàng hot shop")
                }
            }
            self.screenSection = 27;
            break;
        case .BaoHanhVang:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_BAOHANH_VANG_SHOP {
                    cellTitle.append("Bảo hành theo shop")
                }
                if permission == PermissionHashCode.BC_BAOHANH_VANG_VUNG {
                    cellTitle.append("Bảo hành theo vùng")
                }
                if permission == PermissionHashCode.BC_BAOHANH_VANG_KHUVUC {
                    cellTitle.append("Bảo hành theo khu vực")
                }
            }
            self.screenSection = 28
            break
        case .BaoHiemXe:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_BAOHIEM_XE_SHOP {
                    cellTitle.append("Báo cáo BH theo Shop")
                }
                if permission == PermissionHashCode.BC_BAOHIEM_XE_VUNG {
                    cellTitle.append("Báo cáo BH theo vùng")
                }
                if permission == PermissionHashCode.BC_BAOHIEM_XE_KHUVUC {
                    cellTitle.append("Báo cáo BH theo khu vực")
                }
            }
            self.screenSection = 29
            break
        case .GetDailyGiaDung:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_DAILY_GIA_DUNG_VUNG {
                    cellTitle.append("Báo cáo luỹ kế gia dụng theo vùng")
                }
                if permission == PermissionHashCode.BC_DAILY_GIA_DUNG_KHUVUC {
                    cellTitle.append("Báo cáo luỹ kế gia dụng theo khu vực")
                }
                if permission == PermissionHashCode.BC_DAILY_GIA_DUNG_SHOP {
                    cellTitle.append("Báo cáo luỹ kế gia dụng theo shop")
                }
            }
            self.screenSection = 30;
            break;
        case .GetRealTimeGiaDung:
            for permission in self.listPermisstionID {
                if permission == PermissionHashCode.BC_REALTIME_GIA_DUNG_VUNG {
                    cellTitle.append("Báo cáo realtime gia dụng theo vùng")
                }
                if permission == PermissionHashCode.BC_REALTIME_GIA_DUNG_KHUVUC {
                    cellTitle.append("Báo cáo realtime gia dụng theo khu vực")
                }
                if permission == PermissionHashCode.BC_REALTIME_GIA_DUNG_SHOP {
                    cellTitle.append("Báo cáo realtime gia dụng theo shop")
                }
            }
            self.screenSection = 31;
            break;
            case .GetSLiphone14:
                for permission in self.listPermisstionID {
                    if permission == PermissionHashCode.BC_SL_iphone14_VUNG {
                        cellTitle.append("Tỷ lệ khai thác combo iphone theo vùng")
                    }
                    if permission == PermissionHashCode.BC_SL_iphone14_KHUVUC {
                        cellTitle.append("Tỷ lệ khai thác combo iphone theo khu vực")
                    }
                    if permission == PermissionHashCode.BC_SL_iphone14_SHOP {
                        cellTitle.append("Tỷ lệ khai thác combo iphone theo shop")
                    }
                }

                self.screenSection = 32;
                break;
        default:
            break;
        }
        self.tbvSections.reloadData();
    }
    
    func ProcessHealthData(data: [ReportHealth], id: String) -> [[String]]{
        var returnData: [[String]] = [];
        var counter = 0;
        
        if(screenSection == 0 && id.range(of: "C") == nil){ 
            data.forEach{ item in
                counter += 1;
                returnData.append([
                    "\(counter)",
                    "\(item.TenChiTieu!)",
                    "\(item.ChiSoChoPhep!)",
                    "\(item.ChiSoHienTai!)",
                    "\(item.ChiSoConLai!)",
                    "\(item.SoSanh!)",
                    "\(item.TinhTrang!)"
                ]);
            }
        }
        else if(screenSection == 1 && (id == "C.4" || id == "C.5")){
            data.forEach{ item in
                counter += 1;
                returnData.append([
                    "\(counter)",
                    "\(item.TenChiTieu!)",
                    "\(item.SoLuong!)",
                    "\(item.GiaTri!)",
                    "\(item.VongQuay!)"
                ]);
            }
        }
        else if(screenSection == 1 && id == "C.9"){
            data.forEach{ item in
                counter += 1;
                returnData.append([
                    "\(counter)",
                    "\(item.TenChiTieu!)",
                    "\(item.SoLuongSSD!)",
                    "\(item.SoLuongSamsung!)",
                    "\(item.TiLeSL!)",
                    "\(item.DoanhThuSSD!)",
                    "\(item.DoanhThuSamSung!)",
                    "\(item.TiLeDS!)"
                ]);
            }
        }
        else if(screenSection == 1 && id == "C.2"){
            data.forEach{ item in
                counter += 1;
                returnData.append([
                    "\(counter)",
                    "\(item.TenChiTieu!)",
                    "\(item.ChiSoChoPhep!)",
                    "\(item.ChiSoHienTai!)",
                    "\(item.ChiSoConLai!)",
                    "\(item.SoSanh!)",
                    "\(item.TinhTrang!)"
                ]);
            }
        }
        else if(screenSection == 1 && id == "C.10"){
            data.forEach{ item in
                counter += 1;
                returnData.append([
                    "\(counter)",
                    "\(item.TenChiTieu!)",
                    "\(item.ChiSoChoPhep!)",
                    "\(item.ChiSoConLai!)",
                    "\(item.SoSanh!)",
                    "\(item.ChiSoHienTai!)",
                    "\(item.TinhTrang!)"
                ]);
            }
        }
        else if(screenSection == 1 && id == "C.11"){
            data.forEach{ item in
                counter += 1;
                returnData.append([
                    "\(counter)",
                    "\(item.TenChiTieu!)",
                    "\(item.ChiSoHienTai!)",
                    "\(item.ChiSoChoPhep!)",
                    "\(item.ChiSoConLai!)",
                    "\(item.SoSanh!)",
                    "\(item.TinhTrang!)"
                ]);
            }
        }
            
        else if(screenSection == 1 && id == "C.8"){
            data.forEach{ item in
                counter += 1;
                returnData.append([
                    "\(counter)",
                    "\(item.TenChiTieu!)"
                ]);
            }
        }
        else{
            data.forEach{ item in
                counter += 1;
                returnData.append([
                    "\(counter)",
                    "\(item.TenChiTieu!)",
                    "\(item.ChiSoChoPhep!)",
                    "\(item.ChiSoHienTai!)",
                    "\(item.ChiSoConLai!)",
                    "\(item.SoSanh!)",
                    "\(item.TinhTrang!)"
                ]);
            }
        }
        return returnData;
    }
    
    func getKhaiThacComboLuyKe(data: [KhaiThacCombo]) -> [[String]] {
        var returnData: [[String]] = [];
        data.forEach{ item in
            returnData.append([
                "\(item.STT ?? "")",
                "\(item.TenShop ?? "")",
                "\(item.MaNV ?? "")",
                "\(item.TenNV ?? "")",
                "\(item.SLMay3M ?? 0)",
                "\(item.SoComboBanKemMay ?? 0)",
                "\(item.SoMayChuaKemCombo ?? 0)"
            ]);
        }
        
        return returnData;
    }
}
