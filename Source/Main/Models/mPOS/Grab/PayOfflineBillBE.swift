//
//  PayOfflineBillBE.swift
//  fptshop
//
//  Created by tan on 5/14/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class PayOfflineBillBE: NSObject {
    var OrderNo:String
    var ReturnCode:String
    var ReturnCodeDescription:String
    var DocEntry:Int
    var MaGDFRT:String
    var VCName:String
    var VCnum:String
    var Den_ngay:String
    var Tu_ngay:String
    
    init(OrderNo:String
    , ReturnCode:String
    , ReturnCodeDescription:String
        , DocEntry:Int
        , MaGDFRT:String
    , VCName:String
    , VCnum:String
    , Den_ngay:String
    , Tu_ngay:String){
        self.OrderNo = OrderNo
        self.ReturnCode = ReturnCode
        self.ReturnCodeDescription = ReturnCodeDescription
        self.DocEntry = DocEntry
        self.MaGDFRT = MaGDFRT
        self.VCName = VCName
        self.VCnum = VCnum
        self.Den_ngay = Den_ngay
        self.Tu_ngay = Tu_ngay
    }
    
  
    class func parseObjfromArray(array:[JSON])->[PayOfflineBillBE]{
        var list:[PayOfflineBillBE] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> PayOfflineBillBE{
        
        var OrderNo = data["OrderNo"].string
        var ReturnCode = data["ReturnCode"].string
        var ReturnCodeDescription = data["ReturnCodeDescription"].string
        var DocEntry = data["DocEntry"].int
        var MaGDFRT = data["MaGDFRT"].string
        var VCName = data["VCName"].string
        var VCnum = data["VCnum"].string
        var Den_ngay = data["Den_ngay"].string
        var Tu_ngay = data["Tu_ngay"].string

        
        
        OrderNo = OrderNo == nil ? "" : OrderNo
        ReturnCode = ReturnCode == nil ? "" : ReturnCode
        ReturnCodeDescription = ReturnCodeDescription == nil ? "" : ReturnCodeDescription
        DocEntry = DocEntry == nil ? 0 : DocEntry
        MaGDFRT = MaGDFRT == nil ? "" : MaGDFRT
        VCName = VCName == nil ? "" : VCName
        VCnum = VCnum == nil ? "" : VCnum
        Den_ngay = Den_ngay == nil ? "" : Den_ngay
        Tu_ngay = Tu_ngay == nil ? "" : Tu_ngay

        return PayOfflineBillBE(OrderNo: OrderNo!,ReturnCode:ReturnCode!,ReturnCodeDescription:ReturnCodeDescription!,DocEntry:DocEntry!,MaGDFRT:MaGDFRT!,VCName:VCName!,VCnum:VCnum!, Den_ngay:Den_ngay!,Tu_ngay:Tu_ngay!)
    }
    
    
}
