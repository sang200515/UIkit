//
//  GuaranteeAutoItems.swift
//  fptshop
//
//  Created by Ngoc Bao on 22/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON


class GRTHistoryItem : NSObject {
    
    var phongBan_Ten : String
    var nvTestMay : String
    var ngayTest : String
    var soPhien : Int
    var maPhieuBH : Int
    var kqTest_Ten : String
    var moTaLoi : String
    var imei : String
    var tenSanPham : String
    var tenCuaHangTaoPhieu : String
    var tenHinhThuc : String
    var ketQuaLoi_Ten : String
    var soLanBH : Int
    var huongXLFRT_Ten : String
    var huongXLKH_Ten : String
    var imeiMoiKH : String
    var ngayTaoPhieu : String
    var trangThaiKH : Int
    var trangThaiPhieu: String
    var maSanPham: String
    
    init(phongBan_Ten: String, nvTestMay: String, ngayTest: String, soPhien: Int, maPhieuBH: Int, kqTest_Ten: String, moTaLoi: String, imei: String, tenSanPham: String, tenCuaHangTaoPhieu: String, tenHinhThuc: String, ketQuaLoi_Ten: String, soLanBH: Int, huongXLFRT_Ten: String, huongXLKH_Ten: String, imeiMoiKH: String, ngayTaoPhieu: String, trangThaiKH: Int,trangThaiPhieu: String,maSanPham: String) {
       self.phongBan_Ten = phongBan_Ten
       self.nvTestMay = nvTestMay
       self.ngayTest = ngayTest
       self.soPhien = soPhien
       self.maPhieuBH = maPhieuBH
       self.kqTest_Ten = kqTest_Ten
       self.moTaLoi = moTaLoi
       self.imei = imei
       self.tenSanPham = tenSanPham
       self.tenCuaHangTaoPhieu = tenCuaHangTaoPhieu
       self.tenHinhThuc = tenHinhThuc
       self.ketQuaLoi_Ten = ketQuaLoi_Ten
       self.soLanBH = soLanBH
       self.huongXLFRT_Ten = huongXLFRT_Ten
       self.huongXLKH_Ten = huongXLKH_Ten
       self.imeiMoiKH = imeiMoiKH
       self.ngayTaoPhieu = ngayTaoPhieu
       self.trangThaiKH = trangThaiKH
        self.trangThaiPhieu = trangThaiPhieu
        self.maSanPham = maSanPham
   }
    
    class func getObjFromDictionary(data:JSON) -> GRTHistoryItem {
        let phongBan_Ten = data["phongBan_Ten"].stringValue
        let nvTestMay = data["nvTestMay"].stringValue
        let ngayTest = data["ngayTest"].stringValue
        let soPhien = data["soPhien"].intValue
        let maPhieuBH = data["maPhieuBH"].intValue
        let kqTest_Ten = data["kqTest_Ten"].stringValue
        let moTaLoi = data["moTaLoi"].stringValue
        let imei = data["imei"].stringValue
        let tenSanPham = data["tenSanPham"].stringValue
        let tenCuaHangTaoPhieu = data["tenCuaHangTaoPhieu"].stringValue
        let tenHinhThuc = data["tenHinhThuc"].stringValue
        let ketQuaLoi_Ten = data["ketQuaLoi_Ten"].stringValue
        let soLanBH = data["soLanBH"].intValue
        let huongXLFRT_Ten = data["huongXLFRT_Ten"].stringValue
        let huongXLKH_Ten = data["huongXLKH_Ten"].stringValue
        let imeiMoiKH = data["imeiMoiKH"].stringValue
        let ngayTaoPhieu = data["ngayTaoPhieu"].stringValue
        let trangThaiKH = data["trangThaiKH"].intValue
        let trangThaiPhieu = data["trangThaiPhieu"].stringValue
        let maSanPham = data["maSanPham"].stringValue
        
        return GRTHistoryItem(phongBan_Ten: phongBan_Ten, nvTestMay: nvTestMay, ngayTest: ngayTest, soPhien: soPhien, maPhieuBH: maPhieuBH, kqTest_Ten: kqTest_Ten, moTaLoi: moTaLoi, imei: imei, tenSanPham: tenSanPham, tenCuaHangTaoPhieu: tenCuaHangTaoPhieu, tenHinhThuc: tenHinhThuc, ketQuaLoi_Ten: ketQuaLoi_Ten, soLanBH: soLanBH, huongXLFRT_Ten: huongXLFRT_Ten, huongXLKH_Ten: huongXLKH_Ten, imeiMoiKH: imeiMoiKH, ngayTaoPhieu: ngayTaoPhieu, trangThaiKH: trangThaiKH,trangThaiPhieu: trangThaiPhieu,maSanPham:maSanPham)
    }
    
    class func parseObjfromArray(array:[JSON])->[GRTHistoryItem]{
        var list:[GRTHistoryItem] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }

}

class GRTSaveDeleteItem: NSObject {
    
    var result : Int // (1: Cập nhật thành công;  -1: Cập nhật không thành công; 0: Cảnh báo)
    var soPhien : Int
    var thongBaoLoi : String
    var daChuyenTT : String
    var trucTiepKhongTestLai : String
    var phieuKhongHopLe : String
    
    
    init(result: Int, soPhien: Int, thongBaoLoi: String, daChuyenTT: String, trucTiepKhongTestLai: String, phieuKhongHopLe: String) {
        self.result = result
        self.soPhien = soPhien
        self.thongBaoLoi = thongBaoLoi
        self.daChuyenTT = daChuyenTT
        self.trucTiepKhongTestLai = trucTiepKhongTestLai
        self.phieuKhongHopLe = phieuKhongHopLe
    }

    class func getObjFromDictionary(data:JSON) -> GRTSaveDeleteItem {
        let result = data["result"].intValue
        let soPhien = data["soPhien"].intValue
        let thongBaoLoi = data["thongBaoLoi"].stringValue
        let daChuyenTT = data["daChuyenTT"].stringValue
        let trucTiepKhongTestLai = data["trucTiepKhongTestLai"].stringValue
        let phieuKhongHopLe = data["phieuKhongHopLe"].stringValue
        
        return GRTSaveDeleteItem(result: result, soPhien: soPhien, thongBaoLoi: thongBaoLoi, daChuyenTT: daChuyenTT, trucTiepKhongTestLai: trucTiepKhongTestLai, phieuKhongHopLe: phieuKhongHopLe)
    }
    var resultStr: String {
        switch result {
        case 1:
            return "Cập nhật thành công"
        case -1:
            return "Cập nhật không thành công!"
        case 0:
            return "Cảnh báo, đã xảy ra lỗi"
        default:
            return ""
        }
    }
    
}
