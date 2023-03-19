//
//  TestContentViolationCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/31/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class TestContentViolationCell: BaseTableCell {

    let lbContentTest: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        return label
    }()
    
    override func setupCell() {
        super.setupCell()
        self.addSubview(lbContentTest)
        lbContentTest.myCustomAnchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 16, trailingConstant: 4, bottomConstant: 4, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func getDataContentTest(_ content: String?) {
        lbContentTest.text = content
    }
    
}
