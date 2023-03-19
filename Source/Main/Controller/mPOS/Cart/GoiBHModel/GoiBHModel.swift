//
//  GoiBHModel.swift
//  fptshop
//
//  Created by Sang Truong on 3/7/22.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit
class GoiBHModel {
    
    var masp : String?
    var nameSP : String?
    var brand : String?
    var role2:String?
    init(masp: String? = nil, nameSP: String? = nil, brand: String? = nil, role2: String? = nil) {
        self.masp = masp
        self.nameSP = nameSP
        self.brand = brand
        self.role2 = role2
    }
    
    class func getObjFromDictionary(map:JSON) -> GoiBHModel {
        let masp = map["masp"].stringValue
        let nameSP = map["nameSP"].stringValue
        let brand = map["brand"].stringValue
        let role2 = map["role2"].stringValue
        return GoiBHModel(masp: masp, nameSP: nameSP, brand: brand, role2: role2)
    }
    class func parseObjfromArray(array:[JSON])->[GoiBHModel]{
        var list:[GoiBHModel] = []
        for item in array {
            list.append(self.getObjFromDictionary(map: item))
        }
        return list
    }
    
}

class InsuranceCodeItem {
    var message : MessageGoiBH?
    var data : DataGoiBH?
    
    init(message: MessageGoiBH? = nil, data: DataGoiBH? = nil) {
        self.message = message
        self.data = data
    }
    
    class func getObjFromDictionary(map:JSON) -> InsuranceCodeItem {
        let message = MessageGoiBH.getObjFromDictionary(map: map["message"])
        let data = DataGoiBH.getObjFromDictionary(map: map["data"])
        return InsuranceCodeItem(message: message, data: data)
    }
}

class MessageGoiBH {
    
    let message_Code : Int?
    let message_Desc : String?

    init(message_Code: Int?, message_Desc: String?) {
        self.message_Code = message_Code
        self.message_Desc = message_Desc
    }
    
    class func getObjFromDictionary(map:JSON) -> MessageGoiBH {
        let message_Code = map["message_Code"].intValue
        let message_Desc = map["message_Desc"].stringValue
        return MessageGoiBH(message_Code: message_Code, message_Desc: message_Desc)
    }

}
class DataGoiBH  {
    var canSell : Bool?
    var imei : String = ""
    var insuranceCode : String = ""
    var insurancePrice : Float = 0
    
    init(canSell: Bool? = nil,imei: String, insuranceCode: String,insurancePrice: Float) {
        self.canSell = canSell
        self.imei = imei
            self.insuranceCode = insuranceCode
            self.insurancePrice = insurancePrice
    }
    
    
    class func getObjFromDictionary(map:JSON) -> DataGoiBH {
        let canSell = map["canSell"].boolValue
        let imei = map["imei"].stringValue
        let insuranceCode = map["insuranceCode"].stringValue
        let insurancePrice = map["insurancePrice"].floatValue
        return DataGoiBH(canSell: canSell, imei: imei, insuranceCode: insuranceCode, insurancePrice: insurancePrice)
    }
    
}
