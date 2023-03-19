//
//  ShopInventoryViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
class ShopInventoryViewController: UIViewController{
    var listSku:String = ""
    var shops: [String:NSMutableArray] = [:]
    var productName:String = ""
    var scrollView:UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        self.title = "Tồn kho shop gần nhất"
        self.view.backgroundColor = .white
        //TODO
//        let newViewController = LoadingViewController()
//        newViewController.content = "Đang kiểm tra tồn kho..."
//        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.navigationController?.present(newViewController, animated: true, completion: nil)
//        let nc = NotificationCenter.default
        
        MPOSAPIManager.getTonKhoShopGanNhat(listsp: listSku, shopCode: "\(Cache.user!.ShopCode)") { (results, err) in
            
//            let when = DispatchTime.now() + 0.5
//            DispatchQueue.main.asyncAfter(deadline: when) {
//                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results.count > 0){
                        for item in results {
                            if let val:NSMutableArray = self.shops["\(item.Shopname)"] {
                                val.add(item)
                                self.shops.updateValue(val, forKey: "\(item.Shopname)")
                            } else {
                                let arr: NSMutableArray = NSMutableArray()
                                arr.add(item)
                                self.shops.updateValue(arr, forKey: "\(item.Shopname)")
                            }
                        }
                        print(self.shops)
                        self.loadUI()
                    }else{
                        let alertController = UIAlertController(title: "Thông báo", message: "Không có shop gần nhất nào còn tồn kho!", preferredStyle: .alert)
                        
                        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                            _ = self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        }
                        alertController.addAction(confirmAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                }else{
                    let alertController = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                        _ = self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                    alertController.addAction(confirmAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
//            }
        }
    }
    
    func loadUI() {
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y:0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        
        let sizeProductName = productName.height(withConstrainedWidth: scrollView.frame.size.width - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:20)))
        
        let lbProductName = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:10), height: sizeProductName))
        lbProductName.textAlignment = .center
        lbProductName.textColor = UIColor(netHex:0xb8462e)
        lbProductName.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
        lbProductName.text = productName
        lbProductName.numberOfLines = 3;
        scrollView.addSubview(lbProductName)
        
        var indexY = lbProductName.frame.size.height + lbProductName.frame.origin.y + Common.Size(s:10)
        for items in self.shops {
            print(items)
            let sizeShopName = items.key.height(withConstrainedWidth: scrollView.frame.size.width - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
            let lbShopName = UILabel(frame: CGRect(x: Common.Size(s:5), y: indexY, width: scrollView.frame.size.width - Common.Size(s:10), height: sizeShopName))
            lbShopName.textAlignment = .left
            lbShopName.textColor = UIColor.darkText
            lbShopName.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbShopName.text = items.key
            lbShopName.numberOfLines = 1;
            scrollView.addSubview(lbShopName)
            
            var count = 0
            var indexYProduct = lbShopName.frame.size.height + lbShopName.frame.origin.y + Common.Size(s:5)
            for item in items.value {
                count = count + 1
                let itm = item as! ShopInventory
                let lbShopName = UILabel(frame: CGRect(x: Common.Size(s:10), y: indexYProduct, width: scrollView.frame.size.width - Common.Size(s:20), height: sizeShopName))
                lbShopName.textAlignment = .left
                lbShopName.textColor = UIColor.darkGray
                lbShopName.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbShopName.text =  "\(count). Mã \(itm.itemcode) (\(itm.Mausac)): SL \(itm.SL)"
                lbShopName.numberOfLines = 1;
                scrollView.addSubview(lbShopName)
                indexYProduct = indexYProduct + lbShopName.frame.size.height
            }
            indexY = indexYProduct + Common.Size(s:15)
        }
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: indexY +  Common.Size(s:20))
    }
}

