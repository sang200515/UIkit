//
//  ThongTinDonHangCompleteRouter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class ThongTinDonHangMiraeCompleteRouter : ThongTinDonHangMiraeCompletePresenterToRouterProtocol {

    var view: ThongTinDonHangMiraeCompleteViewController!

    func configureVIPERThongTinDonHangComplete() -> ThongTinDonHangMiraeCompleteViewController {
        self.view = ThongTinDonHangMiraeCompleteViewController()
        let presenter: ThongTinDonHangMiraeCompletePresenter = ThongTinDonHangMiraeCompletePresenter()
        let interactor: ThongTinDonHangMiraeCompleteInteractor = ThongTinDonHangMiraeCompleteInteractor()
        let router:ThongTinDonHangMiraeCompletePresenterToRouterProtocol = ThongTinDonHangMiraeCompleteRouter()
        self.view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return self.view!
    }

}
