//
//  DiaChiThuongTruVC.swift
//  QuickCode
//
//  Created by Sang Trương on 16/07/2022.
//

import UIKit

class DiaChiThuongTruVC: UIViewController {
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
	var addressType: Int = 1
	var fullAddress: String = ""
	var flow: String = ""
	var onSelectSuccess: ((String) -> Void)?
	var onselectDiaChi: (([String: Any]) -> Void)?
	//MARK: - Properties
	@IBOutlet weak var tfHouseNumber: UITextField!
	@IBOutlet weak var tfStreet: UITextField!
	@IBOutlet weak var tfCity: UITextField!
	@IBOutlet weak var tfDistrict: UITextField!
	@IBOutlet weak var tfWard: UITextField!

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
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

	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//		autoFillParams()
//		switch flow {
//		case "create":
//			tfHouseNumber.text = CoreInstallMentData.shared.itemDiaChiThuongTru["houseNo"] as? String
//			tfStreet.text = CoreInstallMentData.shared.itemDiaChiThuongTru["street"] as? String
//			tfCity.text = CoreInstallMentData.shared.itemDiaChiThuongTru["provinceName"] as? String
//			tfDistrict.text = CoreInstallMentData.shared.itemDiaChiThuongTru["districtName"] as? String
//			tfWard.text = CoreInstallMentData.shared.itemDiaChiThuongTru["wardName"] as? String
//		case "edit":
//			tfHouseNumber.text = CoreInstallMentData.shared.editItemDiaChiTT["houseNo"] as? String
//			tfStreet.text = CoreInstallMentData.shared.editItemDiaChiTT["street"] as? String
//			tfCity.text = CoreInstallMentData.shared.editItemDiaChiTT["provinceName"] as? String
//			tfDistrict.text = CoreInstallMentData.shared.editItemDiaChiTT["districtName"] as? String
//			tfWard.text = CoreInstallMentData.shared.editItemDiaChiTT["wardName"] as? String
//		default:
//			return
//		}

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
					self.districtCode = value.code ?? ""
					self.districtName = value.name ?? ""
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
					self.wardCode = value.code ?? ""
					self.wardName = value.name ?? ""
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
	// MARK: - Selectors

	@IBAction func onClickSuccess(_ sender: Any) {
		guard validateInputs() else { return }
		prepareParams()
		//        CoreInstallMentData.shared.itemDiaChi =  addItemDiaChi()
		//        print( CoreInstallMentData.shared.itemDiaChi)
		//        for (index,item) in CoreInstallMentData.shared.listDiaChi.enumerated() {
		//            if item["addressType"] as! Int == 1{
		//                CoreInstallMentData.shared.listDiaChi[index] = addItemDiaChi()
		//            }else{
		//                CoreInstallMentData.shared.listDiaChi.append(addItemDiaChi())
		//            }
		//        }
		//FIXME: check lai dieu kien append

        if flow == "create"{
            CoreInstallMentData.shared.itemDiaChiThuongTru = addItemDiaChi1()
        }else if flow == "edit"{
            CoreInstallMentData.shared.editItemDiaChiTT = addItemDiaChi1()
        }
        if let onSelectSuccess = onSelectSuccess {
            onSelectSuccess(
                "\(tfHouseNumber.text!),\(tfStreet.text!),\(tfWard.text!),\(tfDistrict.text!),\(tfCity.text!) "
            )
        }
        self.navigationController?.popViewController(animated: true)



	}
	private func addItemDiaChi1() -> [String: Any] {
		fullAddress =
			"\(tfHouseNumber.text!),\(tfStreet.text!),\(tfWard.text!),\(tfDistrict.text!),\(tfCity.text!) "
		var detail = [String: Any]()
		detail["provinceCode"] = provinceCode
		detail["provinceName"] = provinceName
		detail["districtCode"] = districtCode
		detail["districtName"] = districtName
		detail["wardCode"] = wardCode
		detail["wardName"] = wardName
		detail["street"] = tfStreet.text ?? ""
		detail["houseNo"] = tfHouseNumber.text ?? ""
		detail["addressType"] = addressType
		detail["fullAddress"] = fullAddress
		return detail
	}

	// MARK: - Helpers

	private func prepareParams() {
		switch flow {
		case "create":
			CoreInstallMentData.shared.houseNumberThuongTru = tfHouseNumber.text!
			CoreInstallMentData.shared.streetThuongTru = tfStreet.text!
			CoreInstallMentData.shared.cityThuongTru = tfCity.text!
			CoreInstallMentData.shared.districtThuongTru = tfDistrict.text!
			CoreInstallMentData.shared.wardThuongTru = tfWard.text!
			CoreInstallMentData.shared.diaChiThuongTru =
				"\(tfHouseNumber.text!),\(tfStreet.text!),\(tfWard.text!),\(tfDistrict.text!),\(tfCity.text!) "
		case "edit":
			print("case edit")
		default:
			return
		}

	}

	private func addItemDiaChi() -> [String: Any] {
		var detail = [String: Any]()
		fullAddress =
			"\(tfHouseNumber.text!),\(tfStreet.text!),\(tfWard.text!),\(tfDistrict.text!),\(tfCity.text!) "
		CoreInstallMentData.shared.itemDiaChiTamTru["fullAddress"] = fullAddress
		detail["provinceCode"] = provinceCode
		detail["provinceName"] = provinceName
		detail["districtCode"] = districtCode
		detail["districtName"] = districtName
		detail["wardCode"] = wardCode
		detail["wardName"] = wardName
		detail["street"] = tfStreet.text ?? ""
		detail["houseNo"] = tfHouseNumber.text ?? ""
		detail["addressType"] = 1
		detail["fullAddress"] = fullAddress
		return detail
	}
	private func autoFillParams() {
		//FIXME: fix parram here

		tfHouseNumber.text = CoreInstallMentData.shared.houseNumberThuongTru
		tfStreet.text = CoreInstallMentData.shared.streetThuongTru
		tfCity.text = CoreInstallMentData.shared.cityThuongTru
		tfDistrict.text = CoreInstallMentData.shared.districtThuongTru
		tfWard.text = CoreInstallMentData.shared.wardThuongTru
	}
	private func validateInputs() -> Bool {
		guard let ward = tfWard.text, !ward.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn Phường/Xã", titleButton: "OK")
			return false
		}

		guard let district = tfDistrict.text, !district.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn Quận/Huyện", titleButton: "OK")
			return false
		}

		guard let city = tfCity.text, !city.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn Thành phố", titleButton: "OK")
			return false
		}

		guard let number = tfHouseNumber.text, !number.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn số nhà", titleButton: "OK")
			return false
		}

		guard let street = tfStreet.text, !street.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn tên đường", titleButton: "OK")
			return false
		}
		return true
	}
}
