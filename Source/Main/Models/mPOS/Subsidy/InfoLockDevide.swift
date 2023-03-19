//
//  InfoLockDevide.swift
//  mPOS
//
//  Created by tan on 8/22/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class InfoLockDevide: NSObject{
    var TenKH:String
    var NgaySinh:String
    var CMND:String
    var NoiCapCMND:String
    var SDTSSD:String
    var NgayKichHoat:String
    var ImeiMay:String
    var TenSP:String
    var GoiCuoc:String
    
    init(TenKH:String,NgaySinh:String,CMND:String,NoiCapCMND:String,SDTSSD:String,NgayKichHoat:String,ImeiMay:String,TenSP:String,GoiCuoc:String){
        self.TenKH = TenKH
        self.NgaySinh = NgaySinh
        self.CMND = CMND
        self.NoiCapCMND = NoiCapCMND
        self.SDTSSD = SDTSSD
        self.NgayKichHoat = NgayKichHoat
        self.ImeiMay = ImeiMay
        self.TenSP = TenSP
        self.GoiCuoc = GoiCuoc
        
    }
    
    
    
    class func parseObjfromArray(array:[JSON])->[InfoLockDevide]{
        var list:[InfoLockDevide] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> InfoLockDevide{
        var TenKH = data["TenKH"].string
        var NgaySinh = data["NgaySinh"].string
        var CMND = data["CMND"].string
        var NoiCapCMND = data["NoiCapCMND"].string
        var SDTSSD = data["SDTSSD"].string
        var NgayKichHoat = data["NgayKichHoat"].string
        var ImeiMay = data["ImeiMay"].string
        var TenSP = data["TenSP"].string
        var GoiCuoc = data["GoiCuoc"].string
        
        TenKH = TenKH == nil ? "" : TenKH
        NgaySinh = NgaySinh == nil ? "1970-01-01T00:00:00" : NgaySinh
        CMND = CMND == nil ? "" : CMND
        NoiCapCMND = NoiCapCMND == nil ? "" : NoiCapCMND
        SDTSSD = SDTSSD == nil ? "" : SDTSSD
        NgayKichHoat = NgayKichHoat == nil ? "" : NgayKichHoat
        ImeiMay = ImeiMay == nil ? "" : ImeiMay
        TenSP = TenSP == nil ? "" : TenSP
        GoiCuoc = GoiCuoc == nil ? "" : GoiCuoc
        
        
        //NgayKichHoat = formatDate(date: NgayKichHoat!)
        NgaySinh = formatDate(date: NgaySinh!)
        return InfoLockDevide(TenKH: TenKH!, NgaySinh: NgaySinh!,CMND: CMND!, NoiCapCMND: NoiCapCMND!,
                              SDTSSD: SDTSSD!, NgayKichHoat: NgayKichHoat!,ImeiMay: ImeiMay!, TenSP: TenSP!,GoiCuoc: GoiCuoc!)
    }
    
    class func formatDate(date:String) -> String{
        let deFormatter = DateFormatter()
        deFormatter.timeZone = TimeZone(abbreviation: "UTC")
        deFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let startTime = deFormatter.date(from: date)
        deFormatter.dateFormat = "dd/MM/yyyy"
        return deFormatter.string(from: startTime!)
    }
    
}
