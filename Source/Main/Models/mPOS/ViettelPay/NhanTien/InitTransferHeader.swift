//
//  InitTransferHeader.swift
//  fptshop
//
//  Created by tan on 7/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class InitTransferHeader: NSObject {
    
    var docentry:Int
    var sender_name:String
    
    var sender_msisdn:String
    var receiver_name:String
    
    var receiver_msisdn:String
    var amount:Int
    
    var NgayGiaoDich:String
    var TrangThai:String
    
    init( docentry:Int
    , sender_name:String
    , sender_msisdn:String
    , receiver_name:String
    , receiver_msisdn:String
    , amount:Int
    , NgayGiaoDich:String
    , TrangThai:String){
        
        self.docentry = docentry
        self.sender_name = sender_name
        self.sender_msisdn = sender_msisdn
        self.receiver_name = receiver_name
        self.receiver_msisdn = receiver_msisdn
        self.amount = amount
        self.NgayGiaoDich = NgayGiaoDich
        self.TrangThai = TrangThai
    }
    
    class func parseObjfromArray(array:[JSON])->[InitTransferHeader]{
        var list:[InitTransferHeader] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> InitTransferHeader{
        
        var docentry = data["docentry"].int
        var sender_name = data["sender_name"].string
        
        var sender_msisdn = data["sender_msisdn"].string
        var receiver_name = data["receiver_name"].string
        
        var receiver_msisdn = data["receiver_msisdn"].string
        var amount = data["amount"].int
        
        var NgayGiaoDich = data["NgayGiaoDich"].string
        var TrangThai = data["TrangThai"].string
        
        
        
        
        
        docentry = docentry == nil ? 0 : docentry
        sender_name = sender_name == nil ? "" : sender_name
        
        sender_msisdn = sender_msisdn == nil ? "" : sender_msisdn
        receiver_name = receiver_name == nil ? "" : receiver_name
        
        receiver_msisdn = receiver_msisdn == nil ? "" : receiver_msisdn
        amount = amount == nil ? 0 : amount
        
        NgayGiaoDich = NgayGiaoDich == nil ? "" : NgayGiaoDich
        TrangThai = TrangThai == nil ? "" : TrangThai
        
        
        
        return InitTransferHeader( docentry:docentry!
            , sender_name:sender_name!
            , sender_msisdn:sender_msisdn!
            , receiver_name:receiver_name!
            , receiver_msisdn:receiver_msisdn!
            , amount:amount!
            , NgayGiaoDich:NgayGiaoDich!
            , TrangThai:TrangThai!
        )
    }
}
