//
//  UpdateHinhAnhMiraeProtocol.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

protocol UpdateHinhAnhMiraeViewToPresenterProtocol: class {
    var view: UpdateHinhAnhMiraePresenterToViewProtocol? { get set }
    var interactor: UpdateHinhAnhMiraePresenterToInteractorProtocol? { get set }
    var router: UpdateHinhAnhMiraePresenterToRouterProtocol? { get set }
    func viewDidLoad()
    func updateHinhConThieu()
    func resubmitToMirae()
    func uploadHinhHoSo(base64:String,fileId:Int,image:UIImage)
}

protocol UpdateHinhAnhMiraePresenterToInteractorProtocol: class {
    var presenter:UpdateHinhAnhMiraeInteractorToPresenterProtocol? { get set }
    func loadAnhConThieu(userCode:String,shopCode:String,partnerId:String,appDocEntry:String)
    func uploadHinhHoSo(userCode:String,
                        shopCode:String,
                        partnerId:String,
                        base64:String,
                        fileId: Int,
                        appDocEntry: Int,
                        applicationId:String,image:UIImage)
    func updateHinhConThieu(userCode:String,shopCode:String,partnerId:String,appDocEntry:String)
    func resubmitToMirae(userCode:String,shopCode:String,partnerId:String,appDocEntry:String)
}

protocol UpdateHinhAnhMiraeInteractorToPresenterProtocol:class {
    func loadAnhConThieuSuccess(model:[UpdateHinhAnhMiraeEntity.EditableField])
    func updateHinhConThieuSuccess(message:String)
    func resubmitToMiraeSuccess(message:String)
    func uploadHinhSuccess(message:String,tag:Int,image:UIImage)
    func updateHinhConThieuFailed(message:String,model:[UpdateHinhAnhMiraeEntity.EditableField])
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol UpdateHinhAnhMiraePresenterToViewProtocol:class {
    func didUpdateHinhConThieuSuccess(message:String)
    func didResubmitToMiraeSuccess(message:String)
    func didUpdateHinhConThieuFailed(message:String)
    func didUploadHinhSuccess(message:String,tag:Int,image:UIImage)
    func didLoadAnhConThieuSuccess()
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol UpdateHinhAnhMiraePresenterToRouterProtocol:class {
    var view: UpdateHinhAnhMiraeViewController! { get set }
    func configureVIPERUpdateHinhAnhMirae() -> UpdateHinhAnhMiraeViewController
}

