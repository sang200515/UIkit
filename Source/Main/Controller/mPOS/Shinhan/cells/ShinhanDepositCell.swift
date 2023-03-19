//
//  ShinhanDepositCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 01/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ShinhanDepositCell: UITableViewCell {

    
    @IBOutlet weak var cusName: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var createDate: UILabel!
    @IBOutlet weak var posNum: UILabel!
    @IBOutlet weak var mPosNum: UILabel!
    @IBOutlet weak var ecomNUm: UILabel!
    @IBOutlet weak var moneyDeposit: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindCell(details: [ShinhanSchemeDetails],header: ShinhanSchemeHeader) {
        cusName.text = header.cardname
        phoneLbl.text = header.sDT
        createDate.text = "\(header.createDate.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS", newFormat: "HH:mm dd/MM/yyyy"))"
        posNum.text = "\(header.sOPOS)"
        mPosNum.text = "\(header.sOMPOS)"
        ecomNUm.text = "\(header.ecomNum)"
        moneyDeposit.text = "\(Common.convertCurrencyDouble(value: header.soTienCoc)) VNĐ"
        for item in details {
            if item.qlSerial == "Y" {
                self.productName.text = "\(item.itemName)"
                self.productPrice.text = "\(Common.convertCurrencyDouble(value: item.price)) VNĐ"
            }
        }
    }

    
}
