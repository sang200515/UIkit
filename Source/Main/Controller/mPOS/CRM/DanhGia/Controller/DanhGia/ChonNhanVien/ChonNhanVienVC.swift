	//
	//  ChonNhanVienVC.swift
	//  QuickCode
	//
	//  Created by Sang Trương on 01/11/2022.
	//

import DropDown
import Foundation
import SwiftyJSON
import UIKit

class ChonNhanVienVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

	var listEmployee: [CustomerEveluateModel] = []
	var onSelectedEmployee: ((CustomerEveluateModel) -> Void)?
		//MARK: - Properties
	let dropDownMenu = DropDown()
	private let viewmodel = ChonNhanVienViewModel()
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var tableViewShop: UITableView!
	@IBOutlet weak var employeeTextField: UITextField!
	@IBOutlet weak var parentSelectedView: UIView!
	@IBOutlet weak var selectedTitleLabel: UILabel!
	@IBOutlet weak var searchButton: UIButton!
	@IBOutlet weak var shopDescriptionLabel: UILabel!
	@IBOutlet weak var dropDownView: UIView!
	@IBOutlet weak var nameLabel: UILabel!
	var loaiDanhGia: Int = 1
	var typeSearch: String = ""
	var typeUser: String = ""
	var shopCodeSelected: String = ""
	var isSM:Bool = false
	var listItemShop:[ListShopDanhGiaModel] = []
		// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
