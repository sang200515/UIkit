//
//  ShinhanPromotionCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 09/02/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ShinhanPromotionCell: UITableViewCell {

    @IBOutlet weak var subTitleCell: UILabel!
    @IBOutlet weak var titlecell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindCell() {
        titlecell.text = "Giảm giá: 3,500,000 VND"
        subTitleCell.text = "SL: 1 - (Khi mua: DTDĐ Samsung Note 8)"
    }
}
