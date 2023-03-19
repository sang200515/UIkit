//
//  CreateQRCodeMobile.swift
//  fptshop
//
//  Created by DiemMy Le on 11/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
////
//"code": "00",
//"message": "Tạo QRCode thành công!",
//"msgID": "9e323b9751204546a0bd9c6074241b4e",
//"partnerTxID": "M-13",
//"qrcode": "00020101021226550011vn.moca.www0136679863f0-1ffa-4da5-a07f-786d8eec793752047298530370454062000005802VN5907FPT pos6011Ho Chi Minh62310507KSF3S2q0716YqLelZqiTiXIqM8b64170002EN0107FPT pos6304C98D",
//"txID": "3c1853dc3fdf4fe1915cd0edc01f6b16"

import UIKit
import SwiftyJSON

class CreateQRCodeMobile: NSObject {
    var code:String
    var message:String
    var msgID:String
    var partnerTxID:String
    var qrcode:String
    var txID:String
    
    init(code:String, message:String, msgID:String, partnerTxID:String, qrcode:String, txID:String) {
        self.code = code
        self.message = message
        self.msgID = msgID
        self.partnerTxID = partnerTxID
        self.qrcode = qrcode
        self.txID = txID
    }
    
    class func parseObjfromArray(array:[JSON])->[CreateQRCodeMobile]{
        var list:[CreateQRCodeMobile] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> CreateQRCodeMobile{
        var code = data["code"].string
        var message = data["message"].string
        var msgID = data["msgID"].string
        var partnerTxID = data["partnerTxID"].string
        var qrcode = data["qrcode"].string
        var txID = data["txID"].string
        
        code = code == nil ? "" : code
        message = message == nil ? "" : message
        msgID = msgID == nil ? "" : msgID
        partnerTxID = partnerTxID == nil ? "" : partnerTxID
        qrcode = qrcode == nil ? "" : qrcode
        txID = txID == nil ? "" : txID
        
        return CreateQRCodeMobile(code: code!, message: message!, msgID: msgID!, partnerTxID: partnerTxID!, qrcode: qrcode!, txID: txID!)
    }
}
