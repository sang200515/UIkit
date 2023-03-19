//
//  ShinhanMenuVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 02/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit 

import Foundation
import UIKit
class ShinhanMenuVC: UIViewController {
    
    // MARK: - Properties
    private var items = [ItemApp]()
    
    private var collectionView: UICollectionView!
    
    private var cellWidth: CGFloat = 0
    private var coCellWidth: CGFloat = 0
    private var coCellHeight: CGFloat = 0
    // MARK: - Lifecycle
    override func viewDidLoad() {
        ShinhanData.IS_RUNNING = true
        self.title = "SHINHAN"
        self.navigationItem.setHidesBackButton(true, animated:true)
        configureNavigationItem()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func handleBack(){
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Helpers
    
    func configureNavigationItem(){
        //left menu icon
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
    }
    func configureUI(){
        view.backgroundColor = .white
        cellWidth = self.view.frame.size.width
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
        
        collectionView.register(ItemMiraeCollectionViewCell.self, forCellWithReuseIdentifier: "ItemMiraeCollectionViewCell")
        self.view.addSubview(collectionView)
        

        let crmItem3 = ItemApp(id: "103", name: "Tạo hồ sơ", type: "1", icon: #imageLiteral(resourceName: "shinhan_create"))
        items.append(crmItem3)
        let crmItem2 = ItemApp(id: "102", name: "Xem lịch sử mua hàng", type: "2", icon: #imageLiteral(resourceName: "shinhan_history"))
        items.append(crmItem2)
        
        collectionView.reloadData()
    }
    
}
    // MARK: - UICollectionViewDelegateFlowLayout
extension ShinhanMenuVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let coCell: ItemMiraeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemMiraeCollectionViewCell", for: indexPath) as! ItemMiraeCollectionViewCell
        
        let item = items[indexPath.item]
        coCell.setUpCollectionViewCell(item: item)
        coCell.layer.borderWidth = 0.5
        coCell.layer.borderColor = UIColor(netHex: 0xEEEEEE).cgColor
        return coCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ShinhanData.resetShinhanData()
        ShinhanData.IS_RUNNING = true
        let item = items[indexPath.row]
        if item.type == "1" {
            
            let popup = CmndTypePopUp()
            popup.modalPresentationStyle = .overCurrentContext
            popup.modalTransitionStyle = .crossDissolve
            popup.onNext = {
                let vc = ShinhanCaptureCmndVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            self.present(popup, animated: true, completion: nil)
        } else if(item.type == "2"){
            let vc = ShinhanHistoryVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        coCellWidth = cellWidth/3.0
        coCellHeight = coCellWidth * 0.8
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
}
