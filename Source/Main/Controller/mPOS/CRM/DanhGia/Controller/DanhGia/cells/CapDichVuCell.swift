//
//  CapDichVuCell.swift
//  QuickCode
//
//  Created by Sang Trương on 02/11/2022.
//

import UIKit

class CapDichVuCell: UITableViewCell {
	@IBOutlet weak var titleLabel:UILabel!
	@IBOutlet weak var noteLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		self.addBottomBorder(with: UIColor.lightGray, andWidth: 0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
