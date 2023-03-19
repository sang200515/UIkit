//
//  HistorykiemKeCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 07/09/2021.
//  Copyright © 2021 Duong Hoang Minh. All rights reserved.
//

import UIKit

class HistorykiemKeCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var shopLbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var userKKLbl: UILabel!
    @IBOutlet weak var userGTLbl: UILabel!
    @IBOutlet weak var userHuyLbl: UILabel!
    @IBOutlet weak var userHoanTat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.backgroundColor = .white
        mainView.layer.masksToBounds = false
        mainView.layer.shadowColor = UIColor.darkGray.cgColor
        mainView.layer.shadowOpacity = 1
        mainView.layer.shadowOffset = CGSize(width: -1, height: 1)
        mainView.layer.shadowRadius = 1
    }
    
    func bindCell(item: SearchKiemKeDetail) {
        titleLbl.text = "\(item.docentry ?? "")-\(item.statusName)-\(item.doc_Type_Name ?? "")"
        titleLbl.textColor = item.statusColor
        shopLbl.text = item.shop_Name
        timelbl.text = item.create_Date
        userKKLbl.isHidden = item.user_KK == ""
        userKKLbl.text = item.user_KK
        
        userGTLbl.isHidden = item.user_GT == ""
        userGTLbl.text = item.user_GT
        
        userHuyLbl.isHidden = item.user_HuyKK == ""
        userHuyLbl.text = item.user_HuyKK
        
        userHoanTat.isHidden = item.user_HT == ""
        userHoanTat.text = item.user_HT
    }
    
}
