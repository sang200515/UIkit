//
//  HistoryChangeSimItelViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 10/5/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HistoryChangeSimItelViewController: UIViewController {
    
    var tableView: UITableView!
    var cellHeight: CGFloat = 0
    var list = [SimItelHistory]()
    var btnSearch: UIBarButtonItem!
    var btnBack: UIBarButtonItem!
    
    var filterList = [SimItelHistory]()
    var searchBarContainer:SearchBarContainerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.title = "Lịch sử cập nhật Esim"
        self.navigationController?.navigationBar.isTranslucent = false
        
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
        searchBar.addDoneButtonOnKeyboard()
        if #available(iOS 11.0, *) {
            searchBarContainer.searchBar.placeholder = "Nhập từ khoá cần tìm"
        }else{
            searchBarContainer.searchBar.searchBarStyle = .minimal
            let textFieldInsideSearchBar = searchBarContainer.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = .white
            
            let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            glassIconView?.tintColor = .white
            textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Nhập từ khoá cần tìm",
                                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as? UIButton
            clearButton?.setImage(clearButton?.imageView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            clearButton?.tintColor = .white
        }
        
        let tableViewHeight:CGFloat = self.view.frame.height - (self.self.navigationController?.navigationBar.frame.height ?? 0) - UIApplication.shared.statusBarFrame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: tableViewHeight))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(netHex:0xF8F4F5)
        tableView.separatorStyle = .none
        tableView.register(ChangeSimItelCell.self, forCellReuseIdentifier: "changeSimItelCell")
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            CRMAPIManager.Itel_GetUpdateSubInfoHistory(PhoneNumber: "") { (rs, errCode, errMsg, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs.count > 0 {
                            self.list = rs
                            self.filterList = rs
                            self.tableView.reloadData()
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(errMsg)", preferredStyle: UIAlertController.Style.alert)
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
        self.navigationController?.popViewController(animated: true)
    }
}

extension HistoryChangeSimItelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ChangeSimItelCell = tableView.dequeueReusableCell(withIdentifier: "changeSimItelCell", for: indexPath) as! ChangeSimItelCell
        let item = self.filterList[indexPath.row]
        cell.setUpCell(item: item)
        self.cellHeight = cell.estimateHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

class ChangeSimItelCell: UITableViewCell {
    
    var estimateHeight:CGFloat = 0
    
    func setUpCell(item: SimItelHistory) {
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = UIColor(netHex:0xF8F4F5)
        
        let viewContent = UIView(frame: CGRect(x: Common.Size(s: 8), y: Common.Size(s: 8), width: self.frame.width - Common.Size(s: 16), height: self.frame.height))
        viewContent.backgroundColor = .white
        viewContent.layer.cornerRadius = 8
        self.addSubview(viewContent)
        
        let lbMpos = UILabel(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: (viewContent.frame.width - Common.Size(s: 10))/2 - Common.Size(s: 10), height: Common.Size(s: 20)))
        lbMpos.text = "MPOS: \(item.docentry)"
        lbMpos.font = UIFont.boldSystemFont(ofSize: 15)
        lbMpos.textColor = UIColor(netHex:0x00955E)
        viewContent.addSubview(lbMpos)
        
        let lbCreateDate = UILabel(frame: CGRect(x: lbMpos.frame.origin.x + lbMpos.frame.width, y: Common.Size(s: 5), width: viewContent.frame.width - lbMpos.frame.width - Common.Size(s: 10), height: Common.Size(s: 20)))
        lbCreateDate.text = "\(item.datetime)"
        lbCreateDate.font = UIFont.systemFont(ofSize: 13)
        lbCreateDate.textColor = .darkGray
        lbCreateDate.textAlignment = .right
        viewContent.addSubview(lbCreateDate)
        
        let line = UIView(frame: CGRect(x: 0, y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height, width: viewContent.frame.width, height: Common.Size(s: 0.7)))
        line.backgroundColor = .lightGray
        viewContent.addSubview(line)
        
        let lbHinhThuc = UILabel(frame: CGRect(x: Common.Size(s: 5), y: line.frame.origin.y + line.frame.height + Common.Size(s: 8), width: (viewContent.frame.width - Common.Size(s: 10))/2 - Common.Size(s: 10), height: Common.Size(s: 20)))
        lbHinhThuc.text = "Hình thức thay đổi:"
        lbHinhThuc.font = UIFont.systemFont(ofSize: 13)
        lbHinhThuc.textColor = .darkGray
        viewContent.addSubview(lbHinhThuc)
        
        let lbHinhThucText = UILabel(frame: CGRect(x: lbHinhThuc.frame.origin.x + lbHinhThuc.frame.width, y: lbHinhThuc.frame.origin.y, width: viewContent.frame.width - lbHinhThuc.frame.width - Common.Size(s: 10), height: Common.Size(s: 20)))
        lbHinhThucText.text = "\(item.phoneNumber)"
        lbHinhThucText.font = UIFont.systemFont(ofSize: 13)
        lbHinhThucText.textAlignment = .right
        viewContent.addSubview(lbHinhThucText)
        
        let lbHinhThucTextHeight:CGFloat = lbHinhThucText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbHinhThucText.optimalHeight + Common.Size(s: 5))
        lbHinhThucText.numberOfLines = 0
        lbHinhThucText.frame = CGRect(x: lbHinhThucText.frame.origin.x, y: lbHinhThucText.frame.origin.y , width: lbHinhThucText.frame.width, height: lbHinhThucTextHeight)
        
        let lbSerialNum = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbHinhThucText.frame.origin.y + lbHinhThucTextHeight, width: lbHinhThuc.frame.width, height: Common.Size(s: 20)))
        lbSerialNum.text = "Serial:"
        lbSerialNum.font = UIFont.systemFont(ofSize: 13)
        lbSerialNum.textColor = .darkGray
        viewContent.addSubview(lbSerialNum)
        
        let lbSerialNumText = UILabel(frame: CGRect(x: lbSerialNum.frame.origin.x + lbSerialNum.frame.width, y: lbSerialNum.frame.origin.y, width: lbHinhThucText.frame.width, height: Common.Size(s: 20)))
        lbSerialNumText.text = "\(item.phoneNumber)"
        lbSerialNumText.font = UIFont.systemFont(ofSize: 13)
        lbSerialNumText.textAlignment = .right
        viewContent.addSubview(lbSerialNumText)
        
        let lbNVCapNhat = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbSerialNumText.frame.origin.y + lbSerialNumText.frame.height, width: lbHinhThuc.frame.width, height: Common.Size(s: 20)))
        lbNVCapNhat.text = "Nhân viên cập nhật:"
        lbNVCapNhat.font = UIFont.systemFont(ofSize: 13)
        lbNVCapNhat.textColor = .darkGray
        viewContent.addSubview(lbNVCapNhat)
        
        let lbNVCapNhatText = UILabel(frame: CGRect(x: lbNVCapNhat.frame.origin.x + lbNVCapNhat.frame.width, y: lbNVCapNhat.frame.origin.y, width: lbHinhThucText.frame.width, height: Common.Size(s: 20)))
        lbNVCapNhatText.text = "\(item.employeeName)"
        lbNVCapNhatText.font = UIFont.systemFont(ofSize: 13)
        lbNVCapNhatText.textAlignment = .right
        viewContent.addSubview(lbNVCapNhatText)
        
        let lbNVCapNhatTextHeight:CGFloat = lbNVCapNhatText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNVCapNhatText.optimalHeight + Common.Size(s: 5))
        lbNVCapNhatText.numberOfLines = 0
        lbNVCapNhatText.frame = CGRect(x: lbNVCapNhatText.frame.origin.x, y: lbNVCapNhatText.frame.origin.y , width: lbNVCapNhatText.frame.width, height: lbNVCapNhatTextHeight)
        
        viewContent.frame = CGRect(x: viewContent.frame.origin.x, y: viewContent.frame.origin.y , width: viewContent.frame.width, height: lbNVCapNhatText.frame.origin.y + lbNVCapNhatTextHeight + Common.Size(s: 5))
        
        estimateHeight = viewContent.frame.origin.y + viewContent.frame.height + Common.Size(s: 8)
    }
}

extension HistoryChangeSimItelViewController: UISearchBarDelegate {
    
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
            filterList = list.filter({($0.docentry.contains(find: key)) || ($0.employeeName.localizedCaseInsensitiveContains(key))})
        } else {
            filterList = list
        }
        tableView.reloadData()
    }
}
