//
//  ShopListViewController.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 06/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ShopListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var shopList: [Shop] = [];
    var reportCase: ReportCase!;
    lazy var searchBar:UISearchBar = UISearchBar()
    var filterShop: [Shop] = []
    
    @IBOutlet weak var tbvShopList: UITableView!;
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterShop.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        
        let font = cell?.textLabel?.font;
        cell?.textLabel?.font = font?.withSize(13);
        let key = self.searchBar.text ?? ""
        if key.count > 0 {
            cell?.textLabel?.text = "\(filterShop[indexPath.row].ShopCode ?? "") - \(filterShop[indexPath.row].ShopName ?? "")"
        } else {
            cell?.textLabel?.text = "\(shopList[indexPath.row].ShopCode ?? "") - \(shopList[indexPath.row].ShopName ?? "")"
        }
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let key = self.searchBar.text ?? ""
        if key.count > 0 {
            Cache.selectedShopCode = filterShop[indexPath.row].ShopCode ?? ""
            Cache.selectedShopNameDSTarget = filterShop[indexPath.row].ShopName ?? ""
        } else {
            Cache.selectedShopCode = shopList[indexPath.row].ShopCode ?? ""
            Cache.selectedShopNameDSTarget = shopList[indexPath.row].ShopName ?? ""
        }
        self.PresentNextView();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        searchBar.addDoneButtonOnKeyboard()
        self.navigationItem.titleView = searchBar
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
        
        tbvShopList.register(UITableViewCell.self, forCellReuseIdentifier: "cell");
        tbvShopList.delegate = self;
        tbvShopList.dataSource = self;
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            self.shopList = mSMApiManager.GetShopByUser(username: Cache.user?.UserName ?? "").Data ?? []
            self.filterShop = self.shopList
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if self.shopList.count > 0 {
                    self.tbvShopList.reloadData()
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: "Không có danh sách shop!", preferredStyle: UIAlertController.Style.alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func canRotate() -> Void{}
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation;
            
            switch orient {
            case .portrait:
                
                self.viewDidLoad();
            case .landscapeLeft,
                 .landscapeRight:
                
                self.viewDidLoad();
            default:
                break;
            }
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
            
        })
        super.viewWillTransition(to: size, with: coordinator)
        
    }
    
    func PresentNextView(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            switch self.reportCase.unsafelyUnwrapped {
            case .GetTargetReport:
//                let reportCollectionVC = DetailDSTargetViewController();
                let reportCollectionVC = DetailDSTargetVC();
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.navigationController?.pushViewController(reportCollectionVC, animated: true);
                }
            case .GetUpgradeLoan,
                 .GetUnpaidLoan:
                let reportCollectionVC = ReportCollectionViewController();
                reportCollectionVC.cellData = self.reportCase.reportData;
                reportCollectionVC.header = self.reportCase.reportHeader;
                reportCollectionVC.reportSection = self.reportCase;
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.navigationController?.pushViewController(reportCollectionVC, animated: true);
                }
            default:
                let listVC = ReportListTableViewController();
                listVC.reportSection = self.reportCase;
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.navigationController?.pushViewController(listVC, animated: true);
                }
            }
        }
    }
}

extension ShopListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(key: searchText)
    }

    func search(key:String){
        if key.count > 0 {
            filterShop = shopList.filter({(($0.ShopName ?? "").localizedCaseInsensitiveContains(key)) || (($0.ShopCode ?? "").localizedCaseInsensitiveContains(key))})
        } else {
            filterShop = shopList
        }
        self.tbvShopList.reloadData()
    }
}
