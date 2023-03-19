//
//  VietjetEndPoint.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum VietjetEndPoint {
    case getCityPairs
    case getTravelOptions(from: String, to: String, fromTime: String, adult: Int, child: Int, infant: Int, toTime: String, reservationKey: String, journeyKey: String)
    case getSeatOptions(bookingKey: String)
    case getAncillaryOptions(bookingKey: String)
    case calculateVietjetPrice(param: VietjetPriceQuotationParam)
    case checkPromotions(phone: String, xml: String)
    case createReservation(param: VietjetPriceQuotationParam)
    case getOrderHistory(key: String)
    case getOrderDetail(id: Int, mpos: Int, locator: String)
    case getInsuranceOptions(param: VietjetPriceQuotationParam)
    case getReservation(locator: String)
    case calculateVietjetAncillaryPrice(param: VietjetAncillaryPriceQuotationParam)
    case calculateVietjetSeatPrice(param: VietjetAncillaryPriceQuotationParam)
    case calculateVietjetUpdateSeatPrice(param: VietjetAncillaryPriceQuotationParam)
    case createVietjetAncillary(param: VietjetAncillaryPriceQuotationParam)
    case createVietjetSeat(param: VietjetAncillaryPriceQuotationParam)
    case createVietjetUpdateSeat(param: VietjetAncillaryPriceQuotationParam)
    case calculateVietjetUpdateFlightPrice(param: VietjetJourneyPriceQuotationParam)
    case createVietjetUpdateFlight(param: VietjetJourneyPriceQuotationParam)
}

extension VietjetEndPoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getCityPairs,
             .getTravelOptions,
             .getOrderHistory,
             .getOrderDetail,
             .getReservation:
            return .get
        default:
            return .post
        }
    }

    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY! + "/mpos-cloud-api"
            
        switch self {
        case .getCityPairs:
            return BASE_URL + "/api/vietjetair/CityPairs"
        case .getTravelOptions:
            return BASE_URL + "/api/vietjetair/TravelOptions"
        case .getSeatOptions:
            return BASE_URL + "/api/vietjetair/SeatOptions"
        case .getAncillaryOptions:
            return BASE_URL + "/api/vietjetair/AncillaryOptions"
        case .calculateVietjetPrice:
            return BASE_URL + "/api/vietjetair/PriceQuotations"
        case .checkPromotions:
            return BASE_URL + "/api/vietjetair/Checkpromotions"
        case .createReservation:
            return BASE_URL + "/api/vietjetair/CreateReservation"
        case .getOrderHistory:
            return BASE_URL + "/api/vietjetair/OrderHistory"
        case .getOrderDetail:
            return BASE_URL + "/api/vietjetair/OrderDetails"
        case .getInsuranceOptions:
            return BASE_URL + "/api/vietjetair/InsuranceOptions"
        case .getReservation:
            return BASE_URL + "/api/vietjetair/GetReservation"
        case .calculateVietjetAncillaryPrice:
            return BASE_URL + "/api/vietjetair/AncillaryPurchasesQuotations"
        case .calculateVietjetSeatPrice:
            return BASE_URL + "/api/vietjetair/SeatSelectionsQuotations"
        case .createVietjetAncillary:
            return BASE_URL + "/api/vietjetair/AddAncillaryPurchases"
        case .createVietjetSeat:
            return BASE_URL + "/api/vietjetair/AddSeatSelections"
        case .calculateVietjetUpdateSeatPrice:
            return BASE_URL + "/api/vietjetair/UpdateSeatSelectionsQuotations"
        case .createVietjetUpdateSeat:
            return BASE_URL + "/api/vietjetair/UpdateSeatSelections"
        case .calculateVietjetUpdateFlightPrice:
            return BASE_URL + "/api/vietjetair/UpdateJourneyQuotations"
        case .createVietjetUpdateFlight:
            return BASE_URL + "/api/vietjetair/UpdateJourney"
        }
    }

    var parameters: JSONDictionary {
        switch self {
        case .getTravelOptions(let from, let to, let fromTime, let adult, let child, let infant, let toTime, let reservationKey, let journeyKey):
            return ["cityPair": "\(from)-\(to)",
                    "departure": fromTime,
                    "cabinClass": "Y",
                    "currency": "VND",
                    "adultCount": adult,
                    "childCount": child,
                    "infantCount": infant,
                    "return": toTime,
                    "promoCode": "",
                    "company": "",
                    "shopcode": Cache.user!.ShopCode,
                    "reservationKey": reservationKey,
                    "journeyKey": journeyKey]
        case .getSeatOptions(let bookingKey), .getAncillaryOptions(let bookingKey):
            return ["shopcode": Cache.user!.ShopCode,
                    "bookingKey": bookingKey]
        case .calculateVietjetPrice(let param), .createReservation(let param), .getInsuranceOptions(let param):
            return param.toJSON()
        case .checkPromotions(let phone, let xml):
            return ["usercode": Cache.user!.UserName,
                    "shopcode": Cache.user!.ShopCode,
                    "phoneNumber": phone,
                    "xmlItemProducts": xml]
        case .getOrderHistory(let key):
            return ["shopcode": Cache.user!.ShopCode,
                    "usercode": Cache.user!.UserName,
                    "key": key]
        case .getOrderDetail(let id, let mpos, let locator):
            return ["Id": id,
                    "SO_MPOS": mpos,
                    "locator": locator]
        case .getReservation(let locator):
            return ["locator": locator]
        case .calculateVietjetAncillaryPrice(let param), .calculateVietjetSeatPrice(let param), .createVietjetAncillary(let param), .createVietjetSeat(let param), .calculateVietjetUpdateSeatPrice(let param), .createVietjetUpdateSeat(let param):
            return param.toJSON()
        case .calculateVietjetUpdateFlightPrice(let param), .createVietjetUpdateFlight(let param):
            return param.toJSON()
        default:
            return [:]
        }
    }
}
