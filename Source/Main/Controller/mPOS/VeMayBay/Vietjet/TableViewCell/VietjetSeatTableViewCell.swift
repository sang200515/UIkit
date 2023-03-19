//
//  VietjetSeatTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 20/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetSeatTableViewCell: UITableViewCell {

    @IBOutlet var imgSeats: [UIImageView]!
    @IBOutlet weak var lbIndex: UILabel!
    
    private var seatIndexDict = ["A": 0, "B": 1, "C": 2, "D": 3, "E": 4, "F": 5]
    private var seats: [VietjetSeatOption] = []
    private var selectedIndexes: [Int] = []
    var didSelectSeat: ((VietjetSeatOption) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        seats = []
        selectedIndexes = []
    }
    
    func setupCell(seats: [VietjetSeatOption], index: Int, selectedIndexes: [Int]) {
        lbIndex.text = "\(index)"
        self.selectedIndexes = selectedIndexes
        
        for index in 0...5 {
            if let seat = seats.first(where: { seatIndexDict[$0.seatMapCell.seatIdentifier] == index }) {
                imgSeats[index].image = UIImage(named: "seat_unavailable_ic")!
                imgSeats[index].image = imgSeats[index].image?.withRenderingMode(.alwaysTemplate)
                imgSeats[index].tintColor = UIColor(hexString: "\(seat.color)")
                self.seats.append(seat)
            } else {
                imgSeats[index].image = UIImage()
                self.seats.append(VietjetSeatOption(JSON: [:])!)
            }
        }
        
        for index in selectedIndexes {
            imgSeats[index].tintColor = UIColor(hexString: "FFEF61")
        }
    }
    
    @IBAction func selectSeatButtonPressed(_ sender: UIButton) {
        if seats[sender.tag].available {
            didSelectSeat?(seats[sender.tag])
        }
    }
}
