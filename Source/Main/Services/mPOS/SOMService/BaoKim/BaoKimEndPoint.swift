//
//  BaoKimEndPoint.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 17/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum BaoKimEndPoint {
    case getCitiesAndDistricts
    case getCities
    case getDistricts(cityId: String)
    case getTrips(param: BaoKimSearchTripParam)
    case getSeats(tripCode: String)
    case getPoints(pointId: Int)
    case bookTrip(param: BaoKimBookingParam)
    case getTransactionId(seats: String, quantity: Int)
    case getBookingInfo(bookingCode: String)
    case getVoucherInfo(voucher: String, tripCode: String, bookingCode: String)
    case paymentBooking(transactionCode: String, bookingCode: String, voucher: String)
    case updateMPOSBooking(transactionCode: String, bookingCode: String, bookingInfo: String, price: Int)
    case updateMPOSVoucher(transactionCode: String, bookingCode: String, voucherInfo: String, price: Int)
    case getMPOSProduct
    case updateMPOSPayment(bookingCode: String, transactionCode: String, voucher: String, des: String, rdr1: String, promos: String, voucherMPOS: String, xmlPayment: String, xmlVoucher: String)
    case getHistories
    case getHistoryDetail(bookingCode: String, mposCode: String)
    case getFilters(from: Int, to: Int, date: String)
    case getCompanyDetail(companyId: String)
}

extension BaoKimEndPoint: EndPointType {
    var headers: HTTPHeaders? {
        var temp = DefaultHeader().addAuthHeader()
        
        switch self {
        case .getTransactionId, .updateMPOSBooking, .updateMPOSVoucher, .getMPOSProduct, .updateMPOSPayment, .getHistories, .getHistoryDetail:
            return temp
        default:
            temp.add(name: "X-Som-Provider-Id", value: "3952cbe7-85a1-426e-b4ea-506d8cbca8e0")
            return temp
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getMPOSProduct, .getHistories, .getHistoryDetail:
            return .get
        case .updateMPOSBooking, .updateMPOSVoucher:
            return .put
        default:
            return .post
        }
    }
    
