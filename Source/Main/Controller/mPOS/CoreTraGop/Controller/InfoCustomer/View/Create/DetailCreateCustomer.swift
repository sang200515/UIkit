import ActionSheetPicker_3_0
import DropDown
import Kingfisher
import SkyFloatingLabelTextField
import Toaster
import UIKit

class DetailCreateCustomer: BaseController, RadioCustomDelegate, ImageFrameCustomDelegate {
	var modelFromDetech: DetechCMNDModel?
	var itemDetail: CreateCustomerModel?
	//MARK: - Variable
	var flow: String = ""
    var titleNav = "Tạo hồ sơ khách hàng"
	var isFamiliarTT = false
	private var gender = -1
	private var idCardTypeDrop: Int = 0
	var sexTag: Int = 0
	var textFields: [SkyFloatingLabelTextField] = []
	@IBOutlet weak var tamtruRadio: RadioCustom!
	//MARK: - Properties

	var imageChanDungURL: String = ""
	var imageThueBaoURL: String = ""

	@IBOutlet weak var tfHo: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfTenDem: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfName: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfPhone: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfDate: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfEmail: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfAddressDefault: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfAddress: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfIDCard: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfIdCardIssuedDate: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var tfIdCardIssuedExpiration: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var anhChanDungView: ImageFrameCustom!
	@IBOutlet weak var thueBaoView: ImageFrameCustom!
	@IBOutlet weak var tfIssueBy: SkyFloatingLabelTextFieldWithIcon!
	@IBOutlet weak var frontIDCardView: ImageFrameCustom!
	@IBOutlet weak var backIDCardView: ImageFrameCustom!
	@IBOutlet weak var male: RadioCustom!
	@IBOutlet weak var female: RadioCustom!
	@IBOutlet weak var selecIDCardType: UITextField!

	@IBOutlet weak var saveButton: UIButton!
	let dropDownMenu = DropDown()
	var itemDropDown: [TypeIDCardModel] = []
	// MARK: - setupUI

