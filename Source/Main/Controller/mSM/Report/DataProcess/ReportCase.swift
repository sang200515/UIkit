//
//  ReportCase.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 23/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;

enum ReportCase{
    case GetDiscountLoanReport;
    case GetDiscountFundReport;
    case GetFFriendInstallReport;
    case GetPendingRequestReport;
    case GetNotBoughtCompanyReport;
    case GetTotalLoanByShop;
    case GetFFriendsOrder;
    case GetVoucherImg;
    case GetOrderImg;
    case GetConfidentFund;
    case GetOverDateWarranty;
    case GetOverProduct;
    case GetCameraReport;
//    case GetTargetCustomerCare;
    case GetOverDeviceReport;
    case GetRemainDeviceByCategory;
    case GetAccessoryRealtimeReport;
    case GetAccessoryRealtimeByZone;
    case GetAccessoryRealtimeByArea;
    case GetAccessoryRealtimeByShop;
    case GetSalemanReport;
    case GetShopSalesByCategory;
    case GetShopSalesByShop;
    case GetAPRSales;
    case GetShopSalesByArea;
    case GetShopSalesByZone;
    case GetShopSalesRealtime;
    case GetLoanRealtimeByArea;
    case GetLoanRealtimeByShop;
    case GetLoanRealtimeByZone;
    case GetAreaSalesRealtime;
    case GetZoneSalesRealtime;
    case GetDeviceNotSold;
    case GetUnpaidLoan;
    case GetInstallmentRate;
    case GetG38ShopSalesRealtime;
    case GetG38ShopSalesMTD;
    case GetASMAgreementReport;
    case GetOpenedAccount(type: String);
    case GetTargetReport;
    case GetHealthReport;
    case GetTrafficReport;
    case GetViolationMember;
    case GetUpgradeLoan;
    case GetComboPKRealtime
    case GetFFiends
    case GetDSMayRealtime
    case GetLuyKeSLMay
    case GetSLSim
    case GetSLiphone14
    case GetLuyKeSLSim
    case GetTraGop
    case GetTraCoc
    case GetSLLaiGopThuHo
    case GetKhaiThacKMCRM
    case GetVisitorCounting
    case GetVisitorTheoDoiShop
    
    case CheckListShopASM
    case GetDSRealtimeMatKinh
    case GetDSRealtimeDongHo
    case GetVirus
    case GetBHMR
    case GetVirusLuyKe
    case GetBHMRLuyKe
    case GetVeMayBayRealtime
    case GetVeMayBayLuyKe
    case GetBCDSRealtimeDongHo
    case GetKhaiThacMayKemPK
    case GetRealtimeShopKhaiThacMayKemPK
    case GetTyLePKRealtime
    case GetPKIphoneRealtime
    case GetRealtimeAppleComboPK
    case GetRealTimeHanghot
    case GetLuyKeHot
    case BaoHanhVang
    case BaoHiemXe
    case GetDailyGiaDung
    case GetRealTimeGiaDung
}
extension ReportCase{
    var caseIcon: String{
        switch self {
        case .GetAccessoryRealtimeReport,
             .GetAccessoryRealtimeByZone,
             .GetAccessoryRealtimeByArea,
             .GetAccessoryRealtimeByShop,
             .GetShopSalesRealtime,
             .GetLoanRealtimeByArea,
             .GetLoanRealtimeByShop,
             .GetLoanRealtimeByZone,
             .GetAreaSalesRealtime,
             .GetZoneSalesRealtime,
             .GetG38ShopSalesRealtime,
             .GetComboPKRealtime,
             .GetDSMayRealtime,
             .GetSLLaiGopThuHo,
             .GetKhaiThacKMCRM,
             .GetDSRealtimeMatKinh,
             .GetDSRealtimeDongHo,
             .GetTyLePKRealtime,
             .GetPKIphoneRealtime,
             .GetRealtimeAppleComboPK,
             .GetRealTimeHanghot,
             .GetRealTimeGiaDung:
            return "ic_report_realtime";
        case .GetTargetReport,
             .GetHealthReport,
             .GetDailyGiaDung:
            return "ic_report_details1";
        default:
            return "ic_report_details";
        }
    }
    
