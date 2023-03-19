//
//  HistoryTVBaohiemViewController.swift
//  fptshop
//
//  Created by Apple on 9/24/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HistoryTVBaohiemViewController: UIViewController {
    
    var tableView: UITableView!
    var listBHHistory: [BaoHiemHistory] = []
    var cellHeight:CGFloat = 0
    let searchController = UISearchController(searchResultsController: nil)
    var filterBH = [BaoHiemHistory]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Lịch sử bảo hiểm CHUBB"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        self.listBHHistory.removeAll()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.mpos_FRT_SP_BH_history_thongtinKH(handler: { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs.count > 0 {
                            self.listBHHistory = rs
                            self.setUpTableView()
                        } else {
                            self.showAlert(title: "Thông báo", message: "Không có danh sách lịch sử bảo hiểm CHUBB!")
                        }
                    } else {
                        self.showAlert(title: "Thông báo", message: "\(err)")
                    }
                }
            })
        }
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Nhập mã lỗi..."
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .red
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
                textfield.textColor = UIColor(netHex:0x00579c)
                textfield.tintColor = UIColor(netHex:0x00579c)
                if let backgroundview = textfield.subviews.first {
                    // Background color
                    backgroundview.backgroundColor = UIColor.white
                    // Rounded corner
                    backgroundview.layer.cornerRadius = 5;
                    backgroundview.clipsToBounds = true;
                }
                if let navigationbar = self.navigationController?.navigationBar {
                    navigationbar.barTintColor = UIColor(patternImage: Common.imageLayerForGradientBackground(searchBar: (self.searchController.searchBar)))
                }
            }
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func filterContentForSearchText(_ searchText: String, scrop: String = "All") {
        if self.listBHHistory.count > 0 {
            filterBH = listBHHistory.filter({( item : BaoHiemHistory) -> Bool in
                return ("\(item.phonenumber)".contains(searchText)) || ("\(item.FullName)".contains(searchText))
            })
            tableView.reloadData()
        }
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        self.view.addSubview(tableView)
        tableView.register(TVBaoHiemHistoryCell.self, forCellReuseIdentifier: "tvBaoHiemHistoryCell")
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension HistoryTVBaohiemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering() {
            return filterBH.count
        }
        return listBHHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TVBaoHiemHistoryCell = tableView.dequeueReusableCell(withIdentifier: "tvBaoHiemHistoryCell", for: indexPath) as! TVBaoHiemHistoryCell
        
        let item:BaoHiemHistory
        if isFiltering() {
            item = self.filterBH[indexPath.row]
        } else {
            item = self.listBHHistory[indexPath.row]
        }
        cell.setUpCell(item: item)
        self.cellHeight = cell.estimateCellHeight
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

extension HistoryTVBaohiemViewController: UISearchResultsUpdating, UISearchBarDelegate {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text ?? "", scrop: "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.navigationController?.navigationBar.isTranslucent = true
        return true
    }
}

class TVBaoHiemHistoryCell: UITableViewCell {
    
    var estimateCellHeight: CGFloat = 0
    
