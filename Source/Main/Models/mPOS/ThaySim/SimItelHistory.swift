//
//  SimItelHistory.swift
//  fptshop
//
//  Created by Ngo Dang tan on 10/13/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON

class SimItelHistory: NSObject {

    let docentry: String
    let phoneNumber: String
    let shopName: String
    let employeeName: String
    let datetime: String
    
    init(docentry: String, phoneNumber: String, shopName: String, employeeName: String, datetime: String) {
        self.docentry = docentry
        self.phoneNumber = phoneNumber
        self.shopName = shopName
        self.employeeName = employeeName
        self.datetime = datetime
    }
    
    class func parseObjfromArray(array:[JSON])->[SimItelHistory]{
        var list:[SimItelHistory] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> SimItelHistory{
        let docentry = data["docentry"].stringValue
        let phoneNumber = data["phoneNumber"].stringValue
        let shopName = data["shopName"].stringValue
        let employeeName = data["employeeName"].stringValue
        let datetime = data["datetime"].stringValue
        
        return SimItelHistory(docentry: docentry, phoneNumber: phoneNumber, shopName: shopName, employeeName: employeeName, datetime: datetime)
    }
}
