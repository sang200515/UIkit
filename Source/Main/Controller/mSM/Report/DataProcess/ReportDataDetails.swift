//
//  ReportDataDetails.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 11/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;

extension ReportCase{
    var reportDetailsHeader: [String]{
        switch self {
        case .GetG38ShopSalesMTD:
            return ["STT", "Tên shop", "ASM", "DS MTD", "DSPK MTD", "TTPK MTD", "SLPK MTD", "SL máy", "SLPK/SLM MTD", "Target SL máy", "% HT Target", "SL máy MTD kỳ trước", "% tăng giảm sv kỳ truóc", "SL lời khen", "SL khen MTD kỳ trước", "% tăng giảm vs lời khen kỳ trc", "% trên SO MTD", "SL HDTG", "SL SSD"];
        case .GetShopSalesRealtime:
            return ["STT", "Khu vực", "Shop", "DS Shop", "DS E-com", "DSPK", "DSPK Thường", "DSPKNK", "TTPK", "Tổng"];
        case .GetAreaSalesRealtime:
            return ["STT", "ASM", "Khu vực", "DS Shop", "DS E-com", "DSPK", "DSPK Thường", "DSPKNK", "TTPK", "Tổng"];
        case .GetZoneSalesRealtime:
            return ["STT", "Vùng", "DS Shop", "DS E-com" , "DSTG", "DSPK", "DSPK Thường", "DSPKNK", "TTPK", "Tổng"];
        case .GetShopSalesByShop:
            return ["STT", "Shop", "ASM", "DS MTD", "DS TB ngày", "Target tháng trước", "DS Estimate", "% HT target", "DS MTD tháng trước", "% tăng giảm vs DS tháng trước", "SL MT", "SL ĐT", "SL MTB", "SL Apple", "SL Máy cũ", "Tổng SL", "% Hoàn thành PK", "Dự kiến hoàn thành PK", "Tỷ trọng PK", "Tỷ lệ PK", "ACS", "PPF", "FE", "HDS", "Total HS Trả góp"];
        case .GetShopSalesByArea:
            return ["STT", "Khu vực", "ASM", "SL Shop", "DS MTD", "DS D-1", "DS TB ngày", "DS TB/Shop", "Target tháng trước", "DS Estimate", "% HT target", "DS MTD tháng trước", "% tăng giảm vs DS tháng trước", "SL MT", "SL ĐT", "SL MTB", "SL Apple", "SL Máy cũ", "Tổng SL", "% Hoàn thành PK", "Dự kiến hoàn thành PK", "Tỷ trọng PK", "Tỷ lệ PK", "ACS", "PPF", "FE", "HDS", "Total HS Trả góp"];
        case .GetShopSalesByZone:
            return ["STT", "Vùng miền", "RSM", "SL Shop", "DS MTD", "DS D-1", "DS TB ngày", "DS TB/Shop", "Target tháng trước", "DS Estimate", "% HT target", "DS MTD tháng trước", "% tăng giảm vs DS tháng trước", "SL MT", "SL ĐT", "SL MTB", "SL Apple", "SL Máy cũ", "Tổng SL", "% Hoàn thành PK", "Dự kiến hoàn thành PK", "Tỷ trọng PK", "Tỷ lệ PK", "ACS", "PPF", "FE", "HDS", "Total HS Trả góp"];
        case .GetSalemanReport:
            return ["STT", "Tên NV", "Tổng DS", "Tổng SL", "SLTB", "Apple", "SL Apple", "ĐTDĐ", "SL ĐTDĐ", "MT", "SL MT", "MTB", "SL MTB", "PK", "Doanh số PK", "DV", "Máy cũ", "SL Máy cũ"];
        default:
            return [];
        }
    }
    
