//
//  ContactTableViewCell.swift
//  mSM
//
//  Created by Trần Thành Phương Đăng on 6/20/18.
//  Copyright © 2018 FPT. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var lblContactFullname: UILabel!
    @IBOutlet weak var lblPhoneNum: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblShopName: UILabel!
    @IBOutlet weak var lblOffice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
