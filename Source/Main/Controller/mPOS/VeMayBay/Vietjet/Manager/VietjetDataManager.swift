//
//  VietjetDataManager.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

class VietjetDataManager {
    static let shared = VietjetDataManager()
    
    // MARK:- BOOKING FLOW
    // MARK:- Is Oneway
    var isOneWay: Bool = false
    
    // MARK:- Date
    var firstDate: Date?
    var lastDate: Date?
    var datesRange: [Date]?
    var selectedFirstDate: Date = Date()
    var selectedLastDate: Date?
    
    // MARK:- Passenger
    var adultCount: Int = 1
    var childCount: Int = 0
    var infantCount: Int = 0
    
    // MARK:- City Pairs
    var cityPairs: VietjetDeparture = VietjetDeparture(JSON: [:])!
    var departureCity: Departure = Departure(JSON: [:])!
    var arrivalCity: Departure = Departure(JSON: [:])!
    var selectedDepartureCity: Departure = Departure(JSON: [:])!
    var selectedArrivalCity: Departure = Departure(JSON: [:])!
    
    // MARK:- Travel Options
    var travelOptions: VietjetTravelOption = VietjetTravelOption(JSON: [:])!
    var selectedDepartureTravel: VietjetTravel = VietjetTravel(JSON: [:])!
    var selectedReturnTravel: VietjetTravel = VietjetTravel(JSON: [:])!
    
    // MARK:- Fare Charge
    var selectedDepartureFareOption: FareOption = FareOption(JSON: [:])!
    var selectedReturnFareOption: FareOption = FareOption(JSON: [:])!
    
    // MARK:- Passenger
    var passengers: [VietjetPassenger] = []
    
    // MARK:- Contact
    var contact: VietjetContact = VietjetContact(JSON: [:])!
    
    // MARK:- Baggage
    var departureBaggages: [VietjetBaggage] = []
    var returnBaggages: [VietjetBaggage] = []
    var selectedDepartureBaggages: [VietjetBaggage] = []
    var selectedReturnBaggages: [VietjetBaggage] = []
    var choosenDepartureBaggages: [VietjetBaggage] = []
    var choosenReturnBaggages: [VietjetBaggage] = []
    
    // MARK:- Seat
    var departureSeat: VietjetSeat = VietjetSeat(JSON: [:])!
    var returnSeat: VietjetSeat = VietjetSeat(JSON: [:])!
    var selectedDepartureSeats: [VietjetSeatOption] = []
    var selectedReturnSeats: [VietjetSeatOption] = []
    
    // MARK:- Insurance
    var insurances: [VietjetInsurance] = []
    var selectedInsurance: [VietjetInsurance] = []
    
    // MARK:- Order Param
    var orderParam: VietjetPriceQuotationParam = VietjetPriceQuotationParam(JSON: [:])!
    
    func resetData() {
        isOneWay = false
        firstDate = nil
        lastDate = nil
        datesRange = nil
        selectedFirstDate = Date()
        selectedLastDate = nil
        adultCount = 1
        childCount = 0
        infantCount = 0
        cityPairs = VietjetDeparture(JSON: [:])!
        departureCity = Departure(JSON: [:])!
        arrivalCity = Departure(JSON: [:])!
        selectedDepartureCity = Departure(JSON: [:])!
        selectedArrivalCity = Departure(JSON: [:])!
        travelOptions = VietjetTravelOption(JSON: [:])!
        selectedDepartureTravel = VietjetTravel(JSON: [:])!
        selectedReturnTravel = VietjetTravel(JSON: [:])!
        selectedDepartureFareOption = FareOption(JSON: [:])!
        selectedReturnFareOption = FareOption(JSON: [:])!
        passengers = []
        contact = VietjetContact(JSON: [:])!
        departureBaggages = []
        returnBaggages = []
        selectedDepartureBaggages = []
        selectedReturnBaggages = []
        choosenDepartureBaggages = []
        choosenReturnBaggages = []
        departureSeat = VietjetSeat(JSON: [:])!
        returnSeat = VietjetSeat(JSON: [:])!
        selectedDepartureSeats = []
        selectedReturnSeats = []
        insurances = []
        selectedInsurance = []
        orderParam = VietjetPriceQuotationParam(JSON: [:])!
    }
    
