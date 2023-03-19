//
//  DetailShinhanOrder.swift
//  fptshop
//
//  Created by Ngoc Bao on 02/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown
import DLRadioButton
import PopupDialog
import ActionSheetPicker_3_0
import AVFoundation
import SwiftUI

enum ShinhanDetailType {
    case detailHistory
    case detailCreate
    case saveApplication
    case updateLoan
}

class DetailShinhanOrder: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var type: ShinhanDetailType = .detailHistory
    var goiTragop: ShinhanGoitragopBase?
    var listKyhan: [ShinhanLoanTenure] = []
    var selectedTragop: ShinhanTragopData?
    var goitragop:ShinhanTragopData?
    var selectedKyHan: ShinhanLoanTenure?
    var dropDownMenu = DropDown()
    var totalPay: Float = 0.0
    var promotionsMirae: [String:NSMutableArray] = [:]
    var groupMirae: [String] = []
    var promos:[ProductPromotions] = []
    var docEntry = 0
    var detailOrder:ShinhanOrderDetail?
    var cellHeight:CGFloat = 0
    var itemVoucher:[VoucherNoPrice] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindData()
        if type == .detailCreate {
            getListVoucherNoPrice(phone:  ShinhanData.inforCustomer?.personalLoan?.phone ?? "")

        }
        
    }
    
    private func bindData() {
        if type == .detailCreate {
            ShinhanData.totalWithoutByProduct = 0
            loadGoitragop()
            for item in Cache.cartsMirae {
                totalPay = totalPay + (item.product.price * Float(item.quantity))
                if item.product.qlSerial == "Y" {
                    ShinhanData.totalWithoutByProduct = ShinhanData.totalWithoutByProduct + (item.product.price)
                }
            }
        } else if type == .saveApplication {
            ShinhanData.totalWithoutByProduct = 0
            if ShinhanData.detailorDerHistory != nil {
                for item in ShinhanData.detailorDerHistory?.order ?? [] {
                    totalPay = totalPay + (item.price * Float(item.quantity))
                    if item.imei != "" {
                        ShinhanData.totalWithoutByProduct = ShinhanData.totalWithoutByProduct + item.price
                    }
                }
            } else {
                for item in Cache.cartsMirae {
                    totalPay = totalPay + (item.product.price * Float(item.quantity))
                    if item.product.qlSerial == "Y" {
                        ShinhanData.totalWithoutByProduct = ShinhanData.totalWithoutByProduct + (item.product.price)
                    }
                }
            }
            var discountPay:Float = 0.0
            Cache.itemsPromotionTempMirae.removeAll()
            
            for item in Cache.itemsPromotionMirae{
                let it = item
                if (it.TienGiam <= 0) || (item.Loai_KM == "GiamGia"){
                    if (it.TienGiam > 0){
                        discountPay = discountPay + it.TienGiam
                    }
                    if (promos.count == 0){
                        promos.append(it)
                        Cache.itemsPromotionTempFF.append(item)
                    }else{
                        for pro in promos {
                            if (pro.SanPham_Tang == it.SanPham_Tang){
                                pro.SL_Tang =  pro.SL_Tang + item.SL_Tang
                            }else{
                                promos.append(it)
                                Cache.itemsPromotionTempFF.append(item)
                                break
                            }
                        }
                    }
                }else{
                    Cache.itemsPromotionTempFF.append(item)
                    discountPay = discountPay + it.TienGiam
                }
            }
            
            ShinhanData.giamgia = discountPay
            ShinhanData.phibaohiem = ((totalPay - ShinhanData.giamgia - ShinhanData.tientraTruoc - ShinhanData.sotiencoc) * ( Float(ShinhanData.selectedTragop?.insuranceFeeRate ?? 0) / 100)).cleanAfterDot
            ShinhanData.tienvay = totalPay - ShinhanData.tientraTruoc - ShinhanData.sotiencoc - discountPay
            ShinhanData.tongTHanhtoan = ShinhanData.tienvay.round() + ShinhanData.phibaohiem.round()
        } else if type == .detailHistory {
            loadDetailOrder()
        } else if type == .updateLoan {
            ShinhanData.selectedTragop = ShinhanTragopData(schemeCode: detailOrder?.payment?.schemeCode ?? "", interestRate: Double(detailOrder?.payment?.interestRate ?? 0),schemeName: self.detailOrder?.payment?.schemeName ?? "",schemeDetail: detailOrder?.payment?.SchemeDetails ?? "")
            ShinhanData.selectedKyHan = ShinhanLoanTenure(number: Int(detailOrder?.payment?.loanTenor ?? 0))
            ShinhanData.totalWithoutByProduct = 0
            for item in detailOrder?.order ?? [] {
                totalPay = totalPay + (item.price * Float(item.quantity))
                if item.imei != "" {
                ShinhanData.totalWithoutByProduct = ShinhanData.totalWithoutByProduct + (item.price)
                }
            }
            loadGoitragop()
        }
        self.tableView.reloadData()
    }
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension

        tableView.registerTableCell(ItemVoucherNoPriceShinhanCell.self)
        tableView.registerTableCell(ShinhanInfoCell.self)
        tableView.registerTableCell(ShinhanPaymentCell.self)
        tableView.register(UINib(nibName: "HeaderDetailShinhan", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderDetailShinhan")
        tableView.registerTableCell(PromotionInfoCell.self)
        tableView.registerTableCell(VoucherInfoCell.self)
        tableView.registerTableCell(OrderInfoCellTableViewCell.self)
        tableView.registerTableCell(ButtonCell.self)
        tableView.registerTableCell(ShinhanInfoCell.self)
        tableView.registerTableCell(ShinhanTragopCell.self)
        tableView.registerTableCell(HeaderVoucherCell.self)
    }
    
    func loadDetailOrder() {
        Provider.shared.shinhan.loadDetailOrder(docEntry: "\(docEntry)") { [weak self] result in
            guard let self = self else {return}
            if result?.success ?? false {
                self.detailOrder = result?.data
                
            } else {
                self.showAlertOneButton(title: "Thông báo", with: result?.message ?? "", titleButton: "OK") {
                    if self.type == .detailHistory {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            self.tableView.reloadData()
        } failure: { [weak self ] error in
            guard let self = self else {return}
            self.showAlert(error.localizedDescription)
        }

    }
    
    
    func loadGoitragop() {
        let rDR1 = type == .updateLoan ? ShinhanData.parseXMLProduct(list: detailOrder?.order ?? []).toBase64() : Cache().parseXMLProduct().toBase64()
        
        Provider.shared.shinhan.loadGoitragop(rdr1: rDR1) { [weak self] result in
            guard let self = self else {return}
            if result?.success ?? false {
                self.goiTragop = result
            }
        } failure: { [weak self] error in
            guard let self = self else {return}
            self.showAlert(error.localizedDescription)
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
                self.tableView.reloadData()
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
                                let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                
                                // Create first button
                                let buttonOne = CancelButton(title: "OK") {
                                    
                                }
                                // Add buttons to dialog
                                popup.addButtons([buttonOne])
                                
                                // Present dialog
                                self.present(popup, animated: true, completion: nil)
                            }
                        self.tableView.reloadData()
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
                                            
                                            // Create the dialog
                                            let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                print("Completed")
                                            }
                                            
                                            // Create first button
                                            let buttonOne = CancelButton(title: "OK") {
                                                
                                            }
                                            
                                            // Add buttons to dialog
                                            popup.addButtons([buttonOne])
                                            
                                            // Present dialog
                                            self.present(popup, animated: true, completion: nil)
                                        }
                                    }
                                    
                                    itemCart.imei = "\(arr[value])"
                                    itemCart.whsCode = whsCodes[value]
                                }else{
                                    // Prepare the popup
                                    let title = "CHÚ Ý"
                                    let message = "Bạn chọn IMEI máy bị trùng!"
                                    
                                    // Create the dialog
                                    let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        print("Completed")
                                    }
                                    
                                    // Create first button
                                    let buttonOne = CancelButton(title: "OK") {
                                        
                                    }
                                    
                                    // Add buttons to dialog
                                    popup.addButtons([buttonOne])
                                    
                                    // Present dialog
                                    self.present(popup, animated: true, completion: nil)
                                }
                                self.tableView.reloadData()
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
    
    @objc func setupDrop(view: UIView) {
        dropDownMenu.anchorView = view
        dropDownMenu.bottomOffset = CGPoint(x: 0,y:(dropDownMenu.anchorView?.plainView.bounds.height)! + 10)
        dropDownMenu.dataSource = self.listKyhan.map({$0.text})
        dropDownMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dropDownMenu.selectionAction = { [weak self] (index, item) in
            let filter = self?.listKyhan.filter({$0.text == item})
            self?.selectedKyHan = filter?.first
            ShinhanData.selectedKyHan = filter?.first
            self?.tableView.reloadData()
        }
        dropDownMenu.show()
    }
    
    func submitApplication(needisSubmitApp: Bool,isSubmitApp: Bool) {
        Provider.shared.shinhan.submitApplication(promos: parseXMLPromotion().toBase64(), rdr1: ShinhanData.detailorDerHistory != nil ? ShinhanData.parseXMLProduct().toBase64() : parseXMLProduct().toBase64(),neeSubmit: needisSubmitApp,submitValue: isSubmitApp, success: {[weak self] result in
            guard let self = self else {return}
            self.showAlertOneButton(title: "Thông báo", with: result?.message ?? "", titleButton: "OK") {
                 if result?.status == 1 {
                     if needisSubmitApp && !isSubmitApp {
                         let vc = ShinhanUpdateImageVC()
                         vc.detailOrder = ShinhanData.detailorDerHistory
                         vc.isFromUpdateLoan = true
                         self.navigationController?.pushViewController(vc, animated: true)
                     } else {
                         Cache.itemsPromotionTempMirae.removeAll()
                         Cache.cartsMirae.removeAll()
                         Cache.listVoucherMirae = []
                         ShinhanData.resetShinhanData()
                         Cache.listVoucherNoPrice = []
                         let vc = OTPShinhanVC()
                         vc.mposNum = "\(result?.mposSoNum ?? 0)"
                         vc.isFromHistory = false
                         self.navigationController?.pushViewController(vc, animated: true)
                     }
                } else if result?.status == 2 {
                    self.uploadMoreImage(needSubmit: needisSubmitApp, submitValue: isSubmitApp)
                }
            }
        }, failure: {[weak self] error in
            guard let self = self else {return}
            self.showAlert(error.localizedDescription)
        })
    }
    
    func uploadMoreImage(needSubmit: Bool,submitValue: Bool) {
        let trackingId: String = ShinhanData.detailorDerHistory != nil ? ShinhanData.detailorDerHistory?.customer?.trackingId ?? "" : detailOrder?.customer?.trackingId ?? ""
        let popup = AddImagePopUp()
        popup.trackingID = trackingId
        popup.idCard = ShinhanData.detailorDerHistory == nil ? ShinhanData.inforCustomer?.personalLoan?.idCard ?? "" : ShinhanData.detailorDerHistory?.customer?.idCard ?? ""
        
        popup.onContinue = {
            self.submitApplication(needisSubmitApp: needSubmit, isSubmitApp: submitValue)
        }
        popup.descriptionLbl = "Bạn vui lòng upload thêm hình ảnh chứng từ chứng minh thu nhập của khách hàng."
        popup.modalPresentationStyle = .overCurrentContext
        popup.modalTransitionStyle = .crossDissolve
        self.present(popup, animated: true, completion: nil)
    }
    
    func parseXMLPromotion()->String{
        var rs:String = "<line>"
        for item in Cache.itemsPromotionMirae {
            var tenCTKM = item.TenCTKM
            tenCTKM = tenCTKM.replace(target: "&", withString:"&#38;")
            tenCTKM = tenCTKM.replace(target: "<", withString:"&#60;")
            tenCTKM = tenCTKM.replace(target: ">", withString:"&#62;")
            tenCTKM = tenCTKM.replace(target: "\"", withString:"&#34;")
            tenCTKM = tenCTKM.replace(target: "'", withString:"&#39;")
            
            var tenSanPham_Tang = item.TenSanPham_Tang
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "&", withString:"&#38;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "<", withString:"&#60;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: ">", withString:"&#62;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "\"", withString:"&#34;")
            tenSanPham_Tang = tenSanPham_Tang.replace(target: "'", withString:"&#39;")
            
            rs = rs + "<item SanPham_Mua=\"\(item.SanPham_Mua)\" TienGiam=\"\(String(format: "%.6f", item.TienGiam))\" LoaiKM=\"\(item.Loai_KM)\" SanPham_Tang=\"\(item.SanPham_Tang)\" TenSanPham_Tang=\"\(tenSanPham_Tang)\" SL_Tang=\"\(item.SL_Tang)\" Nhom=\"\(item.Nhom)\" MaCTKM=\"\(item.MaCTKM)\" TenCTKM=\"\(tenCTKM)\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    func parseXMLProduct()->String{
        var rs:String = "<line>"
        for item in Cache.cartsMirae {
            var name = item.product.name
            name = name.replace(target: "&", withString:"&#38;")
            name = name.replace(target: "<", withString:"&#60;")
            name = name.replace(target: ">", withString:"&#62;")
            name = name.replace(target: "\"", withString:"&#34;")
            name = name.replace(target: "'", withString:"&#39;")
            
            if(item.imei == "N/A"){
                item.imei = ""
            }
            
            item.imei = item.imei.replace(target: "&", withString:"&#38;")
            item.imei = item.imei.replace(target: "<", withString:"&#60;")
            item.imei = item.imei.replace(target: ">", withString:"&#62;")
            item.imei = item.imei.replace(target: "\"", withString:"&#34;")
            item.imei = item.imei.replace(target: "'", withString:"&#39;")
            
            rs = rs + "<item U_ItmCod=\"\(item.sku)\" U_Imei=\"\(item.imei)\" U_Quantity=\"\(item.quantity)\"  U_Price=\"\(String(format: "%.6f", item.product.price))\" U_WhsCod=\"\(Cache.user!.ShopCode)010\" U_ItmName=\"\(name)\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    private func getListVoucherNoPrice(phone:String) {
                ProgressView.shared.show()
        MPOSAPIManager.mpos_FRT_SP_VC_get_list_voucher_by_phone(phonenumber: phone) {
            (results, err) in
            let when = DispatchTime.now() + 0
                ProgressView.shared.hide()

                if err.count <= 0 {
                        //                    self.heightTableView.constant = CGFloat(150 * results.count)
                        //                    self.tableViewVoucherNoPrice.isScrollEnabled = false
                    self.itemVoucher = results
                    Cache.listVoucherNoPrice = results

                    self.tableView.reloadData()
                }


        }
    }
	private func checkKhuyenMai(){

		for item in Cache.cartsMirae {
			if (item.product.qlSerial == "Y"){
				if item.imei == "N/A" || item.imei == "" {
					self.showAlert("\(item.product.name) chưa chọn IMEI.")
					return
				}
			}
		}

		if ShinhanData.selectedTragop == nil{
			self.showAlert("Bạn chưa chọn gói trả góp")
			return
		}
		if self.selectedKyHan == nil {
			self.showAlert("Bạn chưa chọn kỳ hạn trả góp!")
			return
		}
		var voucher = ""
		var voucherNew :String =  ""
		if(Cache.listVoucherMirae.count > 0){
			voucher = "<line>"
			for item in Cache.listVoucherMirae{
				voucher  = voucher + "<item voucher=\"\(item)\" />"
			}
			voucher = voucher + "</line>"
		}
		var check = false
		if Cache.listVoucherNoPrice.count  > 0 {

			for item in Cache.listVoucherNoPrice{
				if(item.isSelected == true){
					voucherNew = "<line>"
					voucherNew  = voucherNew + "<item voucher=\"\(item.VC_Code)\" />"
					check = true
				}
			}
			voucherNew = voucherNew + "</line>"
			voucher.append(voucherNew)
		}

		if check{
			Cache.voucherMirae = voucher
		}else {
			voucher = ""
			Cache.voucherMirae = voucher
		}


		let nc = NotificationCenter.default
		let newViewController = LoadingViewController()
		newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
		newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
		self.present(newViewController, animated: true, completion: nil)

		MPOSAPIManager.checkPromotionMirae(  u_CrdCod: ShinhanData.inforCustomer?.personalLoan?.idCard ?? "", sdt: ShinhanData.inforCustomer?.personalLoan?.phone ?? "", LoaiDonHang: "02", LoaiTraGop: "02", LaiSuat: Float(ShinhanData.selectedTragop?.interestRate ?? 0), SoTienTraTruoc: ShinhanData.tientraTruoc + ShinhanData.sotiencoc,voucher:voucher, kyhan: "\(self.selectedKyHan?.number ?? 0)", U_cardcode: "2322579", HDNum: "0",Docentry: "\(ShinhanData.newDocEntry)",schemecode:ShinhanData.selectedTragop?.schemeCode ?? "") { (promotion, err) in
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
								//
							let alert = UIAlertController(title: "Thông báo", message: "Hết hàng ! Vui lòng chọn sản phẩm khác", preferredStyle: .alert)

							alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
								_ = self.navigationController?.popViewController(animated: true)
								self.dismiss(animated: true, completion: nil)
							})
							self.present(alert, animated: true)
								//

						}
					}else{
						Cache.infoCustomerMirae?.sotientratruoc = ShinhanData.tientraTruoc
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
								Cache.cartsTemp = Cache.cartsMirae
								Cache.phoneTemp = ShinhanData.infoUser?.personalLoan?.phone ?? ""
								Cache.nameTemp = ShinhanData.infoUser?.personalLoan?.fullName ?? ""
								newViewController.productPromotions = (promotion?.productPromotions) ?? []
								self.navigationController?.pushViewController(newViewController, animated: true)
							}
								// chuyen qua khuyen main

						}else{
							let when = DispatchTime.now() + 0.5
							DispatchQueue.main.asyncAfter(deadline: when) {
								nc.post(name: Notification.Name("dismissLoading"), object: nil)
								let newViewController = DetailShinhanOrder()
								newViewController.type = .saveApplication

								self.navigationController?.pushViewController(newViewController, animated: true)


							}
						}
					}
				}else{
					Cache.infoCustomerMirae?.sotientratruoc = ShinhanData.tientraTruoc
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
							Cache.cartsTemp = Cache.cartsMirae
							Cache.phoneTemp = ShinhanData.infoUser?.personalLoan?.phone ?? ""
							Cache.nameTemp = ShinhanData.infoUser?.personalLoan?.fullName ?? ""
							newViewController.productPromotions = (promotion?.productPromotions) ?? []
							self.navigationController?.pushViewController(newViewController, animated: true)
						}
							// chuyen qua khuyen main

					}else{
						let when = DispatchTime.now() + 0.5
						DispatchQueue.main.asyncAfter(deadline: when) {
							nc.post(name: Notification.Name("dismissLoading"), object: nil)
							let newViewController = DetailShinhanOrder()
							newViewController.type = .saveApplication

							self.navigationController?.pushViewController(newViewController, animated: true)


						}
					}
				}
					//

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

			//                    let vc = ShinhanPromotionVC()
			//                    self.navigationController?.pushViewController(vc, animated: true)

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
}


