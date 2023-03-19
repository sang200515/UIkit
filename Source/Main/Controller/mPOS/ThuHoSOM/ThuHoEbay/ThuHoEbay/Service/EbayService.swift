    //
    //  EbayService.swift
    //  fptshop
    //
    //  Created by Sang Trương on 08/08/2022.
    //  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
    //
import Foundation
import SwiftyJSON
import Alamofire

protocol EbayProtocol {
    func getListFinancial(
        success: @escaping SuccessHandler<EbayListFinicial>.object, failure: @escaping RequestFailure)
    func getFeeEbay(
        financialCode: String, contractNo: String, customerIdNo: String, address: String,
        success: @escaping SuccessHandler<EbayFeeModel>.object, failure: @escaping RequestFailure)
    func uploadImageEbay(
        ma_hop_dong: String, type: Int, base64: String,
        success: @escaping SuccessHandler<UpLoadImageEbayModel>.object, failure: @escaping RequestFailure)
    func genBienLaiEbay(
        ten_shop: String, dia_chi_shop: String, ngay_tao: String, ma_giao_dich: String, khach_hang: String,
        ma_hop_dong: String, so_tien_nhan: Double, so_dien_thoai: String, ma_thu_ngan: String,
        ten_thu_ngan: String, chu_ky_dien_tu: String,don_vi_tai_chinh:String,
        success: @escaping SuccessHandler<UpLoadImageEbayModel>.object, failure: @escaping RequestFailure)

    func saveOrder(
        orderStatus: Int,
        orderStatusDisplay: String,
        billNo: String,
        customerId: String,
        customerName: String,
        customerPhoneNumber: String,
        warehouseCode: String,
        regionCode: String,
        creationBy: String,
        creationTime: String,
        referenceSystem: String,
        referenceValue: String,
        orderTransactionDtos: [[String: Any]],
        payments: [[String: Any]],
        id: String,
        ip: String,
        success: @escaping SuccessHandler<EbaySaveOrderModel>.object, failure: @escaping RequestFailure)
    func updateBienLai(
        orderId: String, url: String, success: @escaping SuccessHandler<UpdateBienLaiEbayModel>.object,
        failure: @escaping RequestFailure)

    func checkGiaoDich(
        ProviderId: String, OrderId: String, ProductId: String,
        success: @escaping SuccessHandler<TransactionCheckEbayModel>.object, failure: @escaping RequestFailure)

    func checkGiaoDichNew(
        OrderId: String, success: @escaping SuccessHandler<TransactionCheckEbayNewModel>.object,
        failure: @escaping RequestFailure)
    func uploadImageEbayNoLoading(
        ma_hop_dong: String, type: Int, base64: String,
        success: @escaping SuccessHandler<UpLoadImageEbayModel>.object, failure: @escaping RequestFailure
    )
	func searchContractSeason1(
		providerId: String, customerId: String, integratedGroupCode: String,integratedProductCode: String, pin: String,
		success: @escaping SuccessHandler<SearchContractSeasonModel1>.object, failure: @escaping RequestFailure
	)
	func searchContractSeason2(
		providerId: String, customerId: String, integratedGroupCode: String,integratedProductCode: String, pin: String,
		success: @escaping SuccessHandler<ThuHoSOMCustomer>.object, failure: @escaping RequestFailure
	)
}

class EbayAPIService: EbayProtocol {

    private let network: APINetworkProtocol

    init(
        network: APINetworkProtocol
    ) {
        self.network = network
    }

