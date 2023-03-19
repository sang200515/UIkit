//
//  ListFeatureView.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/16/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

enum ListFeatureMyInfo: Int, CaseCountable{
    case todaySaleTarget
    case news
    case detailRewards
    case workHour
    case getToken
}

protocol ListFeatureViewDelegate: AnyObject {
    func gotoScreen(_ listFeatureScreen: ListFeatureView, type: ListFeatureMyInfo)
}

class ListFeatureView: BaseView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let minimumLineSpacing: CGFloat = 0
    let minimumInternSpacing: CGFloat = 0
    let heightItem: CGFloat = 80
    weak var listFeatureViewDelegate: ListFeatureViewDelegate?
    
    override func setupViews() {
        super.setupViews()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ListFeatureCollectionViewCell.self, forCellWithReuseIdentifier: ListFeatureCollectionViewCell.identifier)
        self.addSubview(collectionView)
        collectionView.myCustomAnchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

extension ListFeatureView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ListFeatureMyInfo.caseCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListFeatureCollectionViewCell.identifier, for: indexPath) as! ListFeatureCollectionViewCell
        
        let listFeature = ListFeatureMyInfo(rawValue: indexPath.row)
        switch listFeature {
        case .todaySaleTarget:
            cell.setupListFeatureCollectionViewCell(image: #imageLiteral(resourceName: "ic_target_sale_today"), content: "Hôm nay bán gì")
        case .news:
            cell.setupListFeatureCollectionViewCell(image: #imageLiteral(resourceName: "ic_news"), content: "Tin tức")
        case .detailRewards:
            cell.setupListFeatureCollectionViewCell(image: UIImage.init(named: "ic_detail_gift"), content: "Chi tiết thưởng")
        case .workHour:
            cell.setupListFeatureCollectionViewCell(image: UIImage.init(named: "ic_work_hour"), content: "Giờ công")
        case .getToken:
            cell.setupListFeatureCollectionViewCell(image: UIImage.init(named: "ic_get_token"), content: "Lấy mã xác thực")
        default:
            break
        }
        return cell
    }
}

extension ListFeatureView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let listFeature = ListFeatureMyInfo(rawValue: indexPath.item) else {return}
        if let cb = self.listFeatureViewDelegate?.gotoScreen {
            cb(self, listFeature)
        }
    }
    
}

extension ListFeatureView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let width = (bounds.width - minimumInternSpacing) / 3
        
        return CGSize(width: width, height: heightItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInternSpacing
    }
}
