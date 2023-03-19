//
//  ThongTinDonHangMiraePresenter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit
import KeychainSwift

//MARK:- Input View to Presenter
class ThongTinDonHangMiraePresenter : ThongTinDonHangMiraeViewToPresenterProtocol {

    var appDocEntry:String = ""
    var totalPay:Float = 0
    var isUpdate:Bool = false
    
    weak var view: ThongTinDonHangMiraePresenterToViewProtocol?
    var model:[ThongTinDonHangMiraeEntity.Order] = []
    var modelArrayGoiTraGop:[ThongTinDonHangMiraeEntity.DataGoiVayMiraeModel] = []
    var modelArrayKyHan:[ThongTinDonHangMiraeEntity.LoanTenure] = []
    var khuyenMaiModel:[ThongTinDonHangMiraeEntity.Promotion] = []
    var goiTraGop:String = "0"
    var kyHanTraGop:Int = 0
    var interactor: ThongTinDonHangMiraePresenterToInteractorProtocol?
    
    var router: ThongTinDonHangMiraePresenterToRouterProtocol?
    
    func viewDidLoad() {
        self.view?.showLoading(message: "Đang tải dữ liệu")
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        if self.isUpdate {
            self.interactor?.loadThongTinDonHang(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)", appDocEntry: self.appDocEntry)
        }else {
            self.appDocEntry = KeychainSwift().get("appDocEntryMirae") ?? ""
            self.interactor?.loadGoiTraGop(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)",RDR1:self.parseXMLProduct().toBase64())
            self.setDataDonHang()
        }
        self.interactor?.loadThongTinKhachHang(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)", appDocEntry: self.appDocEntry)
        self.getListVoucherNoPrice()
    }
    
    private func getListVoucherNoPrice() {
        MPOSAPIManager.mpos_FRT_SP_VC_get_list_voucher_by_phone(phonenumber: Cache.infoKHMirae?.soDienThoai ?? "") {
            (results, err) in
                if err.count <= 0 {
                    Cache.listVoucherNoPrice = results
                    self.view?.didLoadVoucherSuccess()
                }
        }
    }
    
