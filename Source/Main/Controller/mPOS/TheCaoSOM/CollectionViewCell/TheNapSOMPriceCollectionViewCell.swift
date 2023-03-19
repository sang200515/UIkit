//
//  TheNapSOMPriceCollectionViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class TheNapSOMPriceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(product: TheNapSOMProduct, isSelected: Bool) {
        vBackground.backgroundColor = isSelected ? UIColor(hexString: "109E59") : .white
        lbPrice.textColor = isSelected ? .white : .black
        
        lbPrice.text = product.name
    }
}
