//
//  ThongTinCongNo.swift
//  mPOS
//
//  Created by MinhDH on 4/6/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class ThongTinCongNo: NSObject {
    
    var DNSoTienKyHan: Double
    var Ky: String
    var NgayKyHan: String
    var TTThanhToan: String
    
    init(DNSoTienKyHan: Double, Ky: String, NgayKyHan: String, TTThanhToan: String){
        self.DNSoTienKyHan = DNSoTienKyHan
        self.Ky = Ky
        self.NgayKyHan = NgayKyHan
        self.TTThanhToan = TTThanhToan
    }
    class func parseObjfromArray(array:[JSON])->[ThongTinCongNo]{
        var list:[ThongTinCongNo] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ThongTinCongNo{
        
        var dnSoTienKyHan = data["DNSoTienKyHan"].double
        var ky = data["Ky"].string
        var ngayKyHan = data["NgayKyHan"].string
        var ttThanhToan = data["TTThanhToan"].string
        
        dnSoTienKyHan = dnSoTienKyHan == nil ? 0 : dnSoTienKyHan
        ky = ky == nil ? "" : ky
        ngayKyHan = ngayKyHan == nil ? "" : ngayKyHan
        ttThanhToan = ttThanhToan == nil ? "" : ttThanhToan
        
        return ThongTinCongNo(DNSoTienKyHan: dnSoTienKyHan!, Ky: ky!, NgayKyHan: ngayKyHan!, TTThanhToan: ttThanhToan!)
    }
}
