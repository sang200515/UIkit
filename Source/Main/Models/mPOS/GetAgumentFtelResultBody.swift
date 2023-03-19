//
//  GetAgumentFtelResultBody.swift
//  mPOS
//
//  Created by sumi on 12/4/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetAgumentFtelResultBody: NSObject {
    
    var RowID: String
    var Bill: String
    var Amount: String
    var BillDate: String
    var Description: String

    
    init(RowID: String, Bill: String, Amount: String, BillDate: String, Description: String){
        self.RowID =  RowID
        self.Bill = Bill
        self.Amount = Amount
        self.BillDate = BillDate
        self.Description = Description
    }
    class func parseObjfromArray(array:[JSON])->[GetAgumentFtelResultBody]{
        var list:[GetAgumentFtelResultBody] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> GetAgumentFtelResultBody{
        var RowID = data["RowID"].string
        var Bill = data["Bill"].string
        var Amount = data["Amount"].string
        var BillDate = data["BillDate"].string
        var Description = data["Description"].string
        
        RowID = RowID == nil ? "" : RowID
        Bill = Bill == nil ? "" :Bill
        Amount = Amount == nil ? "" : Amount
        BillDate = BillDate == nil ? "" : BillDate
        Description = Description == nil ? "" : Description
        
        return GetAgumentFtelResultBody(RowID: RowID!, Bill: Bill!, Amount: Amount!, BillDate: BillDate!, Description: Description!)
    }
}

