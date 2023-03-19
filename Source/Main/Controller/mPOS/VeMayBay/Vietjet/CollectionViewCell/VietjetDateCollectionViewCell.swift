//
//  VietjetDateCollectionViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 19/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetDateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    
    override var isSelected: Bool {
        didSet {
            self.vBackground.backgroundColor = isSelected ? UIColor(hexString: "04AB6E") : .clear
            self.lbDay.textColor = isSelected ? .white : .black
            self.lbDate.textColor = isSelected ? .white : .black
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vBackground.roundCorners(.allCorners, radius: 5)
    }

    func setupCell(_ date: Date) {
        lbDay.text = date.getDayOfWeek().getDayOfWeekString()
        lbDate.text = date.stringWith(format: "dd/MM/yyyy")
    }
}

