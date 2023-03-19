//
//  GuaranteeAutoCompleteCellTableViewCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 22/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class GuaranteeAutoCompleteCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var statuLabel: UILabel!
    @IBOutlet weak var imeiLabel: UILabel!
    @IBOutlet weak var grtTypeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var hlxCusLabel: UILabel!
    @IBOutlet weak var hlxFrtLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var errDesLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.cornerRadius = 10
        mainView.layer.shadowOffset = CGSize(width: 0, height: 3)
        mainView.layer.shadowOpacity = 0.6
        mainView.layer.shadowRadius = 3.0
        mainView.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    func bindCell(item: GRTHistoryItem, isSearch: Bool) {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let current = formatter.string(from: currentDateTime)
        
        numberLabel.text = "\(item.maPhieuBH) - \(item.trangThaiPhieu)"
        dateTimeLabel.text = isSearch ? current : item.ngayTest
        statuLabel.text = isSearch ? "Chưa test" : item.kqTest_Ten
        imeiLabel.text = item.imei
        grtTypeLabel.text = item.tenHinhThuc
        resultLabel.text = item.ketQuaLoi_Ten
        hlxCusLabel.text = item.huongXLKH_Ten
        hlxFrtLabel.text = item.huongXLFRT_Ten
        errDesLabel.text = item.moTaLoi
        descriptionLabel.text = "\(item.maSanPham) - \(item.tenSanPham)"
    }
    
    
}
