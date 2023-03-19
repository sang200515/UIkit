//
//  CardTypeFromPOSResult.swift
//  mPOS
//
//  Created by sumi on 7/12/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import SwiftyJSON

class CardTypeFromPOSResult: NSObject {
    
    var FixedAmountFee : Int
    var Is_Credit: String
    var PercentFee : Double
    var Text: String
    var Value: Int

    init(FixedAmountFee : Int, Is_Credit: String, PercentFee : Double, Text: String, Value: Int){
        self.FixedAmountFee = FixedAmountFee
        self.Is_Credit = Is_Credit
        self.PercentFee = PercentFee
        self.Text = Text
        self.Value = Value
    }
    
    class func parseObjfromArray(array:[JSON])->[CardTypeFromPOSResult]{
        var list:[CardTypeFromPOSResult] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> CardTypeFromPOSResult{
        var FixedAmountFee = data["FixedAmountFee"].int
        var Is_Credit = data["Is_Credit"].string
        var PercentFee = data["PercentFee"].double
        var Text = data["Text"].string
        var Value = data["Value"].int
        FixedAmountFee = FixedAmountFee == nil ? 0: FixedAmountFee
        Is_Credit = Is_Credit == nil ? "" : Is_Credit
        PercentFee = PercentFee == nil ? 0 : PercentFee
        Text = Text == nil ? "" : Text
        Value = Value == nil ? 0 : Value
        return CardTypeFromPOSResult(FixedAmountFee: FixedAmountFee!, Is_Credit: Is_Credit!,PercentFee:PercentFee!,Text:Text!,Value:Value!)
    }
}
