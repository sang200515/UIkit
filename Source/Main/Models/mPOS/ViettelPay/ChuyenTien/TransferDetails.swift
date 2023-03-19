//
//  TransferDetails.swift
//  fptshop
//
//  Created by tan on 6/27/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class TransferDetails: NSObject {
    var docentry:Int
    var TransactionCode:String
    var trans_id_viettel:String
    var billcode:String
    var amount:Int
    var cust_fee:Int
    var receiver_name:String
    var receiver_msisdn:String
    var receiver_id_number:String
    var receiver_province:String
    var receiver_district:String
    var receiver_precinct:String
    var receiver_address:String
    var sender_name:String
    var sender_msisdn:String
    var sender_id_number:String
    var transfer_type:Int
    var transfer_form:Int
    var CMND_mattruoc:String
    var CMND_matsau:String
    var transfer_typeName:String
    var transfer_formName:String
    var trangthai:String
    var NgayGiaoDich:String
    
    init(   docentry:Int
    , TransactionCode:String
    , trans_id_viettel:String
    , billcode:String
    , amount:Int
    , cust_fee:Int
    , receiver_name:String
    , receiver_msisdn:String
    , receiver_id_number:String
    , receiver_province:String
    , receiver_district:String
    , receiver_precinct:String
    , receiver_address:String
    , sender_name:String
    , sender_msisdn:String
    , sender_id_number:String
    , transfer_type:Int
    , transfer_form:Int
    , CMND_mattruoc:String
    , CMND_matsau:String
    , transfer_typeName:String
   , transfer_formName:String
        ,trangthai:String
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
        self.receiver_province = receiver_province
        self.receiver_district = receiver_district
        self.receiver_precinct = receiver_precinct
        self.receiver_address = receiver_address
        self.sender_name = sender_name
        self.sender_msisdn = sender_msisdn
        self.sender_id_number = sender_id_number
        self.transfer_type = transfer_type
        self.transfer_form = transfer_form
        self.CMND_mattruoc = CMND_mattruoc
        self.CMND_matsau = CMND_matsau
        self.transfer_typeName = transfer_typeName
        self.transfer_formName = transfer_formName
        self.trangthai = trangthai
        self.NgayGiaoDich = NgayGiaoDich
    }
    
    class func parseObjfromArray(array:[JSON])->[TransferDetails]{
        var list:[TransferDetails] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> TransferDetails{
        
        var docentry = data["docentry"].int
        var TransactionCode = data["TransactionCode"].string
        
        var trans_id_viettel = data["trans_id_viettel"].string
        var billcode = data["billcode"].string
        
        var amount = data["amount"].int
        var cust_fee = data["cust_fee"].int
        
        var receiver_name = data["receiver_name"].string
        var receiver_msisdn = data["receiver_msisdn"].string
        
        var receiver_id_number = data["receiver_id_number"].string
        var receiver_province = data["receiver_province"].string
        
        var receiver_district = data["receiver_district"].string
        var receiver_precinct = data["receiver_precinct"].string
        
        var receiver_address = data["receiver_address"].string
        var sender_name = data["sender_name"].string
        
        var sender_msisdn = data["sender_msisdn"].string
        var sender_id_number = data["sender_id_number"].string
        
        var transfer_type = data["transfer_type"].int
        var transfer_form = data["transfer_form"].int
        
        var CMND_mattruoc = data["CMND_mattruoc"].string
        var CMND_matsau = data["CMND_matsau"].string
        
        var transfer_typeName = data["transfer_typeName"].string
        var transfer_formName = data["transfer_formName"].string
        
        
        
        
        
        
        
        
        
        docentry = docentry == nil ? 0 : docentry
        TransactionCode = TransactionCode == nil ? "" : TransactionCode
        
        trans_id_viettel = trans_id_viettel == nil ? "" : trans_id_viettel
        billcode = billcode == nil ? "" : billcode
        
        amount = amount == nil ? 0 : amount
        cust_fee = cust_fee == nil ? 0 : cust_fee
        
        receiver_name = receiver_name == nil ? "" : receiver_name
        receiver_msisdn = receiver_msisdn == nil ? "" : receiver_msisdn
        
        receiver_id_number = receiver_id_number == nil ? "" : receiver_id_number
        receiver_province = receiver_province == nil ? "" : receiver_province
        
        receiver_district = receiver_district == nil ? "" : receiver_district
        receiver_precinct = receiver_precinct == nil ? "" : receiver_precinct
        
        receiver_address = receiver_address == nil ? "" : receiver_address
        sender_name = sender_name == nil ? "" : sender_name
        
        sender_msisdn = sender_msisdn == nil ? "" : sender_msisdn
        sender_id_number = sender_id_number == nil ? "" : sender_id_number
        
        transfer_type = transfer_type == nil ? 0 : transfer_type
        transfer_form = transfer_form == nil ? 0 : transfer_form
        
        CMND_mattruoc = CMND_mattruoc == nil ? "" : CMND_mattruoc
        CMND_matsau = CMND_matsau == nil ? "" : CMND_matsau
        
        transfer_typeName = transfer_typeName == nil ? "" : transfer_typeName
        transfer_formName = transfer_formName == nil ? "" : transfer_formName
        
        
        
        return TransferDetails(  docentry:docentry!
            , TransactionCode:TransactionCode!
            , trans_id_viettel:trans_id_viettel!
            , billcode:billcode!
            , amount:amount!
            , cust_fee:cust_fee!
            , receiver_name:receiver_name!
            , receiver_msisdn:receiver_msisdn!
            , receiver_id_number:receiver_id_number!
            , receiver_province:receiver_province!
            , receiver_district:receiver_district!
            , receiver_precinct:receiver_precinct!
            , receiver_address:receiver_address!
            , sender_name:sender_name!
            , sender_msisdn:sender_msisdn!
            , sender_id_number:sender_id_number!
            , transfer_type:transfer_type!
            , transfer_form:transfer_form!
            , CMND_mattruoc:CMND_mattruoc!
            , CMND_matsau:CMND_matsau!
            , transfer_typeName:transfer_typeName!
            , transfer_formName:transfer_formName!
            , trangthai:""
            , NgayGiaoDich: ""
            
        )
    }
}
