//
//  MultipleChoiceBtnCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 16/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
enum ContestState: Int {
    case complete = 0
    case reTest
    case home
    case none
}

class MultipleChoiceBtnCell: UITableViewCell {
    
    @IBOutlet weak var actionButton: UIButton!
    
    var curentState: ContestState = .none
    
    var onClick: (()->Void)?
    func bindCell(state: ContestState) {
        actionButton.backgroundColor = Constants.COLORS.bold_green
        switch state {
        case .complete:
            actionButton.setTitle("HOÀN TẤT", for: .normal)
        case .reTest:
            actionButton.setTitle("THI LẠI", for: .normal)
        case .home:
            actionButton.setTitle("TRANG CHỦ", for: .normal)
        case .none:
            actionButton.isHidden = true
        }
    }
    @IBAction func onAction(_ sender: Any) {
        if let click = onClick {
            click()
        }
    }
}
