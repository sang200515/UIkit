//
//  ThongTinKhachHangMireaTableViewCell.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 18/04/2022.
//

import UIKit

class ThongTinKhachHangMireaTableViewCell : UIView {
    
    let cmndTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.titleTextField = "CMND/CCCD (*)"
        textField.styleKeyboard = .numberPad
        return textField
    }()
    
    let ngayCapTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.tag = 10
        textField.titleTextField = "Ngày cấp (*)"
        return textField
    }()
    
    let noiCapTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.textField.tag = 100
//        textField.isSelected = true
        textField.iconImage = UIImage(named: "arrowDropICON")
        textField.titleTextField = "Nơi cấp (*)"
        return textField
    }()
    
    let gioiTinhLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "Giới tính (*)"
        label.textColor = .darkGray
        return label
    }()
    
    lazy var gioiTinhNamButton:RadioCustom = {
        let button = RadioCustom()
        button.tag = 0
        button.titleLabel.text = "Nam"
        return button
    }()
    
    lazy var gioiTinhNuButton:RadioCustom = {
        let button = RadioCustom()
        button.titleLabel.text = "Nữ"
        button.tag = 1
        return button
    }()
    
    let hoKHTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.titleTextField = "Họ KH (*)"
        return textField
    }()
    
    let tenLotTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.titleTextField = "Tên lót (*)"
        return textField
    }()
    
    let tenKHTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.titleTextField = "Tên KH (*)"
        return textField
    }()
    
    let ngaySinhTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.tag = 1
        textField.placeHolder = "dd/mm/yyyy"
        textField.titleTextField = "Ngày sinh (*)"
        return textField
    }()
    
    let soDTTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.titleTextField = "Số điện thoại (*)"
        textField.styleKeyboard = .numberPad
        return textField
    }()
    
    let thuNhapTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.titleTextField = "Thu nhập (*)"
        textField.isCurrency = true
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.autoLayout()
        self.configureViewThongTinKhachHang()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewThongTinKhachHang(){
        
    }
    
    private func addView(){
        self.addSubview(self.cmndTextField)
        self.addSubview(self.ngayCapTextField)
        self.addSubview(self.noiCapTextField)
        self.addSubview(self.gioiTinhLabel)
        self.addSubview(self.gioiTinhNamButton)
        self.addSubview(self.gioiTinhNuButton)
        self.addSubview(self.hoKHTextField)
        self.addSubview(self.tenLotTextField)
        self.addSubview(self.tenKHTextField)
        self.addSubview(self.ngaySinhTextField)
        self.addSubview(self.soDTTextField)
        self.addSubview(self.thuNhapTextField)
    }
    
    private func autoLayout(){
        self.cmndTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.ngayCapTextField.snp.makeConstraints { make in
            make.top.equalTo(self.cmndTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.noiCapTextField.snp.makeConstraints { make in
            make.top.equalTo(self.ngayCapTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.gioiTinhLabel.snp.makeConstraints { make in
            make.top.equalTo(self.noiCapTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        self.gioiTinhNamButton.snp.makeConstraints { make in
            make.top.equalTo(self.gioiTinhLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(80)
        }
        self.gioiTinhNuButton.snp.makeConstraints { make in
            make.top.equalTo(self.gioiTinhLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.gioiTinhNamButton.snp.trailing).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(80)
        }
        self.hoKHTextField.snp.makeConstraints { make in
            make.top.equalTo(self.gioiTinhNuButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.tenLotTextField.snp.makeConstraints { make in
            make.top.equalTo(self.hoKHTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.tenKHTextField.snp.makeConstraints { make in
            make.top.equalTo(self.tenLotTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.ngaySinhTextField.snp.makeConstraints { make in
            make.top.equalTo(self.tenKHTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.soDTTextField.snp.makeConstraints { make in
            make.top.equalTo(self.ngaySinhTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }
        self.thuNhapTextField.snp.makeConstraints { make in
            make.top.equalTo(self.soDTTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(58)
        }

    }
    
}
extension ThongTinKhachHangMireaTableViewCell : CustomTxtDelegate {
    func onRightTxt(tag:Int) {
        print("---tag")
    }
}
