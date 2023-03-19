//
//  KhuiSealView.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 20/10/2022.
//

import UIKit

class KhuiSealView : UIView {
    
    let imeitextField:TextFieldCoreICT = {
        let textField = TextFieldCoreICT()
        textField.titleString = "IMEI sản phẩm"
        textField.isRequeied = true
        textField.isShowButton = true
        textField.placeholder = "Nhập hoặc scan mã IMEI sản phẩm"
        return textField
    }()
    
    let noteLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .red
        label.text = "IMEI thuộc biên bản cam kết phải trùng với IMEI của đơn hàng trả góp."
        return label
    }()
    
    lazy var finalButton:BaseButton = {
        let button = BaseButton()
        button.isEnabled = false
        button.backgroundColor = UIColor(hexString: "#04AB6E")
        button.title = "Hoàn tất biên bản"
        return button
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.darkGray]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.red]
        
        let attributedString1 = NSMutableAttributedString(string:"Hình ảnh khách hàng khui seal", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:"(*)", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        label.attributedText = attributedString1
        return label
    }()
    
    lazy var imageView:ImageViewCoreICT = {
        let imageView = ImageViewCoreICT()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imeitextField)
        self.addSubview(self.noteLabel)
        self.addSubview(self.titleLabel)
        self.addSubview(self.imageView)
        self.addSubview(self.finalButton)
        
        self.imeitextField.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(70)
        }
        self.noteLabel.snp.makeConstraints { make in
            make.top.equalTo(self.imeitextField.snp.bottom).offset(5)
            make.leading.trailing.equalTo(self.imeitextField)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.noteLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.imeitextField)
        }
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(250)
            make.width.equalToSuperview().offset(-20)
        }
        self.finalButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalTo(self.imeitextField)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
