//
//  Checklistshop_ASM_getNoiDung.swift
//  fptshop
//
//  Created by Apple on 8/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
//"table1": [
//    {
//"p_contentype": 1
//    "p_content": "hfege",
//
//    }
//]

import UIKit
import SwiftyJSON;

class Checklistshop_ASM_getNoiDung: NSObject {
    
    let p_contentype: Int
    let p_content: String
    
    init(p_contentype: Int, p_content: String) {
        self.p_contentype = p_contentype
        self.p_content = p_content
    }
    
    class func parseObjfromArray(array:[JSON])->[Checklistshop_ASM_getNoiDung]{
        var list:[Checklistshop_ASM_getNoiDung] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> Checklistshop_ASM_getNoiDung {
        var p_contentype = data["p_contentype"].int
        var p_content = data["p_content"].string
        
        p_contentype = p_contentype == nil ? 0 : p_contentype
        p_content = p_content == nil ? "" : p_content
        
        return Checklistshop_ASM_getNoiDung(p_contentype: p_contentype!, p_content: p_content!)
    }
}

//"DS_ConLai": 46987825,
//"DS_PK_ConLai": 855027,
//"Name": "23424 - Đoàn Thiên Khang"

class Checklistshop_ASM_getDSTargetPK: NSObject {
    
    let DS_ConLai: Int
    let DS_PK_ConLai: Int
    let Name: String
    
    init(DS_ConLai: Int, DS_PK_ConLai: Int, Name: String) {
        self.DS_ConLai = DS_ConLai
        self.DS_PK_ConLai = DS_PK_ConLai
        self.Name = Name
    }
    
    class func parseObjfromArray(array:[JSON])->[Checklistshop_ASM_getDSTargetPK]{
        var list:[Checklistshop_ASM_getDSTargetPK] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> Checklistshop_ASM_getDSTargetPK {
        var DS_ConLai = data["DS_ConLai"].int
        var DS_PK_ConLai = data["DS_PK_ConLai"].int
        var Name = data["Name"].string
        
        DS_ConLai = DS_ConLai == nil ? 0 : DS_ConLai
        DS_PK_ConLai = DS_PK_ConLai == nil ? 0 : DS_PK_ConLai
        Name = Name == nil ? "" : Name
        
        return Checklistshop_ASM_getDSTargetPK(DS_ConLai: DS_ConLai!, DS_PK_ConLai: DS_PK_ConLai!, Name: Name!)
    }
}

//"table3": [
//    {
//    "p_Target_index": 35
//    "Current_Index": 29.36,

//    }
//]

class Checklistshop_ASM_getDSTargetTyTrongTraGop: NSObject {
    
    let p_Target_index: Int
    let Current_Index: Double
    
    init(p_Target_index: Int, Current_Index: Double) {
        self.p_Target_index = p_Target_index
        self.Current_Index = Current_Index
    }
    
    class func parseObjfromArray(array:[JSON])->[Checklistshop_ASM_getDSTargetTyTrongTraGop]{
        var list:[Checklistshop_ASM_getDSTargetTyTrongTraGop] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> Checklistshop_ASM_getDSTargetTyTrongTraGop {
        var p_Target_index = data["p_Target_index"].int
        var Current_Index = data["Current_Index"].double
        
        p_Target_index = p_Target_index == nil ? 0 : p_Target_index
        Current_Index = Current_Index == nil ? 0.0 : Current_Index
        
        return Checklistshop_ASM_getDSTargetTyTrongTraGop(p_Target_index: p_Target_index!, Current_Index: Current_Index!)
    }
}
//
//"table4": [
//    {
//    "MaSP": "00594152",
//    "Model": "Mi A3 64GB",
//    "TenSP": "ĐTDĐ Xiaomi Mi A3 64GB Xám (Grey )"
//    }
//]

class Checklistshop_ASM_getDSSPHotSale: NSObject {
    
    let MaSP: String
    let Model: String
    let TenSP: String
    
    init(MaSP: String, Model: String, TenSP: String) {
        self.MaSP = MaSP
        self.Model = Model
        self.TenSP = TenSP
    }
    
    class func parseObjfromArray(array:[JSON])->[Checklistshop_ASM_getDSSPHotSale]{
        var list:[Checklistshop_ASM_getDSSPHotSale] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> Checklistshop_ASM_getDSSPHotSale {
        var MaSP = data["MaSP"].string
        var Model = data["Model"].string
        var TenSP = data["TenSP"].string
        
        MaSP = MaSP == nil ? "" : MaSP
        Model = Model == nil ? "" : Model
        TenSP = TenSP == nil ? "" : TenSP
        
        return Checklistshop_ASM_getDSSPHotSale(MaSP: MaSP!, Model: Model!, TenSP: TenSP!)
    }
}
