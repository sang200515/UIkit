//
//  GetTopUpListResult.swift
//  mPOS
//
//  Created by MinhDH on 11/12/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetTopUpListResult: NSObject {
    var Price : Int
    var PriceCard: Int
    var TelecomName: String
    var TypeNCC: String
    var Telecomcode: String

    
    init(Price: Int, PriceCard: Int,TelecomName: String, TypeNCC: String, Telecomcode: String){
        self.Price =  Price
        self.PriceCard = PriceCard
        self.TelecomName =  TelecomName
        self.TypeNCC = TypeNCC
        self.Telecomcode = Telecomcode
    }
    class func parseObjfromArray(array:[JSON])->[GetTopUpListResult]{
        var list:[GetTopUpListResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> GetTopUpListResult{
        var Price = data["Price"].int
       var  PriceCard = data["PriceCard"].int
        var TelecomName = data["TelecomName"].string
        var  TypeNCC = data["TypeNCC"].string
        var Telecomcode = data["Telecomcode"].string
        
        Price = Price == nil ? 0 : Price
        PriceCard = PriceCard == nil ? 0 : PriceCard
        TelecomName = TelecomName == nil ? "" : TelecomName
        TypeNCC = TypeNCC == nil ? "": TypeNCC
        Telecomcode = Telecomcode == nil ? "" : Telecomcode
        return GetTopUpListResult(Price: Price!, PriceCard: PriceCard!,TelecomName: TelecomName!, TypeNCC: TypeNCC!, Telecomcode: Telecomcode!)
        
    }
}

