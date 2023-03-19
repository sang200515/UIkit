//
//  ShinhanInfoCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 02/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ShinhanInfoCell: UITableViewCell {

    @IBOutlet weak var appIDLabel: UILabel!
    @IBOutlet weak var appIDStack: UIStackView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cmndLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    
    func bindCell() {
        appIDStack.isHidden = true
        nameLabel.text = ShinhanData.inforCustomer?.personalLoan?.fullName
        cmndLabel.text = ShinhanData.inforCustomer?.personalLoan?.idCard
        phoneLabel.text = ShinhanData.inforCustomer?.personalLoan?.phone
    }
    
    func bindCellDetail(item: ShinhanCustomer?) {
        appIDStack.isHidden = false
        appIDLabel.text = item?.afn&
        nameLabel.text = item?.fullName&
        cmndLabel.text = item?.idCard&
        phoneLabel.text = item?.phone&
    }
}
