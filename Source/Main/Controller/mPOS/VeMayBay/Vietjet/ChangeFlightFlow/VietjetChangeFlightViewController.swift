//
//  VietjetChangeFlightViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 11/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetChangeFlightViewController: UIViewController {

    @IBOutlet var circleViews: [UIView]!
    
    //MARK:- DEPARTURE
    @IBOutlet weak var vEditDeparture: UIView!
    @IBOutlet weak var vDepartureBackground: UIView!
    @IBOutlet weak var lbDepartureFlightNo: UILabel!
    @IBOutlet weak var lbDepartureDate: UILabel!
    @IBOutlet weak var lbDepartureFromCode: UILabel!
    @IBOutlet weak var lbDepartureFromCity: UILabel!
    @IBOutlet weak var lbDepartureFromTime: UILabel!
    @IBOutlet weak var lbDepartureTotalTime: UILabel!
    @IBOutlet weak var lbDepartureToCode: UILabel!
    @IBOutlet weak var lbDepartureToCity: UILabel!
    @IBOutlet weak var lbDepartureToTime: UILabel!
    @IBOutlet weak var lbDeparturePassenger: UILabel!
    
    //MARK:- RETURN
    @IBOutlet weak var vReturn: UIView!
    @IBOutlet weak var vEditReturn: UIView!
    @IBOutlet weak var vReturnBackground: UIView!
    @IBOutlet weak var lbReturnFlightNo: UILabel!
    @IBOutlet weak var lbReturnDate: UILabel!
    @IBOutlet weak var lbReturnFromCode: UILabel!
    @IBOutlet weak var lbReturnFromCity: UILabel!
    @IBOutlet weak var lbReturnFromTime: UILabel!
    @IBOutlet weak var lbReturnTotalTime: UILabel!
    @IBOutlet weak var lbReturnToCode: UILabel!
    @IBOutlet weak var lbReturnToCity: UILabel!
    @IBOutlet weak var lbReturnToTime: UILabel!
    @IBOutlet weak var lbReturnPassenger: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDepartureUI()
        setupReturnUI()
    }
    
    private func setupUI() {
        title = "Thông tin chuyến bay"
        addBackButton()
        
        for circle in circleViews {
            circle.roundCorners(.allCorners, radius: 16)
        }
        vDepartureBackground.roundCorners(.allCorners, radius: 10)
        vReturnBackground.roundCorners(.allCorners, radius: 10)
        
        vReturn.isHidden = VietjetDataManager.shared.historyBooking.arrival == nil
    }
    
    private func setupDepartureUI() {
        let departure = VietjetDataManager.shared.historyBooking.departure
        lbDepartureFlightNo.text = "\(departure.airlineNumber) - \(departure.fareClass)"
        lbDepartureDate.text = departure.departureDate
        lbDepartureFromCode.text = departure.cityPair.departure.code
        lbDepartureFromCity.text = departure.cityPair.departure.name
        lbDepartureFromTime.text = departure.cityPair.departure.hours
        lbDepartureTotalTime.text = departure.totalTime
        lbDepartureToCode.text = departure.cityPair.arrival.code
        lbDepartureToCity.text = departure.cityPair.arrival.name
        lbDepartureToTime.text = departure.cityPair.arrival.hours
        lbDeparturePassenger.text = "\(VietjetDataManager.shared.historyBooking.passengers.count) Hành khách"
    }
    
    private func setupReturnUI() {
        guard let arrival = VietjetDataManager.shared.historyBooking.arrival else { return }
        lbReturnFlightNo.text = "\(arrival.airlineNumber) - \(arrival.fareClass)"
        lbReturnDate.text = arrival.departureDate
        lbReturnFromCode.text = arrival.cityPair.departure.code
        lbReturnFromCity.text = arrival.cityPair.departure.name
        lbReturnFromTime.text = arrival.cityPair.departure.hours
        lbReturnTotalTime.text = arrival.totalTime
        lbReturnToCode.text = arrival.cityPair.arrival.code
        lbReturnToCity.text = arrival.cityPair.arrival.name
        lbReturnToTime.text = arrival.cityPair.arrival.hours
        lbReturnPassenger.text = "\(VietjetDataManager.shared.historyBooking.passengers.count) Hành khách"
    }
    
    @IBAction func editDepartureButtonPressed(_ sender: Any) {
        let vc = BookingChangeFlightViewController()
        VietjetDataManager.shared.isDeparture = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func editReturnButtonPressed(_ sender: Any) {
        let vc = BookingChangeFlightViewController()
        VietjetDataManager.shared.isDeparture = false
        navigationController?.pushViewController(vc, animated: true)
    }
}
