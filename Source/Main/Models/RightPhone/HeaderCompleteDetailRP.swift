//
//  HeaderCompleteDetailRP.swift
//  fptshop
//
//  Created by Ngo Dang tan on 2/18/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"docentry": 1,
//"KhacShop": "N",
//"IMEI": "123456",
//"manufacturer": "Samsung",
//"memory": "80GB",
//"color": "Vang",
//"Sale_price": 0.000000,
//"NgayDang": "2020-02-14 11:30:10.5",
//"Sale_Name": "test api",
//"Sale_mail": "test@gmail.com",

//"Sale_phone": "0369852147",
//"Buy_Name": null,
//"Buy_mail": null,
//"Buy_phone": null,
//"Buy_invoice_SKTel": null,
//"buy_date": null,
//"NgayDenShop": null,
//"Note": "-aaaa",
//"Sotiencoc": 2000.000000,
//"SoTienConLai": 0.000000,
//"NgayCuoi": null
//"TenShopDK": "HCM 305 Tô Hiến Thành",
//"LCNB_number": "",
//"LCNB_TrangThai": "",
//"SoPhieuThu": "",
//"SoPhieuChi": "",
//"Note_LCNB": "",
//"ItemCode": "",
//"ItemName": "samsung S20"
import Foundation
import SwiftyJSON
class HeaderCompleteDetailRP: NSObject {
    var docentry:String
    var KhacShop:String
    var IMEI:String
    var manufacturer:String
    var memory:String
    var color:String
    var Sale_price:Float
    var NgayDang:String
    var Sale_Name:String
    var Sale_mail:String
    var Sale_phone:String
    var Buy_Name:String
    var Buy_mail:String
    var Buy_phone:String
    var Buy_invoice_SKTel:String
    var buy_date:String
    var NgayDenShop:String
    var Note:String
    var Sotiencoc:Float
    var SoTienConLai:Float
    var NgayCuoi:String
    
