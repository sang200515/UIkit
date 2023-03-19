//
//  VietjetSelectingCollectionViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 19/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetSelectingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var vUnselected: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbRoute: UILabel!
    @IBOutlet weak var lbSeat: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbSelection: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vBackground.roundCorners(.allCorners, radius: 10)
    }

    func setupCell(isBaggege: Bool, isSelected: Bool, passenger: VietjetPassenger, baggage: VietjetBaggage = VietjetBaggage(JSON: [:])!, seat: VietjetSeatOption = VietjetSeatOption(JSON: [:])!, isDeparture: Bool) {
        vUnselected.isHidden = isSelected
        lbTitle.text = passenger.fareApplicability.adult ? "Người lớn" : "Trẻ em"
        lbName.text = passenger.reservationProfile.lastName + " " + passenger.reservationProfile.firstName
        lbSeat.isHidden = false
        
        lbRoute.text = isDeparture ? "\(VietjetDataManager.shared.selectedDepartureCity.code) - \(VietjetDataManager.shared.selectedArrivalCity.code)" : "\(VietjetDataManager.shared.selectedArrivalCity.code) - \(VietjetDataManager.shared.selectedDepartureCity.code)"
        
        if isBaggege {
            lbPrice.text = "\(Common.convertCurrencyV2(value: baggage.ancillaryCharge.totalAmountFRT)) VNĐ"
            lbSeat.text = baggage.description
            let isChoosen = !baggage.purchaseKey.isEmpty
            lbSelection.text = isChoosen ? "Đã chọn" : "Chưa chọn"
            lbSelection.textColor = isChoosen ? UIColor(hexString: "10AF71") : UIColor(hexString: "6C6B6B")
            lbPrice.isHidden = !isChoosen
        } else {
            lbPrice.text = "\(Common.convertCurrencyV2(value: seat.seatCharges.totalAmountFRT)) VNĐ"
            lbSeat.text = "\(seat.seatMapCell.rowIdentifier)-\(seat.seatMapCell.seatIdentifier)"
            let isChoosen = !seat.selectionKey.isEmpty
            lbSelection.text = isChoosen ? "Đã chọn" : "Chưa chọn"
            lbSelection.textColor = isChoosen ? UIColor(hexString: "10AF71") : UIColor(hexString: "6C6B6B")
            lbPrice.isHidden = !isChoosen
            lbSeat.isHidden = !isChoosen
        }
    }
    
    func setupAddMoreCell(isBaggege: Bool, isSelected: Bool, passenger: VietjetHistoryPassenger, baggage: VietjetBaggage = VietjetBaggage(JSON: [:])!, seat: VietjetSeatOption = VietjetSeatOption(JSON: [:])!, isDeparture: Bool) {
        vUnselected.isHidden = isSelected
        lbTitle.text = passenger.fareApplicability == "adult" ? "Người lớn" : "Trẻ em"
        lbName.text = passenger.lastName + " " + passenger.firstName
        lbSeat.isHidden = false
        
        lbRoute.text = isDeparture ? "\(VietjetDataManager.shared.historyBooking.departure.cityPair.departure.code) - \(VietjetDataManager.shared.historyBooking.departure.cityPair.arrival.code)" : "\(VietjetDataManager.shared.historyBooking.departure.cityPair.arrival.code) - \(VietjetDataManager.shared.historyBooking.departure.cityPair.departure.code)"
        
        if isBaggege {
            lbPrice.text = "\(Common.convertCurrencyV2(value: baggage.ancillaryCharge.totalAmountFRT)) VNĐ"
            lbSeat.text = baggage.description
            let isChoosen = !baggage.purchaseKey.isEmpty
            lbSelection.text = isChoosen ? "Đã chọn" : "Chưa chọn"
            lbSelection.textColor = isChoosen ? UIColor(hexString: "10AF71") : UIColor(hexString: "6C6B6B")
            lbPrice.isHidden = !isChoosen
        } else {
            lbPrice.text = "\(Common.convertCurrencyV2(value: seat.seatCharges.totalAmountFRT)) VNĐ"
            lbSeat.text = "\(seat.seatMapCell.rowIdentifier)-\(seat.seatMapCell.seatIdentifier)"
            let isChoosen = !seat.selectionKey.isEmpty
            lbSelection.text = isChoosen ? "Đã chọn" : "Chưa chọn"
            lbSelection.textColor = isChoosen ? UIColor(hexString: "10AF71") : UIColor(hexString: "6C6B6B")
            lbPrice.isHidden = !isChoosen
            lbSeat.isHidden = !isChoosen
        }
    }
}
