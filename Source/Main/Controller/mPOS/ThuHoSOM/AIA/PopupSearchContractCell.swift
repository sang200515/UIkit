//
//  PopupSearchContractCell.swift
//  reWriteRXSwift
//
//  Created by Sang Trương on 28/11/2022.
//

import UIKit

class PopupSearchContractCell: UITableViewCell {
	@IBOutlet weak var sttLabel:UILabel!
	@IBOutlet weak var codeLabel:UILabel!
	@IBOutlet weak var descriptionLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	func bindCell(item:SuggestionsModel,Stt:Int){
		self.sttLabel.text = "\(Stt)"
		self.codeLabel.text = item.contractId ?? ""
		self.descriptionLabel.text = item.description ?? ""
	}
}
