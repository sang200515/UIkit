//
//  ThongTinThamChieuMireaTableViewCell.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 18/04/2022.
//

import UIKit

class ThongTinThamChieuMireaTableViewCell : UIView {
    
    let hoTenTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.titleTextField = "Họ tên người tham chiếu 1 (*)"
        return textField
    }()
    
    let moiQuanHeTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.tag = 12
        textField.isSelected = true
        textField.iconImage = UIImage(named: "arrowDropICON")
        textField.titleTextField = "Mối quan hệ (*)"
        return textField
    }()
    
    let soDTTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.titleTextField = "Số điện thoại (*)"
        textField.styleKeyboard = .numberPad
        return textField
    }()
    
    let hoTen2TextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.titleTextField = "Họ tên người tham chiếu 2 (*)"
        return textField
    }()
    
    let moiQuanHe2TextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.tag = 13
        textField.isSelected = true
        textField.iconImage = UIImage(named: "arrowDropICON")
        textField.titleTextField = "Mối quan hệ (*)"
        return textField
    }()
    
    let soDT2TextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.titleTextField = "Số điện thoại (*)"
        textField.styleKeyboard = .numberPad
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.hoTenTextField)
        self.addSubview(self.moiQuanHeTextField)
        self.addSubview(self.soDTTextField)
        self.addSubview(self.hoTen2TextField)
        self.addSubview(self.moiQuanHe2TextField)
        self.addSubview(self.soDT2TextField)
        
        self.hoTenTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.moiQuanHeTextField.snp.makeConstraints { make in
            make.top.equalTo(self.hoTenTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.soDTTextField.snp.makeConstraints { make in
            make.top.equalTo(self.moiQuanHeTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.hoTen2TextField.snp.makeConstraints { make in
            make.top.equalTo(self.soDTTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.moiQuanHe2TextField.snp.makeConstraints { make in
            make.top.equalTo(self.hoTen2TextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.soDT2TextField.snp.makeConstraints { make in
            make.top.equalTo(self.moiQuanHe2TextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
