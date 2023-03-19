//
//  UpdateGoiVayMiraeProtocol.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

protocol UpdateGoiVayMiraeViewToPresenterProtocol: class {
    var view: UpdateGoiVayMiraePresenterToViewProtocol? { get set }
    var interactor: UpdateGoiVayMiraePresenterToInteractorProtocol? { get set }
    var router: UpdateGoiVayMiraePresenterToRouterProtocol? { get set }
    func updateGoiVay()
    func resubmitToMirae()
}

protocol UpdateGoiVayMiraePresenterToInteractorProtocol: class {
    var presenter:UpdateGoiVayMiraeInteractorToPresenterProtocol? { get set }
    func resubmitToMirae(userCode:String,shopCode:String,partnerId:String,appDocEntry:String)
    func updateGoiVay(discount: Float,
                               loaiTraGop: String,
                               voucher: String,
                               diviceType: String,
                               payments: String,
                               doctype: String,
                               soTienTraTruoc: Float,
                               tenCTyTraGop: String,
                               token: String,
                               shopCode: String,
                               ngaySinh: String,
                               cardName: String,
                               soHDtragop: String,
                               address: String,
                               mail: String,
                               phone: String,
                               pre_docentry: String,
                               xmlspGiamGiaTay: String,
                               xmlVoucherDH: String,
                               U_EplCod: String,
                               xml_url_pk: String,
                               cardcode: String,
                               laiSuat: Float,
                               is_sale_MDMH: String,
                               CMND: String,
                               is_DH_DuAn: String,
                               PROMOS: String,
                               U_des: String,
                               is_sale_software: String,
                               is_samsung: String,
                               RDR1: String,
                               xmlstringpay: String,
                               kyhan: Int,
                               is_KHRotTG: Int,
                               gioitinh: Int,
                               CRMCode: String,
                               appDocEntry: Int,
                               schemecode: String)
}

protocol UpdateGoiVayMiraeInteractorToPresenterProtocol:class {
    func capNhatKhoanVaySuccess(message:String)
    func resubmitToMiraeSuccess(message:String)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol UpdateGoiVayMiraePresenterToViewProtocol:class {
    func didCapNhatKhoanVaySuccess(message:String)
    func didResubmitToMiraeSuccess(message:String)
    func didBidingDataCache(model: KhachHangMiraeModel)
    func outPutSuccess(data:String)
    func outPutFailed(error:String)
    func showLoading(message:String)
    func hideLoading()
}

protocol UpdateGoiVayMiraePresenterToRouterProtocol:class {
    var view: UpdateGoiVayMiraeViewController! { get set }
    func configureVIPERUpdateGoiVayMirae() -> UpdateGoiVayMiraeViewController
}