    func getListFinancial(
        success: @escaping SuccessHandler<EbayListFinicial>.object, failure: @escaping RequestFailure
    ) {
        let endPoint = EbayEndpoint.getListFinacial
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func getFeeEbay(
        financialCode: String, contractNo: String, customerIdNo: String, address: String,
        success: @escaping SuccessHandler<EbayFeeModel>.object, failure: @escaping RequestFailure
    ) {
        let endPoint = EbayEndpoint.getFeeEbay(
            financialCode: financialCode, contractNo: contractNo, customerIdNo: customerIdNo,
            address: address)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func uploadImageEbay(
        ma_hop_dong: String, type: Int, base64: String,
        success: @escaping SuccessHandler<UpLoadImageEbayModel>.object, failure: @escaping RequestFailure
    ) {
        let endPoint = EbayEndpoint.uploadImageEbay(ma_hop_dong: ma_hop_dong, type: type, base64: base64)
        network.requestData(
            endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func uploadImageEbayNoLoading(
        ma_hop_dong: String, type: Int, base64: String,
        success: @escaping SuccessHandler<UpLoadImageEbayModel>.object, failure: @escaping RequestFailure
    ) {
        let endPoint = EbayEndpoint.uploadImageEbay(ma_hop_dong: ma_hop_dong, type: type, base64: base64)
        network.requestData(
            endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func genBienLaiEbay(
        ten_shop: String, dia_chi_shop: String, ngay_tao: String, ma_giao_dich: String, khach_hang: String,
        ma_hop_dong: String, so_tien_nhan: Double, so_dien_thoai: String, ma_thu_ngan: String,
        ten_thu_ngan: String, chu_ky_dien_tu: String,don_vi_tai_chinh:String,
        success: @escaping SuccessHandler<UpLoadImageEbayModel>.object, failure: @escaping RequestFailure
    ) {
        let endPoint = EbayEndpoint.genBienLaiEbay(
            ten_shop: ten_shop, dia_chi_shop: dia_chi_shop, ngay_tao: ngay_tao, ma_giao_dich: ma_giao_dich,
            khach_hang: khach_hang, ma_hop_dong: ma_hop_dong, so_tien_nhan: so_tien_nhan,
            so_dien_thoai: so_dien_thoai, ma_thu_ngan: ma_thu_ngan, ten_thu_ngan: ten_thu_ngan,
            chu_ky_dien_tu: chu_ky_dien_tu,don_vi_tai_chinh:don_vi_tai_chinh)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }

    func saveOrder(
        orderStatus: Int, orderStatusDisplay: String, billNo: String, customerId: String, customerName: String,
        customerPhoneNumber: String, warehouseCode: String, regionCode: String, creationBy: String,
        creationTime: String, referenceSystem: String, referenceValue: String,
        orderTransactionDtos: [[String: Any]], payments: [[String: Any]], id: String, ip: String,
        success: @escaping SuccessHandler<EbaySaveOrderModel>.object, failure: @escaping RequestFailure
    ) {
        let endPoint = EbayEndpoint.saveOrderEbay(
            orderStatus: orderStatus, orderStatusDisplay: orderStatusDisplay, billNo: billNo,
            customerId: customerId, customerName: customerName, customerPhoneNumber: customerPhoneNumber,
            warehouseCode: warehouseCode, regionCode: regionCode, creationBy: creationBy,
            creationTime: creationTime, referenceSystem: referenceSystem, referenceValue: referenceValue,
            orderTransactionDtos: orderTransactionDtos, payments: payments, id: id, ip: ip)
        network.requestDataNoLoading(
            endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func checkGiaoDich(
        ProviderId: String, OrderId: String, ProductId: String,
        success: @escaping SuccessHandler<TransactionCheckEbayModel>.object, failure: @escaping RequestFailure
    ) {
        let endPoint = EbayEndpoint.checkTransaction(
            ProviderId: ProviderId, OrderId: OrderId, ProductId: ProductId)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }

    func updateBienLai(
        orderId: String, url: String, success: @escaping SuccessHandler<UpdateBienLaiEbayModel>.object,
        failure: @escaping RequestFailure
    ) {
        let endPoint = EbayEndpoint.updateBienLai(orderId: orderId, url: url)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }

    func checkGiaoDichNew(
        OrderId: String, success: @escaping SuccessHandler<TransactionCheckEbayNewModel>.object,
        failure: @escaping RequestFailure
    ) {
        let endPoint = EbayEndpoint.checkTransactionNew(OrderId: OrderId)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
	func searchContractSeason1(
		providerId: String, customerId: String, integratedGroupCode: String,integratedProductCode: String, pin: String,
		success: @escaping SuccessHandler<SearchContractSeasonModel1>.object, failure: @escaping RequestFailure){
			let endPoint = EbayEndpoint.searchContractSeason1(providerId: providerId, customerId: customerId, integratedGroupCode: integratedGroupCode, integratedProductCode: integratedProductCode, pin: pin)
			network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
		}
	func searchContractSeason2(
		providerId: String, customerId: String, integratedGroupCode: String,integratedProductCode: String, pin: String,
		success: @escaping SuccessHandler<ThuHoSOMCustomer>.object, failure: @escaping RequestFailure){
			let endPoint =  EbayEndpoint.searchContractSeason2(providerId: providerId, customerId: customerId, integratedGroupCode: integratedGroupCode, integratedProductCode: integratedProductCode, pin: pin)
			network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
		}
}
