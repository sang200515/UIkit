//
//  EveluateSelectCell.swift
//  QuickCode
//
//  Created by Sang Trương on 01/11/2022.
//

import UIKit

class EveluateSelectCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var noteLabel: UILabel!
	@IBOutlet weak var checkButton: UIButton!
	var model :HangMucGiaTri?
	var didSelectedCell:((Bool) -> Void)?
	var index: Int = 0
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	func bindCell(item: HangMucGiaTri,indexPath:Int) {
		checkButton.setImage(UIImage(named: "unchecked_ic_core"), for: .normal)
		if item.isSelected {
			checkButton.setImage(UIImage(named: "checked_ic_core"), for: .normal)
		}
		self.index = indexPath
		self.model = item
        titleLabel.text = item.text ?? ""
		noteLabel.text = item.note ?? ""
		checkButton.imageView?.contentMode = .scaleToFill
	}
	@IBAction func actionSelect(_ sender: Any) {

	}

}
