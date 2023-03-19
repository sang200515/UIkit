//
//  ThongTinDonHangMiraeView.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 20/04/2022.
//

import UIKit

class ThongTinDonHangMiraeView : UIView {
    
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
    
    let thongTinVoucherLabel:TitleLabel = {
        let label = TitleLabel()
        label.text = "THÔNG TIN VOUCHER"
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
        tableView.separatorColor = .clear
        tableView.register(ThongTinDonHangMiraeTableViewCell.self,
                           forCellReuseIdentifier: Common.TraGopMirae.identifierTableViewCell.thongTinDonHang)
        tableView.isScrollEnabled = false
        return tableView 
    }()
    
    lazy var voucherTableView:TableViewAutoHeight = {
        let tableView = TableViewAutoHeight()
        tableView.register(ItemVoucherNoPriceTableViewCell.self,
                           forCellReuseIdentifier: "ItemVoucherNoPriceTableViewCell")
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    lazy var themVoucherButton:UIButton = {
        let button = UIButton()
        button.underline(title: "Thêm Voucher")
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    let goiTraGopTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.titleTextField = "Chọn gói trả góp"
        textField.styleTextField = .roundedRect
        textField.hideLineView = true
        textField.isSelected = true
        textField.tag = 0
        textField.iconImage = UIImage(named: "arrowDropICON")
        return textField
    }()
    
    let kyHanTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.titleTextField = "Kỳ hạn trả góp"
        textField.styleTextField = .roundedRect
        textField.hideLineView = true
        textField.tag = 1
        textField.isSelected = true
        textField.iconImage = UIImage(named: "arrowDropICON")
        return textField
    }()
    
    let noteLabel:BaseLabel = {
        let label = BaseLabel()
        label.textColor = .lightGray
        label.font = .italicSystemFont(ofSize: 15)
        label.text = "Lãi suất 0% / Trả trước 30-70%"
        return label
    }()
    
    let soTienTraTruocTextField:InputInfoTextField = {
        let textField = InputInfoTextField()
        textField.titleTextField = "Số tiền trả trước"
        textField.isCurrency = true
        return textField
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
        label.text = "Số tiền đặt cọc :"
        return label
    }()

    let datCocResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "0"
        label.textColor = .red
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
        label.text = "0"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .red
        label.textAlignment = .right
        return label
    }()
    
    lazy var kiemTraKhuyenMaiButton:BaseButton = {
        let button = BaseButton()
        button.setTitle("KIỂM TRA KHUYẾN MÃI", for: .normal)
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
        self.scrollView.addSubview(self.thongTinVoucherLabel)
        self.scrollView.addSubview(self.themVoucherButton)
        self.scrollView.addSubview(self.voucherTableView)
        self.scrollView.addSubview(self.thongTinTraGopLabel)
        self.scrollView.addSubview(self.goiTraGopTextField)
        self.scrollView.addSubview(self.kyHanTextField)
        self.scrollView.addSubview(self.noteLabel)
        self.scrollView.addSubview(self.soTienTraTruocTextField)
        self.scrollView.addSubview(self.thongTinThanhToanLabel)
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
        self.scrollView.addSubview(self.kiemTraKhuyenMaiButton)
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
        self.thongTinVoucherLabel.snp.makeConstraints { make in
            make.top.equalTo(self.donHangTableView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.thongTinKHLabel)
        }
        self.themVoucherButton.snp.makeConstraints { make in
            make.top.equalTo(self.thongTinVoucherLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.thongTinKHLabel)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        
        self.voucherTableView.snp.makeConstraints { make in
            make.top.equalTo(self.themVoucherButton.snp.bottom).offset(5)
            make.leading.trailing.equalTo(self.donHangTableView)
        }

        self.thongTinTraGopLabel.snp.makeConstraints { make in
            make.top.equalTo(self.voucherTableView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.thongTinKHLabel)
        }
        self.goiTraGopTextField.snp.makeConstraints { make in
            make.top.equalTo(self.thongTinTraGopLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.thongTinKHLabel)
            make.height.equalTo(Common.TraGopMirae.Padding.heightTextField)
        }
        self.kyHanTextField.snp.makeConstraints { make in
            make.top.equalTo(self.goiTraGopTextField.snp.bottom).offset(15)
            make.leading.trailing.equalTo(self.thongTinKHLabel)
            make.height.equalTo(Common.TraGopMirae.Padding.heightTextField)
        }
        self.noteLabel.snp.makeConstraints { make in
            make.top.equalTo(self.kyHanTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.thongTinKHLabel)
        }
        self.soTienTraTruocTextField.snp.makeConstraints { make in
            make.top.equalTo(self.noteLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.thongTinKHLabel)
            make.height.equalTo(Common.TraGopMirae.Padding.heightTextField)
        }
        self.thongTinThanhToanLabel.snp.makeConstraints { make in
            make.top.equalTo(self.soTienTraTruocTextField.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.thongTinKHLabel)
        }
        self.thanhTienLabel.snp.makeConstraints { make in
            make.top.equalTo(self.thongTinThanhToanLabel.snp.bottom).offset(10)
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
        self.kiemTraKhuyenMaiButton.snp.makeConstraints { make in
            make.top.equalTo(self.tongTienResultLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.thongTinKHLabel)
            make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
        }
        self.bottomView.snp.makeConstraints { make in
            make.top.equalTo(self.kiemTraKhuyenMaiButton.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.thongTinKHLabel)
            make.height.equalTo(20)
            make.bottom.equalToSuperview()
        }
    }
}
