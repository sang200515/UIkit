//
//  CMSNHistoryTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 08/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CMSNHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbDOB: UILabel!
    @IBOutlet weak var lbCMND: UILabel!
    @IBOutlet weak var lbUser: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ item: CMSNHistoryData) {
        lbName.text = item.fullname
        lbPhone.text = item.phoneNumber
        lbDOB.text = item.birthday
        lbCMND.text = item.idCard
        lbUser.text = item.updatedBy
        lbDate.text = item.updatedDate
        lbStatus.text = item.status
        lbStatus.textColor = UIColor.init(hexString: item.statusColor)
    }
}
