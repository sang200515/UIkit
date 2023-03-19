//
//  OCRDFFriend.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class OCRDFFriend: NSObject {
    
    var CardName: String
    var CMND: String
    var SDT: String
    var Name: String
    var TenHinhThucMuaHang: String
    var HanMucSoTien: Float
    var HanMucConLai: Float
    var TTHanMuc: String
    var IDCLDuyetCT: String
    var IDCLDuyetTK: String
    var TraThang: Int
    var MaCongTy: String
    var TenCongTy: String
    var MaChiNhanhDoanhNghiep: String
    var TenChiNhanhDoanhNghiep: String
    var MaChucVu: Int
    var TenChucVu: String
    var DiaChiHoKhau: String
    var NgayCapCMND: String
    var NoiCapCMND: Int
    var SoTKNH: String
    var IdBank: Int
    var ChiNhanhNH: Int
    var NgayBatDauLamViec: String
    var Email: String
    var HTThanhToan: String
    var MaHTThanhToan: String
    var DiaChiDN:String
    var IDcardCode:Int
    var LoaiKH: Int
    var Message:String
    var Message_TT:String
    var Message_TG:String
    var TTDuyetHanMuc:String
    var flag_UQTN:String
    var Birthday:String
    var CreditCard:String
    var MaNV_KH:String
    var HinhThucXacNhan:Int
    var FlagEdit: Int
    var Knox:String
    var VendorCodeRef:Int
    
    var CMND_TinhThanhPho:Int
    var CMND_QuanHuyen:Int
    var CMND_PhuongXa:String
    var NguoiLienHe:String
    var SDT_NguoiLienHe:String
    var QuanHeVoiNguoiLienHe:Int
    var NguoiLienHe_2: String
    var SDT_NguoiLienHe_2:String
    var QuanHeVoiNguoiLienHe_2:Int
    var Flag_Credit:String
    var TTCalllogChungTu:String
    var TimeFrom:String
    var TimeTo:String
    var OtherTime:String
    var TenSPThamDinh:String
    var NoteCredit:String
    var Is_AllowCreateCust:Bool
    var Gender:Int
    var Flag_ImageScoring:String
    var Message_InfoScoring:String
    var TransactionID:Int
    var Is_FRT:Int
    var NguoiLienHe_3:String
    var SDT_NguoiLienHe_3:String
    var NguoiLienHe_4:String
    var SDT_NguoiLienHe_4:String
    
    var QuanHeVoiNguoiLienHe_3:Int
    var QuanHeVoiNguoiLienHe_4:Int
    var IS_Show_NT34:Int
    var Lock_NguoiLienHe:Int
    var Lock_NguoiLienHe_2:Int
    var Lock_NguoiLienHe_3:Int
    var Lock_NguoiLienHe_4:Int
    var IsKHTT:Int
    var MessageQRCode:String
    
    
    init(CardName: String, CMND: String, SDT: String, Name: String, TenHinhThucMuaHang: String, HanMucSoTien: Float, HanMucConLai: Float, TTHanMuc: String, IDCLDuyetCT: String, IDCLDuyetTK: String, TraThang: Int, MaCongTy: String, TenCongTy: String, MaChiNhanhDoanhNghiep: String, TenChiNhanhDoanhNghiep: String, MaChucVu: Int, TenChucVu: String, DiaChiHoKhau: String, NgayCapCMND: String, NoiCapCMND: Int, SoTKNH: String, IdBank: Int, ChiNhanhNH: Int, NgayBatDauLamViec: String, Email: String, HTThanhToan: String, MaHTThanhToan: String,DiaChiDN:String,IDcardCode:Int,LoaiKH: Int,Message:String,Message_TT:String,Message_TG:String,TTDuyetHanMuc:String,flag_UQTN:String,Birthday:String,CreditCard:String,MaNV_KH:String,HinhThucXacNhan:Int,FlagEdit: Int,Knox:String,VendorCodeRef:Int, CMND_TinhThanhPho:Int, CMND_QuanHuyen:Int, CMND_PhuongXa:String, NguoiLienHe:String, SDT_NguoiLienHe:String, QuanHeVoiNguoiLienHe:Int, NguoiLienHe_2: String, SDT_NguoiLienHe_2:String, QuanHeVoiNguoiLienHe_2:Int,Flag_Credit:String,TTCalllogChungTu:String,TimeFrom:String, TimeTo:String, OtherTime: String, TenSPThamDinh:String, NoteCredit:String, Is_AllowCreateCust:Bool,Gender:Int,Flag_ImageScoring:String,Message_InfoScoring:String,TransactionID:Int,Is_FRT:Int,NguoiLienHe_3:String,SDT_NguoiLienHe_3:String,NguoiLienHe_4:String,SDT_NguoiLienHe_4:String,QuanHeVoiNguoiLienHe_3:Int,QuanHeVoiNguoiLienHe_4:Int,IS_Show_NT34:Int,Lock_NguoiLienHe:Int,Lock_NguoiLienHe_2:Int,Lock_NguoiLienHe_3:Int,Lock_NguoiLienHe_4:Int,IsKHTT:Int,MessageQRCode:String){
        self.CardName = CardName
        self.CMND = CMND
        self.SDT = SDT
        self.Name = Name
        self.TenHinhThucMuaHang = TenHinhThucMuaHang
        self.HanMucSoTien = HanMucSoTien
        self.HanMucConLai = HanMucConLai
        self.TTHanMuc = TTHanMuc
        self.IDCLDuyetCT = IDCLDuyetCT
        self.IDCLDuyetTK = IDCLDuyetTK
        self.TraThang = TraThang
        self.MaCongTy = MaCongTy
        self.TenCongTy = TenCongTy
        self.MaChiNhanhDoanhNghiep = MaChiNhanhDoanhNghiep
        self.TenChiNhanhDoanhNghiep = TenChiNhanhDoanhNghiep
        self.MaChucVu = MaChucVu
        self.TenChucVu = TenChucVu
        self.DiaChiHoKhau = DiaChiHoKhau
        self.NgayCapCMND = NgayCapCMND
        self.NoiCapCMND = NoiCapCMND
        self.SoTKNH = SoTKNH
        self.IdBank = IdBank
        self.ChiNhanhNH = ChiNhanhNH
        self.NgayBatDauLamViec = NgayBatDauLamViec
        self.Email = Email
        self.HTThanhToan = HTThanhToan
        self.MaHTThanhToan = MaHTThanhToan
        self.DiaChiDN = DiaChiDN
        self.IDcardCode = IDcardCode
        self.LoaiKH = LoaiKH
        self.Message = Message
        self.Message_TT = Message_TT
        self.Message_TG = Message_TG
        self.TTDuyetHanMuc = TTDuyetHanMuc
        self.flag_UQTN = flag_UQTN
        self.Birthday = Birthday
        self.CreditCard = CreditCard
        self.MaNV_KH = MaNV_KH
        self.HinhThucXacNhan = HinhThucXacNhan
        self.FlagEdit = FlagEdit
        self.Knox = Knox
        self.VendorCodeRef = VendorCodeRef
        
        self.CMND_TinhThanhPho = CMND_TinhThanhPho
        self.CMND_QuanHuyen = CMND_QuanHuyen
        self.CMND_PhuongXa = CMND_PhuongXa
        self.NguoiLienHe = NguoiLienHe
        self.SDT_NguoiLienHe = SDT_NguoiLienHe
        self.QuanHeVoiNguoiLienHe = QuanHeVoiNguoiLienHe
        self.NguoiLienHe_2 = NguoiLienHe_2
        self.SDT_NguoiLienHe_2 = SDT_NguoiLienHe_2
        self.QuanHeVoiNguoiLienHe_2 = QuanHeVoiNguoiLienHe_2
        self.Flag_Credit = Flag_Credit
        self.TTCalllogChungTu = TTCalllogChungTu
        
        self.TimeFrom =  TimeFrom
        self.TimeTo = TimeTo
        self.OtherTime = OtherTime
        self.TenSPThamDinh = TenSPThamDinh
        self.NoteCredit = NoteCredit
        self.Is_AllowCreateCust = Is_AllowCreateCust
        self.Gender = Gender
        self.Flag_ImageScoring = Flag_ImageScoring
        self.Message_InfoScoring = Message_InfoScoring
        self.TransactionID = TransactionID
        self.Is_FRT = Is_FRT
        self.NguoiLienHe_3 = NguoiLienHe_3
        self.SDT_NguoiLienHe_3 = SDT_NguoiLienHe_3
        self.NguoiLienHe_4 = NguoiLienHe_4
        self.SDT_NguoiLienHe_4 = SDT_NguoiLienHe_4
        
        self.QuanHeVoiNguoiLienHe_3 = QuanHeVoiNguoiLienHe_3
        self.QuanHeVoiNguoiLienHe_4 = QuanHeVoiNguoiLienHe_4
        self.IS_Show_NT34 = IS_Show_NT34
        self.Lock_NguoiLienHe = Lock_NguoiLienHe
        self.Lock_NguoiLienHe_2 = Lock_NguoiLienHe_2
        self.Lock_NguoiLienHe_3 = Lock_NguoiLienHe_3
        self.Lock_NguoiLienHe_4 = Lock_NguoiLienHe_4
        self.IsKHTT = IsKHTT
        self.MessageQRCode = MessageQRCode
    }
    class func parseObjfromArray(array:[JSON])->[OCRDFFriend]{
        var list:[OCRDFFriend] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> OCRDFFriend{
        
        var cardName = data["CardName"].string
        var cmnd = data["CMND"].string
        var sdt = data["SDT"].string
        var name = data["Name"].string
        var tenHinhThucMuaHang = data["TenHinhThucMuaHang"].string
        var hanMucSoTien = data["HanMucSoTien"].float
        var hanMucConLai = data["HanMucConLai"].float
        var ttHanMuc = data["TTHanMuc"].string
        var idCLDuyetCT = data["IDCLDuyetCT"].string
        var idCLDuyetTK = data["IDCLDuyetTK"].string
        var traThang = data["TraThang"].int
        
        let maCongTy = "\(String(describing: data["MaCongTy"]))"
        var tenCongTy = data["TenCongTy"].string
        var maChiNhanhDoanhNghiep = data["MaChiNhanhDoanhNghiep"].string
        var tenChiNhanhDoanhNghiep = data["TenChiNhanhDoanhNghiep"].string
        
        var maChucVu = data["MaChucVu"].int
        var tenChucVu = data["TenChucVu"].string
        
        var diaChiHoKhau = data["DiaChiHoKhau"].string
        var ngayCapCMND = data["NgayCapCMND"].string
        var noiCapCMND = data["NoiCapCMND"].int
        var soTKNH = data["SoTKNH"].string
        var idBank = data["IdBank"].int
        var chiNhanhNH = data["ChiNhanhNH"].int
        var ngayBatDauLamViec = data["NgayBatDauLamViec"].string
        var email = data["Email"].string
        var htThanhToan = data["HTThanhToan"].string
        var maHTThanhToan = data["MaHTThanhToan"].string
        var diaChiDN = data["DiaChiDN"].string
        var idcardCode = data["IDcardCode"].int
        var loaiKH = data["LoaiKH"].int
        var message = data["Message"].string
        var message_TT = data["Message_TT"].string
        var message_TG = data["Message_TG"].string
        
        var ttDuyetHanMuc = data["TTDuyetHanMuc"].string
        var flag_UQTN = data["flag_UQTN"].string
        
        var birthday = data["Birthday"].string
        var creditCard = data["CreditCard"].string
        
        var maNV_KH = data["MaNV_KH"].string
        var hinhThucXacNhan = data["HinhThucXacNhan"].int
        var flagEdit = data["FlagEdit"].int
        var knox = data["Knox"].string
        var vendorCodeRef = data["VendorCodeRef"].int
        
        
        var cmnd_TinhThanhPho = data["CMND_TinhThanhPho"].int
        var cmnd_QuanHuyen = data["CMND_QuanHuyen"].int
        
        var cmnd_PhuongXa = data["CMND_PhuongXa"].string
        var nguoiLienHe = data["NguoiLienHe"].string
        
        var sdt_NguoiLienHe = data["SDT_NguoiLienHe"].string
        var quanHeVoiNguoiLienHe = data["QuanHeVoiNguoiLienHe"].int
        var nguoiLienHe_2 = data["NguoiLienHe_2"].string
        var sdt_NguoiLienHe_2 = data["SDT_NguoiLienHe_2"].string
        var quanHeVoiNguoiLienHe_2 = data["QuanHeVoiNguoiLienHe_2"].int
        var flag_Credit = data["Flag_Credit"].string
        var ttCalllogChungTu = data["TTCalllogChungTu"].string
        
        
        var timeFrom = data["TimeFrom"].string
        var timeTo = data["TimeTo"].string
        var otherTime = data["OtherTime"].string
        var tenSPThamDinh = data["TenSPThamDinh"].string
        var noteCredit = data["NoteCredit"].string
        var is_AllowCreateCust = data["Is_AllowCreateCust"].bool
        var Gender = data["Gender"].int
        var Flag_ImageScoring = data["Flag_ImageScoring"].string
        var Message_InfoScoring = data["Message_InfoScoring"].string
        var TransactionID = data["TransactionID"].int
        var Is_FRT = data["Is_FRT"].int
        var NguoiLienHe_3 = data["NguoiLienHe_3"].string
        var SDT_NguoiLienHe_3 = data["SDT_NguoiLienHe_3"].string
        var NguoiLienHe_4 = data["NguoiLienHe_4"].string
        var SDT_NguoiLienHe_4 = data["SDT_NguoiLienHe_4"].string
        
        var QuanHeVoiNguoiLienHe_3 = data["QuanHeVoiNguoiLienHe_3"].int
        var QuanHeVoiNguoiLienHe_4 = data["QuanHeVoiNguoiLienHe_4"].int
        var IS_Show_NT34 = data["IS_Show_NT34"].int
        var Lock_NguoiLienHe = data["Lock_NguoiLienHe"].int
        var Lock_NguoiLienHe_2 = data["Lock_NguoiLienHe_2"].int
        var Lock_NguoiLienHe_3 = data["Lock_NguoiLienHe_3"].int
        var Lock_NguoiLienHe_4 = data["Lock_NguoiLienHe_4"].int
        var IsKHTT = data["IsKHTT"].int
        var MessageQRCode = data["MessageQRCode"].string
        
        cardName = cardName == nil ? "" : cardName
        cmnd = cmnd == nil ? "" : cmnd
        sdt = sdt == nil ? "" : sdt
        name = name == nil ? "" : name
        tenHinhThucMuaHang = tenHinhThucMuaHang == nil ? "" : tenHinhThucMuaHang
        hanMucSoTien = hanMucSoTien == nil ? 0 : hanMucSoTien
        hanMucConLai = hanMucConLai == nil ? 0 : hanMucConLai
        ttHanMuc = ttHanMuc == nil ? "" : ttHanMuc
        idCLDuyetCT = idCLDuyetCT == nil ? "" : idCLDuyetCT
        idCLDuyetTK = idCLDuyetTK == nil ? "" : idCLDuyetTK
        traThang = traThang == nil ? 0 : traThang
        
        //        maCongTy = maCongTy == nil ? "" : maCongTy
        tenCongTy = tenCongTy == nil ? "" : tenCongTy
        maChiNhanhDoanhNghiep = maChiNhanhDoanhNghiep == nil ? "" : maChiNhanhDoanhNghiep
        tenChiNhanhDoanhNghiep = tenChiNhanhDoanhNghiep == nil ? "" : tenChiNhanhDoanhNghiep
        maChucVu = maChucVu == nil ? 0 : maChucVu
        tenChucVu = tenChucVu == nil ? "" : tenChucVu
        
        diaChiHoKhau = diaChiHoKhau == nil ? "" : diaChiHoKhau
        ngayCapCMND = ngayCapCMND == nil ? "1970-01-01T00:00:00" : ngayCapCMND
        noiCapCMND = noiCapCMND == nil ? 0 : noiCapCMND
        soTKNH = soTKNH == nil ? "" : soTKNH
        idBank = idBank == nil ? 0 : idBank
        chiNhanhNH = chiNhanhNH == nil ? 0 : chiNhanhNH
        ngayBatDauLamViec = ngayBatDauLamViec == nil ? "1970-01-01T00:00:00" : ngayBatDauLamViec
        email = email == nil ? "" : email
        htThanhToan = htThanhToan == nil ? "" : htThanhToan
        maHTThanhToan = maHTThanhToan == nil ? "" : maHTThanhToan
        diaChiDN = diaChiDN == nil ? "" : diaChiDN
        idcardCode = idcardCode == nil ? 0 : idcardCode
        loaiKH = loaiKH == nil ? 0 : loaiKH
        message = message == nil ? "" : message
        message_TT = message_TT == nil ? "" : message_TT
        message_TG = message_TG == nil ? "" : message_TG
        ttDuyetHanMuc = ttDuyetHanMuc == nil ? "" : ttDuyetHanMuc
        flag_UQTN = flag_UQTN == nil ? "" : flag_UQTN
        
        birthday = birthday == nil ? "1970-01-01T00:00:00" : birthday
        creditCard = creditCard == nil ? "" : creditCard
        
        maNV_KH = maNV_KH == nil ? "" : maNV_KH
        hinhThucXacNhan = hinhThucXacNhan == nil ? 0 : hinhThucXacNhan
        flagEdit = flagEdit == nil ? 0 : flagEdit
        
        knox = knox == nil ? "" : knox
        vendorCodeRef  = vendorCodeRef == nil ? 0 : vendorCodeRef
        
        ngayCapCMND = formatDate(date: ngayCapCMND!)
        ngayBatDauLamViec = formatDate(date: ngayBatDauLamViec!)
        birthday = formatDate(date: birthday!)
        
        cmnd_TinhThanhPho = cmnd_TinhThanhPho == nil ? 0 : cmnd_TinhThanhPho
        cmnd_QuanHuyen = cmnd_QuanHuyen == nil ? 0 : cmnd_QuanHuyen
        
        cmnd_PhuongXa = cmnd_PhuongXa == nil ? "" : cmnd_PhuongXa
        nguoiLienHe = nguoiLienHe == nil ? "" : nguoiLienHe
        
        sdt_NguoiLienHe = sdt_NguoiLienHe == nil ? "" : sdt_NguoiLienHe
        quanHeVoiNguoiLienHe = quanHeVoiNguoiLienHe == nil ? 0 : quanHeVoiNguoiLienHe
        nguoiLienHe_2 = nguoiLienHe_2 == nil ? "" : nguoiLienHe_2
        
        sdt_NguoiLienHe_2 = sdt_NguoiLienHe_2 == nil ? "" : sdt_NguoiLienHe_2
        quanHeVoiNguoiLienHe_2  = quanHeVoiNguoiLienHe_2 == nil ? 0 : quanHeVoiNguoiLienHe_2
        
        flag_Credit = flag_Credit == nil ? "" : flag_Credit
        
        ttCalllogChungTu = ttCalllogChungTu == nil ? "" : ttCalllogChungTu
        
        //        flag_Credit = "0,0,0,0,0,0,1,0,0,0,0,0,0,0,0"
        
        timeFrom = timeFrom == nil ? "" : timeFrom
        timeTo = timeTo == nil ? "" : timeTo
        
        if(timeTo == "00:00:00"){
            timeTo = ""
        }
        if(timeFrom == "00:00:00"){
            timeFrom = ""
        }
        
        otherTime = otherTime == nil ? "" : otherTime
        tenSPThamDinh  = tenSPThamDinh == nil ? "" : tenSPThamDinh
        
        noteCredit = noteCredit == nil ? "" : noteCredit
        
        is_AllowCreateCust = is_AllowCreateCust == nil ? false : is_AllowCreateCust
        Gender = Gender == nil ? 0 : Gender
        Flag_ImageScoring = Flag_ImageScoring == nil ? "" : Flag_ImageScoring
        Message_InfoScoring = Message_InfoScoring == nil ? "" : Message_InfoScoring
        TransactionID = TransactionID == nil ? 0 : TransactionID
        Is_FRT = Is_FRT == nil ? 0 : Is_FRT
        NguoiLienHe_3 = NguoiLienHe_3 == nil ? "" : NguoiLienHe_3
        SDT_NguoiLienHe_3 = SDT_NguoiLienHe_3 == nil ? "" : SDT_NguoiLienHe_3
        NguoiLienHe_4 = NguoiLienHe_4 == nil ? "" : NguoiLienHe_4
        SDT_NguoiLienHe_4 = SDT_NguoiLienHe_4 == nil ? "" : SDT_NguoiLienHe_4
        
        QuanHeVoiNguoiLienHe_3 = QuanHeVoiNguoiLienHe_3 == nil ? 0 : QuanHeVoiNguoiLienHe_3
        QuanHeVoiNguoiLienHe_4 = QuanHeVoiNguoiLienHe_4 == nil ? 0 : QuanHeVoiNguoiLienHe_4
        IS_Show_NT34 = IS_Show_NT34 == nil ? 0 : IS_Show_NT34
        
        Lock_NguoiLienHe = Lock_NguoiLienHe == nil ? 0 : Lock_NguoiLienHe
        Lock_NguoiLienHe_2 = Lock_NguoiLienHe_2 == nil ? 0 : Lock_NguoiLienHe_2
        Lock_NguoiLienHe_3 = Lock_NguoiLienHe_3 == nil ? 0 : Lock_NguoiLienHe_3
        Lock_NguoiLienHe_4 = Lock_NguoiLienHe_4 == nil ? 0 : Lock_NguoiLienHe_4
        IsKHTT = IsKHTT == nil ? 0 : IsKHTT
        MessageQRCode = MessageQRCode == nil ? "" : MessageQRCode
        
        return OCRDFFriend(CardName: cardName!,CMND: cmnd!,SDT: sdt!,Name: name!,TenHinhThucMuaHang: tenHinhThucMuaHang!,HanMucSoTien: hanMucSoTien!,HanMucConLai: hanMucConLai!,TTHanMuc: ttHanMuc!,IDCLDuyetCT: idCLDuyetCT!,IDCLDuyetTK: idCLDuyetTK!,TraThang:traThang!, MaCongTy: maCongTy, TenCongTy: tenCongTy!, MaChiNhanhDoanhNghiep: maChiNhanhDoanhNghiep!, TenChiNhanhDoanhNghiep: tenChiNhanhDoanhNghiep!, MaChucVu: maChucVu!, TenChucVu: tenChucVu!, DiaChiHoKhau: diaChiHoKhau!, NgayCapCMND: ngayCapCMND!, NoiCapCMND: noiCapCMND!, SoTKNH: soTKNH!, IdBank: idBank!, ChiNhanhNH: chiNhanhNH!, NgayBatDauLamViec: ngayBatDauLamViec!, Email: email!, HTThanhToan: htThanhToan!, MaHTThanhToan: maHTThanhToan!,DiaChiDN:diaChiDN!,IDcardCode:idcardCode!,LoaiKH:loaiKH!,Message:message!,Message_TT:message_TT!,Message_TG:message_TG!,TTDuyetHanMuc:ttDuyetHanMuc!,flag_UQTN:flag_UQTN!,Birthday:birthday!,CreditCard:creditCard!,MaNV_KH:maNV_KH!, HinhThucXacNhan: hinhThucXacNhan!,FlagEdit:flagEdit!,Knox:knox!,VendorCodeRef:vendorCodeRef!, CMND_TinhThanhPho:cmnd_TinhThanhPho!, CMND_QuanHuyen:cmnd_QuanHuyen!, CMND_PhuongXa:cmnd_PhuongXa!, NguoiLienHe:nguoiLienHe!, SDT_NguoiLienHe:sdt_NguoiLienHe!, QuanHeVoiNguoiLienHe:quanHeVoiNguoiLienHe!, NguoiLienHe_2: nguoiLienHe_2!, SDT_NguoiLienHe_2:sdt_NguoiLienHe_2!, QuanHeVoiNguoiLienHe_2:quanHeVoiNguoiLienHe_2!,Flag_Credit:flag_Credit!,TTCalllogChungTu:ttCalllogChungTu!,TimeFrom:timeFrom!, TimeTo:timeTo!, OtherTime: otherTime!, TenSPThamDinh:tenSPThamDinh!, NoteCredit:noteCredit!, Is_AllowCreateCust:is_AllowCreateCust!,Gender:Gender!,Flag_ImageScoring:Flag_ImageScoring!,Message_InfoScoring:Message_InfoScoring!,TransactionID:TransactionID!,Is_FRT:Is_FRT!,NguoiLienHe_3:NguoiLienHe_3!,SDT_NguoiLienHe_3:SDT_NguoiLienHe_3!,NguoiLienHe_4:NguoiLienHe_4!,SDT_NguoiLienHe_4:SDT_NguoiLienHe_4!,QuanHeVoiNguoiLienHe_3:QuanHeVoiNguoiLienHe_3!,QuanHeVoiNguoiLienHe_4:QuanHeVoiNguoiLienHe_4!,IS_Show_NT34:IS_Show_NT34!,Lock_NguoiLienHe:Lock_NguoiLienHe!,Lock_NguoiLienHe_2:Lock_NguoiLienHe_2!,Lock_NguoiLienHe_3:Lock_NguoiLienHe_3!,Lock_NguoiLienHe_4:Lock_NguoiLienHe_4!,IsKHTT:IsKHTT!,MessageQRCode:MessageQRCode!)
    }
    
    class func formatDate(date:String) -> String{
        let deFormatter = DateFormatter()
        deFormatter.timeZone = TimeZone(abbreviation: "UTC")
        deFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let startTime = deFormatter.date(from: date)
        deFormatter.dateFormat = "dd/MM/yyyy"
        if startTime != nil {
            return deFormatter.string(from: startTime!)
        }else{
            return "01/01/1970"
        }
        
    }
    
}

