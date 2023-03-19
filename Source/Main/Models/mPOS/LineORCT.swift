//
//  LineORCT.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/6/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class LineORCT: NSObject {
    
    var U_MoCCad: Float
    var U_MoCash: Float
    var U_MoQRCode: Float
    var U_MoVoCh: Float
    var LoanAmount: Float
    var electronic_wallet: String

    init(U_MoCCad: Float, U_MoCash: Float, U_MoQRCode: Float, U_MoVoCh: Float, LoanAmount: Float, electronic_wallet: String) {
        self.U_MoCCad = U_MoCCad
        self.U_MoCash = U_MoCash
        self.U_MoQRCode = U_MoQRCode
        self.U_MoVoCh = U_MoVoCh
        self.LoanAmount = LoanAmount
        self.electronic_wallet = electronic_wallet
    }
    class func parseObjfromArray(array:[JSON])->[LineORCT]{
        var list:[LineORCT] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    class func getObjFromDictionary(data:JSON) -> LineORCT{
        
        var U_MoCCad = data["U_MoCCad"].float
        var U_MoCash = data["U_MoCash"].float
        var U_MoQRCode = data["U_MoQRCode"].float
        var U_MoVoCh = data["U_MoVoCh"].float
        var LoanAmount = data["LoanAmount"].float
        var electronic_wallet = data["electronic_wallet"].string
        
        U_MoCCad = U_MoCCad == nil ? 0 : U_MoCCad
        U_MoCash = U_MoCash == nil ? 0 : U_MoCash
        U_MoQRCode = U_MoQRCode == nil ? 0 : U_MoQRCode
        U_MoVoCh = U_MoVoCh == nil ? 0 : U_MoVoCh
        LoanAmount = LoanAmount == nil ? 0 : LoanAmount
        electronic_wallet = electronic_wallet == nil ? "" : electronic_wallet
        
        return LineORCT(U_MoCCad: U_MoCCad!, U_MoCash: U_MoCash!, U_MoQRCode: U_MoQRCode!, U_MoVoCh: U_MoVoCh!, LoanAmount: LoanAmount!, electronic_wallet: electronic_wallet!)
    }
}


