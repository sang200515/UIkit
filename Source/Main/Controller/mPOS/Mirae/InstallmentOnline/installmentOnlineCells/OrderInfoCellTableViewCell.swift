//
//  OrderInfoCellTableViewCell.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 31/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SnapKit

class OrderInfoCellTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imeiLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    
    func bindCell(item: InstallmentOrderData) {
        countLabel.text = "1"
        nameLabel.text = "\(item.product.code)-\(item.product.name)"
        imeiLabel.text = item.product.imei != "" ?  "IMEI: \(item.product.imei)" : "IMEI: SA"
        moneyLabel.text = "\(Common.convertCurrencyDouble(value: item.realPrice.removeSubNum())) đ"
    }
    
    func bindCellShinhan(item: Cart,index: Int) {
        countLabel.text = "\(index)"
        
        nameLabel.text = "\(item.product.sku) - \(item.product.name)"
		if item.product.hotSticker {
			let imageAttachment = NSTextAttachment()
			imageAttachment.image = UIImage(named: "ic_hot3")
			let imageString = NSAttributedString(attachment: imageAttachment)
			imageAttachment.bounds = CGRect(x: -10, y: 0, width: 65, height: 23)
			let textString = NSAttributedString(string: " \(item.product.sku) - \(item.product.name)")
			let combinedString = NSMutableAttributedString()
			combinedString.append(imageString)
			combinedString.append(textString)
			nameLabel.text = ""
			nameLabel.attributedText = combinedString
//			nameLabel.snp.updateConstraints { make in
//				make.top.right.equalToSuperview()
//				make.left.equalTo(imeiLabel)
//			}``
			nameLabel.layoutIfNeeded()
		}

        if (item.product.qlSerial == "Y"){
            imeiLabel.text = "IMEI: \((item.imei))"
        }else{
            imeiLabel.text = "Số lượng: \((item.quantity))"
        }
        
        moneyLabel.text = "Giá: \(Common.convertCurrencyFloat(value: (item.product.price)))"
        quantityLabel.text = "SL: \((item.quantity))"
    }
    
    func bindCellDetailShinhan(item: ShinhanOrder?,index: Int) {
        countLabel.text = "\(index)"
        nameLabel.text = "\(item?.itemCode ?? "") - \(item?.itemName ?? "")"
        imeiLabel.text = "IMEI: \(item?.imei ?? "")"
        moneyLabel.text = "Giá: \(Common.convertCurrencyFloat(value: (item?.price ?? 0)))"
        quantityLabel.text = "SL: \(item?.quantity ?? 0)"
    }
}