	private func editCustomerCoreInnstallment() {
		let firstName = tfName.text ?? ""
		let middleName = tfTenDem.text ?? ""
		let lastName = tfHo.text ?? ""
		let idCard = tfIDCard.text ?? ""
		let idCardType = CoreInstallMentData.shared.editIdCardType
		let email = tfEmail.text ?? ""
		//		let gender1 = gender

		let birthDate = tfDate.text ?? ""
		let idCardIssuedBy = tfIssueBy.text ?? ""
		let idCardIssuedDate = tfIdCardIssuedDate.text ?? ""
		let idCardIssuedExpiration = tfIdCardIssuedExpiration.text ?? ""
		let phone = tfPhone.text ?? ""
		//        let typeOfReladoc = itemDetail?.relatedDocType
		let relatedDocType = CoreInstallMentData.shared.editrelatedDocumentType ?? ""
		let relatedDocument = CoreInstallMentData.shared.ediItemDocument
		let company = CoreInstallMentData.shared.editCompanyDetail
		let liistRefPersons = [
			CoreInstallMentData.shared.editItemNguoiLienHe1,
			CoreInstallMentData.shared.editItemNguoiLienHe2,
		]
		let addresses: [[String: Any]] = [
			CoreInstallMentData.shared.editItemDiaChiTT, CoreInstallMentData.shared.editItemDiaChiTamTru,
		]
		//		let listChungTuThuNhap = [
		//			CoreInstallMentData.shared.editItemNguoiLienHe1,
		//			CoreInstallMentData.shared.editItemNguoiLienHe2,
		//		]
		var listUploadFiles: [[String: Any]] = [
			CoreInstallMentData.shared.editPathIDCardFront, CoreInstallMentData.shared.editPathIDCardBack,
			CoreInstallMentData.shared.editPathChanDung, CoreInstallMentData.shared.editPathIDThueBao,
		]
		let listUploadFilesFilter: [[String: Any]] = [
			CoreInstallMentData.shared.editPathIDCardFront, CoreInstallMentData.shared.editPathIDCardBack,
			CoreInstallMentData.shared.editPathChanDung, CoreInstallMentData.shared.editPathIDThueBao,
		]
		listUploadFiles = listUploadFilesFilter
		if itemDetail?.relatedDocType == "DL" {
			listUploadFiles.append(contentsOf: [
				CoreInstallMentData.shared.editPathIDDLFront,
				CoreInstallMentData.shared.editPathIDDLBack,
			])
		} else if itemDetail?.relatedDocType == "FB" {
			CoreInstallMentData.shared.editListSHKImage.forEach { item in
				listUploadFiles.append(item)
			}
		}

		Provider.shared.createCustomerAPIService.editCustomerCoreInstallment(
			userCode: Cache.user!.UserName, idCard: idCard, idCardType: idCardType, firstName: firstName,
			middleName: middleName, lastName: lastName, email: email, gender: sexTag, birthDate: birthDate,
			phone: phone, idCardIssuedBy: idCardIssuedBy, idCardIssuedDate: idCardIssuedDate,
			idCardIssuedExpiration: idCardIssuedExpiration, relatedDocument: relatedDocument,
			company: company, refPersons: liistRefPersons, addresses: addresses,
			uploadFiles: listUploadFiles,
			relatedDocType: relatedDocType,
			success: { [weak self] result in
				guard let self = self else { return }
				if self.flow == "edit" {
                    self.navigationController?.popViewController(animated: true)
					Toast.init(text: "Cập nhật thông tin thành công").show()
				}

			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})
	}
	@objc func tapFromAddresDeefault() {
		let vc = DiaChiThuongTruVC()
		vc.onSelectSuccess = { [weak self] fullAddress in
			guard let self = self else { return }
			switch self.flow {
			case "edit":
				vc.flow = self.flow
				self.tfAddressDefault.text = fullAddress
			case "create":
				vc.flow = self.flow
				self.tfAddressDefault.text = fullAddress
			default:
				return
			}

		}
		vc.flow = flow
		self.navigationController?.navigationBar.tintColor = .white

		self.navigationController?.pushViewController(vc, animated: true)

	}
	@objc func tapFromAddress() {
		let vc = DiaChiTamTruVC()
		vc.flow = flow
		vc.onSelectSuccess = { [weak self] fullAddress in
			guard let self = self else { return }
			switch self.flow {
			case "edit":
				vc.flow = self.flow
				self.tfAddress.text = fullAddress
			case "create":
				vc.flow = self.flow
				self.tfAddress.text = fullAddress
			default:
				return
			}

		}
		vc.addressType = 1  // 0 and 1
		self.navigationController?.navigationBar.tintColor = .white

		self.navigationController?.pushViewController(vc, animated: true)
	}
	// MARK: - Lifecycle
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		//		setupUI()
		switch flow {
		case "create":
			//                prepareParams()
			saveButton.setTitle("Tiếp theo", for: .normal)
			print("oke")

		case "edit":
			print("oke")
			saveButton.setTitle("Cập nhật thông tin", for: .normal)
		default:
			return
		}
	}
	override func viewDidLoad() {
		super.viewDidLoad()
        tfIDCard.isUserInteractionEnabled = false
		sexTag = itemDetail?.gender ?? 0
		tamtruRadio.delegate = self
		tamtruRadio.setSelect(isSelect: false)
		setupUITextField()
		setupUI()
		loadTypeOfCart()
		let tapFromField1 = UITapGestureRecognizer(target: self, action: #selector(self.tapFromNoiCap))
		tfIssueBy.addGestureRecognizer(tapFromField1)
		tfIssueBy.isUserInteractionEnabled = true
	}

	private func setupUITextField() {

		for textField in textFields {
			textField.delegate = self
		}

		applySkyscannerThemeWithIcon(textField: tfHo)
		applySkyscannerThemeWithIcon(textField: tfTenDem)
		applySkyscannerThemeWithIcon(textField: tfName)
		applySkyscannerThemeWithIcon(textField: tfPhone)

		tfHo.iconWidth = 12.5
		tfHo.iconType = .image
		tfHo.iconImage = UIImage(named: "ic_user")!
		tfHo.placeholder = "Họ (*)"

		applySkyscannerThemeWithIcon(textField: tfTenDem)
		tfTenDem.iconWidth = 12.5  // Control the size of the image
		tfTenDem.iconType = .image
		tfTenDem.iconImage = UIImage(named: "ic_user")!
		tfTenDem.placeholder = "Tên đệm (*)"

		applySkyscannerThemeWithIcon(textField: tfHo)
		tfName.iconWidth = 12.5
		tfName.iconType = .image
		tfName.iconImage = UIImage(named: "ic_user")!
		tfName.placeholder = "Tên (*)"

		applySkyscannerThemeWithIcon(textField: tfPhone)
		tfPhone.iconWidth = 12.5
		tfPhone.iconType = .image
		tfPhone.iconImage = UIImage(named: "ic_phone")!
		tfPhone.placeholder = "Số điện thoại (*)"
		tfPhone.keyboardType = .numberPad

		applySkyscannerThemeWithIcon(textField: tfDate)
		tfDate.iconWidth = 12.5
		tfDate.iconType = .image
		tfDate.iconImage = UIImage(named: "ic_calendar")!
		tfDate.placeholder = "Ngày tháng năm sinh (*)"

		applySkyscannerThemeWithIcon(textField: tfEmail)
		tfEmail.iconWidth = 12.5
		tfEmail.iconType = .image
		tfEmail.iconImage = UIImage(named: "ic_mail")!
		tfEmail.placeholder = "Email "

		applySkyscannerThemeWithIcon(textField: tfAddressDefault)
		tfAddressDefault.iconWidth = 12.5 
		tfAddressDefault.iconType = .image
		tfAddressDefault.iconImage = UIImage(named: "ic_map")!
		tfAddressDefault.placeholder = "Địa chỉ thường trú (*)"
		tfAddressDefault.withImage(direction: .right, image: UIImage(named: "right-arrow")!)
		let tapFromField = UITapGestureRecognizer(target: self, action: #selector(self.tapFromAddresDeefault))
		tfAddressDefault.addGestureRecognizer(tapFromField)
		tfAddressDefault.isUserInteractionEnabled = true
		//
		applySkyscannerThemeWithIcon(textField: tfAddress)
		tfAddress.iconWidth = 12.5
		tfAddress.iconType = .image
		tfAddress.iconImage = UIImage(named: "ic_map2")!
		tfAddress.placeholder = "Địa chỉ tạm trú (*)"
		tfAddress.withImage(direction: .right, image: UIImage(named: "right-arrow")!)
		let tapFromField1 = UITapGestureRecognizer(target: self, action: #selector(self.tapFromAddress))
		tfAddress.addGestureRecognizer(tapFromField1)
		tfAddress.isUserInteractionEnabled = true

		applySkyscannerThemeWithIcon(textField: tfIDCard)
		tfIDCard.iconWidth = 12.5
		tfIDCard.iconType = .image
		tfIDCard.iconImage = UIImage(named: "ic_calendar")!
		tfIDCard.placeholder = "Số CMND/CCCD (*)"

		applySkyscannerThemeWithIcon(textField: tfIdCardIssuedDate)
		tfIdCardIssuedDate.iconWidth = 12.5
		tfIdCardIssuedDate.iconType = .image
		tfIdCardIssuedDate.iconImage = UIImage(named: "ic_calendar")!
		tfIdCardIssuedDate.placeholder = "Ngày cấp (*)"

		applySkyscannerThemeWithIcon(textField: tfIdCardIssuedExpiration)
		tfIdCardIssuedExpiration.iconWidth = 12.5
		tfIdCardIssuedExpiration.iconType = .image
		tfIdCardIssuedExpiration.iconImage = UIImage(named: "ic_calendar")!
		tfIdCardIssuedExpiration.placeholder = "Ngày hết hạn (*)"

		applySkyscannerThemeWithIcon(textField: tfIssueBy)
		tfIssueBy.iconWidth = 12.5
		tfIssueBy.iconType = .image
		tfIssueBy.iconImage = UIImage(named: "ic_mail")!
		tfIssueBy.placeholder = "Nơi cấp (*)"
	}
	func applySkyscannerThemeWithIcon(textField: SkyFloatingLabelTextFieldWithIcon) {
		self.applySkyscannerTheme(textField: textField)
		let overcastBlueColor: UIColor = UIColor(named: "primary_green")!
		textField.selectedTitleColor = overcastBlueColor
		textField.selectedLineColor = overcastBlueColor
		textField.iconColor = overcastBlueColor
		textField.selectedIconColor = overcastBlueColor
		textField.iconFont = UIFont(name: "FontAwesome", size: 15)
	}

	func applySkyscannerTheme(textField: SkyFloatingLabelTextField) {
		let overcastBlueColor: UIColor = UIColor(named: "primary_green")!
		textField.tintColor = overcastBlueColor
		textField.selectedTitleColor = overcastBlueColor
		textField.selectedLineColor = overcastBlueColor

	}
	private func setupUI() {
		title = titleNav
		male.delegate = self
		female.delegate = self
		frontIDCardView.controller = self
		frontIDCardView.delegate = self
		backIDCardView.controller = self
		backIDCardView.delegate = self
		anhChanDungView.controller = self
		anhChanDungView.delegate = self
		thueBaoView.controller = self
		thueBaoView.delegate = self
		selecIDCardType.withImage(direction: .right, image: UIImage(named: "down_arrow_ic")!)
		selecIDCardType.placeholder = "Chọn loại CMND"

		let tapFromField = UITapGestureRecognizer(target: self, action: #selector(self.tapFromField))
		tfDate.addGestureRecognizer(tapFromField)
		//        tfDate.isUserInteractionEnabled = false

		let tapFromField2 = UITapGestureRecognizer(target: self, action: #selector(self.tapFromFieldNgayCap))
		tfIdCardIssuedDate.addGestureRecognizer(tapFromField2)
		//        tfIdCardIssuedDate.isUserInteractionEnabled = false

		let tapFromField3 = UITapGestureRecognizer(target: self, action: #selector(self.tapFromFielNgayHetHan))
		tfIdCardIssuedExpiration.addGestureRecognizer(tapFromField3)

		let tapFromField4 = UITapGestureRecognizer(target: self, action: #selector(self.showDropDown))
		selecIDCardType.addGestureRecognizer(tapFromField4)
		selecIDCardType.isUserInteractionEnabled = true

		//FIXME: chèn ảnh vào asset

		//        tfAddress.withImage(direction: .left, image: UIImage(named: "ic_map2")!)
		//        tfIDCard.withImage(direction: .left, image: UIImage(named: "ic_credit_card")!)
		//        tfIdCardIssuedDate.withImage(direction: .left, image: UIImage(named: "ic_calendar")!)
		//        tfIdCardIssuedExpiration.withImage(direction: .left, image: UIImage(named: "ic_calendar")!)
		//        tfIssueBy.withImage(direction: .left, image: UIImage(named:
        tfHo.clearButtonMode = .whileEditing
        tfTenDem.clearButtonMode = .whileEditing
        tfName.clearButtonMode = .whileEditing
        tfDate.clearButtonMode = .whileEditing
        tfIDCard.clearButtonMode = .whileEditing
        tfEmail.clearButtonMode = .whileEditing
		switch flow {
		case "create":
			frontIDCardView.setimage(image: CoreInstallMentData.shared.frontImageIDCard!, isleft: true)
			backIDCardView.setimage(image: CoreInstallMentData.shared.backImageIDCard!, isleft: true)
			tfHo.text = modelFromDetech?.lastName
			tfTenDem.text = modelFromDetech?.middleName
			tfName.text = modelFromDetech?.firstName
			tfDate.text = modelFromDetech?.birthDate
			tfIDCard.text = modelFromDetech?.idCard
                tfIdCardIssuedDate.text = modelFromDetech?.idCardIssuedDate ?? ""
//                tfid.text = modelFromDetech?.idCardIssuedDate ?? ""

			//			tfIdCardIssuedDate.text = modelFromDetech?.idCardIssuedDate
			//			tfIdCardIssuedExpiration.text = modelFromDetech?.idCardIssuedExpiration
			tfIssueBy.text = modelFromDetech?.idCardIssuedBy
		case "edit":
                self.idCardTypeDrop = itemDetail?.idCardType ?? 0
			sexTag = itemDetail?.gender == 0 ? 0 : 1
                gender = itemDetail?.gender == 0 ? 0 : 1
			if itemDetail?.gender == 1 {
				male.setSelect(isSelect: true)
//				onClickRadio(radioView: UIView(), tag: 0)
			} else {
				female.setSelect(isSelect: true)
//				onClickRadio(radioView: UIView(), tag: 1)

			}
			tfHo.text = CoreInstallMentData.shared.editLastName
			tfTenDem.text = CoreInstallMentData.shared.editMiddleName
			tfName.text = CoreInstallMentData.shared.editFirstName
			tfPhone.text = CoreInstallMentData.shared.editPhone
			tfEmail.text = CoreInstallMentData.shared.email
			tfDate.text = CoreInstallMentData.shared.editBirthDate
			tfEmail.text = CoreInstallMentData.shared.editEmail
			tfAddressDefault.text = CoreInstallMentData.shared.editItemDiaChiTT["fullAddress"] as? String
			tfAddress.text = CoreInstallMentData.shared.editItemDiaChiTamTru["fullAddress"] as? String

			//                onClickRadio(radioView: UIView(), tag: sexTag)
			tfIDCard.text = CoreInstallMentData.shared.editIdCard
			tfIdCardIssuedDate.text = CoreInstallMentData.shared.editIdCardIssuedDate
			tfIdCardIssuedExpiration.text = CoreInstallMentData.shared.editIdCardIssuedExpiration
			tfIssueBy.text = CoreInstallMentData.shared.editIdCardIssuedBy
			selecIDCardType.text = itemDetail?.idCardTypeName
			guard let list = itemDetail?.uploadFiles else { return }
			for item in list {
				let url = URL(string: "\(item.urlImage ?? "")")!

				if item.fileType == "IdCardFront" {
					self.setImage(imageFrameCustom: self.frontIDCardView)
					let url = URL(string: item.urlImage ?? "")
					self.frontIDCardView.resultLeftImg.kf.indicatorType = .activity
					self.frontIDCardView.isUserInteractionEnabled = true
					self.frontIDCardView.resultLeftImg.kf.setImage(
						with: url, placeholder: UIImage(named: ""),
						options: [
							.transition(.fade(1)),
							.cacheOriginalImage,
						],
						progressBlock: nil
					) { [weak self] result in
						guard let self = self else { return }
						self.frontIDCardView.isUserInteractionEnabled = true
						switch result {
						case .success(let image):
							self.setImage(imageFrameCustom: self.frontIDCardView)
						case .failure(let error):
							print(error)

						}
					}

				}
				if item.fileType == "IdCardBack" {
					self.setImage(imageFrameCustom: self.backIDCardView)
					let url = URL(string: item.urlImage ?? "")
					self.backIDCardView.resultLeftImg.kf.indicatorType = .activity
					self.backIDCardView.isUserInteractionEnabled = false
					self.backIDCardView.resultLeftImg.kf.setImage(
						with: url, placeholder: UIImage(named: ""),
						options: [
							.transition(.fade(1)),
							.cacheOriginalImage,
						],
						progressBlock: nil
					) { [weak self] result in
						guard let self = self else { return }
						self.backIDCardView.isUserInteractionEnabled = true
						switch result {
						case .success(let image):
							self.setImage(imageFrameCustom: self.backIDCardView)
						case .failure(let error):
							print(error)

						}
					}
				}
				if item.fileType == "SELFIE" {
					self.setImage(imageFrameCustom: self.anhChanDungView)
					let url = URL(string: item.urlImage ?? "")
					self.anhChanDungView.resultLeftImg.kf.indicatorType = .activity
					self.anhChanDungView.isUserInteractionEnabled = false
					self.anhChanDungView.resultLeftImg.kf.setImage(
						with: url, placeholder: UIImage(named: ""),
						options: [
							.transition(.fade(1)),
							.cacheOriginalImage,
						],
						progressBlock: nil
					) { [weak self] result in
						guard let self = self else { return }
						self.anhChanDungView.isUserInteractionEnabled = true
						switch result {
						case .success(let image):
							self.setImage(imageFrameCustom: self.anhChanDungView)
						case .failure(let error):
							print(error)

						}
					}
				}
				if item.fileType == "SIM_CARD_OWNER" {
					self.setImage(imageFrameCustom: self.thueBaoView)
					let url = URL(string: item.urlImage ?? "")
					self.thueBaoView.resultLeftImg.kf.indicatorType = .activity
					self.thueBaoView.isUserInteractionEnabled = false
					self.thueBaoView.resultLeftImg.kf.setImage(
						with: url, placeholder: UIImage(named: ""),
						options: [
							.transition(.fade(1)),
							.cacheOriginalImage,
						],
						progressBlock: nil
					) { [weak self] result in
						guard let self = self else { return }
						self.thueBaoView.isUserInteractionEnabled = true
						switch result {
						case .success(let image):
							self.setImage(imageFrameCustom: self.thueBaoView)
						case .failure(let error):
							print(error)

						}
					}
				}
			}

		default:
			return
		}
	}
	private func setImage(imageFrameCustom: ImageFrameCustom) {
		imageFrameCustom.leftPlaceholderView.isHidden = true
		imageFrameCustom.leftResultView.isHidden = false
		imageFrameCustom.resultLeftImg.layer.masksToBounds = true
	}

	// MARK: - API

	// MARK: - Helpers
	@objc func tapFromField() {
		let datePicker = ActionSheetDatePicker(
			title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(),
			doneBlock: {
				picker, value, index in
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "yyyy-MM-dd"
				let strDate = dateFormatter.string(from: value as! Date)
				self.tfDate.text = "\(strDate)"
				return
			}, cancel: { ActionStringCancelBlock in return }, origin: self.view)
		datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
		datePicker?.maximumDate = Date()
		datePicker?.show()
	}
	@objc func tapFromFieldNgayCap() {
		let datePicker = ActionSheetDatePicker(
			title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(),
			doneBlock: {
				picker, value, index in
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "yyyy-MM-dd"
				let strDate = dateFormatter.string(from: value as! Date)
				self.tfIdCardIssuedDate.text = "\(strDate)"
				return
			}, cancel: { ActionStringCancelBlock in return }, origin: self.view)
		datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
		datePicker?.maximumDate = Date()
		datePicker?.show()
	}
	@objc func tapFromFielNgayHetHan() {
		let datePicker = ActionSheetDatePicker(
			title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(),
			doneBlock: {
				picker, value, index in
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "yyyy-MM-dd"
				let strDate = dateFormatter.string(from: value as! Date)
				self.tfIdCardIssuedExpiration.text = "\(strDate)"
				//            self.valueFromDate = self.formatDate2(date: value as! Date)

				return
			}, cancel: { ActionStringCancelBlock in return }, origin: self.view)
		datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
		//		datePicker?.maximumDate = Date()
		datePicker?.show()
	}
	private func loadTypeOfCart() {

		Provider.shared.coreInstallmentService.getTypeOfIdCard(
			success: { [weak self] result in
				guard let self = self else { return }
				self.itemDropDown = result

			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})
	}

	@objc func showDropDown() {
		dropDownMenu.anchorView = selecIDCardType
		dropDownMenu.bottomOffset = CGPoint(x: 0, y: (dropDownMenu.anchorView?.plainView.bounds.height)! + 10)
		dropDownMenu.dataSource = self.itemDropDown.map({ $0.idCardTypeName ?? "" })
		dropDownMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
		dropDownMenu.selectionAction = { [weak self] (index, item) in
			guard let self = self else { return }
			self.idCardTypeDrop = self.itemDropDown[index].idCardType ?? 0
			self.selecIDCardType.text = "  " + "\(self.itemDropDown[index].idCardTypeName ?? "")"
			switch self
				.flow
			{
			case "create":
				CoreInstallMentData.shared.idCardType = self.itemDropDown[index].idCardType ?? 0
			case "edit":
				CoreInstallMentData.shared.editIdCardType = self.itemDropDown[index].idCardType ?? 0
			default:
				return
			}
		}
		dropDownMenu.show()
	}

	func formatDate2(date: Date) -> String {
		let deFormatter = DateFormatter()
		deFormatter.dateFormat = "yyyy-MM-dd"
		return deFormatter.string(from: date)
	}


	// MARK: - Selectors

	@IBAction func onClickContinue(_ sender: Any) {
		guard validateInputs() else { return }

		switch flow {
		case "create":
                CoreInstallMentData.shared.firstName = tfHo.text ?? ""
                CoreInstallMentData.shared.idCardType = idCardTypeDrop
                CoreInstallMentData.shared.middleName = tfTenDem.text ?? ""
                CoreInstallMentData.shared.lastName = tfName.text ?? ""
                CoreInstallMentData.shared.birthDate = tfDate.text ?? ""
                CoreInstallMentData.shared.email = tfEmail.text ?? ""
                CoreInstallMentData.shared.phone = tfPhone.text ?? ""
                CoreInstallMentData.shared.idCard = tfIDCard.text ?? ""
                CoreInstallMentData.shared.idCardIssuedBy = tfIssueBy.text ?? ""
                CoreInstallMentData.shared.customerInforFromDetechCMND?.idCardIssuedBy = tfIssueBy.text ?? ""
                CoreInstallMentData.shared.idCardIssuedDate = tfIdCardIssuedDate.text ?? ""
                CoreInstallMentData.shared.idCardIssuedExpiration = tfIdCardIssuedExpiration.text ?? ""
			let vc = CreateInfoCompany()
			vc.flow = flow
			self.navigationController?.navigationBar.tintColor = .white
			self.navigationController?.pushViewController(vc, animated: true)
		case "edit":
			editCustomerCoreInnstallment()

		default:
			return
		}

	}
	private func uploadPhoto(fileName: String, image: UIImage, type: String) {
		var idCard = ""
		if flow == "edit" {
			idCard = itemDetail?.idCard ?? ""
		} else {
			idCard = CoreInstallMentData.shared.idCard
		}
		let parameters =
			[
				"fileType": fileName,
				"idCard": idCard,
			] as [String: Any]  //O
		self.loading(isShow: true)
		MultiPartService.uploadPhoto(
			media: image, params: parameters, fileName: fileName,
			handler: { [weak self] result, errer in
				guard let self = self else { return }
				self.loading(isShow: false)
				if result.fileName == "" || result.fileName == nil {
					self.showAlertOneButton(
                        title: "Thông báo", with: errer , titleButton: "OK")
				} else {
					if self.flow == "edit" {
						switch type {
						case "SELFIE":
							CoreInstallMentData.shared.editPathChanDung =
								self.addItemUpload(
									fileName: Common.PrefixUploadImage
										+ (result.fileName ?? ""),
									fileType: result.fileType ?? "",
									urlImage: result.urlImage ?? ""
								)
						case "SIM_CARD_OWNER":
							CoreInstallMentData.shared.editPathIDThueBao =
								self.addItemUpload(
									fileName: Common.PrefixUploadImage
										+ (result.fileName ?? ""),
									fileType: result.fileType ?? "",
									urlImage: result.urlImage ?? ""
								)
						case "IdCardFront":
							CoreInstallMentData.shared.editPathIDCardFront =
								self.addItemUpload(
									fileName: Common.PrefixUploadImage
										+ (result.fileName ?? ""),
									fileType: result.fileType ?? "",
									urlImage: result.urlImage ?? ""
								)

						case "IdCardBack":
							CoreInstallMentData.shared.editPathIDCardBack =
								self.addItemUpload(
									fileName: Common.PrefixUploadImage
										+ (result.fileName ?? ""),
									fileType: result.fileType ?? "",
									urlImage: result.urlImage ?? ""
								)

						default: return

						}
					} else {
						switch type {
						case "SELFIE":
							CoreInstallMentData.shared.pathChanDung = self.addItemUpload(
								fileName: Common.PrefixUploadImage
									+ (result.fileName ?? ""),
								fileType: result.fileType ?? "",
								urlImage: result.urlImage ?? ""
							)
						case "SIM_CARD_OWNER":
							CoreInstallMentData.shared.paththueBao = self.addItemUpload(
								fileName: Common.PrefixUploadImage
									+ (result.fileName ?? ""),
								fileType: result.fileType ?? "",
								urlImage: result.urlImage ?? ""
							)
						case "IdCardFront":
							CoreInstallMentData.shared.pathCMNDfront = self.addItemUpload(
								fileName: Common.PrefixUploadImage
									+ (result.fileName ?? ""),
								fileType: result.fileType ?? "",
								urlImage: result.urlImage ?? ""
							)
						case "IdCardBack":
							CoreInstallMentData.shared.pathCMNDBack = self.addItemUpload(
								fileName: Common.PrefixUploadImage
									+ (result.fileName ?? ""),
								fileType: result.fileType ?? "",
								urlImage: result.urlImage ?? ""
							)
						default: return

						}
					}

				}

				print(result)

			})
	}

	@objc func tapFromNoiCap() {
		let detailViewController = ChoooseThanhPhoVCPopupVC()
		Provider.shared.coreInstallmentService.getListTinhThanh(
			success: { [weak self] result in
				guard let self = self else { return }
				detailViewController.listThanhPho = result
				detailViewController.onSelected = { (value) in
                    if self.flow == "create" {
                        self.tfIssueBy.text = value.name ?? ""
                        CoreInstallMentData.shared.idCardIssuedByCode = value.code ?? ""
                    }else {
                        self.tfIssueBy.text = value.name ?? ""
                        CoreInstallMentData.shared.editIdCardIssuedByCode = value.code ?? ""
                    }

				}
				let nav = UINavigationController(rootViewController: detailViewController)
				nav.modalPresentationStyle = .pageSheet
				if #available(iOS 15.0, *) {
					if let sheet = nav.sheetPresentationController {
						sheet.detents = [.medium(), .large()]
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
	private func addItemUpload(fileName: String, fileType: String, urlImage: String) -> [String: Any] {
		var detail = [String: Any]()
		detail["fileType"] = fileType
		detail["fileName"] = fileName
		detail["urlImage"] = urlImage
		return detail
	}
	@IBAction func selectDiaChiThuongTru(_ sender: Any) {

	}

	//selected male or female
	func onClickRadio(radioView: UIView, tag: Int) {
		if tag != 2 {
            male.setSelect(isSelect: radioView.tag == 0)
			female.setSelect(isSelect: radioView.tag == 1)

		} else if tag == 2 {
			tamtruRadio.setSelect(isSelect: false)
		}
		switch tag {

		case 1:
			if flow == "create" {
				CoreInstallMentData.shared.gender = 0
				gender = 0
			} else if flow == "edit" {
				sexTag = 0
				CoreInstallMentData.shared.editGender = 0
			}
            case 0:
                if flow == "create" {
                    gender = 1
                    CoreInstallMentData.shared.gender = 1
                } else if flow == "edit" {
                    sexTag = 1
                    CoreInstallMentData.shared.editGender = 1
                }
		case 2:
			isFamiliarTT = !isFamiliarTT
			tamtruRadio.setSelect(isSelect: isFamiliarTT)
			print(isFamiliarTT)
			if flow == "create" {
				if isFamiliarTT {  //giong d/c thuong tru
					tfAddress.text = tfAddressDefault.text
					CoreInstallMentData.shared.itemDiaChiTamTru =
						CoreInstallMentData.shared.itemDiaChiThuongTru
					CoreInstallMentData.shared.itemDiaChiTamTru["addressType"] = 2
				} else {
					CoreInstallMentData.shared.itemDiaChiTamTru = [:]
					tfAddress.text = ""
				}
            }else {
                if isFamiliarTT {  //giong d/c thuong tru
                    tfAddress.text = tfAddressDefault.text
                    CoreInstallMentData.shared.editItemDiaChiTamTru =
                    CoreInstallMentData.shared.editItemDiaChiTT
                    CoreInstallMentData.shared.editItemDiaChiTamTru["addressType"] = 2
                } else {
                    CoreInstallMentData.shared.editItemDiaChiTamTru = [:]
                    tfAddress.text = ""
                }
            }

		default:
			self.showAlertOneButton(title: "Thông báo", with: "Lỗi chọn giới tính", titleButton: "OK")
		//			self.showAlertOneButton(title: "Thông báo", with: "Lỗi chọn giới tính", titleButton: "OK")
		}
	}
	func loading(isShow: Bool) {
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
	private func validateInputs() -> Bool {


        guard let name = tfHo.text, !name.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập họ khách hàng", titleButton: "OK")
            return false
        }
        guard let name = tfName.text, !name.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập tên khách hàng", titleButton: "OK")
            return false
        }
        guard let phone = tfPhone.text, !phone.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập SĐT khách hàng", titleButton: "OK")
            return false
        }

        if phone.count != 10 {
            showAlertOneButton(
                title: "Thông báo", with: "Bạn vui lòng nhập thông tin SĐT 10 chữ số", titleButton: "OK"
            )
            return false
        }
        guard let name = tfDate.text, !name.isEmpty else {
            showAlertOneButton(
                title: "Thông báo", with: "Bạn vui lòng nhập chọn ngày", titleButton: "OK"
            )
            return false
        }
		guard let name = tfAddressDefault.text, !name.isEmpty else {
			showAlertOneButton(
				title: "Thông báo", with: "Vui lòng chọn địa chỉ thường trú", titleButton: "OK")
			return false
		}

		guard let name = tfAddress.text, !name.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn địa chỉ tạm trú", titleButton: "OK")
			return false
		}
		guard let name = tfIDCard.text, !name.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Vui nhập số CMND", titleButton: "OK")
			return false
		}
                    if gender == -1 {
                        self.showAlert("Bạn vui lòng chọn giới tính")
                        return false
                    }
        guard let name = selecIDCardType.text, !name.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn loại CMND", titleButton: "OK")
            return false
        }
        if idCardTypeDrop == 0 && tfIDCard.text!.length != 9{
            showAlertOneButton(title: "Thông báo", with: "Chọn sai loại CMND/CCCD", titleButton: "OK")
            return false
        }
        if idCardTypeDrop == 1 && tfIDCard.text!.length != 12{
            showAlertOneButton(title: "Thông báo", with: "Chọn sai loại CMND/CCCD", titleButton: "OK")
            return false
        }
        if idCardTypeDrop == 3 && tfIDCard.text!.length != 12{
            showAlertOneButton(title: "Thông báo", with: "Chọn sai loại CMND/CCCD", titleButton: "OK")
            return false
        }
        if tfIDCard.text!.length != 9 && tfIDCard.text!.length != 12{
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập số CMND/CCCD 9 hoặc 12 số", titleButton: "OK")
            return false
        }
		guard let name = tfIdCardIssuedDate.text, !name.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Vui chọn ngày cấp CMND", titleButton: "OK")
			return false
		}
        guard let name = tfIdCardIssuedExpiration.text, !name.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui chọn ngày hết hạn CMND", titleButton: "OK")
            return false
        }
        guard let name = tfIssueBy.text, !name.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui chọn nơi cấp", titleButton: "OK")
            return false
        }




//		if !Common.isValidEmail(tfEmail.text ?? "") {
//			self.showAlert("Bạn vui lòng nhập thông tin email đúng định dạng")
//			return false
//		}

		if anhChanDungView.resultLeftImg.image == nil {
			self.showAlert("Bạn vui lòng chụp ảnh  chân dung khách hàng")
			return false
		}

		if thueBaoView.resultLeftImg.image == nil {
			self.showAlert("Bạn vui lòng chụp ảnh  thuê bao khách hàng")
			return false
		}
		return true
	}
}

extension DetailCreateCustomer: UITextFieldDelegate {
	func textField(
		_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String
	) -> Bool {
		if textField == tfPhone {
			let allowedCharacters = CharacterSet.decimalDigits
			let characterSet = CharacterSet(charactersIn: string)

			return range.location < 10 && allowedCharacters.isSuperset(of: characterSet)
		}

		return true
	}
}

extension DetailCreateCustomer {
	func didPickImage(_ view: ImageFrameCustom, image: UIImage, isLeft: Bool) {
		if flow == "create" {
			if view == anhChanDungView {
				self.uploadPhoto(
					fileName: "SELFIE", image: anhChanDungView.resultLeftImg.image!, type: "SELFIE")
			} else if view == thueBaoView {
				self.uploadPhoto(
					fileName: "SIM_CARD_OWNER", image: thueBaoView.resultLeftImg.image!,
					type: "SIM_CARD_OWNER")
			} else if view == frontIDCardView {
				self.uploadPhoto(
					fileName: "IdCardFront", image: frontIDCardView.resultLeftImg.image!,
					type: "IdCardFront")
			} else if view == backIDCardView {
				self.uploadPhoto(
					fileName: "IdCardBack", image: backIDCardView.resultLeftImg.image!,
					type: "IdCardBack")
			}
		} else {
			if view == anhChanDungView {
				self.uploadPhoto(
					fileName: "SELFIE", image: anhChanDungView.resultLeftImg.image!, type: "SELFIE")
//				editCustomerCoreInnstallment()
			} else if view == thueBaoView {
				self.uploadPhoto(
					fileName: "SIM_CARD_OWNER", image: thueBaoView.resultLeftImg.image!,
					type: "SIM_CARD_OWNER")
//				editCustomerCoreInnstallment()
			} else if view == frontIDCardView {
				self.uploadPhoto(
					fileName: "IdCardFront", image: frontIDCardView.resultLeftImg.image!,
					type: "IdCardFront")
//				editCustomerCoreInnstallment()

			} else if view == backIDCardView {
				self.uploadPhoto(
					fileName: "IdCardBack", image: backIDCardView.resultLeftImg.image!,
					type: "IdCardBack")
//				editCustomerCoreInnstallment()

			}
		}

	}
}
extension SkyFloatingLabelTextField {
	func setDeFaultInputText(textField: UITextField, text: String, textAttribute: String) {
		let attrs1 = [
			NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13),
			NSAttributedString.Key.foregroundColor: UIColor.systemGray,
		]

		let attrs2 = [
			NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13),
			NSAttributedString.Key.foregroundColor: UIColor.systemPink,
		]

		let attributedString1 = NSMutableAttributedString(string: "\(text)", attributes: attrs1)

		let attributedString2 = NSMutableAttributedString(string: "  (*)", attributes: attrs2)

		attributedString1.append(attributedString2)
		textField.attributedText! = attributedString1
	}
}
