//
//  HistoryUpdateVNMViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 7/16/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class HistoryUpdateVNMViewController: UIViewController {
    var tableView: UITableView!
    var cellHeight: CGFloat = 0
    var listBank = [HistoryUpdateVNM]()
    
    var filterList = [HistoryUpdateVNM]()
    var btnSearch: UIBarButtonItem!
    var btnBack: UIBarButtonItem!
    var searchBarContainer:SearchBarContainerView!
    
    override func viewDidLoad() {
        
        self.title = "Lịch sử cập nhật VNM"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(HistoryUpdateVNMViewController.backButton), for: UIControl.Event.touchUpInside)
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
            searchBarContainer.searchBar.placeholder = "Tìm theo số điện thoại KH"
        }else{
            searchBarContainer.searchBar.searchBarStyle = .minimal
            let textFieldInsideSearchBar = searchBarContainer.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = .white
            
            let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            glassIconView?.tintColor = .white
            textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Tìm theo sđt khách hàng",
                                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as? UIButton
            clearButton?.setImage(clearButton?.imageView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            clearButton?.tintColor = .white
        }
        self.setUpView()
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.mpos_FRT_ActiveSim_VNM_Swap_Info_GetData { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        self.listBank = rs
                        self.filterList = rs
                        
                        if(rs.count <= 0){
                            TableViewHelper.EmptyMessage(message: "Không có lịch sử.\n:/", viewController: self.tableView)
                        }else{
                            TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                        }
                        self.tableView.reloadData()
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
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
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
    func setUpView() {
        let tableViewHeight:CGFloat = self.view.frame.height - ((self.navigationController?.navigationBar.frame.height ?? 0) + UIApplication.shared.statusBarFrame.height)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: tableViewHeight))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HistoryUpdateVNMCell.self, forCellReuseIdentifier: "HistoryUpdateVNMCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        self.tableView.allowsSelection = false
    }
}
extension HistoryUpdateVNMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HistoryUpdateVNMCell = tableView.dequeueReusableCell(withIdentifier: "HistoryUpdateVNMCell", for: indexPath) as! HistoryUpdateVNMCell
        
        let item = filterList[indexPath.row]
        cell.setUpCell(item: item)
        self.cellHeight = cell.estimateCellHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

class HistoryUpdateVNMCell: UITableViewCell {
    
    var lbMposNum: UILabel!
    var lbCreateDate: UILabel!
    var lbNameCustomer: UILabel!
    var lbSDTCustomer: UILabel!
    var lbCMND: UILabel!
    var lbBirthday:UILabel!
    var lbShopName:UILabel!
    var lbUserShop:UILabel!
    var lbFee:UILabel!
    
    
    
    var lbCreateDateValue: UILabel!
    var lbNameCustomerValue: UILabel!
    var lbSDTCustomerValue: UILabel!
    var lbCMNDValue: UILabel!
    var lbBirthdayValue:UILabel!
    var lbShopNameValue:UILabel!
    var lbUserShopValue:UILabel!
    var lbFeeValue:UILabel!
    
    
    var estimateCellHeight: CGFloat = 0
    
