//
//  InfoCmndVNPT.swift
//  fptshop
//
//  Created by Ngo Dang tan on 11/29/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"p_status": 1,
//"p_messagess": "Đã phép mua hàng",
//"HoTen_boss": "Trịnh Duy Nhân",
//"Chucvu_boss": "Giám đốc",
//"SDT_boss": "0947826999",
//"Emai_boss": "nhantd.tha@vnpt.vn",
//"DonVi": "PBH Bá Thước",
//"TenKH": "Phạm Trung Kiên",
//"CMND": "164156657",
//"SDT": "0918682668",
//"ID_mpos": 1
import Foundation
import SwiftyJSON
class InfoCmndVNPT: NSObject {
    var p_status:Int
    var p_messagess:String
    var HoTen_boss:String
    var Chucvu_boss:String
    var SDT_boss:String
    var Emai_boss:String
    var DonVi:String
    var TenKH:String
    var CMND:String
    var SDT:String
    var ID_mpos:Int
    var Docentry:String
    
    init(    p_status:Int
     , p_messagess:String
     , HoTen_boss:String
     , Chucvu_boss:String
     , SDT_boss:String
     , Emai_boss:String
     , DonVi:String
     , TenKH:String
     , CMND:String
     , SDT:String
     , ID_mpos:Int
        ,Docentry:String){
        self.p_status = p_status
        self.p_messagess = p_messagess
        self.HoTen_boss = HoTen_boss
        self.Chucvu_boss = Chucvu_boss
        self.SDT_boss = SDT_boss
        self.Emai_boss = Emai_boss
        self.DonVi = DonVi
        self.TenKH = TenKH
        self.CMND = CMND
        self.SDT = SDT
        self.ID_mpos = ID_mpos
        self.Docentry = Docentry
    }
    
    class func parseObjfromArray(array:[JSON])->[InfoCmndVNPT]{
          var list:[InfoCmndVNPT] = []
          for item in array {
              list.append(self.getObjFromDictionary(data: item))
          }
          return list
      }
      
      class func getObjFromDictionary(data:JSON) -> InfoCmndVNPT{
          var p_status = data["p_status"].int
          var p_messagess = data["p_messagess"].string
          var HoTen_boss = data["HoTen_boss"].string
          var Chucvu_boss = data["Chucvu_boss"].string
          var SDT_boss = data["SDT_boss"].string
        var Emai_boss = data["Emai_boss"].string
            var DonVi = data["DonVi"].string
          
            var TenKH = data["TenKH"].string
            var CMND = data["CMND"].string
        var SDT = data["SDT"].string
        var ID_mpos = data["ID_mpos"].int
      
          
          p_status = p_status == nil ? 0 : p_status
          p_messagess = p_messagess == nil ? "" : p_messagess
          HoTen_boss = HoTen_boss == nil ? "" : HoTen_boss
          Chucvu_boss = Chucvu_boss == nil ? "" : Chucvu_boss
          SDT_boss = SDT_boss == nil ? "" : SDT_boss
        Emai_boss = Emai_boss == nil ? "" : Emai_boss
        DonVi = DonVi == nil ? "" : DonVi
        TenKH = TenKH == nil ? "" : TenKH
        CMND = CMND == nil ? "" : CMND
        SDT = SDT == nil ? "" : SDT
    ID_mpos = ID_mpos == nil ? 0 : ID_mpos
          return InfoCmndVNPT(
         p_status:p_status!
              , p_messagess:p_messagess!
              , HoTen_boss:HoTen_boss!
              , Chucvu_boss:Chucvu_boss!
              , SDT_boss:SDT_boss!
              , Emai_boss:Emai_boss!
              , DonVi:DonVi!
              , TenKH:TenKH!
              , CMND:CMND!
              , SDT:SDT!
              , ID_mpos:ID_mpos!
            ,Docentry:""
          )
      }
}
