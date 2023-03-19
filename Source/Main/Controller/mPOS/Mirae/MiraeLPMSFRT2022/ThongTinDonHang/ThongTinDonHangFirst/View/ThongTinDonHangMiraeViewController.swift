//
//  ThongTinDonHangMiraeViewController.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit
import KeychainSwift
import ActionSheetPicker_3_0
import DropDown



class ThongTinDonHangMiraeViewController: BaseVC<ThongTinDonHangMiraeView> {
    
    //MARK:- Properties
    var presenter: ThongTinDonHangMiraePresenter?
    var dropDown:DropDown?
    var promotionsMirae: [String:NSMutableArray] = [:]
    var groupMirae:[String] = []
    //MARK:- Create ComponentUI
    
    
    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.configureTableView()
        self.configureButton()
        self.configureNavigationBackItem(title: "THÔNG TIN ĐƠN HÀNG")
        self.updateHeightScrollView()
        self.bindingData()
        self.configureDropDown()
    }
    
    
    deinit {
        print("Denit ThongTinDonHangMiraeViewController is Success")
    }
    
    //MARK:- Configure
    private func configureButton(){
        self.mainView.goiTraGopTextField.delegate = self
        self.mainView.kyHanTextField.delegate = self
        self.mainView.soTienTraTruocTextField.currencyTextField.delegate = self
        self.mainView.kiemTraKhuyenMaiButton.addTarget(self, action: #selector(self.kiemTraKhuyenMaiTapped), for: .touchUpInside)
        self.mainView.themVoucherButton.addTarget(self, action: #selector(self.tapShowAddVoucher), for: .touchUpInside)
    }
    
    private func configureTableView(){
        self.mainView.donHangTableView.dataSource = self
        self.mainView.donHangTableView.delegate = self
        self.mainView.voucherTableView.dataSource = self
        self.mainView.voucherTableView.delegate = self
    }
    private func updateHeightScrollView(){
        let contentRect: CGRect = self.mainView.scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        self.mainView.scrollView.contentSize = contentRect.size
        view.layoutIfNeeded()
    }
    private func bindingData(){
		Cache.infoKHMirae?.soTienCoc = Cache.soTienCocMirae
        self.mainView.hotenKHResultLabel.text = "\(Cache.infoKHMirae?.ho ?? "") \(Cache.infoKHMirae?.tenLot ?? "") \(Cache.infoKHMirae?.ten ?? "")"
        if self.presenter?.isUpdate ?? false {
            let thuNhap:Double = Double(Cache.infoKHMirae?.soTienTraTruoc ?? 0)
            self.mainView.soTienTraTruocTextField.currencyTextField.text = Common.convertCurrencyDouble(value: thuNhap).replace(",", withString: ".").trimAllSpace()
            self.mainView.hotenKHResultLabel.text = Cache.infoKHMirae?.fullname ?? ""
        }
        self.mainView.cmndResultLabel.text = Cache.infoKHMirae?.soCMND ?? ""
        self.mainView.soDTResultLabel.text = Cache.infoKHMirae?.soDienThoai ?? ""
        self.mainView.thanhTienResultLabel.text = Common.convertCurrencyFloat(value: self.presenter?.totalPay ?? 0)
        if self.presenter?.isUpdate ?? false {
            self.mainView.tongTienResultLabel.text = Common.convertCurrencyFloat(value: Cache.infoKHMirae?.tongTien ?? 0)
        }else {
            let tongTien = (self.presenter?.totalPay ?? 0) - (Cache.infoKHMirae?.soTienTraTruoc ?? 0) - (Cache.infoKHMirae?.soTienCoc ?? 0)
            self.mainView.tongTienResultLabel.text = Common.convertCurrencyFloat(value: tongTien)
        }
        self.mainView.soTienTraTruocResultLabel.text = Common.convertCurrencyFloat(value:Cache.infoKHMirae?.soTienTraTruoc ?? 0)
        self.mainView.soTienVayResultLabel.text = Common.convertCurrencyFloat(value:Cache.infoKHMirae?.soTienVay ?? 0)
        self.mainView.phiBaoHiemResultLabel.text = Common.convertCurrencyFloat(value:(Cache.infoKHMirae?.soTienVay ?? 0) * (Cache.infoKHMirae?.phiBaoHiem ?? 0) / 100)
        self.mainView.giamGiaResultLabel.text = Common.convertCurrencyFloat(value:Cache.infoKHMirae?.giamGia ?? 0)
        self.mainView.datCocResultLabel.text = Common.convertCurrencyFloat(value:Cache.infoKHMirae?.soTienCoc ?? 0)
        if self.presenter?.isUpdate == false {
            Cache.infoKHMirae?.tongTien = self.presenter?.totalPay ?? 0
		}else {
			self.mainView.giamGiaResultLabel.text = "0đ"
		}
    }
    private func configureDropDown(){
        self.dropDown = DropDown()
        self.dropDown?.direction = .bottom
        self.dropDown?.offsetFromWindowBottom = 20
    }
    
    //MARK:- Actions
	private func checkKhuyenMai(){
		for item in Cache.cartsMirae {
			if (item.product.qlSerial == "Y"){
				if item.imei == "N/A" || item.imei == "" {
					self.outPutFailed(error: "\(item.product.name) chưa chọn IMEI.")
					return
				}
			}
		}
		if Cache.infoKHMirae?.codeGoiTraGop == ""{
			self.outPutFailed(error: "Bạn chưa chọn gói trả góp")
			return
		}
		if Cache.infoKHMirae?.kyHan == 0 {
			self.outPutFailed(error: "Bạn chưa chọn kỳ hạn trả góp!")
			return
		}
		var voucher = ""
		var voucherBTS:String = ""
		if(Cache.listVoucherMirae.count > 0){
			voucher = "<line>"
			for item in Cache.listVoucherMirae{
				voucher  = voucher + "<item voucher=\"\(item)\" />"
			}
			voucher = voucher + "</line>"
		}

		if Cache.listVoucherNoPrice.count > 0 {
			voucherBTS = "<line>"
			for item in Cache.listVoucherNoPrice{
				voucherBTS  = voucherBTS + "<item voucher=\"\(item.VC_Code)\" />"
			}
			voucherBTS = voucherBTS + "</line>"
		}

		Cache.voucherMirae = voucher == "" ? voucherBTS : voucher

		let nc = NotificationCenter.default
		let newViewController = LoadingViewController()
		newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
		newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
		self.present(newViewController, animated: true, completion: nil)

		MPOSAPIManager.checkPromotionMirae(  u_CrdCod: Cache.infoKHMirae?.soCMND ?? "",
											 sdt: Cache.infoKHMirae?.soDienThoai ?? "",
											 LoaiDonHang: "02",
											 LoaiTraGop: "02",
											 LaiSuat: Float(Cache.infoKHMirae?.laiSuat ?? 0),
											 SoTienTraTruoc: (Cache.infoKHMirae?.soTienTraTruoc ?? 0 + (Cache.infoKHMirae?.soTienCoc ?? 0)),
											 voucher:voucher == "" ? voucherBTS : voucher , kyhan: "\(Cache.infoKHMirae?.kyHan ?? 0)",
											 U_cardcode: PARTNERID == "FPT" ? "4221595" : "12828217",
											 HDNum: "\(Cache.infoKHMirae?.appDocEntry ?? 0)",
											 Docentry: Cache.infoKHMirae?.soMPOS ?? "0",schemecode:Cache.infoKHMirae?.codeGoiTraGop ?? "") { (promotion, err) in
			if(promotion != nil){
					//
				let carts = Cache.cartsMirae
				for item2 in carts{
					item2.inStock = -1
				}
				if let instock = promotion?.productInStock {

					if instock.count > 0 {

						for item1 in instock{
							for item2 in carts{
								if(item1.MaSP == item2.sku){
									item2.inStock = item1.TonKho
								}
							}
						}
							// het hang
						nc.post(name: Notification.Name("dismissLoading"), object: nil)
						let when = DispatchTime.now() + 0.5
						DispatchQueue.main.asyncAfter(deadline: when) {
							AlertManager.shared.alertWithViewController(title: "Thông báo", message: "Hết hàng ! Vui lòng chọn sản phẩm khác", titleButton: "Đồng ý", viewController: self) {
								self.navigationController?.popViewController(animated: true)
							}

						}
					}else{
						Cache.infoCustomerMirae?.sotientratruoc = Cache.infoKHMirae?.soTienTraTruoc ?? 0
						if ((promotion?.productPromotions?.count) ?? 0 > 0){
							for item in (promotion?.productPromotions) ?? [] {

								if let val:NSMutableArray = self.promotionsMirae["Nhóm \(item.Nhom)"] {
									val.add(item)
									self.promotionsMirae.updateValue(val, forKey: "Nhóm \(item.Nhom)")
								} else {
									let arr: NSMutableArray = NSMutableArray()
									arr.add(item)
									self.promotionsMirae.updateValue(arr, forKey: "Nhóm \(item.Nhom)")
									self.groupMirae.append("Nhóm \(item.Nhom)")
								}
							}
							Cache.promotionsMirae = self.promotionsMirae
							Cache.groupMirae = self.groupMirae
							let when = DispatchTime.now() + 0.5
							DispatchQueue.main.asyncAfter(deadline: when) {
								nc.post(name: Notification.Name("dismissLoading"), object: nil)
								let newViewController = PromotionMiraeViewController()
								if self.presenter?.isUpdate ?? false {
									newViewController.count = 1
								}
								Cache.cartsTemp = Cache.cartsMirae
								Cache.phoneTemp = Cache.infoKHMirae?.soDienThoai ?? ""
								Cache.nameTemp = Cache.infoKHMirae?.fullname ?? ""
								newViewController.productPromotions = (promotion?.productPromotions) ?? []
								self.navigationController?.pushViewController(newViewController, animated: true)
							}
						}else{
							let when = DispatchTime.now() + 0.5
							DispatchQueue.main.asyncAfter(deadline: when) {
								nc.post(name: Notification.Name("dismissLoading"), object: nil)
								if self.presenter?.isUpdate ?? false {
									let vc = UpdateGoiVayMiraeRouter().configureVIPERUpdateGoiVayMirae()
									self.navigationController?.pushViewController(vc, animated: true)
								}else {
									let vc = ThongTinDonHangMiraeCompleteRouter().configureVIPERThongTinDonHangComplete()
									vc.presenter?.isLichSu = false
									vc.presenter?.cart = Cache.cartsMirae
									vc.presenter?.cachePromotions = []
									self.navigationController?.pushViewController(vc, animated: true)
								}
							}
						}
					}
				}else{
					Cache.infoCustomerMirae?.sotientratruoc = Cache.infoKHMirae?.soTienTraTruoc ?? 0
					if ((promotion?.productPromotions?.count) ?? 0 > 0){
						for item in (promotion?.productPromotions) ?? [] {

							if let val:NSMutableArray = self.promotionsMirae["Nhóm \(item.Nhom)"] {
								val.add(item)
								self.promotionsMirae.updateValue(val, forKey: "Nhóm \(item.Nhom)")
							} else {
								let arr: NSMutableArray = NSMutableArray()
								arr.add(item)
								self.promotionsMirae.updateValue(arr, forKey: "Nhóm \(item.Nhom)")
								self.groupMirae.append("Nhóm \(item.Nhom)")
							}
						}
						Cache.promotionsMirae = self.promotionsMirae
						Cache.groupMirae = self.groupMirae

						let when = DispatchTime.now() + 0.5
						DispatchQueue.main.asyncAfter(deadline: when) {
							nc.post(name: Notification.Name("dismissLoading"), object: nil)
							if self.presenter?.isUpdate ?? false {
								let vc = UpdateGoiVayMiraeRouter().configureVIPERUpdateGoiVayMirae()
								self.navigationController?.pushViewController(vc, animated: true)
							}else {
								let newViewController = PromotionMiraeViewController()
								if self.presenter?.isUpdate ?? false {
									newViewController.count = 1
								}
								Cache.cartsTemp = Cache.cartsMirae
								Cache.phoneTemp = Cache.infoKHMirae?.soDienThoai ?? ""
								Cache.nameTemp = Cache.infoKHMirae?.fullname ?? ""
								newViewController.productPromotions = (promotion?.productPromotions) ?? []
								self.navigationController?.pushViewController(newViewController, animated: true)
							}
						}
							// chuyen qua khuyen main

					}else{
						let when = DispatchTime.now() + 0.5
						DispatchQueue.main.asyncAfter(deadline: when) {
							nc.post(name: Notification.Name("dismissLoading"), object: nil)
							let vc = ThongTinDonHangMiraeCompleteRouter().configureVIPERThongTinDonHangComplete()
							vc.presenter?.isLichSu = false
							vc.presenter?.cart = Cache.cartsMirae
							vc.presenter?.cachePromotions = []
							self.navigationController?.pushViewController(vc, animated: true)


						}
					}
				}
			}else{
				let when = DispatchTime.now() + 0.5
				DispatchQueue.main.asyncAfter(deadline: when) {
					nc.post(name: Notification.Name("dismissLoading"), object: nil)
					let errorAlert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
					errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
						alert -> Void in

					}))
					self.present(errorAlert, animated: true, completion: nil)
				}
			}

		}

	}
    @objc private func kiemTraKhuyenMaiTapped(){
		for item in Cache.cartsMirae {
			if (item.product.qlSerial == "Y"){
				if item.imei == "N/A" || item.imei == "" {
					self.showAlert("\(item.product.name) chưa chọn IMEI.")
					return
				}
			}
		}

		if Cache.infoKHMirae?.codeGoiTraGop == ""{
			self.outPutFailed(error: "Bạn chưa chọn gói trả góp")
			return
		}
		if Cache.infoKHMirae?.kyHan == 0 {
			self.outPutFailed(error: "Bạn chưa chọn kỳ hạn trả góp!")
			return
		}
		var endIndex :Int = 0
		var arrCount:[Int] = []
		var itemEndIndex = 0
		for (index,item) in Cache.cartsMirae.enumerated(){
			if item.product.amountGoiBH == "1" || item.product.amountGoiBH == "2"{
				endIndex = index
				switch item.product.amountGoiBH {
					case "1":
						arrCount.append(1)
						itemEndIndex = 1
					case "2":
						arrCount.append(2)
						itemEndIndex = 2
					default:
						return
				}
			}
		}

		getPricegoiBH(itemBH: 0,endIndex:endIndex,itemEndIndex:itemEndIndex)

		
    }
	private  func getPricegoiBH(itemBH:Int,endIndex:Int,itemEndIndex:Int){
		if itemEndIndex == 0 {
			self.checkKhuyenMai()
		}else {
			WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
				var itemBH:Int = 0
				for (index,item) in Cache.cartsMirae.enumerated() {
					if item.product.amountGoiBH == "1" || item.product.amountGoiBH == "2"  {
						if item.product.amountGoiBH == "1" {
							itemBH = 1
						}else if item.product.amountGoiBH == "2"{
							itemBH = 2
						}
						if itemBH != 0 {
							for i in 1...itemBH{

								let itemInsuraceCode:String = Cache.cartsMirae[index + i].product.itemCodeGoiBH
								let imei = Cache.cartsMirae[index].imei
								let priceMainProduct:Int =  Int(Cache.cartsMirae[index].product.price) - Int(Cache.cartsMirae[index].product.priceSauKM) - Cache.cartsMirae[index].discount
								MPOSAPIManager.getPriceGoiBH(IMEI: imei, InsuranceCode: itemInsuraceCode, priceMainProduct: "\(priceMainProduct)", completion: { [weak self](results, err) in

									guard let self = self else { return }
									if index ==  endIndex {
										if itemEndIndex == 1 {
											WaitingNetworkResponseAlert.DismissWaitingAlertWithTime(timeWaiting: 1.5){
												self.checkKhuyenMai()
											}
										}else if itemEndIndex == 2 && i == 2{
											WaitingNetworkResponseAlert.DismissWaitingAlertWithTime(timeWaiting: 1.5) {
												self.checkKhuyenMai()
											}
										}
									}
									if results?.message?.message_Code == 200 && results?.data?.canSell == true {
											//có data
										let itemNameBH = Cache.cartsMirae[index + i].product.itemNameGoiBH
										let itemCodeBH = Cache.cartsMirae[index + i].product.itemCodeGoiBH
										let itemBrandBH = Cache.cartsMirae[index + i].product.brandName

										let price:Float = results?.data?.insurancePrice ?? 0
										var taxPercent:Float = 0
//										if Cache.cartsMirae.count > 0 {
//											taxPercent = Float(Cache.cartsMirae[0].product.taxrate_sa ?? "10") ?? 10
////										}
										let pro = Product(model_id: "", id: 0, name: itemNameBH, brandID: 0, brandName: itemBrandBH, typeId: 0, typeName: Cache.cartsMirae[index + i].product.typeName, sku: "", price: Float(price * 1.1), priceMarket: 0, priceBeforeTax: 0, iconUrl: "", imageUrl: "", promotion: "", includeInfo: "", hightlightsDes: "", labelName: "", urlLabelPicture: "", isRecurring: false, manSerNum: "", bonusScopeBoom: "", qlSerial: "", inventory: 0, LableProduct: "", p_matkinh: "", ecomColorValue: "", ecomColorName: "", ecom_itemname_web: "", price_special: 0, price_online_pos: 0, price_online: 0, hotSticker: false, is_NK: false, is_ExtendedWar: false, skuBH: [], nameBH: [],brandGoiBH:[], isPickGoiBH: "0đ", amountGoiBH: "true", itemCodeGoiBH: itemCodeBH, itemNameGoiBH: itemNameBH ,priceSauKM: 0,role2: [])

										let cart = Cart(sku: itemCodeBH, product: pro,quantity: 1,color:"#ffffff",inStock:-1, imei: "",price: Float(price * 1.1), priceBT: 0, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: results?.data?.imei ?? "", replacementAccessoriesLabel: "")
										Cache.cartsMirae[index + i] = cart
									}else {

										self.showPopUp(results?.message?.message_Desc ?? "", "Thông báo", buttonTitle: "OK")
									}
								}
								)
							}
						}
					}
				}
			}
		}

	}
	@objc func tapShowAddVoucher() {
		let alertController = UIAlertController(title: "Thêm voucher", message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Huỷ", style: .default, handler: {
            alert -> Void in
            self.dismiss(animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: "Lưu", style: .cancel, handler: {
            alert -> Void in
            let fNameField = alertController.textFields![0] as UITextField
            if fNameField.text != ""{
                self.dismiss(animated: true, completion: nil)
                Cache.listVoucherMirae.append("\(fNameField.text!)")
                //                self.tableView.reloadData()
            } else {
                let errorAlert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập mã voucher!", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                    alert -> Void in
                    self.present(alertController, animated: true, completion: nil)
                }))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }))
        alertController.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Nhập mã voucher..."
            textField.textAlignment = .center
            textField.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func selectImeiAction(index: Int){
        // do other task
        let itemCart = Cache.cartsMirae[index]
        if(itemCart.product.qlSerial == "Y"){
            ProgressView.shared.show()
            
            MPOSAPIManager.getImeiFF(productCode: "\(itemCart.product.sku)", shopCode: "\(Cache.user!.ShopCode)") { (result, err) in
                if (result.count > 0){
                    var arr:[String] = []
                    var arrDate:[String] = []
                    var whsCodes:[String] = []
                    for item in result {
                        arr.append("\(item.DistNumber)")
                        if let theDate = Date(jsonDate: "\(item.CreateDate)") {
                            let dayTimePeriodFormatter = DateFormatter()
                            dayTimePeriodFormatter.dateFormat = "dd/MM/YY"
                            let dateString = dayTimePeriodFormatter.string(from: theDate)
                            arrDate.append("\(item.DistNumber)-\(dateString)")
                        } else {
                            arrDate.append("\(item.DistNumber)")
                        }
                        
                        whsCodes.append("\(item.WhsCode)")
                    }
                    if(arr.count == 1){
                        let when = DispatchTime.now() + 1
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            ProgressView.shared.hide()
                            
                            var check: Bool = true
                            for item in Cache.cartsMirae {
                                if (item.product.qlSerial == "Y"){
                                    if item.imei == "\(String(describing: arr[0]))" {
                                        check = false
                                        break
                                    }
                                }
                            }
                            if (check == true) {
                                itemCart.imei = arr[0]
                                itemCart.whsCode = whsCodes[0]
                            }else{
                                // Prepare the popup
                                let title = "CHÚ Ý"
                                let message = "Bạn chọn IMEI máy bị trùng!"
                                
                                // Create the dialog
                                AlertManager.shared.alertWithViewController(title: title, message: message, titleButton: "OK", viewController: self) {
                                    
                                }
                            }
                            DispatchQueue.main.async {
                                self.mainView.donHangTableView.reloadData()
                            }
                        }
                        
                    }else{
                        let when = DispatchTime.now() + 1
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            ProgressView.shared.hide()
                            ActionSheetStringPicker.show(withTitle: "Chọn IMEI", rows: arrDate, initialSelection: 0, doneBlock: {
                                picker, value, index1 in
                                ProgressView.shared.hide()
                                
                                var check: Bool = true
                                for item in Cache.cartsMirae {
                                    if (item.product.qlSerial == "Y"){
                                        if item.imei == "\(String(describing: arr[value]))" {
                                            check = false
                                            break
                                        }
                                    }
                                }
                                if (check == true) {
                                    
                                    let dateChoose = arrDate[value].components(separatedBy: "-")
                                    let dateDefault = arrDate[0].components(separatedBy: "-")
                                    if(dateChoose.count == 2 && dateDefault.count == 2){
                                        if (dateChoose[1] != dateDefault[1]){
                                            // Prepare the popup
                                            let title = "CHÚ Ý"
                                            let message = "Bạn chọn IMEI sai FIFO"
                                            
                                            AlertManager.shared.alertWithViewController(title: title, message: message, titleButton: "OK", viewController: self) {
                                                
                                            }
                                        }
                                    }
                                    
                                    itemCart.imei = "\(arr[value])"
                                    itemCart.whsCode = whsCodes[value]
                                }else{
                                    // Prepare the popup
                                    let title = "CHÚ Ý"
                                    let message = "Bạn chọn IMEI máy bị trùng!"
                                    
                                    // Create the dialog
                                    AlertManager.shared.alertWithViewController(title: title, message: message, titleButton: "OK", viewController: self) {
                                        
                                    }
                                }
                                DispatchQueue.main.async {
                                    self.mainView.donHangTableView.reloadData()
                                }
                                return
                            }, cancel: { ActionStringCancelBlock in
                                ProgressView.shared.hide()
                                return
                            }, origin: self.view)
                        }
                        
                    }
                } else {
                    
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        ProgressView.shared.hide()
                        let alertController = UIAlertController(title: "HẾT HÀNG", message: "Sản phẩm bạn chọn đã hết hàng tại shop!", preferredStyle: .alert)
                        
                        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                            itemCart.inStock = 0
                            var checkDatCoc:Bool = false
                            if(Cache.listDatCocMirae.count > 0){
                                for itemDatCoc in Cache.listDatCocMirae{
                                    if(itemDatCoc.sku == itemCart.sku ){
                                        checkDatCoc = true
                                        break
                                    }
                                }
                            }
                            if(checkDatCoc == true){
                                _ = self.navigationController?.popToRootViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                            }else{
                                _ = self.navigationController?.popViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                            }
                            
                        }
                        alertController.addAction(confirmAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                    
                }
            }
        }
        
    }
    
}

