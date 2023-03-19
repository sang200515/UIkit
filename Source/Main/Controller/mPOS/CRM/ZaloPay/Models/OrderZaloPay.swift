//
//  OrderZaloPay.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 28/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
enum OrderStatus: Int, Decodable {
    case NON_SUPPORT
    case CREATE
    case SUCCESS
    case FAILED
    case CANCELLED
    case PUSHED_TO_POS
    case REQUEST_CANCEL
    case PROCESSING
    case CANCEL_FAILED
    case CANCEL_PROCESSING
    case PARTIAL_CANCEL
    case NEED_ADDITIONAL_INFORMATION
    
    var name: String {
        get {
            switch self {
            case .NON_SUPPORT:
                return "Không hỗ trợ"
            case .CREATE:
                return "Đã tạo giao dịch (thu tiền khách hàng)"
            case .SUCCESS:
                return "Giao dịch thành công"
            case .FAILED:
                return "Giao dịch thất bại"
            case .CANCELLED:
                return "Đã hủy"
            case .PUSHED_TO_POS:
                return "Đã đẩy sang POS"
            case .REQUEST_CANCEL:
                return "Yêu cầu hủy"
            case .PROCESSING:
                return "Đang thực hiện (thu tiền khách hàng)"
            case .CANCEL_FAILED:
                return "Hủy thất bại (Giao dịch thành công)"
            case .CANCEL_PROCESSING:
                return "Đang thực hiện hủy"
            case .PARTIAL_CANCEL:
                return "Đã hủy 1 phần"
            case .NEED_ADDITIONAL_INFORMATION:
                return "Cần bổ sung thông tin"
            }
        }
    }
    var color: UIColor {
        get {
            switch self {
            case .SUCCESS:
                return UIColor.blue
            case .FAILED:
                return UIColor.red
            default:
                return UIColor.black
            }
        }
    }
}

struct OrderZaloPay:Decodable
{
    var orderId: String
    var billNo: String
    var crmBillNo: String?
    var totalAmountIncludingFee: Double
    var customerPhoneNumber: String
    var orderStatus: OrderStatus
    var productCustomerCode: String
    var productId: String
    var productName: String
    var warehouseName: String
    var warehouseCode: String
    var quantity: Int
    var parentCategoryId: String
    var parentCategoryName:  String
    var creationTime:  String
    var employeeName:  String
    var categoryId: String
    var categoryName:  String
    var payoutNo:  String?
    var transactionCode:  String?
    var paymentMethods: String
    var posso: String?
    var providerTransactionIds: String
    var noPartnerContract: Int
    var haveSO: Int
    var partnerReturnTransactionId: String?
    var region: String
}
