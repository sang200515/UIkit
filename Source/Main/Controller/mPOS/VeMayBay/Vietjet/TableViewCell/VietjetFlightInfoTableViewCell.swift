//
//  VietjetFlightInfoTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 28/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetFlightInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbOneWay: UILabel!
    @IBOutlet weak var lbDepartureTime: UILabel!
    @IBOutlet weak var lbDepartureDate: UILabel!
    @IBOutlet weak var lbDepartureCity: UILabel!
    @IBOutlet weak var lbDepartureCode: UILabel!
    @IBOutlet weak var lbCode: UILabel!
    @IBOutlet weak var lbClass: UILabel!
    @IBOutlet weak var lbBrand: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbArrivalTime: UILabel!
    @IBOutlet weak var lbArrivalDate: UILabel!
    @IBOutlet weak var lbArrivalCity: UILabel!
    @IBOutlet weak var lbArrivalCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCell(_ info: VietjetHistoryDeparture, isDeparture: Bool, code: String) {
        lbOneWay.text = isDeparture ? "Chiều bay đi" : "Chiều bay về"
        lbDepartureTime.text = info.cityPair.departure.hours
        lbDepartureDate.text = String(info.cityPair.departure.schedueledTime.split(separator: " ").first&)
        lbDepartureCity.text = info.cityPair.departure.name
        lbDepartureCode.text = info.cityPair.departure.code
        lbCode.text = code
        lbClass.text = info.fareClass
        lbBrand.text = info.airlineNumber
        lbTime.text = info.totalTime
        lbArrivalTime.text = info.cityPair.arrival.hours
        lbArrivalDate.text = String(info.cityPair.arrival.schedueledTime.split(separator: " ").first&)
        lbArrivalCode.text = info.cityPair.arrival.code
        lbArrivalCity.text = info.cityPair.arrival.name
    }
}