extension ThongTinDonHangMiraeViewController : ThongTinDonHangMiraePresenterToViewProtocol {
    
    func didLoadVoucherSuccess() {
        DispatchQueue.main.async {
            self.mainView.voucherTableView.reloadData()
        }
    }
    
    func didLoadThongTinDonHangFailed(message: String) {
        
    }
    
    func didLoadGoiTraGopSuccess(model: [ThongTinDonHangMiraeEntity.DataGoiVayMiraeModel]) {
        
    }
    
    func didLoadThongTinDonHangSuccess(model: ThongTinDonHangMiraeEntity.DataChiTietDonHangModel) {
        self.bindingData()
        DispatchQueue.main.async {
            self.mainView.donHangTableView.reloadData()
        }
    }
    
    func outPutFailed(error: String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo", message: error, titleButton: "OK", viewController: self) {
            
        }
    }
    
    func showLoading(message: String) {
        self.startLoading(message: message)
    }
    
    func hideLoading() {
        self.stopLoading()
    }
}

extension ThongTinDonHangMiraeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.mainView.voucherTableView {
            return Cache.listVoucherNoPrice.count
        }else {
            return Cache.cartsMirae.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.mainView.voucherTableView {
            let cell = ItemVoucherNoPriceTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemVoucherNoPriceTableViewCell")
            cell.selectionStyle = .none
            if Cache.listVoucherNoPrice.count > 0 {
                let item:VoucherNoPrice = Cache.listVoucherNoPrice[indexPath.row]
                cell.setup(so: item,indexNum: indexPath.row,readOnly:false)
            }
            cell.delegate = self
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Common.TraGopMirae.identifierTableViewCell.thongTinDonHang, for: indexPath) as! ThongTinDonHangMiraeTableViewCell
            cell.selectionStyle = .none
            if Cache.cartsMirae.count > 1 {
                let totalRows = tableView.numberOfRows(inSection: indexPath.section)
                if indexPath.row == totalRows - 1 {
                    cell.isLast = true
                }
            }
            cell.model = Cache.cartsMirae[indexPath.row]
            cell.sttLabel.text = "\(indexPath.row + 1)"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.mainView.voucherTableView {
            return 150
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.mainView.donHangTableView {
            self.selectImeiAction(index: indexPath.row)
        }
    }
    
}

