//
//  PaymentBaoKimViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 13/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class PaymentBaoKimViewController: UIViewController {

    @IBOutlet weak var lbBooking: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var tbvProduct: UITableView!
    @IBOutlet weak var cstProduct: NSLayoutConstraint!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var lbDiscount: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var tbvVoucher: UITableView!
    @IBOutlet weak var cstVoucher: NSLayoutConstraint!
    @IBOutlet weak var tbvPromotion: UITableView!
    @IBOutlet weak var cstPromotion: NSLayoutConstraint!
    @IBOutlet weak var vPromotion: UIView!
    @IBOutlet weak var vPromotionInfo: UIView!
    @IBOutlet weak var tbvSelectPromotion: UITableView!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var vVoucher: UIView!
    @IBOutlet weak var tfVoucher: UITextField!
    @IBOutlet weak var btnPayment: UIButton!
    
    private var product: BaoKimProduct = BaoKimProduct(JSON: [:])!
    private var promotions: [ProductPromotions] = []
    private var selectedPromotions: [ProductPromotions] = []
    private var promotionGroup: [String: [ProductPromotions]] = [:]
    private var selectedPromotionIndex: Int = 0
    private var selectedPromotionGroup: [(sl: String, name: String)] = []
    private var vouchers: [VoucherNoPrice] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadData()
    }
    
    private func setupUI() {
        title = "Thông tin đơn hàng"
        addBackButton(#selector(actionBack))
        
        if let bookingInfo = BaoKimDataManager.shared.bookingInfo.data.first {
            lbBooking.text = bookingInfo.code
            lbName.text = bookingInfo.customer.name
            lbPhone.text = bookingInfo.customer.phone
            lbEmail.text = bookingInfo.customer.email
            lbTotal.text = "\(Common.convertCurrencyV2(value: bookingInfo.amountBooking)) VNĐ"
            lbDiscount.text = "\(Common.convertCurrencyV2(value: BaoKimDataManager.shared.voucherInfo.data.info.fareInfo.couponValue)) VNĐ"
            lbPrice.text = BaoKimDataManager.shared.voucherInfo.data.info.code.isEmpty ?
            "\(Common.convertCurrencyV2(value: bookingInfo.amountBooking)) VNĐ" :
            "\(Common.convertCurrencyV2(value: BaoKimDataManager.shared.voucherInfo.data.info.fareInfo.finalFare)) VNĐ"
        }
    }
    
    @objc private func actionBack() {
        if btnPayment.title(for: .normal) == "KIỂM TRA KHUYẾN MÃI" {
            showAlertTwoButton(title: "Thông báo", with: "Bạn chưa hoàn tất thanh toán cho mã đặt vé này. Bạn có chắc muốn thoát?", titleButtonOne: "OK", titleButtonTwo: "Cancel", handleButtonOne: {
                self.navigationController?.popToRootViewController(animated: true)
            }, handleButtonTwo: nil)
        } else {
            btnPayment.setTitle("KIỂM TRA KHUYẾN MÃI", for: .normal)
            promotionGroup = [:]
            selectedPromotionIndex = 0
            selectedPromotionGroup = []
            
            if let bookingInfo = BaoKimDataManager.shared.bookingInfo.data.first {
                lbDiscount.text = "\(Common.convertCurrencyFloatV2(value: Float(BaoKimDataManager.shared.voucherInfo.data.info.fareInfo.couponValue))) VNĐ"
                lbPrice.text = BaoKimDataManager.shared.voucherInfo.data.info.code.isEmpty ?
                "\(Common.convertCurrencyFloatV2(value: Float(bookingInfo.amountBooking))) VNĐ" :
                "\(Common.convertCurrencyFloatV2(value: Float(BaoKimDataManager.shared.voucherInfo.data.info.fareInfo.finalFare))) VNĐ"
                tbvPromotion.reloadData()
                cstPromotion.constant = CGFloat(selectedPromotionGroup.count * 60)
            }
        }
    }
    
    private func setupTableView() {
        tbvProduct.registerTableCell(VietjetProductTableViewCell.self)
        tbvProduct.estimatedRowHeight = 100
        tbvProduct.rowHeight = UITableView.automaticDimension
        
        tbvPromotion.registerTableCell(VietjetPromotionTableViewCell.self)
        tbvPromotion.estimatedRowHeight = 100
        tbvPromotion.rowHeight = UITableView.automaticDimension
        
        tbvSelectPromotion.registerTableCell(VietjetSelectPromotionTableViewCell.self)
        tbvSelectPromotion.estimatedRowHeight = 100
        tbvSelectPromotion.rowHeight = UITableView.automaticDimension
        
        tbvVoucher.registerTableCell(VietjetPromotionTableViewCell.self)
        tbvVoucher.estimatedRowHeight = 100
        tbvVoucher.rowHeight = UITableView.automaticDimension
    }
    
    private func loadData() {
        Provider.shared.baokimAPIService.getMPOSProduct(success: { [weak self] result in
            guard let self = self, let data = result else { return }
            self.product = data
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func checkPromotion() {
        if let bookingInfo = BaoKimDataManager.shared.bookingInfo.data.first {
            let price = BaoKimDataManager.shared.voucherInfo.data.info.code.isEmpty ? bookingInfo.amountBooking : BaoKimDataManager.shared.voucherInfo.data.info.fareInfo.finalFare

            let product: Product = Product(model_id: "", id: 0, name: self.product.itemName, brandID: 0, brandName: "", typeId: 0, typeName: "", sku: self.product.itemCode, price: Float(price / bookingInfo.seats), priceMarket: 0, priceBeforeTax: Float(price / bookingInfo.seats), iconUrl: "", imageUrl: "", promotion: "", includeInfo: "", hightlightsDes: "", labelName: "", urlLabelPicture: "", isRecurring: false, manSerNum: "", bonusScopeBoom: "", qlSerial: "", inventory: 0, LableProduct: "", p_matkinh: "", ecomColorValue: "", ecomColorName: "", ecom_itemname_web: "", price_special: 0, price_online_pos: 0, price_online: 0, hotSticker: false, is_NK: false,is_ExtendedWar:false,skuBH:[],nameBH:[],brandGoiBH:[],isPickGoiBH:"",amountGoiBH:"",itemCodeGoiBH:"",itemNameGoiBH:"",priceSauKM: 0,role2:[])

            let item: Cart = Cart(sku: self.product.itemCode, product: product, quantity: bookingInfo.seats, color: "", inStock: 0, imei: "", price: Float(price / bookingInfo.seats), priceBT: Float(price / bookingInfo.seats), whsCode: "", discount: 0, reason: "", note: "", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
            Cache.carts = []
            Cache.type_so = 0
            Cache.DocEntryEcomCache = 0
            
            Cache.carts.append(item)
            
            ProgressView.shared.show()
            MPOSAPIManager.checkPromotionNew(u_CrdCod: "0", sdt: BaoKimDataManager.shared.phone, LoaiDonHang: "01", LoaiTraGop: "", LaiSuat: 0, SoTienTraTruoc: 0, voucher: "", kyhan: "0", U_cardcode: "0", HDNum: "", is_KHRotTG: 0, is_DH_DuAn: "", handler: { [weak self] promotion, err in
                ProgressView.shared.hide()
                guard let self = self else { return }
                if promotion != nil {
                    if let reasons = promotion?.unconfirmationReasons {
                        var notify: String = ""
                        for item in reasons {
                            if item.issuccess == 0 {
                                if notify == "" {
                                    notify = "\(item.ItemCode)"
                                } else {
                                    notify = "\(notify),\(item.ItemCode)"
                                }
                            }
                        }
                        if notify != "" {
                            self.showAlertOneButton(title: "Thông báo", with: "Mã sản phẩm \(notify) vi phạm nguyên tắc giảm giá. Vui lòng kiểm tra lại!", titleButton: "OK")
                        }
                    }
                    
                    if let promotions = promotion?.productPromotions {
                        self.promotions = promotions
                        self.preparePromotions()
                    }
                } else {
                    self.showAlertOneButton(title: "Thông báo", with: err, titleButton: "OK")
                }
            })
        }
    }
    
    private func preparePromotions() {
        for promotion in promotions {
            if promotionGroup[promotion.Nhom] != nil {
                promotionGroup[promotion.Nhom]!.append(promotion)
            } else {
                var tempPromotion: [ProductPromotions] = []
                tempPromotion.append(promotion)
                promotionGroup[promotion.Nhom] = tempPromotion
            }
        }
        
        if promotionGroup.keys.count > 0 {
            vPromotion.isHidden = false
            tbvSelectPromotion.reloadData()
        } else {
            showAlertOneButton(title: "Thông báo", with: "Không có chương trình khuyến mãi khả dụng", titleButton: "OK", handleOk: nil)
        }
    }
    
    private func setupPromotionData() {
        var discount: Float = 0
        for promotion in selectedPromotions {
            if promotion.TienGiam > 0 {
                let tuple = (sl: "1", name: "Giảm giá: \(Common.convertCurrencyFloatV2(value: promotion.TienGiam)) VNĐ")
                selectedPromotionGroup.append(tuple)
                discount += promotion.TienGiam
            }
            
            if !promotion.TenSanPham_Tang.isEmpty {
                let tuple = (sl: "\(promotion.SL_Tang)", name: promotion.TenSanPham_Tang)
                selectedPromotionGroup.append(tuple)
            }
        }
        
        if let bookingInfo = BaoKimDataManager.shared.bookingInfo.data.first {
            lbDiscount.text = "\(Common.convertCurrencyFloatV2(value: Float(BaoKimDataManager.shared.voucherInfo.data.info.fareInfo.couponValue) + discount)) VNĐ"
            lbPrice.text = BaoKimDataManager.shared.voucherInfo.data.info.code.isEmpty ?
            "\(Common.convertCurrencyFloatV2(value: Float(bookingInfo.amountBooking) - discount)) VNĐ" :
            "\(Common.convertCurrencyFloatV2(value: Float(BaoKimDataManager.shared.voucherInfo.data.info.fareInfo.finalFare) - discount)) VNĐ"
            tbvPromotion.reloadData()
            cstPromotion.constant = CGFloat(selectedPromotionGroup.count * 60)
        }
    }
    
    @IBAction func addVoucherButtonPressed(_ sender: Any) {
        vVoucher.isHidden = false
        tfVoucher.text = ""
    }
    
    @IBAction func checkVoucherButtonPressed(_ sender: Any) {
        guard let voucher = tfVoucher.text, !voucher.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập mã voucher", titleButton: "OK", handleOk: nil)
            return
        }
        
        ProgressView.shared.show()
        MPOSAPIManager.mpos_FRT_SP_check_VC_crm(voucher: voucher, sdt: BaoKimDataManager.shared.phone, doctype: "") { p_status, p_message, err in
            ProgressView.shared.hide()
            if err.count <= 0 {
                if p_status == 2 {
                    self.vouchers = []
                    self.showAlertOneButton(title: "Thông báo", with: p_message, titleButton: "OK", handleOk: nil)
                } else {
                    let voucherObject = VoucherNoPrice(VC_Code: voucher, VC_Name: "", Endate: "", U_OTPcheck: "", STT: 0, isSelected: true)
                    self.vouchers.append(voucherObject)
                    self.tbvVoucher.reloadData()
                    self.cstVoucher.constant = CGFloat(self.vouchers.count * 60)
                    self.vVoucher.isHidden = true
                }
            } else {
                self.showAlertOneButton(title: "Thông báo", with: err, titleButton: "OK", handleOk: nil)
            }
        }
    }
    
    @IBAction func cancelVoucherButtonPressed(_ sender: Any) {
        vVoucher.isHidden = true
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        vPromotion.isHidden = true
        if selectedPromotionIndex < promotionGroup.keys.count {
            let index = promotionGroup.index(promotionGroup.startIndex, offsetBy: selectedPromotionIndex)
            let key = promotionGroup.keys[index]
            
            selectedPromotions = promotionGroup[key]!
        }
        
        setupPromotionData()
    }
    
    @IBAction func paymentButtonPressed(_ sender: Any) {
        if btnPayment.title(for: .normal) == "KIỂM TRA KHUYẾN MÃI" {
            checkPromotion()
            btnPayment.setTitle("THANH TOÁN", for: .normal)
        } else {
            showAlertTwoButton(title: "Thông báo", with: "Bạn chắc chắn muốn thanh toán?", titleButtonOne: "OK", titleButtonTwo: "Cancel", handleButtonOne: {
                if let bookingInfo = BaoKimDataManager.shared.bookingInfo.data.first {
                    var discount: Float = 0
                    let price: Float = Float(BaoKimDataManager.shared.voucherInfo.data.info.code.isEmpty ? bookingInfo.amountBooking : BaoKimDataManager.shared.voucherInfo.data.info.fareInfo.finalFare)
                    
                    let rdr1 = "<line><item U_ItmCod=\"\(self.product.itemCode)\" U_Imei=\"\" U_Quantity=\"\(bookingInfo.seats)\" PhoneNumber=\"\(BaoKimDataManager.shared.phone)\" Warr_imei=\"\" U_Price=\"\(String(format: "%.6f", price / Float(bookingInfo.seats)))\" U_WhsCod=\"\(Cache.user!.ShopCode)010\" U_ItmName=\"\(self.product.itemName)\" /></line>"
                    
                    var xmlVoucher = "<line>"
                    for voucher in self.vouchers {
                        let xml = "<item voucher=\"\(voucher.VC_Code)\" />"
                        xmlVoucher += xml
                    }
                    xmlVoucher += "</line>"
                    
                    for promotion in self.selectedPromotions {
                        discount += promotion.TienGiam
                    }
                    let xmlPayment = "<line><item Totalcash=\"\(price - discount)\" Totalcardcredit=\"0\" Numcard=\"\" IDBankCard=\"\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" IDQrCode=\"\" TotalQRCode=\"0\" TypeBank=\"\" /></line>"
                    
                    var xmlPromotion = "<line>"
                    for promotion in self.selectedPromotions {
                        let xml = "<item SanPham_Mua=\"\(promotion.SanPham_Mua)\" TienGiam=\"\(promotion.TienGiam)\" LoaiKM=\"\(promotion.Loai_KM)\" SanPham_Tang=\"\(promotion.SanPham_Tang)\" TenSanPham_Tang=\"\(promotion.TenSanPham_Tang)\" SL_Tang=\"\(promotion.SL_Tang)\" Nhom=\"\(promotion.Nhom)\" MaCTKM=\"\(promotion.MaCTKM)\" TenCTKM=\"\(promotion.TenCTKM)\" SLThayThe=\"\(promotion.SL_ThayThe)\" MenhGia_VC=\"\(promotion.MenhGia_VC)\" VC_used=\"\(promotion.VC_used)\" KhoTang=\"\(promotion.KhoTang)\" is_imei=\"\(promotion.is_imei)\" imei=\"\" />"
                        xmlPromotion += xml
                    }
                    xmlPromotion += "</line>"
                    xmlPromotion = self.selectedPromotions.isEmpty ? "<line><item></item></line>" : xmlPromotion
                    
                    Provider.shared.baokimAPIService.updateMPOSPayment(bookingCode: BaoKimDataManager.shared.bookingCode.bookingCode, transactionCode: BaoKimDataManager.shared.bookingCode.transactionID, voucher: BaoKimDataManager.shared.voucherInfo.data.info.code, des: "", rdr1: rdr1, promos: xmlPromotion, voucherMPOS: xmlVoucher, xmlPayment: xmlPayment, xmlVoucher: xmlVoucher, success: { [weak self] result in
                        guard let self = self, let data = result else { return }
                        self.showAlertOneButton(title: "Thông báo", with: data.message, titleButton: "OK", handleOk: {
                            BaoKimDataManager.shared.resetCustomer()
                            BaoKimDataManager.shared.resetData()
                            BaoKimDataManager.shared.resetParam()
                            self.navigationController?.popToRootViewController(animated: true)
                        })
                    }, failure: { [weak self] error in
                        guard let self = self else { return }
                        self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                    })
                }
            }, handleButtonTwo: nil)
        }
    }
}

extension PaymentBaoKimViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tbvProduct:
            return 1
        case tbvSelectPromotion:
            return promotionGroup.keys.count
        case tbvVoucher:
            return vouchers.count
        default:
            return selectedPromotionGroup.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case tbvProduct:
            let cell = tableView.dequeueTableCell(VietjetProductTableViewCell.self)
            
            if let bookingInfo = BaoKimDataManager.shared.bookingInfo.data.first {
                cell.lbName.text = "\(bookingInfo.code) - \(bookingInfo.company)"
                cell.lbQuantiy.text = "SL: \(bookingInfo.seats)"
                cell.lbPrice.text = BaoKimDataManager.shared.voucherInfo.data.info.code.isEmpty ?
                "Giá: \(Common.convertCurrencyV2(value: bookingInfo.amountBooking)) VNĐ" :
                "Giá: \(Common.convertCurrencyV2(value: BaoKimDataManager.shared.voucherInfo.data.info.fareInfo.finalFare)) VNĐ"
            }
            
            return cell
        case tbvSelectPromotion:
            let cell = tableView.dequeueTableCell(VietjetSelectPromotionTableViewCell.self)
            let index = promotionGroup.index(promotionGroup.startIndex, offsetBy: indexPath.row)
            let key = promotionGroup.keys[index]
            
            cell.setupCell(key, promotions: promotionGroup[key]!, isSelected: indexPath.row == selectedPromotionIndex)
            return cell
        case tbvVoucher:
            let cell = tableView.dequeueTableCell(VietjetPromotionTableViewCell.self)
            
            cell.lbIndex.text = "\(indexPath.row + 1)"
            cell.lbName.text = vouchers[indexPath.row].VC_Code
            cell.lbQuantity.text = "SL: 1"
            
            return cell
        default:
            let cell = tableView.dequeueTableCell(VietjetPromotionTableViewCell.self)
            
            cell.lbIndex.text = "\(indexPath.row + 1)"
            cell.lbName.text = selectedPromotionGroup[indexPath.row].name
            cell.lbQuantity.text = "SL: \(selectedPromotionGroup[indexPath.row].sl)"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case tbvSelectPromotion:
            selectedPromotionIndex = indexPath.row
            tbvSelectPromotion.reloadData()
        default:
            break
        }
    }
}
