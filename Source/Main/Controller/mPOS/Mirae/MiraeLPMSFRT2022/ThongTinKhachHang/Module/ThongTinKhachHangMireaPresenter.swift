//
//  ThongTinKhachHangMireaPresenter.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

//MARK:- Input View to Presenter
class ThongTinKhachHangMireaPresenter : ThongTinKhachHangMireaViewToPresenterProtocol {

    var isLichSu:Bool = false
    var isReview:Bool = false
    var modelMoiQuanHe:[CapNhatChungTuMiraeEntity.DataMoiQuanHeModel] = []
    var modelLoaiHopDong:[CapNhatChungTuMiraeEntity.DataMoiQuanHeModel] = []
    var modelLoaiChungTu:[CapNhatChungTuMiraeEntity.DataLoaiChungTuModel] = []
    var modelNgayThanhToan:[CapNhatChungTuMiraeEntity.DataLoaiChungTuModel] = []
    var modelChucVu:[CapNhatChungTuMiraeEntity.DataMoiQuanHeModel] = []
    var modelMaNoiBo:[CapNhatChungTuMiraeEntity.DataMoiQuanHeModel] = []
    var modelTinhThanhPho:[ThongTinKhachHangMireaEntity.DataTinhModel] = []
    var modelTinhThanhPhoFull:[ThongTinKhachHangMireaEntity.DataTinhModel] = []
    var ngayCap: Date? {
        didSet {
            guard ngayCap != nil else { return }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.view?.bindingNgayCap(date: dateFormatter.string(from: ngayCap!))
        }
    }
    var ngaySinh: Date? {
        didSet {
            guard ngaySinh != nil else { return }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.view?.bindingNgaySinh(date: dateFormatter.string(from: ngaySinh!))
        }
    }
    weak var view: ThongTinKhachHangMireaPresenterToViewProtocol?
    var isShowThongTinKH:Bool = false
    var isNgaySinh:Bool = false
    var model:ORCCMNDMiraeEntity.ORCCMNDMiraeDataModel?
    var modelLichSu:LichSuTraGopMiraeEntity.DataLichSuTraGopMiraeModel?
    var modelDiaChi:ThongTinKhachHangMireaEntity.KhachHangMiraeModel = ThongTinKhachHangMireaEntity.KhachHangMiraeModel()
    var modelWorkInfo:[ThongTinKhachHangMireaEntity.ParamCustomer] = []

        //data from core tra gop
    var isCore:Bool = false
    var detailDataMapping:MasterDataInstallMent?
    var interactor: ThongTinKhachHangMireaPresenterToInteractorProtocol?
    
    var router: ThongTinKhachHangMireaPresenterToRouterProtocol?
    
    func viewDidLoad() {
        if self.isLichSu {
            self.modelWorkInfo = [
                ThongTinKhachHangMireaEntity.ParamCustomer(key: "companyName", value: ""),
                ThongTinKhachHangMireaEntity.ParamCustomer(key: "position", value: ""),
                ThongTinKhachHangMireaEntity.ParamCustomer(key: "laborContractType", value: ""),
                ThongTinKhachHangMireaEntity.ParamCustomer(key: "yearWorkNum", value: 0),
                ThongTinKhachHangMireaEntity.ParamCustomer(key: "monthWorkNum", value: 0),
                ThongTinKhachHangMireaEntity.ParamCustomer(key: "firstPaymentDate", value: ""),
                ThongTinKhachHangMireaEntity.ParamCustomer(key: "internalCode", value: ""),
            ]
            guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
            self.interactor?.loadThongTinKhachHang(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)", appDocEntry: "\(self.modelLichSu?.appDocEntry ?? 0)")
        }
        self.loadMoiQuanHe(tag: 0)
    }
    
