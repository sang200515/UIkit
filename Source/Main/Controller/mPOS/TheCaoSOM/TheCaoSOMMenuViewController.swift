//
//  TheCaoSOMMenuViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class TheCaoSOMMenuViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var cellWidth: CGFloat = 0
    var coCellWidth: CGFloat = 0
    var coCellHeight: CGFloat = 0
    var collectionViewHeightConstraint = NSLayoutConstraint()
    var btnBack: UIBarButtonItem!
    private var items = [ItemApp]()
    private let categories = [(name: "Thẻ nạp", image: "thenap"), (name: "Bắn tiền-Bán gói cước", image: "bantien")]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        loadData()
    }
    
    private func setupUI() {
        title = "Nạp Thẻ - Bắn Tiền"
        view.backgroundColor = UIColor.white
        navigationItem.hidesBackButton = true
        addBackButton()
        
        cellWidth = self.view.frame.width
        let crmItem3 = ItemApp(id: "103", name: "Thẻ nạp", type: "1", icon: #imageLiteral(resourceName: "thenap"))
        items.append(crmItem3)
        let crmItem2 = ItemApp(id: "102", name: "Bắn tiền-Bán gói cước", type: "2", icon: #imageLiteral(resourceName: "bantien"),rightIcon: UIImage(named: "icon_new"))
        items.append(crmItem2)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
        layout.itemSize = CGSize(width: 111, height: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - UIApplication.shared.statusBarFrame.height - (self.navigationController?.navigationBar.frame.height ?? 0)), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        
        collectionView.register(ItemSessionCollectionViewCell.self, forCellWithReuseIdentifier: "ItemSessionCollectionViewCell")
        self.view.addSubview(collectionView)
    }
    
    private func loadData() {
        ProgressView.shared.show()
        Provider.shared.thecaoSOMAPIService.getProviders(success: { result in
            ProgressView.shared.hide()
            guard let data = result else { return }
            TheCaoSOMDataManager.shared.providers = data
        }, failure: { [weak self] error in
            ProgressView.shared.hide()
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
}

extension TheCaoSOMMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let coCell: ItemSessionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemSessionCollectionViewCell", for: indexPath) as! ItemSessionCollectionViewCell
        let item = items[indexPath.row]
        coCell.setUpCollectionViewCell(item: item)
        
        coCell.layer.borderWidth = 0.5
        coCell.layer.borderColor = UIColor(netHex: 0xEEEEEE).cgColor
        return coCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        if item.name == "Thẻ nạp" {
            let vc = TheNapSOMViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if item.name == "Bắn tiền-Bán gói cước" {
            let vc = BanTienSOMViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        coCellWidth = cellWidth/3.0
        coCellHeight = (coCellWidth * 0.7)/2 + Common.Size(s: 40)
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
