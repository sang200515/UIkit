//
//  TabletOldViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/10/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import Kingfisher
class TabletOldViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var collectionView: UICollectionView!
    var products: [ProductOld] = []
    
    var parentNavigationController : UINavigationController?
    var parentTabBarController: UITabBarController?
    var isLoadingView:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        isLoadingView = false
        navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = UIColor.white
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:10), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        layout.itemSize = CGSize(width: (self.view.frame.size.width - Common.Size(s:10))/2, height: (self.view.frame.size.width - Common.Size(s:10))/2 * 1.4)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = Common.Size(s:5)/2
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - CGFloat((self.tabBarController?.tabBar.frame.size.height)!) - UIApplication.shared.statusBarFrame.height), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductOldCollectionCell.self, forCellWithReuseIdentifier: "ProductOldCollectionCell")
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        
        let newViewController = LoadingViewController()
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.getListOldProduct(shop: "\(Cache.user!.ShopCode)", skip: 0, top: 100, type: 2) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                self.products = results
                self.loadView(results: results)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if(!isLoadingView){
            isLoadingView = true
            let newViewController = LoadingViewController()
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
        }
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
        let newViewController = DetailOldProductViewController()
        newViewController.product = item
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
