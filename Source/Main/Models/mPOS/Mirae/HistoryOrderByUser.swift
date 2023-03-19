//
//  HistoryOrderByUser.swift
//  fptshop
//
//  Created by tan on 6/6/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class HistoryOrderByUser: NSObject {
    var Docentry:Int
    var SoMPOS:Int
    var SOPOS:Int
    var Ngay:String
    var FullName:String
    var IDCard:String
    var reason_cance_messagess:String
    var TTDH:String
    var TTHS:String
    var PhoneNumber:String
    var TTbuttonHT:Int
    var TTbuttonHuy:Int
    var processId_Mirae:String
    var Imei:String
    var ContractNumber:String
    var linePromos: [LinePromotionMirae]
    var lineProduct: [LineProductMirae]
    var RequestID:Int
    var ApprovedCall:String
    var partnerId: String
    var ParticipationFee: Float
    init(Docentry:Int
    , SoMPOS:Int
    , SOPOS:Int
    , Ngay:String
    , FullName:String
    , IDCard:String
    , reason_cance_messagess:String
    , TTDH:String
    , TTHS:String
    , PhoneNumber:String
    , TTbuttonHT:Int
    , TTbuttonHuy:Int
    , processId_Mirae:String
    , Imei:String
        ,ContractNumber:String
        ,linePromos:[LinePromotionMirae]
        ,lineProduct:[LineProductMirae]
    ,  RequestID:Int
    , ApprovedCall:String
         ,partnerId: String
         ,ParticipationFee:Float){
        self.Docentry = Docentry
        self.SoMPOS = SoMPOS
        self.SOPOS = SOPOS
        self.Ngay = Ngay
        self.FullName = FullName
        self.IDCard = IDCard
        self.reason_cance_messagess = reason_cance_messagess
        self.TTDH = TTDH
        self.TTHS = TTHS
        self.PhoneNumber = PhoneNumber
        self.TTbuttonHT = TTbuttonHT
        self.TTbuttonHuy = TTbuttonHuy
        self.processId_Mirae = processId_Mirae
        self.Imei = Imei
        self.ContractNumber = ContractNumber
        self.linePromos = linePromos
        self.lineProduct = lineProduct
        self.RequestID = RequestID
        self.ApprovedCall = ApprovedCall
        self.partnerId = partnerId
        self.ParticipationFee = ParticipationFee
    }
    
    class func parseObjfromArray(array:[JSON])->[HistoryOrderByUser]{
        var list:[HistoryOrderByUser] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> HistoryOrderByUser{
        
        var Docentry = data["Docentry"].int
        var SoMPOS = data["SoMPOS"].int
        var SOPOS = data["SOPOS"].int
        var Ngay = data["Ngay"].string
        var FullName = data["FullName"].string
        var IDCard = data["IDCard"].string
        var reason_cance_messagess = data["reason_cance_messagess"].string
        var TTDH = data["TTDH"].string
        var TTHS = data["TTHS"].string
        var PhoneNumber = data["PhoneNumber"].string
        var TTbuttonHT = data["TTbuttonHT"].int
        var TTbuttonHuy = data["TTbuttonHuy"].int
        var processId_Mirae = data["processId_Mirae"].string
        var Imei = data["Imei"].string
        var ContractNumber = data["ContractNumber"].string
        var RequestID = data["RequestID"].int
        var ApprovedCall = data["ApprovedCall"].string
        let partnerId = data["partnerId"].stringValue
        let ParticipationFee = data["ParticipationFee"].floatValue
        Docentry = Docentry == nil ? 0 : Docentry
        SoMPOS = SoMPOS == nil ? 0 : SoMPOS
        SOPOS = SOPOS == nil ? 0 : SOPOS
        Ngay = Ngay == nil ? "" : Ngay
          FullName = FullName == nil ? "" : FullName
           IDCard = IDCard == nil ? "" : IDCard
            reason_cance_messagess = reason_cance_messagess == nil ? "" : reason_cance_messagess
          TTDH = TTDH == nil ? "" : TTDH
            TTHS = TTHS == nil ? "" : TTHS
          PhoneNumber = PhoneNumber == nil ? "" : PhoneNumber
           TTbuttonHT = TTbuttonHT == nil ? 0 : TTbuttonHT
          TTbuttonHuy = TTbuttonHuy == nil ? 0 : TTbuttonHuy
           processId_Mirae = processId_Mirae == nil ? "" : processId_Mirae
            Imei = Imei == nil ? "" : Imei
        ContractNumber = ContractNumber == nil ? "" : ContractNumber
        RequestID = RequestID == nil ? 0 : RequestID
        ApprovedCall = ApprovedCall == nil ? "" : ApprovedCall
        
        return HistoryOrderByUser(Docentry:Docentry!
            , SoMPOS:SoMPOS!
            , SOPOS:SOPOS!
            , Ngay:Ngay!
            , FullName:FullName!
            , IDCard:IDCard!
            , reason_cance_messagess:reason_cance_messagess!
            , TTDH:TTDH!
            , TTHS:TTHS!
            , PhoneNumber:PhoneNumber!
            , TTbuttonHT:TTbuttonHT!
            , TTbuttonHuy:TTbuttonHuy!
            , processId_Mirae:processId_Mirae!
            , Imei:Imei!
            , ContractNumber:ContractNumber!
            ,linePromos: []
            , lineProduct:[]
            ,RequestID:RequestID!
            ,ApprovedCall:ApprovedCall!
            ,partnerId:partnerId
            ,ParticipationFee: ParticipationFee)
    }
    
    
}
