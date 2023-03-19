//
//  FilterViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/28/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit

protocol ActionHandleFilter: AnyObject {
    func pushViewFilter(_ sort: String, _ sortPriceFrom: Float, _ sortPriceTo: Float, _ sortGroupName: String, _ sortManafacture: String, _ u_ng_code:String,_ inventory:String)
}

class FilterViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,HandleFilter {

    
    
    
    var collectionview: UICollectionView!
    var items: [ItemApp] = []
    weak var handleFilterDelegate: ActionHandleFilter?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Lọc sản phẩm"
        self.initNavigationBar()
        _ = UIScreen.main.bounds.size.width
        _ = UIScreen.main.bounds.size.height
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "Close"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(FilterViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---

        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:5), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        layout.itemSize = CGSize(width: (self.view.frame.size.width - Common.Size(s:20))/3, height: (self.view.frame.size.width - Common.Size(s:20))/3)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0
        
        collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)), collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(ItemAppCell.self, forCellWithReuseIdentifier: "ItemAppCell")
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.white
        self.view.addSubview(collectionview)
        //

        
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            ProductAPIManager.get_list_nganh_hang(handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
                        for item in results{
                            
                            switch item.u_ng_code {
                            case "01":
                                self.items.append(ItemApp(id: "1", name: item.u_ng_name, type: item.u_ng_code, icon: #imageLiteral(resourceName: "ic_apple_filter")))
                            case "02":
                                self.items.append(ItemApp(id: "2", name: item.u_ng_name, type: item.u_ng_code, icon: #imageLiteral(resourceName: "ic-apple")))
                            case "05":
                                self.items.append(ItemApp(id: "3", name: item.u_ng_name, type: item.u_ng_code, icon: #imageLiteral(resourceName: "ic-laptop")))
                            case "06":
                                self.items.append(ItemApp(id: "4", name: item.u_ng_name, type: item.u_ng_code, icon: #imageLiteral(resourceName: "ic-phukien")))
                            case "12":
                                self.items.append(ItemApp(id: "5", name: item.u_ng_name, type: item.u_ng_code, icon: #imageLiteral(resourceName: "ic-tablet")))
                            case "22":
                                self.items.append(ItemApp(id: "6", name: item.u_ng_name, type: item.u_ng_code, icon: #imageLiteral(resourceName: "ic_matkieng_filter")))
                            case "24":
                                self.items.append(ItemApp(id: "7", name: item.u_ng_name, type: item.u_ng_code, icon: #imageLiteral(resourceName: "ic_dongho_filter")))
                            default:
                                self.items.append(ItemApp(id: "8", name: item.u_ng_name, type: item.u_ng_code, icon: #imageLiteral(resourceName: "ic-phone")))
                            }
                        }
                        self.collectionview.reloadData()
                        
                        
                        
                    } else {
                        self.showAlert(title: "Thông báo", message: "\(err)")
                    }
                }
            })
        }
    
        //
    }
    @objc func actionBack() {
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "ItemAppCell", for: indexPath) as! ItemAppCell
        let item: ItemApp = self.items[indexPath.row]
        cell.setup(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item: ItemApp = self.items[indexPath.row]
        let vc = DetailFilterViewController()
        vc.item = item
        vc.handleFilterDelegate = self
        self.navigationController?.pushViewController(vc, animated: false)
    }
    func pushViewFilter(_ sort: String, _ sortPriceFrom: Float, _ sortPriceTo: Float, _ sortGroupName: String, _ sortManafacture: String , _ u_ng_code:String, _ inventory:String) {
        handleFilterDelegate?.pushViewFilter(sort,sortPriceFrom,sortPriceTo,sortGroupName,sortManafacture,u_ng_code,inventory)
        self.dismiss(animated: false, completion: nil)
    }
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}
