//
//  HeaderSectionStudentFPTView.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/20/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HeaderSectionStudentFPTView: BaseView {
    
    let labelTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.1)
        self.addSubview(labelTitle)
        labelTitle.myCustomAnchor(top: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: nil, centerX: nil, centerY: self.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 8, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupTitleView(_ title: String) {
        labelTitle.loadWith(text: title.uppercased(), textColor: Constants.COLORS.light_green, font: UIFont.regularFontOfSize(ofSize: 14), textAlignment: .left)
    }
}
