//
//  TimKiemDonHangHangMireaEntity.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import Foundation

struct TimKiemDonHangHangMireaEntity:Decodable {
    class TimKiemDonHangModel: Codable {
        let success: Bool?
        let message: String?
        let data: [DataTimKiemDonHangModel]?

        init(success: Bool?, message: String?, data: [DataTimKiemDonHangModel]?) {
            self.success = success
            self.message = message
            self.data = data
        }
    }

    // MARK: - Datum
    class DataTimKiemDonHangModel: Codable {
        let soPos, ecomNum: Int?
        let sdt, cardName, createDate: String?
        let docTotal, soTienCoc: Int?

        init(soPos: Int?, ecomNum: Int?, sdt: String?, cardName: String?, createDate: String?, docTotal: Int?, soTienCoc: Int?) {
            self.soPos = soPos
            self.ecomNum = ecomNum
            self.sdt = sdt
            self.cardName = cardName
            self.createDate = createDate
            self.docTotal = docTotal
            self.soTienCoc = soTienCoc
        }
    }
 
    class ChiTietDonHangCocModel: Codable {
        let success: Bool?
        let message: String?
        let data: DataChiTietDonHangCocModel?

        init(success: Bool?, message: String?, data: DataChiTietDonHangCocModel?) {
            self.success = success
            self.message = message
            self.data = data
        }
    }

    // MARK: - DataClass
    class DataChiTietDonHangCocModel: Codable {
        let header: Header?
        let details: Details?

        init(header: Header?, details: Details?) {
            self.header = header
            self.details = details
        }
    }

    // MARK: - Details
    class Details: Codable {
        let itemCode, itemName: String?
        let price: Int?
        let bonusScopeBoom: String?
        let linkAnh: String?
        let id, brandID, productTypeID, priceMarket: Int?
        let priceBeforeTax: Int?
        let iconURL: String?
        let manSerNum: String?
        let inventory: Int?
        let includeInfo, labelName, hightlightsDES, qlSerial: String?
        let lableProduct: String?

        enum CodingKeys: String, CodingKey {
            case itemCode, itemName, price, bonusScopeBoom, linkAnh, id, brandID, productTypeID, priceMarket, priceBeforeTax
            case iconURL = "iconUrl"
            case manSerNum, inventory, includeInfo, labelName
            case hightlightsDES = "hightlightsDes"
            case qlSerial, lableProduct
        }

        init(itemCode: String?, itemName: String?, price: Int?, bonusScopeBoom: String?, linkAnh: String?, id: Int?, brandID: Int?, productTypeID: Int?, priceMarket: Int?, priceBeforeTax: Int?, iconURL: String?, manSerNum: String?, inventory: Int?, includeInfo: String?, labelName: String?, hightlightsDES: String?, qlSerial: String?, lableProduct: String?) {
            self.itemCode = itemCode
            self.itemName = itemName
            self.price = price
            self.bonusScopeBoom = bonusScopeBoom
            self.linkAnh = linkAnh
            self.id = id
            self.brandID = brandID
            self.productTypeID = productTypeID
            self.priceMarket = priceMarket
            self.priceBeforeTax = priceBeforeTax
            self.iconURL = iconURL
            self.manSerNum = manSerNum
            self.inventory = inventory
            self.includeInfo = includeInfo
            self.labelName = labelName
            self.hightlightsDES = hightlightsDES
            self.qlSerial = qlSerial
            self.lableProduct = lableProduct
        }
    }

    // MARK: - Header
    class Header: Codable {
        let soPos,soMpos, ecomNum: Int?
        let sdt, cardName, createDate: String?
        let docTotal, soTienCoc: Int?

        init(soPos: Int?, ecomNum: Int?, sdt: String?, cardName: String?, createDate: String?, docTotal: Int?, soTienCoc: Int?,soMpos:Int?) {
            self.soPos = soPos
            self.ecomNum = ecomNum
            self.sdt = sdt
            self.cardName = cardName
            self.createDate = createDate
            self.docTotal = docTotal
            self.soTienCoc = soTienCoc
            self.soMpos = soMpos
        }
    }

}
