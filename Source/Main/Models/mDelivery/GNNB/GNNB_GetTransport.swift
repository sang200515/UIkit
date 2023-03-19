//
//  GNNB_GetTransport.swift
//  fptshop
//
//  Created by DiemMy Le on 9/1/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"BinTotal" : 0,
//"ShipDateTime" : "2020-09-03T08:51:30.260",
//"ShiperName" : "",
//"BillStatusCode" : "1",
//"CreateDateTime" : "2020-08-31T14:39:04.587",
//"TransporterName" : "Nhất Tín",
//"ReceiveDateTime" : "2020-09-03T08:51:30.260",
//"ReceiverName" : "",
//"ShopCode_Re" : "18030",
//"ShiperCode" : "",
//"ShopCode_Ex" : "30808",
//"username" : "5529",**
//"ReceiverCode" : "",
//"TransporterCode" : "FS",
//"BillCode" : "FS435766",
//"ShopName_Re" : "Phòng bảo hành Miền Nam",
//"ShopName_Ex" : "HCM 305 Tô Hiến Thành",
//"BillStatusName" : "Chờ Giao"
//"BillType": "2" => Nha Van Chuyen
//"BillType": "1" => GNNB

import UIKit
import SwiftyJSON

class GNNB_GetTransport: NSObject {

    let billCode:String
    let shopCode_Ex:String
    let shopName_Ex:String
    let shopCode_Re: String
    let shopName_Re: String
    let binTotal: Int
    let createDateTime: String
    let shipDateTime: String
    let receiveDateTime: String
    var transporterName: String
    let transporterCode: String
    let shiperCode: String
    let shiperName: String
    let receiverCode: String
    var receiverName: String
    let billStatusCode: String
    let billStatusName: String
    let username: String
    let BillType: String
    let SenderName: String
    var arrKienHang = [GNNB_KienHang]()
    var STT: Int

    init(billCode:String, shopCode_Ex:String, shopName_Ex:String, shopCode_Re: String, shopName_Re: String, binTotal: Int, createDateTime: String, shipDateTime: String, receiveDateTime: String, transporterName: String, transporterCode: String, shiperCode: String, shiperName: String, receiverCode: String, receiverName: String, billStatusCode: String, billStatusName: String, username: String, BillType: String, SenderName: String, STT: Int) {
        
        self.billCode = billCode
        self.shopCode_Ex = shopCode_Ex
        self.shopName_Ex = shopName_Ex
        self.shopCode_Re = shopCode_Re
        self.shopName_Re = shopName_Re
        
        self.binTotal = binTotal
        self.createDateTime = createDateTime
        self.shipDateTime = shipDateTime
        self.receiveDateTime = receiveDateTime
        self.transporterName = transporterName
        
        self.transporterCode = transporterCode
        self.shiperCode = shiperCode
        self.shiperName = shiperName
        self.receiverCode = receiverCode
        self.receiverName = receiverName
        
        self.billStatusCode = billStatusCode
        self.billStatusName = billStatusName
        self.username = username
        self.BillType = BillType
        self.SenderName = SenderName
        self.STT = STT
    }
    
    class func parseObjfromArray(array:[JSON])->[GNNB_GetTransport]{
        var list:[GNNB_GetTransport] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> GNNB_GetTransport {
        var billCode = data["BillCode"].string
        var shopCode_Ex = data["ShopCode_Ex"].string
        var shopName_Ex = data["ShopName_Ex"].string
        var shopCode_Re = data["ShopCode_Re"].string
        var shopName_Re = data["ShopName_Re"].string
        var binTotal = data["BinTotal"].int
        var createDateTime = data["CreateDateTime"].string
        var shipDateTime = data["ShipDateTime"].string
        
        var receiveDateTime = data["ReceiveDateTime"].string
        var transporterName = data["TransporterName"].string
        var transporterCode = data["TransporterCode"].string
        var shiperCode = data["ShiperCode"].string
        
        var shiperName = data["ShiperName"].string
        var receiverCode = data["ReceiverCode"].string
        var receiverName = data["ReceiverName"].string
        var billStatusCode = data["BillStatusCode"].string
        var billStatusName = data["BillStatusName"].string
        var username = data["username"].string
        var BillType = data["BillType"].string
        var SenderName = data["SenderName"].string
        
        billCode = billCode == nil ? "" : billCode
        shopCode_Ex = shopCode_Ex == nil ? "" : shopCode_Ex
        shopName_Ex = shopName_Ex == nil ? "" : shopName_Ex
        shopCode_Re = shopCode_Re == nil ? "" : shopCode_Re
        shopName_Re = shopName_Re == nil ? "" : shopName_Re
        
        binTotal = binTotal == nil ? 0 : binTotal
        createDateTime = createDateTime == nil ? "" : createDateTime
        shipDateTime = shipDateTime == nil ? "" : shipDateTime
        receiveDateTime = receiveDateTime == nil ? "" : receiveDateTime
        transporterName = transporterName == nil ? "" : transporterName
        transporterCode = transporterCode == nil ? "" : transporterCode
        shiperCode = shiperCode == nil ? "" : shiperCode
        
        shiperName = shiperName == nil ? "" : shiperName
        receiverCode = receiverCode == nil ? "" : receiverCode
        receiverName = receiverName == nil ? "" : receiverName
        billStatusCode = billStatusCode == nil ? "" : billStatusCode
        billStatusName = billStatusName == nil ? "" : billStatusName
        username = username == nil ? "" : username
        BillType = BillType == nil ? "" : BillType
        SenderName = SenderName == nil ? "" : SenderName
        
        return GNNB_GetTransport(billCode: billCode!, shopCode_Ex: shopCode_Ex!, shopName_Ex: shopName_Ex!, shopCode_Re: shopCode_Re!, shopName_Re: shopName_Re!, binTotal: binTotal!, createDateTime: createDateTime!, shipDateTime: shipDateTime!, receiveDateTime: receiveDateTime!, transporterName: transporterName!, transporterCode: transporterCode!, shiperCode: shiperCode!, shiperName: shiperName!, receiverCode: receiverCode!, receiverName: receiverName!, billStatusCode: billStatusCode!, billStatusName: billStatusName!, username: username!, BillType: BillType!, SenderName: SenderName!, STT: 0)
    }
}

struct GNNB_KienHang {
    var kienHangCode: String
    var status: Bool
}
