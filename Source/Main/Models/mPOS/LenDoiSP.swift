//
//  LenDoiSP.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 4/1/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class LenDoiSP:NSObject{
    
    var Cty:String
    var LaiSuatPhang:String
    var LaiSuatThuc:String
    var TienTraTruoc:Int
    
    var PhanTramTraTruoc:Int
    var SoThangTra:String
    var TenGoi:String
    var GiayToCanCo:String
    
    var PhiThuHo:Int
    var PhiBaoHiem:String
    var TongTienBaoHiem:Int
    var TienBHMoiThang:Int
    
    var PhanTramBaoHiem:Int
    var HeSoLaiSuat:Double
    var GopMoiThang:Int
    var TongTienTra:Int
    
    var TienChenhLech:Int
    var Flag:Int
    var GiaSauKhuyenMai:Int
    var GiaMuaTraThang:Int
    var GiaMuaTraGop:Int
    var TongChiPhi:Int
    
    
    init(Cty:String, LaiSuatPhang:String, LaiSuatThuc:String, TienTraTruoc:Int, PhanTramTraTruoc:Int, SoThangTra:String, TenGoi:String, GiayToCanCo:String, PhiThuHo:Int, PhiBaoHiem:String, TongTienBaoHiem:Int, TienBHMoiThang:Int, PhanTramBaoHiem:Int, HeSoLaiSuat:Double, GopMoiThang:Int, TongTienTra:Int, TienChenhLech:Int, Flag:Int, GiaSauKhuyenMai:Int, GiaMuaTraThang:Int, GiaMuaTraGop:Int,TongChiPhi:Int){
        self.Cty = Cty
        self.LaiSuatPhang = LaiSuatPhang
        self.LaiSuatThuc = LaiSuatThuc
        self.TienTraTruoc = TienTraTruoc
        
        self.PhanTramTraTruoc = PhanTramTraTruoc
        self.SoThangTra = SoThangTra
        self.TenGoi = TenGoi
        self.GiayToCanCo = GiayToCanCo
        
        self.PhiThuHo = PhiThuHo
        self.PhiBaoHiem = PhiBaoHiem
        self.TongTienBaoHiem = TongTienBaoHiem
        self.TienBHMoiThang = TienBHMoiThang
        
        self.PhanTramBaoHiem = PhanTramBaoHiem
        self.HeSoLaiSuat = HeSoLaiSuat
        self.GopMoiThang = GopMoiThang
        self.TongTienTra = TongTienTra
        
        self.TienChenhLech = TienChenhLech
        self.Flag = Flag
        self.GiaSauKhuyenMai = GiaSauKhuyenMai
        self.GiaMuaTraThang = GiaMuaTraThang
        self.GiaMuaTraGop = GiaMuaTraGop
        self.TongChiPhi = TongChiPhi
    }
    
    class func parseObjfromArray(array:[JSON])->[LenDoiSP]{
        var list:[LenDoiSP] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> LenDoiSP{
        var Cty = data["Cty"].string
        var LaiSuatPhang = data["LaiSuatPhang"].string
        var LaiSuatThuc = data["LaiSuatThuc"].string
        var TienTraTruoc = data["TienTraTruoc"].int
        
        Cty = Cty == nil ? "" : Cty
        LaiSuatPhang = LaiSuatPhang == nil ? "" : LaiSuatPhang
        LaiSuatThuc = LaiSuatThuc == nil ? "" : LaiSuatThuc
        TienTraTruoc = TienTraTruoc == nil ? 0 : TienTraTruoc
        
        var PhanTramTraTruoc = data["PhanTramTraTruoc"].int
        var SoThangTra = data["SoThangTra"].string
        var TenGoi = data["TenGoi"].string
        var GiayToCanCo = data["GiayToCanCo"].string
    
        PhanTramTraTruoc = PhanTramTraTruoc == nil ? 0 : PhanTramTraTruoc
        SoThangTra = SoThangTra == nil ? "" : SoThangTra
        TenGoi = TenGoi == nil ? "" : TenGoi
        GiayToCanCo = GiayToCanCo == nil ? "" : GiayToCanCo
        
        
        var PhiThuHo = data["PhiThuHo"].int
        var PhiBaoHiem = data["PhiBaoHiem"].string
        var TongTienBaoHiem = data["TongTienBaoHiem"].int
        var TienBHMoiThang = data["TienBHMoiThang"].int
        
        PhiThuHo = PhiThuHo == nil ? 0 : PhiThuHo
        PhiBaoHiem = PhiBaoHiem == nil ? "" : PhiBaoHiem
        TongTienBaoHiem = TongTienBaoHiem == nil ? 0 : TongTienBaoHiem
        TienBHMoiThang = TienBHMoiThang == nil ? 0 : TienBHMoiThang
        
        var PhanTramBaoHiem = data["PhanTramBaoHiem"].int
        var HeSoLaiSuat = data["HeSoLaiSuat"].double
        var GopMoiThang = data["GopMoiThang"].int
        var TongTienTra = data["TongTienTra"].int
        
        PhanTramBaoHiem = PhanTramBaoHiem == nil ? 0 : PhanTramBaoHiem
        HeSoLaiSuat = HeSoLaiSuat == nil ? 0 : HeSoLaiSuat
        GopMoiThang = GopMoiThang == nil ? 0 : GopMoiThang
        TongTienTra = TongTienTra == nil ? 0 : TongTienTra
        
        var TienChenhLech = data["TienChenhLech"].int
        var Flag = data["Flag"].int
        var GiaSauKhuyenMai = data["GiaSauKhuyenMai"].int
        var GiaMuaTraThang = data["GiaMuaTraThang"].int
         var GiaMuaTraGop = data["GiaMuaTraGop"].int
        var TongChiPhi = data["TongChiPhi"].int
        
        TienChenhLech = TienChenhLech == nil ? 0 : TienChenhLech
        Flag = Flag == nil ? 0 : Flag
        GiaSauKhuyenMai = GiaSauKhuyenMai == nil ? 0 : GiaSauKhuyenMai
        GiaMuaTraThang = GiaMuaTraThang == nil ? 0 : GiaMuaTraThang
         GiaMuaTraGop = GiaMuaTraGop == nil ? 0 : GiaMuaTraGop
        TongChiPhi = TongChiPhi == nil ? 0 : TongChiPhi
        
        return LenDoiSP(Cty:Cty!, LaiSuatPhang:LaiSuatPhang!, LaiSuatThuc:LaiSuatThuc!, TienTraTruoc:TienTraTruoc!, PhanTramTraTruoc:PhanTramTraTruoc!, SoThangTra:SoThangTra!, TenGoi:TenGoi!, GiayToCanCo:GiayToCanCo!, PhiThuHo:PhiThuHo!, PhiBaoHiem:PhiBaoHiem!, TongTienBaoHiem:TongTienBaoHiem!, TienBHMoiThang:TienBHMoiThang!, PhanTramBaoHiem:PhanTramBaoHiem!, HeSoLaiSuat:HeSoLaiSuat!, GopMoiThang:GopMoiThang!, TongTienTra:TongTienTra!, TienChenhLech:TienChenhLech!, Flag:Flag!, GiaSauKhuyenMai:GiaSauKhuyenMai!, GiaMuaTraThang:GiaMuaTraThang!, GiaMuaTraGop:GiaMuaTraGop!,TongChiPhi:TongChiPhi!)
    }
}
