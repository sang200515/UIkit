//
//  CustomerTraCoc.swift
//  fptshop
//
//  Created by Ngo Dang tan on 11/3/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

    // MARK: - CustomerTraCoc
struct CustomerTraCoc {
    let soStatus:String
    let docNum:String
    let u_CrdCod:String
    let u_EplCod:String
    let u_CrDate:String
    let u_Status:String
    let u_Desc:String
    
    let u_INV_TYPE:String
    let u_ShipTyp:String
    let docEntry:String
    let u_ShpCod:String
    let u_CompCod:String
    let u_CmpPrivate:String
    let u_UCode:String
    let u_LicTrad:String
    let u_Address1:String
    let u_CodeECom:String
    let u_SOType:String
    let isConfirm:String
    let u_Phone:String
    let u_TMonBi:String
    let u_PayOnline:String
    let u_Mustpay:String
    let docType:String
    
    init( dictionary: [String:Any]) {
        self.docType = dictionary["docType"] as? String ?? ""
        self.soStatus = dictionary["caption"] as? String ?? ""
        self.docNum = dictionary["docNum"] as? String ?? ""
        self.u_CrdCod = dictionary["u_CrdCod"] as? String ?? ""
        self.u_EplCod = dictionary["u_EplCod"] as? String ?? ""
        self.u_CrDate = dictionary["u_CrDate"] as? String ?? ""
        self.u_Status = dictionary["u_Status"] as? String ?? ""
        self.u_Desc = dictionary["u_Desc"] as? String ?? ""
        self.u_INV_TYPE = dictionary["u_INV_TYPE"] as? String ?? ""
        self.u_ShipTyp = dictionary["u_ShipTyp"] as? String ?? ""
        self.docEntry = dictionary["docEntry"] as? String ?? ""
        self.u_ShpCod = dictionary["u_ShpCod"] as? String ?? ""
        self.u_CompCod = dictionary["u_CompCod"] as? String ?? ""
        self.u_CmpPrivate = dictionary["u_CmpPrivate"] as? String ?? ""
        self.u_UCode = dictionary["u_UCode"] as? String ?? ""
        self.u_LicTrad = dictionary["u_LicTrad"] as? String ?? ""
        self.u_Address1 = dictionary["u_Address1"] as? String ?? ""
        self.u_CodeECom = dictionary["u_CodeECom"] as? String ?? ""
        self.u_SOType = dictionary["u_SOType"] as? String ?? ""
        self.isConfirm = dictionary["isConfirm"] as? String ?? ""
        self.u_Phone = dictionary["u_Phone"] as? String ?? ""
        self.u_TMonBi = dictionary["u_TMonBi"] as? String ?? "0"
        self.u_PayOnline = dictionary["u_PayOnline"] as? String ?? "0"
        self.u_Mustpay = dictionary["u_Mustpay"] as? String ?? "0"
        
    }
}
    // MARK: - TraCoc
struct TraCoc {
    var headers:[HeaderDetailTraCoc]
    var details:[DetailTraCoc]
}

    // MARK: - HeaderDetailTraCoc
struct HeaderDetailTraCoc {
    
    let docNum:String
    let cardCode:String
    let Phone:String
    let cardName:String
    let birthday:String
    let e_Mail:String
    let u_ShpCod:String
    let u_DownPay:String
    let cusAddress:String
    let u_Desc:String
    let docType:String
    
    init( dictionary: [String:Any]) {
        self.docType = dictionary["docType"] as? String ?? ""
        self.docNum = dictionary["docNum"] as? String ?? ""
        self.cardCode = dictionary["cardCode"] as? String ?? "0"
        self.Phone = dictionary["phone"] as? String ?? ""
        self.cardName = dictionary["cardName"] as? String ?? ""
        self.birthday = dictionary["birthday"] as? String ?? ""
        self.e_Mail = dictionary["e_Mail"] as? String ?? ""
        self.u_ShpCod = dictionary["u_ShpCod"] as? String ?? ""
        self.u_DownPay = dictionary["u_DownPay"] as? String ?? "0"
        self.cusAddress = dictionary["cusAddress"] as? String ?? ""
        self.u_Desc = dictionary["u_Desc"] as? String ?? ""
        
        
    }
}
    // MARK: - DetailTraCoc
struct DetailTraCoc  {
    let docEntry:String
    let itemCode:String
    let itemName:String
    let serial:String //imei
    let price:String
    let finalPrice:String
    let quantity:String
    let inventory:String
    let invntItem:String
    let taxPrice:String
    let discountInShop:String
    let totalPrice:String
    let discount:String
    let u_PROMOS:String
    let taxRate:String
    let u_DownPay:String
    
    init( dictionary: [String:Any]) {
        self.docEntry = dictionary["docEntry"] as? String ?? ""
        self.itemCode = dictionary["itemCode"] as? String ?? ""
        self.itemName = dictionary["itemName"] as? String ?? ""
        self.serial = dictionary["serial"] as? String ?? ""
        self.price = dictionary["price"] as? String ?? "0"
        self.finalPrice = dictionary["finalPrice"] as? String ?? ""
        self.quantity = dictionary["quantity"] as? String ?? "0"
        self.inventory = dictionary["inventory"] as? String ?? ""
        self.invntItem = dictionary["invntItem"] as? String ?? ""
        self.taxPrice = dictionary["taxPrice"] as? String ?? ""
        self.discountInShop = dictionary["discountInShop"] as? String ?? ""
        self.totalPrice = dictionary["totalPrice"] as? String ?? "0"
        self.discount = dictionary["discount"] as? String ?? "0"
        self.u_PROMOS = dictionary["u_PROMOS"] as? String ?? ""
        self.taxRate = dictionary["taxRate"] as? String ?? "0"
        self.u_DownPay = dictionary["u_DownPay"] as? String ?? "0"
    }
    
}
