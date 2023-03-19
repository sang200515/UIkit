//
//  ThuHoSOMAgreementTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 16/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ThuHoSOMAgreementTableViewCell: UITableViewCell {

    @IBOutlet weak var lbOrder: UILabel!
    @IBOutlet weak var lbContract: UILabel!
    @IBOutlet weak var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(order: Int, agreement: ThuHoSOMAgreement) {
        lbOrder.text = "\(order)"
        lbContract.text = agreement.contract
        lbName.text = agreement.fullName
    }
}