    var path: String {
        var BASE_URL = ""
        switch self {
        case .getTransactionId, .updateMPOSBooking, .updateMPOSVoucher, .getMPOSProduct, .updateMPOSPayment, .getHistories, .getHistoryDetail:
            BASE_URL = Config.manager.URL_GATEWAY! + "/internal-api-service/api/baokimticket/"
        default:
            let target = Bundle.main.infoDictionary?["TargetName"] as? String
            var prefix = ""
            switch target {
            case "fptshop", "Production":
                prefix = "/som-integration-service"
            default:
                prefix = "/som-dev-integration-service"
            }
            BASE_URL = Config.manager.URL_GATEWAY! + prefix + "/api/integration/v1/BaoKim/VeXeRe/"
        }
            
        switch self {
        case .getCitiesAndDistricts:
            return BASE_URL + "Lay_danh_sach_tat_ca_tinh_thanh_quan_huyen"
        case .getCities:
            return BASE_URL + "Tra_cuu_tinh_thanh"
        case .getDistricts:
            return BASE_URL + "Tra_cuu_quan_huyen"
        case .getTrips:
            return BASE_URL + "Ham_chon_chuyen"
        case .getSeats:
            return BASE_URL + "Ham_chon_ghe"
        case .getPoints:
            return BASE_URL + "Ham_chon_diem_don_tra"
        case .bookTrip:
            return BASE_URL + "Ham_dat_ve"
        case .getTransactionId:
            return BASE_URL + "create-booking"
        case .getBookingInfo:
            return BASE_URL + "Ham_lay_thong_tin_ve"
        case .getVoucherInfo:
            return BASE_URL + "Ham_kiem_tra_phieu_giam_gia"
        case .paymentBooking:
            return BASE_URL + "Ham_thanh_toan"
        case .updateMPOSBooking:
            return BASE_URL + "update-booking"
        case .updateMPOSVoucher:
            return BASE_URL + "update-booking-coupon"
        case .getMPOSProduct:
            return BASE_URL + "oitms"
        case .updateMPOSPayment:
            return BASE_URL + "payment"
        case .getHistories:
            return BASE_URL + "historys"
        case .getHistoryDetail:
            return BASE_URL + "history-detail"
        case .getFilters:
            return BASE_URL + "Ham_lay_so_luong_chuyen"
        case .getCompanyDetail:
            return BASE_URL + "Ham_lay_danh_sach_hinh_anh_cua_nha_xe"
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getDistricts(let cityId):
            return ["CityId": cityId]
        case .getTrips(let param):
            return param.toJSON()
        case .getSeats(let tripCode):
            return ["TripCode": tripCode]
        case .getPoints(let pointId):
            return ["PointId": pointId]
        case .bookTrip(let param):
            return param.toJSON()
        case .getTransactionId(let seats, let quantity):
            return ["tripCode": BaoKimDataManager.shared.selectedTrip.route.schedules.first!.tripCode&,
                    "seats": seats,
                    "userid": Cache.user!.UserName,
                    "shopcode": Cache.user!.ShopCode,
                    "requestTime": Date().toString(dateFormat: "yyyy-MM-dd HH:mm:ss"),
                    "customerphone": BaoKimDataManager.shared.phone,
                    "customername": BaoKimDataManager.shared.name,
                    "customeremail": BaoKimDataManager.shared.email,
                    "pickup": BaoKimDataManager.shared.selectedPickup.name,
                    "dropoffinfo": BaoKimDataManager.shared.selectedDropoff.name,
                    "note": "",
                    "quanity": quantity]
        case .getBookingInfo(let bookingCode):
            return ["BookingCode": bookingCode]
        case .getVoucherInfo(let voucher, let tripCode, let bookingCode):
            return ["CouponCode": voucher,
                    "TripCode": tripCode,
                    "BookingCode": bookingCode]
        case .paymentBooking(let transactionCode, let bookingCode, let voucher):
            return ["TransactionId": transactionCode,
                    "BookingCode": bookingCode,
                    "Coupon": voucher]
        case .updateMPOSBooking(let transactionCode, let bookingCode, let bookingInfo, let price):
            return ["userid": Cache.user!.UserName,
                    "shopcode": Cache.user!.ShopCode,
                    "transactioncode": transactionCode,
                    "bookingid": bookingCode,
                    "json_infobooking": bookingInfo,
                    "doctal": price]
        case .updateMPOSVoucher(let transactionCode, let bookingCode, let voucherInfo, let price):
            return ["userid": Cache.user!.UserName,
                    "shopcode": Cache.user!.ShopCode,
                    "transactioncode": transactionCode,
                    "bookingid": bookingCode,
                    "json_coupon": voucherInfo,
                    "doctal": price]
        case .getMPOSProduct:
            return ["userid": Cache.user!.UserName,
                    "shopcode": Cache.user!.ShopCode]
        case .updateMPOSPayment(let bookingCode, let transactionCode, let voucher, let des, let rdr1, let promos, let voucherMPOS, let xmlPayment, let xmlVoucher):
            return ["userid": Cache.user!.UserName,
                    "shopcode": Cache.user!.ShopCode,
                    "bookingid": bookingCode,
                    "transactioncode_booking": transactionCode,
                    "coupon": voucher,
                    "customerphone": BaoKimDataManager.shared.phone,
                    "customername": BaoKimDataManager.shared.name,
                    "customeremail": BaoKimDataManager.shared.email,
                    "u_des": des,
                    "rdR1": rdr1,
                    "promos": promos,
                    "voucher": voucherMPOS,
                    "xmlVoucherDH": xmlVoucher,
                    "xmlstringpay": xmlPayment,
                    "diviceType": 2]
        case .getHistories:
            return ["userid": Cache.user!.UserName,
                    "shopcode": Cache.user!.ShopCode]
        case .getHistoryDetail(let bookingCode, let mposCode):
            return ["userid": Cache.user!.UserName,
                    "shopcode": Cache.user!.ShopCode,
                    "bookingid": bookingCode,
                    "sompos": mposCode]
        case .getFilters(let from, let to, let date):
            return ["From": from,
                    "To": to,
                    "Date": date,
                    "Page": 1,
                    "Pagesize": 1]
        case .getCompanyDetail(let companyId):
            return ["CompanyId": companyId]
        default:
            return [:]
        }
    }
}
