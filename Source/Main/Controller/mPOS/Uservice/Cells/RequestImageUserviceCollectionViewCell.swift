//
//  RequestImageUserviceCollectionViewCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/16/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class RequestImageUserviceCollectionViewCell: BaseCollectionViewCell {

    let imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func setupView() {
        super.setupView()
        self.contentView.addSubview(imgView)
        imgView.fill()
    }
    
    func loadImage(image: UIImage?) {
        if let img = image {
            self.imgView.image = img
        }
    }
}
