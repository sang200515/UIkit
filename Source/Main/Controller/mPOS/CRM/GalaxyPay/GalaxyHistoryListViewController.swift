//
//  GalaxyHistoryListViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 9/15/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class GalaxyHistoryListViewController: UIViewController {
    
    // MARK: - Properties
    
    var btnSearch: UIBarButtonItem!
    var btnBack: UIBarButtonItem!
    var tableView: UITableView!
    var cellHeight: CGFloat = 0
    var searchBarContainer:SearchBarContainerView!
    private var lstHistoryItem = [OrderHistoryGalaxyPlay]()
    private var filterList = [OrderHistoryGalaxyPlay]()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Lịch sử nạp Galaxy Play"
        self.view.backgroundColor = .white
        
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
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        if #available(iOS 13.0, *) {
            searchBarContainer.searchBar.searchTextField.backgroundColor = .white
        } else {
            // Fallback on earlier versions
        }
         searchBarContainer.searchBar.delegate = self
        
        if #available(iOS 11.0, *) {
            searchBarContainer.searchBar.placeholder = "Nhập số đơn hàng/SĐT"
        }else{
            searchBarContainer.searchBar.searchBarStyle = .minimal
            let textFieldInsideSearchBar = searchBarContainer.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = .white
            
            let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            glassIconView?.tintColor = .white
            textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Nhập số đơn hàng/SĐT",
                                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as? UIButton
            clearButton?.setImage(clearButton?.imageView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            clearButton?.tintColor = .white
        }
        
        let tableViewHeight:CGFloat = self.view.frame.height - ((self.navigationController?.navigationBar.frame.height ?? 0) + UIApplication.shared.statusBarFrame.height)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: tableViewHeight))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GalaxyHistoryCell.self, forCellReuseIdentifier: "galaxyHistoryCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        fetchHistory()
    }
    
    // MARK: - API
    func fetchHistory(){
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            CRMAPIManager.Galaxy_order_history() { (result, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        self.lstHistoryItem.removeAll()
                        self.lstHistoryItem = result
                        self.filterList = result
                        self.tableView.reloadData()
                        
                    } else {
                        self.showDialog(message: err)
                        
                    }
                }
            }
        }
    }
    
    func fetchDetailHistory(docentry:String){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            CRMAPIManager.Galaxy_order_detais(docentry: docentry) { (lstOrder,orct, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if(lstOrder.count > 0){
                            let controller = DetailGalaxyHistoryViewController()
                            controller.itemGalaxyPay = lstOrder[0]
                            controller.orct = orct
                            self.navigationController?.pushViewController(controller, animated: true)
                        }
                 
                        
                    } else {
                        
                        self.showDialog(message: err)
                    }
                }
            }
        }
    }
    
    // MARK: Selectors
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
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
    // MARK: - Helpers
    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}

extension GalaxyHistoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lstHistoryItem.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:GalaxyHistoryCell = tableView.dequeueReusableCell(withIdentifier: "galaxyHistoryCell", for: indexPath) as! GalaxyHistoryCell
        cell.setUpCell(item: lstHistoryItem[indexPath.row])
        cellHeight = cell.estimateHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = lstHistoryItem[indexPath.row]
        fetchDetailHistory(docentry: "\(item.docentry)")
        
    }
}

class GalaxyHistoryCell: UITableViewCell {
    var estimateHeight:CGFloat = 0
    
