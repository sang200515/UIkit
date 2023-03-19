//
//  ThuHoSOMInvoiceTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 01/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ThuHoSOMInvoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbIndex: UILabel!
    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var lbCode: UILabel!
    @IBOutlet weak var lbCost: UILabel!
    @IBOutlet weak var lbFee: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var lbInvoice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vBackground.dropShadowV2()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(invoice: ThuHoSOMOrderInvoiceDetail, index: Int) {
        let check = UIImage(named: "check-1")!
        let uncheck = UIImage(named: "check-2")!
        
        lbIndex.text = "\(index)"
        imgCheck.image = invoice.isCheck ? check : uncheck
        lbCode.text = invoice.id
        lbCost.text = "\(Common.convertCurrencyV2(value: invoice.paymentAmount)) VNĐ"
        lbFee.text = "\(Common.convertCurrencyV2(value: invoice.paymentFee)) VNĐ"
        lbTotal.text = "\(Common.convertCurrencyV2(value: invoice.paymentAmount + invoice.paymentFee)) VNĐ"
        lbInvoice.text = invoice.rawPeriod
    }
}
