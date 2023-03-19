//
//  UpdateGoiVayMiraeViewController.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class UpdateGoiVayMiraeViewController: BaseVC<UpdateGoiVayView> {
   
    //MARK:- Properties
    var presenter: UpdateGoiVayMiraePresenter?
    
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
    }
    
    private func configureNavigation(){
        self.configureNavigationBackItem(title: "THÔNG TIN ĐƠN HÀNG")
    }
    
    private func configureTableView(){
        self.mainView.donHangTableView.dataSource = self
        self.mainView.donHangTableView.delegate = self
        self.mainView.khuyenMaiTableView.dataSource = self
        self.mainView.khuyenMaiTableView.delegate = self
    }

    private func updateHeightScrollView(){
        let contentRect: CGRect = self.mainView.scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        self.mainView.scrollView.contentSize = contentRect.size
        view.layoutIfNeeded()
    }
    
    deinit {
        print("Denit UpdateGoiVayMiraeViewController is Success")
    }
    
    //MARK:- Configure
    private func configureButton(){
        self.mainView.luuDonHangButton.addTarget(self, action: #selector(self.luuDonHangTapped), for: .touchUpInside)
    }
    
    //MARK:- Actions
    @objc private func luuDonHangTapped(){
        guard let presenter = presenter else {
            return
        }
        presenter.updateGoiVay()
        
    }
    
}

extension UpdateGoiVayMiraeViewController : UpdateGoiVayMiraePresenterToViewProtocol {
    
    func didResubmitToMiraeSuccess(message: String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo", message: message, titleButton: "OK", viewController: self) {
            if self.presenter?.count == 0 {
                let controllers : Array = self.navigationController!.viewControllers
                self.navigationController?.popToViewController(controllers[1], animated: true)
            }else {
                let controllers : Array = self.navigationController!.viewControllers
                self.navigationController?.popToViewController(controllers[1], animated: true)
            }
        }
    }
    
    func didCapNhatKhoanVaySuccess(message: String) {
        self.showAlertMultiOption(title: "Thông Báo", message: message, options: "GỬI NHÀ TRẢ GÓP","TIẾP TỤC CẬP NHẬT", buttonAlignment: .horizontal) { index in
            if index == 1 {
                if self.presenter?.count == 0 {
                    let controllers : Array = self.navigationController!.viewControllers
                    self.navigationController?.popToViewController(controllers[1], animated: true)
                }else {
                    let controllers : Array = self.navigationController!.viewControllers
                    self.navigationController?.popToViewController(controllers[2], animated: true)
                }
            }else {
                self.presenter?.resubmitToMirae()
            }
        }
    }
    
    
    func outPutSuccess(data: String) {
        
    }
    
    func outPutFailed(error: String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo", message: error, titleButton: "OK", viewController: self) {
            
        }
    }
    
    func showLoading(message: String) {
        self.startLoading(message: message)
    }
    
    func hideLoading() {
        self.stopLoading()
    }
    
    func didBidingDataCache(model: KhachHangMiraeModel) {
        
        let soTienVay = model.soTienVay
        let phiBH = soTienVay * model.phiBaoHiem / 100
        
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
        view.tongTienResultLabel.text = Common.convertCurrencyFloat(value: model.tongTien)
    }
}

extension UpdateGoiVayMiraeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.mainView.khuyenMaiTableView {
            return self.presenter?.khuyenMaiModel.count ?? 0
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
        return UITableView.automaticDimension
    }
}
