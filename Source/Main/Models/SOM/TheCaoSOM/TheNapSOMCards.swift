//
//  TheNapSOMCards.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

class TheNapSOMCards: Mappable {
    var orderID: String = ""
    var orderTransactionID: String = ""
    var providerID: String = ""
    var cards: [TheNapSOMCard] = []

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.orderID <- map["orderId"]
        self.orderTransactionID <- map["orderTransactionId"]
        self.providerID <- map["providerId"]
        self.cards <- map["cards"]
    }
}

class TheNapSOMCard: Mappable {
    var cardName: String = ""
    var pin: String = ""
    var serial: String = ""
    var price: Int = 0
    var rawExpiredDate: String = ""

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.cardName <- map["cardName"]
        self.pin <- map["pin"]
        self.serial <- map["serial"]
        self.price <- map["price"]
        self.rawExpiredDate <- map["rawExpiredDate"]
    }
}
