//
//  TransferHeaders.swift
//  fptshop
//
//  Created by tan on 6/27/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class TransferHeaders: NSObject {
    var docentry:Int
    var TransactionCode:String
    var trans_id_viettel:String
    var TrangThai:String
    var sender_name:String
    var amount:Int
    var cust_fee:Int
    var sender_msisdn:String
    var NgayGiaoDich:String
    
    init( docentry:Int
    , TransactionCode:String
    , trans_id_viettel:String
    , TrangThai:String
    , sender_name:String
    , amount:Int
    , cust_fee:Int
    , sender_msisdn:String
    , NgayGiaoDich:String){
        self.docentry = docentry
        self.TransactionCode = TransactionCode
        self.trans_id_viettel = trans_id_viettel
        self.TrangThai = TrangThai
        self.sender_name = sender_name
        self.amount = amount
        self.cust_fee = cust_fee
        self.sender_msisdn = sender_msisdn
        self.NgayGiaoDich = NgayGiaoDich
    }
    
    class func parseObjfromArray(array:[JSON])->[TransferHeaders]{
        var list:[TransferHeaders] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> TransferHeaders{
        
        var docentry = data["docentry"].int
        var TransactionCode = data["TransactionCode"].string
        var trans_id_viettel = data["trans_id_viettel"].string
        
        var TrangThai = data["TrangThai"].string
        var sender_name = data["sender_name"].string
        var amount = data["amount"].int
        
        var cust_fee = data["cust_fee"].int
        var sender_msisdn = data["sender_msisdn"].string
        var NgayGiaoDich = data["NgayGiaoDich"].string
        
        
        
        
        
        
        docentry = docentry == nil ? 0 : docentry
        TransactionCode = TransactionCode == nil ? "" : TransactionCode
        trans_id_viettel = trans_id_viettel == nil ? "" : trans_id_viettel
        
        TrangThai = TrangThai == nil ? "" : TrangThai
        sender_name = sender_name == nil ? "" : sender_name
        amount = amount == nil ? 0 : amount
        
        cust_fee = cust_fee == nil ? 0 : cust_fee
        sender_msisdn = sender_msisdn == nil ? "" : sender_msisdn
        NgayGiaoDich = NgayGiaoDich == nil ? "" : NgayGiaoDich
        
        
        return TransferHeaders(  docentry:docentry!
            , TransactionCode:TransactionCode!
            , trans_id_viettel:trans_id_viettel!
            
            , TrangThai: TrangThai!
            , sender_name: sender_name!
            , amount: amount!
            
            , cust_fee:cust_fee!
            , sender_msisdn:sender_msisdn!
            , NgayGiaoDich:NgayGiaoDich!
        )
    }
}
