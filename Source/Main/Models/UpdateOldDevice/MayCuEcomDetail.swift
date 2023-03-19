//
//  MayCuEcomDetail.swift
//  fptshop
//
//  Created by DiemMy Le on 11/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftyJSON

class MayCuEcomDetail: NSObject {
    let ID: Int
    let Sku: String
    let Imei: String
    let ItemName: String
    let Accessories: String
    let ShortDescription: String
    let ColorID: String
    let listImage: [MayCuEcomDetail_Image]
    
    init(ID: Int, Sku: String, Imei: String, ItemName: String, Accessories: String, ShortDescription: String, ColorID: String, listImage: [MayCuEcomDetail_Image]) {
        self.ID = ID
        self.Sku = Sku
        self.Imei = Imei
        self.ItemName = ItemName
        self.Accessories = Accessories
        self.ShortDescription = ShortDescription
        self.ColorID = ColorID
        self.listImage = listImage
    }
    
    class func parseObjfromArray(array:[JSON])->[MayCuEcomDetail]{
        var list:[MayCuEcomDetail] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> MayCuEcomDetail {
        var ID = data["ID"].int
        var Sku = data["Sku"].string
        var Imei = data["Imei"].string
        var ItemName = data["ItemName"].string
        var Accessories = data["Accessories"].string
        var ShortDescription = data["ShortDescription"].string
        var ColorID = data["ColorID"].string
        let listImage = data["listImage"].array
        
        ID = ID == nil ? 0 : ID
        Sku = Sku == nil ? "" : Sku
        Imei = Imei == nil ? "" : Imei
        ItemName = ItemName == nil ? "" : ItemName
        Accessories = Accessories == nil ? "" : Accessories
        ShortDescription = ShortDescription == nil ? "" : ShortDescription
        ColorID = ColorID == nil ? "" : ColorID
        let listImageMayCu = MayCuEcomDetail_Image.parseObjfromArray(array: listImage ?? [])
        
        return MayCuEcomDetail(ID: ID!, Sku: Sku!, Imei: Imei!, ItemName: ItemName!, Accessories: Accessories!, ShortDescription: ShortDescription!, ColorID: ColorID!, listImage: listImageMayCu)
    }
}

class MayCuEcomDetail_Image: NSObject {
    let TypeImage: Int
    let NameDescription: String
    let PictureID: String
    var PictureUrl: String
    let DisplayOrder: Int
    
    init(TypeImage: Int, NameDescription: String, PictureID: String, PictureUrl: String, DisplayOrder: Int) {
        self.TypeImage = TypeImage
        self.NameDescription = NameDescription
        self.PictureID = PictureID
        self.PictureUrl = PictureUrl
        self.DisplayOrder = DisplayOrder
    }
    
    class func parseObjfromArray(array:[JSON])->[MayCuEcomDetail_Image]{
        var list:[MayCuEcomDetail_Image] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> MayCuEcomDetail_Image {
        var TypeImage = data["TypeImage"].int
        var NameDescription = data["NameDescription"].string
        var PictureID = data["PictureID"].string
        var PictureUrl = data["PictureUrl"].string
        var DisplayOrder = data["DisplayOrder"].int
        
        TypeImage = TypeImage == nil ? 0 : TypeImage
        NameDescription = NameDescription == nil ? "" : NameDescription
        PictureID = PictureID == nil ? "" : PictureID
        PictureUrl = PictureUrl == nil ? "" : PictureUrl
        DisplayOrder = DisplayOrder == nil ? 0 : DisplayOrder
        
        return MayCuEcomDetail_Image(TypeImage: TypeImage!, NameDescription: NameDescription!, PictureID: PictureID!, PictureUrl: PictureUrl!, DisplayOrder: DisplayOrder!)
    }
}
