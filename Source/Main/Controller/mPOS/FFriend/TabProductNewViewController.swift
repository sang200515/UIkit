//
//  TabProductNewViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/13/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import UIKit
import MIBadgeButton_Swift
class TabProductNewViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var collectionView: UICollectionView!
    var products: [Product] = []
    private var fromPagination = 0
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
        collectionView.register(ProductBonusCollectionCell.self, forCellWithReuseIdentifier: "ProductBonusCollectionCell")
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        
        let lstDict:[Any] = ParamPriceFilter.convertParams(sortPriceFrom: 0,sortPriceTo: 0)
        let lstDictPagination:[Any] = ParamPaginationFilter.convertParams(from: fromPagination,size: 40)
        ProductAPIManager.product_filter(u_ng_code:"02",item_group_code:"111",sort_point:"0",price:lstDict[0],firm_code:"", pagination: lstDictPagination[0]) {[weak self] (results, err) in
            guard let self = self else {return}
            self.products = results
            self.loadView(results: results)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
  
        Cache.searchOld = false
    }
    func loadView(results: [Product]){
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductBonusCollectionCell", for: indexPath) as! ProductBonusCollectionCell
        let item:Product = products[indexPath.row]
        cell.setup(item: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item:Product = products[indexPath.row]
        if (item.manSerNum == "Y"){
            let newViewController = DetailProductNewViewController()
            newViewController.sku = item.sku
            newViewController.model_id = item.model_id
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            let newViewController = DetailAccessoriesFFriendViewController()
            newViewController.product = item
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    var isLoading:Bool = false
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//
//        if offsetY > contentHeight - scrollView.frame.size.height - 100 {
//            if (isLoading == false){
//                isLoading = true
//                MPOSAPIManager.getListBonusScope(typeId: 1, skip: self.products.count, top: 20) { (results, err) in
//                    self.products.append(contentsOf: results)
//                    self.collectionView.reloadData()
//                    self.isLoading = false
//                    print(self.products.count)
//                }
//            }
//
//        }
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

