//
//  BaseCollectionViewCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/15/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        
    }

    required init?(coder: NSCoder) {
        fatalError("Has not been implement")
    }
}
