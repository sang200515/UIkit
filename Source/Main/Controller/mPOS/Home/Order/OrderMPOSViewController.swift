//
//  OrderMPOSViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

class OrderMPOSViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    var tableView: UITableView = UITableView()
    var items: [SOHeader] = []
    var parentTabBarController: UITabBarController?
    var cellHeight:CGFloat = Common.Size(s: 70)
    var arrFilter: [SOHeader] = []
    var btnBack: UIBarButtonItem!
    var btnSearch: UIBarButtonItem!
    var searchBarContainer:SearchBarContainerView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00955E)
        self.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Đơn hàng mPOS"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00955E)
        
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.frame = CGRect(x: 0, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btnBack = UIBarButtonItem(customView: btBackIcon)
        self.navigationItem.leftBarButtonItems = [btnBack]
        
        let btSearchIcon = UIButton.init(type: .custom)
        btSearchIcon.setImage(#imageLiteral(resourceName: "Search"), for: UIControl.State.normal)
        btSearchIcon.imageView?.contentMode = .scaleAspectFit
        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        btSearchIcon.addTarget(self, action: #selector(actionSearchAssets), for: UIControl.Event.touchUpInside)
        btnSearch = UIBarButtonItem(customView: btSearchIcon)
        self.navigationItem.rightBarButtonItems = [btnSearch]
        
        //search bar custom
        let searchBar = UISearchBar()
        searchBarContainer = SearchBarContainerView(customSearchBar: searchBar)
        searchBarContainer.searchBar.showsCancelButton = true
        searchBarContainer.searchBar.addDoneButtonOnKeyboard()
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        if #available(iOS 13.0, *) {
            searchBarContainer.searchBar.searchTextField.backgroundColor = .white
        } else {
            // Fallback on earlier versions
        }
        searchBarContainer.searchBar.delegate = self
        
        if #available(iOS 11.0, *) {
            searchBarContainer.searchBar.placeholder = "Tìm theo tên khách hàng"
        }else{
            searchBarContainer.searchBar.searchBarStyle = .minimal
            let textFieldInsideSearchBar = searchBarContainer.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = .white
            
            let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            glassIconView?.tintColor = .white
            textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Tìm theo tên khách hàng",
                                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as? UIButton
            clearButton?.setImage(clearButton?.imageView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            clearButton?.tintColor = .white
        }
        
        let tableViewHeight:CGFloat = self.view.frame.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.height ?? 0) - (self.parentTabBarController?.tabBar.frame.size.height ?? 0)
        
        tableView.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: tableViewHeight - Common.Size(s: 40))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemSOTableViewCell.self, forCellReuseIdentifier: "itemSOTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
    }
    
    func loadData() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.getEmployeeSOHeaders { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if(err.count <= 0){
                        if(results.count > 0) {
                            self.items = results
                            self.arrFilter = results
                            TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                        } else {
                            TableViewHelper.EmptyMessage(message: "Không có đơn hàng.\n:/", viewController: self.tableView)
                        }
                        self.tableView.reloadData()
                    }else{
//                        let popup = PopupDialog(title: "Thông báo", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
//                        }
//                        let buttonOne = CancelButton(title: "OK") {
//                        }
//                        popup.addButtons([buttonOne])
//                        self.present(popup, animated: true, completion: nil)
                        self.showAlertOneButton(title: "Thông báo", with: "\(err)", titleButton: "OK")
                    }
                }
            }
        }
    }
    
    @objc func actionSearchAssets() {
        self.searchBarContainer.searchBar.text = ""
        navigationItem.titleView = searchBarContainer
        self.searchBarContainer.searchBar.alpha = 0
        navigationItem.setRightBarButtonItems(nil, animated: true)
        navigationItem.setLeftBarButtonItems(nil, animated: true)
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBarContainer.searchBar.alpha = 1
        }, completion: { finished in
            self.searchBarContainer.searchBar.becomeFirstResponder()
        })
    }
    
    @objc func actionBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func hideKeyBoard() {
        self.searchBarContainer.searchBar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ItemSOTableViewCell = tableView.dequeueReusableCell(withIdentifier: "itemSOTableViewCell", for: indexPath) as! ItemSOTableViewCell
        
        let key = searchBarContainer.searchBar.text ?? ""
        if !(key.isEmpty) {
            let item = arrFilter[indexPath.row]
            cell.setup(so: item)
            cell.item = item
        }else{
            let item = items[indexPath.row]
            cell.setup(so: item)
            cell.item = item
        }
        cell.delegate = self
        self.cellHeight = cell.estimateCellHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.cellHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
            var so:SOHeader
            let key = searchBarContainer.searchBar.text ?? ""
            if !(key.isEmpty) {
                so = arrFilter[indexPath.row]
            }else{
                so = items[indexPath.row]
            }
            
            let alert = UIAlertController(title: "XOÁ ĐƠN HÀNG", message: "Bạn có chắc xoá đơn hàng \(so.DocEntry) không?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                MPOSAPIManager.removeSO(docEntry: "\(so.DocEntry)", handler: { (result, err) in
                    if(result == 1){
                        let alertController = UIAlertController(title: "", message: "Xoá đơn hàng \(so.DocEntry) thành công", preferredStyle: .alert)
                        
                        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                            tableView.beginUpdates()
                            if !(key.isEmpty) {
                                self.arrFilter.remove(at: indexPath.row)
                            }else{
                                self.items.remove(at: indexPath.row)
                            }
                            tableView.deleteRows(at: [indexPath], with: .none)
                            tableView.endUpdates()
                        }
                        alertController.addAction(confirmAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }else if(result == 0){
                        let alertController = UIAlertController(title: "XOÁ ĐƠN HÀNG", message: err, preferredStyle: .alert)
                        
                        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                            tableView.reloadData()
                        }
                        alertController.addAction(confirmAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }else{
                        let alertController = UIAlertController(title: "XOÁ ĐƠN HÀNG", message: "\(err)", preferredStyle: .alert)
                        
                        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                            tableView.reloadData()
                        }
                        alertController.addAction(confirmAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
            })
            
            alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel) { _ in
                
            })
            self.present(alert, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension OrderMPOSViewController: ItemSOTableViewCellDelegate {
    func getSO(so: SOHeader) {
        let newViewController = MposSOHistoryMainViewController()
        newViewController.modalPresentationStyle = .overFullScreen
        newViewController.so = so
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}

extension OrderMPOSViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in

        })
        self.navigationItem.setLeftBarButton(btnBack, animated: true)
        self.navigationItem.setRightBarButton(btnSearch, animated: true)
        search(key: "")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(key: "\(searchBar.text!)")
        self.navigationItem.setLeftBarButton(btnBack, animated: true)
        self.navigationItem.setRightBarButton(btnSearch, animated: true)

        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in

        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: searchText)
    }

    func search(key:String){
        if key.isEmpty {
            arrFilter = self.items
        } else {
            arrFilter = items.filter({
                ("\("\($0.DocEntry)")".localizedCaseInsensitiveContains(key)) || ($0.CardName.localizedCaseInsensitiveContains(key)) || ("\($0.U_LicTrad)".localizedCaseInsensitiveContains(key)) || ("\($0.SO_POS)".contains(find: key)) || ("\($0.EcomNum)".contains(find: key))
            })
        }
        tableView.reloadData()
    }
}

