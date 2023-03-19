//
//  ThuHoSOMDataManager.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 28/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

class ThuHoSOMDataManager {
    static let shared = ThuHoSOMDataManager()
    
    //MARK:- DATA
    var catagories: ThuHoSOMCatagories = ThuHoSOMCatagories(JSON: [:])!
    var providers: ThuHoSOMProviders = ThuHoSOMProviders(JSON: [:])!
    var selectedCatagory: ThuHoSOMItem = ThuHoSOMItem(JSON: [:])!
    var selectedProduct: ThuHoSOMProduct = ThuHoSOMProduct(JSON: [:])!
    var selectedCustomer: ThuHoSOMCustomer = ThuHoSOMCustomer(JSON: [:])!
    var orderDetail: ThuHoSOMOrderDetail = ThuHoSOMOrderDetail(JSON: [:])!
    var order: ThuHoSOMOrder = ThuHoSOMOrder(JSON: [:])!
    var status: ThuHoSOMOrderStatus = ThuHoSOMOrderStatus(JSON: [:])!
    
    //MARK:- PAYMENT
    var cards: [ThuHoSOMCardItem] = []
    var banks: [ThuHoSOMBankItem] = []
    var paymentTypes: [ThuHoSOMPaymentTypeItem] = []
    
    //MARK:- PARAM
    var orderParam: ThuHoSOMOrderParam = ThuHoSOMOrderParam(JSON: [:])!
    
    func resetProduct() {
        catagories = ThuHoSOMCatagories(JSON: [:])!
        providers = ThuHoSOMProviders(JSON: [:])!
        selectedCatagory = ThuHoSOMItem(JSON: [:])!
        selectedProduct = ThuHoSOMProduct(JSON: [:])!
    }
    
    func resetParam() {
        selectedCustomer = ThuHoSOMCustomer(JSON: [:])!
        orderDetail = ThuHoSOMOrderDetail(JSON: [:])!
        order = ThuHoSOMOrder(JSON: [:])!
        status = ThuHoSOMOrderStatus(JSON: [:])!
        
        cards = []
        banks = []
        paymentTypes = []
        
        orderParam = ThuHoSOMOrderParam(JSON: [:])!
    }
}

enum ThuHoSOMOrderStatusEnum: Int {
    case NON_SUPPORT = 0
    case CREATE = 1
    case SUCCESS = 2
    case FAILED = 3
    case CANCELLED = 4
    case PUSHED_TO_POS = 5
    case REQUEST_CANCEL = 6
    case PROCESSING = 7
    case CANCEL_FAILED = 8
    case CANCEL_PROCESSING = 9
    case PARTIAL_CANCEL = 10
    case NEED_ADDITIONAL_INFORMATION = 11
    
    var description: String {
        switch self {
        case .NON_SUPPORT:
            return "Không hỗ trợ"
        case .CREATE:
            return "Đã tạo giao dịch"
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
            return "Đang thực hiện"
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
    
    var group: String {
        switch self {
        case .NON_SUPPORT,
             .PUSHED_TO_POS,
             .NEED_ADDITIONAL_INFORMATION:
            return "N/A"
        case .CREATE,
             .REQUEST_CANCEL,
             .PROCESSING,
             .CANCEL_PROCESSING:
            return "Cần xử lý"
        case .SUCCESS,
             .FAILED,
             .CANCELLED,
             .CANCEL_FAILED,
             .PARTIAL_CANCEL:
            return "Trạng thái cuối"
        }
    }
    
    var color: UIColor {
        switch self {
        case .SUCCESS:
            return UIColor(netHex: 0x4fa845)
        case .FAILED:
            return .red
        default:
            return .blue
        }
    }
}

enum ThuHoSOMPaymentTypeEnum: Int {
    case CASH = 1
    case CARD = 2
    case TRANSFER = 3
    case VOUCHER = 4
    
    var description: String {
        switch self {
        case .CASH:
            return "Tiền mặt"
        case .CARD:
            return "Thẻ"
        case .TRANSFER:
            return "Chuyển khoản"
        case .VOUCHER:
            return "Voucher"
        }
    }
}
