//
//  UpdateGoiVayView.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 20/05/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class UpdateGoiVayView : UIView {
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.contentInsetAdjustmentBehavior = .never
        sv.keyboardDismissMode = .interactive
        return sv
    }()
    
    let thongTinKHLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "THÔNG TIN KHÁCH HÀNG"
        return label
    }()
    
    let thongTinDonHangLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "THÔNG TIN ĐƠN HÀNG"
        return label
    }()
    
    let thongTinKhuyenMaiLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "THÔNG TIN KHUYẾN MÃI"
        return label
    }()
    
    let thongTinTraGopLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "THÔNG TIN TRẢ GÓP"
        return label
    }()
    
    let thongTinThanhToanLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "THÔNG TIN THANH TOÁN"
        return label
    }()
    
    let hotenKHLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Họ tên KH :"
        return label
    }()
    
    let cmndLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "CMND/CCCD :"
        return label
    }()
    
    let soDTLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Số điện thoại :"
        return label
    }()
    
    let hotenKHResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = ""
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let cmndResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = ""
        return label
    }()
    
    let soDTResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = ""
        return label
    }()
    
    lazy var donHangTableView:TableViewAutoHeight = {
        let tableView = TableViewAutoHeight()
        tableView.register(ThongTinDonHangMiraeCompleteTableViewCell.self,
                           forCellReuseIdentifier: Common.TraGopMirae.identifierTableViewCell.thongTinDonHang)
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    lazy var khuyenMaiTableView:TableViewAutoHeight = {
        let tableView = TableViewAutoHeight()
        tableView.register(ThongTinKhuyenMaiMiraeTableViewCell.self,
                           forCellReuseIdentifier: Common.TraGopMirae.identifierTableViewCell.thongTinKhuyenMai)
        tableView.isScrollEnabled = false
        tableView.layer.borderColor = UIColor.mainGreen.cgColor
        tableView.layer.borderWidth = 1
        return tableView
    }()
    
    let thanhTienLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Thành tiền :"
        return label
    }()
    
    let thanhTienResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "0"
        label.textAlignment = .right
        label.textColor = .red
        return label
    }()
    
    let soTienTraTruocLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Số tiền trả trước :"
        return label
    }()
    
    let soTienTraTruocResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "0"
        label.textColor = .red
        label.textAlignment = .right
        return label
    }()
    
    let soTienVayLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Số tiền vay :"
        return label
    }()
    
    let soTienVayResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "0"
        label.textAlignment = .right
        label.textColor = .red
        return label
    }()
    
    let phiBaoHiemLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Phí bảo hiểm :"
        return label
    }()
    
    let phiBaoHiemResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "0"
        label.textColor = .red
        label.textAlignment = .right
        return label
    }()
    
    let giamGiaLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Giảm giá :"
        return label
    }()
    
    let giamGiaResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "0"
        label.textColor = .red
        label.textAlignment = .right
        return label
    }()

    let datCocLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Số tiền cọc :"
        return label
    }()

    let datCocResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "0"
        label.textColor = .red
        label.textAlignment = .right
        return label
    }()

    let goiTraGopLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Gói trả góp :"
        return label
    }()
    
    let goiTraGopResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Gói lãi suất 0%"
        label.textAlignment = .right
        return label
    }()
    
    let laiSuatLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Lãi suất :"
        return label
    }()
    
    let laiSuatResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "0%"
        label.textAlignment = .right
        return label
    }()
    
    let kyHanLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Kỳ hạn :"
        return label
    }()
    
    let kyHanResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "6 tháng"
        label.textAlignment = .right
        return label
    }()
    
    let tongTienLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Tổng tiền đơn hàng(Bao gồm phí BH) :"
        return label
    }()
    
    let tongTienResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "130,000,000 VND"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .red
        label.textAlignment = .right
        return label
    }()
    
    lazy var luuDonHangButton:BaseButton = {
        let button = BaseButton()
        button.setTitle("CẬP NHẬT KHOẢN VAY", for: .normal)
        return button
    }()
    
    lazy var huyDonHangButton:BaseButton = {
        let button = BaseButton()
        button.isHidden = true
        button.backgroundColor = Common.TraGopMirae.Color.red
        button.setTitle("HỦY", for: .normal)
        return button
    }()
    
    lazy var capNhatThongTinButton:BaseButton = {
        let button = BaseButton()
        button.isHidden = true
        button.backgroundColor = Common.TraGopMirae.Color.green
        button.setTitle("CẬP NHẬT THÔNG TIN", for: .normal)
        return button
    }()
    
    lazy var capNhatKhoangVayButton:BaseButton = {
        let button = BaseButton()
        button.isHidden = true
        button.backgroundColor = Common.TraGopMirae.Color.orange
        button.setTitle("CẬP NHẬT KHOẢN VAY", for: .normal)
        return button
    }()
    
    lazy var thongTinKhachHangButton:BaseButton = {
        let button = BaseButton()
        button.isHidden = true
        button.backgroundColor = Common.TraGopMirae.Color.blue
        button.setTitle("THÔNG TIN KH", for: .normal)
        return button
    }()
    
    let bottomView:UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView(){
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.thongTinKHLabel)
        self.scrollView.addSubview(self.hotenKHLabel)
        self.scrollView.addSubview(self.hotenKHResultLabel)
        self.scrollView.addSubview(self.cmndLabel)
        self.scrollView.addSubview(self.cmndResultLabel)
        self.scrollView.addSubview(self.soDTLabel)
        self.scrollView.addSubview(self.soDTResultLabel)
        self.scrollView.addSubview(self.thongTinDonHangLabel)
        self.scrollView.addSubview(self.donHangTableView)
        self.scrollView.addSubview(self.thongTinKhuyenMaiLabel)
        self.scrollView.addSubview(self.khuyenMaiTableView)
        self.scrollView.addSubview(self.thongTinThanhToanLabel)
        self.scrollView.addSubview(self.goiTraGopLabel)
        self.scrollView.addSubview(self.goiTraGopResultLabel)
        self.scrollView.addSubview(self.laiSuatLabel)
        self.scrollView.addSubview(self.laiSuatResultLabel)
        self.scrollView.addSubview(self.kyHanLabel)
        self.scrollView.addSubview(self.kyHanResultLabel)
        self.scrollView.addSubview(self.thanhTienLabel)
        self.scrollView.addSubview(self.thanhTienResultLabel)
        self.scrollView.addSubview(self.soTienTraTruocLabel)
        self.scrollView.addSubview(self.soTienTraTruocResultLabel)
        self.scrollView.addSubview(self.soTienVayLabel)
        self.scrollView.addSubview(self.soTienVayResultLabel)
        self.scrollView.addSubview(self.phiBaoHiemLabel)
        self.scrollView.addSubview(self.phiBaoHiemResultLabel)
        self.scrollView.addSubview(self.giamGiaLabel)
        self.scrollView.addSubview(self.giamGiaResultLabel)
        self.scrollView.addSubview(self.datCocLabel)
        self.scrollView.addSubview(self.datCocResultLabel)
        self.scrollView.addSubview(self.tongTienLabel)
        self.scrollView.addSubview(self.tongTienResultLabel)
        self.scrollView.addSubview(self.capNhatThongTinButton)
        self.scrollView.addSubview(self.capNhatKhoangVayButton)
        self.scrollView.addSubview(self.luuDonHangButton)
        self.scrollView.addSubview(self.huyDonHangButton)
        self.scrollView.addSubview(self.thongTinKhachHangButton)
        self.scrollView.addSubview(self.bottomView)
    }
    
    private func autoLayout(){
        self.scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(self)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(Common.TraGopMirae.Padding.padding)
            make.trailing.equalToSuperview().offset(-Common.TraGopMirae.Padding.padding)
        }
        
        self.thongTinKHLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-Common.TraGopMirae.Padding.padding)
        }
        self.hotenKHLabel.snp.makeConstraints { make in
            make.top.equalTo(self.thongTinKHLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.thongTinKHLabel)
            make.height.greaterThanOrEqualTo(18)
            make.width.equalTo(100)
        }
        self.hotenKHResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.hotenKHLabel)
            make.height.greaterThanOrEqualTo(18)
            make.leading.equalTo(self.hotenKHLabel.snp.trailing).offset(10)
            make.trailing.equalTo(self.thongTinKHLabel)
        }
        self.cmndLabel.snp.makeConstraints { make in
            make.top.equalTo(self.hotenKHResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.thongTinKHLabel)
            make.height.greaterThanOrEqualTo(18)
            make.width.equalTo(100)
        }
        self.cmndResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cmndLabel)
            make.height.greaterThanOrEqualTo(18)
            make.leading.equalTo(self.cmndLabel.snp.trailing).offset(10)
            make.trailing.equalTo(self.thongTinKHLabel)
        }
        self.soDTLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cmndResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.thongTinKHLabel)
            make.height.greaterThanOrEqualTo(18)
            make.width.equalTo(100)
        }
        self.soDTResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.soDTLabel)
            make.height.greaterThanOrEqualTo(18)
            make.leading.equalTo(self.soDTLabel.snp.trailing).offset(10)
            make.trailing.equalTo(self.thongTinKHLabel)
        }
        self.thongTinDonHangLabel.snp.makeConstraints { make in
            make.top.equalTo(self.soDTResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.thongTinKHLabel)
            make.trailing.equalTo(self.thongTinKHLabel)
        }
        self.donHangTableView.snp.makeConstraints { make in
            make.top.equalTo(self.thongTinDonHangLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.thongTinKHLabel)
        }
        self.thongTinKhuyenMaiLabel.snp.makeConstraints { make in
            make.top.equalTo(self.donHangTableView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.thongTinKHLabel)
        }
        self.khuyenMaiTableView.snp.makeConstraints { make in
            make.top.equalTo(self.thongTinKhuyenMaiLabel.snp.bottom).offset(5)
            make.leading.trailing.equalTo(self.donHangTableView)
        }
        self.thongTinThanhToanLabel.snp.makeConstraints { make in
            make.top.equalTo(self.khuyenMaiTableView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.thongTinKHLabel)
        }
        self.goiTraGopLabel.snp.makeConstraints { make in
            make.top.equalTo(self.thongTinThanhToanLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.goiTraGopResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.goiTraGopLabel)
            make.trailing.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.laiSuatLabel.snp.makeConstraints { make in
            make.top.equalTo(self.goiTraGopResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.laiSuatResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.laiSuatLabel)
            make.trailing.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.kyHanLabel.snp.makeConstraints { make in
            make.top.equalTo(self.laiSuatResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.kyHanResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.kyHanLabel)
            make.trailing.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.thanhTienLabel.snp.makeConstraints { make in
            make.top.equalTo(self.kyHanResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.thanhTienResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.thanhTienLabel)
            make.trailing.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.soTienTraTruocLabel.snp.makeConstraints { make in
            make.top.equalTo(self.thanhTienLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.soTienTraTruocResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.soTienTraTruocLabel)
            make.trailing.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.soTienVayLabel.snp.makeConstraints { make in
            make.top.equalTo(self.soTienTraTruocLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.soTienVayResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.soTienVayLabel)
            make.trailing.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.phiBaoHiemLabel.snp.makeConstraints { make in
            make.top.equalTo(self.soTienVayResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.phiBaoHiemResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.phiBaoHiemLabel)
            make.trailing.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.giamGiaLabel.snp.makeConstraints { make in
            make.top.equalTo(self.phiBaoHiemResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.giamGiaResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.giamGiaLabel)
            make.trailing.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.datCocLabel.snp.makeConstraints { make in
            make.top.equalTo(self.giamGiaResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.datCocResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.datCocLabel)
            make.trailing.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.tongTienLabel.snp.makeConstraints { make in
            make.top.equalTo(self.datCocResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.tongTienResultLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.tongTienLabel)
            make.trailing.equalTo(self.thongTinKHLabel)
            make.width.equalTo(UIScreen.main.bounds.width / 2)
        }
        self.luuDonHangButton.snp.makeConstraints { make in
            make.top.equalTo(self.tongTienResultLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.thongTinKHLabel)
            make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
        }
        self.huyDonHangButton.snp.makeConstraints { make in
            make.leading.equalTo(self.luuDonHangButton)
            make.top.equalTo(self.luuDonHangButton.snp.bottom).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.centerX).offset(-5)
            make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
        }
        self.thongTinKhachHangButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.luuDonHangButton)
            make.top.equalTo(self.huyDonHangButton)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.centerX).offset(5)
            make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
        }
//        self.capNhatThongTinButton.snp.makeConstraints { make in
//            make.leading.top.bottom.equalTo(self.luuDonHangButton)
//            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.centerX).offset(-5)
//        }
//        self.capNhatKhoangVayButton.snp.makeConstraints { make in
//            make.trailing.top.bottom.equalTo(self.luuDonHangButton)
//            make.leading.equalTo(self.safeAreaLayoutGuide.snp.centerX).offset(5)
//        }
        self.bottomView.snp.makeConstraints { make in
            make.top.equalTo(self.thongTinKhachHangButton.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.thongTinKHLabel)
            make.height.equalTo(20)
            make.bottom.equalToSuperview()
        }
    }
    
}
