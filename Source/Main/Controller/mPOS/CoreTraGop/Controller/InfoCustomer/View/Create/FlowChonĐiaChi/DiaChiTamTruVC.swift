//
//  DiaChiThuongTruVC.swift
//  QuickCode
//
//  Created by Sang Trương on 16/07/2022.
//

import UIKit
import SkyFloatingLabelTextField

class DiaChiTamTruVC: UIViewController {
	//MARK: - Variable
	private var listPhuongXa = [ListPhuongXaCore]()
	var provinceCode: String = ""
	var provinceName: String = ""
	var districtCode: String = ""
	var districtName: String = ""
	var wardCode: String = ""
	var wardName: String = ""
	var street: String = ""
	var houseNo: String = ""
	var addressType: Int = 2
	var fullAddress: String = ""
	var flow: String = ""
	//MARK: - Properties
	@IBOutlet weak var tfHouseNumber: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfStreet: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfCity: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfDistrict: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfWard: SkyFloatingLabelTextFieldWithIcon!
	var onSelectSuccess: ((String) -> Void)?
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
        setupTextField()
	}
    private func setupTextField() {
        let tapFromField1 = UITapGestureRecognizer(target: self, action: #selector(self.tapFromCity))
        tfCity.addGestureRecognizer(tapFromField1)
        tfCity.isUserInteractionEnabled = true
        let tapFromField2 = UITapGestureRecognizer(target: self, action: #selector(self.tapFromDistrict))
        tfDistrict.addGestureRecognizer(tapFromField2)
        tfDistrict.isUserInteractionEnabled = true
        let tapFromField3 = UITapGestureRecognizer(target: self, action: #selector(self.tapFromWard))
        tfWard.addGestureRecognizer(tapFromField3)
        tfWard.isUserInteractionEnabled = true
        tfCity.withImage(direction: .right, image: UIImage(named: "down_arrow_ic")!)
        tfDistrict.withImage(direction: .right, image: UIImage(named: "down_arrow_ic")!)
        tfWard.withImage(direction: .right, image: UIImage(named: "down_arrow_ic")!)
        applySkyscannerThemeWithIcon(textField: tfHouseNumber)
        applySkyscannerThemeWithIcon(textField: tfStreet)
        applySkyscannerThemeWithIcon(textField: tfCity)
        applySkyscannerThemeWithIcon(textField: tfDistrict)
        applySkyscannerThemeWithIcon(textField: tfWard)

        tfHouseNumber.iconWidth = 12.5
        tfHouseNumber.iconType = .image
        tfHouseNumber.placeholder = "Số nhà"

        tfStreet.iconWidth = 12.5
        tfStreet.iconType = .image
        tfStreet.placeholder = "Tên đường (*)"

        tfCity.iconWidth = 12.5
        tfCity.iconType = .image
        tfCity.placeholder = "Tỉnh/Thành phố (*)"

        tfDistrict.iconWidth = 12.5
        tfDistrict.iconType = .image
        tfDistrict.placeholder = "Quận/Huyện (*)"

        tfWard.iconWidth = 12.5
        tfWard.iconType = .image
        tfWard.placeholder = "Phường/Xã (*)"
    }
    private func applySkyscannerThemeWithIcon(textField: SkyFloatingLabelTextFieldWithIcon) {
        self.applySkyscannerTheme(textField: textField)
        let overcastBlueColor: UIColor = UIColor(named: "primary_green")!
        textField.selectedTitleColor = overcastBlueColor
        textField.selectedLineColor = overcastBlueColor
        textField.iconColor = overcastBlueColor
        textField.selectedIconColor = overcastBlueColor
        textField.iconFont = UIFont(name: "FontAwesome", size: 15)
    }

    private func applySkyscannerTheme(textField: SkyFloatingLabelTextField) {
        let overcastBlueColor: UIColor = UIColor(named: "primary_green")!
        textField.tintColor = overcastBlueColor
        textField.selectedTitleColor = overcastBlueColor
        textField.selectedLineColor = overcastBlueColor

    }
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	// MARK: - Selectors

	@IBAction func onClickContinue(_ sender: Any) {
		guard validateInputs() else { return }
		saveLocalParams()

		if let onSelectSuccess = onSelectSuccess {
			onSelectSuccess(
				"\(tfHouseNumber.text!),\(tfStreet.text!),\(tfWard.text!),\(tfDistrict.text!),\(tfCity.text!) "
			)
			CoreInstallMentData.shared.diaChiTamTru =
				"\(tfHouseNumber.text!),\(tfStreet.text!),\(tfWard.text!),\(tfDistrict.text!),\(tfCity.text!) "
		}
		self.navigationController?.popViewController(animated: true)
	}
	@objc func tapFromCity() {
		let detailViewController = ChoooseThanhPhoVCPopupVC()
		Provider.shared.coreInstallmentService.getListTinhThanh(
			success: { [weak self] result in
				guard let self = self else { return }
				detailViewController.listThanhPho = result
				detailViewController.onSelected = { (value) in
					self.tfCity.text = value.name ?? ""
					self.provinceCode = value.code ?? ""
					self.provinceName = value.name ?? ""
				}
				let nav = UINavigationController(rootViewController: detailViewController)
				nav.modalPresentationStyle = .pageSheet
				if #available(iOS 15.0, *) {
					if let sheet = nav.sheetPresentationController {
                        sheet.detents =  [.large()]
						sheet.prefersGrabberVisible = true
						sheet.preferredCornerRadius = 30
						sheet.prefersScrollingExpandsWhenScrolledToEdge = false
						sheet.prefersEdgeAttachedInCompactHeight = true
					}
				} else {
				}
				self.present(nav, animated: true, completion: nil)
			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})

	}
	@objc func tapFromDistrict() {
		guard let start = tfCity.text, !start.isEmpty else {
			return showAlertOneButton(
				title: "Thông báo", with: "Bạn vui lòng Tỉnh/Thành phố", titleButton: "OK")
		}
		let detailViewController = ChooseQuanHuyenPopupVC()
		Provider.shared.coreInstallmentService.getListQuanhuyen(
			proVinceCode: provinceCode,
			success: { [weak self] result in
				guard let self = self else { return }
				detailViewController.listQuanhuyen = result
				detailViewController.onSelected = { value in
					self.tfDistrict.text = value.name ?? ""
					self.districtName = value.name ?? ""
					self.districtCode = value.code ?? ""
				}
				let nav = UINavigationController(rootViewController: detailViewController)
				nav.modalPresentationStyle = .pageSheet
				if #available(iOS 15.0, *) {
					if let sheet = nav.sheetPresentationController {
                        sheet.detents =  [.large()]
						sheet.prefersGrabberVisible = true
						sheet.preferredCornerRadius = 30
						sheet.prefersScrollingExpandsWhenScrolledToEdge = false
						sheet.prefersEdgeAttachedInCompactHeight = true
					}
				} else {
				}
				self.present(nav, animated: true, completion: nil)

			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})

	}
	@objc func tapFromWard() {
		guard let start = tfDistrict.text, !start.isEmpty else {
			return showAlertOneButton(
				title: "Thông báo", with: "Bạn vui lòng Quận/Huyện", titleButton: "OK")
		}
		let detailViewController = ChoosePhuongXaPopupVC()
		Provider.shared.coreInstallmentService.getListPhuongXa(
			districtCode: districtCode,
			success: { [weak self] result in
				guard let self = self else { return }
				detailViewController.listPhuongXa = result
				detailViewController.onSelected = { value in
					self.tfWard.text = value.name
					self.wardName = value.name ?? ""
					self.wardCode = value.code ?? ""
				}
				let nav = UINavigationController(rootViewController: detailViewController)
				nav.modalPresentationStyle = .pageSheet
				if #available(iOS 15.0, *) {
					if let sheet = nav.sheetPresentationController {
						sheet.detents = [.large()]
						sheet.prefersGrabberVisible = true
						sheet.preferredCornerRadius = 30
						sheet.prefersScrollingExpandsWhenScrolledToEdge = false
						sheet.prefersEdgeAttachedInCompactHeight = true
					}
				} else {
				}
				self.present(nav, animated: true, completion: nil)
			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})
	}

	// MARK: - Helpers

	private func saveLocalParams() {

		switch flow {
		case "create":
			CoreInstallMentData.shared.itemDiaChiTamTru = addItemDiaChi()
		case "edit":
			CoreInstallMentData.shared.editItemDiaChiTamTru = addItemDiaChi()

		default:
			return
		}
	}
	private func validateInputs() -> Bool {
//		guard let ward = tfHouseNumber.text, !ward.isEmpty else {
//			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn số nhà ", titleButton: "OK")
//			return false
//		}

		guard let district = tfStreet.text, !district.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn Quận/Huyện", titleButton: "OK")
			return false
		}

		guard let city = tfCity.text, !city.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn Thành phố", titleButton: "OK")
			return false
		}

		guard let number = tfDistrict.text, !number.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn số nhà", titleButton: "OK")
			return false
		}

		guard let street = tfWard.text, !street.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn Phường xã", titleButton: "OK")
			return false
		}
		return true
	}
	private func addItemDiaChi() -> [String: Any] {
		var detail = [String: Any]()
		fullAddress =
			"\(tfHouseNumber.text!),\(tfStreet.text!),\(tfWard.text!),\(tfDistrict.text!),\(tfCity.text!) "
		detail["provinceCode"] = provinceCode
		detail["provinceName"] = provinceName
		detail["districtCode"] = districtCode
		detail["districtName"] = districtName
		detail["wardCode"] = wardCode
		detail["wardName"] = wardName
		detail["street"] = tfStreet.text ?? ""
		detail["houseNo"] = tfHouseNumber.text ?? ""
		detail["addressType"] = 2
		detail["fullAddress"] = fullAddress
		return detail
	}
}
