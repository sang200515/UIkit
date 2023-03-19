//
//  ProductsFilterViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/28/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Kingfisher
class ProductsFilterViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var collectionView: UICollectionView!
    var products: [Product] = []
    var parentNavigationController : UINavigationController?
    var parentTabBarController: UITabBarController?
    var isLoadingView:Bool = false
    
    var arrId: String!
    var arrIDPrice: String!
    var sort: String!
    var arrIdBrand: String!
    
    var sortBonus:String?
    var sortPriceFrom:Float?
    var sortPriceTo:Float?
    var sortGroup:String?
    var sortManafacture:String?
    var u_ng_code:String?
    var inventory:String?
    private var fromPagination = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = UIColor.white
        self.title = "Kết quả lọc"
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        let viewSwitch = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 50)))
  
        let switchCheckStock = UISwitch(frame: CGRect(x: 0, y: 8, width: 30, height: 10))

        switchCheckStock.onTintColor = .orange
        switchCheckStock.isOn = true // or false
        switchCheckStock.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchCheckStock.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        viewSwitch.addSubview(switchCheckStock)
        let switch_display = UIBarButtonItem(customView: viewSwitch)
        
        let lblStockLable = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
        lblStockLable.font = UIFont.systemFont(ofSize: 15)
        lblStockLable.textColor = .white
        lblStockLable.text = "Tồn kho"
        let lblStock = UIBarButtonItem(customView: lblStockLable)
        self.navigationItem.rightBarButtonItems  = [switch_display,lblStock]
        
        //---
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:10), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        layout.itemSize = CGSize(width: (self.view.frame.size.width - Common.Size(s:10))/2, height: (self.view.frame.size.width - Common.Size(s:10))/2 * 1.4)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = Common.Size(s:5)/2
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - UIApplication.shared.statusBarFrame.height), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductFilterCollectionCell.self, forCellWithReuseIdentifier: "ProductFilterCollectionCell")
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        fetchProduct(isOn: true)
    }
    
    func fetchProduct(isOn: Bool) {
        inventory = isOn ? "1" : "0"
        showLoadingView()
        let lstDict:[Any] = ParamPriceFilter.convertParams(sortPriceFrom:sortPriceFrom ?? 0,sortPriceTo:sortPriceTo ?? 0)
        let lstDictPagination:[Any] = ParamPaginationFilter.convertParams(from: fromPagination,size: 40)
        ProductAPIManager.product_filter(u_ng_code:"\(u_ng_code ?? "")",item_group_code:"\(sortGroup ?? "")",sort_point:"\(sortBonus ?? "0")",price:lstDict[0],firm_code:"\(sortManafacture ?? "")", pagination: lstDictPagination[0],inventory: inventory ?? "0") { (results, err) in
            
            self.products = results
            var listSku = ""
            for item in self.products {
                if(listSku == ""){
                    listSku = "\(item.sku)"
                }else{
                    listSku = "\(listSku),\(item.sku)"
                }
            }
            MPOSAPIManager.getTonKhoShop(listsp: listSku, userCode: "\(Cache.user!.UserName)", shopCode: "\(Cache.user!.ShopCode)", handler: { (results, err) in
                self.isLoadingView = false
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.hideLoading()
                    if(err.count <= 0){
                        if(results.count > 0){
                            for item in self.products {
                                for it in results {
                                    if("\(item.sku)" == "\(it.ItemCode)"){
                                        item.inventory = it.SL
                                        break
                                    }
                                }
                            }
                        }
                        self.collectionView.reloadData()
                    }else{
                        for item in self.products {
                            item.inventory = -1
                        }
                        self.collectionView.reloadData()
                    }
                }
            })
//            let when = DispatchTime.now() + 0.5
//            DispatchQueue.main.asyncAfter(deadline: when) {
//                nc.post(name: Notification.Name("dismissLoading"), object: nil)
//                self.products = results
//                self.loadView(results: results)
//            }
        }
    }
    @IBAction func switchToggled(_ sender: UISwitch) {
        fromPagination = 0
        products.removeAll()
        self.collectionView.reloadData()
        inventory = sender.isOn ? "1" : "0"
        if sender.isOn {
            fetchProduct(isOn: true)
        } else{
            fetchProduct(isOn: false)
        }
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
//        showLoadingView()
    }
    
    func showLoadingView() {
        if(!isLoadingView){
            isLoadingView = true
            let newViewController = LoadingViewController()
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
        }
    }
    
    func hideLoading() {
        NotificationCenter.default.post(name: Notification.Name("dismissLoading"), object: nil)
    }
    func loadView(results: [Product]){
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductFilterCollectionCell", for: indexPath) as! ProductFilterCollectionCell
        let item:Product = products[indexPath.row]
        cell.setup(item: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item:Product = products[indexPath.row]
        //        navigationController?.navigationBar.isTranslucent = true
        Cache.sku = item.sku
        Cache.model_id = "\(item.model_id)"
       
        let newViewController = DetailProductViewController()
        //            newViewController.product = item
        newViewController.isCompare = false
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    var isLoading:Bool = false
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.size.height - 100 {
        
            
            if (isLoading == false){
                isLoading = true
                fromPagination = fromPagination + 40
                let lstDictPagination:[Any] = ParamPaginationFilter.convertParams(from: fromPagination,size: 40)
                let lstDictPrice:[Any] = ParamPriceFilter.convertParams(sortPriceFrom:sortPriceFrom ?? 0,sortPriceTo:sortPriceTo ?? 0)
                ProductAPIManager.product_filter(u_ng_code:"\(u_ng_code ?? "")",item_group_code:"\(sortGroup ?? "")",sort_point:"\(sortBonus ?? "0")",price:lstDictPrice[0],firm_code:"\(sortManafacture ?? "")", pagination: lstDictPagination[0],inventory: inventory ?? "0") {[weak self] (results, err) in
                    guard let self = self else {return}
                    self.products.append(contentsOf: results)
                    self.collectionView.reloadData()
                    self.isLoading = false
                    
                }
            }

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
class ProductFilterCollectionCell: UICollectionViewCell {
    var iconImage:UIImageView!
    var title:UILabel!
    var price:UILabel!
    var bonus:UILabel!
    var stock:UILabel!
    var installment:UILabel!
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
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] ").inverted)
        
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
        
        bonus = UILabel(frame: CGRect(x: 0, y: 0, width: viewBonus.frame.size.width/2 - Common.Size(s:1), height: Common.Size(s:14)))
        //         bonus = UILabel(frame: CGRect(x: 0, y: 0, width: viewBonus.frame.size.width, height: Common.Size(s:14)))
        bonus.textAlignment = .right
        
        bonus.textColor = UIColor(netHex:0x47B054)
        bonus.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        bonus.text = "\(item.bonusScopeBoom)"
        bonus.numberOfLines = 1
        viewBonus.addSubview(bonus)
        
        stock = UILabel(frame: CGRect(x: viewBonus.frame.size.width/2 + Common.Size(s:1), y: 0, width: viewBonus.frame.size.width/2 - Common.Size(s:2), height: Common.Size(s:14)))
        stock.textAlignment = .left
        stock.textColor = UIColor.darkGray
        stock.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        stock.text = "(\(item.inventory))"
        if(item.inventory == -1){
            stock.text = "(N/A)"
        }
        stock.numberOfLines = 1
        viewBonus.addSubview(stock)
        
        if(item.labelName != ""){
            installment = UILabel(frame: CGRect(x: self.frame.size.width/2, y: 0, width: self.frame.size.width/2, height: Common.Size(s:18)))
            installment.textAlignment = .center
            installment.textColor = UIColor.white
            installment.backgroundColor = .red
            installment.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            
            if ("\(item.labelName)" == "TG 0%&0d"){
                installment.text = " TG 0%&0đ "
            }else{
                installment.text = " \(item.labelName) "
            }
            
            installment.numberOfLines = 1
            //            installment.layer.cornerRadius = Common.Size(s:3)
            //            installment.clipsToBounds = true
            installment.sizeToFit()
            addSubview(installment)
            installment.frame.origin.x = self.frame.size.width -  installment.frame.size.width
        }

        if(item.hotSticker){
           hotSticker = UIImageView(frame: CGRect(x: self.frame.size.width/2, y: 0, width: Common.Size(s:30), height: Common.Size(s:30)))
            hotSticker.image = UIImage(named: "ic_Hot")
            addSubview(hotSticker)
            hotSticker.frame.origin.x = self.frame.size.width -  hotSticker.frame.size.width
        }
        if(item.is_NK){
            is_NK = UIImageView(frame: CGRect(x: self.frame.size.width, y: 20, width: Common.Size(s:45), height: Common.Size(s:30)))
            is_NK.image = UIImage(named: "icNhapKhau")
            is_NK.frame.origin.x = self.frame.size.width/8-5
          addSubview(is_NK)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