    func setUpCell(item: BaoHiemHistory) {
        self.subviews.forEach({$0.removeFromSuperview()})
        let lbSdt = UILabel(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 10), width: (self.frame.width - Common.Size(s: 20))/2, height: Common.Size(s: 20)))
        lbSdt.text = "\(item.phonenumber)"
        lbSdt.font = UIFont.boldSystemFont(ofSize: 15)
        lbSdt.textColor = UIColor(red: 38/255, green: 135/255, blue: 26/255, alpha: 1)
        self.addSubview(lbSdt)
        
        let lbStatus = UILabel(frame: CGRect(x: self.frame.width - lbSdt.frame.width - Common.Size(s: 20), y: lbSdt.frame.origin.y, width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbStatus.text = "\(item.TrangThai)"
        lbStatus.font = UIFont.boldSystemFont(ofSize: 15)
        lbStatus.textAlignment = .right
        lbStatus.textColor = UIColor(red: 244/255, green: 0/255, blue: 19/255, alpha: 1)
        self.addSubview(lbStatus)
        
        let line = UIView(frame: CGRect(x: Common.Size(s: 10), y: lbSdt.frame.origin.y + lbSdt.frame.height + Common.Size(s: 5), width: self.frame.width - Common.Size(s: 20), height: 1))
        line.backgroundColor = UIColor.lightGray
        self.addSubview(line)
        
        let lbTenKH = UILabel(frame: CGRect(x: line.frame.origin.x, y: line.frame.origin.y + line.frame.height + Common.Size(s: 10), width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbTenKH.text = "Tên khách hàng:"
        lbTenKH.font = UIFont.systemFont(ofSize: 14)
        lbTenKH.textColor = UIColor.lightGray
        self.addSubview(lbTenKH)
        
        let lbTenKHText = UILabel(frame: CGRect(x: lbStatus.frame.origin.x, y: lbTenKH.frame.origin.y, width: lbStatus.frame.width, height: Common.Size(s: 20)))
        lbTenKHText.text = "\(item.FullName)"
        lbTenKHText.font = UIFont.systemFont(ofSize: 14)
        lbTenKHText.textColor = UIColor.lightGray
        self.addSubview(lbTenKHText)
        
        let lbTenKHTextHeight:CGFloat = lbTenKHText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbTenKHText.optimalHeight
        lbTenKHText.numberOfLines = 0
        lbTenKHText.frame = CGRect(x: lbTenKHText.frame.origin.x, y: lbTenKHText.frame.origin.y, width: lbTenKHText.frame.width, height: lbTenKHTextHeight)
        
        let lbGender = UILabel(frame: CGRect(x: line.frame.origin.x, y: lbTenKHText.frame.origin.y + lbTenKHTextHeight, width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbGender.text = "Giới tính:"
        lbGender.font = UIFont.systemFont(ofSize: 14)
        lbGender.textColor = UIColor.lightGray
        self.addSubview(lbGender)
        
        let lbGenderText = UILabel(frame: CGRect(x: lbTenKHText.frame.origin.x, y: lbGender.frame.origin.y, width: lbTenKHText.frame.width, height: Common.Size(s: 20)))
        lbGenderText.text = "\(item.Gender)"
        lbGenderText.font = UIFont.systemFont(ofSize: 14)
        lbGenderText.textColor = UIColor.lightGray
        self.addSubview(lbGenderText)
        
        let lbDiaChi = UILabel(frame: CGRect(x: line.frame.origin.x, y: lbGenderText.frame.origin.y + lbGenderText.frame.height, width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbDiaChi.text = "Địa chỉ:"
        lbDiaChi.font = UIFont.systemFont(ofSize: 14)
        lbDiaChi.textColor = UIColor.lightGray
        self.addSubview(lbDiaChi)
        
        let lbAddressText = UILabel(frame: CGRect(x: lbTenKHText.frame.origin.x, y: lbDiaChi.frame.origin.y, width: lbTenKHText.frame.width, height: Common.Size(s: 20)))
        lbAddressText.text = "\(item.address)"
        lbAddressText.font = UIFont.systemFont(ofSize: 14)
        lbAddressText.textColor = UIColor.lightGray
        self.addSubview(lbAddressText)
        
        let lbAddressTextHeight:CGFloat = lbAddressText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbAddressText.optimalHeight
        lbAddressText.numberOfLines = 0
        lbAddressText.frame = CGRect(x: lbAddressText.frame.origin.x, y: lbAddressText.frame.origin.y, width: lbAddressText.frame.width, height: lbAddressTextHeight)
        
        let lbNgayTao = UILabel(frame: CGRect(x: line.frame.origin.x, y: lbAddressText.frame.origin.y + lbAddressTextHeight, width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbNgayTao.text = "Ngày tạo:"
        lbNgayTao.font = UIFont.systemFont(ofSize: 14)
        lbNgayTao.textColor = UIColor.lightGray
        self.addSubview(lbNgayTao)
        
        let lbNgayTaoText = UILabel(frame: CGRect(x: lbTenKHText.frame.origin.x, y: lbNgayTao.frame.origin.y, width: lbTenKHText.frame.width, height: Common.Size(s: 20)))
        lbNgayTaoText.text = "\(item.NgayTao)"
        lbNgayTaoText.font = UIFont.systemFont(ofSize: 14)
        lbNgayTaoText.textColor = UIColor(red: 30/255, green: 102/255, blue: 180/255, alpha: 1)
        self.addSubview(lbNgayTaoText)
        
        let lbNgayConfirm = UILabel(frame: CGRect(x: line.frame.origin.x, y: lbNgayTaoText.frame.origin.y + lbNgayTaoText.frame.height, width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbNgayConfirm.text = "Ngày confirm:"
        lbNgayConfirm.font = UIFont.systemFont(ofSize: 14)
        lbNgayConfirm.textColor = UIColor.lightGray
        self.addSubview(lbNgayConfirm)
        
        let lbNgayConfirmText = UILabel(frame: CGRect(x: lbTenKHText.frame.origin.x, y: lbNgayConfirm.frame.origin.y, width: lbTenKHText.frame.width, height: Common.Size(s: 20)))
        lbNgayConfirmText.text = "\(item.NgayPGconfirm)"
        lbNgayConfirmText.font = UIFont.systemFont(ofSize: 14)
        lbNgayConfirmText.textColor = UIColor(red: 30/255, green: 102/255, blue: 180/255, alpha: 1)
        self.addSubview(lbNgayConfirmText)
        
        let lbGhiChu = UILabel(frame: CGRect(x: line.frame.origin.x, y: lbNgayConfirmText.frame.origin.y + lbNgayConfirmText.frame.height, width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbGhiChu.text = "Ghi chú:"
        lbGhiChu.font = UIFont.systemFont(ofSize: 14)
        lbGhiChu.textColor = UIColor.lightGray
        self.addSubview(lbGhiChu)
        
        let lbGhiChuText = UILabel(frame: CGRect(x: lbTenKHText.frame.origin.x, y: lbGhiChu.frame.origin.y, width: lbTenKHText.frame.width, height: Common.Size(s: 20)))
        lbGhiChuText.text = "\(item.Note)"
        lbGhiChuText.font = UIFont.systemFont(ofSize: 14)
        lbGhiChuText.textColor = UIColor.lightGray
        self.addSubview(lbGhiChuText)
        
        let lbGhiChuTextHeight:CGFloat = lbGhiChuText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbGhiChuText.optimalHeight
        lbGhiChuText.numberOfLines = 0
        lbGhiChuText.frame = CGRect(x: lbGhiChuText.frame.origin.x, y: lbGhiChuText.frame.origin.y, width: lbGhiChuText.frame.width, height: lbGhiChuTextHeight)
        
        let lbNVPG = UILabel(frame: CGRect(x: line.frame.origin.x, y: lbGhiChuText.frame.origin.y + lbGhiChuTextHeight, width: lbSdt.frame.width, height: Common.Size(s: 20)))
        lbNVPG.text = "NV PG:"
        lbNVPG.font = UIFont.systemFont(ofSize: 14)
        lbNVPG.textColor = UIColor.lightGray
        self.addSubview(lbNVPG)
        
        let lbNVPGText = UILabel(frame: CGRect(x: lbTenKHText.frame.origin.x, y: lbNVPG.frame.origin.y, width: lbTenKHText.frame.width, height: Common.Size(s: 20)))
        lbNVPGText.text = "\(item.NVPG)"
        lbNVPGText.font = UIFont.systemFont(ofSize: 14)
        lbNVPGText.textColor = UIColor.lightGray
        self.addSubview(lbNVPGText)
        
        self.estimateCellHeight = lbNVPGText.frame.origin.y + lbNVPGText.frame.height + Common.Size(s: 15)
    }
}
