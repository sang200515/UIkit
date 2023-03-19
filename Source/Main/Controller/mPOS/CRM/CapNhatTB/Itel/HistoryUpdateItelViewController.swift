//
//  HistoryUpdateItelViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 10/2/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
class HistoryUpdateItelViewController: UIViewController {
    
    // MARK:- Properties
    private var tableView: UITableView!
    private var cellHeight: CGFloat = 0
    private var searchBarContainer:SearchBarContainerView!
    private var btnSearch: UIBarButtonItem!
    private var btnBack: UIBarButtonItem!
    private var lstHistoryItem = [SimItelHistory]()
    private var filterList = [SimItelHistory]()
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lịch sử cập nhật Itel"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        btnBack = UIBarButtonItem(customView: btLeftIcon)
  
        self.navigationItem.leftBarButtonItems = [btnBack]
        
        let btSearchIcon = UIButton.init(type: .custom)
        btSearchIcon.setImage(#imageLiteral(resourceName: "Search"), for: UIControl.State.normal)
        btSearchIcon.imageView?.contentMode = .scaleAspectFit
        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        btSearchIcon.addTarget(self, action: #selector(actionSearchAssets), for: UIControl.Event.touchUpInside)
        btnSearch = UIBarButtonItem(customView: btSearchIcon)
        self.navigationItem.rightBarButtonItems = [btnSearch]
        
        configureNavigationItem()
        configureUI()
        fetchHistoryAPI()
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
    
    // MARK: - API
    func fetchHistoryAPI(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            CRMAPIManager.Itel_GetUpdateSubInfoHistory(PhoneNumber: "") { (result, errCode, errMsg, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        self.lstHistoryItem = result
                        self.filterList = result
                        
                        if(result.count <= 0){
                            TableViewHelper.EmptyMessage(message: "\(errMsg)\nKhông có lịch sử.\n:/", viewController: self.tableView)
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
    
    
    
    
    // MARK: - Selectors
    @objc func handleBack(){
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    func configureNavigationItem(){
        //left menu icon
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
        
        
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
    }
    
    
    func configureUI(){
        let tableViewHeight:CGFloat = self.view.frame.height - ((self.navigationController?.navigationBar.frame.height ?? 0) + UIApplication.shared.statusBarFrame.height)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: tableViewHeight))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItelUpdateHistoryCell.self, forCellReuseIdentifier: "ItelUpdateHistoryCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
    }
    
    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}

extension HistoryUpdateItelViewController: UISearchBarDelegate {
    
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
            filterList = lstHistoryItem.filter({($0.phoneNumber.localizedCaseInsensitiveContains(key)) || ($0.docentry.localizedCaseInsensitiveContains(key))})
        } else {
            filterList = lstHistoryItem
        }
        tableView.reloadData()
    }
}
extension HistoryUpdateItelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return filterList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ItelUpdateHistoryCell = tableView.dequeueReusableCell(withIdentifier: "ItelUpdateHistoryCell", for: indexPath) as! ItelUpdateHistoryCell
        cell.setUpCell(item: filterList[indexPath.row])
        cellHeight = cell.estimateHeight
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

}

class ItelUpdateHistoryCell: UITableViewCell {
    var estimateHeight:CGFloat = 0
    
    func setUpCell(item:SimItelHistory) {
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let contentView = UIView(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 5), width: self.frame.width -  Common.Size(s: 30), height: Common.Size(s: 8)))
        contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        contentView.layer.cornerRadius = 8
        self.addSubview(contentView)
        
        let lbMposNum = UILabel(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: (contentView.frame.width - Common.Size(s: 10))/2, height: Common.Size(s: 20)))
        lbMposNum.text = "Mpos: \(item.docentry)"
        lbMposNum.font = UIFont.boldSystemFont(ofSize: 14)
        lbMposNum.textColor = UIColor(netHex: 0x04AB6E)
        contentView.addSubview(lbMposNum)
        
        let lbCreateDate = UILabel(frame: CGRect(x: lbMposNum.frame.origin.x + lbMposNum.frame.width, y: Common.Size(s: 5), width: lbMposNum.frame.width, height: Common.Size(s: 20)))
        lbCreateDate.text = "\(item.datetime)"
        lbCreateDate.font = UIFont.systemFont(ofSize: 13)
        lbCreateDate.textAlignment = .right
        lbCreateDate.textColor = UIColor.lightGray
        contentView.addSubview(lbCreateDate)
        
