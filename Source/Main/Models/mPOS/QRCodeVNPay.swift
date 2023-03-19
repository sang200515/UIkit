//
//  QRCodeVNPay.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/4/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class QRCodeVNPay: NSObject {
    var base64QRCode: String
    var txnId: String
    
    init(base64QRCode: String, txnId: String) {
        self.base64QRCode = base64QRCode
        self.txnId = txnId
    }
    class func parseObjfromArray(array:[JSON])->[QRCodeVNPay]{
        var list:[QRCodeVNPay] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> QRCodeVNPay{
    
        var base64QRCode = data["base64QRCode"].string
        var txnId = data["txnId"].string

        base64QRCode = base64QRCode == nil ? "" : base64QRCode
        txnId = txnId == nil ? "" : txnId
        
        return QRCodeVNPay(base64QRCode: base64QRCode!, txnId: txnId!)
    }
}

