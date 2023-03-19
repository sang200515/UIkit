//
//  VietjetPaymentViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetPaymentViewController: UIViewController {
    
    @IBOutlet weak var svCode: UIStackView!
    @IBOutlet weak var lbCode: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var tbvProduct: UITableView!
    @IBOutlet weak var cstProduct: NSLayoutConstraint!
    @IBOutlet weak var tbvPromotion: UITableView!
    @IBOutlet weak var cstPromotion: NSLayoutConstraint!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbDiscount: UILabel!
    @IBOutlet weak var lbPay: UILabel!
    @IBOutlet weak var btnPromotion: UIButton!
    @IBOutlet weak var vPromotion: UIView!
    @IBOutlet weak var vPromotionInfo: UIView!
    @IBOutlet weak var tbvSelectPromotion: UITableView!
    @IBOutlet weak var btnContinue: UIButton!
    
    //MARK:- PROMOTION
    @IBOutlet weak var vPromotionSection: UIView!
    @IBOutlet weak var cstPromotionSection: NSLayoutConstraint!
    
    //MARK:- CONDITIONS
    @IBOutlet weak var vCondition: UIView!
    @IBOutlet weak var imgCondition: UIImageView!
    @IBOutlet weak var tvCondition: UITextView!
    
    var bill: VietjetBill = VietjetBill(JSON: [:])!
    var order: VietjetHistoryOrder = VietjetHistoryOrder(JSON: [:])!
    var isHistory: Bool = false
    private var items: [[String : String]] = [] {
        didSet {
            if !isHistory {
                setupPrice()
                tbvProduct.reloadData()
                cstProduct.constant = CGFloat(90 * items.count)
            }
        }
    }
    private var selectedPromotions: [VietjetPromotion] = []
    private var promotionGroup: [String: [VietjetPromotion]] = [:]
    private var selectedPromotionIndex: Int = 0
    private var selectedPromotionGroup: [(sl: String, name: String)] = []
    private var xmlPromotion: String = ""
    private var xmlPayment: String = ""
    private var isAcceptCondition: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupCondition()
    }
    
    private func setupUI() {
        title = "Thông tin đơn hàng"
        addBackButton()
        
        vPromotionInfo.roundCorners(.allCorners, radius: 6)
        btnPromotion.roundCorners(.allCorners, radius: 5)
        btnContinue.roundCorners(.allCorners, radius: 5)
        
        if isHistory {
            vCondition.isHidden = true
            btnPromotion.isHidden = true
            svCode.isHidden = false
            lbCode.text = order.order.contact.locator
            lbName.text = order.order.contact.contactName
            lbPhone.text = order.order.contact.contactPhone
            lbEmail.text = order.order.contact.contactEmail
            lbPrice.text = "\(Common.convertCurrencyV2(value: order.order.payment.totalAmount)) VNĐ"
            lbDiscount.text = "\(Common.convertCurrencyV2(value: order.order.payment.discount)) VNĐ"
            lbPay.text = "\(Common.convertCurrencyV2(value: order.order.payment.totalPay)) VNĐ"
            
            return
        }
        
        lbName.text = VietjetDataManager.shared.isAddon || VietjetDataManager.shared.isChangeFlight ? VietjetDataManager.shared.historyBooking.contactInformation.name : VietjetDataManager.shared.contact.fullName
        lbPhone.text = VietjetDataManager.shared.isAddon || VietjetDataManager.shared.isChangeFlight ? VietjetDataManager.shared.historyBooking.contactInformation.phoneNumber : VietjetDataManager.shared.contact.phoneNumber
        lbEmail.text = VietjetDataManager.shared.isAddon || VietjetDataManager.shared.isChangeFlight ? VietjetDataManager.shared.historyBooking.contactInformation.email : VietjetDataManager.shared.contact.email
        
        if VietjetDataManager.shared.isUpdateSeat || VietjetDataManager.shared.isChangeFlight {
            btnPromotion.setTitle("HOÀN TẤT", for: .normal)
            vPromotionSection.isHidden = true
            cstPromotionSection.constant = 0
        }
        
        let paser = XMLParser(data: bill.xmlItemProducts.data)
        paser.delegate = self
        paser.parse()
    }
    
    private func setupCondition() {
        changeCondition()
        
        let text = NSMutableAttributedString(string: "Tôi đã đọc và đồng ý với ")
        text.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14, weight: .medium), range: NSMakeRange(0, text.length))
        
        let selectablePart = NSMutableAttributedString(string: "Điều kiện giá vé, Điều kiện vận chuyển")
        selectablePart.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14, weight: .medium), range: NSMakeRange(0, selectablePart.length))
        selectablePart.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, selectablePart.length))
        selectablePart.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.blue, range: NSMakeRange(0, selectablePart.length))
        selectablePart.addAttribute(NSAttributedString.Key.link, value: "https://www.vietjetair.com/vi/pages/de-co-chuyen-bay-tot-dep-1578323501979/dieu-le-van-chuyen-1601835865384", range: NSMakeRange(0, selectablePart.length))
        text.append(selectablePart)
        
        let endText = NSMutableAttributedString(string: " của VietjetAir.")
        endText.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14, weight: .medium), range: NSMakeRange(0, endText.length))
        text.append(endText)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        text.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, text.length))
        
        tvCondition.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium)]
        
        DispatchQueue.main.async {
            self.tvCondition.attributedText = text
            self.tvCondition.isEditable = false
            self.tvCondition.isSelectable = true
            self.tvCondition.delegate = self
        }
    }
    
    private func changeCondition() {
        let selectedImage = UIImage(named: "selected_ic")!
        let unselectedImage = UIImage(named: "unselected_ic")!
        
        imgCondition.image = isAcceptCondition ? selectedImage : unselectedImage
    }
    
    private func setupPrice() {
        lbPrice.text = "\(Common.convertCurrencyV2(value: bill.totalAmountFRT)) VNĐ"
        
        var discount = 0
        for promotion in selectedPromotions {
            discount += promotion.tienGiam
        }
        lbDiscount.text = "\(Common.convertCurrencyV2(value: discount)) VNĐ"
        lbPay.text = "\(Common.convertCurrencyV2(value: bill.totalAmountFRT - discount)) VNĐ"
    }
    
    private func setupTableView() {
        tbvProduct.registerTableCell(VietjetProductTableViewCell.self)
        tbvProduct.estimatedRowHeight = 100
        tbvProduct.rowHeight = UITableView.automaticDimension
        
        tbvPromotion.registerTableCell(VietjetPromotionTableViewCell.self)
        tbvPromotion.estimatedRowHeight = 100
        tbvProduct.rowHeight = UITableView.automaticDimension
        
        tbvSelectPromotion.registerTableCell(VietjetSelectPromotionTableViewCell.self)
        tbvSelectPromotion.estimatedRowHeight = 100
        tbvSelectPromotion.rowHeight = UITableView.automaticDimension
        
        if isHistory {
            cstProduct.constant = CGFloat(90 * order.order.products.count)
            cstPromotion.constant = CGFloat(60 * order.order.promotions.count)
        }
    }
    
    private func prepareXML() {
        var discount = 0
        for promotion in selectedPromotions {
            discount += promotion.tienGiam
        }
        xmlPayment = "<line><item Totalcash=\"\(bill.totalAmountFRT - discount)\" Totalcardcredit=\"0\" Numcard=\"\" IDBankCard=\"\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" IDQrCode=\"\" TotalQRCode=\"0\" TypeBank=\"\" /></line>"
        
        xmlPromotion = "<line>"
        for promotion in selectedPromotions {
            let xml = "<item SanPham_Mua=\"\(promotion.sanPhamMUA)\" TienGiam=\"\(promotion.tienGiam)\" LoaiKM=\"\(promotion.loaiKM)\" SanPham_Tang=\"\(promotion.sanPhamTang)\" TenSanPham_Tang=\"\(promotion.tenSANPhamTang)\" SL_Tang=\"\(promotion.slTang)\" Nhom=\"\(promotion.nhom)\" MaCTKM=\"\(promotion.maCTKM)\" TenCTKM=\"\(promotion.tenCTKM)\" SLThayThe=\"\(promotion.slThayThe)\" MenhGia_VC=\"\(promotion.menhGiaVC)\" VC_used=\"\(promotion.vcUsed)\" KhoTang=\"\(promotion.khoTang)\" is_imei=\"\(promotion.isImei)\" imei=\"\" />"
            xmlPromotion += xml
        }
        xmlPromotion += "</line>"
        xmlPromotion = selectedPromotions.isEmpty ? "<line><item></item></line>" : xmlPromotion
    }
    
    private func prepareParam() {
        prepareXML()
        
        VietjetDataManager.shared.orderParam.order.totalAmount = bill.totalAmount
        VietjetDataManager.shared.orderParam.order.totalAmountFRT = bill.totalAmountFRT
        VietjetDataManager.shared.orderParam.order.xmlPayments = xmlPayment
        VietjetDataManager.shared.orderParam.order.xmlPromotions = xmlPromotion
        VietjetDataManager.shared.orderParam.order.xmlItemProducts = bill.xmlItemProducts
    }
    
    private func prepareBaggageParam() {
        prepareXML()
        
        VietjetDataManager.shared.ancillaryOrderParam.order.totalAmount = bill.totalAmount
        VietjetDataManager.shared.ancillaryOrderParam.order.totalAmountFRT = bill.totalAmountFRT
        VietjetDataManager.shared.ancillaryOrderParam.order.xmlPayments = xmlPayment
        VietjetDataManager.shared.ancillaryOrderParam.order.xmlPromotions = xmlPromotion
        VietjetDataManager.shared.ancillaryOrderParam.order.xmlItemProducts = bill.xmlItemProducts
    }
    
    private func prepareSeatParam() {
        prepareXML()
        
        VietjetDataManager.shared.seatOrderParam.order.totalAmount = bill.totalAmount
        VietjetDataManager.shared.seatOrderParam.order.totalAmountFRT = bill.totalAmountFRT
        VietjetDataManager.shared.seatOrderParam.order.xmlPayments = xmlPayment
        VietjetDataManager.shared.seatOrderParam.order.xmlPromotions = xmlPromotion
        VietjetDataManager.shared.seatOrderParam.order.xmlItemProducts = bill.xmlItemProducts
    }
    
    private func prepareUpdateFlightParam() {
        prepareXML()
        
        VietjetDataManager.shared.changeFlightParam.order.totalAmount = bill.totalAmount
        VietjetDataManager.shared.changeFlightParam.order.totalAmountFRT = bill.totalAmountFRT
        VietjetDataManager.shared.changeFlightParam.order.xmlPayments = xmlPayment
        VietjetDataManager.shared.changeFlightParam.order.xmlPromotions = xmlPromotion
        VietjetDataManager.shared.changeFlightParam.order.xmlItemProducts = bill.xmlItemProducts
    }
    
    private func preparePromotions(_ promotions: [VietjetPromotion]) {
        for promotion in promotions {
            if promotionGroup[promotion.nhom] != nil {
                promotionGroup[promotion.nhom]!.append(promotion)
            } else {
                var tempPromotion: [VietjetPromotion] = []
                tempPromotion.append(promotion)
                promotionGroup[promotion.nhom] = tempPromotion
            }
        }
        
        self.vPromotion.isHidden = false
        self.tbvSelectPromotion.reloadData()
    }
    
    @IBAction func promotionButtonPressed(_ sender: Any) {
        if !isAcceptCondition {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng đồng ý Điều kiện giá vé, Điều kiện vận chuyển của VietjetAir", titleButton: "OK")
        } else {
            if btnPromotion.title(for: .normal) == "KIỂM TRA KHUYẾN MÃI" {
                let phone = VietjetDataManager.shared.isAddon || VietjetDataManager.shared.isChangeFlight ? VietjetDataManager.shared.historyBooking.contactInformation.phoneNumber : VietjetDataManager.shared.contact.phoneNumber
                Provider.shared.vietjetAPIService.checkPromotions(phone: phone, xml: bill.xmlItemProducts, success: { [weak self] data in
                    guard let self = self, let result = data else { return }
                    self.preparePromotions(result.promotions)
                }, failure: { [weak self] error in
                    guard let self = self else { return }
                    self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                })
                
                btnPromotion.setTitle("HOÀN TẤT", for: .normal)
            } else {
                if VietjetDataManager.shared.isAddon {
                    if VietjetDataManager.shared.isAddonBaggage {
                        prepareBaggageParam()
                        Provider.shared.vietjetAPIService.createVietjetAncillary(param: VietjetDataManager.shared.ancillaryOrderParam, success: { [weak self] data in
                            guard let self = self, let result = data else { return }
                            self.showAlertOneButton(title: "Thông báo", with: result.messages, titleButton: "OK", handleOk: {
                                VietjetDataManager.shared.resetAddon()
                                for controller in self.navigationController!.viewControllers as Array {
                                    if controller.isKind(of: VietjetBookingMenuViewController.self) {
                                        self.navigationController!.popToViewController(controller, animated: true)
                                        break
                                    }
                                }
                            })
                        }, failure: { [weak self] error in
                            guard let self = self else { return }
                            if error.description == "Request timeout!" {
                                self.showAlertOneButton(title: "Thông báo", with: "Vui lòng không thao tác tiếp và báo support để kiểm tra trạng thái đặt vé!", titleButton: "OK", handleOk: {
                                    VietjetDataManager.shared.resetAddon()
                                    for controller in self.navigationController!.viewControllers as Array {
                                        if controller.isKind(of: VietjetBookingMenuViewController.self) {
                                            self.navigationController!.popToViewController(controller, animated: true)
                                            break
                                        }
                                    }
                                })
                            } else {
                                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                            }
                        })
                    } else {
                        prepareSeatParam()
                        if VietjetDataManager.shared.isUpdateSeat {
                            Provider.shared.vietjetAPIService.createVietjetUpdateSeat(param: VietjetDataManager.shared.seatOrderParam, success: { [weak self] data in
                                guard let self = self, let result = data else { return }
                                self.showAlertOneButton(title: "Thông báo", with: result.messages, titleButton: "OK", handleOk: {
                                    VietjetDataManager.shared.resetAddon()
                                    for controller in self.navigationController!.viewControllers as Array {
                                        if controller.isKind(of: VietjetBookingMenuViewController.self) {
                                            self.navigationController!.popToViewController(controller, animated: true)
                                            break
                                        }
                                    }
                                })
                            }, failure: { [weak self] error in
                                guard let self = self else { return }
                                if error.description == "Request timeout!" {
                                    self.showAlertOneButton(title: "Thông báo", with: "Vui lòng không thao tác tiếp và báo support để kiểm tra trạng thái đặt vé!", titleButton: "OK", handleOk: {
                                        VietjetDataManager.shared.resetAddon()
                                        for controller in self.navigationController!.viewControllers as Array {
                                            if controller.isKind(of: VietjetBookingMenuViewController.self) {
                                                self.navigationController!.popToViewController(controller, animated: true)
                                                break
                                            }
                                        }
                                    })
                                } else {
                                    self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                                }
                            })
                        } else {
                            Provider.shared.vietjetAPIService.createVietjetSeat(param: VietjetDataManager.shared.seatOrderParam, success: { [weak self] data in
                                guard let self = self, let result = data else { return }
                                self.showAlertOneButton(title: "Thông báo", with: result.messages, titleButton: "OK", handleOk: {
                                    VietjetDataManager.shared.resetAddon()
                                    for controller in self.navigationController!.viewControllers as Array {
                                        if controller.isKind(of: VietjetBookingMenuViewController.self) {
                                            self.navigationController!.popToViewController(controller, animated: true)
                                            break
                                        }
                                    }
                                })
                            }, failure: { [weak self] error in
                                guard let self = self else { return }
                                if error.description == "Request timeout!" {
                                    self.showAlertOneButton(title: "Thông báo", with: "Vui lòng không thao tác tiếp và báo support để kiểm tra trạng thái đặt vé!", titleButton: "OK", handleOk: {
                                        VietjetDataManager.shared.resetAddon()
                                        for controller in self.navigationController!.viewControllers as Array {
                                            if controller.isKind(of: VietjetBookingMenuViewController.self) {
                                                self.navigationController!.popToViewController(controller, animated: true)
                                                break
                                            }
                                        }
                                    })
                                } else {
                                    self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                                }
                            })
                        }
                    }
                } else if VietjetDataManager.shared.isChangeFlight {
                    prepareUpdateFlightParam()
                    Provider.shared.vietjetAPIService.createVietjetUpdateFlight(param: VietjetDataManager.shared.changeFlightParam, success: { [weak self] data in
                        guard let self = self, let result = data else { return }
                        self.showAlertOneButton(title: "Thông báo", with: result.messages, titleButton: "OK", handleOk: {
                            VietjetDataManager.shared.resetChangeFlight()
                            for controller in self.navigationController!.viewControllers as Array {
                                if controller.isKind(of: VietjetBookingMenuViewController.self) {
                                    self.navigationController!.popToViewController(controller, animated: true)
                                    break
                                }
                            }
                        })
                    }, failure: { [weak self] error in
                        guard let self = self else { return }
                        if error.description == "Request timeout!" {
                            self.showAlertOneButton(title: "Thông báo", with: "Vui lòng không thao tác tiếp và báo support để kiểm tra trạng thái đặt vé!", titleButton: "OK", handleOk: {
                                VietjetDataManager.shared.resetChangeFlight()
                                for controller in self.navigationController!.viewControllers as Array {
                                    if controller.isKind(of: VietjetBookingMenuViewController.self) {
                                        self.navigationController!.popToViewController(controller, animated: true)
                                        break
                                    }
                                }
                            })
                        } else {
                            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                        }
                    })
                } else {
                    prepareParam()
                    Provider.shared.vietjetAPIService.createReservation(param: VietjetDataManager.shared.orderParam, success: { [weak self] data in
                        guard let self = self, let result = data else { return }
                        self.showAlertOneButton(title: "Thông báo", with: result.messages, titleButton: "OK", handleOk: {
                            VietjetDataManager.shared.resetData()
                            for controller in self.navigationController!.viewControllers as Array {
                                if controller.isKind(of: BookingVietjetFlightViewController.self) {
                                    self.navigationController!.popToViewController(controller, animated: true)
                                    break
                                }
                            }
                        })
                    }, failure: { [weak self] error in
                        guard let self = self else { return }
                        if error.description == "Request timeout!" {
                            self.showAlertOneButton(title: "Thông báo", with: "Vui lòng không thao tác tiếp và báo support để kiểm tra trạng thái đặt vé!", titleButton: "OK", handleOk: {
                                VietjetDataManager.shared.resetData()
                                for controller in self.navigationController!.viewControllers as Array {
                                    if controller.isKind(of: BookingVietjetFlightViewController.self) {
                                        self.navigationController!.popToViewController(controller, animated: true)
                                        break
                                    }
                                }
                            })
                        } else {
                            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                        }
                    })
                }
            }
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        vPromotion.isHidden = true
        if selectedPromotionIndex < promotionGroup.keys.count {
            let index = promotionGroup.index(promotionGroup.startIndex, offsetBy: selectedPromotionIndex)
            let key = promotionGroup.keys[index]
            
            selectedPromotions = promotionGroup[key]!
        }
        
        setupPromotionData()
        setupPrice()
    }
    
    private func setupPromotionData() {
        for promotion in selectedPromotions {
            if promotion.tienGiam > 0 {
                let tuple = (sl: "1", name: "Giảm giá: \(Common.convertCurrencyV2(value: promotion.tienGiam)) VNĐ")
                selectedPromotionGroup.append(tuple)
            }
            
            if !promotion.tenSANPhamTang.isEmpty {
                let tuple = (sl: "\(promotion.slTang)", name: promotion.tenSANPhamTang)
                selectedPromotionGroup.append(tuple)
            }
        }
        
        tbvPromotion.reloadData()
        cstPromotion.constant = CGFloat(selectedPromotionGroup.count * 60)
    }
    
    @IBAction func conditionButtonPressed(_ sender: Any) {
        if btnPromotion.title(for: .normal) == "KIỂM TRA KHUYẾN MÃI" || VietjetDataManager.shared.isUpdateSeat || VietjetDataManager.shared.isChangeFlight {
            isAcceptCondition = !isAcceptCondition
            changeCondition()
        }
    }
}

