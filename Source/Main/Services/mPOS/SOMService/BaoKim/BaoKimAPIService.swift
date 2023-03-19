//
//  BaoKimAPIService.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 17/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol BaoKimAPIServiceProtocol {
    func getCitiesAndDistricts(success: @escaping SuccessHandler<BaoKimCitiesAndDistricts>.object, failure: @escaping RequestFailure)
    func getCities(success: @escaping SuccessHandler<BaoKimCities>.object, failure: @escaping RequestFailure)
    func getDistricts(cityId: String, success: @escaping SuccessHandler<BaoKimDistricts>.object, failure: @escaping RequestFailure)
    func getTrips(param: BaoKimSearchTripParam, success: @escaping SuccessHandler<BaoKimTrip>.object, failure: @escaping RequestFailure)
    func getSeats(tripCode: String, success: @escaping SuccessHandler<BaoKimSeat>.object, failure: @escaping RequestFailure)
    func getPoints(pointId: Int, success: @escaping SuccessHandler<BaoKimPoint>.object, failure: @escaping RequestFailure)
    func bookTrip(param: BaoKimBookingParam, success: @escaping SuccessHandler<BaoKimBookingCode>.object, failure: @escaping RequestFailure)
    func getTransactionId(seats: String, quantity: Int, success: @escaping SuccessHandler<BaoKimTransaction>.object, failure: @escaping RequestFailure)
    func getBookingInfo(bookingCode: String, success: @escaping SuccessHandler<BaoKimBooking>.object, failure: @escaping RequestFailure)
    func getVoucherInfo(voucher: String, tripCode: String, bookingCode: String, success: @escaping SuccessHandler<BaoKimVoucher>.object, failure: @escaping RequestFailure)
    func paymentBooking(transactionCode: String, bookingCode: String, voucher: String, success: @escaping SuccessHandler<BaoKimBookingCode>.object, failure: @escaping RequestFailure)
    func updateMPOSBooking(transactionCode: String, bookingCode: String, bookingInfo: String, price: Int, success: @escaping SuccessHandler<BaoKimTransaction>.object, failure: @escaping RequestFailure)
    func updateMPOSVoucher(transactionCode: String, bookingCode: String, voucherInfo: String, price: Int, success: @escaping SuccessHandler<BaoKimTransaction>.object, failure: @escaping RequestFailure)
    func getMPOSProduct(success: @escaping SuccessHandler<BaoKimProduct>.object, failure: @escaping RequestFailure)
    func updateMPOSPayment(bookingCode: String, transactionCode: String, voucher: String, des: String, rdr1: String, promos: String, voucherMPOS: String, xmlPayment: String, xmlVoucher: String, success: @escaping SuccessHandler<BaoKimTransaction>.object, failure: @escaping RequestFailure)
    func getHistories(success: @escaping SuccessHandler<BaoKimHistory>.array, failure: @escaping RequestFailure)
    func getHistoryDetail(bookingCode: String, mposCode: String, success: @escaping SuccessHandler<BaoKimHistoryDetail>.object, failure: @escaping RequestFailure)
    func getFilters(from: Int, to: Int, date: String, success: @escaping SuccessHandler<BaoKimFilter>.object, failure: @escaping RequestFailure)
    func getCompanyDetail(companyId: String, success: @escaping SuccessHandler<BaoKimCompanyDetail>.object, failure: @escaping RequestFailure)
}

class BaoKimAPIService: BaoKimAPIServiceProtocol {

    private let network: APINetworkProtocol

    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getCitiesAndDistricts(success: @escaping SuccessHandler<BaoKimCitiesAndDistricts>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.getCitiesAndDistricts
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getCities(success: @escaping SuccessHandler<BaoKimCities>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.getCities
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getDistricts(cityId: String, success: @escaping SuccessHandler<BaoKimDistricts>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.getDistricts(cityId: cityId)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getTrips(param: BaoKimSearchTripParam, success: @escaping SuccessHandler<BaoKimTrip>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.getTrips(param: param)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getSeats(tripCode: String, success: @escaping SuccessHandler<BaoKimSeat>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.getSeats(tripCode: tripCode)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getPoints(pointId: Int, success: @escaping SuccessHandler<BaoKimPoint>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.getPoints(pointId: pointId)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func bookTrip(param: BaoKimBookingParam, success: @escaping SuccessHandler<BaoKimBookingCode>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.bookTrip(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getTransactionId(seats: String, quantity: Int, success: @escaping SuccessHandler<BaoKimTransaction>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.getTransactionId(seats: seats, quantity: quantity)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getBookingInfo(bookingCode: String, success: @escaping SuccessHandler<BaoKimBooking>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.getBookingInfo(bookingCode: bookingCode)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getVoucherInfo(voucher: String, tripCode: String, bookingCode: String, success: @escaping SuccessHandler<BaoKimVoucher>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.getVoucherInfo(voucher: voucher, tripCode: tripCode, bookingCode: bookingCode)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func paymentBooking(transactionCode: String, bookingCode: String, voucher: String, success: @escaping SuccessHandler<BaoKimBookingCode>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.paymentBooking(transactionCode: transactionCode, bookingCode: bookingCode, voucher: voucher)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func updateMPOSBooking(transactionCode: String, bookingCode: String, bookingInfo: String, price: Int, success: @escaping SuccessHandler<BaoKimTransaction>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.updateMPOSBooking(transactionCode: transactionCode, bookingCode: bookingCode, bookingInfo: bookingInfo, price: price)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func updateMPOSVoucher(transactionCode: String, bookingCode: String, voucherInfo: String, price: Int, success: @escaping SuccessHandler<BaoKimTransaction>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.updateMPOSVoucher(transactionCode: transactionCode, bookingCode: bookingCode, voucherInfo: voucherInfo, price: price)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getMPOSProduct(success: @escaping SuccessHandler<BaoKimProduct>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.getMPOSProduct
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func updateMPOSPayment(bookingCode: String, transactionCode: String, voucher: String, des: String, rdr1: String, promos: String, voucherMPOS: String, xmlPayment: String, xmlVoucher: String, success: @escaping SuccessHandler<BaoKimTransaction>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.updateMPOSPayment(bookingCode: bookingCode, transactionCode: transactionCode, voucher: voucher, des: des, rdr1: rdr1, promos: promos, voucherMPOS: voucherMPOS, xmlPayment: xmlPayment, xmlVoucher: xmlVoucher)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getHistories(success: @escaping SuccessHandler<BaoKimHistory>.array, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.getHistories
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getHistoryDetail(bookingCode: String, mposCode: String, success: @escaping SuccessHandler<BaoKimHistoryDetail>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.getHistoryDetail(bookingCode: bookingCode, mposCode: mposCode)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getFilters(from: Int, to: Int, date: String, success: @escaping SuccessHandler<BaoKimFilter>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.getFilters(from: from, to: to, date: date)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getCompanyDetail(companyId: String, success: @escaping SuccessHandler<BaoKimCompanyDetail>.object, failure: @escaping RequestFailure) {
        let endPoint = BaoKimEndPoint.getCompanyDetail(companyId: companyId)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
