//
//  ThongTinKhuyenMaiMiraeTableViewCell.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 21/04/2022.
//

import UIKit

class ThongTinKhuyenMaiMiraeTableViewCell : UITableViewCell {
    
    var isLast:Bool = false
    
    var model:ThongTinDonHangMiraeEntity.Promotion? {
        didSet {
            self.bindData()
        }
    }
    
    let sttLabel:BaseLabel = {
        let label = BaseLabel()
        label.textAlignment = .center
        return label
    }()
    
    let tenSPLabel:BaseLabel = {
        let label = BaseLabel()
        return label
    }()
    
    let soLuongLabel:BaseLabel = {
        let label = BaseLabel()
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addView()
        self.autoLayout()
        self.sttLabel.addRightBorder(with: .mainGreen, andWidth: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView(){
        self.addSubview(self.sttLabel)
        self.addSubview(self.tenSPLabel)
        self.addSubview(self.soLuongLabel)
    }
    private func autoLayout(){
        self.sttLabel.snp.makeConstraints { make in
            make.leading.bottom.top.equalToSuperview()
            make.width.equalTo(40)
        }
        self.tenSPLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(self.sttLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        self.soLuongLabel.snp.makeConstraints { make in
            make.top.equalTo(self.tenSPLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.tenSPLabel)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
    private func bindData(){
        self.tenSPLabel.text = self.model?.itemName ?? ""
        self.soLuongLabel.text = "Số lượng : \(self.model?.quantity ?? 0)"
        self.sttLabel.addRightBorder(with: .mainGreen, andWidth: 1)
        if self.isLast {
            self.addBottomBorder(with: .clear, andWidth: 1)
        }else {
            self.addBottomBorder(with: .mainGreen, andWidth: 1)
        }
    }
    
}