    func prepareParam() {
        let param = VietjetPriceQuotationParam(JSON: [:])!
        param.contact = VietjetDataManager.shared.contact
        
        param.order.shopcode = Cache.user!.ShopCode
        param.order.usercode = Cache.user!.UserName
        param.order.deviceID = Int(Cache.UUID) ?? 2
        
        var totalAmount = VietjetDataManager.shared.selectedDepartureFareOption.totalAmount + VietjetDataManager.shared.selectedReturnFareOption.totalAmount
        for p in VietjetDataManager.shared.selectedDepartureBaggages {
            totalAmount += p.ancillaryCharge.totalAmount
        }
        for p in VietjetDataManager.shared.selectedReturnBaggages {
            totalAmount += p.ancillaryCharge.totalAmount
        }
        for p in VietjetDataManager.shared.selectedDepartureSeats {
            totalAmount += p.seatCharges.totalAmount
        }
        for p in VietjetDataManager.shared.selectedReturnSeats {
            totalAmount += p.seatCharges.totalAmount
        }
        param.order.totalAmount = totalAmount
        
        var totalAmountFRT = VietjetDataManager.shared.selectedDepartureFareOption.totalAmountFRT + VietjetDataManager.shared.selectedReturnFareOption.totalAmountFRT
        for p in VietjetDataManager.shared.selectedDepartureBaggages {
            totalAmountFRT += p.ancillaryCharge.totalAmountFRT
        }
        for p in VietjetDataManager.shared.selectedReturnBaggages {
            totalAmountFRT += p.ancillaryCharge.totalAmountFRT
        }
        for p in VietjetDataManager.shared.selectedDepartureSeats {
            totalAmountFRT += p.seatCharges.totalAmountFRT
        }
        for p in VietjetDataManager.shared.selectedReturnSeats {
            totalAmountFRT += p.seatCharges.totalAmountFRT
        }
        param.order.totalAmountFRT = totalAmountFRT
        
        param.booking.adultCount = VietjetDataManager.shared.adultCount
        param.booking.childCount = VietjetDataManager.shared.childCount
        param.booking.infantCount = VietjetDataManager.shared.infantCount
        
        param.booking.departure.cityPair = VietjetDataManager.shared.selectedDepartureTravel.cityPair
        param.booking.departure.aircraftModel = VietjetDataManager.shared.selectedDepartureTravel.aircraftModel
        param.booking.departure.airlineNumber = VietjetDataManager.shared.selectedDepartureTravel.airlineNumber
        param.booking.departure.bookingKey = VietjetDataManager.shared.selectedDepartureFareOption.bookingKey
        
        if !VietjetDataManager.shared.isOneWay {
            let arrival = VietjetBookingDeparture(JSON: [:])!
            arrival.cityPair = VietjetDataManager.shared.selectedReturnTravel.cityPair
            arrival.aircraftModel = VietjetDataManager.shared.selectedReturnTravel.aircraftModel
            arrival.airlineNumber = VietjetDataManager.shared.selectedReturnTravel.airlineNumber
            arrival.bookingKey = VietjetDataManager.shared.selectedReturnFareOption.bookingKey
            
            param.booking.arrival = arrival
        }
        
        for (index, passenger) in VietjetDataManager.shared.passengers.enumerated() {
            if VietjetDataManager.shared.selectedDepartureBaggages.count > 0 || VietjetDataManager.shared.selectedDepartureSeats.count > 0 {
                let departure: VietjetPassengerDeparture = VietjetPassengerDeparture(JSON: [:])!
                
                if !VietjetDataManager.shared.selectedDepartureBaggages[index].purchaseKey.isEmpty {
                    let baggage = VietjetDataManager.shared.selectedDepartureBaggages[index]
                    let ancillary = VietjetAncillary(JSON: [:])!
                    ancillary.ancillaryDescription = baggage.description
                    ancillary.purchaseKey = baggage.purchaseKey
                    departure.ancillaries.append(ancillary)
                }
                
                if !VietjetDataManager.shared.selectedDepartureSeats[index].selectionKey.isEmpty {
                    let seat = VietjetDataManager.shared.selectedDepartureSeats[index]
                    let seatOption = VietjetSeatOrderOption(JSON: [:])!
                    seatOption.seatName = "\(seat.seatMapCell.rowIdentifier)-\(seat.seatMapCell.seatIdentifier)"
                    seatOption.selectionKey = seat.selectionKey
                    departure.seatOption = seatOption
                }
                
                passenger.departure = departure
            }
        }
        
        if !VietjetDataManager.shared.isOneWay {
            for (index, passenger) in VietjetDataManager.shared.passengers.enumerated() {
                if VietjetDataManager.shared.selectedReturnBaggages.count > 0 || VietjetDataManager.shared.selectedReturnSeats.count > 0 {
                    let arrival: VietjetPassengerDeparture = VietjetPassengerDeparture(JSON: [:])!
                    
                    if !VietjetDataManager.shared.selectedReturnBaggages[index].purchaseKey.isEmpty {
                        let baggage = VietjetDataManager.shared.selectedReturnBaggages[index]
                        let ancillary = VietjetAncillary(JSON: [:])!
                        ancillary.ancillaryDescription = baggage.description
                        ancillary.purchaseKey = baggage.purchaseKey
                        arrival.ancillaries.append(ancillary)
                    }
                    
                    if !VietjetDataManager.shared.selectedReturnSeats[index].selectionKey.isEmpty {
                        let seat = VietjetDataManager.shared.selectedReturnSeats[index]
                        let seatOption = VietjetSeatOrderOption(JSON: [:])!
                        seatOption.seatName = "\(seat.seatMapCell.rowIdentifier)-\(seat.seatMapCell.seatIdentifier)"
                        seatOption.selectionKey = seat.selectionKey
                        arrival.seatOption = seatOption
                    }
                    
                    passenger.arrival = arrival
                }
            }
        }
        
        param.booking.passengers = VietjetDataManager.shared.passengers
        
        for passenger in param.booking.passengers {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            let pattern = "^\\d{2}/\\d{2}/\\d{4}$"
            let reservationRange = NSRange(location: 0, length: passenger.reservationProfile.birthDate.utf16.count)
            let regex = try! NSRegularExpression(pattern: pattern)
            
            if regex.firstMatch(in: passenger.reservationProfile.birthDate, options: [], range: reservationRange) != nil {
                let dob = dateFormatter.date(from: passenger.reservationProfile.birthDate) ?? Date()
                passenger.reservationProfile.birthDate = dob.stringWith(format: "yyyy-MM-dd")
            }
            
            if let infant = passenger.infantProfile {
                let infantRange = NSRange(location: 0, length: infant.birthDate.utf16.count)
                if regex.firstMatch(in: infant.birthDate, options: [], range: infantRange) != nil {
                    let infantDOB = dateFormatter.date(from: infant.birthDate) ?? Date()
                    infant.birthDate = infantDOB.stringWith(format: "yyyy-MM-dd")
                }
            }
        }
        
        var insurances: [VietjetInsurancePolicy] = []
        for insurance in VietjetDataManager.shared.selectedInsurance {
            let option = VietjetInsurancePolicy(JSON: [:])!
            option.name = insurance.name
            option.purchaseKey = insurance.purchaseKey
            insurances.append(option)
        }
        param.booking.insurancePolicies = insurances
        
        orderParam = param
    }
    
