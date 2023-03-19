//
//  HistoryChangeItelCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 06/10/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HistoryChangeItelCell: UITableViewCell {

    
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var mposLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var nhamangLbl: UILabel!
    @IBOutlet weak var typeSimLbl: UILabel!
    @IBOutlet weak var serialLbl: UILabel!
    @IBOutlet weak var cusNameLbl: UILabel!
    @IBOutlet weak var shopLbl: UILabel!
    @IBOutlet weak var feeLbl: UILabel!

    func bindCell(item: SimHistoryItem) {
        phoneLbl.text = item.Phonenumber
        timeLbl.text = item.NgayThaySim
        nhamangLbl.text = item.Provider
        typeSimLbl.text = item.LoaiSim
        serialLbl.text = item.SeriSim_New
        cusNameLbl.text = item.FullName
        shopLbl.text = item.TenShop
        mposLbl.text = "MPOS: \(item.SoMPos)"
        feeLbl.text = "\(Common.convertCurrency(value: item.Doctotal))"
    }
}
