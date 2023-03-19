//
//  ItemShoporASMCell.swift
//  fptshop
//
//  Created by Sang Trương on 18/11/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ItemShoporASMCell: UITableViewCell {
	@IBOutlet weak var titleLabel:UILabel!
	@IBOutlet weak var mainView:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	func bindCell(item:ListShopDanhGiaModel) {
		self.mainView.dropShadowV2()
		self.titleLabel.text = "\(item.warehouseCode ?? "") - \(item.warehouseName ?? "")"
	}
}
