//
//  HeaderLeaseTableView.swift
//  fptshop
//
//  Created by Ngoc Bao on 19/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HeaderLeaseTableView: UITableViewHeaderFooterView {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var corectLbl: UILabel!
    @IBOutlet weak var rightView: UIView!
    
    func loadNib() -> HeaderLeaseTableView {
        Bundle.main.loadNibNamed("HeaderLeaseTableView", owner: self, options: nil)?.first as! HeaderLeaseTableView
    }
}
