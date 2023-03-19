//
//  Cart.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class Cart: NSObject {
    let sku: String
    let product: Product
    var quantity: Int
    let color: String
    var inStock: Int = -1
    var imei: String
    var price: Float
    var priceBT: Float
    var whsCode: String
    var discount: Int
    var reason: String
    var note: String
    var userapprove: String
    var listURLImg: [String]
    var Warr_imei:String
    var replacementAccessoriesLabel: String
    init(sku: String,product: Product,quantity: Int,color: String,inStock: Int,imei: String,price: Float,priceBT: Float,whsCode: String,discount: Int,reason: String,note: String,userapprove: String, listURLImg: [String],Warr_imei:String, replacementAccessoriesLabel: String){
        self.sku = sku
        self.product = product
        self.quantity = quantity
        self.color = color
        self.inStock = inStock
        self.imei = imei
        self.price = price
        self.priceBT = priceBT
        self.whsCode = whsCode
        self.discount = discount
        self.reason = reason
        self.note = note
        self.userapprove = userapprove
        self.listURLImg = listURLImg
        self.Warr_imei = Warr_imei
        self.replacementAccessoriesLabel = replacementAccessoriesLabel
    }
}

