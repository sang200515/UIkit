//
//  HeaderChamdiem.swift
//  fptshop
//
//  Created by Ngoc Bao on 05/10/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HeaderChamdiem: UITableViewHeaderFooterView {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var button: UIButton!
    var onheader: (()->Void)?
    func loadNib() -> HeaderLeaseTableView {
        Bundle.main.loadNibNamed("HeaderLeaseTableView", owner: self, options: nil)?.first as! HeaderLeaseTableView
    }
    @IBAction func onClickHeader(_ sender: Any) {
        if let header = onheader {
            header()
        }
    }
    
}
