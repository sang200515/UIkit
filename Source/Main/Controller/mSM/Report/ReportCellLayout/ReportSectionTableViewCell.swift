//
//  ReportSectionTableViewCell.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 26/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ReportSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var imgvCellIcon: UIImageView!;
    @IBOutlet weak var lblCellLabel: UILabel!;
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
