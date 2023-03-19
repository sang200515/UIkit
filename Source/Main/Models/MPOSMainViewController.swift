//
//  MPOSMainViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/28/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import MIBadgeButton_Swift
import AVFoundation
class MPOSMainViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,SearchDelegate {
    
    var collectionview: UICollectionView!
    var items: [ItemApp] = []
    var btCartIcon:MIBadgeButton!
    var CMND:String = ""
    var valueScreen: Int = 0 // 1: FF
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let width = UIScreen.main.bounds.size.width
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "home"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(MPOSMainViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        let searchField = UITextField(frame: CGRect(x: 30, y: 20, width: width, height: 35))
        searchField.placeholder = "Bạn cần tìm sản phẩm?"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 5
        
        searchField.leftViewMode = .always
        let searchImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let searchImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        let search = UIImage(named: "search", in: Bundle(for: YNSearch.self), compatibleWith: nil)
        searchImageView.image = search
        searchImageViewWrapper.addSubview(searchImageView)
        searchField.leftView = searchImageViewWrapper
        
        searchField.rightViewMode = .always
        let searchImageRight = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        let searchImageViewRight = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let scan = UIImage(named: "scan_barcode")
        searchImageViewRight.image = scan
        searchImageRight.addSubview(searchImageViewRight)
        searchField.rightView = searchImageRight
        let gestureSearchImageRight = UITapGestureRecognizer(target: self, action:  #selector(self.actionScan))
        searchImageRight.addGestureRecognizer(gestureSearchImageRight)
        self.navigationItem.titleView = searchField
             searchField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
//        searchField.isUserInteractionEnabled = false
        //---
        //---
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: viewRightNav)
        btCartIcon = MIBadgeButton.init(type: .custom)
        btCartIcon.setImage(#imageLiteral(resourceName: "cart"), for: UIControl.State.normal)
        btCartIcon.imageView?.contentMode = .scaleAspectFit
        btCartIcon.addTarget(self, action: #selector(MPOSMainViewController.actionCart), for: UIControl.Event.touchUpInside)
        btCartIcon.frame = CGRect(x: -5, y: 0, width: 50, height: 45)
        viewRightNav.addSubview(btCartIcon)
        //---
        
        
        let height = UIScreen.main.bounds.size.height
        
        let item1 = ItemApp(id: "1", name: "Sản phẩm", type: "1", icon: #imageLiteral(resourceName: "sanpham"))
        let item2 = ItemApp(id: "2", name: "Đơn hàng", type: "2", icon: #imageLiteral(resourceName: "donhang"))
        let item3 = ItemApp(id: "3", name: "SP Đổi trả", type: "3", icon: #imageLiteral(resourceName: "doitra"))
        let item4 = ItemApp(id: "4", name: "F.Friends", type: "4", icon: #imageLiteral(resourceName: "ffriends"))
        
        let item5 = ItemApp(id: "5", name: "DS Đặt cọc", type: "5", icon: #imageLiteral(resourceName: "datcoc"))
        let item6 = ItemApp(id: "6", name: "CRM", type: "6", icon: #imageLiteral(resourceName: "crm"))
        let item7 = ItemApp(id: "7", name: "Tra cứu KH", type: "7", icon: #imageLiteral(resourceName: "tracuukh"))
        let item8 = ItemApp(id: "8", name: "Bảo hành", type: "8", icon: #imageLiteral(resourceName: "baohanh"))
        
        let item9 = ItemApp(id: "9", name: "KT FNOX", type: "9", icon: #imageLiteral(resourceName: "fnox"))
        let item10 = ItemApp(id: "10", name: "Thông báo", type: "10", icon: #imageLiteral(resourceName: "noti"))
        let item11 = ItemApp(id: "11", name: "TV Subsidy", type: "11", icon: #imageLiteral(resourceName: "tuvansubsidy"))
        let item12 = ItemApp(id: "12", name: "Chọn số", type: "12", icon: #imageLiteral(resourceName: "chonso"))
        
        let item13 = ItemApp(id: "13", name: "Cài đặt VNG", type: "13", icon: #imageLiteral(resourceName: "caidatvng"))
        let item14 = ItemApp(id: "14", name: "BC Bán hàng", type: "14", icon: #imageLiteral(resourceName: "baocao"))
          let item15 = ItemApp(id: "15", name: "Nhập hàng", type: "15", icon: #imageLiteral(resourceName: "NhapHang"))
        
        items.append(item1)
        items.append(item2)
        items.append(item3)
        items.append(item4)
        items.append(item5)
        items.append(item6)
        items.append(item7)
        items.append(item8)
        items.append(item9)
        items.append(item10)
        items.append(item11)
        items.append(item12)
        items.append(item13)
        items.append(item14)
        items.append(item15)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:5), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        layout.itemSize = CGSize(width: (self.view.frame.size.width - Common.Size(s:20))/4, height: (self.view.frame.size.width - Common.Size(s:20))/4)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = Common.Size(s:5)
        
        collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: height), collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(ItemAppHomeCell.self, forCellWithReuseIdentifier: "ItemAppHomeCell")
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.white
        self.view.addSubview(collectionview)
        
        if(valueScreen == 1){
            let newViewController = FFriendViewController()
            newViewController.CMND = CMND
            newViewController.autoLoadCMND = 1
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
    }
 
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        Cache.searchOld = false
        textField.endEditing(true)
        let newViewController = SearchViewController()
        newViewController.delegateSearchView = self
        self.navigationController?.pushViewController(newViewController, animated: false)
    }
    
    @objc func actionCart() {
        let newViewController = CartViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func actionScan() {
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            self.actionSearchProduct(sku: code)
        }
        self.present(viewController, animated: false, completion: nil)
    }
    func pushView(_ product: Product) {
        Cache.sku = product.sku
        let newViewController = DetailProductViewController()
        newViewController.product = product
        newViewController.isCompare = false
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func pushViewOld(_ product: ProductOld) {
        let newViewController = DetailOldProductViewController()
        newViewController.product = product
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func searchScanSuccess(text: String) {
         actionSearchProduct(sku: text)
    }
    
    func searchActionCart() {
        let newViewController = CartViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func actionSearch() {
        let newViewController = SearchViewController()
        self.navigationController?.pushViewController(newViewController, animated: false)
    }
    func actionSearchProduct(sku:String) {
        let newViewController = LoadingViewController()
//        newViewController.content = "Đang tìm mã \(sku)"
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        //
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            //             nc.post(name: Notification.Name("dismissLoading"), object: nil)
            ProductAPIManager.searchProduct(keyword: sku,handler: { (success , error) in
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    if(success.count > 0){
                        Cache.sku = sku
                        Cache.model_id = success[0].model_id
                        let newViewController = DetailProductViewController()
                        newViewController.isCompare = false
                        self.navigationController?.pushViewController(newViewController, animated: true)
                        
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: error, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                    
                }
            })
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "ItemAppHomeCell", for: indexPath) as! ItemAppHomeCell
        let item: ItemApp = self.items[indexPath.row]
        cell.setup(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item: ItemApp = self.items[indexPath.row]
        self.title = ""
        if(item.id == "1"){
            let newViewController = ProductBonusScopeViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        } else if(item.id == "2"){
            let newViewController = OrdersViewController()
            newViewController.modalPresentationStyle = .overFullScreen
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else if(item.id == "3"){
            let newViewController = ProductOldViewController()
            
            newViewController.parentNavigationController = self.navigationController
           
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else if(item.id == "4"){
            let newViewController = FFriendViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else if(item.id == "6"){
            let newViewController = CRMViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else if(item.id == "15"){
            let newViewController = NhapHangViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let sum = Cache.carts.count
        if(sum > 0){
            btCartIcon.badgeString = "\(sum)"
            btCartIcon.badgeTextColor = UIColor.white
            btCartIcon.badgeEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 0, right: 12)
        }else{
            btCartIcon.badgeString = ""
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        //        self.title = ""
    }
}

class ItemAppHomeCell: UICollectionViewCell {
    var iconImage:UIImageView!
    var name: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func setup(item:ItemApp){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: self.frame.size.width/4, y:  self.frame.size.width/6, width: self.frame.size.width/2, height:  self.frame.size.width/2))
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        iconImage.image = item.icon
        
        name = UILabel(frame: CGRect(x: 0, y:  iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s: 7), width: self.frame.size.width, height:  Common.Size(s:30)))
        name.textColor = UIColor.black
        name.numberOfLines = 2
        name.textAlignment = .center
        name.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        addSubview(name)
        name.text = "\(item.name)"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

