//
//  BaoKimPointCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 23/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class BaoKimPointCell: UITableViewCell {

    @IBOutlet weak var imgSelection: UIImageView!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    
    private let selectedImage: UIImage = UIImage(named: "selected_radio_ic")!
    private let unselectedImage: UIImage = UIImage(named: "unselected_radio_ic")!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(point: BaoKimDropOffPointsatArrive, isSelected: Bool) {
        imgSelection.image = isSelected ? selectedImage : unselectedImage
        lbTime.text = String(point.realTime.prefix(5))
        lbName.text = point.name
        lbLocation.text = point.address
    }
}
