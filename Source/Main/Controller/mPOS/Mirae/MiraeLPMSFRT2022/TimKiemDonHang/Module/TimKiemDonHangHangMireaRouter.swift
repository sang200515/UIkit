//
//  TimKiemDonHangHangMireaRouter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class TimKiemDonHangHangMireaRouter : TimKiemDonHangHangMireaPresenterToRouterProtocol {

    var view: TimKiemDonHangHangMireaViewController!

    func configureVIPERTimKiemDonHangHangMirea() -> TimKiemDonHangHangMireaViewController {
        self.view = TimKiemDonHangHangMireaViewController()
        let presenter: TimKiemDonHangHangMireaPresenter = TimKiemDonHangHangMireaPresenter()
        let interactor: TimKiemDonHangHangMireaInteractor = TimKiemDonHangHangMireaInteractor()
        let router:TimKiemDonHangHangMireaPresenterToRouterProtocol = TimKiemDonHangHangMireaRouter()
        self.view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return self.view!
    }

}
