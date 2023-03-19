//
//  LichSuTraGopMiraeProtocol.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

protocol LichSuTraGopMiraeViewToPresenterProtocol: class {
    var view: LichSuTraGopMiraePresenterToViewProtocol? { get set }
    var interactor: LichSuTraGopMiraePresenterToInteractorProtocol? { get set }
    var router: LichSuTraGopMiraePresenterToRouterProtocol? { get set }
    func viewDidLoad(type:String)
}

protocol LichSuTraGopMiraePresenterToInteractorProtocol: class {
    var presenter:LichSuTraGopMiraeInteractorToPresenterProtocol? { get set }
    func loadDanhSachLichSu(userCode:String,shopCode:String,partnerId:String,loadType:String)
}

protocol LichSuTraGopMiraeInteractorToPresenterProtocol:class {
    func loadDanhSachLichSuSuccess(model:[LichSuTraGopMiraeEntity.DataLichSuTraGopMiraeModel])
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol LichSuTraGopMiraePresenterToViewProtocol:class {
    func didSearchSuccess()
    func didLoadDanhSachLichSuSuccess(model:[LichSuTraGopMiraeEntity.DataLichSuTraGopMiraeModel])
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol LichSuTraGopMiraePresenterToRouterProtocol:class {
    var view: LichSuTraGopMiraeViewController! { get set }
    func configureVIPERLichSuTraGopMirae() -> LichSuTraGopMiraeViewController
}

