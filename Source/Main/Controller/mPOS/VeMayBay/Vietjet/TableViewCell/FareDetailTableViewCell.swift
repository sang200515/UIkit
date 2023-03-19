//
//  FareDetailTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 10/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class FareDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ detail: FareChargeDetail) {
        lbName.text = detail.fareChargeDetailDescription
        lbPrice.text = "\(Common.convertCurrencyV2(value: detail.totalAmount)) VNĐ"
        lbCount.text = "x\(detail.count)"
    }
}
