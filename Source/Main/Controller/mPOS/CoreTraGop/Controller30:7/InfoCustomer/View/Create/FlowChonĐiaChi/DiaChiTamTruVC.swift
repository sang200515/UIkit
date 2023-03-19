//
//  DiaChiThuongTruVC.swift
//  QuickCode
//
//  Created by Sang Trương on 16/07/2022.
//

import UIKit

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
	@IBOutlet weak var soNhaTxt: UITextField!
	@IBOutlet weak var tenDuongTxt: UITextField!
	@IBOutlet weak var thanhPhoTxt: UITextField!
	@IBOutlet weak var quanHuyenTxt: UITextField!
	@IBOutlet weak var phuongXaTxt: UITextField!
	var onSelectSuccess: ((String) -> Void)?
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		let tapFromField1 = UITapGestureRecognizer(target: self, action: #selector(self.tapFromCity))
		thanhPhoTxt.addGestureRecognizer(tapFromField1)
		thanhPhoTxt.isUserInteractionEnabled = true
		let tapFromField2 = UITapGestureRecognizer(target: self, action: #selector(self.tapFromDistrict))
		quanHuyenTxt.addGestureRecognizer(tapFromField2)
		quanHuyenTxt.isUserInteractionEnabled = true
		let tapFromField3 = UITapGestureRecognizer(target: self, action: #selector(self.tapFromWard))
		phuongXaTxt.addGestureRecognizer(tapFromField3)
		phuongXaTxt.isUserInteractionEnabled = true
        thanhPhoTxt.withImage(direction: .right, image: UIImage(named: "down_arrow_ic")!)
        quanHuyenTxt.withImage(direction: .right, image: UIImage(named: "down_arrow_ic")!)
        phuongXaTxt.withImage(direction: .right, image: UIImage(named: "down_arrow_ic")!)

	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
//        switch flow {
//            case "create":
//                soNhaTxt.text = CoreInstallMentData.shared.itemDiaChiTamTru["houseNo"] as? String
//                tenDuongTxt.text = CoreInstallMentData.shared.itemDiaChiTamTru["street"] as? String
//                thanhPhoTxt.text = CoreInstallMentData.shared.itemDiaChiTamTru["provinceName"] as? String
//                quanHuyenTxt.text = CoreInstallMentData.shared.itemDiaChiTamTru["districtName"] as? String
//                phuongXaTxt.text = CoreInstallMentData.shared.itemDiaChiTamTru["wardName"] as? String
//            case "edit":
//                soNhaTxt.text = CoreInstallMentData.shared.editItemDiaChiTamTru["houseNo"] as? String
//                tenDuongTxt.text = CoreInstallMentData.shared.editItemDiaChiTamTru["street"] as? String
//                thanhPhoTxt.text = CoreInstallMentData.shared.editItemDiaChiTamTru["provinceName"] as? String
//                quanHuyenTxt.text = CoreInstallMentData.shared.editItemDiaChiTamTru["districtName"] as? String
//                phuongXaTxt.text = CoreInstallMentData.shared.editItemDiaChiTamTru["wardName"] as? String
//            default:
//                return
//        }
	}
	// MARK: - Selectors

	@IBAction func onClickContinue(_ sender: Any) {
		guard validateInputs() else { return }
		saveLocalParams()

		if let onSelectSuccess = onSelectSuccess {
			onSelectSuccess(
				"\(soNhaTxt.text!),\(tenDuongTxt.text!),\(phuongXaTxt.text!),\(quanHuyenTxt.text!),\(thanhPhoTxt.text!) "
			)
			CoreInstallMentData.shared.diaChiTamTru =
				"\(soNhaTxt.text!),\(tenDuongTxt.text!),\(phuongXaTxt.text!),\(quanHuyenTxt.text!),\(thanhPhoTxt.text!) "
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
					self.thanhPhoTxt.text = value.name ?? ""
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
		guard let start = thanhPhoTxt.text, !start.isEmpty else {
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
					self.quanHuyenTxt.text = value.name ?? ""
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
		guard let start = quanHuyenTxt.text, !start.isEmpty else {
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
					self.phuongXaTxt.text = value.name
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
		//        CoreInstallMentData.shared.houseNumberTamTru = soNhaTxt.text!
		//        CoreInstallMentData.shared.streetTamTru = tenDuongTxt.text!
		//        CoreInstallMentData.shared.cityTamTru = thanhPhoTxt.text!
		//        CoreInstallMentData.shared.diaChiTamTru = quanHuyenTxt.text!
		//        CoreInstallMentData.shared.wardTamTru = phuongXaTxt.text!
		//        CoreInstallMentData.shared.diaChiTamTru =
		//        "\(soNhaTxt.text!),\(tenDuongTxt.text!),\(phuongXaTxt.text!),\(quanHuyenTxt.text!),\(thanhPhoTxt.text!) "
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
		guard let ward = soNhaTxt.text, !ward.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn số nhà ", titleButton: "OK")
			return false
		}

		guard let district = tenDuongTxt.text, !district.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn Quận/Huyện", titleButton: "OK")
			return false
		}

		guard let city = thanhPhoTxt.text, !city.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn Thành phố", titleButton: "OK")
			return false
		}

		guard let number = quanHuyenTxt.text, !number.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn số nhà", titleButton: "OK")
			return false
		}

		guard let street = phuongXaTxt.text, !street.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn Phường xã", titleButton: "OK")
			return false
		}
		return true
	}
	private func addItemDiaChi() -> [String: Any] {
		var detail = [String: Any]()
		fullAddress =
			"\(soNhaTxt.text!),\(tenDuongTxt.text!),\(phuongXaTxt.text!),\(quanHuyenTxt.text!),\(thanhPhoTxt.text!) "
		detail["provinceCode"] = provinceCode
		detail["provinceName"] = provinceName
		detail["districtCode"] = districtCode
		detail["districtName"] = districtName
		detail["wardCode"] = wardCode
		detail["wardName"] = wardName
		detail["street"] = tenDuongTxt.text ?? ""
		detail["houseNo"] = soNhaTxt.text ?? ""
		detail["addressType"] = 2
		detail["fullAddress"] = fullAddress
		return detail
	}
}
