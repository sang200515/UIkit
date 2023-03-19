//
//  PGCheckIn.swift
//  fptshop
//
//  Created by Apple on 1/23/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"personalID": "123456780",
//        "fullName": "Nguyễn Văn B",
//        "doiTac": "Samsung",
//        "checkIN": "1/12/21 9:18:13 AM",
//        "checkOut": "1/9/21 9:18:13 AM",
//        "wareHouseName": "HNM 34 Biên Hòa"

import UIKit
import SwiftyJSON

class PGCheckIn: NSObject {
    let personalID: String
    let fullName: String
    let doiTac: String
    let checkIN: String
    let checkOut: String
    let wareHouseName: String
    
    init(personalID: String, fullName: String, doiTac: String, checkIN: String, checkOut: String, wareHouseName: String) {
        self.personalID = personalID
        self.fullName = fullName
        self.doiTac = doiTac
        self.checkIN = checkIN
        self.checkOut = checkOut
        self.wareHouseName = wareHouseName
    }
    
    class func parseObjfromArray(array:[JSON])->[PGCheckIn]{
        var list:[PGCheckIn] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> PGCheckIn{
        let personalID = data["personalID"].stringValue
        let fullName = data["fullName"].stringValue
        let doiTac = data["doiTac"].stringValue
        let checkIN = data["checkIN"].stringValue
        let checkOut = data["checkOut"].stringValue
        let wareHouseName = data["wareHouseName"].stringValue
        
        return PGCheckIn(personalID: personalID, fullName: fullName, doiTac: doiTac, checkIN: checkIN, checkOut: checkOut, wareHouseName: wareHouseName)
    }
}
