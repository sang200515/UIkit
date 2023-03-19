//
//  BaoKimTripCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 19/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class BaoKimTripCell: UITableViewCell {

    @IBOutlet weak var lbFromTime: UILabel!
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var lbToTime: UILabel!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var lbTotalTime: UILabel!
    @IBOutlet weak var lbTotalDistance: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbRate: UILabel!
    @IBOutlet weak var lbSeat: UILabel!
    @IBOutlet weak var lbDetail: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(trip: BaoKimTripData) {
        lbFromTime.text = trip.route.schedules.first?.pickupDate.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mmZ", newFormat: "HH:mm")
        lbFrom.text = trip.route.from.name
        lbToTime.text = trip.route.schedules.last?.arrivalTime.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mmZ", newFormat: "HH:mm")
        lbTo.text = trip.route.to.name
        lbTotalTime.text = "\(trip.route.duration / 60) giờ \(trip.route.duration % 60) phút"
        lbTotalDistance.text = "\(trip.route.distance) km"
        lbName.text = trip.company.name
        lbRate.text = "\(trip.company.ratings.overall)"
        lbSeat.text = "\(trip.route.schedules.first?.availableSeats ?? 0)"
        lbDetail.text = trip.route.schedules.first?.vehicleType
        lbPrice.text = "\(Common.convertCurrencyV2(value: trip.route.schedules.first?.fare.original ?? 0)) đ"
        
        var urlString = trip.company.images.first?.files.the1000X600 ?? ""
        while urlString.first == "/" {
            urlString = String(urlString.dropFirst())
        }
        urlString = "https://" + urlString
        Common.encodeURLImg(urlString: urlString, imgView: imgLogo)
    }
}
