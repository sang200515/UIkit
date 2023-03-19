//
//  MenuTraGopView.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 21/10/2022.
//

import UIKit

class MenuTraGopView : UIView {
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = Common.Colors.CamKet.background
        collectionView.register(MenuCoreICTCollectionViewCell.self, forCellWithReuseIdentifier: "MenuCoreICTCollectionViewCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
