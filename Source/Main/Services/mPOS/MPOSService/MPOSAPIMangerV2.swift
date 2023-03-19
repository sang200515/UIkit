//
//  MPOSAPIMangerV2.swift
//  fptshop
//
//  Created by Ngo Dang tan on 11/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class MPOSAPIMangerV2 {
    static let shared = MPOSAPIMangerV2()
    private let networkManager = NetworkManager()
    
    func updateDeviceInfo(completion: @escaping (Result<Bool, NetworkError>) -> ()) {
        networkManager.request(target: MPOSAPIService.updateDeviceInfo, completion: completion)
    }
    
    func fetchReceiptMasterDataInstallLaptop(serviceType:Int,completion: @escaping (Result<MasterDataInstallLaptop, NetworkError>) -> ()) {
        let params = [
            "userId": "\(Cache.user?.UserName ?? "")",
            "shopCode":"\(Cache.user?.ShopCode ?? "")",
            "serviceType":serviceType
        ] as [String : Any]
        networkManager.request(target: MPOSAPIService.getReceiptMasterData(params: params), completion: completion)
    }
    
    func createInstallationReceipt(Imei:String,
                                   ItemName:String,
                                   DeviceColor:String,
                                   PhoneNumber:String,
                                   CustFullname:String,
                                   Note:String,
                                   SignatureBase64:String,
                                   ServiceType:Int,
                                   MasterDataIdList:String,
                                   CurrentStatus:String,
                                   BitLockerStatus:Bool,
                                   Problem:String,
                                   discriptionFail:String,
                                   completion: @escaping (Result<ResultInstallationReceipt, NetworkError>) -> ()) {
      
        
        let params = [
            
            "UserId" : "\(Cache.user?.UserName ?? "")",
            "ShopCode": "\(Cache.user?.ShopCode ?? "")",
            "Imei": Imei,
            "ItemName": ItemName,
            "DeviceColor" : DeviceColor,
            "PhoneNumber": PhoneNumber,
            "CustFullname": CustFullname,
            "Note": Note,
            "SignatureBase64": SignatureBase64,
            "ServiceType": ServiceType, 
            "MasterDataIdList": MasterDataIdList,
            "CurrentStatus": CurrentStatus,
            "BitLockerStatus":BitLockerStatus,
            "Problem":Problem,

            
        ] as [String : Any]
        print(params)
        networkManager.request(target: MPOSAPIService.CreateInstallationReceipt(params: params), completion: completion)
    }
    
    func fetchInstallationReceiptList(completion: @escaping (Result<InstallationReceipt, NetworkError>) -> ()) {
        let params = [
            "userId": "\(Cache.user?.UserName ?? "")",
            "shopCode":"\(Cache.user?.ShopCode ?? "")"
        ] as [String : Any]
        print(params)
        networkManager.request(target: MPOSAPIService.GetInstallationReceiptList(params: params), completion: completion)
    }
    
    func fetchInstallationReceiptDetailByReceiptId(receiptId: Int,completion: @escaping (Result<DetailInstallationReceipt, NetworkError>) -> ()) {
        let params = [
            "userId": "\(Cache.user?.UserName ?? "")",
            "shopCode":"\(Cache.user?.ShopCode ?? "")",
            "receiptId": receiptId
        ] as [String : Any]
        print(params)
        networkManager.request(target: MPOSAPIService.GetInstallationReceiptDetailByReceiptId(params: params), completion: completion)
    }
    func deleteInstallationReceipt(receiptId: String,completion: @escaping (Result<DetailDeleteInstallationReceipt, NetworkError>) -> ()) {
        let params = [
            "UserCode": "\(Cache.user?.UserName ?? "")",
            "ShopCode":"\(Cache.user?.ShopCode ?? "")",
            "ReceiptId": receiptId
        ] as [String : Any]
        print(params)
        networkManager.request(target: MPOSAPIService.deleteInstallatioReceipt(params: params), completion: completion)
    }
    func sendOTPForCustomer(receiptId:Int,completion: @escaping (Result<SendOTPForCustomer, NetworkError>) -> ()) {
       let params = [
      
            "UserCode":"\(Cache.user?.UserName ?? "")",
            "ShopCode": "\(Cache.user?.ShopCode ?? "")",
            "ReceiptId":"\(receiptId)"
            
        ] as [String : Any]
        print(params)
        networkManager.request(target: MPOSAPIService.sendOTPForCustomer(params: params), completion: completion)
    }
    func confirmOTPReceipt(receiptId:Int,customerOTP:String,completion: @escaping (Result<ConfirmOTPReceipt, NetworkError>) -> ()) {
      
        
        let params = [
            
            "UserCode":"\(Cache.user?.UserName ?? "")",
            "ShopCode": "\(Cache.user?.ShopCode ?? "")",
            "ReceiptId":"\(receiptId)",
            "CustomerOtp":customerOTP
            
        ] as [String : Any]
        print(params)
        networkManager.request(target: MPOSAPIService.confirmOTPReceipt(params: params), completion: completion)
    }
    func returnDeviceReceipt(receiptId:Int,signatureBase64:String,completion: @escaping (Result<ReturnDevice, NetworkError>) -> ()) {
      
        
        let params = [
            
            "UserCode":"\(Cache.user?.UserName ?? "")",
            "ShopCode": "\(Cache.user?.ShopCode ?? "")",
            "ReceiptId":"\(receiptId)",
            "SignatureBase64":"\(signatureBase64)"
            
        ] as [String : Any]
        print(params)
        networkManager.request(target: MPOSAPIService.returnDeviceReceipt(params: params), completion: completion)
    }
    
}