    func setUpCell(item: HistoryUpdateVNM) {
        self.subviews.forEach({$0.removeFromSuperview()})
        
        lbMposNum = UILabel(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 10), width: self.frame.width - Common.Size(s:20), height: Common.Size(s: 20)))
        lbMposNum.text = "MPOS: \(item.SO_MPOS)"
        lbMposNum.font = UIFont.boldSystemFont(ofSize: 15)
        lbMposNum.textAlignment = .left
        lbMposNum.textColor = UIColor(netHex:0x00955E)
        self.addSubview(lbMposNum)
        
        
        lbCreateDate = UILabel(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 10), width: lbMposNum.frame.size.width, height: Common.Size(s: 20)))
        lbCreateDate.text = "\(item.CreateDate)"
        lbCreateDate.textAlignment = .right
        lbCreateDate.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbCreateDate.textColor = UIColor.gray
        self.addSubview(lbCreateDate)
        
        let line1 = UIView(frame: CGRect(x: Common.Size(s: 10), y: lbMposNum.frame.origin.y + lbMposNum.frame.size.height + Common.Size(s: 8), width: self.frame.width - Common.Size(s: 20), height: Common.Size(s: 1)))
        line1.backgroundColor = .gray
        self.addSubview(line1)
        
        
        lbNameCustomer = UILabel(frame: CGRect(x: Common.Size(s: 10), y:line1.frame.size.height + line1.frame.origin.y + Common.Size(s: 10), width: lbMposNum.frame.size.width/2.7, height: Common.Size(s: 20)))
        lbNameCustomer.text = "Họ tên KH:"
        lbNameCustomer.textAlignment = .left
        lbNameCustomer.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbNameCustomer.textColor = UIColor.black
        self.addSubview(lbNameCustomer)
        
        
        lbNameCustomerValue = UILabel(frame: CGRect(x: lbNameCustomer.frame.origin.x + lbNameCustomer.frame.size.width, y:lbNameCustomer.frame.origin.y, width: self.frame.width - Common.Size(s:20), height: Common.Size(s: 20)))
        lbNameCustomerValue.text = "\(item.FullName)"
        lbNameCustomerValue.textAlignment = .left
        lbNameCustomerValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbNameCustomerValue.textColor = UIColor.black
        self.addSubview(lbNameCustomerValue)
        
        
        lbCMND = UILabel(frame: CGRect(x: Common.Size(s: 10), y:lbNameCustomer.frame.size.height + lbNameCustomer.frame.origin.y + Common.Size(s: 10), width: lbNameCustomer.frame.size.width, height: Common.Size(s: 20)))
        lbCMND.text = "CMND/Căn cước:"
        lbCMND.textAlignment = .left
        lbCMND.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbCMND.textColor = UIColor.black
        self.addSubview(lbCMND)
        
        
        lbCMNDValue = UILabel(frame: CGRect(x: lbCMND.frame.size.width + lbCMND.frame.origin.x, y:lbCMND.frame.origin.y , width: lbNameCustomerValue.frame.size.width, height: Common.Size(s: 20)))
        lbCMNDValue.text = "\(item.IdCard)"
        lbCMNDValue.textAlignment = .left
        lbCMNDValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbCMNDValue.textColor = UIColor.black
        self.addSubview(lbCMNDValue)
        
        
        
        lbShopName = UILabel(frame: CGRect(x: Common.Size(s: 10), y:lbCMND.frame.size.height + lbCMND.frame.origin.y + Common.Size(s: 10), width: lbNameCustomer.frame.size.width, height: Common.Size(s: 20)))
        lbShopName.text = "Tên Shop:"
        lbShopName.textAlignment = .left
        lbShopName.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbShopName.textColor = UIColor.black
        self.addSubview(lbShopName)
        
        
        lbShopNameValue = UILabel(frame: CGRect(x: lbShopName.frame.size.width + lbShopName.frame.origin.x, y:lbShopName.frame.origin.y, width: lbNameCustomerValue.frame.size.width, height: Common.Size(s: 20)))
        lbShopNameValue.text = "\(item.ShopName)"
        lbShopNameValue.textAlignment = .left
        lbShopNameValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbShopNameValue.textColor = UIColor.black
        self.addSubview(lbShopNameValue)
        
        let lbShopNameValueTextHeight:CGFloat = lbShopNameValue.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbShopNameValue.optimalHeight
        lbShopNameValue.numberOfLines = 0
        lbShopNameValue.frame = CGRect(x: lbShopNameValue.frame.origin.x, y: lbShopNameValue.frame.origin.y, width: lbShopNameValue.frame.width, height: lbShopNameValueTextHeight)
        
        
        
        
        lbUserShop = UILabel(frame: CGRect(x: Common.Size(s: 10), y:lbShopName.frame.size.height + lbShopNameValue.frame.origin.y + Common.Size(s: 10), width: lbNameCustomer.frame.size.width, height: Common.Size(s: 20)))
        lbUserShop.text = "NV cập nhật:"
        lbUserShop.textAlignment = .left
        lbUserShop.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbUserShop.textColor = UIColor.black
        self.addSubview(lbUserShop)
        
        lbUserShopValue = UILabel(frame: CGRect(x: lbUserShop.frame.size.width + lbUserShop.frame.origin.x, y:lbUserShop.frame.origin.y, width: lbNameCustomerValue.frame.size.width, height: Common.Size(s: 20)))
        lbUserShopValue.text = "\(item.EmployeeName)"
        lbUserShopValue.textAlignment = .left
        lbUserShopValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbUserShopValue.textColor = UIColor.black
        self.addSubview(lbUserShopValue)
        
        
        lbSDTCustomer = UILabel(frame: CGRect(x: Common.Size(s: 10), y:lbUserShop.frame.size.height + lbUserShop.frame.origin.y + Common.Size(s: 10), width: lbNameCustomer.frame.size.width, height: Common.Size(s: 20)))
        lbSDTCustomer.text = "SĐT:"
        lbSDTCustomer.textAlignment = .left
        lbSDTCustomer.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbSDTCustomer.textColor = UIColor.black
        self.addSubview(lbSDTCustomer)
        
        
        lbSDTCustomerValue = UILabel(frame: CGRect(x:lbSDTCustomer.frame.size.width + lbSDTCustomer.frame.origin.x, y:lbSDTCustomer.frame.origin.y , width: lbNameCustomerValue.frame.size.width, height: Common.Size(s: 20)))
        lbSDTCustomerValue.text = "\(item.PhoneNumber)"
        lbSDTCustomerValue.textAlignment = .left
        lbSDTCustomerValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbSDTCustomerValue.textColor = UIColor.black
        self.addSubview(lbSDTCustomerValue)
        
 
        
        
        lbBirthday = UILabel(frame: CGRect(x: Common.Size(s: 10), y:lbSDTCustomer.frame.size.height + lbSDTCustomer.frame.origin.y + Common.Size(s: 10), width: lbNameCustomer.frame.size.width, height: Common.Size(s: 20)))
        lbBirthday.text = "Ngày cấp CMND:"
        lbBirthday.textAlignment = .left
        lbBirthday.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbBirthday.textColor = UIColor.black
        self.addSubview(lbBirthday)
        
        lbBirthdayValue = UILabel(frame: CGRect(x: lbBirthday.frame.size.width + lbBirthday.frame.origin.x , y:lbBirthday.frame.origin.y, width: lbNameCustomerValue.frame.size.width, height: Common.Size(s: 20)))
        lbBirthdayValue.text = "\(item.DateOfIssue)"
        lbBirthdayValue.textAlignment = .left
        lbBirthdayValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbBirthdayValue.textColor = UIColor.black
        self.addSubview(lbBirthdayValue)
        
   
    
        
        
        lbFee = UILabel(frame: CGRect(x: Common.Size(s: 10), y:lbBirthday.frame.size.height + lbBirthday.frame.origin.y + Common.Size(s: 10), width: lbNameCustomer.frame.size.width, height: Common.Size(s: 20)))
        lbFee.text = "Phí cập nhật:"
        lbFee.textAlignment = .left
        lbFee.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbFee.textColor = UIColor.black
        self.addSubview(lbFee)
        
        lbFeeValue = UILabel(frame: CGRect(x: lbFee.frame.size.width + lbFee.frame.origin.x, y:lbFee.frame.origin.y , width: lbNameCustomerValue.frame.size.width, height: Common.Size(s: 20)))
        lbFeeValue.text = "\(item.PhiCapNhat) VNĐ"
        lbFeeValue.textAlignment = .left
        lbFeeValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        lbFeeValue.textColor = UIColor.red
        self.addSubview(lbFeeValue)
        
        let line2 = UIView(frame: CGRect(x: Common.Size(s: 10), y: lbFee.frame.origin.y + lbFee.frame.size.height + Common.Size(s: 8), width: self.frame.width - Common.Size(s: 20), height: Common.Size(s: 1)))
        line2.backgroundColor = .lightGray
        self.addSubview(line2)
        
        estimateCellHeight = line2.frame.origin.y + line2.frame.height + Common.Size(s: 5)
    }
}

extension HistoryUpdateVNMViewController: UISearchBarDelegate {
    
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
            filterList = listBank.filter({$0.PhoneNumber.localizedCaseInsensitiveContains(key)})
        } else {
            filterList = listBank
        }
        tableView.reloadData()
    }
}
