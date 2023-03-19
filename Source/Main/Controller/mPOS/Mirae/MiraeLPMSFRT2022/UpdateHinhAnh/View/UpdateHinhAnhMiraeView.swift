//
//  UpdateHinhAnhMiraeView.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 19/05/2022.
//

import UIKit

class UpdateHinhAnhMiraeView : UIView {
    
    lazy var hinhDinhKemButton:HeaderInfo = {
        let button = HeaderInfo()
        button.titleHeader.text = "HÌNH ĐÍNH KÈM"
        return button
    }()
    
    lazy var tableView:BaseTableView = {
        let tableView = BaseTableView()
        tableView.register(UpdateHinhAnhTableViewCell.self,
                           forCellReuseIdentifier: Common.TraGopMirae.identifierTableViewCell.updateHinh)
        return tableView
    }()
    
    lazy var updateButton:BaseButton = {
        let button = BaseButton()
        button.setTitle("CẬP NHẬT HÌNH ẢNH", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.hinhDinhKemButton)
        self.addSubview(self.tableView)
        self.addSubview(self.updateButton)
        
        self.hinhDinhKemButton.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(40)
        }
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.hinhDinhKemButton.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-60)
        }
        self.updateButton.snp.makeConstraints { make in
            make.top.equalTo(self.tableView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.hinhDinhKemButton)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
