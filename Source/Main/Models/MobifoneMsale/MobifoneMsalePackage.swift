//
//  MobifoneMsalePackage.swift
//  fptshop
//
//  Created by DiemMy Le on 11/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"package_fpt": "00726248",
//            "package_name_fpt": "Gọi Thả Ga 70 đầu 09 ",
//            "package_price": 0,
//            "package_code": "205441CT01-MQ-09"
//"price_topup" : 90000,
import UIKit
import SwiftyJSON

class MobifoneMsalePackage: NSObject {
    var package_price:Double
    var package_fpt:String
    var package_name_fpt:String
    var package_code:String
    var price_topup:Double
    
    init(package_price:Double, package_fpt:String, package_name_fpt:String, package_code:String, price_topup:Double) {
        self.package_price = package_price
        self.package_fpt = package_fpt
        self.package_name_fpt = package_name_fpt
        self.package_code = package_code
        self.price_topup = price_topup
    }
    
    class func parseObjfromArray(array:[JSON])->[MobifoneMsalePackage]{
        var list:[MobifoneMsalePackage] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> MobifoneMsalePackage {
        let package_price = data["package_price"].doubleValue
        let package_fpt = data["package_fpt"].stringValue
        let package_name_fpt = data["package_name_fpt"].stringValue
        let package_code = data["package_code"].stringValue
        let price_topup = data["price_topup"].doubleValue

        return MobifoneMsalePackage(package_price: package_price, package_fpt: package_fpt, package_name_fpt: package_name_fpt, package_code: package_code, price_topup: price_topup)
        
    }
}
