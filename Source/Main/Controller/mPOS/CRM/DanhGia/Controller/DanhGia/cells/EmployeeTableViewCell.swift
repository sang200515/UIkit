//
//  EmployeeTableViewCell.swift
//  QuickCode
//
//  Created by Sang Trương on 02/11/2022.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

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
		employeeLabel.text = item.fullName ?? ""
		emailLabel.text = item.email ?? ""
		phoneLabel.text = item.phone ?? ""
		roomLabel.text = item.phongBan ?? ""
		positionLabel.text = item.jobTitle ?? ""
	}
}
