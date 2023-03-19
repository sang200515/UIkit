//
//  VoucherInfoCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 09/02/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VoucherInfoCell: UITableViewCell {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var scanButton: UIButton!
    
    var onAdd: (() -> Void)?
    var onScan: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        addButton.underline()
        scanButton.setTitle("", for: .normal)
    }
    
    @IBAction func addVoucher(_ sender: Any) {
        if let add = onAdd {
            add()
        }
    }
    @IBAction func onScan(_ sender: Any) {
        if let scan = onScan {
            scan()
        }
    }
}