    func loadListTinhThanhPho(tag:Int){
        if self.modelTinhThanhPhoFull.isEmpty {
            self.view?.showLoading(message: "")
            guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
            self.interactor?.loadTinhThanhPho(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)",tag: tag)
        }else {
            self.filterContentForSearchText("", tag: tag)
        }
    }
    func loadMoiQuanHe(tag:Int){
        self.view?.showLoading(message: "")
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        self.interactor?.loadMoiQuanHe(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)")
    }
    func loadQuanHuyen(tag: Int) {
        self.view?.showLoading(message: "")
        let codeTinh = tag == 3 ? self.modelDiaChi.codeTinhThuongTru : self.modelDiaChi.codeTinhTamTru
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        self.interactor?.loadQuanHuyen(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "",partnerId: "\(PARTNERID)", codeTinh : codeTinh,tag: tag)
    }
    func loadPhuongXa(tag: Int) {
        self.view?.showLoading(message: "")
        let codeHuyen:String = tag == 4 ? self.modelDiaChi.codeHuyenThuongTru : self.modelDiaChi.codeHuyenTamTru
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        self.interactor?.loadXaPhuong(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)", codeQuanHuyen: codeHuyen, tag: tag)
    }
    func luuHoSo(customerInfo: Dictionary<String, Any>,
                 permanentAddress: Dictionary<String, Any>,
                 residenceAddress: Dictionary<String, Any>,
                 refPerson1: Dictionary<String, Any>,
                 refPerson2: Dictionary<String, Any>) {
        self.view?.showLoading(message: "")
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        self.interactor?.luuHoSoMirae(userCode: userCode,
                                      shopCode: Cache.user?.ShopCode ?? "",
                                      partnerId: "\(PARTNERID)",
                                      customerInfo: customerInfo,
                                      permanentAddress: permanentAddress,
                                      residenceAddress: residenceAddress,
                                      refPerson1: refPerson1,
                                      refPerson2: refPerson2)
        
    }
    func updateThongTinCongViec(customerInfo: Dictionary<String, Any>,
                                permanentAddress: Dictionary<String, Any>,
                                residenceAddress: Dictionary<String, Any>,
                                refPerson1: Dictionary<String, Any>,
                                refPerson2: Dictionary<String, Any>) {
        self.view?.showLoading(message: "")
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        self.interactor?.updateThongTinCongViec(userCode: userCode,
                                                shopCode: Cache.user?.ShopCode ?? "",
                                                partnerId: "\(PARTNERID)",
                                                appDocEntry: "\(self.modelLichSu?.appDocEntry ?? 0)",
                                                customerInfo: customerInfo,
                                                permanentAddress: permanentAddress,
                                                residenceAddress: residenceAddress,
                                                refPerson1: refPerson1,
                                                refPerson2: refPerson2,
                                                workInfo: self.createParamWorkInfo())
    }
    
    private func setupData(){
        self.modelDiaChi.gioiTinh = self.model?.customerInfo?.sex ?? ""
        self.modelDiaChi.codeTinhThuongTru = self.model?.permanentAddress?.cityCode ?? ""
        self.modelDiaChi.codeHuyenThuongTru = self.model?.permanentAddress?.districtCode ?? ""
        self.modelDiaChi.codeXaThuongTru = self.model?.permanentAddress?.wardCode ?? ""
        self.modelDiaChi.diaChi = self.model?.permanentAddress?.street ?? ""
        self.modelDiaChi.codeTinhTamTru = self.model?.residenceAddress?.cityCode ?? ""
        self.modelDiaChi.codeHuyenTamTru = self.model?.residenceAddress?.districtCode ?? ""
        self.modelDiaChi.codeXaTamTru = self.model?.residenceAddress?.wardCode ?? ""
        self.modelDiaChi.diaChiTamTru = self.model?.residenceAddress?.street ?? ""
        
        self.modelDiaChi.tenNguoiThamChieu1 = self.model?.refPerson1?.fullName ?? ""
        self.modelDiaChi.moiQuanHeNguoiThamChieu1 = self.model?.refPerson1?.relationship ?? ""
        self.modelDiaChi.soDTNguoiThamChieu1 = self.model?.refPerson1?.phone ?? ""
        
        self.modelDiaChi.tenNguoiThamChieu2 = self.model?.refPerson2?.fullName ?? ""
        self.modelDiaChi.moiQuanHeNguoiThamChieu2 = self.model?.refPerson2?.relationship ?? ""
        self.modelDiaChi.soDTNguoiThamChieu2 = self.model?.refPerson2?.phone ?? ""

        self.modelWorkInfo[0].value = self.model?.workInfo?.companyName ?? ""
        self.modelWorkInfo[1].value = self.model?.workInfo?.position ?? ""
        self.modelWorkInfo[2].value = self.model?.workInfo?.laborContractType ?? ""
        self.modelWorkInfo[3].value = "\(self.model?.workInfo?.monthWorkNum ?? 0)"
        self.modelWorkInfo[4].value = "\(self.model?.workInfo?.yearWorkNum ?? 0)"
        self.modelWorkInfo[5].value = self.model?.workInfo?.firstPaymentDate ?? ""
        self.modelWorkInfo[6].value = self.model?.workInfo?.internalCode ?? ""
    }
    
