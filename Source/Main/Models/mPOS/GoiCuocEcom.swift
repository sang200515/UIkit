//
//  GoiCuocEcom.swift
//  fptshop
//
//  Created by tan on 2/21/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class GoiCuocEcom: NSObject {
    var Code:String
    var Name:String
    var Provider:String
    var Price:Int
    var Data:String
    var pCall:String
    var CallSMS:String
    var SMS:String
    var PromotionTime:String
    var OtherPromotion:String
    var PeriodPromotion:String
    var FeePack:String
    var SysTax:String
    var Note:String
    var Data1Home:String
    var Data1HomeDes:String
    var Data2Home:String
    var Data2HomeDes:String
    var CallInsideHome:String
    var CallInsideHomeDes:String
    var CallOutHome:String
    var CallOutsideHomeDes:String
    var SMSHome:String
    var SMSHomeDes:String
    var NoteHome:String
    var PackofData:String
    var OrderNo:Int
    var PackageType: Int
    
    init(   Code:String
            , Name:String
            , Provider:String
            , Price:Int
            , Data:String
            , pCall:String
            , CallSMS:String
            , SMS:String
            , PromotionTime:String
            , OtherPromotion:String
            , PeriodPromotion:String
            , FeePack:String
            , SysTax:String
            , Note:String
            , Data1Home:String
            , Data1HomeDes:String
            , Data2Home:String
            , Data2HomeDes:String
            , CallInsideHome:String
            , CallInsideHomeDes:String
            , CallOutHome:String
            , CallOutsideHomeDes:String
            , SMSHome:String
            , SMSHomeDes:String
            , NoteHome:String
            ,PackofData:String
            ,OrderNo:Int
            , PackageType:Int){
        self.Code = Code
        self.Name = Name
        self.Provider = Provider
        self.Price = Price
        self.Data = Data
        self.pCall = pCall
        self.CallSMS = CallSMS
        self.SMS = SMS
        self.PromotionTime = PromotionTime
        self.OtherPromotion = OtherPromotion
        self.PeriodPromotion = PeriodPromotion
        self.FeePack = FeePack
        self.SysTax = SysTax
        self.Note = Note
        self.Data1Home = Data1Home
        self.Data1HomeDes = Data1HomeDes
        self.Data2Home = Data2Home
        self.Data2HomeDes = Data2HomeDes
        self.CallInsideHome = CallInsideHome
        self.CallInsideHomeDes = CallInsideHomeDes
        self.CallOutHome = CallOutHome
        self.CallOutsideHomeDes = CallOutsideHomeDes
        self.SMSHome = SMSHome
        self.SMSHomeDes = SMSHomeDes
        self.NoteHome = NoteHome
        self.PackofData  = PackofData
        self.OrderNo = OrderNo
        self.PackageType = PackageType
    }
    class func parseObjfromArray(array:[JSON])->[GoiCuocEcom]{
        var list:[GoiCuocEcom] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> GoiCuocEcom{
        
        
        
        var Code = data["Code"].string
        var Name = data["Name"].string
        var Provider = data["Provider"].string
        var Price = data["Price"].int
        var Data = data["Data"].string
        var pCall = data["pCall"].string
        var CallSMS = data["CallSMS"].string
        var SMS = data["SMS"].string
        var PromotionTime = data["PromotionTime"].string
        var OtherPromotion = data["OtherPromotion"].string
        var PeriodPromotion = data["PeriodPromotion"].string
        var FeePack = data["FeePack"].string
        var SysTax = data["SysTax"].string
        var Note = data["Note"].string
        var Data1Home = data["Data1Home"].string
        var Data1HomeDes = data["Data1HomeDes"].string
        var Data2Home = data["Data2Home"].string
        var Data2HomeDes = data["Data2HomeDes"].string
        var CallInsideHome = data["CallInsideHome"].string
        var CallInsideHomeDes = data["CallInsideHomeDes"].string
        var CallOutHome = data["CallOutHome"].string
        var CallOutsideHomeDes = data["CallOutsideHomeDes"].string
        var SMSHome = data["SMSHome"].string
        var SMSHomeDes = data["SMSHomeDes"].string
        var NoteHome = data["NoteHome"].string
        var PackofData = data["PackofData"].string
        var OrderNo = data["OrderNo"].int
        var PackageType = data["PackageType"].int
        
        Code = Code == nil ? "" : Code
        Name = Name == nil ? "" : Name
        Provider = Provider == nil ? "" : Provider
        Price = Price == nil ? 0 : Price
        Data = Data == nil ? "" : Data
        pCall = pCall == nil ? "" : pCall
        CallSMS = CallSMS == nil ? "" : CallSMS
        SMS = SMS == nil ? "" : SMS
        PromotionTime = PromotionTime == nil ? "" : PromotionTime
        OtherPromotion = OtherPromotion == nil ? "" : OtherPromotion
        PeriodPromotion = PeriodPromotion == nil ? "" : PeriodPromotion
        FeePack = FeePack == nil ? "" : FeePack
        SysTax = SysTax == nil ? "" : SysTax
        Note = Note == nil ? "" : Note
        Data1Home = Data1Home == nil ? "" : Data1Home
        Data1HomeDes = Data1HomeDes == nil ? "" : Data1HomeDes
        Data2Home = Data2Home == nil ? "" : Data2Home
        Data2HomeDes = Data2HomeDes == nil ? "" : Data2HomeDes
        CallInsideHome = CallInsideHome == nil ? "" : CallInsideHome
        CallInsideHomeDes = CallInsideHomeDes == nil ? "" : CallInsideHomeDes
        CallOutHome = CallOutHome == nil ? "" : CallOutHome
        CallOutsideHomeDes = CallOutsideHomeDes == nil ? "" : CallOutsideHomeDes
        SMSHome = SMSHome == nil ? "" : SMSHome
        SMSHomeDes = SMSHomeDes == nil ? "" : SMSHomeDes
        NoteHome = NoteHome == nil ? "" : NoteHome
        PackofData = PackofData == nil ? "" : PackofData
        OrderNo = OrderNo == nil ? 0 : OrderNo
        PackageType = PackageType == nil ? 0 : PackageType
        
        return GoiCuocEcom(Code:Code!
                           , Name:Name!
                           , Provider:Provider!
                           , Price:Price!
                           , Data:Data!
                           , pCall:pCall!
                           , CallSMS:CallSMS!
                           , SMS:SMS!
                           , PromotionTime:PromotionTime!
                           , OtherPromotion:OtherPromotion!
                           , PeriodPromotion:PeriodPromotion!
                           , FeePack:FeePack!
                           , SysTax:SysTax!
                           , Note:Note!
                           , Data1Home:Data1Home!
                           , Data1HomeDes:Data1HomeDes!
                           , Data2Home:Data2Home!
                           , Data2HomeDes:Data2HomeDes!
                           , CallInsideHome:CallInsideHome!
                           , CallInsideHomeDes:CallInsideHomeDes!
                           , CallOutHome:CallOutHome!
                           , CallOutsideHomeDes:CallOutsideHomeDes!
                           , SMSHome:SMSHome!
                           , SMSHomeDes:SMSHomeDes!
                           , NoteHome: NoteHome!
                           , PackofData :PackofData!
                           ,OrderNo:OrderNo!
                           , PackageType:PackageType!)
    }
    
    
}
