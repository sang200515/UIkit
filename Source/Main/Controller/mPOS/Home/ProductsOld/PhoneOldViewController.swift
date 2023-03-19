//
//  PhoneOldViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/10/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import Kingfisher
class PhoneOldViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
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
        
//        let newViewController = LoadingViewController()
//        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.getListOldProduct(shop: "\(Cache.user!.ShopCode)", skip: 0, top: 100, type: 1) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
            self.products = results
            self.loadView(results: results)
                  }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
class ProductOldCollectionCell: UICollectionViewCell {
    var iconImage:UIImageView!
    var title:UILabel!
    var priceOld:UILabel!
    var price:UILabel!
    var bounus:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setup(item:ProductOld){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: self.frame.size.width, height:  self.frame.size.width - Common.Size(s:20)))
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = item.IconUrl.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            let url = URL(string: "\(escapedString)")!
            iconImage.kf.setImage(with: url,
                                  placeholder: nil,
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil,
                                  completionHandler: nil)
        }
        
        let heightTitel = item.Name.height(withConstrainedWidth: self.frame.size.width - 4, font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
        
        title = UILabel(frame: CGRect(x: 2, y: iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s:5), width: self.frame.size.width - 4, height: heightTitel))
        title.textAlignment = .center
        title.textColor = UIColor.lightGray
        title.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        title.text = item.Name
        title.numberOfLines = 2
        title.sizeToFit()
        title.frame.origin.x = self.frame.size.width/2 -  title.frame.size.width/2
        addSubview(title)
        //
        bounus = UILabel(frame: CGRect(x: 2, y: title.frame.size.height + title.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:14)))
        bounus.textAlignment = .center
        bounus.textColor = UIColor(netHex:0x04AB6E)
        bounus.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        bounus.text = item.BonusScopeBoom
        bounus.numberOfLines = 1
        addSubview(bounus)
        //
        priceOld = UILabel(frame: CGRect(x: 2, y: bounus.frame.size.height + bounus.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:14)))
        priceOld.textAlignment = .center
        priceOld.textColor = UIColor.lightGray
        priceOld.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: Common.convertCurrencyFloat(value: item.OldPrice))
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        priceOld.attributedText =  attributeString
        priceOld.numberOfLines = 1
        addSubview(priceOld)
        
        price = UILabel(frame: CGRect(x: 2, y: priceOld.frame.size.height + priceOld.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:14)))
        price.textAlignment = .center
        price.textColor = UIColor(netHex:0xEF4A40)
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        price.text = Common.convertCurrencyFloat(value: item.Price)
        price.numberOfLines = 1
        addSubview(price)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
