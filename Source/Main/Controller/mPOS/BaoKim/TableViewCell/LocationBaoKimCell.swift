//
//  LocationBaoKimCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 17/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class LocationBaoKimCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgCheck: UIImageView!
    
    private let checked = UIImage(named: "check-1-1")!
    private let unchecked = UIImage(named: "check-2-1")!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(location: String, isSelected: Bool = false, isShow: Bool = false) {
        lbName.text = location
        imgCheck.image = isSelected ? checked : unchecked
        imgCheck.isHidden = !isShow
    }
}
