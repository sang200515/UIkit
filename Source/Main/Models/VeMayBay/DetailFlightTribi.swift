//
//  DetailFlightTribi.swift
//  fptshop
//
//  Created by Ngo Dang tan on 1/7/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"DocEntry": 12,
//"bookingId": 1763538,
//"tilte": "Mr",
//"fullName": "nguyen hoang di",
//"email": "trungtp@gmail.com.vn",
//"phone": "0908376564",
//"ageCategory": "adult",
//"insuranceContact": "{\"id\":11405,\"gender\":\"M\",\"firstName\":\"Hoang Di\",\"lastName\":\"Nguyen\",\"fullName\":\"Nguyen Hoang di\",\"email\":\"trungtp@gmail.com.vn\",\"dob\":\"\",\"phone1\":\"0908376564\",\"passport\":\"\",\"totalPrice\":90000}",
//"inboundPnrCode": null,
//"inbound": null,
//"outboundPnrCode": "FAKE-8453",
//"outbound": "{\"fromAirport\":\"HAN\",\"toAirport\":\"SGN\",\"fromAirportName\":\"Nội Bài\",\"toAirportName\":\"Tân Sơn Nhất\",\"airline\":\"Vietnam Airlines\",\"ticketStatus\":\"holding\",\"supportChangeItinerary\":false,\"ticketId\":2801107,\"departureDate\":\"03-01-2020\",\"departureTime\":\"17:30\",\"arrivalDate\":\"03-01-2020\",\"arrivalTime\":\"19:45\",\"flightCode\":\"VN261\",\"airlineId\":1,\"ticketClassCode\":\"economy\",\"numStops\":0,\"duration\":8100000,\"farePrice\":3009000,\"price\":6024000,\"netPrice\":6018000}",
//"numGuests": 2,
//"numChildren": 0,
//"numInfants": 0,
//"guests": "[{\"id\":5020477,\"gender\":\"M\",\"firstName\":\"Phu Trung\",\"lastName\":\"Tran\",\"fullName\":\"Tran Phu Trung\",\"dob\":\"\",\"ageCategory\":\"adult\",\"passport\":\"\",\"infants\":[],\"insuranceInfo\":{\"insurancePackageCode\":\"VN_OneWay_IND_short\",\"insurancePackageName\":\"Chubb\",\"fromDate\":\"03-01-2020\",\"toDate\":\"03-01-2020\"}},{\"id\":5020478,\"gender\":\"M\",\"firstName\":\"Nguyen Duy\",\"lastName\":\"Tran\",\"fullName\":\"Tran Nguyen Duy\",\"dob\":\"\",\"ageCategory\":\"adult\",\"passport\":\"\",\"infants\":[],\"insuranceInfo\":{\"insurancePackageCode\":\"VN_OneWay_IND_short\",\"insurancePackageName\":\"Chubb\",\"fromDate\":\"03-01-2020\",\"toDate\":\"03-01-2020\"}}]",
//"bookedDate": "03-01-2020 13:39:12",
//"expriredTime": "03-01-2020 14:09:12",
//"bookStatus": "Đang giữ chỗ",
//"finalPriceFormatted": "6.114.000 đ",
//"Status": "Thông tin đặt vé đã hết hạn",
//"So_POS": 0,
//"Isbutton": 0
//"IsCalllog": 0,
//"RequestID": "0"
import Foundation
import SwiftyJSON
class DetailFlightTribi: NSObject {
    var DocEntry:Int
    var bookingId:Int
    var tilte:String
    var fullName:String
    var email:String
    var phone:String
    var ageCategory:String
    var insuranceContact:String
    var inboundPnrCode:String
    var inbound:String
    var outboundPnrCode:String
    var outbound:String
    var numGuests:Int
    var numChildren:Int
    var numInfants:Int
    var guests:String
    var bookedDate:String
    var expriredTime:String
    var bookStatus:String
    var finalPriceFormatted:String
    var Status:String
    var So_POS:Int
    var Isbutton:Int
    var IsCalllog:Int
    var RequestID:String
    var SoMPOS:Int
    
