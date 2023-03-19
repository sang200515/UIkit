//
//  UpdateGoiVayMiraeInteractor.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class UpdateGoiVayMiraeInteractor:UpdateGoiVayMiraePresenterToInteractorProtocol {
    
    func resubmitToMirae(userCode: String, shopCode: String, partnerId: String, appDocEntry: String) {
        ApiRequestMirae.request(.resubmitToMirae(userCode: userCode, shopCode: shopCode, partnerId: partnerId, appDocEntry: appDocEntry), UpdateGoiVayMiraeEntity.ResubmitModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.resubmitToMiraeSuccess(message: "Gửi hồ sơ thành công.\(data.message ?? "")")
                }else {
                    self.presenter?.outPutFailed(error: "Gửi hồ sơ không thành công. \(data.message ?? "")")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Gửi hồ sơ không thành công. \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }
    
    
    weak var presenter: UpdateGoiVayMiraeInteractorToPresenterProtocol?
    
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
                               schemecode: String){
        ApiRequestMirae.request(.updateGoiVay(discount: Double(discount), loaiTraGop: loaiTraGop, voucher: voucher, diviceType: diviceType, payments: payments, doctype: doctype, soTienTraTruoc: soTienTraTruoc, tenCTyTraGop: tenCTyTraGop, token: token, shopCode: shopCode, ngaySinh: ngaySinh, cardName: cardName, soHDtragop: soHDtragop, address: address, mail: mail, phone: phone, pre_docentry: pre_docentry, xmlspGiamGiaTay: xmlspGiamGiaTay, xmlVoucherDH: xmlVoucherDH, U_EplCod: U_EplCod, xml_url_pk: xml_url_pk, cardcode: cardcode, laiSuat: laiSuat, is_sale_MDMH: is_sale_MDMH, CMND: CMND, is_DH_DuAn: is_DH_DuAn, PROMOS: PROMOS, U_des: U_des, is_sale_software: is_sale_software, is_samsung: is_samsung, RDR1: RDR1, xmlstringpay: xmlstringpay, kyhan: kyhan, is_KHRotTG: is_KHRotTG, gioitinh: gioitinh, CRMCode: CRMCode, appDocEntry: appDocEntry, schemecode: schemecode), ThongTinDonHangMiraeCompleteEntity.LuuDonHangAndCustomerModel.self) { response in
            switch response {
            case .success(let data):
                if data.success == true {
                    self.presenter?.capNhatKhoanVaySuccess(message: "Cập nhật khoản vay thành công.\(data.message ?? "")")
                }else {
                    self.presenter?.outPutFailed(error: "Cập nhật khoản vay không thành công. \(data.message ?? "")")
                }
            case .failure(let error):
                self.presenter?.outPutFailed(error: "Cập nhật khoản vay không thành công. \(error.message)")
            }
            self.presenter?.hideLoading()
        }
    }

}
