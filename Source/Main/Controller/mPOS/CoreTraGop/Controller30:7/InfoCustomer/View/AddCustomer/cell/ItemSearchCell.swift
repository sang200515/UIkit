//
//  ItemSearchCell.swift
//  fptshop
//
//  Created by Sang Truong on 10/7/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ItemSearchCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var dateMonthLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var cmndLbl: UILabel!
    @IBOutlet weak var gplxLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.backgroundColor = .white
        mainView.layer.masksToBounds = false
        mainView.layer.shadowColor = UIColor.darkGray.cgColor
        mainView.layer.shadowOpacity = 1
        mainView.layer.shadowOffset = CGSize(width: -1, height: 1)
        mainView.layer.shadowRadius = 1
    }

    func bindCell(item: ItemsSearchCustomer) {
        nameLbl.text = item.fullName
        phoneLbl.text = item.phone
        dateMonthLbl.text = item.birthDate?.convertDate(dateString: item.birthDate ?? "")
        emailLbl.text = item.email
        addressLbl.text = item.company?.companyName
        cmndLbl.text = item.idCard
        gplxLbl.text = "GPLX can sua laii"
    }
    
}

//extension UILabel {
//    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
//        let label:UILabel = UILabel(frame: CGRect(x:0,y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = font
//        label.text = text
//
//        label.sizeToFit()
//        return label.frame.height
//    }
//
//}
