//
//  TimKiemDonHangHangMireaPresenter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

//MARK:- Input View to Presenter
class TimKiemDonHangHangMireaPresenter : TimKiemDonHangHangMireaViewToPresenterProtocol {

    weak var view: TimKiemDonHangHangMireaPresenterToViewProtocol?
    
    var interactor: TimKiemDonHangHangMireaPresenterToInteractorProtocol?
    
    var router: TimKiemDonHangHangMireaPresenterToRouterProtocol?
    
    var docEntry:Int = 0
    var model:[TimKiemDonHangHangMireaEntity.DataTimKiemDonHangModel] = []
    
    func timKiemDonHang(soPOS:String) {
        if soPOS == "" {
            return
        }
        self.view?.showLoading(message: "")
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        self.interactor?.timKiemDonHang(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)", soPOS: soPOS)
    }
}

//MARK: -Out Presenter To View
extension TimKiemDonHangHangMireaPresenter : TimKiemDonHangHangMireaInteractorToPresenterProtocol {
    
    func outPutSuccess(data: [TimKiemDonHangHangMireaEntity.DataTimKiemDonHangModel]) {
        self.model = data
        self.view?.didOutPutSuccess()
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
