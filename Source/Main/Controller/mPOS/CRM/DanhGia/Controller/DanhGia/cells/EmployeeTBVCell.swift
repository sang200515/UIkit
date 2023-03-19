//
//  LaprapPCCell.swift
//  fptshop
//
//  Created by Sang Truong on 10/7/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class EmployeeTBVCell: UITableViewCell {
	@IBOutlet weak var mainView: UIView!
	@IBOutlet weak var employeeLabel: UILabel!
	@IBOutlet weak var emailLabel: UILabel!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var roomLabel: UILabel!
	@IBOutlet weak var positionLabel: UILabel!
	override func awakeFromNib() {
		super.awakeFromNib()
			// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

			// Configure the view for the selected state
	}

	func bindCell(item:CustomerEveluateModel){
		contentView.layer.masksToBounds = false 
		mainView.dropShadowV2()
		employeeLabel.text = item.fullName ?? ""
		emailLabel.text = item.email ?? ""
		phoneLabel.text = item.phone ?? ""
		roomLabel.text = item.phongBan ?? ""
		positionLabel.text = item.jobTitle ?? ""
	}
}