    private func createParamWorkInfo() -> Dictionary<String, Any>{
        var model:Dictionary<String,Any> = Dictionary<String,Any>()
        self.modelWorkInfo.forEach { item in
            model[item.key] = item.value
        }
        return model
    }
    
    func resubmitToMirae(){
        self.view?.showLoading(message: "Đang tải")
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        self.interactor?.resubmitToMirae(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)", appDocEntry: "\(Cache.infoKHMirae?.appDocEntry ?? 0)")
    }
    
    func filterContentForSearchText(_ searchText: String,tag:Int) {
        var filteredItems:[ThongTinKhachHangMireaEntity.DataTinhModel] = []
        if searchText == "" {
            self.modelTinhThanhPho = self.modelTinhThanhPhoFull
        }else {
            let options = String.CompareOptions.caseInsensitive
            filteredItems = self.modelTinhThanhPhoFull
                .filter{$0.text?.range(of: searchText, options: options) != nil}
                .sorted{ ($0.text?.hasPrefix(searchText) ?? false ? 0 : 1) < ($1.text?.hasPrefix(searchText) ?? false ? 0 : 1) }
            self.modelTinhThanhPho = filteredItems
        }
        self.view?.didSearchTinhThanhPhoSuccess(model: self.modelTinhThanhPho, tag: tag)
    }
}

//MARK: -Out Presenter To View
extension ThongTinKhachHangMireaPresenter : ThongTinKhachHangMireaInteractorToPresenterProtocol {
    func resubmitToMiraeSuccess(message: String) {
        self.view?.didResubmitToMiraeSuccess(message: message)
    }
    
    
    func loadNgayThanhToanSuccess(model:[CapNhatChungTuMiraeEntity.DataLoaiChungTuModel]) {
        self.modelNgayThanhToan = model
    }

    func loadMoiQuanHeSuccess(model: [CapNhatChungTuMiraeEntity.DataMoiQuanHeModel]) {
        self.modelMoiQuanHe = model
    }
    
    func loadLoaiHopDongSuccess(model: [CapNhatChungTuMiraeEntity.DataMoiQuanHeModel]) {
        self.modelLoaiHopDong = model
    }
    
    func loadLoaiChungTuSuccess(model: [CapNhatChungTuMiraeEntity.DataLoaiChungTuModel]) {
        self.modelLoaiChungTu = model
    }
    
    func loadLoaiChucVuSuccess(model: [CapNhatChungTuMiraeEntity.DataMoiQuanHeModel]) {
        self.modelChucVu = model
    }
    
    func loadMaNoiBoSuccess(model: [CapNhatChungTuMiraeEntity.DataMoiQuanHeModel]) {
        self.modelMaNoiBo = model
    }
    
    func updateThongTinCongViecSuccess(model: ThongTinKhachHangMireaEntity.UpdateThongTinCongViecModel) {
        self.view?.didUpdateThongTinCongViecSuccess(model: model)
    }

    func loadThongTinKhachHangSuccess(model: ORCCMNDMiraeEntity.ORCCMNDMiraeDataModel) {
        self.model = model
        self.setupData()
        self.view?.didLoadThongTinKhachHangSuccess(model: model)
    }
    
    func luuHoSoSuccess(message: String, docEntry: Int) {
        self.view?.didLuuHoSoSuccess(message: message,docEntry: docEntry)
    }
    
    func loadQuanHuyenSuccess(model: [ThongTinKhachHangMireaEntity.DataTinhModel], tag: Int) {
        self.view?.didLoadQuanHuyenSuccess(model: model, tag: tag)
    }
    
    func loadPhuongXaSuccess(model: [ThongTinKhachHangMireaEntity.DataTinhModel], tag: Int) {
        self.view?.didLoadPhuongXaSuccess(model: model, tag: tag)
    }
    
    func loadTinhThanhPhoSuccess(model: [ThongTinKhachHangMireaEntity.DataTinhModel],tag:Int) {
        self.modelTinhThanhPho = model
        self.modelTinhThanhPhoFull = model
        self.view?.didLoadTinhThanhPhoSuccess(model: model,tag: tag)
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
