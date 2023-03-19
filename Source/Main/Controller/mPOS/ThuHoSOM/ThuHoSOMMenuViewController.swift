//
//  ThuHoSOMMenuViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 31/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ThuHoSOMMenuViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var cellWidth: CGFloat = 0
    var coCellWidth: CGFloat = 0
    var coCellHeight: CGFloat = 0
    var collectionViewHeightConstraint = NSLayoutConstraint()
    var btnBack: UIBarButtonItem!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        loadData()
    }
    
    private func setupUI() {
        title = "Thu Hộ"
        view.backgroundColor = UIColor.white
        navigationItem.hidesBackButton = true
        addBackButton()
        
        cellWidth = self.view.frame.width
    }
    
    func loadData() {
        ProgressView.shared.show()
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Provider.shared.thuhoSOMAPIService.getCategories(isEnable: true, parentId: "9d47824c-b08c-4327-a187-979a8cb8eb5c", shopCode: Cache.user!.ShopCode, isDetail: true, sort: "orderno", success: { result in
            guard let data = result else { return }
            ThuHoSOMDataManager.shared.catagories = data
            ThuHoSOMDataManager.shared.catagories.items = ThuHoSOMDataManager.shared.catagories.items.filter { $0.id != "8e81719d-34db-48b9-9ace-6c0fee968f17" }
            dispatchGroup.leave()
        }, failure: {[weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        Provider.shared.thuhoSOMAPIService.getProviders(success: { result in
            guard let data = result else { return }
            ThuHoSOMDataManager.shared.providers = data
            dispatchGroup.leave()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main) {
            ProgressView.shared.hide()
            self.collectionView.reloadData()
        }
    }
    
    func setupCollectionView() {
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
}

extension ThuHoSOMMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ThuHoSOMDataManager.shared.catagories.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let coCell: ItemSessionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemSessionCollectionViewCell", for: indexPath) as! ItemSessionCollectionViewCell
        let item = ThuHoSOMDataManager.shared.catagories.items[indexPath.row]
        coCell.setupCollectionViewCellThuHoSOM(item: item)
        
        coCell.layer.borderWidth = 0.5
        coCell.layer.borderColor = UIColor(netHex: 0xEEEEEE).cgColor
        return coCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = ThuHoSOMDataManager.shared.catagories.items[indexPath.row]
        if item.id == "a6123000-0cb9-4f6e-a36f-7efa3d5a69cb" {
            ThuHoSOMDataManager.shared.selectedCatagory = item
            let vc = ThuHoEbayVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if item.extraProperties.isHideProduct != "true" {
             if ThuHoSOMDataManager.shared.catagories.items[indexPath.row].id == "f949c618-ead3-4bc6-8b9d-c3611f058bc4" {
                showAlertOneButton(title: "Thông báo", with: "Chức năng đang phát triển. Bạn vui lòng vào SOM thao tác trước nhé.", titleButton: "OK")
             }else{
                 ThuHoSOMDataManager.shared.selectedCatagory = item
                 let vc = ThuHoSOMSearchOrderViewController()
                 self.navigationController?.pushViewController(vc, animated: true)
             }

        }
            else {
            if item.id == "8e81719d-34db-48b9-9ace-6c0fee968f17" {
                ThuHoSOMDataManager.shared.selectedCatagory = item
                let vc = ThuHoSOMBikeInsuranceViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                showAlertOneButton(title: "Thông báo", with: "Chức năng đang phát triển. Bạn vui lòng vào SOM thao tác trước nhé.", titleButton: "OK")
            }
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
