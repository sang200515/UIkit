//
//  BaseLabel.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 13/05/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

class BaseLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = .darkGray
        self.numberOfLines = 0
        self.font = .systemFont(ofSize: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
