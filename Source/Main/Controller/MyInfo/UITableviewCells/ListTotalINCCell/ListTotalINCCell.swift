//
//  ListTotalINCCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/25/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListTotalINCCell: BaseTableCell {

    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.COLORS.text_gray
        return view
    }()
    
    let lbTitleINC: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_14)
        label.textColor = Constants.COLORS.black_main
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let lbValueINC: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: Constants.TextSizes.size_14)
        label.textColor = Constants.COLORS.main_red_my_info
        label.textAlignment = .right
        return label
    }()
    
    override func setupCell() {
        super.setupCell()
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(lineView)
        lineView.myCustomAnchor(top: self.contentView.topAnchor, leading: self.contentView.leadingAnchor, trailing: nil, bottom: self.contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 20, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 1.5, heightConstant: 0)
        
        self.contentView.addSubview(lbTitleINC)
        lbTitleINC.myCustomAnchor(top: contentView.topAnchor, leading: lineView.leadingAnchor, trailing: nil, bottom: contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 4, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.contentView.addSubview(lbValueINC)
        lbValueINC.myCustomAnchor(top: lbTitleINC.topAnchor, leading: lbTitleINC.trailingAnchor, trailing: self.contentView.trailingAnchor, bottom: contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 100, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        lbValueINC.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func getDetailINCItem(_ data: Child) {
        lbTitleINC.text = data.title
        lbValueINC.text = data.value
    }
    
}
