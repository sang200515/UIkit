//
//  CheckListCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 25/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CheckListCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageCheck: UIImageView!
    
    func bindCell(item: DSMayType) {
        nameLabel.text = item.textValue
        imageCheck.image = item.isCheck ? UIImage(named: "check-1-1") : UIImage(named: "check-2-1")
    }
    
}
