//
//  BookingChangeFlightViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 11/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class BookingChangeFlightViewController: UIViewController {

    //MARK:- SEARCH FLIGHT
    @IBOutlet weak var vSearch: UIView!
    @IBOutlet weak var vFrom: UIView!
    @IBOutlet weak var lbFromDate: UILabel!
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var vTo: UIView!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    
    //MARK:- CURRENT FLIGHT INFO
    @IBOutlet var vCircles: [UIView]!
    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbFlightNo: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbFromCode: UILabel!
    @IBOutlet weak var lbFromCity: UILabel!
    @IBOutlet weak var lbFromTime: UILabel!
    @IBOutlet weak var lbTotalTime: UILabel!
    @IBOutlet weak var lbToCode: UILabel!
    @IBOutlet weak var lbToCity: UILabel!
    @IBOutlet weak var lbToTime: UILabel!
    @IBOutlet weak var lbPassenger: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCurrentFlightUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchUI()
    }
    
    private func setupUI() {
        title = "Tìm chuyến bay"
        addBackButton()
        
        for circle in vCircles {
            circle.roundCorners(.allCorners, radius: 16)
        }
        vBackground.roundCorners(.allCorners, radius: 10)
        vSearch.roundCorners(.allCorners, radius: 10)
        btnSearch.roundCorners(.allCorners, radius: 20)
        vFrom.roundCorners(.allCorners, radius: 20)
        vTo.roundCorners(.allCorners, radius: 20)
        
        let booking = VietjetDataManager.shared.historyBooking
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let bookingDate = dateFormatter.date(from: VietjetDataManager.shared.isDeparture ? booking.departure.departureDate : booking.arrival!.departureDate) ?? Date()
        VietjetDataManager.shared.selectedFirstDate = bookingDate
        
        VietjetDataManager.shared.isOneWay = true
        VietjetDataManager.shared.adultCount = booking.passengers.filter { $0.fareApplicability == "adult" }.count
        VietjetDataManager.shared.childCount = booking.passengers.filter { $0.fareApplicability == "child" }.count
        VietjetDataManager.shared.infantCount = booking.passengers.filter { $0.fareApplicability == "infant" }.count
        
        let departure = Departure(JSON: [:])!
        departure.name = VietjetDataManager.shared.isDeparture ? booking.departure.cityPair.departure.name : booking.arrival!.cityPair.departure.name
        departure.code = VietjetDataManager.shared.isDeparture ? booking.departure.cityPair.departure.code : booking.arrival!.cityPair.departure.code
        VietjetDataManager.shared.selectedDepartureCity = departure
        
        let arrival = Departure(JSON: [:])!
        arrival.name = VietjetDataManager.shared.isDeparture ? booking.departure.cityPair.arrival.name : booking.arrival!.cityPair.arrival.name
        arrival.code = VietjetDataManager.shared.isDeparture ? booking.departure.cityPair.arrival.code : booking.arrival!.cityPair.arrival.code
        VietjetDataManager.shared.selectedArrivalCity = arrival
    }
    
    private func setupSearchUI() {
        let dayOfWeek = VietjetDataManager.shared.selectedFirstDate.getDayOfWeek()
        lbFromDate.text = "\(dayOfWeek == 1 ? "CN" : "T\(dayOfWeek)"), \(VietjetDataManager.shared.selectedFirstDate.stringWith(format: "dd/MM"))"
        
        if !VietjetDataManager.shared.selectedDepartureCity.name.isEmpty {
            lbFrom.text = "\(VietjetDataManager.shared.selectedDepartureCity.name) - \(VietjetDataManager.shared.selectedDepartureCity.code)"
        }
        
        if !VietjetDataManager.shared.selectedArrivalCity.name.isEmpty {
            lbTo.text = "\(VietjetDataManager.shared.selectedArrivalCity.name) - \(VietjetDataManager.shared.selectedArrivalCity.code)"
        }
    }
    
    private func setupCurrentFlightUI() {
        let flight = VietjetDataManager.shared.isDeparture ? VietjetDataManager.shared.historyBooking.departure : VietjetDataManager.shared.historyBooking.arrival!
        
        lbFlightNo.text = "\(flight.airlineNumber) - \(flight.fareClass)"
        lbDate.text = flight.departureDate
        lbFromCode.text = flight.cityPair.departure.code
        lbFromCity.text = flight.cityPair.departure.name
        lbFromTime.text = flight.cityPair.departure.hours
        lbTotalTime.text = flight.totalTime
        lbToCode.text = flight.cityPair.arrival.code
        lbToCity.text = flight.cityPair.arrival.name
        lbToTime.text = flight.cityPair.arrival.hours
        lbPassenger.text = "\(VietjetDataManager.shared.historyBooking.passengers.count) Hành khách"
    }
    
    @IBAction func fromButtonPressed(_ sender: Any) {
        let vc = SearchVietjetFlightViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func fromDateButtonPressed(_ sender: Any) {
        let vc = SelectVietjetFlightDateViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func toButtonPressed(_ sender: Any) {
        let vc = SearchVietjetFlightViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        let vc = SelectBookingChangeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
