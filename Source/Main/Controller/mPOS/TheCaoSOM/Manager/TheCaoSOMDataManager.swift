//
//  TheCaoSOMDataManager.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

class TheCaoSOMDataManager {
    static let shared = TheCaoSOMDataManager()
    
    //MARK:- DATA
    var providers: ThuHoSOMProviders = ThuHoSOMProviders(JSON: [:])!
    var selectedItem: TheNapSOMItem = TheNapSOMItem(JSON:[:])!
    var selectedProduct: (quantity: Int, product: TheNapSOMProduct) = (0, TheNapSOMProduct(JSON:[:])!)
    var orderDetail: TheNapSOMOrderDetail = TheNapSOMOrderDetail(JSON: [:])!
    var order: ThuHoSOMOrder = ThuHoSOMOrder(JSON: [:])!
    var status: ThuHoSOMOrderStatus = ThuHoSOMOrderStatus(JSON: [:])!
    
    //MARK:- PAYMENT
    var cards: [ThuHoSOMCardItem] = []
    var paymentTypes: [ThuHoSOMPaymentTypeItem] = []
    
    func resetParam() {
        selectedItem = TheNapSOMItem(JSON: [:])!
        selectedProduct = (0, TheNapSOMProduct(JSON:[:])!)
        orderDetail = TheNapSOMOrderDetail(JSON: [:])!
        order = ThuHoSOMOrder(JSON: [:])!
        status = ThuHoSOMOrderStatus(JSON: [:])!
        
        cards = []
        paymentTypes = []
    }
}
