//
//  HeaderSectionUserserviceView.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/12/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HeaderSectionUserviceView: UICollectionReusableView {
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(netHex: 0xEEEEEE)
        addSubview(label)
        label.myCustomAnchor(top: nil, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: nil, centerX: nil, centerY: self.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 16, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupTitle(_ titleHeaderSection: String) {
        label.text = titleHeaderSection
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