extension ThongTinDonHangMiraeViewController : InputInfoTextFieldDelegate {
    func didSelected(index:Int) {
        if index == 0 {
            self.dropDown?.anchorView = self.mainView.goiTraGopTextField
            self.dropDown?.bottomOffset = CGPoint(x: 0, y:(self.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            self.dropDown?.dataSource = self.presenter?.modelArrayGoiTraGop.map({ item in
                return item.schemeName ?? ""
            }) ?? []
            self.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
                self.mainView.goiTraGopTextField.textField.text = item
                self.presenter?.modelArrayKyHan = self.presenter?.modelArrayGoiTraGop[index].loanTenure ?? []
                self.mainView.kyHanTextField.textField.text =  self.presenter?.modelArrayKyHan[0].text ?? ""
                self.mainView.noteLabel.text = self.presenter?.modelArrayGoiTraGop[index].schemeDetails ?? ""
                
                let phiBH = (self.presenter?.totalPay ?? 0) * (self.presenter?.modelArrayGoiTraGop[index].insuranceFeeRate ?? 0) / 100
                self.mainView.phiBaoHiemResultLabel.text = Common.convertCurrencyFloat(value: phiBH)
                
                Cache.infoKHMirae?.phiBaoHiem = self.presenter?.modelArrayGoiTraGop[index].insuranceFeeRate ?? 0
                Cache.infoKHMirae?.kyHan = self.presenter?.modelArrayKyHan[0].number ?? 0
                Cache.infoKHMirae?.codeGoiTraGop = self.presenter?.modelArrayGoiTraGop[index].schemeCode ?? ""
                Cache.infoKHMirae?.tenGoiTraGop = self.presenter?.modelArrayGoiTraGop[index].schemeName ?? ""
                Cache.infoKHMirae?.laiSuat = Float(self.presenter?.modelArrayGoiTraGop[index].interestRate ?? 0)
                
            }
        }else {
            self.dropDown?.anchorView = self.mainView.kyHanTextField
            self.dropDown?.bottomOffset = CGPoint(x: 0, y:(self.dropDown?.anchorView?.plainView.bounds.height)! + 20)
            self.dropDown?.dataSource = self.presenter?.modelArrayKyHan.map({ item in
                return item.text ?? ""
            }) ?? []
            self.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
                self.mainView.kyHanTextField.textField.text = item
                Cache.infoKHMirae?.kyHan = self.presenter?.modelArrayKyHan[index].number ?? 0
            }
        }
        self.dropDown?.show()
    }
}

extension ThongTinDonHangMiraeViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let money:Float = Float((textField.text ?? "0").replacingOccurrences(of: ".", with: "").trimmingCharacters(in: .whitespaces)) ?? 0
        var totalMoney:Float = self.presenter?.totalPay ?? 0
        totalMoney =  totalMoney - money
        let phiBH = (totalMoney) * (Cache.infoKHMirae?.phiBaoHiem ?? 0) / 100
        let newPhiBH = ((totalMoney - (Cache.infoKHMirae?.soTienCoc ?? 0) - (Cache.infoKHMirae?.giamGia ?? 0)) * (Cache.infoKHMirae?.phiBaoHiem ?? 0) / 100)
		let phiBHCaseUpdate = ((totalMoney - (Cache.infoKHMirae?.soTienCoc ?? 0)) * (Cache.infoKHMirae?.phiBaoHiem ?? 0) / 100)
        let giamGia = Cache.infoKHMirae?.giamGia ?? 0
        self.mainView.phiBaoHiemResultLabel.text = Common.convertCurrencyFloat(value: newPhiBH.rounded(.up))
        self.mainView.thanhTienResultLabel.text = Common.convertCurrencyFloat(value: self.presenter?.totalPay ?? 0)
        self.mainView.soTienTraTruocResultLabel.text = Common.convertCurrencyFloat(value: money)
        self.mainView.soTienVayResultLabel.text = Common.convertCurrencyFloat(value: totalMoney - (Cache.infoKHMirae?.soTienCoc ?? 0) - giamGia)
        self.mainView.tongTienResultLabel.text = Common.convertCurrencyFloat(value: totalMoney - (Cache.infoKHMirae?.soTienCoc ?? 0) - giamGia + newPhiBH)
        Cache.infoKHMirae?.soTienTraTruoc = money
        Cache.infoKHMirae?.giamGia = giamGia
        Cache.infoKHMirae?.thanhTien = self.presenter?.totalPay ?? 0
        Cache.infoKHMirae?.soTienVay = totalMoney - (Cache.infoKHMirae?.soTienCoc ?? 0) - giamGia
        Cache.infoKHMirae?.tongTien = totalMoney - (Cache.infoKHMirae?.soTienCoc ?? 0) - giamGia + newPhiBH
		if self.presenter?.isUpdate == true {
			self.mainView.giamGiaResultLabel.text = "0đ"
			self.mainView.soTienVayResultLabel.text = Common.convertCurrencyFloat(value: totalMoney - (Cache.infoKHMirae?.soTienCoc ?? 0) )
			self.mainView.phiBaoHiemResultLabel.text = Common.convertCurrencyFloat(value: phiBHCaseUpdate.rounded(.up))
			self.mainView.tongTienResultLabel.text = Common.convertCurrencyFloat(value: totalMoney - (Cache.infoKHMirae?.soTienCoc ?? 0) + phiBHCaseUpdate)
		}
    }

}



