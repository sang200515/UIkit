    //
    //  ThongTinKhachHangMireaViewController.swift
    //
    //  Created by Trần Văn Dũng 07/10/2021.
    // VIPER Template
    //

import DropDown
import IQKeyboardManagerSwift
import KeychainSwift
import UIKit

class ThongTinKhachHangMireaViewController: BaseVC<ThongTinKhachHangMireaView> {

        //MARK: - Properties
    var presenter: ThongTinKhachHangMireaPresenter?
    let datePicker = UIDatePicker()
    var amountTypedString: String = "0"

        // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.bindingData()
        self.configureView()
        self.configureNavigationBackItem(title: "THÔNG TIN KHÁCH HÀNG")
        self.configureButton()
        self.configureDropDown()
        self.configureTextField()
        self.showDatePicker(textField: self.mainView.viewThongTinKhachHang.ngayCapTextField.textField)
        self.showDatePicker(textField: self.mainView.viewThongTinKhachHang.ngaySinhTextField.textField)
        self.title = "TRẢ GÓP MIRAE ASSET"
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 100
    }

    deinit {
        print("Denit ThongTinKhachHangMireaViewController is Success")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateHeightScrollView()
    }

        //MARK: - Configure
    private func configureDropDown() {
        self.mainView.dropDown = DropDown()
        self.mainView.dropDown?.direction = .bottom
        self.mainView.dropDown?.offsetFromWindowBottom = 20
    }

    private func configureTextField() {
        self.mainView.viewThongTinCongViec.tenCongTyTextField.textField.addTarget(
            self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        self.mainView.viewThongTinCongViec.thoiGianLamViecTextField.textField.addTarget(
            self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        self.mainView.viewThongTinCongViec.soThangLamViecTextField.textField.addTarget(
            self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        self.mainView.viewThongTinKhachHang.noiCapTextField.textField.addTarget(
            self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        self.mainView.viewTamTruKhachHang.tinhTextField.textField.addTarget(
            self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        self.mainView.viewThuongTruKhachHang.tinhTextField.textField.addTarget(
            self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        self.mainView.viewThongTinKhachHang.thuNhapTextField.textField.addTarget(
            self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }

    private func configureView() {
        self.mainView.scrollView.delegate = self
        self.mainView.thongTinThamChieuButton.delegate = self
        self.mainView.thongTinKhachHangButton.delegate = self
        self.mainView.thongTinThuongTruButton.delegate = self
        self.mainView.thongTinTamTruButton.delegate = self
        self.mainView.viewThongTinKhachHang.thuNhapTextField.textField.delegate = self
        self.mainView.viewThongTinKhachHang.ngaySinhTextField.textField.delegate = self
        self.mainView.viewThongTinKhachHang.ngayCapTextField.textField.delegate = self
        self.mainView.viewThongTinKhachHang.noiCapTextField.textField.delegate = self
        self.mainView.viewThuongTruKhachHang.tinhTextField.textField.delegate = self
        self.mainView.viewTamTruKhachHang.tinhTextField.textField.delegate = self
        self.mainView.viewThuongTruKhachHang.huyenTextField.delegate = self
        self.mainView.viewTamTruKhachHang.huyenTextField.delegate = self
        self.mainView.viewThuongTruKhachHang.xaTextField.delegate = self
        self.mainView.viewTamTruKhachHang.xaTextField.delegate = self
        self.mainView.viewThongTinKhachHang.gioiTinhNamButton.delegate = self
        self.mainView.viewThongTinKhachHang.gioiTinhNuButton.delegate = self
        self.mainView.viewThamChieuKhachHang.moiQuanHeTextField.delegate = self
        self.mainView.viewThamChieuKhachHang.moiQuanHe2TextField.delegate = self
    }

    private func configureButton() {
        self.mainView.diaChiButton.addTarget(self, action: #selector(self.checkBoxTapped), for: .touchUpInside)
        self.mainView.taoHoSoButton.addTarget(
            self, action: #selector(self.checkHoSoKhachHang), for: .touchUpInside)
    }

    private func updateHeightScrollView() {
        let contentRect: CGRect = self.mainView.scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        self.mainView.scrollView.contentSize = contentRect.size
        view.layoutIfNeeded()
    }

    private func bindingData() {
        if self.presenter?.isCore ?? false {
                //data frome core
            guard let model = self.presenter?.detailDataMapping else { return }
            ShinhanData.IS_RUNNING = false
            for i in model.addresses! {
                if i.addressType == 1 {
                    self.presenter?.modelDiaChi.codeTinhThuongTru =
                    model.addresses?[0].insHouseProvice?.miraeCode ?? ""
                    self.presenter?.modelDiaChi.codeHuyenThuongTru =
                    model.addresses?[0].insHouseDistrict?.miraeCode ?? ""
                    self.presenter?.modelDiaChi.codeXaThuongTru =
                    model.addresses?[0].insHouseWard?.miraeCode ?? ""
                } else {
                    self.presenter?.modelDiaChi.codeTinhTamTru =
                    model.addresses?[1].insHouseProvice?.miraeCode ?? ""
                    self.presenter?.modelDiaChi.codeHuyenTamTru =
                    model.addresses?[1].insHouseDistrict?.miraeCode ?? ""
                    self.presenter?.modelDiaChi.codeXaTamTru =
                    model.addresses?[1].insHouseWard?.miraeCode ?? ""

                }

            }
            self.presenter?.modelDiaChi.gioiTinh = model.gender == 1 ? "M" : "F"
            self.mainView.viewThongTinKhachHang.tenKHTextField.textField.text = model.fullName
            self.mainView.viewThongTinKhachHang.ngayCapTextField.textField.text = model.idCardIssuedDate
            self.mainView.viewThongTinKhachHang.noiCapTextField.textField.text = model.idCardIssued?.idCardIssuedBy
            self.mainView.viewThongTinKhachHang.hoKHTextField.textField.text = model.lastName
            self.mainView.viewThongTinKhachHang.tenLotTextField.textField.text = model.middleName
            self.mainView.viewThongTinKhachHang.tenKHTextField.textField.text = model.firstName
            self.mainView.viewThongTinKhachHang.ngaySinhTextField.textField.text = model.birthDate
            self.mainView.viewThongTinKhachHang.cmndTextField.textField.text = model.idCard
            self.mainView.viewThongTinKhachHang.soDTTextField.textField.text = model.phone
            let thuNhap: Double = model.company?.income ?? 0
            self.mainView.viewThongTinKhachHang.thuNhapTextField.currencyTextField.text =
            Common.convertCurrencyDouble(value: thuNhap).replace(",", withString: ".")
                .trimAllSpace()
            self.mainView.viewThongTinKhachHang.gioiTinhNamButton.setSelect(
                isSelect: self.presenter?.modelDiaChi.gioiTinh == "M" ? true : false)
            self.mainView.viewThongTinKhachHang.gioiTinhNuButton.setSelect(
                isSelect: self.presenter?.modelDiaChi.gioiTinh == "M" ? false : true)
            self.mainView.viewThuongTruKhachHang.tinhTextField.textField.text =
            model.addresses?[0].provinceName
            self.mainView.viewThuongTruKhachHang.huyenTextField.textField.text =
            model.addresses?[0].districtName
            self.mainView.viewThuongTruKhachHang.xaTextField.textField.text = model.addresses?[0].wardName
            self.mainView.viewThuongTruKhachHang.duongTextField.textField.text =
            "\( (model.addresses?[0].houseNo ?? "") + (model.addresses?[0].street ?? "") )"

            self.mainView.viewTamTruKhachHang.tinhTextField.textField.text =
            model.addresses?[1].provinceName
            self.mainView.viewTamTruKhachHang.huyenTextField.textField.text =
            model.addresses?[1].districtName
            self.mainView.viewTamTruKhachHang.xaTextField.textField.text = model.addresses?[1].wardName
            self.mainView.viewTamTruKhachHang.duongTextField.textField.text =
            "\( (model.addresses?[1].houseNo ?? "") + (model.addresses?[1].street ?? "") )"

            self.mainView.viewThamChieuKhachHang.hoTenTextField.textField.text =
            model.refPersons?[0].fullName
            self.mainView.viewThamChieuKhachHang.moiQuanHeTextField.textField.text =
            model.refPersons?[0].relationshipName
            self.mainView.viewThamChieuKhachHang.soDTTextField.textField.text = model.refPersons?[0].phone
            self.mainView.viewThamChieuKhachHang.hoTen2TextField.textField.text =
            model.refPersons?[1].fullName
            self.mainView.viewThamChieuKhachHang.moiQuanHe2TextField.textField.text =
            model.refPersons?[1].relationshipName
            self.mainView.viewThamChieuKhachHang.soDT2TextField.textField.text = model.refPersons?[1].phone

            self.mainView.viewThongTinCongViec.chucVuTextField.delegate = self
            self.mainView.viewThongTinCongViec.loaiHopDongTextField.delegate = self
            self.mainView.viewThongTinCongViec.ngayDongDauTienTextField.delegate = self
            self.mainView.viewThongTinCongViec.maNoiBoTextField.delegate = self

            self.mainView.viewThongTinCongViec.tenCongTyTextField.textField.text =
            model.company?.companyName
            self.mainView.viewThongTinCongViec.chucVuTextField.textField.text = model.company?.position
            self.mainView.viewThongTinCongViec.thoiGianLamViecTextField.textField.text =
            "\(model.company?.workYear ?? 0)"
            self.mainView.viewThongTinCongViec.soThangLamViecTextField.textField.text =
            "\(model.company?.workMonth ?? 0)"
                //            self.mainView.viewThongTinCongViec.loaiHopDongTextField.textField.text = ""
                //            self.mainView.viewThongTinCongViec.ngayDongDauTienTextField.textField.text = "chon ngay tt dau tien"
                //            self.mainView.viewThongTinCongViec.maNoiBoTextField.textField.text = "0"
        } else {
            self.presenter?.modelDiaChi.gioiTinh = self.presenter?.model?.customerInfo?.sex ?? ""
            self.mainView.viewThongTinKhachHang.tenKHTextField.textField.text =
            "\(self.presenter?.model?.customerInfo?.fName ?? "") \(self.presenter?.model?.customerInfo?.mName ?? "") \(self.presenter?.model?.customerInfo?.lName ?? "")"
            self.mainView.viewThongTinKhachHang.ngayCapTextField.textField.text =
            self.presenter?.model?.customerInfo?.idIssuedDate ?? ""
            self.mainView.viewThongTinKhachHang.noiCapTextField.textField.text =
            self.presenter?.model?.customerInfo?.idIssuedBy ?? ""
            self.mainView.viewThongTinKhachHang.hoKHTextField.textField.text =
            self.presenter?.model?.customerInfo?.lName ?? ""
            self.mainView.viewThongTinKhachHang.tenLotTextField.textField.text =
            self.presenter?.model?.customerInfo?.mName ?? ""
            self.mainView.viewThongTinKhachHang.tenKHTextField.textField.text =
            self.presenter?.model?.customerInfo?.fName ?? ""
            self.mainView.viewThongTinKhachHang.ngaySinhTextField.textField.text =
            self.presenter?.model?.customerInfo?.dob ?? ""
            self.mainView.viewThongTinKhachHang.cmndTextField.textField.text =
            self.presenter?.model?.customerInfo?.nationalID ?? ""
            self.mainView.viewThongTinKhachHang.soDTTextField.textField.text =
            self.presenter?.model?.customerInfo?.mobile ?? ""
            let thuNhap: Double = Double(self.presenter?.model?.customerInfo?.empSalary ?? "0") ?? 0
            self.mainView.viewThongTinKhachHang.thuNhapTextField.currencyTextField.text =
            Common.convertCurrencyDouble(value: thuNhap).replace(",", withString: ".")
                .trimAllSpace()
            self.mainView.viewThongTinKhachHang.gioiTinhNamButton.setSelect(
                isSelect: self.presenter?.model?.customerInfo?.sex == "M" ? true : false)
            self.mainView.viewThongTinKhachHang.gioiTinhNuButton.setSelect(
                isSelect: self.presenter?.model?.customerInfo?.sex == "M" ? false : true)
            self.mainView.viewThuongTruKhachHang.tinhTextField.textField.text =
            self.presenter?.model?.permanentAddress?.cityName ?? ""
            self.mainView.viewThuongTruKhachHang.huyenTextField.textField.text =
            self.presenter?.model?.permanentAddress?.districtName ?? ""
            self.mainView.viewThuongTruKhachHang.xaTextField.textField.text =
            self.presenter?.model?.permanentAddress?.wardName ?? ""
            self.mainView.viewThuongTruKhachHang.duongTextField.textField.text =
            self.presenter?.model?.permanentAddress?.street ?? ""

            self.mainView.viewTamTruKhachHang.tinhTextField.textField.text =
            self.presenter?.model?.residenceAddress?.cityName ?? ""
            self.mainView.viewTamTruKhachHang.huyenTextField.textField.text =
            self.presenter?.model?.residenceAddress?.districtName ?? ""
            self.mainView.viewTamTruKhachHang.xaTextField.textField.text =
            self.presenter?.model?.residenceAddress?.wardName ?? ""
            self.mainView.viewTamTruKhachHang.duongTextField.textField.text =
            self.presenter?.model?.residenceAddress?.street ?? ""

            self.mainView.viewThamChieuKhachHang.hoTenTextField.textField.text =
            self.presenter?.model?.refPerson1?.fullName ?? ""
            self.mainView.viewThamChieuKhachHang.moiQuanHeTextField.textField.text =
            self.presenter?.model?.refPerson1?.relationship ?? ""
            self.mainView.viewThamChieuKhachHang.soDTTextField.textField.text =
            self.presenter?.model?.refPerson1?.phone ?? ""

            self.mainView.viewThamChieuKhachHang.hoTen2TextField.textField.text =
            self.presenter?.model?.refPerson2?.fullName ?? ""
            self.mainView.viewThamChieuKhachHang.moiQuanHe2TextField.textField.text =
            self.presenter?.model?.refPerson2?.relationship ?? ""
            self.mainView.viewThamChieuKhachHang.soDT2TextField.textField.text =
            self.presenter?.model?.refPerson2?.phone ?? ""

            if self.presenter?.isLichSu ?? false {
                self.disableInterface()
                self.mainView.diaChiButton.isChecked =
                self.presenter?.model?.residenceAddress?.samePerResAddress ?? false
                if self.mainView.diaChiButton.isChecked == true {
                    self.mainView.viewTamTruKhachHang.isUserInteractionEnabled = false
                } else {
                    self.mainView.viewTamTruKhachHang.isUserInteractionEnabled = true
                }
                self.presenter?.model?.editableField?.forEach({ item in
                    if item.fieldID == 1 {
                        self.mainView.viewThongTinKhachHang.isUserInteractionEnabled = true
                        self.mainView.diaChiButton.isUserInteractionEnabled = true
                        self.mainView.viewThuongTruKhachHang.isUserInteractionEnabled = true
                        self.mainView.viewTamTruKhachHang.isUserInteractionEnabled = true
                        self.mainView.viewThamChieuKhachHang.isUserInteractionEnabled = true
                        self.mainView.viewThongTinCongViec.isUserInteractionEnabled = false
                    }
                    if item.fieldID == 8 {
                        self.mainView.viewThongTinKhachHang.isUserInteractionEnabled = false
                        self.mainView.diaChiButton.isUserInteractionEnabled = false
                        self.mainView.viewThuongTruKhachHang.isUserInteractionEnabled = false
                        self.mainView.viewTamTruKhachHang.isUserInteractionEnabled = false
                        self.mainView.viewThamChieuKhachHang.isUserInteractionEnabled = false
                        self.mainView.viewThongTinCongViec.isUserInteractionEnabled = true
                    }

                    if item.fieldID == 1 && item.fieldID == 8 {
                        self.mainView.viewThongTinKhachHang.isUserInteractionEnabled = true
                        self.mainView.diaChiButton.isUserInteractionEnabled = true
                        self.mainView.viewThuongTruKhachHang.isUserInteractionEnabled = true
                        self.mainView.viewTamTruKhachHang.isUserInteractionEnabled = true
                        self.mainView.viewThamChieuKhachHang.isUserInteractionEnabled = true
                        self.mainView.viewThongTinCongViec.isUserInteractionEnabled = true
                    }
                })
                self.mainView.viewThongTinCongViec.chucVuTextField.delegate = self
                self.mainView.viewThongTinCongViec.loaiHopDongTextField.delegate = self
                self.mainView.viewThongTinCongViec.ngayDongDauTienTextField.delegate = self
                self.mainView.viewThongTinCongViec.maNoiBoTextField.delegate = self

                self.mainView.viewThongTinCongViec.tenCongTyTextField.textField.text =
                self.presenter?.model?.workInfo?.companyName ?? ""
                self.mainView.viewThongTinCongViec.chucVuTextField.textField.text =
                self.presenter?.model?.workInfo?.position ?? ""
                self.mainView.viewThongTinCongViec.loaiHopDongTextField.textField.text =
                self.presenter?.model?.workInfo?.laborContractType ?? ""
                self.mainView.viewThongTinCongViec.thoiGianLamViecTextField.textField.text =
                "\(self.presenter?.model?.workInfo?.yearWorkNum ?? 0)"
                self.mainView.viewThongTinCongViec.soThangLamViecTextField.textField.text =
                "\(self.presenter?.model?.workInfo?.monthWorkNum ?? 0)"
                self.mainView.viewThongTinCongViec.ngayDongDauTienTextField.textField.text =
                self.presenter?.model?.workInfo?.firstPaymentDate ?? ""
                self.mainView.viewThongTinCongViec.maNoiBoTextField.textField.text =
                self.presenter?.model?.workInfo?.internalCode ?? ""

                let view = self.mainView
                view.taoHoSoButton.setTitle("CẬP NHẬT HỒ SƠ", for: .normal)
                view.viewThongTinCongViec.isHidden = false

                view.thongTinCongViecButton.snp.makeConstraints { make in
                    make.top.equalTo(view.viewThamChieuKhachHang.snp.bottom).offset(10)
                    make.leading.equalTo(view.viewThamChieuKhachHang)
                    make.trailing.equalTo(view.viewThamChieuKhachHang)
                    make.height.equalTo(40)
                }
                view.viewThongTinCongViec.snp.makeConstraints { make in
                    make.top.equalTo(view.thongTinCongViecButton.snp.bottom).offset(10)
                    make.leading.equalTo(view.viewThamChieuKhachHang)
                    make.trailing.equalTo(view.viewThamChieuKhachHang)
                    make.height.equalTo(446)
                }
                view.taoHoSoButton.snp.remakeConstraints { make in
                    make.top.equalTo(view.viewThongTinCongViec.snp.bottom).offset(20)
                    make.leading.equalTo(view.viewThongTinCongViec)
                    make.trailing.equalTo(view.viewThongTinCongViec)
                    make.height.equalTo(Common.TraGopMirae.Padding.heightButton)
                }
                view.viewBottom.snp.makeConstraints { make in
                    make.top.equalTo(view.taoHoSoButton.snp.bottom).offset(20)
                    make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
                    make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
                    make.height.equalTo(20)
                    make.bottom.equalToSuperview()
                }
                if self.presenter?.isReview ?? false {
                    self.disableInterface()
                    view.taoHoSoButton.snp.updateConstraints { make in
                        make.height.equalTo(0)
                    }
                }
            }

        }

    }

    private func disableInterface() {
        self.mainView.viewThongTinKhachHang.isUserInteractionEnabled = false
        self.mainView.viewThuongTruKhachHang.isUserInteractionEnabled = false
        self.mainView.viewTamTruKhachHang.isUserInteractionEnabled = false
        self.mainView.viewThamChieuKhachHang.isUserInteractionEnabled = false
        self.mainView.viewThongTinCongViec.isUserInteractionEnabled = false
        self.mainView.diaChiButton.isUserInteractionEnabled = false
    }

        //MARK: - Actions
    private func showHideViewThongTinKH() {
        if !self.mainView.viewThongTinKhachHang.isHidden {
            self.mainView.viewThongTinKhachHang.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            self.mainView.viewThongTinKhachHang.isHidden = true
        } else {
            self.mainView.viewThongTinKhachHang.snp.updateConstraints { make in
                make.height.equalTo(680)
            }
            self.mainView.viewThongTinKhachHang.isHidden = false
        }
    }

    private func showHideViewThuongTru() {
        if !self.mainView.viewThuongTruKhachHang.isHidden {
            self.mainView.viewThuongTruKhachHang.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            self.mainView.viewThuongTruKhachHang.isHidden = true
        } else {
            self.mainView.viewThuongTruKhachHang.snp.updateConstraints { make in
                make.height.equalTo(270)
            }
            self.mainView.viewThuongTruKhachHang.isHidden = false
        }
    }

    private func showHideViewTamTru() {
        if !self.mainView.viewTamTruKhachHang.isHidden {
            self.mainView.viewTamTruKhachHang.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            self.mainView.viewTamTruKhachHang.isHidden = true
        } else {
            self.mainView.viewTamTruKhachHang.snp.updateConstraints { make in
                make.height.equalTo(270)
            }
            self.mainView.viewTamTruKhachHang.isHidden = false
        }
    }

    private func showHideViewThamChieu() {
        if !self.mainView.viewThamChieuKhachHang.isHidden {
            self.mainView.viewThamChieuKhachHang.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            self.mainView.viewThamChieuKhachHang.isHidden = true
        } else {
            self.mainView.viewThamChieuKhachHang.snp.updateConstraints { make in
                make.height.equalTo(408)
            }
            self.mainView.viewThamChieuKhachHang.isHidden = false
        }
    }

    @objc private func checkBoxTapped() {
        let button = self.mainView.diaChiButton
        if button.isChecked {
            self.mainView.viewTamTruKhachHang.isUserInteractionEnabled = false
            self.mainView.viewTamTruKhachHang.tinhTextField.textField.text =
            self.mainView.viewThuongTruKhachHang.tinhTextField.textField.text
            self.mainView.viewTamTruKhachHang.huyenTextField.textField.text =
            self.mainView.viewThuongTruKhachHang.huyenTextField.textField.text
            self.mainView.viewTamTruKhachHang.xaTextField.textField.text =
            self.mainView.viewThuongTruKhachHang.xaTextField.textField.text
            self.mainView.viewTamTruKhachHang.duongTextField.textField.text =
            self.mainView.viewThuongTruKhachHang.duongTextField.textField.text
        } else {
            self.mainView.viewTamTruKhachHang.isUserInteractionEnabled = true
            self.mainView.viewTamTruKhachHang.tinhTextField.textField.text = ""
            self.mainView.viewTamTruKhachHang.huyenTextField.textField.text = ""
            self.mainView.viewTamTruKhachHang.xaTextField.textField.text = ""
            self.mainView.viewTamTruKhachHang.duongTextField.textField.text = ""
        }
    }

    @objc private func checkHoSoKhachHang() {
        if let soCMND = self.mainView.viewThongTinKhachHang.cmndTextField.textField.text {
            if soCMND.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThongTinKhachHang.cmndTextField.textField)
                self.outPutFailed(error: "Vui lòng nhập số CMND/CCCD")
                return
            }
        }
        if let ngayCap = self.mainView.viewThongTinKhachHang.ngayCapTextField.textField.text {
            if ngayCap.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThongTinKhachHang.ngayCapTextField.textField)
                self.outPutFailed(error: "Vui lòng nhập ngày cấp CMND/CCCD")
                return
            }
        }
        if let noiCap = self.mainView.viewThongTinKhachHang.noiCapTextField.textField.text {
            if noiCap.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThongTinKhachHang.noiCapTextField.textField)
                self.outPutFailed(error: "Vui lòng chọn nơi cấp CMND/CCCD")
                return
            }
        }
        if self.presenter?.modelDiaChi.gioiTinh == "" {
            self.outPutFailed(error: "Vui lòng chọn giới tính")
            return
        }
        if let hoKH = self.mainView.viewThongTinKhachHang.hoKHTextField.textField.text {
            if hoKH.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThongTinKhachHang.hoKHTextField.textField)
                self.outPutFailed(error: "Vui lòng nhập họ")
                return
            }
        }
//        if let tenLotKH = self.mainView.viewThongTinKhachHang.tenLotTextField.textField.text {
//            if tenLotKH.isEmpty {
//                self.firstResponse(
//                    textField: self.mainView.viewThongTinKhachHang.tenLotTextField.textField)
//                self.outPutFailed(error: "Vui lòng nhập tên lót")
//                return
//            }
//        }
        if let tenKH = self.mainView.viewThongTinKhachHang.tenKHTextField.textField.text {
            if tenKH.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThongTinKhachHang.tenKHTextField.textField)
                self.outPutFailed(error: "Vui lòng nhập tên")
                return
            }
        }
        if let ngaySinh = self.mainView.viewThongTinKhachHang.ngaySinhTextField.textField.text {
            if ngaySinh.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThongTinKhachHang.ngaySinhTextField.textField)
                self.outPutFailed(error: "Vui lòng nhập ngày sinh")
                return
            }
        }
        if let soDT = self.mainView.viewThongTinKhachHang.soDTTextField.textField.text {
            if soDT.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThongTinKhachHang.soDTTextField.textField)
                self.outPutFailed(error: "Vui lòng nhập số điện thoại")
                return
            }
            if soDT.count != 10 {
                self.firstResponse(
                    textField: self.mainView.viewThongTinKhachHang.soDTTextField.textField)
                self.outPutFailed(error: "Vui lòng nhập đúng định dạng số điện thoại")
            }

        }
        if let thuNhap = self.mainView.viewThongTinKhachHang.thuNhapTextField.currencyTextField.text {
            if thuNhap.isEmpty || thuNhap == "0" {
                self.firstResponse(
                    textField: self.mainView.viewThongTinKhachHang.thuNhapTextField
                        .currencyTextField)
                self.outPutFailed(error: "Vui lòng nhập thu nhập")
                return
            }
        }
        if let tinhThuongTru = self.mainView.viewThuongTruKhachHang.tinhTextField.textField.text {
            if tinhThuongTru.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThuongTruKhachHang.tinhTextField.textField)
                self.outPutFailed(error: "Vui lòng chọn tỉnh/thành phố thường trú")
                return
            }
        }
        if let quanThuongTru = self.mainView.viewThuongTruKhachHang.huyenTextField.textField.text {
            if quanThuongTru.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThuongTruKhachHang.huyenTextField.textField)
                self.outPutFailed(error: "Vui lòng chọn quận/huyện thường trú")
                return
            }
        }
        if let xaThuongTru = self.mainView.viewThuongTruKhachHang.xaTextField.textField.text {
            if xaThuongTru.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThuongTruKhachHang.xaTextField.textField)
                self.outPutFailed(error: "Vui lòng chọn xã/phường thường trú")
                return
            }
        }
        if let diaChiThuongTru = self.mainView.viewThuongTruKhachHang.duongTextField.textField.text {
            if diaChiThuongTru.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThuongTruKhachHang.duongTextField.textField)
                self.outPutFailed(error: "Vui lòng nhập địa chỉ thường trú")
                return
            }
        }
        if let tinhTamTru = self.mainView.viewTamTruKhachHang.tinhTextField.textField.text {
            if tinhTamTru.isEmpty {
                self.firstResponse(textField: self.mainView.viewTamTruKhachHang.tinhTextField.textField)
                self.outPutFailed(error: "Vui lòng chọn tỉnh/thành phố tạm trú")
                return
            }
        }
        if let quanTamTru = self.mainView.viewTamTruKhachHang.huyenTextField.textField.text {
            if quanTamTru.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewTamTruKhachHang.huyenTextField.textField)
                self.outPutFailed(error: "Vui lòng chọn quận/huyện tạm trú")
                return
            }
        }
        if let xaTamTru = self.mainView.viewTamTruKhachHang.xaTextField.textField.text {
            if xaTamTru.isEmpty {
                self.firstResponse(textField: self.mainView.viewTamTruKhachHang.xaTextField.textField)
                self.outPutFailed(error: "Vui lòng chọn xã/phường tạm trú")
                return
            }
        }
        if let diaChiTamTru = self.mainView.viewTamTruKhachHang.duongTextField.textField.text {
            if diaChiTamTru.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewTamTruKhachHang.duongTextField.textField)
                self.outPutFailed(error: "Vui lòng nhập địa chỉ thường trú")
                return
            }
        }
        if let nguoiThamChieu1 = self.mainView.viewThamChieuKhachHang.hoTenTextField.textField.text {
            if nguoiThamChieu1.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThamChieuKhachHang.hoTenTextField.textField)
                self.outPutFailed(error: "Vui lòng nhập họ tên người tham chiếu thứ 1")
                return
            }
        }
        if let moiQuanHe1 = self.mainView.viewThamChieuKhachHang.moiQuanHeTextField.textField.text {
            if moiQuanHe1.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThamChieuKhachHang.moiQuanHeTextField.textField)
                self.outPutFailed(error: "Vui lòng nhập mối quan hệ của người tham chiếu thứ 1")
                return
            }
        }
        if let soDT1 = self.mainView.viewThamChieuKhachHang.soDTTextField.textField.text {
            if soDT1.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThamChieuKhachHang.soDTTextField.textField)
                self.outPutFailed(error: "Vui lòng nhập số điện thoại của người tham chiếu thứ 1")
                return
            }
            if soDT1.count != 10 {
                self.firstResponse(
                    textField: self.mainView.viewThamChieuKhachHang.soDTTextField.textField)
                self.outPutFailed(error: "Vui lòng nhập đúng định dạng số điện thoại")
            }
        }
        if let nguoiThamChieu2 = self.mainView.viewThamChieuKhachHang.hoTen2TextField.textField.text {
            if nguoiThamChieu2.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThamChieuKhachHang.hoTen2TextField.textField)
                self.outPutFailed(error: "Vui lòng nhập họ tên người tham chiếu thứ 2")
                return
            }
        }
        if let moiQuanHe2 = self.mainView.viewThamChieuKhachHang.moiQuanHe2TextField.textField.text {
            if moiQuanHe2.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThamChieuKhachHang.moiQuanHe2TextField.textField)
                self.outPutFailed(error: "Vui lòng nhập mối quan hệ của người tham chiếu thứ 2")
                return
            }
        }
        if let soDT2 = self.mainView.viewThamChieuKhachHang.soDT2TextField.textField.text {
            if soDT2.isEmpty {
                self.firstResponse(
                    textField: self.mainView.viewThamChieuKhachHang.soDT2TextField.textField)
                self.outPutFailed(error: "Vui lòng nhập số điện thoại của người tham chiếu thứ 2")
                return
            }
            if soDT2.count != 10 {
                self.firstResponse(
                    textField: self.mainView.viewThamChieuKhachHang.soDT2TextField.textField)
                self.outPutFailed(error: "Vui lòng nhập đúng định dạng số điện thoại")
            }
        }
        if self.presenter?.isLichSu ?? false {
            self.presenter?.updateThongTinCongViec(
                customerInfo: self.createParamCustomer(), permanentAddress: self.createParamThuongTru(),
                residenceAddress: self.createParamTamTru(), refPerson1: self.createParamThamChieu1(),
                refPerson2: self.createParamThamChieu2())
        } else {
            self.presenter?.luuHoSo(
                customerInfo: self.createParamCustomer(),
                permanentAddress: self.createParamThuongTru(),
                residenceAddress: self.createParamTamTru(),
                refPerson1: self.createParamThamChieu1(),
                refPerson2: self.createParamThamChieu2())
        }
    }

    private func firstResponse(textField: UITextField) {
        textField.becomeFirstResponder()
    }

    private func createParamThuongTru() -> [String: Any] {
        let model: [ThongTinKhachHangMireaEntity.ParamCustomer] = [
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "street",
                value: self.mainView.viewThuongTruKhachHang.duongTextField.textField.text ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "cityCode", value: self.presenter?.modelDiaChi.codeTinhThuongTru ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "districtCode", value: self.presenter?.modelDiaChi.codeHuyenThuongTru ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "wardCode", value: self.presenter?.modelDiaChi.codeXaThuongTru ?? ""),
        ]
        var thuongTru: [String: Any] = [:]
        model.forEach { item in
            thuongTru[item.key] = item.value
        }
        return thuongTru
    }
    private func createParamCustomer() -> [String: Any] {
        let money = (self.mainView.viewThongTinKhachHang.thuNhapTextField.currencyTextField.text ?? "0")
        let model: [ThongTinKhachHangMireaEntity.ParamCustomer] = [
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "nationalId",
                value: self.mainView.viewThongTinKhachHang.cmndTextField.textField.text ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "idIssuedDate",
                value: self.mainView.viewThongTinKhachHang.ngayCapTextField.textField.text ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "idIssuedBy",
                value: self.mainView.viewThongTinKhachHang.noiCapTextField.textField.text ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "sex", value: self.presenter?.modelDiaChi.gioiTinh ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "lName",
                value: self.mainView.viewThongTinKhachHang.hoKHTextField.textField.text ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "mName",
                value: self.mainView.viewThongTinKhachHang.tenLotTextField.textField.text ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "fName",
                value: self.mainView.viewThongTinKhachHang.tenKHTextField.textField.text ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "dob",
                value: self.mainView.viewThongTinKhachHang.ngaySinhTextField.textField.text ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "mobile",
                value: self.mainView.viewThongTinKhachHang.soDTTextField.textField.text ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "empSalary", value: money.replacingOccurrences(of: ".", with: "")),
        ]
        var customerInfo: [String: Any] = [:]
        model.forEach { item in
            customerInfo[item.key] = item.value
        }
        return customerInfo
    }
    private func createParamTamTru() -> [String: Any] {
        let isThuongTru: Bool = self.mainView.diaChiButton.isChecked
        let model: [ThongTinKhachHangMireaEntity.ParamCustomer] = [
            ThongTinKhachHangMireaEntity.ParamCustomer(key: "samePerResAddress", value: isThuongTru),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "street",
                value: isThuongTru
                ? self.mainView.viewThuongTruKhachHang.duongTextField.textField.text ?? ""
                : self.mainView.viewTamTruKhachHang.duongTextField.textField.text ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "cityCode",
                value: isThuongTru
                ? self.presenter?.modelDiaChi.codeTinhThuongTru ?? ""
                : self.presenter?.modelDiaChi.codeTinhTamTru ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "districtCode",
                value: isThuongTru
                ? self.presenter?.modelDiaChi.codeHuyenThuongTru ?? ""
                : self.presenter?.modelDiaChi.codeHuyenTamTru ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "wardCode",
                value: isThuongTru
                ? self.presenter?.modelDiaChi.codeXaThuongTru ?? ""
                : self.presenter?.modelDiaChi.codeXaTamTru ?? ""),
        ]
        var tamTru: [String: Any] = [:]
        model.forEach { item in
            tamTru[item.key] = item.value
        }
        return tamTru
    }
    private func createParamThamChieu1() -> [String: Any] {
        let model: [ThongTinKhachHangMireaEntity.ParamCustomer] = [
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "fullName",
                value: self.mainView.viewThamChieuKhachHang.hoTenTextField.textField.text ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "relationship",
                value: self.mainView.viewThamChieuKhachHang.moiQuanHeTextField.textField.text ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "phone",
                value: self.mainView.viewThamChieuKhachHang.soDTTextField.textField.text ?? ""),
        ]
        var thamChieu: [String: Any] = [:]
        model.forEach { item in
            thamChieu[item.key] = item.value
        }
        return thamChieu
    }
    private func createParamThamChieu2() -> [String: Any] {
        let model: [ThongTinKhachHangMireaEntity.ParamCustomer] = [
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "fullName",
                value: self.mainView.viewThamChieuKhachHang.hoTen2TextField.textField.text ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "relationship",
                value: self.mainView.viewThamChieuKhachHang.moiQuanHe2TextField.textField.text ?? ""),
            ThongTinKhachHangMireaEntity.ParamCustomer(
                key: "phone",
                value: self.mainView.viewThamChieuKhachHang.soDT2TextField.textField.text ?? ""),
        ]
        var thamChieu: [String: Any] = [:]
        model.forEach { item in
            thamChieu[item.key] = item.value
        }
        return thamChieu
    }
}

