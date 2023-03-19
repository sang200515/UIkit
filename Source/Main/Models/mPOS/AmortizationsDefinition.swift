//
//  AmortizationsDefinition.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class AmortizationsDefinition: NSObject {
    var CongTyDuyet: String
    var Flag: Int
    var GiayToCanCo: String
    var GopMoiThang: Float
    var HeSoLaiSuat: Float
    var LaiSuatPhang: Float
    var LaiSuatThuc: Float
    var PhanTramTraTruoc: Float
    var PhiBaoHiem: Float
    var PhiThuHo: Float
    var SoThangTra: String
    var TenGoi: String
    var TienChenhLech: Float
    var TienTraTruoc: Float
    var TongTienTra: Float
    var TongTienBaoHiem :Float
    var TienBaoHiemMoiThang:Float
    var PhanTramBaoHiem:Float
    var GiaSauKhuyenMai:Float
    var SchemeCode: String
    var AmortizationBy: Int
    var GiamayMin: Float
    var Giamaymax: Float
    
    init(CongTyDuyet: String, Flag: Int, GiayToCanCo: String, GopMoiThang: Float, HeSoLaiSuat: Float, LaiSuatPhang: Float, LaiSuatThuc: Float, PhanTramTraTruoc: Float, PhiBaoHiem: Float, PhiThuHo: Float, SoThangTra: String, TenGoi: String, TienChenhLech: Float, TienTraTruoc: Float, TongTienTra: Float, TongTienBaoHiem: Float, TienBaoHiemMoiThang: Float, PhanTramBaoHiem: Float, GiaSauKhuyenMai: Float, SchemeCode: String, AmortizationBy: Int, GiamayMin: Float, Giamaymax: Float) {
        self.CongTyDuyet = CongTyDuyet
        self.Flag = Flag
        self.GiayToCanCo = GiayToCanCo
        self.GopMoiThang = GopMoiThang
        self.HeSoLaiSuat = HeSoLaiSuat
        self.LaiSuatPhang = LaiSuatPhang
        self.LaiSuatThuc = LaiSuatThuc
        self.PhanTramTraTruoc = PhanTramTraTruoc
        self.PhiBaoHiem = PhiBaoHiem
        self.PhiThuHo = PhiThuHo
        self.SoThangTra = SoThangTra
        self.TenGoi = TenGoi
        self.TienChenhLech = TienChenhLech
        self.TienTraTruoc = TienTraTruoc
        self.TongTienTra = TongTienTra
        self.TongTienBaoHiem = TongTienBaoHiem
        self.TienBaoHiemMoiThang = TienBaoHiemMoiThang
        self.PhanTramBaoHiem = PhanTramBaoHiem
        self.GiaSauKhuyenMai = GiaSauKhuyenMai
        self.SchemeCode = SchemeCode
        self.AmortizationBy = AmortizationBy
        self.GiamayMin = GiamayMin
        self.Giamaymax = Giamaymax
    }
    
    class func parseObjfromArray(array:[JSON])->[AmortizationsDefinition]{
        var list:[AmortizationsDefinition] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> AmortizationsDefinition{
        
        var congTyDuyet = data["CongTyDuyet"].string
        var flag = data["Flag"].int
        var giayToCanCo = data["GiayToCanCo"].string
        var gopMoiThang = data["GopMoiThang"].float
        var heSoLaiSuat = data["HeSoLaiSuat"].float
        var laiSuatPhang = data["LaiSuatPhang"].float
        var laiSuatThuc = data["LaiSuatThuc"].float
        var phanTramTraTruoc = data["PhanTramTraTruoc"].float
        var phiBaoHiem = data["PhiBaoHiem"].float
        var phiThuHo = data["PhiThuHo"].float
        var soThangTra = data["SoThangTra"].string
        var tenGoi = data["TenGoi"].string
        var tienChenhLech = data["TienChenhLech"].float
        var tienTraTruoc = data["TienTraTruoc"].float
        var tongTienTra = data["TongTienTra"].float
        let TongTienBaoHiem = data["TongTienBaoHiem"].float
        let TienBaoHiemMoiThang = data["TienBaoHiemMoiThang"].float
        let PhanTramBaoHiem = data["PhanTramBaoHiem"].float
        let GiaSauKhuyenMai = data["GiaSauKhuyenMai"].float
        let SchemeCode = data["SchemeCode"].string
        let AmortizationBy = data["AmortizationBy"].int
        let GiamayMin = data["GiamayMin"].float
        let Giamaymax = data["Giamaymax"].float
        
        congTyDuyet = congTyDuyet == nil ? "" : congTyDuyet
        flag = flag == nil ? 0 : flag
        giayToCanCo = giayToCanCo == nil ? "" : giayToCanCo
        gopMoiThang = gopMoiThang == nil ? 0 : gopMoiThang
        heSoLaiSuat = heSoLaiSuat == nil ? 0 : heSoLaiSuat
        laiSuatPhang = laiSuatPhang == nil ? 0 : laiSuatPhang
        laiSuatThuc = laiSuatThuc == nil ? 0 : laiSuatThuc
        phanTramTraTruoc = phanTramTraTruoc == nil ? 0 : phanTramTraTruoc
        phiBaoHiem = phiBaoHiem == nil ? 0 : phiBaoHiem
        phiThuHo = phiThuHo == nil ? 0 : phiThuHo
        soThangTra = soThangTra == nil ? "" : soThangTra
        tenGoi = tenGoi == nil ? "" : tenGoi
        tienChenhLech = tienChenhLech == nil ? 0 : tienChenhLech
        tienTraTruoc = tienTraTruoc == nil ? 0 : tienTraTruoc
        tongTienTra = tongTienTra == nil ? 0 : tongTienTra
        
        
        return AmortizationsDefinition(CongTyDuyet: congTyDuyet!, Flag: flag!, GiayToCanCo: giayToCanCo!, GopMoiThang: gopMoiThang!, HeSoLaiSuat: heSoLaiSuat!, LaiSuatPhang: laiSuatPhang!, LaiSuatThuc: laiSuatThuc!, PhanTramTraTruoc: phanTramTraTruoc!, PhiBaoHiem: phiBaoHiem!, PhiThuHo: phiThuHo!, SoThangTra: soThangTra!, TenGoi: tenGoi!, TienChenhLech: tienChenhLech!, TienTraTruoc: tienTraTruoc!, TongTienTra: tongTienTra!, TongTienBaoHiem: TongTienBaoHiem ?? 0,TienBaoHiemMoiThang: TienBaoHiemMoiThang ?? 0, PhanTramBaoHiem: PhanTramBaoHiem ?? 0,GiaSauKhuyenMai: GiaSauKhuyenMai ?? 0,SchemeCode: SchemeCode ?? "",AmortizationBy: AmortizationBy ?? 0,GiamayMin: GiamayMin ?? 0,Giamaymax: Giamaymax ?? 0)
    }
}

