//
//  LaprapPCCell.swift
//  fptshop
//
//  Created by Sang Truong on 10/7/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class LaprapPCCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var completeDate: UILabel!
    @IBOutlet weak var shopNamelbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var ycNumberlbl: UILabel!
    @IBOutlet weak var createEmployLbl: UILabel!
    
    @IBOutlet weak var shopHeight: NSLayoutConstraint!
    @IBOutlet weak var prodHeight: NSLayoutConstraint!
    @IBOutlet weak var updateEmployeeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.backgroundColor = .white
        mainView.layer.masksToBounds = false
        mainView.layer.shadowColor = UIColor.darkGray.cgColor
        mainView.layer.shadowOpacity = 1
        mainView.layer.shadowOffset = CGSize(width: -1, height: 1)
        mainView.layer.shadowRadius = 1
    }
    
    func bindCell(item: DataPC) {
        self.stateLbl.textColor = item.colorStatus
        self.stateLbl.text = "\(item.docEntry)" +  item.statusDes
        
        self.timeLbl.text = item.createDate
        self.productLbl.text = item.itemCode + "-" + item.itemName
        self.countLbl.text = item.quantity
        self.completeDate.text = item.finishDate
        self.shopNamelbl.text = item.shopCode + "-" + item.shopName
        
        self.ycNumberlbl.text = item.docEntry_Request
        self.createEmployLbl.text = item.createCode + "-" +  item.createName
        self.updateEmployeeLbl.text = item.updateBy + "-" +
item.updateByName 
        let font = UIFont.boldSystemFont(ofSize: 14)
        let height = productLbl.heightForView(text: item.itemCode + "-" + item.itemName, font: font, width: productLbl.bounds.size.width)
        prodHeight.constant = height <= 20 ? 20 : height + 10
        let height2 = shopNamelbl.heightForView(text: item.shopCode + "-" + item.shopName, font: font, width: shopNamelbl.bounds.size.width)
        shopHeight.constant = height2 <= 20 ? 20 : height2 + 10

    }
    
}

extension UILabel {
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x:0,y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    
}
