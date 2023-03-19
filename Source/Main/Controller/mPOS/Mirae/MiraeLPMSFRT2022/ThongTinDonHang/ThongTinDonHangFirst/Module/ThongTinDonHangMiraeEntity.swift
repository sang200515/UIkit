//
//  ThongTinDonHangMiraeEntity.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import Foundation

class ThongTinDonHangMiraeEntity {
    
    // MARK: - ChiTietDonHangModel
    class ChiTietDonHangModel: Codable {
        let success: Bool?
        let message: String?
        let data: DataChiTietDonHangModel?
   
        init(success: Bool?, message: String?, data: DataChiTietDonHangModel?) {
            self.success = success
            self.message = message
            self.data = data
        }
    }
    
    // MARK: - DataChiTietDonHangModel
    class DataChiTietDonHangModel: Codable {
        let customer: Customer?
        let orders: [Order]?
        let promotions: [Promotion]?
        let payment: Payment?
        let buttons: Buttons?
        
        init(customer: Customer?, orders: [Order]?, promotions: [Promotion]?, payment: Payment?, buttons: Buttons?) {
            self.customer = customer
            self.orders = orders
            self.promotions = promotions
            self.payment = payment
            self.buttons = buttons
        }
    }
    
    // MARK: - Customer
    class Customer: Codable {
        let appDocEntry,soMpos: Int?
        let applicationID, fullName, idCard, phone: String?
        
        enum CodingKeys: String, CodingKey {
            case appDocEntry,soMpos
            case applicationID = "applicationId"
            case fullName, idCard, phone
        }
        
        init(appDocEntry: Int?, applicationID: String?, fullName: String?, idCard: String?, phone: String?,soMpos:Int?) {
            self.appDocEntry = appDocEntry
            self.applicationID = applicationID
            self.fullName = fullName
            self.idCard = idCard
            self.phone = phone
            self.soMpos = soMpos
        }
    }
    
    // MARK: - Order
    class Order: Codable {
        let itemCode, itemName, imei: String?
        let quantity: Int?
        let price : Double?
		let is_Hot : Bool?
        init(itemCode: String?, itemName: String?, imei: String?, price: Double?, quantity: Int?, is_Hot: Bool?) {
            self.itemCode = itemCode
            self.itemName = itemName
            self.imei = imei
            self.price = price
            self.quantity = quantity
			self.is_Hot = is_Hot
        }
    }
    
    // MARK: - Payment
    class Payment: Codable {
        let schemeCode, schemeName: String?
           let interestRate, loanTenor, insuranceFee: Float?
           let insuranceFeeRate: Float?
           let totalPrice, discount, downPayment, loanAmount: Float?
           let finalPrice: Float?
           let deposit:Float?
           let otherDownPayment:Float?
            init(schemeCode: String?, schemeName: String?, interestRate: Float?, loanTenor: Float?, insuranceFee: Float?, insuranceFeeRate: Float?, totalPrice: Float?, discount: Float?, downPayment: Float?, loanAmount: Float?, finalPrice: Float?,deposit:Float?,otherDownPayment:Float?) {
                self.schemeCode = schemeCode
                self.schemeName = schemeName
                self.interestRate = interestRate
                self.loanTenor = loanTenor
                self.insuranceFee = insuranceFee
                self.insuranceFeeRate = insuranceFeeRate
                self.totalPrice = totalPrice
                self.discount = discount
                self.downPayment = downPayment
                self.loanAmount = loanAmount
                self.finalPrice = finalPrice
                self.deposit = deposit
                self.otherDownPayment = otherDownPayment
            }
    }
    
    // MARK: - Promotion
    class Promotion: Codable {
        let itemCode, itemName: String?
        let quantity: Int?
        
        init(itemCode: String?, itemName: String?, quantity: Int?) {
            self.itemCode = itemCode
            self.itemName = itemName
            self.quantity = quantity
        }
    }
    
    class Buttons:Codable {
        let uploadWorkInfoAndImageBtn, cancelBtn, updateCustomerInfoBtn, updateLoanInfoBtn: Bool?
            let updateImageBtn: Bool?

            init(uploadWorkInfoAndImageBtn: Bool?, cancelBtn: Bool?, updateCustomerInfoBtn: Bool?, updateLoanInfoBtn: Bool?, updateImageBtn: Bool?) {
                self.uploadWorkInfoAndImageBtn = uploadWorkInfoAndImageBtn
                self.cancelBtn = cancelBtn
                self.updateCustomerInfoBtn = updateCustomerInfoBtn
                self.updateLoanInfoBtn = updateLoanInfoBtn
                self.updateImageBtn = updateImageBtn
            }
    }
    
    class GoiVayMiraeModel: Codable {
        let success: Bool?
        let message: String?
        let data: [DataGoiVayMiraeModel]?

        init(success: Bool?, message: String?, data: [DataGoiVayMiraeModel]?) {
            self.success = success
            self.message = message
            self.data = data
        }
    }

    // MARK: - Datum
    class DataGoiVayMiraeModel: Codable {
        let schemeCode, schemeName: String?
        let interestRate: Double?
        let schemeDetails: String?
        let insuranceFeeRate: Float?
        let loanTenure: [LoanTenure]?

        init(schemeCode: String?, schemeName: String?, interestRate: Double?, schemeDetails: String?, insuranceFeeRate: Float?, loanTenure: [LoanTenure]?) {
            self.schemeCode = schemeCode
            self.schemeName = schemeName
            self.interestRate = interestRate
            self.schemeDetails = schemeDetails
            self.insuranceFeeRate = insuranceFeeRate
            self.loanTenure = loanTenure
        }
    }

    // MARK: - LoanTenure
    class LoanTenure: Codable {
        let number: Int?
        let text: String?

        init(number: Int?, text: String?) {
            self.number = number
            self.text = text
        }
    }
    
}
