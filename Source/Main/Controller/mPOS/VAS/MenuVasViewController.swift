//
//  MenuVasViewController.swift
//  fptshop
//
//  Created by Ngoc Bao on 09/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class MenuVasViewController: UIViewController {
    
    // MARK: - Properties
    private var btnSimThuong: UIImageView!
    private var btnEsim: UIImageView!
    private var items = [ItemApp]()
    
    private var collectionView: UICollectionView!
    
    private var cellWidth: CGFloat = 0
    private var coCellWidth: CGFloat = 0
    private var coCellHeight: CGFloat = 0
    // MARK: - Lifecycle
    override func viewDidLoad() {
        self.title = "BÁN GÓI CƯỚC KH ĐÃ CÓ SIM"
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
        

        let crmItem3 = ItemApp(id: "103", name: "Đăng ký gói cước", type: "1", icon: #imageLiteral(resourceName: "Viettel"))
        items.append(crmItem3)
        let crmItem2 = ItemApp(id: "102", name: "Lịch sử", type: "2", icon: #imageLiteral(resourceName: "UpdateTargetPDMenu"))
        items.append(crmItem2)
        
        collectionView.reloadData()
    }
    
}
    // MARK: - UICollectionViewDelegateFlowLayout
extension MenuVasViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let item = items[indexPath.row]
        if item.type == "1" {
            ProgressView.shared.show()
                CRMAPIManager.ViettelVAS_GetMainInfo { (rs, totalCount, err) in
                    ProgressView.shared.hide()
                        if err.count <= 0 {
                            if rs.count > 0 {
                                let controller = RegisterViettelVASViewController()
                                controller.listProductViettelVAS_MainInfo = rs[0].products
                                self.navigationController?.pushViewController(controller, animated: true)
                            } else {
                                let alert = UIAlertController(title: "Thông báo", message: "Lấy dữ liệu Viettal VAS thất bại!", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            }
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                }
        } else if(item.type == "2"){
            let controller = HistoryViettelVASViewController()
            navigationController?.pushViewController(controller, animated: true)
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
}
