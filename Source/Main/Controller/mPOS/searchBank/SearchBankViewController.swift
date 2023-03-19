//
//  SearchBankViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 6/4/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SearchBankViewController: UIViewController {
    
    var tableView: UITableView!
    var cellHeight: CGFloat = 0
    var number = 0
    var listBank = [SMS_Banking]()
    
    var filterList = [SMS_Banking]()
    var btnSearch: UIBarButtonItem!
    var btnBack: UIBarButtonItem!
    private let refreshControl = UIRefreshControl()
    var searchBarContainer:SearchBarContainerView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Thông tin chuyển khoản"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        
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
        
        self.setUpView()
        self.getData()
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        // Customizing Refresh Control
        self.refreshControl.tintColor = UIColor.lightGray
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        self.refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...", attributes: attributes)
    }
    
    func setUpView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - (self.navigationController?.navigationBar.frame.height ?? 0) - UIApplication.shared.statusBarFrame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchBankCell.self, forCellReuseIdentifier: "searchBankCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        self.tableView.allowsSelection = false
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
    }
    
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
    
    func getData() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.mpos_FRT_SMS_Banking_GetSMS { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs.count > 0 {
                            self.listBank = rs
                            self.filterList = rs
                            self.tableView.reloadData()
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Không có data!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc func updateData() {
        self.number += 1
        self.getData()
        self.refreshControl.endRefreshing()
    }
}

extension SearchBankViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SearchBankCell = tableView.dequeueReusableCell(withIdentifier: "searchBankCell", for: indexPath) as! SearchBankCell
        
        let item = filterList[indexPath.row]
        cell.setUpCell(item: item)
        self.cellHeight = cell.estimateCellHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

class SearchBankCell: UITableViewCell {
    
    var lbBankName: UILabel!
    var lbCustomerName: UILabel!
    var lbSPName: UILabel!
    var lbNgayCKText: UILabel!
    var lbSMSContent: UILabel!
    var imgBank: UIImageView!
    var estimateCellHeight: CGFloat = 0
    
    func setUpCell(item: SMS_Banking) {
        self.subviews.forEach({$0.removeFromSuperview()})
        
        imgBank = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: Common.Size(s: 35), height: Common.Size(s: 35)))
        imgBank.contentMode = .scaleAspectFill
        self.addSubview(imgBank)
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        if let escapedString = "\(item.icon_bank)".addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print("escapedString: \(escapedString)")
            if let url = URL(string: "\(escapedString)") {
                imgBank.kf.setImage(with: url,
                placeholder: nil,
                options: [.transition(.fade(0.5))],
                progressBlock: nil,
                completionHandler: nil)
            } else {
                imgBank.image = #imageLiteral(resourceName: "bank")
            }
        } else {
            imgBank.image = #imageLiteral(resourceName: "bank")
        }
        
        lbCustomerName = UILabel(frame: CGRect(x: imgBank.frame.origin.x + imgBank.frame.width + Common.Size(s: 10), y: Common.Size(s: 10), width: (self.frame.width - (imgBank.frame.width + Common.Size(s: 10)) - Common.Size(s: 30))/2, height: Common.Size(s: 20)))
        lbCustomerName.text = "\(item.cardname)"
        lbCustomerName.font = UIFont.boldSystemFont(ofSize: 15)
        lbCustomerName.textColor = UIColor.black
        self.addSubview(lbCustomerName)
        
        let lbCustomerNameHeight: CGFloat = lbCustomerName.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbCustomerName.optimalHeight
        lbCustomerName.numberOfLines = 0
        lbCustomerName.frame = CGRect(x: lbCustomerName.frame.origin.x, y: lbCustomerName.frame.origin.y, width: lbCustomerName.frame.width, height: lbCustomerNameHeight)
        
        lbNgayCKText = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x + lbCustomerName.frame.width, y: lbCustomerName.frame.origin.y, width: lbCustomerName.frame.width, height: Common.Size(s: 20)))
        lbNgayCKText.text = "\(item.createdate)"
        lbNgayCKText.font = UIFont.systemFont(ofSize: 13)
        lbNgayCKText.textColor = UIColor.lightGray
        lbNgayCKText.textAlignment = .right
        self.addSubview(lbNgayCKText)
        
        lbBankName = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: lbCustomerName.frame.origin.y + lbCustomerNameHeight, width: self.frame.width - (imgBank.frame.width + Common.Size(s: 10)) - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbBankName.text = "\(item.brandname)"
        lbBankName.font = UIFont.systemFont(ofSize: 14)
        lbBankName.textColor = Common.hexStringToUIColor(hex: "\(item.color_bank)")
        self.addSubview(lbBankName)
        
        let lbSP = UILabel(frame: CGRect(x: lbCustomerName.frame.origin.x, y: lbBankName.frame.origin.y + lbBankName.frame.height, width: Common.Size(s: 70), height: Common.Size(s: 20)))
        lbSP.text = "Sản phẩm: "
        lbSP.font = UIFont.boldSystemFont(ofSize: 14)
        lbSP.textColor = UIColor.lightGray
        self.addSubview(lbSP)
        
        lbSPName = UILabel(frame: CGRect(x: lbSP.frame.origin.x + lbSP.frame.width, y: lbSP.frame.origin.y, width: self.frame.width - lbSP.frame.origin.x - lbSP.frame.width - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbSPName.text = "\(item.itemname)"
        lbSPName.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbSPName)
        
        let lbSPNameHeight: CGFloat = lbSPName.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbSPName.optimalHeight + Common.Size(s: 5)
        lbSPName.numberOfLines = 0
        lbSPName.frame = CGRect(x: lbSPName.frame.origin.x, y: lbSPName.frame.origin.y, width: lbSPName.frame.width, height: lbSPNameHeight)
        
        let lbSoTienChuyenKhoan = UILabel(frame: CGRect(x: lbSP.frame.origin.x, y: lbSPName.frame.origin.y + lbSPNameHeight, width: self.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbSoTienChuyenKhoan.text = "Số tiền chuyển khoản:  \(item.doctotal)"
        lbSoTienChuyenKhoan.font = UIFont.boldSystemFont(ofSize: 14)
        lbSoTienChuyenKhoan.textColor = UIColor.lightGray
        self.addSubview(lbSoTienChuyenKhoan)
        //attributed1
        let attributed1 = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let attributed2 = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributedString1 = NSMutableAttributedString(string:"Số tiền chuyển khoản:  ", attributes:attributed1)
        let attributedString2 = NSMutableAttributedString(string:"\(item.doctotal)", attributes:attributed2)
        attributedString1.append(attributedString2)
        lbSoTienChuyenKhoan.attributedText = attributedString1
        
        let lbND = UILabel(frame: CGRect(x: lbSP.frame.origin.x, y: lbSoTienChuyenKhoan.frame.origin.y + lbSoTienChuyenKhoan.frame.height, width: lbSP.frame.width, height: Common.Size(s: 20)))
        lbND.text = "Nội dung: "
        lbND.font = UIFont.boldSystemFont(ofSize: 14)
        lbND.textColor = UIColor.lightGray
        self.addSubview(lbND)
        
        lbSMSContent = UILabel(frame: CGRect(x: lbND.frame.origin.x + lbND.frame.width, y: lbND.frame.origin.y, width: lbSPName.frame.width, height: Common.Size(s: 20)))
        lbSMSContent.text = "\(item.sms_content)"
        lbSMSContent.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbSMSContent)
        
        let lbSMSContentHeight: CGFloat = lbSMSContent.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbSMSContent.optimalHeight
        lbSMSContent.numberOfLines = 0
        lbSMSContent.frame = CGRect(x: lbSMSContent.frame.origin.x, y: lbSMSContent.frame.origin.y, width: lbSMSContent.frame.width, height: lbSMSContentHeight)
        
        let line2 = UIView(frame: CGRect(x: Common.Size(s: 10), y: lbSMSContent.frame.origin.y + lbSMSContentHeight + Common.Size(s: 8), width: self.frame.width - Common.Size(s: 20), height: Common.Size(s: 1)))
        line2.backgroundColor = .lightGray
        self.addSubview(line2)
        
        estimateCellHeight = line2.frame.origin.y + line2.frame.height + Common.Size(s: 5)
    }
}

extension SearchBankViewController: UISearchBarDelegate {
    
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
            filterList = listBank.filter({$0.cardname.localizedCaseInsensitiveContains(key)})
        } else {
            filterList = listBank
        }
        tableView.reloadData()
    }
}
