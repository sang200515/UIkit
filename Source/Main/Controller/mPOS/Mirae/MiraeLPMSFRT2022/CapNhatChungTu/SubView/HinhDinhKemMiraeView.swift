//
//  HinhDinhKemMiraeView.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 22/04/2022.
//

import UIKit

class HinhDinhKemMiraeView : UIView {
    
    let loaiChungTuTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.tag = 4
        textField.isSelected = true
        textField.iconImage = UIImage(named: "arrowDropICON")
        textField.titleTextField = "Loại chứng từ (*)"
        return textField
    }()
    
    let cmndLabel:BaseLabel = {
        let label = BaseLabel()
        label.textColor = .mainGreen
        label.text = "CMND/CCCD (*)"
        return label
    }()
    
    let chanDungKHLabel:BaseLabel = {
        let label = BaseLabel()
        label.textColor = .mainGreen
        label.text = "CHÂN DUNG KHÁCH HÀNG (*)"
        return label
    }()
    
    let giayPhepLXLabel:BaseLabel = {
        let label = BaseLabel()
        label.textColor = .mainGreen
        label.text = "GIẤY PHÉP LÁI XE (*)"
        return label
    }()
    
    let cmndMatTruocImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 1
        return imageView
    }()
    
    let cmndMatSauImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 2
        return imageView
    }()
    
    let chanDungImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 3
        return imageView
    }()
    
    let giayPhepLXMatTruocImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 4
        return imageView
    }()
    
    let giayPhepLXMatSauImageView:UploadImageButton = {
        let imageView = UploadImageButton()
        imageView.tag = 5
        return imageView
    }()
    
    lazy var uploadThemSoHoKhauButton:UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.titleLabel?.font = .italicSystemFont(ofSize: 15)
        button.setTitle("Upload thêm hình hộ khẩu", for: .normal)
        button.setTitleColor(.mainGreen, for: .normal)
        return button
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
        self.addSubview(self.loaiChungTuTextField)
        self.addSubview(self.cmndLabel)
        self.addSubview(self.cmndMatTruocImageView)
        self.addSubview(self.cmndMatSauImageView)
        self.addSubview(self.chanDungKHLabel)
        self.addSubview(self.chanDungImageView)
        self.addSubview(self.giayPhepLXLabel)
        self.addSubview(self.giayPhepLXMatTruocImageView)
        self.addSubview(self.giayPhepLXMatSauImageView)
        self.addSubview(self.uploadThemSoHoKhauButton)
    }
    
    private func autoLayout(){
        self.loaiChungTuTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Common.TraGopMirae.Padding.heightTextField)
        }
        self.cmndLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.loaiChungTuTextField.snp.bottom).offset(20)
            make.height.greaterThanOrEqualTo(18)
        }
        self.cmndMatTruocImageView.snp.makeConstraints { make in
            make.top.equalTo(self.cmndLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.cmndLabel).offset(2)
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(150)
        }
        self.cmndMatSauImageView.snp.makeConstraints { make in
            make.top.equalTo(self.cmndMatTruocImageView)
            make.trailing.equalTo(self.cmndLabel)
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.height.equalTo(150)
        }
        self.chanDungKHLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.cmndMatTruocImageView.snp.bottom).offset(10)
        }
        self.chanDungImageView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.loaiChungTuTextField)
            make.top.equalTo(self.chanDungKHLabel.snp.bottom).offset(10)
            make.height.equalTo(150)
        }
        self.giayPhepLXLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.chanDungImageView.snp.bottom).offset(10)
        }
        self.giayPhepLXMatTruocImageView.snp.makeConstraints { make in
            make.top.equalTo(self.giayPhepLXLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.cmndLabel).offset(2)
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(150)
        }
        self.giayPhepLXMatSauImageView.snp.makeConstraints { make in
            make.top.equalTo(self.giayPhepLXMatTruocImageView)
            make.trailing.equalTo(self.cmndLabel)
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.height.equalTo(150)
        }
        self.uploadThemSoHoKhauButton.snp.makeConstraints { make in
            make.top.equalTo(self.giayPhepLXMatTruocImageView.snp.bottom).offset(10)
            make.leading.equalTo(self.giayPhepLXLabel)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
    }
    
}
