//
//  TheNapSOMProductCollectionViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class TheNapSOMProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(item: TheNapSOMItem, isSelected: Bool) {
        vBackground.backgroundColor = isSelected ? UIColor(hexString: "109E59") : .lightGray
        
        if let decodedData = Data(base64Encoded: item.extraProperties.imageBase64, options: .ignoreUnknownCharacters) {
            imgLogo.image = UIImage(data: decodedData)
        }
    }
}
