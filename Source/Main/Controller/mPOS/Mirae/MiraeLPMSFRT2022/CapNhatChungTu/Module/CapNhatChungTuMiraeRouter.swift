//
//  CapNhatChungTuMiraeRouter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class CapNhatChungTuMiraeRouter : CapNhatChungTuMiraePresenterToRouterProtocol {

    var view: CapNhatChungTuMiraeViewController!

    func configureVIPERCapNhatChungTuMirae() -> CapNhatChungTuMiraeViewController {
        self.view = CapNhatChungTuMiraeViewController()
        let presenter: CapNhatChungTuMiraePresenter = CapNhatChungTuMiraePresenter()
        let interactor: CapNhatChungTuMiraeInteractor = CapNhatChungTuMiraeInteractor()
        let router:CapNhatChungTuMiraePresenterToRouterProtocol = CapNhatChungTuMiraeRouter()
        self.view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return self.view!
    }

}
