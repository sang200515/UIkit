//
//  ShinhanData.swift
//  fptshop
//
//  Created by Ngoc Bao on 14/02/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
struct ShinhanData {
    static var IS_RUNNING = false
    static var cmndType = -1 // CMND-9 số: truyền 0; CCCD: truyền 1; CMND-12 số: truyền 3
    static var docEntry = 0
	static var newDocEntry = 0
    static var fontCmnd: ShinhanFontBase?
    static var behindCmnd: ShinhanBehindBase?
    static var infoUser: ShinhanExistingApp?
    static var inforCustomer: ShinhanExistingApp?
    static var inforCustomerFromCore: ShinhanExistingApp?
    static var selectedTragop: ShinhanTragopData?
    static var selectedKyHan: ShinhanLoanTenure?
    static var sotiencoc: Float = 0
    static var tientraTruoc: Float = 0
    static var tienvay: Float = 0
    static var phibaohiem: Float = 0
    static var giamgia: Float = 0
    static var tongTHanhtoan: Int = 0
    static var imageChungtu1: UIImage?
    static var imageChungtu2: UIImage?
    static var imageChungtu3: UIImage?
    static var imageChungtu4: UIImage?
    static var imageChungtu5: UIImage?
    static var detailorDerHistory: ShinhanOrderDetail?
    static var updateFromImageVC = false
    static var totalWithoutByProduct: Float = 0
    static var soMpos: String =  ""
    static var mposNum: String = ""

    static func resetShinhanData() {
        mposNum = ""
        IS_RUNNING = false
        cmndType = -1
        docEntry = 0
//		newDocEntry = 0
        fontCmnd = nil
        behindCmnd = nil
        infoUser = nil
        inforCustomer = nil
        selectedTragop = nil
        selectedKyHan = nil
        sotiencoc = 0
        tientraTruoc = 0
        tienvay = 0
        phibaohiem = 0
        giamgia = 0
        tongTHanhtoan = 0
        Cache.infoCustomerMirae?.pre_docentry = "0"
        Cache.promotionsMirae.removeAll()
        Cache.groupMirae = []
        Cache.itemsPromotionMirae.removeAll()
        Cache.listDatCocMirae.removeAll()
        imageChungtu1 = nil
        imageChungtu2 = nil
        imageChungtu3 = nil
        imageChungtu4 = nil
        imageChungtu5 = nil
        detailorDerHistory = nil
        updateFromImageVC = false
        totalWithoutByProduct = 0
        soMpos = ""
    }

    static func createXmlPromotion() -> String {
        var xml = "<line>"
        for item in ShinhanData.detailorDerHistory?.order ?? []{
            let whsCod = "\(Cache.user!.ShopCode)010"
            var imei = item.imei
            if(imei == "N/A"){
                imei = ""
            }
            xml  = xml + "<item U_ItmCod=\"\(item.itemCode)\" U_Imei=\"\(imei)\" U_Quantity=\"\(1)\" U_PriceBT=\"\(String(format: "%.6f", 0))\" U_Price=\"\(String(format: "%.6f", item.price))\" U_WhsCod=\"\(whsCod)\"/>"
        }
        xml = xml + "</line>"
        return xml
    }
    
    static func parseXMLProduct(list:[ShinhanOrder] = ShinhanData.detailorDerHistory?.order ?? [])->String{
        var rs:String = "<line>"
        for item in list {
            var name = item.itemName
            name = name.replace(target: "&", withString:"&#38;")
            name = name.replace(target: "<", withString:"&#60;")
            name = name.replace(target: ">", withString:"&#62;")
            name = name.replace(target: "\"", withString:"&#34;")
            name = name.replace(target: "'", withString:"&#39;")
            
            if(item.imei == "N/A"){
                item.imei = ""
            }
            
            item.imei = item.imei.replace(target: "&", withString:"&#38;")
            item.imei = item.imei.replace(target: "<", withString:"&#60;")
            item.imei = item.imei.replace(target: ">", withString:"&#62;")
            item.imei = item.imei.replace(target: "\"", withString:"&#34;")
            item.imei = item.imei.replace(target: "'", withString:"&#39;")
            
            rs = rs + "<item U_ItmCod=\"\(item.itemCode)\" U_Imei=\"\(item.imei)\" U_Quantity=\"\(1)\"  U_Price=\"\(String(format: "%.6f", item.price))\" U_WhsCod=\"\(Cache.user!.ShopCode)010\" U_ItmName=\"\(name)\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
}
