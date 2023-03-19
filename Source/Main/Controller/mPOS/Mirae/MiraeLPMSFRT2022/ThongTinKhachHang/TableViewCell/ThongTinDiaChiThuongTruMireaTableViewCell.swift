//
//  ThongTinDiaChiThuongTruMireaTableViewCell.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 18/04/2022.
//

import UIKit

class ThongTinDiaChiThuongTruMireaTableViewCell : UIView {
    
    let tinhTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.textField.tag = 101
//        textField.isSelected = true
        textField.iconImage = UIImage(named: "arrowDropICON")
        textField.titleTextField = "Tỉnh/Thành phố (*)"
        return textField
    }()
    
    let huyenTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.tag = 3
        textField.isSelected = true
        textField.iconImage = UIImage(named: "arrowDropICON")
        textField.titleTextField = "Quận/Huyện (*)"
        return textField
    }()
    
    let xaTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.tag = 4
        textField.isSelected = true
        textField.iconImage = UIImage(named: "arrowDropICON")
        textField.titleTextField = "Phường/Xã (*)"
        return textField
    }()
    
    let duongTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.titleTextField = "Đường/Ấp (*)"
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.tinhTextField)
        self.addSubview(self.huyenTextField)
        self.addSubview(self.xaTextField)
        self.addSubview(self.duongTextField)
        
        self.tinhTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.huyenTextField.snp.makeConstraints { make in
            make.top.equalTo(self.tinhTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.xaTextField.snp.makeConstraints { make in
            make.top.equalTo(self.huyenTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.duongTextField.snp.makeConstraints { make in
            make.top.equalTo(self.xaTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
