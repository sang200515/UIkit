import ActionSheetPicker_3_0
//
//  CreateRelateProfile.swift
//  QuickCode
//
//  Created by Sang Trương on 14/07/2022.
//
import Kingfisher
import Toaster
import UIKit

class CreateRelateProfile: BaseController, RadioCustomDelegate, ImageFrameCustomDelegate {
    @IBOutlet weak var mainStackView: UIStackView!
    var itemDetail: CreateCustomerModel?

        //	func didPickImage(_ view: ImageFrameCustom, image: UIImage, isLeft: Bool) {
	//
	//	}
	var flow: String = ""
	//MARK: - Variable
	var listImgSHK: [String] = []
	var listImgSHKCreate: [String] = []
	var listImageSHKSelected: [UIImage] = []
	private lazy var datePicker: UIDatePicker = {
		let datePicker = UIDatePicker(frame: .zero)

		return datePicker
	}()
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var gplxRadio: RadioCustom!
	@IBOutlet weak var shkRadio: RadioCustom!
	//MARK: - GPLX
	@IBOutlet weak var viewGPLX: UIView!
	@IBOutlet weak var gplxFront: ImageFrameCustom!
	@IBOutlet weak var gplxBack: ImageFrameCustom!
	@IBOutlet weak var tfSoGPLX: UITextField!
	@IBOutlet weak var tfNgayCap: UITextField!
	@IBOutlet weak var tfNoiCap: UITextField!

	//MARK: SHK
	@IBOutlet weak var viewSHK: UIView!
	@IBOutlet weak var tableVewSoHoKhau: UITableView!
	@IBOutlet weak var soSHKTxt: UITextField!
	@IBOutlet weak var hoTenChuHoTxt: UITextField!
	@IBOutlet weak var diaChiThuongTruTxt: UITextField!
	@IBOutlet weak var addNewImgSHKbtn: UIButton!
	var paper: String = ""

//    @IBOutlet weak var heightTableView: NSLayoutConstraint!

