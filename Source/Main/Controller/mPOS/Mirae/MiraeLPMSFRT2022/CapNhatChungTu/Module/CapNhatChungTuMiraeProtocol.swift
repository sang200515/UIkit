//
//  CapNhatChungTuMiraeProtocol.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

protocol CapNhatChungTuMiraeViewToPresenterProtocol: AnyObject {
    var view: CapNhatChungTuMiraePresenterToViewProtocol? { get set }
    var interactor: CapNhatChungTuMiraePresenterToInteractorProtocol? { get set }
    var router: CapNhatChungTuMiraePresenterToRouterProtocol? { get set }
    func uploadHinhHoSo(base64:String,fileId:Int,image:UIImage)
    func viewDidLoad()
}

protocol CapNhatChungTuMiraePresenterToInteractorProtocol: AnyObject {
    var presenter:CapNhatChungTuMiraeInteractorToPresenterProtocol? { get set }
    func uploadHinhHoSo(userCode:String,
                        shopCode:String,
                        partnerId:String,
                        base64:String,
                        fileId: Int,
                        appDocEntry: Int,
                        applicationId:String,image:UIImage)
    func loadLyDoHuy(userCode: String, shopCode: String, partnerId: String)
    func uploadCapNhatChungTu(applicationId:String,userCode:String,shopCode:String,partnerId:String,appDocEntry:String,workInfo:Dictionary<String, Any>,documentType:String)
}

protocol CapNhatChungTuMiraeInteractorToPresenterProtocol:AnyObject {
    func uploadHinhSuccess(message:String,tag:Int,image:UIImage)
    func uploadCapNhatChungTuSuccess(message:String)
    func loadLyDoHuySuccess(model:[CapNhatChungTuMiraeEntity.DataLyDoHuyModel])
    func loadMoiQuanHeSuccess(model:[CapNhatChungTuMiraeEntity.DataMoiQuanHeModel])
    func loadLoaiHopDongSuccess(model:[CapNhatChungTuMiraeEntity.DataMoiQuanHeModel])
    func loadLoaiChungTuSuccess(model:[CapNhatChungTuMiraeEntity.DataLoaiChungTuModel])
    func loadLoaiChucVuSuccess(model:[CapNhatChungTuMiraeEntity.DataMoiQuanHeModel])
    func loadMaNoiBoSuccess(model:[CapNhatChungTuMiraeEntity.DataMoiQuanHeModel])
    func loadNgayThanhToanSuccess(model:[CapNhatChungTuMiraeEntity.DataLoaiChungTuModel])
    func outPutSuccess(message:String)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol CapNhatChungTuMiraePresenterToViewProtocol:AnyObject {
    func didUploadCapNhatChungTuSuccess(message:String)
    func didUploadHinhSuccess(message:String,tag:Int,image:UIImage)
    func didLoadInfoCore(model:MasterDataInstallMent)
    func outPutSuccess(data:String)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol CapNhatChungTuMiraePresenterToRouterProtocol:AnyObject {
    var view: CapNhatChungTuMiraeViewController! { get set }
    func configureVIPERCapNhatChungTuMirae() -> CapNhatChungTuMiraeViewController
}

