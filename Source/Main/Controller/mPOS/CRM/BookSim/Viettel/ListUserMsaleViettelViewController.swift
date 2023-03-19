//
//  ListUserMsaleViettelViewController.swift
//  fptshop
//
//  Created by Ngoc Bao on 14/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Presentr

class ListUserMsaleViettelViewController: UIViewController {

    var tableView: UITableView!
    var cellHeight: CGFloat = 0
    var codeSegmented = CustomSegmentControl()
    var tabType = "1"
    lazy var searchBar:UISearchBar = UISearchBar()
    var list = [Mobifone_Msale_ActiveSim]()
    var filterList = [Mobifone_Msale_ActiveSim]()
    
    let presenter: Presentr = {
        let dynamicType = PresentationType.dynamic(center: ModalCenterPosition.center)
        let customPresenter = Presentr(presentationType: dynamicType)
        customPresenter.backgroundOpacity = 0.3
        customPresenter.roundCorners = true
        customPresenter.dismissOnSwipe = false
        customPresenter.dismissAnimated = false
//        customPresenter.backgroundTap = .noAction
        return customPresenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = .white
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Tìm theo số CMND/Căn cước/SĐT"
        
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.font = UIFont.systemFont(ofSize: 13)
            let placeholderLabel = searchBar.searchTextField.value(forKey: "placeholderLabel") as? UILabel
            placeholderLabel?.font = UIFont.italicSystemFont(ofSize: 13.0)
        } else {
            // Fallback on earlier versions
            let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideUISearchBar?.font = UIFont.systemFont(ofSize: 13)
            let placeholderLabel = textFieldInsideUISearchBar?.value(forKey: "placeholderLabel") as? UILabel
            placeholderLabel?.font = UIFont.italicSystemFont(ofSize: 13.0)
        }
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        self.navigationItem.titleView = searchBar
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)

        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:30))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:30), height: Common.Size(s:40))
        viewLeftNav.addSubview(btBackIcon)
        
        codeSegmented.frame = CGRect(x: 0, y: Common.Size(s: 10), width: self.view.frame.width, height: Common.Size(s: 40))
        codeSegmented.setButtonTitles(buttonTitles: ["CHƯA XÁC NHẬN", "ĐÃ XÁC NHẬN"])
        self.view.addSubview(codeSegmented)
        codeSegmented.backgroundColor = .white
        codeSegmented.selectorViewColor = UIColor(netHex:0x00955E)
        codeSegmented.selectorTextColor = UIColor(netHex:0x00955E)
        codeSegmented.unSelectorViewColor = UIColor.lightGray
        codeSegmented.unSelectorTextColor = UIColor.lightGray
        codeSegmented.delegate = self
        self.view.bringSubviewToFront(codeSegmented)
        
        let tableViewHeight:CGFloat = self.view.frame.height - (self.self.navigationController?.navigationBar.frame.height ?? 0) - UIApplication.shared.statusBarFrame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: codeSegmented.frame.origin.y + codeSegmented.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: tableViewHeight - Common.Size(s: 60)))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ItemUserMobifoneTableViewCell.self, forCellReuseIdentifier: "itemUserMobifoneTableViewCell")
        tableView.tableFooterView = UIView()
        
        self.searchBar.addDoneButtonOnKeyboard()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
        self.loadData(type: "P")
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChoosePackageMsaleMobifone(notification:)), name: NSNotification.Name.init("didChoosePackageMsaleMobifone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: NSNotification.Name.init("didEnterTopup_MobifoneMsale"), object: nil)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func hideKeyBoard() {
        self.searchBar.resignFirstResponder()
    }
    
    @objc func reloadData() {
        if self.tabType == "1" {
            self.loadData(type: "P")
        } else {
            self.loadData(type: "C")
        }
    }
    
    @objc func didChoosePackageMsaleMobifone(notification : NSNotification) {
        let info = notification.userInfo
        let totalSumNew = info?["totalSumNew"] as! Double
        let itemMobifoneID = info?["itemMobifoneID"] as! Int
        let package_price = info?["package_price"] as! Double
        let package_fpt = info?["package_fpt"] as! String
        let package_name_fpt = info?["package_name_fpt"] as! String
        let package_code = info?["package_code"] as! String
        let price_topup = info?["price_topup"] as! Double
        let btn_is_topup = info?["is_topup"] as! Int
        
        let itemGoiCuocSelected = MobifoneMsalePackage(package_price: package_price, package_fpt: package_fpt, package_name_fpt: package_name_fpt, package_code: package_code, price_topup: price_topup)
        let itemMobifone = self.list.first(where: {$0.id == itemMobifoneID})
        
        if btn_is_topup == 1 { // có topup
            let alert = UIAlertController(title: "Thông báo", message: "Bạn vui lòng vào POS để thu tiền khách hàng \(itemMobifone?.sub_name ?? "")\n Số tiền: \(Common.convertCurrencyDouble(value: totalSumNew))đ", preferredStyle: .alert)
            
            let actionConfirm = UIAlertAction(title: "OK", style: .default) { (action) in
                self.confirm_ActiveSim(simID: "\(itemMobifone?.id ?? 0)", package: itemGoiCuocSelected, phoneNum: "\(itemMobifone?.phonenumber ?? "")", is_topup: 1,provider: "Viettel")
            }
            alert.addAction(actionConfirm)
            self.present(alert, animated: true, completion: nil)
            
        } else { // không topup
            let alert = UIAlertController(title: "Thông báo", message: "Bạn vui lòng vào POS để thu tiền khách hàng \(itemMobifone?.sub_name ?? "")\n Số tiền: \(Common.convertCurrencyDouble(value: totalSumNew))đ", preferredStyle: .alert)
            
            let actionConfirm = UIAlertAction(title: "OK", style: .default) { (action) in
                self.confirm_ActiveSim(simID: "\(itemMobifone?.id ?? 0)", package: itemGoiCuocSelected, phoneNum: "\(itemMobifone?.phonenumber ?? "")", is_topup: 0,provider: "Viettel")
            }
            alert.addAction(actionConfirm)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func confirm_ActiveSim(simID: String, package: MobifoneMsalePackage, phoneNum: String, is_topup: Int,provider: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang xác nhận...") {
            CRMAPIManager.mpos_FRT_Viettel_Msale_ActiveSim_Confirm(id: "\(simID)", package_fpt: "\(package.package_fpt)", package_name_fpt: "\(package.package_name_fpt)", package_price: "\(package.package_price)", is_topup: "\(is_topup)", providers: provider) { (rsCode, msg, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rsCode == 1 {
                            let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "Xác nhận thành công!")", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                if is_topup == 1 {
                                    let vc = CardViewController()
                                    vc.is_Mobifone_Msale = true
                                    vc.mobifone_phone = phoneNum
                                    vc.mobifoneMsale_Package = package
                                    self.navigationController?.pushViewController(vc, animated: true)
                                } else {
                                    self.reloadData()
                                }
                            }
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "Xác nhận thất bại!")", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func loadData(type: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            CRMAPIManager.mpos_FRT_Viettel_Msale_ActiveSim_Getlist(type: "\(type)") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        self.list = rs
                        self.filterList = rs
                        if(rs.count <= 0){
                            TableViewHelper.EmptyMessage(message: "Không có dữ liệu.\n:/", viewController: self.tableView)
                        }else{
                            TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                        }
                        self.tableView.reloadData()
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

extension ListUserMsaleViettelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ItemUserMobifoneTableViewCell = tableView.dequeueReusableCell(withIdentifier: "itemUserMobifoneTableViewCell", for: indexPath) as! ItemUserMobifoneTableViewCell
        var item: Mobifone_Msale_ActiveSim
        let key = searchBar.text ?? ""
        if key.count > 0 {
            item = filterList[indexPath.row]
        } else {
            item = list[indexPath.row]
        }
        
        cell.setupCell(tabType: self.tabType, item: item)
        self.cellHeight = cell.estimateCellHeight
        cell.itemMSaleMobifone = item
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

extension ListUserMsaleViettelViewController: CustomSegmentControlDelegate {
    func change(to index: Int) {
        debugPrint("change index = \(index)")
        
        switch index {
        case 0:
            self.tabType = "1"
            self.loadData(type: "p")
            break
        case 1:
            self.tabType = "2"
            tableView.allowsSelection = false
            self.loadData(type: "C")
            break
        default:
            break
        }
    }
}
extension ListUserMsaleViettelViewController: ItemUserMobifoneTableViewCellDelegate {
    func actionSelectUserMobifone(item: Mobifone_Msale_ActiveSim, totalSum: Double) {
        if item.flag_package == 0 { //qua xác nhận

            let alert = UIAlertController(title: "Thông báo", message: "Bạn vui lòng vào POS để thu tiền khách hàng \(item.sub_name)\n Số tiền: \(Common.convertCurrencyDouble(value: totalSum))đ", preferredStyle: .alert)

            let actionCancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
            let actionConfirm = UIAlertAction(title: "Xác nhận", style: .default) { (_) in
                WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang xác nhận...") {
                    CRMAPIManager.mpos_FRT_Viettel_Msale_ActiveSim_Confirm(id: "\(item.id)", package_fpt: "\(item.package_fpt)", package_name_fpt: "\(item.package_name_fpt)", package_price: "\(item.package_price)", is_topup: "0",providers: item.Provider) { (rsCode, msg, err) in
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            if err.count <= 0 {
                                if rsCode == 1 {
                                    let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "Xác nhận thành công!")", preferredStyle: UIAlertController.Style.alert)
                                    let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                        self.reloadData()
                                    }
                                    alert.addAction(action)
                                    self.present(alert, animated: true, completion: nil)
                                } else {
                                    let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "Xác nhận thất bại!")", preferredStyle: UIAlertController.Style.alert)
                                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                    alert.addAction(action)
                                    self.present(alert, animated: true, completion: nil)
                                }
                            } else {
                                let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }

            alert.addAction(actionCancel)
            alert.addAction(actionConfirm)
            self.present(alert, animated: true, completion: nil)

        } else if item.flag_package == 1 { // chọn gói cước
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                CRMAPIManager.mpos_FRT_Mobifone_Msale_ActiveSim_Load_package(phonenumber: "\(item.phonenumber)") { (rs, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if err.count <= 0 {
                            if rs.count > 0 {
                                let vc = ChonGoiCuocMobifoneViewController()
                                vc.listGoiCuoc = rs
                                vc.itemMsaleMobifone = item
                                self.customPresentViewController(self.presenter, viewController: vc, animated: true)
                            } else {
                                let alert = UIAlertController(title: "Thông báo", message: "Không có danh sách gói cước!", preferredStyle: UIAlertController.Style.alert)
                                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            }
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
}

extension ListUserMsaleViettelViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: "\(searchBar.text ?? "")")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(key: "\(searchBar.text ?? "")")
    }
    
    func search(key:String){
        if key.count > 0 {
            filterList = list.filter({($0.id_no.localizedCaseInsensitiveContains(key)) || ($0.phonenumber.localizedCaseInsensitiveContains(key))})
        } else {
            filterList = list
        }
        tableView.reloadData()
    }
}
