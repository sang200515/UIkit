//
//  ThongTinDonHangCompleteViewController.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class ThongTinDonHangMiraeCompleteViewController: BaseVC<ThongTinDonHangMiraeCompleteView> {
   
    //MARK:- Properties
    var presenter: ThongTinDonHangMiraeCompletePresenter?
    //MARK:- Create ComponentUI
    

    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.configureTableView()
        self.configureNavigation()
        self.configureButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateHeightScrollView()
        self.presenter?.viewDidLoad()
    }
    
    private func configureNavigation(){
        self.configureNavigationBackItem(title: "THÔNG TIN ĐƠN HÀNG")
    }
    
    private func configureTableView(){
        self.mainView.donHangTableView.dataSource = self
        self.mainView.donHangTableView.delegate = self
        self.mainView.khuyenMaiTableView.dataSource = self
        self.mainView.khuyenMaiTableView.delegate = self
        self.mainView.voucherTableView.dataSource = self
        self.mainView.voucherTableView.delegate = self
    }

    private func updateHeightScrollView(){
        let contentRect: CGRect = self.mainView.scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        self.mainView.scrollView.contentSize = contentRect.size
        view.layoutIfNeeded()
    }
    
    deinit {
        print("Denit ThongTinDonHangCompleteViewController is Success")
    }
    
    //MARK:- Configure
    private func configureButton(){
        self.mainView.luuDonHangButton.addTarget(self, action: #selector(self.luuDonHangTapped), for: .touchUpInside)
        self.mainView.capNhatThongTinButton.addTarget(self, action: #selector(self.capNhatThongTinKhachHangTapped), for: .touchUpInside)
        self.mainView.thongTinKhachHangButton.addTarget(self, action: #selector(self.thongTinKhachHangTapped), for: .touchUpInside)
        self.mainView.huyDonHangButton.addTarget(self, action: #selector(self.huyDonHang), for: .touchUpInside)
        self.mainView.capNhatKhoangVayButton.addTarget(self, action: #selector(self.capNhatKhoanVayTapped), for: .touchUpInside)
    }
    
    private func bindingData(model:ThongTinDonHangMiraeEntity.DataChiTietDonHangModel){
        let view = self.mainView
        view.hotenKHResultLabel.text = model.customer?.fullName ?? ""
        view.cmndResultLabel.text = model.customer?.idCard ?? ""
        view.soDTResultLabel.text = model.customer?.phone ?? ""
        view.goiTraGopResultLabel.text = model.payment?.schemeName ?? ""
        view.laiSuatResultLabel.text = "\(model.payment?.interestRate ?? 0)%"
        view.kyHanResultLabel.text = "\(model.payment?.loanTenor ?? 0) tháng"
        view.thanhTienResultLabel.text = Common.convertCurrencyFloat(value: model.payment?.totalPrice ?? 0)
        view.soTienVayResultLabel.text = Common.convertCurrencyFloat(value: model.payment?.loanAmount ?? 0)
        view.soTienTraTruocResultLabel.text = Common.convertCurrencyFloat(value: model.payment?.downPayment ?? 0)
        view.phiBaoHiemResultLabel.text = Common.convertCurrencyFloat(value: model.payment?.insuranceFee ?? 0)
        view.giamGiaResultLabel.text = Common.convertCurrencyFloat(value: model.payment?.discount ?? 0)
        view.datCocResultLabel.text = Common.convertCurrencyFloat(value: model.payment?.otherDownPayment ?? 0)
        view.tongTienResultLabel.text = Common.convertCurrencyFloat(value: model.payment?.finalPrice ?? 0)
        Cache.soTienCocMirae = model.payment?.otherDownPayment ?? 0
        DispatchQueue.main.async {
//
//            view.datCocResultLabel.snp.updateConstraints { make in
//                make.height.equalTo(0)
//            }
//            view.datCocLabel.snp.updateConstraints { make in
//                make.height.equalTo(0)
//            }
            
            switch self.presenter?.lichSuModel?.statusCode {
            case "M","F","C":
                view.luuDonHangButton.isHidden = false
                view.luuDonHangButton.setTitle("UPLOAD CHỨNG TỪ VAY", for: .normal)
                view.huyDonHangButton.isEnabled = (model.buttons?.cancelBtn ?? false)
                view.luuDonHangButton.isEnabled = (model.buttons?.uploadWorkInfoAndImageBtn ?? false)
                view.thongTinKhachHangButton.isHidden = false
                view.huyDonHangButton.isHidden = false
//            case "C":
//                view.luuDonHangButton.isHidden = false
//                view.luuDonHangButton.setTitle("UPLOAD CHỨNG TỪ VAY", for: .normal)
//                view.huyDonHangButton.isEnabled = (model.buttons?.cancelBtn ?? false)
//                view.luuDonHangButton.isEnabled = (model.buttons?.uploadWorkInfoAndImageBtn ?? false)
//                view.thongTinKhachHangButton.isHidden = false
//                view.huyDonHangButton.isHidden = false
            case "D":
                view.capNhatKhoangVayButton.isEnabled = (model.buttons?.updateLoanInfoBtn ?? false)
                view.capNhatThongTinButton.isEnabled = (model.buttons?.updateCustomerInfoBtn ?? false)
                view.luuDonHangButton.isEnabled = (model.buttons?.updateImageBtn ?? false)
                view.thongTinKhachHangButton.isHidden = false
                view.huyDonHangButton.isHidden = false
                view.capNhatThongTinButton.snp.makeConstraints { make in
                    make.top.equalTo(self.mainView.tongTienResultLabel.snp.bottom).offset(10)
                    make.leading.equalTo(self.mainView.thongTinKHLabel)
                    make.trailing.equalTo(self.mainView.safeAreaLayoutGuide.snp.centerX).offset(-5)
                    make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
                }
                view.capNhatKhoangVayButton.snp.makeConstraints { make in
                    make.top.equalTo(self.mainView.tongTienResultLabel.snp.bottom).offset(10)
                    make.trailing.equalTo(self.mainView.thongTinKHLabel)
                    make.leading.equalTo(self.mainView.safeAreaLayoutGuide.snp.centerX).offset(5)
                    make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
                }
                view.luuDonHangButton.setTitle("CẬP NHẬT HÌNH ẢNH", for: .normal)
                view.luuDonHangButton.snp.remakeConstraints { make in
                    make.top.equalTo(self.mainView.capNhatKhoangVayButton.snp.bottom).offset(10)
                    make.leading.trailing.equalTo(self.mainView.thongTinKHLabel)
                    make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
                }
                view.huyDonHangButton.snp.remakeConstraints { make in
                    make.leading.equalTo(view.luuDonHangButton)
                    make.top.equalTo(view.luuDonHangButton.snp.bottom).offset(10)
                    make.trailing.equalTo(view.safeAreaLayoutGuide.snp.centerX).offset(-5)
                    make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
                }
                view.thongTinKhachHangButton.snp.remakeConstraints { make in
                    make.trailing.equalTo(view.luuDonHangButton)
                    make.top.equalTo(view.huyDonHangButton)
                    make.leading.equalTo(view.safeAreaLayoutGuide.snp.centerX).offset(5)
                    make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
                }
            default:
                break
            }
            view.donHangTableView.reloadData()
            view.khuyenMaiTableView.reloadData()
        }
        
    }
    
    //MARK:- Actions
    @objc private func luuDonHangTapped(){
        guard let presenter = presenter else {
            return
        }
        if presenter.isLichSu {
            if self.mainView.luuDonHangButton.titleLabel?.text == "UPLOAD CHỨNG TỪ VAY" {
                let vc = CapNhatChungTuMiraeRouter().configureVIPERCapNhatChungTuMirae()
                vc.presenter?.model = self.presenter?.lichSuModel
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if self.mainView.luuDonHangButton.titleLabel?.text == "CẬP NHẬT HÌNH ẢNH" {
                self.capNhatHinhAnhTapped()
            }
        }else {
            self.presenter?.sumitApplication()
        }
        
    }
    
    @objc private func capNhatKhoanVayTapped(){
        let vc = ThongTinDonHangMiraeRouter().configureVIPERThongTinDonHangMirae()
        vc.presenter?.appDocEntry = "\(self.presenter?.lichSuModel?.appDocEntry ?? 0)"
        vc.presenter?.isUpdate = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func huyDonHang(){
        let vc = PopupHuyDonHangMiraeViewController()
        vc.docEntry = "\(self.presenter?.lichSuModel?.appDocEntry ?? 0)"
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func capNhatHinhAnhTapped(){
        let vc = UpdateHinhAnhMiraeRouter().configureVIPERUpdateHinhAnhMirae()
        vc.presenter?.modelLichSu = self.presenter?.lichSuModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func capNhatThongTinKhachHangTapped(){
        let vc = ThongTinKhachHangMireaRouter().configureVIPERThongTinKhachHangMirea()
        vc.presenter?.isLichSu = true
        vc.presenter?.modelLichSu = self.presenter?.lichSuModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func thongTinKhachHangTapped(){
        let vc = ThongTinKhachHangMireaRouter().configureVIPERThongTinKhachHangMirea()
        vc.presenter?.isLichSu = true
        vc.presenter?.isReview = true
        vc.presenter?.modelLichSu = self.presenter?.lichSuModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ThongTinDonHangMiraeCompleteViewController : ThongTinDonHangMiraeCompletePresenterToViewProtocol {

    func didLoadThongTinDonHangFailed(message: String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo",
                                                    message: message,
                                                    titleButton: "OK",
                                                    viewController: self) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func didLuuDonHangSuccess(message:String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo",
                                                    message: message,
                                                    titleButton: "OK",
                                                    viewController: self) {
            let controllers : Array = self.navigationController!.viewControllers
            print("count Controller\(controllers.count)")
            self.navigationController?.popToViewController(controllers[1], animated: true)
        }
    }
    
    func didBidingDataCache(model: KhachHangMiraeModel) {
        
        let phiBH = (model.phiBaoHiem * model.soTienVay) / 100
        
		let tongTien = Double(model.tongTien) 
        
        let view = self.mainView
        view.hotenKHResultLabel.text = model.fullname
        view.cmndResultLabel.text = model.soCMND
        view.soDTResultLabel.text = model.soDienThoai
        view.goiTraGopResultLabel.text = model.tenGoiTraGop
        view.laiSuatResultLabel.text = "\(model.laiSuat)%"
        view.kyHanResultLabel.text = "\(model.kyHan) tháng"
        view.thanhTienResultLabel.text = Common.convertCurrencyFloat(value: model.thanhTien)
        view.soTienVayResultLabel.text = Common.convertCurrencyFloat(value: model.soTienVay)
        view.soTienTraTruocResultLabel.text = Common.convertCurrencyFloat(value: model.soTienTraTruoc)
        view.phiBaoHiemResultLabel.text = Common.convertCurrencyFloat(value: phiBH)
        view.giamGiaResultLabel.text = Common.convertCurrencyFloat(value: model.giamGia)
        view.datCocResultLabel.text = Common.convertCurrencyFloat(value: model.soTienCoc)
        view.tongTienResultLabel.text = Common.convertCurrencyDouble(value: tongTien)

    }
    
    func didLoadThongTinDonHangSuccess(model: ThongTinDonHangMiraeEntity.DataChiTietDonHangModel) {
        self.bindingData(model: model)
    }

    func outPutFailed(error: String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo",
                                                    message: error,
                                                    titleButton: "OK",
                                                    viewController: self) {
            
        }
    }
    
    func showLoading(message: String) {
        self.startLoading(message: message)
    }
    
    func hideLoading() {
        self.stopLoading()
    }
}

extension ThongTinDonHangMiraeCompleteViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.mainView.khuyenMaiTableView {
            return self.presenter?.khuyenMaiModel.count ?? 0
        } else if tableView == self.mainView.voucherTableView {
            return Cache.listVoucherNoPrice.count
        }else {
            return self.presenter?.sanPhamModel.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.mainView.khuyenMaiTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: Common.TraGopMirae.identifierTableViewCell.thongTinKhuyenMai, for: indexPath) as! ThongTinKhuyenMaiMiraeTableViewCell
            cell.selectionStyle = .none
            if self.presenter?.khuyenMaiModel.count ?? 0 > 1 {
                let totalRows = tableView.numberOfRows(inSection: indexPath.section)
                if indexPath.row == totalRows - 1 {
                    cell.isLast = true
                }
            }
            cell.model = self.presenter?.khuyenMaiModel[indexPath.row]
            cell.sttLabel.text = "\(indexPath.row + 1)"
            return cell
        } else if tableView == self.mainView.voucherTableView {
            let cell = ItemVoucherNoPriceTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemVoucherNoPriceTableViewCell")
            cell.selectionStyle = .none
            if Cache.listVoucherNoPrice.count > 0 {
                let item:VoucherNoPrice = Cache.listVoucherNoPrice[indexPath.row]
                cell.setup(so: item,indexNum: indexPath.row,readOnly:true)
            }
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Common.TraGopMirae.identifierTableViewCell.thongTinDonHang, for: indexPath) as! ThongTinDonHangMiraeCompleteTableViewCell
            cell.selectionStyle = .none
            if self.presenter?.sanPhamModel.count ?? 0 > 1 {
                let totalRows = tableView.numberOfRows(inSection: indexPath.section)
                if indexPath.row == totalRows - 1 {
                    cell.isLast = true
                }
            }
            cell.model = presenter?.sanPhamModel[indexPath.row]
            cell.sttLabel.text = "\(indexPath.row + 1)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.mainView.voucherTableView {
            return 150
        }
        return UITableView.automaticDimension
    }
}

extension ThongTinDonHangMiraeCompleteViewController : PopupHuyDonHangMiraeViewControllerDelegate {
    func cancelSuccess(){
        self.navigationController?.popViewController(animated: true)
    }
}
