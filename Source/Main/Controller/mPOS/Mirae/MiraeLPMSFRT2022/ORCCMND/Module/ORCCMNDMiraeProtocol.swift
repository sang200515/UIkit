//
//  ORCCMNDMiraeProtocol.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

protocol ORCCMNDMiraeViewToPresenterProtocol: class {
    var view: ORCCMNDMiraePresenterToViewProtocol? { get set }
    var interactor: ORCCMNDMiraePresenterToInteractorProtocol? { get set }
    var router: ORCCMNDMiraePresenterToRouterProtocol? { get set }
    func orcCMND()
}

protocol ORCCMNDMiraePresenterToInteractorProtocol: class {
    var presenter:ORCCMNDMiraeInteractorToPresenterProtocol? { get set }
    func orcCMND(hinhMatTruoc:String,hinhMatSau:String,userCode:String,shopCode:String,partnerId:String)
}

protocol ORCCMNDMiraeInteractorToPresenterProtocol:class {
    func outPutSuccess(model:ORCCMNDMiraeEntity.ORCCMNDMiraeDataModel)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol ORCCMNDMiraePresenterToViewProtocol:class {
    func outPutSuccess(model:ORCCMNDMiraeEntity.ORCCMNDMiraeDataModel)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol ORCCMNDMiraePresenterToRouterProtocol:class {
    var view: ORCCMNDMiraeViewController! { get set }
    func configureVIPERORCCMNDMirae() -> ORCCMNDMiraeViewController
}

