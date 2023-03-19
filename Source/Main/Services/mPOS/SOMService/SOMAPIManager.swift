//
//  SOMAPIManager.swift
//  fptshop
//
//  Created by Ngo Dang tan on 27/01/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

class SOMAPIManager {
    static let shared = SOMAPIManager()
    private let networkManager = NetworkManager()
    // MARK: - MoMo
   
    
    func checkPemissionMoMoAPI(completion: @escaping (Result<PermissionMoMo, NetworkError>) -> ()) {
        let params = [
            "userid": Cache.user?.UserName ?? "",
            "shopcode": Cache.user?.ShopCode ?? ""
        ]
        networkManager.request(target: SOMAPIService.checkPemissionMoMo(params: params), completion: completion)
    }
   
    func fetchInfoSOM(includeDetails:String,completion: @escaping (Result<InfoSOM, NetworkError>) -> ()) {
        let params = [
            "_includeDetails": "\(includeDetails)"
        ]
        networkManager.request(target: SOMAPIService.getInfoProviderSOM(params: params), completion: completion)
    }
    
    func getInfoCustomerSOM(providerId:String,productId:String,phone:String,integrationGroupCode:String,integrationProductCode:String,completion: @escaping (Result<InfoCustomerMoMo, NetworkError>) -> ()) {
        let params = [
            "providerId": providerId,
            "productId": productId,
            "subject": phone,
            "integrationGroupCode": integrationGroupCode,
            "integrationProductCode": integrationProductCode
        ]
        print(params)
        networkManager.request(target: SOMAPIService.getInfoCustomerSOM(params: params), completion: completion)
    }
    
    
    func createOrderSOM(customerName:String,customerPhoneNumber:String,subject:Subject, orderTransactionDtos:[Any],payments:[Any], creationTime: String, completion: @escaping (Result<OrderSOM, NetworkError>) -> ()) {
        let params = [
            "orderStatus": 1,
            "orderStatusDisplay": "",
            "billNo": "",
            "customerId": subject.id ?? "",
            "referenceSystem": "MPOS",
            "referenceValue": "",
            "tenant": "",
            "warehouseCode": "\(Cache.user?.ShopCode ?? "")",
            "regionCode": "",
            "ip": "",
            "customerName": customerName,
            "customerPhoneNumber": customerPhoneNumber,
            "employeeName": Cache.user?.UserName ?? "",
            "warehouseAddress": "\(Cache.user?.ShopName ?? "")",
            "creationTime": "\(creationTime)",
            "creationBy": Cache.user?.UserName ?? "",
            "orderTransactionDtos":orderTransactionDtos,
            "payments":payments
       
        ] as [String : Any]
        print(params)
        networkManager.request(target: SOMAPIService.createOrderSOM(params:params), completion: completion)
        
    }
    
 
    
    func checkStatusSOM(orderId:String,integratedGroupCode:String,completion: @escaping (Result<StatusOrderSOM, NetworkError>) -> ()) {
        let params = [
            "orderId": orderId,
            "integratedGroupCode": integratedGroupCode
       
        ] as [String : Any]
        print(params)
        networkManager.request(target: SOMAPIService.checkStatusSOM(params:params), completion: completion)
        
        
    }
    
    func getInfoOrderSOM(id:String,completion: @escaping (Result<InfoOrderSOM, NetworkError>) -> ()) {
        let params = [
            "id":"\(id)"
       
        ] as [String : Any]
        print(params)
        networkManager.request(target: SOMAPIService.getOrderSOM(params:params), completion: completion)
        
        
    }

    func filterItemsHistorySOM(fromDate:String,toDate:String, parentCategoryIds: String, completion: @escaping (Result<[ItemHistorySOM], NetworkError>) -> ()) {
        let params = [
            "warehouseCode": Cache.user?.ShopCode ?? "",
            "fromDate": "\(fromDate)",
            "toDate": "\(toDate)",
            "parentCategoryIds":"\(parentCategoryIds)",
            "employeeCode": Cache.user?.UserName ?? ""
            
        ] as [String : Any]
        print(params)
        networkManager.request(target: SOMAPIService.filterItemsHistorySOM(params:params), completion: completion)
        
        
    }

    func getOrderVoucher(orderID: String, providerName: String, completion: @escaping (Result<OrderVoucherSOM, NetworkError>) -> ()) {
        let params = [
            "providerName": providerName
        ] as [String: Any]
        print(params)
        networkManager.requestWithTimeout(target: SOMAPIService.getOrderVoucher(orderID: orderID, params: params), timeout: 120, completion: completion)
    }
    
    func getProviderDetail(providerID: String, completion: @escaping (Result<ProviderDetailSOM, NetworkError>) -> ()) {
        let params = [
            "_includeDetails": "true"
        ] as [String: Any]
        print(params)
        networkManager.request(target: SOMAPIService.getProviderDetail(providerID: providerID, params: params), completion: completion)
    }
    
    func checkPermissionWallet(paymentType: String, promotions: String, completion: @escaping (Result<[PaymentPromotion], NetworkError>) -> ()) {
        let params = [
            "payment_type": paymentType,
            "list_ID_Prom": promotions
        ] as [String: Any]
        print(params)
        networkManager.request(target: SOMAPIService.checkPermissionWallet(params: params), completion: completion)
    }
}
