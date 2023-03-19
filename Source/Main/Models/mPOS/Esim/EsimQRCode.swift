//
//  EsimQRCode.swift
//  fptshop
//
//  Created by tan on 3/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class EsimQRCode: NSObject {
    var arrQRCode:String
    var imsi:String
    var serial:String
    var status:String
    var urlEsim:String
    var sdt:String
    
    init(     arrQRCode:String
        ,imsi:String
    , serial:String
    , status:String
    , urlEsim:String
        , sdt:String){
        self.arrQRCode = arrQRCode
        self.imsi = imsi
        self.serial = serial
        self.status = status
        self.urlEsim = urlEsim
        self.sdt = sdt
    }
    
    class func parseObjfromArray(array:[JSON])->[EsimQRCode]{
        var list:[EsimQRCode] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> EsimQRCode{
        
        var arrQRCode = data["arrQRCode"].string
        var imsi = data["imsi"].string
        var serial = data["serial"].string
        var status = data["status"].string
        var urlEsim = data["urlEsim"].string
        
        
        arrQRCode = arrQRCode == nil ? "" : arrQRCode
        imsi = imsi == nil ? "" : imsi
        serial = serial == nil ? "" : serial
        status = status == nil ? "" : status
        urlEsim = urlEsim == nil ? "" : urlEsim
        
        
        return EsimQRCode(arrQRCode: arrQRCode!,imsi:imsi!, serial: serial!,status:status!,urlEsim:urlEsim!,sdt: "")
    }
}
