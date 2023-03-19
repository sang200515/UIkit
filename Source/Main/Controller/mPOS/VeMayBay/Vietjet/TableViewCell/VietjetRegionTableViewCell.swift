//
//  VietjetRegionTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 19/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetRegionTableViewCell: UITableViewCell {

    @IBOutlet weak var lbRegion: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    
    var expandButtonDidPressed: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(isDomestic: Bool, isExpand: Bool) {
        lbRegion.text = isDomestic ? "Việt Nam" : "Quốc Tế"
        imgArrow.image = isExpand ? UIImage(named: "up_arrow_ic") :
        UIImage(named: "down_arrow_ic")
    }
    
    @IBAction func expandButtonPressed(_ sender: Any) {
        expandButtonDidPressed?()
    }
}