	// MARK: - Lifecycle
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.barTintColor = #colorLiteral(
			red: 0.01877964661, green: 0.6705997586, blue: 0.4313761592, alpha: 1)

	}
	override func viewDidLoad() {
		super.viewDidLoad()
        if flow == "create"{

        }else {
            guard let list = itemDetail?.uploadFiles else { return}
            for item in list {
                if item.fileType != "DLFront" && item.fileType != "DLFront"
                    && item.fileType != "IdCardFront" && item.fileType != "IdCardBack" && item.fileType != "SELFIE" && item.fileType != "SIM_CARD_OWNER"  && item.fileType != ""{
//                    heightTableView.constant += CGFloat(190)

                }
            }
        }


		CoreInstallMentData.shared.listSHKImage = []
		if CoreInstallMentData.shared.listSHKImage.count == 0 {
			CoreInstallMentData.shared.listSHKImage.append(contentsOf: [
				addItemUploadSHK(), addItemUploadSHK(), addItemUploadSHK(),
			])
		}
        paper = itemDetail?.relatedDocType ?? ""
		setupUI()
		setupTableViewSHK()
		gplxRadio.setSelect(isSelect: (00 != 0))
		gplxRadio.delegate = self
		shkRadio.delegate = self
		gplxFront.controller = self
		gplxFront.delegate = self
		gplxBack.controller = self
		gplxBack.delegate = self
		let tapFromField = UITapGestureRecognizer(target: self, action: #selector(self.tapFromField))
		tfNgayCap.addGestureRecognizer(tapFromField)
		tfNgayCap.isUserInteractionEnabled = true
		tfNgayCap.addGestureRecognizer(tapFromField)
		tfNgayCap.isUserInteractionEnabled = true
		let tapFromField2 = UITapGestureRecognizer(target: self, action: #selector(self.tapFromField2))
		diaChiThuongTruTxt.withImage(direction: .right, image: UIImage(named: "right-arrow")!)
		diaChiThuongTruTxt.isUserInteractionEnabled = true
		diaChiThuongTruTxt.addGestureRecognizer(tapFromField2)
		viewSHK.isHidden = true
		onClickRadio(radioView: gplxRadio, tag: 0)
	}

	private func setupTableViewSHK() {
		tableVewSoHoKhau.registerTableCell(SoHoKhauCell.self)
	}

	// MARK: - setupUI
	private func uploadPhoto(fileName: String, image: UIImage, isCheck: Bool) {
		loading(isShow: true)
		var idCard = ""
		if flow == "create" {
			idCard = CoreInstallMentData.shared.idCard
		} else {
			idCard = CoreInstallMentData.shared.editIdCard
		}
		let parameters =
			[
				"fileType": fileName,
				"idCard": idCard,
			] as [String: Any]  //O
		MultiPartService.uploadPhoto(
			media: image, params: parameters, fileName: fileName,
			handler: { [weak self] result, errer in
				guard let self = self else { return }
				self.loading(isShow: false)
                if result.fileName == "" || result.fileName == nil{
					self.showAlertOneButton(title: "Thông báo", with: errer, titleButton: "OK")
				} else {
                    if self.flow == "create" {
                        if isCheck {
                            CoreInstallMentData.shared.pathGPLXfront = self.addItemUpload(
                                fileName: result.fileName ?? "",
                                fileType: result.fileType ?? "", urlImage: result.urlImage ?? ""
                            )
                        } else {
                            CoreInstallMentData.shared.pathhGPLXBack = self.addItemUpload(
                                fileName: result.fileName ?? "",
                                fileType: result.fileType ?? "", urlImage: result.urlImage ?? ""
                            )

                        }
                    }else if self.flow == "edit"{
                        if isCheck {
                            CoreInstallMentData.shared.editPathIDDLFront = self.addItemUpload(
                                fileName: result.fileName ?? "",
                                fileType: result.fileType ?? "", urlImage: result.urlImage ?? ""
                            )
                        } else {
                            CoreInstallMentData.shared.editPathIDDLBack = self.addItemUpload(
                                fileName: result.fileName ?? "",
                                fileType: result.fileType ?? "", urlImage: result.urlImage ?? ""
                            )

                        }
                    }


				}

			})
	}
	private func addItemUpload(fileName: String, fileType: String, urlImage: String) -> [String: Any] {
		var detail = [String: Any]()
		detail["fileType"] = fileType
		detail["fileName"] = fileName
		detail["urlImage"] = urlImage
		return detail
	}
	private func addItemUploadSHK() -> [String: Any] {
		var detail = [String: Any]()
		detail["fileType"] = ""
		detail["fileName"] = ""
		detail["urlImage"] = ""
		return detail
	}
    private func setImage(imageFrameCustom: ImageFrameCustom) {
        imageFrameCustom.leftPlaceholderView.isHidden = true
        imageFrameCustom.leftResultView.isHidden = false
        imageFrameCustom.resultLeftImg.layer.masksToBounds = true
    }

	private func setupUI() {
		title = "Giấy tờ liên quan"
		//		viewSHK.isHidden = true
		//		if viewSHK.isHidden == false {
		//			scrollView.isScrollEnabled = false
		//		}
		if #available(iOS 13.4, *) {
			datePicker.preferredDatePickerStyle = .wheels
		} else {
			// Fallback on earlier versions
		}
		tfNgayCap.inputView = datePicker
		datePicker.addTarget(self, action: #selector(tapFromField), for: .valueChanged)
		let tapFromField1 = UITapGestureRecognizer(target: self, action: #selector(self.tapFromNoiCap))
		tfNoiCap.addGestureRecognizer(tapFromField1)
		tfNoiCap.isUserInteractionEnabled = true
		tfSoGPLX.withImage(direction: .left, image: UIImage(named: "ic_credit_card")!)
		tfNgayCap.withImage(direction: .left, image: UIImage(named: "ic_calendar")!)
		tfNoiCap.withImage(direction: .left, image: UIImage(named: "ic_map2")!)
		soSHKTxt.withImage(direction: .left, image: UIImage(named: "ic_credit_card")!)
		hoTenChuHoTxt.withImage(direction: .left, image: UIImage(named: "ic_user")!)
		diaChiThuongTruTxt.withImage(direction: .left, image: UIImage(named: "ic_map2")!)
		if flow == "edit" {

			Toast.init(text: "Đang tải ảnh xuống.Bạn đơi xíu nhé!").show()
			if itemDetail?.relatedDocType == "DL" {  //GPLX
                gplxRadio.setSelect(isSelect: true)
				tfSoGPLX.text = itemDetail?.relatedDocument?.drivingLicNum
				tfNgayCap.text = itemDetail?.relatedDocument?.drivingLicNumDate
				tfNoiCap.text = itemDetail?.relatedDocument?.drivingLicNumBy
				for item in itemDetail?.uploadFiles ?? [] {
					if item.fileType == "DLFront" {
                        self.setImage(imageFrameCustom: self.gplxFront)
                        let url = URL(string: item.urlImage ?? "")
                        self.gplxFront.resultLeftImg.kf.indicatorType = .activity
                        self.gplxFront.isUserInteractionEnabled = false
                            //                let processor = DownsamplingImageProcessor(size: self.frontCMND.resultLeftImg.bounds.size)
                        self.gplxFront.resultLeftImg.kf.setImage(
                            with: url, placeholder: UIImage(named: ""),
                            options: [
                                .transition(.fade(1)),
                                .cacheOriginalImage,
                            ],
                            progressBlock: nil
                        ) { [weak self] result in
                            guard let self = self else { return }
                            self.gplxFront.isUserInteractionEnabled = true
                            switch result {
                                case .success(let image):
                                    self.setImage(imageFrameCustom: self.gplxFront)
                                case .failure(let error):
//                                    self.showAlertOneButton(
//                                        title: "Thông báo", with: error.errorDescription ?? "",
//                                        titleButton: "OK")
                                    print(error)

                            }
                        }
					} else if item.fileType == "DLBack" {
                        self.setImage(imageFrameCustom: self.gplxBack)
                        let url = URL(string: item.urlImage ?? "")
                        self.gplxBack.resultLeftImg.kf.indicatorType = .activity
                        self.gplxBack.isUserInteractionEnabled = false
                            //                let processor = DownsamplingImageProcessor(size: self.frontCMND.resultLeftImg.bounds.size)
                        self.gplxBack.resultLeftImg.kf.setImage(
                            with: url, placeholder: UIImage(named: ""),
                            options: [
                                .transition(.fade(1)),
                                .cacheOriginalImage,
                            ],
                            progressBlock: nil
                        ) { [weak self] result in
                            guard let self = self else { return }
                            self.gplxBack.isUserInteractionEnabled = true
                            switch result {
                                case .success(let image):
                                    self.setImage(imageFrameCustom: self.gplxBack)
                                case .failure(let error):
//                                    self.showAlertOneButton(
//                                        title: "Thông báo", with: error.errorDescription ?? "",
//                                        titleButton: "OK")
                                    print(error)

                            }
                        }
					}
				}

			} else {  //SHK
                shkRadio.setSelect(isSelect: true)
				soSHKTxt.text = itemDetail?.relatedDocument?.houseBookNum
				hoTenChuHoTxt.text = itemDetail?.relatedDocument?.houseBookName
				diaChiThuongTruTxt.text = itemDetail?.relatedDocument?.houseBookAddress
				for item in itemDetail?.uploadFiles ?? [] {
					listImageSHKSelected = []
					if item.fileType != "DLFront" && item.fileType != "DLFront"
						&& item.fileType != "IdCardFront" && item.fileType != "IdCardBack"
						&& item.fileType != "SELFIE" && item.fileType != "SIM_CARD_OWNER"
					{
						listImgSHK.append(item.urlImage ?? "")
					}
				}
			}

		}
	}

	// MARK: - API
	// MARK: - Helpers
	private func addItemDiaChi() -> [String: Any] {
		var detail = [String: Any]()
		detail["drivingLicNum"] = tfSoGPLX.text ?? ""
		detail["drivingLicNumDate"] = tfNgayCap.text ?? ""
		detail["drivingLicNumBy"] = tfNoiCap.text ?? ""
		detail["houseBookNum"] = soSHKTxt.text ?? ""
		detail["houseBookName"] = hoTenChuHoTxt.text ?? ""
		detail["houseBookAddress"] = diaChiThuongTruTxt.text ?? ""
		return detail
	}
	private func isValidEmail(_ email: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

		let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
		return email.isEmpty ? true : emailPred.evaluate(with: email)
	}

	private func validateInputs() -> Bool {
		if paper == "FB" {

			guard let phone = hoTenChuHoTxt.text, !phone.isEmpty else {
				showAlertOneButton(
					title: "Thông báo", with: "Vui lòng nhâp họ tên chủ hộ", titleButton: "OK")
				return false
			}
			guard let name = diaChiThuongTruTxt.text, !name.isEmpty else {
				showAlertOneButton(
					title: "Thông báo", with: "Vui lòng nhập địa chỉ thường trú SHK",
					titleButton: "OK"
				)
				return false
			}
			if CoreInstallMentData.shared.listSHKImage.count < 3 {
				self.showAlert("Bạn vui lòng chụp ít nhất 3 ảnh Sổ hộ khẩu")
				return false
			}

		} else {
			guard let name = tfSoGPLX.text, !name.isEmpty else {
				showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập số GPLX", titleButton: "OK")
				return false
			}

			guard let phone = tfNgayCap.text, !phone.isEmpty else {
				showAlertOneButton(
					title: "Thông báo", with: "Vui lòng chọn ngày cấp GPLX", titleButton: "OK")
				return false
			}
			guard let name = tfNoiCap.text, !name.isEmpty else {
				showAlertOneButton(
					title: "Thông báo", with: "Vui lòng chọn nơi cấp GPLX", titleButton: "OK"
				)
				return false
			}
			if gplxFront.resultLeftImg.image == nil {
				self.showAlert("Bạn vui lòng chụp ảnh  GPLX mặt trước")
				return false
			}
			if gplxBack.resultLeftImg.image == nil {
				self.showAlert("Bạn vui lòng chụp ảnh  GPLX mặt sau")
				return false
			}
		}

		return true
	}

	// MARK: - Selectors
	@objc func tapFromNoiCap() {
		let detailViewController = ChoooseThanhPhoVCPopupVC()
		Provider.shared.coreInstallmentService.getListTinhThanh(
			success: { [weak self] result in
				guard let self = self else { return }
				detailViewController.listThanhPho = result
				detailViewController.onSelected = { (value) in
					self.tfNoiCap.text = value.name ?? ""
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
	@objc func tapFromField() {
		let datePicker = ActionSheetDatePicker(
			title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(),
			doneBlock: {
				picker, value, index in
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "yyyy-MM-dd"
				let strDate = dateFormatter.string(from: value as! Date)
				self.tfNgayCap.text = "\(strDate)"
				//            self.valueFromDate = self.formatDate2(date: value as! Date)

				return
			}, cancel: { ActionStringCancelBlock in return }, origin: self.view)
		datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
		datePicker?.maximumDate = Date()
		datePicker?.show()
	}
	@objc func tapFromField2() {
		let vc = DiaChiThuongTruVC()
		vc.onSelectSuccess = { [weak self] fullAddress in
			guard let self = self else { return }
			self.diaChiThuongTruTxt.text = fullAddress
		}

		//		vc.flow = "shk"
		self.navigationController?.navigationBar.tintColor = .white
		self.navigationController?.pushViewController(vc, animated: true)

	}
	@objc func cancelDatePicker() {
		self.datePicker.endEditing(true)
	}
	@IBAction func chooseAddressBtn(_ sender: Any) {
		let vc = DiaChiThuongTruVC()
		vc.onSelectSuccess = { [weak self] text in
			guard let self = self else { return }
			self.diaChiThuongTruTxt.text = text
		}
		self.navigationController?.navigationBar.tintColor = .white
		self.navigationController?.pushViewController(vc, animated: true)
	}
	@IBAction func addNewImageSHK(_ sender: Any) {

	}
	@IBAction func addNewImgSHK(_ sender: Any) {

		if flow == "create" {
			var a = 1
			listImgSHKCreate.append("a \(a)")
			a += 1
		} else {
			CoreInstallMentData.shared.editListSHKImage.append(addItemUploadSHK())
            Toast.init(text: "Đã thêm thành công trang \( CoreInstallMentData.shared.editListSHKImage.count)").show()

            self.tableVewSoHoKhau.reloadData()
            scrollToBottom()
//            self.heightTableView.constant += CGFloat(190)

//            self.tableVewSoHoKhau.layoutIfNeeded()
//            self.mainStackView.layoutIfNeeded()

		}


	}
   private func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: CoreInstallMentData.shared.editListSHKImage.count - 1, section: 0)
            self.tableVewSoHoKhau.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
	@IBAction func saveInfoCustomer(_ sender: Any) {
		if flow == "create" {
			createCustomerCoreInnstallment()
		} else {

            guard validateInputs() else { return }
            actionEdit()

		}

	}

	func didPickImage(_ view: ImageFrameCustom, image: UIImage, isLeft: Bool) {

		if view == gplxFront {
			guard let gplxFront1 = gplxFront.resultLeftImg.image else { return }
			self.uploadPhoto(fileName: "DLFront", image: gplxFront1, isCheck: true)
		} else if view == gplxBack {
			guard let gplxFBack1 = gplxBack.resultLeftImg.image else { return }
			self.uploadPhoto(fileName: "DLBack", image: gplxFBack1, isCheck: false)

		}
	}

	//MARK: -  API
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
			let relatedDocType = paper
			let company = CoreInstallMentData.shared.editCompanyDetail
			let liistRefPersons = [
				CoreInstallMentData.shared.editItemNguoiLienHe1,
				CoreInstallMentData.shared.editItemNguoiLienHe2,
			]
			let addresses: [[String: Any]] = [
				CoreInstallMentData.shared.editItemDiaChiTT,
				CoreInstallMentData.shared.editItemDiaChiTamTru,
			]
			_ = [
				CoreInstallMentData.shared.editItemNguoiLienHe1,
				CoreInstallMentData.shared.editItemNguoiLienHe2,
			]
			var listUploadFiles: [[String: Any]] = [
				CoreInstallMentData.shared.editPathIDCardFront,
				CoreInstallMentData.shared.editPathIDCardBack,
				CoreInstallMentData.shared.editPathChanDung,
				CoreInstallMentData.shared.editPathIDThueBao,
			]
            let listUploadFilesFilter: [[String: Any]] = [
                CoreInstallMentData.shared.editPathIDCardFront,
                CoreInstallMentData.shared.editPathIDCardBack,
                CoreInstallMentData.shared.editPathChanDung,
                CoreInstallMentData.shared.editPathIDThueBao,
            ]
			if itemDetail?.uploadFiles?.count ?? 0 > 0 {

				if paper == "DL" {
					listUploadFiles.append(CoreInstallMentData.shared.editPathIDDLFront)
					listUploadFiles.append(CoreInstallMentData.shared.editPathIDDLBack)
				} else if paper == "FB"{
					for item in CoreInstallMentData.shared.editListSHKImage {
						if item["urlImage"] as? String != "" {
							listUploadFiles.append(item)
						}

					}
				}

			}
			CoreInstallMentData.shared.ediItemDocument["drivingLicNum"] = tfSoGPLX.text ?? ""
			CoreInstallMentData.shared.ediItemDocument["drivingLicNumDate"] = tfNgayCap.text ?? ""
			CoreInstallMentData.shared.ediItemDocument["drivingLicNumBy"] = tfNoiCap.text ?? ""
			CoreInstallMentData.shared.ediItemDocument["houseBookNum"] = soSHKTxt.text ?? ""
			CoreInstallMentData.shared.ediItemDocument["houseBookName"] = hoTenChuHoTxt.text ?? ""
			CoreInstallMentData.shared.ediItemDocument["houseBookAddress"] = diaChiThuongTruTxt.text ?? ""
			let relatedDocument = CoreInstallMentData.shared.ediItemDocument

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
                    listUploadFiles = listUploadFilesFilter
                    
				},
				failure: { [weak self] error in
					guard let self = self else { return }
                    listUploadFiles = listUploadFilesFilter
					self.loading(isShow: false)
					self.showAlertOneButton(
						title: "Thông báo", with: error.description, titleButton: "OK")
				})
		}
	}
	private func createCustomerCoreInnstallment() {
		//FIXME:thay doi lai param
		guard validateInputs() else { return }
		CoreInstallMentData.shared.itemGPLX = addItemDiaChi()

		let userCode = Cache.user!.UserName
		let idCard = CoreInstallMentData.shared.idCard
		let idCardType = CoreInstallMentData.shared.idCardType
		let email = CoreInstallMentData.shared.email
		let gender = CoreInstallMentData.shared.gender
		let birthDate = CoreInstallMentData.shared.customerInforFromDetechCMND?.birthDate ?? ""
		let idCardIssuedBy = CoreInstallMentData.shared.customerInforFromDetechCMND?.idCardIssuedBy ?? ""
		let idCardIssuedDate = CoreInstallMentData.shared.customerInforFromDetechCMND?.idCardIssuedDate ?? ""
		let idCardIssuedExpiration = CoreInstallMentData.shared.idCardIssuedExpiration
		let phone = CoreInstallMentData.shared.phone
		let relatedDocument = CoreInstallMentData.shared.itemGPLX
		let company = CoreInstallMentData.shared.itemDiaChiCty
		let refPersons = CoreInstallMentData.shared.listNguoiLienHe
		let addresses: [[String: Any]] = [
			CoreInstallMentData.shared.itemDiaChiThuongTru, CoreInstallMentData.shared.itemDiaChiTamTru,
		]

		//lay tu detech model
		let firstName = CoreInstallMentData.shared.customerInforFromDetechCMND?.firstName ?? ""
		let middleName = CoreInstallMentData.shared.customerInforFromDetechCMND?.middleName ?? ""
		let lastName = CoreInstallMentData.shared.customerInforFromDetechCMND?.lastName ?? ""

		let pathCMNDfront = CoreInstallMentData.shared.pathCMNDfront
		let pathCMNDBack = CoreInstallMentData.shared.pathCMNDBack
		let pathChanDung = CoreInstallMentData.shared.pathChanDung
		let paththueBao = CoreInstallMentData.shared.paththueBao
		//       let listChungTuThuNhap  = CoreInstallMentData.shared.listLienHeImage //sai
		let pathGPLXfront = CoreInstallMentData.shared.pathGPLXfront
		let pathhGPLXBack = CoreInstallMentData.shared.pathhGPLXBack
		let listSHKImage = CoreInstallMentData.shared.listSHKImage
		var uploadFiles: [[String: Any]] = [
			pathCMNDfront, pathCMNDBack, pathChanDung, paththueBao, pathGPLXfront, pathhGPLXBack,
		]
		let uploadFilesFilter: [[String: Any]] = [
			pathCMNDfront, pathCMNDBack, pathChanDung, paththueBao,
		]
		if paper == "DL" {
			uploadFiles[4] = pathGPLXfront
			uploadFiles[5] = pathhGPLXBack
		} else {
			uploadFiles.remove(at: 5)
			uploadFiles.remove(at: 4)
			for item in listSHKImage {
				if item["urlImage"] as? String != "" {
					uploadFiles.append(item)
				}

			}
		}

		loading(isShow: true)
		Provider.shared.createCustomerAPIService.createCustomerCoreInstallment(
			userCode: userCode, idCard: idCard, idCardType: idCardType, firstName: firstName,
			middleName: middleName, lastName: lastName, email: email, gender: gender, birthDate: birthDate,
			phone: phone, idCardIssuedBy: idCardIssuedBy, idCardIssuedDate: idCardIssuedDate,
			idCardIssuedExpiration: idCardIssuedExpiration, relatedDocument: relatedDocument,
			company: company, refPersons: refPersons, addresses: addresses, uploadFiles: uploadFiles,
			relatedDocType: paper,
			success: { [weak self] result in
				guard let self = self else { return }
				self.loading(isShow: false)
				print(result)
				if result?.id ?? 0 > 0 {
					CoreInstallMentData.shared.resetParamCreate()
					self.showAlertOneButton(
						title: "Thông báo",
						with:
							"Tạo hồ sơ thành công hồ sơ với số CMND \(CoreInstallMentData.shared.idCard )",
						titleButton: "OK",
						handleOk: {
							let vc = ListInstallentViewController()
							vc.flowSearch = false
							self.navigationController?.navigationBar.tintColor = .white
							self.navigationController?.pushViewController(
								vc, animated: true)
						})
				}

			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.loading(isShow: false)
				uploadFiles = [[:]]
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})

	}
	private func getParamRelatedDocument() {
		var detail: [String: Any] = [:]
		//    https://s3-sgn09.fptcloud.com/detail["ss"]
	}
	@IBAction func onClickContinue(_ sender: Any) {
		let vc = ListInstallentViewController()
		//		self.navigationController?.pushViewController(vc, animated: true)
	}
	func onClickRadio(radioView: UIView, tag: Int) {
		gplxRadio.setSelect(isSelect: radioView.tag == 0)
		shkRadio.setSelect(isSelect: radioView.tag == 1)
		switch radioView.tag {
		case 0:
			addNewImgSHKbtn.isHidden = true
			viewSHK.isHidden = true
			viewGPLX.isHidden = false
			paper = "DL"
		case 1:
			addNewImgSHKbtn.isHidden = false
			viewGPLX.isHidden = true
			viewSHK.isHidden = false
			paper = "FB"
		default:
			return
		}
	}
	func loading(isShow: Bool) {
		let nc = NotificationCenter.default
		if isShow {
			let newViewController = LoadingViewController()
			newViewController.content = "Đang cập nhât thông tin..."
			newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
			newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
			self.navigationController?.present(newViewController, animated: true, completion: nil)
		} else {
			nc.post(name: Notification.Name("dismissLoading"), object: nil)
		}
	}
}
extension CreateRelateProfile: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 170
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if flow == "create" {
			return CoreInstallMentData.shared.listSHKImage.count
		} else {
			return CoreInstallMentData.shared.editListSHKImage.count
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueTableCell(SoHoKhauCell.self)
		if flow == "create" {
			cell.bindCell(mainController: self, index: indexPath.row, flow: flow)
			cell.onCaptureImage = { image, index in
				print(index, image)
			}
		} else {
			cell.bindCellEdit(
				itemEdit: CoreInstallMentData.shared.editListSHKImage[indexPath.row],
				mainController: self, index: indexPath.row, flow: flow)
			cell.onCaptureImage = { image, index in
				print(index, image)

			}
		}

		return cell
	}

}

//class Common {
//	static let resizeImageScanCMND: CGFloat = 0.2
//    static let PrefixUploadImage:String = ""
//}