    var TenShopDK:String
    var LCNB_number:String
    var LCNB_TrangThai:String
    var SoPhieuThu:String
    var SoPhieuChi:String
    var Note_LCNB:String
    var ItemCode:String
    var ItemName:String
    
    
    init(docentry:String
        , KhacShop:String
        , IMEI:String
        , manufacturer:String
        , memory:String
        , color:String
        , Sale_price:Float
        , NgayDang:String
        , Sale_Name:String
        , Sale_mail:String
        , Sale_phone:String
        , Buy_Name:String
        , Buy_mail:String
        , Buy_phone:String
        , Buy_invoice_SKTel:String
        , buy_date:String
        , NgayDenShop:String
        , Note:String
        , Sotiencoc:Float
        , SoTienConLai:Float
        , NgayCuoi:String
        , TenShopDK:String
        , LCNB_number:String
        , LCNB_TrangThai:String
        , SoPhieuThu:String
        , SoPhieuChi:String
        , Note_LCNB:String
        , ItemCode:String
        , ItemName:String){
        self.docentry = docentry
        self.KhacShop = KhacShop
        self.IMEI = IMEI
        self.manufacturer = manufacturer
        self.memory = memory
        self.color = color
        self.Sale_price = Sale_price
        self.NgayDang = NgayDang
        self.Sale_Name = Sale_Name
        self.Sale_mail = Sale_mail
        self.Sale_phone = Sale_phone
        self.Buy_Name = Buy_Name
        self.Buy_mail = Buy_mail
        self.Buy_phone = Buy_phone
        self.Buy_invoice_SKTel = Buy_invoice_SKTel
        self.buy_date = buy_date
        self.NgayDenShop = NgayDenShop
        self.Note = Note
        self.Sotiencoc = Sotiencoc
        self.SoTienConLai = SoTienConLai
        self.NgayCuoi = NgayCuoi
        
        
        self.TenShopDK = TenShopDK
        self.LCNB_number = LCNB_number
        self.LCNB_TrangThai = LCNB_TrangThai
        self.SoPhieuThu = SoPhieuThu
        self.SoPhieuChi = SoPhieuChi
        self.Note_LCNB = Note_LCNB
        self.ItemCode = ItemCode
        self.ItemName = ItemName
    }
    
    
    class func parseObjfromArray(array:[JSON])->[HeaderCompleteDetailRP]{
        var list:[HeaderCompleteDetailRP] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> HeaderCompleteDetailRP{
        var docentry = data["docentry"].string
        var KhacShop = data["KhacShop"].string
        var IMEI = data["IMEI"].string
        var manufacturer = data["manufacturer"].string
        var memory = data["memory"].string
        var color = data["color"].string
        var Sale_price = data["Sale_price"].float
        var NgayDang = data["NgayDang"].string
        var Sale_Name = data["Sale_Name"].string
        
        var Sale_mail = data["Sale_mail"].string
        var Sale_phone = data["Sale_phone"].string
        var Buy_Name = data["Buy_Name"].string
        var Buy_mail = data["Buy_mail"].string
        var Buy_phone = data["Buy_phone"].string
        var Buy_invoice_SKTel = data["Buy_invoice_SKTel"].string
        var buy_date = data["buy_date"].string
        var NgayDenShop = data["NgayDenShop"].string
        var Note = data["Note"].string
        var Sotiencoc = data["Sotiencoc"].float
        var SoTienConLai = data["SoTienConLai"].float
        var NgayCuoi = data["NgayCuoi"].string
        
        var TenShopDK = data["TenShopDK"].string
        var LCNB_number = data["LCNB_number"].string
        var LCNB_TrangThai = data["LCNB_TrangThai"].string
        var SoPhieuThu = data["SoPhieuThu"].string
        
        var SoPhieuChi = data["SoPhieuChi"].string
        var Note_LCNB = data["Note_LCNB"].string
        var ItemCode = data["ItemCode"].string
        var ItemName = data["ItemName"].string
        
        
        
        docentry = docentry == nil ? "" : docentry
        KhacShop = KhacShop == nil ? "" : KhacShop
        IMEI = IMEI == nil ? "" : IMEI
        manufacturer = manufacturer == nil ? "" : manufacturer
        memory = memory == nil ? "" : memory
        color = color == nil ? "" : color
        Sale_price = Sale_price == nil ? 0 : Sale_price
        NgayDang = NgayDang == nil ? "" : NgayDang
        Sale_Name = Sale_Name == nil ? "" : Sale_Name
        Sale_mail = Sale_mail == nil ? "" : Sale_mail
        Sale_phone = Sale_phone == nil ? "" : Sale_phone
        Buy_Name = Buy_Name == nil ? "" : Buy_Name
        Buy_mail = Buy_mail == nil ? "" : Buy_mail
        Buy_phone = Buy_phone == nil ? "" : Buy_phone
        Buy_invoice_SKTel = Buy_invoice_SKTel == nil ? "" : Buy_invoice_SKTel
        buy_date = buy_date == nil ? "" : buy_date
        NgayDenShop = NgayDenShop == nil ? "" : NgayDenShop
        Note = Note == nil ? "" : Note
        Sotiencoc = Sotiencoc == nil ? 0 :Sotiencoc
        SoTienConLai = SoTienConLai == nil ? 0 : SoTienConLai
        NgayCuoi = NgayCuoi == nil ? "" : NgayCuoi
        
        TenShopDK = TenShopDK == nil ? "" : TenShopDK
        LCNB_number = LCNB_number == nil ? "" : LCNB_number
        LCNB_TrangThai = LCNB_TrangThai == nil ? "" : LCNB_TrangThai
        SoPhieuThu = SoPhieuThu == nil ? "" : SoPhieuThu
        
        
        SoPhieuChi = SoPhieuChi == nil ? "" : SoPhieuChi
        Note_LCNB = Note_LCNB == nil ? "" : Note_LCNB
        ItemCode = ItemCode == nil ? "" : ItemCode
        ItemName = ItemName == nil ? "" : ItemName
        
        return HeaderCompleteDetailRP(docentry:docentry!
            , KhacShop:KhacShop!
            , IMEI:IMEI!
            , manufacturer:manufacturer!
            , memory:memory!
            , color:color!
            , Sale_price:Sale_price!
            , NgayDang:NgayDang!
            , Sale_Name:Sale_Name!
            , Sale_mail:Sale_mail!
            , Sale_phone:Sale_phone!
            , Buy_Name:Buy_Name!
            , Buy_mail:Buy_mail!
            , Buy_phone:Buy_phone!
            , Buy_invoice_SKTel:Buy_invoice_SKTel!
            , buy_date:buy_date!
            , NgayDenShop:NgayDenShop!
            , Note:Note!
            , Sotiencoc:Sotiencoc!
            , SoTienConLai:SoTienConLai!
            , NgayCuoi:NgayCuoi!
        , TenShopDK:TenShopDK!
        , LCNB_number:LCNB_number!
        , LCNB_TrangThai:LCNB_TrangThai!
        , SoPhieuThu:SoPhieuThu!
        , SoPhieuChi:SoPhieuChi!
        , Note_LCNB:Note_LCNB!
        , ItemCode:ItemCode!
        , ItemName:ItemName!)
    }
}
