//
//  InForCustomerCell.swift
//  QuickCode
//
//  Created by Sang Trương on 20/07/2022.
//

import UIKit

class InForCustomerCell: UITableViewCell {

    @IBOutlet weak var nguoiLienHeLbl: UILabel!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfMQH: UITextField!
    @IBOutlet weak var tfSDT: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
            // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
    }
    func bindCell(item:CreateRefPersons,index:Int){
        nguoiLienHeLbl.text = "Thông tin người liên hệ \(index + 1)"
        tfName.text = item.fullName
        tfMQH.text = item.relationshipName
        tfSDT.text = item.phone
        print(contentView.frame.size.height)
        

    }
}
