	//
	//  CalTuVanSanPhamCell.swift
	//  QuickCode
	//
	//  Created by Sang Trương on 26/12/2022.
	//

import UIKit

class CalTuVanSanPhamCell: UITableViewCell {
	var element:CallTuVanSanPhamDataModel? {
		didSet{
			self.bind()
		}
	}
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var codeLabel: UILabel!
	@IBOutlet weak var instalmentLabel: UILabel!
	@IBOutlet weak var tenorLabel: UILabel!
	@IBOutlet weak var modelLabel: UILabel!
	@IBOutlet weak var purchaseDateLabel: UILabel!
	@IBOutlet weak var employeeStackView: UIStackView!
	@IBOutlet weak var employeeLabel: UILabel!
	@IBOutlet weak var statusLabel: UILabel!
	@IBOutlet weak var callButton :UIButton!
	@IBOutlet weak var buttonView :UIView!
	var delegate:callTuVanSanPhamCellDelegate!
	override func awakeFromNib() {
		super.awakeFromNib()
			// Initialization code
		let gesture = UITapGestureRecognizer(target: self, action: #selector(callButtonPressed))
		buttonView.addGestureRecognizer(gesture)
		callButton.imageView?.contentMode = .scaleAspectFit
		self.contentView.dropShadowV2()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

	}

	private func bind(){
		self.phoneLabel.text = "SDT:\(element?.phone ?? "")"
		self.dateLabel.text = "\(element?.callDate ?? "")"
		self.nameLabel.text = element?.customerName ?? ""
		self.instalmentLabel.text = element?.installmentHouse ?? ""
		self.tenorLabel.text = "\(element?.tenure ?? "")"
		self.modelLabel.text = element?.model ?? ""
		self.purchaseDateLabel.text = element?.purchaseDate ?? ""
		self.statusLabel.text = element?.status ?? ""
		self.statusLabel.textColor = UIColor(hexString: "\(element?.statusColor ?? "")")
		self.employeeLabel.text = element?.employeeName ?? ""
		self.contentView.dropShadowV2()
		
	}

	@objc func callButtonPressed(){
		delegate?.callKH(item: element!)
	}

}
protocol callTuVanSanPhamCellDelegate:AnyObject {
	func callKH(item:CallTuVanSanPhamDataModel)
}

