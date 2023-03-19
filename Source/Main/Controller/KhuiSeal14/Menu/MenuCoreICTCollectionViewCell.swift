//
//  MenuCoreICTCollectionViewCell.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 20/10/2022.
//

import UIKit

class MenuCoreICTCollectionViewCell : UICollectionViewCell {
    
    var model:MenuCoreModel? {
        didSet {
            self.bind()
        }
    }
    
    let iconImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .center
        return img
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(self.iconImageView)
        self.addSubview(self.titleLabel)
        
        self.layer.cornerRadius = 5
        
        self.iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
            make.height.width.equalTo(50)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.iconImageView.snp.bottom).offset(-20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(){
        self.iconImageView.image = self.model?.icon
        self.titleLabel.text = self.model?.title
    }
}
