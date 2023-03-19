//
//  SearchPKViewController.swift
//  fptshop
//
//  Created by tan on 5/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class SearchPKViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,UISearchBarDelegate{
    var barClose : UIBarButtonItem!
    
    var collectionView: UICollectionView!
    var items: [ComboPK_SearchSP] = []
    var filteredCandies = [ComboPK_SearchSP]()
    
    var ind:Int!
    var isSPChinh:String?
    var searchBarContainer:SearchBarContainerViewV3!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00579c)
        self.title = "Tìm Phụ Kiện"
        self.navigationController?.navigationBar.isTranslucent = true
        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(SearchPKViewController.actionClose), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        
        let searchBar = UISearchBar()
        searchBarContainer = SearchBarContainerViewV3(customSearchBar: searchBar)
        searchBarContainer.searchBar.showsCancelButton = true
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        
        
        
        if #available(iOS 11.0, *) {
            searchBarContainer.searchBar.placeholder = "Tìm kiếm theo tên / mã sản phẩm?"
        }else{
            searchBarContainer.searchBar.searchBarStyle = .minimal
            //             setTextFieldTintColor(to: UIColor(netHex:0x47B054), for: searchBarContainer.searchBar)
            
            let textFieldInsideSearchBar = searchBarContainer.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = .white
            
            let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            glassIconView?.tintColor = .white
            textFieldInsideSearchBar?.attributedPlaceholder = NSAttributedString(string: "Tìm kiếm theo tên / mã sản phẩm?",
                                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as? UIButton
            clearButton?.setImage(clearButton?.imageView?.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
            clearButton?.tintColor = .white
        }
        
        self.searchBarContainer.searchBar.text = ""
        navigationItem.titleView = searchBarContainer
        self.searchBarContainer.searchBar.alpha = 0
        navigationItem.setRightBarButtonItems(nil, animated: true)
        navigationItem.setLeftBarButtonItems(nil, animated: true)
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBarContainer.searchBar.alpha = 1
        }, completion: { finished in
            self.searchBarContainer.searchBar.becomeFirstResponder()
        })
        searchBar.delegate = self
        
        searchBarContainer.searchBar.endEditing(true)
        
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:10), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        // layout.itemSize = CGSize(width: self.view.frame.size.width , height: (self.view.frame.size.width - Common.Size(s:150)))
        
        layout.itemSize = CGSize(width: (self.view.frame.size.width - Common.Size(s:10))/2, height: (self.view.frame.size.width - Common.Size(s:10))/2 * 1.4)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = Common.Size(s:5)/2
        
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: Common.Size(s: 5), width: self.view.frame.size.width, height: self.view.frame.size.height - CGFloat((self.tabBarController?.tabBar.frame.size.height)!) - UIApplication.shared.statusBarFrame.height), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductAccessorieCell4.self, forCellWithReuseIdentifier: "ProductAccessorieCell4")
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        
        
        
        let currentTimeInMiliseconds = getCurrentMillis()
        let defaults = UserDefaults.standard
        let CacheTimeContact = defaults.integer(forKey: "CacheTimeSearchPK")
        if(CacheTimeContact > 0){
            if(currentTimeInMiliseconds - Int64(CacheTimeContact) < 86400000){ //1 day
                
            }else{
                let newViewController = LoadingViewController()
                newViewController.content = "Đang cập nhật danh sách phụ kiện..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    DBMangerComboPK.sharedInstance.deleteFromDb()
                    MPOSAPIManager.sp_mpos_FRT_SP_combopk_searchsp(keyword: "") { (results, err) in
                        if(results.count > 0){
                            debugPrint("COUNT \(results.count)")
                            DBMangerComboPK.sharedInstance.addListData(objects: results)
                            let currentTimeInMiliseconds2 = self.getCurrentMillis()
                            defaults.set(currentTimeInMiliseconds2, forKey: "CacheTimeSearchPK")
                            debugPrint("COUNT TIEM  \((currentTimeInMiliseconds2 - currentTimeInMiliseconds))")
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                
                            }
                        }
                      
                    }
                    
                }
            }
        }else{
            let newViewController = LoadingViewController()
            newViewController.content = "Đang cập nhật danh sách phụ kiện..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                DBMangerComboPK.sharedInstance.deleteFromDb()
                MPOSAPIManager.sp_mpos_FRT_SP_combopk_searchsp(keyword: "") { (results, err) in
                    if(results.count > 0){
                        debugPrint("COUNT \(results.count)")
                        DBMangerComboPK.sharedInstance.addListData(objects: results)
                        let currentTimeInMiliseconds2 = self.getCurrentMillis()
                        defaults.set(currentTimeInMiliseconds2, forKey: "CacheTimeSearchPK")
                        debugPrint("COUNT TIEM  \((currentTimeInMiliseconds2 - currentTimeInMiliseconds))")
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        }
                    }
                
                }
            }
        }
        
        
    }
    
    func getCurrentMillis()->Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        
        
        if(searchText.count > 0){
            let searchText =  searchText.folding(options: .diacriticInsensitive, locale: nil)
            
            items = DBMangerComboPK.sharedInstance.searchName(key: "\(searchText.uppercased())")
            collectionView.reloadData()
            
        }else{
            self.items = []
            //    TableViewHelper.EmptyMessage(message: "Bạn vui lòng nhập từ khoá để tra cứu.", viewController: self.tableView)
            collectionView.reloadData()
        }
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //        self.dismiss(animated: false, completion: nil)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text
        
        
        if(Int(text!) != nil){
            if(Int(text!)! >= 6){
                let comboPK:ComboPK_Search_TableView = ComboPK_Search_TableView(
                    Name:""
                    , Price:Int(text!)!
                    , Sku:""
                    , BonusScopeBoom:""
                    , Sl:0
                    , linkAnh:""
                    , isSPChinh:self.isSPChinh!
                    ,id:0
                    ,brandID: 0
                    , brandName: ""
                    , typeId: 0
                    , typeName: ""
                    , priceMarket: 0
                    , priceBeforeTax: 0
                    , iconUrl: ""
                    ,imageUrl: ""
                    , promotion: ""
                    , includeInfo: ""
                    , hightlightsDes: ""
                    , labelName: ""
                    , urlLabelPicture: "'"
                    , isRecurring: false
                    , manSerNum: ""
                    ,  qlSerial: ""
                    ,  LableProduct:"",
                    hotSticker: false
                    ,is_NK: false
                    ,is_ExtendedWar: false
                    ,skuBH: []
                    ,nameBH: []
                    ,brandGoiBH: []
                    , isPickGoiBH: ""
                    ,  amountGoiBH: ""
                    ,  itemCodeGoiBH: ""
                    , itemNameGoiBH: ""
                    ,priceSauKM: 0
                    , role2: []
                )
                Cache.comboPKSP = comboPK
                self.navigationController?.popViewController(animated: true)
            }
        }
            
    }
    @objc func actionClose(){
        //        self.dismiss(animated: false, completion: nil)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductAccessorieCell4", for: indexPath) as! ProductAccessorieCell4
        let item:ComboPK_SearchSP = self.items[indexPath.row]
        
        cell.setup(item: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item:ComboPK_SearchSP = self.items[indexPath.row]
        
        let comboPK:ComboPK_Search_TableView = ComboPK_Search_TableView(Name:item.Name
            , Price:item.Price
            , Sku: item.Sku
            , BonusScopeBoom: item.BonusScopeBoom
            , Sl: item.Sl
            , linkAnh: item.linkAnh
            , isSPChinh: self.isSPChinh!
            ,id: item.id
            ,brandID: item.brandID
            , brandName: item.brandName
            , typeId: item.typeId
            , typeName: item.typeName
            , priceMarket: item.priceMarket
            , priceBeforeTax: item.priceBeforeTax
            , iconUrl: item.linkAnh
            ,imageUrl: item.imageUrl
            , promotion: item.promotion
            , includeInfo: item.includeInfo
            , hightlightsDes: item.hightlightsDes
            , labelName: item.labelName
            , urlLabelPicture: item.urlLabelPicture
            , isRecurring: item.isRecurring
            , manSerNum: item.manSerNum
            ,  qlSerial: item.qlSerial
            ,  LableProduct: item.LableProduct
            ,hotSticker: item.hotSticker
            ,is_NK: item.is_NK
            ,is_ExtendedWar: item.is_ExtendedWar
            ,skuBH: item.skuBH
            ,nameBH: item.nameBH
           ,brandGoiBH: item.brandGoiBH
            ,isPickGoiBH: item.isPickGoiBH
             ,amountGoiBH: item.amountGoiBH
             ,itemCodeGoiBH: item.itemCodeGoiBH
             ,itemNameGoiBH: item.itemNameGoiBH
             ,priceSauKM: item.priceSauKM
             ,role2: item.role2
        )
        Cache.comboPKSP = comboPK
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    // MARK: - Private instance methods
    
    func filterContentForSearchText(_ searchText: String, scope: String = "Gía/Sản Phẩm") {
        if(searchText.count > 0){
            let searchText =  searchText.folding(options: .diacriticInsensitive, locale: nil)
            
            items = DBMangerComboPK.sharedInstance.searchName(key: "\(searchText.uppercased())")
            collectionView.reloadData()
            
            
        }else{
            self.items = DBMangerComboPK.sharedInstance.getAllDataFromDB()
            self.collectionView.reloadData()
        }
    }
    
    
    
    class SearchBarContainerViewV3: UIView {
        
        let searchBar: UISearchBar
        
        init(customSearchBar: UISearchBar) {
            searchBar = customSearchBar
            super.init(frame: CGRect.zero)
            
            addSubview(searchBar)
        }
        
        override convenience init(frame: CGRect) {
            self.init(customSearchBar: UISearchBar())
            self.frame = frame
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            searchBar.frame = bounds
        }
    }
    
}


class ProductAccessorieCell4: UICollectionViewCell {
    var iconImage:UIImageView!
    var title:UILabel!
    var price:UILabel!
    var diemthuong:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setup(item:ComboPK_SearchSP){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: self.frame.size.width, height:  self.frame.size.width - Common.Size(s:20)))
        //        iconImage.image = Image(named: "demo")
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        //iconImage.backgroundColor = .red
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = item.linkAnh.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
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
        
        let heightTitel = item.Name.height(withConstrainedWidth: self.frame.size.width - Common.Size(s:4), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
        
        title = UILabel(frame: CGRect(x: Common.Size(s:2), y: iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s:5), width: self.frame.size.width - Common.Size(s:4), height: heightTitel))
        title.textAlignment = .center
        title.textColor = UIColor.lightGray
        title.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        title.text = item.Name
        title.numberOfLines = 2
        title.sizeToFit()
        addSubview(title)
        
        diemthuong = UILabel(frame: CGRect(x: Common.Size(s:2), y: title.frame.size.height + title.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:14)))
        diemthuong.textAlignment = .center
        diemthuong.textColor =  UIColor(netHex:0x47B054)
        
        diemthuong.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        diemthuong.text = "\(item.BonusScopeBoom)(SL:\(item.Sl))"
        diemthuong.numberOfLines = 1
        addSubview(diemthuong)
        
        price = UILabel(frame: CGRect(x: Common.Size(s:2), y: diemthuong.frame.size.height + diemthuong.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:14)))
        price.textAlignment = .center
        price.textColor = UIColor(netHex:0xEF4A40)
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        price.text = Common.convertCurrencyV2(value: item.Price)
        price.numberOfLines = 1
        addSubview(price)
        
        
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

