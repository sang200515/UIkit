//
//  ThongTinKhachHangMireaEntity.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import Foundation

class ThongTinKhachHangMireaEntity:Decodable {
    class ParamCustomer {
        var key:String
        var value:Any
        init(key:String,value:Any) {
            self.key = key
            self.value = value
        }
    }
    
    class TinhModel: Codable {
        let success: Bool?
        let data: [DataTinhModel]?

        enum CodingKeys: String, CodingKey {
            case success
            case data
        }

        init(success: Bool?, data: [DataTinhModel]?) {
            self.success = success
            self.data = data
        }
    }

    // MARK: - DataTinhModel
    class DataTinhModel: Codable {
        let value: String?
        let text: String?

        enum CodingKeys: String, CodingKey {
            case value,text
        }

        init(value: String?, text: String?) {
            self.value = value
            self.text = text
        }
    }
    
    class LuuHoSoModel: Codable {
        let success: Bool?
        let message: String?
        let appDocEntry: Int?

        enum CodingKeys: String, CodingKey {
            case success,message 
            case appDocEntry
        }

        init(success: Bool?, message: String?, appDocEntry: Int?) {
            self.success = success
            self.message = message
            self.appDocEntry = appDocEntry
        }
    }
    
    class KhachHangMiraeModel:NSObject {
        var soDienThoai:String = ""
        var thuNhap:String = ""
        var soCMND:String = ""
        var fullname:String = ""
        var ngayCapCMND:String = ""
        var ngaySinh:String = ""
        var ho:String = ""
        var gioiTinh:String = ""
        var tenLot:String = ""
        var ten:String = ""
        var diaChi:String = ""
        var diaChiTamTru:String = ""
        var codeTinhThuongTru:String = ""
        var tinhThuongTru:String = ""
        var tinhTamTru:String = ""
        var huyenThuongTru:String = ""
        var huyenTamTru:String = ""
        var xaThuongTru:String = ""
        var xaTamTru:String = ""
        var codeTinhTamTru:String = ""
        var codeHuyenThuongTru:String = ""
        var codeHuyenTamTru:String = ""
        var codeXaThuongTru:String = ""
        var codeXaTamTru:String = ""
        var noiCapCMND:String = ""
        var tenNguoiThamChieu1:String = ""
        var moiQuanHeNguoiThamChieu1:String = ""
        var soDTNguoiThamChieu1:String = ""
        var tenNguoiThamChieu2:String = ""
        var moiQuanHeNguoiThamChieu2:String = ""
        var soDTNguoiThamChieu2:String = ""
        var appDocEntry:Int = 0
        var tenCongTy:String = ""
        var chucVu:String = ""
        var loaiHopDong:String = ""
        var soNamLamViec:String = ""
        var soThangLamViec:String = ""
        var ngayThanhToan:String = ""
        var maNoiBo:String = ""
    }
    class UpdateThongTinCongViecModel: Codable {
        let success: Bool?
        let message: String?
        let continueUpdateBtn: Bool?

        init(success: Bool?, message: String?, continueUpdateBtn: Bool?) {
            self.success = success
            self.message = message
            self.continueUpdateBtn = continueUpdateBtn
        }
    }
    
    class HuyDonHangModel: Codable {
        let success: Bool?
        let message: String?

        enum CodingKeys: String, CodingKey {
            case success,message
        }

        init(success: Bool?, message: String?) {
            self.success = success
            self.message = message
        }
    }
}

class KhachHangMiraeModel:NSObject {
    var soDienThoai:String
    var thuNhap:String
    var soCMND:String
    var fullname:String
    var ngayCapCMND:String
    var ngaySinh:String
    var ho:String
    var gioiTinh:String
    var tenLot:String
    var ten:String
    var diaChi:String
    var codeTinhThuongTru:String
    var tinhThuongTru:String
    var tinhTamTru:String
    var huyenThuongTru:String
    var huyenTamTru:String
    var xaThuongTru:String
    var xaTamTru:String
    var codeTinhTamTru:String
    var codeHuyenThuongTru:String
    var codeHuyenTamTru:String
    var codeXaThuongTru:String
    var codeXaTamTru:String
    var noiCapCMND:String
    var tenNguoiThamChieu1:String
    var moiQuanHeNguoiThamChieu1:String
    var soDTNguoiThamChieu1:String
    var tenNguoiThamChieu2:String
    var moiQuanHeNguoiThamChieu2:String
    var soDTNguoiThamChieu2:String
    var appDocEntry:Int
    var tenGoiTraGop:String
    var codeGoiTraGop:String
    var kyHan:Int
    var soTienTraTruoc:Float
    var soTienCoc:Float
    var phiBaoHiem:Float
    var soTienVay:Float
    var giamGia:Float
    var tongTien:Float
    var laiSuat:Float
    var thanhTien:Float
    var fullAddress:String
    var soPOS:String
    var soMPOS:String
    
