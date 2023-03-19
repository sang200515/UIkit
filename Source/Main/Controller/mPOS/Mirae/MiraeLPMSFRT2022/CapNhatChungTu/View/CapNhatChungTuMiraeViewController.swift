//
//  CapNhatChungTuMiraeViewController.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit
import DropDown

class CapNhatChungTuMiraeViewController: BaseVC<CapNhatChungTuMiraeView> {
   
    //MARK:- Properties
    var presenter: CapNhatChungTuMiraePresenter?
    
    //MARK:- Create ComponentUI
    

    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBackItem(title: "CẬP NHẬT CHỨNG TỪ")
        self.confiureImageView()
        self.configureTextField()
        self.configureHeaderButton()
        self.configureDropDown()
        self.presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateHeightScrollView()
    }
    
    //MARK: - Configure
    private func configureHeaderButton(){
        self.mainView.thongTinCongViecButton.delegate = self
        self.mainView.hinhDinhKemButton.delegate = self
    }
    
    private func configureTextField(){
        self.mainView.thongTinCongViecView.tenCongTyTextField.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.mainView.thongTinCongViecView.thoiGianLamViecTextField.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.mainView.thongTinCongViecView.soThangLamViecTextField.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        self.mainView.thongTinCongViecView.soThangLamViecTextField.textField.delegate = self
        self.mainView.thongTinCongViecView.thoiGianLamViecTextField.textField.delegate = self
        self.mainView.thongTinCongViecView.chucVuTextField.delegate = self
        self.mainView.thongTinCongViecView.loaiHopDongTextField.delegate = self
        self.mainView.thongTinCongViecView.ngayDongDauTienTextField.delegate = self
        self.mainView.thongTinCongViecView.maNoiBoTextField.delegate = self
        self.mainView.hinhDinhKemView.loaiChungTuTextField.delegate = self
    }
    
    private func confiureImageView(){
        self.mainView.hinhDinhKemView.cmndMatTruocImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.hinhDinhKemView.cmndMatSauImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.hinhDinhKemView.chanDungImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.hinhDinhKemView.giayPhepLXMatTruocImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.hinhDinhKemView.giayPhepLXMatSauImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.hinhDinhKemView.uploadThemSoHoKhauButton.addTarget(self, action: #selector(self.uploadThemHinhHoKhauTapped), for: .touchUpInside)
        self.mainView.guiHoSoButton.addTarget(self, action: #selector(self.guiHoSoTapped), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK3ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK4ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK5ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK6ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK7ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK8ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK9ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK10ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK11ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK12ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK13ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK14ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK15ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK16ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK17ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK18ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK19ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        self.mainView.themHinhHKView.soHK20ImageView.addTarget(self, action: #selector(self.selectedTapped(sender:)), for: .touchUpInside)
        
    }
    
    private func configureDropDown(){
        self.mainView.dropDown = DropDown()
        self.mainView.dropDown?.direction = .bottom
        self.mainView.dropDown?.offsetFromWindowBottom = 20
    }
    
    private func updateHeightScrollView(){
        let contentRect: CGRect = self.mainView.scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        self.mainView.scrollView.contentSize = contentRect.size
        view.layoutIfNeeded()
    }
    
    deinit {
        print("Denit CapNhatChungTuMiraeViewController is Success")
    }
    
    
    //MARK: - Actions
    @objc private func uploadThemHinhHoKhauTapped(){
        let view = self.mainView
        if view.themHinhHKView.isHidden == true {
            view.themHinhHKView.snp.updateConstraints { make in
                make.height.equalTo(1440)
            }
            view.themHinhHKView.isHidden = false
        }else {
            view.themHinhHKView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            view.themHinhHKView.isHidden = true
        }
    }
    
    @objc func selectedTapped(sender: UIButton) {
        /* Tag hình ảnh
         0 - CMND Mặt trước
         1 - CMND Mặt sau
         2 - Chân dung khách hàng
         3 - Giấy phép lái xe mặt trước
         4 - Giấy phép lái xe mặt sau
         */
      
        /* FileID :
             1: cmnd-front
             2: cmnd-back
             3: customer photo
             4: DL-front(DL: giấy phép lái xe)
             5: DL-back
             6-14: FB(sổ hộ khẩu)
         */
        ImagePickerManager().pickImage(isCamera: true, self) { [weak self] image in
            guard let self = self else { return }
            guard let imageData: Data = image.jpegData(compressionQuality: 0.8) else {
                self.outPutFailed(error: "Lỗi hình. Hãy thử chụp lại")
                return
            }
            let base64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
            var fileID:Int = 0
            DispatchQueue.main.async {
                fileID = sender.tag
                self.presenter?.uploadHinhHoSo(base64: base64, fileId: fileID, image:image)
            }
        }
    }
    
    @objc private func guiHoSoTapped(){
        self.presenter?.updateThongTinCongViec()
    }
    
    func selectedType(){
        if self.presenter?.codeLoaiChungTu == "FB" {
            self.mainView.hinhDinhKemView.giayPhepLXLabel.text = "SỔ HỘ KHẨU (*)"
            self.mainView.hinhDinhKemView.giayPhepLXMatTruocImageView.tag = 6
            self.mainView.hinhDinhKemView.giayPhepLXMatSauImageView.tag = 7
            self.mainView.hinhDinhKemView.uploadThemSoHoKhauButton.isHidden = false
        }else {
            self.mainView.hinhDinhKemView.giayPhepLXLabel.text = "GIẤY PHÉP LÁI XE (*)"
            self.mainView.hinhDinhKemView.giayPhepLXMatTruocImageView.tag = 4
            self.mainView.hinhDinhKemView.giayPhepLXMatSauImageView.tag = 5
            self.mainView.hinhDinhKemView.uploadThemSoHoKhauButton.isHidden = true
        }
    }
    
}

extension CapNhatChungTuMiraeViewController : CapNhatChungTuMiraePresenterToViewProtocol {
    
    func didUploadCapNhatChungTuSuccess(message:String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo",
                                                    message: message,
                                                    titleButton: "OK",
                                                    viewController: self) {
            let controllers : Array = self.navigationController!.viewControllers
            self.navigationController?.popToViewController(controllers[1], animated: true)
        }
    }
    
    func didUploadHinhSuccess(message:String,tag:Int,image:UIImage) {
//        AlertManager.shared.alertWithViewController(title: "Thông báo", message: message, titleButton: "Đồng ý", viewController: self) {
            switch tag {
            case 1:
                self.mainView.hinhDinhKemView.cmndMatTruocImageView.imageSet = image
            case 2:
                self.mainView.hinhDinhKemView.cmndMatSauImageView.imageSet = image
            case 3:
                self.mainView.hinhDinhKemView.chanDungImageView.imageSet = image
            case 4,6:
                self.mainView.hinhDinhKemView.giayPhepLXMatTruocImageView.imageSet = image
            case 5,7:
                self.mainView.hinhDinhKemView.giayPhepLXMatSauImageView.imageSet = image
            case 8:
                self.mainView.themHinhHKView.soHK3ImageView.imageSet = image
            case 9:
                self.mainView.themHinhHKView.soHK4ImageView.imageSet = image
            case 10:
                self.mainView.themHinhHKView.soHK5ImageView.imageSet = image
            case 11:
                self.mainView.themHinhHKView.soHK6ImageView.imageSet = image
            case 12:
                self.mainView.themHinhHKView.soHK7ImageView.imageSet = image
            case 13:
                self.mainView.themHinhHKView.soHK8ImageView.imageSet = image
            case 14:
                self.mainView.themHinhHKView.soHK9ImageView.imageSet = image
            case 15:
                self.mainView.themHinhHKView.soHK10ImageView.imageSet = image
            case 16:
                self.mainView.themHinhHKView.soHK11ImageView.imageSet = image
            case 17:
                self.mainView.themHinhHKView.soHK12ImageView.imageSet = image
            case 18:
                self.mainView.themHinhHKView.soHK13ImageView.imageSet = image
            case 19:
                self.mainView.themHinhHKView.soHK14ImageView.imageSet = image
            case 20:
                self.mainView.themHinhHKView.soHK15ImageView.imageSet = image
            case 21:
                self.mainView.themHinhHKView.soHK16ImageView.imageSet = image
            case 22:
                self.mainView.themHinhHKView.soHK17ImageView.imageSet = image
            case 23:
                self.mainView.themHinhHKView.soHK18ImageView.imageSet = image
            case 24:
                self.mainView.themHinhHKView.soHK19ImageView.imageSet = image
            case 25:
                self.mainView.themHinhHKView.soHK20ImageView.imageSet = image
            default:
                break
            }
//        }
    }
    
    func outPutSuccess(data: String) {
        
    }
    
    func outPutFailed(error: String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo", message: error, titleButton: "Đồng ý", viewController: self) {
            self.hideLoading()
        }
    }
    
    func showLoading(message: String) {
        self.startLoading(message: message)
    }
    
    func hideLoading() {
        self.stopLoading()
    }
}

