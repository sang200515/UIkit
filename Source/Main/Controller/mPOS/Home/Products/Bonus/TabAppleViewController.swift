//
//  TabAppleViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
import SnapKit
import Foundation
import Kingfisher
class TabAppleViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var collectionView: UICollectionView!
    var products: [Product] = []
     var isLoadingView:Bool = false
    private var isLoading:Bool = false
    var parentNavigationController : UINavigationController?
    var parentTabBarController: UITabBarController?
    private var fromPagination = 0
    private let lstDict:[Any] = ParamPriceFilter.convertParams(sortPriceFrom: 0,sortPriceTo: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = UIColor.white
        self.title = "Apple"
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
        collectionView.register(ProductBonusCollectionCell.self, forCellWithReuseIdentifier: "ProductBonusCollectionCell")
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        let nc = NotificationCenter.default
  
        let lstDictPagination:[Any] = ParamPaginationFilter.convertParams(from: fromPagination,size: 40)
        ProductAPIManager.product_filter(u_ng_code:"01",item_group_code:"",sort_point:"0",price:lstDict[0],firm_code:"", pagination: lstDictPagination[0]) { [weak self](results, err) in
            guard let self = self else {return}
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductBonusCollectionCell", for: indexPath) as! ProductBonusCollectionCell
        let item:Product = products[indexPath.row]
        cell.setup(item: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item:Product = products[indexPath.row]
        //        navigationController?.navigationBar.isTranslucent = true
        Cache.sku = item.sku
        Cache.model_id = item.model_id
        let newViewController = DetailProductViewController()
//            newViewController.product = item
        newViewController.isCompare = false
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
     
        if offsetY > contentHeight - scrollView.frame.size.height - 100 {
         
            if (isLoading == false){
                isLoading = true
                fromPagination = fromPagination + 40
                let lstDictPagination:[Any] = ParamPaginationFilter.convertParams(from: fromPagination,size: 40)
                ProductAPIManager.product_filter(u_ng_code:"01",item_group_code:"",sort_point:"0",price:lstDict[0],firm_code:"", pagination: lstDictPagination[0]) {[weak self] (results, err) in
                    guard let self = self else {return}
                    self.products.append(contentsOf: results)
                    self.collectionView.reloadData()
                    self.isLoading = false
                    
                }
            }
            
        }
        
        
        
    }

    
}

class ProductBonusCollectionCell: UICollectionViewCell {
    var iconImage:UIImageView!
    var title:UILabel!
    var price:UILabel!
    var bonus:UILabel!
    var hotSticker:UIImageView!
    var is_NK:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setup(item:Product){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: self.frame.size.width, height:  self.frame.size.width - Common.Size(s:20)))
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
		if item.hotSticker {
			lazy var hotSticker = UIImageView()
			iconImage.addSubview(hotSticker)
			hotSticker.snp.makeConstraints { make in
				make.left.equalTo(iconImage.snp.left)
				make.bottom.equalTo(iconImage.snp.bottom)
			}
			hotSticker.image = UIImage(named: "ic_hot3")
		}
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = item.imageUrl.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            if(escapedString != ""){
                let url = URL(string: "\(escapedString)")!
                iconImage.kf.setImage(with: url,
                                      placeholder: nil,
                                      options: [.transition(.fade(1))],
                                      progressBlock: nil,
                                      completionHandler: nil)
            }
  
        }
        
        let heightTitel = item.name.height(withConstrainedWidth: self.frame.size.width - Common.Size(s:4), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
        
        title = UILabel(frame: CGRect(x: Common.Size(s:2), y: iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s:5), width: self.frame.size.width - Common.Size(s:4), height: heightTitel))
        title.textAlignment = .center
        title.textColor = UIColor.lightGray
        title.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        title.text = item.name
        title.numberOfLines = 3
        title.sizeToFit()
        title.frame.origin.x = self.frame.size.width/2 -  title.frame.size.width/2
        addSubview(title)
        price = UILabel(frame: CGRect(x: Common.Size(s:2), y: title.frame.size.height + title.frame.origin.y, width: self.frame.size.width - Common.Size(s:4), height: Common.Size(s:14)))
        price.textAlignment = .center
        price.textColor = UIColor(netHex:0xEF4A40)
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        price.text = Common.convertCurrencyFloat(value: item.price)
        price.numberOfLines = 1
        addSubview(price)
        
        let viewBonus = UIView(frame: CGRect(x: 2, y: price.frame.size.height + price.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:14)))
        addSubview(viewBonus)
        
        bonus = UILabel(frame: CGRect(x: 0, y: 0, width: viewBonus.frame.size.width, height: Common.Size(s:14)))
        bonus.textAlignment = .center
        bonus.textColor = UIColor(netHex:0x47B054)
        bonus.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        bonus.text = "\(item.bonusScopeBoom)"
        bonus.numberOfLines = 1
        viewBonus.addSubview(bonus)
        
    }
    func setupVariant(item:Variant){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: self.frame.size.width, height:  self.frame.size.width - Common.Size(s:20)))
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = item.ecom_image_url.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            if(escapedString != ""){
                let url = URL(string: "\(escapedString)")!
                iconImage.kf.setImage(with: url,
                                      placeholder: nil,
                                      options: [.transition(.fade(1))],
                                      progressBlock: nil,
                                      completionHandler: nil)
            }
  
        }
        
        let heightTitel = item.name.height(withConstrainedWidth: self.frame.size.width - Common.Size(s:4), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
        
        title = UILabel(frame: CGRect(x: Common.Size(s:2), y: iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s:5), width: self.frame.size.width - Common.Size(s:4), height: heightTitel))
        title.textAlignment = .center
        title.textColor = UIColor.lightGray
        title.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        title.text = item.name
        title.numberOfLines = 3
        title.sizeToFit()
        title.frame.origin.x = self.frame.size.width/2 -  title.frame.size.width/2
        addSubview(title)
        price = UILabel(frame: CGRect(x: Common.Size(s:2), y: title.frame.size.height + title.frame.origin.y, width: self.frame.size.width - Common.Size(s:4), height: Common.Size(s:14)))
        price.textAlignment = .center
        price.textColor = UIColor(netHex:0xEF4A40)
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        price.text = Common.convertCurrencyFloat(value: item.price)
        price.numberOfLines = 1
        addSubview(price)
        
        let viewBonus = UIView(frame: CGRect(x: 2, y: price.frame.size.height + price.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:14)))
        addSubview(viewBonus)
        
        bonus = UILabel(frame: CGRect(x: 0, y: 0, width: viewBonus.frame.size.width, height: Common.Size(s:14)))
        bonus.textAlignment = .center
        bonus.textColor = UIColor(netHex:0x47B054)
        bonus.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        bonus.text = "\(item.bonusScopeBoom)"
        bonus.numberOfLines = 1
        viewBonus.addSubview(bonus)
        if item.hotSticker{
            hotSticker = UIImageView(frame: CGRect(x: self.frame.size.width/1.5, y: 0, width: Common.Size(s:30), height: Common.Size(s:30)))
            hotSticker.image = UIImage(named: "ic_Hot")
            hotSticker.frame.origin.x = self.frame.size.width -  hotSticker.frame.size.width
            addSubview(hotSticker)
        }
        if item.is_NK{
            is_NK = UIImageView(frame: CGRect(x: self.frame.size.width/1.5, y: 0, width: Common.Size(s:30), height: Common.Size(s:30)))
            is_NK.image = UIImage(named: "icNhapKhau")
            is_NK.frame.origin.x = self.frame.size.width -  is_NK.frame.size.width
            addSubview(is_NK)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