        let line1 = UIView(frame: CGRect(x: Common.Size(s: 5), y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 2), width: self.frame.width - Common.Size(s: 10), height: Common.Size(s: 0.6)))
        line1.backgroundColor = .lightGray
        contentView.addSubview(line1)
        
        let lbPhone = UILabel(frame: CGRect(x: Common.Size(s: 5), y: line1.frame.origin.y + line1.frame.height + Common.Size(s: 2), width: contentView.frame.width/3 + Common.Size(s: 13), height: Common.Size(s: 20)))
        lbPhone.text = "Số thuê bao:"
        lbPhone.font = UIFont.systemFont(ofSize: 14)
        lbPhone.textColor = UIColor.lightGray
        contentView.addSubview(lbPhone)
        
        let lbPhoneText = UILabel(frame: CGRect(x: lbPhone.frame.origin.x + lbPhone.frame.width, y: lbPhone.frame.origin.y, width: (contentView.frame.width - Common.Size(s: 10)) - lbPhone.frame.width, height: Common.Size(s: 20)))
        lbPhoneText.text = "\(item.phoneNumber)"
        lbPhoneText.font = UIFont.systemFont(ofSize: 14)
        lbPhoneText.textAlignment = .right
        contentView.addSubview(lbPhoneText)
        

        
        let lbNV = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbPhoneText.frame.origin.y + lbPhoneText.frame.size.height, width: lbPhone.frame.width, height: Common.Size(s: 20)))
        lbNV.text = "NV cập nhật:"
        lbNV.font = UIFont.systemFont(ofSize: 14)
        lbNV.textColor = UIColor.lightGray
        contentView.addSubview(lbNV)
        
        let lbNVText = UILabel(frame: CGRect(x: lbNV.frame.origin.x + lbNV.frame.width, y: lbNV.frame.origin.y, width: lbPhoneText.frame.width, height: Common.Size(s: 20)))
        lbNVText.text = "\(item.employeeName)"
        lbNVText.font = UIFont.systemFont(ofSize: 14)
        lbNVText.textAlignment = .right
        contentView.addSubview(lbNVText)
        
        let lbNVTextHeight: CGFloat = lbNVText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNVText.optimalHeight + Common.Size(s: 5))
        lbNVText.numberOfLines = 0
        lbNVText.frame = CGRect(x: lbNVText.frame.origin.x, y: lbNVText.frame.origin.y, width: lbNVText.frame.width, height: lbNVTextHeight)
        
        let lbShop = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbNVText.frame.origin.y + lbNVText.frame.size.height, width: lbNV.frame.width, height: Common.Size(s: 20)))
        lbShop.text = "Shop cập nhật:"
        lbShop.font = UIFont.systemFont(ofSize: 14)
        lbShop.textColor = UIColor.lightGray
        contentView.addSubview(lbShop)
        
        let lbShopText = UILabel(frame: CGRect(x: lbShop.frame.origin.x + lbShop.frame.width, y: lbShop.frame.origin.y, width: lbNVText.frame.width, height: Common.Size(s: 20)))
        lbShopText.text = "\(item.shopName)"
        lbShopText.font = UIFont.systemFont(ofSize: 14)
        lbShopText.textAlignment = .right
        contentView.addSubview(lbShopText)
        
        let lbShopTextHeight: CGFloat = lbShopText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbShopText.optimalHeight + Common.Size(s: 5))
        lbShopText.numberOfLines = 0
        lbShopText.frame = CGRect(x: lbShopText.frame.origin.x, y: lbShopText.frame.origin.y, width: lbShopText.frame.width, height: lbShopTextHeight)
        
        contentView.frame = CGRect(x: contentView.frame.origin.x, y: contentView.frame.origin.y, width: contentView.frame.width, height: lbShopText.frame.origin .y + lbShopText.frame.height + Common.Size(s: 5))
        
        estimateHeight = contentView.frame.origin.y + contentView.frame.height + Common.Size(s: 10)
    }
}