//		typeSearch = ""
	}
		// MARK: - API
	private func getListShop(selectTypeFromDropDown:String) {
		var typeParam :String = ""
		if selectTypeFromDropDown == "Shop"{
			if self.typeUser == "ASM" || self.typeUser == "RSM" {
				typeParam = "Shop"
			}
		}else if selectTypeFromDropDown == "ASM"{
			if self.typeUser == "RSM" {
				typeParam = "ASM"
			}
		}
		Provider.shared.eveluateAPIService.loadListShopOrASM(
			type: typeParam,
			success: { [weak self] result in
				guard let self = self else { return }
				if result.first?.Message ?? "" != "" {
					self.showAlert(result.first?.Message ?? "")
				}else {
//					self.listItemShop = result
//					self.shouldHiddenTableShop(isHidden: false)
//					self.tableViewShop.reloadData()
					self.showPopupSelectShop(listShop: result)
				}
			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlert(error.description)
			})
	}

		// MARK: - Selectors

	@IBAction func searchAction(_ sender: Any) {
		if typeUser == "RSM" {
			guard typeSearch != "" else { return self.showAlert("Vui lòng chọn loại tìm kiếm!") }
		}
		let completion: ChonNhanVienViewModel.completionSearchEmployee = { [weak self] result in
			guard let self = self else { return }
			switch result {
				case .message(let message):
					if message != "" {
						self.showAlert(message)
					}
					DispatchQueue.main.async {
						self.tableViewShop.isHidden = true
						self.tableView.isHidden = false
						self.tableView.reloadData()
					}
			}
		}
		if isSM {
			shopCodeSelected = Cache.user!.ShopCode
			self.typeSearch = "Shop"
		}
		if self.typeUser == "BO" {
			self.typeSearch = "BO"
		}
		viewmodel.searchEmployee(
			loaiDanhGia: loaiDanhGia, typeSearch: typeSearch, keySearch: employeeTextField.text ?? "",
			shopCode: typeSearch == "ASM" ? "Shop" : shopCodeSelected, completion: completion)
	}

	@objc func setupDrop() {
		let listDataSource = ["ASM", "Shop"]
		dropDownMenu.anchorView = self.parentSelectedView
		dropDownMenu.bottomOffset = CGPoint(x: 0, y: 45)
		dropDownMenu.dataSource = listDataSource
		dropDownMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
		dropDownMenu.selectionAction = { [unowned self] (index, item) in
			self.selectedTitleLabel.text = listDataSource[index]
			switch index {
				case 0:
					self.typeSearch = item
//					self.getListShop(selectTypeFromDropDown:item)
					self.shouldHiddenTableShop(isHidden: false)
				case 1:
					self.selectedTitleLabel.text = "ASM"
					self.getListShop(selectTypeFromDropDown:item)
//					self.shouldHiddenTableShop(isHidden: true)
//					self.showPopupSelectShop()
				default:
					return
			}
		}
		dropDownMenu.show()
	}
	private func showPopupSelectShop(listShop:[ListShopDanhGiaModel]){
		let detailViewController = PopupChonShopVC()
		detailViewController.listShop = listShop
		detailViewController.onSelected = { [weak self] result in
			guard let self = self else { return }
			self.dropDownView.isHidden = true
			self.nameLabel.isHidden = false
			self.nameLabel.text = "\(result.warehouseCode ?? "") - \(result.warehouseName ?? "")"
			self.employeeTextField.placeholder = "Nhập mã inside/Tên/Email"
			self.tableViewShop.isHidden = true
			self.shopDescriptionLabel.isHidden = true
			self.shopCodeSelected = result.warehouseCode ?? ""
			self.tableView.isHidden = true
			self.employeeTextField.text = ""
			self.typeSearch = "Shop"
		}
		detailViewController.didSelectedItem = { [weak self] isSelected in
			guard let self = self else { return }
			if isSelected == false {
				self.navigationController?.popViewController(animated: true)
			}
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
		}
		self.present(nav, animated: true, completion: nil)
	}
		// MARK: - Helpers
	private func shouldHiddenTableShop(isHidden:Bool){
		if isHidden {
			self.tableViewShop.isHidden = false
			self.shopDescriptionLabel.isHidden = false
			self.tableView.isHidden = true
		}else {
			self.tableViewShop.isHidden = true
			self.shopDescriptionLabel.isHidden = true
			self.tableView.isHidden = false
		}
	}
	private func setupUI() {
		self.title = "Đánh giá Nhân Viên"
		tableView.registerTableCell(EmployeeTBVCell.self)
		tableViewShop.registerTableCell(ItemShoporASMCell.self)

		tableView.backgroundColor = .clear
		tableView.separatorStyle = .none
		tableView.dataSource = self
		tableView.delegate = self
		tableViewShop.backgroundColor = .clear
		tableViewShop.separatorStyle = .none
		tableViewShop.dataSource = self
		tableViewShop.delegate = self

		employeeTextField.delegate = self
		searchButton.setImage(UIImage(named: "hc_search"), for: .normal)
		searchButton.setTitle("", for: .normal)
		parentSelectedView.isUserInteractionEnabled = true
		let gesture = UITapGestureRecognizer(target: self, action: #selector(setupDrop))
		parentSelectedView.addGestureRecognizer(gesture)
		self.nameLabel.isHidden = true

		if isSM{
			self.dropDownView.isHidden = true
			self.employeeTextField.placeholder = "Nhập mã inside/Tên/Email"
			self.tableViewShop.isHidden = true
			self.tableView.isHidden = false
			self.shopDescriptionLabel.isHidden = true
		}
		if typeUser == "ASM" {
			self.getListShop(selectTypeFromDropDown:"Shop")
			self.shouldHiddenTableShop(isHidden: true)
			self.dropDownView.isHidden = true
			self.nameLabel.isHidden = false
		}
	}

		// MARK: - UITableViewDataSource
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableView == self.tableView {
			return viewmodel.listEmployee.count
		}else {
			return listItemShop.count
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if tableView == self.tableView {
			let cell = tableView.dequeueTableCell(EmployeeTBVCell.self)
			cell.bindCell(item: viewmodel.listEmployee[indexPath.row])
			return cell
		} else {
			if listItemShop.count > 0{
				let cell = tableView.dequeueTableCell(ItemShoporASMCell.self)
				cell.bindCell(item: listItemShop[indexPath.row])
				return cell
			}
			return UITableViewCell()
		}

	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if tableView == self.tableView {
			let model = viewmodel.listEmployee[indexPath.row]
			if self.loaiDanhGia == 2{
				if let select = onSelectedEmployee {
					select(	model)
					self.navigationController?.popViewController(animated: true)
				}
			}else {
				let vc = DanhGiaVC()
				vc.type = 1
				vc.loaiDanhGia = 1
				vc.employeeSelected = model
				self.navigationController?.pushViewController(vc, animated: true)
			}

		} else {
			let model = self.listItemShop[indexPath.row]
			self.dropDownView.isHidden = true
			self.nameLabel.isHidden = false
			self.nameLabel.text = "\(model.warehouseCode ?? "") - \(model.warehouseName ?? "")"
			self.employeeTextField.placeholder = "Nhập mã inside/Tên/Email"
			self.tableViewShop.isHidden = true
			self.shopDescriptionLabel.isHidden = true
			self.shopCodeSelected = model.warehouseCode ?? ""
			self.tableView.isHidden = true
			self.employeeTextField.text = ""
		}


	}
}
extension ChonNhanVienVC: UITextFieldDelegate {

}