    func setUpCell(item:OrderHistoryGalaxyPlay) {
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let contentView = UIView(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 5), width: self.frame.width -  Common.Size(s: 30), height: Common.Size(s: 8)))
        contentView.backgroundColor = UIColor(netHex: 0xFAFAFA)
        self.addSubview(contentView)
        
        let lbMposNum = UILabel(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: (contentView.frame.width - Common.Size(s: 10))/2, height: Common.Size(s: 20)))
        lbMposNum.text = "Mpos: \(item.docentry)"
        lbMposNum.font = UIFont.boldSystemFont(ofSize: 14)
        lbMposNum.textColor = UIColor(netHex: 0x04AB6E)
        contentView.addSubview(lbMposNum)
        
        let lbCreateDate = UILabel(frame: CGRect(x: lbMposNum.frame.origin.x + lbMposNum.frame.width, y: Common.Size(s: 5), width: lbMposNum.frame.width, height: Common.Size(s: 20)))
        lbCreateDate.text = "\(item.ngaygiaodich)"
        lbCreateDate.font = UIFont.systemFont(ofSize: 13)
        lbCreateDate.textAlignment = .right
        lbCreateDate.textColor = UIColor(netHex: 0xbababa)
        contentView.addSubview(lbCreateDate)
        
        let line1 = UIView(frame: CGRect(x: Common.Size(s: 5), y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 2), width: self.frame.width - Common.Size(s: 10), height: Common.Size(s: 0.6)))
        line1.backgroundColor = .lightGray
        contentView.addSubview(line1)
        
        let lbNVGD = UILabel(frame: CGRect(x: Common.Size(s: 5), y: line1.frame.origin.y + line1.frame.height + Common.Size(s: 2), width: contentView.frame.width/3 + Common.Size(s: 13), height: Common.Size(s: 20)))
        lbNVGD.text = "NV giao dịch:"
        lbNVGD.font = UIFont.systemFont(ofSize: 14)
        lbNVGD.textColor = UIColor(netHex: 0xbababa)
        contentView.addSubview(lbNVGD)
        
        let lbNVGDText = UILabel(frame: CGRect(x: lbNVGD.frame.origin.x + lbNVGD.frame.width, y: lbNVGD.frame.origin.y, width: (contentView.frame.width - Common.Size(s: 10)) - lbNVGD.frame.width, height: Common.Size(s: 20)))
        lbNVGDText.text = "\(item.EmployeeName)"
        lbNVGDText.font = UIFont.systemFont(ofSize: 14)
        lbNVGDText.textAlignment = .right
        contentView.addSubview(lbNVGDText)
        
        let lbNVGDTextHeight: CGFloat = lbNVGDText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNVGDText.optimalHeight + Common.Size(s: 5))
        lbNVGDText.numberOfLines = 0
        lbNVGDText.frame = CGRect(x: lbNVGDText.frame.origin.x, y: lbNVGDText.frame.origin.y, width: lbNVGDText.frame.width, height: lbNVGDTextHeight)
        
        let lbNCC = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbNVGDText.frame.origin.y + lbNVGDTextHeight, width: lbNVGD.frame.width, height: Common.Size(s: 20)))
        lbNCC.text = "Nhà cung cấp:"
        lbNCC.font = UIFont.systemFont(ofSize: 14)
        lbNCC.textColor = UIColor(netHex: 0xbababa)
        contentView.addSubview(lbNCC)
        
        let lbNCCText = UILabel(frame: CGRect(x: lbNCC.frame.origin.x + lbNCC.frame.width, y: lbNCC.frame.origin.y, width: lbNVGDText.frame.width, height: Common.Size(s: 20)))
        lbNCCText.text = "\(item.NhaCC)"
        lbNCCText.font = UIFont.systemFont(ofSize: 14)
        lbNCCText.textAlignment = .right
        contentView.addSubview(lbNCCText)
        
        let lbNCCTextHeight: CGFloat = lbNCCText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNCCText.optimalHeight + Common.Size(s: 5))
        lbNCCText.numberOfLines = 0
        lbNCCText.frame = CGRect(x: lbNCCText.frame.origin.x, y: lbNCCText.frame.origin.y, width: lbNCCText.frame.width, height: lbNCCTextHeight)
        
        let lbSdtKH = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbNCCText.frame.origin.y + lbNCCTextHeight, width: lbNVGD.frame.width, height: Common.Size(s: 20)))
        lbSdtKH.text = "Sđt khách hàng:"
        lbSdtKH.font = UIFont.systemFont(ofSize: 14)
        lbSdtKH.textColor = UIColor(netHex: 0xbababa)
        contentView.addSubview(lbSdtKH)
        
        let lbSdtKHText = UILabel(frame: CGRect(x: lbSdtKH.frame.origin.x + lbSdtKH.frame.width, y: lbSdtKH.frame.origin.y, width: lbNVGDText.frame.width, height: Common.Size(s: 20)))
        lbSdtKHText.text = "\(item.Phonenumber)"
        lbSdtKHText.font = UIFont.systemFont(ofSize: 14)
        lbSdtKHText.textAlignment = .right
        contentView.addSubview(lbSdtKHText)
        
        let lbTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbSdtKHText.frame.origin.y + lbSdtKHText.frame.height, width: lbNVGD.frame.width, height: Common.Size(s: 20)))
        lbTrangThai.text = "Trạng thái:"
        lbTrangThai.font = UIFont.systemFont(ofSize: 14)
        lbTrangThai.textColor = UIColor(netHex: 0xbababa)
        contentView.addSubview(lbTrangThai)
        
        let lbTrangThaiText = UILabel(frame: CGRect(x: lbTrangThai.frame.origin.x + lbTrangThai.frame.width, y: lbTrangThai.frame.origin.y, width: lbNVGDText.frame.width, height: Common.Size(s: 20)))
        lbTrangThaiText.text = "Giao dịch thành công"
        lbTrangThaiText.font = UIFont.systemFont(ofSize: 14)
        lbTrangThaiText.textAlignment = .right
        lbTrangThaiText.textColor = UIColor(netHex: 0x04AB6E)
        contentView.addSubview(lbTrangThaiText)
        
        let lbTongTien = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbTrangThaiText.frame.origin.y + lbTrangThaiText.frame.height, width: lbNVGD.frame.width, height: Common.Size(s: 20)))
        lbTongTien.text = "Tổng tiền:"
        lbTongTien.font = UIFont.systemFont(ofSize: 14)
        lbTongTien.textColor = UIColor(netHex: 0xbababa)
        contentView.addSubview(lbTongTien)
        
        let lbTongTienText = UILabel(frame: CGRect(x: lbTongTien.frame.origin.x + lbTongTien.frame.width, y: lbTongTien.frame.origin.y, width: lbNVGDText.frame.width, height: Common.Size(s: 20)))
        lbTongTienText.text = "\(Common.convertCurrencyV2(value: Int(item.Doctotal)))đ"
        lbTongTienText.font = UIFont.systemFont(ofSize: 14)
        lbTongTienText.textAlignment = .right
        lbTongTienText.textColor = UIColor(netHex: 0xE30613)
        contentView.addSubview(lbTongTienText)
        
        contentView.frame = CGRect(x: contentView.frame.origin.x, y: contentView.frame.origin.y, width: contentView.frame.width, height: lbTongTienText.frame.origin .y + lbTongTienText.frame.height + Common.Size(s: 5))
        
        estimateHeight = contentView.frame.origin.y + contentView.frame.height + Common.Size(s: 10)
    }
}
extension GalaxyHistoryListViewController: UISearchBarDelegate {
    
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
        if key.count > 0 {
       
            if key[0] == "0"{
                lstHistoryItem = filterList.filter({$0.Phonenumber.localizedCaseInsensitiveContains(key)})
            }else{
                lstHistoryItem = filterList.filter({$0.docentry.localizedCaseInsensitiveContains(key)})
            }
            
        } else {
            lstHistoryItem = filterList
        }
        tableView.reloadData()
    }
}