extension VietjetPaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tbvProduct:
            return isHistory ? order.order.products.count : items.count
        case tbvSelectPromotion:
            return promotionGroup.keys.count
        default:
            return isHistory ? order.order.promotions.count : selectedPromotionGroup.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case tbvProduct:
            let cell = tableView.dequeueTableCell(VietjetProductTableViewCell.self)
            
            if isHistory {
                cell.lbName.text = "\(order.order.products[indexPath.row].itemCode) - \(order.order.products[indexPath.row].dscription)"
                cell.lbQuantiy.text = "SL: \(order.order.products[indexPath.row].quantity)"
                cell.lbPrice.text = "Giá: \(Common.convertCurrencyV2(value: order.order.products[indexPath.row].price)) VNĐ"
            } else {
                cell.lbName.text = "\(items[indexPath.row]["U_ItmCod"]&) - \(items[indexPath.row]["U_ItmName"]&)"
                cell.lbQuantiy.text = "SL: \(items[indexPath.row]["U_Quantity"]&)"
                let price = Float(items[indexPath.row]["U_Price"] ?? "0.0") ?? 0.0
                cell.lbPrice.text = "Giá: \(Common.convertCurrencyV2(value: Int(price.rounded(.toNearestOrEven)))) VNĐ"
            }
            return cell
        case tbvSelectPromotion:
            let cell = tableView.dequeueTableCell(VietjetSelectPromotionTableViewCell.self)
            let index = promotionGroup.index(promotionGroup.startIndex, offsetBy: indexPath.row)
            let key = promotionGroup.keys[index]
            
            cell.setupCell(key, promotions: promotionGroup[key]!, isSelected: indexPath.row == selectedPromotionIndex)
            return cell
        default:
            let cell = tableView.dequeueTableCell(VietjetPromotionTableViewCell.self)
            
            if isHistory {
                cell.lbIndex.text = "\(indexPath.row + 1)"
                cell.lbName.text = order.order.promotions[indexPath.row].tenCTKM
                cell.lbQuantity.text = "SL: 1"
            } else {
                cell.lbIndex.text = "\(indexPath.row + 1)"
                cell.lbName.text = selectedPromotionGroup[indexPath.row].name
                cell.lbQuantity.text = "SL: \(selectedPromotionGroup[indexPath.row].sl)"
            }
            
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

extension VietjetPaymentViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            items.append(attributeDict)
        }
    }
}

extension VietjetPaymentViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let vc = TicketDetailPopupViewController()
        vc.url = URL
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        
        self.present(vc, animated: true, completion: nil)
        return false
    }
}
