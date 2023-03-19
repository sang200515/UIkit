//
//  ThongTinDonHangMiraeRouter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class ThongTinDonHangMiraeRouter : ThongTinDonHangMiraePresenterToRouterProtocol {

    var view: ThongTinDonHangMiraeViewController!

    func configureVIPERThongTinDonHangMirae() -> ThongTinDonHangMiraeViewController {
        self.view = ThongTinDonHangMiraeViewController()
        let presenter: ThongTinDonHangMiraePresenter = ThongTinDonHangMiraePresenter()
        let interactor: ThongTinDonHangMiraeInteractor = ThongTinDonHangMiraeInteractor()
        let router:ThongTinDonHangMiraePresenterToRouterProtocol = ThongTinDonHangMiraeRouter()
        self.view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return self.view!
    }

}
