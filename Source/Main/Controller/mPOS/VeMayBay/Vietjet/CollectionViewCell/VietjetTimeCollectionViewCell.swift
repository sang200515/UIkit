//
//  VietjetTimeCollectionViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 19/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetTimeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vBackground.roundCorners(.allCorners, radius: 20)
    }

    func setupCell(_ travel: VietjetTravel) {
        lbTime.text = travel.departureTime
        let price = travel.fareOptions.first?.fareCharges.first?.totalAmountFRT ?? 0
        lbPrice.text = "\(Common.convertCurrencyV2(value: price)) VNĐ"
    }
}
