//
//  WarrantyItem.swift
//  mPOS
//
//  Created by MinhDH on 5/11/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class WarrantyItem: NSObject {
    
    var CreateDate: String
    var DocEntry: Int
    var DocEntrySO: Int
    var Imei: String
    var ItemCodeBH: String
    var ItemCodeP: String
    var ItemNameBH: String
    var ItemNameP: String
    var LineNumMap: String
    var NgayBH: String
    var NgayHetHanBH: String
    var NguoiTao: String
    var Quantity: Int
    var QuantityBH: Int
    var SoDT_SO: String
    var Status: String
    var TypeWarranty: String
    
    init(CreateDate: String, DocEntry: Int, DocEntrySO: Int, Imei: String, ItemCodeBH: String, ItemCodeP: String, ItemNameBH: String, ItemNameP: String, LineNumMap: String, NgayBH: String, NgayHetHanBH: String, NguoiTao: String, Quantity: Int, QuantityBH: Int, SoDT_SO: String, Status: String, TypeWarranty: String){
        self.CreateDate = CreateDate
        self.DocEntry = DocEntry
        self.DocEntrySO = DocEntrySO
        self.Imei = Imei
        self.ItemCodeBH = ItemCodeBH
        self.ItemCodeP = ItemCodeP
        self.ItemNameBH = ItemNameBH
        self.ItemNameP = ItemNameP
        self.LineNumMap = LineNumMap
        self.NgayBH = NgayBH
        self.NgayHetHanBH = NgayHetHanBH
        self.NguoiTao = NguoiTao
        self.Quantity = Quantity
        self.QuantityBH = QuantityBH
        self.SoDT_SO = SoDT_SO
        self.Status = Status
        self.TypeWarranty = TypeWarranty
    }

    
    
    
    class func parseObjfromArray(array:[JSON])->[WarrantyItem]{
        var list:[WarrantyItem] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    
    class func getObjFromDictionary(data:JSON) -> WarrantyItem{
        
        var createDate = data["CreateDate"].string
        var docEntry = data["DocEntry"].int
        var docEntrySO = data["DocEntrySO"].int
        var imei = data["Imei"].string
        
        createDate = createDate == nil ? "" : createDate
        docEntry = docEntry == nil ? 0 : docEntry
        docEntrySO = docEntrySO == nil ? 0 : docEntrySO
        imei = imei == nil ? "" : imei
        
        var itemCodeBH = data["ItemCodeBH"].string
        var itemCodeP = data["ItemCodeP"].string
        var itemNameBH = data["ItemNameBH"].string
        var itemNameP = data["ItemNameP"].string
        
        itemCodeBH = itemCodeBH == nil ? "" : itemCodeBH
        itemCodeP = itemCodeP == nil ? "" : itemCodeP
        itemNameBH = itemNameBH == nil ? "" : itemNameBH
        itemNameP = itemNameP == nil ? "" : itemNameP
        
        var lineNumMap = data["LineNumMap"].string
        var ngayBH = data["NgayBH"].string
        var ngayHetHanBH = data["NgayHetHanBH"].string
        var nguoiTao = data["NguoiTao"].string
        
        lineNumMap = lineNumMap == nil ? "" : lineNumMap
        ngayBH = ngayBH == nil ? "" : ngayBH
        ngayHetHanBH = ngayHetHanBH == nil ? "" : ngayHetHanBH
        nguoiTao = nguoiTao == nil ? "" : nguoiTao
        
        
        var quantity = data["Quantity"].int
        var quantityBH = data["QuantityBH"].int
        var soDT_SO = data["SoDT_SO"].string
        var status = data["Status"].string
        var typeWarranty = data["Type"].string
        
        quantity = quantity == nil ? 0 : quantity
        quantityBH = quantityBH == nil ? 0 : quantityBH
        soDT_SO = soDT_SO == nil ? "" : soDT_SO
        status = status == nil ? "" : status
        typeWarranty = typeWarranty == nil ? "" : typeWarranty
        
        return WarrantyItem(CreateDate: createDate!, DocEntry: docEntry!, DocEntrySO: docEntrySO!, Imei: imei!, ItemCodeBH: itemCodeBH!, ItemCodeP: itemCodeP!, ItemNameBH: itemNameBH!, ItemNameP: itemNameP!, LineNumMap: lineNumMap!, NgayBH: ngayBH!, NgayHetHanBH: ngayHetHanBH!, NguoiTao: nguoiTao!, Quantity: quantity!, QuantityBH: quantityBH!, SoDT_SO: soDT_SO!, Status: status!, TypeWarranty: typeWarranty!)
    }
    
}

class WarrantyImgItem: NSObject {
    var ItemCode: String
    var ItemName: String
    var LinkAnh: String
    
    init(ItemCode: String, ItemName: String, LinkAnh: String){
        self.ItemCode = ItemCode
        self.ItemName = ItemName
        self.LinkAnh = LinkAnh
        
    }
    
    class func parseObjfromArray(array:[JSON])->[WarrantyImgItem]{
        var list:[WarrantyImgItem] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    
    
    class func getObjFromDictionary(data:JSON) -> WarrantyImgItem{
        
        var ItemCode = data["ItemCode"].string
        var ItemName = data["ItemName"].string
        var LinkAnh = data["LinkAnh"].string
        
        
        ItemCode = ItemCode == nil ? "" : ItemCode
        ItemName = ItemName == nil ? "" : ItemName
        LinkAnh = LinkAnh == nil ? "" : LinkAnh
        
        
        return WarrantyImgItem(ItemCode: ItemCode!, ItemName: ItemName!, LinkAnh: LinkAnh!)
    }
}
