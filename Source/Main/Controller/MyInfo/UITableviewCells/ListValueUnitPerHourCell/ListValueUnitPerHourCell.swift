//
//  ListValueUnitPerHourCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListValueUnitPerHourCell: BaseTableCell {
    
    let lbTitleUnitPerHour: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_12)
        label.textColor = Constants.COLORS.black_main
        return label
    }()
    
    let lbValueUnitPerHour: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 12)
        label.textColor = Constants.COLORS.main_red_my_info
        return label
    }()
    
    override func setupCell() {
        super.setupCell()
        self.contentView.backgroundColor = .clear
        setupStackView()
        
    }
    
    func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [lbTitleUnitPerHour, lbValueUnitPerHour])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.backgroundColor = .clear
        
        self.contentView.addSubview(stackView)
        stackView.fill(left: 26, top: 10, right: 0, bottom: 10)
        
    }
    
    func getDataDetailUnitPerHour(_ title: String, value: String) {
        lbTitleUnitPerHour.text = title
        lbValueUnitPerHour.text = value
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
