//
//  SimThuong.swift
//  fptshop
//
//  Created by Apple on 4/16/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"sim4G": "true",
//"serial": "8984048000050230645",
//"normalIsdn": "true",
//"normalIsdnDesc": "Sim thường",
//"payType": "2",
//"payTypeDesc": "Trả trước"


import UIKit
import SwiftyJSON

class SimThuong: NSObject {

    let sim4G: String
    let serial: String
    let normalIsdn: String
    let normalIsdnDesc: String
    let payType: String
    let payTypeDesc: String
    
    
    init(sim4G: String, serial: String, normalIsdn: String, normalIsdnDesc: String, payType: String, payTypeDesc: String) {
        self.sim4G = sim4G
        self.serial = serial
        self.normalIsdn = normalIsdn
        self.normalIsdnDesc = normalIsdnDesc
        self.payType = payType
        self.payTypeDesc = payTypeDesc
       
    }
    
    class func parseObjfromArray(array:[JSON])->[SimThuong]{
        var list:[SimThuong] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> SimThuong{
        var sim4G = data["sim4G"].string
        var serial = data["serial"].string
        var normalIsdn = data["normalIsdn"].string
        var normalIsdnDesc = data["normalIsdnDesc"].string
        var payType = data["payType"].string
        var payTypeDesc = data["payTypeDesc"].string
        
        sim4G = sim4G == nil ? "" : sim4G
        serial = serial == nil ? "" : serial
        normalIsdn = normalIsdn == nil ? "" : normalIsdn
        normalIsdnDesc = normalIsdnDesc == nil ? "" : normalIsdnDesc
        payType = payType == nil ? "" : payType
        payTypeDesc = payTypeDesc == nil ? "" : payTypeDesc
        
        
        return SimThuong(sim4G: sim4G!, serial: serial!, normalIsdn: normalIsdn!, normalIsdnDesc: normalIsdnDesc!, payType: payType!, payTypeDesc: payTypeDesc!)
    }
}

class GetSimFeeItel {
    
    let amount: Int
    let p_messages: String
    let tenkhachhang: String
    let birthdate:String
    let cmnd: String
    let noicap: String
    let ngaycap: String
    
    init(amount: Int, p_messages: String, tenkhachhang: String, birthdate: String, cmnd: String, noicap: String, ngaycap: String) {
        self.amount = amount
        self.p_messages = p_messages
        self.tenkhachhang = tenkhachhang
        self.birthdate = birthdate
        self.cmnd = cmnd
        self.noicap = noicap
        self.ngaycap = ngaycap
    }
    
    class func getObjFromDictionary(data:JSON) -> GetSimFeeItel{
        let amount = data["amount"].intValue
        let p_messages = data["p_messages"].stringValue
        let tenkhachhang = data["tenkhachhang"].stringValue
        let birthdate = data["birthdate"].stringValue
        let cmnd = data["cmnd"].stringValue
        let noicap = data["noicap"].stringValue
        let ngaycap = data["ngaycap"].stringValue
        
        return GetSimFeeItel(amount: amount, p_messages: p_messages, tenkhachhang: tenkhachhang,birthdate: birthdate,cmnd:cmnd,noicap: noicap, ngaycap: ngaycap)
    }
}
