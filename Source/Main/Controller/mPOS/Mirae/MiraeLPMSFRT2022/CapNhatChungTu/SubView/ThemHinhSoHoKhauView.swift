//
//  ThemHinhSoHoKhauView.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 05/05/2022.
//

import UIKit

class ThemHinhSoHoKhauView : UIView {
    
    let soHK3ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 8
        return imageView
    }()
    
    let soHK4ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 9
        return imageView
    }()
    
    let soHK5ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 10
        return imageView
    }()
    
    let soHK6ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 11
        return imageView
    }()
    
    let soHK7ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 12
        return imageView
    }()
    
    let soHK8ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 13
        return imageView
    }()
    
    let soHK9ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 14
        return imageView
    }()
    
    let soHK10ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 15
        return imageView
    }()
    
    let soHK11ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 16
        return imageView
    }()
    
    let soHK12ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 17
        return imageView
    }()
    
    let soHK13ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 18
        return imageView
    }()
    
    let soHK14ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 19
        return imageView
    }()
    
    let soHK15ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 20
        return imageView
    }()
    
    let soHK16ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 21
        return imageView
    }()
    
    let soHK17ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 22
        return imageView
    }()
    
    let soHK18ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 23
        return imageView
    }()
    
    let soHK19ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 24
        return imageView
    }()
    
    let soHK20ImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 25
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addView(){
        self.addSubview(self.soHK3ImageView)
        self.addSubview(self.soHK4ImageView)
        self.addSubview(self.soHK5ImageView)
        self.addSubview(self.soHK6ImageView)
        self.addSubview(self.soHK7ImageView)
        self.addSubview(self.soHK8ImageView)
        self.addSubview(self.soHK9ImageView)
        self.addSubview(self.soHK10ImageView)
        self.addSubview(self.soHK11ImageView)
        self.addSubview(self.soHK12ImageView)
        self.addSubview(self.soHK13ImageView)
        self.addSubview(self.soHK14ImageView)
        self.addSubview(self.soHK15ImageView)
        self.addSubview(self.soHK16ImageView)
        self.addSubview(self.soHK17ImageView)
        self.addSubview(self.soHK18ImageView)
        self.addSubview(self.soHK19ImageView)
        self.addSubview(self.soHK20ImageView)
    }
    
    private func autoLayout(){
        self.soHK3ImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(150)
        }
        self.soHK4ImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-2)
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.height.equalTo(150)
        }
        self.soHK5ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK3ImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(150)
        }
        self.soHK6ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK5ImageView)
            make.trailing.equalToSuperview().offset(-2)
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.height.equalTo(150)
        }
        self.soHK7ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK6ImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(150)
        }
        self.soHK8ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK7ImageView)
            make.trailing.equalToSuperview().offset(-2)
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.height.equalTo(150)
        }
        self.soHK9ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK7ImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(150)
        }
        self.soHK10ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK9ImageView)
            make.trailing.equalToSuperview().offset(-2)
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.height.equalTo(150)
        }
        self.soHK11ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK9ImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(150)
        }
        self.soHK12ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK11ImageView)
            make.trailing.equalToSuperview().offset(-2)
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.height.equalTo(150)
        }
        self.soHK13ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK12ImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(150)
        }
        self.soHK14ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK13ImageView)
            make.trailing.equalToSuperview().offset(-2)
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.height.equalTo(150)
        }
        self.soHK15ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK14ImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(150)
        }
        self.soHK16ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK15ImageView)
            make.trailing.equalToSuperview().offset(-2)
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.height.equalTo(150)
        }
        self.soHK17ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK16ImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(150)
        }
        self.soHK18ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK17ImageView)
            make.trailing.equalToSuperview().offset(-2)
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.height.equalTo(150)
        }
        self.soHK19ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK18ImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(2)
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(150)
        }
        self.soHK20ImageView.snp.makeConstraints { make in
            make.top.equalTo(self.soHK19ImageView)
            make.trailing.equalToSuperview().offset(-2)
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.height.equalTo(150)
        }
    }
}
