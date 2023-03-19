//
//  TabLaptopViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Kingfisher
class TabLaptopVNPTViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var collectionView: UICollectionView!
    var products: [Product] = []
     var isLoadingView:Bool = false
    var parentNavigationController : UINavigationController?
    var parentTabBarController: UITabBarController?
    private var fromPagination = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = UIColor.white
        self.title = "Laptop"
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
        collectionView.register(ProductBonusCollectionCell3.self, forCellWithReuseIdentifier: "ProductBonusCollectionCell3")
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        let nc = NotificationCenter.default
        let lstDict:[Any] = ParamPriceFilter.convertParams(sortPriceFrom: 0,sortPriceTo: 0)
        let lstDictPagination:[Any] = ParamPaginationFilter.convertParams(from: fromPagination,size: 40)
        ProductAPIManager.product_filter(u_ng_code:"05",item_group_code:"124",sort_point:"0",price:lstDict[0],firm_code:"", pagination: lstDictPagination[0]) { (results, err) in
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
    func loadView(results: [Product]){
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.reloadData()
  
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductBonusCollectionCell3", for: indexPath) as! ProductBonusCollectionCell3
        let item:Product = products[indexPath.row]
        cell.setup(item: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item:Product = products[indexPath.row]
        //        navigationController?.navigationBar.isTranslucent = true
        if (item.manSerNum == "Y"){
            Cache.sku = item.sku
            Cache.model_id = item.model_id
            let newViewController = DetailProductVNPTViewController()
//            newViewController.product = item
            newViewController.isCompare = false
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            let newViewController = DetailAccessoriesVNPTViewController()
            newViewController.product = item
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
