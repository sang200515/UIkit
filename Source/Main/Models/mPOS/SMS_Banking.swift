//
//  SMS_Banking.swift
//  fptshop
//
//  Created by DiemMy Le on 6/4/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"brandname": "VietComBank",
//"sms_content": "day la tin nha",
//"createdate": "04/06/2020 13:45:01",
//"shopcode": "30808",
//"cardname": "Nguyen Van A",
//"itemname": "Iphone"
//"icon_bank": "http://imagescore.fptshop.com.vn:1233/SMSBanking/TPBank.png",
//"color_bank": "#3d2666",
//"doctotal": "30,000,000 VND"

import UIKit
import SwiftyJSON

class SMS_Banking: NSObject {
    
    let brandname: String
    let sms_content: String
    let createdate: String
    let shopcode: String
    let cardname: String
    let itemname: String
    let icon_bank: String
    let color_bank: String
    let doctotal: String
    
    init(brandname: String, sms_content: String, createdate: String, shopcode: String, cardname: String, itemname: String, icon_bank: String, color_bank: String, doctotal: String) {
        self.brandname = brandname
        self.sms_content = sms_content
        self.createdate = createdate
        self.shopcode = shopcode
        self.cardname = cardname
        self.itemname = itemname
        self.icon_bank = icon_bank
        self.color_bank = color_bank
        self.doctotal = doctotal
    }
    
    class func parseObjfromArray(array:[JSON])->[SMS_Banking]{
        var list:[SMS_Banking] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> SMS_Banking {
        var brandname = data["brandname"].string
        var sms_content = data["sms_content"].string
        var createdate = data["createdate"].string
        var shopcode = data["shopcode"].string
        var cardname = data["cardname"].string
        var itemname = data["itemname"].string
        var icon_bank = data["icon_bank"].string
        var color_bank = data["color_bank"].string
        var doctotal = data["doctotal"].string
        
        brandname = brandname == nil ? "" : brandname
        sms_content = sms_content == nil ? "" : sms_content
        createdate = createdate == nil ? "" : createdate
        shopcode = shopcode == nil ? "" : shopcode
        cardname = cardname == nil ? "" : cardname
        itemname = itemname == nil ? "" : itemname
        icon_bank = icon_bank == nil ? "" : icon_bank
        color_bank = color_bank == nil ? "" : color_bank
        doctotal = doctotal == nil ? "" : doctotal
        
        return SMS_Banking(brandname: brandname!, sms_content: sms_content!, createdate: createdate!, shopcode: shopcode!, cardname: cardname!, itemname: itemname!,icon_bank: icon_bank!, color_bank:color_bank!, doctotal: doctotal!)
    }
}
