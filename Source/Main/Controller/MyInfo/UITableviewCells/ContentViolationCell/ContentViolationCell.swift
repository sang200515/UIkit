//
//  ContentViolationCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/31/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ContentViolationCell: BaseTableCell {
    
    let vContent: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let lbContentViolation: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_13)
        return label
    }()
    
    override func setupCell() {
        super.setupCell()
        self.addSubview(vContent)
        vContent.myCustomAnchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        vContent.addSubview(lbContentViolation)
        lbContentViolation.myCustomAnchor(top: vContent.topAnchor, leading: vContent.leadingAnchor, trailing: vContent.trailingAnchor, bottom: vContent.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 16, trailingConstant: 4, bottomConstant: 4, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func getDataContentViolation(_ content: String) {
        self.lbContentViolation.text = content
    }
    
}
