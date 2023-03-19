//
//  LinhKienPCCell.swift
//  fptshop
//
//  Created by Sang Truong on 10/7/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class LinhKienPCCell: UITableViewCell {

    @IBOutlet weak var nameSpLabel: UILabel!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var spCode: UILabel!
    
    @IBOutlet weak var scanImage: UIImageView!
    var onScan:(()->Void)?
    var onSelectImei:(()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindCell(item:LinhKienDetail,canUpdateImei:Bool) {
        if (item.is_Imei == "1") {
            let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.systemGray]

            let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.systemPink]

            let attributedString1 = NSMutableAttributedString(string:"\(item.itemCode_LK!)", attributes:attrs1)

            let attributedString2 = NSMutableAttributedString(string:"  (*)", attributes:attrs2)

            attributedString1.append(attributedString2)
            spCode.attributedText! = attributedString1

        }
        else {
            spCode.text = item.itemCode_LK
            selectImageButton.isHidden = true
            scanImage.isHidden = true
        }
   
        
        
        let nameSpLabelAttri1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.systemGray]

        let nameSpLabelAttri2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.systemPink]

        let attributedString1 = NSMutableAttributedString(string:"\(item.itemName_LK!)", attributes:nameSpLabelAttri1)
        guard item.so_Luong != nil else { return }

        let attributedString2 = NSMutableAttributedString(string:" (SL:\(item.so_Luong!)) ", attributes:nameSpLabelAttri2)

        attributedString1.append(attributedString2)
        nameSpLabel.attributedText! = attributedString1
        
        selectImageButton.setTitle(item.imei != "" ? item.imei : "Chọn Imei", for: .normal)
        
        selectImageButton.underline(text: item.imei != "" ? item.imei! : "Chọn Imei")
        scanImage.isUserInteractionEnabled = canUpdateImei
        selectImageButton.isUserInteractionEnabled = canUpdateImei
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectImageIcon))
        scanImage.addGestureRecognizer(gesture)
    }
    
    @objc func selectImageIcon() {
        if let scan  = onScan {
            scan()
        }
    }
    
    @IBAction func onSelectImei(_ sender: Any) {
        if let select  = onSelectImei {
            select()
        }
    }
}
