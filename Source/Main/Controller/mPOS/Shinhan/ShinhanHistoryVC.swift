	//
	//  ShinhanHistoryVC.swift
	//  fptshop
	//
	//  Created by Ngoc Bao on 02/12/2021.
	//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
	//

import UIKit
import DropDown

class ShinhanHistoryVC: UIViewController {

	@IBOutlet weak var hsCanXulyLbl: UILabel!
	@IBOutlet weak var hsCanXulyLineView: UIView!
	@IBOutlet weak var dsHSLbl: UILabel!
	@IBOutlet weak var dsHSLineView: UIView!
	@IBOutlet weak var dropDownLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var sesarchTxt: UITextField!
	@IBOutlet weak var dropDownView: UIView!

	let dropDownMenu = DropDown()
	let refresh = UIRefreshControl()
	var listOrders: [ShinhanOrderItem] = []
	var filteredListOrders: [ShinhanOrderItem] = []
	var currentTab = 0 //  = 0 ho so can xu ly, = 1 danh sach ho so
	var searchType = 0 // = 0 cmnd, 1 sdt khach hang, 2 mpos
	let searchSource = ["CMND/CCCD", "SĐT khách hàng", "SO MPOS"]
	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.registerTableCell(ShinHanHistoryCell.self)
		tableView.delegate = self
		tableView.dataSource = self
		refresh.addTarget(self, action: #selector(onReload), for: .valueChanged)
		tableView.addSubview(refresh)
		let gesture = UITapGestureRecognizer(target: self, action: #selector(setupDrop))
		dropDownView.addGestureRecognizer(gesture)
		onSelect(isHsCanXuly: true)
		loadData(isHsCanXuly: true)
		dropDownLabel.text = searchSource.first
		sesarchTxt.addTarget(self, action: #selector(onTxtChange), for: .editingChanged)
	}

	@objc func onReload() {
		refresh.endRefreshing()
		loadData(isHsCanXuly: currentTab == 0)
	}

	@objc func onTxtChange() {
		let text = sesarchTxt.text ?? ""
		search(text: text)
	}

	func search(text: String) {
		filteredListOrders = []
		if text == "" {
			filteredListOrders = listOrders
		} else {
			if searchType == 0 {
				filteredListOrders = listOrders.filter({$0.idCard.lowercased().contains(text.lowercased())})
			} else if searchType == 1 {
				filteredListOrders = listOrders.filter({$0.contractNumber.lowercased().contains(text.lowercased())})
			} else {
				filteredListOrders = listOrders.filter({$0.trackingId.lowercased().contains(text.lowercased())})
			}
		}
		self.tableView.reloadData()
	}


	private func onSelect(isHsCanXuly: Bool) {
		currentTab = isHsCanXuly ? 0 : 1
		hsCanXulyLbl.textColor = isHsCanXuly ? .black : .lightGray
		dsHSLbl.textColor = !isHsCanXuly ? .black : .lightGray
		hsCanXulyLineView.backgroundColor = isHsCanXuly ? UIColor(red: 66, green: 133, blue: 107) : .white
		dsHSLineView.backgroundColor = !isHsCanXuly ? UIColor(red: 66, green: 133, blue: 107) : .white
	}

	@objc func setupDrop() {
		dropDownMenu.anchorView = dropDownView
		dropDownMenu.bottomOffset = CGPoint(x: 0, y:(dropDownMenu.anchorView?.plainView.bounds.height)! + 10)
		dropDownMenu.dataSource = searchSource
		dropDownMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
		dropDownMenu.selectionAction = { [weak self] (index, item) in
			self?.dropDownLabel.text = item
			self?.searchType = index
		}
		dropDownMenu.show()
	}

	func loadData(isHsCanXuly: Bool) {
		let type = isHsCanXuly ? "1" : "2"
		Provider.shared.shinhan.loadListHistoryOrder(type: type) { [weak self] result in
			guard let self = self else {return}
			if result?.success ?? false {
				self.listOrders = result?.data ?? []
				self.filteredListOrders = result?.data ?? []
			} else {
				self.showAlert(result?.message ?? "")
			}
			self.tableView.reloadData()
		} failure: { [weak self] error in
			guard let self = self else {return}
			self.showAlert(error.localizedDescription)
			self.tableView.reloadData()
		}

	}


	@IBAction func hsCanxulyAction(_ sender: Any) {
		onSelect(isHsCanXuly: true)
		loadData(isHsCanXuly: true)
	}
	@IBAction func dsHSAction(_ sender: Any) {
		onSelect(isHsCanXuly: false)
		loadData(isHsCanXuly: false)
	}

}


extension ShinhanHistoryVC: UITableViewDelegate,UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredListOrders.count
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueTableCell(ShinHanHistoryCell.self)
		cell.bindCell(item: filteredListOrders[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = DetailShinhanOrder()
		ShinhanData.mposNum = filteredListOrders[indexPath.row].mposSoNum
		vc.type = .detailHistory
		vc.docEntry = filteredListOrders[indexPath.row].docEntry
		ShinhanData.docEntry = filteredListOrders[indexPath.row].docEntry
		ShinhanData.newDocEntry = Int(filteredListOrders[indexPath.row].mposSoNum)  ?? 0
		print(filteredListOrders)
		print(filteredListOrders[indexPath.row].docEntry)
		print(ShinhanData.newDocEntry)
		ShinhanData.soMpos = filteredListOrders[indexPath.row].mposSoNum
		self.navigationController?.pushViewController(vc, animated: true)
	}


}
