//
//  RequestTableViewCell.swift
//  mCallLog_v2
//
//  Created by Trần Thành Phương Đăng on 31/08/2018.
//  Copyright © 2018 vn.com.fptshop. All rights reserved.
//

import UIKit

class CallLogTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDateCreated: UILabel!
    @IBOutlet weak var lblRequestNumber: UILabel!
    @IBOutlet weak var lblRequestTitle: UILabel!
    @IBOutlet weak var lblRequestContent: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib();
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
    }
}
