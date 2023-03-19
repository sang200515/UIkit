//
//  mSMApiService.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 07/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import Moya;

enum mSMApiService {
    //Get notification
    case GetNotification(username: String);
    //User timekeeping
    case GetUserCheckinResult(userID: String);
    case GetUserCheckinV2Result(userID: String);
    case GetUserCheckoutResult(userID: String);
    case GetUserShiftList(userID: String);
    case SendUserCheckinRequest(userID: String, shiftCode: String, type: String);
    case SendUserCheckoutRequest(userID: String, shiftCode: String, type: String);
    case SendASMAgreementCheck(username: String, shopIP: String, checkingType: String);
    //IpChecking
    case GetIPCheckingResult(params:[String:String]);
    case GetShopInfo;
    //Phonebook
    case GetContactByKeyword(keyword: String);
    //Report
    case GetShopByUser(username: String);
    case GetDiscountLoanReport(shopCode: String);
    case GetDiscountFundReport(username: String);
    case GetFFriendInstallReport(username: String);
    case GetPendingRequestReport(username: String);
    case GetNotBoughtCompanyReport(username: String);
    case GetTotalLoanByShop(username: String);
    case GetFFriendsOrder(username: String);
    case GetVoucherImg(username: String);
    case GetOrderImg(username: String);
    case GetConfidentFund(username: String);
    case GetOverDateWarranty(username: String, shopCode: String);
    case GetOverProduct(username: String, shopCode: String);
    case GetCameraReport(username: String);
    case GetTargetCustomerCare(username: String);
    case GetRemainOldDevice60Report(username: String, shopCode: String);
    case GetOverDeviceReport(username: String, shopCode: String);
    case GetRemainDeviceByCategory(username: String, shopCode: String);
    case GetAccessoryRealtimeReport(username: String);
    case GetAccessoryRealtimeByZone(username: String);
    case GetAccessoryRealtimeByArea(username: String);
    case GetAccessoryRealtimeByShop(username: String);
    case GetSalemanReport(username: String, shopCode: String, token: String);
    case GetShopSalesByCategory(username: String, shopCode: String, token: String);
    case GetShopSalesByShop(username: String, token: String);
    case GetAPRSales(username: String);
    case GetShopSalesByArea(username: String, token: String);
    case GetShopSalesByZone(username: String, token: String);
    case GetShopSalesRealtime(username: String, token: String);
    case GetLoanRealtimeByZone(username: String, token: String);
    case GetLoanRealtimeByShop(username: String, token: String);
    case GetLoanRealtime(username: String, token: String);
    case GetAreaSalesRealtime(username: String, token: String);
    case GetZoneSalesRealtime(username: String, token: String);
    case GetDeviceNotSold(username: String);
    case GetUnpaidLoan(shopCode: String);
    case GetUpgradeLoan(shopCode: String);
    case GetInstallmentRateByShop(username: String);
    case GetInstallmentRateByZone(username: String);
    case GetInstallmentRateByLender(username: String);
    case GetG38ShopSalesRealtime(username: String, token: String);
    case GetG38ShopSalesMTD(username: String, token: String);
    case GetASMAgreementReport(username: String, reportDate: String);
    case GetOpenedAccountPending(username: String, reportDate: String, reportMonth: String, reportYear: String, type: String);
    case GetOpenedAccountCompleted(username: String, reportDate: String, reportMonth: String, reportYear: String, type: String);
    case GetOpenedAccountPendingDetails(reportDate: String, reportMonth: String, reportYear: String, shopCode: String);
    case GetOpenedAccountCompletedDetails(reportDate: String, reportMonth: String, reportYear: String, shopCode: String)
    case GetTargetReport(shopCode: String, month: String, year: String, username: String, token: String);
    case SendTargetReportData(shopCode: String, username: String, id: String, employeeCode: String, month: String, year: String, workingDate: String, targetDS: String, targetPK: String, note: String);
    case RequestTargetReportDelete(id: String, username: String);
    case GetHealthReport(id: String, level: String, shopCode: String, type: String);
    case GetTrafficReport(username: String, type: String);
    case GetReportSections(userCode: String, token: String);
    case GetViolationMember(employeeCode: String);

    //Bao cao combo PK realtime
    
    case GetComboPKRealtimeVung(username: String, token: String);
    case GetComboPKRealtimeASM(username: String, token: String);
    case GetComboPKRealtimeShop(username: String, token: String);

    case GiaTriCotLoi
    case getListDoanhNghiep(username: String);
    case getListCallogPending(username: String);
    case getTLDuyetTrongThang(username: String);
    case getTLDuyetTheoTungThang(username: String, vendorCode: Int);
    
    //Bao cao ListDoanhSo_Realtime_SL_May
    case getListDoanhSo_Realtime_SL_May_Vung(username: String, loai: String, token: String);
    case getListDoanhSo_Realtime_SL_May_Khuvuc(username: String, loai: String, token: String);
    case getListDoanhSo_Realtime_SL_May_Shop(username: String, loai: String, token: String);
    
    //Bao cao Luy ke_SL_May
    case getLuyLe_SL_May_Vung(username: String, loai: String, token: String);
    case getLuyLe_SL_May_Khuvuc(username: String, loai: String, token: String);
    case getLuyLe_SL_May_Shop(username: String, loai: String, token: String);
    
    //BC SL SIM
    
    case getSL_SIM_Vung(username: String, token: String);
    case getSL_SIM_khuvuc(username: String, token: String);
    case getSL_SIM_Shop(username: String, token: String);
    //    //BC Ty Le SIM
    case getTyLe_SIM_Vung(username: String, token: String);
    case getTyLe_SIM_Khuvuc(username: String, token: String);
    case getTyLe_SIM_Shop(username: String, token: String);

    //SL iphone14
    case getSL_iphone14_Vung(username: String, token: String);
    case getSL_iphone14_khuvuc(username: String, token: String);
    case getSL_iphone14_Shop(username: String, token: String);
    //    //BC Tra gop
    case getTraGopVungMien_Team_PTNH_Vung(username: String, token: String);
    case getTraGopVungMien_Team_PTNH_KhuVuc(username: String, token: String);
    case getTraGopVungMien_Team_PTNH_Shop(username: String, token: String);
    //    //BC Tra gop Realtime
    case TraGopVungMien_Realtime_Team_PTNH_Vung(username: String, token: String);
    case TraGopVungMien_Realtime_Team_PTNH_KhuVuc(username: String, token: String);
    case TraGopVungMien_Realtime_Team_PTNH_Shop(username: String, token: String);
    
    //BC Tra coc
    case getSoCoc(username: String);
    
    //Luỹ Kế Số lượt - Lãi gộp DV Thu Hộ
    
    case ThanhToanHoaDon_CRM001_Vung(username: String, token: String);
    case ThanhToanHoaDon_CRM001_KhuVuc(username: String, token: String);
    case ThanhToanHoaDon_CRM001_Shop(username: String, token: String);
    
    //    Khai thác KH CRM - CTKM tặng 50K
    
    case KhaiThacKH_CRM_CTKM_Vung(username: String, token: String);
    case KhaiThacKH_CRM_CTKM_KhuVuc(username: String, token: String);
    case KhaiThacKH_CRM_CTKM_Shop(username: String, token: String);

