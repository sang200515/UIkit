//
//  UpdateGoiVayMiraeRouter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class UpdateGoiVayMiraeRouter : UpdateGoiVayMiraePresenterToRouterProtocol {

    var view: UpdateGoiVayMiraeViewController!

    func configureVIPERUpdateGoiVayMirae() -> UpdateGoiVayMiraeViewController {
        self.view = UpdateGoiVayMiraeViewController()
        let presenter: UpdateGoiVayMiraePresenter = UpdateGoiVayMiraePresenter()
        let interactor: UpdateGoiVayMiraeInteractor = UpdateGoiVayMiraeInteractor()
        let router:UpdateGoiVayMiraePresenterToRouterProtocol = UpdateGoiVayMiraeRouter()
        self.view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return self.view!
    }

}