    // MARK:- ADDON FLOW
    var isAddon: Bool = false
    var isAddonBaggage: Bool = true
    var isUpdateSeat: Bool = false
    var historyBooking: VietjetHistoryBooking = VietjetHistoryBooking(JSON: [:])!
    var ancillaryOrderParam: VietjetAncillaryPriceQuotationParam = VietjetAncillaryPriceQuotationParam(JSON: [:])!
    var seatOrderParam: VietjetAncillaryPriceQuotationParam = VietjetAncillaryPriceQuotationParam(JSON: [:])!
    
    func resetAddon() {
        departureBaggages = []
        returnBaggages = []
        departureSeat = VietjetSeat(JSON: [:])!
        returnSeat = VietjetSeat(JSON: [:])!
        historyBooking = VietjetHistoryBooking(JSON: [:])!
        ancillaryOrderParam = VietjetAncillaryPriceQuotationParam(JSON: [:])!
        seatOrderParam = VietjetAncillaryPriceQuotationParam(JSON: [:])!
        isAddon = false
        isAddonBaggage = true
        isUpdateSeat = false
    }
    
    // MARK:- CHANGE FLIGHT
    var isChangeFlight: Bool = false
    var isDeparture: Bool = true
    var selectedChangeTravel: VietjetTravel = VietjetTravel(JSON: [:])!
    var selectedChangeFareOption: FareOption = FareOption(JSON: [:])!
    var changeFlightParam: VietjetJourneyPriceQuotationParam = VietjetJourneyPriceQuotationParam(JSON: [:])!
    
    func resetChangeFlight() {
        isChangeFlight = false
        isDeparture = true
        historyBooking = VietjetHistoryBooking(JSON: [:])!
        isOneWay = false
        adultCount = 1
        childCount = 0
        infantCount = 0
        selectedDepartureCity = Departure(JSON: [:])!
        selectedArrivalCity = Departure(JSON: [:])!
        travelOptions = VietjetTravelOption(JSON: [:])!
        selectedChangeTravel = VietjetTravel(JSON: [:])!
        selectedChangeFareOption = FareOption(JSON: [:])!
        changeFlightParam = VietjetJourneyPriceQuotationParam(JSON: [:])!
    }
}
