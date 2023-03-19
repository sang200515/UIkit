//
//  ScanQRCodeVerify.swift
//  fptshop
//
//  Created by DiemMy Le on 9/4/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"shiperCode": null,
//"shiperName": null,
//"result": "0",
//"message": ""

import UIKit
import SwiftyJSON

class ScanQRCodeVerify: NSObject {

    let shiperCode:String
    let shiperName:String
    let result:String
    let message: String
    
    init(shiperCode:String, shiperName:String, result:String, message: String) {
        self.shiperCode = shiperCode
        self.shiperName = shiperName
        self.result = result
        self.message = message
    }
    
    class func parseObjfromArray(array:[JSON])->[ScanQRCodeVerify]{
        var list:[ScanQRCodeVerify] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ScanQRCodeVerify {
        var shiperCode = data["shiperCode"].string
        var shiperName = data["shiperName"].string
        var result = data["result"].string
        var message = data["message"].string
        
        shiperCode = shiperCode == nil ? "" : shiperCode
        shiperName = shiperName == nil ? "" : shiperName
        result = result == nil ? "" : result
        message = message == nil ? "" : message
        
        return ScanQRCodeVerify(shiperCode: shiperCode!, shiperName: shiperName!, result: result!, message: message!)
    }
}

class GNNB_ScanQRCode: NSObject {

    let billCode:String
    let binCode:String
    let result:String
    let message: String
    let totalScaned: String
    
    init(billCode:String, binCode:String, result:String, message: String, totalScaned: String) {
        self.billCode = billCode
        self.binCode = binCode
        self.result = result
        self.message = message
        self.totalScaned = totalScaned
    }
    
    class func parseObjfromArray(array:[JSON])->[GNNB_ScanQRCode]{
        var list:[GNNB_ScanQRCode] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> GNNB_ScanQRCode {
        var billCode = data["billCode"].string
        var binCode = data["binCode"].string
        var result = data["result"].string
        var message = data["message"].string
        var totalScaned = data["totalScaned"].string
        
        billCode = billCode == nil ? "" : billCode
        binCode = binCode == nil ? "" : binCode
        result = result == nil ? "" : result
        message = message == nil ? "" : message
        totalScaned = totalScaned == nil ? "" : totalScaned
        
        return GNNB_ScanQRCode(billCode: billCode!, binCode: binCode!, result: result!, message: message!, totalScaned: totalScaned!)
    }
}
