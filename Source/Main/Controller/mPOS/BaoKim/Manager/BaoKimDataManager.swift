//
//  BaoKimDataManager.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 18/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

class BaoKimDataManager {
    static let shared = BaoKimDataManager()
    
    //MARK:- CUSTOMER
    var name: String = ""
    var phone: String = ""
    var email: String = ""
    
    //MARK:- DATA
    var cities: [BaoKimLocation] = []
    var companies: [BaoKimFilterCompaniesData] = []
    var selectedTrip: BaoKimTripData = BaoKimTripData(JSON: [:])!
    var selectedSeats: [BaoKimSeatTemplate] = []
    var selectedPickup: BaoKimDropOffPointsatArrive = BaoKimDropOffPointsatArrive(JSON: [:])!
    var selectedDropoff: BaoKimDropOffPointsatArrive = BaoKimDropOffPointsatArrive(JSON: [:])!
    var bookingCode: BaoKimBookingCode = BaoKimBookingCode(JSON: [:])!
    var bookingInfo: BaoKimBooking = BaoKimBooking(JSON: [:])!
    var voucherInfo: BaoKimVoucher = BaoKimVoucher(JSON: [:])!
    
    //MARK:- PARAM
    var searchTripParam: BaoKimSearchTripParam = BaoKimSearchTripParam(JSON: [:])!
    var bookTripParam: BaoKimBookingParam = BaoKimBookingParam(JSON: [:])!
    
    func resetCustomer() {
        name = ""
        phone = ""
        email = ""
    }
    
    func resetData() {
        selectedTrip = BaoKimTripData(JSON: [:])!
        selectedSeats = []
        selectedPickup = BaoKimDropOffPointsatArrive(JSON: [:])!
        selectedDropoff = BaoKimDropOffPointsatArrive(JSON: [:])!
        bookingCode = BaoKimBookingCode(JSON: [:])!
        bookingInfo = BaoKimBooking(JSON: [:])!
        voucherInfo = BaoKimVoucher(JSON: [:])!
    }
    
    func resetParam() {
        searchTripParam = BaoKimSearchTripParam(JSON: [:])!
        bookTripParam = BaoKimBookingParam(JSON: [:])!
    }
}
