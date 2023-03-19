//
//  ListFeatureBackToSchoolView.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/19/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

enum ListFeatureBackToSchool: Int, CaseCountable{
    case studentsFPT
    case students
    case directOffer
    case searchStudents
	case polytechnic
}

protocol ListFeatureBackToSchoolDelegate: AnyObject {
    func gotoScreen(_ listFeatureScreen: ListFeatureBackToSchoolView, type: ListFeatureBackToSchool)
}

class ListFeatureBackToSchoolView: BaseView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let minimumLineSpacing: CGFloat = 0
    let minimumInternSpacing: CGFloat = 0
    let heightItem: CGFloat = 85
    var showFull = false
    var isFromSearch = false
    weak var listFeatureBackToSchoolViewDelegate: ListFeatureBackToSchoolDelegate?
    
    override func setupViews() {
        super.setupViews()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ListFeatureBackToSchoolCell.self, forCellWithReuseIdentifier: ListFeatureBackToSchoolCell.identifier)
        self.addSubview(collectionView)
        collectionView.myCustomAnchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

extension ListFeatureBackToSchoolView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if showFull {
            return isFromSearch ? 2 :  3
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListFeatureBackToSchoolCell.identifier, for: indexPath) as! ListFeatureBackToSchoolCell
        
        if !showFull {
            cell.setupListFeatureCollectionViewCell(image: UIImage.init(named: "ic_lichsu_student"), content: "Lịch sử")
            return cell
        }
        if isFromSearch {
            if indexPath.row == 0 {
                cell.setupListFeatureCollectionViewCell(image: UIImage.init(named: "studentFPT"), content: "Chương trình dành cho HS/SV")
			}else if indexPath.row == 1{
				cell.setupListFeatureCollectionViewCell(image: UIImage.init(named: "bts_logo"), content: "Ưu đãi sinh viên FPT Polytechnic")
			}
        } else {
            if indexPath.row == 0 {
                cell.setupListFeatureCollectionViewCell(image: UIImage.init(named: "studentFPT"), content: "Chương trình dành cho HS/SV")
            }else if indexPath.row == 1{
                cell.setupListFeatureCollectionViewCell(image: UIImage.init(named: "ic_lichsu_student"), content: "Lịch sử")
			}else if indexPath.row == 2{
				cell.setupListFeatureCollectionViewCell(image: UIImage.init(named: "bts_logo"), content: "Ưu đãi sinh viên FPT Polytechnic")
			}
        }
        
        return cell
    }
}

extension ListFeatureBackToSchoolView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !showFull {
            let feature = ListFeatureBackToSchool(rawValue: 3)
            if let cb = self.listFeatureBackToSchoolViewDelegate?.gotoScreen {
                cb(self, feature!)
            }
        }else if isFromSearch {
            if indexPath.row == 0 {
                guard let feature = ListFeatureBackToSchool(rawValue: 0) else { return }
                if let cb = self.listFeatureBackToSchoolViewDelegate?.gotoScreen {
                    cb(self, feature)
                }
			}else  if indexPath.row == 1 {
				guard let feature = ListFeatureBackToSchool(rawValue: 4) else { return }
				if let cb = self.listFeatureBackToSchoolViewDelegate?.gotoScreen {
					cb(self, feature)
				}
			}
        } else {
             if indexPath.row == 0 {
                guard let feature = ListFeatureBackToSchool(rawValue: 0) else { return }
                if let cb = self.listFeatureBackToSchoolViewDelegate?.gotoScreen {
                    cb(self, feature)
                }
             }else  if indexPath.row == 1 {
                 guard let feature = ListFeatureBackToSchool(rawValue: 3) else { return }
                 if let cb = self.listFeatureBackToSchoolViewDelegate?.gotoScreen {
                     cb(self, feature)
                 }
			 }else  if indexPath.row == 2 {
				 guard let feature = ListFeatureBackToSchool(rawValue: 4) else { return }
				 if let cb = self.listFeatureBackToSchoolViewDelegate?.gotoScreen {
					 cb(self, feature)
				 }
			 }
        }
    }
    
}

extension ListFeatureBackToSchoolView: UICollectionViewDelegateFlowLayout {
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

