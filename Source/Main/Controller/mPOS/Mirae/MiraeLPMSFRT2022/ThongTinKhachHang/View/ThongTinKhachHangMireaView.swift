//
//  ThongTinKhachHangMireaView.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 18/04/2022.
//

import Foundation
import UIKit
import DropDown

class ThongTinKhachHangMireaView : UIView {
  
    var dropDown:DropDown?
    
    lazy var thongTinKhachHangButton:HeaderInfo = {
        let button = HeaderInfo()
        button.titleHeader.text = "THÔNG TIN KHÁCH HÀNG"
        return button
    }()
    
    lazy var thongTinCongViecButton:HeaderInfo = {
        let button = HeaderInfo()
        button.titleHeader.text = "THÔNG TIN CÔNG VIỆC"
        return button
    }()
    
    lazy var thongTinThuongTruButton:HeaderInfo = {
        let button = HeaderInfo()
        button.titleHeader.text = "THÔNG TIN ĐỊA CHỈ THƯỜNG TRÚ"
        return button
    }()
    
    lazy var thongTinTamTruButton:HeaderInfo = {
        let button = HeaderInfo()
        button.titleHeader.text = "THÔNG TIN ĐỊA CHỈ TẠM TRÚ"
        return button
    }()
    
    lazy var thongTinThamChieuButton:HeaderInfo = {
        let button = HeaderInfo()
        button.titleHeader.text = "THÔNG TIN THAM CHIẾU"
        return button
    }()

    lazy var diaChiButton:CheckBoxButton = {
        let button = CheckBoxButton()
        button.isChecked = false
        return button
    }()
    
    lazy var taoHoSoButton:UIButton = {
        let button = UIButton()
        button.setTitle("TẠO HỒ SƠ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.backgroundColor = .mainGreen
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.contentInsetAdjustmentBehavior = .never
        sv.keyboardDismissMode = .interactive
        return sv
    }()
    
    let viewThongTinKhachHang:ThongTinKhachHangMireaTableViewCell = {
        let view = ThongTinKhachHangMireaTableViewCell()
        return view
    }()
    let viewThuongTruKhachHang:ThongTinDiaChiThuongTruMireaTableViewCell = {
        let view = ThongTinDiaChiThuongTruMireaTableViewCell()
        return view
    }()
    let viewTamTruKhachHang:ThongTinDiaChiTamTruMireaTableViewCell = {
        let view = ThongTinDiaChiTamTruMireaTableViewCell()
        return view
    }()
    let viewThamChieuKhachHang:ThongTinThamChieuMireaTableViewCell = {
        let view = ThongTinThamChieuMireaTableViewCell()
        return view
    }()
    let viewThongTinCongViec:ThongTinCongViecMiraeView = {
        let view = ThongTinCongViecMiraeView()
        view.isHidden = true
        return view
    }()
    
    let viewBottom:UIView = UIView()
    
    let diaChiLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "Giống địa chỉ trường trú"
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.autoLayout()
    }
    
    private func addView(){
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.thongTinKhachHangButton)
        self.scrollView.addSubview(self.viewThongTinKhachHang)
        self.scrollView.addSubview(self.thongTinThuongTruButton)
        self.scrollView.addSubview(self.viewThuongTruKhachHang)
        self.scrollView.addSubview(self.thongTinTamTruButton)
        self.scrollView.addSubview(self.diaChiButton)
        self.scrollView.addSubview(self.diaChiLabel)
        self.scrollView.addSubview(self.viewTamTruKhachHang)
        self.scrollView.addSubview(self.thongTinThamChieuButton)
        self.scrollView.addSubview(self.viewThamChieuKhachHang)
        self.scrollView.addSubview(self.thongTinCongViecButton)
        self.scrollView.addSubview(self.viewThongTinCongViec)
        self.scrollView.addSubview(self.taoHoSoButton)
        self.scrollView.addSubview(self.viewBottom)
    }
    
    private func autoLayout(){
        self.scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(self)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(Common.TraGopMirae.Padding.padding)
            make.trailing.equalToSuperview().offset(-Common.TraGopMirae.Padding.padding)
        }
        self.thongTinKhachHangButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        self.viewThongTinKhachHang.snp.makeConstraints { make in
            make.top.equalTo(self.thongTinKhachHangButton.snp.bottom)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(Common.TraGopMirae.Padding.padding)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-Common.TraGopMirae.Padding.padding)
            make.height.equalTo(680)
        }
        self.thongTinThuongTruButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(self.viewThongTinKhachHang.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        self.viewThuongTruKhachHang.snp.makeConstraints { make in
            make.top.equalTo(self.thongTinThuongTruButton.snp.bottom).offset(0)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(Common.TraGopMirae.Padding.padding)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-Common.TraGopMirae.Padding.padding)
            make.height.equalTo(270)
        }
        self.thongTinTamTruButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(self.viewThuongTruKhachHang.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        self.diaChiButton.snp.makeConstraints { make in
            make.top.equalTo(self.thongTinTamTruButton.snp.bottom).offset(10)
            make.height.width.equalTo(20)
        }
        self.diaChiLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.diaChiButton.snp.trailing).offset(5)
            make.bottom.equalTo(self.diaChiButton)
        }
        self.viewTamTruKhachHang.snp.makeConstraints { make in
            make.top.equalTo(self.diaChiButton.snp.bottom).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(Common.TraGopMirae.Padding.padding)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-Common.TraGopMirae.Padding.padding)
            make.height.equalTo(270)
        }
        self.thongTinThamChieuButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(self.viewTamTruKhachHang.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        self.viewThamChieuKhachHang.snp.makeConstraints { make in
            make.top.equalTo(self.thongTinThamChieuButton.snp.bottom).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(Common.TraGopMirae.Padding.padding)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-Common.TraGopMirae.Padding.padding)
            make.height.equalTo(408)
        }
        self.taoHoSoButton.snp.makeConstraints { make in
            make.top.equalTo(self.viewThamChieuKhachHang.snp.bottom).offset(20)
            make.leading.equalTo(viewThamChieuKhachHang)
            make.trailing.equalTo(viewThamChieuKhachHang)
            make.height.equalTo(45)
        }
        self.viewBottom.snp.makeConstraints { make in
            make.top.equalTo(self.taoHoSoButton.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(20)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