    var reportDetailsData: [[String]]{
        switch self {
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
                    valueArr.append("\(Common.convertCurrencyDouble(value:  item.DoanhSoMTD!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  item.DoanhSoPK!))");
                    valueArr.append("\(item.TyTrongPK!)");
                    valueArr.append("\(item.SLPK_TN!)");
                    valueArr.append("\(item.SLMayTN!)");
                    valueArr.append("\(item.SLPK_TNSLMay_TN!)");
                    valueArr.append("\(item.TargetSLMay!)");
                    valueArr.append("\(item.PhanTramHTTarget!)%");
                    valueArr.append("\(item.SLMayTT!)");
                    valueArr.append("\(item.PhanTramTangGiamSL!)%");
                    valueArr.append("\(item.LoiKhenTN!)");
                    valueArr.append("\(item.LoiKhenTT!)");
                    valueArr.append("\(item.PhanTramTangGiamLK!)%");
                    valueArr.append("\(item.PhanTramSOMTD!)%");
                    valueArr.append("\(item.SLHopDongTraGop!)");
                    valueArr.append("\(item.SoLuongSSD!)");
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
                    valueArr.append("\(Common.convertCurrencyDouble(value:  item.DoanhSoNgay!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  item.DS_ECOM!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  item.DSPK!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  item.DSPKThuong!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  item.DSPKNK!))");
                    valueArr.append("\(item.PT!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  item.Tong!))");
                    
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
                    valueArr.append("\(Common.convertCurrencyDouble(value:  item.DoanhSoNgay!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  item.DS_ECOM!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  item.DSDV!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  item.DSPK!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  item.DSPKThuong!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  item.DSPKNK!))");
                    valueArr.append("\(item.PT!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  item.Tong!))");
                    
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
                    valueArr.append("\(report.KhuVuc!)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DoanhSoNgay!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_ECOM!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DSPK!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DSPKThuong!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DSPKNK!))");
                    valueArr.append("\(report.PT!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.Tong!))");
                    
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
                    valueArr.append("\(report.TenKhuVuc!)");
                    valueArr.append("\(report.Ten_ASM!)");
                    valueArr.append("\(report.SLShop!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_MTD!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_NgayTruoc!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_TB_MTD!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_TB_MTD_Shop!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.Target!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_Estimate!))");
                    valueArr.append("\(report.Percent_HT_Target!)%");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_MTD_ThangTruoc!))");
                    valueArr.append("\(report.SoSanh_Percent_DS!)%");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.MayTinh!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.DienThoai!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.MayTinhBang!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.Apple!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.MayCu!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.TongSoLuong!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.PT_HoanThanhPK!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DuKienHoanThanhPK!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.TyTrongPK!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.TyLePK!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.ACS!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.PPF!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.FE!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.HDS!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.Total_HS_TraGop!))");
                    
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
                    valueArr.append("\(report.Ten_RSM!)");
                    valueArr.append("\(report.SLShop!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_MTD!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_NgayTruoc!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_TB_MTD!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_TB_MTD_Shop!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.Target!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_Estimate!))");
                    valueArr.append("\(report.Percent_HT_Target!)%");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_MTD_ThangTruoc!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.SoSanh_Percent_DS!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.MayTinh!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.DienThoai!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.MayTinhBang!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.Apple!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.MayCu!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.TongSoLuong!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.PT_HoanThanhPK!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DuKienHoanThanhPK!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.TyTrongPK!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.TyLePK!)))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.ACS!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.PPF!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.FE!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.HDS!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.Total_HS_TraGop!))");
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
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_MTD!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_TB_MTD!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.Target!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_Estimate!))");
                    valueArr.append("\(report.Percent_HT_Target!)%");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_MTD_ThangTruoc!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.SoSanh_Percent_DS!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.MayTinh!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.DienThoai!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.MayTinhBang!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.Apple!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.MayCu!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.TongSoLuong!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.PT_HoanThanhPK!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DuKienHoanThanhPK!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.TyTrongPK!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.TyLePK!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.ACS!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.PPF!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.FE!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.HDS!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.Total_HS_TraGop!))");
                    
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
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_Total!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.SL_Total!))");
                    valueArr.append("\(report.SL_Total! / thisDay!)");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_Apple!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.SL_Apple!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_Mobile!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.SL_Mobile!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_MT!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.SL_MT!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_MTB!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.SL_MTB!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_PhuKien!))");
                    valueArr.append("\(Common.convertCurrencyFloat(number:  report.TiTrong_DS!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_DichVu!))");
                    valueArr.append("\(Common.convertCurrencyDouble(value:  report.DS_MayCu!))");
                    valueArr.append("\(Common.convertCurrencyInteger(value: report.SL_MayCu!))");
                    
                    dataArr.append(valueArr);
                    valueArr.removeAll();
                }
            }
            
            return dataArr;
        default:
            return [];
        }
    }
    
    var exportReportDetailsData: [[String]]{
        switch self {
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
                    valueArr.append("\(item.DoanhSoMTD!)");
                    valueArr.append("\(item.TyTrongPK!)");
                    valueArr.append("\(item.SLPK_TN!)");
                    valueArr.append("\(item.SLMayTN!)");
                    valueArr.append("\(item.SLPK_TNSLMay_TN!)");
                    valueArr.append("\(item.TargetSLMay!)");
                    valueArr.append("\(item.PhanTramHTTarget!)%");
                    valueArr.append("\(item.SLMayTT!)");
                    valueArr.append("\(item.PhanTramTangGiamSL!)%");
                    valueArr.append("\(item.LoiKhenTN!)");
                    valueArr.append("\(item.LoiKhenTT!)");
                    valueArr.append("\(item.PhanTramTangGiamLK!)%");
                    valueArr.append("\(item.PhanTramSOMTD!)%");
                    valueArr.append("\(item.SLHopDongTraGop!)");
                    valueArr.append("\(item.SoLuongSSD!)");
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
                    valueArr.append("\(item.DoanhSoNgay!)");
                    valueArr.append("\(item.DS_ECOM!)");
                    valueArr.append("\(item.DSPK!)");
                    valueArr.append("\(item.DSPKThuong!)");
                    valueArr.append("\(item.DSPKNK!)");
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
                    valueArr.append("\(item.DoanhSoNgay!)");
                    valueArr.append("\(item.DS_ECOM!)");
                    valueArr.append("\(item.DSDV!)");
                    valueArr.append("\(item.DSPK!)");
                    valueArr.append("\(item.DSPKThuong!)");
                    valueArr.append("\(item.DSPKNK!)");
                    valueArr.append("\(item.PT!)");
                    valueArr.append("\(item.Tong!)");
                    
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
                    valueArr.append("\(report.KhuVuc!)");
                    valueArr.append("\(report.TenShop!)");
                    valueArr.append("\(report.DoanhSoNgay!)");
                    valueArr.append("\(report.DS_ECOM!)");
                    valueArr.append("\(report.DSPK!)");
                    valueArr.append("\(report.DSPKThuong!)");
                    valueArr.append("\(report.DSPKNK!)");
                    valueArr.append("\(report.PT!)");
                    valueArr.append("\(report.Tong!)");
                    
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
                    valueArr.append("\(report.TenKhuVuc!)");
                    valueArr.append("\(report.Ten_ASM!)");
                    valueArr.append("\(report.SLShop!)");
                    valueArr.append("\(report.DS_MTD!)");
                    valueArr.append("\(report.DS_NgayTruoc!)");
                    valueArr.append("\(report.DS_TB_MTD!)");
                    valueArr.append("\(report.DS_TB_MTD_Shop!)");
                    valueArr.append("\(report.Target!)");
                    valueArr.append("\(report.DS_Estimate!)");
                    valueArr.append("\(report.Percent_HT_Target!)%");
                    valueArr.append("\(report.DS_MTD_ThangTruoc!)");
                    valueArr.append("\(report.SoSanh_Percent_DS!)%");
                    valueArr.append("\(report.MayTinh!)");
                    valueArr.append("\(report.DienThoai!)");
                    valueArr.append("\(report.MayTinhBang!)");
                    valueArr.append("\(report.Apple!)");
                    valueArr.append("\(report.MayCu!)");
                    valueArr.append("\(report.TongSoLuong!)");
                    valueArr.append("\(report.PT_HoanThanhPK!)");
                    valueArr.append("\(report.DuKienHoanThanhPK!)");
                    valueArr.append("\(report.TyTrongPK!)");
                    valueArr.append("\(report.TyLePK!)");
                    valueArr.append("\(report.ACS!)");
                    valueArr.append("\(report.PPF!)");
                    valueArr.append("\(report.FE!)");
                    valueArr.append("\(report.HDS!)");
                    valueArr.append("\(report.Total_HS_TraGop!)");
                    
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
                    valueArr.append("\(report.Ten_RSM!)");
                    valueArr.append("\(report.SLShop!)");
                    valueArr.append("\(report.DS_MTD!)");
                    valueArr.append("\(report.DS_NgayTruoc!)");
                    valueArr.append("\(report.DS_TB_MTD!)");
                    valueArr.append("\(report.DS_TB_MTD_Shop!)");
                    valueArr.append("\(report.Target!)");
                    valueArr.append("\(report.DS_Estimate!)");
                    valueArr.append("\(report.Percent_HT_Target!)%");
                    valueArr.append("\(report.DS_MTD_ThangTruoc!)");
                    valueArr.append("\(report.SoSanh_Percent_DS!)");
                    valueArr.append("\(report.MayTinh!)");
                    valueArr.append("\(report.DienThoai!)");
                    valueArr.append("\(report.MayTinhBang!)");
                    valueArr.append("\(report.Apple!)");
                    valueArr.append("\(report.MayCu!)");
                    valueArr.append("\(report.TongSoLuong!)");
                    valueArr.append("\(report.PT_HoanThanhPK!)");
                    valueArr.append("\(report.DuKienHoanThanhPK!)");
                    valueArr.append("\(report.TyTrongPK!)");
                    valueArr.append("\(report.TyLePK!))");
                    valueArr.append("\(report.ACS!)");
                    valueArr.append("\(report.PPF!)");
                    valueArr.append("\(report.FE!)");
                    valueArr.append("\(report.HDS!)");
                    valueArr.append("\(report.Total_HS_TraGop!)");
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
                    valueArr.append("\(report.Target!)");
                    valueArr.append("\(report.DS_Estimate!)");
                    valueArr.append("\(report.Percent_HT_Target!)%");
                    valueArr.append("\(report.DS_MTD_ThangTruoc!)");
                    valueArr.append("\(report.SoSanh_Percent_DS!)");
                    valueArr.append("\(report.MayTinh!)");
                    valueArr.append("\(report.DienThoai!)");
                    valueArr.append("\(report.MayTinhBang!)");
                    valueArr.append("\(report.Apple!)");
                    valueArr.append("\(report.MayCu!)");
                    valueArr.append("\(report.TongSoLuong!)");
                    valueArr.append("\(report.PT_HoanThanhPK!)");
                    valueArr.append("\(report.DuKienHoanThanhPK!)");
                    valueArr.append("\(report.TyTrongPK!)");
                    valueArr.append("\(report.TyLePK!)");
                    valueArr.append("\(report.ACS!)");
                    valueArr.append("\(report.PPF!)");
                    valueArr.append("\(report.FE!)");
                    valueArr.append("\(report.HDS!)");
                    valueArr.append("\(report.Total_HS_TraGop!)");
                    
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
                    valueArr.append("\(report.DS_Apple!)");
                    valueArr.append("\(report.SL_Apple!)");
                    valueArr.append("\(report.DS_Mobile!)");
                    valueArr.append("\(report.SL_Mobile!)");
                    valueArr.append("\(report.DS_MT!)");
                    valueArr.append("\(report.SL_MT!)");
                    valueArr.append("\(report.DS_MTB!)");
                    valueArr.append("\(report.SL_MTB!)");
                    valueArr.append("\(report.DS_PhuKien!)");
                    valueArr.append("\(report.TiTrong_DS!)");
                    valueArr.append("\(report.DS_DichVu!)");
                    valueArr.append("\(report.DS_MayCu!)");
                    valueArr.append("\(report.SL_MayCu!)");
                    
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
