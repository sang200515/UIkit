//
//  VietjetPromotionTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetPromotionTableViewCell: UITableViewCell {

    @IBOutlet weak var lbIndex: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbQuantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
