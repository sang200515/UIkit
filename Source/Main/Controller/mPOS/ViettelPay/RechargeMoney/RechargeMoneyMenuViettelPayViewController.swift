//
//  RechargeMoneyMenuViettelPayViewController.swift
//  fptshop
//
//  Created by tan on 6/25/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class RechargeMoneyMenuViettelPayViewController:  UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var items = [ItemApp]()
    
    var collectionView: UICollectionView!
    
    var cellWidth: CGFloat = 0
    var coCellWidth: CGFloat = 0
    var coCellHeight: CGFloat = 0
    //SOM
    var itemViettelPaySOMInfo: ViettelPayNccInfo?
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.blue
        self.title = "Nạp Tiền"
        self.initNavigationBar()
        self.view.backgroundColor = .white
        cellWidth = self.view.frame.size.width
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(ViettelPayMenuViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
        layout.itemSize = CGSize(width: 111, height: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ItemViettelPayCollectionViewCell.self, forCellWithReuseIdentifier: "ItemViettelPayCollectionViewCell")
        self.view.addSubview(collectionView)
        
        //---DATA
        let crmItem1 = ItemApp(id: "101", name: "Tạo mới", type: "1", icon: #imageLiteral(resourceName: "taophieu"))
        items.append(crmItem1)
        let crmItem2 = ItemApp(id: "102", name: "Lịch sử giao dịch", type: "2", icon: #imageLiteral(resourceName: "ViettelPay-LichSu"))
        items.append(crmItem2)
      
        //---DATA
//        collectionView.reloadData()
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "") {
            CRMAPIManager.ViettelPay_SOM_GetMainInfo { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs != nil {
                            self.itemViettelPaySOMInfo = rs
                            self.collectionView.reloadData()
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Không có data ViettelPay SOM!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let coCell: ItemViettelPayCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemViettelPayCollectionViewCell", for: indexPath) as! ItemViettelPayCollectionViewCell
        
        let item = items[indexPath.item]
        coCell.setUpCollectionViewCell(item: item)
        coCell.layer.borderWidth = 0.5
        coCell.layer.borderColor = UIColor(netHex: 0xEEEEEE).cgColor
        return coCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        if(item.type == "1"){
            let vc = NapTienViettelPayViewControllerV2()
            vc.itemViettelPaySOMInfo = self.itemViettelPaySOMInfo
            self.navigationController?.pushViewController(vc, animated: true)
        }else if(item.type == "2"){
            let vc = LSViettelPaySOMViewControllerV2()
            let cateID = (self.itemViettelPaySOMInfo?.categoryIds.count ?? 0 > 0) ? (self.itemViettelPaySOMInfo?.categoryIds[0] ?? "") : ""
            vc.cateID = cateID
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        coCellWidth = cellWidth/3.0
        coCellHeight = coCellWidth * 0.7
        let size = CGSize(width: coCellWidth, height: coCellHeight)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    @objc func actionBack(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tapTranferMoney(_ sender:UITapGestureRecognizer){
        
    }
}

