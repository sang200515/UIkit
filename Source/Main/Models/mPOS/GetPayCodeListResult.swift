//
//  GetPayCodeListResult.swift
//  mPOS
//
//  Created by MinhDH on 11/12/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class GetPayCodeListResult: NSObject {
    
    var ID : Int
    var TelecomCode: String
    var TelecomName : String
    var Price: Int
    var PriceCard: Int
    var TypeNCC:String

    init(ID : Int, TelecomCode: String, TelecomName: String, Price: Int, PriceCard: Int, TypeNCC:String){
        self.ID = ID
        self.TelecomCode = TelecomCode
        self.TelecomName = TelecomName
        self.Price = Price
        self.PriceCard = PriceCard
        self.TypeNCC = TypeNCC
    }
    class func parseObjfromArray(array:[JSON])->[GetPayCodeListResult]{
        var list:[GetPayCodeListResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> GetPayCodeListResult{
        var ID = data["ID"].int
        var TelecomCode = data["TelecomCode"].string
        var TelecomName = data["TelecomName"].string
        var Price = data["Price"].int
        var PriceCard = data["PriceCard"].int
        var TypeNCC = data["TypeNCC"].string
        
        ID = ID == nil ? 0 : ID
        TelecomCode = TelecomCode == nil ? "" : TelecomCode
        TelecomName = TelecomName == nil ? "" : TelecomName
        
        Price = Price == nil ? 0 : Price
        PriceCard = PriceCard == nil ? 0 : PriceCard
        TypeNCC = TypeNCC == nil ? "" : TypeNCC
        
        
        return GetPayCodeListResult(ID: ID!, TelecomCode: TelecomCode!, TelecomName: TelecomName!, Price: Price!, PriceCard: PriceCard!, TypeNCC:TypeNCC!)
        
    }
}
