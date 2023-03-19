//
//  ThongTinSSD.swift
//  mPOS
//
//  Created by MinhDH on 4/25/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class ThongTinSSD: NSObject {
    
    var SoTien1Nam: Float
    var SoTien1NamSub: Float
    var SoTien1NamText: String
    var SoTien1NamTextSub: String
    var Tong1namchitieu: Float
    var Tong1namssd: Float
    var TongChenhLech:String
    
    init(SoTien1Nam: Float, SoTien1NamSub: Float, SoTien1NamText: String, SoTien1NamTextSub: String, Tong1namchitieu: Float, Tong1namssd: Float,TongChenhLech:String){
        self.SoTien1Nam = SoTien1Nam
        self.SoTien1NamSub = SoTien1NamSub
        self.SoTien1NamText = SoTien1NamText
        self.SoTien1NamTextSub = SoTien1NamTextSub
        self.Tong1namchitieu = Tong1namchitieu
        self.Tong1namssd = Tong1namssd
        self.TongChenhLech = TongChenhLech
    }
    class func parseObjfromArray(array:[JSON])->[ThongTinSSD]{
        var list:[ThongTinSSD] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ThongTinSSD{
        
        var soTien1Nam = data["SoTien1Nam"].float
        var soTien1NamSub = data["SoTien1NamSub"].float
        var soTien1NamText = data["SoTien1NamText"].string
        var soTien1NamTextSub = data["SoTien1NamTextSub"].string
        var tong1namchitieu = data["Tong1namchitieu"].float
        var tong1namssd = data["Tong1namssd"].float
        var tongChenhLech = data["TongChenhLech"].string
        
        
        soTien1Nam = soTien1Nam == nil ? 0 : soTien1Nam
        soTien1NamSub = soTien1NamSub == nil ? 0 : soTien1NamSub
        soTien1NamText = soTien1NamText == nil ? "" : soTien1NamText
        soTien1NamTextSub = soTien1NamTextSub == nil ? "" : soTien1NamTextSub
        tong1namchitieu = tong1namchitieu == nil ? 0 : tong1namchitieu
        tong1namssd = tong1namssd == nil ? 0 : tong1namssd
        tongChenhLech = tongChenhLech == nil ? "" : tongChenhLech
        
        return ThongTinSSD(SoTien1Nam: soTien1Nam!, SoTien1NamSub: soTien1NamSub!, SoTien1NamText: soTien1NamText!, SoTien1NamTextSub: soTien1NamTextSub!, Tong1namchitieu: tong1namchitieu!, Tong1namssd: tong1namssd!,TongChenhLech:tongChenhLech!)
    }
}
