    //
    //  CoreInstallMentEndpoint.swift
    //  QuickCode
    //
    //  Created by Sang Trương on 16/07/2022.
    //

import Alamofire
import Foundation

enum CoreInstallMentEndPoint {
    case getListTinhThanh
    case getListQuanhuyen(provinceCode: String)
    case getListPhuongXa(districtCode: String)
    case getListMoiQuanHe
    case getListNhaTraGhop(idCard: String)
    case getMasterDataInstallMapping(idCard: String)
    case getTypeOfIdCard
}

extension CoreInstallMentEndPoint: EndPointType {

    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }

    var httpMethod: HTTPMethod {
        switch self {
            case .getListTinhThanh, .getListQuanhuyen, .getListPhuongXa, .getListMoiQuanHe, .getListNhaTraGhop,
                    .getMasterDataInstallMapping,.getTypeOfIdCard:
                return .get
        }
    }

    var path: String {
        let BASE_URL = Config.manager.URL_GATEWAY!
            //https://gatewaybeta.fptshop.com.vn/gateway/dev-installment-service/api/common/province
        switch self {
            case .getListTinhThanh:
                return BASE_URL + "/dev-installment-service/api/common/province"
            case .getListQuanhuyen:
                return BASE_URL + "/dev-installment-service/api/common/district"
            case .getListPhuongXa:
                return BASE_URL + "/dev-installment-service/api/common/ward"
            case .getListMoiQuanHe:
                return BASE_URL + "/dev-installment-service/api/common/relationship"
            case .getListNhaTraGhop:
                return BASE_URL + "/dev-installment-service/api/common/installmenthouse"
            case .getMasterDataInstallMapping:
                return BASE_URL + "/dev-installment-service/api/customer/details"
            case .getTypeOfIdCard:
               return BASE_URL + "/dev-installment-service/api/common/idcardtype"
        }
    }

    var parameters: JSONDictionary {
        switch self {
            case .getListTinhThanh:
                return [:]
            case .getListQuanhuyen(let proviceCode):
                return [
                    "provinceCode": proviceCode
                ]
            case .getListPhuongXa(let districtCode):
                return [
                    "districtCode": districtCode
                ]
            case .getListMoiQuanHe:
                return [:]
            case .getListNhaTraGhop(let idCard):
                return [
                    "idCard": idCard
                ]
            case .getMasterDataInstallMapping(let idCard):
                return  [
                    "idCard": idCard
                ]
            case .getTypeOfIdCard:
                return [:]
        }
    }
}