extension ThongTinKhachHangMireaViewController: ThongTinKhachHangMireaPresenterToViewProtocol {

    func didSearchTinhThanhPhoSuccess(model: [ThongTinKhachHangMireaEntity.DataTinhModel], tag: Int) {
        switch tag {
            case 100:
                self.mainView.dropDown?.anchorView = self.mainView.viewThongTinKhachHang.noiCapTextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            case 101:
                self.mainView.dropDown?.anchorView = self.mainView.viewThuongTruKhachHang.tinhTextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            case 102:
                self.mainView.dropDown?.anchorView = self.mainView.viewTamTruKhachHang.tinhTextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            default:
                break
        }
        self.mainView.dropDown?.dataSource = model.map({ item in
            return item.text ?? ""
        })
        self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
            switch tag {
                case 100:
                    self.mainView.viewThongTinKhachHang.noiCapTextField.textField.text = item
                    self.presenter?.modelDiaChi.noiCapCMND = item
                case 101:
                    self.mainView.viewThuongTruKhachHang.tinhTextField.textField.text = item
                    self.presenter?.modelDiaChi.codeTinhThuongTru = model[index].value ?? ""
                case 102:
                    self.mainView.viewTamTruKhachHang.tinhTextField.textField.text = item
                    self.presenter?.modelDiaChi.codeTinhTamTru = model[index].value ?? ""
                default:
                    break
            }
        }
        self.mainView.dropDown?.show()
    }

    func didResubmitToMiraeSuccess(message: String) {
        AlertManager.shared.alertWithViewController(
            title: "Thông báo", message: message, titleButton: "OK", viewController: self
        ) {
            let controllers: Array = self.navigationController!.viewControllers
            self.navigationController?.popToViewController(controllers[1], animated: true)
        }
    }

    func didUpdateThongTinCongViecSuccess(model: ThongTinKhachHangMireaEntity.UpdateThongTinCongViecModel) {
        self.showAlertMultiOption(
            title: "Thông báo", message: model.message ?? "", options: "GỬI NHÀ TRẢ GÓP",
            "TIẾP TỤC CẬP NHẬT", buttonAlignment: .horizontal
        ) { index in
            if index == 0 {
                self.presenter?.resubmitToMirae()
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    func didLoadThongTinKhachHangSuccess(model: ORCCMNDMiraeEntity.ORCCMNDMiraeDataModel) {
        self.bindingData()
    }

    func didLuuHoSoSuccess(message: String, docEntry: Int) {
        AlertManager.shared.alertWithViewController(
            title: "Thông báo",
            message: message,
            titleButton: "Đồng ý",
            viewController: self
        ) {

            let vc = TimKiemDonHangHangMireaRouter().configureVIPERTimKiemDonHangHangMirea()
            let keyChain = KeychainSwift()
            keyChain.set("\(docEntry)", forKey: "appDocEntryMirae")
            let thuNhap =
            (self.mainView.viewThongTinKhachHang.thuNhapTextField.currencyTextField.text ?? "")
                .replacingOccurrences(of: ".", with: "")
            let fullName =
            "\(self.mainView.viewThongTinKhachHang.hoKHTextField.textField.text ?? "") \(self.mainView.viewThongTinKhachHang.tenLotTextField.textField.text ?? "") \(self.mainView.viewThongTinKhachHang.tenKHTextField.textField.text ?? "")"
            Cache.infoKHMirae = KhachHangMiraeModel(
                soDienThoai: self.mainView.viewThongTinKhachHang.soDTTextField.textField.text ?? "",
                thuNhap: thuNhap,
                soCMND: self.mainView.viewThongTinKhachHang.cmndTextField.textField.text ?? "",
                fullname: fullName,
                ngayCapCMND: self.mainView.viewThongTinKhachHang.ngayCapTextField.textField.text ?? "",
                ngaySinh: self.mainView.viewThongTinKhachHang.ngaySinhTextField.textField.text ?? "",
                ho: self.mainView.viewThongTinKhachHang.hoKHTextField.textField.text ?? "",
                gioiTinh: self.presenter?.modelDiaChi.gioiTinh ?? "M",
                tenLot: self.mainView.viewThongTinKhachHang.tenLotTextField.textField.text ?? "",
                ten: self.mainView.viewThongTinKhachHang.tenKHTextField.textField.text ?? "",
                diaChi: self.mainView.viewThuongTruKhachHang.duongTextField.textField.text ?? "",
                codeTinhThuongTru: self.presenter?.modelDiaChi.codeTinhThuongTru ?? "",
                tinhThuongTru: self.presenter?.modelDiaChi.tinhThuongTru ?? "",
                tinhTamTru: self.presenter?.modelDiaChi.codeTinhTamTru ?? "",
                huyenThuongTru: self.presenter?.modelDiaChi.huyenThuongTru ?? "",
                huyenTamTru: self.presenter?.modelDiaChi.huyenTamTru ?? "",
                xaThuongTru: self.presenter?.modelDiaChi.xaThuongTru ?? "",
                xaTamTru: self.presenter?.modelDiaChi.xaTamTru ?? "",
                codeTinhTamTru: self.presenter?.modelDiaChi.codeTinhTamTru ?? "",
                codeHuyenThuongTru: self.presenter?.modelDiaChi.codeHuyenThuongTru ?? "",
                codeHuyenTamTru: self.presenter?.modelDiaChi.codeHuyenTamTru ?? "",
                codeXaThuongTru: self.presenter?.modelDiaChi.codeXaThuongTru ?? "",
                codeXaTamTru: self.presenter?.modelDiaChi.codeXaTamTru ?? "",
                noiCapCMND: self.mainView.viewThongTinKhachHang.noiCapTextField.textField.text ?? "",
                tenNguoiThamChieu1: self.mainView.viewThamChieuKhachHang.hoTenTextField.textField.text
                ?? "",
                moiQuanHeNguoiThamChieu1:
                    self.mainView.viewThamChieuKhachHang.moiQuanHeTextField.textField.text ?? "",
                soDTNguoiThamChieu1: self.mainView.viewThamChieuKhachHang.soDTTextField.textField.text
                ?? "",
                tenNguoiThamChieu2: self.mainView.viewThamChieuKhachHang.hoTen2TextField.textField.text
                ?? "",
                moiQuanHeNguoiThamChieu2:
                    self.mainView.viewThamChieuKhachHang.moiQuanHe2TextField.textField.text ?? "",
                soDTNguoiThamChieu2: self.mainView.viewThamChieuKhachHang.soDT2TextField.textField.text
                ?? "",
                appDocEntry: docEntry,
                tenGoiTraGop: "",
                kyHan: 0,
                phiBaoHiem: 0,
                soTienVay: 0,
                giamGia: 0,
                tongTien: 0,
                soTienTraTruoc: 0, soTienCoc: 0,
                laiSuat: 0,
                thanhTien: 0,
                codeGoiTraGop: "0",
                fullAddress:
                    "\(self.mainView.viewThuongTruKhachHang.duongTextField.textField.text ?? ""),\(self.presenter?.modelDiaChi.xaThuongTru ?? ""),\(self.presenter?.modelDiaChi.huyenThuongTru ?? ""),\(self.presenter?.modelDiaChi.tinhThuongTru ?? "")",
                soPOS: "", soMPOS: "")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func didLoadQuanHuyenSuccess(model: [ThongTinKhachHangMireaEntity.DataTinhModel], tag: Int) {
        switch tag {
            case 3:
                self.mainView.dropDown?.anchorView = self.mainView.viewThuongTruKhachHang.huyenTextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            case 6:
                self.mainView.dropDown?.anchorView = self.mainView.viewTamTruKhachHang.huyenTextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            default:
                break
        }
        self.mainView.dropDown?.dataSource = model.map({ item in
            return item.text ?? ""
        })
        self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
            switch tag {
                case 3:
                    self.mainView.viewThuongTruKhachHang.huyenTextField.textField.text = item
                    self.presenter?.modelDiaChi.codeHuyenThuongTru = model[index].value ?? ""
                case 6:
                    self.mainView.viewTamTruKhachHang.huyenTextField.textField.text = item
                    self.presenter?.modelDiaChi.codeHuyenTamTru = model[index].value ?? ""
                default:
                    break
            }
        }
        self.mainView.dropDown?.show()
    }

    func didLoadPhuongXaSuccess(model: [ThongTinKhachHangMireaEntity.DataTinhModel], tag: Int) {
        switch tag {
            case 4:
                self.mainView.dropDown?.anchorView = self.mainView.viewThuongTruKhachHang.xaTextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            case 7:
                self.mainView.dropDown?.anchorView = self.mainView.viewTamTruKhachHang.xaTextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            default:
                break
        }
        self.mainView.dropDown?.dataSource = model.map({ item in
            return item.text ?? ""
        })
        self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
            switch tag {
                case 4:
                    self.mainView.viewThuongTruKhachHang.xaTextField.textField.text = item
                    self.presenter?.modelDiaChi.codeXaThuongTru = model[index].value ?? ""
                case 7:
                    self.mainView.viewTamTruKhachHang.xaTextField.textField.text = item
                    self.presenter?.modelDiaChi.codeXaTamTru = model[index].value ?? ""
                default:
                    break
            }
        }
        self.mainView.dropDown?.show()
    }

    func didLoadTinhThanhPhoSuccess(model: [ThongTinKhachHangMireaEntity.DataTinhModel], tag: Int) {
        switch tag {
            case 100:
                self.mainView.dropDown?.anchorView = self.mainView.viewThongTinKhachHang.noiCapTextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            case 101:
                self.mainView.dropDown?.anchorView = self.mainView.viewThuongTruKhachHang.tinhTextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            case 102:
                self.mainView.dropDown?.anchorView = self.mainView.viewTamTruKhachHang.tinhTextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            default:
                break
        }
        self.mainView.dropDown?.dataSource = model.map({ item in
            return item.text ?? ""
        })
        self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
            switch tag {
                case 100:
                    self.mainView.viewThongTinKhachHang.noiCapTextField.textField.text = item
                    self.presenter?.modelDiaChi.noiCapCMND = item
                case 101:
                    self.mainView.viewThuongTruKhachHang.tinhTextField.textField.text = item
                    self.presenter?.modelDiaChi.codeTinhThuongTru = model[index].value ?? ""
                case 102:
                    self.mainView.viewTamTruKhachHang.tinhTextField.textField.text = item
                    self.presenter?.modelDiaChi.codeTinhTamTru = model[index].value ?? ""
                default:
                    break
            }
        }
        self.mainView.dropDown?.show()
    }

    func outPutFailed(error: String) {
        AlertManager.shared.alertWithViewController(
            title: "Thông báo", message: error, titleButton: "Đồng ý", viewController: self
        ) {
            self.hideLoading()
        }
    }

    func bindingNgaySinh(date: String) {
        self.mainView.viewThongTinKhachHang.ngaySinhTextField.textField.text = date
    }

    func bindingNgayCap(date: String) {
        self.mainView.viewThongTinKhachHang.ngayCapTextField.textField.text = date
    }

    func showLoading(message: String) {
        self.startLoading(message: message)
    }

    func hideLoading() {
        self.stopLoading()
    }
}

extension ThongTinKhachHangMireaViewController: HeaderInfoDelegate {
    func onClickHeader(headerView: UIView) {
        if headerView == self.mainView.thongTinKhachHangButton {
            self.showHideViewThongTinKH()
        }
        if headerView == self.mainView.thongTinThuongTruButton {
            self.showHideViewThuongTru()
        }
        if headerView == self.mainView.thongTinTamTruButton {
            self.showHideViewTamTru()
        }
        if headerView == self.mainView.thongTinThamChieuButton {
            self.showHideViewThamChieu()
        }
    }
}

extension ThongTinKhachHangMireaViewController: InputInfoTextFieldDelegate {
    func didSelected(index: Int) {
        self.view.endEditing(true)
        switch index {
            case 0, 2, 5:
                break
                    //            self.presenter?.loadListTinhThanhPho(tag: index)
            case 3, 6:
                self.presenter?.loadQuanHuyen(tag: index)
            case 4, 7:
                self.presenter?.loadPhuongXa(tag: index)
            case 8:
                self.mainView.dropDown?.anchorView = self.mainView.viewThongTinCongViec.chucVuTextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
                self.mainView.dropDown?.dataSource =
                self.presenter?.modelChucVu.map({ item in
                    return item.value ?? ""
                }) ?? []
                self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
                    self.mainView.viewThongTinCongViec.chucVuTextField.textField.text = item
                    self.presenter?.modelWorkInfo[1].value = item
                }
            case 9:
                self.mainView.dropDown?.anchorView = self.mainView.viewThongTinCongViec.loaiHopDongTextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
                self.mainView.dropDown?.dataSource =
                self.presenter?.modelLoaiHopDong.map({ item in
                    return item.value ?? ""
                }) ?? []
                self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
                    self.mainView.viewThongTinCongViec.loaiHopDongTextField.textField.text = item
                    self.presenter?.modelWorkInfo[2].value = item
                }
            case 10:
                self.mainView.dropDown?.anchorView = self.mainView.viewThongTinCongViec.ngayDongDauTienTextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
                self.mainView.dropDown?.dataSource =
                self.presenter?.modelNgayThanhToan.map({ item in
                    return item.name ?? ""
                }) ?? []
                self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
                    self.mainView.viewThongTinCongViec.ngayDongDauTienTextField.textField.text = item
                    self.presenter?.modelWorkInfo[5].value = item
                }
            case 11:
                self.mainView.dropDown?.anchorView = self.mainView.viewThongTinCongViec.maNoiBoTextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
                self.mainView.dropDown?.dataSource =
                self.presenter?.modelMaNoiBo.map({ item in
                    return item.value ?? ""
                }) ?? []
                self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
                    self.mainView.viewThongTinCongViec.maNoiBoTextField.textField.text = item
                    self.presenter?.modelWorkInfo[6].value = item
                }
            case 12:
                self.mainView.dropDown?.anchorView = self.mainView.viewThamChieuKhachHang.moiQuanHeTextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
                self.mainView.dropDown?.dataSource =
                self.presenter?.modelMoiQuanHe.map({ item in
                    return item.value ?? ""
                }) ?? []
                self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
                    self.mainView.viewThamChieuKhachHang.moiQuanHeTextField.textField.text = item
                }
            case 13:
                self.mainView.dropDown?.anchorView = self.mainView.viewThamChieuKhachHang.moiQuanHe2TextField
                self.mainView.dropDown?.bottomOffset = CGPoint(
                    x: 0, y: (self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 20)
                self.mainView.dropDown?.dataSource =
                self.presenter?.modelMoiQuanHe.map({ item in
                    return item.value ?? ""
                }) ?? []
                self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
                    self.mainView.viewThamChieuKhachHang.moiQuanHe2TextField.textField.text = item
                }
            default:
                break
        }
        self.mainView.dropDown?.show()
    }

    func showDatePicker(textField: UITextField) {
        self.datePicker.datePickerMode = .date
        self.datePicker.locale = Locale.init(identifier: "vi_VN")
        self.datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
        }
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "", style: .plain, target: self, action: #selector(self.cancelDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(
            title: "Đóng", style: .plain, target: self, action: #selector(datePickerDone))
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
    }

    @objc func handleDatePicker(sender: UIDatePicker) {
        if self.mainView.viewThongTinKhachHang.ngayCapTextField.textField.isFirstResponder {
            self.presenter?.ngayCap = sender.date
        } else {
            if self.mainView.viewThongTinKhachHang.ngaySinhTextField.textField.isFirstResponder {
                self.presenter?.ngaySinh = sender.date
            } else {
                print("Error: Can't find first responder field.")
            }
        }
    }

    @objc func datePickerDone(dateField: UITextView) {

        if self.mainView.viewThongTinKhachHang.ngayCapTextField.textField.isFirstResponder {
            self.mainView.viewThongTinKhachHang.ngayCapTextField.textField.resignFirstResponder()
        } else {
            if self.mainView.viewThongTinKhachHang.ngaySinhTextField.textField.isFirstResponder {
                self.mainView.viewThongTinKhachHang.ngaySinhTextField.textField.resignFirstResponder()
            } else {
                print("Error: Can't find first responder field.")
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
}

extension ThongTinKhachHangMireaViewController: RadioCustomDelegate {
    func onClickRadio(radioView: UIView, tag: Int) {
        self.presenter?.modelDiaChi.gioiTinh = tag == 0 ? "M" : "F"
        self.mainView.viewThongTinKhachHang.gioiTinhNamButton.setSelect(isSelect: tag == 0 ? true : false)
        self.mainView.viewThongTinKhachHang.gioiTinhNuButton.setSelect(isSelect: tag == 1 ? true : false)
    }
}

extension ThongTinKhachHangMireaViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
extension ThongTinKhachHangMireaViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
            //        textField.becomeFirstResponder()
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
            case 100, 101, 102:
                self.presenter?.loadListTinhThanhPho(tag: textField.tag)
            default:
                break
        }
        return true
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == self.mainView.viewThongTinCongViec.tenCongTyTextField.textField {
            self.presenter?.modelWorkInfo[0].value = textField.text ?? ""
        }
        if textField == self.mainView.viewThongTinCongViec.thoiGianLamViecTextField.textField {
            self.presenter?.modelWorkInfo[3].value = textField.text ?? ""
        }
        if textField == self.mainView.viewThongTinCongViec.soThangLamViecTextField.textField {
            self.presenter?.modelWorkInfo[4].value = textField.text ?? ""
        }
        if textField == self.mainView.viewThongTinKhachHang.noiCapTextField.textField {
            self.presenter?.filterContentForSearchText(textField.text ?? "", tag: textField.tag)
        }
        if textField == self.mainView.viewThuongTruKhachHang.tinhTextField.textField {
            self.presenter?.filterContentForSearchText(textField.text ?? "", tag: textField.tag)
        }
        if textField == self.mainView.viewTamTruKhachHang.tinhTextField.textField {
            self.presenter?.filterContentForSearchText(textField.text ?? "", tag: textField.tag)
        }

    }

}
