//
//  ThongTinDonHangMiraeCompleteTableViewCell.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 17/05/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ThongTinDonHangMiraeCompleteTableViewCell : UITableViewCell {
    
    var model:ThongTinDonHangMiraeEntity.Order? {
        didSet {
            self.bindData()
        }
    }
    
    var isLast:Bool = false
    
    let sttLabel:BaseLabel = {
        let label = BaseLabel()
        label.textAlignment = .center
        return label
    }()
    
    let tenSPLabel:BaseLabel = {
        let label = BaseLabel()
        return label
    }()
    
    let imeiSPLabel:BaseLabel = {
        let label = BaseLabel()
        label.textColor = .lightGray
        return label
    }()
    
    let giaSPLabel:BaseLabel = {
        let label = BaseLabel()
        label.textColor = .red
        return label
    }()
    
    let soLuongLabel:BaseLabel = {
        let label = BaseLabel()
        label.textColor = .red
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
        self.addSubview(self.imeiSPLabel)
        self.addSubview(self.giaSPLabel)
        self.addSubview(self.imeiSPLabel)
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
        self.imeiSPLabel.snp.makeConstraints { make in
            make.top.equalTo(self.tenSPLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.tenSPLabel)
        }
        self.giaSPLabel.snp.makeConstraints { make in
            make.top.equalTo(self.imeiSPLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.imeiSPLabel)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo((UIScreen.main.bounds.width - 40) / 2)
        }
        self.soLuongLabel.snp.makeConstraints { make in
            make.top.equalTo(self.giaSPLabel)
            make.leading.equalTo(self.giaSPLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func bindData(){
        self.tenSPLabel.text = "\(self.model?.itemCode ?? "") - \(self.model?.itemName ?? "")"
		if model?.is_Hot ?? false {
			let imageAttachment = NSTextAttachment()
			imageAttachment.image = UIImage(named: "ic_hot3")
			let imageString = NSAttributedString(attachment: imageAttachment)
			imageAttachment.bounds = CGRect(x: -10, y: 0, width: 65, height: 23)
			let textString = NSAttributedString(string: " \(self.model?.itemCode ?? "") - \(self.model?.itemName ?? "")")
			let combinedString = NSMutableAttributedString()
			combinedString.append(imageString)
			combinedString.append(textString)
			tenSPLabel.text = ""
			tenSPLabel.attributedText = combinedString
			tenSPLabel.snp.updateConstraints { make in
				make.top.equalToSuperview().offset(10)
				make.leading.equalTo(self.sttLabel.snp.trailing).offset(10)
				make.trailing.equalToSuperview().offset(-10)
			}

		}
        self.imeiSPLabel.text = "IMEI : -\(self.model?.imei ?? "")"
        self.giaSPLabel.text = Common.convertCurrencyDoubleV2(value: self.model?.price ?? 0)
        self.soLuongLabel.text = "SL : \(self.model?.quantity ?? 0)"
        if self.isLast {
            self.addBottomBorder(with: .clear, andWidth: 1)
        }else {
            self.addBottomBorder(with: .mainGreen, andWidth: 1)
        }
    }
}