extension DetailShinhanOrder: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch type {
        case .detailCreate:
            return 6
        case .detailHistory:
            return 5
        case .saveApplication:
            return 6
        case .updateLoan:
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch type {
        case .detailCreate:
            if section == 5 {
                return .leastNormalMagnitude
            }
            return 35
        case .saveApplication:
            if section == 4 {
                return .leastNormalMagnitude
            }
            return 35
        case .detailHistory:
            if section > 3 {
                return .leastNormalMagnitude
            }
            return 35
        case .updateLoan:
            if section > 4 {
                return .leastNormalMagnitude
            }
            return 35
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderDetailShinhan") as! HeaderDetailShinhan
        
        switch type {
        case .saveApplication:
            switch section {
            case 0:
                header.lblTItle.text = "THÔNG TIN KHÁCH HÀNG"
            case 1:
                header.lblTItle.text = "THÔNG TIN ĐƠN HÀNG"
            case 2:
                 header.lblTItle.text = "THÔNG TIN VOUCHER"
            case 3:
                header.lblTItle.text = "THÔNG TIN KHUYẾN MÃI"
            case 4:
                header.lblTItle.text = "THÔNG TIN THANH TOÁN"
            default:
                return nil
            }
            return header
        case .detailCreate:
            switch section {
            case 0:
                header.lblTItle.text = "THÔNG TIN KHÁCH HÀNG"
            case 1:
                header.lblTItle.text = "THÔNG TIN ĐƠN HÀNG"
            case 2:
                header.lblTItle.text = "THÔNG TIN VOUCHER"
            case 3:
                header.lblTItle.text = "THÔNG TIN TRẢ GÓP"
            case 4:
                header.lblTItle.text = "THÔNG TIN THANH TOÁN"
            default:
                return nil
            }
            
            return header
        case .detailHistory:
            switch section {
            case 0:
                header.lblTItle.text = "THÔNG TIN KHÁCH HÀNG"
            case 1:
                header.lblTItle.text = "THÔNG TIN ĐƠN HÀNG"
            case 2:
                header.lblTItle.text = "THÔNG TIN KHUYẾN MÃI"
            case 3:
                header.lblTItle.text = "THÔNG TIN THANH TOÁN"
            default:
                return nil
            }
            return header
        case .updateLoan:
            switch section {
            case 0:
                header.lblTItle.text = "THÔNG TIN KHÁCH HÀNG"
            case 1:
                header.lblTItle.text = "THÔNG TIN ĐƠN HÀNG"
            case 2:
                header.lblTItle.text = "THÔNG TIN VOUCHER"
            case 3:
                header.lblTItle.text = "THÔNG TIN TRẢ GÓP"
            case 4:
                header.lblTItle.text = "THÔNG TIN THANH TOÁN"
            default:
                return nil
            }
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == .detailCreate {
            if section == 1 {
                return Cache.cartsMirae.count
            } else if section == 2 {
                if Cache.listVoucherMirae.count > 0 {
                    return Cache.listVoucherMirae.count + 3
                }else{
                    return 2
                }
            }
        }
        if type == .saveApplication {
            if section == 1 {
                if ShinhanData.detailorDerHistory != nil {
                    return ShinhanData.detailorDerHistory?.order.count ?? 0
                } else {
                    return Cache.cartsMirae.count
                }
            } else if section == 3 {
                return promos.count
            }
        }
        
        if type == .detailHistory {
            if section == 1 {
                return detailOrder?.order.count ?? 0
            } else if section == 2 {
                return detailOrder?.promotion.count ?? 0
            }
        }
        
        if type == .updateLoan {
            if section == 1 {
                return detailOrder?.order.count ?? 0
            } else if section == 2 {
                if Cache.listVoucherMirae.count > 0 {
                    return Cache.listVoucherMirae.count + 2
                }
            }
        }
                
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch type {
        case .detailCreate:
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueTableCell(ShinhanInfoCell.self)
                cell.bindCell()
                return cell
            case 1:
                let cell = tableView.dequeueTableCell(OrderInfoCellTableViewCell.self)
                cell.bindCellShinhan(item: Cache.cartsMirae[indexPath.row], index: indexPath.row + 1)
                return cell
            case 2:
                    if indexPath.row == 0 {
                        let cell = tableView.dequeueTableCell(ItemVoucherNoPriceShinhanCell.self)
                        cell.itemVoucher = self.itemVoucher
//                        cell.tableViewVoucherNoPrice.isScrollEnabled = false
                        cell.heightTable = Cache.listVoucherNoPrice.count * 150
                        cell.bindCell(phone: ShinhanData.inforCustomer?.personalLoan?.phone ?? "", mainController: self)
                        return cell
                    }
                if indexPath.row == 1 {
                    let cell = tableView.dequeueTableCell(VoucherInfoCell.self)
                    cell.onAdd = {
                        self.tapShowAddVoucher()
                    }
                    cell.onScan = {
                        let viewController = ScanCodeViewController()
                        viewController.scanSuccess = { code in
                            if(code != "SELECT_VOUCHER_KHONG_GIA"){
                                Cache.listVoucherMirae.append("\(code)")
                                self.tableView.reloadData()
                            }
                        }
                        self.present(viewController, animated: false, completion: nil)
                    }
                    return cell
                }
                    else if indexPath.row == 2 {
                    let cell = tableView.dequeueTableCell(HeaderVoucherCell.self)
                    cell.bindCell(des: "MÃ VOUCHER", stt: "STT")
                    return cell
                } else {
                    let cell = tableView.dequeueTableCell(HeaderVoucherCell.self)
                    cell.bindCell(des: Cache.listVoucherMirae[indexPath.row - 3], stt: "\(indexPath.row - 2)",hiddenDel: false)
                    cell.delete = {
                        Cache.listVoucherMirae.remove(at: indexPath.row - 3)
                        tableView.reloadData()
                    }
                    return cell
                }
            case 3:
                let cell = tableView.dequeueTableCell(ShinhanTragopCell.self)
                cell.bindCell(pack: ShinhanData.selectedTragop, selectedKyHan: ShinhanData.selectedKyHan)
                cell.onChangeTxt = { value in
                    ShinhanData.tientraTruoc = value
                    let newIndex = IndexPath(row: 0, section: 4)
                    ShinhanData.tienvay = self.totalPay - ShinhanData.tientraTruoc - ShinhanData.sotiencoc
                    ShinhanData.phibaohiem = (ShinhanData.tienvay * ( Float( ShinhanData.selectedTragop?.insuranceFeeRate ?? 0) / 100)).cleanAfterDot
                    self.tableView.reloadRows(at: [newIndex], with: .none)
                }
                cell.onlick = { index in
                    if index == 0 {
                        let vc = ShinhanInstallmentList()
                        vc.listData = self.goiTragop?.data ?? []
                        vc.didselect = { data in
                            ShinhanData.selectedTragop = data
                            self.listKyhan = ShinhanData.selectedTragop?.loanTenure ?? []
                            self.tableView.reloadData()
                        }
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        self.setupDrop(view: cell.kyhan)
                    }
                }
                return cell
            case 4:
                let cell = tableView.dequeueTableCell(ShinhanPaymentCell.self)
                cell.bindCell(totalPay: totalPay, tratruoc: ShinhanData.tientraTruoc, tienVay: ShinhanData.tienvay, giamgia: ShinhanData.giamgia, baohiem: ShinhanData.phibaohiem, tongDonhang: ShinhanData.tongTHanhtoan,sotiencoc: ShinhanData.sotiencoc)
                return cell
            case 5:
                let cell = tableView.dequeueTableCell(ButtonCell.self)
                cell.bindCellKM()
                cell.onAction = { [weak self] in
					guard let self = self else { return}
					for item in Cache.cartsMirae {
						if (item.product.qlSerial == "Y"){
							if item.imei == "N/A" || item.imei == "" {
								self.showAlert("\(item.product.name) chưa chọn IMEI.")
								return
							}
						}
					}

					if ShinhanData.selectedTragop == nil{
						self.showAlert("Bạn chưa chọn gói trả góp")
						return
					}
					if self.selectedKyHan == nil {
						self.showAlert("Bạn chưa chọn kỳ hạn trả góp!")
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
				self.getPricegoiBH(itemBH: 0,endIndex:endIndex,itemEndIndex:itemEndIndex)
                }
                return cell
            default:
                return UITableViewCell()
            }
        case .saveApplication:
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueTableCell(ShinhanInfoCell.self)
                if ShinhanData.detailorDerHistory != nil {
                    cell.bindCellDetail(item: ShinhanData.detailorDerHistory?.customer)
                } else {
                    cell.bindCell()
                }
                return cell
            case 1:
                let cell = tableView.dequeueTableCell(OrderInfoCellTableViewCell.self)
                if ShinhanData.detailorDerHistory != nil {
                    cell.bindCellDetailShinhan(item: ShinhanData.detailorDerHistory?.order[indexPath.row], index: indexPath.row + 1)
                } else {
                    cell.bindCellShinhan(item: Cache.cartsMirae[indexPath.row], index: indexPath.row + 1)
                }

                return cell
                case 2:
                    let cell = tableView.dequeueTableCell(ItemVoucherNoPriceShinhanCell.self)
                    cell.itemVoucher = self.itemVoucher
                    cell.heightTable = Cache.listVoucherNoPrice.count * 150
                    cell.isReadOnly = true
                    cell.bindCell(phone: ShinhanData.inforCustomer?.personalLoan?.phone ?? "", mainController: self)
                    return cell
            case 3:
                let cell = tableView.dequeueTableCell(PromotionInfoCell.self)
                cell.bindCellShinhan(item: promos[indexPath.row], index: indexPath.row + 1)
                return cell
            case 4:
                let cell = tableView.dequeueTableCell(ShinhanPaymentCell.self)
                    cell.bindCell(totalPay: totalPay, tratruoc: ShinhanData.tientraTruoc, tienVay: ShinhanData.tienvay, giamgia: ShinhanData.giamgia, baohiem: ShinhanData.phibaohiem, tongDonhang: ShinhanData.tongTHanhtoan,goitragop: ShinhanData.selectedTragop,kyhan: ShinhanData.selectedKyHan,sotiencoc: ShinhanData.sotiencoc)
                return cell
            case 5:
                let cell = tableView.dequeueTableCell(ButtonCell.self)
                cell.bindCellSave()
                cell.onAction = {
                    if ShinhanData.detailorDerHistory != nil {
                        self.showPopUpTwoButtons(message: ShinhanData.detailorDerHistory?.button?.updateImages ?? "", title: "THÔNG BÁO", title1: "GỬI SANG NTG", title2: "CẬP NHẬT HÌNH ẢNH") {
                            self.submitApplication(needisSubmitApp: true, isSubmitApp: true)
                        } handleButtonTwo: {
                            self.submitApplication(needisSubmitApp: true, isSubmitApp: false)
                        }
                    } else {
                        self.submitApplication(needisSubmitApp: false, isSubmitApp: false)
                    }
                }
                return cell
            default:
                return UITableViewCell()
            }
        case .detailHistory:
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueTableCell(ShinhanInfoCell.self)
                cell.bindCellDetail(item: detailOrder?.customer)
                return cell
            case 1:
                let cell = tableView.dequeueTableCell(OrderInfoCellTableViewCell.self)
                cell.bindCellDetailShinhan(item: detailOrder?.order[indexPath.row], index: indexPath.row + 1)
                return cell
            case 2:
                let cell = tableView.dequeueTableCell(PromotionInfoCell.self)
                cell.bindCellDetailShinhan(item: detailOrder?.promotion[indexPath.row], index: indexPath.row + 1)
                return cell
            case 3:
                let cell = tableView.dequeueTableCell(ShinhanPaymentCell.self)
                cell.isHistory = true
                cell.bindCellDetail(item: detailOrder?.payment)
                return cell
            case 4:
                let cell = tableView.dequeueTableCell(ButtonCell.self)
                
                    cell.bincellDetail(item: detailOrder?.button, mainController: self)
                cell.onInfoAction = {
                    let vc = ShinhanInfoCustomerVC()
                    vc.isInfoHistory = true
                    vc.docEntry = self.docEntry
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                cell.onAction = { //cap nhat khoan vay
                    let vc = DetailShinhanOrder()
                    vc.type = .updateLoan
                    vc.detailOrder = self.detailOrder
                    vc.docEntry = self.docEntry
                    let soMpos = ShinhanData.soMpos
                    ShinhanData.resetShinhanData()
                    ShinhanData.soMpos = soMpos
                    ShinhanData.docEntry = self.docEntry
                    ShinhanData.IS_RUNNING = true
                    ShinhanData.detailorDerHistory = self.detailOrder
                    ShinhanData.tienvay = self.detailOrder?.payment?.loanAmount ?? 0
                    ShinhanData.tientraTruoc = self.detailOrder?.payment?.downPayment ?? 0
                    ShinhanData.phibaohiem = self.detailOrder?.payment?.insuranceFee ?? 0
                    ShinhanData.tongTHanhtoan = Int(self.detailOrder?.payment?.finalPrice ?? 0)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                cell.rightAction = { // cap nhat hinh anh
                    let vc = ShinhanUpdateImageVC()
                    vc.detailOrder = self.detailOrder
                    vc.onSuccess = {
                        self.loadDetailOrder()
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                cell.onCancelAction = {
                    self.showPopUp("Cách 1: Khi KH nhận điện thoại thẩm định thông tin từ nhân viên Shinhan, bạn vui lòng hướng dẫn KH thông báo với Shinhan về việc hủy hồ sơ.\n\nCách 2: Nếu hồ sơ đã qua bước thẩm định, bạn vui lòng vào mobileapp của Shinhan để hủy", "HƯỚNG DẪN HỦY HỒ SƠ", buttonTitle: "Đóng")
                }
                return cell
            default:
                return UITableViewCell()
            }
        case .updateLoan:
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueTableCell(ShinhanInfoCell.self)
                cell.bindCellDetail(item: detailOrder?.customer)
                return cell
            case 1:
                let cell = tableView.dequeueTableCell(OrderInfoCellTableViewCell.self)
                cell.bindCellDetailShinhan(item: detailOrder?.order[indexPath.row], index: indexPath.row + 1)
                return cell
            case 2:
                if indexPath.row == 0 {
                    let cell = tableView.dequeueTableCell(VoucherInfoCell.self)
                    cell.onAdd = {
                        self.tapShowAddVoucher()
                    }
                    cell.onScan = {
                        let viewController = ScanCodeViewController()
                        viewController.scanSuccess = { code in
                            if(code != "SELECT_VOUCHER_KHONG_GIA"){
                                Cache.listVoucherMirae.append("\(code)")
                                self.tableView.reloadData()
                            }
                        }
                        self.present(viewController, animated: false, completion: nil)
                    }
                    return cell
                } else if indexPath.row == 1 {
                    let cell = tableView.dequeueTableCell(HeaderVoucherCell.self)
                    cell.bindCell(des: "MÃ VOUCHER", stt: "STT")
                    return cell
                } else {
                    let cell = tableView.dequeueTableCell(HeaderVoucherCell.self)
                    cell.bindCell(des: Cache.listVoucherMirae[indexPath.row - 2], stt: "\(indexPath.row - 1)",hiddenDel: false)
                    cell.delete = {
                        Cache.listVoucherMirae.remove(at: indexPath.row - 2)
                        tableView.reloadData()
                    }
                    return cell
                }
            case 3:
                let cell = tableView.dequeueTableCell(ShinhanTragopCell.self)
                cell.bindCell(pack: ShinhanData.selectedTragop, selectedKyHan: ShinhanData.selectedKyHan)
                    ShinhanData.sotiencoc = detailOrder?.payment?.U_DownPay ?? 0
                cell.onChangeTxt = { value in
                    ShinhanData.tientraTruoc = value
                    let newIndex = IndexPath(row: 0, section: 4)
                    ShinhanData.tienvay = self.totalPay - ShinhanData.tientraTruoc -  ShinhanData.sotiencoc
                    ShinhanData.phibaohiem = (ShinhanData.tienvay * ( Float(ShinhanData.selectedTragop?.insuranceFeeRate ?? 0) / 100)).cleanAfterDot
                    self.tableView.reloadRows(at: [newIndex], with: .none)
                }
                cell.onlick = { index in
                    if index == 0 {
                        let vc = ShinhanInstallmentList()
                        vc.listData = self.goiTragop?.data ?? []
                        vc.didselect = { data in
                            ShinhanData.selectedTragop = data
                            self.listKyhan = ShinhanData.selectedTragop?.loanTenure ?? []
                            self.tableView.reloadData()
                        }
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        self.setupDrop(view: cell.kyhan)
                    }
                }
                return cell
            case 4:
                let cell = tableView.dequeueTableCell(ShinhanPaymentCell.self)
                    cell.bindCell(totalPay: totalPay, tratruoc: ShinhanData.tientraTruoc, tienVay: ShinhanData.tienvay, giamgia: ShinhanData.giamgia, baohiem: ShinhanData.phibaohiem, tongDonhang: ShinhanData.tongTHanhtoan,sotiencoc:ShinhanData.sotiencoc)
                return cell
            case 5:
                let cell = tableView.dequeueTableCell(ButtonCell.self)
                cell.bindCellKM()
                cell.onAction = {
                    
                    if ShinhanData.selectedTragop == nil{
                        self.showAlert("Bạn chưa chọn gói trả góp")
                        return
                    }
                    if ShinhanData.selectedKyHan == nil {
                        self.showAlert("Bạn chưa chọn kỳ hạn trả góp!")
                        return
                    }
                    var voucher = ""
                    if(Cache.listVoucherMirae.count > 0){
                        voucher = "<line>"
                        for item in Cache.listVoucherMirae{
                            voucher  = voucher + "<item voucher=\"\(item)\" />"
                        }
                        voucher = voucher + "</line>"
                    }
                    Cache.voucherMirae = voucher
                    
                    let nc = NotificationCenter.default
                    let newViewController = LoadingViewController()
                    newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                    newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                    self.present(newViewController, animated: true, completion: nil)
                  
					MPOSAPIManager.checkPromotionMirae(  u_CrdCod: ShinhanData.detailorDerHistory?.customer?.idCard ?? "", sdt: ShinhanData.detailorDerHistory?.customer?.phone ?? "", LoaiDonHang: "02", LoaiTraGop: "02", LaiSuat: Float(self.selectedTragop?.interestRate ?? 0), SoTienTraTruoc: (ShinhanData.tientraTruoc + ShinhanData.sotiencoc),voucher:voucher, kyhan: "\(ShinhanData.selectedKyHan?.number ?? 0)", U_cardcode: "2322579", HDNum: "0",Docentry: "\(self.detailOrder?.customer?.mposSoNum ?? 0)",schemecode:self.selectedTragop?.schemeCode ?? "",isProsShinhanHistory: true) { (promotion, err) in
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
                                        //
                                        let alert = UIAlertController(title: "Thông báo", message: "Hết hàng ! Vui lòng chọn sản phẩm khác", preferredStyle: .alert)

                                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                            _ = self.navigationController?.popViewController(animated: true)
                                            self.dismiss(animated: true, completion: nil)
                                        })
                                        self.present(alert, animated: true)
                                        //
                                  
                                    }
                                }else{
                                    Cache.infoCustomerMirae?.sotientratruoc = ShinhanData.tientraTruoc
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
                                            Cache.cartsTemp = Cache.cartsMirae
                                            Cache.phoneTemp = ShinhanData.infoUser?.personalLoan?.phone ?? ""
                                            Cache.nameTemp = ShinhanData.infoUser?.personalLoan?.fullName ?? ""
                                            newViewController.productPromotions = (promotion?.productPromotions) ?? []
                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                        }
                                        // chuyen qua khuyen main
                                        
                                    }else{
                                        let when = DispatchTime.now() + 0.5
                                        DispatchQueue.main.asyncAfter(deadline: when) {
                                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                            let newViewController = DetailShinhanOrder()
                                            newViewController.type = .saveApplication
                                            
                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                            
                                            
                                        }
                                    }
                                }
                            }else{
                                Cache.infoCustomerMirae?.sotientratruoc = ShinhanData.tientraTruoc
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
                                        Cache.cartsTemp = Cache.cartsMirae
                                        Cache.phoneTemp = ShinhanData.infoUser?.personalLoan?.phone ?? ""
                                        Cache.nameTemp = ShinhanData.infoUser?.personalLoan?.fullName ?? ""
                                        newViewController.productPromotions = (promotion?.productPromotions) ?? []
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                    }
                                    // chuyen qua khuyen main
                                    
                                }else{
                                    let when = DispatchTime.now() + 0.5
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                        let newViewController = DetailShinhanOrder()
                                        newViewController.type = .saveApplication
                                        
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                        
                                        
                                    }
                                }
                            }
                            //
                     
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
                    
//                    let vc = ShinhanPromotionVC()
//                    self.navigationController?.pushViewController(vc, animated: true)
                }
                return cell
            default:
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == .detailCreate && indexPath.section == 1 && Cache.cartsMirae[indexPath.row].product.qlSerial == "Y" {
            self.selectImeiAction(index: indexPath.row)
        }
    }
    
}
