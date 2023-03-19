	//
	//  ChuyenCanMenuVC.swift
	//  QuickCode
	//
	//  Created by Sang Trương on 01/11/2022.
	//


import UIKit
import DropDown
import ActionSheetPicker_3_0
class LichSuDanhGiaVC: UIViewController {
	@IBOutlet weak var chuyenCanLine: UIView!
	@IBOutlet weak var sangKienLine: UIView!
	@IBOutlet weak var fromDateView: UIView!
	@IBOutlet weak var toDateView: UIView!
	@IBOutlet weak var fromDateLabel: UILabel!
	@IBOutlet weak var toDateLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchTextField: UITextField!
	@IBOutlet weak var searchBtn: UIButton!

	var isChuyenCan = true
	let dropDownMenu = DropDown()
	var refresh = UIRefreshControl()
	var listSearchItem:[SearchHistoryEveluateModel] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		searchHistory()
	}
	private func setupUI(){
		self.title = "Lịch sử"
		sangKienLine.backgroundColor = .white
		tableView.registerTableCell(LichSuDanhGiaCell.self)
		searchBtn.setImage(UIImage(named: "hc_search"), for: .normal)
		searchBtn.setTitle("", for: .normal)
		tableView.backgroundColor = .clear
		tableView.separatorStyle = .none
		let gesture = UITapGestureRecognizer(target: self, action: #selector(handleFromDatePressed))
		fromDateView.addGestureRecognizer(gesture)
		fromDateView.isUserInteractionEnabled = true
		let gesture1 = UITapGestureRecognizer(target: self, action: #selector(handleToDatePressed))
		toDateView.addGestureRecognizer(gesture1)
		toDateView.isUserInteractionEnabled = true
		fromDateLabel.text = Common.gettimeWith(format:"dd/MM/YYYY")
		toDateLabel.text =  Common.gettimeWith(format:"dd/MM/YYYY")
	}

		//MARK: - API
	private func validateInputs() -> Bool {
		guard let fr = fromDateLabel.text, fr != "Chọn ngày" else {
			self.showAlert("Bạn vui lòng chọn ngày bắt đầu!")
			return false
		}
		guard let to = toDateLabel.text, to != "Chọn ngày" else {
			self.showAlert("Bạn vui lòng chọn ngày kết thúc!")
			return false
		}
		return true
	}
	private func searchHistory(){
		guard validateInputs() else { return }
		let fromDate  = Common.convertDateToStringWith(dateString: fromDateLabel.text ?? "", formatIn: "dd/MM/yyyy", formatOut: "yyyy-MM-dd")
		let toDate  = Common.convertDateToStringWith(dateString: toDateLabel.text ?? "", formatIn: "dd/MM/yyyy", formatOut: "yyyy-MM-dd")
		Provider.shared.eveluateAPIService.searchHistory(fromDate: fromDate, toDate: toDate, keySearch: searchTextField.text ?? "",type: isChuyenCan ? 1 : 2,success: { [weak self] result in
			guard let self = self else { return }
			if result.count == 0 {
				self.listSearchItem = []
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
				self.showAlertOneButton(title: "Thông báo", with: "Không tìm thấy thông tin", titleButton: "Đồng ý")
			}else {
				self.listSearchItem = result
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}, failure: { [weak self] error in
			guard let self = self else { return }
			self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
		})

	}

	@objc private func handleFromDatePressed(){
		let datePicker = ActionSheetDatePicker(
			title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(),
			doneBlock: {
				picker, value, index in
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "dd/MM/yyyy"
				let strDate = dateFormatter.string(from: value as! Date)
				self.fromDateLabel.text = "\(strDate)"
				return
			}, cancel: { ActionStringCancelBlock in return }, origin: self.view)
		datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
		datePicker?.show()
	}
	@objc private func handleToDatePressed(){
		let datePicker = ActionSheetDatePicker(
			title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(),
			doneBlock: {[weak self] picker, value, index in
				guard let self = self else { return }
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "dd/MM/yyyy"
				let strDate = dateFormatter.string(from: value as! Date)
				self.toDateLabel.text = "\(strDate)"
				return
			}, cancel: { ActionStringCancelBlock in return }, origin: self.view)
		datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
		datePicker?.show()
	}



	private func onSelect(isChuyenCan: Bool) {
		chuyenCanLine.backgroundColor = isChuyenCan ? UIColor.init(hexString: "004329") : .white
		sangKienLine.backgroundColor = !isChuyenCan ? UIColor.init(hexString: "004329") : .white
	}


	@IBAction func onChangeTab(_ sender: UIButton) {
		isChuyenCan = sender.tag == 0
		onSelect(isChuyenCan: sender.tag == 0)
		searchHistory()
	}

	@IBAction func searchBtnOnPressed(_ sender: UIButton) {
		guard validateInputs() else { return }
		self.searchHistory()
	}

}

extension LichSuDanhGiaVC :UITableViewDataSource,UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listSearchItem.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueTableCell(LichSuDanhGiaCell.self)
		cell.backgroundColor = .clear
		cell.selectionStyle = .none
		cell.separatorInset = .zero
		if isChuyenCan {
			cell.bindCellChuyenCan(item:listSearchItem[indexPath.row])
		}else {
			cell.bindCellSangKien(item:listSearchItem[indexPath.row])
		}
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if isChuyenCan {
			let vc = DanhGiaVC()
			vc.idHistory = listSearchItem[indexPath.row].iD ?? 0
			vc.type = isChuyenCan ? 1 : 2
			vc.isFromHistory = true
			vc.loaiDanhGiaString = listSearchItem[indexPath.row].loaiDanhGia ?? ""
			self.navigationController?.pushViewController(vc, animated: true)
		}else {
			let vc = QuestionsViewController()
			vc.idHistory = listSearchItem[indexPath.row].iD ?? 0
			vc.type = isChuyenCan ? 1 : 2
			vc.isHistory = true
			self.navigationController?.pushViewController(vc, animated: true)
		}

	}
}
