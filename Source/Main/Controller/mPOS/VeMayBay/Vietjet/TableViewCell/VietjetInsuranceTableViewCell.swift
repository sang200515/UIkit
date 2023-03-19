//
//  VietjetInsuranceTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 04/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetInsuranceTableViewCell: UITableViewCell {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var imgSelect: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vBackground.roundCorners(.allCorners, radius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ insurance: VietjetInsurance, isSelected: Bool) {
        let selectedImage = UIImage(named: "selected_ic")!
        let unselectedImage = UIImage(named: "unselected_ic")!
        
        imgSelect.image = isSelected ? selectedImage : unselectedImage
        lbTitle.text = insurance.name
        lbPrice.text = "\(Common.convertCurrencyV2(value: insurance.totalAmountFRT)) VNĐ"
    }
}
