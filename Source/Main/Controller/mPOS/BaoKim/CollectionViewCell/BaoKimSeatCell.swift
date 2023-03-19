//
//  BaoKimSeatCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class BaoKimSeatCell: UICollectionViewCell {

    @IBOutlet weak var btnSeat: UIButton!
    
    var didSelectSeat: ((BaoKimSeatTemplate) -> Void)?
    
    private let availableColor: UIColor = UIColor(hexString: "04AB6E")
    private let unavailableColor: UIColor = UIColor(hexString: "0064B0")
    private let selectionColor: UIColor = UIColor(hexString: "FC7133")
    private var seat: BaoKimSeatTemplate = BaoKimSeatTemplate(JSON: [:])!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(seat: BaoKimSeatTemplate, isSelected: Bool) {
        self.seat = seat
        btnSeat.isHidden = false
        btnSeat.setTitle(seat.seatCode, for: .normal)
        if isSelected {
            btnSeat.backgroundColor = selectionColor
        } else {
            btnSeat.backgroundColor = seat.isAvailable ? availableColor : unavailableColor
        }
    }

    @IBAction func seatButtonPressed(_ sender: Any) {
        if seat.isAvailable {
            didSelectSeat?(seat)
        }
    }
}
