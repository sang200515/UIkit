//
//  ReplacementAccessoriesViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 14/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ReplacementAccessoriesViewController: UIViewController {

    var collectionView: UICollectionView!
    
    var sku: String = ""
    private var replacementAccessories: [Variant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        loadData()
    }
    
    private func setupUI() {
        title = "Phụ kiện bán kèm"
        addBackButton()
    }
    
    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:10), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - Common.Size(s:10))/2, height: (UIScreen.main.bounds.width - Common.Size(s:10))/2 * 1.4)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = Common.Size(s:5)/2

        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view.frame.size.height - UIApplication.shared.statusBarFrame.height), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductBonusCollectionCell.self, forCellWithReuseIdentifier: "ProductBonusCollectionCell")
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
    }
    
    private func loadData() {
        Provider.shared.replacementAccessoriesAPIService.getReplacementAccessories(sku: sku, success: { [weak self] (result, label) in
            guard let self = self else { return }
            self.replacementAccessories = result.variants
            self.collectionView.reloadData()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
}

extension ReplacementAccessoriesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return replacementAccessories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductBonusCollectionCell", for: indexPath) as! ProductBonusCollectionCell
        let item: Variant = replacementAccessories[indexPath.row]
        cell.setupVariant(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item: Variant = replacementAccessories[indexPath.row]
        Cache.sku = item.sku
        Cache.model_id = item.model_id
        
        let newViewController = DetailProductViewController()
//        newViewController.product = item
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
