//
//  ThongTinDonHangMiraeInteractor.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class ThongTinDonHangMiraeInteractor:ThongTinDonHangMiraePresenterToInteractorProtocol {
    
    weak var presenter: ThongTinDonHangMiraeInteractorToPresenterProtocol?
    
    func loadThongTinKhachHang(userCode: String, shopCode: String, partnerId: String, appDocEntry: String){
        ApiRequestMirae.request(.loadThongTinKH(userCode: userCode, shopCode: shopCode, partnerId: partnerId, appDocEntry: appDocEntry), ORCCMNDMiraeEntity.ORCCMNDMiraeModel.self) { response in
            switch response {
            case .success(let modelData):
                if modelData.success == true {
                    if let model = modelData.data {
                        self.presenter?.loadThongTinKhachHangSuccess(model: model)
                    }
                }else {
                    self.presenter?.outPutFailed(error: modelData.message ?? "")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: error.message)
            }
            self.presenter?.hideLoading()
        }
    }
    
    func loadNgayThanhToan(userCode: String, shopCode: String, partnerId: String) {
        ApiRequestMirae.request(.loadNgayThanhToan(userCode: userCode, shopCode: shopCode, partnerId: partnerId), ThongTinDonHangMiraeEntity.GoiVayMiraeModel.self) { response in
            switch response {
            case .success(let modelData):
                if modelData.success == true {
                    if let model = modelData.data {
                        
                    }
                }else {
                    self.presenter?.outPutFailed(error: modelData.message ?? "")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: error.message)
            }
            self.presenter?.hideLoading()
        }
    }
    
    func loadGoiTraGop(userCode:String,shopCode:String,partnerId:String,RDR1:String) {
        ApiRequestMirae.request(.loadGoiTraGop(userCode: userCode, shopCode: shopCode, partnerId: partnerId, RDR1 : RDR1), ThongTinDonHangMiraeEntity.GoiVayMiraeModel.self) { response in
            switch response {
        case .success(let modelData):
            if modelData.success == true {
                if let model = modelData.data {
                    self.presenter?.loadGoiTraGopSuccess(model: model)
                }
            }else {
                self.presenter?.outPutFailed(error: modelData.message ?? "")
            }
        case .failure(let error):
            self.presenter?.outPutFailed(error: error.message)
        }
        self.presenter?.hideLoading()
        }
    }
    
    func loadThongTinDonHang(userCode: String, shopCode: String, partnerId: String, appDocEntry: String) {
        ApiRequestMirae.request(ApiRouterMirae.loadChiTietDonHangMirae(userCode: userCode, shopCode: shopCode, partnerId: partnerId, appDocEntry: appDocEntry), ThongTinDonHangMiraeEntity.ChiTietDonHangModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    if let model = data.data {
                        self.presenter?.loadThongTinDonHangSuccess(model: model)
                    }
                }else {
                    self.presenter?.loadThongTinDonHangFailed(message: "Lấy thông tin đơn hàng trả góp Mirae không thành công. \(data.message ?? "")")
                }
            case .failure(let error):
                self.presenter?.loadThongTinDonHangFailed(message: "Lấy thông tin đơn hàng trả góp Mirae không thành công. \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
    
}