extension ThongTinDonHangMiraeViewController: ItemVoucherNoPriceTableViewCellDelegate {
    
    func tabReloadViewRemoveVoucher(indexNum: Int) {
        guard indexNum < Cache.listVoucherNoPrice.count else { return }
        Cache.listVoucherNoPrice.remove(at: indexNum)
        self.mainView.voucherTableView.reloadData()
    }
    
    func tabClickView(voucher: VoucherNoPrice) {
        let docType:String = "02" // trả góp
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        let phoneNumber = Cache.infoKHMirae?.soDienThoai ?? ""
        MPOSAPIManager.mpos_FRT_SP_check_VC_crm(voucher:"\(voucher.VC_Code)",sdt:phoneNumber,doctype:"\(docType)") { [weak self] (p_status,p_message,err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if p_status == 2 {
                        Cache.listVoucherNoPrice = []
                        self.showPopUp(p_message, "Thông báo", buttonTitle: "Đồng ý")
                        return
                    }else {
                        
                    }
                    if(p_status == 1){//1
                        let alertController = UIAlertController(title: "Thông báo", message: "Bạn có muốn sử dụng voucher này ?", preferredStyle: .alert)
                        
                        let confirmAction = UIAlertAction(title: "Có", style: .default) { (_) in
                            let newViewController = CheckVoucherOTPViewController()
                            newViewController.delegate = self as? CheckVoucherOTPViewControllerDelegate
                            newViewController.phone = phoneNumber
                            newViewController.doctype = docType
                            newViewController.voucher = voucher.VC_Code
                            
                            let navController = UINavigationController(rootViewController: newViewController)
                            self.navigationController?.present(navController, animated:false, completion: nil)
                        }
                        let rejectConfirm =  UIAlertAction(title: "Không", style: .cancel) { (_) in
                            
                        }
                        alertController.addAction(rejectConfirm)
                        alertController.addAction(confirmAction)
                        
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    if(p_status == 0){
                        
                        for item in Cache.listVoucherNoPrice{
                            if(item.VC_Code == voucher.VC_Code){
                                item.isSelected = true
                                Cache.voucherMirae = voucher.VC_Code
                                break
                            }
                        }
                        self.mainView.voucherTableView.reloadData()
                        
                    }
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
            
        }
    }
    
}
