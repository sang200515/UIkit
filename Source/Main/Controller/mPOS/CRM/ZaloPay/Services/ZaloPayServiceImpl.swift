//
//  ZaloPayServiceImpl.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 28/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
public class ZaloPayServiceImpl
{
    
    class func searchOrders(param: RequestHistoryZalopay, completionHandler: @escaping ([OrderZaloPay]) -> Void) {
        let paramDic = param.dictionary!
        print(paramDic)
        let provider = MoyaProvider<ZaloPayService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.searchOrders(parameters: paramDic)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([OrderZaloPay].self, from: response.data)
                    completionHandler(results)
                } catch let err {
                    print(err)
                    completionHandler([])
                }
            case let .failure(error):
                print(error)
                completionHandler([])
            }
        }
    }
    
    class func detailOrder(id: String, completionHandler: @escaping (DetailOrderZaloPay?) -> Void) {
        let provider = MoyaProvider<ZaloPayService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.detailOrder(parameters: ["id":id ])) { (result) in
            switch result {
            case let .success(response):
                do {
                    let data = response.data
                    let json = try? JSON(data: data)
                    debugPrint(json as Any)
                    let results = try JSONDecoder().decode(DetailOrderZaloPay.self, from: response.data)
                    completionHandler(results)
                } catch let err {
                    print(err)
                    completionHandler(nil)
                }
            case let .failure(error):
                print(error)
                completionHandler(nil)
            }
        }
    }
    class func userByQR(qr: String, completionHandler: @escaping (ResponseCusomerZaloPay?,ResponeErrorZaloPay?) -> Void) {
        let provider = MoyaProvider<ZaloPayService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.userByQR(parameters: ["qr_url":qr ])) { (result) in
            switch result {
            case let .success(response):
                do {
                    if(response.statusCode == 200){
                        let data = response.data
                        let json = try? JSON(data: data)
                        debugPrint(json as Any)
                        let results = try JSONDecoder().decode(ResponseCusomerZaloPay.self, from: response.data)
                        completionHandler(results,nil)
                    }else{
                        let results = try JSONDecoder().decode(ResponeErrorZaloPay.self, from: response.data)
                        completionHandler(nil,results)
                    }
                } catch let err {
                    print(err)
                    completionHandler(nil,nil)
                }
            case let .failure(error):
                print(error)
                completionHandler(nil,nil)
            }
        }
    }
    class func getInfoProduct(id: String, completionHandler: @escaping (ProductSOM?) -> Void) {
        let provider = MoyaProvider<ZaloPayService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.getInfoProduct(id: id)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let data = response.data
                    let json = try? JSON(data: data)
                    debugPrint(json as Any)
                    let results = try JSONDecoder().decode(ProductSOM.self, from: response.data)
                    completionHandler(results)
                } catch let err {
                    print(err)
                    completionHandler(nil)
                }
            case let .failure(error):
                print(error)
                completionHandler(nil)
            }
        }
    }
    class func getInfoProvider(id: String, completionHandler: @escaping (ProviderSOM?) -> Void) {
        let provider = MoyaProvider<ZaloPayService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.getInfoProvider(id: id)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let data = response.data
                    let json = try? JSON(data: data)
                    debugPrint(json as Any)
                    let results = try JSONDecoder().decode(ProviderSOM.self, from: response.data)
                    completionHandler(results)
                } catch let err {
                    print(err)
                    completionHandler(nil)
                }
            case let .failure(error):
                print(error)
                completionHandler(nil)
            }
        }
    }
    class func createOrder(param: RequestCreateOrderZaloPay, completionHandler: @escaping (ResponseCreateOrderZaloPay?) -> Void) {
        let paramDic = param.dictionary!
        print(paramDic)
        let provider = MoyaProvider<ZaloPayService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.createOrder(parameters: paramDic)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let data = response.data
                    let json = try? JSON(data: data)
                    debugPrint(json as Any)
                    let results = try JSONDecoder().decode(ResponseCreateOrderZaloPay.self, from: response.data)
                    completionHandler(results)
                } catch let err {
                    print(err)
                    completionHandler(nil)
                }
            case let .failure(error):
                print(error)
                completionHandler(nil)
            }
        }
    }
    class func userByPhone(phone: String, completionHandler: @escaping (ResponseCusomerZaloPay?,ResponeErrorZaloPay?) -> Void) {
        let provider = MoyaProvider<ZaloPayService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.userByPhone(parameters: ["phone":phone ])) { (result) in
            switch result {
            case let .success(response):
                do {
                    if(response.statusCode == 200){
                        let data = response.data
                        let json = try? JSON(data: data)
                        debugPrint(json as Any)
                        let results = try JSONDecoder().decode(ResponseCusomerZaloPay.self, from: response.data)
                        completionHandler(results, nil)
                    }else{
                        let results = try JSONDecoder().decode(ResponeErrorZaloPay.self, from: response.data)
                        completionHandler(nil,results)
                    }
                } catch let err {
                    print(err)
                    completionHandler(nil,nil)
                }
            case let .failure(error):
                print(error)
                completionHandler(nil,nil)
            }
        }
    }
    class func printBill(param: RequestPrintBill, completionHandler: @escaping (ResponsePrintBill?) -> Void) {
        let paramDic = param.dictionary!
        print(paramDic)
        let provider = MoyaProvider<ZaloPayService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.printBill(shopCode: "\(Cache.user!.ShopCode)" , parameters: paramDic)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let data = response.data
                    let json = try? JSON(data: data)
                    debugPrint(json as Any)
                    let results = try JSONDecoder().decode(ResponsePrintBill.self, from: response.data)
                    completionHandler(results)
                } catch let err {
                    print(err)
                    completionHandler(nil)
                }
            case let .failure(error):
                print(error)
                completionHandler(nil)
            }
        }
    }
    class func checkStatusOrder(orderId: String,integratedGroupCode: String, completionHandler: @escaping (ResponseStatusOrderZaloPay?) -> Void) {
        let provider = MoyaProvider<ZaloPayService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.checkStatusOrder(parameters: ["orderId":orderId,"integratedGroupCode":integratedGroupCode])) { (result) in
            switch result {
            case let .success(response):
                do {
                    let data = response.data
                    let json = try? JSON(data: data)
                    debugPrint(json as Any)
                    let results = try JSONDecoder().decode(ResponseStatusOrderZaloPay.self, from: response.data)
                    completionHandler(results)
                } catch let err {
                    print(err)
                    completionHandler(nil)
                }
            case let .failure(error):
                print(error)
                completionHandler(nil)
            }
        }
    }
    class func getVoucher(id: String,providerName: String , completionHandler: @escaping (ResponseGetVoucher?) -> Void) {
        let provider = MoyaProvider<ZaloPayService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.getVoucher(id: id,parameters: ["providerName":providerName ])) { (result) in
            switch result {
            case let .success(response):
                do {
                    let data = response.data
                    let json = try? JSON(data: data)
                    debugPrint(json as Any)
                    let results = try JSONDecoder().decode(ResponseGetVoucher.self, from: response.data)
                    completionHandler(results)
                } catch let err {
                    print(err)
                    completionHandler(nil)
                }
            case let .failure(error):
                print(error)
                completionHandler(nil)
            }
        }
    }
    class func getCategories(params: RequestCategoryZaloPay, completionHandler: @escaping (ResponseCategoriesZaloPay?) -> Void) {
        let paramDic = params.dictionary!
        print(paramDic)
        let provider = MoyaProvider<ZaloPayService>(plugins: [NetworkLoggerPlugin()])
        provider.request(.getCategories(parameters: paramDic)) { (result) in
            switch result {
            case let .success(response):
                do {
                    let data = response.data
                    let json = try? JSON(data: data)
                    debugPrint(json as Any)
                    let results = try JSONDecoder().decode(ResponseCategoriesZaloPay.self, from: response.data)
                    completionHandler(results)
                } catch let err {
                    print(err)
                    completionHandler(nil)
                }
            case let .failure(error):
                print(error)
                completionHandler(nil)
            }
        }
    }
}
