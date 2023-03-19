//
//  SOPhoneNumberHeader.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SOPhoneNumberHeader:NSObject{
    
    var DocEntry:Int
    var SO_POS:Int
    var DocType:String
    var LicTradNum:String
    var CardName:String
    var Mail:String
    var Address:String
    var Birthday:String
    var NumberContract:String
    var gender:Int
    var period:Int
    var IdentityCard:String
    var IDFinancier:String
    var EcomNum:Int
    var LaiSuat:Float
    var SoTienTraTruoc:Int
    var SDT_SSD:String
    
    
    init(DocEntry:Int, SO_POS:Int, DocType:String, LicTradNum:String, CardName:String, Mail:String, Address:String, Birthday:String, NumberContract:String, gender:Int, period:Int, IdentityCard:String, IDFinancier:String, EcomNum:Int, LaiSuat:Float, SoTienTraTruoc:Int, SDT_SSD:String){
        self.DocEntry = DocEntry
        self.SO_POS = SO_POS
        self.DocType = DocType
        self.LicTradNum = LicTradNum
        self.CardName = CardName
        self.Mail = Mail
        self.Address = Address
        self.Birthday = Birthday
        self.NumberContract = NumberContract
        self.gender = gender
        self.period = period
        self.IdentityCard = IdentityCard
        self.IDFinancier = IDFinancier
        self.EcomNum = EcomNum
        self.LaiSuat = LaiSuat
        self.SoTienTraTruoc = SoTienTraTruoc
        self.SDT_SSD = SDT_SSD
    }

    class func parseObjfromArray(array:[JSON])->[SOPhoneNumberHeader]{
        var list:[SOPhoneNumberHeader] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    class func getObjFromDictionary(data:JSON) -> SOPhoneNumberHeader{
        var DocEntry = data["DocEntry"].int
        var SO_POS = data["SO_POS"].int
        var DocType = data["DocType"].string
        var LicTradNum = data["LicTradNum"].string
        var CardName = data["CardName"].string
        var Mail = data["Mail"].string
        
        var Address = data["Address"].string
        var Birthday = data["Birthday"].string
        
        var NumberContract = data["NumberContract"].string
        var gender = data["gender"].int
        var period = data["period"].int
        var IdentityCard = data["IdentityCard"].string
        var IDFinancier = data["IDFinancier"].string
        
        var EcomNum = data["EcomNum"].int
        var LaiSuat = data["LaiSuat"].float
        var SoTienTraTruoc = data["SoTienTraTruoc"].int
        var SDT_SSD = data["SDT_SSD"].string
        
        DocEntry = DocEntry == nil ? 0 : DocEntry
        SO_POS = SO_POS == nil ? 0 : SO_POS
        DocType = DocType == nil ? "" : DocType
        LicTradNum = LicTradNum == nil ? "" : LicTradNum
        CardName = CardName == nil ? "" : CardName
        Mail = Mail == nil ? "" : Mail
        Address = Address == nil ? "" : Address
        Birthday = Birthday == nil ? "1970-01-01T00:00:00" : Birthday
        NumberContract = NumberContract == nil ? "" : NumberContract
        gender = gender == nil ? 0 : gender
        period = period == nil ? 0 : period
        IdentityCard = IdentityCard == nil ? "" : IdentityCard
        IDFinancier = IDFinancier == nil ? "" : IDFinancier
        EcomNum = EcomNum == nil ? 0 : EcomNum
        
        LaiSuat = LaiSuat == nil ? 0 : LaiSuat
        
        SoTienTraTruoc = SoTienTraTruoc == nil ? 0 : SoTienTraTruoc
        Birthday = formatDate(date: Birthday!)
        SDT_SSD = SDT_SSD == nil ? "" : SDT_SSD
        return SOPhoneNumberHeader(DocEntry:DocEntry!, SO_POS:SO_POS!, DocType:DocType!, LicTradNum:LicTradNum!, CardName:CardName!, Mail:Mail!, Address:Address!, Birthday:Birthday!, NumberContract:NumberContract!, gender:gender!, period:period!, IdentityCard:IdentityCard!, IDFinancier:IDFinancier!, EcomNum:EcomNum!, LaiSuat:LaiSuat!, SoTienTraTruoc:SoTienTraTruoc!, SDT_SSD:SDT_SSD!
        )
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
