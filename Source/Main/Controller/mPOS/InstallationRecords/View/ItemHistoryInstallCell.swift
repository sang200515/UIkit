//
//  ItemHistoryInstallCell.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 01/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ItemHistoryInstallCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lbIMEI: UILabel!
    @IBOutlet weak var lbCreateDate: UILabel!
    @IBOutlet weak var lbCustomerNameText: UILabel!
    @IBOutlet weak var lbSdtKHText: UILabel!
    @IBOutlet weak var lbProductText: UILabel!
    @IBOutlet weak var lbNVText: UILabel!
    
    @IBOutlet weak var receiptID: UILabel!
    @IBOutlet weak var packNameStack: UIStackView!
    @IBOutlet weak var packNameLabel: UILabel!
    @IBOutlet weak var totalMoneyStack: UIStackView!
    
    @IBOutlet weak var statusReceiptLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbIMEI.font = UIFont.boldSystemFont(ofSize: 14)
        lbIMEI.textColor = UIColor(netHex: 0x04AB6E)
        lbCreateDate.font = UIFont.systemFont(ofSize: 13)
        lbCreateDate.textColor = UIColor(netHex: 0xbababa)
        lbCustomerNameText.font = UIFont.systemFont(ofSize: 14)
        lbSdtKHText.font = UIFont.systemFont(ofSize: 14)
        lbProductText.font = UIFont.systemFont(ofSize: 14)
        lbNVText.font = UIFont.systemFont(ofSize: 14)
        mainView.backgroundColor = UIColor(netHex: 0xFAFAFA)
        
        mainView.layer.cornerRadius = 10
        mainView.layer.shadowOffset = CGSize(width: 0, height: 3)
        mainView.layer.shadowOpacity = 0.6
        mainView.layer.shadowRadius = 3.0
        mainView.layer.shadowColor = UIColor.darkGray.cgColor

    }
    func bindCell(item: InstallationReceiptData){
        lbIMEI.text = item.imei
        lbCreateDate.text = item.createDate
        lbCustomerNameText.text = item.custFullname
        lbSdtKHText.text = item.phoneNumber
        lbProductText.text = item.itemName
        lbNVText.text = item.updatedBy
        statusReceiptLabel.text = item.receiptStatus
        setTitleColor(title: item.receiptStatus)
        receiptID.text = "\(item.id)"
    }
    func setTitleColor(title:String) {
        switch title{
        case "Tạo phiếu":
            return   statusReceiptLabel.textColor = Constants.COLORS.createStatus
        case "Đang xử lý":
            return  statusReceiptLabel.textColor = .blue
        case "Hoàn tất":
            return  statusReceiptLabel.textColor = .mainGreen
        case "Đã hủy":
            return  statusReceiptLabel.textColor = UIColor.systemPink
        default:
            return statusReceiptLabel.textColor = UIColor.black
        }
    }
    
}

