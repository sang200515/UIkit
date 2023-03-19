//
//  DetailsLinhKienCell.swift
//  fptshop
//
//  Created by Sang Truong on 12/4/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DetailsLinhKienCell: UITableViewCell {
    var isCheckHiddenContentView = false
    @IBOutlet weak var contentAllViews: UIView!
    

    @IBOutlet weak var productHeight: NSLayoutConstraint!
    @IBOutlet weak var productCode: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var imeilLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindCell(item:DetailsLinhKienByImei) {
        if isCheckHiddenContentView {
            contentAllViews.isHidden = true
        }
        productCode.text = item.itemCode_LK
        productName.text = item.itemName_LK
        imeilLbl.text = item.imei
        let font = UIFont.boldSystemFont(ofSize: 14)
        let height = productName.heightForView(text: item.itemName_LK ?? "" , font: font, width: productName.bounds.size.width)
        productHeight.constant = height <= 20 ? 20 : height + 10

        
    }
    
}
