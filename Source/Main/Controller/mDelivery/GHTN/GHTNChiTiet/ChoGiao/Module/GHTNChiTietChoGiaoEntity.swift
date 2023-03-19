//
//  GHTNChiTietChoGiaoEntity.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import Foundation

class GHTNChiTietChoGiaoEntity {
    
    struct ChiTietDonHangModel: Codable {
        let id, orderID: Int?
        let uItmCod, uItmName, uImei: String?
        let uQutity, uPrice, uDisCou, uTMoney: Double?

        enum CodingKeys: String, CodingKey {
            case id = "ID"
            case orderID = "ORDRID"
            case uItmCod = "U_ItmCod"
            case uItmName = "U_ItmName"
            case uImei = "U_Imei"
            case uQutity = "U_Qutity"
            case uPrice = "U_Price"
            case uDisCou = "U_DisCou"
            case uTMoney = "U_TMoney"
        }
    }
  
    struct UpLoadImageGHTNModel: Codable {
        let result: Int?
        let msg: String?

        enum CodingKeys: String, CodingKey {
            case result = "Result"
            case msg = "Msg"
        }
    }
    
    struct XacNhanGiaoHangModel: Codable {
        let result: Int?
        let description: String?

        enum CodingKeys: String, CodingKey {
            case result = "Result"
            case description = "Description"
        }
    }
    
    struct DatGrabGiaoHangModel: Codable {
        let result : Int?
        let msg : String?
        let planningId : Int?
        let expected_Time : String?
        let partner : String?
        let amount : Int?
        let amount_FRT : Int?
        let services_Code : String?
        let servicesName : String?
        let distance : Double?
        let duration : Int?
        let diaChiShop : String?
        let diaChiKhachHang : String?
        let tenDichVu : String?
        let khoangCach : String?
        let duKien : String?
        let tongCong : String?
        
        enum CodingKeys: String, CodingKey {
            case result = "Result"
            case msg = "Msg"
            case planningId = "PlanningId"
            case expected_Time = "Expected_Time"
            case partner = "Partner"
            case amount = "Amount"
            case amount_FRT = "Amount_FRT"
            case services_Code = "Services_Code"
            case servicesName = "ServicesName"
            case distance = "Distance"
            case duration = "Duration"
            case diaChiShop = "DiaChiShop"
            case diaChiKhachHang = "DiaChiKhachHang"
            case tenDichVu = "TenDichVu"
            case khoangCach = "KhoangCach"
            case duKien = "DuKien"
            case tongCong = "TongCong"
        }
    }
    
    struct ListGHTNModel: Codable {
        let success: Bool?
        let data: [GHTNModel]?
    }

