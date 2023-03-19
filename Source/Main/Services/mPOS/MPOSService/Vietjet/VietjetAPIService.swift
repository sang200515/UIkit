//
//  VietjetAPIService.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire

protocol VietjetAPIServiceProtocol {
    func getCityPairs(success: @escaping SuccessHandler<VietjetDeparture>.object, failure: @escaping RequestFailure)
    func getTravelOptions(from: String, to: String, fromTime: String, adult: Int, child: Int, infant: Int, toTime: String, reservationKey: String, journeyKey: String, success: @escaping SuccessHandler<VietjetTravelOption>.object, failure: @escaping RequestFailure)
    func getSeatOptions(bookingKey: String, success: @escaping SuccessHandler<VietjetSeat>.object, failure: @escaping RequestFailure)
    func getAncillaryOptions(bookingKey: String, success: @escaping SuccessHandler<VietjetBaggage>.array, failure: @escaping RequestFailure)
    func calculateVietjetPrice(param: VietjetPriceQuotationParam, success: @escaping SuccessHandler<VietjetBill>.object, failure: @escaping RequestFailure)
    func checkPromotions(phone: String, xml: String, success: @escaping SuccessHandler<JetPromotion>.object, failure: @escaping RequestFailure)
    func createReservation(param: VietjetPriceQuotationParam, success: @escaping SuccessHandler<VietjetOrderMessage>.object, failure: @escaping RequestFailure)
    func getOrderHistory(key: String, success: @escaping SuccessHandler<VietjetPaymentHistory>.array, failure: @escaping RequestFailure)
    func getOrderDetail(id: Int, mpos: Int, locator: String, success: @escaping SuccessHandler<VietjetHistoryOrder>.object, failure: @escaping RequestFailure)
    func getInsuranceOptions(param: VietjetPriceQuotationParam, success: @escaping SuccessHandler<VietjetInsurance>.array, failure: @escaping RequestFailure)
    func getReservation(locator: String, success: @escaping SuccessHandler<VietjetHistoryBooking>.object, failure: @escaping RequestFailure)
    func calculateVietjetAncillaryPrice(param: VietjetAncillaryPriceQuotationParam, success: @escaping SuccessHandler<VietjetBill>.object, failure: @escaping RequestFailure)
    func calculateVietjetSeatPrice(param: VietjetAncillaryPriceQuotationParam, success: @escaping SuccessHandler<VietjetBill>.object, failure: @escaping RequestFailure)
    func createVietjetAncillary(param: VietjetAncillaryPriceQuotationParam, success: @escaping SuccessHandler<VietjetOrderMessage>.object, failure: @escaping RequestFailure)
    func createVietjetSeat(param: VietjetAncillaryPriceQuotationParam, success: @escaping SuccessHandler<VietjetOrderMessage>.object, failure: @escaping RequestFailure)
    func calculateVietjetUpdateSeatPrice(param: VietjetAncillaryPriceQuotationParam, success: @escaping SuccessHandler<VietjetBill>.object, failure: @escaping RequestFailure)
    func createVietjetUpdateSeat(param: VietjetAncillaryPriceQuotationParam, success: @escaping SuccessHandler<VietjetOrderMessage>.object, failure: @escaping RequestFailure)
    func calculateVietjetUpdateFlightPrice(param: VietjetJourneyPriceQuotationParam, success: @escaping SuccessHandler<VietjetBill>.object, failure: @escaping RequestFailure)
    func createVietjetUpdateFlight(param: VietjetJourneyPriceQuotationParam, success: @escaping SuccessHandler<VietjetOrderMessage>.object, failure: @escaping RequestFailure)
}

class VietjetAPIService: VietjetAPIServiceProtocol {

    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }

    func getCityPairs(success: @escaping SuccessHandler<VietjetDeparture>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.getCityPairs
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getTravelOptions(from: String, to: String, fromTime: String, adult: Int, child: Int, infant: Int, toTime: String, reservationKey: String, journeyKey: String, success: @escaping SuccessHandler<VietjetTravelOption>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.getTravelOptions(from: from, to: to, fromTime: fromTime, adult: adult, child: child, infant: infant, toTime: toTime, reservationKey: reservationKey, journeyKey: journeyKey)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getSeatOptions(bookingKey: String, success: @escaping SuccessHandler<VietjetSeat>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.getSeatOptions(bookingKey: bookingKey)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getAncillaryOptions(bookingKey: String, success: @escaping SuccessHandler<VietjetBaggage>.array, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.getAncillaryOptions(bookingKey: bookingKey)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func calculateVietjetPrice(param: VietjetPriceQuotationParam, success: @escaping SuccessHandler<VietjetBill>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.calculateVietjetPrice(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func checkPromotions(phone: String, xml: String, success: @escaping SuccessHandler<JetPromotion>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.checkPromotions(phone: phone, xml: xml)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func createReservation(param: VietjetPriceQuotationParam, success: @escaping SuccessHandler<VietjetOrderMessage>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.createReservation(param: param)
        network.requestData(withTimeInterval: 300, endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getOrderHistory(key: String, success: @escaping SuccessHandler<VietjetPaymentHistory>.array, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.getOrderHistory(key: key)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getOrderDetail(id: Int, mpos: Int, locator: String, success: @escaping SuccessHandler<VietjetHistoryOrder>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.getOrderDetail(id: id, mpos: mpos, locator: locator)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getInsuranceOptions(param: VietjetPriceQuotationParam, success: @escaping SuccessHandler<VietjetInsurance>.array, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.getInsuranceOptions(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getReservation(locator: String, success: @escaping SuccessHandler<VietjetHistoryBooking>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.getReservation(locator: locator)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func calculateVietjetAncillaryPrice(param: VietjetAncillaryPriceQuotationParam, success: @escaping SuccessHandler<VietjetBill>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.calculateVietjetAncillaryPrice(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func calculateVietjetSeatPrice(param: VietjetAncillaryPriceQuotationParam, success: @escaping SuccessHandler<VietjetBill>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.calculateVietjetSeatPrice(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func createVietjetAncillary(param: VietjetAncillaryPriceQuotationParam, success: @escaping SuccessHandler<VietjetOrderMessage>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.createVietjetAncillary(param: param)
        network.requestData(withTimeInterval: 300, endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func createVietjetSeat(param: VietjetAncillaryPriceQuotationParam, success: @escaping SuccessHandler<VietjetOrderMessage>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.createVietjetSeat(param: param)
        network.requestData(withTimeInterval: 300, endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func calculateVietjetUpdateSeatPrice(param: VietjetAncillaryPriceQuotationParam, success: @escaping SuccessHandler<VietjetBill>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.calculateVietjetUpdateSeatPrice(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func createVietjetUpdateSeat(param: VietjetAncillaryPriceQuotationParam, success: @escaping SuccessHandler<VietjetOrderMessage>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.createVietjetUpdateSeat(param: param)
        network.requestData(withTimeInterval: 300, endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func calculateVietjetUpdateFlightPrice(param: VietjetJourneyPriceQuotationParam, success: @escaping SuccessHandler<VietjetBill>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.calculateVietjetUpdateFlightPrice(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func createVietjetUpdateFlight(param: VietjetJourneyPriceQuotationParam, success: @escaping SuccessHandler<VietjetOrderMessage>.object, failure: @escaping RequestFailure) {
        let endPoint = VietjetEndPoint.createVietjetUpdateFlight(param: param)
        network.requestData(withTimeInterval: 300, endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
