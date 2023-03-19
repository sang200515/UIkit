//
//  HistoryLapTopBirthdayViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 11/13/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HistoryLapTopBirthdayViewController: UIViewController {
    var tableView: UITableView!
    var cellHeight: CGFloat = 0
    lazy var searchBar:UISearchBar = UISearchBar()
    var list = [LapTopBirthdayHistory]()
    var filterList = [LapTopBirthdayHistory]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = UIColor(netHex:0xF8F4F5)
        
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Nhập số CMND/Căn cước/SĐT"
        
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
            placeholderLabel?.font = UIFont.systemFont(ofSize: 13)
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
        
        let tableViewHeight:CGFloat = self.view.frame.height - (self.self.navigationController?.navigationBar.frame.height ?? 0) - UIApplication.shared.statusBarFrame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: Common.Size(s:8), width: self.view.frame.width, height: tableViewHeight - Common.Size(s:16)))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(LaptopBirthdayCell.self, forCellReuseIdentifier: "birthdayCell")
        tableView.tableFooterView = UIView()
        
        self.searchBar.addDoneButtonOnKeyboard()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(didScanQRCode(notification:)), name: NSNotification.Name.init("didScanQRCodeGNNB"), object: nil)
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            CRMAPIManager.sp_FRT_Voucher_Birthday_History(keysearch: "") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        self.list = rs
                        if(rs.count <= 0){
                            TableViewHelper.EmptyMessage(message: "Không có danh sách lịch sử.\n:/", viewController: self.tableView)
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
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func hideKeyBoard() {
        self.searchBar.resignFirstResponder()
    }
}

extension HistoryLapTopBirthdayViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: "\(searchBar.text ?? "")")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(key: "\(searchBar.text ?? "")")
    }
    
    func search(key:String){
        DispatchQueue.main.async {
            CRMAPIManager.sp_FRT_Voucher_Birthday_History(keysearch: key) { (rs, err) in
                self.list = rs
                if(rs.count <= 0){
                    TableViewHelper.EmptyMessage(message: "Không có danh sách lịch sử.\n:/", viewController: self.tableView)
                }else{
                    TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                }
                self.tableView.reloadData()
            }
        }
    }
}

