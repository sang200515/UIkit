//
//  HistoryFlightTribi.swift
//  fptshop
//
//  Created by Ngo Dang tan on 1/7/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"DocEntry": 12,
//"bookingId": 1763538,
//"fullName": "nguyen hoang di",
//"email": "trungtp@gmail.com.vn",
//"phone": "0908376564",
//"finalPriceFormatted": "6.114.000 đ",
//"bookedDate": "03-01-2020 13:39:12",
//"So_POS": 0,
//"EmployeeName": "Nguyễn Thị Thương",
//"ShopCode": "30808",
//"Status": "Đã ghi nhận thông tin đặt vé thành công",
//"StatusCode": "P"
import Foundation
import SwiftyJSON
class HistoryFlightTribi: NSObject {
    var DocEntry:Int
    var bookingId:Int
    var fullName:String
    var email:String
    var phone:String
    var finalPriceFormatted:String
    var bookedDate:String
    var So_POS:Int
    var EmployeeName:String
    var ShopCode:String
    var Status:String
    var StatusCode:String
    var SO_MPOS:Int
    var inboundPnrCode:String
    var outboundPnrCode:String
    
    init(DocEntry:Int
        , bookingId:Int
        , fullName:String
        , email:String
        , phone:String
        , finalPriceFormatted:String
        , bookedDate:String
        , So_POS:Int
        , EmployeeName:String
        , ShopCode:String
        , Status:String
        , StatusCode:String
        , SO_MPOS:Int
    , inboundPnrCode:String
    , outboundPnrCode:String){
        self.DocEntry = DocEntry
        self.bookingId = bookingId
        self.fullName = fullName
        self.email = email
        self.phone = phone
        self.finalPriceFormatted = finalPriceFormatted
        self.bookedDate = bookedDate
        self.So_POS = So_POS
        self.EmployeeName = EmployeeName
        self.ShopCode = ShopCode
        self.Status = Status
        self.StatusCode = StatusCode
        self.SO_MPOS = SO_MPOS
        self.inboundPnrCode = inboundPnrCode
        self.outboundPnrCode = outboundPnrCode
    }
    
    class func parseObjfromArray(array:[JSON])->[HistoryFlightTribi]{
        var list:[HistoryFlightTribi] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> HistoryFlightTribi{
        
        var DocEntry = data["DocEntry"].int
        var bookingId = data["bookingId"].int
        var fullName = data["fullName"].string
        var email = data["email"].string
        var phone = data["phone"].string
        
        var finalPriceFormatted = data["finalPriceFormatted"].string
        var bookedDate = data["bookedDate"].string
        var So_POS = data["So_POS"].int
        var EmployeeName = data["EmployeeName"].string
        var ShopCode = data["ShopCode"].string
        var Status = data["Status"].string
        var StatusCode = data["StatusCode"].string
        var SO_MPOS = data["SO_MPOS"].int
        var inboundPnrCode = data["inboundPnrCode"].string
        var outboundPnrCode = data["outboundPnrCode"].string
        
        DocEntry = DocEntry == nil ? 0 : DocEntry
        bookingId = bookingId == nil ? 0 : bookingId
           fullName = fullName == nil ? "" : fullName
         email = email == nil ? "" : email
         phone = phone == nil ? "" : phone
        finalPriceFormatted = finalPriceFormatted == nil ? "" : finalPriceFormatted
        bookedDate = bookedDate == nil ? "" : bookedDate
           So_POS = So_POS == nil ? 0 : So_POS
         EmployeeName = EmployeeName == nil ? "" : EmployeeName
         ShopCode = ShopCode == nil ? "" : ShopCode
           Status = Status == nil ? "" : Status
           StatusCode = StatusCode == nil ? "" : StatusCode
        SO_MPOS = SO_MPOS == nil ? 0 : SO_MPOS
        inboundPnrCode = inboundPnrCode == nil ? "" : inboundPnrCode
        outboundPnrCode = outboundPnrCode == nil ? "" : outboundPnrCode
        return HistoryFlightTribi(DocEntry:DocEntry!
        , bookingId:bookingId!
        , fullName:fullName!
        , email:email!
        , phone:phone!
        , finalPriceFormatted:finalPriceFormatted!
        , bookedDate:bookedDate!
        , So_POS:So_POS!
        , EmployeeName:EmployeeName!
        , ShopCode:ShopCode!
        , Status:Status!
        , StatusCode:StatusCode!
            ,SO_MPOS:SO_MPOS!
            ,inboundPnrCode:inboundPnrCode!
            ,outboundPnrCode:outboundPnrCode!
        )
    }
}
