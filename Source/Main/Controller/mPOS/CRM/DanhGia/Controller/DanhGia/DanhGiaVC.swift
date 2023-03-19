//
//  DanhGiaVC.swift
//  QuickCode
//
//  Created by Sang Trương on 01/11/2022.
//

import Foundation
import ObjectMapper
import SwiftyJSON
import UIKit

class DanhGiaVC: UIViewController {
	//MARK: - Variable
	var idHistory: Int = 0
	var type: Int = 0
	var isFromHistory: Bool = false
	var isHiddenTableViewDanhGia = true
	//	var masterDataObject:EvaluateMasterDataModel?
	var employeeSelected: CustomerEveluateModel?
	var loaiDanhGia: Int = 1
	var loaiUser:String = ""
	var loaiDanhGiaString: String = ""
	private var hangMuc: String = ""
	private let viewmodel = DanhGiaViewModel()
	//MARK: - Properties
	@IBOutlet weak var mainStackView: UIStackView!
	@IBOutlet weak var childStackView: UIStackView!
	@IBOutlet weak var tableView: UITableViewAutoHeight!
	@IBOutlet weak var tableViewDanhGia: UITableViewAutoHeight!

	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var levelTextField: UITextField!
	@IBOutlet weak var explainTextField: UITextView!
	@IBOutlet weak var saveButton: UIButton!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var cuaHangTitleLabel: UILabel!
	@IBOutlet weak var cuaHangTextField: UITextField!

