//
//  RadioButtonBTSCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 6/17/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class RadioButtonBTSCell: UITableViewCell {

    @IBOutlet weak var leftRadioImg: UIImageView!
    @IBOutlet weak var leftRadioLbl: UILabel!
    @IBOutlet weak var rightRadioImg: UIImageView!
    @IBOutlet weak var rightRadioLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindShiptye(isShop: Bool) {
        leftRadioLbl.text = "GH tại shop"
        rightRadioLbl.text = "GH tại nhà"
        leftRadioImg.image = isShop ? UIImage(named: "selected_radio_ic") : UIImage(named: "unselected_radio_ic")
        rightRadioImg.image = !isShop ? UIImage(named: "selected_radio_ic") : UIImage(named: "unselected_radio_ic")
    }
    
    @IBAction func onClickleft(_ sender: Any) {
        
    }
    
    @IBAction func onClickRight(_ sender: Any) {
        
    }
}
