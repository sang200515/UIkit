//
//  CallLogDescriptionDetails.swift
//  mCallLog_v2
//
//  Created by Trần Thành Phương Đăng on 09/10/18.
//  Copyright © 2018 vn.com.fptshop. All rights reserved.
//

import Foundation;

class CallLogDescriptionDetails{
    var RequestAmount: Int!;
    var ReceivingShop: String!;
    var ProductId: String!;
    var ProductName: String!;
    var RemainAmount: Int!;
    var RequestNumber: String!;
    var ReceiveStorageId: String!;
    var ExportStorageId: String!;
    var ExportShopName: String!;
    var TotalMoney2Weeks: String!;
    var TotalMoneyInRequest: String!;
    
    public static func ParseStringToModel(fromStr: String) -> CallLogDescriptionDetails{
        var temp = fromStr;
        temp.removeFirst();
        
        let regex = try! NSRegularExpression(pattern:"@(.*?)@", options: [])
        var results = [String]()
        
        regex.enumerateMatches(in: temp, options: [], range: NSMakeRange(0, temp.utf16.count)) { result, flags, stop in
            if let r = result?.range(at: 1), let range = Range(r, in: temp) {
                results.append(String(temp[range]))
            }
        }
        
        let callLogDescriptionDetails = CallLogDescriptionDetails();
        var tempStr: String!;
        
        results.forEach{ subStr in
            tempStr = subStr;
            
            if(tempStr.contains("Số lượng yêu cầu: ")){
                if let range = tempStr.range(of: "Số lượng yêu cầu: ") {
                    callLogDescriptionDetails.RequestAmount = Int(tempStr[range.upperBound...].trimmingCharacters(in: .whitespacesAndNewlines));
                }
            }
            
            if(tempStr.contains("Shop nhận: ")){
                if let range = tempStr.range(of: "Shop nhận: ") {
                    callLogDescriptionDetails.ReceivingShop = String(tempStr[range.upperBound...]);
                }
            }
            
            if(tempStr.contains("Mã sản phẩm: ")){
                if let range = tempStr.range(of: "Mã sản phẩm: ") {
                    callLogDescriptionDetails.ProductId = String(tempStr[range.upperBound...]);
                }
            }
            
            if(tempStr.contains("Tên sản phẩm: ")){
                if let range = tempStr.range(of: "Tên sản phẩm: ") {
                    callLogDescriptionDetails.ProductName = String(tempStr[range.upperBound...]);
                }
            }
            
            if(tempStr.contains("Số lượng tồn kho: ")){
                if let range = tempStr.range(of: "Số lượng tồn kho: ") {
                    callLogDescriptionDetails.RemainAmount = Int(tempStr[range.upperBound...].trimmingCharacters(in: .whitespacesAndNewlines));
                }
            }
            
            if(tempStr.contains("Số yêu cầu điều chuyển: ")){
                if let range = tempStr.range(of: "Số yêu cầu điều chuyển: ") {
                    callLogDescriptionDetails.RequestNumber = String(tempStr[range.upperBound...]);
                }
            }
            
            if(tempStr.contains("Mã kho nhận: ")){
                if let range = tempStr.range(of: "Mã kho nhận: ") {
                    callLogDescriptionDetails.ReceiveStorageId = String(tempStr[range.upperBound...]);
                }
            }
            
            if(tempStr.contains("Mã kho xuất: ")){
                if let range = tempStr.range(of: "Mã kho xuất: ") {
                    callLogDescriptionDetails.ExportStorageId = String(tempStr[range.upperBound...]);
                }
            }
            
            if(tempStr.contains("Mã shop xuất: ")){
                if let range = tempStr.range(of: "Mã shop xuất: ") {
                    callLogDescriptionDetails.ExportShopName = String(tempStr[range.upperBound...]);
                }
            }
        }
        return callLogDescriptionDetails;
    }
}
