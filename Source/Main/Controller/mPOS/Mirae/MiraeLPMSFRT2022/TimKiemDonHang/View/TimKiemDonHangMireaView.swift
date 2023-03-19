//
//  TimKiemDonHangMireaView.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 19/04/2022.
//

import UIKit

class TimKiemDonHangMireaView : UIView {
    
    let searchText:InputInfoTextField = {
        let label = InputInfoTextField()
        label.titleTextField = "SĐT/Đơn hàng đặt cọc"
        return label
    }()
    
    lazy var cancelButton:UIButton = {
        let button = UIButton()
        button.setTitle("BỎ QUA", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    lazy var searchButton:UIButton = {
        let button = UIButton()
        button.setTitle("TÌM KIẾM", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.backgroundColor = .mainGreen
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    lazy var tableView:BaseTableView = {
        let tableView = BaseTableView()
        tableView.register(TimKiemDonHangMireaTableViewCell.self, forCellReuseIdentifier: Common.TraGopMirae.identifierTableViewCell.timKiemDonHang)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.searchText)
        self.addSubview(self.cancelButton)
        self.addSubview(self.searchButton)
        self.addSubview(self.tableView)
        self.searchText.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(Common.TraGopMirae.Padding.heightTextField)
        }
        self.cancelButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.centerX).offset(-5)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.top.equalTo(self.searchText.snp.bottom).offset(20)
            make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
        }
        self.searchButton.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX).offset(5)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.top.equalTo(self.searchText.snp.bottom).offset(20)
            make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
        }
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.searchButton.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.searchText)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
