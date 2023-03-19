//
//  VASViettelApiManager.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 08/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON
import Alamofire
import SwiftyBeaver

fileprivate protocol VASViettelApiManagerProtocol {
    var provider: MoyaProvider<VASViettelService> { get }
    func getPaymentTypes(completion: @escaping(VASPaymentType?, String) -> Void)
    func getCards(completion: @escaping(VASCard?, String) -> Void)
}

class VASViettelApiManager: VASViettelApiManagerProtocol {
    
    
    static let shared = VASViettelApiManager()
    var provider: MoyaProvider<VASViettelService> = MoyaProvider<VASViettelService>( plugins: [VerbosePlugin(verbose: true)])
    let decoder = JSONDecoder()
    
    func getPaymentTypes(completion: @escaping (VASPaymentType?, String) -> Void) {
        provider.request(.getPaymentType) { [weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let vasItem = try strongSelf.decoder.decode(VASPaymentType.self, from: response.data)
                    printLog(function: #function, json: vasItem)
                    completion(vasItem,"")
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func getCards(completion: @escaping (VASCard?, String) -> Void) {
        provider.request(.getCards) { [weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case let .success(response):
                do {
                    let cardItem = try strongSelf.decoder.decode(VASCard.self, from: response.data)
                    printLog(function: #function, json: cardItem)
                    completion(cardItem,"")
                } catch let err {
                    completion(nil, err.localizedDescription)
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    
    
    func addNewCard(isAdd: Bool,payment: [ViettelPayOrder_Payment],itemGoiCuocMain: ViettelVAS_Product, integrationInfo:ViettelVASGoiCuoc_IntegrationInfo, totalIncludeFee: Int,sdt: String, categoryId: String , completion: @escaping  ((Bool,ViettelPayOrder?, String)-> Void)) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "vi_VN")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let strDate = dateFormatter.string(from: Date())
        let arrDict_payments: [[String:Any]] = ViettelPayOrder_Payment.convertTodict(from: payment)
        
        let dict_orderTransactionDtos: [String:Any] = ["productId": "\(itemGoiCuocMain.id)",
                                                       "providerId": "\(itemGoiCuocMain.details.providerID)",
                                                       "providerName": "Viettel-TVBH",
                                                       "productName": "\(itemGoiCuocMain.name)",
                                                       "price": Int(itemGoiCuocMain.details.sellingPrice),
                                                       "sellingPrice": Int(itemGoiCuocMain.details.sellingPrice),
                                                       "quantity": 1,
                                                       "totalAmount": Int(itemGoiCuocMain.details.sellingPrice),
                                                       "totalAmountIncludingFee": totalIncludeFee,
                                                       "totalFee": "",
                                                       "creationTime": "\(strDate)",
                                                       "creationBy": "\(Cache.user?.UserName ?? "")",
                                                       "integratedGroupCode": "\(itemGoiCuocMain.configs[0].integratedGroupCode)",
                                                       "integratedGroupName": "",
                                                       "integratedProductCode": "\(itemGoiCuocMain.configs[0].integratedProductCode)",
                                                       "integratedProductName": "",
                                                       "isOfflineTransaction": false,
                                                       "referenceCode": "",
                                                       "minFee": 0,
                                                       "maxFee": 0,
                                                       "percentFee": 0,
                                                       "constantFee": 0,
                                                       "paymentFeeType": 0,
                                                       "paymentRule": 0,
                                                       "productCustomerCode": "\(sdt)",
                                                       "productCustomerName": "",
                                                       "productCustomerPhoneNumber": "\(sdt)", // sdt nhap vao
                                                       "productCustomerAddress": "",
                                                       "productCustomerEmailAddress": "",
                                                       "description": "",
                                                       "vehicleNumber": "",
                                                       "invoices": [],
                                                       "categoryId": "\(categoryId)",
                                                       "isExportInvoice": false,
                                                       "id": "",
                                                       "extraProperties": [
                                                           "referenceIntegrationInfo": [
                                                            "requestId": "\(integrationInfo.requestId)",
                                                            "responseId": "\(integrationInfo.responseId)"
                                                           ],
                                                        "warehouseName": "\(Cache.user?.ShopName ?? "")",
                                                           "otp": ""
                                                       ],
                                                       "sender": [:],
                                                       "receiver": [:],
                                                       "productConfigDto": ["checkInventory": false]]
        var arr_orderTransactionDtos = [[String:Any]]()
        arr_orderTransactionDtos.append(dict_orderTransactionDtos)
        
        let parameters: [String: Any] = [
            "orderStatus": 1,
            "orderStatusDisplay": "",
            "billNo": "",
            "customerId": "",
            "customerName": "",
            "customerPhoneNumber": sdt,
            "warehouseCode": "\(Cache.user?.ShopCode ?? "")",
            "regionCode": "",
            "creationBy": "\(Cache.user?.UserName ?? "")",
            "creationTime": "\(strDate)",
            "referenceSystem": "MPOS",
            "referenceValue": "",
            "orderTransactionDtos": arr_orderTransactionDtos,
            "payments": arrDict_payments,
            "id": "",
            "ip": ""
        ]
        let headers: HTTPHeaders = ["Content-type": "application/json", "Authorization": "Bearer \(UserDefaults.standard.getMyInfoToken() ?? "")"]
        let actionValue = isAdd ? 1 : 2
        let baseUrl = Config.manager.URL_GATEWAY!
        var path = ""
        path = "/som-order-service/api/Order/v1/order/calculate?action="
        AF.request("\(baseUrl)\(path)\(actionValue)", method: .post, parameters: parameters, encoding: JSONEncoding.default,headers: headers).validate(statusCode: 200..<299).responseJSON { response in
            switch response.result {
            case .failure(let error):
                var errStr = ""
                if let data = response.data {
                    let json = JSON(data)
                    errStr = json["error"]["message"].description
                } else {
                    errStr = error.localizedDescription
                }
                completion(false,nil,errStr)
            case .success(let value):
                let json = JSON(value)
                let rs = ViettelPayOrder.getObjFromDictionary(data: json)
                completion(true,rs,"")
            }
        }
    }
    
}



extension Dictionary {
    
    /// Convert Dictionary to JSON string
    /// - Throws: exception if dictionary cannot be converted to JSON data or when data cannot be converted to UTF8 string
    /// - Returns: JSON string
    func toJson() throws -> String {
        let data = try JSONSerialization.data(withJSONObject: self)
        if let string = String(data: data, encoding: .utf8) {
            return string
        }
        throw NSError(domain: "Dictionary", code: 1, userInfo: ["message": "Data cannot be converted to .utf8 string"])
    }
}

class MyError: NSObject, LocalizedError {
        var message = ""
        init(str: String) {
            message = str
        }
        override var description: String {
            get {
                return "MyError: \(message)"
            }
        }
        //You need to implement `errorDescription`, not `localizedDescription`.
        var errorDescription: String? {
            get {
                return self.description
            }
        }
    }
