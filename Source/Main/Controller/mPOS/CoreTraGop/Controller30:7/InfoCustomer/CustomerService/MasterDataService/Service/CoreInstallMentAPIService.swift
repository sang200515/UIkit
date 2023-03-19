    //
    //  CoreInstallMentAPIService.swift
    //  QuickCode
    //
    //  Created by Sang Trương on 16/07/2022.
    //

import Foundation
protocol CoreInstallMentProtocol {
    func getListTinhThanh(success: @escaping SuccessHandler<ListTinhThanhCore>.array, failure: @escaping RequestFailure)
    func getListQuanhuyen(proVinceCode:String,success: @escaping SuccessHandler<ListQuanHuyenCore>.array, failure: @escaping RequestFailure)
    func getListPhuongXa(districtCode:String,success: @escaping SuccessHandler<ListPhuongXaCore>.array, failure: @escaping RequestFailure)
    func getListMoiQuanHe(success: @escaping SuccessHandler<ListMoiQuanHe>.array, failure: @escaping RequestFailure)
    func getListNhaTraGhop(idCard:String,success: @escaping SuccessHandler<ListInstallment>.object, failure: @escaping RequestFailure)
    func getMasterDataInstallMent(idCard: String,success: @escaping SuccessHandler<MasterDataInstallMent>.object, failure: @escaping RequestFailure)
    func getTypeOfIdCard(success: @escaping SuccessHandler<TypeIDCardModel>.array, failure: @escaping RequestFailure)
}

class CoreInstallMentAPIService: CoreInstallMentProtocol {
    
    
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getListTinhThanh(success: @escaping SuccessHandler<ListTinhThanhCore>.array, failure: @escaping RequestFailure) {
        let endPoint = CoreInstallMentEndPoint.getListTinhThanh
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getListQuanhuyen(proVinceCode:String,success: @escaping SuccessHandler<ListQuanHuyenCore>.array, failure: @escaping RequestFailure) {
        let endPoint = CoreInstallMentEndPoint.getListQuanhuyen(provinceCode: proVinceCode)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getListPhuongXa(districtCode: String,success: @escaping SuccessHandler<ListPhuongXaCore>.array, failure: @escaping RequestFailure) {
        let endPoint = CoreInstallMentEndPoint.getListPhuongXa(districtCode: districtCode)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getListMoiQuanHe(success: @escaping SuccessHandler<ListMoiQuanHe>.array, failure: @escaping RequestFailure) {
        let endPoint = CoreInstallMentEndPoint.getListMoiQuanHe
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getListNhaTraGhop(idCard:String,success: @escaping SuccessHandler<ListInstallment>.object, failure: @escaping RequestFailure) {
        let endPoint = CoreInstallMentEndPoint.getListNhaTraGhop(idCard: idCard)
        network.requestDataNoLoading(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getMasterDataInstallMent(idCard:String,success: @escaping SuccessHandler<MasterDataInstallMent>.object, failure: @escaping RequestFailure) {
        let endPoint = CoreInstallMentEndPoint.getMasterDataInstallMapping(idCard: idCard)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func getTypeOfIdCard(success: @escaping SuccessHandler<TypeIDCardModel>.array, failure: @escaping RequestFailure) {
        let endPoint = CoreInstallMentEndPoint.getTypeOfIdCard
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
}
