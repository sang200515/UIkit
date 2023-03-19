//
//  ProductAPIService.swift
//  fptshop
//
//  Created by Ngo Dang tan on 8/29/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

import Alamofire
enum ProductAPIService {
    case searchProduct(params: [String:Any])
    case product_filter(params: [String: Any])
    case product_detais_by_model_id(model_id:String,params: [String: String])
    case product_details_by_sku(sku:String,params: [String: Any])
    case get_list_nganh_hang(params: [String: String])
    case get_parameter_filter(params: [String: String])
    case mpos_FRT_SP_innovation_MDMH_Sim(params: [String: String])
    case get_promotions_detais(params: [String:String])
    case get_list_SP_BH_detais(params: [String:String])
    case item_group_distinct(params: [String:Any])
    case searchProductPOST(params: [String:Any])
    case get_parameter_after_search(params: [String:Any])
    //tracoc
    case CustomerTraCoc(params: [String : Any])
    case DetailTraCoc(params: [String : Any])
    case get_stock(params: [String : Any])
    
}
extension ProductAPIService: TargetType {
    private static var _defaults = UserDefaults.standard
    private static var _manager = Config.manager
    var baseURL: URL {
        switch self {
            
        case .searchProduct,.product_filter,.product_detais_by_model_id,.product_details_by_sku,.get_list_nganh_hang,.get_parameter_filter,.get_promotions_detais,.CustomerTraCoc,.DetailTraCoc,.item_group_distinct,.searchProductPOST,.get_list_SP_BH_detais,.get_parameter_after_search,.get_stock:
            
            
            return URL(string: "\(ProductAPIService._manager.URL_GATEWAY!)")!
        case .mpos_FRT_SP_innovation_MDMH_Sim:
            return URL(string: "\(ProductAPIService._manager.URL_GATEWAY!)")!
        }
        
    }
    var path: String {
        switch self {
            
        case .searchProduct(_):
            return "/internal-api-service/api/mpos/search_product"
        case .product_filter(_):
            return "/internal-api-service/api/mpos/product_filter"
        case .product_detais_by_model_id(let model_id,_):
            return "/internal-api-service/api/mpos/product_details/\(model_id)"
        case .product_details_by_sku(let sku,_):
            return "/internal-api-service/api/mpos/product_details_by_sku/\(sku)"
        case .get_list_nganh_hang(_):
            return "/internal-api-service/api/mpos/get_list_nganh_hang"
        case .get_parameter_filter(_):
            return "/internal-api-service/api/mpos/get_parameter_filter"
        case .mpos_FRT_SP_innovation_MDMH_Sim(_):
            return "/mpos-cloud-api/api/product/mpos_FRT_SP_innovation_MDMH_Sim"
        case .get_promotions_detais(_):
            return "/internal-api-service/api/mpos/get_promotions_detais"
        case .get_list_SP_BH_detais:
            return "/promotion-service/api/Order/Get_List_Warranty"
        case .CustomerTraCoc(_):
            return "/promotion-service/api/Order/Customer"
        case .DetailTraCoc(_):
            return "/promotion-service/api/Order/Detail"
            
        case .get_stock(_):
            return "/inventory-service/api/inventory/get-stock"
            
        case .item_group_distinct(_):
            return "internal-api-service/api/mpos/item_group_distinct"
        case .searchProductPOST(_):
            return "/internal-api-service/api/mpos/search_product"
            
        case .get_parameter_after_search(_):
            return "/internal-api-service/api/mpos/get_parameter_after_search"
            
            
            
            
        }
        
    }
    var method: Moya.Method {
        switch self {
            
        case .searchProduct,.product_detais_by_model_id,.product_details_by_sku,.get_list_nganh_hang,.get_parameter_filter,.get_promotions_detais,.item_group_distinct,.get_stock:
            
            
            return .get
            
        case .product_filter,.mpos_FRT_SP_innovation_MDMH_Sim,.CustomerTraCoc,.DetailTraCoc,.searchProductPOST,.get_parameter_after_search,.get_list_SP_BH_detais:
            
            return .post
        }
    }
    var task: Task {
        switch self {
            
        case let .searchProduct(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .product_filter(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .product_detais_by_model_id(_,params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .product_details_by_sku(_,params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case  .get_list_nganh_hang(_):
            return .requestParameters(parameters: [:], encoding:  URLEncoding.queryString)
        case let .get_parameter_filter(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .mpos_FRT_SP_innovation_MDMH_Sim(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .get_promotions_detais(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .get_list_SP_BH_detais(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            // tracoc
        case let .CustomerTraCoc(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .DetailTraCoc(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        case let .get_stock(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
            
        case let .item_group_distinct(params):
            return .requestParameters(parameters: params, encoding:  URLEncoding.queryString)
        case let .searchProductPOST(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        case let .get_parameter_after_search(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
            
            
        }
    }
    var headers: [String: String]? {
        var access_token = ProductAPIService._defaults.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        
        switch self {
        default:
            return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}
