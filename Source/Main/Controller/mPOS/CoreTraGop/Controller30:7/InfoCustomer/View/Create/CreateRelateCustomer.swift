//
//  CreateRelateCustomer.swift
//  QuickCode
//
//  Created by Sang Trương on 14/07/2022.
//

import Toaster
import UIKit

class CreateRelateCustomer: BaseController {
	//MARK: - Variable
	var flow: String = ""
	var itemDetail: CreateCustomerModel?
	//MARK: - Properties
	@IBOutlet weak var btnSave: UIButton!
	@IBOutlet weak var btnAddMore: UIButton!
	@IBOutlet weak var tableView: UITableView!

	// MARK: - Lifecycle
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.barTintColor = #colorLiteral(
			red: 0.01877964661, green: 0.6705997586, blue: 0.4313761592, alpha: 1)

	}
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		tableView.registerTableCell(NguoiLienHeCell.self)
		title = "thông tin người liên hệ"
	}

	// MARK: - setupUI
	private func setupUI() {
		title = "Thông tin khách hàng"
		//        guard CoreInstallMentData.shared.listNguoiLienHe.count == 2 else { return }

		if flow == "edit" {
			btnSave.setTitle("Cập nhật thông tin", for: .normal)
			btnAddMore.isHidden = true
		} else {
			CoreInstallMentData.shared.listNguoiLienHe.removeAll()
			if CoreInstallMentData.shared.listNguoiLienHe.count == 0 {
				CoreInstallMentData.shared.listNguoiLienHe.append(addItemListNguoiLienHe(personNum: 1))
				CoreInstallMentData.shared.listNguoiLienHe.append(addItemListNguoiLienHe(personNum: 2))
			}
		}
	}

	@IBAction func addNewRelatePerson(_ sender: Any) {

//		if CoreInstallMentData.shared.listNguoiLienHe.count == 1 {
//			CoreInstallMentData.shared.listNguoiLienHe.append(addItemListNguoiLienHe(personNum: 2))
//		} else if CoreInstallMentData.shared.listNguoiLienHe.count == 2 {
//			CoreInstallMentData.shared.listNguoiLienHe.append(addItemListNguoiLienHe(personNum: 3))
//		} else {
//			self.showAlertOneButton(
//				title: "Thông báo", with: "Bạn chỉ thêm được tối đa 3 người liên hệ", titleButton: "OK")
//		}
//		tableView.reloadData()
	}

	// MARK: - API
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
			let company = CoreInstallMentData.shared.editCompanyDetail
			let liistRefPersons = [
				CoreInstallMentData.shared.editItemNguoiLienHe1,
				CoreInstallMentData.shared.editItemNguoiLienHe2,
			]
			let addresses: [[String: Any]] = [
				CoreInstallMentData.shared.editItemDiaChiTT,
				CoreInstallMentData.shared.editItemDiaChiTamTru,
			]
			let listChungTuThuNhap = [
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
		} else {
			let vc = CreateRelateProfile()
			vc.flow = flow
			self.navigationController?.pushViewController(vc, animated: true)
		}
	}
	// MARK: - Helpers
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
	//FIXME: add param
	private func addItemListNguoiLienHe(personNum: Int) -> [String: Any] {
		var detail = [String: Any]()
		detail["fullName"] = ""
		detail["relationshipCode"] = ""
		detail["relationshipName"] = ""
		detail["personNum"] = personNum
		detail["phone"] = ""
		return detail
	}
	private func isValidEmail(_ email: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

		let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
		return email.isEmpty ? true : emailPred.evaluate(with: email)
	}

	// MARK: - Selectors

	@IBAction func onClickContinue(_ sender: Any) {
		guard validateInput() else { return }
		if flow == "create" {
            let vc = CreateRelateProfile()
            vc.flow = flow
            self.navigationController?.pushViewController(vc, animated: true)
		} else {
			actionEdit()
		}

	}
	private func validateInput() -> Bool {

        var success: Bool = true
		if flow == "create" {
            success = true
			for item in CoreInstallMentData.shared.listNguoiLienHe {
				for i in item {
					if i.key != "personNum" {
						if i.value as! String == "" {
							self.showAlertOneButton(
								title: "Thông báo",
								with:
									"Bạn vui lòng nhập đầy đủ thông tin người liên hệ.",
                                titleButton: "OK")
                            success = false
                            break

						}
					}
				}

			}
            for item in CoreInstallMentData.shared.listNguoiLienHe {
                for i in item {
                    if i.key == "phone" {
                        if (i.value as! String).count != 10 {
                            self.showAlertOneButton(
                                title: "Thông báo",
                                with:
                                    "Bạn vui lòng đủ 10 số điện thoại.",
                                titleButton: "OK")
                            success = false
                            break

                        }
                    }
                }

            }
            return success
		} else {
			for item in CoreInstallMentData.shared.editItemListNguoiLienHe {
				print(item)
				for i in item {
					if i.key != "personNum" {
						if i.value as! String != "" {
							success = true
							continue
						} else {
							success = false
							self.showAlertOneButton(

                                
								title: "Thông báo",
								with:
									"Bạn vui lòng nhập đầy đủ thông tin người liên hệ trước khi lưu.",
								titleButton: "OK")
						}
					}
				}

                    for i in CoreInstallMentData.shared.editItemNguoiLienHe1 {
                        if i.key == "phone" {
                            if (i.value as! String).count != 10 {
                                self.showAlertOneButton(
                                    title: "Thông báo",
                                    with:
                                        "Bạn vui lòng đủ 10 số điện thoại nggười liên hệ 1.",
                                    titleButton: "OK")
                                success = false
                                break

                            }
                        }
                    }

                    for i in CoreInstallMentData.shared.editItemNguoiLienHe2 {
                        if i.key == "phone" {
                            if (i.value as! String).count != 10 {
                                self.showAlertOneButton(
                                    title: "Thông báo",
                                    with:
                                        "Bạn vui lòng đủ 10 số điện thoại nggười liên hệ 2.",
                                    titleButton: "OK")
                                success = false
                                break

                            }
                        }
                    }
				return success
			}

		}
		return success
	}
}

extension CreateRelateCustomer: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 230
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch flow {
		case "create":
			return CoreInstallMentData.shared.listNguoiLienHe.count
		case "edit":
			return CoreInstallMentData.shared.editItemListNguoiLienHe.count
		default:
			return CoreInstallMentData.shared.listNguoiLienHe.count
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueTableCell(NguoiLienHeCell.self)
		switch flow {
		case "create":
			cell.bindCell(
				item: CoreInstallMentData.shared.listNguoiLienHe[indexPath.row], index: indexPath.row,
				controller: self, flow: flow)
			cell.selectionStyle = .none
			cell.backgroundColor = .clear
		case "edit":
			cell.bindCell(
				item: CoreInstallMentData.shared.editItemListNguoiLienHe[indexPath.row],
				index: indexPath.row,
				controller: self, flow: flow)
			cell.selectionStyle = .none
			cell.backgroundColor = .clear
		default:
			return cell
		}

		return cell
	}
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 230
	}

}
