//
//  UserExamInforCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 16/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Kingfisher

class UserExamInforCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userNameCodeLbl: UILabel!
    @IBOutlet weak var timesTestLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var contestNameLbl: UILabel!
    @IBOutlet weak var timeRemainLbl: UILabel!
    
    func bindCell(item: EmployInfoExam, timeStart: String) {
        avatar.layer.cornerRadius = avatar.frame.width / 2
        avatar.layer.masksToBounds = true
        avatar.contentMode = .scaleToFill
        contestNameLbl.text = item.examName
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        let url_avatar = "\(Cache.user!.AvatarImageLink)".replacingOccurrences(of: "~", with: "")
        if(url_avatar != ""){
            if let escapedString = "https://inside.fptshop.com.vn/\(url_avatar)".addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                let url = URL(string: "\(escapedString)")!
                avatar.kf.setImage(with: url,
                                   placeholder: UIImage(named: "ic_default_avatar"),
                                   options: [.transition(.fade(1))],
                                   progressBlock: nil,
                                   completionHandler: nil)
            }
        }
        nameLbl.text = Cache.user?.EmployeeName ?? ""
        userNameCodeLbl.text = Cache.user?.UserName
        timesTestLbl.text = "\(item.timesExamCurrent)/\(item.timesExamMax)"
        dateLbl.text = timeStart
    }
    
}
