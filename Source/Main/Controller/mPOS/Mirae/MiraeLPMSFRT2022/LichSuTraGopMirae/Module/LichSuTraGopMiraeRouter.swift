//
//  LichSuTraGopMiraeRouter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class LichSuTraGopMiraeRouter : LichSuTraGopMiraePresenterToRouterProtocol {

    var view: LichSuTraGopMiraeViewController!

    func configureVIPERLichSuTraGopMirae() -> LichSuTraGopMiraeViewController {
        self.view = LichSuTraGopMiraeViewController()
        let presenter: LichSuTraGopMiraePresenter = LichSuTraGopMiraePresenter()
        let interactor: LichSuTraGopMiraeInteractor = LichSuTraGopMiraeInteractor()
        let router:LichSuTraGopMiraePresenterToRouterProtocol = LichSuTraGopMiraeRouter()
        self.view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return self.view!
    }

}
