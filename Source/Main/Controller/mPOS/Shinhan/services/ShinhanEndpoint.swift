//
//  ShinhanEndpoint.swift
//  fptshop
//
//  Created by Ngoc Bao on 11/02/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum ShinhanEnpoint {
    case detechCmnd(base64: String, isFont: Bool)
    case loadInforCustomer(docentry: Int,loadType: Int,idCard: String)
    case loadCity
    case loadDistricts(cityCode: String)
    case loadWards(districtCode: String)
    case saveApplication(personalLoan: [String: Any],pernamentAddress: [String: Any],residentAddress: [String: Any],person1: [String: Any],person2: [String: Any],workInfo: [String: Any])
    case loadRelationShip
    case loadPaymentDate
    case loadGoiTraGop(rdr1: String)
    case uploadImage(documentId: String, idCard: String,trackingID: String,base64: String)
    case saveSubmitApplication(prosmos:String,rdr1: String,neeSubmit: Bool,submitValue: Bool)
    case reUploadImage(trackingID: String, type: Int)
    case loadListOrders(type: String)
    case loadDetailOrder(docEntry: String)
    case loadBookedOrder(posNum: String, docEntry: String)
    
}

extension ShinhanEnpoint: EndPointType {
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .detechCmnd,.saveApplication,.loadGoiTraGop,.uploadImage,.saveSubmitApplication,.reUploadImage:
            return .post
        default:
            return .get
        }
    }
    
    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
        switch self {
        case .detechCmnd:
            return BASE_URL + "/mpos-cloud-api/api/sim/GetinfoCustomerByImageIDCard"
        case .loadInforCustomer:
            return BASE_URL + "/mpos-cloud-api/api/shinhan/LoadAppInfo"
        case .loadCity:
            return BASE_URL + "/mpos-cloud-api/api/shinhan/LoadCity"
        case .loadDistricts:
            return BASE_URL + "/mpos-cloud-api/api/shinhan/loadDistrict"
        case .loadWards:
            return BASE_URL + "/mpos-cloud-api/api/shinhan/LoadWard"
        case .saveApplication:
            return BASE_URL + "/mpos-cloud-api/api/shinhan/CreateApplication"
        case .loadRelationShip:
            return BASE_URL + "/mpos-cloud-api/api/shinhan/LoadRelationship"
        case .loadPaymentDate:
            return BASE_URL + "/mpos-cloud-api/api/shinhan/LoadPaymentDate"
        case .loadGoiTraGop:
            return BASE_URL + "/mpos-cloud-api/api/shinhan/LoadSchemeCode"
        case .uploadImage:
            return BASE_URL + "/mpos-friend/api/shinhan/uploadFile"
        case .saveSubmitApplication:
            return BASE_URL + "/mpos-cloud-api/api/shinhan/saveOrderAndSubmitApp"
        case .reUploadImage:
            return BASE_URL + "/mpos-cloud-api/api/shinhan/ReSubmitImage"
        case .loadDetailOrder:
            return BASE_URL + "/mpos-cloud-api/api/shinhan/LoadOrderDetails"
        case .loadListOrders:
            return BASE_URL + "/mpos-cloud-api/api/shinhan/LoadOrderHistoryList"
        case .loadBookedOrder:
            return BASE_URL + "/mpos-cloud-api/api/shinhan/LoadBookedOrder"
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .detechCmnd(let base64, let isFont):
            return [
                "Image_CMND": base64,
                "NhaMang": "Shinhan",
                "UserID": Cache.user?.UserName ?? "",
                "MaShop": Cache.user?.ShopCode ?? "",
                "Type": isFont ? "1" : "2"
            ]
        case .loadInforCustomer(let docentry,let loadType,let idCard):
            return [
                "userCode": Cache.user?.UserName ?? "",
                "shopCode": Cache.user?.ShopCode ?? "",
                "idCard": idCard,
                "docEntry": docentry,
                "loadType": loadType
            ]
        case .loadDistricts(let cityCode):
            return [
                "userCode": Cache.user?.UserName ?? "",
                "shopCode": Cache.user?.ShopCode ?? "",
                "cityCode": cityCode
            ]
        case .loadWards(let districtCode):
            return [
                "userCode": Cache.user?.UserName ?? "",
                "shopCode": Cache.user?.ShopCode ?? "",
                "districtCode": districtCode
            ]
        case .saveApplication(let personalLoan,let pernamentAddress,let residentAddress, let person1,let person2,let workInfo):
            return [
                    "InternalCode": ShinhanDataLocal.share.iternalCode,
                    "userCode": Cache.user?.UserName ?? "",
                    "shopCode": Cache.user?.ShopCode ?? "",
                    "deviceOs":"2",
                    "personalLoan": personalLoan,
                    "permanentAddress": pernamentAddress,
                    "residenceAddress": residentAddress,
                    "refPerson1": person1,
                    "refPerson2": person2,
                    "workInfo": workInfo,
                    "schemecode": ShinhanData.selectedTragop?.schemeCode ?? "",
            ]
        case .loadCity,.loadRelationShip,.loadPaymentDate:
            return [
                "userCode": Cache.user?.UserName ?? "",
                "shopCode": Cache.user?.ShopCode ?? "",
            ]
        case .loadGoiTraGop(let rdr1):
            return [
                "userCode": Cache.user?.UserName ?? "",
                "shopCode": Cache.user?.ShopCode ?? "",
                "RDR1": rdr1
            ]
        case .uploadImage(let documentId,let idCard,let trackingID, let base64):
            return [
                "userCode": Cache.user?.UserName ?? "",
                "shopCode": Cache.user?.ShopCode ?? "",
                "documentId":documentId,
                "idCard":idCard,
                "trackingId": trackingID,
                "base64": base64
            ]
        case .saveSubmitApplication(let prosmos,let rdr1,let neeSubmit, let submitValue):
            let crm =  UserDefaults.standard.string(forKey: "CRMCode")
            let isDetail = ShinhanData.detailorDerHistory != nil
            let detail = ShinhanData.detailorDerHistory
            let infoCus = ShinhanData.inforCustomer
                


                var voucher = ""
                if(Cache.listVoucherNoPrice.count > 0){
                    voucher = "<line>"
                    for item in Cache.listVoucherNoPrice{
                        if(item.isSelected == true){
                            voucher  = voucher + "<item voucher=\"\(item.VC_Code)\" />"
                        }

                    }
                    voucher = voucher + "</line>"
                }
            let soTienTT = ShinhanData.tientraTruoc
            let soTienCoc = ShinhanData.sotiencoc
				
            var submitDic: [String: Any] = [
                "discount": Double(ShinhanData.giamgia),
                "LoaiTraGop": "0",
                "voucher": voucher,
                "DiviceType": "2",
                "payments": "N",
                "Doctype": "02",
                "SoTienTraTruoc": soTienTT + soTienCoc,
                "TenCTyTraGop": "2322579",
                "Token": Cache.user?.Token ?? "",
                "ShopCode": Cache.user?.ShopCode ?? "",
                "NgaySinh": isDetail ? detail?.customer?.NgaySinh ?? "" : infoCus?.personalLoan?.dateOfBirth ?? "",
                "CardName": isDetail ? detail?.customer?.fullName ?? "" : infoCus?.personalLoan?.fullName ?? "",
                "soHDtragop": "0",
                "Address": isDetail ? detail?.customer?.Address ?? "" : ShinhanData.fontCmnd?.data.first?.address ?? "",
                "Mail": isDetail == false ? infoCus?.personalLoan?.email ?? "" : detail?.customer?.Mail ?? "",
                "phone": !isDetail ? infoCus?.personalLoan?.phone ?? "" : detail?.customer?.phone ?? "",
                "pre_docentry": ShinhanData.newDocEntry, //so mpos
                "xmlspGiamGiaTay": "",
                "xmlVoucherDH": "",
                "U_EplCod": Cache.user?.UserName ?? "",
                "xml_url_pk": "",
                "cardcode": "0",
                "LaiSuat": ShinhanData.selectedTragop?.interestRate ?? "",
                "is_sale_MDMH": "",
                "CMND": !isDetail ? infoCus?.personalLoan?.idCard ?? "" : detail?.customer?.idCard ?? "",
                "is_DH_DuAn": "N",
                "PROMOS": prosmos,
                "U_des": "",
                "is_sale_software": "",
                "is_samsung": "0",
                "RDR1": rdr1,
                "xmlstringpay": "",
                "kyhan": "\(ShinhanData.selectedKyHan?.number ?? 0)",
                "is_KHRotTG": 0,
                "gioitinh": !isDetail ? "\(ShinhanData.inforCustomer?.personalLoan?.gender == false ? 0 : 1)" : "\(detail?.customer?.gioitinh == false ? 0 : 1)",
                "CRMCode": crm ?? "",
                "appDocEntry": ShinhanData.docEntry, // mã hs (docentry)
                "schemecode": ShinhanData.selectedTragop?.schemeCode ?? "",
            ]
            if neeSubmit {
                submitDic["isSubmitApp"] = submitValue
            }
            return submitDic
        case .reUploadImage(let trackingID, let type):
            return [
                "trackingId": trackingID,
                "userCode": Cache.user?.UserName ?? "",
                "shopCode": Cache.user?.ShopCode ?? "",
                "type": type
            ]
        case .loadDetailOrder(let docEntry):
            return [
                "userCode": Cache.user?.UserName ?? "",
                "shopCode": Cache.user?.ShopCode ?? "",
                "docEntry": docEntry
            ]
        case .loadListOrders(let type):
            return [
                "userCode": Cache.user?.UserName ?? "",
                "shopCode": Cache.user?.ShopCode ?? "",
                "loadType": type
            ]
        case .loadBookedOrder(let posNum,let docEntry):
            return [
                "userCode": Cache.user?.UserName ?? "",
                "shopCode": Cache.user?.ShopCode ?? "",
                "posSoNum": posNum,
                "docEntry": docEntry
            ]
        }
    }
}
class ShinhanDataLocal{
    static let share = ShinhanDataLocal()
    var iternalCode:String = ""
}
