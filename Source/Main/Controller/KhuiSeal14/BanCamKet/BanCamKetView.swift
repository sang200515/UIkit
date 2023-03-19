//
//  BanCamKetView.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 17/10/2022.
//

import UIKit

class BanCamKetView : UIView {
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.contentInsetAdjustmentBehavior = .never
        sv.keyboardDismissMode = .interactive
        sv.backgroundColor = UIColor(hexString: "#F5F5F5")
        return sv
    }()
    
    let customerInfoHeadr:HeaderCoreICT = {
        let header = HeaderCoreICT()
        header.backgroundColor = UIColor(hexString: "#EDF5F2")
        header.titleString = "Thông tin khách hàng"
        return header
    }()
    
    let contentHeadr:HeaderCoreICT = {
        let header = HeaderCoreICT()
        header.backgroundColor = UIColor(hexString: "#EDF5F2")
        header.titleString = "Nội dung cam kết"
        return header
    }()
    
    let signHeadr:HeaderCoreICT = {
        let header = HeaderCoreICT()
        header.backgroundColor = UIColor(hexString: "#EDF5F2")
        header.titleString = "Chữ ký khách hàng"
        return header
    }()
    
    lazy var nameCustomerTextField: TextFieldCoreICT = {
        let textField = TextFieldCoreICT()
        textField.titleString = "Họ và tên khách hàng"
        textField.isRequeied = true
        textField.placeholder = "Nhập họ tên khách hàng"
        return textField
    }()
    
    lazy var cmndTextField: TextFieldCoreICT = {
        let textField = TextFieldCoreICT()
        textField.typeKeyBoard = .numberPad
        textField.titleString = "Số CMND/CCCD"
        textField.isRequeied = true
        textField.placeholder = "Nhập Số CMND/CCCD"
        return textField
    }()
    
    lazy var ngayCapCMNDTextField: TextFieldCoreICT = {
        let textField = TextFieldCoreICT()
        textField.titleString = "Ngày cấp CMND/CCCD"
        textField.isRequeied = true
        textField.placeholder = "Nhập ngày cấp CMND/CCCD"
        return textField
    }()
    
    lazy var noiCapCMNDTextField: TextFieldCoreICT = {
        let textField = TextFieldCoreICT()
        textField.titleString = "Nơi cấp CMND/CCCD"
        textField.isRequeied = true
        textField.placeholder = "Nhập nơi cấp CMND/CCCD"
        return textField
    }()
    
    lazy var phoneCustomerTextField: TextFieldCoreICT = {
        let textField = TextFieldCoreICT()
        textField.typeKeyBoard = .numberPad
        textField.titleString = "Số điện thoại"
        textField.isRequeied = true
        textField.placeholder = "Nhập số điện thoại"
        return textField
    }()
    
    lazy var sanPhamTextField: TextFieldCoreICT = {
        let textField = TextFieldCoreICT()
        textField.titleString = "Sản phẩm"
        textField.isDisableField = true
        textField.isRequeied = false
        textField.text = "Điện thoại iPhone"
        return textField
    }()
    
    lazy var contentLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let signView:SignatureCoreICT = {
        let view = SignatureCoreICT()
        return view
    }()
    
    let stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }()
    
    lazy var optButton:BaseButton = {
        let button = BaseButton()
        button.backgroundColor = UIColor(hexString: "#4263EC")
        button.title = "Lấy mã OTP"
        return button
    }()
    
    lazy var finalButton:BaseButton = {
        let button = BaseButton()
        button.backgroundColor = UIColor(hexString: "#04AB6E")
        button.title = "Hoàn tất biên bản"
        return button
    }()
    
    lazy var sealButton:BaseButton = {
        let button = BaseButton()
        button.backgroundColor = UIColor(hexString: "#04AB6E")
        button.title = "Khách hàng khui seal"
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.customerInfoHeadr)
        self.scrollView.addSubview(self.nameCustomerTextField)
        self.scrollView.addSubview(self.cmndTextField)
        self.scrollView.addSubview(self.ngayCapCMNDTextField)
        self.scrollView.addSubview(self.noiCapCMNDTextField)
        self.scrollView.addSubview(self.phoneCustomerTextField)
        self.scrollView.addSubview(self.sanPhamTextField)
        self.scrollView.addSubview(self.contentHeadr)
        self.scrollView.addSubview(self.contentLabel)
        self.scrollView.addSubview(self.signHeadr)
        self.scrollView.addSubview(self.signView)
        self.scrollView.addSubview(self.stackView)
        
        self.scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        self.customerInfoHeadr.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(self)
            make.height.equalTo(50)
        }
        self.nameCustomerTextField.snp.makeConstraints { make in
            make.top.equalTo(self.customerInfoHeadr.snp.bottom).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(70)
        }
        self.cmndTextField.snp.makeConstraints { make in
            make.top.equalTo(self.nameCustomerTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nameCustomerTextField)
            make.height.equalTo(70)
        }
        self.ngayCapCMNDTextField.snp.makeConstraints { make in
            make.top.equalTo(self.cmndTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nameCustomerTextField)
            make.height.equalTo(70)
        }
        self.noiCapCMNDTextField.snp.makeConstraints { make in
            make.top.equalTo(self.ngayCapCMNDTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nameCustomerTextField)
            make.height.equalTo(70)
        }
        self.phoneCustomerTextField.snp.makeConstraints { make in
            make.top.equalTo(self.noiCapCMNDTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nameCustomerTextField)
            make.height.equalTo(70)
        }
        self.sanPhamTextField.snp.makeConstraints { make in
            make.top.equalTo(self.phoneCustomerTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.nameCustomerTextField)
            make.height.equalTo(70)
        }
        self.contentHeadr.snp.makeConstraints { make in
            make.top.equalTo(self.sanPhamTextField.snp.bottom).offset(10)
            make.leading.trailing.height.equalTo(self.customerInfoHeadr)
        }
        self.contentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentHeadr.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.sanPhamTextField)
        }
        self.signHeadr.snp.makeConstraints { make in
            make.top.equalTo(self.contentLabel.snp.bottom).offset(10)
            make.leading.trailing.height.equalTo(self.customerInfoHeadr)
        }
        self.signView.snp.makeConstraints { make in
            make.top.equalTo(self.signHeadr.snp.bottom).offset(10)
            make.leading.equalTo(self.contentLabel)
            make.trailing.equalTo(self.contentLabel)
            make.height.equalTo(200)
        }
        self.stackView.snp.makeConstraints { make in
            make.top.equalTo(self.signView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.sanPhamTextField)
            make.bottom.equalToSuperview().offset(-10)
        }
        self.stackView.addArrangedSubview(self.optButton)
        self.stackView.addArrangedSubview(self.finalButton)
        self.stackView.addArrangedSubview(self.sealButton)
        self.optButton.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        self.finalButton.snp.makeConstraints { make in
            make.height.equalTo(self.optButton)
        }
        self.sealButton.snp.makeConstraints { make in
            make.height.equalTo(self.optButton)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