    init(  DocEntry:Int
       , bookingId:Int
       , tilte:String
       , fullName:String
       , email:String
       , phone:String
       , ageCategory:String
       , insuranceContact:String
       , inboundPnrCode:String
       , inbound:String
       , outboundPnrCode:String
       , outbound:String
       , numGuests:Int
       , numChildren:Int
       , numInfants:Int
       , guests:String
       , bookedDate:String
       , expriredTime:String
       , bookStatus:String
       , finalPriceFormatted:String
       , Status:String
       , So_POS:Int
        , Isbutton:Int
        , IsCalllog: Int
        , RequestID: String
        ,SoMPOS:Int){
        self.DocEntry = DocEntry
        self.bookingId = bookingId
        self.tilte = tilte
        self.fullName = fullName
        self.email = email
        self.phone = phone
        self.ageCategory = ageCategory
        self.insuranceContact = insuranceContact
        self.inboundPnrCode = inboundPnrCode
        self.inbound = inbound
        self.outboundPnrCode = outboundPnrCode
        self.outbound = outbound
        self.numGuests = numGuests
        self.numChildren = numChildren
        self.numInfants = numInfants
        self.guests = guests
        self.bookedDate = bookedDate
        self.expriredTime = expriredTime
        self.bookStatus = bookStatus
        self.finalPriceFormatted = finalPriceFormatted
        self.Status = Status
        self.So_POS = So_POS
        self.Isbutton = Isbutton
        self.IsCalllog = IsCalllog
        self.RequestID = RequestID
        self.SoMPOS = SoMPOS
    }
    class func parseObjfromArray(array:[JSON])->[DetailFlightTribi]{
          var list:[DetailFlightTribi] = []
          for item in array {
              list.append(self.getObjFromDictionary(data: item))
          }
          return list
      }
      
      class func getObjFromDictionary(data:JSON) -> DetailFlightTribi{
          
          var DocEntry = data["DocEntry"].int
        var bookingId = data["bookingId"].int
        var tilte = data["tilte"].string
        var fullName = data["fullName"].string
        var email = data["email"].string
        var phone = data["phone"].string
        var ageCategory = data["ageCategory"].string
        var insuranceContact = data["insuranceContact"].string
        var inboundPnrCode = data["inboundPnrCode"].string
        var inbound = data["inbound"].string
        var outboundPnrCode = data["outboundPnrCode"].string
        var outbound = data["outbound"].string
        var numGuests = data["numGuests"].int
        var numChildren = data["numChildren"].int
        var numInfants = data["numInfants"].int
        var guests = data["guests"].string
        var bookedDate = data["bookedDate"].string
        var expriredTime = data["expriredTime"].string
        var bookStatus = data["bookStatus"].string
        var finalPriceFormatted = data["finalPriceFormatted"].string
        var Status = data["Status"].string
        var So_POS = data["So_POS"].int
        var Isbutton = data["Isbutton"].int
        var IsCalllog = data["IsCalllog"].int
        var RequestID = data["RequestID"].string
          
          DocEntry = DocEntry == nil ? 0 : DocEntry
        bookingId = bookingId == nil ? 0 : bookingId
        tilte = tilte == nil ? "" : tilte
            fullName = fullName == nil ? "" : fullName
        email = email == nil ? "" : email
        phone = phone == nil ? "" : phone
        ageCategory = ageCategory == nil ? "" : ageCategory
        insuranceContact = insuranceContact == nil ? "" : insuranceContact
        inboundPnrCode = inboundPnrCode == nil ? "" : inboundPnrCode
        inbound = inbound == nil ? "" : inbound
        outboundPnrCode = outboundPnrCode == nil ? "" : outboundPnrCode
        outbound = outbound == nil ? "" : outbound
        numGuests = numGuests == nil ? 0 : numGuests
             numChildren = numChildren == nil ? 0 : numChildren
              numInfants = numInfants == nil ? 0 : numInfants
                guests = guests == nil ? "" : guests
        bookedDate = bookedDate == nil ? "" : bookedDate
        expriredTime = expriredTime == nil ? "" : expriredTime
        bookStatus = bookStatus == nil ? "" : bookStatus
        finalPriceFormatted = finalPriceFormatted == nil ? "" : finalPriceFormatted
        Status = Status == nil ? "" : Status
        So_POS = So_POS == nil ? 0 : So_POS
        Isbutton = Isbutton == nil ? 0 : Isbutton
        IsCalllog = IsCalllog == nil ? 0 : IsCalllog
        RequestID = RequestID == nil ? "" : RequestID

        return DetailFlightTribi( DocEntry:DocEntry!
            , bookingId:bookingId!
            , tilte:tilte!
            , fullName:fullName!
            , email:email!
            , phone:phone!
            , ageCategory:ageCategory!
            , insuranceContact:insuranceContact!
            , inboundPnrCode:inboundPnrCode!
            , inbound:inbound!
            , outboundPnrCode:outboundPnrCode!
            , outbound:outbound!
            , numGuests:numGuests!
            , numChildren:numChildren!
            , numInfants:numInfants!
            , guests:guests!
            , bookedDate:bookedDate!
            , expriredTime:expriredTime!
            , bookStatus:bookStatus!
            , finalPriceFormatted:finalPriceFormatted!
            , Status:Status!
            , So_POS:So_POS!
            , Isbutton:Isbutton!
            , IsCalllog: IsCalllog!
            , RequestID: RequestID!
            , SoMPOS: 0
        )
      }
}
