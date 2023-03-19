//
//  ThongTuVanComboPK.swift
//  fptshop
//
//  Created by tan on 3/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class ThongTuVanComboPK: NSObject {
    var GiaNhap:Int
    var ThanhTienMuaThem:Int
    var ThanhTienTruocKM:Int
    var ThanhTienSauKM:Int
    var SoTienTraThem:Int
    var PTGiamGia:String
    var DiemThuong:String
    
    init( GiaNhap:Int
        , ThanhTienMuaThem:Int
        , ThanhTienTruocKM:Int
        , ThanhTienSauKM:Int
        , SoTienTraThem:Int
        , PTGiamGia:String
        , DiemThuong:String){
        self.GiaNhap = GiaNhap
        self.ThanhTienMuaThem = ThanhTienMuaThem
        self.ThanhTienTruocKM = ThanhTienTruocKM
        self.ThanhTienSauKM = ThanhTienSauKM
        self.SoTienTraThem = SoTienTraThem
        self.PTGiamGia = PTGiamGia
        self.DiemThuong = DiemThuong
    }
    
    class func parseObjfromArray(array:[JSON])->[ThongTuVanComboPK]{
        var list:[ThongTuVanComboPK] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> ThongTuVanComboPK{
        
        var GiaNhap = data["GiaNhap"].int
        var ThanhTienMuaThem = data["ThanhTienMuaThem"].int
        var ThanhTienTruocKM  = data["ThanhTienTruocKM"].int
        var ThanhTienSauKM = data["ThanhTienSauKM"].int
        var SoTienTraThem = data["SoTienTraThem"].int
        var PTGiamGia = data["PTGiamGia"].string
        var DiemThuong = data["DiemThuong"].string
        
        
        GiaNhap = GiaNhap == nil ? 0 : GiaNhap
        ThanhTienMuaThem = ThanhTienMuaThem == nil ? 0 : ThanhTienMuaThem
        ThanhTienTruocKM = ThanhTienTruocKM == nil ? 0 :ThanhTienTruocKM
        ThanhTienSauKM = ThanhTienSauKM == nil ? 0 : ThanhTienSauKM
        SoTienTraThem = SoTienTraThem == nil ? 0 : SoTienTraThem
        PTGiamGia = PTGiamGia == nil ? "" : PTGiamGia
        DiemThuong = DiemThuong == nil ? "" : DiemThuong
        
        
        return ThongTuVanComboPK(GiaNhap: GiaNhap!, ThanhTienMuaThem: ThanhTienMuaThem!,ThanhTienTruocKM:ThanhTienTruocKM!,ThanhTienSauKM:ThanhTienSauKM!
            ,SoTienTraThem:SoTienTraThem!,PTGiamGia:PTGiamGia!,DiemThuong:DiemThuong!
        )
    }
    
}
