//
//  BillFtel.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class BillFtel: NSObject {
    
    var Description: String
    var BillDate: String
    var RowID: Int
    var Amount: Int
    var Bill: String
    
    init(Description: String, BillDate: String, RowID: Int, Amount: Int, Bill: String){
        self.Description = Description
        self.BillDate = BillDate
        self.RowID = RowID
        self.Amount = Amount
        self.Bill = Bill
    }
    class func parseObjfromArray(array:[JSON])->[BillFtel]{
        var list:[BillFtel] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> BillFtel{
        var Description = data["Description"].string
        var BillDate = data["BillDate"].string
        var Bill = data["Bill"].string
        
        var RowID = data["RowID"].int
        var Amount = data["Amount"].int
        
        Description = Description == nil ? "" : Description
        BillDate = BillDate == nil ? "" : BillDate
        Bill = Bill == nil ? "" : Bill
        RowID = RowID == nil ? 0 : RowID
        Amount = Amount == nil ? 0 : Amount
        return BillFtel(Description: Description!, BillDate: BillDate!, RowID: RowID!, Amount: Amount!, Bill: Bill!)
        
    }
}
