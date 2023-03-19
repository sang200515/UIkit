//
//  CallLogTableViewController.swift
//  mCallLog_v2
//
//  Created by Trần Thành Phương Đăng on 13/09/18.
//  Copyright © 2018 vn.com.fptshop. All rights reserved.
//

import UIKit;

class CallLogTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    var callLogType: Int!;
    var inputCallLogs: [CallLog] = [];
    var callLogs: [CallLog] = [];
    lazy var searchBar:UISearchBar = UISearchBar()
    var searchActive : Bool = false
    var filterCallLog: [CallLog] = []
    
    @IBOutlet var tbvCallLog: UITableView!;
    
    func filterContentForSearchText(_ searchText: String) {
        filterCallLog = self.callLogs.filter({ (item) -> Bool in
            return ("\(item.RequestID ?? 0)".lowercased().contains(searchText.lowercased())) || (item.RequestTitle?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        if filterCallLog.count == 0 {
            searchActive = false
        } else {
            searchActive = true
        }
        tbvCallLog.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filterCallLog.count
        } else {
            return callLogs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CallLogTableViewCell;
//        let formattedDateStr = Common.GetDateStringFrom(jsonStr: callLogs[indexPath.row].CreateDateTime!);
//
//        cell.lblDateCreated.text! = formattedDateStr;
        cell.lblRequestContent.text! = "";
        
        if searchActive {
            cell.lblRequestNumber.text! = "\(filterCallLog[indexPath.row].RequestID!)";
            cell.lblRequestTitle.text! = "\(filterCallLog[indexPath.row].RequestTitle!)";
            cell.lblDateCreated.text = filterCallLog[indexPath.row].CreateDateTime ?? ""
        } else {
            cell.lblRequestNumber.text! = "\(callLogs[indexPath.row].RequestID!)";
            cell.lblRequestTitle.text! = "\(callLogs[indexPath.row].RequestTitle!)";
            cell.lblDateCreated.text = callLogs[indexPath.row].CreateDateTime ?? ""
        }
        
        
        if(!callLogs[indexPath.row].CommentLast!.isEmpty){
            cell.lblRequestTitle.textColor = UIColor.red;
        }
        else{
            cell.lblRequestTitle.textColor = UIColor.darkGray;
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if searchActive {
            return editCalllogCell(listCalllogs: filterCallLog, indexPath: indexPath)
        } else {
            return editCalllogCell(listCalllogs: callLogs, indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch callLogType {
        case 0, 1, 2:
            
            if searchActive {
                if(filterCallLog[indexPath.row].RequestTypeID! == CallLogType.Appearance){
                    let detailsViewController = AppearanceCallLogDetailsVC();
                    detailsViewController.callLog = self.filterCallLog[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                    
                }
                else if(filterCallLog[indexPath.row].RequestTypeID! == CallLogType.Camera ||
                    filterCallLog[indexPath.row].RequestTypeID! == CallLogType.Discount){
                    let username = Cache.user?.UserName;
                    let password = UserDefaults.standard.object(forKey: "password") as! String;
                    let detailsUrl = self.CreateCallLogUrl(callLogId: self.filterCallLog[indexPath.row].RequestID!, userName: username!, password: password);
                    let callLogWebView = CallLogWebViewController();
                    callLogWebView.url = detailsUrl;
                    self.navigationController?.pushViewController(callLogWebView, animated: true);

                }
                else if(filterCallLog[indexPath.row].RequestTypeID! == CallLogType.CLXuatBoMauDemo){
                    let detailsViewController = CLXuatBoMauDemoViewController();
                    detailsViewController.callog = self.filterCallLog[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                    
                } else if(filterCallLog[indexPath.row].RequestTypeID! == CallLogType.CLDuyetLoiDOA){
                    let detailsViewController = DuyetLoiDOAViewController();
                    detailsViewController.callog = self.filterCallLog[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                    
                } else if(filterCallLog[indexPath.row].RequestTypeID! == CallLogType.CLDuyetCongNoVNPT){
                    let detailsViewController = DuyetCongNoVNPTViewController();
                    detailsViewController.callLog = self.filterCallLog[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                    
                } else if(filterCallLog[indexPath.row].RequestTypeID! == CallLogType.CLDuyetHanMucTheCao){
                    let detailsViewController = DuyetHanMucTheCaoViewController();
                    detailsViewController.callLog = self.filterCallLog[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                    
                }else{
                    let detailsViewController = GenericCallLogScreenVC();
                    detailsViewController.callLog = self.filterCallLog[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                }
            } else {
                if(callLogs[indexPath.row].RequestTypeID! == CallLogType.Appearance){
                    let detailsViewController = AppearanceCallLogDetailsVC();
                    detailsViewController.callLog = self.callLogs[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                    
                }
                else if(callLogs[indexPath.row].RequestTypeID! == CallLogType.Camera ||
                    callLogs[indexPath.row].RequestTypeID! == CallLogType.Discount){
                    let username = Cache.user?.UserName;
                    let password = UserDefaults.standard.object(forKey: "password") as! String;
                    let detailsUrl = self.CreateCallLogUrl(callLogId: self.callLogs[indexPath.row].RequestID!, userName: username!, password: password);
                    let callLogWebView = CallLogWebViewController();
                    callLogWebView.url = detailsUrl;
                    self.navigationController?.pushViewController(callLogWebView, animated: true);

                }
                else if(callLogs[indexPath.row].RequestTypeID! == CallLogType.CLXuatBoMauDemo){
                    let detailsViewController = CLXuatBoMauDemoViewController();
                    detailsViewController.callog = self.callLogs[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                    
                } else if(callLogs[indexPath.row].RequestTypeID! == CallLogType.CLDuyetLoiDOA){
                    let detailsViewController = DuyetLoiDOAViewController();
                    detailsViewController.callog = self.callLogs[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                    
                } else if(callLogs[indexPath.row].RequestTypeID! == CallLogType.CLDuyetCongNoVNPT){
                    let detailsViewController = DuyetCongNoVNPTViewController();
                    detailsViewController.callLog = self.callLogs[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                    
                } else if(callLogs[indexPath.row].RequestTypeID! == CallLogType.CLDuyetHanMucTheCao){
                    let detailsViewController = DuyetHanMucTheCaoViewController();
                    detailsViewController.callLog = self.callLogs[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                    
                }else{
                    let detailsViewController = GenericCallLogScreenVC();
                    detailsViewController.callLog = self.callLogs[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                }
            }
            
            
        case 3, 4, 5:
            
            if searchActive {
                guard indexPath.row < filterCallLog.count else { return }
                if(filterCallLog[indexPath.row].RequestTypeID! == CallLogType.RequestTransfer ||
                    filterCallLog[indexPath.row].RequestTypeID! == CallLogType.Infrastructure ||
                    filterCallLog[indexPath.row].RequestTypeID! == CallLogType.TargetSale){
                    let detailsViewController = GenericCallLogScreenVC();
                    detailsViewController.callLog = self.filterCallLog[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                    
                } else if (filterCallLog[indexPath.row].RequestTypeID! == CallLogType.CLHopDongFEC) {
                    let detailsViewController = HopDongFECViewController();
                    detailsViewController.callLog = self.filterCallLog[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true)
                    
                }  else{
                    let detailsViewController = NotificationDetailsScreenVC();
                    detailsViewController.callLog = self.filterCallLog[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                }
            } else {
                guard indexPath.row < callLogs.count else { return }
                if(callLogs[indexPath.row].RequestTypeID! == CallLogType.RequestTransfer ||
                    callLogs[indexPath.row].RequestTypeID! == CallLogType.Infrastructure ||
                    callLogs[indexPath.row].RequestTypeID! == CallLogType.TargetSale){
                    let detailsViewController = GenericCallLogScreenVC();
                    detailsViewController.callLog = self.callLogs[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                    
                } else if (callLogs[indexPath.row].RequestTypeID! == CallLogType.CLHopDongFEC) {
                    let detailsViewController = HopDongFECViewController();
                    detailsViewController.callLog = self.callLogs[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true)
                    
                } else {
                    let detailsViewController = NotificationDetailsScreenVC();
                    detailsViewController.callLog = self.callLogs[indexPath.row];
                    self.navigationController?.pushViewController(detailsViewController, animated: true);
                }
            }
            
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        self.navigationItem.titleView = searchBar
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
        
        let btnSearchDone = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(hideKeyboard))
        self.navigationItem.rightBarButtonItem = btnSearchDone
        tbvCallLog.tableFooterView = UIView();
        
        tbvCallLog.register(UINib(nibName: "CallLogTableViewCell", bundle: nil), forCellReuseIdentifier: "cell");
        tbvCallLog.delegate = self;
        tbvCallLog.dataSource = self;
    }
    
    @objc func hideKeyboard() {
        self.searchBar.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        let newViewController = LoadingViewController();
        let nc = NotificationCenter.default;
        
        newViewController.content = "Đang tải danh sách call log..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        self.navigationController?.present(newViewController, animated: true){
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil);
                self.GetCallLogsByType();
            }
        }
    }
    
    func editCalllogCell(listCalllogs: [CallLog], indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        if(listCalllogs[indexPath.row].RequestTypeID! != CallLogType.Discount){
            let username = (Cache.user?.UserName)!;
            //        let token = (Cache.mCallLogToken);
            let token = (Cache.user?.Token)!;
            
            let approveAction = UITableViewRowAction(style: .default, title: "Duyệt", handler: { action, indexPath in
                //var approvation: Int = 1;
                var data: CallLogUpdateResult?;
                
                WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
                    if(self.callLogType == 5){
                        //   approvation = 2;
                    }
                    
                    data = mCallLogApiManager.PostCallLogUpdate(callLogId: "\(listCalllogs[indexPath.row].RequestID!)", username: username, message: "Duyệt", approvation: 1, token: token).Data;
                    
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if(data != nil){
                            if(data!.StatusCode! == 1){
                                if self.searchActive {
                                    self.filterCallLog.remove(at: indexPath.row)
                                } else {
                                    self.callLogs.remove(at: indexPath.row)
                                }
                                self.tbvCallLog.deleteRows(at: [indexPath], with: .automatic);
                                print("Approved!");
                            }
                            else{
                                let alertViewController = UIAlertController(title: "Thông báo", message: data!.Message!, preferredStyle: .alert);
                                let alertOkAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                                    alertViewController.dismiss(animated: true, completion: nil);
                                })
                                alertViewController.addAction(alertOkAction);
                                self.present(alertViewController, animated: true, completion: nil);
                            }
                        }
                        else{
                            self.ShowUserLoginOtherDevice();
                        }
                    }
                }
            });
            approveAction.backgroundColor = UIColor(red: 0.26, green: 0.79, blue: 0.53, alpha: 1.0);
            
            let rejectAction = UITableViewRowAction(style: .default, title: "Từ chối", handler: { action, indexPath in
                var data: CallLogUpdateResult?;
                
                WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
                    data = mCallLogApiManager.PostCallLogUpdate(callLogId: "\(self.callLogs[indexPath.row].RequestID!)", username: username, message: "Từ chối", approvation: 0, token: token).Data;
                    
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if(data != nil){
                            if(data!.StatusCode! == 1){
                                if self.searchActive {
                                    self.filterCallLog.remove(at: indexPath.row)
                                } else {
                                    self.callLogs.remove(at: indexPath.row)
                                }
                                self.tbvCallLog.deleteRows(at: [indexPath], with: .automatic);
                                print("Rejected!");
                            }
                            else{
                                let alertViewController = UIAlertController(title: "Thông báo", message: data!.Message!, preferredStyle: .alert);
                                let alertOkAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                                    alertViewController.dismiss(animated: true, completion: nil);
                                })
                                alertViewController.addAction(alertOkAction);
                                self.present(alertViewController, animated: true, completion: nil);
                            }
                        }
                        else{
                            self.ShowUserLoginOtherDevice();
                        }
                    }
                }
            });
            rejectAction.backgroundColor = UIColor(red: 0.89, green: 0.32, blue: 0.32, alpha: 1.0);
            
            return [rejectAction, approveAction];
        }
        else{
            return [];
        }

    }
    
    func searchCallLogByTitle(title: String){
        callLogs.removeAll();
        
        inputCallLogs.forEach{ callLog in
            if(callLog.RequestTitle!.contains(title)){
                callLogs.append(callLog);
            }
        }
        tbvCallLog.reloadData();
    }
    
    func GetCallLogsByType(){
        let username: String = (Cache.user?.UserName)!;
        let token = (Cache.user?.Token)!;
        
        self.callLogs.removeAll();
        
        switch callLogType{
        case 0:
            let unfilteredData = mCallLogApiManager.GetCallLogList(username: username, token: token).Data
            if(unfilteredData != nil){
                let data = unfilteredData!.filter({$0.RequestTypeID! == CallLogType.Discount ||
                    $0.RequestTypeID! == CallLogType.Over100M ||
                    $0.RequestTypeID! == CallLogType.LCNB ||
                    $0.RequestTypeID! == CallLogType.CancelTransferRequest ||
                    $0.RequestTypeID! == CallLogType.ApproveDayOff ||
                    $0.RequestTypeID! == CallLogType.ImportSO ||
                    $0.RequestTypeID! == CallLogType.IT ||
                    $0.RequestTypeID! == CallLogType.Camera ||
                    $0.RequestTypeID! == CallLogType.ApproveInternalTranfer ||
                    $0.RequestTypeID! == CallLogType.Appearance || $0.RequestTypeID! == CallLogType.CLDuyetHanMucTheCao});
                self.inputCallLogs = data;
                self.callLogs = self.inputCallLogs;
                
                if(self.callLogs.count <= 0 ){
                    let emptyScreen = UINib(nibName: "EmptyCallLogScreen", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView;
                    emptyScreen.frame = UIScreen.main.bounds;
                    self.view.addSubview(emptyScreen);
                }
                else{
                    self.tbvCallLog.reloadData();
                }
            }
            else{
                self.ShowUserLoginOtherDevice();
            }
            break;
        case 3:
            let unfilteredData = mCallLogApiManager.GetCallLogList(username: username, token: token).Data
            if(unfilteredData != nil){
                let data = unfilteredData!.filter({ $0.RequestTypeID! == CallLogType.RequestTransfer ||
                    $0.RequestTypeID! == CallLogType.Infrastructure ||
                    $0.RequestTypeID! == CallLogType.TargetSale ||
                    $0.RequestTypeID! == CallLogType.CLHopDongFEC });
                self.inputCallLogs = data
                self.callLogs = self.inputCallLogs;
                if(self.callLogs.count <= 0 ){
                    let emptyScreen = UINib(nibName: "EmptyCallLogScreen", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView;
                    emptyScreen.frame = UIScreen.main.bounds;
                    self.view.addSubview(emptyScreen);
                }
                else{
                    self.tbvCallLog.reloadData();
                }
            }
            else{
                self.ShowUserLoginOtherDevice();
            }
            break;
        case 5:
            let unfilteredData = mCallLogApiManager.GetCallLogList(username: username, token: token).Data;
            
            if(unfilteredData != nil){
                let data = unfilteredData!.filter({ $0.RequestTypeID! == CallLogType.Notification ||
                    $0.RequestTypeID! == CallLogType.NotificationGQKN ||
                    $0.RequestTypeID! == CallLogType.InternalControl ||
                    $0.RequestTypeID! == CallLogType.BIPriceRemove ||
                    $0.RequestTypeID! == CallLogType.POSCheckSchedule ||
                    $0.RequestTypeID! == CallLogType.CRMErrorCheckingResult ||
                    $0.RequestTypeID! == CallLogType.CRMWarrantyResult ||
                    $0.RequestTypeID! == CallLogType.CRMGoldWarrantyResult });
                self.inputCallLogs = data;
                self.callLogs = self.inputCallLogs;
                if(self.callLogs.count <= 0 ){
                    let emptyScreen = UINib(nibName: "EmptyCallLogScreen", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView;
                    emptyScreen.frame = UIScreen.main.bounds;
                    self.view.addSubview(emptyScreen);
                }
                else{
                    self.tbvCallLog.reloadData();
                }
            }
            else{
                self.ShowUserLoginOtherDevice();
            }
            break;
        default:
            break;
        }
    }
    
    func ShowUserLoginOtherDevice(){
        let alertVC = UIAlertController(title: "Thông báo", message: "User đã đăng nhập trên thiết bị khác. \nVui lòng kiểm tra lại", preferredStyle: .alert);
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            alertVC.dismiss(animated: true, completion: nil);
        });
        
        alertVC.addAction(okAction);
        self.present(alertVC, animated: true, completion: nil);
    }
    
    func CreateCallLogUrl(callLogId: Int, userName: String, password: String) -> URL{
        let endpoint = "\(userName)\n\r\(password)\n\r/Requests/DetailFormMobile/\(callLogId)".toBase64();
        let url = URL(string: "https://calllog.fptshop.com.vn/Users/Authentication?k=\(endpoint)")!;
        return url;
    }
}

extension CallLogTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchBar.text ?? "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.searchBar.endEditing(true)
    }
}
