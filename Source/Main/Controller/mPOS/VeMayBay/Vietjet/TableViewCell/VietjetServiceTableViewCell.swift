//
//  VietjetServiceTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var vHeader: UIView!
    @IBOutlet weak var lbDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vHeader.roundCorners(.allCorners, radius: 2.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ detail: String) {
        lbDetail.text = detail
    }
}