protocol ItemSOTableViewCellDelegate:AnyObject {
    func getSO(so:SOHeader)
}

class ItemSOTableViewCell: UITableViewCell {
    var estimateCellHeight:CGFloat = 0
    weak var delegate:ItemSOTableViewCellDelegate?
    var item:SOHeader?
    
    func setup(so:SOHeader){
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let viewContent = UIView(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.frame.height))
        viewContent.backgroundColor = .white
        self.addSubview(viewContent)
        
        let lbMposNum = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 5), width: (viewContent.frame.width - Common.Size(s: 30))/2, height: Common.Size(s: 20)))
        lbMposNum.text = "MPOS: \(so.DocEntry)"
        lbMposNum.font = UIFont.boldSystemFont(ofSize: 15)
        lbMposNum.textColor = UIColor(netHex: 0x109e59)
        viewContent.addSubview(lbMposNum)

        let lbCreateDate = UILabel(frame: CGRect(x: lbMposNum.frame.origin.x + lbMposNum.frame.width, y: Common.Size(s: 5), width: lbMposNum.frame.width, height: Common.Size(s: 20)))
        lbCreateDate.font = UIFont.systemFont(ofSize: 13)
        lbCreateDate.textAlignment = .right
        viewContent.addSubview(lbCreateDate)
        
        if !(so.U_CrDate.isEmpty) {
            let dateStrOld = so.U_CrDate
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            let date2 = formatter.date(from: dateStrOld)

            let newFormatter = DateFormatter()
            newFormatter.locale = Locale(identifier: "vi_VN");
            newFormatter.timeZone = TimeZone(identifier: "UTC");
            newFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let str = newFormatter.string(from: date2 ?? Date())
            lbCreateDate.text = str
        } else {
            lbCreateDate.text = so.U_CrDate
        }

        let line = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 3), width: viewContent.frame.width - Common.Size(s: 30), height: Common.Size(s: 1)))
        line.backgroundColor = .lightGray
        viewContent.addSubview(line)

        let lbKHName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: line.frame.origin.y + line.frame.height + Common.Size(s: 5), width: (line.frame.width)/3, height: Common.Size(s: 20)))
        lbKHName.text = "Họ tên KH:"
        lbKHName.font = UIFont.systemFont(ofSize: 14)
        lbKHName.textColor = .lightGray
        viewContent.addSubview(lbKHName)

        let lbKHNameText = UILabel(frame: CGRect(x: lbKHName.frame.origin.x + lbKHName.frame.width, y: lbKHName.frame.origin.y, width: (line.frame.width - Common.Size(s: 30)) * 2/3, height: Common.Size(s: 20)))
        lbKHNameText.text = "\(so.CardName)"
        lbKHNameText.textColor = UIColor(netHex: 0x109e59)
        lbKHNameText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbKHNameText)

        let lbKHNameTextHeight:CGFloat = lbKHNameText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbKHNameText.optimalHeight + Common.Size(s: 5))
        lbKHNameText.numberOfLines = 0
        lbKHNameText.frame = CGRect(x: lbKHNameText.frame.origin.x, y: lbKHNameText.frame.origin.y, width: lbKHNameText.frame.width, height: lbKHNameTextHeight)

        let lbAddress = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbKHNameText.frame.origin.y + lbKHNameTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbAddress.text = "Địa chỉ:"
        lbAddress.font = UIFont.systemFont(ofSize: 14)
        lbAddress.textColor = .lightGray
        viewContent.addSubview(lbAddress)

        let lbAddressText = UILabel(frame: CGRect(x: lbAddress.frame.origin.x + lbAddress.frame.width, y: lbAddress.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbAddressText.text = "\(so.U_Address1)"
        lbAddressText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbAddressText)

        let lbAddressTextHeight:CGFloat = lbAddressText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbAddressText.optimalHeight + Common.Size(s: 5))
        lbAddressText.numberOfLines = 0
        lbAddressText.frame = CGRect(x: lbAddressText.frame.origin.x, y: lbAddressText.frame.origin.y, width: lbAddressText.frame.width, height: lbAddressTextHeight)

        let lbSdt = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbAddressText.frame.origin.y + lbAddressTextHeight, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbSdt.text = "SĐT:"
        lbSdt.font = UIFont.systemFont(ofSize: 14)
        lbSdt.textColor = .lightGray
        viewContent.addSubview(lbSdt)

        let lbSdtText = UILabel(frame: CGRect(x: lbSdt.frame.origin.x + lbSdt.frame.width, y: lbSdt.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbSdtText.text = "\(so.U_LicTrad)"
        lbSdtText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbSdtText)
        
        let lbPosNum = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSdtText.frame.origin.y + lbSdtText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbPosNum.text = "Số Ecom:"
        lbPosNum.font = UIFont.systemFont(ofSize: 14)
        lbPosNum.textColor = .lightGray
        viewContent.addSubview(lbPosNum)
        
        let lbPosNumText = UILabel(frame: CGRect(x: lbPosNum.frame.origin.x + lbPosNum.frame.width, y: lbPosNum.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbPosNumText.text = "\(so.EcomNum)"
        lbPosNumText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbPosNumText)
        
        if so.EcomNum == 0 {
            lbPosNum.isHidden = true
            lbPosNumText.isHidden = true
            
            lbPosNum.frame = CGRect(x: lbPosNum.frame.origin.x, y: lbPosNum.frame.origin.y, width: lbPosNum.frame.width, height: 0)
            lbPosNumText.frame = CGRect(x: lbPosNumText.frame.origin.x, y: lbPosNumText.frame.origin.y, width: lbPosNumText.frame.width, height: 0)
        } else {
            lbPosNum.isHidden = false
            lbPosNumText.isHidden = false
            
            lbPosNum.frame = CGRect(x: lbPosNum.frame.origin.x, y: lbPosNum.frame.origin.y, width: lbPosNum.frame.width, height: Common.Size(s: 20))
            lbPosNumText.frame = CGRect(x: lbPosNumText.frame.origin.x, y: lbPosNumText.frame.origin.y, width: lbPosNumText.frame.width, height: Common.Size(s: 20))
        }
        
        let lbSoPOS = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbPosNumText.frame.origin.y + lbPosNumText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbSoPOS.text = "Số POS:"
        lbSoPOS.font = UIFont.systemFont(ofSize: 14)
        lbSoPOS.textColor = .lightGray
        viewContent.addSubview(lbSoPOS)
        
        let lbSoPOSText = UILabel(frame: CGRect(x: lbSoPOS.frame.origin.x + lbSoPOS.frame.width, y: lbSoPOS.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbSoPOSText.text = "\(so.SO_POS)"
        lbSoPOSText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbSoPOSText)
        
        if so.SO_POS == 0 {
            lbSoPOS.isHidden = true
            lbSoPOSText.isHidden = true
            
            lbSoPOS.frame = CGRect(x: lbSoPOS.frame.origin.x, y: lbSoPOS.frame.origin.y, width: lbSoPOS.frame.width, height: 0)
            lbSoPOSText.frame = CGRect(x: lbSoPOSText.frame.origin.x, y: lbSoPOSText.frame.origin.y, width: lbSoPOSText.frame.width, height: 0)
        } else {
            lbSoPOS.isHidden = false
            lbSoPOSText.isHidden = false
            
            lbSoPOS.frame = CGRect(x: lbSoPOS.frame.origin.x, y: lbSoPOS.frame.origin.y, width: lbSoPOS.frame.width, height: Common.Size(s: 20))
            lbSoPOSText.frame = CGRect(x: lbSoPOSText.frame.origin.x, y: lbSoPOSText.frame.origin.y, width: lbSoPOSText.frame.width, height: Common.Size(s: 20))
        }
        
        let lbDes = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSoPOSText.frame.origin.y + lbSoPOSText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbDes.text = "Mô tả:"
        lbDes.font = UIFont.systemFont(ofSize: 14)
        lbDes.textColor = .lightGray
        viewContent.addSubview(lbDes)
        
        let lbDesText = UILabel(frame: CGRect(x: lbDes.frame.origin.x + lbDes.frame.width, y: lbDes.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbDesText.text = "\(so.U_Desc)"
        lbDesText.font = UIFont.systemFont(ofSize: 14)
        viewContent.addSubview(lbDesText)
        
        let lbDesTextHeight:CGFloat = lbDesText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbDesText.optimalHeight + Common.Size(s: 5))
        lbDesText.numberOfLines = 0
        lbDesText.frame = CGRect(x: lbDesText.frame.origin.x, y: lbDesText.frame.origin.y, width: lbDesText.frame.width, height: lbDesTextHeight)
        
        if so.U_Desc.isEmpty {
            lbDes.isHidden = true
            lbDesText.isHidden = true
            lbDes.frame = CGRect(x: lbDes.frame.origin.x, y: lbDes.frame.origin.y, width: lbDes.frame.width, height: 0)
            lbDesText.frame = CGRect(x: lbDesText.frame.origin.x, y: lbDesText.frame.origin.y, width: lbDesText.frame.width, height: 0)
        } else {
            lbDes.isHidden = false
            lbDesText.isHidden = false
            lbDes.frame = CGRect(x: lbDes.frame.origin.x, y: lbDes.frame.origin.y, width: lbDes.frame.width, height: Common.Size(s: 20))
            lbDesText.frame = CGRect(x: lbDesText.frame.origin.x, y: lbDesText.frame.origin.y, width: lbDesText.frame.width, height: lbDesTextHeight)
        }

        let lbTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbDesText.frame.origin.y + lbDesText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbTrangThai.text = "Trạng thái:"
        lbTrangThai.font = UIFont.systemFont(ofSize: 14)
        lbTrangThai.textColor = .lightGray
        viewContent.addSubview(lbTrangThai)

        let lbTrangThaiText = UILabel(frame: CGRect(x: lbTrangThai.frame.origin.x + lbTrangThai.frame.width, y: lbTrangThai.frame.origin.y, width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbTrangThaiText.text = "\(so.TrangThaiDH)"
        lbTrangThaiText.font = UIFont.boldSystemFont(ofSize: 14)
        lbTrangThaiText.textColor = Common.hexStringToUIColor(hex: "\(so.TrangThaiDH_Color)")
        viewContent.addSubview(lbTrangThaiText)

        let lbTongDH = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTrangThaiText.frame.origin.y + lbTrangThaiText.frame.height, width: lbKHName.frame.width, height: Common.Size(s: 20)))
        lbTongDH.text = "Tổng đơn hàng:"
        lbTongDH.font = UIFont.systemFont(ofSize: 14)
        lbTongDH.textColor = .lightGray
        viewContent.addSubview(lbTongDH)

        let lbTongDHText = UILabel(frame: CGRect(x: lbTongDH.frame.origin.x + lbTongDH.frame.width, y: lbTongDH.frame.origin.y , width: lbKHNameText.frame.width, height: Common.Size(s: 20)))
        lbTongDHText.text = "\(Common.convertCurrencyFloat(value: so.U_TMonBi))"
        lbTongDHText.font = UIFont.boldSystemFont(ofSize: 14)
        lbTongDHText.textColor = UIColor(netHex: 0xcc0c2f)
        viewContent.addSubview(lbTongDHText)

        let line2 = UIView(frame: CGRect(x: 0, y: lbTongDHText.frame.origin.y + lbTongDHText.frame.height + Common.Size(s: 10), width: viewContent.frame.width + Common.Size(s: 15), height: Common.Size(s: 3)))
        line2.backgroundColor = UIColor(netHex: 0xcfd1d0)
        viewContent.addSubview(line2)
        
        viewContent.frame = CGRect(x: viewContent.frame.origin.x, y: viewContent.frame.origin.y , width: viewContent.frame.width, height: line2.frame.origin.y + line2.frame.height)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pushSODetail))
        viewContent.isUserInteractionEnabled = true
        viewContent.addGestureRecognizer(tapGesture)

        estimateCellHeight = viewContent.frame.origin.y + viewContent.frame.height
    }
    
    @objc func pushSODetail() {
        self.delegate?.getSO(so: item ?? SOHeader(CardName: "", DiscPrcnt: 0, DocEntry: 0, DocStatus: "", DocType: "", FMoney: 0, Note: "", Payment: "", SO_POS: 0, StockManager: "", U_Address1: "", U_City1: "", U_CmpPrivate: "", U_CrDate: "", U_CrdCod: 0, U_Email: "", U_EplCod: "", U_EplName: "", U_ErrDesc: "", U_Inv3rd: "", U_LicTrad: "", U_NuBill: "", U_ShpCod: "", U_Status: 0, LaiSuat: 0, LoaiTraGop: 0, SoTienTraTruoc: 0, TrangThaiDH: "", MaCTTG: "", So_HD: "", TenCtyTraGop: "", TraGopUuDai: 0, TypeSO_Mpos: 0, FlagEdit: 0, gender: 0, period: 0, IdentityCard: "", TrangThaiDH_Color: "", U_TMonBi: 0, EcomNum: 0, U_Desc: "", LoanAmount: 0, Downpayment_ecom: 0))
    }
}
