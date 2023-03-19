//
//  ThongTinCongViecView.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 22/04/2022.
//

import UIKit

class ThongTinCongViecMiraeView : UIView {
    
    let tenCongTyTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.titleTextField = "Tên công ty (*)"
        return textField
    }()
    
    let chucVuTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.tag = 8
        textField.isSelected = true
        textField.iconImage = UIImage(named: "arrowDropICON")
        textField.titleTextField = "Chức vụ (*)"
        return textField
    }()
    
    let loaiHopDongTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.tag = 9
        textField.isSelected = true
        textField.iconImage = UIImage(named: "arrowDropICON")
        textField.titleTextField = "Loại hợp đồng lao động (*)"
        return textField
    }()
    
    let thoiGianLamViecTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.styleKeyboard = .numberPad
        textField.titleTextField = "Số năm làm việc (*)"
        textField.placeHolder = "Số năm làm việc"
        return textField
    }()
    
    let soThangLamViecTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.styleKeyboard = .numberPad
        textField.placeHolder = "Số tháng làm việc"
        return textField
    }()
    
    let ngayDongDauTienTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.tag = 10
        textField.isSelected = true
        textField.placeHolder = "dd/mm/yyyy"
        textField.iconImage = UIImage(named: "arrowDropICON")
        textField.titleTextField = "Ngày đóng đầu tiên (*)"
        return textField
    }()
    
    let maNoiBoTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.tag = 11
        textField.isSelected = true
        textField.iconImage = UIImage(named: "arrowDropICON")
        textField.titleTextField = "Mã nội bộ (*)"
        return textField
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
        self.addSubview(self.tenCongTyTextField)
        self.addSubview(self.chucVuTextField)
        self.addSubview(self.loaiHopDongTextField)
        self.addSubview(self.thoiGianLamViecTextField)
        self.addSubview(self.soThangLamViecTextField)
        self.addSubview(self.ngayDongDauTienTextField)
        self.addSubview(self.maNoiBoTextField)
    }
    
    private func autoLayout(){
        self.tenCongTyTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Common.TraGopMirae.Padding.heightTextField)
        }
        self.chucVuTextField.snp.makeConstraints { make in
            make.top.equalTo(self.tenCongTyTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Common.TraGopMirae.Padding.heightTextField)
        }
        self.loaiHopDongTextField.snp.makeConstraints { make in
            make.top.equalTo(self.chucVuTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Common.TraGopMirae.Padding.heightTextField)
        }
        self.thoiGianLamViecTextField.snp.makeConstraints { make in
            make.top.equalTo(self.loaiHopDongTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.height.equalTo(Common.TraGopMirae.Padding.heightTextField)
        }
        self.soThangLamViecTextField.snp.makeConstraints { make in
            make.top.equalTo(self.thoiGianLamViecTextField)
            make.trailing.equalToSuperview()
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.height.equalTo(Common.TraGopMirae.Padding.heightTextField)
        }
        self.ngayDongDauTienTextField.snp.makeConstraints { make in
            make.top.equalTo(self.thoiGianLamViecTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.tenCongTyTextField)
            make.height.equalTo(Common.TraGopMirae.Padding.heightTextField)
        }
        self.maNoiBoTextField.snp.makeConstraints { make in
            make.top.equalTo(self.ngayDongDauTienTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Common.TraGopMirae.Padding.heightTextField)
        }

    }
    
}