    var caseName: String{
        switch self {
        case .GetDiscountLoanReport:
            return "Báo cáo nợ khuyến mãi";
        case .GetDiscountFundReport:
            return "Quỹ duyệt giảm giá";
        case .GetFFriendInstallReport:
            return "Cài đặt F.Friends";
        case .GetPendingRequestReport:
            return "Đơn hàng pending";
        case .GetNotBoughtCompanyReport:
            return "Doanh nghiệp chưa mua hàng";
        case .GetTotalLoanByShop:
            return "Tổng nợ theo Shop";
        case .GetFFriendsOrder:
            return "Doanh số đơn hàng F.Friends";
        case .GetVoucherImg:
            return "Báo cáo tình trạng CallLog chứng từ";
        case .GetOrderImg:
            return "Báo cáo tình trạng CallLog hình ảnh";
        case .GetConfidentFund:
            return "Báo cáo quỹ tự tin tổng hợp trên BI";
        case .GetOverDateWarranty:
            return "Bảo hành quá hạn";
        case .GetOverProduct:
            return "Hàng Over đã bán";
        case .GetCameraReport:
            return "Báo cáo lỗi camera";
//        case .GetTargetCustomerCare:
//            return "Điểm CSKH WELoveFPTShop 3";
        case .GetOverDeviceReport:
            return "Hàng Over đang tồn kho thanh lý";
        case .GetRemainDeviceByCategory:
            return "Tồn kho theo ngành hàng";
        case .GetAccessoryRealtimeReport:
            return "Doanh số phụ kiện realtime";
        case .GetAccessoryRealtimeByZone:
            return "Doanh số phụ kiện Vùng realtime";
        case .GetAccessoryRealtimeByArea:
            return "Doanh số phụ kiện khu vực realtime"
        case .GetAccessoryRealtimeByShop:
            return "Doanh số phụ kiện shop realtime";
        case .GetSalemanReport:
            return "Doanh số theo saleman";
        case .GetShopSalesByCategory:
            return "Doanh số shop theo ngành hàng";
        case .GetShopSalesByShop:
            return "Doanh số shop theo shop"
        case .GetAPRSales:
            return "Doanh số APR"
        case .GetShopSalesByArea:
            return "Doanh số shop theo khu vực"
        case .GetShopSalesByZone:
            return "Doanh số shop theo vùng";
        case .GetShopSalesRealtime:
            return "Doanh số shop realtime";
        case .GetLoanRealtimeByArea:
            return "BC ngành hàng trả góp theo khu vực"
        case .GetLoanRealtimeByShop:
            return "BC ngành hàng trả góp theo shop"
        case .GetLoanRealtimeByZone:
            return "BC ngành hàng trả góp theo vùng";
        case .GetAreaSalesRealtime:
            return "Doanh số khu vực realtime";
        case .GetZoneSalesRealtime:
            return "Doanh số vùng realtime";
        case .GetDeviceNotSold:
            return "Cảnh báo máy xin về chưa bán";
        case .GetUnpaidLoan:
            return "Danh sách giao dịch chưa nộp tiền thẻ cào - thu hộ";
        case .GetG38ShopSalesRealtime:
            return "Báo cáo realtime G100";
        case .GetG38ShopSalesMTD:
            return "Báo cáo doanh số shop G100";
        case .GetASMAgreementReport:
            return "Báo cáo kiểm tra SSD ASM";
        case .GetOpenedAccount(let type):
            if(type == "1"){
                return "Báo cáo mở thẻ FFriends theo shop"
            }
            else if(type == "2"){
                return "Báo cáo mở thẻ FFriends theo khu vực"
            }
            else{
                return "Báo cáo mở thẻ FFriends theo vùng"
            }
        case .GetTargetReport:
            return "Nhập DS Target và PK";
        case .GetHealthReport:
            return "Chỉ số sức khoẻ shop";
        case .GetTrafficReport:
            return "Báo cáo traffic";
        case .GetViolationMember:
            return "Báo cáo nhân viên vi phạm";
        case .GetUpgradeLoan:
            return "Báo cáo chương trình lên đời PKG 3M-6M";
        case .GetInstallmentRate:
            return "BC tỷ lệ thành công trả góp";
            
        case .GetComboPKRealtime:
            return "Báo cáo CB PK Realtime";
        case .GetFFiends:
            return "Báo cáo FFiends";
        case .GetDSMayRealtime:
            return "BC Realtime Doanh Số Máy";
        //-------------
        case .GetLuyKeSLMay:
            return "BC Luỹ kế doanh số máy";
        case .GetSLSim:
            return "BC Số lượng SIM";
        case .GetLuyKeSLSim:
            return "BC Tỷ lệ Sim";
            case .GetSLiphone14:
                return "Báo cáo tỉ lệ khai thác combo/iPhone 14 Series";
        case .GetTraGop:
            return "BC Trả Góp";
        case .GetTraCoc:
            return "BC Theo Dõi Số Cọc";
        case .GetSLLaiGopThuHo:
            return "Luỹ Kế Số Lượt-Lãi Gộp Thu Hộ";
        case .GetKhaiThacKMCRM:
            return "Báo cáo Khai Thác KH Thu Hộ";
        case .GetVisitorCounting:
            return "BC Visitor Couting";
        case .GetVisitorTheoDoiShop:
            return "BC Visitor Theo Dõi Shop";
            
        case .CheckListShopASM:
            return "Check List Shop ASM";
        case .GetDSRealtimeMatKinh:
            return "DS Realtime Mắt Kính"
        case .GetDSRealtimeDongHo:
            return "DS Realtime Đồng Hồ"
        case .GetVirus:
            return "BC Realtime PM Diệt Virus Eset"
        case .GetBHMR:
            return "BC Realtime Gói GHBH"
        case .GetVirusLuyKe:
            return "BC Luỹ Kế Tháng PM Diệt Virus Eset"
        case .GetBHMRLuyKe:
            return "BC Luỹ Kế Tháng Gói GHBH"
        case .GetVeMayBayRealtime:
            return "BC Realtime Vé Máy Bay"
        case .GetVeMayBayLuyKe:
            return "BC Luỹ Kế Vé Máy Bay"
        case .GetBCDSRealtimeDongHo:
            return "BC RealTime Vùng DS Đồng Hồ"
        case .GetKhaiThacMayKemPK:
            return "BC khai thác máy kèm PK"
        case .GetRealtimeShopKhaiThacMayKemPK:
            return "BC realtime khai thác máy kèm PK"
        case .GetTyLePKRealtime:
            return "Báo cáo realtime tỷ trọng PK"
        case .GetPKIphoneRealtime:
            return "Báo cáo Realtime Non IPhone"
        case .GetRealtimeAppleComboPK:
            return "BC Realtime khai thác Apple kèm combo PK/PKNK"
        case .GetRealTimeHanghot:
            return "Báo cáo Realtime Hàng Hot"
        case .GetLuyKeHot:
            return "Báo cáo lũy kế Hàng Hot"
        case .BaoHanhVang:
            return "Báo cáo bảo hành vàng"
        case .BaoHiemXe:
            return "Báo cáo bảo hiểm xe"
        case .GetDailyGiaDung:
            return "Báo cáo Luỹ kế Gia dụng"
        case .GetRealTimeGiaDung:
            return "Báo cáo Realtime Gia dụng"
        }
    }
    
