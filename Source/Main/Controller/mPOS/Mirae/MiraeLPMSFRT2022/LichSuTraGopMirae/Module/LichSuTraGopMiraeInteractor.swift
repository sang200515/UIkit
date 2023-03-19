//
//  LichSuTraGopMiraeInteractor.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class LichSuTraGopMiraeInteractor:LichSuTraGopMiraePresenterToInteractorProtocol {
    
    weak var presenter: LichSuTraGopMiraeInteractorToPresenterProtocol?

    func loadDanhSachLichSu(userCode: String, shopCode: String, partnerId: String, loadType: String) {
        ApiRequestMirae.request(ApiRouterMirae.loadDanhSachLichSu(userCode: userCode, shopCode: shopCode, partnerId: partnerId, loadType: loadType), LichSuTraGopMiraeEntity.LichSuTraGopMiraeModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    if let model = data.data {
                        self.presenter?.loadDanhSachLichSuSuccess(model: model)
                    }
                }else {
                    self.presenter?.outPutFailed(error: "Lấy danh sách lịch sử trả góp Mirae không thành công. \(data.message ?? "")")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Lấy danh sách lịch sử trả góp Mirae không thành công. \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
}
