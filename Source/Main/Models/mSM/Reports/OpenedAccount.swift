//
//  OpenedAccount.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 05/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

class OpenedAccount: Jsonable{
    var MaKhuVuc: String?;
    var MaShop: String?;
    var MaVungMien: String?;
    var ReqComplete: String?;
    var ReqComplete_Allow: Int?;
    var ReqComplete_NotAllow: Int?;
    var ReqPending: String?;
    var ReqPending_AppraisalBank:Int?;
    var ReqPending_CustInfo: Int?;
    var TenKhuVuc: String?;
    var TenShop: String?;
    var TenVungMien: String?;
    
    var KetQua: String?;
    var BuocPending: String?;
    var MaKH: Int?;
    var SoCallLog: Int?;
    var TenKH: String?;
    
    required init?(json: JSON) {
        MaKhuVuc = json["MaKhuVuc"].string ?? "";
        MaShop = json["MaShop"].string ?? "";
        MaVungMien = json["MaVungMien"].string ?? "";
        ReqComplete = json["ReqComplete"].string ?? "";
        ReqComplete_Allow = json["ReqComplete__Allow"].int ?? 0;
        ReqComplete_NotAllow = json["ReqComplete__NotAllow"].int ?? 0;
        ReqPending = json["ReqPending"].string ?? "";
        ReqPending_AppraisalBank = json["ReqPending__AppraisalBank"].int ?? 0;
        ReqPending_CustInfo = json["ReqPending__CustInfo"].int ?? 0;
        TenKhuVuc = json["TenKhuVuc"].string ?? "";
        TenVungMien = json["TenVungMien"].string ?? "";
        TenShop = json["TenShop"].string ?? "";
        
        //Details
        KetQua = json["KetQua"].string ?? "";
        BuocPending = json["BuocPending"].string ?? "";
        MaKH = json["MaKH"].int ?? 0;
        SoCallLog = json["SoCallLog"].int ?? 0;
        TenKH = json["TenKH"].string ?? "";
    }
}
