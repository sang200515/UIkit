//
//  GetSOByUserResult.swift
//  NewmDelivery
//
//  Created by sumi on 3/23/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetSOByUserResult: NSObject {
    
    var ID : String
    var Code: String
    var UserName : String
    var EmpName: String
    var BookDate : String
    var WHConfirmed: String
    var WHDate : String
    var RejectReason: String
    var RejectDate: String
    var PaymentType: String
    var FinishLatitude : String
    var FinishLongitude: String
    var FinishTime : String
    var PaidConfirmed: String
    var PaidDate : String
    var OrderStatus: String
    var DocEntry : String
    var U_NuBill: String
    var U_ReveRe : String
    var U_CrdName: String
    var U_CAddress: String
    var U_CPhone: String
    var U_SyBill : String
    var U_CrDate: String
    var U_Desc: String
    var U_TMonPr : String
    var U_MonPer: String
    var U_TMonTx : String
    var U_DownPay: String
    var U_TMonBi : String
    var U_Receive: String
    var U_AdrDel : String
    var U_Phone: String
    var U_DateDe : String
    var U_NumEcom: String
    var U_ShpCode: String
    var U_Deposit: String
    var U_PaidMoney : String
    var SourceType: String
    var RowVersion: String
    var mType: String
    var Is_CN : String
    var HTTT_FF: String
    var ImgUrl_PDK_MatTruocCMND : String
    var ImgUrl_PDK_MatSauCMND: String
    var ImgUrl_GiayUyQuyen_MatSauCMND : String
    var ImgUrl_GiayThayDoiChuKy: String
    var CMND : String
    var Ten_DN: String
    var SM_ChiuTrachNhiem : String
    var Is_Upload_TGH: String
    var Is_Upload_NKH: String
    var Is_Upload_PGH: String
    var _WHConfirmed_MaTen:String
    
    
    var ImgUrl_TGH: String
    var ImgUrl_NKH: String
    var ImgUrl_PGH: String
    var ImgUrl_TTD: String
    var ReturnReason: String
    var SoTienTraTruoc:String
    var mCreateType:String
    var ImgUrl_MatTruocCMND:String
    var ImgUrl_HDTC1:String
    var ContentWork:String
    var UserBookCode:String
    var InstallLocation:String
    var U_ShopName:String
    var UserBookName:String
    var ImgUploadTime:String
    var ImgUrl_XNGH:String
    var Ma_HD:String
    var is_fado:String
    var otp_fado:String
    var Partner_code: String
    var Partner_name: String
    var p_TabName: String
    var p_NguoiGiao: String
    var p_TrangThaiGiaoHang: String
    var p_TrangThaiDonHang: String
    var p_ThongTinNCC_TaiXe_Ten: String
    var p_ThongTinNCC_TaiXe_SDT: String
    var p_ThongTinNCC_TaiXe_ThoiGianDenShop: String
    var btn_BatDauGiaoHang: String
    var btn_HuyGiaoHang: String
    var p_ThongTinNCC_URLTracking: String
    var btn_XacNhanXuatKho: String
    var p_ThongTinNCC_TransactionCode: String
    var U_AdrDel_New: String
    var p_LoaiDonHang: String
    var btn_XacNhanNhapKho: String
    var btn_FRTGiao: String
    var p_ThongTinNguoiNhan_Date: String
    var CreateDateTime: String
    var p_ThongTinNguoiNhan_Name: String
    var p_ThongTinNguoiNhan_SDT: String
    var p_ThongTinNguoiNhan_Address: String
    var DeliveryDateTime: String
    var MaShopNhoGiaoHang: String
    var p_ShopXuat: String
    var p_ShopGiaoHo: String
    var btn_KhachNhanHang: String
    var btn_KhachKhongNhanHang: String
    var p_ThongTinNCC_Delivery_Id: String
    
    init(GetSOByUserResult: JSON)
    {
        p_ThongTinNCC_Delivery_Id = GetSOByUserResult["p_ThongTinNCC_Delivery_Id"].stringValue
        ID = GetSOByUserResult["ID"].stringValue;
        Code = GetSOByUserResult["Code"].stringValue;
        UserName = GetSOByUserResult["UserName"].stringValue;
        EmpName = GetSOByUserResult["EmpName"].stringValue;
        BookDate = GetSOByUserResult["BookDate"].stringValue;
        WHConfirmed = GetSOByUserResult["WHConfirmed"].stringValue;
        WHDate = GetSOByUserResult["WHDate"].stringValue;
        RejectReason = GetSOByUserResult["RejectReason"].stringValue;
        RejectDate = GetSOByUserResult["RejectDate"].stringValue;
        PaymentType = GetSOByUserResult["PaymentType"].stringValue;
        FinishLatitude = GetSOByUserResult["FinishLatitude"].stringValue;
        FinishLongitude = GetSOByUserResult["FinishLongitude"].stringValue;
        FinishTime = GetSOByUserResult["FinishTime"].stringValue;
        PaidConfirmed = GetSOByUserResult["PaidConfirmed"].stringValue;
        PaidDate = GetSOByUserResult["PaidDate"].stringValue;
        OrderStatus = GetSOByUserResult["OrderStatus"].stringValue;
        DocEntry = GetSOByUserResult["DocEntry"].stringValue;
        U_NuBill = GetSOByUserResult["U_NuBill"].stringValue;
        U_ReveRe = GetSOByUserResult["U_ReveRe"].stringValue;
        U_CrdName = GetSOByUserResult["U_CrdName"].stringValue;
        U_CAddress = GetSOByUserResult["U_CAddress"].stringValue;
        U_CPhone = GetSOByUserResult["U_CPhone"].stringValue;
        U_SyBill = GetSOByUserResult["U_SyBill"].stringValue;
        U_CrDate = GetSOByUserResult["U_CrDate"].stringValue;
        U_Desc = GetSOByUserResult["U_Desc"].stringValue;
        U_TMonPr = GetSOByUserResult["U_TMonPr"].stringValue;
        U_MonPer = GetSOByUserResult["U_MonPer"].stringValue;
        U_TMonTx = GetSOByUserResult["U_TMonTx"].stringValue;
        U_DownPay = GetSOByUserResult["U_DownPay"].stringValue;
        U_TMonBi = GetSOByUserResult["U_TMonBi"].stringValue;
        U_Receive = GetSOByUserResult["U_Receive"].stringValue;
        U_AdrDel = GetSOByUserResult["U_AdrDel"].stringValue;
        U_Phone = GetSOByUserResult["U_Phone"].stringValue;
        U_DateDe = GetSOByUserResult["U_DateDe"].stringValue;
        U_NumEcom = GetSOByUserResult["U_NumEcom"].stringValue;
        U_ShpCode = GetSOByUserResult["U_ShpCode"].stringValue;
        U_Deposit = GetSOByUserResult["U_Deposit"].stringValue;
        U_PaidMoney = GetSOByUserResult["U_PaidMoney"].stringValue;
        SourceType = GetSOByUserResult["SourceType"].stringValue;
        RowVersion = GetSOByUserResult["RowVersion"].stringValue;
        mType = GetSOByUserResult["Type"].stringValue;
        Is_CN = GetSOByUserResult["Is_CN"].stringValue;
        HTTT_FF = GetSOByUserResult["HTTT_FF"].stringValue;
        ImgUrl_PDK_MatTruocCMND = GetSOByUserResult["ImgUrl_PDK_MatTruocCMND"].stringValue;
        ImgUrl_PDK_MatSauCMND = GetSOByUserResult["ImgUrl_PDK_MatSauCMND"].stringValue;
        ImgUrl_GiayUyQuyen_MatSauCMND = GetSOByUserResult["ImgUrl_GiayUyQuyen_MatSauCMND"].stringValue;
        ImgUrl_GiayThayDoiChuKy = GetSOByUserResult["ImgUrl_GiayThayDoiChuKy"].stringValue;
        CMND = GetSOByUserResult["CMND"].stringValue;
        Ten_DN = GetSOByUserResult["Ten_DN"].stringValue;
        SM_ChiuTrachNhiem = GetSOByUserResult["SM_ChiuTrachNhiem"].stringValue;
        Is_Upload_TGH = GetSOByUserResult["Is_Upload_TGH"].stringValue;
        Is_Upload_NKH = GetSOByUserResult["Is_Upload_NKH"].stringValue;
        Is_Upload_PGH = GetSOByUserResult["Is_Upload_PGH"].stringValue;
        _WHConfirmed_MaTen = GetSOByUserResult["_WHConfirmed_MaTen"].stringValue;
        ImgUrl_TGH = GetSOByUserResult["ImgUrl_TGH"].stringValue;
        ImgUrl_NKH = GetSOByUserResult["ImgUrl_NKH"].stringValue;
        ImgUrl_PGH = GetSOByUserResult["ImgUrl_PGH"].stringValue;
        ReturnReason = GetSOByUserResult["ReturnReason"].stringValue;
        SoTienTraTruoc = GetSOByUserResult["SoTienTraTruoc"].stringValue;
        mCreateType = GetSOByUserResult["CreateType"].stringValue;
        ImgUrl_TTD =  GetSOByUserResult["ImgUrl_TTD"].stringValue;
        ImgUrl_MatTruocCMND = GetSOByUserResult["ImgUrl_MatTruocCMND"].stringValue;
        ImgUrl_HDTC1 = GetSOByUserResult["ImgUrl_HDTC1"].stringValue;
        ContentWork = GetSOByUserResult["ContentWork"].stringValue;
        UserBookCode = GetSOByUserResult["UserBookCode"].stringValue;
        InstallLocation = GetSOByUserResult["InstallLocation"].stringValue
        U_ShopName = GetSOByUserResult["U_ShopName"].stringValue
        UserBookName = GetSOByUserResult["UserBookName"].stringValue
        ImgUploadTime = GetSOByUserResult["ImgUploadTime"].stringValue
        ImgUrl_XNGH = GetSOByUserResult["ImgUrl_XNGH"].stringValue
        Ma_HD = GetSOByUserResult["Ma_HD"].stringValue
        is_fado = GetSOByUserResult["is_fado"].stringValue
        otp_fado = GetSOByUserResult["otp_fado"].stringValue
        Partner_code = GetSOByUserResult["Partner_code"].stringValue
        Partner_name = GetSOByUserResult["Partner_name"].stringValue
        p_TabName = GetSOByUserResult["p_TabName"].stringValue
        p_NguoiGiao = GetSOByUserResult["p_NguoiGiao"].stringValue
        p_TrangThaiGiaoHang = GetSOByUserResult["p_TrangThaiGiaoHang"].stringValue
        p_TrangThaiDonHang = GetSOByUserResult["p_TrangThaiDonHang"].stringValue
        p_ThongTinNCC_TaiXe_Ten = GetSOByUserResult["p_ThongTinNCC_TaiXe_Ten"].stringValue
        p_ThongTinNCC_TaiXe_SDT = GetSOByUserResult["p_ThongTinNCC_TaiXe_SDT"].stringValue
        p_ThongTinNCC_TaiXe_ThoiGianDenShop = GetSOByUserResult["p_ThongTinNCC_TaiXe_ThoiGianDenShop"].stringValue
        btn_BatDauGiaoHang = GetSOByUserResult["btn_BatDauGiaoHang"].stringValue
        btn_HuyGiaoHang = GetSOByUserResult["btn_HuyGiaoHang"].stringValue
        p_ThongTinNCC_URLTracking = GetSOByUserResult["p_ThongTinNCC_URLTracking"].stringValue
        btn_XacNhanXuatKho = GetSOByUserResult["btn_XacNhanXuatKho"].stringValue
        p_ThongTinNCC_TransactionCode = GetSOByUserResult["p_ThongTinNCC_TransactionCode"].stringValue
        U_AdrDel_New = GetSOByUserResult["U_AdrDel_New"].stringValue
        p_LoaiDonHang = GetSOByUserResult["p_LoaiDonHang"].stringValue
        btn_XacNhanNhapKho = GetSOByUserResult["btn_XacNhanNhapKho"].stringValue
        btn_FRTGiao = GetSOByUserResult["btn_FRTGiao"].stringValue
        p_ThongTinNguoiNhan_Date = GetSOByUserResult["p_ThongTinNguoiNhan_Date"].stringValue
        CreateDateTime = GetSOByUserResult["CreateDateTime"].stringValue
        p_ThongTinNguoiNhan_Name = GetSOByUserResult["p_ThongTinNguoiNhan_Name"].stringValue
        p_ThongTinNguoiNhan_SDT = GetSOByUserResult["p_ThongTinNguoiNhan_SDT"].stringValue
        p_ThongTinNguoiNhan_Address = GetSOByUserResult["p_ThongTinNguoiNhan_Address"].stringValue
        DeliveryDateTime = GetSOByUserResult["DeliveryDateTime"].stringValue
        
        MaShopNhoGiaoHang = GetSOByUserResult["MaShopNhoGiaoHang"].stringValue
        p_ShopXuat = GetSOByUserResult["p_ShopXuat"].stringValue
        p_ShopGiaoHo = GetSOByUserResult["p_ShopGiaoHo"].stringValue
        btn_KhachNhanHang = GetSOByUserResult["btn_KhachNhanHang"].stringValue
        btn_KhachKhongNhanHang = GetSOByUserResult["btn_KhachKhongNhanHang"].stringValue
    }
    
    
}


