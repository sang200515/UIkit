//
//  ORCCMNDMiraePresenter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

//MARK:- Input View to Presenter
class ORCCMNDMiraePresenter : ORCCMNDMiraeViewToPresenterProtocol {

    var hinhMatTruoc:String = ""
    var hinhMatSau:String = ""
    var infoModel:ORCCMNDMiraeEntity.ORCCMNDMiraeDataModel?
    
    weak var view: ORCCMNDMiraePresenterToViewProtocol?
    
    var interactor: ORCCMNDMiraePresenterToInteractorProtocol?
    
    var router: ORCCMNDMiraePresenterToRouterProtocol?
    
    func orcCMND() {
        self.view?.showLoading(message: "Đang xác minh")
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        self.interactor?.orcCMND(hinhMatTruoc: self.hinhMatTruoc,
                                 hinhMatSau: self.hinhMatSau,
                                 userCode: userCode,
                                 shopCode: Cache.user?.ShopCode ?? "",
                                 partnerId: "\(PARTNERID)")
    }
}

//MARK: -Out Presenter To View
extension ORCCMNDMiraePresenter : ORCCMNDMiraeInteractorToPresenterProtocol {
    
    func outPutSuccess(model:ORCCMNDMiraeEntity.ORCCMNDMiraeDataModel) {
        self.infoModel = model
        self.view?.outPutSuccess(model: model)
    }
    
    func outPutFailed(error: String) {
        self.view?.outPutFailed(error: error)
    }
    
    func showLoading(message: String) {
        self.view?.showLoading(message: message)
    }
    
    func hideLoading() {
        self.view?.hideLoading()
    }

}
