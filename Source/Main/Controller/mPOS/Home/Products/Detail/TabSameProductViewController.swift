//
//  TabSameProductViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Foundation
import PopupDialog
private let reuseIdentifier = "ProductSameCollectionCell"
class TabSameProductViewController: UIViewController{
    
    // MARK: - Properties
    
    var segment: [Product] = []
    private var collectionView: UICollectionView!
    var product: ProductBySku!
    private var fromPagination = 0
    // MARK: - Lifecycle
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if (self.product != nil) {
            Cache.product = self.product
        }
        //notification center
        let nc = NotificationCenter.default
        
        nc.addObserver(self, selector: #selector(compareProductNotification), name: Notification.Name("updateCompare"), object: nil)
        nc.post(name: Notification.Name("dismissLoading"), object: nil)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("updateCompare"), object: nil);
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "Cùng giá"
        product = Cache.product
      

        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("dismissLoading"), object: nil)
   
        
 
        let lstDict:[Any] = ParamPriceFilter.convertParams(sortPriceFrom: product.product.price,sortPriceTo: product.product.price + 3000000)
        let lstDictPagination:[Any] = ParamPaginationFilter.convertParams(from: fromPagination,size: 40)
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            ProductAPIManager.product_filter(u_ng_code:"01",item_group_code:"",sort_point:"1",price:lstDict[0],firm_code:"", pagination: lstDictPagination[0],handler: { [weak self](results, err)  in
                guard let self = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if (results.count <= 0){
                            let productNotFound = "Không tìm thấy sản phẩm!"
                            let lbNotFound = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height/2 + Common.Size(s:22)/2, width: UIScreen.main.bounds.size.width, height: Common.Size(s:22)))
                            lbNotFound.textAlignment = .center
                            lbNotFound.textColor = UIColor.lightGray
                            lbNotFound.font = UIFont.systemFont(ofSize: Common.Size(s:15))
                            lbNotFound.text = productNotFound
                            self.view.addSubview(lbNotFound)
                        }else{
                            Cache.segment = results
                            self.segment = Cache.segment
                            // Do any additional setup after loading the view, typically from a nib.
                            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                            layout.scrollDirection = UICollectionView.ScrollDirection.vertical
                            layout.sectionInset = UIEdgeInsets(top: Common.Size(s:10), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
                            
                            layout.itemSize = CGSize(width: (self.view.frame.size.width - Common.Size(s:10))/2, height: (self.view.frame.size.width - Common.Size(s:10))/2 * 1.45)
                            layout.minimumInteritemSpacing = 0;
                            layout.minimumLineSpacing = Common.Size(s:5)/2
                            
                            self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - UIApplication.shared.statusBarFrame.height - ((self.navigationController?.navigationBar.frame.size.height)!)), collectionViewLayout: layout)
                            self.collectionView.dataSource = self
                            self.collectionView.delegate = self
                            self.collectionView.showsHorizontalScrollIndicator = false
                            self.collectionView.register(ProductSameCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
                            self.collectionView.backgroundColor = UIColor.white
                            self.view.addSubview(self.collectionView)
                        }
                        
                        
                    } else {
                        let popup = PopupDialog(title: "THÔNG BÁO", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            _ = self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            })
            
        }
    }
    
    // MARK: - Selectors
 
    @objc func compareProductNotification(notification:Notification) -> Void {
        _ = self.tabBarController?.selectedIndex = 2
    }

    
}
    // MARK: - UICollectionViewDataSource

extension TabSameProductViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segment.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductSameCollectionCell
        let item:Product = segment[indexPath.row]
        cell.setup(item: item,pos:indexPath.row)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item:Product = segment[indexPath.row]
        Cache.sku = item.sku
        let newViewController = DetailProductViewController()
//        newViewController.product = item
        newViewController.isCompare = true
        self.navigationController?.pushViewController(newViewController, animated: true)
        print("You selected cell #\(item.name)")
    }
}

    // MARK: - ProductSameCollectionCell
class ProductSameCollectionCell: UICollectionViewCell {
    var iconImage:UIImageView!
    var title:UILabel!
    var price:UILabel!
    var compare:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setup(item:Product,pos:Int){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: self.frame.size.width, height:  self.frame.size.width - Common.Size(s:20)))
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        
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
        title.textColor = UIColor.black
        title.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        title.text = item.name
        title.numberOfLines = 2
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
        
        compare = UILabel(frame: CGRect(x: Common.Size(s:5), y: price.frame.size.height + price.frame.origin.y + Common.Size(s:5), width: self.frame.size.width - Common.Size(s:10), height: Common.Size(s:28)))
        compare.textAlignment = .center
        compare.textColor = UIColor.white
        compare.backgroundColor = UIColor(netHex: 0x04AB6E)
        compare.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        compare.text = "So sánh"
        compare.layer.cornerRadius = 6
        compare.clipsToBounds = true
        compare.numberOfLines = 1
        addSubview(compare)
        compare.tag = pos
        let tapPlus = UITapGestureRecognizer(target: self, action: #selector(compareAction(tapGestureRecognizer:)))
        compare.isUserInteractionEnabled = true
        compare.addGestureRecognizer(tapPlus)
        
    }
    
    @objc func compareAction(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UILabel
        let pos: Int = tappedImage.tag
        Cache.compareProduct = Cache.segment[pos]
      
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("updateCompare"), object: nil)
        
        nc.post(name: Notification.Name("dismissLoading"), object: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

