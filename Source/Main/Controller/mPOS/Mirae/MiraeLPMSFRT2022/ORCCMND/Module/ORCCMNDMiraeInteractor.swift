//
//  ORCCMNDMiraeInteractor.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class ORCCMNDMiraeInteractor:ORCCMNDMiraePresenterToInteractorProtocol {
    
    weak var presenter: ORCCMNDMiraeInteractorToPresenterProtocol?
    
    func orcCMND(hinhMatTruoc:String,hinhMatSau:String,userCode:String,shopCode:String,partnerId:String) {
        self.presenter?.showLoading(message: "Vui lòng chờ")
        ApiRequestMirae.request(ApiRouterMirae.orcCMNDCCCDMirae(partnerId: partnerId, userCode: userCode, shopCode: shopCode, frontBase64: hinhMatTruoc, backBase64: hinhMatSau), ORCCMNDMiraeEntity.ORCCMNDMiraeModel.self) { response in
            switch response {
            case .success(let modelData):
                if modelData.success == true {
                    if let model = modelData.data {
                        self.presenter?.outPutSuccess( model: model)
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

}
