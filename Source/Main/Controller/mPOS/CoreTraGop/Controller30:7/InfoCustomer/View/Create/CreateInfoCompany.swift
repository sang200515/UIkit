//
//  CreateInfoCompany.swift
//  QuickCode
//
//  Created by Sang Trương on 14/07/2022.
//

import SkyFloatingLabelTextField
import Toaster
import UIKit

class CreateInfoCompany: BaseController, UITextFieldDelegate {
	//MARK: - Variable
	var itemDetail: CreateCustomerModel?
	//MARK: - Properties
	var flow: String = ""

	@IBOutlet weak var tfName: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfPosition: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfAddress: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfYear: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfIncome: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfMonth: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfPhone: SkyFloatingLabelTextFieldWithIcon!
	//    @IBOutlet weak var btnSearch: UIButton!
	@IBOutlet weak var continueButton: UIButton!

	// MARK: - Lifecycle
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.barTintColor = #colorLiteral(
			red: 0.01877964661, green: 0.6705997586, blue: 0.4313761592, alpha: 1)

	}
	override func viewDidLoad() {
		super.viewDidLoad()
		//		setupUI()CreateRelateCustomer
		tfIncome.delegate = self
		tfPhone.delegate = self

		setupUITextFieldUI()
		title = "thông công ty khách hàng"
		editFlow()
	}

	// MARK: - setupUI
	private func editFlow() {
		if flow == "edit" {
            continueButton.setTitle("Cập nhật thông tin", for: .normal)
			tfName.text = itemDetail?.company?.companyName
			tfPosition.text = itemDetail?.company?.position
			tfAddress.text = itemDetail?.company?.companyAddress
			tfYear.text = "\(Int(itemDetail?.company?.workYear ?? 0))"
			tfIncome.text = "\(Int(itemDetail?.company?.income ?? 0 ))"
			tfMonth.text = "\(Int(itemDetail?.company?.workMonth ?? 0))"
			tfPhone.text = itemDetail?.company?.companyPhone
		}
	}
	private func setupUITextFieldUI() {
		applySkyscannerThemeWithIcon(textField: tfName)
		applySkyscannerThemeWithIcon(textField: tfPosition)
		applySkyscannerThemeWithIcon(textField: tfAddress)
		applySkyscannerThemeWithIcon(textField: tfYear)
		applySkyscannerThemeWithIcon(textField: tfIncome)
		applySkyscannerThemeWithIcon(textField: tfMonth)
		applySkyscannerThemeWithIcon(textField: tfPhone)

		tfName.iconWidth = 12.5
		tfName.iconType = .image
		tfName.iconImage = UIImage(named: "ic_home")!
		tfName.placeholder = "Tên công ty (*)"

		tfPosition.iconWidth = 12.5  // Control the size of the image
		tfPosition.iconType = .image
		tfPosition.iconImage = UIImage(named: "ic_user")!
		tfPosition.placeholder = "Chức danh (*)"

		tfYear.iconWidth = 12.5
		tfYear.iconType = .image
		tfYear.iconImage = UIImage(named: "ic_calendar")!
		tfYear.placeholder = "Số năm làm việc (*)"

		tfMonth.iconWidth = 12.5
		tfMonth.iconType = .image
		tfMonth.iconImage = UIImage(named: "ic_calendar")!
		tfMonth.placeholder = "Số tháng làm việc (*)"

		tfIncome.iconWidth = 12.5
		tfIncome.iconType = .image
		tfIncome.iconImage = UIImage(named: "ic_money")!
		tfIncome.placeholder = "Mức lương (*)"
		var moneyString: String = tfIncome.text!
		moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
		moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
		if moneyString.isEmpty {
			moneyString = "0"
		}

		tfAddress.iconWidth = 12.5
		tfAddress.iconType = .image
		tfAddress.iconImage = UIImage(named: "ic_map2")!
		tfAddress.placeholder = "Địa chỉ công ty"
		tfAddress.placeholder = "Địa chỉ thường trú"
		tfAddress.withImage(direction: .right, image: UIImage(named: "right-arrow")!)
		let tapFromField = UITapGestureRecognizer(target: self, action: #selector(self.tapFromAddresDeefault))
		tfAddress.addGestureRecognizer(tapFromField)
		tfAddress.isUserInteractionEnabled = true
		tfPhone.iconWidth = 12.5
		tfPhone.iconType = .image
		tfPhone.iconImage = UIImage(named: "ic_phone")!
		tfPhone.placeholder = "Số điện thoại công ty"

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
	// MARK: - API

	// MARK: - Helpers

	private func isValidEmail(_ email: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

		let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
		return email.isEmpty ? true : emailPred.evaluate(with: email)
	}
	private func validateInputs() -> Bool {
		guard let name = tfName.text, !name.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập tên công ty", titleButton: "OK")
			return false
		}

		guard let phone = tfPosition.text, !phone.isEmpty else {
			showAlertOneButton(
				title: "Thông báo", with: "Vui lòng nhập chức vụ trong công ty", titleButton: "OK")
			return false
		}

		guard let name = tfAddress.text, !name.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập địa chỉ", titleButton: "OK")
			return false
		}
		guard let name = tfYear.text, !name.isEmpty else {
			showAlertOneButton(
				title: "Thông báo", with: "Bạn vui lòng nhập số năm làm việc", titleButton: "OK")
			return false
		}
		guard let name = tfMonth.text, !name.isEmpty else {
			showAlertOneButton(
				title: "Thông báo", with: "Bạn vui lòng nhập số tháng làm việc", titleButton: "OK")
			return false
		}
		guard let name = tfIncome.text, !name.isEmpty else {
			showAlertOneButton(
				title: "Thông báo", with: "Bạn vui lòng nhập mức lương làm việc", titleButton: "OK")
			return false
		}

		guard let phone = tfPhone.text, !phone.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập SĐT công ty khách hàng", titleButton: "OK")
			return false
		}

		if phone.count != 10 {
			showAlertOneButton(
				title: "Thông báo", with: "Bạn vui lòng nhập thông tin SĐT 10 chữ số", titleButton: "OK"
			)
			return false
		}
		return true
	}
	private func saveDataLocalCompany() -> [String: Any] {
		var detail = [String: Any]()
		detail["companyName"] = tfName.text!
		detail["companyAddress"] = tfAddress.text!
		detail["position"] = tfPosition.text!
		detail["income"] = Float(currentString) ?? 0
		detail["workYear"] = Int(tfYear!.text!) ?? 0
		detail["workMonth"] = Int(tfMonth!.text!) ?? 0
		detail["companyPhone"] = tfPhone.text ?? ""
		return detail
	}
	// MARK: - Selectors
	@objc func tapFromAddresDeefault() {
		let vc = DiaChiThuongTruVC()
		vc.onSelectSuccess = { fullAddress in
			self.tfAddress.text = fullAddress
		}
		vc.flow = flow
		self.navigationController?.navigationBar.tintColor = .white
		self.navigationController?.pushViewController(vc, animated: true)

	}
	@IBAction func onSelectedAddressBtn(_ sender: Any) {
		//		let vc = DiaChiThuongTruVC()
		//		vc.onSelectSuccess = { [weak self] text in
		//			guard let self = self else { return }
		//			self.tfAddress.text = text
		//		}
		//        vc.flow = "createCompany"
		//		self.navigationController?.pushViewController(vc, animated: true)
	}
	@IBAction func onClickContinue(_ sender: Any) {
		//FIXME: add more validate
		guard validateInputs() else { return }
		switch flow {
		case "create":
			CoreInstallMentData.shared.itemDiaChiCty = saveDataLocalCompany()
		case "edit":
			CoreInstallMentData.shared.editCompanyDetail = saveDataLocalCompany()
			actionEdit()
		default:
			self.showAlertOneButton(
				title: "Thông báo", with: "Không xác định được flow tạo hay sửa", titleButton: "OK")
			return
		}

		let vc = CreateChungTuThuNhapVC()
        vc.flow = flow
		self.navigationController?.navigationBar.tintColor = .white
		self.navigationController?.pushViewController(vc, animated: true)
	}
	var currentString = ""
	func formatCurrency(text: String, isBack: Bool = true) {
		currentString = text.trimMoney()
		tfIncome.text = Common.convertCurrencyDouble(value: Double(text.trimMoney()) ?? 0)

	}

	func textField(
		_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String
	) -> Bool {  // return NO to not change text
		if textField == tfPhone {
			let allowedCharacters = CharacterSet.decimalDigits
			let characterSet = CharacterSet(charactersIn: string)

			return range.location < 10 && allowedCharacters.isSuperset(of: characterSet)
		}

		switch string {
		case "-", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
			currentString += string
			print(currentString)
			formatCurrency(text: currentString)
		default:
			let array = Array(string)
			var currentStringArray = Array(currentString)
			if array.count == 0 && currentStringArray.count != 0 {
				currentStringArray.removeLast()
				currentString = ""
				for character in currentStringArray {
					currentString += String(character)
				}
				formatCurrency(text: currentString)
			}
		}
		return false
	}
}
extension CreateInfoCompany {
	private func loading(isShow: Bool) {
		let nc = NotificationCenter.default
		if isShow {
			let newViewController = LoadingViewController()
			newViewController.content = "Đang cập nhật thông tin..."
			newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
			newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
			self.navigationController?.present(newViewController, animated: true, completion: nil)
		} else {
			nc.post(name: Notification.Name("dismissLoading"), object: nil)
		}
	}
	private func actionEdit() {
		if flow == "edit" {
			let firstName = CoreInstallMentData.shared.editFirstName
			let middleName = CoreInstallMentData.shared.editMiddleName
			let lastName = CoreInstallMentData.shared.editLastName
			let idCard = CoreInstallMentData.shared.editIdCard
			let idCardType = CoreInstallMentData.shared.editIdCardType
			let email = CoreInstallMentData.shared.editEmail
			let birthDate = CoreInstallMentData.shared.editBirthDate
			let idCardIssuedBy = CoreInstallMentData.shared.editIdCardIssuedBy
			let idCardIssuedDate = CoreInstallMentData.shared.editIdCardIssuedDate
			let idCardIssuedExpiration = CoreInstallMentData.shared.editIdCardIssuedExpiration
			let phone = CoreInstallMentData.shared.editPhone
            let gender = CoreInstallMentData.shared.editGender
            let relatedDocType = CoreInstallMentData.shared.editrelatedDocumentType ?? ""
			let relatedDocument = CoreInstallMentData.shared.ediItemDocument
			let company = saveDataLocalCompany()
			let liistRefPersons = [
				CoreInstallMentData.shared.editItemNguoiLienHe1,
				CoreInstallMentData.shared.editItemNguoiLienHe2,
			]
            let addresses: [[String: Any]] = [
                CoreInstallMentData.shared.editItemDiaChiTT,
                CoreInstallMentData.shared.editItemDiaChiTamTru,
            ]
            var listUploadFiles: [[String: Any]] = [CoreInstallMentData.shared.editPathIDCardFront, CoreInstallMentData.shared.editPathIDCardBack,
                                                    CoreInstallMentData.shared.editPathChanDung, CoreInstallMentData.shared.editPathIDThueBao]
            let listUploadFilesFilter: [[String: Any]] = [CoreInstallMentData.shared.editPathIDCardFront, CoreInstallMentData.shared.editPathIDCardBack,
                                                          CoreInstallMentData.shared.editPathChanDung, CoreInstallMentData.shared.editPathIDThueBao]
            listUploadFiles = listUploadFilesFilter
            if itemDetail?.relatedDocType == "DL"{
                listUploadFiles.append(contentsOf: [CoreInstallMentData.shared.editPathIDDLFront, CoreInstallMentData.shared.editPathIDDLBack])
            }else if itemDetail?.relatedDocType == "FB" {
                CoreInstallMentData.shared.editListSHKImage.forEach { item in
                    listUploadFiles.append(item)
                }
            }
			self.loading(isShow: true)
			Provider.shared.createCustomerAPIService.editCustomerCoreInstallment(
				userCode: Cache.user!.UserName, idCard: idCard, idCardType: idCardType,
				firstName: firstName,
				middleName: middleName, lastName: lastName, email: email, gender: gender,
				birthDate: birthDate,
				phone: phone, idCardIssuedBy: idCardIssuedBy, idCardIssuedDate: idCardIssuedDate,
				idCardIssuedExpiration: idCardIssuedExpiration, relatedDocument: relatedDocument,
				company: company, refPersons: liistRefPersons, addresses: addresses,
				uploadFiles: listUploadFiles,
				relatedDocType: relatedDocType,
				success: { [weak self] result in
					guard let self = self else { return }
					self.loading(isShow: false)
					Toast.init(text: "Cập nhật thông tin thành công").show()
				},
				failure: { [weak self] error in
					guard let self = self else { return }
					self.loading(isShow: false)
					self.showAlertOneButton(
						title: "Thông báo", with: error.description, titleButton: "OK")
				})
		}
	}
}
