//
//  DanhSachCamKetView.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 17/10/2022.
//

import UIKit

class DanhSachCamKetView : UIView {
    
    let identifier:String = "DanhSachCamKetTableViewCell"
    
    let dropView:SelectDropDownCoreICT = {
        let view = SelectDropDownCoreICT()
        return view
    }()
    
    lazy var searchTextField:UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 15)
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.placeholder = "Nhập thông tin cần tìm"
        return textField
    }()
    
    lazy var searchButton:UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = Common.Colors.CamKet.green
        button.setImage(UIImage(named: "searchCoreICON"), for: .normal)
        return button
    }()
    
    lazy var tableView:BaseTableView = {
        let tableView = BaseTableView()
        tableView.backgroundColor = Common.Colors.CamKet.background
        tableView.register(DanhSachCamKetTableViewCell.self, forCellReuseIdentifier: self.identifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.dropView)
        self.addSubview(self.searchButton)
        self.addSubview(self.searchTextField)
        self.addSubview(self.tableView)
        
        self.dropView.snp.makeConstraints { make in
            make.leading.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(130)
        }
        self.searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.dropView)
            make.height.equalTo(42)
            make.width.equalTo(42)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
        self.searchTextField.snp.makeConstraints { make in
            make.centerY.equalTo(self.searchButton)
            make.height.equalTo(42)
            make.leading.equalTo(self.dropView.snp.trailing).offset(10)
            make.trailing.equalTo(self.searchButton.snp.leading)
        }
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.dropView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
