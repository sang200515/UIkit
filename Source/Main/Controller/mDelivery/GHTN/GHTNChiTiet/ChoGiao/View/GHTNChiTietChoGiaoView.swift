//
//  GHTNChiTietChoGiaoView.swift
//  FPTShop_GHTN
//
//  Created by Trần Văn Dũng on 11/03/2022.
//

import UIKit

class GHTNChiTietChoGiaoView : UIView {
    
    let identifier:String = "GHTNChiTietChoGiaoTableViewCell"
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentInsetAdjustmentBehavior = .never
        sv.keyboardDismissMode = .interactive
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    let iconNguoiMuaImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic-TTNM.png")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let iconNguoiNhanImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic-TTNN.png")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let iconPhanCongImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic-TTPC.png")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let iconThongTinDonHangImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic-TTDH")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
  
    let nguoiMuaTitleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Thông tin người mua"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    let tenNguoiMuaLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let soDTNguoiMuaLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let diaChiNguoiMuaLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let nguoiNhanTitleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Thông tin người nhận"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    let tenNguoiNhanLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let soDTNguoiNhanLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let diaChiNguoiNhanLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let nhanVienGiaoLabel:UILabel = {
        let label = UILabel()
        label.text = "NV Giao:"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let donHangLabel:UILabel = {
        let label = UILabel()
        label.text = "ĐH:"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let donHangResultLabel:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.numberOfLines = 0
        label.textColor = .mainGreen
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let ecomLabel:UILabel = {
        let label = UILabel()
        label.text = "Ecom:"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let ecomResultLabel:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.numberOfLines = 0
        label.textColor = .red
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let thoiGianGiaoLabel:UILabel = {
        let label = UILabel()
        label.text = "Thời gian giao:"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let thoiGianGiaoResultLabel:UILabel = {
        let label = UILabel()
        label.text = "20/03/1991 14:29"
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let thoiGianTreLabel:UILabel = {
        let label = UILabel()
        label.text = "Thời gian"
        label.textColor = UIColor.mainGreen
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let thoiGianTreResultLabel:UILabel = {
        let label = UILabel()
        label.text = "1 ngày 20 phút"
        label.numberOfLines = 0
        label.textColor = UIColor.mainGreen
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let nhanVienGiaoTextField:UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.placeholder = "0001 - FRT"
        textField.font = .systemFont(ofSize: 15, weight: .semibold)
        return textField
    }()
    
    let ghiChuLabel:UILabel = {
        let label = UILabel()
        label.text = "Ghi chú:"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let donHangTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "Đơn hàng:"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let ghiChuTextView:UITextView = {
        let textView = UITextView()
        textView.text = "Nhập ghi chú"
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 5
        textView.textColor = .darkGray
        textView.font = .systemFont(ofSize: 15, weight: .semibold)
        return textView
    }()
    
    let phanCongTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "Phân công"
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    let thongTonDonHangTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "Thông tin đơn hàng"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    let lineViewNguoiNhan:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let lineViewThongTin:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let lineViewPhanCong:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var tableView:TableViewAutoHeight = {
        let tableView = TableViewAutoHeight()
        tableView.isScrollEnabled = false
        tableView.register(GHTNChiTietChoGiaoTableViewCell.self, forCellReuseIdentifier: self.identifier)
        return tableView
    }()
    
    let tongDonHangLabel:UILabel = {
        let label = UILabel()
        label.text = "Tổng đơn hàng:"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let tongDonHangResultLabel:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let tienGiamLabel:UILabel = {
        let label = UILabel()
        label.text = "Tiền giảm:"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let tienGiamResultLabel:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let datCocLabel:UILabel = {
        let label = UILabel()
        label.text = "Đặt cọc:"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let datCocResultLabel:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .black
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let phaiThuLabel:UILabel = {
        let label = UILabel()
        label.text = "Phải thu:"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let phaiThuResult:UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.textColor = .red
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let chupAnhTaiNhaLabel:UILabel = {
        let label = UILabel()
        label.text = "Ảnh chụp tại nhà khách hàng"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let anhChupTaiNhaImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 2
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let chupAnhChanDungLabel:UILabel = {
        let label = UILabel()
        label.text = "Ảnh chân dung khách hàng"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let chupAnhChanDungImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 11
        imageView.image = UIImage(named: "plus-icon")
        imageView.tintColor = .mainGreen
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var khachKhongNhanHangButton:UIButton = {
        let button = UIButton()
        button.sizeToFit()
        button.backgroundColor = .red
        button.setTitle("Khách không nhận hàng", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 15,weight: .semibold)
        return button
    }()
    
    lazy var khachNhanHangButton:UIButton = {
        let button = UIButton()
        button.sizeToFit()
        button.backgroundColor = .mainGreen
        button.setTitle("Khách nhận hàng", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 15,weight: .semibold)
        return button
    }()
    
    lazy var datGrabButton:UIButton = {
        let button = UIButton()
        button.sizeToFit()
        button.backgroundColor = .mainGreen
        button.setTitle("Đặt Grab", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 15,weight: .semibold)
        return button
    }()
    
    lazy var xacNhanButton:UIButton = {
        let button = UIButton()
        button.sizeToFit()
        button.backgroundColor = .mainGreen
        button.setTitle("Xác nhận", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 15,weight: .semibold)
        return button
    }()
    
    lazy var goiNhanhButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 15,weight: .semibold)
        button.setTitle("Gọi nhanh", for: .normal)
        button.backgroundColor = .mainGreen
        return button
    }()
    
    lazy var capNhatButton:UIButton = {
        let button = UIButton()
        button.sizeToFit()
        button.setTitle("Cập nhật đơn hàng", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 15,weight: .semibold)
        return button
    }()
    
    lazy var huyDHButton:UIButton = {
        let button = UIButton()
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 15,weight: .semibold)
        button.setTitle("Hủy đơn hàng", for: .normal)
        return button
    }()
    
    let viewMenuButton:UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.iconNguoiMuaImageView)
        self.scrollView.addSubview(self.nguoiMuaTitleLabel)
        self.scrollView.addSubview(self.tenNguoiMuaLabel)
        self.scrollView.addSubview(self.soDTNguoiMuaLabel)
        self.scrollView.addSubview(self.diaChiNguoiMuaLabel)
        self.addSubview(self.lineViewNguoiNhan)
        self.scrollView.addSubview(self.iconNguoiNhanImageView)
        self.scrollView.addSubview(self.nguoiNhanTitleLabel)
        self.scrollView.addSubview(self.tenNguoiNhanLabel)
        self.scrollView.addSubview(self.soDTNguoiNhanLabel)
        self.scrollView.addSubview(self.diaChiNguoiNhanLabel)
        self.addSubview(self.lineViewPhanCong)
        self.scrollView.addSubview(self.phanCongTitleLabel)
        self.scrollView.addSubview(self.iconPhanCongImageView)
        self.scrollView.addSubview(self.nhanVienGiaoLabel)
        self.scrollView.addSubview(self.nhanVienGiaoTextField)
        self.addSubview(self.lineViewThongTin)
        self.scrollView.addSubview(self.iconThongTinDonHangImageView)
        self.scrollView.addSubview(self.thongTonDonHangTitleLabel)
        self.scrollView.addSubview(self.donHangLabel)
        self.scrollView.addSubview(self.donHangResultLabel)
        self.scrollView.addSubview(self.ecomLabel)
        self.scrollView.addSubview(self.ecomResultLabel)
        self.scrollView.addSubview(self.thoiGianGiaoLabel)
        self.scrollView.addSubview(self.thoiGianGiaoResultLabel)
        self.scrollView.addSubview(self.thoiGianTreLabel)
        self.scrollView.addSubview(self.thoiGianTreResultLabel)
        self.scrollView.addSubview(self.ghiChuLabel)
        self.scrollView.addSubview(self.ghiChuTextView)
        self.scrollView.addSubview(self.donHangTitleLabel)
        self.scrollView.addSubview(self.tableView)
        self.scrollView.addSubview(self.tongDonHangLabel)
        self.scrollView.addSubview(self.tongDonHangResultLabel)
        self.scrollView.addSubview(self.tienGiamLabel)
        self.scrollView.addSubview(self.tienGiamResultLabel)
        self.scrollView.addSubview(self.datCocLabel)
        self.scrollView.addSubview(self.datCocResultLabel)
        self.scrollView.addSubview(self.phaiThuLabel)
        self.scrollView.addSubview(self.phaiThuResult)
        self.scrollView.addSubview(self.khachKhongNhanHangButton)
        self.scrollView.addSubview(self.khachNhanHangButton)
        self.scrollView.addSubview(self.datGrabButton)
        self.scrollView.addSubview(self.chupAnhTaiNhaLabel)
        self.scrollView.addSubview(self.anhChupTaiNhaImageView)
        self.scrollView.addSubview(self.chupAnhChanDungLabel)
        self.scrollView.addSubview(self.chupAnhChanDungImageView)
        self.scrollView.addSubview(self.xacNhanButton)
        self.scrollView.addSubview(self.goiNhanhButton)
        self.addSubview(self.viewMenuButton)
        self.viewMenuButton.addSubview(self.capNhatButton)
        self.viewMenuButton.addSubview(self.huyDHButton)
        
        self.scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        self.iconNguoiMuaImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.height.width.equalTo(25)
        }
        self.nguoiMuaTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.iconNguoiMuaImageView.snp.trailing).offset(5)
            make.bottom.equalTo(self.iconNguoiMuaImageView)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
        self.tenNguoiMuaLabel.snp.makeConstraints { make in
            make.top.equalTo(self.iconNguoiMuaImageView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nguoiMuaTitleLabel)
        }
        self.soDTNguoiMuaLabel.snp.makeConstraints { make in
            make.top.equalTo(self.tenNguoiMuaLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nguoiMuaTitleLabel)
        }
        self.diaChiNguoiMuaLabel.snp.makeConstraints { make in
            make.top.equalTo(self.soDTNguoiMuaLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nguoiMuaTitleLabel)
        }
        self.lineViewNguoiNhan.snp.makeConstraints { make in
            make.top.equalTo(self.diaChiNguoiMuaLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nguoiMuaTitleLabel)
            make.height.equalTo(0.5)
        }
        self.iconNguoiNhanImageView.snp.makeConstraints { make in
            make.leading.equalTo(iconNguoiMuaImageView)
            make.top.equalTo(self.lineViewNguoiNhan.snp.bottom).offset(10)
            make.height.width.equalTo(25)
        }
        self.nguoiNhanTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.iconNguoiNhanImageView.snp.trailing).offset(5)
            make.bottom.equalTo(self.iconNguoiNhanImageView.snp.bottom)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        self.tenNguoiNhanLabel.snp.makeConstraints { make in
            make.top.equalTo(self.iconNguoiNhanImageView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nguoiNhanTitleLabel)
        }
        self.soDTNguoiNhanLabel.snp.makeConstraints { make in
            make.top.equalTo(self.tenNguoiNhanLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nguoiNhanTitleLabel)
        }
        self.diaChiNguoiNhanLabel.snp.makeConstraints { make in
            make.top.equalTo(self.soDTNguoiNhanLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nguoiNhanTitleLabel)
        }
        self.lineViewPhanCong.snp.makeConstraints { make in
            make.top.equalTo(self.diaChiNguoiNhanLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nguoiMuaTitleLabel)
            make.height.equalTo(0.5)
        }
        self.iconPhanCongImageView.snp.makeConstraints { make in
            make.leading.equalTo(iconNguoiMuaImageView)
            make.top.equalTo(self.lineViewPhanCong.snp.bottom).offset(10)
            make.height.width.equalTo(25)
        }
        self.phanCongTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.iconPhanCongImageView.snp.trailing).offset(5)
            make.bottom.equalTo(self.iconPhanCongImageView.snp.bottom)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        self.nhanVienGiaoLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.phanCongTitleLabel)
            make.top.equalTo(self.phanCongTitleLabel.snp.bottom).offset(25)
            make.width.equalTo(70)
        }
        self.nhanVienGiaoTextField.snp.makeConstraints { make in
            make.bottom.equalTo(self.nhanVienGiaoLabel)
            make.leading.equalTo(self.nhanVienGiaoLabel.snp.trailing).offset(5)
            make.trailing.equalTo(self.nguoiMuaTitleLabel)
            make.height.equalTo(35)
        }
        
        self.lineViewThongTin.snp.makeConstraints { make in
            make.top.equalTo(self.nhanVienGiaoTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.nguoiMuaTitleLabel)
            make.height.equalTo(0.5)
        }
        self.iconThongTinDonHangImageView.snp.makeConstraints { make in
            make.leading.equalTo(iconNguoiMuaImageView)
            make.top.equalTo(self.lineViewThongTin.snp.bottom).offset(10)
            make.height.width.equalTo(25)
        }
        self.thongTonDonHangTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.iconThongTinDonHangImageView.snp.trailing).offset(5)
            make.bottom.equalTo(self.iconThongTinDonHangImageView.snp.bottom)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        self.donHangLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.phanCongTitleLabel)
            make.top.equalTo(self.thongTonDonHangTitleLabel.snp.bottom).offset(10)
            make.width.equalTo(30)
        }
        self.donHangResultLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.donHangLabel.snp.trailing).offset(5)
            make.top.equalTo(self.donHangLabel)
            make.width.lessThanOrEqualTo(130)
            make.height.greaterThanOrEqualTo(20)
        }
        self.ecomLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.donHangResultLabel.snp.trailing).offset(10)
            make.top.equalTo(self.thongTonDonHangTitleLabel.snp.bottom).offset(10)
            make.width.lessThanOrEqualTo(50)
        }
        self.ecomResultLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.ecomLabel.snp.trailing).offset(5)
            make.top.equalTo(self.ecomLabel)
            make.trailing.equalTo(self.nguoiMuaTitleLabel)
            make.height.greaterThanOrEqualTo(20)
        }
        self.thoiGianGiaoLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(self.donHangResultLabel.snp.bottom).offset(10)
            make.top.greaterThanOrEqualTo(self.ecomResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.donHangLabel)
        }
        self.thoiGianGiaoResultLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.thoiGianGiaoLabel.snp.trailing).offset(5)
            make.top.equalTo(self.thoiGianGiaoLabel)
            make.trailing.equalTo(self.nguoiMuaTitleLabel)
            make.height.greaterThanOrEqualTo(20)
        }
        self.thoiGianTreLabel.snp.makeConstraints { make in
            make.top.equalTo(self.thoiGianGiaoResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.donHangLabel)
        }
        self.thoiGianTreResultLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.thoiGianTreLabel.snp.trailing).offset(5)
            make.top.equalTo(self.thoiGianTreLabel)
            make.trailing.equalTo(self.nguoiMuaTitleLabel)
            make.height.greaterThanOrEqualTo(20)
        }
        self.ghiChuLabel.snp.makeConstraints { make in
            make.top.equalTo(self.thoiGianTreResultLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nguoiMuaTitleLabel)
        }
        self.ghiChuTextView.snp.makeConstraints { make in
            make.top.equalTo(self.ghiChuLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nguoiMuaTitleLabel)
            make.height.equalTo(100)
        }
        self.donHangTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.ghiChuTextView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nguoiMuaTitleLabel)
        }
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.donHangTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nguoiMuaTitleLabel)
            make.height.greaterThanOrEqualTo(0)
        }
        self.tongDonHangLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.tableView)
            make.top.equalTo(self.tableView.snp.bottom).offset(10)
        }
        self.tongDonHangResultLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self.tableView)
            make.top.equalTo(self.tongDonHangLabel)
        }
        self.tienGiamLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.tableView)
            make.top.equalTo(self.tongDonHangResultLabel.snp.bottom).offset(10)
        }
        self.tienGiamResultLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self.tableView)
            make.top.equalTo(self.tienGiamLabel)
        }
        self.datCocLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.tableView)
            make.top.equalTo(self.tienGiamLabel.snp.bottom).offset(10)
        }
        self.datCocResultLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self.tableView)
            make.top.equalTo(self.datCocLabel)
        }
        self.phaiThuLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.tableView)
            make.top.equalTo(self.datCocLabel.snp.bottom).offset(10)
        }
        self.phaiThuResult.snp.makeConstraints { make in
            make.trailing.equalTo(self.tableView)
            make.top.equalTo(self.phaiThuLabel)
        }
        self.khachKhongNhanHangButton.snp.makeConstraints { make in
            make.top.equalTo(self.phaiThuLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.iconNguoiMuaImageView)
            make.height.equalTo(40)
            make.trailing.equalTo(self.snp.centerX).offset(-2)
        }
        self.khachNhanHangButton.snp.makeConstraints { make in
            make.top.equalTo(self.phaiThuLabel.snp.bottom).offset(10)
            make.trailing.equalTo(self.phaiThuResult)
            make.height.equalTo(40)
            make.leading.equalTo(self.snp.centerX).offset(2)
        }
        self.datGrabButton.snp.makeConstraints { make in
            make.leading.equalTo(self.iconNguoiMuaImageView)
            make.trailing.top.equalTo(self.khachNhanHangButton)
            make.height.equalTo(40)
        }
        self.chupAnhTaiNhaLabel.snp.makeConstraints { make in
            make.top.equalTo(self.khachNhanHangButton.snp.bottom).offset(10)
            make.leading.equalTo(self.tableView)
            make.height.equalTo(18)
        }
        self.anhChupTaiNhaImageView.snp.makeConstraints { make in
            make.top.equalTo(self.chupAnhTaiNhaLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.tableView)
            make.height.equalTo(200)
        }
        self.chupAnhChanDungLabel.snp.makeConstraints { make in
            make.top.equalTo(self.anhChupTaiNhaImageView.snp.bottom).offset(10)
            make.leading.equalTo(self.tableView)
            make.height.equalTo(18)
        }
        self.chupAnhChanDungImageView.snp.makeConstraints { make in
            make.top.equalTo(self.chupAnhChanDungLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.tableView)
            make.height.equalTo(200)
        }
        
        self.xacNhanButton.snp.makeConstraints { make in
            make.top.equalTo(self.chupAnhChanDungImageView.snp.bottom).offset(10)
            make.leading.equalTo(self.iconNguoiMuaImageView)
            make.trailing.equalTo(self.tableView)
            make.height.equalTo(40)
        }
        self.goiNhanhButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.thongTonDonHangTitleLabel)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
        self.viewMenuButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(80)
            make.width.equalTo(150)
        }
        self.capNhatButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        self.huyDHButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(self.capNhatButton.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