    private func setDataDonHang(){
        ShinhanData.totalWithoutByProduct = 0
        Cache.cartsMirae.forEach { item in
            self.totalPay += (item.product.price * Float(item.quantity))
            if item.product.qlSerial == "Y" {
                ShinhanData.totalWithoutByProduct = ShinhanData.totalWithoutByProduct + (item.product.price)
            }
        }
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
extension ThongTinDonHangMiraePresenter : ThongTinDonHangMiraeInteractorToPresenterProtocol {
    
    func loadThongTinDonHangSuccess(model: ThongTinDonHangMiraeEntity.DataChiTietDonHangModel) {
        Cache.cartsMirae.removeAll()
        Cache.itemsPromotionMirae.removeAll()
        let tiencoc:Float = Cache.infoKHMirae?.soTienCoc ?? 0
        Cache.infoKHMirae = nil
        self.model = model.orders ?? []
        
        model.orders?.forEach({ item in
            let product = Product(model_id: "", id: 0, name: item.itemName ?? "", brandID: 0, brandName: "", typeId: 0, typeName: "", sku: item.itemCode ?? "", price: Float(item.price ?? 0), priceMarket: 0, priceBeforeTax: 0, iconUrl: "", imageUrl: "", promotion: "", includeInfo: "", hightlightsDes: "", labelName: "", urlLabelPicture: "", isRecurring: false, manSerNum: "", bonusScopeBoom: "", qlSerial: "", inventory: 0, LableProduct: "", p_matkinh: "", ecomColorValue: "", ecomColorName: "", ecom_itemname_web: "", price_special: 0, price_online_pos: 0, price_online: 0, hotSticker: false, is_NK: false, is_ExtendedWar: false, skuBH: [], nameBH: [], brandGoiBH: [], isPickGoiBH: "", amountGoiBH: "", itemCodeGoiBH: "", itemNameGoiBH: "", priceSauKM: 0, role2: [])
            let cart = Cart(sku: item.itemCode ?? "", product: product, quantity: item.quantity ?? 0, color: "", inStock: 0, imei: item.imei ?? "", price: Float(item.price ?? 0), priceBT: 0, whsCode: "\(Cache.user?.ShopCode ?? "")010", discount: 0, reason: "", note: "", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
            Cache.cartsMirae.append(cart)
            
        })
        model.promotions?.forEach({ item in
            let promotions = ProductPromotions(Loai_KM: "", MaCTKM: item.itemCode ?? "", MaSP: "", TenSanPham_Mua: "", Nhom: "", SL_Tang: item.quantity ?? 0, SanPham_Tang: "", SanPham_Mua: "", TenCTKM: item.itemName ?? "", TenSanPham_Tang: "", TienGiam: 0, MaSP_ThayThe: "", SL_ThayThe: 0, TenSP_ThayThe: "", MenhGia_VC: "", VC_used: "", KhoTang: "", is_imei: "", imei: "")
            Cache.itemsPromotionMirae.append(promotions)
        })
        let userData:KhachHangMiraeModel = KhachHangMiraeModel(soDienThoai: model.customer?.phone ?? "",
                                                               thuNhap: "",
                                                               soCMND: model.customer?.idCard ?? "",
                                                               fullname: model.customer?.fullName ?? "",
                                                               ngayCapCMND: "",
                                                               ngaySinh: "",
                                                               ho: "",
                                                               gioiTinh: "",
                                                               tenLot: "",
                                                               ten: "",
                                                               diaChi: "",
                                                               codeTinhThuongTru: "",
                                                               tinhThuongTru: "", tinhTamTru: "", huyenThuongTru: "", huyenTamTru: "", xaThuongTru: "", xaTamTru: "", codeTinhTamTru: "", codeHuyenThuongTru: "", codeHuyenTamTru: "", codeXaThuongTru: "", codeXaTamTru: "", noiCapCMND: "", tenNguoiThamChieu1: "", moiQuanHeNguoiThamChieu1: "", soDTNguoiThamChieu1: "", tenNguoiThamChieu2: "", moiQuanHeNguoiThamChieu2: "", soDTNguoiThamChieu2: "", appDocEntry: model.customer?.appDocEntry ?? 0, tenGoiTraGop: model.payment?.schemeName ?? "", kyHan: Int(model.payment?.loanTenor ?? 0), phiBaoHiem: model.payment?.insuranceFeeRate ?? 0, soTienVay: model.payment?.loanAmount ?? 0, giamGia: model.payment?.discount ?? 0, tongTien: model.payment?.finalPrice ?? 0, soTienTraTruoc: model.payment?.downPayment ?? 0, soTienCoc: model.payment?.deposit ?? 0, laiSuat: model.payment?.interestRate ?? 0, thanhTien: model.payment?.totalPrice ?? 0, codeGoiTraGop: model.payment?.schemeCode ?? "", fullAddress: "", soPOS: "", soMPOS: "\(model.customer?.soMpos ?? 0)")
        Cache.infoKHMirae = userData
        Cache.infoKHMirae?.soTienCoc = tiencoc
        self.totalPay = model.payment?.totalPrice ?? 0
        self.view?.showLoading(message: "Đang tải dữ liệu")
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        self.interactor?.loadGoiTraGop(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)",RDR1:self.parseXMLProduct().toBase64())
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view?.didLoadThongTinDonHangSuccess(model: model)
        }
    }
    
    func loadThongTinDonHangFailed(message: String) {
        self.view?.didLoadThongTinDonHangFailed(message: message)
    }
    
    
    func loadThongTinKhachHangSuccess(model: ORCCMNDMiraeEntity.ORCCMNDMiraeDataModel) {
        
    }
    
    func loadGoiTraGopSuccess(model: [ThongTinDonHangMiraeEntity.DataGoiVayMiraeModel]) {
        self.modelArrayGoiTraGop = model
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
