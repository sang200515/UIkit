//
//  HistoryOrderByID.swift
//  fptshop
//
//  Created by tan on 6/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class HistoryOrderByID: NSObject {
    
    var PhoneNumber:String
    var IDCard:String
    var FullName:String
    var Docentry:Int
    var processId_Mirae:String
    var activityId_Mirae:String
    var P_Address:String
    var schemecode:String
    var SchemName:String
    var laisuat:Float
    var TongTienThanhToan:Float
    var DownPaymentAmount:Float
    var LoanAmount:Float
    var TenureOfLoan:Int
    var interestrate:Float
    var protectionfee:Float
    var discount_amount:Float
    var doctal_before_discount:Float
    var soDetail:[SODetailMirae] = []
    var Sotienchenhlech:Float
    var is_SMS:Int
    var ParticipationFee: Float
    init(PhoneNumber:String
        ,IDCard:String
    , FullName:String
    , Docentry:Int
    , processId_Mirae:String
    , activityId_Mirae:String
    , P_Address:String
    , schemecode:String
    , SchemName:String
    , laisuat:Float
    , TongTienThanhToan:Float
    , DownPaymentAmount:Float
    , LoanAmount:Float
    , TenureOfLoan:Int
    , interestrate:Float
    , protectionfee:Float
    , discount_amount:Float
    , doctal_before_discount:Float
        ,soDetail:[SODetailMirae]
    ,Sotienchenhlech:Float
         ,is_SMS:Int,ParticipationFee: Float){
        self.PhoneNumber = PhoneNumber
        self.IDCard = IDCard
        self.FullName = FullName
        self.Docentry = Docentry
        self.processId_Mirae = processId_Mirae
        self.activityId_Mirae = activityId_Mirae
        self.P_Address = P_Address
        self.schemecode = schemecode
        self.SchemName = SchemName
        self.laisuat = laisuat
        self.TongTienThanhToan = TongTienThanhToan
        self.DownPaymentAmount = DownPaymentAmount
        self.LoanAmount = LoanAmount
        self.TenureOfLoan = TenureOfLoan
        self.interestrate = interestrate
        self.protectionfee = protectionfee
        self.discount_amount = discount_amount
        self.doctal_before_discount = doctal_before_discount
        self.soDetail = soDetail
        self.Sotienchenhlech = Sotienchenhlech
        self.is_SMS = is_SMS
        self.ParticipationFee = ParticipationFee
    }
    
    
    class func parseObjfromArray(array:[JSON])->[HistoryOrderByID]{
        var list:[HistoryOrderByID] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> HistoryOrderByID{
        
        var PhoneNumber = data["PhoneNumber"].string
        var IDCard = data["IDCard"].string
        var FullName = data["FullName"].string
        var Docentry = data["Docentry"].int
        var processId_Mirae = data["processId_Mirae"].string
        var activityId_Mirae = data["activityId_Mirae"].string
        var P_Address = data["P_Address"].string
        
           var schemecode = data["schemecode"].string
        var SchemName = data["SchemName"].string
        var laisuat = data["laisuat"].float
        var TongTienThanhToan = data["TongTienThanhToan"].float
        var DownPaymentAmount = data["DownPaymentAmount"].float
        var LoanAmount = data["LoanAmount"].float
        var TenureOfLoan = data["TenureOfLoan"].int
        var interestrate = data["interestrate"].float
        var protectionfee = data["protectionfee"].float
        var discount_amount = data["discount_amount"].float
        var doctal_before_discount = data["doctal_before_discount"].float
        var Sotienchenhlech = data["Sotienchenhlech"].float
        var ParticipationFee = data["ParticipationFee"].float
        var is_SMS = data["is_SMS"].int
        PhoneNumber = PhoneNumber == nil ? "" : PhoneNumber
        IDCard = IDCard == nil ? "" : IDCard
        FullName = FullName == nil ? "" : FullName
        Docentry = Docentry == nil ? 0 : Docentry
        processId_Mirae = processId_Mirae == nil ? "" : processId_Mirae
        activityId_Mirae = activityId_Mirae == nil ? "" : activityId_Mirae
        P_Address = P_Address == nil ? "" : P_Address
        
        schemecode = schemecode == nil ? "" : schemecode
           SchemName = SchemName == nil ? "" : SchemName
           laisuat = laisuat == nil ? 0 : laisuat
           TongTienThanhToan = TongTienThanhToan == nil ? 0 : TongTienThanhToan
           DownPaymentAmount = DownPaymentAmount == nil ? 0 : DownPaymentAmount
           LoanAmount = LoanAmount == nil ? 0 : LoanAmount
        TenureOfLoan = TenureOfLoan == nil ? 0 : TenureOfLoan
        interestrate = interestrate == nil ? 0 : interestrate
        protectionfee = protectionfee == nil ? 0 : protectionfee
        discount_amount = discount_amount == nil ? 0 : discount_amount
        doctal_before_discount = doctal_before_discount == nil ? 0 : doctal_before_discount
        Sotienchenhlech = Sotienchenhlech == nil ? 0 : Sotienchenhlech
        ParticipationFee = ParticipationFee == nil ? 0 : ParticipationFee
        is_SMS = is_SMS == nil ? 0 : is_SMS
        return HistoryOrderByID( PhoneNumber:PhoneNumber!
            , IDCard:IDCard!
            , FullName:FullName!
            , Docentry:Docentry!
            , processId_Mirae:processId_Mirae!
            , activityId_Mirae:activityId_Mirae!
            , P_Address:P_Address!
            ,schemecode:schemecode!
            ,SchemName:SchemName!
            ,laisuat:laisuat!
            ,TongTienThanhToan:TongTienThanhToan!
            ,DownPaymentAmount:DownPaymentAmount!
            ,LoanAmount:LoanAmount!
            ,TenureOfLoan:TenureOfLoan!
            ,interestrate:interestrate!
            ,protectionfee:protectionfee!
            ,discount_amount:discount_amount!
            ,doctal_before_discount:doctal_before_discount!
            ,soDetail:[]
            ,Sotienchenhlech:Sotienchenhlech!
            ,is_SMS:is_SMS!
            ,ParticipationFee: ParticipationFee!
        )
    }
    
    
}
