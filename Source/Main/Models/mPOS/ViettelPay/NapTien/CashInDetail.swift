//
//  CashInDetail.swift
//  fptshop
//
//  Created by tan on 7/10/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class CashInDetail: NSObject {
    var trans_id:Int
    var order_id:String
    var docentry:Int
    var TransactionCode:String
    
    var trans_id_viettel:String
    var billcode:String
    
    var amount:Int
    var cust_fee:Int
    
    var receiver_name:String
    var receiver_msisdn:String
    
    var receiver_id_number:String
    var sender_name:String
    
    
    var sender_msisdn:String
    var sender_id_number:String
    
    var CMND_mattruoc:String
    var CMND_matsau:String
    
    var Note:String
    var trans_fee:Int
    var u_vocher:String
    
    init(trans_id:Int
        ,order_id:String
        ,docentry:Int
    , TransactionCode:String
    , trans_id_viettel:String
    , billcode:String
    , amount:Int
    , cust_fee:Int
    , receiver_name:String
    , receiver_msisdn:String
    , receiver_id_number:String
    , sender_name:String
    , sender_msisdn:String
    , sender_id_number:String
    , CMND_mattruoc:String
    , CMND_matsau:String
    , Note:String
        ,trans_fee:Int
        ,u_vocher:String){
        self.trans_id = trans_id
        self.order_id = order_id
        self.docentry = docentry
        self.TransactionCode = TransactionCode
        self.trans_id_viettel = trans_id_viettel
        self.billcode = billcode
        self.amount = amount
        self.cust_fee = cust_fee
        self.receiver_name = receiver_name
        self.receiver_msisdn = receiver_msisdn
        self.receiver_id_number = receiver_id_number
        self.sender_name = sender_name
        self.sender_msisdn = sender_msisdn
        self.sender_id_number = sender_id_number
        self.CMND_mattruoc = CMND_mattruoc
        self.CMND_matsau = CMND_matsau
        self.Note = Note
        self.trans_fee = trans_fee
        self.u_vocher = u_vocher
    }
    
    class func parseObjfromArray(array:[JSON])->[CashInDetail]{
        var list:[CashInDetail] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> CashInDetail{
   
        var trans_id = data["trans_id"].int
        var order_id = data["order_id"].string
        var docentry = data["docentry"].int
        var TransactionCode = data["TransactionCode"].string
        
        var trans_id_viettel = data["trans_id_viettel"].string
        var billcode = data["billcode"].string
        
        var amount = data["amount"].int
        var cust_fee = data["cust_fee"].int
        
        var receiver_name = data["receiver_name"].string
        var receiver_msisdn = data["receiver_msisdn"].string
        
        var receiver_id_number = data["receiver_id_number"].string
        var sender_name = data["sender_name"].string
        
        var sender_msisdn = data["sender_msisdn"].string
        var sender_id_number = data["sender_id_number"].string
        
        var CMND_mattruoc = data["CMND_mattruoc"].string
        var CMND_matsau = data["CMND_matsau"].string
        var Note = data["Note"].string
        var trans_fee = data["trans_fee"].int
        var u_vocher = data["u_vocher"].string
        
        
        docentry = docentry == nil ? 0 : docentry
        TransactionCode = TransactionCode == nil ? "" : TransactionCode
        
        trans_id_viettel = trans_id_viettel == nil ? "" : trans_id_viettel
        billcode = billcode == nil ? "" : billcode
        
        amount = amount == nil ? 0 : amount
        cust_fee = cust_fee == nil ? 0 : cust_fee
        
        receiver_name = receiver_name == nil ? "" : receiver_name
        receiver_msisdn = receiver_msisdn == nil ? "" : receiver_msisdn
        
        receiver_id_number = receiver_id_number == nil ? "" : receiver_id_number
        sender_name = sender_name == nil ? "" : sender_name
        
        sender_msisdn = sender_msisdn == nil ? "" : sender_msisdn
        sender_id_number = sender_id_number == nil ? "" : sender_id_number
        
        CMND_mattruoc = CMND_mattruoc == nil ? "" : CMND_mattruoc
        CMND_matsau = CMND_matsau == nil ? "" : CMND_matsau
        
        Note = Note == nil ? "" : Note
        trans_id = trans_id == nil ? 0 : trans_id
        order_id = order_id == nil ? "" : order_id
        trans_fee = trans_fee == nil ? 0 : trans_fee
        u_vocher = u_vocher == nil ? "" : u_vocher
        
        
        
        return CashInDetail(trans_id:trans_id!
            ,order_id: order_id!
            ,docentry:docentry!
            , TransactionCode:TransactionCode!
            ,trans_id_viettel:trans_id_viettel!
            ,billcode:billcode!
            ,amount:amount!
            ,cust_fee:cust_fee!
            ,receiver_name:receiver_name!
            ,receiver_msisdn:receiver_msisdn!
            ,receiver_id_number:receiver_id_number!
            ,sender_name:sender_name!
            ,sender_msisdn:sender_msisdn!
            ,sender_id_number:sender_id_number!
            ,CMND_mattruoc:CMND_mattruoc!
            ,CMND_matsau:CMND_matsau!
            ,Note:Note!
            ,trans_fee:trans_fee!
            ,u_vocher:u_vocher!
            
        )
    }
    
}
