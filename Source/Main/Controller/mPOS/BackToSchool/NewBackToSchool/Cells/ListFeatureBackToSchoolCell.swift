//
//  ListFeatureBackToSchoolCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/19/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListFeatureBackToSchoolCell: BaseCollectionViewCell {
    
    let vImageTitle: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let lbContent: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override func setupView() {
        super.setupView()
        self.setBorder(color: Constants.COLORS.text_gray, borderWidth: 0.5, corner: 0)
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        self.addSubview(vImageTitle)
        vImageTitle.myCustomAnchor(top: self.topAnchor, leading: nil, trailing: nil, bottom: nil, centerX: self.centerXAnchor, centerY: nil, width: nil, height: nil, topConstant: 10, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 30, heightConstant: 30)
        self.addSubview(lbContent)
        lbContent.myCustomAnchor(top: vImageTitle.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 2, leadingConstant: 1, trailingConstant: 1, bottomConstant: 2, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupListFeatureCollectionViewCell(image: UIImage?, content: String? = "") {
        self.vImageTitle.image = image
        self.lbContent.loadWith(text: content, textColor: Constants.COLORS.text_gray, font: UIFont.regularFontOfSize(ofSize: 11), textAlignment: .center)
    }
    
}

