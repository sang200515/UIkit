//
//  ListUserMsaleMobifoneViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 11/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Presentr

class ListUserMsaleMobifoneViewController: UIViewController {

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
                self.confirm_ActiveSim(simID: "\(itemMobifone?.id ?? 0)", package: itemGoiCuocSelected, phoneNum: "\(itemMobifone?.phonenumber ?? "")", is_topup: 1)
            }
            alert.addAction(actionConfirm)
            self.present(alert, animated: true, completion: nil)
            
        } else { // không topup
            let alert = UIAlertController(title: "Thông báo", message: "Bạn vui lòng vào POS để thu tiền khách hàng \(itemMobifone?.sub_name ?? "")\n Số tiền: \(Common.convertCurrencyDouble(value: totalSumNew))đ", preferredStyle: .alert)
            
            let actionConfirm = UIAlertAction(title: "OK", style: .default) { (action) in
                self.confirm_ActiveSim(simID: "\(itemMobifone?.id ?? 0)", package: itemGoiCuocSelected, phoneNum: "\(itemMobifone?.phonenumber ?? "")", is_topup: 0)
            }
            alert.addAction(actionConfirm)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func confirm_ActiveSim(simID: String, package: MobifoneMsalePackage, phoneNum: String, is_topup: Int) {
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang xác nhận...") {
            CRMAPIManager.mpos_FRT_Mobifone_Msale_ActiveSim_Confirm(id: "\(simID)", package_fpt: "\(package.package_fpt)", package_name_fpt: "\(package.package_name_fpt)", package_price: "\(package.package_price)", is_topup: "\(is_topup)") { (rsCode, msg, err) in
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
            CRMAPIManager.mpos_FRT_Mobifone_Msale_ActiveSim_Getlist(type: "\(type)") { (rs, err) in
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

extension ListUserMsaleMobifoneViewController: UITableViewDelegate, UITableViewDataSource {
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

extension ListUserMsaleMobifoneViewController: CustomSegmentControlDelegate {
    func change(to index: Int) {
        debugPrint("change index = \(index)")
        
        switch index {
        case 0:
            self.tabType = "1"
            self.loadData(type: "P")
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
extension ListUserMsaleMobifoneViewController: ItemUserMobifoneTableViewCellDelegate {
    func actionSelectUserMobifone(item: Mobifone_Msale_ActiveSim, totalSum: Double) {
        if item.flag_package == 0 { //qua xác nhận

            let alert = UIAlertController(title: "Thông báo", message: "Bạn vui lòng vào POS để thu tiền khách hàng \(item.sub_name)\n Số tiền: \(Common.convertCurrencyDouble(value: totalSum))đ", preferredStyle: .alert)

            let actionCancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
            let actionConfirm = UIAlertAction(title: "Xác nhận", style: .default) { (_) in
                WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang xác nhận...") {
                    CRMAPIManager.mpos_FRT_Mobifone_Msale_ActiveSim_Confirm(id: "\(item.id)", package_fpt: "\(item.package_fpt)", package_name_fpt: "\(item.package_name_fpt)", package_price: "\(item.package_price)", is_topup: "0") { (rsCode, msg, err) in
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

extension ListUserMsaleMobifoneViewController: UISearchBarDelegate {
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

protocol ItemUserMobifoneTableViewCellDelegate: AnyObject {
    func actionSelectUserMobifone(item: Mobifone_Msale_ActiveSim, totalSum: Double)
}

class ItemUserMobifoneTableViewCell: UITableViewCell {
    var estimateCellHeight:CGFloat = 0
    var itemMSaleMobifone:Mobifone_Msale_ActiveSim?
    weak var delegate:ItemUserMobifoneTableViewCellDelegate?
    var totalSum: Double = 0
    
    func setupCell(tabType: String, item: Mobifone_Msale_ActiveSim){
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let viewContent = UIView(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: self.contentView.frame.width - Common.Size(s: 10), height: self.frame.height))
        viewContent.backgroundColor = UIColor(netHex: 0xF8F4F5)
        viewContent.layer.cornerRadius = 5
        self.addSubview(viewContent)
        
        if tabType == "1" {
            let tapAction = UITapGestureRecognizer(target: self, action: #selector(actionCell))
            viewContent.isUserInteractionEnabled = true
            viewContent.addGestureRecognizer(tapAction)
        }
        
        let lbMposNum = UILabel(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 5), width: (viewContent.frame.width - Common.Size(s: 20))/2, height: Common.Size(s: 20)))
        lbMposNum.text = "MPOS: \(item.so_mpos)"
        lbMposNum.font = UIFont.boldSystemFont(ofSize: 15)
        lbMposNum.textColor = UIColor(netHex: 0x109e59)
        viewContent.addSubview(lbMposNum)

        let lbCreateDate = UILabel(frame: CGRect(x: lbMposNum.frame.origin.x + lbMposNum.frame.width, y: Common.Size(s: 5), width: lbMposNum.frame.width, height: Common.Size(s: 20)))
        lbCreateDate.font = UIFont.systemFont(ofSize: 13)
        lbCreateDate.textAlignment = .right
        lbCreateDate.text = "\(item.activedate)"
        viewContent.addSubview(lbCreateDate)
        
        let line = UIView(frame: CGRect(x: Common.Size(s: 10), y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 3), width: viewContent.frame.width - Common.Size(s: 20), height: Common.Size(s: 1)))
        line.backgroundColor = .lightGray
        viewContent.addSubview(line)

        let lbKHName = UILabel(frame: CGRect(x: Common.Size(s: 10), y: line.frame.origin.y + line.frame.height + Common.Size(s: 5), width: (line.frame.width)/3 + Common.Size(s: 15), height: Common.Size(s: 20)))
        lbKHName.text = "Tên khách hàng:"
        lbKHName.font = UIFont.systemFont(ofSize: 14)
        lbKHName.textColor = .lightGray
        viewContent.addSubview(lbKHName)
        
        if tabType == "1" { // chua xac nhan
//            lbMposNum.isHidden = true
//            lbCreateDate.isHidden = true
//            line.isHidden = true
            
//            lbKHName.frame = CGRect(x: lbKHName.frame.origin.x, y: Common.Size(s: 5), width: lbKHName.frame.width, height: lbKHName.frame.height)
        } else {
//            lbMposNum.isHidden = false
//            lbCreateDate.isHidden = false
//            line.isHidden = false
//            lbKHName.frame = CGRect(x: lbKHName.frame.origin.x, y: line.frame.origin.y + line.frame.height + Common.Size(s: 5), width: lbKHName.frame.width, height: lbKHName.frame.height)
        }

        let lbKHNameText = UILabel(frame: CGRect(x: lbKHName.frame.origin.x + lbKHName.frame.width, y: lbKHName.frame.origin.y, width: (line.frame.width * 2/3) - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbKHNameText.text = "\(item.sub_name)"
        lbKHNameText.font = UIFont.systemFont(ofSize: 14)
        lbKHNameText.textAlignment = .right
        viewContent.addSubview(lbKHNameText)

        let lbKHNameTextHeight:CGFloat = lbKHNameText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbKHNameText.optimalHeight + Common.Size(s: 5))
        lbKHNameText.numberOfLines = 0
        lbKHNameText.frame = CGRect(x: lbKHNameText.frame.origin.x, y: lbKHNameText.frame.origin.y, width: lbKHNameText.frame.width, height: lbKHNameTextHeight)
        
        let lbSdt = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbKHNameText.frame.origin.y + lbKHNameTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbSdt.text = "SĐT khách hàng:"
        lbSdt.font = UIFont.systemFont(ofSize: 14)
        lbSdt.textColor = .lightGray
        viewContent.addSubview(lbSdt)
        
        let lbSdtText = UILabel(frame: CGRect(x: lbSdt.frame.origin.x + lbSdt.frame.width, y: lbSdt.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbSdtText.text = "\(item.phonenumber)"
        lbSdtText.font = UIFont.systemFont(ofSize: 14)
        lbSdtText.textAlignment = .right
        viewContent.addSubview(lbSdtText)
        
        let lbSerial = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbSdtText.frame.origin.y + lbSdtText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbSerial.text = "Serial:"
        lbSerial.font = UIFont.systemFont(ofSize: 14)
        lbSerial.textColor = .lightGray
        viewContent.addSubview(lbSerial)
        
        let lbSerialText = UILabel(frame: CGRect(x: lbSerial.frame.origin.x + lbSerial.frame.width, y: lbSerial.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbSerialText.text = "\(item.serial)"
        lbSerialText.font = UIFont.systemFont(ofSize: 14)
        lbSerialText.textAlignment = .right
        viewContent.addSubview(lbSerialText)
        
        let lbCMND = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbSerialText.frame.origin.y + lbSerialText.frame.height, width: lbKHName.frame.width + Common.Size(s: 10), height: Common.Size(s: 20)))
        lbCMND.text = "Số CMND/Căn cước:"
        lbCMND.font = UIFont.systemFont(ofSize: 14)
        lbCMND.textColor = .lightGray
        viewContent.addSubview(lbCMND)
        
        let lbCMNDText = UILabel(frame: CGRect(x: lbCMND.frame.origin.x + lbCMND.frame.width, y: lbCMND.frame.origin.y, width: lbKHNameText.frame.width - Common.Size(s: 10), height: Common.Size(s: 20)))
        lbCMNDText.text = "\(item.id_no)"
        lbCMNDText.font = UIFont.systemFont(ofSize: 14)
        lbCMNDText.textAlignment = .right
        viewContent.addSubview(lbCMNDText)
        
        let lbNgayDauNoi = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbCMNDText.frame.origin.y + lbCMNDText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNgayDauNoi.text = "Ngày đấu nối:"
        lbNgayDauNoi.font = UIFont.systemFont(ofSize: 14)
        lbNgayDauNoi.textColor = .lightGray
        viewContent.addSubview(lbNgayDauNoi)
        
        let lbNgayDauNoiText = UILabel(frame: CGRect(x: lbNgayDauNoi.frame.origin.x + lbNgayDauNoi.frame.width, y: lbNgayDauNoi.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbNgayDauNoiText.text = "\(item.activedate)"
        lbNgayDauNoiText.font = UIFont.systemFont(ofSize: 14)
        lbNgayDauNoiText.textAlignment = .right
        viewContent.addSubview(lbNgayDauNoiText)
        
        if tabType == "1" { // chua xac nhan
            lbNgayDauNoi.isHidden = true
            lbNgayDauNoiText.isHidden = true
            
            lbNgayDauNoi.frame = CGRect(x: lbNgayDauNoi.frame.origin.x, y: lbNgayDauNoi.frame.origin.y, width: lbNgayDauNoi.frame.width, height: 0)
            lbNgayDauNoiText.frame = CGRect(x: lbNgayDauNoiText.frame.origin.x, y: lbNgayDauNoiText.frame.origin.y, width: lbNgayDauNoiText.frame.width, height: 0)
        } else {
            lbNgayDauNoi.isHidden = false
            lbNgayDauNoiText.isHidden = false
            
            lbNgayDauNoi.frame = CGRect(x: lbNgayDauNoi.frame.origin.x, y: lbNgayDauNoi.frame.origin.y, width: lbNgayDauNoi.frame.width, height: Common.Size(s: 20))
            lbNgayDauNoiText.frame = CGRect(x: lbNgayDauNoiText.frame.origin.x, y: lbNgayDauNoiText.frame.origin.y, width: lbNgayDauNoiText.frame.width, height: Common.Size(s: 20))
        }
        
        let lbNVDauNoi = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbNgayDauNoiText.frame.origin.y + lbNgayDauNoiText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNVDauNoi.text = "NV đấu nối:"
        lbNVDauNoi.font = UIFont.systemFont(ofSize: 14)
        lbNVDauNoi.textColor = .lightGray
        viewContent.addSubview(lbNVDauNoi)
        
        let lbNVDauNoiText = UILabel(frame: CGRect(x: lbNVDauNoi.frame.origin.x + lbNVDauNoi.frame.width, y: lbNVDauNoi.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbNVDauNoiText.text = "\(item.userid)"
        lbNVDauNoiText.font = UIFont.systemFont(ofSize: 14)
        lbNVDauNoiText.textAlignment = .right
        viewContent.addSubview(lbNVDauNoiText)
        
        let lbNVDauNoiTextHeight:CGFloat = lbNVDauNoiText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNVDauNoiText.optimalHeight + Common.Size(s: 5))
        lbNVDauNoiText.numberOfLines = 0
        lbNVDauNoiText.frame = CGRect(x: lbNVDauNoiText.frame.origin.x, y: lbNVDauNoiText.frame.origin.y, width: lbNVDauNoiText.frame.width, height: lbNVDauNoiTextHeight)
        
        let lbTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbNVDauNoiText.frame.origin.y + lbNVDauNoiTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbTrangThai.text = "Trạng thái:"
        lbTrangThai.font = UIFont.systemFont(ofSize: 14)
        lbTrangThai.textColor = .lightGray
        viewContent.addSubview(lbTrangThai)
        
        let lbTrangThaiText = UILabel(frame: CGRect(x: lbTrangThai.frame.origin.x + lbTrangThai.frame.width, y: lbTrangThai.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbTrangThaiText.text = "\(item.status)"
        lbTrangThaiText.font = UIFont.systemFont(ofSize: 14)
        lbTrangThaiText.textAlignment = .right
        lbTrangThaiText.textColor = UIColor(netHex:0x00955E)
        viewContent.addSubview(lbTrangThaiText)
        
        let lbTenGoiCuocMpos = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbTrangThaiText.frame.origin.y + lbTrangThaiText.frame.height, width: lbKHName.frame.width + Common.Size(s: 30), height: Common.Size(s: 20)))
        lbTenGoiCuocMpos.text = "Tên gói cước Mpos:"
        lbTenGoiCuocMpos.font = UIFont.systemFont(ofSize: 14)
        lbTenGoiCuocMpos.textColor = .lightGray
        viewContent.addSubview(lbTenGoiCuocMpos)
        
        let lbTenGoiCuocMposText = UILabel(frame: CGRect(x: lbTenGoiCuocMpos.frame.origin.x + lbTenGoiCuocMpos.frame.width, y: lbTenGoiCuocMpos.frame.origin.y, width: lbKHNameText.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbTenGoiCuocMposText.font = UIFont.systemFont(ofSize: 14)
        lbTenGoiCuocMposText.textAlignment = .right
        viewContent.addSubview(lbTenGoiCuocMposText)
        
        if tabType == "1" {
            lbTenGoiCuocMpos.text = "Gói cước Sale chọn Mpos:"
            lbTenGoiCuocMposText.text = "\(item.package_name_sale)"
        } else {
            lbTenGoiCuocMpos.text = "Tên gói cước Mpos:"
            lbTenGoiCuocMposText.text = "\(item.package_name_fpt)"
        }
        
        let lbTenGoiCuocMposTextHeight:CGFloat = lbTenGoiCuocMposText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbTenGoiCuocMposText.optimalHeight + Common.Size(s: 5))
        lbTenGoiCuocMposText.numberOfLines = 0
        lbTenGoiCuocMposText.frame = CGRect(x: lbTenGoiCuocMposText.frame.origin.x, y: lbTenGoiCuocMposText.frame.origin.y, width: lbTenGoiCuocMposText.frame.width, height: lbTenGoiCuocMposTextHeight)
        
        let lbTenGoiCuocMsale = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbTenGoiCuocMposText.frame.origin.y + lbTenGoiCuocMposTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbTenGoiCuocMsale.text = "Tên gói cước Msale:"
        lbTenGoiCuocMsale.font = UIFont.systemFont(ofSize: 14)
        lbTenGoiCuocMsale.textColor = .lightGray
        viewContent.addSubview(lbTenGoiCuocMsale)
        
        let lbTenGoiCuocMsaleText = UILabel(frame: CGRect(x: lbTenGoiCuocMsale.frame.origin.x + lbTenGoiCuocMsale.frame.width, y: lbTenGoiCuocMsale.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbTenGoiCuocMsaleText.text = "\(item.package_name_provider)"
        lbTenGoiCuocMsaleText.font = UIFont.systemFont(ofSize: 14)
        lbTenGoiCuocMsaleText.textAlignment = .right
        viewContent.addSubview(lbTenGoiCuocMsaleText)
        
        let lbTenGoiCuocMsaleTextHeight:CGFloat = lbTenGoiCuocMsaleText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbTenGoiCuocMsaleText.optimalHeight + Common.Size(s: 5))
        lbTenGoiCuocMsaleText.numberOfLines = 0
        lbTenGoiCuocMsaleText.frame = CGRect(x: lbTenGoiCuocMsaleText.frame.origin.x, y: lbTenGoiCuocMsaleText.frame.origin.y, width: lbTenGoiCuocMsaleText.frame.width, height: lbTenGoiCuocMsaleTextHeight)
        
        let lbNhaMang = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbTenGoiCuocMsaleText.frame.origin.y + lbTenGoiCuocMsaleTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNhaMang.text = "Nhà mạng:"
        lbNhaMang.font = UIFont.systemFont(ofSize: 14)
        lbNhaMang.textColor = .lightGray
        viewContent.addSubview(lbNhaMang)
        
        let lbNhaMangText = UILabel(frame: CGRect(x: lbNhaMang.frame.origin.x + lbNhaMang.frame.width, y: lbNhaMang.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbNhaMangText.text = "\(item.Provider)"
        lbNhaMangText.font = UIFont.systemFont(ofSize: 14)
        lbNhaMangText.textAlignment = .right
        lbNhaMangText.textColor = .black
        viewContent.addSubview(lbNhaMangText)
//        ====
        let lbLoaiSim = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbNhaMangText.frame.origin.y + lbNhaMangText.frame.size.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbLoaiSim.text = "Loại sim:"
        lbLoaiSim.font = UIFont.systemFont(ofSize: 14)
        lbLoaiSim.textColor = .lightGray
        viewContent.addSubview(lbLoaiSim)
        
        let lbLoaiSimText = UILabel(frame: CGRect(x: lbLoaiSim.frame.origin.x + lbLoaiSim.frame.width, y: lbLoaiSim.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbLoaiSimText.text = "\(item.sub_number_name)"
        lbLoaiSimText.font = UIFont.systemFont(ofSize: 14)
        lbLoaiSimText.textAlignment = .right
        lbLoaiSimText.textColor = .black
        viewContent.addSubview(lbLoaiSimText)
        
        let lbGiagoi = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbLoaiSimText.frame.origin.y + lbLoaiSimText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbGiagoi.text = "Giá gói cước:"
        lbGiagoi.font = UIFont.systemFont(ofSize: 14)
        lbGiagoi.textColor = .lightGray
        viewContent.addSubview(lbGiagoi)
        
        let lbGiagoiText = UILabel(frame: CGRect(x: lbGiagoi.frame.origin.x + lbGiagoi.frame.width, y: lbGiagoi.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbGiagoiText.text = "\(Common.convertCurrencyDouble(value: item.package_price))VNĐ"
        lbGiagoiText.font = UIFont.systemFont(ofSize: 14)
        lbGiagoiText.textAlignment = .right
        lbGiagoiText.textColor = .red
        viewContent.addSubview(lbGiagoiText)
        
        let lbGiaSoThueBao = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbGiagoiText.frame.origin.y + lbGiagoiText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbGiaSoThueBao.text = "Giá số thuê bao:"
        lbGiaSoThueBao.font = UIFont.systemFont(ofSize: 14)
        lbGiaSoThueBao.textColor = .lightGray
        viewContent.addSubview(lbGiaSoThueBao)
        
        let lbGiaSoThueBaoText = UILabel(frame: CGRect(x: lbGiaSoThueBao.frame.origin.x + lbGiaSoThueBao.frame.width, y: lbGiaSoThueBao.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbGiaSoThueBaoText.text = "\(Common.convertCurrencyDouble(value: item.sub_number_price))VNĐ"
        lbGiaSoThueBaoText.font = UIFont.systemFont(ofSize: 14)
        lbGiaSoThueBaoText.textAlignment = .right
        lbGiaSoThueBaoText.textColor = .red
        viewContent.addSubview(lbGiaSoThueBaoText)
        
        let lbTongThanhToan = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbGiaSoThueBaoText.frame.origin.y + lbGiaSoThueBaoText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbTongThanhToan.text = "Tổng thanh toán:"
        lbTongThanhToan.font = UIFont.systemFont(ofSize: 14)
        lbTongThanhToan.textColor = .lightGray
        viewContent.addSubview(lbTongThanhToan)
        
        let lbTongThanhToanText = UILabel(frame: CGRect(x: lbTongThanhToan.frame.origin.x + lbTongThanhToan.frame.width, y: lbTongThanhToan.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbTongThanhToanText.text = "0đ"
        lbTongThanhToanText.font = UIFont.systemFont(ofSize: 14)
        lbTongThanhToanText.textAlignment = .right
        lbTongThanhToanText.textColor = .red
        viewContent.addSubview(lbTongThanhToanText)
        
        totalSum = item.package_price + item.sub_number_price
        lbTongThanhToanText.text = "\(Common.convertCurrencyDouble(value: totalSum))VNĐ"
        
        let line2 = UIView(frame: CGRect(x: 0, y: lbTongThanhToanText.frame.origin.y + lbTongThanhToanText.frame.height + Common.Size(s: 5), width: viewContent.frame.width, height: Common.Size(s: 5)))
        line2.backgroundColor = .white
        viewContent.addSubview(line2)
        
        viewContent.frame = CGRect(x: viewContent.frame.origin.x, y: viewContent.frame.origin.y , width: viewContent.frame.width, height: line2.frame.origin.y + line2.frame.height)
        
        estimateCellHeight = viewContent.frame.origin.y + viewContent.frame.height
    }
    
    @objc func actionCell() {
        self.delegate?.actionSelectUserMobifone(item: self.itemMSaleMobifone ?? Mobifone_Msale_ActiveSim(id: 0, so_mpos: 0, confirm_date: "", sub_name: "", phonenumber: "", id_no: "", activedate: "", userid: "", status: "", package_name_sale: "", package_sale: "", package_name_provider: "", package_provider: "", package_fpt: "", package_name_fpt: "", package_price: 0, sub_number_price: 0, sub_number_name: "", flag_package: -1, serial: "",Provider: ""), totalSum: self.totalSum)
    }
}
