//
//  CardCodePayoo.swift
//  mPOS
//
//  Created by MinhDH on 2/1/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class CardCodePayoo: NSObject {
    
    var CardId: String
    var Expired: String
    var SeriNumber: String
    var TypeCard: String
    
    init(CardId: String,Expired: String,SeriNumber: String,TypeCard: String){
        self.CardId = CardId
        self.Expired = Expired
        self.SeriNumber = SeriNumber
        self.TypeCard = TypeCard
    }
    class func parseObjfromArray(array:[JSON])->[CardCodePayoo]{
        var list:[CardCodePayoo] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> CardCodePayoo{
        
        var cardId = data["CardId"].string
        var expired = data["Expired"].string
        var seriNumber = data["SeriNumber"].string
        var typeCard = data["TypeCard"].string
        
        cardId = cardId == nil ? "" : cardId
        expired = expired == nil ? "" : expired
        seriNumber = seriNumber == nil ? "" : seriNumber
        typeCard = typeCard == nil ? "" : typeCard
        
        return CardCodePayoo(CardId: cardId!,Expired: expired!,SeriNumber: seriNumber!,TypeCard: typeCard!)
    }
}

