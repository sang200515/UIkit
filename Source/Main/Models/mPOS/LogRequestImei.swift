//
//  LogRequestImei.swift
//  mPOS
//
//  Created by MinhDH on 4/5/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class LogRequestImei: NSObject {
    
    var Imei: String
    var LanCuoigoiServer: String
    var TTFKnox: String
    var passcode: String
    var tokenapi: String
    
    init(Imei: String, LanCuoigoiServer: String, TTFKnox: String, passcode: String, tokenapi: String){
        self.Imei = Imei
        self.LanCuoigoiServer = LanCuoigoiServer
        self.TTFKnox = TTFKnox
        self.passcode = passcode
        self.tokenapi = tokenapi
    }
    class func parseObjfromArray(array:[JSON])->[LogRequestImei]{
        var list:[LogRequestImei] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> LogRequestImei{
        
        var imei = data["Imei"].string
        var lanCuoigoiServer = data["LanCuoigoiServer"].string
        var ttFKnox = data["TTFKnox"].string
        var passcode = data["passcode"].string
        var tokenapi = data["tokenapi"].string
        
        imei = imei == nil ? "" : imei
        lanCuoigoiServer = lanCuoigoiServer == nil ? "" : lanCuoigoiServer
        ttFKnox = ttFKnox == nil ? "" : ttFKnox
        passcode = passcode == nil ? "" : passcode
        tokenapi = tokenapi == nil ? "" : tokenapi
        
        return LogRequestImei(Imei: imei!, LanCuoigoiServer: lanCuoigoiServer!, TTFKnox: ttFKnox!, passcode: passcode!, tokenapi: tokenapi!)
    }
}
