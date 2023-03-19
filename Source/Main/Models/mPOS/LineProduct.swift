//
//  LineProduct.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class LineProduct: NSObject {
    var DocEntry: Int
    var Dscription: String
    var GroupCode_promos: String
    var ItemCode: String
    var LineNum: Int
    var Price: Float
    var LineTotal: Float
    var Quantity: Int
    var Status: String
    var U_DisOther: Float
    var U_Imei: String
    var U_PROMOS: String
    var U_ProCode: String
    var WhsCode: String
    var QLImei: String
    var MaShop: String
    var U_discount: Float
    var PriceAfterPromos: Float
    var LineTax: Float
    var LinkAnh: String
    
    init(DocEntry: Int, Dscription: String, GroupCode_promos: String, ItemCode: String, LineNum: Int, Price: Float,LineTotal: Float, Quantity: Int, Status: String, U_DisOther: Float, U_Imei: String, U_PROMOS: String, U_ProCode: String, WhsCode: String,QLImei :String,MaShop: String,U_discount: Float, PriceAfterPromos: Float, LineTax: Float, LinkAnh: String) {
        self.DocEntry = DocEntry
        self.Dscription = Dscription
        self.GroupCode_promos = GroupCode_promos
        self.ItemCode = ItemCode
        self.LineNum = LineNum
        self.Price = Price
        self.LineTotal = LineTotal
        self.Quantity = Quantity
        self.Status = Status
        self.U_DisOther = U_DisOther
        self.U_Imei = U_Imei
        self.U_PROMOS = U_PROMOS
        self.U_ProCode = U_ProCode
        self.WhsCode = WhsCode
        self.QLImei = QLImei
        self.MaShop = MaShop
        self.U_discount = U_discount
        self.PriceAfterPromos = PriceAfterPromos
        self.LineTax = LineTax
        self.LinkAnh = LinkAnh
    }
    class func parseObjfromArray(array:[JSON])->[LineProduct]{
        var list:[LineProduct] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> LineProduct{
        var docEntry = data["DocEntry"].int
        var dscription = data["Dscription"].string
        var groupCode_promos = data["GroupCode_promos"].string
        var itemCode = data["ItemCode"].string
        var lineNum = data["LineNum"].int
        var price = data["Price"].float
        var lineTotal = data["LineTotal"].float
        var quantity = data["Quantity"].int
        var status = data["Status"].string
        var u_DisOther = data["U_DisOther"].float
        var u_Imei = data["U_Imei"].string
        var u_PROMOS = data["U_PROMOS"].string
        var u_ProCode = data["U_ProCode"].string
        var whsCode = data["WhsCode"].string
        var qlImei = data["QLImei"].string
        var maShop = data["MaShop"].string
        var U_discount = data["U_discount"].float
        var PriceAfterPromos = data["PriceAfterPromos"].float
        var LineTax = data["LineTax"].float
        var LinkAnh = data["LinkAnh"].string
        
        docEntry = docEntry == nil ? 0 : docEntry
        dscription = dscription == nil ? "" : dscription
        groupCode_promos = groupCode_promos == nil ? "" : groupCode_promos
        itemCode = itemCode == nil ? "" : itemCode
        lineNum = lineNum == nil ? 0 : lineNum
        price = price == nil ? 0 : price
        lineTotal = lineTotal == nil ? 0 : lineTotal
        quantity = quantity == nil ? 0 : quantity
        status = status == nil ? "" : status
        u_DisOther = u_DisOther == nil ? 0 : u_DisOther
        u_Imei = u_Imei == nil ? "" : u_Imei
        u_PROMOS = u_PROMOS == nil ? "" : u_PROMOS
        u_ProCode = u_ProCode == nil ? "" : u_ProCode
        whsCode = whsCode == nil ? "" : whsCode
        qlImei = qlImei == nil ? "" : qlImei
        maShop = maShop == nil ? "" : maShop
        U_discount = U_discount == nil ? 0 : U_discount
        PriceAfterPromos = PriceAfterPromos == nil ? 0 : PriceAfterPromos
        LineTax = LineTax == nil ? 0 : LineTax
        LinkAnh = LinkAnh == nil ? "" : LinkAnh
        
        return LineProduct(DocEntry: docEntry!, Dscription: dscription!, GroupCode_promos: groupCode_promos!, ItemCode: itemCode!, LineNum: lineNum!, Price: price!,LineTotal: lineTotal!, Quantity: quantity!, Status: status!, U_DisOther: u_DisOther!, U_Imei: u_Imei!, U_PROMOS: u_PROMOS!, U_ProCode: u_ProCode!, WhsCode: whsCode!,QLImei:qlImei!,MaShop:maShop!,U_discount:U_discount!, PriceAfterPromos: PriceAfterPromos!, LineTax: LineTax!, LinkAnh: LinkAnh!)
    }
}

