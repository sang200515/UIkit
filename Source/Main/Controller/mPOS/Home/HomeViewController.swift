//
//  HomeViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/28/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class HomeViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var collectionview: UICollectionView!
    var items: [ItemApp] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Trang chủ"
        self.initNavigationBar()
        let width = UIScreen.main.bounds.size.width
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
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "mPOS"
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
    }
}
