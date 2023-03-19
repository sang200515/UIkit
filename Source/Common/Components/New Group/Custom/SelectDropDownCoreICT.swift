//
//  SelectDropDownCoreICT.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 17/10/2022.
//

import UIKit

class SelectDropDownCoreICT : UIView {
    
    let dropIcon:UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.image = UIImage(named: "dropDownCore")
        return image
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Tất cả"
        label.font = .systemFont(ofSize: 15)
        label.textColor = Common.Colors.CamKet.green
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = Common.Colors.CamKet.green.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.backgroundColor = .white
        self.addSubview(self.dropIcon)
        self.addSubview(self.titleLabel)
        
        self.dropIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(25)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(self.dropIcon.snp.leading).offset(-5)
            make.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
