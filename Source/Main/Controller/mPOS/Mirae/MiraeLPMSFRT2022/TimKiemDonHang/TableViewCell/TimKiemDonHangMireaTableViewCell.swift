//
//  TimKiemDonHangMireaTableViewCell.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 12/05/2022.
//

import UIKit

class TimKiemDonHangMireaTableViewCell : UITableViewCell {
    
    var model:TimKiemDonHangHangMireaEntity.DataTimKiemDonHangModel? {
        didSet {
            self.bindingData()
        }
    }
    
    let viewBoder:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    let soPOSLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Số POS :"
        return label
    }()
 
    let soPOSLabelResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let ecomNumberLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "ECOM Number :"
        return label
    }()
    
    let ecomNumberResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let soDTLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Số ĐT :"
        return label
    }()
    
    let soDTResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let cardNameLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Tên :"
        return label
    }()
    
    let cardNameResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let ngayTaoLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Ngày tạo :"
        return label
    }()
    
    let ngayTaoResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let tienCocLabel:BaseLabel = {
        let label = BaseLabel()
        label.text = "Tiền cọc :"
        return label
    }()
    
    let tienCocResultLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addView()
        self.autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView(){
        self.addSubview(self.soPOSLabel)
        self.addSubview(self.soPOSLabelResultLabel)
        self.addSubview(self.ecomNumberLabel)
        self.addSubview(self.ecomNumberResultLabel)
        self.addSubview(self.soDTLabel)
        self.addSubview(self.soDTResultLabel)
        self.addSubview(self.cardNameLabel)
        self.addSubview(self.cardNameResultLabel)
        self.addSubview(self.ngayTaoLabel)
        self.addSubview(self.ngayTaoResultLabel)
        self.addSubview(self.tienCocLabel)
        self.addSubview(self.tienCocResultLabel)
        self.addSubview(self.viewBoder)
        self.insertSubview(self.viewBoder, at: 0)
    }
    
    private func autoLayout(){
       
        self.soPOSLabel.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.top.equalTo(self).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        self.soPOSLabelResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.soPOSLabel)
            make.leading.equalTo(self.soPOSLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(20)
        }
        self.ecomNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.soPOSLabel)
            make.width.equalTo(150)
            make.top.equalTo(self.soPOSLabelResultLabel.snp.bottom).offset(10)
        }
        self.ecomNumberResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.ecomNumberLabel)
            make.leading.equalTo(self.ecomNumberLabel.snp.trailing)
            make.trailing.equalTo(self.soPOSLabelResultLabel)
            make.height.greaterThanOrEqualTo(20)
        }
        self.soDTLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.ecomNumberLabel)
            make.width.equalTo(150)
            make.top.equalTo(self.ecomNumberResultLabel.snp.bottom).offset(10)
        }
        self.soDTResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.soDTLabel)
            make.leading.equalTo(self.soDTLabel.snp.trailing)
            make.trailing.equalTo(self.soPOSLabelResultLabel)
            make.height.greaterThanOrEqualTo(20)
        }
        self.cardNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.soDTResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.soDTLabel)
            make.width.equalTo(150)
            make.height.greaterThanOrEqualTo(20)
        }
        self.cardNameResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cardNameLabel)
            make.leading.equalTo(self.cardNameLabel.snp.trailing)
            make.trailing.equalTo(self.soPOSLabelResultLabel)
            make.height.greaterThanOrEqualTo(20)
        }
        self.ngayTaoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cardNameResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.soPOSLabel)
            make.width.equalTo(150)
        }
        self.ngayTaoResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.ngayTaoLabel)
            make.leading.equalTo(self.ngayTaoLabel.snp.trailing)
            make.trailing.equalTo(self.soPOSLabelResultLabel)
            make.height.greaterThanOrEqualTo(20)
        }
        self.tienCocLabel.snp.makeConstraints { make in
            make.top.equalTo(self.ngayTaoResultLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.soPOSLabel)
            make.width.equalTo(150)
        }
        self.tienCocResultLabel.snp.makeConstraints { make in
            make.top.equalTo(self.tienCocLabel)
            make.leading.equalTo(self.tienCocLabel.snp.trailing)
            make.trailing.equalTo(self.ngayTaoResultLabel)
            make.height.greaterThanOrEqualTo(20)
            make.bottom.equalToSuperview().offset(-10)
        }
        self.viewBoder.snp.makeConstraints { make in
            make.top.equalTo(self.soPOSLabel).offset(-5)
            make.leading.equalTo(self.tienCocLabel).offset(-10)
            make.bottom.equalTo(self.tienCocResultLabel).offset(5)
            make.trailing.equalTo(self.tienCocResultLabel).offset(10)
        }
    }
    
    private func bindingData(){
        self.soPOSLabelResultLabel.text = "\(self.model?.soPos ?? 0)"
        self.ngayTaoResultLabel.text = self.model?.createDate
        self.tienCocResultLabel.text = Common.convertCurrencyDouble(value: Double(self.model?.soTienCoc ?? 0))
        self.ecomNumberResultLabel.text = "\(self.model?.ecomNum ?? 0)"
        self.soDTResultLabel.text = "\(self.model?.sdt ?? "0")"
        self.cardNameResultLabel.text = self.model?.cardName ?? ""
    }
}
