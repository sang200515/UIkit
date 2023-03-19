//
//  ReportCaseMyPham.swift
//  fptshop
//
//  Created by DiemMy Le on 2/17/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

enum ReportCaseMyPham {
    case GetMyPhamShop
    case GetMyPhamSaleman
    case GetDSRealtimeMyPham
    case GetMyPhamSalemanNew
}

extension ReportCaseMyPham{
    var caseIcon: String{
        return "ic_report_details";
    }
    
    var caseName: String{
        switch self {
        case .GetMyPhamShop:
            return "BC DS Mỹ Phẩm Theo Shop"
        case .GetMyPhamSaleman:
            return "BC DS Mỹ Phẩm Theo Nhân Viên"
        case .GetDSRealtimeMyPham:
            return "DS Realtime Mỹ Phẩm"
        case .GetMyPhamSalemanNew:
            return "Báo cáo DS theo NV"
        }
    }
    
    var reportHeader: [String]{
        return [];
    }
    
    static func MapPermissionMypham(permissions: [PermissionHashCode]) -> [ReportCaseMyPham]{
        var returnedCase: [ReportCaseMyPham] = [];
        permissions.forEach{ permission in
            switch permission{
            case .MYPHAM_SHOP:
                returnedCase.append(ReportCaseMyPham.GetMyPhamShop)
            case .MYPHAM_SALEMAN:
                returnedCase.append(ReportCaseMyPham.GetMyPhamSaleman)
            case .DS_REALTIME_MYPHAM:
                returnedCase.append(ReportCaseMyPham.GetDSRealtimeMyPham)
            case .BC_MYPHAM_NEW:
                returnedCase.append(ReportCaseMyPham.GetMyPhamSalemanNew)
            default:
                break;
            }
        }
        
        return returnedCase;
    }
}
