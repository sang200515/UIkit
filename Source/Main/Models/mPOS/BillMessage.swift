//
//  BillMessage.swift
//  mPOS
//
//  Created by MinhDH on 3/29/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class BillMessage: NSObject {
    
    var message: BillParam
    
    init(message: BillParam) {
        self.message = message
    }
}
extension BillMessage {
    func toJSON() -> Dictionary<String, Any> {
        return [
            "message": self.message.toJSON(),
        ]
    }
}
