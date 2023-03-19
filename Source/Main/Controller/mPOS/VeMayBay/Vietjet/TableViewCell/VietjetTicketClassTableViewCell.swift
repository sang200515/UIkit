//
//  VietjetTicketClassTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 19/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Kingfisher

class VietjetTicketClassTableViewCell: UITableViewCell {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lbTicketType: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var vExpand: UIView!
    @IBOutlet weak var vDetail: UIView!
    @IBOutlet weak var lbDetail: UILabel!
    
    var didExpand: (() -> Void)?
    var didPressHyperlink: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(_ fareOption: FareOption, isSelected: Bool) {
        let url = URL(string: fareOption.logo)
        imgLogo.kf.setImage(with: url)
        lbTicketType.text = fareOption.fareClass
        let price = fareOption.fareCharges.first?.totalAmountFRT ?? 0
        lbPrice.text = "\(Common.convertCurrencyV2(value: price)) VNĐ"
        imgSelected.image = isSelected ? UIImage(named: "selected_ic") : UIImage(named: "unselected_ic")
        lbDetail.attributedText = fareOption.html.htmlToAttributedString
    }
    
    @IBAction func expandButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            self.vExpand.isHidden = true
            self.vDetail.isHidden = false
            self.didExpand?()
        }
    }
    
    @IBAction func collapseButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            self.vExpand.isHidden = false
            self.vDetail.isHidden = true
            self.didExpand?()
        }
    }
    
    @IBAction func hyperLinkButtonPressed(_ sender: Any) {
        didPressHyperlink?()
    }
}
