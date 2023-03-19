//
//  HeaderVoucherCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 17/02/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HeaderVoucherCell: UITableViewCell {

    @IBOutlet weak var desVoucherLbl: UILabel!
    @IBOutlet weak var sttLbl: UILabel!
    @IBOutlet weak var deleteView: UIView!
    
    var delete: (()-> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindCell(des: String, stt: String, hiddenDel: Bool = true) {
        desVoucherLbl.text = des
        sttLbl.text = stt
        deleteView.isHidden = hiddenDel
    }
    
    @IBAction func ondelete(_ sender: Any) {
        if let del = delete {
            del()
        }
    }
}
