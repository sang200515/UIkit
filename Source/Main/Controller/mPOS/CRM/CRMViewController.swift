//
//  CRMViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class CRMViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var collectionview: UICollectionView!
    var items: [ItemApp] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "CRM"
        self.initNavigationBar()
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let item1 = ItemApp(id: "1", name: "Thẻ cào", type: "1", icon: #imageLiteral(resourceName: "TheCao"))
        let item2 = ItemApp(id: "2", name: "Book SIM", type: "2", icon: #imageLiteral(resourceName: "BookSim"))
        let item3 = ItemApp(id: "3", name: "Thu hộ", type: "3", icon: #imageLiteral(resourceName: "ThuHo"))
        let item4 = ItemApp(id: "4", name: "Cập nhật thuê bao", type: "4", icon: #imageLiteral(resourceName: "CapNhatThueBao"))
        
        let item5 = ItemApp(id: "5", name: "Chuyển 4G", type: "5", icon: #imageLiteral(resourceName: "Chuyen4G"))
        let item6 = ItemApp(id: "6", name: "Bảo hiểm", type: "6", icon: #imageLiteral(resourceName: "BaoHiem"))
        let item7 = ItemApp(id: "7", name: "Thu hộ LC", type: "7", icon: #imageLiteral(resourceName: "ThuHoLC"))
        //        let item8 = ItemApp(id: "8", name: "Book SIM", type: "8", icon: #imageLiteral(resourceName: "BookSim"))
        let item8 = ItemApp(id: "8", name: "LS kích hoạt", type: "9", icon: #imageLiteral(resourceName: "LSKichHoat"))
        let item9 = ItemApp(id: "9", name: "Gia hạn SSD", type: "10", icon: #imageLiteral(resourceName: "GiaHanSSD"))
        
        items.append(item1)
        items.append(item2)
        items.append(item3)
        items.append(item4)
        items.append(item5)
        items.append(item6)
        items.append(item7)
        items.append(item8)
        items.append(item9)
        //        items.append(item10)
        
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
        if(item.id == "2"){
            let newViewController = ChooseTelecomBookSimV3ViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else if(item.id == "4"){
            let newViewController = InputOTPVNMViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else if(item.id == "5"){
            let newViewController = CheckInfoConvert4GViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else if(item.id == "6"){
            let newViewController = BaoHiemMainViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else if(item.id == "7"){
            let newViewController = ThuHoLongChauViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else if(item.id == "8"){
            let newViewController = LichSuKichHoatV2ViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else if(item.id == "9"){
            let newViewController = GiaHanSSDViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
}
