//
//  InitTransferDetail.swift
//  fptshop
//
//  Created by tan on 7/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class InitTransferDetail: NSObject {
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
    var receiver_address:String
    var NgayGiaoDich:String
    
    init(  docentry:Int
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
    , receiver_address:String
        ,NgayGiaoDich:String){
        
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
        self.receiver_address = receiver_address
        self.NgayGiaoDich  = NgayGiaoDich
    }
    
    class func parseObjfromArray(array:[JSON])->[InitTransferDetail]{
        var list:[InitTransferDetail] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> InitTransferDetail{
        
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
        
        var receiver_address = data["receiver_address"].string
        
        
        
        
        
        
        
        
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
         receiver_address = receiver_address == nil ? "" : receiver_address
        return InitTransferDetail(docentry:docentry!
            , TransactionCode:TransactionCode!
            , trans_id_viettel:trans_id_viettel!
            , billcode:billcode!
            , amount:amount!
            , cust_fee:cust_fee!
            , receiver_name:receiver_name!
            , receiver_msisdn:receiver_msisdn!
            , receiver_id_number:receiver_id_number!
            , sender_name:sender_name!
            , sender_msisdn:sender_msisdn!
            , sender_id_number:sender_id_number!
            , CMND_mattruoc:CMND_mattruoc!
            , CMND_matsau:CMND_matsau!
            , Note:CMND_matsau!
            , receiver_address:receiver_address!
            , NgayGiaoDich: ""
        )
    }
}
