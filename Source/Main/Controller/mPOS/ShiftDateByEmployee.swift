//
//  ShiftDateByEmployee.swift
//  fptshop
//
//  Created by DiemMy Le on 12/24/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class ShiftDateByEmployee: NSObject {

    let employeeCode:String
    let gioBatDauDuocChamIN:String
    let gioKetThuc:String
    
    init(employeeCode:String, gioBatDauDuocChamIN:String, gioKetThuc:String) {
        self.employeeCode = employeeCode
        self.gioBatDauDuocChamIN = gioBatDauDuocChamIN
        self.gioKetThuc = gioKetThuc
    }
    
    class func parseObjfromArray(array:[JSON])->[ShiftDateByEmployee]{
        var list:[ShiftDateByEmployee] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
        
    class func getObjFromDictionary(data:JSON) -> ShiftDateByEmployee{
        let employeeCode = data["employeeCode"].stringValue
        let gioBatDauDuocChamIN = data["gioBatDauDuocChamIN"].stringValue
        let gioKetThuc = data["gioKetThuc"].stringValue
        
        return ShiftDateByEmployee(employeeCode: employeeCode, gioBatDauDuocChamIN: gioBatDauDuocChamIN, gioKetThuc: gioKetThuc)
    }
}
