//
//  LinhKienRaPCCell.swift
//  fptshop
//
//  Created by Sang Truong on 11/30/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class LinhKienRaPCCell: UITableViewCell {

    @IBOutlet weak var nameSpLabel: UILabel!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var spCode: UILabel!
    
    @IBOutlet weak var selectDetailsButotn: UIButton!
    @IBOutlet weak var ViewChooseImei: UIView!
    @IBOutlet weak var scanImage: UIImageView!
    var onScan:(()->Void)?
    var onSelectImei:(()->Void)?
    var onSelectDetails:(()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var height:Int = 0
    func bindCell(item:LinhKienRaPCDetail,canUpdateImei:Bool) {
        selectImageButton?.titleLabel?.lineBreakMode = .byWordWrapping

        if (item.is_Imei == "1") {
            let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.systemGray]

            let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.systemPink]

            let attributedString1 = NSMutableAttributedString(string:"\n\(item.itemCode_PC!)", attributes:attrs1)

            let attributedString2 = NSMutableAttributedString(string:"  \n(*)\n", attributes:attrs2)

            attributedString1.append(attributedString2)
            spCode.attributedText! = attributedString1

        }
        else {
            spCode.text = item.itemCode_PC
            selectImageButton.isHidden = true
            scanImage.isHidden = true
        }
   
        
        
        let nameSpLabelAttri1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.systemGray]

        let nameSpLabelAttri2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.systemPink]

        let attributedString1 = NSMutableAttributedString(string:"\(item.itemName_PC!)", attributes:nameSpLabelAttri1)
        guard item.so_Luong != nil else { return }
        
        if item.itemName_PC != "" {
            let attributedString2 = NSMutableAttributedString(string:" \n(số lượng:\(item.so_Luong!)) ", attributes:nameSpLabelAttri2)
            attributedString1.append(attributedString2)

        }else {
            let attributedString2 = NSMutableAttributedString(string:"", attributes:nameSpLabelAttri2)
            attributedString1.append(attributedString2)
        }

        nameSpLabel.attributedText! = attributedString1
      
        selectImageButton.setTitle(item.imei != "" ? item.imei : "Chọn Imei", for: .normal)
        
        selectImageButton.underline(text: item.imei != "" ? item.imei! : "Chọn Imei")
        selectDetailsButotn.setTitle("Chi tiết", for: .normal)
        selectDetailsButotn.underline(text: "Chi tiết")
//        selectImageButton.font = UIFont.systemFont(ofSize: 14)
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
    @IBAction func onSelectDetail(_ sender: Any) {
        if let select  = onSelectDetails {
            select()
        }
    }
}