extension HistoryLapTopBirthdayViewController: UITableViewDelegate, UITableViewDataSource, LaptopBirthdayCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LaptopBirthdayCell = tableView.dequeueReusableCell(withIdentifier: "birthdayCell", for: indexPath) as! LaptopBirthdayCell
        let item = list[indexPath.row]
        cell.item = item
        cell.setUpCell(item: item)
        self.cellHeight = cell.estimateCellHeight
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let item = list[indexPath.row]
        if editingStyle == .delete {

            let alert = UIAlertController(title: "Thông báo", message: "Bạn có chắc chắn hủy khách hàng này không?", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Không", style: .cancel, handler: nil)
            let action2 = UIAlertAction(title: "Có", style: .default) { (_) in
                self.deleteItemHistory(id: "\(item.id)")
            }
            alert.addAction(action1)
            alert.addAction(action2)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func deleteItemHistory(id: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang xoá...") {
            CRMAPIManager.sp_FRT_Voucher_Birthday_Cancel(idItem: "\(id)") { (rsCode, msg, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rsCode == 1 {
                            let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "Xoá lịch sử thành công!")", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                
                                WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Reload data...") {
                                    CRMAPIManager.sp_FRT_Voucher_Birthday_History(keysearch: "") { (rs, err) in
                                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                                            if err.count <= 0 {
                                                self.list = rs
                                                if(rs.count <= 0){
                                                    TableViewHelper.EmptyMessage(message: "Không có danh sách lịch sử.\n:/", viewController: self.tableView)
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
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "Xoá lịch sử thất bại!")", preferredStyle: UIAlertController.Style.alert)
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
    
    func getItemBirhday(item: LapTopBirthdayHistory) {
        let vc = DetailLaptopBirthdayViewController()
        vc.itemDetail = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
protocol LaptopBirthdayCellDelegate:AnyObject {
    func getItemBirhday(item:LapTopBirthdayHistory)
}

class LaptopBirthdayCell: UITableViewCell {
    var estimateCellHeight:CGFloat = 0
    weak var delegate:LaptopBirthdayCellDelegate?
    var item:LapTopBirthdayHistory?
    
    func setUpCell(item:LapTopBirthdayHistory) {
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = UIColor(netHex:0xF8F4F5)
        
        let viewContent = UIView(frame: CGRect(x: Common.Size(s: 8), y: Common.Size(s: 8), width: self.frame.width - Common.Size(s: 16), height: self.frame.height))
        viewContent.backgroundColor = .white
        viewContent.layer.cornerRadius = 10
        self.addSubview(viewContent)
        
        let tapDetail = UITapGestureRecognizer(target: self, action: #selector(showDetail))
        viewContent.isUserInteractionEnabled = true
        viewContent.addGestureRecognizer(tapDetail)
        
        let lbKHName = UILabel(frame: CGRect(x: Common.Size(s: 8), y: 0, width: (viewContent.frame.width - Common.Size(s: 16))/2, height: Common.Size(s: 20)))
        lbKHName.text = "Tên khách hàng:"
        lbKHName.font = UIFont.systemFont(ofSize: 14)
        lbKHName.textColor = .lightGray
        viewContent.addSubview(lbKHName)

        let lbKHNameText = UILabel(frame: CGRect(x: lbKHName.frame.origin.x + lbKHName.frame.width, y: lbKHName.frame.origin.y, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbKHNameText.text = "\(item.fullname)"
        lbKHNameText.font = UIFont.systemFont(ofSize: 14)
        lbKHNameText.textAlignment = .right
        viewContent.addSubview(lbKHNameText)
        
        let lbKHNameTextHeight: CGFloat = lbKHNameText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbKHNameText.optimalHeight + Common.Size(s: 5))
        lbKHNameText.numberOfLines = 0
        lbKHNameText.frame = CGRect(x: lbKHNameText.frame.origin.x, y: lbKHNameText.frame.origin.y, width: lbKHNameText.frame.width, height: lbKHNameTextHeight)
        
        let lbSdt = UILabel(frame: CGRect(x: lbKHName.frame.origin.x, y: lbKHNameText.frame.origin.y + lbKHNameTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbSdt.text = "SĐT:"
        lbSdt.font = UIFont.systemFont(ofSize: 14)
        lbSdt.textColor = .lightGray
        viewContent.addSubview(lbSdt)
        
        let lbSdtText = UILabel(frame: CGRect(x: lbSdt.frame.origin.x + lbSdt.frame.width, y: lbSdt.frame.origin.y, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbSdtText.text = "\(item.phonenumber)"
        lbSdtText.font = UIFont.systemFont(ofSize: 14)
        lbSdtText.textAlignment = .right
        viewContent.addSubview(lbSdtText)
        
        let lbNgaySinh = UILabel(frame: CGRect(x: lbKHName.frame.origin.x, y: lbSdtText.frame.origin.y + lbSdtText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNgaySinh.text = "Ngày sinh:"
        lbNgaySinh.font = UIFont.systemFont(ofSize: 14)
        lbNgaySinh.textColor = .lightGray
        viewContent.addSubview(lbNgaySinh)
        
        let lbNgaySinhText = UILabel(frame: CGRect(x: lbNgaySinh.frame.origin.x + lbNgaySinh.frame.width, y: lbNgaySinh.frame.origin.y, width: lbKHName.frame.width, height: Common.Size(s: 20)))
//        lbNgaySinhText.text = "\(item.birthday)"
        lbNgaySinhText.font = UIFont.systemFont(ofSize: 14)
        lbNgaySinhText.textAlignment = .right
        viewContent.addSubview(lbNgaySinhText)
        
        if !(item.birthday.isEmpty) {
            let dateStrOld = item.birthday
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            let date2 = formatter.date(from: dateStrOld)

            let newFormatter = DateFormatter()
            newFormatter.locale = Locale(identifier: "vi_VN");
            newFormatter.timeZone = TimeZone(identifier: "UTC");
            newFormatter.dateFormat = "dd/MM/yyyy"
            let str = newFormatter.string(from: date2 ?? Date())
            lbNgaySinhText.text = str
        } else {
            lbNgaySinhText.text = item.birthday
        }
        
        let lbSoCMND = UILabel(frame: CGRect(x: lbKHName.frame.origin.x, y: lbNgaySinhText.frame.origin.y + lbNgaySinhText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbSoCMND.text = "Số CMND/Căn cước:"
        lbSoCMND.font = UIFont.systemFont(ofSize: 14)
        lbSoCMND.textColor = .lightGray
        viewContent.addSubview(lbSoCMND)
        
        let lbSoCMNDText = UILabel(frame: CGRect(x: lbSoCMND.frame.origin.x + lbSoCMND.frame.width, y: lbSoCMND.frame.origin.y, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbSoCMNDText.text = "\(item.idcard)"
        lbSoCMNDText.font = UIFont.systemFont(ofSize: 14)
        lbSoCMNDText.textAlignment = .right
        lbSoCMNDText.textColor = UIColor(netHex: 0x2c9949)
        viewContent.addSubview(lbSoCMNDText)
        
        let lbNV = UILabel(frame: CGRect(x: lbKHName.frame.origin.x, y: lbSoCMNDText.frame.origin.y + lbSoCMNDText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNV.text = "Nhân viên cập nhật:"
        lbNV.font = UIFont.systemFont(ofSize: 14)
        lbNV.textColor = .lightGray
        viewContent.addSubview(lbNV)
        
        let lbNVText = UILabel(frame: CGRect(x: lbNV.frame.origin.x + lbNV.frame.width, y: lbNV.frame.origin.y, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNVText.text = "\(item.createby)"
        lbNVText.font = UIFont.systemFont(ofSize: 14)
        lbNVText.textAlignment = .right
        viewContent.addSubview(lbNVText)
        
        let lbNVTextHeight: CGFloat = lbNVText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNVText.optimalHeight + Common.Size(s: 5))
        lbNVText.numberOfLines = 0
        lbNVText.frame = CGRect(x: lbNVText.frame.origin.x, y: lbNVText.frame.origin.y, width: lbNVText.frame.width, height: lbNVTextHeight)
        
        let lbNgayCapNhat = UILabel(frame: CGRect(x: lbKHName.frame.origin.x, y: lbNVText.frame.origin.y + lbNVTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNgayCapNhat.text = "Ngày cập nhật:"
        lbNgayCapNhat.font = UIFont.systemFont(ofSize: 14)
        lbNgayCapNhat.textColor = .lightGray
        viewContent.addSubview(lbNgayCapNhat)
        
        let lbNgayCapNhatText = UILabel(frame: CGRect(x: lbNgayCapNhat.frame.origin.x + lbNgayCapNhat.frame.width, y: lbNgayCapNhat.frame.origin.y, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbNgayCapNhatText.text = "\(item.createtime)"
        lbNgayCapNhatText.font = UIFont.systemFont(ofSize: 14)
        lbNgayCapNhatText.textAlignment = .right
        viewContent.addSubview(lbNgayCapNhatText)
        
        let lbStatus = UILabel(frame: CGRect(x: lbKHName.frame.origin.x, y: lbNgayCapNhatText.frame.origin.y + lbNgayCapNhatText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbStatus.text = "Tình trạng:"
        lbStatus.font = UIFont.systemFont(ofSize: 14)
        lbStatus.textColor = .lightGray
        viewContent.addSubview(lbStatus)
        
        let lbStatusText = UILabel(frame: CGRect(x: lbStatus.frame.origin.x + lbStatus.frame.width, y: lbStatus.frame.origin.y, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbStatusText.text = "\(item.status)"
        lbStatusText.font = UIFont.systemFont(ofSize: 14)
        lbStatusText.textAlignment = .right
        lbStatusText.textColor = .red
        viewContent.addSubview(lbStatusText)
        
        viewContent.frame = CGRect(x: viewContent.frame.origin.x, y: viewContent.frame.origin.y, width: viewContent.frame.width, height:  lbStatusText.frame.origin.y + lbStatusText.frame.height)
        
        let line2 = UIView(frame: CGRect(x: 0, y: viewContent.frame.origin.y + viewContent.frame.height, width: self.frame.width, height: Common.Size(s: 8)))
        line2.backgroundColor = UIColor(netHex:0xF8F4F5)
        self.addSubview(line2)
        
        estimateCellHeight = line2.frame.origin.y + line2.frame.height
    }
    
    @objc func showDetail() {
        delegate?.getItemBirhday(item: self.item ?? LapTopBirthdayHistory(id: 0, phonenumber: "", idcard: "", fullname: "", birthday: "", address: "", issueday: "", url_mattruoc: "", url_matsau: "", typecard: 0, voucher: "", status: "", createby: "", createtime: ""))
    }
}

