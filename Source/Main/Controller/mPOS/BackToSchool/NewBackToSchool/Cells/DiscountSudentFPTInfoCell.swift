//
//  DiscountInfoCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/20/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DiscountSudentFPTInfoCell: BaseTableCell {

    let lbDiscount: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.text = "% Giảm giá:"
        return label
    }()
    
    let lbStatus: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.text = "Trạng thái: "
        return label
    }()
    
    let lbDiscountValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.text = ""
        label.textAlignment = .right
        label.textColor = .red
        return label
    }()
    
    let lbStatusValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.text = ""
        label.textAlignment = .right
        label.textColor = .red
        return label
    }()
    
    override func setupCell() {
        super.setupCell()
        setupStackView()
    }
    
    fileprivate func setupStackView() {
//        let stackViewDiscount = UIStackView(arrangedSubviews: [lbDiscount, lbDiscountValue])
//        stackViewDiscount.axis = .horizontal
//        stackViewDiscount.distribution = .fill
//        stackViewDiscount.spacing = 30
//
        let stackViewStatus = UIStackView(arrangedSubviews: [lbStatus, lbStatusValue])
        stackViewStatus.axis = .horizontal
        stackViewStatus.distribution = .fill
        stackViewStatus.spacing = 30
        
        let stackViewContainer = UIStackView(arrangedSubviews: [stackViewStatus])
        stackViewContainer.axis = .vertical
        stackViewContainer.distribution = .fillEqually
        stackViewContainer.spacing = 8
        
        self.contentView.addSubview(stackViewContainer)
        stackViewContainer.myCustomAnchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 8, leadingConstant: 8, trailingConstant: 8, bottomConstant: 8, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func getValueData(_ valueDiscount: String, valueStatus: String) {
        lbDiscountValue.text = "\(valueDiscount)%"
        if valueStatus == "Chưa cấp Voucher" {
            lbStatusValue.textColor = UIColor(red: 158/255, green: 0/255, blue: 14/255, alpha: 1)
        } else if valueStatus == "Đã cấp Voucher" {
            lbStatusValue.textColor = UIColor(red: 20/255, green: 100/255, blue: 174/255, alpha: 1)
        } else if valueStatus == "Đã sử dụng" {
            lbStatusValue.textColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        } else {
            lbStatusValue.textColor = UIColor(red: 158/255, green: 0/255, blue: 14/255, alpha: 1)
        }
        lbStatusValue.text = valueStatus
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