    var reportHeader: [String]{
        switch self {
        case .GetDiscountLoanReport:
            return ["STT", "Tên Shop", "Mã KH", "Tên KH", "Số ĐT", "Đơn hàng nợ KM", "Đơn hàng gốc", "Ngày mua hàng", "Mã SP gốc", "Tên SP gốc", "Mã SP nợ KM", "Tên SP nợ KM", "Mã kho còn", "Số ngày nợ", "SL nợ", "SL tồn kho"];
        case .GetDiscountFundReport:
            return ["STT", "Shop", "Quỹ giảm giá tháng", "Quỹ GG Laptop" , "Số tiền đã giảm", "Quỹ giảm giá còn lại"];
        case .GetFFriendInstallReport:
            return ["STT", "Tên Shop", "SL Bán", "SL Cài", "% Cài", "Doanh Số", "DS Loại Bỏ"];
        case .GetPendingRequestReport:
            return ["STT", "Tên Shop", "Hội viên", "Số ĐT", "Số đơn hàng", "Sản phẩm", "SL", "Thành tiền"];
        case .GetNotBoughtCompanyReport:
            return ["STT", "Tên doanh nghiệp", "Ngày ký hợp đồng", "Người tiếp cận"]
        case .GetTotalLoanByShop:
            return ["STT", "Tên Shop", "Tổng nợ hiện tại", "Nợ chưa đến hạn", "Nợ đến hạn", "Tổng nợ quá hạn", "> 90 ngày", "> 60 ngày", "> 30 ngày", "< 30 ngày"]
        case .GetFFriendsOrder:
            return ["STT","Tên Shop", "Tổng cộng", "Trả góp", "Trả thẳng", "MTD tháng này", "EST tháng này", "TT F.F so với DS Tổng"]
        case .GetVoucherImg:
            return ["STT", "KH", "Số ĐT", "CallLog", "Tình trạng", "Sales Shop", "Ngày hết hạn"]
        case .GetOrderImg:
            return ["STT", "SO", "CallLog", "Tình trạng", "Sales Shop", "Ngày hết hạn"]
        case .GetConfidentFund:
            return ["STT","Mã shop", "Tên shop", "Doanh thu", "Budget quỹ của tháng", "Tổng chi phí sử dụng", "Chi phí đổi trả", "Chi phí bảo hành", "Chi phí thu mua", "Quỹ tự tin còn lại"]
        case .GetOverDateWarranty:
            return ["STT", "Tên shop", "Số ngày còn lại", "Tên SP", "Sản phẩm BH", "Số phiếu BH", "Ngày tạo", "Hình thức bàn giao", "Hình thức BH", "Trạng thái"]
        case .GetOverProduct:
            return ["STT", "Tên SP", "IMEI", "Ngày Bán"]
        case .GetCameraReport:
            return ["STT", "Tên shop", "Mã yêu cầu", "Trạng thái ", "Loại lỗi ", "Nhân viên vi phạm ", "Ghi chú"];
//        case .GetTargetCustomerCare:
//            return ["STT", "Tên shop","Điểm camera", "Điểm happy ", "Chất lượng cuộc gọi ", "Lời khen W3 ", "Số SO ", "Target lời khen ", "Kết quả W3 ", "Tổng điểm CSKH" ]
        case .GetOverDeviceReport:
            return ["STT", "Tên SP", "IMEI", "Ngày Tồn"];
        case .GetRemainDeviceByCategory:
            return ["STT", "Ngành", "Kho hàng bán", "Giá trị", "Vòng quay", "Chờ xử lý", "Bảo hành", "Ký gửi", "Máy cũ"];
        case .GetAccessoryRealtimeReport:
            return ["STT", "Vùng", "ASM", "Khu vực", "Shop", "Doanh số phụ kiện", "Tỷ trọng phụ kiện"];
        case .GetAccessoryRealtimeByZone:
            return ["STT", "Vùng", "DS Ecom", "DS Shop", "DSPK", "TTPK", "Tổng"];
        case .GetAccessoryRealtimeByArea:
            return ["STT", "ASM", "Khu Vực", "DS Ecom", "DS Shop", "DSPK", "TTPK", "Tổng"]
        case .GetAccessoryRealtimeByShop:
            return ["STT",  "Shop",  "DS Ecom",  "DS Shop",  "DSPK",  "TTPK",  "Tổng"]
        case .GetSalemanReport:
            return ["STT", "Tên NV", "Tổng DS", "Tổng SL", "SLTB", "Doanh số PK"];
        case .GetShopSalesByCategory:
            return ["STT", "Shop", "Ngành", "Target tháng trước", "Số lượng", "DS MTD", "% Hoàn thành", "DS TB ngày", "DS TB ngày còn lại", "% tăng giảm vs DS tháng trước"];
        case .GetShopSalesByShop:
            return ["STT", "Shop", "ASM", "DS MTD", "DS TB ngày", "% HT target", "% tăng giảm vs DS tháng trước", "Tổng SL", "Total HS Trả góp"];
        case .GetAPRSales:
            return ["STT", "Shop APR", "DS Apple MTD", "DS TB ngày", "% tăng giảm vs so với tháng trước", "Target tháng", "% HT MTD", "% dự kiến HT"]
        case .GetShopSalesByArea:
            return ["STT", "ASM", "SL Shop", "DS MTD", "DS TB ngày", "% HT target", "% tăng giảm vs DS tháng trước"];
        case .GetShopSalesByZone:
            return ["STT", "Vùng miền", "SL Shop", "DS MTD", "DS TB ngày", "% HT target", "% tăng giảm vs DS tháng trước"];
            //add dspknk
        case .GetShopSalesRealtime:
            return ["STT", "Shop", "DSPK", "TTPK", "Tổng"];
        case .GetLoanRealtimeByArea:
            return ["STT", "Vùng miền", "Số lượng ACS", "Số lượng FE", "Số lượng HC", "Số lượng HDS", "Số lượng SO hoàn tất", "Tống số HĐ trả góp", "Tỷ trọng trả góp"];
        case .GetLoanRealtimeByShop:
            return ["STT","Shop", "Số lượng ACS", "Số lượng FE", "Số lượng HC", "Số lượng HDS", "Số lượng SO hoàn tất", "Tống số HĐ trả góp", "Tỷ trọng trả góp"];
        case .GetLoanRealtimeByZone:
            return ["STT","Khu vực", "Số lượng ACS", "Số lượng FE", "Số lượng HC", "Số lượng HDS", "Số lượng SO hoàn tất", "Tống số HĐ trả góp", "Tỷ trọng trả góp"];
            //add dspknk
        case .GetAreaSalesRealtime:
            return ["STT", "ASM", "Khu vực", "DSPK", "TTPK", "Tổng"];
            ////add dspknk
        case .GetZoneSalesRealtime:
            return ["STT", "Vùng", "DSPK", "TTPK", "Tổng"];
        case .GetDeviceNotSold:
            return ["STT","Shop xin hàng","Mã SP","Tên SP","SL chưa bán","Giá trị chưa bán", "% chưa bán"];
        case .GetG38ShopSalesRealtime:
            return ["STT", "Tên shop", "DSPK", "TTPK", "DS Tổng", "SLPK", "SL Máy", "SLPK/SLM"];
        case .GetG38ShopSalesMTD:
            return ["STT", "Tên shop", "ASM", "DS MTD", "DSPK MTD", "TTPK MTD", "SLPK MTD", "SL máy", "SLPK/SLM MTD", "Target SL máy", "% HT Target", "SL lời khen MTD", "% trên SO MTD"];
        case .GetASMAgreementReport:
            return ["STT", "ASM", "Tên shop", "Ngày đánh giá", "Kết quả ASM chọn"];
        case .GetViolationMember:
            return ["STT", "Mã nhân viên", "Tên nhân viên", "Chức danh", "Lỗi vi phạm", "Số lần lặp", "Số tiền phạt", "Tháng ghi nhận", "Bộ phận ghi nhận"];
        case .GetUpgradeLoan:
            return ["STT", "Tên Shop", "Tên nhân viên", "TB/tháng 1M-3M", "TB/tháng 3M-6M", "Target TG 3M-6M", "Luỹ kế", "% Target", "Ước tính đến 31/12", "% Target theo ước tính", "Số bán PKG trả thắng\n1M-3M đến 11-22", "Tiền thưởng"];
        case .GetUnpaidLoan:
            return ["STT","Tên shop","ASM phụ trách","SM phụ trách","Nhân viên sales","Loại","Hình thức thanh toán", "Tổng tiền"];
        case .GetTargetReport:
            return [];
        default:
            return [];
        }
    }
    
