//
//  UrlImageRP.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/18/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class UrlImageRP: NSObject {
    var anh_trai_dt:String
    var anh_phai_dt:String
    var anh_tray_xuoc:String
    var anh_chan_dung:String
    var anh_bien_ban:String
    var anh_niem_phong:String
    var CMND_mattruoc:String
    var CMND_matsau:String
    
    init(     anh_trai_dt:String
    , anh_phai_dt:String
    , anh_tray_xuoc:String
    , anh_chan_dung:String
    , anh_bien_ban:String
    , anh_niem_phong:String
    , CMND_mattruoc:String
    , CMND_matsau:String){
        self.anh_trai_dt = anh_trai_dt
        self.anh_phai_dt = anh_phai_dt
        self.anh_tray_xuoc = anh_tray_xuoc
        self.anh_chan_dung = anh_chan_dung
        self.anh_bien_ban = anh_bien_ban
        self.anh_niem_phong = anh_niem_phong
        self.CMND_mattruoc = CMND_mattruoc
        self.CMND_matsau = CMND_mattruoc
    }
    
    class func parseObjfromArray(array:[JSON])->[UrlImageRP]{
         var list:[UrlImageRP] = []
         for item in array {
             list.append(self.getObjFromDictionary(data: item))
         }
         return list
     }
     
     class func getObjFromDictionary(data:JSON) -> UrlImageRP{
         var anh_trai_dt = data["anh_trai_dt"].string
         var anh_phai_dt = data["anh_phai_dt"].string
         var anh_tray_xuoc = data["anh_tray_xuoc"].string
        
        var anh_chan_dung = data["anh_chan_dung"].string
        var anh_bien_ban = data["anh_bien_ban"].string
        var anh_niem_phong = data["anh_niem_phong"].string
        var CMND_mattruoc = data["CMND_mattruoc"].string
        var CMND_matsau = data["CMND_matsau"].string
         
         anh_trai_dt = anh_trai_dt == nil ? "" : anh_trai_dt
         anh_phai_dt = anh_phai_dt == nil ? "" : anh_phai_dt
         anh_tray_xuoc = anh_tray_xuoc == nil ? "" : anh_tray_xuoc
        
        anh_chan_dung = anh_chan_dung == nil ? "" : anh_chan_dung
        anh_bien_ban = anh_bien_ban == nil ? "" : anh_bien_ban
        anh_niem_phong = anh_niem_phong == nil ? "" : anh_niem_phong
        CMND_mattruoc = CMND_mattruoc == nil ? "" : CMND_mattruoc
        CMND_matsau = CMND_matsau == nil ? "" : CMND_matsau
         return UrlImageRP(anh_trai_dt:anh_trai_dt!
         , anh_phai_dt:anh_phai_dt!
         , anh_tray_xuoc:anh_tray_xuoc!
         , anh_chan_dung:anh_chan_dung!
         , anh_bien_ban:anh_bien_ban!
         , anh_niem_phong:anh_niem_phong!
         , CMND_mattruoc:CMND_mattruoc!
         , CMND_matsau:CMND_matsau!
         )
     }
}
