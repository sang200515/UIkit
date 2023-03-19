//
//  DanhSachCamKetTableViewCell.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 17/10/2022.
//

import UIKit

class DanhSachCamKetTableViewCell : UITableViewCell {
    
    var model:DanhSachCamKetModel? {
        didSet {
            self.bind()
        }
    }
    
    let idLabel:UILabel = {
        let label = UILabel()
        label.text = "ID: 564546484"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = Common.Colors.CamKet.blue
        return label
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Họ và tên KH:"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    let cmndLabel:UILabel = {
        let label = UILabel()
        label.text = "CMND/CCCD:"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    let phoneLabel:UILabel = {
        let label = UILabel()
        label.text = "Số điện thoại:"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.text = "Biên bản kí ngày:"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    let statusLabel:UILabel = {
        let label = UILabel()
        label.text = "Tình trạng đơn hàng:"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    let nameRSLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "FPT Retail"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    let cmndRSLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.text = "241066612"
        return label
    }()
    
    let phoneRSLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.text = "0934871827"
        return label
    }()
    
    let dateRSLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.text = "20-03-1991"
        return label
    }()
    
    let statusRSLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.text = "Chưa hoàn tất"
        label.textAlignment = .right
        label.textColor = .darkGray
        return label
    }()
    
    let lineView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let viewBackGround:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.idLabel)
        self.addSubview(self.lineView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.nameRSLabel)
        self.addSubview(self.cmndLabel)
        self.addSubview(self.cmndRSLabel)
        self.addSubview(self.phoneLabel)
        self.addSubview(self.phoneRSLabel)
        self.addSubview(self.dateLabel)
        self.addSubview(self.dateRSLabel)
        self.addSubview(self.statusLabel)
        self.addSubview(self.statusRSLabel)
        self.addSubview(self.viewBackGround)
        
        self.backgroundColor = Common.Colors.CamKet.background
        let width = (UIScreen.main.bounds.width - 40) / 2
        
        self.idLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        self.lineView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.idLabel)
            make.top.equalTo(self.idLabel.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.lineView.snp.bottom).offset(10)
            make.leading.equalTo(self.idLabel)
            make.width.equalTo(width)
        }
        self.nameRSLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel)
            make.leading.equalTo(self.nameLabel.snp.trailing)
            make.trailing.equalTo(self.idLabel)
            make.height.greaterThanOrEqualTo(20)
        }
        self.cmndLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameRSLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.idLabel)
            make.width.equalTo(width - 40)
        }
        self.cmndRSLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cmndLabel)
            make.leading.equalTo(self.nameLabel.snp.trailing)
            make.trailing.equalTo(self.idLabel)
            make.height.greaterThanOrEqualTo(20)
        }
        self.phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(self.cmndRSLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.idLabel)
            make.width.equalTo(width - 40)
        }
        self.phoneRSLabel.snp.makeConstraints { make in
            make.top.equalTo(self.phoneLabel)
            make.leading.equalTo(self.nameLabel.snp.trailing)
            make.trailing.equalTo(self.idLabel)
            make.height.greaterThanOrEqualTo(20)
        }
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.phoneRSLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.idLabel)
            make.width.equalTo(width - 40)
        }
        self.dateRSLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dateLabel)
            make.leading.equalTo(self.nameLabel.snp.trailing)
            make.trailing.equalTo(self.idLabel)
            make.height.greaterThanOrEqualTo(20)
        }
        self.statusLabel.snp.makeConstraints { make in
            make.top.equalTo(self.dateRSLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.idLabel)
            make.width.equalTo(width - 40)
        }
        self.statusRSLabel.snp.makeConstraints { make in
            make.top.equalTo(self.statusLabel)
            make.leading.equalTo(self.nameLabel.snp.trailing)
            make.trailing.equalTo(self.idLabel)
            make.bottom.equalToSuperview().offset(-20)
            make.height.greaterThanOrEqualTo(20)
        }
        self.viewBackGround.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-5)
            make.trailing.equalToSuperview().offset(-10)
        }
        self.insertSubview(self.viewBackGround, at: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(){
        self.idLabel.text = "ID : \(self.model?.id ?? 0)"
        self.nameRSLabel.text = self.model?.nameCustomer ?? ""
        self.cmndRSLabel.text = self.model?.cmnd ?? ""
        self.phoneRSLabel.text = self.model?.phone ?? ""
        self.dateRSLabel.text = self.model?.dateSign ?? ""
        self.statusRSLabel.text = self.model?.statusName ?? ""
        self.statusRSLabel.textColor = self.model?.statusName == "Hoàn tất đơn" ? Common.Colors.CamKet.green : .red
    }
    
}
