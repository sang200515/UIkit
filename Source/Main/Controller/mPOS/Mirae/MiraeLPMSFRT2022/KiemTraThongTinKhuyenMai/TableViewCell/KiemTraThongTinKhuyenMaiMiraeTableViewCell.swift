//
//  KiemTraThongTinKhuyenMaiMiraeTableViewCell.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 20/04/2022.
//

import UIKit

class KiemTraThongTinKhuyenMaiMiraeTableViewCell : UITableViewCell {
    
    var model:TestSubModel? {
        didSet {
            self.bindingData()
        }
    }
    
    let titleLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    let subTitleLabel:BaseLabel = {
        let label = BaseLabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addView()
        self.autoLayout()
        self.bindingData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView(){
        self.addSubview(self.titleLabel)
        self.addSubview(self.subTitleLabel)
        
        self.selectionStyle = .none
        self.backgroundColor = .lightGray.withAlphaComponent(0.1)
    }
    
    private func autoLayout(){
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-10)
        }
        self.subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.trailing.equalTo(self.titleLabel)
            make.leading.equalTo(self.titleLabel).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func bindingData(){
        self.titleLabel.text = self.model?.title ?? ""
        self.subTitleLabel.text = self.model?.subTitle ?? ""
    }
    
}
