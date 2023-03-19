//
//  ReportInstallVNG.swift
//  fptshop
//
//  Created by Apple on 9/26/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"IMEI": "35533109016117500",
//"OS": "Android",
//"RegisStatus": "Thiết bị đã đăng ký",
//"ZaloStatus": "Chờ xác nhận",
//"ZingStatus": "Chờ xác nhận",
//"NewsStatus": "Chờ xác nhận",
//"Price": 0,
//"LastUpdate": "26/09/2019 15:44:09"

import UIKit
import SwiftyJSON

class ReportInstallVNG: NSObject {

    let IMEI: String
    let OS: String
    let RegisStatus: String
    let ZaloStatus: String
    let ZingStatus: String
    let NewsStatus: String
    let Price: Int
    let LastUpdate: String
    
    init(IMEI: String, OS: String, RegisStatus: String, ZaloStatus: String, ZingStatus: String, NewsStatus: String, Price: Int, LastUpdate: String) {
        self.IMEI = IMEI
        self.OS = OS
        self.RegisStatus = RegisStatus
        self.ZaloStatus = ZaloStatus
        self.ZingStatus = ZingStatus
        self.NewsStatus = NewsStatus
        self.Price = Price
        self.LastUpdate = LastUpdate
    }
    
    class func parseObjfromArray(array:[JSON])->[ReportInstallVNG]{
        var list:[ReportInstallVNG] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ReportInstallVNG {
        var IMEI = data["IMEI"].string
        var OS = data["OS"].string
        var RegisStatus = data["RegisStatus"].string
        var ZaloStatus = data["ZaloStatus"].string
        var ZingStatus = data["ZingStatus"].string
        var NewsStatus = data["NewsStatus"].string
        var Price = data["Price"].int
        var LastUpdate = data["LastUpdate"].string
        
        IMEI = IMEI == nil ? "" : IMEI
        OS = OS == nil ? "" : OS
        RegisStatus = RegisStatus == nil ? "" : RegisStatus
        ZaloStatus = ZaloStatus == nil ? "" : ZaloStatus
        ZingStatus = ZingStatus == nil ? "" : ZingStatus
        NewsStatus = NewsStatus == nil ? "" : NewsStatus
        Price = Price == nil ? 0 : Price
        LastUpdate = LastUpdate == nil ? "" : LastUpdate
        
        return ReportInstallVNG(IMEI: IMEI!, OS: OS!, RegisStatus: RegisStatus!, ZaloStatus: ZaloStatus!, ZingStatus: ZingStatus!, NewsStatus: NewsStatus!, Price: Price!, LastUpdate: LastUpdate!)
    }
}
