//
//  UserviceCollectionViewCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/12/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class UserviceCollectionViewCell: BaseCollectionViewCell {
    
    let vImageTitle: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let lbContent: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    override func setupView() {
        super.setupView()
        self.setupBorder(color: Constants.COLORS.text_gray, width: 0.5, cornerRadius: 0)
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        self.addSubview(vImageTitle)
        vImageTitle.myCustomAnchor(top: self.topAnchor, leading: nil, trailing: nil, bottom: nil, centerX: self.centerXAnchor, centerY: nil, width: nil, height: nil, topConstant: 10, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 30, heightConstant: 30)
        self.addSubview(lbContent)
        lbContent.myCustomAnchor(top: vImageTitle.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 8, trailingConstant: 8, bottomConstant: 8, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupListFeatureCollectionViewCell(image: UIImage?, content: String? = "") {
        self.vImageTitle.image = image
        self.lbContent.loadWith(text: content, textColor: Constants.COLORS.text_gray, font: UIFont.regularFont(size: Constants.TextSizes.size_13), textAlignment: .center)
    }

}
