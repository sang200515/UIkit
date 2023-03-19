//
//  InstallmentHistoryCell.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 30/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class InstallmentHistoryCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var soNumberLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var idNumberLabel: UILabel!
    @IBOutlet weak var numberHDLabel: UILabel!
    @IBOutlet weak var appIDLabel: UILabel!
    @IBOutlet weak var shipTypeLabel: UILabel!
    @IBOutlet weak var stateMire: UILabel!
    @IBOutlet weak var imeiStatusLabel: UILabel!
    @IBOutlet weak var totalStatusLabel: UILabel!
    @IBOutlet weak var imeiStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.cornerRadius = 10
        mainView.layer.shadowColor = UIColor.gray.cgColor
        mainView.layer.shadowOffset = CGSize(width: 3, height: 3)
        mainView.layer.shadowOpacity = 0.7
        mainView.layer.shadowRadius = 3
    }

    func bindcell(with item: DataOrder) {
        self.soNumberLabel.text = "SO POS: \(item.docNum)"
        self.dateTimeLabel.text = item.u_CrDate
        self.customerLabel.text = item.u_UCode
        self.phoneLabel.text = item.u_Phone
        self.idNumberLabel.text = item.cmnd
        self.numberHDLabel.text = item.contractNumber
        self.shipTypeLabel.text = item.u_ShipTyp == "2" ? "giao tại shop" : "giao tại nhà"
        self.stateMire.text = "Mở"
        self.imeiStatusLabel.text = "Chưa up imei"
        self.totalStatusLabel .text = "Chờ xử lý"
    }
    
    func bindcellNew(with item: OrderNewItem) {
        self.soNumberLabel.text = "SO POS: \(item.PosSoNum)"
        self.dateTimeLabel.text = item.CreatedDate.toNewStrDate()
        self.customerLabel.text = item.FullName
        self.phoneLabel.text = item.PhoneNumber
        self.idNumberLabel.text = item.NationalIdNum
        self.numberHDLabel.text = item.ContractNumber
        self.shipTypeLabel.text = item.ShipType == "2" ? "giao tại shop" : "giao tại nhà"
        self.stateMire.text = "Mở"
        self.imeiStatusLabel.text = "Chưa up imei"
        self.totalStatusLabel.text = "Chờ xử lý"
        self.appIDLabel.text = item.ApplicationId
    }
    
    
    func bindcell2(with item: HistoryIsdetailData) {
        self.soNumberLabel.text = "SO POS: \(item.soNumber)"
        self.dateTimeLabel.text = item.createdDate.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS", newFormat: "dd/MM/yyyy HH:mm")
        self.customerLabel.text = item.fullName
        self.phoneLabel.text = item.phoneNumber
        self.idNumberLabel.text = item.nationalIdNum
        self.numberHDLabel.text = item.contractNumber
        self.shipTypeLabel.text = item.ShipTypeString
        self.stateMire.text = "Mở"
        self.imeiStatusLabel.text = item.ImeiStatus
        self.totalStatusLabel.text = item.DocStatusString
        self.appIDLabel.text = item.applicationId
    }
}