    // MARK: - Datum
    struct GHTNModel: Codable {
        let id: Int?
        var code, userName, empName, bookDate: String?
            let whConfirmed, whDate: String?
            let rejectReason, rejectDate: String?
            let paymentType: Int?
            let finishLatitude, finishLongitude: Double?
            let finishTime: String?
            let paidConfirmed, paidDate: String?
            let orderStatus, docEntry: Int?
            let uNuBill: String?
            let uReveRe: String?
            let uCrdName, uCAddress, uCPhone: String?
            let uSyBill: String?
            let uCRDate, uDesc: String?
            let uTMonPR, uMonPer, uTMonTx, uDownPay: Int?
            let uTMonBI: Int?
            let uReceive, uAdrDel, uPhone, uDateDe: String?
            let uNumEcom: Int?
            let uShpCode: String?
            let uDeposit: Int?
            let uPaidMoney: Int?
            let sourceType, rowVersion, type: Int?
            let isCN, htttFf, imgURLPDKMatTruocCMND, imgURLPDKMatSauCMND: String?
            let imgURLGiayUyQuyenMatSauCMND, imgURLGiayThayDoiChuKy: String?
            let cmnd: String?
            let tenDN: String?
            let smChiuTrachNhiem: String?
            let imgURLTGH, imgURLNKH: String?
            let imgURLPGH: String?
            let isUploadTGH, isUploadNKH, isUploadPGH: Int?
            let whConfirmedMaTen: String?
            let returnReason, cantCallReason, imgURLTTD, imgURLHDTC1: String?
            let imgURLHDTC2, imgURLHDTC3: String?
            let soTienTraTruoc, createType: Double?
            let installLocation: String?
            let contentWork: String?
            let userBookCode: String?
            let userBookName: String?
            let sdtUserBook: String?
            let uShopName: String?
            let imgUploadTime: String?
            let imgURLXNGH: String?
            let maHD: String?
            let uAdrDelNew: String?
            let isFado: Bool?
            let otpFado, createDateTime: String?
            let partnerCode, partnerName: String?
            let maShopNhoGiaoHang, deliveryDateTime: String?
            let pTabName: String?
            let pLoaiDonHang: String?
            let pShopXuat: String?
            let pShopGiaoHo: String?
            let pNguoiGiao: String?
            let pTrangThaiGiaoHang: String?
            let pTrangThaiDonHang: String?
            let pThongTinNCCTransactionCode, pThongTinNCCTaiXeTen, pThongTinNCCTaiXeSDT, pThongTinNCCTaiXeThoiGianDenShop: String?
            let pThongTinNCCURLTracking: String?
            let btnXacNhanXuatKho: String?
            let btnBatDauGiaoHang: String?
            let btnFRTGiao: String?
            let btnHuyGiaoHang: String?
            let btnKhachNhanHang: String?
            let btnKhachKhongNhanHang: String?
            let btnXacNhanNhapKho, pThongTinNguoiNhanName, pThongTinNguoiNhanSDT, pThongTinNguoiNhanAddress: String?
            let pThongTinNguoiNhanDate: String?

