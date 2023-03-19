//
//  GroupImeiBook.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class GroupImeiBook: NSObject{
    var ItemCode:String
    var IsExpand:Bool
    var listImeiBook:[ImeiBook]

    init(ItemCode:String,listImeiBook:[ImeiBook],IsExpand:Bool){
        self.ItemCode = ItemCode
        self.listImeiBook = listImeiBook
        self.IsExpand = IsExpand
    }
}
