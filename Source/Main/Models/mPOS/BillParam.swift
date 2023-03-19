//
//  BillParam.swift
//  mPOS
//
//  Created by MinhDH on 3/29/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
class BillParam: NSObject {
    
    var title: String
    var body: String
    var id: String
    var key: String
    
    init(title: String, body: String,id: String,key: String) {
        self.title = title
        self.body = body
        self.id = id
        self.key = key
    }
}
extension BillParam {
    func toJSON() -> Dictionary<String, Any> {
        return [
            "title": self.title,
            "body": self.body,
            "id": self.id,
            "key": self.key,
        ]
    }
}
