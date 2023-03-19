//
//  TabProductOldMiraeViewController.swift
//  fptshop
//
//  Created by tan on 5/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import UIKit
class TabProductOldMiraeViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var collectionView: UICollectionView!
    var products: [ProductOld] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:10), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        layout.itemSize = CGSize(width: (self.view.frame.size.width - Common.Size(s:10))/2, height: (self.view.frame.size.width - Common.Size(s:10))/2 * 1.4)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = Common.Size(s:5)/2
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - (self.tabBarController?.tabBar.frame.size.height)!), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductOldCollectionCell.self, forCellWithReuseIdentifier: "ProductOldCollectionCell")
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        MPOSAPIManager.getListOldProduct(shop: "\(Cache.user!.ShopCode)", skip: 0, top: 100, type: 0) { (results, err) in
            self.products = results
            self.loadView(results: results)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        Cache.searchOld = true
    }
    func loadView(results: [ProductOld]){
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductOldCollectionCell", for: indexPath) as! ProductOldCollectionCell
        let item:ProductOld = products[indexPath.row]
        cell.setup(item: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item:ProductOld = products[indexPath.row]
        let newViewController = DetailProductOldMiraeViewController()
        newViewController.product = item
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    var isLoading:Bool = false
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height - 100 {
            if (isLoading == false){
                isLoading = true
                //                APIService.getListOldProduct(shop: "\(Cache.User!.ShopCode)", skip:  self.products.count, top: 30, type: 2) { (results, err) in
                //                    self.products.append(contentsOf: results)
                //                    self.collectionView.reloadData()
                //                    self.isLoading = false
                //                    print(self.products.count)
                //                }
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
