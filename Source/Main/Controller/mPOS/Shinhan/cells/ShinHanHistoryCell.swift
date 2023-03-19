//
//  ShinHanHistoryCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 02/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ShinHanHistoryCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var appIdLabel: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var cusNameLabel: UILabel!
    @IBOutlet weak var cmndLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var constractLabel: UILabel!
    @IBOutlet weak var confirmCodeLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var mposLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.highlightView()
        
    }
    
    func bindCell(item: ShinhanOrderItem) {
        appIdLabel.text = "AFN: \(item.afn)"
        mposLabel.text = "\(item.mposSoNum)"
        dateTime.text = item.createdDate
        cusNameLabel.text = item.fullName
        cmndLabel.text = item.idCard
        constractLabel.text = item.contractNumber
        reasonLabel.text = item.cancelReason
        orderStatusLabel.text = item.status
        orderStatusLabel.textColor = UIColor(hexString: item.statusColor)
        //        stateLabel.text = "chua xong"
        //        confirmCodeLabel.text = "3123564878966asda"
    }
    
}
