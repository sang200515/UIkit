//
//  UpdateGoiVayMiraePresenter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

//MARK:- Input View to Presenter
class UpdateGoiVayMiraePresenter : UpdateGoiVayMiraeViewToPresenterProtocol {

    var count:Int = 0
    var lichSuModel:LichSuTraGopMiraeEntity.DataLichSuTraGopMiraeModel?
    var sanPhamModel:[ThongTinDonHangMiraeEntity.Order] = []
    var khuyenMaiModel:[ThongTinDonHangMiraeEntity.Promotion] = []
    
    weak var view: UpdateGoiVayMiraePresenterToViewProtocol?
    
    var interactor: UpdateGoiVayMiraePresenterToInteractorProtocol?
    
    var router: UpdateGoiVayMiraePresenterToRouterProtocol?
    
    func viewDidLoad() {
        Cache.cartsMirae.forEach { item in
			let model = ThongTinDonHangMiraeEntity.Order(itemCode: item.sku , itemName: item.product.name, imei: item.imei, price: Double(item.price), quantity: item.quantity, is_Hot: item.product.hotSticker)
            self.sanPhamModel.append(model)
        }
        Cache.itemsPromotionMirae.forEach { item in
            let model = ThongTinDonHangMiraeEntity.Promotion(itemCode: item.MaCTKM, itemName: item.TenCTKM, quantity: item.SL_Tang)
            self.khuyenMaiModel.append(model)
        }
        if let data = Cache.infoKHMirae {
            self.view?.didBidingDataCache(model: data)
        }
    }
    
    func updateGoiVay(){
        self.view?.showLoading(message: "")
        guard let crm = UserDefaults.standard.string(forKey: "CRMCode") else {return}
        var voucher:String = ""
        if(Cache.listVoucherMirae.count > 0){
            voucher = "<line>"
            for item in Cache.listVoucherMirae{
                voucher  = voucher + "<item voucher=\"\(item)\" />"
            }
            voucher = voucher + "</line>"
        }
		let soTienTraTruoc:Float = (Cache.infoKHMirae?.soTienTraTruoc ?? 0) + (Cache.infoKHMirae?.soTienCoc ?? 0)
        self.interactor?.updateGoiVay(discount: Cache.infoKHMirae?.giamGia ?? 0, loaiTraGop: "0", voucher: voucher, diviceType: "2", payments: "N", doctype: "02", soTienTraTruoc: soTienTraTruoc, tenCTyTraGop: PARTNERID == "FPT" ? "4221595" : "12828217", token: Cache.user?.Token ?? "", shopCode: Cache.user?.ShopCode ?? "", ngaySinh:Cache.infoKHMirae?.ngaySinh ?? "", cardName:  Cache.infoKHMirae?.fullname ?? "", soHDtragop: "0", address:  Cache.infoKHMirae?.fullAddress ?? "", mail: "", phone:  Cache.infoKHMirae?.soDienThoai ?? "", pre_docentry: Cache.infoKHMirae?.soMPOS ?? "0", xmlspGiamGiaTay: "", xmlVoucherDH: "", U_EplCod: Cache.user?.UserName ?? "", xml_url_pk: "", cardcode: "0", laiSuat: Cache.infoKHMirae?.laiSuat ?? 0, is_sale_MDMH: "", CMND: Cache.infoKHMirae?.soCMND ?? "", is_DH_DuAn: "N", PROMOS: self.parseXMLPromotion().toBase64(), U_des: "", is_sale_software: "", is_samsung: "0", RDR1: self.parseXMLProduct().toBase64(), xmlstringpay: "", kyhan: Cache.infoKHMirae?.kyHan ?? 0, is_KHRotTG: 0, gioitinh: Cache.infoKHMirae?.gioiTinh == "M" ? 0 : 1, CRMCode: crm, appDocEntry:  Cache.infoKHMirae?.appDocEntry ?? 0, schemecode: Cache.infoKHMirae?.codeGoiTraGop ?? "")
        
    }
    
    func resubmitToMirae(){
        self.view?.showLoading(message: "Đang tải")
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        self.interactor?.resubmitToMirae(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)", appDocEntry: "\(Cache.infoKHMirae?.appDocEntry ?? 0)")
    }
    
    func parseXMLPromotion()->String{
        var rs:String = "<line>"
        for item in Cache.itemsPromotionMirae {
            var tenCTKM = item.TenCTKM
            tenCTKM = tenCTKM.replace(target: "&", withString:"&#38;")
            tenCTKM = tenCTKM.replace(target: "<", withString:"&#60;")
            tenCTKM = tenCTKM.replace(target: ">", withString:"&#62;")
            tenCTKM = tenCTKM.replace(target: "\"", withString:"&#34;")
            tenCTKM = tenCTKM.replace(target: "'", withString:"&#39;")
            
            var tenSanPham_Tang = item.TenSanPham_Tang
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "&", withString:"&#38;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "<", withString:"&#60;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: ">", withString:"&#62;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "\"", withString:"&#34;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "'", withString:"&#39;")
            
            rs = rs + "<item SanPham_Mua=\"\(item.SanPham_Mua)\" TienGiam=\"\(String(format: "%.6f", item.TienGiam))\" LoaiKM=\"\(item.Loai_KM)\" SanPham_Tang=\"\(item.SanPham_Tang)\" TenSanPham_Tang=\"\(tenSanPham_Tang)\" SL_Tang=\"\(item.SL_Tang)\" Nhom=\"\(item.Nhom)\" MaCTKM=\"\(item.MaCTKM)\" TenCTKM=\"\(tenCTKM)\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    func parseXMLProduct()->String{
        var rs:String = "<line>"
        for item in Cache.cartsMirae {
            var name = item.product.name
            name = name.replace(target: "&", withString:"&#38;")
            name = name.replace(target: "<", withString:"&#60;")
            name = name.replace(target: ">", withString:"&#62;")
            name = name.replace(target: "\"", withString:"&#34;")
            name = name.replace(target: "'", withString:"&#39;")
            
            if(item.imei == "N/A"){
                item.imei = ""
            }
            
            item.imei = item.imei.replace(target: "&", withString:"&#38;")
            item.imei = item.imei.replace(target: "<", withString:"&#60;")
            item.imei = item.imei.replace(target: ">", withString:"&#62;")
            item.imei = item.imei.replace(target: "\"", withString:"&#34;")
            item.imei = item.imei.replace(target: "'", withString:"&#39;")
            
            rs = rs + "<item U_ItmCod=\"\(item.sku)\" U_Imei=\"\(item.imei)\" U_Quantity=\"\(item.quantity)\"  U_Price=\"\(String(format: "%.6f", item.product.price))\" U_WhsCod=\"\(Cache.user!.ShopCode)010\" U_ItmName=\"\(name)\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
}

//MARK: -Out Presenter To View
extension UpdateGoiVayMiraePresenter : UpdateGoiVayMiraeInteractorToPresenterProtocol {
    func resubmitToMiraeSuccess(message: String) {
        self.view?.didResubmitToMiraeSuccess(message: message)
    }
    
    func capNhatKhoanVaySuccess(message: String) {
        self.view?.didCapNhatKhoanVaySuccess(message: message)
    }
    
    
    func outPutSuccess(data: String) {
        self.view?.outPutSuccess(data: data)
    }
    
    func outPutFailed(error: String) {
        self.view?.outPutFailed(error: error)
    }
    
    func showLoading(message: String) {
        self.view?.showLoading(message: message)
    }
    
    func hideLoading() {
        self.view?.hideLoading()
    }

}
