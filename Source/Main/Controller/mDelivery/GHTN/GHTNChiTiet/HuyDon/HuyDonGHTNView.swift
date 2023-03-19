//
//  HuyDonGHTNView.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 15/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HuyDonGHTNView : UIView {
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Lý do hủy đơn hàng"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.backgroundColor = .mainGreen
        return label
    }()
    
    let reasonLabel:UILabel = {
        let label = UILabel()
        label.text = "Lý do :"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    let reasonTextView:UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 15, weight: .semibold)
        textView.textColor = .darkGray
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.clipsToBounds = true
        textView.text = "Nhập lý do hủy đơn hàng"
        return textView
    }()
    
    let viewBackGround:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var xacNhanHuyButton:UIButton = {
        let button = UIButton()
        button.setTitle("Xác nhận hủy", for: .normal)
        button.backgroundColor = .mainGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var closeButton:UIButton = {
        let button = UIButton()
        let image = UIImage(named: "Close")
        button.setImage(image, for: .normal)
        button.backgroundColor = .mainGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.reasonTextView)
        self.addSubview(self.reasonLabel)
        self.addSubview(self.titleLabel)
        self.addSubview(self.xacNhanHuyButton)
        self.addSubview(self.closeButton)
        self.addSubview(self.viewBackGround)
        
        self.reasonTextView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(320)
        }
        self.reasonLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.reasonTextView.snp.top).offset(-10)
            make.leading.trailing.equalTo(self.reasonTextView)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.reasonLabel.snp.top).offset(-10)
            make.leading.equalTo(self.reasonTextView).offset(-10)
            make.trailing.equalTo(self.reasonTextView).offset(10)
            make.height.equalTo(40)
        }
        self.xacNhanHuyButton.snp.makeConstraints { make in
            make.top.equalTo(self.reasonTextView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        self.closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.titleLabel)
            make.trailing.equalTo(self.titleLabel).offset(-10)
            make.height.width.equalTo(30)
        }
        self.viewBackGround.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.titleLabel)
            make.bottom.equalTo(self.xacNhanHuyButton).offset(10)
        }
        self.insertSubview(self.viewBackGround, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