    //NhapChiTieuDoanhSo_Save
    case NhapChiTieuDoanhSo_Report(params:[String:String])
    case NhapChiTieuDoanhSo_Save(params:[String:String])
    
    //Visitor
    case sp_mpos_Report_FRT_Visitor_Report(params: [String: String])
    case Report_FRT_SP_Visitor_Report_V2(params: [String: String])
    case Report_FRT_SP_Visitor_Report_TheoDoiShop(params: [String: String])
    //Check list shop ASM
    case LoadShopByASM(params: [String: String])
    case CheckListShop_insert(params: [String: String])
    case Checklistshop_ASM_get(params: [String: String])
    case Checklist_ASM_confirm(params: [String: String])

//    KhaiThacCombo
    case KhaiThacCombo_LuyKe(params: [String: String])
    case KhaiThacCombo_HomQua(params: [String: String])
    
    // DS vung realtime
    case ListDoanhSo_Realtime_Vung_NotDA(params: [String: String])
    // DS mat kinh realtime
    case ListDoanhSo_MatKinh_Realtime_Shop_View_Final(params: [String: String])
    // DS my pham realtime
    case ListDoanhSo_Realtime_ShopMyPham(params: [String: String])
    // DS dong ho realtime
    case ListDoanhSo_DongHo_Realtime_Shop(params: [String: String])
    
    //Virus - BHMR
    case ListSP_Realtime_SLSP_Virus_ASM_View(params: [String: String])
    case ListSP_Realtime_SLSP_Virus_Shop_View(params: [String: String])
    case ListSP_Realtime_SLSP_Virus_Vung_View(params: [String: String])
    
    case ListSP_Realtime_SLSP_BHMR_ASM_View(params: [String: String])
    case ListSP_Realtime_SLSP_BHMR_Shop_View(params: [String: String])
    case ListSP_Realtime_SLSP_BHMR_Vung_View(params: [String: String])
    
    //LUY KE Virus - BHMR
    case ListSP_LuyKe_SLSP_Virus_ASM_View(params: [String: String])
    case ListSP_LuyKe_SLSP_Virus_Shop_View(params: [String: String])
    case ListSP_LuyKe_SLSP_Virus_Vung_View(params: [String: String])
    case ListSP_LuyKe_SLSP_BHMR_ASM_View(params: [String: String])
    case ListSP_LuyKe_SLSP_BHMR_Shop_View(params: [String: String])
    case ListSP_LuyKe_SLSP_BHMR_Vung_View(params: [String: String])
    
    //VeMaybay
    case ListSP_LuyKe_VeMayBay_Shop_View(params: [String: String])
    case ListSP_LuyKe_VeMayBay_ASM_View(params: [String: String])
    case ListSP_LuyKe_VeMayBay_Vung_View(params: [String: String])
    case ListSP_Realtime_VeMayBay_Shop_View(params: [String: String])
    case ListSP_Realtime_VeMayBay_ASM_View(params: [String: String])
    case ListSP_Realtime_VeMayBay_Vung_View(params: [String: String])
    
    //ShopMyPham_Saleman
    case ListDoanhSo_ShopMyPham_View_Final(params: [String: String])
    case DoanhSoShop_MyPhamSaleman_View(params: [String: String])
    case DoanhSoShop_MyPhamSaleman_View_New(params: [String: String])
    case FRT_usp_RP_PRO1_FR_FR124(params: [String: String])
    
    //BHMR NewTest
    case ListSP_LuyKe_SLSP_BHMR_ASM_View_NewTest(params: [String: String])
    case ListSP_LuyKe_SLSP_BHMR_Shop_View_NewTest(params: [String: String])
    case ListSP_LuyKe_SLSP_BHMR_Vung_View_NewTest(params: [String: String])
    case ListSP_Realtime_SLSP_BHMR_Shop_View_NewTest(params: [String: String])
    case ListSP_Realtime_SLSP_BHMR_ASM_View_NewTest(params: [String: String])
    case ListSP_Realtime_SLSP_BHMR_Vung_View_NewTest(params: [String: String])
    
    case msm_KhaiThacMayKemPK(params: [String: String])
    case ListDoanhSo_Realtime_Vung_NotDA_CungKy_View_Final(params: [String: String])
    case msm_RealtimeShopKhaiThacMayKemPK(params: [String: String])
    
    case DoanhSo_TyLePhuKien_Realtime_Vung_View(params: [String: String])
    case DoanhSo_TyLePhuKien_Realtime_KhuVuc_View(params: [String: String])
    case DoanhSo_PhuKien_Iphone_Realtime_Vung_View(params: [String: String])
    case DoanhSo_PhuKien_Iphone_Realtime_KhuVuc_View(params: [String: String])
    
    case DoanhSo_Iphone_ComboPK_Realtime_GetData_Model(params: [String: String])
    case DoanhSo_Iphone_ComboPK_Realtime_GetData_Vung(params: [String: String])
    case DoanhSo_Iphone_ComboPK_Realtime_GetData_ASM(params: [String: String])
    
    //Track thao tác user
    case trackUserActivity(params: [String: String])
}

extension mSMApiService: TargetType{
    var baseURL: URL {
        switch self {
        case .GetDiscountFundReport:
            return URL(string: Config.manager.URL_GATEWAY + "/mpos-cloud-msm")! // just beta need production
        case .GetUserCheckinResult,
             .GetUserCheckinV2Result,
             .GetUserCheckoutResult,
             .GetUserShiftList,
             .SendUserCheckinRequest,
             .SendUserCheckoutRequest,
             .GetNotification,
             .GetContactByKeyword,
             .GetOverDeviceReport,
             .GetOverProduct,
             .GetRemainDeviceByCategory,
             .GetConfidentFund,
             .GetDiscountLoanReport,
             .GetCameraReport,
             .GetFFriendInstallReport,
             .GetOrderImg,
             .GetVoucherImg,
             .GetPendingRequestReport,
             .GetFFriendsOrder,
             .GetTotalLoanByShop,
             .GetOverDateWarranty,
             .GetShopSalesByCategory:
            return URL(string: Config.manager.URL_GATEWAY + "/mpos-cloud-callogapi")!;
            
        case .GetIPCheckingResult,
             .GetShopInfo,
             .sp_mpos_Report_FRT_Visitor_Report,
             .Report_FRT_SP_Visitor_Report_V2,
             .Report_FRT_SP_Visitor_Report_TheoDoiShop:
            return URL(string: "\(Config.manager.URL_GATEWAY!)")!
        case .trackUserActivity:
            return URL(string: "\(Config.manager.URL_GATEWAY!)/mpos-cloud-api")!
        default:
            return URL(string: Config.manager.URL_GATEWAY + "/mpos-cloud-msm")!;
        }
    }
    
