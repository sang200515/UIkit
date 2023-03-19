//
//  SignatureCoreICT.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 17/10/2022.
//

import UIKit

class SignatureCoreICT : UIView {
    
    lazy var titleLabel:UILabel = {
       let label = UILabel()
       label.font = .systemFont(ofSize: 15)
       label.textColor = .darkGray
        label.text = "Chạm để ký tên"
       return label
   }()
    
    let iconSign:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "signICON")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let imageSign:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
        
        self.addSubview(self.iconSign)
        self.addSubview(self.imageSign)
        self.iconSign.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        self.imageSign.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
