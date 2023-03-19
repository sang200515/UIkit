//
//  UpdateHinhAnhMiraeRouter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class UpdateHinhAnhMiraeRouter : UpdateHinhAnhMiraePresenterToRouterProtocol {

    var view: UpdateHinhAnhMiraeViewController!

    func configureVIPERUpdateHinhAnhMirae() -> UpdateHinhAnhMiraeViewController {
        self.view = UpdateHinhAnhMiraeViewController()
        let presenter: UpdateHinhAnhMiraePresenter = UpdateHinhAnhMiraePresenter()
        let interactor: UpdateHinhAnhMiraeInteractor = UpdateHinhAnhMiraeInteractor()
        let router:UpdateHinhAnhMiraePresenterToRouterProtocol = UpdateHinhAnhMiraeRouter()
        self.view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return self.view!
    }

}
