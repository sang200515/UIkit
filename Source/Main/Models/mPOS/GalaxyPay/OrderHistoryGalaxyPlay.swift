//
//  OrderHistoryGalaxyPlay.swift
//  fptshop
//
//  Created by DiemMy Le on 9/16/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"EmployeeName": "15261-Nguyễn Phúc Hữu",
//"Phonenumber": "0396440829",
//"productcode": "01364455",
//"productname": "Gói Mobile 6 tháng",
//"note_product": "Chỉ xem trên 1 thiết bị di động thông minh: Điện thoại hoặc máy tính bảng.",
//"startdate_product": "",
//"enddate_product": "",
//"ngaygiaodich": "2020-09-16 14:19:21.8",
//"Itemcode_NCC": "5f3fea90942bef30ec50b3bd",
//"Doctotal": 180000,
//"docentry": "1",
//"transactioncode_NCC": "5f61bbf6e1034e6a969a7a97",
//"orderid": "FRT-M-1"

import UIKit
import SwiftyJSON

class OrderHistoryGalaxyPlay: NSObject {

    var EmployeeName: String
    var Phonenumber: String
    var productcode: String
    var productname: String
    var note_product: String
    var startdate_product: String
    var enddate_product: String
    var ngaygiaodich: String
    var Itemcode_NCC: String
    var Doctotal: Double
    var docentry: String
    var transactioncode_NCC: String
    var orderid: String
    var NhaCC:String
    var crm_SalesOrderCode:String
    
    init(EmployeeName: String, Phonenumber: String, productcode: String, productname: String, note_product: String, startdate_product: String, enddate_product: String, ngaygiaodich: String, Itemcode_NCC: String, Doctotal: Double, docentry: String, transactioncode_NCC: String, orderid: String,NhaCC:String,crm_SalesOrderCode:String) {
        
        self.EmployeeName = EmployeeName
        self.Phonenumber = Phonenumber
        self.productcode = productcode
        self.productname = productname
        self.note_product = note_product
        self.startdate_product = startdate_product
        self.enddate_product = enddate_product
        self.ngaygiaodich = ngaygiaodich
        self.Itemcode_NCC = Itemcode_NCC
        self.Doctotal = Doctotal
        self.docentry = docentry
        self.transactioncode_NCC = transactioncode_NCC
        self.orderid = orderid
        self.NhaCC = NhaCC
        self.crm_SalesOrderCode = crm_SalesOrderCode
    }
    
    class func parseObjfromArray(array:[JSON])->[OrderHistoryGalaxyPlay] {
        var list:[OrderHistoryGalaxyPlay] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> OrderHistoryGalaxyPlay {
        let EmployeeName = data["EmployeeName"].stringValue
        let Phonenumber = data["Phonenumber"].stringValue
        let productcode = data["productcode"].stringValue
        let productname = data["productname"].stringValue
        let note_product = data["note_product"].stringValue
        let startdate_product = data["startdate_product"].stringValue
        let enddate_product = data["enddate_product"].stringValue
        let ngaygiaodich = data["ngaygiaodich"].stringValue
        let Itemcode_NCC = data["Itemcode_NCC"].stringValue
        let Doctotal = data["Doctotal"].doubleValue
        let docentry = data["docentry"].stringValue
        let transactioncode_NCC = data["transactioncode_NCC"].stringValue
        let orderid = data["orderid"].stringValue
        let NhaCC = data["NhaCC"].stringValue
        let crm_SalesOrderCode = data["crm_SalesOrderCode"].stringValue
        
        return OrderHistoryGalaxyPlay(EmployeeName: EmployeeName, Phonenumber: Phonenumber, productcode: productcode, productname: productname, note_product: note_product, startdate_product: startdate_product, enddate_product: enddate_product, ngaygiaodich: ngaygiaodich, Itemcode_NCC: Itemcode_NCC, Doctotal: Doctotal, docentry: docentry, transactioncode_NCC: transactioncode_NCC, orderid: orderid,NhaCC:NhaCC,crm_SalesOrderCode:crm_SalesOrderCode)
    }
}
struct OrctGalaxyPay{
    let U_MoCCad:Int
    let TypeBank:String
    let U_MoCash:Int
    let cardfee:Int
    let namecard:String
    let phonenumber:String
    let IDBankCard:String
    let totalcardfee:Int
    let U_NumVouhcer:String
    
    init(dictionary: [String:AnyObject]) {
        self.U_MoCCad = dictionary["U_MoCCad"] as? Int ?? 0
        self.TypeBank = dictionary["TypeBank"] as? String ?? ""
        self.U_MoCash = dictionary["U_MoCash"] as? Int ?? 0
        self.cardfee = dictionary["cardfee"] as? Int ?? 0
        self.namecard = dictionary["namecard"] as? String ?? ""
        self.phonenumber = dictionary["phonenumber"] as? String ?? ""
        self.IDBankCard = dictionary["IDBankCard"] as? String ?? ""
        self.totalcardfee = dictionary["totalcardfee"] as? Int ?? 0
        self.U_NumVouhcer = dictionary["U_NumVouhcer"] as? String ?? ""

    }
    
}
