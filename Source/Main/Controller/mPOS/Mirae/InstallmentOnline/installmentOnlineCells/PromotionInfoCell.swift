//
//  PromotionInfo swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 31/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class PromotionInfoCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var numberItemLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func bindCell(item: InstallmentPromotions, index: IndexPath) {
        countLabel.text = "\(index.row + 1)"
        numberItemLabel.text = "Số lượng: \(item.quantity)"
        nameLabel.text = item.itemName
    }
    
    func bindCellShinhan(item: ProductPromotions, index: Int) {
        countLabel.text = "\(index)"
        nameLabel.text = item.TenCTKM
        numberItemLabel.text = "Số lượng: \(item.SL_Tang)"
    }
    func bindCellShinhan() {
        print("ready to add tableview voucher")

    }
    
    func bindCellDetailShinhan(item: ShinhanPromotion?, index: Int) {
        countLabel.text = "\(index)"
        nameLabel.text = "\(item?.itemName ?? "")"
        numberItemLabel.text = "Số lượng: \(item?.quantity ?? 0)"
    }
    
}
