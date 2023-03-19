//
//  ThuHoSOMSearchOrderViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 31/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import WebKit
import DropDown

class ThuHoSOMSearchOrderViewController: UIViewController {

    @IBOutlet weak var tfMenu: UITextField!
    @IBOutlet weak var tfProduct: UITextField!
    @IBOutlet weak var tfCode: UITextField!
    @IBOutlet weak var btnSearchHD: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var wvInfo: WKWebView!
	var isAIA:Bool = false
    private var products = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        configureDropdown()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ThuHoSOMDataManager.shared.resetParam()
    }
    
    private func setupUI() {
        title = "Thu Hộ"
        addBackButton()
        
        btnSearchHD.roundCorners(.allCorners, radius: 5)
        btnSearch.roundCorners(.allCorners, radius: 5)
        tfMenu.withImage(direction: .left, image: UIImage(named: "som_menu_icon")!)
        tfProduct.withImage(direction: .left, image: UIImage(named: "som_product_icon")!)
        tfProduct.withImage(direction: .right, image: UIImage(named: "ArrowDown-1")!)
        tfCode.withImage(direction: .left, image: UIImage(named: "som_code_icon")!)
        
        wvInfo.backgroundColor = .white
        MPOSAPIManager.mpos_FRT_SP_Mirae_noteforsale(type: "3") { (result, err) in
            if result.count > 0 {
                self.wvInfo.loadHTMLString(result, baseURL: nil)
            }
        }
    }
    
    private func loadData() {
        tfMenu.text = ThuHoSOMDataManager.shared.selectedCatagory.name
        
        for product in ThuHoSOMDataManager.shared.selectedCatagory.products {
            if let url = product.configs.first?.createURL, url.isEmpty {
                tfProduct.text = product.name
                ThuHoSOMDataManager.shared.selectedProduct = product
                checkSearchHD()
            }
        }
    }
    
	private func checkSearchHD() {
        if ThuHoSOMDataManager.shared.selectedCatagory.name == "Internet" && ThuHoSOMDataManager.shared.selectedProduct.name == "FPT Telecom" {
            btnSearchHD.isHidden = false
        } else {
            btnSearchHD.isHidden = true
        }
    }
    
    private func configureDropdown() {
        products.direction = .bottom
        products.bottomOffset = CGPoint(x: 0, y: tfProduct.bounds.height)
        products.anchorView = tfProduct
        DropDown.startListeningToKeyboard()
        
        products.selectionAction = { [weak self] index, item in
            guard let self = self else { return }
            self.view.endEditing(true)
			self.isAIA = item == "AIA" ? true : false
            let product = ThuHoSOMDataManager.shared.selectedCatagory.products.first(where: { $0.name == item }) ?? ThuHoSOMProduct(JSON: [:])!
			
            if product.configs.first!.createURL.isEmpty {
                self.tfProduct.text = product.name
                ThuHoSOMDataManager.shared.selectedProduct = product
                self.checkSearchHD()
            } else {
                self.showAlertOneButton(title: "Thông báo", with: "Chức năng đang phát triển. Bạn vui lòng vào SOM thao tác trước nhé.", titleButton: "OK", handleOk: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
    
    private func validateInputs() -> Bool {
        guard let code = tfCode.text, !code.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng điền mã hợp đồng", titleButton: "OK")
            return false
        }
        
        guard let product = tfProduct.text, !product.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng chọn nhà cung cấp", titleButton: "OK")
            return false
        }
        
        guard let name = tfProduct.text, name == ThuHoSOMDataManager.shared.selectedProduct.name else {
            showAlertOneButton(title: "Thông báo", with: "Nhà cung cấp không hợp lệ. Vui lòng chọn lại", titleButton: "OK")
            return false
        }
        
        return true
    }
    
    @IBAction func searchHDButtonPressed(_ sender: Any) {
        let vc = ThuHoSOMSearchHDViewController()
        vc.didSelectHD = { contract in
            self.tfCode.text = contract
        }
        self.navigationController?.push(viewController: vc)
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        guard validateInputs() else { return }
		searchContract(isAIA:self.isAIA)
    }
	private func searchContrackSeason2(pin:String,contractID:String){
		let param  = ThuHoSOMDataManager.shared.selectedProduct
		Provider.shared.ebayService.searchContractSeason2(providerId: param.defaultProviderId, customerId: contractID, integratedGroupCode: param.configs.first?.integratedGroupCode ?? "" , integratedProductCode: param.configs.first?.integratedProductCode ?? "" , pin: pin, success: { [weak self] result in
			guard let self = self else { return }
				if let respone = result {
				ThuHoSOMDataManager.shared.selectedCustomer = respone
				let vc = ThuHoSOMOrderDetailViewController()
				vc.isAIA = true
				self.navigationController?.pushViewController(vc, animated: true)
			}

		}, failure: { [weak self] error in
			guard let self = self else { return }
			self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
		})
	}
	private func searchContract(isAIA:Bool){
		let param  = ThuHoSOMDataManager.shared.selectedProduct
		Provider.shared.ebayService.searchContractSeason1(providerId: param.defaultProviderId, customerId: tfCode.text  ?? "", integratedGroupCode: param.configs.first?.integratedGroupCode ?? "" , integratedProductCode: param.configs.first?.integratedProductCode ?? "" , pin: "", success: { [weak self] result in
			guard let self = self, let data = result else { return }
			if result?.extraProperties != nil {
				let vc = PopupSearchContractVC()
				vc.onSelectPin = { [weak self] model in
					guard let self = self else { return }
					self.searchContrackSeason2(pin:model.additionalData?.pin ?? "",contractID:model.contractId ?? "")
				}
				vc.listSuggestion = result?.extraProperties?.suggestionsModel ?? []
				vc.modalPresentationStyle = .overCurrentContext
				vc.modalTransitionStyle = .crossDissolve
				self.present(vc, animated: false)
			}else {
				self.getCustomerV1()
			}

		}, failure: { [weak self] error in
			guard let self = self else { return }
			self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
		})
	}
	private func getCustomerV1(){
		Provider.shared.thuhoSOMAPIService.getCustomer(providerId: ThuHoSOMDataManager.shared.selectedProduct.defaultProviderId, customerId: tfCode.text&, groupCode: ThuHoSOMDataManager.shared.selectedProduct.configs.first?.integratedGroupCode ?? "", productCode: ThuHoSOMDataManager.shared.selectedProduct.configs.first?.integratedProductCode ?? "", pin: "", success: { [weak self] result in
			guard let self = self, let data = result else { return }
			ThuHoSOMDataManager.shared.selectedCustomer = data

			let vc = ThuHoSOMOrderDetailViewController()
			self.navigationController?.pushViewController(vc, animated: true)
		}, failure: { [weak self] error in
			guard let self = self else { return }
			self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
		})
	}
}

extension ThuHoSOMSearchOrderViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfProduct {
            products.dataSource = ThuHoSOMDataManager.shared.selectedCatagory.products.map { $0.name }
            products.show()
        }

        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfCode {
            textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
            return false
        } else if textField == tfProduct {
            let text = textField.text&
            if (text.isEmpty) {
                return true
            }

            var listDataSuggest: [String] = []
            let locale = Locale(identifier: "vi_VN")
            for item in ThuHoSOMDataManager.shared.selectedCatagory.products {
                let string = item.name.folding(options: .diacriticInsensitive, locale: locale)
                if string.contains(text.folding(options: .diacriticInsensitive, locale: locale), caseSensitive: false) {
                    listDataSuggest.append(item.name)
                }
            }

            products.dataSource = listDataSuggest
            products.show()
        }
        
        return true
    }
}
