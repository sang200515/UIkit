//
//  HoSoCanXuLy.swift
//  fptshop
//
//  Created by Ngo Dang tan on 10/24/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

//"Docentry": 6810,
//   "SoMPOS": 2931209,
//   "SOPOS": null,
//   "Ngay": "11:5 24/10/2019",
//   "FullName": "test hệ thống",
//   "IDCard": "241020191",
//   "reason_cance_messagess": "hs này cần được bổ sung chữ ký khách hàng, xem lại điều 10 tráng 5 nhé shop. nhanh chóng hoàn tất hs-",
//   "TTDH": "Chưa hoàn tất",
//   "TTHS": "Đã gửi sang mirae",
//   "PhoneNumber": "0909777555",
//   "TTbuttonHT": 0,
//   "TTbuttonHuy": 1,
//   "processId_Mirae": "204404",
//   "Imei": "358780106055648",
//   "ContractNumber": "204402"
import Foundation
import SwiftyJSON
class HoSoCanXuLy: NSObject{
    
    var Docentry:Int
    var SOPOS:String
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
    
    init(    Docentry:Int
     , SOPOS:String
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
     , ContractNumber:String){
        
        self.Docentry = Docentry
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
        
    }
    
    class func parseObjfromArray(array:[JSON])->[HoSoCanXuLy]{
        var list:[HoSoCanXuLy] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> HoSoCanXuLy {
         var Docentry = data["Docentry"].int
         var SOPOS = data["SOPOS"].string
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
         
         Docentry = Docentry == nil ? 0 : Docentry
         SOPOS = SOPOS == nil ? "" : SOPOS
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
        
         
         return HoSoCanXuLy(Docentry:Docentry!
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
         , ContractNumber:ContractNumber!)
    }
     
}
