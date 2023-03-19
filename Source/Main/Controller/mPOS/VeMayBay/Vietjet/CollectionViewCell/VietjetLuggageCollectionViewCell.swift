//
//  VietjetLuggageCollectionViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 20/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetLuggageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vBackground.roundCorners(.allCorners, radius: 10)
    }

    func setupCell(baggage: VietjetBaggage, isSelected: Bool) {
        let selectedImage = UIImage(named: "selected_ic")!
        let unselectedImage = UIImage(named: "unselected_ic")!
        
        lbName.text = baggage.name
        lbPrice.text = "\(Common.convertCurrencyV2(value: baggage.ancillaryCharge.totalAmountFRT)) VNĐ"
        imgSelected.image = isSelected ? selectedImage : unselectedImage
    }
}