    init(soDienThoai:String
         , thuNhap:String
         , soCMND:String
         , fullname:String
         , ngayCapCMND:String
         , ngaySinh:String
         , ho:String
         , gioiTinh:String
         , tenLot:String
         , ten:String
         , diaChi:String
         , codeTinhThuongTru:String
         , tinhThuongTru:String
         , tinhTamTru:String
         , huyenThuongTru:String
         , huyenTamTru:String
         , xaThuongTru:String
         , xaTamTru:String
         , codeTinhTamTru:String
         , codeHuyenThuongTru:String
         , codeHuyenTamTru:String
         , codeXaThuongTru:String
         , codeXaTamTru:String
         , noiCapCMND:String
         , tenNguoiThamChieu1:String
         , moiQuanHeNguoiThamChieu1:String
         , soDTNguoiThamChieu1:String
         , tenNguoiThamChieu2:String
         , moiQuanHeNguoiThamChieu2:String
         , soDTNguoiThamChieu2:String
          , appDocEntry:Int,
         tenGoiTraGop:String,
         kyHan:Int,
         phiBaoHiem:Float,
         soTienVay:Float,
         giamGia:Float,
         tongTien:Float,
         soTienTraTruoc:Float,
         soTienCoc:Float,
         laiSuat:Float,
         thanhTien:Float,
         codeGoiTraGop:String,
         fullAddress:String,soPOS:String,soMPOS:String) {
        self.thuNhap = thuNhap
        self.appDocEntry = appDocEntry
        self.soDienThoai = soDienThoai
        self.soCMND = soCMND
        self.fullname = fullname
        self.ngayCapCMND = ngayCapCMND
        self.ngaySinh = ngaySinh
        self.ho = ho
        self.gioiTinh = gioiTinh
        self.tenLot = tenLot
        self.ten = ten
        self.diaChi = diaChi
        self.codeTinhThuongTru = codeTinhThuongTru
        self.tinhThuongTru = tinhThuongTru
        self.tinhTamTru = tinhTamTru
        self.huyenThuongTru = huyenTamTru
        self.huyenTamTru = huyenTamTru
        self.xaThuongTru = xaThuongTru
        self.xaTamTru = xaTamTru
        self.codeTinhTamTru = codeTinhTamTru
        self.codeHuyenThuongTru = codeHuyenThuongTru
        self.codeHuyenTamTru = codeHuyenTamTru
        self.codeXaThuongTru = codeXaThuongTru
        self.codeXaTamTru = codeXaTamTru
        self.noiCapCMND = noiCapCMND
        self.tenNguoiThamChieu1 = tenNguoiThamChieu1
        self.moiQuanHeNguoiThamChieu1 = moiQuanHeNguoiThamChieu1
        self.soDTNguoiThamChieu1 = soDTNguoiThamChieu1
        self.tenNguoiThamChieu2 = tenNguoiThamChieu2
        self.moiQuanHeNguoiThamChieu2 = moiQuanHeNguoiThamChieu2
        self.soDTNguoiThamChieu2 = soDTNguoiThamChieu2
        self.tenGoiTraGop = tenGoiTraGop
        self.kyHan = kyHan
        self.phiBaoHiem = phiBaoHiem
        self.soTienVay = soTienVay
        self.giamGia = giamGia
        self.tongTien = tongTien
        self.soTienTraTruoc = soTienTraTruoc
        self.soTienCoc = soTienCoc
        self.laiSuat = laiSuat
        self.thanhTien = thanhTien
        self.codeGoiTraGop = codeGoiTraGop
        self.fullAddress = fullAddress
        self.soPOS = soPOS
        self.soMPOS = soMPOS
    }
    
    
}

