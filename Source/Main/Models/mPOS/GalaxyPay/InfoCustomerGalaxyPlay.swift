//
//  InfoCustomerGalaxyPlay.swift
//  fptshop
//
//  Created by DiemMy Le on 9/16/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class InfoCustomerGalaxyPlay: NSObject {
    var phone: String
    var message: String
    var status: Int
    var listPlans: [GalaxyPlayPlans]
    var listOffers: [GalaxyPlayOffer]
    
    init(phone: String, message: String, status: Int, listPlans: [GalaxyPlayPlans], listOffers: [GalaxyPlayOffer]) {
        self.phone = phone
        self.message = message
        self.status = status
        self.listPlans = listPlans
        self.listOffers = listOffers
    }
    
    class func getObjFromDictionary(data:JSON) -> InfoCustomerGalaxyPlay {
        let subscription = data["subscription"]
        let phone = subscription["phone"].stringValue
        let message = subscription["message"].stringValue
        let status = subscription["status"].intValue
        
        let arrJsonPlans = subscription["plans"].array ?? []
        let listPlansGalaxy = GalaxyPlayPlans.parseObjfromArray(array: arrJsonPlans)
        
        let arrJsonOffers = data["offers"].array ?? []
        let listOffersGalaxy = GalaxyPlayOffer.parseObjfromArray(array: arrJsonOffers)
        
        
        return InfoCustomerGalaxyPlay(phone: phone, message: message, status: status, listPlans: listPlansGalaxy, listOffers: listOffersGalaxy)
    }
}

class GalaxyPlayPlans {
    var startAt:String
    var expireAt:String
    var productName:String
    var statusExpire:Int
    
    init(startAt:String, expireAt:String, productName:String, statusExpire:Int) {
        self.startAt = startAt
        self.expireAt = expireAt
        self.productName = productName
        self.statusExpire = statusExpire
    }
    
    class func parseObjfromArray(array:[JSON])->[GalaxyPlayPlans] {
        var list:[GalaxyPlayPlans] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> GalaxyPlayPlans {
        let startAt = data["startAt"].stringValue
        let expireAt = data["expireAt"].stringValue
        let productName = data["productName"].stringValue
        let statusExpire = data["statusExpire"].intValue
        
        return GalaxyPlayPlans(startAt: startAt, expireAt: expireAt, productName: productName, statusExpire: statusExpire)
    }
}

class GalaxyPlayOffer {

    var productcode_frt:String
    var name:String
    var startAt:String
    var endAt:String
    var description:String
    var id:String
    var price:Double
    var price_cost:Double
    var isChoose = false
    
    init(productcode_frt:String, name:String, startAt:String, endAt:String, description:String, id:String, price:Double,price_cost:Double) {
        self.productcode_frt = productcode_frt
        self.name = name
        self.startAt = startAt
        self.endAt = endAt
        self.description = description
        self.id = id
        self.price = price
        self.price_cost = price_cost
    }
    
    class func parseObjfromArray(array:[JSON])->[GalaxyPlayOffer] {
        var list:[GalaxyPlayOffer] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> GalaxyPlayOffer {
        let productcode_frt = data["productcode_frt"].stringValue
        let name = data["name"].stringValue
        let startAt = data["startAt"].stringValue
        let endAt = data["endAt"].stringValue
        let description = data["description"].stringValue
        let id = data["id"].stringValue
        let price = data["price"].doubleValue
        let price_cost = data["price_cost"].doubleValue
        
        return GalaxyPlayOffer(productcode_frt: productcode_frt, name: name, startAt: startAt, endAt: endAt, description: description, id: id, price: price,price_cost:price_cost)
    }
}
struct ResultInsertGalaxyPay {
    let total_credit_fee:Int
    var Phonenumber:String
    let p_messages:String
    let Doctotal:Int
    let Itemcode_NCC:String
    let total_credit:Int
    let productcode:String
    let total_cash:Int
    let p_status:Int
    let NhaCC:String
    let Docentry: Int
    let productname:String
    let crm_SalesOrderCode:String
    
    init(dictionary: [String:AnyObject]) {
        self.total_credit_fee = dictionary["total_credit_fee"] as? Int ?? 0
        self.Phonenumber = dictionary["Phonenumber"] as? String ?? ""
        self.p_messages = dictionary["p_messages"] as? String ?? ""
        self.Doctotal = dictionary["Doctotal"] as? Int ?? 0
        self.Itemcode_NCC = dictionary["dictionary"] as? String ?? ""
        self.total_credit = dictionary["total_credit"] as? Int ?? 0
        self.productcode = dictionary["productcode"] as? String ?? ""
        self.total_cash = dictionary["total_cash"] as? Int ?? 0
        self.p_status = dictionary["p_status"] as? Int ?? 0
        self.NhaCC = dictionary["NhaCC"] as? String ?? ""
        self.Docentry = dictionary["Docentry"] as? Int ?? 0
        self.productname = dictionary["productname"] as? String ?? ""
        self.crm_SalesOrderCode = dictionary["crm_SalesOrderCode"] as? String ?? ""
    }
    
    
}
