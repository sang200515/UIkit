//
//  SoSanhGoiSSD.swift
//  mPOS
//
//  Created by Duong Hoang Minh on 11/27/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class SoSanhGoiSSD: NSObject {
    
    var Goicuoc: String
    var GiaMay: String
    var Trogia: String
    var Tiencuocnam: String
    var TongChi: String
    var Datangay: String
    var Datathang: String
    var Thoainoimang: String
    var Thoaingoaimang: String
    var SMS: String
    var Sotienphaichi: Double
    
    init(Goicuoc: String, GiaMay: String, Trogia: String, Tiencuocnam: String, TongChi: String, Datangay: String, Datathang: String, Thoainoimang: String, Thoaingoaimang: String, SMS: String, Sotienphaichi: Double){
        self.Goicuoc = Goicuoc
        self.GiaMay = GiaMay
        self.Trogia = Trogia
        self.Tiencuocnam = Tiencuocnam
        self.TongChi = TongChi
        self.Datangay = Datangay
        self.Datathang = Datathang
        self.Thoainoimang = Thoainoimang
        self.Thoaingoaimang = Thoaingoaimang
        self.SMS = SMS
        self.Sotienphaichi = Sotienphaichi
    }
    class func parseObjfromArray(array:[JSON])->[SoSanhGoiSSD]{
        var list:[SoSanhGoiSSD] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> SoSanhGoiSSD{
        
        var Goicuoc = data["Goicuoc"].string
        var GiaMay = data["GiaMay"].string
        var Trogia = data["Trogia"].string
        var Tiencuocnam = data["Tiencuocnam"].string
        var TongChi = data["TongChi"].string
        var Datangay = data["Datangay"].string
        var Datathang = data["Datathang"].string
        var Thoainoimang = data["Thoainoimang"].string
        var Thoaingoaimang = data["Thoaingoaimang"].string
        var SMS = data["SMS"].string
        var Sotienphaichi = data["Sotienphaichi"].double
        
        Goicuoc = Goicuoc == nil ? "N/A" : Goicuoc
        GiaMay = GiaMay == nil ? "N/A" : GiaMay
        Trogia = Trogia == nil ? "N/A" : Trogia
        Tiencuocnam = Tiencuocnam == nil ? "N/A" : Tiencuocnam
        TongChi = TongChi == nil ? "N/A" : TongChi
        Datangay = Datangay == nil ? "N/A" : Datangay
        Datathang = Datathang == nil ? "N/A" : Datathang
        Thoainoimang = Thoainoimang == nil ? "N/A" : Thoainoimang
        Thoaingoaimang = Thoaingoaimang == nil ? "N/A" : Thoaingoaimang
        SMS = SMS == nil ? "N/A" : SMS
        Sotienphaichi = Sotienphaichi == nil ? 0 : Sotienphaichi
        
        return SoSanhGoiSSD(Goicuoc: Goicuoc!, GiaMay: GiaMay!, Trogia: Trogia!, Tiencuocnam: Tiencuocnam!, TongChi: TongChi!, Datangay: Datangay!, Datathang: Datathang!, Thoainoimang: Thoainoimang!, Thoaingoaimang: Thoaingoaimang!, SMS: SMS!, Sotienphaichi: Sotienphaichi!)
    }
}

