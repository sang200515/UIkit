//
//  MyPhamSalemanItem.swift
//  fptshop
//
//  Created by DiemMy Le on 2/17/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"CoThe": 0.000000,
//"Da": 0.000000,
//"EmployeeName": "",
//"Khac": 0.000000,
//"NuocHoa": 0.000000,
//"SLTB": 0.000000,
//"STT": "9999",
//"ShopName": "Tổng",
//"Toc": 0.000000,
//"TongDS": 0.000000,
//"TongSL": 0.000000,
//"TrangDiem": 0.000000,
//SLSO
//DS_TBBill

import UIKit
import SwiftyJSON

class MyPhamSalemanItem: Jsonable {
     required init(json: JSON) {
        CoThe = json["CoThe"].double ?? 0.0;
        Da = json["Da"].double ?? 0.0;
        EmployeeName = json["EmployeeName"].string ?? "";
        Khac = json["Khac"].double ?? 0.0;
        NuocHoa = json["NuocHoa"].double ?? 0.0;
        SLTB = json["SLTB"].double ?? 0.0;
        STT = json["STT"].string ?? "";
        ShopName = json["ShopName"].string ?? "";
        Toc = json["Toc"].double ?? 0.0;
        TongDS = json["TongDS"].double ?? 0.0;
        TongSL = json["TongSL"].double ?? 0.0;
        TrangDiem = json["TrangDiem"].double ?? 0.0;
        SLSO = json["SLSO"].double ?? 0.0;
        DS_TBBill = json["DS_TBBill"].double ?? 0.0;
    }

    var CoThe: Double
    var Da: Double
    var EmployeeName: String
    var Khac: Double
    var NuocHoa: Double
    var SLTB: Double
    var STT: String
    var ShopName: String
    var Toc: Double
    var TongDS: Double
    var TongSL: Double
    var TrangDiem: Double
    var SLSO: Double
    var DS_TBBill: Double
}

class MyPhamSalemanItem2: NSObject {

    var CoThe: Double
    var Da: Double
    var EmployeeName: String
    var Khac: Double
    var NuocHoa: Double
    var SLTB: Double
    var STT: String
    var ShopName: String
    var Toc: Double
    var TongDS: Double
    var TongSL: Double
    var TrangDiem: Double
    var SLSO: Double
    var DS_TBBill: Double
    
    init(CoThe: Double, Da: Double, EmployeeName: String, Khac: Double, NuocHoa: Double, SLTB: Double, STT: String, ShopName: String, Toc: Double, TongDS: Double, TongSL: Double, TrangDiem: Double, SLSO: Double, DS_TBBill: Double) {
        self.CoThe = CoThe
        self.Da = Da
        self.EmployeeName = EmployeeName
        self.Khac = Khac
        self.NuocHoa = NuocHoa
        self.SLTB = SLTB
        self.STT = STT
        self.ShopName = ShopName
        self.Toc = Toc
        self.TongDS = TongDS
        self.TongSL = TongSL
        self.TrangDiem = TrangDiem
        self.SLSO = SLSO
        self.DS_TBBill = DS_TBBill
    }
    
    class func getObjFromDictionary(json:JSON) -> MyPhamSalemanItem2 {
                let CoThe = json["CoThe"].doubleValue
        let Da = json["Da"].doubleValue
        let EmployeeName = json["EmployeeName"].stringValue
        let Khac = json["Khac"].doubleValue
        let NuocHoa = json["NuocHoa"].doubleValue
        let SLTB = json["SLTB"].doubleValue
        let STT = json["STT"].stringValue
        let ShopName = json["ShopName"].stringValue
        let Toc = json["Toc"].doubleValue
        let TongDS = json["TongDS"].doubleValue
        let TongSL = json["TongSL"].doubleValue
        let TrangDiem = json["TrangDiem"].doubleValue
        let SLSO = json["SLSO"].doubleValue
        let DS_TBBill = json["DS_TBBill"].doubleValue
        
        return MyPhamSalemanItem2(CoThe: CoThe, Da: Da, EmployeeName: EmployeeName, Khac: Khac, NuocHoa: NuocHoa, SLTB: SLTB, STT: STT, ShopName: ShopName, Toc: Toc, TongDS: TongDS, TongSL: TongSL, TrangDiem: TrangDiem, SLSO: SLSO, DS_TBBill: DS_TBBill)

    }
    class func parseObjfromArray(array:[JSON])->[MyPhamSalemanItem2]{
        var list:[MyPhamSalemanItem2] = []
        for item in array {
            list.append(self.getObjFromDictionary(json: item))
        }
        return list
    }
    
}

class MyPhamSalemanNew: NSObject {

    var CoThe: String
    var DS_MTD: String
    var DS_TBBill: String
    var Da: String
    var KenhBH: String
    var Khac: String
    var NuocHoa: String
    var TPCN: String
    var SLSO: String
    var STT: String
    var TenNV: String
    var TenShop: String
    var Toc: String
    var TongSL: String
    var TrangDiem: String
    
    init(CoThe: String, DS_MTD: String, DS_TBBill: String, Da: String, KenhBH: String, Khac: String, NuocHoa: String,TPCN: String, SLSO: String, STT: String, TenNV: String, TenShop: String, Toc: String, TongSL: String, TrangDiem: String) {
        self.CoThe = CoThe
        self.DS_MTD = DS_MTD
        self.DS_TBBill = DS_TBBill
        self.Da = Da
        self.KenhBH = KenhBH
        self.Khac = Khac
        self.NuocHoa = NuocHoa
        self.TPCN = TPCN
        self.SLSO = SLSO
        self.STT = STT
        self.TenNV = TenNV
        self.TenShop = TenShop
        self.Toc = Toc
        self.TongSL = TongSL
        self.TrangDiem = TrangDiem
    }
    
    class func getObjFromDictionary(json:JSON) -> MyPhamSalemanNew {
        let CoThe = json["CoThe"].stringValue
        let DS_MTD = json["DS_MTD"].stringValue
        let DS_TBBill = json["DS_TBBill"].stringValue
        let Da = json["Da"].stringValue
        let KenhBH = json["KenhBH"].stringValue
        let Khac = json["Khac"].stringValue
        let NuocHoa = json["NuocHoa"].stringValue
        let TPCN = json["TPCN"].stringValue
        let SLSO = json["SLSO"].stringValue
        let STT = json["STT"].stringValue
        let TenNV = json["TenNV"].stringValue
        let TenShop = json["TenShop"].stringValue
        let Toc = json["Toc"].stringValue
        let TongSL = json["TongSL"].stringValue
        let TrangDiem = json["TrangDiem"].stringValue
        
        return MyPhamSalemanNew(CoThe: CoThe, DS_MTD: DS_MTD, DS_TBBill: DS_TBBill, Da: Da, KenhBH: KenhBH, Khac: Khac, NuocHoa: NuocHoa,TPCN: TPCN, SLSO: SLSO, STT: STT, TenNV: TenNV, TenShop: TenShop, Toc: Toc, TongSL: TongSL, TrangDiem: TrangDiem)
    }
    
    
    class func parseObjfromArray(array:[JSON])->[MyPhamSalemanNew]{
        var list:[MyPhamSalemanNew] = []
        for item in array {
            list.append(self.getObjFromDictionary(json: item))
        }
        return list
    }
    
}

