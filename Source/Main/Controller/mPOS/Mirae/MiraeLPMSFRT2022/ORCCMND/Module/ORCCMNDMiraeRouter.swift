//
//  ORCCMNDMiraeRouter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class ORCCMNDMiraeRouter : ORCCMNDMiraePresenterToRouterProtocol {

    var view: ORCCMNDMiraeViewController!

    func configureVIPERORCCMNDMirae() -> ORCCMNDMiraeViewController {
        self.view = ORCCMNDMiraeViewController()
        let presenter: ORCCMNDMiraePresenter = ORCCMNDMiraePresenter()
        let interactor: ORCCMNDMiraeInteractor = ORCCMNDMiraeInteractor()
        let router:ORCCMNDMiraePresenterToRouterProtocol = ORCCMNDMiraeRouter()
        self.view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return self.view!
    }

}
