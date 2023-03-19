//
//  VietjetAirportTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 19/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetAirportTableViewCell: UITableViewCell {

    @IBOutlet weak var lbCity: UILabel!
    @IBOutlet weak var lbCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(_ airport: Departure) {
        lbCity.text = airport.name
        lbCode.text = airport.code
    }
}
