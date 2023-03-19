//
//  EbayService.swift
//  fptshop
//
//  Created by Sang Trương on 08/08/2022.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import DropDown
import UIKit
import WebKit

class ThuHoEbayVC: UIViewController {

	@IBOutlet weak var tfMenu: UITextField!
	@IBOutlet weak var tfProduct: UITextField!
	@IBOutlet weak var tfContractNo: UITextField!
	@IBOutlet weak var tfCMND: UITextField!
	@IBOutlet weak var btnSearchHD: UIButton!
	@IBOutlet weak var btnSearch: UIButton!
	@IBOutlet weak var wvInfo: WKWebView!
	let dropDownMenu = DropDown()
	private var listFinacial: EbayListFinicial?
	private var products = DropDown()
	private var finacialCode: String = ""
	private var finacialName: String = ""

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()

		wvInfo.backgroundColor = .white
		MPOSAPIManager.mpos_FRT_SP_Mirae_noteforsale(type: "3") { (result, err) in
			if result.count > 0 {
				self.wvInfo.loadHTMLString(result, baseURL: nil)
			}
		}
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

	}

	private func setupUI() {
		//MARK: - Test
		//		tfContractNo.text = "6873648626"
		//		tfCMND.text = "517028783300"
		title = "Chi Hộ"
		tfMenu.withImage(direction: .left, image: UIImage(named: "som_menu_icon")!)
		tfProduct.withImage(direction: .left, image: UIImage(named: "som_product_icon")!)
		tfProduct.withImage(direction: .right, image: UIImage(named: "ArrowDown-1")!)
		tfContractNo.withImage(direction: .left, image: UIImage(named: "som_code_icon")!)
		if #available(iOS 13.0, *) {
			tfCMND.withImage(direction: .left, image: (UIImage(systemName: "creditcard.fill")!))
		} else {
			// Fallback on earlier versions
		}
		tfCMND.tintColor = .gray
		tfContractNo.clearButtonMode = .whileEditing
		tfCMND.clearButtonMode = .whileEditing

		let tapSelectedFinacial = UITapGestureRecognizer(target: self, action: #selector(setupDrop))
		tfProduct.isUserInteractionEnabled = true
		tfProduct.addGestureRecognizer(tapSelectedFinacial)
		getlistFinacialEbay()
	}

	@objc func setupDrop() {
		dropDownMenu.anchorView = tfProduct
		dropDownMenu.bottomOffset = CGPoint(x: 0, y: (dropDownMenu.anchorView?.plainView.bounds.height)! + 10)
		dropDownMenu.dataSource = self.listFinacial?.items?.map({ $0.name }) as! [String]
		dropDownMenu.heightAnchor.constraint(equalToConstant: 200).isActive = true
		dropDownMenu.selectionAction = { [weak self] (index, item) in
			self?.finacialCode = self?.listFinacial?.items?[index].code ?? ""
			self?.finacialName = item
			self?.tfProduct.text = item
		}
		dropDownMenu.show()
	}

	private func validateInputs() -> Bool {
        if finacialCode == "" {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn đơn vị tài chính", titleButton: "OK")
            return false
        }

		guard let code = tfContractNo.text, !code.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Vui lòng điền mã hợp đồng", titleButton: "OK")
			return false
		}
		guard let code = tfCMND.text, !code.isEmpty else {
			showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập số CMND/CCCD", titleButton: "OK")
			return false
		}


		return true
	}
	//MARK: - API
	private func getlistFinacialEbay() {

		Provider.shared.ebayService.getListFinancial(
			success: { [weak self] (result) in
				guard let self = self, let response = result else { return }
				self.listFinacial = result
			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})
	}

	private func getInfoCustomer() {

		Provider.shared.ebayService.getFeeEbay(
			financialCode: finacialCode, contractNo: tfContractNo.text!, customerIdNo: tfCMND.text!,
            address: Cache.user!.Address,
			success: { [weak self] (result) in
				guard let self = self, let response = result else { return }
				if result?.error == nil {  //success
					let vc = DetailThuHoEbayVC()
					vc.itemFetch = response
					vc.finacialNAme = self.finacialName
					vc.finacialCode = self.finacialCode

					vc.maHopDong = self.tfContractNo.text!
					vc.soCMND = self.tfCMND.text ?? ""
					self.navigationController?.pushViewController(vc, animated: true)
				} else {  //fail
					self.showAlertOneButton(
						title: "Thông báo", with: result?.error?.message ?? "",
						titleButton: "OK")
				}
			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})
	}

	//MARK: - SELECTOR
	@IBAction func searchHDButtonPressed(_ sender: Any) {

	}

	@IBAction func searchButtonPressed(_ sender: Any) {
		guard validateInputs() else { return }
		getInfoCustomer()

	}
}