    var path: String {
        switch self {
        case .GetIPCheckingResult:
            return "/mpos-cloud-api/api/Notification/masm_sp_checkIP"
        case .GetUserCheckinV2Result:
            return "/MSM/Service.svc/checkUserCheckInV2"
        case .GetContactByKeyword:
            return "/MSM/Service.svc/searchContacts";
        case .GetReportSections:
            return "/MSM/Service.svc/getPosition_ByUserCode";
        case .GetUserCheckinResult:
            return "/MSM/Service.svc/checkUserCheckInV2";
        case .GetUserCheckoutResult:
            return "/MSM/Service.svc/checkUserCheckOut";
        case .GetUserShiftList:
            return "/MSM/Service.svc/getListShiftDate";
        case .SendUserCheckinRequest:
            return "/MSM/Service.svc/insertCheckIn";
        case .SendUserCheckoutRequest:
            return "/MSM/Service.svc/insertCheckOut";
        case .GetNotification:
            return "/MCallLog/Service.svc/getUserCallLogThongBao";
        case .GetShopByUser:
            return "/mSM/Service.svc/GetShop_ByUser";
        case .GetDiscountLoanReport:
            return "/MSM/Service.svc/getReportV2BaoCaoNoKhuyenMai";
        case .GetDiscountFundReport:
            return "/mSM/Service.svc/msm_getDuyetGiamGia";
        case .GetFFriendInstallReport:
            return "/MSM/Service.svc/getCaiDatFFriends";
        case .GetPendingRequestReport:
            return "/MSM/Service.svc/msm_sp_CallLog_GetDonHangPending";
        case .GetNotBoughtCompanyReport:
            return "/MSM/Service.svc/msm_sp_CallLog_GetDoanhNghiepChuaMuaHang";
        case .GetTotalLoanByShop:
            return "/MSM/Service.svc/msm_sp_CallLog_GetTongNoTheoShop";
        case .GetFFriendsOrder:
            return "/MSM/Service.svc/msm_sp_CallLog_GetDoanhSoDonHangFF";
        case .GetVoucherImg:
            return "/MSM/Service.svc/msm_sp_getBaoCao_TheoDoi_CallLog_HinhAnh_ChungTu_DonHang_FFriends";
        case .GetOrderImg:
            return "/MSM/Service.svc/msm_sp_getBaoCao_TheoDoi_CallLog_HinhAnh_DonHang_FFriends";
        case .GetConfidentFund:
            return "/MSM/Service.svc/msm_sp_get_BaoCaoChiTietQuyTuTin";
        case .GetOverDateWarranty:
            return "/MSM/Service.svc/getReportV2BaoHanhQuaHan";
        case .GetOverProduct:
            return "/MSM/Service.svc/getReportV2HangOverBan";
        case .GetCameraReport:
            return "/MSM/Service.svc/msm_sp_get_BaoCaoLoiCamera";
        case .GetTargetCustomerCare:
            return "/mSM/Service.svc/Get_DiemCSKHWELoveFPTShop2";
        case .GetRemainOldDevice60Report:
            return "/MSM/Service.svc/getReportV2TonKhoMayCuOver60";
        case .GetOverDeviceReport:
            return "/MSM/Service.svc/getReportV2HangOver";
        case .GetRemainDeviceByCategory:
            return "/MSM/Service.svc/getReportV2TonKho";
        case .GetAccessoryRealtimeReport:
            return "/mSM/Service.svc/Report_DoanhSo_PK_Realtime";
        case .GetAccessoryRealtimeByZone:
            return "/mSM/Service.svc/Report_DoanhSo_PK_Realtime_Vung";
        case .GetAccessoryRealtimeByArea:
            return "/mSM/Service.svc/Report_DoanhSo_PK_Realtime_KhuVuc";
        case .GetAccessoryRealtimeByShop:
            return "/mSM/Service.svc/Report_DoanhSo_PK_Realtime_Shop";
        case .GetSalemanReport:
            return "/MSM/Service.svc/Get_DoanhSo_TheoSaleman";
        case .GetShopSalesByCategory:
            return "/MSM/Service.svc/getReportV2DoanhSoShop";
        case .GetShopSalesByShop:
            return "/MSM/Service.svc/Get_DoanhSoShop_TheoShop";
        case .GetAPRSales:
            return "/MSM/Service.svc/Get_DoanhSoShop_APR_TheoShop";
        case .GetShopSalesByArea:
            return "/MSM/Service.svc/Get_DoanhSoShop_TheoKhuVuc";
        case .GetShopSalesByZone:
            return "/MSM/Service.svc/Get_DoanhSoShop_TheoVung";
        case .GetShopSalesRealtime:
            return "/MSM/Service.svc/Get_DoanhSoShopRealTime";
        case .GetLoanRealtimeByZone:
            return "/MSM/Service.svc/TraGop_VungMien_KhuVuc";
        case .GetLoanRealtimeByShop:
            return "/MSM/Service.svc/TraGop_VungMien_Shop";
        case .GetLoanRealtime:
            return "/MSM/Service.svc/Report_NganhHangTraGop";
        case .GetAreaSalesRealtime:
            return "/MSM/Service.svc/Get_DoanhSoKhuVucRealTime";
        case .GetZoneSalesRealtime:
            return "/MSM/Service.svc/Get_DoanhSoVungRealTime";
        case .GetDeviceNotSold:
            return "/mSM/Service.svc/UyQuyenShop_MayTren50TR";
        case .GetUnpaidLoan:
            return "/mSM/Service.svc/BaoCaoSoNo";
        case .GetInstallmentRateByShop:
            return "/mSM/Service.svc/TyLeDuyetShop_View";
        case .GetInstallmentRateByZone:
            return "/mSM/Service.svc/TyLeDuyetVung_View";
        case .GetInstallmentRateByLender:
            return "/mSM/Service.svc/TyLeDuyetNhaTraGop_View";
        case .GetG38ShopSalesRealtime:
            return "/mSM/Service.svc/DoanhSoShop_G38_PK_View";
        case .GetG38ShopSalesMTD:
            return "/mSM/Service.svc/DoanhSoShop_G38_View";
        case .GetASMAgreementReport:
            return "/mSM/Service.svc/Report_XacNhan_NhacNho_ASM";
        case .GetOpenedAccountPending:
            return "/mSM/Service.svc/Report_OpenCreditCard_Pending";
        case .GetOpenedAccountCompleted:
            return "/mSM/Service.svc/Report_OpenCreditCard_Complete";
        case .GetTargetReport:
            return "/mSM/Service.svc/NhapChiTieuDoanhSo_Report";
        case .SendTargetReportData:
            return "/mSM/Service.svc/NhapChiTieuDoanhSo_Save";
        case .RequestTargetReportDelete:
            return "/mSM/Service.svc/NhapChiTieuDoanhSo_Delete";
        case .GetHealthReport:
            return "/mSM/Service.svc/ChiSoDoLuong_Shop_Get";
        case .GetTrafficReport:
            return "/mSM/Service.svc/Traffic";
        case .GetViolationMember:
            return "/mSM/Service.svc/ViolationReport";
        case .GetOpenedAccountPendingDetails:
            return "/mSM/Service.svc/Report_OpenCreditCard_Pending_Detail";
        case .GetOpenedAccountCompletedDetails:
            return "/mSM/Service.svc/Report_OpenCreditCard_Complete_Detail";
        case .SendASMAgreementCheck:
            return "/mSM/Service.svc/XacNhan_NhacNho_ASM";
        case .GetShopInfo:
            return "/mpos-cloud-api/api/Notification/masm_sp_GetShopInfo"
        case .GetUpgradeLoan:
            return "/mSM/Service.svc/LenDoi_TraGop_Shop_View";
            
            //Bao cao combo PK realtime
        case .GetComboPKRealtimeVung:
            return "/mSM/Service.svc/TyLeComboPhuKien_Realtime_Vung_View";
        case .GetComboPKRealtimeASM:
            return "/mSM/Service.svc/TyLeComboPhuKien_Realtime_KhuVuc_View";
        case .GetComboPKRealtimeShop:
            return "/mSM/Service.svc/TyLeComboPhuKien_Realtime_Shop_View";

        case .GiaTriCotLoi:
            return "/mSM/Service.svc/GiaTriCotLoi"


            
            //BC FFriends
        case .getListDoanhNghiep:
            return "/mSM/Service.svc/Report__CustReq__GetVend"
        case .getListCallogPending:
            return "/mSM/Service.svc/Report__CustReq__Pending"
        case .getTLDuyetTrongThang:
            return "/mSM/Service.svc/Report__CustReq__Rat__CurrMonth"
        case .getTLDuyetTheoTungThang:
            return "/mSM/Service.svc/Report__CustReq__Rat__PerMonth"
            
            
            
        //Bao cao Luy ke_SL_May
        case .getLuyLe_SL_May_Vung:
            return "/mSM/Service.svc/LuyKe_SL_May_Vung_View_Final"
        case .getLuyLe_SL_May_Khuvuc:
            return "/mSM/Service.svc/LuyKe_SL_May_KhuVuc_View_Final"
        case .getLuyLe_SL_May_Shop:
            return "/mSM/Service.svc/LuyKe_SL_May_Shop_View_Final"
            
        //BC SL SIM
        case .getSL_SIM_Vung:
            return "/mSM/Service.svc/ListDoanhSo_Realtime_SL_SIM_Vung_View_Final"
        case .getSL_SIM_khuvuc:
            return "/mSM/Service.svc/ListDoanhSo_Realtime_SL_SIM_khuvuc_View_Final"
        case .getSL_SIM_Shop:
            return "/mSM/Service.svc/ListDoanhSo_Realtime_SL_SIM_Shop_View_Final"
            
        //    //BC Ty Le SIM
        case .getTyLe_SIM_Vung:
            return "/mSM/Service.svc/LuyKe_SL_SIM_Vung_View_Final"
        case .getTyLe_SIM_Khuvuc:
            return "/mSM/Service.svc/LuyKe_SL_SIM_KhuVuc_View_Final"
        case .getTyLe_SIM_Shop:
            return "/mSM/Service.svc/LuyKe_SL_SIM_Shop_View_Final"

                    //BC SL iphone 14
            case .getSL_iphone14_Vung:
                return "/mSM/Service.svc/ComboIPhone14Series_Realtime_Vung_View_Final"
            case .getSL_iphone14_khuvuc:
                return "/mSM/Service.svc/ComboIPhone14Series_Realtime_ASM_View_Final"
            case .getSL_iphone14_Shop:
                return "/mSM/Service.svc/ComboIPhone14Series_Realtime_Shop_View_Final"

        //Bao cao ListDoanhSo_Realtime_SL_May
        case .getListDoanhSo_Realtime_SL_May_Vung:
            return "/mSM/Service.svc/ListDoanhSo_Realtime_SL_May_Vung_View_Final"
        case .getListDoanhSo_Realtime_SL_May_Khuvuc:
            return "/mSM/Service.svc/ListDoanhSo_Realtime_SL_May_KhuVuc_View_Final"
        case .getListDoanhSo_Realtime_SL_May_Shop:
            return "/mSM/Service.svc/ListDoanhSo_Realtime_SL_May_Shop_View_Final"
            
        //Bao cao Tra gop
        case .getTraGopVungMien_Team_PTNH_Vung:
            return "/mSM/Service.svc/TraGopVungMien_Team_PTNH_Vung_View"
        case .getTraGopVungMien_Team_PTNH_KhuVuc:
            return "/mSM/Service.svc/TraGopVungMien_Team_PTNH_KhuVuc_View"
        case .getTraGopVungMien_Team_PTNH_Shop:
            return "/mSM/Service.svc/TraGopVungMien_Team_PTNH_Shop_View"
            
        //    //BC Tra gop Realtime
        case .TraGopVungMien_Realtime_Team_PTNH_Vung:
            return "/mSM/Service.svc/TraGopVungMien_Realtime_Team_PTNH_Vung_View"
        case .TraGopVungMien_Realtime_Team_PTNH_KhuVuc:
            return "/mSM/Service.svc/TraGopVungMien_Realtime_Team_PTNH_KhuVuc_View"
        case .TraGopVungMien_Realtime_Team_PTNH_Shop:
            return "/mSM/Service.svc/TraGopVungMien_Realtime_Team_PTNH_Shop_View"
            
        //BC Tra Coc
        case .getSoCoc:
            return "/mSM/Service.svc/Baocao_MSM_tracoc"
            
            
            //Luỹ Kế Số lượt - Lãi gộp DV Thu Hộ
            
        case .ThanhToanHoaDon_CRM001_Vung:
            return "/mSM/Service.svc/MSM_ThanhToanHoaDon_CRM001_Vung_View"
        case .ThanhToanHoaDon_CRM001_KhuVuc:
            return "/mSM/Service.svc/MSM_ThanhToanHoaDon_CRM001_KhuVuc_View"
        case .ThanhToanHoaDon_CRM001_Shop:
            return "/mSM/Service.svc/MSM_ThanhToanHoaDon_CRM001_Shop_View"
            
            //    Khai thác KH CRM - CTKM tặng 50K
            
        case .KhaiThacKH_CRM_CTKM_Vung:
            return "/mSM/Service.svc/MSM_FRT_MSM_KhaiThacKH_CRM_CTKM_Shop_View"
        case .KhaiThacKH_CRM_CTKM_KhuVuc:
            return "/mSM/Service.svc/FRT_MSM_KhaiThacKH_CRM_CTKM_KhuVuc_View"
        case .KhaiThacKH_CRM_CTKM_Shop:
            return "/mSM/Service.svc/FRT_MSM_KhaiThacKH_CRM_CTKM_Shop_View"
            
            
        //NhapChiTieuDoanhSo_Save
        case .NhapChiTieuDoanhSo_Report:
            return "/mSM/Service.svc/NhapChiTieuDoanhSo_Report"
        case .NhapChiTieuDoanhSo_Save:
            return "/mSM/Service.svc/NhapChiTieuDoanhSo_Save"
            
        //Visitor
        case .sp_mpos_Report_FRT_Visitor_Report:
            return "/mpos-api/api/Report/sp_mpos_Report_FRT_Visitor_Report"
        case .Report_FRT_SP_Visitor_Report_V2:
            return "/mpos-api/api/Report/sp_mpos_Report_FRT_SP_Visitor_Report_V2"
        case .Report_FRT_SP_Visitor_Report_TheoDoiShop:
            return "/mpos-api/api/Report/sp_mpos_Report_FRT_SP_Visitor_Report_TheoDoiShop"
            //Check list shop ASM
        case .LoadShopByASM:
            return "/mSM/Service.svc/FRT_SP_LoadShopByASM"
        case .CheckListShop_insert:
            return "/mSM/Service.svc/FRT_SP_CheckListShop_insert"
        case .Checklistshop_ASM_get:
            return "/mSM/Service.svc/FRT_SP_checklistshop_ASM_get"
        case .Checklist_ASM_confirm:
            return "/mSM/Service.svc/FRT_SP_checklist_ASM_confirm"
            
        //    KhaiThacCombo
        case .KhaiThacCombo_LuyKe:
            return "/mSM/Service.svc/FRT_MSM_KhaiThacCombo_LuyKe_View"
        case .KhaiThacCombo_HomQua:
            return "/mSM/Service.svc/FRT_MSM_KhaiThacCombo_HomQua_View"
            
        // DS vung realtime
        case .ListDoanhSo_Realtime_Vung_NotDA:
            return "/MSM/Service.svc/ListDoanhSo_Realtime_Vung_NotDA_View_Final"
        // DS mat kinh realtime
        case .ListDoanhSo_MatKinh_Realtime_Shop_View_Final:
            return "/MSM/Service.svc/ListDoanhSo_MatKinh_Realtime_Shop_View_Final"
            //DS my pham realtime
        case .ListDoanhSo_Realtime_ShopMyPham:
            return "/mSM/Service.svc/ListDoanhSo_Realtime_ShopMyPham_View_Final"
            //DS dong ho realtime
        case .ListDoanhSo_DongHo_Realtime_Shop:
            return "/mSM/Service.svc/ListDoanhSo_DongHo_Realtime_Shop_View_Final"
            
            //Virus - BHMR
        case .ListSP_Realtime_SLSP_Virus_ASM_View:
            return "/mSM/Service.svc/ListSP_Realtime_SLSP_Virus_ASM_View"
        case .ListSP_Realtime_SLSP_Virus_Shop_View:
            return "/mSM/Service.svc/ListSP_Realtime_SLSP_Virus_Shop_View"
        case .ListSP_Realtime_SLSP_Virus_Vung_View:
            return "/mSM/Service.svc/ListSP_Realtime_SLSP_Virus_Vung_View"
            
        case .ListSP_Realtime_SLSP_BHMR_ASM_View:
            return "/mSM/Service.svc/ListSP_Realtime_SLSP_BHMR_ASM_View"
        case .ListSP_Realtime_SLSP_BHMR_Shop_View:
            return "/mSM/Service.svc/ListSP_Realtime_SLSP_BHMR_Shop_View"
        case .ListSP_Realtime_SLSP_BHMR_Vung_View:
            return "/mSM/Service.svc/ListSP_Realtime_SLSP_BHMR_Vung_View"
            
        //LUY KE Virus - BHMR
        case .ListSP_LuyKe_SLSP_Virus_ASM_View:
            return "/mSM/Service.svc/ListSP_LuyKe_SLSP_Virus_ASM_View"
        case .ListSP_LuyKe_SLSP_Virus_Shop_View:
            return "/mSM/Service.svc/ListSP_LuyKe_SLSP_Virus_Shop_View"
        case .ListSP_LuyKe_SLSP_Virus_Vung_View:
            return "/mSM/Service.svc/ListSP_LuyKe_SLSP_Virus_Vung_View"
            
        case .ListSP_LuyKe_SLSP_BHMR_ASM_View:
            return "/mSM/Service.svc/ListSP_LuyKe_SLSP_BHMR_ASM_View"
        case .ListSP_LuyKe_SLSP_BHMR_Shop_View:
            return "/mSM/Service.svc/ListSP_LuyKe_SLSP_BHMR_Shop_View"
        case .ListSP_LuyKe_SLSP_BHMR_Vung_View:
            return "/mSM/Service.svc/ListSP_LuyKe_SLSP_BHMR_Vung_View"
            
        //        //VeMaybay
        case .ListSP_LuyKe_VeMayBay_Shop_View:
            return "/mSM/Service.svc/ListSP_LuyKe_VeMayBay_Shop_View"
        case .ListSP_LuyKe_VeMayBay_ASM_View:
            return "/mSM/Service.svc/ListSP_LuyKe_VeMayBay_ASM_View"
        case .ListSP_LuyKe_VeMayBay_Vung_View:
            return "/mSM/Service.svc/ListSP_LuyKe_VeMayBay_Vung_View"
            
        case .ListSP_Realtime_VeMayBay_Shop_View:
            return "/mSM/Service.svc/ListSP_Realtime_VeMayBay_Shop_View"
        case .ListSP_Realtime_VeMayBay_ASM_View:
            return "/mSM/Service.svc/ListSP_Realtime_VeMayBay_ASM_View"
        case .ListSP_Realtime_VeMayBay_Vung_View:
            return "/mSM/Service.svc/ListSP_Realtime_VeMayBay_Vung_View"
        //ShopMyPham_Saleman
        case .ListDoanhSo_ShopMyPham_View_Final:
            return "/mSM/Service.svc/ListDoanhSo_ShopMyPham_View_Final"
        case .DoanhSoShop_MyPhamSaleman_View:
            return "/mSM/Service.svc/DoanhSoShop_MyPhamSaleman_View"
        case .DoanhSoShop_MyPhamSaleman_View_New:
            return "/mSM/Service.svc/MSM_DoanhSoShop_MyPhamSaleman_View_mypham"
        case .FRT_usp_RP_PRO1_FR_FR124:
            return "/mSM/Service.svc/FRT_usp_RP_PRO1_FR_FR124"
            
        //BHMR NewTest
        case .ListSP_LuyKe_SLSP_BHMR_ASM_View_NewTest:
            return "/mSM/Service.svc/ListSP_LuyKe_SLSP_BHMR_ASM_View_NewTest"
        case .ListSP_LuyKe_SLSP_BHMR_Shop_View_NewTest:
            return "/mSM/Service.svc/ListSP_LuyKe_SLSP_BHMR_Shop_View_NewTest"
        case .ListSP_LuyKe_SLSP_BHMR_Vung_View_NewTest:
            return "/mSM/Service.svc/ListSP_LuyKe_SLSP_BHMR_Vung_View_NewTest"
            
        case .ListSP_Realtime_SLSP_BHMR_Shop_View_NewTest:
            return "/mSM/Service.svc/ListSP_Realtime_SLSP_BHMR_Shop_View_NewTest"
        case .ListSP_Realtime_SLSP_BHMR_ASM_View_NewTest:
            return "/mSM/Service.svc/ListSP_Realtime_SLSP_BHMR_ASM_View_NewTest"
        case .ListSP_Realtime_SLSP_BHMR_Vung_View_NewTest:
            return "/mSM/Service.svc/ListSP_Realtime_SLSP_BHMR_Vung_View_NewTest"
            
        case .msm_KhaiThacMayKemPK:
            return "/mSM/Service.svc/MSM_usp_RP_PRO1_FR_FR127_Mobile"
        case .ListDoanhSo_Realtime_Vung_NotDA_CungKy_View_Final:
            return "/mSM/Service.svc/ListDoanhSo_Realtime_Vung_NotDA_CungKy_View_Final"
        case .msm_RealtimeShopKhaiThacMayKemPK:
            return "/mSM/Service.svc/ListDoanhSo_Realtime_Shop_KhaiThac_May_PhuKien_View"
            
        case .DoanhSo_TyLePhuKien_Realtime_Vung_View:
            return "/mSM/Service.svc/DoanhSo_TyLePhuKien_Realtime_Vung_View"
        case .DoanhSo_TyLePhuKien_Realtime_KhuVuc_View:
            return "/mSM/Service.svc/DoanhSo_TyLePhuKien_Realtime_KhuVuc_View"
        case .DoanhSo_PhuKien_Iphone_Realtime_Vung_View:
            return "/mSM/Service.svc/DoanhSo_PhuKien_Iphone_Realtime_Vung_View"
        case .DoanhSo_PhuKien_Iphone_Realtime_KhuVuc_View:
            return "/mSM/Service.svc/DoanhSo_PhuKien_Iphone_Realtime_KhuVuc_View"
            
        case .DoanhSo_Iphone_ComboPK_Realtime_GetData_Model:
            return "/mSM/Service.svc/DoanhSo_Iphone_ComboPK_Realtime_GetData_Model"
        case .DoanhSo_Iphone_ComboPK_Realtime_GetData_Vung:
            return "/mSM/Service.svc/DoanhSo_Iphone_ComboPK_Realtime_GetData_Vung"
        case .DoanhSo_Iphone_ComboPK_Realtime_GetData_ASM:
            return "/mSM/Service.svc/DoanhSo_Iphone_ComboPK_Realtime_GetData_ASM"
        
        case .trackUserActivity:
            return "/api/notification/FRT_DeviceInfo_WriteLogEvent"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .GetIPCheckingResult, .GetShopInfo:
            return .get;
        default:
            return .post;
        }
    }
    