	private var placeholderLabel: UILabel!

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		bindViewModel()

	}
	// MARK: - API
	private func bindViewModel() {
		//		self.masterDataObject = viewmodel.masterDataObject
		viewmodel.loadMasterData { [weak self] result in
			guard let self = self else { return }
			if result != "" {
				self.showAlert(result)
				return
			}
			DispatchQueue.main.async {
				self.tableView.reloadData()
				self.tableViewDanhGia.reloadData()
			}
		}
		if isFromHistory {
			self.viewmodel.loadDetailHistory(id: idHistory, type: type) { [weak self] result, message in
				guard let self = self else { return }
				if message != "" {
					self.showAlertOneButton(
						title: "Thông báo", with: message, titleButton: "Đồng ý")
				} else {
					//starting mapping from history
					self.nameTextField.text = result.tenNhanVien ?? ""
					self.saveButton.isHidden = true
					self.tableView.isUserInteractionEnabled = false
					self.levelTextField.text = result.capDoDichVu ?? ""
					self.levelTextField.isUserInteractionEnabled = false
					self.explainTextField.text = result.lyDo ?? ""
					self.explainTextField.isUserInteractionEnabled = false
					self.descriptionLabel.isHidden = true
					if self.loaiDanhGiaString == "Đối tác" {
						self.cuaHangTitleLabel.isHidden = false
						self.cuaHangTextField.isHidden = false
					}
					self.cuaHangTextField.text = result.PhongBan ?? ""
					let model = self.viewmodel.masterDataObject?.hangMucGiaTri
					result.hangMucGiaTri?.forEach({ item in

						if Int(item) ?? 0 <= model?.count ?? 0 {
							if (Int(item) ?? 0) > 0 {
								model?[(Int(item) ?? 0) - 1].isSelected = true
							} else {
								model?[(Int(item) ?? 0)].isSelected = true
							}
						}
					})
					DispatchQueue.main.async {
						self.tableView.reloadData()
					}
				}
			}
		} else {
			createPlaceholderForTextView()
		}
	}

	// MARK: - Helpers
	private func createPlaceholderForTextView() {
		explainTextField.delegate = self
		placeholderLabel = UILabel()
		placeholderLabel.text = "Nhập lý do"
		placeholderLabel.font = UIFont.systemFont(ofSize: 13)
		placeholderLabel.sizeToFit()
		explainTextField.addSubview(placeholderLabel)
		placeholderLabel.frame.origin = CGPoint(x: 8, y: 6)
		placeholderLabel.textColor = UIColor.gray
		placeholderLabel.isHidden = !explainTextField.text.isEmpty
	}
	private func setupUI() {
		self.explainTextField.layer.cornerRadius = 5
		self.tableView.registerTableCell(EveluateSelectCell.self)
		self.tableViewDanhGia.registerTableCell(CapDichVuCell.self)
		tableView.allowsMultipleSelection = true
		tableView.isScrollEnabled = false
		tableViewDanhGia.isScrollEnabled = false
		tableViewDanhGia.separatorStyle = .singleLineEtched
		let tapFromField = UITapGestureRecognizer(target: self, action: #selector(self.selectedFieldEmployee))
		nameTextField.addGestureRecognizer(tapFromField)
		nameTextField.isUserInteractionEnabled = false
		let tapFieldDanhGia = UITapGestureRecognizer(target: self, action: #selector(self.hiddenTableView))
		levelTextField.addGestureRecognizer(tapFieldDanhGia)
		levelTextField.isUserInteractionEnabled = true
		if type == 1 {
			cuaHangTitleLabel.isHidden = true
			cuaHangTextField.isHidden = true
			nameTextField.isUserInteractionEnabled = true
		} else {
			cuaHangTitleLabel.isHidden = true
			cuaHangTextField.isHidden = true
			nameTextField.isUserInteractionEnabled = true
			cuaHangTitleLabel.isHidden = false
			cuaHangTextField.isHidden = false
		}
		cuaHangTextField.isUserInteractionEnabled = false
		//		self.nameTextField.isUserInteractionEnabled = false
		self.nameTextField.text = employeeSelected?.fullName ?? ""
	}

	// MARK: - Selectors
	@objc private func hiddenTableView() {
		if isHiddenTableViewDanhGia {
			isHiddenTableViewDanhGia = false
			self.tableViewDanhGia.isHidden = false

		} else {
			isHiddenTableViewDanhGia = true
			self.tableViewDanhGia.isHidden = true
		}

	}
	private func prepareParams() {
		hangMuc = ""
		let model = viewmodel.masterDataObject?.hangMucGiaTri
		for item in 0..<(model?.count ?? 0) {
			if model![item].isSelected == true {
				hangMuc.append("\(item + 1),")
			}
		}

		print(hangMuc)

	}
	private func validateHangMuc() -> Bool {
		var vld: Bool = false
		let model = viewmodel.masterDataObject?.hangMucGiaTri
		model?.forEach({ item in
			if item.isSelected == true {
				vld = true
			}
		})
		return vld
	}
	private func validateInput() -> Bool {
		guard let text = nameTextField.text, !text.isEmpty else {
			self.showAlert("Vui lòng chọn nhân viên bạn muốn đánh giá!")
			return false
		}
		guard validateHangMuc() else {
			self.showAlert("Vui lòng hạng mục bạn muốn đánh giá!")
			return false
		}
		guard let text1 = levelTextField.text, !text1.isEmpty else {
			self.showAlert("Vui lòng chọn cấp độ dịch vụ!")
			return false
		}
		guard let text2 = explainTextField.text, !text2.isEmpty else {
			self.showAlert("Vui lòng nhập lý do!")
			return false
		}
		return true
	}
	@IBAction func saveButton(_ sender: Any) {
		prepareParams()
		guard validateInput() else { return }
		viewmodel.doneEvaluate(
			loaiDanhGia: loaiDanhGia, nhanVien: self.nameTextField.text ?? "",
			cuaHangPhongBan: employeeSelected?.phongBan ?? "", hangMucGiaTri: String(hangMuc.dropLast()),
			capDoDichVu: levelTextField.text ?? "", lyDo: explainTextField.text ?? "",
			completion: { [weak self] (isSuccess, message) in
				guard let self = self else { return }
				if isSuccess {
					self.showAlertWithColorTitle(
						colorTitle: #colorLiteral(
							red: 0.1000433043, green: 0.7216904759, blue: 0.3567974567,
							alpha: 1), titleAlert: "Thông báo", with: message,
						titleButton: "Đồng ý",
						handleOk: {
							for vc in self.navigationController?.viewControllers ?? [] {
								if vc is ChuyenCanMenuVC {
									self.navigationController?.popToViewController(
										vc, animated: true)
								}
							}
						})
				} else {
					self.showAlertWithColorTitle(
						colorTitle: #colorLiteral(
							red: 0.9366106391, green: 0.06401697546, blue: 0.06735169142,
							alpha: 1), titleAlert: "Thông báo", with: message,
						titleButton: "Đồng ý")
				}
			})
	}

	@objc private func selectedFieldEmployee() {
		let vc = ChonNhanVienVC()
		vc.loaiDanhGia = self.loaiDanhGia
		vc.typeUser = self.loaiUser
		vc.isSM = true
		vc.onSelectedEmployee = { [weak self] result in
			guard let self = self else { return }
			self.employeeSelected = result
			self.nameTextField.text = self.employeeSelected?.fullName ?? ""
			if self.type == 2 {
				self.cuaHangTextField.text = result.phongBan ?? ""
				self.cuaHangTextField.isHidden = false
				self.cuaHangTitleLabel.isHidden = false
			}
		}
		self.navigationController?.pushViewController(vc, animated: true)
	}

}
extension DanhGiaVC: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableView == self.tableView {
			return viewmodel.masterDataObject?.hangMucGiaTri?.count ?? 0
		} else {
			return viewmodel.masterDataObject?.capDoDichVu?.count ?? 0
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if tableView == self.tableView {
			let cell = tableView.dequeueTableCell(EveluateSelectCell.self)
			if let model = viewmodel.masterDataObject?.hangMucGiaTri?[indexPath.row] {
				cell.bindCell(item: model, indexPath: indexPath.row)
			}
			cell.selectionStyle = .none
			//		cell.
			return cell
		} else {
			let cell = tableView.dequeueTableCell(CapDichVuCell.self)
			if let model = viewmodel.masterDataObject?.capDoDichVu?[indexPath.row] {
				cell.titleLabel?.text = model.text ?? ""
				cell.noteLabel?.text = model.note ?? ""
			}

			return cell
		}
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if tableView == self.tableViewDanhGia {
			if let model = viewmodel.masterDataObject?.capDoDichVu?[indexPath.row] {
				levelTextField.text = model.text ?? ""
				DispatchQueue.main.async {
					self.isHiddenTableViewDanhGia = true
					self.tableViewDanhGia.isHidden = true
				}
			}
		} else {
			if let model = viewmodel.masterDataObject?.hangMucGiaTri?[indexPath.row] {
				if model.isSelected == true {
					model.isSelected = false
				} else {
					model.isSelected = true
				}
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}

		}
	}

}
class UITableViewAutoHeight: UITableView {

	override var contentSize: CGSize {
		didSet {
			invalidateIntrinsicContentSize()
		}
	}

	override var intrinsicContentSize: CGSize {
		layoutIfNeeded()
		return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		self.separatorStyle = .none
		self.showsVerticalScrollIndicator = false
		//        TableViewHelper.EmptyMessage(message: "Không có dữ liệu", viewController: self)
	}

}
extension DanhGiaVC: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		placeholderLabel.isHidden = !textView.text.isEmpty
	}
}
