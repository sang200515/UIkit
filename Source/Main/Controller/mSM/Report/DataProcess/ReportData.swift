//
//  ReportHandler.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 23/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;

extension ReportCase{
    var reportData: [[String]]{
        let date = Date();
        let calendar = Calendar.current;
        
        switch self {
        case .GetDiscountLoanReport:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            let shopCode = (Cache.ShopInfo?.ShopCode) ?? "";
            let data = mSMApiManager.GetDiscountLoan(shopCode: shopCode).Data;
            
            if(data != nil && data!.count > 0){
                counter += 1;
                data?.forEach{ report in
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(report.MaKhachHang!)");
                    valueArr.append("\(report.TenKhachHang!)");
                    valueArr.append("\(report.SoDT!)");
                    valueArr.append("\(report.DonHangNoKM!)");
                    valueArr.append("\(report.DonHangGoc!)");
                    valueArr.append("\(report.NgayDonHang!)");
                    valueArr.append("\(report.MaSPGoc!)");
                    valueArr.append("\(report.TenSPGoc!)");
                    valueArr.append("\(report.MaSPNoKM!)");
                    valueArr.append("\(report.TenSPNoKM!)");
                    valueArr.append("\(report.MaKhoCon!)");
                    valueArr.append("\(report.SoNgayNo!)");
                    valueArr.append("\(report.SLNo!)");
                    valueArr.append("\(report.SLTonKho!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetDiscountFundReport:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetDiscountFundReport(username: username).Data;
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT)");
                    valueArr.append("\(report.TenShop)");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.QuyGG))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.QuyGG_TTLP))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.SoTien))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.ConLai))");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetFFriendInstallReport:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetFFriendInstallReport(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(report.SL_Ban!)");
                    valueArr.append("\(report.SL_Cai!)");
                    valueArr.append("\(report.TyLe!)");
                    valueArr.append("\(report.Doanhso!)");
                    valueArr.append("\(report.DoanhSoLoaiBo!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetPendingRequestReport:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetPendingRequestReport(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(report.HoiVien!)");
                    valueArr.append("\(report.SDT!)");
                    valueArr.append("\(report.SoDonHang!)");
                    valueArr.append("\(report.TenSanPham!)");
                    valueArr.append("\(report.SL!)");
                    valueArr.append("\(report.ThanhTien!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetNotBoughtCompanyReport:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetNotBoughtCompanyReport(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.TenDoanhNghiep!)");
                    valueArr.append("\(report.NgayKyHDDoanhNghiep!)");
                    valueArr.append("\(report.NguoiTiepCan!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetTotalLoanByShop:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetTotalLoanByShop(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.Name!)");
                    valueArr.append("\(report.TongNoHienTai!)");
                    valueArr.append("\(report.NoChuaDenHan!)");
                    valueArr.append("\(report.NoDenHan!)");
                    valueArr.append("\(report.NoQuaHan)");
                    valueArr.append("\(report.NoTren90Ngay!)");
                    valueArr.append("\(report.NoTren60Ngay!)");
                    valueArr.append("\(report.NoTren30Ngay!)");
                    valueArr.append("\(report.NoDuoi30Ngay!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetFFriendsOrder:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetFFriendsOrder(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)")
                    valueArr.append("\(report.Shop!)");
                    valueArr.append("\(report.TongCong!)");
                    valueArr.append("\(report.TraGop!)");
                    valueArr.append("\(report.TraThang!)");
                    valueArr.append("\(report.MTD!)");
                    valueArr.append("\(report.EST!)");
                    valueArr.append("\(report.TG_FF_SoVoi_DSTong!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetVoucherImg:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetVoucherImg(username: username).Data;
            
            if(data != nil && data!.count > 0){
                var counter = 0;
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.KH!)");
                    valueArr.append("\(report.SDT!)");
                    valueArr.append("\(report.CallLog!)");
                    valueArr.append("\(report.TinhTrang!)");
                    valueArr.append("\(report.SalesShop!)");
                    valueArr.append("\(report.NgayHetHan!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetOrderImg:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetOrderImg(username: username).Data;
            
            if(data != nil && data!.count > 0){
                var counter = 0;
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.SoSOPOS)");
                    valueArr.append("\(report.MaCallLog!)");
                    valueArr.append("\(report.TinhTrang)");
                    valueArr.append("\(report.SalesShop!)");
                    valueArr.append("\(report.NgayHenHan!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetConfidentFund:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetConfidentFund(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.MaShop!)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(report.DoanhThu!)");
                    valueArr.append("\(report.DoanhThu_5!)");
                    valueArr.append("\(report.TongChiPhi!)");
                    valueArr.append("\(report.DoiTra!)");
                    valueArr.append("\(report.BaoHanh!)");
                    valueArr.append("\(report.ThuMua!)");
                    valueArr.append("\(report.ChenhLech)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetOverDateWarranty:
            let username = (Cache.user?.UserName)!;
            let shopCode = (Cache.ShopInfo?.ShopCode) ?? "";
            let data = mSMApiManager.GetOverDateWarranty(username: username, shopCode: shopCode).Data;
            
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    let dateTemp: Date = Date(jsonDate: report.NgayTao!)!;
                    let components = (Calendar.current as NSCalendar).components([.day,.month,.year], from: dateTemp);
                    let date: String = "\(components.day!)" + "-" + "\(String(describing: components.month!))" + "-" + "\(String(describing: components.year!))";
                    
                    valueArr.append("\(report.STT!)");
                    valueArr.append(report.TenShop!);
                    valueArr.append("\(report.SoNgayConLai!)");
                    valueArr.append("\(report.MaSP!)");
                    valueArr.append("\(report.MaSPBaoHanh!)");
                    valueArr.append("\(report.MaBaoHanh!)");
                    valueArr.append("\(date)");
                    valueArr.append("\(report.KieuChuyen!)");
                    valueArr.append("\(report.HinhThuc!)");
                    valueArr.append("\(report.TrangThai!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetOverProduct:
            let username = (Cache.user?.UserName)!;
            let shopCode = (Cache.user?.ShopCode) ?? "";
            let data = mSMApiManager.GetOverProduct(username: username, shopCode: shopCode).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.TenSP!)");
                    valueArr.append("\(report.IMEI!)");
                    valueArr.append("\(report.NgayBan!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetCameraReport:
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetCameraReport(username: username).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append(report.TenShop!);
                    valueArr.append(report.MaYeuCau!);
                    valueArr.append(report.TrangThai!);
                    valueArr.append(report.LoaiLoi!);
                    valueArr.append(report.NhanVien!);
                    valueArr.append(report.GhiChu!);
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
//        case .GetTargetCustomerCare:
//            let username = (Cache.user?.UserName)!;
//            let data = mSMApiManager.GetTargetCustomerCare(username: username).Data;
//            var dataArr: [[String]] = [];
//            var valueArr: [String] = [];
//
//            if(data != nil && data!.count > 0){
//                data?.forEach{ report in
//                    valueArr.append("\(report.STT!)");
//                    valueArr.append("\(report.TenShop!)");
//                    valueArr.append("\(report.DiemCamera!)");
//                    valueArr.append("\(report.DiemHappy!)");
//                    valueArr.append("\(report.ChatLuong!)");
//                    valueArr.append("\(report.LoiKhen_W3!)");
//                    valueArr.append("\(report.SoSO!)");
//                    valueArr.append("\(report.TARGET_W3!)");
//                    valueArr.append("\(report.KetQua_W3!)");
//                    valueArr.append("\(report.TongDiemCSKH!)");
//
//                    dataArr.append(valueArr);
//                    valueArr.removeAll();
//                }
//            }
//
//            return dataArr;
        case .GetOverDeviceReport:
            let username = (Cache.user?.UserName)!;
            let shopCode = (Cache.user?.ShopCode)!;
            let data = mSMApiManager.GetOverDeviceReport(username: username, shopCode: shopCode).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.TenSP!)");
                    valueArr.append("\(report.IMEI!)");
                    valueArr.append("\(report.NgayTon!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            else{
                
            }
            return dataArr;
        case .GetRemainDeviceByCategory:
            let username = (Cache.user?.UserName)!;
            let shopCode = (Cache.user?.ShopCode)!;
            let data = mSMApiManager.GetRemainDeviceByCategory(username: username, shopCode: shopCode).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.NganhHang!)");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.TonKhoHangBan!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: (report.GiaTriHangBan! / 1000)))");
                    valueArr.append("\(report.VongQuay!)")
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.TonKhoChoXuLy!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.TonKhoBaoHanh!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.TonKhoKyGoi!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.TonKhoMayCu!))");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetAccessoryRealtimeReport:
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetAccessoryRealtimeReport(username: username).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append(report.Vung!);
                    valueArr.append(report.ASM!);
                    valueArr.append(report.KhuVuc!);
                    valueArr.append(report.TenShop!);
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.DSPK!))");
                    valueArr.append("\(report.TyTrong!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetAccessoryRealtimeByZone:
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetAccessoryRealtimeByZone(username: username).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append(report.Vung!);
                    valueArr.append(Common.convertCurrencyInteger(value: report.DoanhSoEcom!));
                    valueArr.append(Common.convertCurrencyInteger(value: report.DoanhSoNgay!));
                    valueArr.append(Common.convertCurrencyInteger(value: report.DSPK!));
                    valueArr.append("\(report.PT!)");
                    valueArr.append("\(report.Tong!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetAccessoryRealtimeByArea:
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetAccessoryRealtimeByArea(username: username).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append(report.ASM!);
                    valueArr.append(report.KhuVuc!);
                    valueArr.append(Common.convertCurrencyInteger(value: report.DoanhSoEcom!));
                    valueArr.append(Common.convertCurrencyInteger(value: report.DoanhSoNgay!));
                    valueArr.append(Common.convertCurrencyInteger(value: report.DSPK!));
                    valueArr.append("\(report.PT!)");
                    valueArr.append("\(report.Tong!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetAccessoryRealtimeByShop:
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetAccessoryRealtimeByShop(username: username).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append(report.TenShop!);
                    valueArr.append(Common.convertCurrencyInteger(value: report.DoanhSoEcom!));
                    valueArr.append(Common.convertCurrencyInteger(value: report.DoanhSoNgay!));
                    valueArr.append(Common.convertCurrencyInteger(value: report.DSPK!));
                    valueArr.append("\(report.PT!)");
                    valueArr.append("\(report.Tong!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetSalemanReport:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetSalemanReport(username: username, shopCode: (Cache.user?.ShopCode)!, token: token).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            let dateSystem = Date()
            _ = (Calendar.current as NSCalendar).components([.day,.month,.year], from: dateSystem)
            let yesterday = dateSystem.addingTimeInterval(-24 * 60 * 60)
            let componentYesterday = (Calendar.current as NSCalendar).components([.day,.month,.year], from: yesterday)
            let thisDay = componentYesterday.day
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.Ten_NVBH!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.DS_Total!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.SL_Total!))");
                    valueArr.append("\(report.SL_Total! / thisDay!)");
                    valueArr.append("\(Common.convertCurrencyFloat(number: report.TiTrong_DS!))");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetShopSalesByCategory:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let shopCode = (Cache.ShopInfo?.ShopCode) ?? "";
            let data = mSMApiManager.GetShopSalesByCategory(username: username, shopCode: shopCode, token: token).Data;
            
            if(data != nil && data!.count > 0){
                data!.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.ShopName!)");
                    valueArr.append("\(report.NganhHang!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.TargetThang!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.SoLuong!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.DS_MTD!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.Percent_HT_Target!))%");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.DS_TB_MTD!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.DS_TB_NgayConLai!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.TangGiam_Percent_DS!))%");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetShopSalesByShop:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetShopSalesByShop(username: username, token: token).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.ShopName!)");
                    valueArr.append("\(report.Ten_ASM!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.DS_MTD!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.DS_TB_MTD!))");
                    valueArr.append("\(report.Percent_HT_Target!)%");
                    valueArr.append("\(report.SoSanh_Percent_DS!)");
                    valueArr.append("\(report.TongSoLuong!)");
                    valueArr.append("\(report.Total_HS_TraGop!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetAPRSales:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetAPRSales(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.DoanhSoMTD!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.DS_TBN!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.TangGiam!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.Target_Thang!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.PT_HoanThanh!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.PT_DuKienHoanThanh!))");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetShopSalesByArea:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetShopSalesByArea(username: username, token: token).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.Ten_ASM!)");
                    valueArr.append("\(report.SLShop!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.DS_MTD!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.DS_TB_MTD!))");
                    valueArr.append("\(report.Percent_HT_Target!)%");
                    valueArr.append("\(report.SoSanh_Percent_DS!)%");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetShopSalesByZone:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetShopSalesByZone(username: username, token: token).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.TenVung!)");
                    valueArr.append("\(report.SLShop!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.DS_MTD!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.DS_TB_MTD!))");
                    valueArr.append("\(report.Percent_HT_Target!)%");
                    valueArr.append("\(report.SoSanh_Percent_DS!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetShopSalesRealtime:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetShopSalesRealtime(username: username, token: token).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
//                    valueArr.append("\(report.KhuVuc!)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.DSPK!))");
                    valueArr.append("\(report.PT!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value: report.Tong!))");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetLoanRealtimeByArea:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetLoanRealtimeByZone(username: username, token: token).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.KhuVung!)");
                    valueArr.append("\(report.SoLuong_SVFC!)");
                    valueArr.append("\(report.SoLuong_FEC!)");
                    valueArr.append("\(report.SoLuong_HC!)");
                    valueArr.append("\(report.SoLuong_HDS!)");
                    valueArr.append("\(Common.convertCurrencyInteger(value:report.SLSOHoanTat!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.Total!))");
                    valueArr.append("\(report.TiTrongTraGop!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetLoanRealtimeByShop:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetLoanRealtimeByShop(username: username, token: token).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(report.SoLuong_SVFC!)");
                    valueArr.append("\(report.SoLuong_FEC!)");
                    valueArr.append("\(report.SoLuong_HC!)");
                    valueArr.append("\(report.SoLuong_HDS!)");
                    valueArr.append("\(Common.convertCurrencyInteger(value:report.SLSOHoanTat!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.Total!))");
                    valueArr.append("\(report.TiTrongTraGop!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetLoanRealtimeByZone:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetLoanRealtime(username: username, token: token).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.VungMien!)");
                    valueArr.append("\(report.SoLuong_SVFC!)");
                    valueArr.append("\(report.SoLuong_FEC!)");
                    valueArr.append("\(report.SoLuong_HC!)");
                    valueArr.append("\(report.SoLuong_HDS!)");
                    valueArr.append("\(Common.convertCurrencyInteger(value:report.SLSOHoanTat!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.Total!))");
                    valueArr.append("\(report.TiTrongTraGop!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetAreaSalesRealtime:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetAreaSalesRealtime(username: username, token: token).Data;
            
            if(data != nil && data!.count > 0){
                data!.forEach{ item in
                    valueArr.append("\(item.STT!)");
                    valueArr.append("\(item.ASM!)");
                    valueArr.append("\(item.KhuVuc!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value: item.DSPK!))");
                    valueArr.append("\(item.PT!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value: item.Tong!))");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetZoneSalesRealtime:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetZoneSalesRealtime(username: username, token: token).Data;
            
            if(data != nil && data!.count > 0){
                data!.forEach{ item in
                    valueArr.append("\(item.STT!)");
                    valueArr.append("\(item.Vung!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value: item.DSPK!))");
                    valueArr.append("\(item.PT!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value: item.Tong!))");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetDeviceNotSold:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetDeviceNotSold(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data!.forEach{ item in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(item.shopXinHang!)");
                    valueArr.append("\(item.maSP!)");
                    valueArr.append("\(item.tenSP!)");
                    valueArr.append("\(item.slChuaBan!)");
                    valueArr.append("\(Common.convertCurrencyInteger(value: item.giaTriChuaBan!))");
                    valueArr.append("\(item.percentChuaBan!)%")
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetUnpaidLoan:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            let shopCode = (Cache.selectedShopCode);
            let data = mSMApiManager.GetUnpaidLoan(shopCode: shopCode).Data;
            
            if(data != nil && data!.count > 0){
                data!.forEach{ item in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(item.WarehouseName!)");
                    valueArr.append("\(item.TenASM!)");
                    valueArr.append("\(item.TenSM!)");
                    valueArr.append("\(item.NhanVienSale!)");
                    valueArr.append("\(item.LoaiThe!)");
                    valueArr.append("\(item.HinhThuc!)");
                    valueArr.append("\(item.TongTien!)")
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            return dataArr;
        case .GetG38ShopSalesRealtime:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetG100Realtime(username: username, token: token).Data;
            
            if(data != nil && data!.count > 0){
                data!.forEach{ item in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(item.TenShop!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value: item.DoanhSoPK!))");
                    valueArr.append("\(item.TTPK!)");
                    valueArr.append("\(Common.convertCurrencyInteger(value: item.DSTong!))");
                    valueArr.append("\(item.SLPK!)");
                    valueArr.append("\(item.SLMay!)");
                    valueArr.append("\(item.SLPKSLMay!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetG38ShopSalesMTD:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetG100MTD(username: username, token: token).Data;
            
            if(data != nil && data!.count > 0){
                data!.forEach{ item in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(item.TenShop!)");
                    valueArr.append("\(item.TenASM!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value: item.DoanhSoMTD!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value: item.DoanhSoPK!))");
                    valueArr.append("\(item.TyTrongPK!)");
                    valueArr.append("\(item.SLPK_TN!)");
                    valueArr.append("\(item.SLMayTN!)");
                    valueArr.append("\(item.SLPK_TNSLMay_TN!)");
                    valueArr.append("\(item.TargetSLMay!)");
                    valueArr.append("\(item.PhanTramHTTarget!)%");
                    valueArr.append("\(item.LoiKhenTN!)");
                    valueArr.append("\(item.PhanTramSOMTD!)%");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetTargetReport:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let shopCode = (Cache.selectedShopCode);
            
            let data = mSMApiManager.GetTargetReport(username: username, year: "\(calendar.component(.year, from: date))", month: "\(calendar.component(.month, from: date))", token: token, shopCode: shopCode).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append(report.MaTenNV!);
                    valueArr.append("\(report.SoNgayLamViec!)");
                    valueArr.append("\(report.Target_PK!)");
                    valueArr.append("\(report.Target_DS!)");
                    valueArr.append("\(report.GhiChu!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetUpgradeLoan:
            let shopCode = (Cache.selectedShopCode);
            let data = mSMApiManager.GetUpgradeLoan(shopCode: shopCode).Data;
            
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append(report.TenVietTat!);
                    valueArr.append("\(report.TenNV!)");
                    valueArr.append("\(report.TB_13!)");
                    valueArr.append("\(report.TB_36!)");
                    valueArr.append("\(report.Target_TG!)");
                    valueArr.append("\(report.SL_BanTG_36!)");
                    valueArr.append("\(report.PT_Target!)");
                    valueArr.append("\(report.UocTinh!)");
                    valueArr.append("\(report.PT_Target_UocTinh!)%");
                    valueArr.append("\(report.SL_BanThang_13!)");
                    valueArr.append("\(report.TienThuong!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetViolationMember:
            let userCode = (Cache.selectedEmployeeCode);
            
            let data = mSMApiManager.GetViolationMember(userCode: userCode).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.EmployeeCode!)");
                    valueArr.append("\(report.EmployeeName!)");
                    valueArr.append("\(report.JobTitleName!)");
                    valueArr.append("\(report.ViolationContent!)");
                    valueArr.append("\(report.ViolationTimes!)");
                    valueArr.append("\(report.SoTienPhat!)");
                    valueArr.append("\(report.MonthRecord!)");
                    valueArr.append("\(report.RequestByCode!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
            
            //Bao cao Combo PK Realtime
            
            //        case .GetComboPKRealtimeVung:
            //            let username = (Cache.user?.UserName)!;
            //            let token = (Cache.user?.Token)!;
            //            let data = mSMApiManager.GetComboPKRealtimeVung(username: username, token: token).Data;
            //            var dataArr: [[String]] = [];
            //            var valueArr: [String] = [];
            //            if(data != nil && data!.count > 0){
            //                data?.forEach{ report in
            //                    valueArr.append("\(report.STT!)")
            //                    valueArr.append("\(report.Vung!)")
            //                    valueArr.append("\(report.SL_Combo10!)")
            //                    valueArr.append("\(report.SL_Combo15!)")
            //                    valueArr.append("\(report.SL_Combo20!)")
            //                    valueArr.append("\(report.TongSL_Combo!)")
            //                    valueArr.append("\(report.TyTrong!)")
            //                    dataArr.append(valueArr);
            //                    valueArr.removeAll();
            //                }
            //            }
            //
            //            return dataArr;
            //
            //        case .GetComboPKRealtimeASM:
            //            let username = (Cache.user?.UserName)!;
            //            let token = (Cache.user?.Token)!;
            //            let data = mSMApiManager.GetComboPKRealtimeASM(username: username, token: token).Data;
            //            var dataArr: [[String]] = [];
            //            var valueArr: [String] = [];
            //            if(data != nil && data!.count > 0){
            //                data?.forEach{ report in
            //                    valueArr.append("\(report.STT!)")
            //                    valueArr.append("\(report.TenASM!)")
            //                    valueArr.append("\(report.TenKhuVuc!)")
            //                    valueArr.append("\(report.SL_Combo10!)")
            //                    valueArr.append("\(report.SL_Combo15!)")
            //                    valueArr.append("\(report.SL_Combo20!)")
            //                    valueArr.append("\(report.TongSL_Combo!)")
            //                    valueArr.append("\(report.TyTrong!)")
            //                    dataArr.append(valueArr);
            //                    valueArr.removeAll();
            //                }
            //            }
            //
            //            return dataArr;
            //
            //        case .GetComboPKRealtimeShop:
            //            let username = (Cache.user?.UserName)!;
            //            let token = (Cache.user?.Token)!;
            //            let data = mSMApiManager.GetComboPKRealtimeShop(username: username, token: token).Data;
            //            var dataArr: [[String]] = [];
            //            var valueArr: [String] = [];
            //            if(data != nil && data!.count > 0){
            //                data?.forEach{ report in
            //                    valueArr.append("\(report.STT!)")
            //                    valueArr.append("\(report.TenShop!)")
            //                    valueArr.append("\(report.SL_Combo10!)")
            //                    valueArr.append("\(report.SL_Combo15!)")
            //                    valueArr.append("\(report.SL_Combo20!)")
            //                    valueArr.append("\(report.TongSL_Combo!)")
            //                    valueArr.append("\(report.TyTrong!)")
            //                    dataArr.append(valueArr);
            //                    valueArr.removeAll();
            //                }
            //            }
            //
        //            return dataArr;
        default:
            return [];
        }
    }
    
    
    var exportReportData: [[String]]{
        let date = Date();
        let calendar = Calendar.current;
        
        switch self {
        case .GetDiscountLoanReport:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            let shopCode = (Cache.ShopInfo?.ShopCode) ?? "";
            let data = mSMApiManager.GetDiscountLoan(shopCode: shopCode).Data;
            
            if(data != nil && data!.count > 0){
                counter += 1;
                data?.forEach{ report in
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(report.MaKhachHang!)");
                    valueArr.append("\(report.TenKhachHang!)");
                    valueArr.append("\(report.SoDT!)");
                    valueArr.append("\(report.DonHangNoKM!)");
                    valueArr.append("\(report.DonHangGoc!)");
                    valueArr.append("\(report.NgayDonHang!)");
                    valueArr.append("\(report.MaSPGoc!)");
                    valueArr.append("\(report.TenSPGoc!)");
                    valueArr.append("\(report.MaSPNoKM!)");
                    valueArr.append("\(report.TenSPNoKM!)");
                    valueArr.append("\(report.MaKhoCon!)");
                    valueArr.append("\(report.SoNgayNo!)");
                    valueArr.append("\(report.SLNo!)");
                    valueArr.append("\(report.SLTonKho!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetDiscountFundReport:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetDiscountFundReport(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT)");
                    valueArr.append("\(report.TenShop)");
                    valueArr.append("\(report.QuyGG)");
                    valueArr.append("\(report.QuyGG_TTLP)");
                    valueArr.append("\(report.SoTien)");
                    valueArr.append("\(report.ConLai)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetFFriendInstallReport:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetFFriendInstallReport(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(report.SL_Ban!)");
                    valueArr.append("\(report.SL_Cai!)");
                    valueArr.append("\(report.TyLe!)");
                    valueArr.append("\(report.Doanhso!)");
                    valueArr.append("\(report.DoanhSoLoaiBo!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetPendingRequestReport:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetPendingRequestReport(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(report.HoiVien!)");
                    valueArr.append("\(report.SDT!)");
                    valueArr.append("\(report.SoDonHang!)");
                    valueArr.append("\(report.TenSanPham!)");
                    valueArr.append("\(report.SL!)");
                    valueArr.append("\(report.ThanhTien!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetNotBoughtCompanyReport:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetNotBoughtCompanyReport(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.TenDoanhNghiep!)");
                    valueArr.append("\(report.NgayKyHDDoanhNghiep!)");
                    valueArr.append("\(report.NguoiTiepCan!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetTotalLoanByShop:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetTotalLoanByShop(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.Name!)");
                    valueArr.append("\(report.TongNoHienTai!)");
                    valueArr.append("\(report.NoChuaDenHan!)");
                    valueArr.append("\(report.NoDenHan!)");
                    valueArr.append("\(report.NoQuaHan)");
                    valueArr.append("\(report.NoTren90Ngay!)");
                    valueArr.append("\(report.NoTren60Ngay!)");
                    valueArr.append("\(report.NoTren30Ngay!)");
                    valueArr.append("\(report.NoDuoi30Ngay!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetFFriendsOrder:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetFFriendsOrder(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)")
                    valueArr.append("\(report.Shop!)");
                    valueArr.append("\(report.TongCong!)");
                    valueArr.append("\(report.TraGop!)");
                    valueArr.append("\(report.TraThang!)");
                    valueArr.append("\(report.MTD!)");
                    valueArr.append("\(report.EST!)");
                    valueArr.append("\(report.TG_FF_SoVoi_DSTong!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetVoucherImg:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetVoucherImg(username: username).Data;
            
            if(data != nil && data!.count > 0){
                var counter = 0;
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.KH!)");
                    valueArr.append("\(report.SDT!)");
                    valueArr.append("\(report.CallLog!)");
                    valueArr.append("\(report.TinhTrang!)");
                    valueArr.append("\(report.SalesShop!)");
                    valueArr.append("\(report.NgayHetHan!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetOrderImg:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetOrderImg(username: username).Data;
            
            if(data != nil && data!.count > 0){
                var counter = 0;
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.SoSOPOS)");
                    valueArr.append("\(report.MaCallLog!)");
                    valueArr.append("\(report.TinhTrang)");
                    valueArr.append("\(report.SalesShop!)");
                    valueArr.append("\(report.NgayHenHan!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetConfidentFund:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetConfidentFund(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.MaShop!)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(report.DoanhThu!)");
                    valueArr.append("\(report.DoanhThu_5!)");
                    valueArr.append("\(report.TongChiPhi!)");
                    valueArr.append("\(report.DoiTra!)");
                    valueArr.append("\(report.BaoHanh!)");
                    valueArr.append("\(report.ThuMua!)");
                    valueArr.append("\(report.ChenhLech)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetOverDateWarranty:
            let username = (Cache.user?.UserName)!;
            let shopCode = (Cache.ShopInfo?.ShopCode) ?? "";
            let data = mSMApiManager.GetOverDateWarranty(username: username, shopCode: shopCode).Data;
            
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    let dateTemp: Date = Date(jsonDate: report.NgayTao!)!;
                    let components = (Calendar.current as NSCalendar).components([.day,.month,.year], from: dateTemp);
                    let date: String = "\(components.day!)" + "-" + "\(String(describing: components.month!))" + "-" + "\(String(describing: components.year!))";
                    
                    valueArr.append("\(report.STT!)");
                    valueArr.append(report.TenShop!);
                    valueArr.append("\(report.SoNgayConLai!)");
                    valueArr.append("\(report.MaSP!)");
                    valueArr.append("\(report.MaSPBaoHanh!)");
                    valueArr.append("\(report.MaBaoHanh!)");
                    valueArr.append("\(date)");
                    valueArr.append("\(report.KieuChuyen!)");
                    valueArr.append("\(report.HinhThuc!)");
                    valueArr.append("\(report.TrangThai!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetOverProduct:
            let username = (Cache.user?.UserName)!;
            let shopCode = (Cache.user?.ShopCode) ?? "";
            let data = mSMApiManager.GetOverProduct(username: username, shopCode: shopCode).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.TenSP!)");
                    valueArr.append("\(report.IMEI!)");
                    valueArr.append("\(report.NgayBan!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetCameraReport:
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetCameraReport(username: username).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append(report.TenShop!);
                    valueArr.append(report.MaYeuCau!);
                    valueArr.append(report.TrangThai!);
                    valueArr.append(report.LoaiLoi!);
                    valueArr.append(report.NhanVien!);
                    valueArr.append(report.GhiChu!);
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
//        case .GetTargetCustomerCare:
//            let username = (Cache.user?.UserName)!;
//            let data = mSMApiManager.GetTargetCustomerCare(username: username).Data;
//            var dataArr: [[String]] = [];
//            var valueArr: [String] = [];
//            
//            if(data != nil && data!.count > 0){
//                data?.forEach{ report in
//                    valueArr.append("\(report.STT!)");
//                    valueArr.append("\(report.TenShop!)");
//                    valueArr.append("\(report.DiemCamera!)");
//                    valueArr.append("\(report.DiemHappy!)");
//                    valueArr.append("\(report.ChatLuong!)");
//                    valueArr.append("\(report.LoiKhen_W3!)");
//                    valueArr.append("\(report.SoSO!)");
//                    valueArr.append("\(report.TARGET_W3!)");
//                    valueArr.append("\(report.KetQua_W3!)");
//                    valueArr.append("\(report.TongDiemCSKH!)");
//                    
//                    dataArr.append(valueArr);
//                    valueArr.removeAll();
//                }
//            }
//            
//            return dataArr;
        case .GetOverDeviceReport:
            let username = (Cache.user?.UserName)!;
            let shopCode = (Cache.user?.ShopCode)!;
            let data = mSMApiManager.GetOverDeviceReport(username: username, shopCode: shopCode).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.TenSP!)");
                    valueArr.append("\(report.IMEI!)");
                    valueArr.append("\(report.NgayTon!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            else{
                
            }
            return dataArr;
        case .GetRemainDeviceByCategory:
            let username = (Cache.user?.UserName)!;
            let shopCode = (Cache.user?.ShopCode)!;
            let data = mSMApiManager.GetRemainDeviceByCategory(username: username, shopCode: shopCode).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.NganhHang!)");
                    valueArr.append("\(report.TonKhoHangBan!)");
                    valueArr.append("\((report.GiaTriHangBan! / 1000))");
                    valueArr.append("\(report.VongQuay!)")
                    valueArr.append("\(report.TonKhoChoXuLy!)");
                    valueArr.append("\(report.TonKhoBaoHanh!)");
                    valueArr.append("\(report.TonKhoKyGoi!)");
                    valueArr.append("\(report.TonKhoMayCu!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetAccessoryRealtimeReport:
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetAccessoryRealtimeReport(username: username).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append(report.Vung!);
                    valueArr.append(report.ASM!);
                    valueArr.append(report.KhuVuc!);
                    valueArr.append(report.TenShop!);
                    valueArr.append("\(report.DSPK!)");
                    valueArr.append("\(report.TyTrong!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetAccessoryRealtimeByZone:
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetAccessoryRealtimeByZone(username: username).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append(report.Vung!);
                    valueArr.append("\(report.DoanhSoEcom!)");
                    valueArr.append("\(report.DoanhSoNgay!)");
                    valueArr.append("\(report.DSPK!)");
                    valueArr.append("\(report.PT!)");
                    valueArr.append("\(report.Tong!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetAccessoryRealtimeByArea:
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetAccessoryRealtimeByArea(username: username).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append(report.ASM!);
                    valueArr.append(report.KhuVuc!);
                    valueArr.append("\(report.DoanhSoEcom!)");
                    valueArr.append("\(report.DoanhSoNgay!)");
                    valueArr.append("\(report.DSPK!)");
                    valueArr.append("\(report.PT!)");
                    valueArr.append("\(report.Tong!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetAccessoryRealtimeByShop:
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetAccessoryRealtimeByShop(username: username).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append(report.TenShop!);
                    valueArr.append("\(report.DoanhSoEcom!)");
                    valueArr.append("\(report.DoanhSoNgay!)");
                    valueArr.append("\(report.DSPK!)");
                    valueArr.append("\(report.PT!)");
                    valueArr.append("\(report.Tong!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetSalemanReport:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetSalemanReport(username: username, shopCode: (Cache.user?.ShopCode)!, token: token).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            let dateSystem = Date()
            _ = (Calendar.current as NSCalendar).components([.day,.month,.year], from: dateSystem)
            let yesterday = dateSystem.addingTimeInterval(-24 * 60 * 60)
            let componentYesterday = (Calendar.current as NSCalendar).components([.day,.month,.year], from: yesterday)
            let thisDay = componentYesterday.day
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.Ten_NVBH!)");
                    valueArr.append("\(report.DS_Total!)");
                    valueArr.append("\(report.SL_Total!)");
                    valueArr.append("\(report.SL_Total! / thisDay!)");
                    valueArr.append("\(report.TiTrong_DS!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetShopSalesByCategory:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let shopCode = (Cache.ShopInfo?.ShopCode) ?? "";
            let data = mSMApiManager.GetShopSalesByCategory(username: username, shopCode: shopCode, token: token).Data;
            
            if(data != nil && data!.count > 0){
                data!.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.ShopName!)");
                    valueArr.append("\(report.NganhHang!)");
                    valueArr.append("\(report.TargetThang!)");
                    valueArr.append("\(report.SoLuong!)");
                    valueArr.append("\(report.DS_MTD!)");
                    valueArr.append("\(report.Percent_HT_Target!)%");
                    valueArr.append("\(report.DS_TB_MTD!)");
                    valueArr.append("\(report.DS_TB_NgayConLai!)");
                    valueArr.append("\(report.TangGiam_Percent_DS!)%");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetShopSalesByShop:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetShopSalesByShop(username: username, token: token).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.ShopName!)");
                    valueArr.append("\(report.Ten_ASM!)");
                    valueArr.append("\(report.DS_MTD!)");
                    valueArr.append("\(report.DS_TB_MTD!)");
                    valueArr.append("\(report.Percent_HT_Target!)%");
                    valueArr.append("\(report.SoSanh_Percent_DS!)");
                    valueArr.append("\(report.TongSoLuong!)");
                    valueArr.append("\(report.Total_HS_TraGop!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetAPRSales:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetAPRSales(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(report.DoanhSoMTD!)");
                    valueArr.append("\(report.DS_TBN!)");
                    valueArr.append("\(report.TangGiam!)");
                    valueArr.append("\(report.Target_Thang!)");
                    valueArr.append("\(report.PT_HoanThanh!)");
                    valueArr.append("\(report.PT_DuKienHoanThanh!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetShopSalesByArea:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetShopSalesByArea(username: username, token: token).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.Ten_ASM!)");
                    valueArr.append("\(report.SLShop!)");
                    valueArr.append("\(report.DS_MTD!)");
                    valueArr.append("\(report.DS_TB_MTD!)");
                    valueArr.append("\(report.Percent_HT_Target!)%");
                    valueArr.append("\(report.SoSanh_Percent_DS!)%");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetShopSalesByZone:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetShopSalesByZone(username: username, token: token).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
                    valueArr.append("\(report.TenVung!)");
                    valueArr.append("\(report.SLShop!)");
                    valueArr.append("\(report.DS_MTD!)");
                    valueArr.append("\(report.DS_TB_MTD!)");
                    valueArr.append("\(report.Percent_HT_Target!)%");
                    valueArr.append("\(report.SoSanh_Percent_DS!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetShopSalesRealtime:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetShopSalesRealtime(username: username, token: token).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    valueArr.append("\(report.STT!)");
//                    valueArr.append("\(report.KhuVuc!)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(report.DSPK!)");
                    valueArr.append("\(report.PT!)");
                    valueArr.append("\(report.Tong!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetLoanRealtimeByArea:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetLoanRealtimeByZone(username: username, token: token).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.KhuVung!)");
                    valueArr.append("\(report.SoLuong_SVFC!)");
                    valueArr.append("\(report.SoLuong_FEC!)");
                    valueArr.append("\(report.SoLuong_HC!)");
                    valueArr.append("\(report.SoLuong_HDS!)");
                    valueArr.append("\(report.SLSOHoanTat!)");
                    valueArr.append("\(report.Total!)");
                    valueArr.append("\(report.TiTrongTraGop!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetLoanRealtimeByShop:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetLoanRealtimeByShop(username: username, token: token).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(report.SoLuong_SVFC!)");
                    valueArr.append("\(report.SoLuong_FEC!)");
                    valueArr.append("\(report.SoLuong_HC!)");
                    valueArr.append("\(report.SoLuong_HDS!)");
                    valueArr.append("\(report.SLSOHoanTat!)");
                    valueArr.append("\(report.Total!)");
                    valueArr.append("\(report.TiTrongTraGop!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetLoanRealtimeByZone:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetLoanRealtime(username: username, token: token).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.VungMien!)");
                    valueArr.append("\(report.SoLuong_SVFC!)");
                    valueArr.append("\(report.SoLuong_FEC!)");
                    valueArr.append("\(report.SoLuong_HC!)");
                    valueArr.append("\(report.SoLuong_HDS!)");
                    valueArr.append("\(report.SLSOHoanTat!)");
                    valueArr.append("\(report.Total!)");
                    valueArr.append("\(report.TiTrongTraGop!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetAreaSalesRealtime:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetAreaSalesRealtime(username: username, token: token).Data;
            
            if(data != nil && data!.count > 0){
                data!.forEach{ item in
                    valueArr.append("\(item.STT!)");
                    valueArr.append("\(item.ASM!)");
                    valueArr.append("\(item.KhuVuc!)");
                    valueArr.append("\(item.DSPK!)");
                    valueArr.append("\(item.PT!)");
                    valueArr.append("\(item.Tong!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetZoneSalesRealtime:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetZoneSalesRealtime(username: username, token: token).Data;
            
            if(data != nil && data!.count > 0){
                data!.forEach{ item in
                    valueArr.append("\(item.STT!)");
                    valueArr.append("\(item.Vung!)");
                    valueArr.append("\(item.DSPK!)");
                    valueArr.append("\(item.PT!)");
                    valueArr.append("\(item.Tong!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetDeviceNotSold:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            let username = (Cache.user?.UserName)!;
            let data = mSMApiManager.GetDeviceNotSold(username: username).Data;
            
            if(data != nil && data!.count > 0){
                data!.forEach{ item in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(item.shopXinHang!)");
                    valueArr.append("\(item.maSP!)");
                    valueArr.append("\(item.tenSP!)");
                    valueArr.append("\(item.slChuaBan!)");
                    valueArr.append("\(item.giaTriChuaBan!)");
                    valueArr.append("\(item.percentChuaBan!)%")
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetUnpaidLoan:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            let shopCode = (Cache.selectedShopCode);
            let data = mSMApiManager.GetUnpaidLoan(shopCode: shopCode).Data;
            
            if(data != nil && data!.count > 0){
                data!.forEach{ item in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(item.WarehouseName!)");
                    valueArr.append("\(item.TenASM!)");
                    valueArr.append("\(item.TenSM!)");
                    valueArr.append("\(item.NhanVienSale!)");
                    valueArr.append("\(item.LoaiThe!)");
                    valueArr.append("\(item.HinhThuc!)")
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            return dataArr;
        case .GetG38ShopSalesRealtime:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetG100Realtime(username: username, token: token).Data;
            
            if(data != nil && data!.count > 0){
                data!.forEach{ item in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(item.TenShop!)");
                    valueArr.append("\(item.DoanhSoPK!)");
                    valueArr.append("\(item.TTPK!)");
                    valueArr.append("\(item.DSTong!)");
                    valueArr.append("\(item.SLPK!)");
                    valueArr.append("\(item.SLMay!)");
                    valueArr.append("\(item.SLPKSLMay!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetG38ShopSalesMTD:
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mSMApiManager.GetG100MTD(username: username, token: token).Data;
            
            if(data != nil && data!.count > 0){
                data!.forEach{ item in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(item.TenShop!)");
                    valueArr.append("\(item.TenASM!)");
                    valueArr.append("\(item.DoanhSoMTD!)");
                    valueArr.append("\(item.DoanhSoPK!)");
                    valueArr.append("\(item.TyTrongPK!)");
                    valueArr.append("\(item.SLPK_TN!)");
                    valueArr.append("\(item.SLMayTN!)");
                    valueArr.append("\(item.SLPK_TNSLMay_TN!)");
                    valueArr.append("\(item.TargetSLMay!)");
                    valueArr.append("\(item.PhanTramHTTarget!)%");
                    valueArr.append("\(item.LoiKhenTN!)");
                    valueArr.append("\(item.PhanTramSOMTD!)%");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetTargetReport:
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let shopCode = (Cache.selectedShopCode);
            
            let data = mSMApiManager.GetTargetReport(username: username, year: "\(calendar.component(.year, from: date))", month: "\(calendar.component(.month, from: date))", token: token, shopCode: shopCode).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append(report.MaTenNV!);
                    valueArr.append("\(report.SoNgayLamViec!)");
                    valueArr.append("\(report.Target_PK!)");
                    valueArr.append("\(report.Target_DS!)");
                    valueArr.append("\(report.GhiChu!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetUpgradeLoan:
            let shopCode = (Cache.selectedShopCode);
            let data = mSMApiManager.GetUpgradeLoan(shopCode: shopCode).Data;
            
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append(report.TenVietTat!);
                    valueArr.append("\(report.TenNV!)");
                    valueArr.append("\(report.TB_13!)");
                    valueArr.append("\(report.TB_36!)");
                    valueArr.append("\(report.Target_TG!)");
                    valueArr.append("\(report.SL_BanTG_36!)");
                    valueArr.append("\(report.PT_Target!)");
                    valueArr.append("\(report.UocTinh!)");
                    valueArr.append("\(report.PT_Target_UocTinh!)%");
                    valueArr.append("\(report.SL_BanThang_13!)");
                    valueArr.append("\(report.TienThuong!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        case .GetViolationMember:
            let userCode = (Cache.selectedEmployeeCode);
            
            let data = mSMApiManager.GetViolationMember(userCode: userCode).Data;
            var dataArr: [[String]] = [];
            var valueArr: [String] = [];
            var counter = 0;
            
            if(data != nil && data!.count > 0){
                data?.forEach{ report in
                    counter += 1;
                    valueArr.append("\(counter)");
                    valueArr.append("\(report.EmployeeCode!)");
                    valueArr.append("\(report.EmployeeName!)");
                    valueArr.append("\(report.JobTitleName!)");
                    valueArr.append("\(report.ViolationContent!)");
                    valueArr.append("\(report.ViolationTimes!)");
                    valueArr.append("\(report.SoTienPhat!)");
                    valueArr.append("\(report.MonthRecord!)");
                    valueArr.append("\(report.RequestByCode!)");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
            
        default:
            return [];
        }
    }
}
