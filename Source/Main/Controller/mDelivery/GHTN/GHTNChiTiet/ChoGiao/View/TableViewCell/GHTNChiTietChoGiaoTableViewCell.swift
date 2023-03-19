//
//  GHTNChiTietChoGiaoTableViewCell.swift
//  FPTShop_GHTN
//
//  Created by Trần Văn Dũng on 11/03/2022.
//

import UIKit

class GHTNChiTietChoGiaoTableViewCell : UITableViewCell {
    
    var model:GHTNChiTietChoGiaoEntity.ChiTietDonHangModel?{
        didSet {
            self.bindingData()
        }
    }
    
    let tenSPLabel:UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let soLuongSPLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainGreen
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let thanhTienLabel:UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let view:UIView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.view.layer.borderColor = UIColor.lightGray.cgColor
        self.view.layer.borderWidth = 0.5
        self.view.layer.cornerRadius = 5
        self.view.layer.masksToBounds = true
        
        self.addSubview(self.tenSPLabel)
        self.addSubview(self.soLuongSPLabel)
        self.addSubview(self.thanhTienLabel)
        self.addSubview(self.view)
        self.tenSPLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(self.frame.width / 2 + 20)
        }
        self.soLuongSPLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.tenSPLabel.snp.trailing).offset(5)
            make.bottom.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(40)
        }
        self.thanhTienLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.soLuongSPLabel.snp.trailing).offset(5)
            make.bottom.top.equalTo(self.tenSPLabel)
            make.trailing.equalToSuperview().offset(-10)
        }
        self.view.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-2)
        }
        
    }
    
    private func bindingData(){
        guard let model = model else {
            return
        }
        let soLuong:Int = Int(model.uQutity ?? 0)
        self.tenSPLabel.text = "\(model.uItmName ?? "")\nIMEI:\(model.uImei ?? "")"
        self.soLuongSPLabel.text = "x\(soLuong)"
        self.thanhTienLabel.text = Common.convertCurrencyDouble(value: model.uTMoney ?? 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
