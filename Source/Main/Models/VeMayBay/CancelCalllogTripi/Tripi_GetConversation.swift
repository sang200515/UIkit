//
//  Tripi_GetConversation.swift
//  fptshop
//
//  Created by DiemMy Le on 1/10/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"DocEntry": 54,
//"bookingId": 1763940,
//"outboundPnrCode": "FAKE-6578",  //đi
//"inboundPnrCode": null,          //về
//"gender": "Nam",
//"fullName": "ngo dang tan",
//"email": "ngodangtan1994@gmail.com",
//"phone": "0901855436",
//"Conversation": "Nhập lí do khách muốn hủy vé."

import UIKit
import SwiftyJSON

class Tripi_GetConversation: NSObject {

    let DocEntry: Int
    let bookingId: Int
    let outboundPnrCode: String
    let inboundPnrCode: String
    let gender: String
    let fullName: String
    let email: String
    let phone: String
    let Conversation: String
    
    init(DocEntry: Int, bookingId: Int, outboundPnrCode: String, inboundPnrCode: String, gender: String, fullName: String, email: String, phone: String, Conversation: String) {
        
        self.DocEntry = DocEntry
        self.bookingId = bookingId
        self.outboundPnrCode = outboundPnrCode
        self.inboundPnrCode = inboundPnrCode
        self.gender = gender
        self.fullName = fullName
        self.email = email
        self.phone = phone
        self.Conversation = Conversation
    }
    
    class func parseObjfromArray(array:[JSON])->[Tripi_GetConversation]{
        var list:[Tripi_GetConversation] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> Tripi_GetConversation {
        var DocEntry = data["DocEntry"].int
        var bookingId = data["bookingId"].int
        var outboundPnrCode = data["outboundPnrCode"].string
        var inboundPnrCode = data["inboundPnrCode"].string
        var gender = data["gender"].string
        var fullName = data["fullName"].string
        var email = data["email"].string
        var phone = data["phone"].string
        var Conversation = data["Conversation"].string
        
        DocEntry = DocEntry == nil ? 0 : DocEntry
        bookingId = bookingId == nil ? 0 : bookingId
        outboundPnrCode = outboundPnrCode == nil ? "" : outboundPnrCode
        inboundPnrCode = inboundPnrCode == nil ? "" : inboundPnrCode
        gender = gender == nil ? "" : gender
        fullName = fullName == nil ? "" : fullName
        email = email == nil ? "" : email
        phone = phone == nil ? "" : phone
        Conversation = Conversation == nil ? "" : Conversation
        
        return Tripi_GetConversation(DocEntry: DocEntry!, bookingId: bookingId!, outboundPnrCode: outboundPnrCode!, inboundPnrCode: inboundPnrCode!, gender: gender!, fullName: fullName!, email: email!, phone: phone!, Conversation: Conversation!)
    }
}