            enum CodingKeys: String, CodingKey {
                case id = "ID"
                case code = "Code"
                case userName = "UserName"
                case empName = "EmpName"
                case bookDate = "BookDate"
                case whConfirmed = "WHConfirmed"
                case whDate = "WHDate"
                case rejectReason = "RejectReason"
                case rejectDate = "RejectDate"
                case paymentType = "PaymentType"
                case finishLatitude = "FinishLatitude"
                case finishLongitude = "FinishLongitude"
                case finishTime = "FinishTime"
                case paidConfirmed = "PaidConfirmed"
                case paidDate = "PaidDate"
                case orderStatus = "OrderStatus"
                case docEntry = "DocEntry"
                case uNuBill = "U_NuBill"
                case uReveRe = "U_ReveRe"
                case uCrdName = "U_CrdName"
                case uCAddress = "U_CAddress"
                case uCPhone = "U_CPhone"
                case uSyBill = "U_SyBill"
                case uCRDate = "U_CrDate"
                case uDesc = "U_Desc"
                case uTMonPR = "U_TMonPr"
                case uMonPer = "U_MonPer"
                case uTMonTx = "U_TMonTx"
                case uDownPay = "U_DownPay"
                case uTMonBI = "U_TMonBi"
                case uReceive = "U_Receive"
                case uAdrDel = "U_AdrDel"
                case uPhone = "U_Phone"
                case uDateDe = "U_DateDe"
                case uNumEcom = "U_NumEcom"
                case uShpCode = "U_ShpCode"
                case uDeposit = "U_Deposit"
                case uPaidMoney = "U_PaidMoney"
                case sourceType = "SourceType"
                case rowVersion = "RowVersion"
                case type = "Type"
                case isCN = "Is_CN"
                case htttFf = "HTTT_FF"
                case imgURLPDKMatTruocCMND = "ImgUrl_PDK_MatTruocCMND"
                case imgURLPDKMatSauCMND = "ImgUrl_PDK_MatSauCMND"
                case imgURLGiayUyQuyenMatSauCMND = "ImgUrl_GiayUyQuyen_MatSauCMND"
                case imgURLGiayThayDoiChuKy = "ImgUrl_GiayThayDoiChuKy"
                case cmnd = "CMND"
                case tenDN = "Ten_DN"
                case smChiuTrachNhiem = "SM_ChiuTrachNhiem"
                case imgURLTGH = "ImgUrl_TGH"
                case imgURLNKH = "ImgUrl_NKH"
                case imgURLPGH = "ImgUrl_PGH"
                case isUploadTGH = "Is_Upload_TGH"
                case isUploadNKH = "Is_Upload_NKH"
                case isUploadPGH = "Is_Upload_PGH"
                case whConfirmedMaTen = "_WHConfirmed_MaTen"
                case returnReason = "ReturnReason"
                case cantCallReason = "CantCallReason"
                case imgURLTTD = "ImgUrl_TTD"
                case imgURLHDTC1 = "ImgUrl_HDTC1"
                case imgURLHDTC2 = "ImgUrl_HDTC2"
                case imgURLHDTC3 = "ImgUrl_HDTC3"
                case soTienTraTruoc = "SoTienTraTruoc"
                case createType = "CreateType"
                case installLocation = "InstallLocation"
                case contentWork = "ContentWork"
                case userBookCode = "UserBookCode"
                case userBookName = "UserBookName"
                case sdtUserBook = "SDT_UserBook"
                case uShopName = "U_ShopName"
                case imgUploadTime = "ImgUploadTime"
                case imgURLXNGH = "ImgUrl_XNGH"
                case maHD = "Ma_HD"
                case uAdrDelNew = "U_AdrDel_New"
                case isFado = "is_fado"
                case otpFado = "otp_fado"
                case createDateTime = "CreateDateTime"
                case partnerCode = "Partner_code"
                case partnerName = "Partner_name"
                case maShopNhoGiaoHang = "MaShopNhoGiaoHang"
                case deliveryDateTime = "DeliveryDateTime"
                case pTabName = "p_TabName"
                case pLoaiDonHang = "p_LoaiDonHang"
                case pShopXuat = "p_ShopXuat"
                case pShopGiaoHo = "p_ShopGiaoHo"
                case pNguoiGiao = "p_NguoiGiao"
                case pTrangThaiGiaoHang = "p_TrangThaiGiaoHang"
                case pTrangThaiDonHang = "p_TrangThaiDonHang"
                case pThongTinNCCTransactionCode = "p_ThongTinNCC_TransactionCode"
                case pThongTinNCCTaiXeTen = "p_ThongTinNCC_TaiXe_Ten"
                case pThongTinNCCTaiXeSDT = "p_ThongTinNCC_TaiXe_SDT"
                case pThongTinNCCTaiXeThoiGianDenShop = "p_ThongTinNCC_TaiXe_ThoiGianDenShop"
                case pThongTinNCCURLTracking = "p_ThongTinNCC_URLTracking"
                case btnXacNhanXuatKho = "btn_XacNhanXuatKho"
                case btnBatDauGiaoHang = "btn_BatDauGiaoHang"
                case btnFRTGiao = "btn_FRTGiao"
                case btnHuyGiaoHang = "btn_HuyGiaoHang"
                case btnKhachNhanHang = "btn_KhachNhanHang"
                case btnKhachKhongNhanHang = "btn_KhachKhongNhanHang"
                case btnXacNhanNhapKho = "btn_XacNhanNhapKho"
                case pThongTinNguoiNhanName = "p_ThongTinNguoiNhan_Name"
                case pThongTinNguoiNhanSDT = "p_ThongTinNguoiNhan_SDT"
                case pThongTinNguoiNhanAddress = "p_ThongTinNguoiNhan_Address"
                case pThongTinNguoiNhanDate = "p_ThongTinNguoiNhan_Date"
            }
    }
}