    static func MapPermission(permissions: [PermissionHashCode]) -> [ReportCase]{
        var returnedCase: [ReportCase] = [];
        permissions.forEach{ permission in
            switch permission{
            case .BC_VUNG_REALTIME:
                returnedCase.append(ReportCase.GetZoneSalesRealtime);
            case .BC_KHUVUC_REALTIME:
                returnedCase.append(ReportCase.GetAreaSalesRealtime);
            case .BC_SHOP_REALTIME:
                returnedCase.append(ReportCase.GetShopSalesRealtime);
//                returnedCase.append(ReportCase.GetG38ShopSalesRealtime);
            case .BC_VUNG_MTD:
                returnedCase.append(ReportCase.GetShopSalesByZone)
            case .BC_KHU_VUC_MTD:
                returnedCase.append(ReportCase.GetShopSalesByArea);
            case .BC_SHOP_MTD:
                returnedCase.append(ReportCase.GetShopSalesByShop);
//                returnedCase.append(ReportCase.GetG38ShopSalesMTD);
            case .BC_SHOP_THE0_NGHANH_HANG:
                returnedCase.append(ReportCase.GetShopSalesByCategory);
            case .BC_SALEMAN:
                returnedCase.append(ReportCase.GetSalemanReport);
            case .BC_TON_KHO_NGHANH_HANG:
                returnedCase.append(ReportCase.GetRemainDeviceByCategory);
            case .BC_OVER_DANG_TON_KHO_THANH_LY:
                returnedCase.append(ReportCase.GetOverDeviceReport);
            case .BC_OVER_DA_BAN:
                returnedCase.append(ReportCase.GetOverProduct);
            case .BC_BAO_HANH_QUA_HAN:
                returnedCase.append(ReportCase.GetOverDateWarranty);
            case .BC_NO_KHUYEN_MAI:
                returnedCase.append(ReportCase.GetDiscountLoanReport);
            case .BC_QUY_TU_TIN:
                returnedCase.append(ReportCase.GetConfidentFund);
            case .BC_QUY_DUYET_GIAM_GIA:
                returnedCase.append(ReportCase.GetDiscountFundReport);
            case .BC_LOI_CAMERA:
                returnedCase.append(ReportCase.GetCameraReport);
//            case .BC_DIEM_CSKH_WE_LOVE_FPT:
//                returnedCase.append(ReportCase.GetTargetCustomerCare);
            case .BC_CAI_DAT_FFRIENDS:
                returnedCase.append(ReportCase.GetFFriendInstallReport);
            case .BC_TINH_TRANG_CALLLOG_HINH_ANH:
                returnedCase.append(ReportCase.GetOrderImg);
            case .BC_TINH_TRANG_CALLLOG_CHUNG_TU:
                returnedCase.append(ReportCase.GetVoucherImg);
            case .BC_DON_HANG_PENDING_CALLLOG_OUTSIDE:
                returnedCase.append(ReportCase.GetPendingRequestReport);
            case .BC_DOANH_SO_DON_HANG_FFRIENDS:
                returnedCase.append(ReportCase.GetFFriendsOrder);
            case .BC_TONG_NO_THEO_SHOP:
                returnedCase.append(ReportCase.GetTotalLoanByShop);
            case .BC_DOANH_NGHIEP_CHUA_MUA_HANG:
                returnedCase.append(ReportCase.GetNotBoughtCompanyReport);
            case .BC_APR:
                returnedCase.append(ReportCase.GetAPRSales);
            case .BC_SUC_KHOE:
                returnedCase.append(ReportCase.GetHealthReport);
                returnedCase.append(ReportCase.GetTargetReport);
            case .BC_REAL_TIME_PHU_KIEN:
                returnedCase.append(ReportCase.GetAccessoryRealtimeReport);
            case .BC_REAL_TIME_PHU_KIEN_VUNG:
                returnedCase.append(ReportCase.GetAccessoryRealtimeByZone);
                returnedCase.append(ReportCase.GetAccessoryRealtimeByShop);
                returnedCase.append(ReportCase.GetAccessoryRealtimeByArea);
            case .BC_NGANH_TRA_GOP_VUNG:
                returnedCase.append(ReportCase.GetLoanRealtimeByZone);
            case .BC_NGANH_TRA_GOP_SHOP:
                returnedCase.append(ReportCase.GetLoanRealtimeByShop);
            case .BC_NGANH_TRA_GOP_KHUVUC:
                returnedCase.append(ReportCase.GetLoanRealtimeByArea);
            case .BC_CHUA_NOP_TIEN_THU_HO:
                returnedCase.append(ReportCase.GetUnpaidLoan)
            case .BC_MAY_XIN_CHUA_BAN:
                returnedCase.append(ReportCase.GetDeviceNotSold);
            case .BC_TRAFFIC:
                returnedCase.append(ReportCase.GetTrafficReport);
            case .BC_TY_LE_TRA_GOP:
                returnedCase.append(ReportCase.GetInstallmentRate);
            case .NHAN_VIEN_VI_PHAM:
                returnedCase.append(ReportCase.GetViolationMember);
            case .MO_THE_THEO_VUNG:
                returnedCase.append(ReportCase.GetOpenedAccount(type: "3"));
            case .MO_THE_THEO_KHU_VUC:
                returnedCase.append(ReportCase.GetOpenedAccount(type: "2"));
            case .MO_THE_THEO_SHOP:
                returnedCase.append(ReportCase.GetOpenedAccount(type: "1"));
            case .KT_SSD_ASM:
                returnedCase.append(ReportCase.GetASMAgreementReport)
            case .BC_LENDOI_TRAGOP:
                returnedCase.append(ReportCase.GetUpgradeLoan)
                
            //Bao cao combo PK realtime
            case .BC_COMBO_PK_REALTIME:
                returnedCase.append(ReportCase.GetComboPKRealtime)
            case .BC_FFRIEND:
                returnedCase.append(ReportCase.GetFFiends)
            case .BC_LIST_DS_REALTIME_SLMAY:
                returnedCase.append(ReportCase.GetDSMayRealtime)
            case .BC_LUY_KE_SLMAY:
                returnedCase.append(ReportCase.GetLuyKeSLMay)
            case .BC_SL_SIM:
                returnedCase.append(ReportCase.GetSLSim)
            case .BC_TY_LE_SL_SIM:
                returnedCase.append(ReportCase.GetLuyKeSLSim)
            case .BC_SL_iphone14:
                    returnedCase.append(ReportCase.GetSLiphone14)
            case .BC_TRA_GOP:
                returnedCase.append(ReportCase.GetTraGop)
            case .BC_THEO_DOI_SO_COC:
                returnedCase.append(ReportCase.GetTraCoc)
            case .BC_LUYKE_SL_LAIGOP_THUHO:
                returnedCase.append(ReportCase.GetSLLaiGopThuHo)
            case .BC_KHAITHAC_KM_CRM:
                returnedCase.append(ReportCase.GetKhaiThacKMCRM)
            case .VISITOR_COUNTING_DETAIL:
                returnedCase.append(ReportCase.GetVisitorCounting)
            case .VISITOR_THEO_DOI_SHOP:
                returnedCase.append(ReportCase.GetVisitorTheoDoiShop)
                
            case .CHECK_LIST_SHOP_ASM:
                returnedCase.append(ReportCase.CheckListShopASM)
            case .DS_REALTIME_MATKINH:
                returnedCase.append(ReportCase.GetDSRealtimeMatKinh)
            case .DS_REALTIME_DONGHO:
                returnedCase.append(ReportCase.GetDSRealtimeDongHo)
            case .REALTIME_VIRUS:
                returnedCase.append(ReportCase.GetVirus)
            case .REALTIME_BHMR:
                returnedCase.append(ReportCase.GetBHMR)
            case .LUYKE_VIRUS:
                returnedCase.append(ReportCase.GetVirusLuyKe)
            case .LUYKE_BHMR:
                returnedCase.append(ReportCase.GetBHMRLuyKe)
            case .REALTIME_VEMAYBAY:
                returnedCase.append(ReportCase.GetVeMayBayRealtime)
            case .LUYKE_VEMAYBAY:
                returnedCase.append(ReportCase.GetVeMayBayLuyKe)
            case .DS_REALTIME_DONG_HO:
                returnedCase.append(ReportCase.GetBCDSRealtimeDongHo)
            case .KHAITHAC_MAY_KEM_PK:
                returnedCase.append(ReportCase.GetKhaiThacMayKemPK)
            case .REALTIME_KHAITHAC_MAY_KEM_PK:
                returnedCase.append(ReportCase.GetRealtimeShopKhaiThacMayKemPK)
            case .TYLE_PHUKIEN_REALTIME:
                returnedCase.append(ReportCase.GetTyLePKRealtime)
            case .PK_IPHONE_REALTIME:
                returnedCase.append(ReportCase.GetPKIphoneRealtime)
            case .BC_REALTIME_APPLE_COMBOPK:
                returnedCase.append(ReportCase.GetRealtimeAppleComboPK)
            case .BC_REALTIME_HOT:
                returnedCase.append(ReportCase.GetRealTimeHanghot)
            case .BC_LUYKE_HOT:
                returnedCase.append(ReportCase.GetLuyKeHot)
            case .BC_BAOHANH_VANG:
                returnedCase.append(ReportCase.BaoHanhVang)
            case .BC_BAOHIEM_XE:
                returnedCase.append(ReportCase.BaoHiemXe)
            case .BC_DAILY_GIA_DUNG:
                returnedCase.append(ReportCase.GetDailyGiaDung)
            case .BC_REALTIME_GIA_DUNG:
                returnedCase.append(ReportCase.GetRealTimeGiaDung)
            default:
                break;
            }
        }
        
        return returnedCase;
    }
}