    var sampleData: Data {
        return Data();
    }
    
    var task: Task {
        switch self {
        case let .GetIPCheckingResult(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .GetContactByKeyword(let keyword):
            return .requestParameters(parameters: ["keyWords": keyword], encoding: JSONEncoding.default);
        case .GetReportSections(let userCode, let token):
            return .requestParameters(parameters: ["p_UserCode": userCode, "p_Token":token], encoding: JSONEncoding.default);
        case .GetUserCheckinResult(let userID):
            return .requestParameters(parameters: ["userCode": userID], encoding: JSONEncoding.default);
        case .GetUserCheckinV2Result(let userID):
            return .requestParameters(parameters: ["userCode": userID], encoding: JSONEncoding.default);
        case .GetUserCheckoutResult(let userID):
            return .requestParameters(parameters: ["userCode": userID], encoding: JSONEncoding.default);
        case .GetUserShiftList(let userID):
            return .requestParameters(parameters: ["userCode": userID], encoding: JSONEncoding.default);
        case .SendUserCheckinRequest(let userID, let shiftCode, let type):
            return .requestParameters(parameters: ["userCode": userID, "shiftCode": shiftCode, "type": type], encoding: JSONEncoding.default);
        case .SendUserCheckoutRequest(let userID, let shiftCode, let type):
            return .requestParameters(parameters: ["userCode": userID, "shiftCode": shiftCode, "type": type], encoding: JSONEncoding.default);
        case .GetNotification(let username):
            return .requestParameters(parameters: ["type": "\(1)", "employeeCode":username, "isMobileApprovePrice": "\(1)"], encoding: JSONEncoding.default);
        case .GetShopByUser(let username):
            return .requestParameters(parameters: ["p_UserCode": username], encoding: JSONEncoding.default);
        case .GetDiscountLoanReport(let shopCode):
            return .requestParameters(parameters: ["shop": shopCode], encoding: JSONEncoding.default);
        case .GetDiscountFundReport(let username):
            return .requestParameters(parameters: ["p_UserCode": username, "p_Token": UserDefaults.standard.string(forKey: "access_token")!], encoding: JSONEncoding.default);
        case .GetFFriendInstallReport(let username):
            return .requestParameters(parameters: ["p_UserCode": username], encoding: JSONEncoding.default);
        case .GetPendingRequestReport(let username):
            return .requestParameters(parameters: ["p_UserID": username], encoding: JSONEncoding.default);
        case .GetNotBoughtCompanyReport(let username):
            return .requestParameters(parameters: ["p_UserID": username], encoding: JSONEncoding.default);
        case .GetTotalLoanByShop(let username):
            return .requestParameters(parameters: ["p_UserID": username], encoding: JSONEncoding.default);
        case .GetFFriendsOrder(let username):
            return .requestParameters(parameters: ["p_UserID": username], encoding: JSONEncoding.default);
        case .GetVoucherImg(let username):
            return .requestParameters(parameters: ["p_UserID": username], encoding: JSONEncoding.default);
        case .GetOrderImg(let username):
            return .requestParameters(parameters: ["p_UserID": username], encoding: JSONEncoding.default);
        case .GetConfidentFund(let username):
            return .requestParameters(parameters: ["p_UserID": username], encoding: JSONEncoding.default);
        case .GetOverDateWarranty(let username, let shopCode):
            return .requestParameters(parameters: ["userCode": username, "shopCode": shopCode], encoding: JSONEncoding.default);
        case .GetOverProduct(let username, let shopCode):
            return .requestParameters(parameters: ["userCode": username, "shopCode": shopCode], encoding: JSONEncoding.default);
        case .GetCameraReport(let username):
            return .requestParameters(parameters: ["p_UserCode": username], encoding: JSONEncoding.default);
        case .GetTargetCustomerCare(let username):
            return .requestParameters(parameters: ["p_UserCode": username], encoding: JSONEncoding.default);
        case .GetRemainOldDevice60Report(let username, let shopCode):
            return .requestParameters(parameters: ["userCode": username, "shopCode": shopCode], encoding: JSONEncoding.default);
        case .GetOverDeviceReport(let username, let shopCode):
            return .requestParameters(parameters: ["userCode": username, "shopCode": shopCode], encoding: JSONEncoding.default);
        case .GetRemainDeviceByCategory(let username, let shopCode):
            return .requestParameters(parameters: ["userCode": username, "shopCode": shopCode], encoding: JSONEncoding.default);
        case .GetAccessoryRealtimeReport(let username):
            return .requestParameters(parameters: ["p_UserCode": username], encoding: JSONEncoding.default);
        case .GetAccessoryRealtimeByZone(let username):
            return .requestParameters(parameters: ["p_UserCode": username], encoding: JSONEncoding.default);
        case .GetAccessoryRealtimeByArea(let username):
            return .requestParameters(parameters: ["p_UserCode": username], encoding: JSONEncoding.default);
        case .GetAccessoryRealtimeByShop(let username):
            return .requestParameters(parameters: ["p_UserCode": username], encoding: JSONEncoding.default);
        case .GetSalemanReport(let username, let shopCode, let token):
            return .requestParameters(parameters: ["p_UserCode": username, "p_ShopCode": shopCode, "p_Token": token], encoding: JSONEncoding.default);
        case .GetShopSalesByCategory(let username, let shopCode, let token):
            return .requestParameters(parameters: ["userCode": username, "shopCode": shopCode, "p_Token": token], encoding: JSONEncoding.default);
        case .GetShopSalesByShop(let username, let token):
            return .requestParameters(parameters: ["p_UserCode": username, "p_Token": token], encoding: JSONEncoding.default);
        case .GetAPRSales(let username):
            return .requestParameters(parameters: ["p_UserCode": username], encoding: JSONEncoding.default);
        case .GetShopSalesByArea(let username, let token):
            return .requestParameters(parameters: ["p_UserCode": username, "p_Token": token], encoding: JSONEncoding.default);
        case .GetShopSalesByZone(let username, let token):
            return .requestParameters(parameters: ["p_UserCode": username, "p_Token" :token], encoding: JSONEncoding.default);
        case .GetShopSalesRealtime(let username, let token):
            return .requestParameters(parameters: ["p_UserCode": username, "p_Token": token], encoding: JSONEncoding.default);
        case .GetLoanRealtimeByZone(let username, let token):
            return .requestParameters(parameters: ["p_UserCode": username, "p_Token": token], encoding: JSONEncoding.default);
        case .GetLoanRealtimeByShop(let username, let token):
            return .requestParameters(parameters: ["p_UserCode": username, "p_Token": token], encoding: JSONEncoding.default);
        case .GetLoanRealtime(let username, let token):
            return .requestParameters(parameters: ["p_UserCode": username, "p_Token": token], encoding: JSONEncoding.default);
        case .GetAreaSalesRealtime(let username, let token):
            return .requestParameters(parameters: ["p_UserCode": username, "p_Token": token], encoding: JSONEncoding.default);
        case .GetZoneSalesRealtime(let username, let token):
            return .requestParameters(parameters: ["p_UserCode": username, "p_Token": token], encoding: JSONEncoding.default);
        case .GetDeviceNotSold(let username):
            return .requestParameters(parameters: ["p_UserCode": username], encoding: JSONEncoding.default);
        case .GetUnpaidLoan(let shopCode):
            return .requestParameters(parameters: ["p_ShopCode": shopCode, "p_FromDate": "", "p_ToDate": ""], encoding: JSONEncoding.default);
        case .GetInstallmentRateByShop(let username):
            return .requestParameters(parameters: ["p_UserCode": username], encoding: JSONEncoding.default);
        case .GetInstallmentRateByZone(let username):
            return .requestParameters(parameters: ["p_UserCode": username], encoding: JSONEncoding.default);
        case .GetInstallmentRateByLender(let username):
            return .requestParameters(parameters: ["p_UserCode": username], encoding: JSONEncoding.default);
        case .GetG38ShopSalesRealtime(let username, let token):
            return .requestParameters(parameters: ["p_EmployeeCode": username, "p_Token": token], encoding: JSONEncoding.default);
        case .GetG38ShopSalesMTD(let username, let token):
            return .requestParameters(parameters: ["p_EmployeeCode": username, "p_Token": token], encoding: JSONEncoding.default);
        case .GetASMAgreementReport(let username, let reportDate):
            return .requestParameters(parameters: ["p_UserCode": username, "p_NgayDanhGia": reportDate], encoding: JSONEncoding.default);
        case .GetOpenedAccountPending(let username, let reportDate, let reportMonth, let reportYear, let type):
            return .requestParameters(parameters: ["p_ReportDate_Day": "\(reportDate)", "p_ReportDate_Month": "\(reportMonth)",  "p_ReportDate_Year": "\(reportYear)", "p_UserCode": username, "p_Type": "\(type)"], encoding: JSONEncoding.default);
        case .GetOpenedAccountCompleted(let username, let reportDate, let reportMonth, let reportYear, let type):
            return .requestParameters(parameters: ["p_ReportDate_Day": "\(reportDate)", "p_ReportDate_Month": "\(reportMonth)",  "p_ReportDate_Year": "\(reportYear)", "p_UserCode": username, "p_Type": "\(type)"], encoding: JSONEncoding.default);
        case .GetTargetReport(let shopCode, let month, let year, let username, let token):
            return .requestParameters(parameters: ["p_MaShop": "\(shopCode)", "p_Nam":"\(year)", "p_Thang":"\(month)", "p_UserCode": "\(username)", "p_Token": "\(token)"], encoding: JSONEncoding.default);
        case .SendTargetReportData(let shopCode, let username, let id, let employeeCode, let month, let year, let workingDate, let targetDS, let targetPK, let note):
            return .requestParameters(parameters: ["p_ID":"\(id)", "p_UserCode": username, "p_Nam":"\(year)", "p_Thang":"\(month)", "p_MaShop":"\(shopCode)", "p_MaNV":"\(employeeCode)", "p_SoNgayLamViec":"\(workingDate)", "p_Target_DS":"\(targetDS)", "p_Target_PK":"\(targetPK)", "p_GhiChu":"\(note)", "p_DeviceType":"\(2)"], encoding: JSONEncoding.default);
        case .RequestTargetReportDelete(let id, let username):
            return .requestParameters(parameters: [ "p_ID":"\(id)", "p_UserCode":username], encoding: JSONEncoding.default);
        case .GetHealthReport(let id, let level, let shopCode, let type):
            return .requestParameters(parameters: ["p_MaShop": shopCode, "p_Type":type, "p_Lv": level, "p_ID": id], encoding: JSONEncoding.default);
        case .GetTrafficReport(let username, let type):
            return .requestParameters(parameters: ["p_UserCode": username, "p_Type": type], encoding: JSONEncoding.default);
        case .GetViolationMember(let employeeCode):
            return .requestParameters(parameters: ["p_EmployeeCode": employeeCode], encoding: JSONEncoding.default);
        case .GetOpenedAccountPendingDetails(let reportDate, let reportMonth, let reportYear, let shopCode):
            return .requestParameters(parameters: ["p_ReportDate_Day": reportDate, "p_ReportDate_Month": reportMonth,  "p_ReportDate_Year": reportYear, "p_ShopCode": shopCode], encoding: JSONEncoding.default);
        case .GetOpenedAccountCompletedDetails(let reportDate, let reportMonth, let reportYear, let shopCode):
            return .requestParameters(parameters: ["p_ReportDate_Day": reportDate, "p_ReportDate_Month": reportMonth,  "p_ReportDate_Year": reportYear, "p_ShopCode": shopCode], encoding: JSONEncoding.default);
        case .SendASMAgreementCheck(let username, let shopIP, let checkingType):
            return .requestParameters(parameters: ["p_UserCode": username, "p_IP": shopIP, "p_IsCheck": checkingType], encoding: JSONEncoding.default);
        case .GetShopInfo:
//            return .requestParameters(parameters: ["":""], encoding: JSONEncoding.default);
            return .requestPlain
        case .GetUpgradeLoan(let shopCode):
            return .requestParameters(parameters: ["p_ShopCode": shopCode], encoding: JSONEncoding.default);
            
            //Bao cao combo PK realtime
        case .GetComboPKRealtimeVung(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
        case .GetComboPKRealtimeASM(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
        case .GetComboPKRealtimeShop(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)

        case .GiaTriCotLoi:
            return .requestPlain

            
            //bc ffriends
        case .getListDoanhNghiep(let username):
            return .requestParameters(parameters: ["p_UserCode":username], encoding: JSONEncoding.default)
        case .getListCallogPending(let username):
            return .requestParameters(parameters: ["p_UserCode":username], encoding: JSONEncoding.default)
        case .getTLDuyetTrongThang(let username):
            return .requestParameters(parameters: ["p_UserCode":username], encoding: JSONEncoding.default)
        case .getTLDuyetTheoTungThang(let username, let vendorCode):
            return .requestParameters(parameters: ["p_UserCode":username, "p_VendCode": vendorCode], encoding: JSONEncoding.default)
            
            
        //Bao cao Luy ke_SL_May
        case .getLuyLe_SL_May_Vung(let username, let loai, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Loai":loai, "p_Token":token], encoding: JSONEncoding.default)
        case .getLuyLe_SL_May_Khuvuc(let username, let loai, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Loai":loai, "p_Token":token], encoding: JSONEncoding.default)
        case .getLuyLe_SL_May_Shop(let username, let loai, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Loai":loai, "p_Token":token], encoding: JSONEncoding.default)
            
        //BC SL SIM
        case .getSL_SIM_Vung(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
        case .getSL_SIM_khuvuc(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
        case .getSL_SIM_Shop(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
            
        //    //BC Ty Le SIM
        case .getTyLe_SIM_Vung(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
        case .getTyLe_SIM_Khuvuc(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
        case .getTyLe_SIM_Shop(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)

                    //BC SL Iphone 14
            case .getSL_iphone14_Vung(let username, let token):
                return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
            case .getSL_iphone14_khuvuc(let username, let token):
                return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
            case .getSL_iphone14_Shop(let username, let token):
                return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
            
        //Bao cao ListDoanhSo_Realtime_SL_May
        case .getListDoanhSo_Realtime_SL_May_Vung(let username, let loai, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Loai":loai, "p_Token":token], encoding: JSONEncoding.default)
        case .getListDoanhSo_Realtime_SL_May_Khuvuc(let username, let loai, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Loai":loai, "p_Token":token], encoding: JSONEncoding.default)
        case .getListDoanhSo_Realtime_SL_May_Shop(let username, let loai, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Loai":loai, "p_Token":token], encoding: JSONEncoding.default)
            
        //Bao cao Tra gop
        case .getTraGopVungMien_Team_PTNH_Vung(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
        case .getTraGopVungMien_Team_PTNH_KhuVuc(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
        case .getTraGopVungMien_Team_PTNH_Shop(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
            
        //    //BC Tra gop Realtime
        case .TraGopVungMien_Realtime_Team_PTNH_Vung(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
        case .TraGopVungMien_Realtime_Team_PTNH_KhuVuc(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
        case .TraGopVungMien_Realtime_Team_PTNH_Shop(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
            
        //BC Tra Coc
        case .getSoCoc(let username):
            return .requestParameters(parameters: ["p_UserCode":username], encoding: JSONEncoding.default)
            
        // bc sl_laigop thu ho
        case .ThanhToanHoaDon_CRM001_Vung(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
        case .ThanhToanHoaDon_CRM001_KhuVuc(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
        case .ThanhToanHoaDon_CRM001_Shop(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)

            //    Khai thác KH CRM - CTKM tặng 50K
            
        case .KhaiThacKH_CRM_CTKM_Vung(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
        case .KhaiThacKH_CRM_CTKM_KhuVuc(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
        case .KhaiThacKH_CRM_CTKM_Shop(let username, let token):
            return .requestParameters(parameters: ["p_UserCode":username, "p_Token":token], encoding: JSONEncoding.default)
            
        //NhapChiTieuDoanhSo_Save
        case let .NhapChiTieuDoanhSo_Report(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
        case let .NhapChiTieuDoanhSo_Save(params):
            return .requestParameters(parameters: params, encoding:  JSONEncoding.default)
            
        //Visitor
        case let .sp_mpos_Report_FRT_Visitor_Report(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .Report_FRT_SP_Visitor_Report_V2(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .Report_FRT_SP_Visitor_Report_TheoDoiShop(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        //Check list shop ASM
        case let .LoadShopByASM(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .CheckListShop_insert(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .Checklistshop_ASM_get(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .Checklist_ASM_confirm(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        //    KhaiThacCombo
        case let .KhaiThacCombo_LuyKe(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .KhaiThacCombo_HomQua(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        // DS vung realtime
        case let .ListDoanhSo_Realtime_Vung_NotDA(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
            // DS mat kinh realtime
        case let .ListDoanhSo_MatKinh_Realtime_Shop_View_Final(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            //DS my pham realtime
        case let .ListDoanhSo_Realtime_ShopMyPham(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            //DS dong ho realtime
        case let .ListDoanhSo_DongHo_Realtime_Shop(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
            //Virus - BHMR
        case let .ListSP_Realtime_SLSP_Virus_ASM_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_Realtime_SLSP_Virus_Shop_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_Realtime_SLSP_Virus_Vung_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        case let .ListSP_Realtime_SLSP_BHMR_ASM_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_Realtime_SLSP_BHMR_Shop_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_Realtime_SLSP_BHMR_Vung_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        //LUY KE Virus - BHMR
        case let .ListSP_LuyKe_SLSP_Virus_ASM_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_LuyKe_SLSP_Virus_Shop_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_LuyKe_SLSP_Virus_Vung_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        case let .ListSP_LuyKe_SLSP_BHMR_ASM_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_LuyKe_SLSP_BHMR_Shop_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_LuyKe_SLSP_BHMR_Vung_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        //VeMaybay
        case let .ListSP_LuyKe_VeMayBay_Shop_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_LuyKe_VeMayBay_ASM_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_LuyKe_VeMayBay_Vung_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        case let .ListSP_Realtime_VeMayBay_Shop_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_Realtime_VeMayBay_ASM_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_Realtime_VeMayBay_Vung_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        //ShopMyPham_Saleman
        case let .ListDoanhSo_ShopMyPham_View_Final(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .DoanhSoShop_MyPhamSaleman_View(param), let .DoanhSoShop_MyPhamSaleman_View_New(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .FRT_usp_RP_PRO1_FR_FR124(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        //BHMR NewTest
        case let .ListSP_LuyKe_SLSP_BHMR_ASM_View_NewTest(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_LuyKe_SLSP_BHMR_Shop_View_NewTest(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_LuyKe_SLSP_BHMR_Vung_View_NewTest(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        case let .ListSP_Realtime_SLSP_BHMR_Shop_View_NewTest(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_Realtime_SLSP_BHMR_ASM_View_NewTest(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListSP_Realtime_SLSP_BHMR_Vung_View_NewTest(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        case let .msm_KhaiThacMayKemPK(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .ListDoanhSo_Realtime_Vung_NotDA_CungKy_View_Final(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .msm_RealtimeShopKhaiThacMayKemPK(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        case let .DoanhSo_TyLePhuKien_Realtime_Vung_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .DoanhSo_TyLePhuKien_Realtime_KhuVuc_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .DoanhSo_PhuKien_Iphone_Realtime_Vung_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .DoanhSo_PhuKien_Iphone_Realtime_KhuVuc_View(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        case let .DoanhSo_Iphone_ComboPK_Realtime_GetData_Model(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .DoanhSo_Iphone_ComboPK_Realtime_GetData_Vung(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case let .DoanhSo_Iphone_ComboPK_Realtime_GetData_ASM(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        
        case let .trackUserActivity(param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        var access_token = UserDefaults.standard.string(forKey: "access_token")
        access_token = access_token == nil ? "" : access_token
        return  ["Content-type": "application/json","Authorization": "Bearer \(access_token!)"]
    }
}