extension CapNhatChungTuMiraeViewController : InputInfoTextFieldDelegate {
    func didSelected(index: Int) {
        // 8 - Chức vụ
        // 9 - Loại hợp đồng
        // 10 - Ngày đóng tiền đầu tiên
        // 11 - Mã nội bộ
        // 4 - Loại chứng từ
        switch index {
        case 8:
            self.mainView.dropDown?.anchorView = self.mainView.thongTinCongViecView.chucVuTextField
            self.mainView.dropDown?.bottomOffset = CGPoint(x: 0, y:(self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            self.mainView.dropDown?.dataSource = self.presenter?.modelChucVu.map({ item in
                return item.value ?? ""
            }) ?? []
            self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
                self.mainView.thongTinCongViecView.chucVuTextField.textField.text = item
                self.presenter?.modelWorkInfo[1].value = item
            }
        case 9:
            self.mainView.dropDown?.anchorView = self.mainView.thongTinCongViecView.loaiHopDongTextField
            self.mainView.dropDown?.bottomOffset = CGPoint(x: 0, y:(self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            self.mainView.dropDown?.dataSource = self.presenter?.modelLoaiHopDong.map({ item in
                return item.value ?? ""
            }) ?? []
            self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
                self.mainView.thongTinCongViecView.loaiHopDongTextField.textField.text = item
                self.presenter?.modelWorkInfo[2].value = item
            }
        case 10:
            self.mainView.dropDown?.anchorView = self.mainView.thongTinCongViecView.ngayDongDauTienTextField
            self.mainView.dropDown?.bottomOffset = CGPoint(x: 0, y:(self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            self.mainView.dropDown?.dataSource = self.presenter?.modelNgayThanhToan.map({ item in
                return item.name ?? ""
            }) ?? []
            self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
                self.mainView.thongTinCongViecView.ngayDongDauTienTextField.textField.text = item
                self.presenter?.modelWorkInfo[5].value = item
            }
        case 11:
            self.mainView.dropDown?.anchorView = self.mainView.thongTinCongViecView.maNoiBoTextField
            self.mainView.dropDown?.bottomOffset = CGPoint(x: 0, y:(self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            self.mainView.dropDown?.dataSource = self.presenter?.modelMaNoiBo.map({ item in
                return item.value ?? ""
            }) ?? []
            self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
                self.mainView.thongTinCongViecView.maNoiBoTextField.textField.text = item
                self.presenter?.modelWorkInfo[6].value = item
            }
        case 4:
            self.mainView.dropDown?.anchorView = self.mainView.hinhDinhKemView.loaiChungTuTextField
            self.mainView.dropDown?.bottomOffset = CGPoint(x: 0, y:(self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            self.mainView.dropDown?.dataSource = self.presenter?.modelLoaiChungTu.map({ item in
                return item.name ?? ""
            }) ?? []
            self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
                self.mainView.hinhDinhKemView.loaiChungTuTextField.textField.text = item
                self.presenter?.codeLoaiChungTu = self.presenter?.modelLoaiChungTu[index].code ?? ""
                self.selectedType()
            }
        default:
            break
        }
        self.mainView.dropDown?.show()
    }

    func didLoadInfoCore(model:MasterDataInstallMent){
        let view = self.mainView
        view.thongTinCongViecView.chucVuTextField.textField.text = model.company?.position ?? ""
        view.thongTinCongViecView.tenCongTyTextField.textField.text = model.company?.companyName ?? ""
        view.thongTinCongViecView.thoiGianLamViecTextField.textField.text = "\(model.company?.workYear ?? 0)"
        view.thongTinCongViecView.soThangLamViecTextField.textField.text = "\(model.company?.workMonth ?? 0)"
        
        self.presenter?.modelWorkInfo[1].value = model.company?.position ?? ""
        self.presenter?.modelWorkInfo[0].value = model.company?.companyName ?? ""
        self.presenter?.modelWorkInfo[3].value = "\(model.company?.workYear ?? 0)"
        self.presenter?.modelWorkInfo[4].value = "\(model.company?.workMonth ?? 0)"
        
        if model.relatedDocType == "DL" {
            view.hinhDinhKemView.loaiChungTuTextField.textField.text = " Giấy phép lái xe"
        }else {
            view.hinhDinhKemView.loaiChungTuTextField.textField.text = "Sổ hộ khẩu"
        }
        self.presenter?.codeLoaiChungTu = model.relatedDocType ?? "DL"
        self.selectedType()
    }
}

extension CapNhatChungTuMiraeViewController : HeaderInfoDelegate {
    func onClickHeader(headerView: UIView) {
        let view = self.mainView
        if headerView == self.mainView.thongTinCongViecButton {
            if view.thongTinCongViecView.isHidden == true {
                view.thongTinCongViecView.snp.updateConstraints { make in
                    make.height.equalTo(436)
                }
                view.thongTinCongViecView.isHidden = false
            }else {
                view.thongTinCongViecView.snp.updateConstraints { make in
                    make.height.equalTo(0)
                }
                view.thongTinCongViecView.isHidden = true
            }
        }
        if headerView == self.mainView.hinhDinhKemButton {
            if view.hinhDinhKemView.isHidden == true {
                view.hinhDinhKemView.snp.updateConstraints { make in
                    make.height.equalTo(858)
                }
                view.hinhDinhKemView.isHidden = false
            }else {
                view.hinhDinhKemView.snp.updateConstraints { make in
                    make.height.equalTo(0)
                }
                view.hinhDinhKemView.isHidden = true
            }
        }
    }
}

extension CapNhatChungTuMiraeViewController : UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == self.mainView.thongTinCongViecView.tenCongTyTextField.textField {
            self.presenter?.modelWorkInfo[0].value = textField.text ?? ""
        }
        if textField == self.mainView.thongTinCongViecView.thoiGianLamViecTextField.textField {
            self.presenter?.modelWorkInfo[3].value = textField.text ?? ""
        }
        if textField == self.mainView.thongTinCongViecView.soThangLamViecTextField.textField {
            self.presenter?.modelWorkInfo[4].value = textField.text ?? ""
        }
    }
}
