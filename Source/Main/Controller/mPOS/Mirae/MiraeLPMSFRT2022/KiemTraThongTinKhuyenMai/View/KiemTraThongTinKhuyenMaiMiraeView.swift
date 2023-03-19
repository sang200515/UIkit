//
//  KiemTraThongTinKhuyenMaiMiraeView.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 20/04/2022.
//

import UIKit

class KiemTraThongTinKhuyenMaiMiraeView : UIView {
    
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(KiemTraThongTinKhuyenMaiMiraeTableViewCell.self,
                           forCellReuseIdentifier: Common.TraGopMirae.identifierTableViewCell.kiemTraThongTinKhuyenMai)
        return tableView
    }()
    
    lazy var accectButton:BaseButton = {
        let button = BaseButton()
        button.setTitle("TIẾP TỤC", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.autoLayout()
    }
    
    private func addView(){
        self.addSubview(self.accectButton)
        self.addSubview(self.tableView)
    }
    
    private func autoLayout(){
        self.accectButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
        }
        self.tableView.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.accectButton.snp.top)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
