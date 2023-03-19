//
//  PayViewControllerV2.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 3/1/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DLRadioButton
import PopupDialog
import Toaster
import ActionSheetPicker_3_0
import KeychainSwift
import SkyFloatingLabelTextField
import DLRadioButton
import AVFoundation

class PayViewControllerV2: UIViewController,UITextFieldDelegate,UITextViewDelegate,ListBankPayViewControllerDelegate,ListBankTypePayViewControllerDelegate,UIAdaptivePresentationControllerDelegate {
    
    //---
    var isEnableWallet = false
    var carts:[Cart] = []
    var itemsPromotion: [ProductPromotions] = []
    var phone: String = ""
    var name: String = ""
    var code: Int = 0
    var address: String = ""
    var email: String = ""
    var note: String = ""
    var type: String = ""
    var payment: String = ""
    var docEntry: String = ""
    var birthday:String = ""
    var gender:Int = 0
    var debitCustomer:DebitCustomer?
    
    var orderType:Int = -1
    var orderPayType:Int = -1
    var orderPayInstallment:Int = -1
    var valueInterestRate:Float = 0
    var valuePrepay:Float = 0
    var payPoint:Bool = false
    var totalPayment:Int = 0
    var voucherSum:Float = 0
    var buttonSaveAction:Bool = false
    var listVoucher:[GenVoucher] = []
    var toshibaPoint:ToshibaPoint?
    var totalPaymentBK:Float = 0
    var txnId:String = ""
    var orderID = ""
    var detailRes: AirpayResponse?
    var zaloModel:ZaloGenQRCodeModel?
    var detailMoney = 0
    var sanPhamXML:String = ""
    var isDisableTxtMoca = false

    //---
    
    var scrollView:UIScrollView!
    var typeCard:UIView!
    var typeCash:UIView!
    var typePayView:UIView!
    var typeWallet:UIView!
    var lbTypeCash:UILabel!
    var lbTypeCard:UILabel!
    var lbTypeWallet:UILabel!
    var typeCashPayment:Bool = true
    var typeCardPayment:Bool = true
    var typeWalletPayment:Bool = true
    
    var payView:UIView!
    var payViewCash:UIView!
    var payViewCard:UIView!
    var payViewWallet:UIView!
    var payViewPoint:UIView!
    var payViewVoucher:UIView!
    var tfCash:UITextField!
    var tfCard:UITextField!
    var tfWallet:UITextField!
    var tfBank:SkyFloatingLabelTextField!
    var tfBankType:SkyFloatingLabelTextField!
    var tfBankNumber:SkyFloatingLabelTextField!
    var tfOTP:UITextField!
    var listVoucherView:UIView!
    var boxVoucherView:UIView!
    var tfVoucher:UITextField!
    //--
    var bodyViewCash:UIView!
    var bodyViewCard:UIView!
    var bodyViewWallet:UIView!
    var bodyViewVoucher:UIView!
    var listVoucherUse: [VerifyVoucher] = []
    
    var bank:PaymentType?
    var bankType:CardTypeFromPOSResult?
    var lbTotalValue: UILabel!
    var listRadioVoucher:[DLRadioButton] = []
    var barcode:UIImageView!
    var viewBarcode:UIView!
    var lbBarcode:UILabel!
    var lbTotalVoucherValue:UILabel!
    var lbTotalSumValue:UILabel!
    var lbTotalCardCashValue:UILabel!
    var typeWalletVNPay:UIView!
    var tfWalletCode:UITextField!
    var lbNumVNPAY:UILabel!
    var priceQRPAY: Int = 0
    var payViewDeposit: UIView!
    var tfDeposit: UITextField!
    var isBookSim:Bool = false
    var is_DH_DuAn:String = ""
    
    //moca
    var isMoca = false
    var isVNPay = false
    var isZaloPay:Bool = false
    var btGetQRCode: UIButton!
    var typeWalletMoca: UIView!
//    var walletIconView: UIView!
    var viewBarcodeMoca: UIView!
    var barcodeMoca: UIImageView!
    var lbBarcodeMoca: UILabel!
    var qrCodeVNPayItem: QRCodeVNPay?
    var partnerTxIDMoca = ""
    var typeBank = ""
    //smartpay
    var isSmartPay = false
    var isAirPay = false
    var isFoxPay = false
    var typeWalletSmartPay: UIView!
    var typeWalletAirPay: UIView!
    var typeWalletFoxPay: UIView!
    var typeWalletZaloPay:UIView!
    var viewBarcodeSmartPay: UIView!
    var viewBarcodeAirPay: UIView!
    var viewBarcodeFoxPay: UIView!
    var viewBarcodeZaloPay: UIView!
    var barcodeSmartPay: UIImageView!
    var barcodeAirPay: UIImageView!
    var barcodeFoxPay: UIImageView!
    var barcodeZaloPay: UIImageView!
    var lbBarcodeSmartPay: UILabel!
    var lbBarcodeAirPay: UILabel!
    var lbBarcodeFoxPay: UILabel!
    var lbBarcodeZaloPay: UILabel!
    var partnerTxIDSmartPay = ""
    var partnerTxIDAirPay = ""
    var partnerTxIDFoxPay = ""
    var priceQRSMARTPAY: Int = 0
    var priceQRAirPAY: Int = 0
    var priceQRFoxPAY: Int = 0
    var priceQRZaloPAY: Int = 0
    var lbcodeKMVNPAY:UILabel!
    var shouldDisableTotalValue = false
    private var lbTotalOnlineValue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        self.title = "Thanh toán"
//        self.totalPaymentBK = self.totalPayment
        //tra gop tru khoan vay
        self.totalPayment =  Int(self.totalPayment) - Int(Cache.khoanvay)
        listRadioVoucher = []
        checkTransactionMocaByItemCode()
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(PayViewControllerV2.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - Common.Size(s: 235) - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let footer = UIView()
        footer.frame = CGRect(x: 0, y:self.view.frame.size.height - Common.Size(s: 235) - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) , width: self.view.frame.size.width, height: Common.Size(s: 235))
        footer.backgroundColor = UIColor.white
        footer.layer.shadowColor = UIColor.gray.cgColor
        footer.layer.shadowOffset =  CGSize(width: 0, height: -1)
        footer.layer.shadowOpacity = 0.5
        self.view.addSubview(footer)
        
        let btNext = UIButton(frame: CGRect(x: Common.Size(s: 20), y: footer.frame.size.height - Common.Size(s: 60), width: footer.frame.size.width - Common.Size(s: 40), height: Common.Size(s: 35)))
        btNext.layer.cornerRadius = 5
        
        btNext.titleLabel?.font = UIFont.systemFont(ofSize: Common.Size(s: 16))
        btNext.backgroundColor = UIColor.init(netHex:0x00955E)
        footer.addSubview(btNext)
        btNext.addTarget(self, action:#selector(self.payAction), for: .touchUpInside)
        btNext.setTitle("HOÀN TẤT",for: .normal)
        
        let lbTotalCardCash = UILabel(frame: CGRect(x: btNext.frame.origin.x, y: btNext.frame.origin.y - Common.Size(s: 10) - Common.Size(s: 16), width: btNext.frame.size.width/2, height: Common.Size(s:16)))
        lbTotalCardCash.textAlignment = .left
        lbTotalCardCash.textColor = UIColor.black
        lbTotalCardCash.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTotalCardCash.text = "Tiền mặt/Thẻ"
        footer.addSubview(lbTotalCardCash)
        
        lbTotalCardCashValue = UILabel(frame: CGRect(x: lbTotalCardCash.frame.origin.x + lbTotalCardCash.frame.size.width, y: lbTotalCardCash.frame.origin.y, width: lbTotalCardCash.frame.size.width, height: lbTotalCardCash.frame.size.height))
        lbTotalCardCashValue.textAlignment = .right
        lbTotalCardCashValue.textColor = UIColor(netHex:0xD0021B)
        lbTotalCardCashValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        footer.addSubview(lbTotalCardCashValue)
        lbTotalCardCashValue.text = "0đ"
        
        
        let lbTotal = UILabel(frame: CGRect(x: btNext.frame.origin.x, y: lbTotalCardCash.frame.origin.y - Common.Size(s: 10) - Common.Size(s: 16), width: btNext.frame.size.width/2, height: Common.Size(s:16)))
        lbTotal.textAlignment = .left
        lbTotal.textColor = UIColor.black
        lbTotal.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTotal.text = "Voucher"
        footer.addSubview(lbTotal)
        
        lbTotalValue = UILabel(frame: CGRect(x: lbTotal.frame.origin.x + lbTotal.frame.size.width, y: lbTotal.frame.origin.y, width: lbTotal.frame.size.width, height: lbTotal.frame.size.height))
        lbTotalValue.textAlignment = .right
        lbTotalValue.textColor = UIColor.black
        lbTotalValue.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        footer.addSubview(lbTotalValue)
         lbTotalValue.text = "0đ"
        
        let lbTotalVoucher = UILabel(frame: CGRect(x: lbTotal.frame.origin.x, y: lbTotal.frame.origin.y - Common.Size(s: 10) - Common.Size(s: 16), width: btNext.frame.size.width/2, height: Common.Size(s:16)))
        lbTotalVoucher.textAlignment = .left
        lbTotalVoucher.textColor = UIColor.black
        lbTotalVoucher.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTotalVoucher.text = "Ví điện tử"
        footer.addSubview(lbTotalVoucher)
        
        lbTotalVoucherValue = UILabel(frame: CGRect(x: lbTotalVoucher.frame.origin.x + lbTotalVoucher.frame.size.width, y: lbTotalVoucher.frame.origin.y, width: lbTotalVoucher.frame.size.width, height: lbTotalVoucher.frame.size.height))
        lbTotalVoucherValue.textAlignment = .right
        lbTotalVoucherValue.textColor = UIColor.black
        lbTotalVoucherValue.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        footer.addSubview(lbTotalVoucherValue)
        lbTotalVoucherValue.text = "0đ"
        
        let lbKhoanVay = UILabel(frame: CGRect(x: lbTotalVoucher.frame.origin.x, y: lbTotalVoucher.frame.origin.y - Common.Size(s: 10) - Common.Size(s: 16), width: btNext.frame.size.width/2, height: Common.Size(s:16)))
        lbKhoanVay.textAlignment = .left
        lbKhoanVay.textColor = UIColor.black
        lbKhoanVay.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbKhoanVay.text = "Khoản vay"
        footer.addSubview(lbKhoanVay)
        
        let lbKhoanVayValue = UILabel(frame: CGRect(x: lbKhoanVay.frame.origin.x + lbKhoanVay.frame.size.width, y: lbKhoanVay.frame.origin.y, width: lbTotalVoucherValue.frame.size.width, height: lbTotalVoucher.frame.size.height))
        lbKhoanVayValue.textAlignment = .right
        lbKhoanVayValue.textColor = UIColor.black
        lbKhoanVayValue.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        footer.addSubview(lbKhoanVayValue)
        lbKhoanVayValue.text = "\(Common.convertCurrency(value: Cache.khoanvay))"
        
        let lbTotalOnline = UILabel(frame: CGRect(x: lbTotalVoucher.frame.origin.x, y: lbKhoanVay.frame.origin.y - Common.Size(s: 10) - Common.Size(s: 16), width: btNext.frame.size.width/2, height: Common.Size(s:16)))
        lbTotalOnline.textAlignment = .left
        lbTotalOnline.textColor = UIColor.black
        lbTotalOnline.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTotalOnline.text = "TT Online"
        footer.addSubview(lbTotalOnline)
        
        lbTotalOnlineValue = UILabel(frame: CGRect(x: lbTotalOnline.frame.origin.x + lbTotalOnline.frame.size.width, y: lbTotalOnline.frame.origin.y, width: lbTotalOnline.frame.size.width, height: lbTotalOnline.frame.size.height))
        lbTotalOnlineValue.textAlignment = .right
        lbTotalOnlineValue.textColor = .black
        lbTotalOnlineValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        footer.addSubview(lbTotalOnlineValue)
        
        let lbTotalSum = UILabel(frame: CGRect(x: lbTotalVoucher.frame.origin.x, y: lbTotalOnline.frame.origin.y - Common.Size(s: 10) - Common.Size(s: 16), width: btNext.frame.size.width/2, height: Common.Size(s:16)))
        lbTotalSum.textAlignment = .left
        lbTotalSum.textColor = UIColor.black
        lbTotalSum.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTotalSum.text = "Số tiền thanh toán"
        footer.addSubview(lbTotalSum)
        
        lbTotalSumValue = UILabel(frame: CGRect(x: lbTotalSum.frame.origin.x + lbTotalSum.frame.size.width, y: lbTotalSum.frame.origin.y, width: lbTotalSum.frame.size.width, height: lbTotalSum.frame.size.height))
        lbTotalSumValue.textAlignment = .right
        lbTotalSumValue.textColor = .black
        lbTotalSumValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        footer.addSubview(lbTotalSumValue)
    
//        for item in listVoucher{
//            item.isSelect = true
//            self.listVoucherUse.append(VerifyVoucher(Price: item.GiaTriVC, VC_code: item.VC_code, MaSP: "", MenhGia: item.GiaTriVC, TenVC: item.VC_Name))
//        }
        //        initUI()
        //        updatePrice()
        
        
        
        if self.type == "3" {
            let rDR1 = parseXMLProduct().toBase64()
            MPOSAPIManager.getPriceDatCoc(rdr1: rDR1, handler: { [weak self] price, error in
                guard let self = self else { return }
                self.totalPayment = error.isEmpty ? price : 500000
                self.verifyVoucherGen(isLoadding: true)
            })
        } else {
            verifyVoucherGen(isLoadding: true)
        }
    }
    
    func updateWalletBodyUI() {
        self.lbcodeKMVNPAY.text = ""
        
        if self.isZaloPay {
            self.viewBarcode.isHidden = true
            self.barcode.isHidden = true
            self.lbBarcode.isHidden = true
            
            self.viewBarcodeMoca.isHidden = true
            self.barcodeMoca.isHidden = true
            self.lbBarcodeMoca.isHidden = true
            
            self.viewBarcodeSmartPay.isHidden = true
            self.barcodeSmartPay.isHidden = true
            self.lbBarcodeSmartPay.isHidden = true
            
            self.viewBarcodeAirPay.isHidden = true
            self.barcodeAirPay.isHidden = true
            self.lbBarcodeAirPay.isHidden = true
            
            self.viewBarcodeFoxPay.isHidden = true
            self.barcodeFoxPay.isHidden = true
            self.lbBarcodeFoxPay.isHidden = true
            
            self.viewBarcodeZaloPay.isHidden = false
            self.barcodeZaloPay.isHidden = false
            self.lbBarcodeZaloPay.isHidden = false
            
            self.typeWalletMoca.layer.borderWidth = 0
            self.typeWalletMoca.layer.borderColor = UIColor.white.cgColor
            
            self.typeWalletVNPay.layer.borderWidth = 0
            self.typeWalletVNPay.layer.borderColor = UIColor.white.cgColor
            
            self.typeWalletZaloPay.layer.borderWidth = 2
            self.typeWalletZaloPay.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
            
            self.typeWalletSmartPay.layer.borderWidth = 0
            self.typeWalletSmartPay.layer.borderColor = UIColor.white.cgColor
            
            self.typeWalletFoxPay.layer.borderWidth = 0
            self.typeWalletFoxPay.layer.borderColor = UIColor.white.cgColor
            
            self.typeWalletAirPay.layer.borderWidth = 0
            self.typeWalletAirPay.layer.borderColor = UIColor.white.cgColor
            
            tfWallet.isUserInteractionEnabled = true
            tfWallet.isEnabled = true
            tfWallet.placeholder = "Nhập số tiền"
            lbNumVNPAY.text = "SỐ CT ZaloPay:"
            self.lbcodeKMVNPAY.text = "Code KM ZaloPay:"
            tfWalletCode.text = ""
            tfWalletCode.placeholder = "Số chứng từ ZaloPay (nếu có)"
            self.viewBarcodeZaloPay.isUserInteractionEnabled = true
            lbNumVNPAY.textColor = UIColor.black
            
            self.lbNumVNPAY.frame.origin.y = viewBarcodeAirPay.frame.origin.y + viewBarcodeSmartPay.frame.size.height + Common.Size(s: 10)
            
            self.bodyViewWallet.frame.size.height = lbNumVNPAY.frame.origin.y + lbNumVNPAY.frame.size.height + Common.Size(s: 10)
            self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
            
            self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
            self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
            self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
            self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
            return
        }
        
        if isAirPay {
            self.viewBarcodeZaloPay.isHidden = true
            self.barcodeZaloPay.isHidden = true
            self.lbBarcodeZaloPay.isHidden = true
            
            self.viewBarcode.isHidden = true
            self.barcode.isHidden = true
            self.lbBarcode.isHidden = true
            
            self.viewBarcodeMoca.isHidden = true
            self.barcodeMoca.isHidden = true
            self.lbBarcodeMoca.isHidden = true
            
            self.viewBarcodeSmartPay.isHidden = true
            self.barcodeSmartPay.isHidden = true
            self.lbBarcodeSmartPay.isHidden = true
            
            self.viewBarcodeAirPay.isHidden = false
            self.barcodeAirPay.isHidden = false
            self.lbBarcodeAirPay.isHidden = false
            
            self.viewBarcodeFoxPay.isHidden = true
            self.barcodeFoxPay.isHidden = true
            self.lbBarcodeFoxPay.isHidden = true
            
            typeWalletMoca.layer.borderWidth = 0
            typeWalletMoca.layer.borderColor = UIColor.white.cgColor
            
            typeWalletVNPay.layer.borderWidth = 0
            typeWalletVNPay.layer.borderColor = UIColor.white.cgColor
            
            typeWalletAirPay.layer.borderWidth = 2
            typeWalletAirPay.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
            
            typeWalletSmartPay.layer.borderWidth = 0
            typeWalletSmartPay.layer.borderColor = UIColor.white.cgColor
            
            typeWalletFoxPay.layer.borderWidth = 0
            typeWalletFoxPay.layer.borderColor = UIColor.white.cgColor
            
            self.typeWalletZaloPay.layer.borderWidth = 0
            self.typeWalletZaloPay.layer.borderColor = UIColor.white.cgColor

            tfWallet.isUserInteractionEnabled = true
            tfWallet.isEnabled = true
            tfWallet.placeholder = "Nhập số tiền"
            lbNumVNPAY.text = "SỐ CT ShopeePay:"
            self.lbcodeKMVNPAY.text = "Code KM ShopeePay:"
            tfWalletCode.text = ""
            tfWallet.text = "0"
            tfWalletCode.placeholder = "Số chứng từ ShopeePay (nếu có)"
            self.viewBarcodeAirPay.isUserInteractionEnabled = true
            lbNumVNPAY.textColor = UIColor.black
            
            self.lbNumVNPAY.frame.origin.y = viewBarcodeAirPay.frame.origin.y + viewBarcodeSmartPay.frame.size.height + Common.Size(s: 10)
            
            self.bodyViewWallet.frame.size.height = lbNumVNPAY.frame.origin.y + lbNumVNPAY.frame.size.height + Common.Size(s: 10)
            self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
            
            self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
            self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
            self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
            self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
            return
        }
        
        if isFoxPay {
            self.viewBarcodeZaloPay.isHidden = true
            self.barcodeZaloPay.isHidden = true
            self.lbBarcodeZaloPay.isHidden = true
            
            self.viewBarcode.isHidden = true
            self.barcode.isHidden = true
            self.lbBarcode.isHidden = true
            
            self.viewBarcodeMoca.isHidden = true
            self.barcodeMoca.isHidden = true
            self.lbBarcodeMoca.isHidden = true
            
            self.viewBarcodeSmartPay.isHidden = true
            self.barcodeSmartPay.isHidden = true
            self.lbBarcodeSmartPay.isHidden = true
            
            self.viewBarcodeAirPay.isHidden = true
            self.barcodeAirPay.isHidden = true
            self.lbBarcodeAirPay.isHidden = true
            
            self.viewBarcodeFoxPay.isHidden = false
            self.barcodeFoxPay.isHidden = false
            self.lbBarcodeFoxPay.isHidden = false
            
            typeWalletMoca.layer.borderWidth = 0
            typeWalletMoca.layer.borderColor = UIColor.white.cgColor
            
            self.typeWalletZaloPay.layer.borderWidth = 0
            self.typeWalletZaloPay.layer.borderColor = UIColor.white.cgColor
            
            typeWalletVNPay.layer.borderWidth = 0
            typeWalletVNPay.layer.borderColor = UIColor.white.cgColor
            
            typeWalletAirPay.layer.borderWidth = 0
            typeWalletAirPay.layer.borderColor = UIColor.white.cgColor
            
            typeWalletSmartPay.layer.borderWidth = 0
            typeWalletSmartPay.layer.borderColor = UIColor.white.cgColor
            
            typeWalletFoxPay.layer.borderWidth = 2
            typeWalletFoxPay.layer.borderColor = UIColor(netHex: 0x00955E).cgColor

            tfWallet.isUserInteractionEnabled = true
            tfWallet.isEnabled = true
            tfWallet.placeholder = "Nhập số tiền"
            lbNumVNPAY.text = "SỐ CT Foxpay:"
            self.lbcodeKMVNPAY.text = "Code KM Foxpay:"
            tfWalletCode.text = ""
            tfWallet.text = "0"
            tfWalletCode.placeholder = "Số chứng từ Foxpay (nếu có)"
            self.viewBarcodeFoxPay.isUserInteractionEnabled = true
            lbNumVNPAY.textColor = UIColor.black
            
            self.lbNumVNPAY.frame.origin.y = viewBarcodeFoxPay.frame.origin.y + viewBarcodeSmartPay.frame.size.height + Common.Size(s: 10)
            
            self.bodyViewWallet.frame.size.height = lbNumVNPAY.frame.origin.y + lbNumVNPAY.frame.size.height + Common.Size(s: 10)
            self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
            
            self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
            self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
            self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
            self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
            return
        }
        
        if isVNPay {
            
            self.viewBarcodeZaloPay.isHidden = true
            self.barcodeZaloPay.isHidden = true
            self.lbBarcodeZaloPay.isHidden = true
            
            self.viewBarcode.isHidden = false
            self.barcode.isHidden = false
            self.lbBarcode.isHidden = false
            
            self.viewBarcodeMoca.isHidden = true
            self.barcodeMoca.isHidden = true
            self.lbBarcodeMoca.isHidden = true
            
            self.viewBarcodeSmartPay.isHidden = true
            self.barcodeSmartPay.isHidden = true
            self.lbBarcodeSmartPay.isHidden = true
            
            self.viewBarcodeAirPay.isHidden = true
            self.barcodeAirPay.isHidden = true
            self.lbBarcodeAirPay.isHidden = true
            
            self.viewBarcodeFoxPay.isHidden = true
            self.barcodeFoxPay.isHidden = true
            self.lbBarcodeFoxPay.isHidden = true
            
//            tfWalletCode.isHidden = false
//            btGetQRCode.isHidden = false
            tfWallet.isEnabled = false
            lbNumVNPAY.text = "SỐ CT VNPAY:"
            self.lbcodeKMVNPAY.text = "Code KM VNPAY:"
            lbNumVNPAY.textColor = UIColor.black
            tfWalletCode.text = ""
            tfWalletCode.placeholder = "Số chứng từ VNPAY (nếu có)"
            
            typeWalletVNPay.layer.borderWidth = 2
            typeWalletVNPay.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
            
            typeWalletMoca.layer.borderWidth = 0
            typeWalletMoca.layer.borderColor = UIColor.white.cgColor
            
            typeWalletSmartPay.layer.borderWidth = 0
            typeWalletSmartPay.layer.borderColor = UIColor.white.cgColor
            
            typeWalletAirPay.layer.borderWidth = 0
            typeWalletAirPay.layer.borderColor = UIColor.white.cgColor
            
            typeWalletFoxPay.layer.borderWidth = 0
            typeWalletFoxPay.layer.borderColor = UIColor.white.cgColor
            
            self.typeWalletZaloPay.layer.borderWidth = 0
            self.typeWalletZaloPay.layer.borderColor = UIColor.white.cgColor
            
            self.viewBarcode.frame = CGRect(x: self.viewBarcode.frame.origin.x, y: self.tfWalletCode.frame.origin.y + self.tfWalletCode.frame.height + Common.Size(s: 15), width: self.viewBarcode.frame.width, height: self.viewBarcode.frame.height)
            
            self.lbNumVNPAY.frame.origin.y = viewBarcode.frame.origin.y + viewBarcode.frame.size.height + Common.Size(s: 10)
            
            self.bodyViewWallet.frame.size.height = lbNumVNPAY.frame.origin.y + lbNumVNPAY.frame.size.height + Common.Size(s: 10)
            self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
            
            self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
            self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
            self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
            self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
            self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
            
        } else {
            typeWalletVNPay.layer.borderWidth = 0
            typeWalletVNPay.layer.borderColor = UIColor.white.cgColor
            
            if isMoca {
                
                self.viewBarcodeZaloPay.isHidden = true
                self.barcodeZaloPay.isHidden = true
                self.lbBarcodeZaloPay.isHidden = true
                
                self.viewBarcode.isHidden = true
                self.barcode.isHidden = true
                self.lbBarcode.isHidden = true
                
                self.viewBarcodeMoca.isHidden = false
                self.barcodeMoca.isHidden = false
                self.lbBarcodeMoca.isHidden = false
                
                self.viewBarcodeSmartPay.isHidden = true
                self.barcodeSmartPay.isHidden = true
                self.lbBarcodeSmartPay.isHidden = true
                
                self.viewBarcodeAirPay.isHidden = true
                self.barcodeAirPay.isHidden = true
                self.lbBarcodeAirPay.isHidden = true
                
                self.viewBarcodeFoxPay.isHidden = true
                self.barcodeFoxPay.isHidden = true
                self.lbBarcodeFoxPay.isHidden = true
                
                
                typeWalletMoca.layer.borderWidth = 2
                typeWalletMoca.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
                
                typeWalletVNPay.layer.borderWidth = 0
                typeWalletVNPay.layer.borderColor = UIColor.white.cgColor
                
                typeWalletSmartPay.layer.borderWidth = 0
                typeWalletSmartPay.layer.borderColor = UIColor.white.cgColor
                
                typeWalletAirPay.layer.borderWidth = 0
                typeWalletAirPay.layer.borderColor = UIColor.white.cgColor
                
                typeWalletFoxPay.layer.borderWidth = 0
                typeWalletFoxPay.layer.borderColor = UIColor.white.cgColor
                
                self.typeWalletZaloPay.layer.borderWidth = 0
                self.typeWalletZaloPay.layer.borderColor = UIColor.white.cgColor
                
//                tfWalletCode.isHidden = true
//                btGetQRCode.isHidden = true

                tfWallet.isEnabled = false
                if isDisableTxtMoca {
                    tfWallet.isUserInteractionEnabled = false
                }
                tfWallet.placeholder = "Nhập số tiền"
                lbNumVNPAY.text = "SỐ CT MOCA:"
                tfWalletCode.text = ""
                tfWallet.text = "0"
                tfWalletCode.placeholder = "Số chứng từ MOCA (nếu có)"
                self.viewBarcodeMoca.isUserInteractionEnabled = true
                lbNumVNPAY.textColor = UIColor.black
                
                self.lbNumVNPAY.frame.origin.y = viewBarcodeMoca.frame.origin.y + viewBarcodeMoca.frame.size.height + Common.Size(s: 10)
                
                self.bodyViewWallet.frame.size.height = lbNumVNPAY.frame.origin.y + lbNumVNPAY.frame.size.height + Common.Size(s: 10)
                self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
                
                self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
                self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
                self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
                self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
                
            } else {
                if isSmartPay{
                    
                    self.viewBarcodeZaloPay.isHidden = true
                    self.barcodeZaloPay.isHidden = true
                    self.lbBarcodeZaloPay.isHidden = true
                    
                    self.viewBarcode.isHidden = true
                    self.barcode.isHidden = true
                    self.lbBarcode.isHidden = true
                    
                    self.viewBarcodeMoca.isHidden = true
                    self.barcodeMoca.isHidden = true
                    self.lbBarcodeMoca.isHidden = true
                    
                    self.viewBarcodeSmartPay.isHidden = false
                    self.barcodeSmartPay.isHidden = false
                    self.lbBarcodeSmartPay.isHidden = false
                    
                    self.viewBarcodeAirPay.isHidden = true
                    self.barcodeAirPay.isHidden = true
                    self.lbBarcodeAirPay.isHidden = true
                    
                    self.viewBarcodeFoxPay.isHidden = true
                    self.barcodeFoxPay.isHidden = true
                    self.lbBarcodeFoxPay.isHidden = true
                    
                    typeWalletMoca.layer.borderWidth = 0
                    typeWalletMoca.layer.borderColor = UIColor.white.cgColor
                    
                    typeWalletVNPay.layer.borderWidth = 0
                    typeWalletVNPay.layer.borderColor = UIColor.white.cgColor
                    
                    typeWalletSmartPay.layer.borderWidth = 2
                    typeWalletSmartPay.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
                    
                    typeWalletAirPay.layer.borderWidth = 0
                    typeWalletAirPay.layer.borderColor = UIColor.white.cgColor
                    
                    typeWalletFoxPay.layer.borderWidth = 0
                    typeWalletFoxPay.layer.borderColor = UIColor.white.cgColor
                    
                    self.typeWalletZaloPay.layer.borderWidth = 0
                    self.typeWalletZaloPay.layer.borderColor = UIColor.white.cgColor
                    
                    //                tfWalletCode.isHidden = true
                    //                btGetQRCode.isHidden = true
                    tfWallet.isUserInteractionEnabled = true
                    tfWallet.isEnabled = true
                    tfWallet.placeholder = "Nhập số tiền"
                    lbNumVNPAY.text = "SỐ CT SMARTPAY:"
                    self.lbcodeKMVNPAY.text = ""
                    tfWalletCode.text = ""
                    tfWallet.text = "0"
                    tfWalletCode.placeholder = "Số chứng từ SMARTPAY (nếu có)"
                    self.viewBarcodeSmartPay.isUserInteractionEnabled = true
                    lbNumVNPAY.textColor = UIColor.black
                    
                    self.lbNumVNPAY.frame.origin.y = viewBarcodeSmartPay.frame.origin.y + viewBarcodeSmartPay.frame.size.height + Common.Size(s: 10)
                    
                    self.bodyViewWallet.frame.size.height = lbNumVNPAY.frame.origin.y + lbNumVNPAY.frame.size.height + Common.Size(s: 10)
                    self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
                    
                    self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
                    self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
                    self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
                    self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
                    self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
                    
                }else{
                    typeWalletSmartPay.layer.borderWidth = 0
                    typeWalletSmartPay.layer.borderColor = UIColor.white.cgColor
                    
                    typeWalletMoca.layer.borderWidth = 0
                    typeWalletMoca.layer.borderColor = UIColor.white.cgColor
                    
                    self.bodyViewWallet.frame.size.height = typeWalletVNPay.frame.origin.y + typeWalletVNPay.frame.size.height + Common.Size(s: 10)
                    self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
                    
                    self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
                    self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
                    self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
                    self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
                    self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
                }
                
           
            }
        }
    }
    private func checkTransactionMocaByItemCode(){
        MPOSAPIManager.checkTransactionMocaByItemCode(SanPhamXML:sanPhamXML, handler:  { [weak self ] (result,messagese,error) in
            //                Note : Result = 1 => app default số tiền thanh toán bằng tổng tiền đơn hàng (không cho nhập lại)
            //                Result = 0 => cho nhập như cũ
            //                Result = -1 => lỗi
            guard let self = self else { return }
            if result == -1 {
                self.isDisableTxtMoca = false
                self.showAlertOneButton(title: "Lỗi", with: messagese, titleButton: "OK",handleOk: {
                    self.navigationController?.popViewController(animated: true)
                })
            }  else if result == 1 {
                self.isDisableTxtMoca = true
            }else {
                self.isDisableTxtMoca = false
            }

        })
    }
    var indexVoucherGen: Int = 0
    func verifyVoucherGen(isLoadding: Bool){
        let nc = NotificationCenter.default
        if(indexVoucherGen < listVoucher.count){
            
            if(isLoadding){
                let newViewController = LoadingViewController()
                newViewController.content = "Đang kiểm tra voucher..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
            }
            
            let item = listVoucher[indexVoucherGen]
            let basexml_list_detail_SO = parseXMLProductVerifyVoucher().toBase64()
            let basexml_list_VC_added = parseXMLVoucherUse().toBase64()
            MPOSAPIManager.mpos_sp_verify_VC_mpos_innovation(sdt: "\(self.phone)", doctypeSO: "\(self.type)", tmonbi: "\(self.totalPayment)", basexml_list_VC_added: "\(basexml_list_VC_added)", basexml_list_detail_SO: "\(basexml_list_detail_SO)", vC_code: "\(item.VC_code)", handler: { (results, err) in
                print("Voucher \(results)")

                    if(err.count <= 0){
                        if(results.count > 0){
                            self.listVoucherUse.append(results[0])
                            self.listVoucher[self.indexVoucherGen].isVerify = true
                            self.indexVoucherGen = self.indexVoucherGen + 1
                            self.verifyVoucherGen(isLoadding: false)
                        }else{
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                self.indexVoucherGen = self.indexVoucherGen + 1
                                self.verifyVoucherGen(isLoadding: true)
                            }
                        
//                            let when = DispatchTime.now() + 0.5
//                            DispatchQueue.main.asyncAfter(deadline: when) {
//                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
//                                let popup = PopupDialog(title: "Thông báo", message: "Voucher không thuộc phạm vi sử dung hoặc seri không hợp lệ!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
//                                    print("Completed")
//                                }
//                                let buttonOne = CancelButton(title: "OK") {
//                                    self.indexVoucherGen = self.indexVoucherGen + 1
//                                     self.verifyVoucherGen(isLoadding: true)
//                                }
//                                popup.addButtons([buttonOne])
//                                self.present(popup, animated: true, completion: nil)
//                            }
                        }
                    }else{
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                self.indexVoucherGen = self.indexVoucherGen + 1
                                self.verifyVoucherGen(isLoadding: true)
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }
                
            })
        }else{
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                self.initUI()
                self.updatePrice()
            }
        }
    }
    
    var payCashTemp:Bool = false
    var payCardTemp:Bool = false
    var payWalletTemp:Bool = false
    var totalTemp:Int = 0
    
    
    func updatePrice(){
        var voucherSum:Int = 0
        if(listVoucherUse.count > 0){
            for item in listVoucherUse {
                voucherSum = voucherSum + Int(item.Price)
            }
        }
        totalTemp  = totalPayment - voucherSum - Int(Cache.payOnlineEcom)
        
        if isVNPay {
            if(self.priceQRPAY > 0){
                let moneyInt = Int(priceQRPAY)
                lbTotalVoucherValue.text = Common.convertCurrency(value: moneyInt )
                let finalMoney = self.totalTemp - (moneyInt )
                lbTotalCardCashValue.text = Common.convertCurrencyFloat(value: Float(finalMoney))
                
                lbTotalVoucherValue.textColor = UIColor(netHex:0xD0021B)
                lbTotalVoucherValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
                
                tfVoucher.isEnabled = false
                tfDeposit.isEnabled = false
            }else{
                //tfWallet.text = Common.convertCurrencyV2(value: totalTemp)
                
                var moneyString:String = tfWallet.text!
                moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
                if(moneyString.isEmpty){
                    moneyString = "0"
                }
                let moneyInt = Int(moneyString)
                lbTotalVoucherValue.text = Common.convertCurrency(value: moneyInt ?? 0)
                let finalMoney = self.totalTemp - (moneyInt ?? 0)
                lbTotalCardCashValue.text = Common.convertCurrencyFloat(value: Float(finalMoney))
                
                lbTotalVoucherValue.textColor = UIColor(netHex:0xD0021B)
                lbTotalVoucherValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
                
                tfVoucher.isEnabled = false
                tfDeposit.isEnabled = false
            }
        } else {
            
            if isMoca {
                
                var moneyString:String = tfWallet.text!
                moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
                if(moneyString.isEmpty){
                    moneyString = "0"
                }
                let moneyInt = Int(moneyString)
                lbTotalVoucherValue.text = Common.convertCurrency(value: moneyInt ?? 0)
                let finalMoney = self.totalTemp - (moneyInt ?? 0)
                lbTotalCardCashValue.text = Common.convertCurrencyFloat(value: Float(finalMoney))
                
                lbTotalVoucherValue.textColor = UIColor(netHex:0xD0021B)
                lbTotalVoucherValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
                
                tfVoucher.isEnabled = false
                tfDeposit.isEnabled = false
//                viewBarcodeMoca.isUserInteractionEnabled = false
            }else{
                if isSmartPay{
                   
                    if(self.priceQRSMARTPAY > 0){
                        
                     
                        let moneyInt = Int(priceQRSMARTPAY)
                        lbTotalVoucherValue.text = Common.convertCurrency(value: moneyInt )
                        let finalMoney = self.totalTemp - (moneyInt )
                        lbTotalCardCashValue.text = Common.convertCurrencyFloat(value: Float(finalMoney))
                        
                        lbTotalVoucherValue.textColor = UIColor(netHex:0xD0021B)
                        lbTotalVoucherValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
                        
                        tfVoucher.isEnabled = false
                        tfDeposit.isEnabled = false
                    }else{
                        //tfWallet.text = Common.convertCurrencyV2(value: totalTemp)
                        
                        var moneyString:String = tfWallet.text!
                        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
                        if(moneyString.isEmpty){
                            moneyString = "0"
                        }
                        let moneyInt = Int(moneyString)
                        lbTotalVoucherValue.text = Common.convertCurrency(value: moneyInt ?? 0)
                        let finalMoney = self.totalTemp - (moneyInt ?? 0)
                        lbTotalCardCashValue.text = Common.convertCurrencyFloat(value: Float(finalMoney))
                        
                        lbTotalVoucherValue.textColor = UIColor(netHex:0xD0021B)
                        lbTotalVoucherValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
                        
                        tfVoucher.isEnabled = false
                        tfDeposit.isEnabled = false
                    }
                  
                } else if isAirPay {
                    if(self.priceQRAirPAY > 0){
                        
                     
                        let moneyInt = Int(priceQRAirPAY)
                        lbTotalVoucherValue.text = Common.convertCurrency(value: moneyInt )
                        let finalMoney = self.totalTemp - (moneyInt )
                        lbTotalCardCashValue.text = Common.convertCurrencyFloat(value: Float(finalMoney))
                        
                        lbTotalVoucherValue.textColor = UIColor(netHex:0xD0021B)
                        lbTotalVoucherValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
                        
                        tfVoucher.isEnabled = false
                        tfDeposit.isEnabled = false
                    }else{
                        //tfWallet.text = Common.convertCurrencyV2(value: totalTemp)
                        
                        var moneyString:String = tfWallet.text!
                        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
                        if(moneyString.isEmpty){
                            moneyString = "0"
                        }
                        let moneyInt = Int(moneyString)
                        lbTotalVoucherValue.text = Common.convertCurrency(value: moneyInt ?? 0)
                        let finalMoney = self.totalTemp - (moneyInt ?? 0)
                        lbTotalCardCashValue.text = Common.convertCurrencyFloat(value: Float(finalMoney))
                        
                        lbTotalVoucherValue.textColor = UIColor(netHex:0xD0021B)
                        lbTotalVoucherValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
                        
                        tfVoucher.isEnabled = false
                        tfDeposit.isEnabled = false
                    }
                } else if isFoxPay {
                    if priceQRFoxPAY > 0 {
                        
                        let moneyInt = Int(priceQRFoxPAY)
                        lbTotalVoucherValue.text = Common.convertCurrency(value: moneyInt)
                        let finalMoney = totalTemp - moneyInt
                        lbTotalCardCashValue.text = Common.convertCurrencyFloat(value: Float(finalMoney))
                        
                        lbTotalVoucherValue.textColor = UIColor(netHex:0xD0021B)
                        lbTotalVoucherValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
                        
                        tfVoucher.isEnabled = false
                        tfDeposit.isEnabled = false
                    } else {
                        
                        var moneyString:String = tfWallet.text!
                        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
                        if moneyString.isEmpty {
                            moneyString = "0"
                        }
                        let moneyInt = Int(moneyString)
                        lbTotalVoucherValue.text = Common.convertCurrency(value: moneyInt ?? 0)
                        let finalMoney = self.totalTemp - (moneyInt ?? 0)
                        lbTotalCardCashValue.text = Common.convertCurrencyFloat(value: Float(finalMoney))
                        
                        lbTotalVoucherValue.textColor = UIColor(netHex:0xD0021B)
                        lbTotalVoucherValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
                        
                        tfVoucher.isEnabled = false
                        tfDeposit.isEnabled = false
                    }
                }else if self.isZaloPay {
                    var moneyString:String = tfWallet.text!
                    moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
                    moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
                    if moneyString.isEmpty {
                        moneyString = "0"
                    }
                    let moneyInt = Int(moneyString)
                    lbTotalVoucherValue.text = Common.convertCurrency(value: moneyInt ?? 0)
                    let finalMoney = self.totalTemp - (moneyInt ?? 0)
                    lbTotalCardCashValue.text = Common.convertCurrencyFloat(value: Float(finalMoney))
                    
                    lbTotalVoucherValue.textColor = UIColor(netHex:0xD0021B)
                    lbTotalVoucherValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
                    
                    tfVoucher.isEnabled = false
                    tfDeposit.isEnabled = false
                } else {
                    
                    tfWallet.text = Common.convertCurrencyFloatV2(value: 0)
                    lbTotalVoucherValue.text = Common.convertCurrencyFloat(value: 0)
                    lbTotalCardCashValue.text = Common.convertCurrency(value: totalTemp)
                    
                    lbTotalCardCashValue.textColor = UIColor(netHex:0xD0021B)
                    lbTotalCardCashValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
                    
                    lbTotalVoucherValue.textColor = UIColor.black
                    lbTotalVoucherValue.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
                    
                    tfWalletCode.text = ""
                    txnId = ""
                    self.priceQRPAY = 0
                    self.priceQRSMARTPAY = 0
                    self.priceQRAirPAY = 0
                    self.priceQRFoxPAY = 0
                    tfVoucher.isEnabled = true
                    tfDeposit.isEnabled = true
                    viewBarcode.isUserInteractionEnabled = true
                }
            }
        }
        
        
        updateBarcode(image: nil)
        lbTotalSumValue.text = Common.convertCurrency(value: totalPayment)
        lbTotalOnlineValue.text = Common.convertCurrencyFloatV2(value: Cache.payOnlineEcom)
        lbTotalValue.text = Common.convertCurrency(value: voucherSum)
    }
    func convertFormat(value:Float)->String{
        let characters = Array("\(value.cleanValue)")
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s),\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            return str
        }else{
            return ""
        }
    }
    
    func initUI(){
        
        payView = UIView()
        payView.frame = CGRect(x: 0, y:0 , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        payView.backgroundColor = UIColor.clear
        scrollView.addSubview(payView)
        
        //--
        payViewWallet = UIView()
        payViewWallet.clipsToBounds = true
        payViewWallet.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: 0)
        payViewWallet.backgroundColor = UIColor.clear
        payView.addSubview(payViewWallet)
        
        let labelWallet = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: payViewWallet.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelWallet.text = "VÍ ĐIỆN TỬ"
        labelWallet.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        payViewWallet.addSubview(labelWallet)
        
        bodyViewWallet = UIView()
        bodyViewWallet.frame = CGRect(x: 0, y:labelWallet.frame.origin.y + labelWallet.frame.size.height, width: scrollView.frame.size.width, height: Common.Size(s: 50))
        bodyViewWallet.backgroundColor = UIColor.white
        payViewWallet.addSubview(bodyViewWallet)
        
        let screenSize = UIScreen.main.bounds
        
        typeWalletVNPay = UIView()
        typeWalletVNPay.frame = CGRect(x: Common.Size(s: 5), y: Common.Size(s: 10), width: (screenSize.width - Common.Size(s: 30)) / 6, height: Common.Size(s: 35))
        typeWalletVNPay.backgroundColor = UIColor.white
        typeWalletVNPay.layer.masksToBounds = false
        typeWalletVNPay.layer.cornerRadius = 5
        //        typeWalletVNPay.layer.borderWidth = 2
        //        typeWalletVNPay.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
        typeWalletVNPay.clipsToBounds = true
        bodyViewWallet.addSubview(typeWalletVNPay)
        
        let tapWalletVNPay = UITapGestureRecognizer(target: self, action: #selector(tapActionWalletVNPay))
        typeWalletVNPay.isUserInteractionEnabled = true
        typeWalletVNPay.addGestureRecognizer(tapWalletVNPay)
        
        let vnpay = UIImageView(frame: CGRect(x: 0,y: 0 ,width:typeWalletVNPay.frame.size.width,height: typeWalletVNPay.frame.size.height))
        vnpay.image = UIImage(named: "vnpay")
        vnpay.contentMode = .scaleAspectFit
        typeWalletVNPay.addSubview(vnpay)
        
        //icon Moca
        typeWalletMoca = UIView()
        typeWalletMoca.frame = CGRect(x: typeWalletVNPay.frame.origin.x + typeWalletVNPay.frame.width + Common.Size(s: 5), y: Common.Size(s: 10), width: typeWalletVNPay.frame.size.width, height: Common.Size(s: 35))
        typeWalletMoca.backgroundColor = UIColor.white
        typeWalletMoca.layer.masksToBounds = false
        typeWalletMoca.layer.cornerRadius = 5
        typeWalletMoca.clipsToBounds = true
        bodyViewWallet.addSubview(typeWalletMoca)
        
        let tapWalletMoca = UITapGestureRecognizer(target: self, action: #selector(tapActionWalletMoca))
        typeWalletMoca.isUserInteractionEnabled = true
        typeWalletMoca.addGestureRecognizer(tapWalletMoca)
        
        let moca = UIImageView(frame: CGRect(x: 0,y: 0 ,width:typeWalletMoca.frame.size.width,height: typeWalletMoca.frame.size.height))
        moca.image = UIImage(named: "Moca_1")
        moca.contentMode = .scaleAspectFit
        typeWalletMoca.addSubview(moca)
        //iconSmartPay
        typeWalletSmartPay = UIView()
        typeWalletSmartPay.frame = CGRect(x: typeWalletMoca.frame.origin.x + typeWalletMoca.frame.width + Common.Size(s: 5), y: Common.Size(s: 10), width: typeWalletVNPay.frame.size.width, height: Common.Size(s: 35))
        typeWalletSmartPay.backgroundColor = UIColor.white
        typeWalletSmartPay.layer.masksToBounds = false
        typeWalletSmartPay.layer.cornerRadius = 5
        typeWalletSmartPay.clipsToBounds = true
        bodyViewWallet.addSubview(typeWalletSmartPay)
        
        let tapWalletSmartPay = UITapGestureRecognizer(target: self, action: #selector(tapActionWalletSmartPay))
        typeWalletSmartPay.isUserInteractionEnabled = true
        typeWalletSmartPay.addGestureRecognizer(tapWalletSmartPay)
        
        let smartPay = UIImageView(frame: CGRect(x: 0,y: 0 ,width:typeWalletSmartPay.frame.size.width,height: typeWalletSmartPay.frame.size.height))
        smartPay.image = UIImage(named: "SmartPayIcon")
        smartPay.contentMode = .scaleAspectFit
        typeWalletSmartPay.addSubview(smartPay)
        
        //new
        typeWalletAirPay = UIView()
        typeWalletAirPay.frame = CGRect(x: typeWalletSmartPay.frame.origin.x + typeWalletSmartPay.frame.width + Common.Size(s: 5), y: Common.Size(s: 10), width: typeWalletVNPay.frame.size.width, height: Common.Size(s: 35))
        typeWalletAirPay.backgroundColor = UIColor.white
        typeWalletAirPay.layer.masksToBounds = false
        typeWalletAirPay.layer.cornerRadius = 5
        typeWalletAirPay.clipsToBounds = true
        bodyViewWallet.addSubview(typeWalletAirPay)
        
        let tapWalletAirPay = UITapGestureRecognizer(target: self, action: #selector(tapActionWalletAirPay))
        typeWalletAirPay.isUserInteractionEnabled = true
        typeWalletAirPay.addGestureRecognizer(tapWalletAirPay)
        
        let airPay = UIImageView(frame: CGRect(x: 0,y: 0 ,width:typeWalletAirPay.frame.size.width,height: typeWalletAirPay.frame.size.height))
        airPay.image = UIImage(named: "Shoppee_icon")
        airPay.contentMode = .scaleAspectFit
        typeWalletAirPay.addSubview(airPay)
        //endNew
        
        //new
        typeWalletFoxPay = UIView()
        typeWalletFoxPay.frame = CGRect(x: typeWalletAirPay.frame.origin.x + typeWalletAirPay.frame.width + Common.Size(s: 5), y: Common.Size(s: 10), width: typeWalletVNPay.frame.size.width, height: Common.Size(s: 35))
        typeWalletFoxPay.backgroundColor = UIColor.white
        typeWalletFoxPay.layer.masksToBounds = false
        typeWalletFoxPay.layer.cornerRadius = 5
        typeWalletFoxPay.clipsToBounds = true
        bodyViewWallet.addSubview(typeWalletFoxPay)
        
        let tapWalletFoxPay = UITapGestureRecognizer(target: self, action: #selector(tapActionWalletFoxPay))
        typeWalletFoxPay.isUserInteractionEnabled = true
        typeWalletFoxPay.addGestureRecognizer(tapWalletFoxPay)
        
        let foxPay = UIImageView(frame: CGRect(x: 0,y: 0 ,width:typeWalletFoxPay.frame.size.width,height: typeWalletFoxPay.frame.size.height))
        foxPay.image = UIImage(named: "Foxpay_icon")
        foxPay.contentMode = .scaleAspectFit
        typeWalletFoxPay.addSubview(foxPay)
        
        self.typeWalletZaloPay = UIView()
        self.typeWalletZaloPay.frame = CGRect(x: self.typeWalletFoxPay.frame.origin.x + self.typeWalletFoxPay.frame.width + Common.Size(s: 5), y: Common.Size(s: 10), width: self.typeWalletVNPay.frame.size.width, height: Common.Size(s: 35))
        self.typeWalletZaloPay.backgroundColor = UIColor.white
        self.typeWalletZaloPay.layer.masksToBounds = false
        self.typeWalletZaloPay.layer.cornerRadius = 5
        self.typeWalletZaloPay.clipsToBounds = true
        bodyViewWallet.addSubview(self.typeWalletZaloPay)
        
        let tapWalletZaloPay = UITapGestureRecognizer(target: self, action: #selector(tapActionWalletZaloPay))
        self.typeWalletZaloPay.isUserInteractionEnabled = true
        self.typeWalletZaloPay.addGestureRecognizer(tapWalletZaloPay)
        
        let zaloPay = UIImageView(frame: CGRect(x: 0,y: 0 ,width:self.typeWalletZaloPay.frame.size.width,height: self.typeWalletZaloPay.frame.size.height))
        zaloPay.image = UIImage(named: "zalo_pay")
        zaloPay.contentMode = .scaleAspectFit
        self.typeWalletZaloPay.addSubview(zaloPay)
        
        
        //endNew
        
        let lbWallet = UILabel(frame: CGRect(x: Common.Size(s: 15), y: typeWalletVNPay.frame.origin.y + typeWalletVNPay.frame.size.height + Common.Size(s: 10), width: bodyViewWallet.frame.size.width/2 - Common.Size(s: 15), height: Common.Size(s: 30)))
        lbWallet.text = "Số tiền"
        lbWallet.textColor = UIColor.lightGray
        lbWallet.textAlignment = .left
        lbWallet.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        bodyViewWallet.addSubview(lbWallet)
        
        tfWallet = UITextField(frame: CGRect(x: lbWallet.frame.origin.x + lbWallet.frame.size.width, y: lbWallet.frame.origin.y , width: bodyViewWallet.frame.size.width/2  - Common.Size(s: 15), height: lbWallet.frame.size.height))
        tfWallet.placeholder = ""
        tfWallet.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfWallet.borderStyle = UITextField.BorderStyle.roundedRect
        tfWallet.autocorrectionType = UITextAutocorrectionType.no
        tfWallet.keyboardType = UIKeyboardType.numberPad
        tfWallet.returnKeyType = UIReturnKeyType.done
        tfWallet.clearButtonMode = UITextField.ViewMode.whileEditing
        tfWallet.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfWallet.delegate = self
        tfWallet.textAlignment = .right
        bodyViewWallet.addSubview(tfWallet)
        tfWallet.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        tfWalletCode = UITextField(frame: CGRect(x: Common.Size(s: 15), y: tfWallet.frame.origin.y + tfWallet.frame.size.height + Common.Size(s: 10) , width: bodyViewWallet.frame.size.width * 2/3 - Common.Size(s: 15), height: Common.Size(s: 30)))
        tfWalletCode.placeholder = "Số chứng từ VNPAY (nếu có)"
        tfWalletCode.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfWalletCode.borderStyle = UITextField.BorderStyle.roundedRect
        tfWalletCode.autocorrectionType = UITextAutocorrectionType.no
        tfWalletCode.keyboardType = UIKeyboardType.default
        tfWalletCode.returnKeyType = UIReturnKeyType.done
        tfWalletCode.clearButtonMode = UITextField.ViewMode.whileEditing
        tfWalletCode.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfWalletCode.delegate = self
        tfWalletCode.textAlignment = .left
        bodyViewWallet.addSubview(tfWalletCode)
        
        btGetQRCode = UIButton(frame: CGRect(x: tfWalletCode.frame.origin.x + tfWalletCode.frame.size.width + Common.Size(s: 15), y: tfWalletCode.frame.origin.y, width: bodyViewWallet.frame.size.width - (tfWalletCode.frame.origin.x + tfWalletCode.frame.size.width + Common.Size(s: 15)) - Common.Size(s: 15), height: tfWalletCode.frame.size.height))
        btGetQRCode.layer.cornerRadius = 5
        btGetQRCode.setTitle("Kiểm tra",for: .normal)
        btGetQRCode.titleLabel?.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        btGetQRCode.backgroundColor = UIColor.init(netHex: 0x00955E)
        bodyViewWallet.addSubview(btGetQRCode)
        btGetQRCode.addTarget(self, action:#selector(self.checkIQcode), for: .touchUpInside)
        
        viewBarcode = UIView()
        viewBarcode.frame = CGRect(x: Common.Size(s: 15), y: tfWalletCode.frame.size.height + tfWalletCode.frame.origin.y + Common.Size(s: 10), width: bodyViewWallet.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 35))
        viewBarcode.backgroundColor = UIColor.white
        viewBarcode.layer.masksToBounds = false
        viewBarcode.layer.cornerRadius = 5
        viewBarcode.layer.borderWidth = 1
        viewBarcode.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        viewBarcode.clipsToBounds = true
        bodyViewWallet.addSubview(viewBarcode)
        
        barcode = UIImageView(frame: CGRect(x:(viewBarcode.frame.size.width - Common.Size(s: 50) )/2,y: Common.Size(s: 10) ,width:Common.Size(s: 50),height: Common.Size(s: 50)))
        barcode.image = UIImage(named:"qrcode")
        barcode.contentMode = .scaleAspectFit
        viewBarcode.addSubview(barcode)
        
        lbBarcode = UILabel(frame: CGRect(x: 0, y: barcode.frame.origin.y + barcode.frame.size.height , width: viewBarcode.frame.size.width, height: Common.Size(s: 30)))
        lbBarcode.text = "Hiện Barcode"
        lbBarcode.textColor = UIColor.lightGray
        lbBarcode.textAlignment = .center
        lbBarcode.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        viewBarcode.addSubview(lbBarcode)
        viewBarcode.frame.size.height = lbBarcode.frame.origin.y + lbBarcode.frame.size.height + Common.Size(s: 5)
        
        let tapBarcode = UITapGestureRecognizer(target: self, action: #selector(typeBarcodeTapped(tapGestureRecognizer:)))
        viewBarcode.isUserInteractionEnabled = true
        viewBarcode.addGestureRecognizer(tapBarcode)
        
        //create new barcodeView
        viewBarcodeMoca = UIView()
        viewBarcodeMoca.frame = CGRect(x: Common.Size(s: 15), y: self.tfWalletCode.frame.origin.y + self.tfWalletCode.frame.height + Common.Size(s: 10), width: bodyViewWallet.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 35))
        viewBarcodeMoca.backgroundColor = UIColor.white
        viewBarcodeMoca.layer.masksToBounds = false
        viewBarcodeMoca.layer.cornerRadius = 5
        viewBarcodeMoca.layer.borderWidth = 1
        viewBarcodeMoca.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        viewBarcodeMoca.clipsToBounds = true
        bodyViewWallet.addSubview(viewBarcodeMoca)
        
        barcodeMoca = UIImageView(frame: CGRect(x:(viewBarcode.frame.size.width - Common.Size(s: 50) )/2,y: Common.Size(s: 10) ,width:Common.Size(s: 50),height: Common.Size(s: 50)))
        barcodeMoca.image = UIImage(named:"qrcode")
        barcodeMoca.contentMode = .scaleAspectFit
        viewBarcodeMoca.addSubview(barcodeMoca)
        
        lbBarcodeMoca = UILabel(frame: CGRect(x: 0, y: barcode.frame.origin.y + barcode.frame.size.height , width: viewBarcode.frame.size.width, height: Common.Size(s: 30)))
        lbBarcodeMoca.text = "Hiện Barcode Moca"
        lbBarcodeMoca.textColor = UIColor.lightGray
        lbBarcodeMoca.textAlignment = .center
        lbBarcodeMoca.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        viewBarcodeMoca.addSubview(lbBarcodeMoca)
        viewBarcodeMoca.frame.size.height = lbBarcodeMoca.frame.origin.y + lbBarcodeMoca.frame.size.height + Common.Size(s: 5)
        
        let tapBarcodeMoca = UITapGestureRecognizer(target: self, action: #selector(showBarcodeMoca))
        viewBarcodeMoca.isUserInteractionEnabled = true
        viewBarcodeMoca.addGestureRecognizer(tapBarcodeMoca)
        ///-----------------------
        //create barcode smartpay
        viewBarcodeSmartPay = UIView()
        viewBarcodeSmartPay.frame = CGRect(x: Common.Size(s: 15), y: self.tfWalletCode.frame.origin.y + self.tfWalletCode.frame.height + Common.Size(s: 10), width: bodyViewWallet.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 35))
        viewBarcodeSmartPay.backgroundColor = UIColor.white
        viewBarcodeSmartPay.layer.masksToBounds = false
        viewBarcodeSmartPay.layer.cornerRadius = 5
        viewBarcodeSmartPay.layer.borderWidth = 1
        viewBarcodeSmartPay.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        viewBarcodeSmartPay.clipsToBounds = true
        bodyViewWallet.addSubview(viewBarcodeSmartPay)
        
        barcodeSmartPay = UIImageView(frame: CGRect(x:(viewBarcode.frame.size.width - Common.Size(s: 50) )/2,y: Common.Size(s: 10) ,width:Common.Size(s: 50),height: Common.Size(s: 50)))
        barcodeSmartPay.image = UIImage(named:"qrcode")
        barcodeSmartPay.contentMode = .scaleAspectFit
        viewBarcodeSmartPay.addSubview(barcodeSmartPay)
        
        lbBarcodeSmartPay = UILabel(frame: CGRect(x: 0, y: barcode.frame.origin.y + barcode.frame.size.height , width: viewBarcode.frame.size.width, height: Common.Size(s: 30)))
        lbBarcodeSmartPay.text = "Hiện Barcode SmartPay"
        lbBarcodeSmartPay.textColor = UIColor.lightGray
        lbBarcodeSmartPay.textAlignment = .center
        lbBarcodeSmartPay.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        viewBarcodeSmartPay.addSubview(lbBarcodeMoca)
        viewBarcodeSmartPay.frame.size.height = lbBarcodeSmartPay.frame.origin.y + lbBarcodeSmartPay.frame.size.height + Common.Size(s: 5)
        
        let tapBarcodeSmartPay = UITapGestureRecognizer(target: self, action: #selector(showBarcodeSmartPay))
        viewBarcodeMoca.isUserInteractionEnabled = true
        viewBarcodeSmartPay.addGestureRecognizer(tapBarcodeSmartPay)
        //
        
//        airpaybarcode
        viewBarcodeAirPay = UIView()
        viewBarcodeAirPay.frame = CGRect(x: Common.Size(s: 15), y: tfWalletCode.frame.size.height + tfWalletCode.frame.origin.y + Common.Size(s: 10), width: bodyViewWallet.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 35))
        viewBarcodeAirPay.backgroundColor = UIColor.white
        viewBarcodeAirPay.layer.masksToBounds = false
        viewBarcodeAirPay.layer.cornerRadius = 5
        viewBarcodeAirPay.layer.borderWidth = 1
        viewBarcodeAirPay.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        viewBarcodeAirPay.clipsToBounds = true
        bodyViewWallet.addSubview(viewBarcodeAirPay)
        
        barcodeAirPay = UIImageView(frame: CGRect(x:(viewBarcodeAirPay.frame.size.width - Common.Size(s: 50) )/2,y: Common.Size(s: 10) ,width:Common.Size(s: 50),height: Common.Size(s: 50)))
        barcodeAirPay.image = UIImage(named:"qrcode")
        barcodeAirPay.contentMode = .scaleAspectFit
        viewBarcodeAirPay.addSubview(barcodeAirPay)
        
        lbBarcodeAirPay = UILabel(frame: CGRect(x: 0, y: barcode.frame.origin.y + barcode.frame.size.height , width: viewBarcode.frame.size.width, height: Common.Size(s: 30)))
        lbBarcodeAirPay.text = "Hiện Barcode ShopeePay"
        lbBarcodeAirPay.textColor = UIColor.lightGray
        lbBarcodeAirPay.textAlignment = .center
        lbBarcodeAirPay.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        viewBarcodeAirPay.addSubview(lbBarcodeAirPay)
        viewBarcodeAirPay.frame.size.height = lbBarcodeAirPay.frame.origin.y + lbBarcodeAirPay.frame.size.height + Common.Size(s: 5)
        
        let tapBarcodeAirpay = UITapGestureRecognizer(target: self, action: #selector(showBarcodeAirPay))
        viewBarcodeAirPay.isUserInteractionEnabled = true
        viewBarcodeAirPay.addGestureRecognizer(tapBarcodeAirpay)
        //end
        
        // foxpay barcode
        viewBarcodeFoxPay = UIView()
        viewBarcodeFoxPay.frame = CGRect(x: Common.Size(s: 15), y: tfWalletCode.frame.size.height + tfWalletCode.frame.origin.y + Common.Size(s: 10), width: bodyViewWallet.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 35))
        viewBarcodeFoxPay.backgroundColor = UIColor.white
        viewBarcodeFoxPay.layer.masksToBounds = false
        viewBarcodeFoxPay.layer.cornerRadius = 5
        viewBarcodeFoxPay.layer.borderWidth = 1
        viewBarcodeFoxPay.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        viewBarcodeFoxPay.clipsToBounds = true
        bodyViewWallet.addSubview(viewBarcodeFoxPay)
        
        barcodeFoxPay = UIImageView(frame: CGRect(x:(viewBarcodeFoxPay.frame.size.width - Common.Size(s: 50) )/2,y: Common.Size(s: 10) ,width:Common.Size(s: 50),height: Common.Size(s: 50)))
        barcodeFoxPay.image = UIImage(named:"qrcode")
        barcodeFoxPay.contentMode = .scaleAspectFit
        viewBarcodeFoxPay.addSubview(barcodeFoxPay)
        
        lbBarcodeFoxPay = UILabel(frame: CGRect(x: 0, y: barcode.frame.origin.y + barcode.frame.size.height , width: viewBarcode.frame.size.width, height: Common.Size(s: 30)))
        lbBarcodeFoxPay.text = "Hiện Barcode FoxPay"
        lbBarcodeFoxPay.textColor = UIColor.lightGray
        lbBarcodeFoxPay.textAlignment = .center
        lbBarcodeFoxPay.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        viewBarcodeFoxPay.addSubview(lbBarcodeFoxPay)
        viewBarcodeFoxPay.frame.size.height = lbBarcodeFoxPay.frame.origin.y + lbBarcodeFoxPay.frame.size.height + Common.Size(s: 5)
        
        let tapBarcodeFoxPay = UITapGestureRecognizer(target: self, action: #selector(showBarcodeFoxPay))
        viewBarcodeFoxPay.isUserInteractionEnabled = true
        viewBarcodeFoxPay.addGestureRecognizer(tapBarcodeFoxPay)
        
        self.viewBarcodeZaloPay = UIView()
        self.viewBarcodeZaloPay.frame = CGRect(x: Common.Size(s: 15), y: tfWalletCode.frame.size.height + tfWalletCode.frame.origin.y + Common.Size(s: 10), width: bodyViewWallet.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 35))
        self.viewBarcodeZaloPay.backgroundColor = UIColor.white
        self.viewBarcodeZaloPay.layer.masksToBounds = false
        self.viewBarcodeZaloPay.layer.cornerRadius = 5
        self.viewBarcodeZaloPay.layer.borderWidth = 1
        self.viewBarcodeZaloPay.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        self.viewBarcodeZaloPay.clipsToBounds = true
        self.bodyViewWallet.addSubview(self.viewBarcodeZaloPay)
        
        self.barcodeZaloPay = UIImageView(frame: CGRect(x:(self.viewBarcodeZaloPay.frame.size.width - Common.Size(s: 50) )/2,y: Common.Size(s: 10) ,width:Common.Size(s: 50),height: Common.Size(s: 50)))
        self.barcodeZaloPay.image = UIImage(named:"qrcode")
        self.barcodeZaloPay.contentMode = .scaleAspectFit
        self.viewBarcodeZaloPay.addSubview(self.barcodeZaloPay)
        
        self.lbBarcodeZaloPay = UILabel(frame: CGRect(x: 0, y: barcode.frame.origin.y + barcode.frame.size.height , width: viewBarcode.frame.size.width, height: Common.Size(s: 30)))
        self.lbBarcodeZaloPay.text = "Hiện Barcode ZaloPay"
        self.lbBarcodeZaloPay.textColor = UIColor.lightGray
        self.lbBarcodeZaloPay.textAlignment = .center
        self.lbBarcodeZaloPay.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        self.viewBarcodeZaloPay.addSubview( self.lbBarcodeZaloPay)
        self.viewBarcodeZaloPay.frame.size.height =  self.lbBarcodeZaloPay.frame.origin.y +  self.lbBarcodeZaloPay.frame.size.height + Common.Size(s: 5)
        
        let tapBarcodeZaloPay = UITapGestureRecognizer(target: self, action: #selector(showBarCodeZaloPay))
        self.viewBarcodeZaloPay.isUserInteractionEnabled = true
        self.viewBarcodeZaloPay.addGestureRecognizer(tapBarcodeZaloPay)
        
        //end
        
        lbNumVNPAY = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewBarcode.frame.origin.y + viewBarcode.frame.size.height + Common.Size(s: 10), width: bodyViewWallet.frame.size.width, height: Common.Size(s: 20)))
        lbNumVNPAY.text = "Số CT VNPAY:"
        lbNumVNPAY.textColor = UIColor.black
        lbNumVNPAY.textAlignment = .left
        lbNumVNPAY.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        bodyViewWallet.addSubview(lbNumVNPAY)
        
        lbcodeKMVNPAY = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNumVNPAY.frame.origin.y + lbNumVNPAY.frame.size.height + Common.Size(s: 10), width: bodyViewWallet.frame.size.width, height: Common.Size(s: 20)))
        
        lbcodeKMVNPAY.textColor = UIColor.black
        lbcodeKMVNPAY.textAlignment = .left
        lbcodeKMVNPAY.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        bodyViewWallet.addSubview(lbcodeKMVNPAY)
        
        bodyViewWallet.clipsToBounds = true
        bodyViewWallet.frame.size.height = typeWalletVNPay.frame.origin.y + typeWalletVNPay.frame.size.height + Common.Size(s: 10)
        payViewWallet.clipsToBounds = true
        payViewWallet.frame.size.height = bodyViewWallet.frame.origin.y + bodyViewWallet.frame.size.height
        
        //------
        payViewPoint = UIView()
        payViewPoint.frame = CGRect(x: 0, y: payViewWallet.frame.origin.y + payViewWallet.frame.size.height, width: scrollView.frame.size.width, height: 0)
        payViewPoint.backgroundColor = UIColor.clear
        payViewPoint.clipsToBounds = true
        payView.addSubview(payViewPoint)
        
        let labelPoint = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: payViewPoint.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelPoint.text = "ĐIỂM THƯỞNG"
        labelPoint.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        payViewPoint.addSubview(labelPoint)
        
        let bodyViewPoint = UIView()
        bodyViewPoint.frame = CGRect(x: 0, y:labelPoint.frame.origin.y + labelPoint.frame.size.height, width: scrollView.frame.size.width, height: Common.Size(s: 50))
        bodyViewPoint.backgroundColor = UIColor.white
        payViewPoint.addSubview(bodyViewPoint)
        
        let  lbFPoint = UILabel(frame: CGRect(x: Common.Size(s: 10), y:  Common.Size(s: 10), width: (bodyViewPoint.frame.size.width - Common.Size(s: 40))/3, height: Common.Size(s:35)))
        lbFPoint.textAlignment = .center
        lbFPoint.textColor = .black
        lbFPoint.layer.cornerRadius = 5
        lbFPoint.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        lbFPoint.layer.borderWidth = 1
        lbFPoint.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        lbFPoint.text = "FMoney"
        lbFPoint.numberOfLines = 1
        bodyViewPoint.addSubview(lbFPoint)
        
        
        let lbFPointLable = UILabel(frame: CGRect(x: lbFPoint.frame.origin.x, y: lbFPoint.frame.size.height + lbFPoint.frame.origin.y+Common.Size(s:5), width: lbFPoint.frame.size.width, height: Common.Size(s:12)))
        lbFPointLable.textAlignment = .center
        lbFPointLable.textColor = .gray
        lbFPointLable.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        lbFPointLable.text = "FMoney"
        lbFPointLable.numberOfLines = 1
        bodyViewPoint.addSubview(lbFPointLable)
        
        
        let lbFCoin = UILabel(frame: CGRect(x: lbFPoint.frame.size.width + lbFPoint.frame.origin.x + Common.Size(s: 10), y: lbFPoint.frame.origin.y, width: lbFPoint.frame.size.width, height: lbFPoint.frame.size.height))
        lbFCoin.textAlignment = .center
        lbFCoin.textColor = .black
        lbFCoin.layer.cornerRadius = 5
        lbFCoin.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        lbFCoin.layer.borderWidth = 1
        lbFCoin.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        lbFCoin.text = "FPoint"
        lbFCoin.numberOfLines = 1
        bodyViewPoint.addSubview(lbFCoin)
        
        let lbFCoinLable = UILabel(frame: CGRect(x: lbFCoin.frame.origin.x, y: lbFCoin.frame.size.height + lbFCoin.frame.origin.y+Common.Size(s:5), width: lbFCoin.frame.size.width, height: Common.Size(s:12)))
        lbFCoinLable.textAlignment = .center
        lbFCoinLable.textColor = .gray
        lbFCoinLable.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        lbFCoinLable.text = "FPoint"
        lbFCoinLable.numberOfLines = 1
        bodyViewPoint.addSubview(lbFCoinLable)
        
        let lbRanking = UILabel(frame: CGRect(x: lbFCoin.frame.size.width + lbFCoin.frame.origin.x + Common.Size(s: 10), y: lbFCoin.frame.origin.y, width: lbFCoin.frame.size.width, height: lbFCoin.frame.size.height))
        lbRanking.textAlignment = .center
        lbRanking.textColor = .black
        lbRanking.layer.cornerRadius = 5
        lbRanking.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        lbRanking.layer.borderWidth = 1
        lbRanking.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        lbRanking.text = "Hạng thẻ"
        lbRanking.numberOfLines = 1
        bodyViewPoint.addSubview(lbRanking)
        
        let lbRankingLable = UILabel(frame: CGRect(x: lbRanking.frame.origin.x, y: lbRanking.frame.size.height + lbRanking.frame.origin.y+Common.Size(s:5), width: lbRanking.frame.size.width, height: Common.Size(s:12)))
        lbRankingLable.textAlignment = .center
        lbRankingLable.textColor = .gray
        lbRankingLable.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        lbRankingLable.text = "Hạng thẻ"
        lbRankingLable.numberOfLines = 1
        bodyViewPoint.addSubview(lbRankingLable)
        
        let lbTextPointValueUse = UILabel(frame: CGRect(x: Common.Size(s: 10), y: lbFPointLable.frame.origin.y + lbFPointLable.frame.size.height + Common.Size(s: 10), width: bodyViewPoint.frame.size.width/2 - Common.Size(s: 10), height: Common.Size(s: 30)))
        lbTextPointValueUse.text = "Điểm sử dụng:"
        lbTextPointValueUse.textColor = UIColor.lightGray
        lbTextPointValueUse.textAlignment = .left
        lbTextPointValueUse.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        bodyViewPoint.addSubview(lbTextPointValueUse)
        
        let lbPointValueUse = UILabel(frame: CGRect(x: lbTextPointValueUse.frame.size.width + lbTextPointValueUse.frame.origin.x, y: lbTextPointValueUse.frame.origin.y, width: bodyViewPoint.frame.size.width/2 - Common.Size(s: 10), height: Common.Size(s: 30)))
        lbPointValueUse.text = "0đ"
        lbPointValueUse.textColor = UIColor.black
        lbPointValueUse.textAlignment = .right
        lbPointValueUse.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        bodyViewPoint.addSubview(lbPointValueUse)
        
        for item in Cache.unconfirmationReasons {
            if(item.ItemCode == Common.skuKHTT){
                lbPointValueUse.text = "\(Common.convertCurrency(value: item.Discount))"
                break
            }
        }
        
        tfOTP = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbTextPointValueUse.frame.origin.y + lbTextPointValueUse.frame.size.height + Common.Size(s: 10) , width: bodyViewPoint.frame.size.width * 2/3 - Common.Size(s: 15), height: Common.Size(s: 30)))
        tfOTP.placeholder = "Nhập mã OTP qua SMS"
        tfOTP.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfOTP.borderStyle = UITextField.BorderStyle.roundedRect
        tfOTP.autocorrectionType = UITextAutocorrectionType.no
        tfOTP.keyboardType = UIKeyboardType.numberPad
        tfOTP.returnKeyType = UIReturnKeyType.done
        tfOTP.clearButtonMode = UITextField.ViewMode.whileEditing
        tfOTP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfOTP.delegate = self
        tfOTP.textAlignment = .left
        bodyViewPoint.addSubview(tfOTP)
        
        let btGetOTP = UIButton(frame: CGRect(x: tfOTP.frame.origin.x + tfOTP.frame.size.width + Common.Size(s: 15), y: tfOTP.frame.origin.y, width: bodyViewPoint.frame.size.width - (tfOTP.frame.origin.x + tfOTP.frame.size.width + Common.Size(s: 15)) - Common.Size(s: 15), height: tfOTP.frame.size.height))
        btGetOTP.layer.cornerRadius = 5
        btGetOTP.setTitle("Lấy mã",for: .normal)
        btGetOTP.titleLabel?.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        btGetOTP.backgroundColor = UIColor.init(netHex: 0x00955E)
        bodyViewPoint.addSubview(btGetOTP)
        btGetOTP.addTarget(self, action:#selector(self.getOTP), for: .touchUpInside)
        
        bodyViewPoint.frame.size.height = tfOTP.frame.origin.y + tfOTP.frame.size.height + Common.Size(s: 10)
        
        if(payPoint && toshibaPoint != nil){
            lbFPoint.text = Common.convertCurrencyV2(value: toshibaPoint!.FPoint)
            lbFCoin.text = Common.convertCurrencyV2(value: toshibaPoint!.FCoin)
            lbRanking.text = toshibaPoint!.CurrentRank
            payViewPoint.frame.size.height = bodyViewPoint.frame.origin.y + bodyViewPoint.frame.size.height
        }else{
            payViewPoint.frame.size.height = 0
        }
        //------
        payViewVoucher = UIView()
        payViewVoucher.frame = CGRect(x: 0, y: payViewPoint.frame.origin.y + payViewPoint.frame.size.height, width: scrollView.frame.size.width, height: Common.Size(s: 200))
        payViewVoucher.backgroundColor = UIColor.clear
        payView.addSubview(payViewVoucher)
        
        let labelVoucher = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: payViewVoucher.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelVoucher.text = "VOUCHER"
        labelVoucher.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        payViewVoucher.addSubview(labelVoucher)
        
        bodyViewVoucher = UIView()
        bodyViewVoucher.frame = CGRect(x: 0, y:labelVoucher.frame.origin.y + labelVoucher.frame.size.height, width: scrollView.frame.size.width, height: Common.Size(s: 50))
        bodyViewVoucher.backgroundColor = UIColor.white
        payViewVoucher.addSubview(bodyViewVoucher)
        
        //--
        listVoucherView = UIView()
        listVoucherView.frame = CGRect(x: 0, y: 0, width: bodyViewVoucher.frame.size.width, height: 0)
        bodyViewVoucher.addSubview(listVoucherView)
        //--
        boxVoucherView = UIView()
        boxVoucherView.frame = CGRect(x: 0, y: listVoucherView.frame.size.height + listVoucherView.frame.origin.y + Common.Size(s: 10), width: bodyViewVoucher.frame.size.width, height: Common.Size(s: 30))
        bodyViewVoucher.addSubview(boxVoucherView)
        
        tfVoucher = UITextField(frame: CGRect(x: Common.Size(s: 15), y: 0, width: boxVoucherView.frame.size.width * 2/3 - Common.Size(s: 15) , height: boxVoucherView.frame.size.height))
        tfVoucher.placeholder = ""
        tfVoucher.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfVoucher.borderStyle = UITextField.BorderStyle.roundedRect
        tfVoucher.autocorrectionType = UITextAutocorrectionType.no
        tfVoucher.keyboardType = UIKeyboardType.default
        tfVoucher.returnKeyType = UIReturnKeyType.done
        tfVoucher.clearButtonMode = UITextField.ViewMode.whileEditing
        tfVoucher.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfVoucher.delegate = self
        boxVoucherView.addSubview(tfVoucher)
        tfVoucher.rightViewMode = .always
        let searchImageRight = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        let searchImageViewRight = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let scan = UIImage(named: "scan_barcode")
        searchImageViewRight.image = scan
        searchImageRight.addSubview(searchImageViewRight)
        tfVoucher.rightView = searchImageRight
        let gestureSearchImageRight = UITapGestureRecognizer(target: self, action:  #selector(self.actionScan))
        searchImageRight.addGestureRecognizer(gestureSearchImageRight)
        
        
        let btCheckVoucher = UIButton(frame: CGRect(x: tfVoucher.frame.origin.x + tfVoucher.frame.size.width + Common.Size(s: 15), y: 0, width: boxVoucherView.frame.size.width - (tfVoucher.frame.origin.x + tfVoucher.frame.size.width + Common.Size(s: 15)) - Common.Size(s: 15), height: boxVoucherView.frame.size.height))
        btCheckVoucher.layer.cornerRadius = 5
        btCheckVoucher.setTitle("Áp dụng",for: .normal)
        btCheckVoucher.titleLabel?.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        btCheckVoucher.backgroundColor = UIColor.init(netHex: 0x00955E)
        boxVoucherView.addSubview(btCheckVoucher)
        btCheckVoucher.addTarget(self, action:#selector(self.checkVoucher), for: .touchUpInside)
        
        //--
        bodyViewVoucher.frame.size.height = boxVoucherView.frame.size.height + boxVoucherView.frame.origin.y + Common.Size(s: 10)
        
        payViewVoucher.frame.size.height = bodyViewVoucher.frame.size.height + bodyViewVoucher.frame.origin.y
        
        //------
        payViewDeposit = UIView()
        payViewDeposit.frame = CGRect(x: 0, y: payViewVoucher.frame.origin.y + payViewVoucher.frame.size.height, width: scrollView.frame.size.width, height: Common.Size(s: 200))
        payViewDeposit.backgroundColor = UIColor.clear
        payView.addSubview(payViewDeposit)
        
        let labelDeposit = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: payViewDeposit.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelDeposit.text = "ĐẶT CỌC"
        labelDeposit.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        payViewDeposit.addSubview(labelDeposit)
        
        let bodyViewDeposit = UIView()
        bodyViewDeposit.frame = CGRect(x: 0, y:labelDeposit.frame.origin.y + labelDeposit.frame.size.height, width: scrollView.frame.size.width, height: Common.Size(s: 50))
        bodyViewDeposit.backgroundColor = UIColor.white
        payViewDeposit.addSubview(bodyViewDeposit)
        
        tfDeposit = UITextField(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: bodyViewDeposit.frame.size.width - Common.Size(s: 30) , height: boxVoucherView.frame.size.height))
        tfDeposit.placeholder = "Nhập số tiền đặt cọc"
        tfDeposit.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfDeposit.borderStyle = UITextField.BorderStyle.roundedRect
        tfDeposit.autocorrectionType = UITextAutocorrectionType.no
        tfDeposit.keyboardType = UIKeyboardType.numberPad
        tfDeposit.returnKeyType = UIReturnKeyType.done
        tfDeposit.clearButtonMode = UITextField.ViewMode.whileEditing
        tfDeposit.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDeposit.delegate = self
        bodyViewDeposit.addSubview(tfDeposit)
        tfDeposit.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        bodyViewDeposit.frame.size.height = tfDeposit.frame.size.height + tfDeposit.frame.origin.y + Common.Size(s: 10)
        
        payViewDeposit.frame.size.height = bodyViewDeposit.frame.size.height + bodyViewDeposit.frame.origin.y
        
        if(self.type != "3"){
            payViewDeposit.frame.size.height = 0
            payViewDeposit.clipsToBounds = true
        }else{
            tfDeposit.text = convertFormat(value: Float(self.totalPayment))
        }
        
        payView.frame.size.height = payViewDeposit.frame.size.height + payViewDeposit.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: payView.frame.size.height + payView.frame.origin.y + Common.Size(s: 10))
        updateUIVoucher()
    }
    
    func getRulesPayment(walletCode: String) {
        let rDR1 = parseXMLProduct().toBase64()
        let pROMOS = parseXMLPromotion().toBase64()
        Provider.shared.payMentApiSevice.getRulesPayment(walletCode: walletCode, rdr1: rDR1, promos: pROMOS, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            self.isEnableWallet = data.isEnableChangeAmount
            self.tfWallet.isEnabled = self.isEnableWallet
            if data.messages != "" {
                self.showPopUp(data.messages, "Thông báo", buttonTitle: "OK", handleOk: nil)
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    @objc func checkIQcode() {
        
        let code = tfWalletCode.text!
        if(!code.isEmpty){
            var typeCheck_IQcode = ""
            if isVNPay {
                typeCheck_IQcode = "0"
            }
            if isMoca {
                typeCheck_IQcode = "1"
            }
            if isSmartPay{
                typeCheck_IQcode = "2"
            }
            if isAirPay {
                typeCheck_IQcode = "5"
            }
            if isFoxPay {
                typeCheck_IQcode = "6"
            }
            if self.isZaloPay {
                typeCheck_IQcode = "7"
            }
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            MPOSAPIManager.sp_mpos_FRT_SP_innovation_check_IQcode(SDT: "\(phone)", p_IDQrCode: code, type: typeCheck_IQcode) { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        if(results.count > 0){
                            let item = results[0]
                            if(item.p_status == 1){
                                let popup = PopupDialog(title: "Thông báo", message: item.p_messagess, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                    if self.isZaloPay {
                                        self.orderID = code
                                        self.priceQRPAY = item.p_sotien
                                        self.tfWallet.text = Common.convertCurrencyV2(value: item.p_sotien)
                                        self.viewBarcode.isUserInteractionEnabled = false
                                        self.lbNumVNPAY.text = "Số CT ZaloPay: \(code)"
                                        self.lbNumVNPAY.textColor = UIColor.lightGray
                                        self.updatePrice()
                                    }
                                    if self.isVNPay {
                                        self.txnId = code
                                        self.priceQRPAY = item.p_sotien
                                        self.tfWallet.text = Common.convertCurrencyV2(value: item.p_sotien)
                                        self.viewBarcode.isUserInteractionEnabled = false
                                        self.lbNumVNPAY.text = "Số CT VNPAY: \(code)"
                                        self.lbNumVNPAY.textColor = UIColor.lightGray
                                        self.updatePrice()
                                    }
                                    
                                    if self.isMoca {
                                        //update UI
                                        self.tfWallet.text = Common.convertCurrencyV2(value: item.p_sotien)
                                        self.viewBarcodeMoca.isUserInteractionEnabled = false
                                        self.lbNumVNPAY.text = "SỐ CT MOCA: \(code)"
                                        self.partnerTxIDMoca = code
                                        self.lbNumVNPAY.textColor = UIColor.lightGray
                                        self.updatePrice()
                                    }
                                    if self.isSmartPay {
                                        //update UI
                                        self.tfWallet.text = Common.convertCurrencyV2(value: item.p_sotien)
                                        self.viewBarcodeSmartPay.isUserInteractionEnabled = false
                                        self.lbNumVNPAY.text = "SỐ CT SMARTPAY: \(code)"
                                        self.partnerTxIDSmartPay = code
                                        self.lbNumVNPAY.textColor = UIColor.lightGray
                                        self.priceQRSMARTPAY = item.p_sotien
                                        self.updatePrice()
                                    }
                                    if self.isAirPay {
                                        self.tfWallet.text = Common.convertCurrencyV2(value: item.p_sotien)
                                        self.viewBarcodeSmartPay.isUserInteractionEnabled = false
                                        self.lbNumVNPAY.text = "SỐ CT AIRPAY: \(code)"
                                        self.partnerTxIDAirPay = code
                                        self.orderID = code
                                        self.lbNumVNPAY.textColor = UIColor.lightGray
                                        self.priceQRAirPAY = item.p_sotien
                                        self.updatePrice()
                                    }
                                    if self.isFoxPay {
                                        self.tfWallet.text = Common.convertCurrencyV2(value: item.p_sotien)
                                        self.viewBarcodeSmartPay.isUserInteractionEnabled = false
                                        self.lbNumVNPAY.text = "SỐ CT FOXPAY: \(code)"
                                        self.partnerTxIDFoxPay = code
                                        self.orderID = code
                                        self.lbNumVNPAY.textColor = UIColor.lightGray
                                        self.priceQRFoxPAY = item.p_sotien
                                        self.updatePrice()
                                    }
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }else{
                                let popup = PopupDialog(title: "Thông báo", message: item.p_messagess, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                    
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }
                        }else{
                            let popup = PopupDialog(title: "Thông báo", message: "Không tìm thấy số chứng từ.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }else{
                        let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            }
        }else{
            var typeMsg = ""
            if isVNPay {
                typeMsg = "VNPAY"
            }
            if isMoca {
                typeMsg = "MOCA"
            }
            
            if self.isZaloPay {
                typeMsg = "ZaloPay"
            }
            let popup = PopupDialog(title: "Thông báo", message: "Bạn phải nhập số chừng từ \(typeMsg).", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
        }
    }
    @objc func actionScan() {
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { code in
            self.tfVoucher.text = code
            self.verifyVoucher(code: code, index: 0, isMore: true)
        }
        self.present(viewController, animated: false, completion: nil)
    }
    
    @objc func tapActionWalletVNPay(sender : UITapGestureRecognizer) {
        self.isMoca = false
        self.isZaloPay = false
        self.isSmartPay = false
        self.isVNPay = !self.isVNPay
        self.isAirPay = false
        self.isFoxPay = false
        self.updateWalletBodyUI()
        self.updatePrice()
        var voucherSum:Int = 0
        if(listVoucherUse.count > 0){
            for item in listVoucherUse {
                voucherSum = voucherSum + Int(item.Price)
            }
        }
        totalTemp  = totalPayment - voucherSum - Int(Cache.payOnlineEcom)
        tfWallet.text = Common.convertCurrencyV2(value: totalTemp)
        getRulesPayment(walletCode: "VNpay")
    }
    
    @objc func tapActionWalletMoca() {
            self.isVNPay = false
        self.isZaloPay = false
            self.isSmartPay = false
            self.isMoca = !self.isMoca
            self.isAirPay = false
            self.isFoxPay = false
        self.updateWalletBodyUI()
        self.updatePrice()
        getRulesPayment(walletCode: "Moca")
        if isDisableTxtMoca {  //disable typing txt moca
            var voucherSum:Int = 0
            if(listVoucherUse.count > 0){
                for item in listVoucherUse {
                    voucherSum = voucherSum + Int(item.Price)
                }
            }
//            totalTemp  = totalPayment - voucherSum - Int(Cache.payOnlineEcom)
            tfWallet.text = Common.convertCurrencyV2(value: totalPayment)
        }
    }
    
    @objc func tapActionWalletSmartPay() {
            self.isVNPay = false
            self.isMoca = false
        self.isZaloPay = false
            self.isSmartPay = !self.isSmartPay
            self.isAirPay = false
            self.isFoxPay = false
            self.updateWalletBodyUI()
            self.updatePrice()
            getRulesPayment(walletCode: "Smartpay")
    }
    
    @objc func tapActionWalletAirPay() {
        self.isVNPay = false
        self.isZaloPay = false
        self.isMoca = false
        self.isSmartPay = false
        self.isAirPay = !self.isAirPay
        self.isFoxPay = false
        self.updateWalletBodyUI()
        self.updatePrice()
        getRulesPayment(walletCode: "Shopeepay")
    }
    
    @objc func tapActionWalletFoxPay() {
        self.isVNPay = false
        self.isMoca = false
        self.isSmartPay = false
        self.isAirPay = false
        self.isFoxPay = true
        self.isZaloPay = false
        self.updateWalletBodyUI()
        self.updatePrice()
        getRulesPayment(walletCode: "Foxpay")
    }
    
    @objc func tapActionWalletZaloPay() {
        self.isZaloPay = true
        self.isVNPay = false
        self.isMoca = false
        self.isSmartPay = false
        self.isAirPay = false
        self.isFoxPay = false
        self.updateWalletBodyUI()
        self.updatePrice()
        var voucherSum:Int = 0
        if(listVoucherUse.count > 0){
            for item in listVoucherUse {
                voucherSum = voucherSum + Int(item.Price)
            }
        }
        totalTemp  = totalPayment - voucherSum - Int(Cache.payOnlineEcom)
        lbTotalVoucherValue.text = "\(Common.convertCurrencyV2(value: totalTemp))đ"
        tfWallet.text = Common.convertCurrencyV2(value: totalTemp)
        
        var moneyString = tfWallet.text ?? "0"
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        let moneyInt = Int(moneyString) ?? 0
        let finalMoney = self.totalTemp - (moneyInt )
        self.lbTotalCardCashValue.text = "\(Common.convertCurrencyV2(value: finalMoney))đ"
        
        getRulesPayment(walletCode: "ZaloPay")
    }
    
    private func promotionString() -> String {
        var promotions = ""
        for item in itemsPromotion {
            promotions += item.MaCTKM + ","
        }
        promotions = promotions.dropLast
        
        return promotions
    }
    
    @objc func actionBank(sender : UITapGestureRecognizer) {
        let myVC = ListBankPayViewController()
        myVC.delegate = self
        let navController = UINavigationController(rootViewController: myVC)
        self.navigationController?.present(navController, animated:false, completion: nil)
    }
    @objc func actionBankType(sender : UITapGestureRecognizer) {
        let myVC = ListBankTypePayViewController()
        myVC.delegate = self
        let navController = UINavigationController(rootViewController: myVC)
        self.navigationController?.present(navController, animated:false, completion: nil)
    }
    func returnBank(item: PaymentType) {
        tfBank.text = item.Text
        self.bank = item
    }
    func returnBankType(item: CardTypeFromPOSResult) {
        tfBankType.text = item.Text
        self.bankType = item
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func typeBarcodeTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        
        var moneyString:String = self.tfWallet.text!
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        if(moneyString.isEmpty){
            moneyString = "0"
        }
        
        guard let moneyInt = Int(moneyString) , moneyInt > 0 else {
            Toast.init(text: "Bạn phải nhập số tiền thanh toán lớn hơn 0").show()
            return
        }
        if isVNPay {
            if(payViewWallet.frame.size.height > 0){
                
                let newViewController = LoadingViewController()
                newViewController.content = "Đang tạo mã QRCode thanh toán..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                let rDR1 = parseXMLProduct().toBase64()
                let pROMOS = parseXMLPromotion().toBase64()
                MPOSAPIManager.mpos_FRT_SP_GetCode_QRcode_payment(RDR1:"\(rDR1)",PROMOS:"\(pROMOS)",Doctotal:"\(moneyString)",type:"1", typeOrder: Cache.typeOrder1) { (codeVnPay, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        
                        if(err.count <= 0){
                            let newViewController = LoadingViewController()
                            newViewController.content = "Đang tạo mã QRCode thanh toán..."
                            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                            self.navigationController?.present(newViewController, animated: true, completion: nil)
                            let nc = NotificationCenter.default
                            MPOSAPIManager.genQRCode(amount: moneyString,purpose:"\(codeVnPay)") { (reult, err) in
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    
                                    self.qrCodeVNPayItem = reult
                                    if(err.count <= 0){
                                        
                                        if let decodedData = Data(base64Encoded: reult!.base64QRCode, options: .ignoreUnknownCharacters) {
                                            self.priceQRPAY = moneyInt
                                            let image = UIImage(data: decodedData)
                                            self.txnId = reult!.txnId
                                            self.updateBarcode(image: image)
                                            self.lbNumVNPAY.text = "Số CT VNPAY: \(self.txnId)"
                                            self.lbcodeKMVNPAY.text = "Code KM Vnpay: \(codeVnPay)"
                                        }
                                    }else{
                                        let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                            print("Completed")
                                        }
                                        let buttonOne = CancelButton(title: "OK") {
                                            
                                        }
                                        popup.addButtons([buttonOne])
                                        self.present(popup, animated: true, completion: nil)
                                    }
                                }
                            }
                            
                        }else{
                            let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    @objc func showBarcodeMoca() {
        if isMoca {
            var moneyString:String = tfWallet.text!
            moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)

            if(moneyString.isEmpty){
                moneyString = "0"
            }
            debugPrint("moneyString Moca: \(moneyString)")
            
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.Moca_CreateQRCodeMobile(amount: "\(moneyString)") { (rs, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if(err.count <= 0){
                            if rs != nil {
                                if rs?.code == "00" {
                                    
                                    self.partnerTxIDMoca = rs?.partnerTxID ?? ""
                                    let popup = PopupDialog(title: "Thông báo", message: "\(rs?.message ?? "Tạo QRCode thành công!")", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        print("Completed")
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                        //
                                        if rs!.qrcode.isEmpty {
                                            let popup = PopupDialog(title: "Thông báo", message: "Không lấy được QRCode!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                                print("Completed")
                                            }
                                            let buttonOne = CancelButton(title: "OK") {
                                                
                                            }
                                            popup.addButtons([buttonOne])
                                            self.present(popup, animated: true, completion: nil)
                                        } else {
                                            let img = Barcode.fromStringV2(string: "\(rs!.qrcode)")
                                            self.updateBarcode(image: img)
                                            self.lbNumVNPAY.text = "SỐ CT MOCA: \(rs?.partnerTxID ?? "")"
                                        }
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                } else {
                                    let popup = PopupDialog(title: "Thông báo", message: "\(rs?.message ?? "Tạo QRCode thất bại!")", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        print("Completed")
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                        
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                }
                            } else {
                                let popup = PopupDialog(title: "Thông báo", message: "LOAD API ERR", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                    
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }
                        }else{
                            let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                        
                    }
                }
            }
        }
    }
    @objc func showBarcodeSmartPay() {
        if isSmartPay {
            //get promotionCode
            let rDR1 = parseXMLProduct().toBase64()
            let pROMOS = parseXMLPromotion().toBase64()
            
            if(payViewWallet.frame.size.height > 0){
                
                WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang tạo mã QRCode thanh toán...") {
                    MPOSAPIManager.mpos_FRT_SP_GetCode_QRcode_payment(RDR1: "\(rDR1)", PROMOS: "\(pROMOS)", Doctotal: "\(self.totalPayment)", type: "3", typeOrder: Cache.typeOrder1) { (promotionCode, err) in
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            if(err.count <= 0){
                                self.genQRCodeSmartPay(promotionCode: "\(promotionCode)")
                            }else{
                                let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne = CancelButton(title: "OK") { }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }

                        }
                    }
                }
            }
        }
    }
    
    @objc func showBarcodeAirPay() {
        var moneyString:String = tfWallet.text!
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        if(moneyString.isEmpty){
            moneyString = "0"
        }
        let moneyInt = Int(moneyString)
        
        if isAirPay {
            WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang tạo mã QRCode thanh toán...") {
                MPOSAPIManager.mpos_FRT_SP_GetCode_QRcode_payment_Airpay(amount: moneyInt ?? 0) { (res, error) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if error != "" && error != "null" {
                            AirpayResponse.storeLocation = ""
                            AirpayResponse.traceId = ""
                            AirpayResponse.amount = 0
                            let popup = PopupDialog(title: "Thông báo", message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            }
                            let buttonOne = CancelButton(title: "OK") { }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        } else {
                            guard let yourUrl = res?.qrcodeImageUrl, let url = URL(string: yourUrl) else {
                                print("can not get url")
                                return
                            }
                            
                            let data = try? Data(contentsOf: url)

                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                self.updateBarcode(image: image)
                                self.lbNumVNPAY.text = "Số CT ShopeePay: \(res?.orderId ?? "")"
                                self.lbcodeKMVNPAY.text = "Code KM ShopeePay: "
                                self.orderID = res?.orderId ?? ""
                                self.priceQRAirPAY = Int(res?.amount ?? 0)
                                self.detailRes = res
                                AirpayResponse.storeLocation = res?.storeLocation ?? ""
                                AirpayResponse.traceId = res?.traceId ?? ""
                                AirpayResponse.amount = res?.amount ?? 0
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    private func getQRCodeZaloPay(code:String){
        var money:String = self.tfWallet.text ?? ""
        money = money.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        money = money.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        if(money.isEmpty){
            money = "0"
        }
        let moneyInt = Int(money) ?? 0
        if moneyInt <= 0 {
            AlertManager.shared.alertWithViewController(title: "Thông báo", message: "Vui lòng điền số tiền thanh toán", titleButton: "OK", viewController: self) {
                
            }
            return
        }
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang tạo mã QRCode thanh toán...") {
            
            APIRequestZalo.request(.genQRCode(amount: moneyInt, phone: self.phone, items: self.parseXMLProduct()), ZaloGenQRCodeModel.self) { response in
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    switch response {
                    case .success(let model):
                        if model.success == 0 {
                            AlertManager.shared.alertWithViewController(title: "Thông báo", message: model.message ?? "", titleButton: "OK", viewController: self) {
                                
                            }
                            return
                        }
                        let dataDecoded : Data = Data(base64Encoded: model.qRcode ?? "", options: .ignoreUnknownCharacters)!
                        let decodedimage = UIImage(data: dataDecoded)
                        self.updateBarcode(image: decodedimage)
                        self.lbNumVNPAY.text = "Số CT ZaloPay: \(model.paymentRequestCode ?? "")"
                        self.lbcodeKMVNPAY.text = "Code KM ZaloPay: \(code)"
                        self.orderID = model.paymentRequestCode ?? ""
                        self.priceQRZaloPAY = Int(self.tfWallet.text?.replacingOccurrences(of: "[,.]", with: "", options: .literal, range: nil) ?? "0") ?? 0
                        print(self.priceQRZaloPAY)
                        self.zaloModel = model
                    case .failure(let error):
                        AlertManager.shared.alertWithViewController(title: "Thông báo", message: "Gen QRCode ZaloPay không thành công.\(error.localizedDescription)", titleButton: "OK", viewController: self) {
                            
                        }
                    }
                }
                self.lbcodeKMVNPAY.text = "Code KM ZaloPay: "
                
            }
        }
    }
    
    @objc func showBarCodeZaloPay(){
        
        if self.isZaloPay {
            
            let rDR1 = parseXMLProduct().toBase64()
            let pROMOS = parseXMLPromotion().toBase64()
            
            if(payViewWallet.frame.size.height > 0){
                
                WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang tạo mã QRCode thanh toán...") {
                    MPOSAPIManager.mpos_FRT_SP_GetCode_QRcode_payment(RDR1: "\(rDR1)", PROMOS: "\(pROMOS)", Doctotal: "\(self.totalPayment)", type: "6", typeOrder: Cache.typeOrder1) { (promotionCode, err) in
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            if(err.count <= 0){
                                self.getQRCodeZaloPay(code: promotionCode)
                            }else{
                                let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne = CancelButton(title: "OK") { }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }

                        }
                    }
                }
            }
            
        }
        
    }
	@objc func showBarcodeFoxPay() {
		if isFoxPay {

			let rDR1 = parseXMLProduct().toBase64()
			let pROMOS = parseXMLPromotion().toBase64()

			if(payViewWallet.frame.size.height > 0){

				WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang tạo mã QRCode thanh toán...") {
					MPOSAPIManager.mpos_FRT_SP_GetCode_QRcode_payment(RDR1: "\(rDR1)", PROMOS: "\(pROMOS)", Doctotal: "\(self.totalPayment)", type: "7", typeOrder: Cache.typeOrder1) { (promotionCode, err) in
						WaitingNetworkResponseAlert.DismissWaitingAlert {
							if(err.count <= 0){
								self.getQRCodeFoxPay(code: promotionCode)
							}else{
								let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
									print("Completed")
								}
								let buttonOne = CancelButton(title: "OK") { }
								popup.addButtons([buttonOne])
								self.present(popup, animated: true, completion: nil)
							}

						}
					}
				}
			}

		}
	}
    
	private func getQRCodeFoxPay(code:String) {
        var moneyString:String = tfWallet.text!
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        if(moneyString.isEmpty){
            moneyString = "0"
        }
        let moneyInt = Int(moneyString)
        
        if moneyInt ?? 0 <= 0 {
            let popup = PopupDialog(title: "Thông báo", message: "Vui lòng điền số tiền thanh toán", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) { }
            let buttonOne = CancelButton(title: "OK") { }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            
            return
        }
        
        if isFoxPay {
            WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang tạo mã QRCode thanh toán...") {
				MPOSAPIManager.mpos_FRT_SP_GetCode_QRcode_payment_Foxpay(customerCode: "\(code)", customerName: self.name, customerPhone: self.phone, address: self.address, amount: moneyInt ?? 0,promotionCode:code) { (res, error) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if error != "" && error != "null" {
                            let popup = PopupDialog(title: "Thông báo", message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            }
                            let buttonOne = CancelButton(title: "OK") { }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        } else {
                            guard let qrcode = res?.qrcode, !qrcode.isEmpty else {
                                print("can not get url")
                                return
                            }

                            let image = Barcode.fromStringV2(string: "\(qrcode)")
                            self.updateBarcode(image: image)
                            self.lbNumVNPAY.text = "Số CT FoxPay: \(res?.orderId ?? "")"
                            self.lbcodeKMVNPAY.text = "Code KM FoxPay: \(code)"
                            self.orderID = res?.orderId ?? ""
                            self.priceQRFoxPAY = Int(res?.amount ?? 0)
                            self.detailRes = res
                        }
                    }
                }
            }
        }
    }
    
    func genQRCodeSmartPay(promotionCode: String) {
        var moneyString:String = tfWallet.text!
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        if(moneyString.isEmpty){
            moneyString = "0"
        }
        debugPrint("moneyString SmartPay: \(moneyString)")
        let xmrdr1 = parseXMLProduct()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.CreateOrderForMobileSmartPay(amount:"\(moneyString)",phoneNumber:"\(self.phone)",requestType:"qrcode",xmrdr1:xmrdr1,promotionCode: promotionCode) { (rs,requestId, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if(rs != nil){
                        self.partnerTxIDSmartPay = rs!.orderNo
                        let popup = PopupDialog(title: "Thông báo", message: "\("Tạo QRCode thành công!")", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            //
                            if rs!.payload.isEmpty {
                                let popup = PopupDialog(title: "Thông báo", message: "Không lấy được QRCode!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                    
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            } else {
                                let img = Barcode.fromStringV2(string: "\(rs!.payload)")
                                self.updateBarcode(image: img)
                                self.lbNumVNPAY.text = "SỐ CT SMARTPAY: \(rs!.orderNo)"
                            }
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }else{
                        let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                    
                }
            }
        }
    }
    
    func updateBarcode(image:UIImage?){
        
        if isVNPay {
            if(image != nil){
                if(self.txnId != ""){
                    tfVoucher.isEnabled = false
                    tfDeposit.isEnabled = false
                }
                //            self.tfVoucher.isEnabled = false
                self.lbBarcode.isHidden = true
                self.barcode.frame = CGRect(x: 0, y: 0, width: self.viewBarcode.frame.size.width, height: self.viewBarcode.frame.size.width)
                self.viewBarcode.frame.size.height = self.viewBarcode.frame.size.width
                
                if(bodyViewWallet.frame.size.height == typeWalletVNPay.frame.origin.y + typeWalletVNPay.frame.size.height + Common.Size(s: 10)){
                    self.bodyViewWallet.frame.size.height = typeWalletVNPay.frame.origin.y + typeWalletVNPay.frame.size.height + Common.Size(s: 10)
                }else{
                    self.lbNumVNPAY.frame.origin.y = viewBarcode.frame.origin.y + viewBarcode.frame.size.height + Common.Size(s: 10)
                    self.lbcodeKMVNPAY.frame.origin.y = lbNumVNPAY.frame.size.height + lbNumVNPAY.frame.origin.y + Common.Size(s:10)
                    
                    self.bodyViewWallet.frame.size.height = lbcodeKMVNPAY.frame.origin.y + lbcodeKMVNPAY.frame.size.height + Common.Size(s: 10)
                }
                self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
                
                self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
                self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
                self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
                self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
                self.barcode.image = image!
            }else{
                
                //            self.tfVoucher.isEnabled = true
                //            self.lbNumVNPAY.text = "Số CT VNPAY:"
                //            self.txnId = ""
                if(self.txnId != ""){
                    tfVoucher.isEnabled = false
                    tfDeposit.isEnabled = false
                    self.lbNumVNPAY.text = "Số CT VNPAY: \(self.txnId)"
                }
                self.lbBarcode.isHidden = false
                self.barcode.frame = CGRect(x:(viewBarcode.frame.size.width - Common.Size(s: 50) )/2,y: Common.Size(s: 10) ,width:Common.Size(s: 50),height: Common.Size(s: 50))
                viewBarcode.frame.size.height = lbBarcode.frame.origin.y + lbBarcode.frame.size.height + Common.Size(s: 5)
                
                if(bodyViewWallet.frame.size.height == typeWalletVNPay.frame.origin.y + typeWalletVNPay.frame.size.height + Common.Size(s: 10)){
                    self.bodyViewWallet.frame.size.height = typeWalletVNPay.frame.origin.y + typeWalletVNPay.frame.size.height + Common.Size(s: 10)
                }else{
                    self.lbNumVNPAY.frame.origin.y = viewBarcode.frame.origin.y + viewBarcode.frame.size.height + Common.Size(s: 10)
                    self.lbcodeKMVNPAY.frame.origin.y = lbNumVNPAY.frame.origin.y + lbNumVNPAY.frame.size.height + Common.Size(s: 10)
                    
                    self.bodyViewWallet.frame.size.height = lbcodeKMVNPAY.frame.origin.y + lbcodeKMVNPAY.frame.size.height + Common.Size(s: 10)
                }
                self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
                
                self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
                self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
                self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
                self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
                self.barcode.image = UIImage(named:"qrcode")
            }
        }
        
        if isMoca {
            if(image != nil) {
                self.lbBarcodeMoca.isHidden = true
                self.barcodeMoca.frame = CGRect(x: Common.Size(s: 30), y: Common.Size(s: 30), width: self.viewBarcodeMoca.frame.size.width - Common.Size(s: 60), height: self.viewBarcodeMoca.frame.size.width - Common.Size(s: 60))
                self.viewBarcodeMoca.frame.size.height = self.viewBarcodeMoca.frame.size.width
                self.barcodeMoca.image = image!
                
                self.lbNumVNPAY.frame.origin.y = viewBarcodeMoca.frame.origin.y + viewBarcodeMoca.frame.size.height + Common.Size(s: 10)
                self.lbcodeKMVNPAY.frame.origin.y = lbNumVNPAY.frame.size.height + lbNumVNPAY.frame.origin.y + Common.Size(s: 10)
                
                self.bodyViewWallet.frame.size.height = lbcodeKMVNPAY.frame.origin.y + lbcodeKMVNPAY.frame.size.height + Common.Size(s: 10)
                self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
                self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
                self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
                self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
                self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
                
            } else {
                
                self.lbBarcodeMoca.isHidden = false
                self.barcodeMoca.frame = CGRect(x:(viewBarcodeMoca.frame.size.width - Common.Size(s: 50) )/2,y: Common.Size(s: 10) ,width:Common.Size(s: 50),height: Common.Size(s: 50))
                viewBarcodeMoca.frame.size.height = lbBarcodeMoca.frame.origin.y + lbBarcodeMoca.frame.size.height + Common.Size(s: 5)
                self.barcodeMoca.image = UIImage(named:"qrcode")
                
                self.lbNumVNPAY.frame.origin.y = viewBarcodeMoca.frame.origin.y + viewBarcodeMoca.frame.size.height + Common.Size(s: 10)
                self.lbcodeKMVNPAY.frame.origin.y = lbNumVNPAY.frame.size.height + lbNumVNPAY.frame.origin.y + Common.Size(s: 10)
                self.bodyViewWallet.frame.size.height = lbcodeKMVNPAY.frame.origin.y + lbcodeKMVNPAY.frame.size.height + Common.Size(s: 10)
                self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
                self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
                self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
                self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
                self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
            }
        }
        if isSmartPay {
            if(image != nil) {
                self.lbBarcodeSmartPay.isHidden = true
                self.barcodeSmartPay.frame = CGRect(x: Common.Size(s: 30), y: Common.Size(s: 30), width: self.viewBarcodeSmartPay.frame.size.width - Common.Size(s: 60), height: self.viewBarcodeSmartPay.frame.size.width - Common.Size(s: 60))
                self.viewBarcodeSmartPay.frame.size.height = self.viewBarcodeSmartPay.frame.size.width
                self.barcodeSmartPay.image = image!
                
                self.lbNumVNPAY.frame.origin.y = viewBarcodeSmartPay.frame.origin.y + viewBarcodeSmartPay.frame.size.height + Common.Size(s: 10)
                self.lbcodeKMVNPAY.frame.origin.y = lbNumVNPAY.frame.size.height + lbNumVNPAY.frame.origin.y + Common.Size(s: 10)
                self.bodyViewWallet.frame.size.height = lbcodeKMVNPAY.frame.origin.y + lbcodeKMVNPAY.frame.size.height + Common.Size(s: 10)
                self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
                self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
                self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
                self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
                self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
                
            } else {
                
                self.lbBarcodeSmartPay.isHidden = false
                self.barcodeSmartPay.frame = CGRect(x:(viewBarcodeSmartPay.frame.size.width - Common.Size(s: 50) )/2,y: Common.Size(s: 10) ,width:Common.Size(s: 50),height: Common.Size(s: 50))
                viewBarcodeSmartPay.frame.size.height = lbBarcodeMoca.frame.origin.y + lbBarcodeMoca.frame.size.height + Common.Size(s: 5)
                self.barcodeSmartPay.image = UIImage(named:"qrcode")
                
                self.lbNumVNPAY.frame.origin.y = viewBarcodeSmartPay.frame.origin.y + viewBarcodeSmartPay.frame.size.height + Common.Size(s: 10)
                self.lbcodeKMVNPAY.frame.origin.y = lbNumVNPAY.frame.size.height + lbNumVNPAY.frame.origin.y + Common.Size(s: 10)
                self.bodyViewWallet.frame.size.height = lbcodeKMVNPAY.frame.origin.y + lbcodeKMVNPAY.frame.size.height + Common.Size(s: 10)
                self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
                self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
                self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
                self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
                self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
            }
        }
        
        if isAirPay {
            if(image != nil) {
                self.lbBarcodeAirPay.isHidden = true
                self.barcodeAirPay.frame = CGRect(x: Common.Size(s: 30), y: Common.Size(s: 30), width: self.viewBarcodeAirPay.frame.size.width - Common.Size(s: 60), height: self.viewBarcodeAirPay.frame.size.width - Common.Size(s: 60))
                self.viewBarcodeAirPay.frame.size.height = self.viewBarcodeAirPay.frame.size.width
                self.barcodeAirPay.image = image!
                
                self.lbNumVNPAY.frame.origin.y = viewBarcodeAirPay.frame.origin.y + viewBarcodeAirPay.frame.size.height + Common.Size(s: 10)
                self.lbcodeKMVNPAY.frame.origin.y = lbNumVNPAY.frame.size.height + lbNumVNPAY.frame.origin.y + Common.Size(s: 10)
                self.bodyViewWallet.frame.size.height = lbcodeKMVNPAY.frame.origin.y + lbcodeKMVNPAY.frame.size.height + Common.Size(s: 10)
                self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
                self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
                self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
                self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
                self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
                
            } else {
                
                self.lbBarcodeAirPay.isHidden = false
                self.barcodeAirPay.frame = CGRect(x:(viewBarcodeAirPay.frame.size.width - Common.Size(s: 50) )/2,y: Common.Size(s: 10) ,width:Common.Size(s: 50),height: Common.Size(s: 50))
                viewBarcodeAirPay.frame.size.height = lbBarcodeAirPay.frame.origin.y + lbBarcodeAirPay.frame.size.height + Common.Size(s: 5)
                self.barcodeAirPay.image = UIImage(named:"qrcode")
                
                self.lbNumVNPAY.frame.origin.y = viewBarcodeAirPay.frame.origin.y + viewBarcodeAirPay.frame.size.height + Common.Size(s: 10)
                self.lbcodeKMVNPAY.frame.origin.y = lbNumVNPAY.frame.size.height + lbNumVNPAY.frame.origin.y + Common.Size(s: 10)
                self.bodyViewWallet.frame.size.height = lbcodeKMVNPAY.frame.origin.y + lbcodeKMVNPAY.frame.size.height + Common.Size(s: 10)
                self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
                self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
                self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
                self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
                self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
            }
        }
        
        if isFoxPay {
            if(image != nil) {
                self.lbBarcodeFoxPay.isHidden = true
                self.barcodeFoxPay.frame = CGRect(x: Common.Size(s: 30), y: Common.Size(s: 30), width: self.viewBarcodeFoxPay.frame.size.width - Common.Size(s: 60), height: self.viewBarcodeFoxPay.frame.size.width - Common.Size(s: 60))
                self.viewBarcodeFoxPay.frame.size.height = self.viewBarcodeFoxPay.frame.size.width
                self.barcodeFoxPay.image = image!
                
                self.lbNumVNPAY.frame.origin.y = viewBarcodeFoxPay.frame.origin.y + viewBarcodeFoxPay.frame.size.height + Common.Size(s: 10)
                self.lbcodeKMVNPAY.frame.origin.y = lbNumVNPAY.frame.size.height + lbNumVNPAY.frame.origin.y + Common.Size(s: 10)
                self.bodyViewWallet.frame.size.height = lbcodeKMVNPAY.frame.origin.y + lbcodeKMVNPAY.frame.size.height + Common.Size(s: 10)
                self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
                self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
                self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
                self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
                self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
                
            } else {
                
                self.lbBarcodeFoxPay.isHidden = false
                self.barcodeFoxPay.frame = CGRect(x:(viewBarcodeFoxPay.frame.size.width - Common.Size(s: 50) )/2,y: Common.Size(s: 10) ,width:Common.Size(s: 50),height: Common.Size(s: 50))
                viewBarcodeFoxPay.frame.size.height = lbBarcodeFoxPay.frame.origin.y + lbBarcodeFoxPay.frame.size.height + Common.Size(s: 5)
                self.barcodeFoxPay.image = UIImage(named:"qrcode")
                
                self.lbNumVNPAY.frame.origin.y = viewBarcodeFoxPay.frame.origin.y + viewBarcodeFoxPay.frame.size.height + Common.Size(s: 10)
                self.lbcodeKMVNPAY.frame.origin.y = lbNumVNPAY.frame.size.height + lbNumVNPAY.frame.origin.y + Common.Size(s: 10)
                self.bodyViewWallet.frame.size.height = lbcodeKMVNPAY.frame.origin.y + lbcodeKMVNPAY.frame.size.height + Common.Size(s: 10)
                self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
                self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
                self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
                self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
                self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
            }
        }
        
        if self.isZaloPay {
            if(image != nil) {
                self.lbBarcodeZaloPay.isHidden = true
                self.barcodeZaloPay.frame = CGRect(x: Common.Size(s: 30), y: Common.Size(s: 30), width: self.viewBarcodeZaloPay.frame.size.width - Common.Size(s: 60), height: self.viewBarcodeZaloPay.frame.size.width - Common.Size(s: 60))
                self.viewBarcodeZaloPay.frame.size.height = self.viewBarcodeZaloPay.frame.size.width
                self.barcodeZaloPay.image = image!
                
                self.lbNumVNPAY.frame.origin.y = viewBarcodeZaloPay.frame.origin.y + viewBarcodeZaloPay.frame.size.height + Common.Size(s: 10)
                self.lbcodeKMVNPAY.frame.origin.y = lbNumVNPAY.frame.size.height + lbNumVNPAY.frame.origin.y + Common.Size(s: 10)
                self.bodyViewWallet.frame.size.height = lbcodeKMVNPAY.frame.origin.y + lbcodeKMVNPAY.frame.size.height + Common.Size(s: 10)
                self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
                self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
                self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
                self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
                self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
                
            } else {
                
                self.lbBarcodeZaloPay.isHidden = false
                self.barcodeZaloPay.frame = CGRect(x:(viewBarcodeZaloPay.frame.size.width - Common.Size(s: 50) )/2,y: Common.Size(s: 10) ,width:Common.Size(s: 50),height: Common.Size(s: 50))
                viewBarcodeZaloPay.frame.size.height = lbBarcodeZaloPay.frame.origin.y + lbBarcodeZaloPay.frame.size.height + Common.Size(s: 5)
                self.barcodeZaloPay.image = UIImage(named:"qrcode")
                
                self.lbNumVNPAY.frame.origin.y = viewBarcodeZaloPay.frame.origin.y + viewBarcodeZaloPay.frame.size.height + Common.Size(s: 10)
                self.lbcodeKMVNPAY.frame.origin.y = lbNumVNPAY.frame.size.height + lbNumVNPAY.frame.origin.y + Common.Size(s: 10)
                self.bodyViewWallet.frame.size.height = lbcodeKMVNPAY.frame.origin.y + lbcodeKMVNPAY.frame.size.height + Common.Size(s: 10)
                self.payViewWallet.frame.size.height = self.bodyViewWallet.frame.size.height + self.bodyViewWallet.frame.origin.y
                self.payViewPoint.frame.origin.y = self.payViewWallet.frame.origin.y + self.payViewWallet.frame.size.height
                self.payViewVoucher.frame.origin.y = self.payViewPoint.frame.origin.y + self.payViewPoint.frame.size.height
                self.payViewDeposit.frame.origin.y = self.payViewVoucher.frame.origin.y + self.payViewVoucher.frame.size.height
                self.payView.frame.size.height = self.payViewDeposit.frame.size.height + self.payViewDeposit.frame.origin.y
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.payView.frame.size.height + self.payView.frame.origin.y + Common.Size(s: 10))
            }
        }
    }
    @objc func typeCashTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if(payViewCash.frame.size.height > 0){
            payViewCash.frame.size.height = 0
            typeCash.layer.borderWidth = 1
            typeCash.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        }else{
            payViewCash.frame.size.height = bodyViewCash.frame.size.height + bodyViewCash.frame.origin.y
            typeCash.layer.borderWidth = 2
            typeCash.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
        }
        payViewCard.frame.origin.y =  payViewCash.frame.origin.y + payViewCash.frame.size.height
        payViewWallet.frame.origin.y = payViewCard.frame.origin.y + payViewCard.frame.size.height
        payViewPoint.frame.origin.y =  payViewWallet.frame.origin.y + payViewWallet.frame.size.height
        payViewVoucher.frame.origin.y = payViewPoint.frame.origin.y + payViewPoint.frame.size.height
        payView.frame.size.height = payViewVoucher.frame.size.height + payViewVoucher.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: payView.frame.size.height + payView.frame.origin.y + Common.Size(s: 10))
        updatePrice()
    }
    @objc func typeCardTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if(payViewCard.frame.size.height > 0){
            payViewCard.frame.size.height = 0
            typeCard.layer.borderWidth = 1
            typeCard.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        }else{
            payViewCard.frame.size.height = bodyViewCard.frame.size.height + bodyViewCard.frame.origin.y
            typeCard.layer.borderWidth = 2
            typeCard.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
        }
        payViewWallet.frame.origin.y = payViewCard.frame.origin.y + payViewCard.frame.size.height
        payViewPoint.frame.origin.y =  payViewWallet.frame.origin.y + payViewWallet.frame.size.height
        payViewVoucher.frame.origin.y = payViewPoint.frame.origin.y + payViewPoint.frame.size.height
        payView.frame.size.height = payViewVoucher.frame.size.height + payViewVoucher.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: payView.frame.size.height + payView.frame.origin.y + Common.Size(s: 10))
        updatePrice()
    }
    @objc func typeWalletTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if(payViewWallet.frame.size.height > 0){
            payViewWallet.frame.size.height = 0
            typeWallet.layer.borderWidth = 1
            typeWallet.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        }else{
            payViewWallet.frame.size.height = bodyViewWallet.frame.size.height + bodyViewWallet.frame.origin.y
            typeWallet.layer.borderWidth = 2
            typeWallet.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
        }
        payViewPoint.frame.origin.y =  payViewWallet.frame.origin.y + payViewWallet.frame.size.height
        payViewVoucher.frame.origin.y = payViewPoint.frame.origin.y + payViewPoint.frame.size.height
        payView.frame.size.height = payViewVoucher.frame.size.height + payViewVoucher.frame.origin.y
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: payView.frame.size.height + payView.frame.origin.y + Common.Size(s: 10))
        updatePrice()
    }
    @objc private func textFieldDidChange(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s),\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
        }else{
            textField.text = ""
        }
        if(textField == tfWallet){
//            var moneyString:String = textField.text!
//            moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
//            if(moneyString.isEmpty){
//                moneyString = "0"
//            }
//            if let moneyInt = Int(moneyString) {
//                var money = totalTemp - moneyInt
//                if(money < 0){
//                    money = 0
//                }
//                let characters = Array("\(money)")
//                if(characters.count > 0){
//                    var str = ""
//                    var count:Int = 0
//                    for index in 0...(characters.count - 1) {
//                        let s = characters[(characters.count - 1) - index]
//                        if(count % 3 == 0 && count != 0){
//                            str = "\(s),\(str)"
//                        }else{
//                            str = "\(s)\(str)"
//                        }
//                        count = count + 1
//                    }
////                    if(payCashTemp && payCardTemp && payWalletTemp){
////                        print("CA 3")
//////                        tfCash.text = convertFormat(value: totalTemp)
//////                        tfCard.text = "0"
//////                        tfWallet.text = "0"
////                    }else if (payCashTemp && payWalletTemp){
////                        print("CASH + Wallet")
////                        tfCash.text = str
////                        tfCard.text = "0"
////                    }else if (payCardTemp && payWalletTemp){
////                        print("CARD + Wallet")
////                        tfCard.text = str
////                        tfCash.text = "0"
////                    }
//                }else{
//
//                }
//            }
            
            if isFoxPay {
                priceQRFoxPAY = 0
            }
            
            debugPrint("Done text wallet")
            self.updatePrice()
            
            
        }else if(textField == tfDeposit){
            var moneyString:String = textField.text!
            moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            if(moneyString.isEmpty){
                moneyString = "0"
            }
            if let moneyInt = Int(moneyString) {
                var money = totalTemp - moneyInt
                if(money < 0){
                    money = 0
                }
                let characters = Array("\(money)")
                if(characters.count > 0){
                    var str = ""
                    var count:Int = 0
                    for index in 0...(characters.count - 1) {
                        let s = characters[(characters.count - 1) - index]
                        if(count % 3 == 0 && count != 0){
                            str = "\(s),\(str)"
                        }else{
                            str = "\(s)\(str)"
                        }
                        count = count + 1
                    }
                    self.totalPayment = moneyInt
                    self.updatePrice()
                }else{
                    self.totalPayment = 0
                    self.updatePrice()
                }
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.tfWalletCode {
            self.tfWallet.text = "0"
            self.tfWallet.isEnabled = false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.tfWalletCode {
//            self.tfWallet.text = "0"
            self.tfWallet.isEnabled = self.tfWalletCode.text?.trim() != "" ? false : true
        }
    }
    
    @objc func payAction(_ sender:UITapGestureRecognizer){
        
        if isMoca {
            guard let moneyString = self.tfWallet.text, !moneyString.isEmpty, !(moneyString == "0") else {
                let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa nhập số tiền!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                    
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
                
                return
            }
            
            if self.tfWalletCode.text!.isEmpty {
                if barcodeMoca.image == UIImage(named: "qrcode") {
                    let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa generate qrcode Moca!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                    return
                }
            } else {
                
            }
            
            
        }
        if isSmartPay{
            guard let moneyString = self.tfWallet.text, !moneyString.isEmpty, !(moneyString == "0") else {
                let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa nhập số tiền!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                    
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
                
                return
            }
            
            if self.tfWalletCode.text!.isEmpty {
                if barcodeSmartPay.image == UIImage(named: "qrcode") {
                    let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa generate qrcode SmartPay!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                    return
                }
            } else {
                
            }
        }
        
        if isAirPay {
            if (self.lbNumVNPAY.text?.count ?? 0 < 14) {
                guard let moneyString = self.tfWallet.text, !moneyString.isEmpty, !(moneyString == "0") else {
                    let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa nhập số tiền, hoặc chứng từ AIRPAY!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                    return
                }
            }
            
            if self.tfWalletCode.text!.isEmpty {
                if barcodeAirPay.image == UIImage(named: "qrcode") {
                    let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa generate qrcode ShopeePay!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                    return
                }
            }
        }
        
        if isFoxPay {
            if (self.lbNumVNPAY.text?.count ?? 0 < 14) {
                guard let moneyString = self.tfWallet.text, !moneyString.isEmpty, !(moneyString == "0") else {
                    let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa nhập số tiền, hoặc chứng từ FOXPAY!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                    return
                }
            }
            
            if self.tfWalletCode.text!.isEmpty {
                if barcodeFoxPay.image == UIImage(named: "qrcode") {
                    let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa generate qrcode FoxPay!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                    return
                }
            }
        }
        
        if self.isZaloPay {
            if (self.lbNumVNPAY.text?.count ?? 0 < 14) {
                guard let moneyString = self.tfWallet.text, !moneyString.isEmpty, !(moneyString == "0") else {
                    let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa nhập số tiền, hoặc chứng từ ZaloPay!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                    return
                }
            }
            
            if self.tfWalletCode.text!.isEmpty {
                if self.barcodeZaloPay.image == UIImage(named: "qrcode") {
                    let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa generate qrcode ZaloPay!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                    return
                }
            }
        }
        
        var payWallet:Bool = false
        var payPoint:Bool = false
//        var payVoucher:Bool = false
        
        var xmlstringpay:String = ""
        if(bodyViewWallet != nil){
            if(bodyViewWallet.frame.size.height != typeWalletVNPay.frame.origin.y + typeWalletVNPay.frame.size.height + Common.Size(s: 10)){
                payWallet = true
            }else{
                if isVNPay {
                    typeBank = "QRCODE VNPAY"
                }
                if isMoca {
                    typeBank = "Grab_moca"
                }
                if isSmartPay {
                    typeBank = "SMART PAY"
                }
                if isAirPay {
                    typeBank = "AIR PAY"
                }
                if isFoxPay {
                    typeBank = "FOX PAY"
                }
                
                if self.isZaloPay {
                    typeBank = "Zalo PAY"
                }
                
                if !isVNPay && !isMoca && !isSmartPay && !isAirPay && !isFoxPay && !self.isZaloPay {
                    typeBank = ""
                }
                
                xmlstringpay = xmlstringpay + "<item Totalcash=\"\(totalTemp)\" Totalcardcredit=\"0\" Numcard=\"\" IDBankCard=\"\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" TotalQRCode=\"\" IDQRCode=\"\" TypeBank=\"\(typeBank)\"/>"
            }
        }else{
            if isVNPay {
                typeBank = "QRCODE VNPAY"
            }
            if isMoca {
                typeBank = "Grab_moca"
            }
            if isSmartPay {
                typeBank = "SMART PAY"
            }
            if isAirPay {
                typeBank = "AIR PAY"
            }
            if isFoxPay {
                typeBank = "FOX PAY"
            }
            
            if self.isZaloPay {
                typeBank = "Zalo PAY"
            }
            
            if !isVNPay && !isMoca && !isSmartPay && !isAirPay && !isFoxPay && !self.isZaloPay {
                typeBank = ""
            }
            
            xmlstringpay = xmlstringpay + "<item Totalcash=\"\(totalTemp)\" Totalcardcredit=\"0\" Numcard=\"\" IDBankCard=\"\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" TotalQRCode=\"\" IDQRCode=\"\" TypeBank=\"\(typeBank)\"/>"
        }
        var showErrPoint: Bool = false
        if(payViewPoint != nil){
            if(payViewPoint.frame.size.height > 0){
                payPoint = true
                for item in Cache.unconfirmationReasons {
                    if(item.ItemCode == Common.skuKHTT){
                        if(item.Discount > toshibaPoint!.FPoint){
                            showErrPoint = true
                            break
                        }
                    }
                }
            }
        }
     
        if(showErrPoint){
            Toast.init(text: "Điểm sử dụng không được lớn hơn FMoney!").show()
            return
        }

        var depositStringT  = ""
        if(tfDeposit != nil){
            depositStringT  = tfDeposit.text!
        }
        depositStringT = depositStringT.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        if(depositStringT == ""){
            depositStringT = "0"
        }
        
        var walletStringT  = ""
        if tfWallet != nil {
            walletStringT  = tfWallet.text!
        }
        walletStringT = walletStringT.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        if(walletStringT == ""){
            walletStringT = "0"
        }
        var voucherSumT:Float = 0
        if(listVoucherUse.count > 0){
            for item in listVoucherUse {
                voucherSumT = voucherSumT + item.Price
            }
        }
        if(payWallet){
            var walletString = tfWallet.text!
            walletString = walletString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            walletString = walletString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            var idQRCode = ""
            if isVNPay {
                if(txnId == ""){
                    Toast.init(text: "Bạn chưa generate qrcode!").show()
                    return
                }
                idQRCode = "\(txnId)"
                typeBank = "QRCODE VNPAY"
                if(totalTemp > 0){
                    xmlstringpay = xmlstringpay + "<item Totalcash=\"\(totalTemp - priceQRPAY)\" Totalcardcredit=\"0\" Numcard=\"\" IDBankCard=\"\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" TotalQRCode=\"\" IDQRCode=\"\" TypeBank=\"\("")\"/>"
                }
            }
            
            if isMoca {
                idQRCode = "\(self.partnerTxIDMoca)"
                typeBank = "Grab_moca"
            }
            if isSmartPay {
                idQRCode = "\(self.partnerTxIDSmartPay)"
                typeBank = "SMART PAY"
                if(totalTemp > 0){
                    xmlstringpay = xmlstringpay + "<item Totalcash=\"\(totalTemp)\" Totalcardcredit=\"0\" Numcard=\"\" IDBankCard=\"\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" TotalQRCode=\"\" IDQRCode=\"\" TypeBank=\"\("")\"/>"
                }
            }
            if isAirPay {
                idQRCode = "\(self.orderID)"
                typeBank = "AIR PAY"
                if(totalTemp > 0){
                    xmlstringpay = xmlstringpay + "<item Totalcash=\"\(totalTemp - priceQRAirPAY)\" Totalcardcredit=\"0\" Numcard=\"\" IDBankCard=\"\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" TotalQRCode=\"\" IDQRCode=\"\" TypeBank=\"\("")\"/>"
                }
            }
            if isFoxPay {
                idQRCode = "\(self.orderID)"
                typeBank = "FOX PAY"
                if(totalTemp > 0){
                    xmlstringpay = xmlstringpay + "<item Totalcash=\"\(totalTemp - priceQRFoxPAY)\" Totalcardcredit=\"0\" Numcard=\"\" IDBankCard=\"\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" TotalQRCode=\"\" IDQRCode=\"\" TypeBank=\"\("")\"/>"
                }
            }
            
            if self.isZaloPay {
                idQRCode = "\(self.orderID)"
                typeBank = "Zalo PAY"
                if(totalTemp > 0){
                    let zaloPay = Int(walletString) ?? 0
                    xmlstringpay = xmlstringpay + "<item Totalcash=\"\(totalTemp - zaloPay)\" Totalcardcredit=\"0\" Numcard=\"\" IDBankCard=\"\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" TotalQRCode=\"\" IDQRCode=\"\" TypeBank=\"\("")\"/>"
                }
            }
            
            if !isVNPay && !isMoca && !isSmartPay && !isAirPay && !isFoxPay && !self.isZaloPay {
                idQRCode = ""
                typeBank = ""
            }
            ////-------------
            if(walletString.count > 0){
                xmlstringpay = xmlstringpay + "<item Totalcash=\"\" Totalcardcredit=\"0\" Numcard=\"\" IDBankCard=\"\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" TotalQRCode=\"\(walletString)\" IDQRCode=\"\(idQRCode)\" TypeBank=\"\(typeBank)\"/>"
            }else{
                Toast.init(text: "Tiền thanh toán ví không được để trống!").show()
                return
            }
            
        }
        if(listVoucherUse.count > 0){
            if isVNPay {
                typeBank = "QRCODE VNPAY"
            }
            if isMoca {
                typeBank = "Grab_moca"
            }
            if isSmartPay {
                typeBank = "SMART PAY"
            }
            if isAirPay {
                typeBank = "AIR PAY"
            }
            if isFoxPay {
                typeBank = "FOX PAY"
            }
            
            if isZaloPay {
                typeBank = "Zalo PAY"
            }
            
            if !isVNPay && !isMoca && !isSmartPay && !isAirPay && !isFoxPay && !self.isZaloPay {
                typeBank = ""
            }
            
            for item in listVoucherUse{
                xmlstringpay = xmlstringpay + "<item Totalcash=\"0\" Totalcardcredit=\"0\" Numcard=\"\" IDBankCard=\"\" Numvoucher=\"\(item.VC_code)\" TotalVoucher=\"\(item.Price.cleanValue)\" Namevoucher=\"\(item.TenVC)\" TotalQRCode=\"\" IDQRCode=\"\" TypeBank=\"\(typeBank)\"/>"
            }
        }
        if(payPoint){
            let otp = tfOTP.text!
            if(otp.count > 0){
                let newViewController = LoadingViewController()
                newViewController.content = "Đang kiểm tra OTP..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                MPOSAPIManager.mpos_verify_maxacthuc_point(sdt: phone, MaXacThuc: "\(otp)", handler: { (success, error) in
                    if(error.count <= 0){
                        if self.isMoca {
                            self.checkMoca(xmlPay: xmlstringpay)
                        } else if self.isSmartPay{
                            self.rcheckSmartPay(xmlPay: xmlstringpay)
                        } else if self.isAirPay {
                            self.checkQRAirpay(xmlString: xmlstringpay)
                        } else if self.isFoxPay {
                            self.checkQRFoxpay(xmlString: xmlstringpay)
                        } else if self.isZaloPay {
                            self.checkTransactionZaloPay(xmlPay: xmlstringpay)
                        } else {
                            self.saveOrder(xmlPay:xmlstringpay)
                        }
                    }else{
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            let popup = PopupDialog(title: "Thông báo", message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }
                })
            }else{
                Toast.init(text: "Bạn phải nhập OTP gửi về SĐT khách hàng!").show()
                return
            }
        }else{
            debugPrint("xmlstringpay: \(xmlstringpay)")
//            self.saveOrder(xmlPay:xmlstringpay)
            if(payWallet) {
                if isVNPay {
                    if txnId != "" {
                        let newViewController = LoadingViewController()
                        newViewController.content = "Đang kiểm tra chứng từ..."
                        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                        self.navigationController?.present(newViewController, animated: true, completion: nil)
                        let nc = NotificationCenter.default
                        MPOSAPIManager.checkTransactionQR(transactionQR: "\(txnId)") { (result, err) in
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                if(!result.isEmpty){
                                    self.saveOrder(xmlPay:xmlstringpay)
                                }else{
                                    let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        print("Completed")
                                    }
                                    let buttonOne = CancelButton(title: "OK") {
                                        
                                    }
                                    popup.addButtons([buttonOne])
                                    self.present(popup, animated: true, completion: nil)
                                }
                            }
                        }
                    } else {
                        self.saveOrder(xmlPay:xmlstringpay)
                    }
                } else {
                    if isMoca {
                        self.checkMoca(xmlPay: xmlstringpay)
                    } else if isSmartPay {
                        self.rcheckSmartPay(xmlPay: xmlstringpay)
                    } else if isAirPay {
                        self.checkQRAirpay(xmlString: xmlstringpay)
                    } else if isFoxPay {
                        self.checkQRFoxpay(xmlString: xmlstringpay)
                    }else if self.isZaloPay {
                        self.checkTransactionZaloPay(xmlPay: xmlstringpay)
                    } else {
                        self.saveOrder(xmlPay:xmlstringpay)
                    }
                }
            }else{
                self.saveOrder(xmlPay:xmlstringpay)
            }
            
        }
    }
    
    private func checkTransactionZaloPay(xmlPay:String){
        APIRequestZalo.request(.checkTransaction(paymentRequestCode: self.tfWalletCode.text ?? "" == "" ? self.zaloModel?.paymentRequestCode ?? "" : self.tfWalletCode.text ?? ""), ZaloGenQRCodeModel.self) { response in
            switch response {
            case.success(let model):
                if model.success == 0 {
                    AlertManager.shared.alertWithViewController(title: "Thông báo", message: model.message ?? "", titleButton: "OK", viewController: self) {
                    }
                }else {
                    self.saveOrder(xmlPay: xmlPay)
                }
            case .failure(let error):
                AlertManager.shared.alertWithViewController(title: "Thông báo", message: "Kiểm tra giao dịch ZaloPay thất bại.\(error.localizedDescription)", titleButton: "OK", viewController: self) {
                }
            }
            
        }
    }
    
    func saveOrder(xmlPay:String){
        let xmlPayFinal = "<line>\(xmlPay)</line>".toBase64()
        let rDR1 = parseXMLProduct().toBase64()
        let pROMOS = parseXMLPromotion().toBase64()
        let xmlspGiamGiaTay = parseXMLUnconfirmationReasons().toBase64()
        let xmlVoucherDH = parseXMLVoucher().toBase64()
        let xml_url_pk = parseXML_URL_PK().toBase64()
        var myStringDate:String = ""
        if(birthday != ""){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.date(from: birthday)!
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            myStringDate  = formatter.string(from: date)
        }
        var soHDtragop:String = ""
        var kyhan:String = ""
        var CMND:String = ""
        var MaCty:String = ""
        if let debitCustomer = debitCustomer {
            soHDtragop = "\(debitCustomer.ContractNo_AgreementNo)"
            kyhan = "\(debitCustomer.TenureOfLoan)"
            CMND = "\(debitCustomer.CustomerIdCard)"
            MaCty = "\(debitCustomer.MaCty)"
            valueInterestRate = debitCustomer.Interestrate
            valuePrepay = debitCustomer.DownPaymentAmount
        }
        
        var docType:String = "01"
        switch self.type {
        case "1":
            docType = "01"
        case "2":
            docType = "02"
        case "3":
            docType = "05"
        case "4":
            docType = "06"
        default:
            docType = "01"
        }
        
        ProgressView.shared.show("Đang lưu đơn hàng...")
        MPOSAPIManager.saveOrder(phone: phone, cardName: name, doctype: docType, u_EplCod: "\(Cache.user!.UserName)", shopCode: "\(Cache.user!.ShopCode)", payments: payment, mail: email, address: address, u_des: note, rDR1: rDR1, pROMOS: pROMOS,LoaiTraGop:"\(orderPayInstallment)",LaiSuat:valueInterestRate,SoTienTraTruoc:valuePrepay,voucher: Cache.voucher,gender: "\(gender)",birthday:myStringDate, soHDtragop: soHDtragop, kyhan: kyhan, CMND: CMND, TenCTyTraGop: MaCty,is_KHRotTG:Cache.is_KHRotTG, xmlspGiamGiaTay: xmlspGiamGiaTay, xmlstringpay: xmlPayFinal, xmlVoucherDH: xmlVoucherDH,xml_url_pk: xml_url_pk,is_DH_DuAn:self.is_DH_DuAn,is_sale_MDMH: Cache.is_sale_MDMH,is_sale_software:Cache.is_sale_software) { [weak self](returnCode, docentry,So_HD, path, returnMessage) in
            ProgressView.shared.hide()
            guard let self = self else {return}
            
            if (returnCode == 0){
                Cache.itemsPromotion = []
                Cache.carts = []
                Cache.phone = ""
                Cache.name = ""
                Cache.code = 0
                Cache.address = ""
                Cache.email = ""
                Cache.orderPayType = -1
                Cache.orderPayInstallment = -1
                Cache.valueInterestRate = 0
                Cache.valuePrepay = 0
                Cache.orderType = -1
                Cache.vlInterestRate = ""
                Cache.vlPrepay = ""
                Cache.docEntry = "\(docentry)"
                Cache.voucher = ""
                Cache.genderType = -1
                Cache.vlBirthday = ""
                Cache.debitCustomer = nil
                Cache.DocEntryEcomCache = 0
                Cache.is_KHRotTG = 0
                Cache.phoneNumberBookSim = ""
                Cache.listVoucherNoPrice = []
                let keychain = KeychainSwift()
                keychain.set("", forKey: "list_VC")
                Cache.unconfirmationReasons = []
                //                    let currentDateTime = Date()
                //                    let formatter = DateFormatter()
                //                    formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                //                    let someDateTime = formatter.string(from: currentDateTime)
                Cache.is_DH_DuAn = "N"
                Cache.is_sale_MDMH = ""
                Cache.is_sale_software = ""
                Cache.codePayment = 0
                Cache.type_so = 0
                Cache.payOnlineEcom = 0
                
                let popup = PopupDialog(title: "Thông báo", message: returnMessage, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                }
                let buttonOne = CancelButton(title: "OK") {
                    if(self.isBookSim == true){
                        let newViewController = DanhSachSimBookV2GioHangViewController()
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }else{
                        if path.isEmpty {
                            self.backToRoot()
                        } else {
                            NotificationCenter.default.addObserver(self, selector: #selector(self.backToRoot), name: NSNotification.Name.init("didClosePopUpWebview"), object: nil)
                            let myVC = PopUpWebview()
                            myVC.path = path
                            let navController = UINavigationController(rootViewController: myVC)
                            self.navigationController?.presentationController?.delegate = self
                            self.navigationController?.present(navController, animated:false, completion: nil)
                        }
                    }
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }else if(returnCode == 5){
                let popup = PopupDialog(title: "Thông báo", message: returnMessage, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                    
                }
                let buttonTwo = DefaultButton(title: "Kiểm tra GD") {
                    if self.isVNPay {
                        self.reCheckVNPAY(xmlPay: xmlPay)
                    }
                    if self.isMoca {
                        self.checkMoca(xmlPay: xmlPay)
                    }
                    if self.isSmartPay {
                        self.rcheckSmartPay(xmlPay: xmlPay)
                    }
                }
                popup.addButtons([buttonOne,buttonTwo])
                self.present(popup, animated: true, completion: nil)
            }else{
                Toast(text: returnMessage).show()
                self.buttonSaveAction = false
            }
        }
    }
    
    @objc private func backToRoot() {
        _ = self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkQRAirpay(xmlString: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.CheckStatusAirPay(orderId: self.orderID) { (response, error) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if error != "" {
                        let popup = PopupDialog(title: "Thông báo", message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        }
                        let buttonOne = CancelButton(title: "OK") { }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    } else {
                        self.saveOrder(xmlPay: xmlString)
                    }
                }
            }
        }
    }
    
    func checkQRFoxpay(xmlString: String) {
        ProgressView.shared.show()
        MPOSAPIManager.CheckStatusFoxPay(orderId: self.orderID) { (response, error) in
            ProgressView.shared.hide()
            if error != "" {
                let popup = PopupDialog(title: "Thông báo", message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                }
                let buttonOne = CancelButton(title: "OK") { }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            } else {
                self.saveOrder(xmlPay: xmlString)
            }
        }
    }
    
    func reCheckVNPAY(xmlPay:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lưu đơn hàng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.checkTransactionQR(transactionQR: "\(txnId)") { (result, err) in
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(!result.isEmpty){
                    self.saveOrder(xmlPay:xmlPay)
                }else{
                    let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    let buttonTwo = DefaultButton(title: "Kiểm tra GD") {
                        self.reCheckVNPAY(xmlPay:xmlPay)
                    }
                    popup.addButtons([buttonOne,buttonTwo])
                    self.present(popup, animated: true, completion: nil)
                }
            }
        }
    }
    
    func checkMoca(xmlPay:String) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Moca_Inquiry(partnerTxID: self.partnerTxIDMoca) { (rs, err) in
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs != nil {
                            if rs?.code == "00" {
                                var msgStatus = ""
                                if rs?.status == "success" {
                                    
                                    self.saveOrder(xmlPay:xmlPay)
//                                    msgStatus = "Transaction was successful!"
//
//                                    let popup = PopupDialog(title: "Thông báo", message: "\(msgStatus)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
//                                        print("Completed")
//                                    }
//                                    let buttonOne = CancelButton(title: "OK") {
//                                        self.saveOrder(xmlPay:xmlPay)
//                                    }
//                                    popup.addButtons([buttonOne])
//                                    self.present(popup, animated: true, completion: nil)
                                    
                                } else {
                                    if rs?.status == "failed" {
                                        msgStatus = "Transaction was declined!"
                                    } else if rs?.status == "unknown" {
                                        msgStatus = "Transaction was processing!"
                                    } else if rs?.status == "pending" {
                                        msgStatus = "Transaction was processing!"
                                    } else if rs?.status == "bad-debt" {
                                        msgStatus = "Transaction was merchant!"
                                    } else {
                                        msgStatus = "\(rs?.message ?? "Truy vấn kết quả Thanh toán GRAB MOCA thất bại!")"
                                    }
                                    
                                    let popup = PopupDialog(title: "Thông báo", message: "\(msgStatus)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                        print("Completed")
                                    }
                                    let buttonOne = CancelButton(title: "OK") {

                                    }
                                    let buttonTwo = DefaultButton(title: "Kiểm tra GD") {
                                        self.checkMoca(xmlPay: xmlPay)
                                    }
                                    popup.addButtons([buttonOne, buttonTwo])
                                    self.present(popup, animated: true, completion: nil)
                                }
                                
                            } else {
                                
                                let popup = PopupDialog(title: "Thông báo", message: "\(rs?.message ?? "Truy vấn kết quả Thanh toán GRAB MOCA thất bại!")", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne = CancelButton(title: "OK") {

                                }
                                let buttonTwo = DefaultButton(title: "Kiểm tra GD") {
                                    self.checkMoca(xmlPay: xmlPay)
                                }
                                popup.addButtons([buttonOne, buttonTwo])
                                self.present(popup, animated: true, completion: nil)
                            }
                        } else {
                            let popup = PopupDialog(title: "Thông báo", message: "LOAD API ERR", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    } else {
                        let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }

                }
            }
        }
    }
    func rcheckSmartPay(xmlPay:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lưu đơn hàng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.QueryOrderSmartPay(orderNo: "\(self.partnerTxIDSmartPay)") { (result,requestId, err) in
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    if(result!.status == "PAYED"){
                        self.saveOrder(xmlPay:xmlPay)
                    }else{
                        let popup = PopupDialog(title: "Thông báo", message: "\(result!.status) - Check chứng từ smartpay thất bại !", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                        }
                        let buttonTwo = DefaultButton(title: "Kiểm tra GD") {
                            self.rcheckSmartPay(xmlPay:xmlPay)
                        }
                        popup.addButtons([buttonOne,buttonTwo])
                        self.present(popup, animated: true, completion: nil)
                    }
                  
                }else{
                    let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    let buttonTwo = DefaultButton(title: "Kiểm tra GD") {
                        self.rcheckSmartPay(xmlPay:xmlPay)
                    }
                    popup.addButtons([buttonOne,buttonTwo])
                    self.present(popup, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    func parseXMLProduct()->String{
        var rs:String = "<line>"
        for item in Cache.carts {
            if(item.sku == "00503355"){
            
                self.isBookSim = true
            }
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
            
            var whsCode = item.whsCode
            if(whsCode.isEmpty){
                whsCode = "\(Cache.user!.ShopCode)010"
            }
            var phoneN = ""
            if(item.sku == "00503355"){
                phoneN = Cache.phoneNumberBookSim
            }
//            rs = rs + "<item PhoneNumber=\"\(phoneN)\" U_ItmCod=\"\(item.product.sku)\" U_Imei=\"\(item.imei)\" U_Quantity=\"\(item.quantity)\"  U_Price=\"\(String(format: "%.6f", item.product.price))\" U_WhsCod=\"\(whsCode)\" U_ItmName=\"\(name)\"/>"
            rs = rs + "<item PhoneNumber=\"\(phoneN)\" U_ItmCod=\"\(item.sku)\" U_Imei=\"\(item.imei)\" U_Quantity=\"\(item.quantity)\"  U_Price=\"\(String(format: "%.6f", item.product.price))\" U_WhsCod=\"\(whsCode)\" U_ItmName=\"\(name)\" Warr_imei=\"\(item.Warr_imei)\"/>"
            
            
//            var totalPay:Float = 0.0
//            var discountPay:Float = 0.0
//            var priceProduct:Float = 0.0
//            for it in self.itemsPromotion{
//                if (it.TienGiam > 0 && item.product.sku == it.SanPham_Mua){
//                    discountPay = discountPay + it.TienGiam
//                }
//            }
//            discountPay = discountPay +  Float(item.discount)
//
//            if((item.product.price != item.product.priceBeforeTax) || item.product.sku == Common.skuKHTT){
//                let sum = ((item.product.priceBeforeTax * Float(item.quantity)) - discountPay)
//                totalPay = (sum * 1.1)
//                priceProduct = ((item.product.priceBeforeTax - (discountPay / Float(item.quantity))) * 1.1)
//            }else{
//                totalPay = ((item.product.priceBeforeTax * Float(item.quantity)) - discountPay)
//                priceProduct = ((item.product.priceBeforeTax - (discountPay / Float(item.quantity))))
//            }
        }
        rs = rs + "</line>"
        print(rs)
        
        return rs
    }
    func parseXMLPromotion()->String{
        var rs:String = "<line>"
        for item in Cache.itemsPromotion {
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
            
            if(item.imei == "N/A"){
                item.imei = ""
            }
            
            item.imei = item.imei.replace(target: "&", withString:"&#38;")
            item.imei = item.imei.replace(target: "<", withString:"&#60;")
            item.imei = item.imei.replace(target: ">", withString:"&#62;")
            item.imei = item.imei.replace(target: "\"", withString:"&#34;")
            item.imei = item.imei.replace(target: "'", withString:"&#39;")
            
            rs = rs + "<item SanPham_Mua=\"\(item.SanPham_Mua)\" TienGiam=\"\(String(format: "%.6f", item.TienGiam))\" LoaiKM=\"\(item.Loai_KM)\" SanPham_Tang=\"\(item.SanPham_Tang)\" TenSanPham_Tang=\"\(tenSanPham_Tang)\" SL_Tang=\"\(item.SL_Tang)\" Nhom=\"\(item.Nhom)\" MaCTKM=\"\(item.MaCTKM)\" TenCTKM=\"\(tenCTKM)\" SLThayThe=\"\(item.SL_ThayThe)\" MenhGia_VC=\"\(item.MenhGia_VC)\" VC_used=\"\(item.VC_used)\" KhoTang=\"\(item.KhoTang)\" is_imei=\"\(item.is_imei)\" imei=\"\(item.imei)\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    func parseXMLUnconfirmationReasons()->String{
        var rs:String = "<line>"
        for item in Cache.unconfirmationReasons {
            rs = rs + "<item U_ItmCod=\"\(item.ItemCode)\" U_Imei=\"\(item.imei)\" issucess=\"\(item.issuccess)\" userapprove=\"\(item.userapprove)\" Discount=\"\(item.Discount)\" Lydo_giamgia=\"\(item.Lydo_giamgia)\" note=\"\(item.Note)\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    func parseXMLVoucher(totalCash:Double, totalCard:Double)->String{
        var rs:String = "<line>"
        for item in listVoucherUse {
            var name = item.TenVC
            name = name.replace(target: "&", withString:"&#38;")
            name = name.replace(target: "<", withString:"&#60;")
            name = name.replace(target: ">", withString:"&#62;")
            name = name.replace(target: "\"", withString:"&#34;")
            name = name.replace(target: "'", withString:"&#39;")
            
            var num  = item.VC_code
            num = num.replace(target: "&", withString:"&#38;")
            num = num.replace(target: "<", withString:"&#60;")
            num = num.replace(target: ">", withString:"&#62;")
            num = num.replace(target: "\"", withString:"&#34;")
            num = num.replace(target: "'", withString:"&#39;")
            
            var sPrice  = "\(item.Price.rounded(.awayFromZero).cleanValue)"
            sPrice = sPrice.replace(target: "&", withString:"&#38;")
            sPrice = sPrice.replace(target: "<", withString:"&#60;")
            sPrice = sPrice.replace(target: ">", withString:"&#62;")
            sPrice = sPrice.replace(target: "\"", withString:"&#34;")
            sPrice = sPrice.replace(target: "'", withString:"&#39;")
            
            rs = rs + "<item Totalcash=\"\(0)\" Totalcardcredit=\"\(0)\" Numcard=\"\" Numvoucher=\"\(num)\" TotalVoucher=\"\(sPrice)\" Namevoucher=\"\(name)\"/>"
        }
        if(totalCash > 0){
            rs = rs + "<item Totalcash=\"\(totalCash)\" Totalcardcredit=\"\(0)\" Numcard=\"\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\"/>"
        }
        if(totalCard > 0){
            rs = rs + "<item Totalcash=\"\(0)\" Totalcardcredit=\"\(totalCard)\" Numcard=\"\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    func parseXMLVoucher()->String{
        var rs:String = "<line>"
        for item in self.listVoucher {
            rs = rs + "<item VC_code=\"\(item.VC_code)\" VC_Name=\"\(item.VC_Name)\" is_used=\"\(item.is_used)\" loai_VC=\"\(item.loai_VC)\" GiaTriVC=\"\(item.GiaTriVC.rounded(.awayFromZero).cleanValue)\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    func parseXML_URL_PK()->String{
        var rs:String = "<line>"
        for item in Cache.carts {
            if item.listURLImg.count > 0 {
                for i in item.listURLImg {
                    rs = rs + "<item itemcode =\"\(item.sku)\" link=\"\(i)\"/>"
                }
            }
            
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    @objc func getOTP(_ sender:UITapGestureRecognizer){
        MPOSAPIManager.FRT_SP_GetSMS_loyaty(SDT: "\(phone)") { (success, err) in
            if(success == 1){
                let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
                    
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }else{
                let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    print("Completed")
                }
                let buttonOne = CancelButton(title: "OK") {
  
                }
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }
        }
    }
    @objc func checkVoucher(_ sender:UITapGestureRecognizer){
        tfVoucher.resignFirstResponder()
        var voucher:String = tfVoucher.text!
        voucher = voucher.uppercased().trim()
        if(!voucher.isEmpty){
            self.verifyVoucher(code: voucher, index: 0, isMore: true)
        }
    }
    func verifyVoucher(code:String,index:Int,isMore:Bool){
        
        for item in self.listVoucherUse {
            if(item.VC_code == "\(code)"){
                Toast(text: "Voucher \(code) bị trùng!").show()
                return
            }
        }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra voucher..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        let basexml_list_detail_SO = parseXMLProductVerifyVoucher().toBase64()
        let basexml_list_VC_added = parseXMLVoucherUse().toBase64()
        MPOSAPIManager.mpos_sp_verify_VC_mpos_innovation(sdt: "\(self.phone)", doctypeSO: "\(self.type)", tmonbi: "\(self.totalPayment)", basexml_list_VC_added: "\(basexml_list_VC_added)", basexml_list_detail_SO: "\(basexml_list_detail_SO)", vC_code: "\((code))", handler: { (results, err) in
            print("Voucher \(results)")
            
           
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                 nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results.count > 0){
                        self.listVoucherUse.append(results[0])
                        if(isMore){
                            self.listVoucher.append(GenVoucher(GiaTriVC: results[0].Price, VC_Name: results[0].TenVC, VC_code: results[0].VC_code, is_used: 1, loai_VC: "M_S", isSelect: true, isVerify: true))
                        }else{
                            let voucher = self.listVoucher[index]
                            voucher.isSelect = true
                        }
                        self.updateUIVoucher()
                    }else{
                        let popup = PopupDialog(title: "Thông báo", message: "Voucher không thuộc phạm vi sử dung hoặc seri không hợp lệ!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            if(!isMore){
                                let voucher = self.listVoucher[index]
                                voucher.isSelect = false
                               self.updateUIVoucher()
                            }
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }else{
                    let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        if(!isMore){
                            let voucher = self.listVoucher[index]
                            voucher.isSelect = false
                            self.updateUIVoucher()
                        }
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
            }
        })
    }
    func updateUIVoucher(){
        listRadioVoucher.removeAll()
        self.tfVoucher.text = ""
        self.listVoucherView.subviews.forEach { $0.removeFromSuperview() }
        if(listVoucher.count > 0){
            listVoucherView.frame.origin.y = Common.Size(s: 10)
            var yValue:CGFloat = 0
            var stt:Int = 1
            for item in listVoucher {
                let voucher = UIView()
                voucher.frame = CGRect(x: Common.Size(s: 15), y: yValue, width: listVoucherView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 30))
                voucher.backgroundColor = UIColor.white
                listVoucherView.addSubview(voucher)
                
                let radioPayNow = createRadioButtonPayType(CGRect(x: 0,y:0 , width: voucher.frame.size.height, height: voucher.frame.size.height), title: "", color: UIColor.black);
                voucher.addSubview(radioPayNow)
                
                if(item.isSelect){
                    radioPayNow.isSelected = true
                }
                if(item.is_used == 0 && item.loai_VC == "Y"){
                    radioPayNow.isSelected = true
                }
                //0 Y cho chon
                if(item.is_used == 1 && item.loai_VC != "M_S"){
                    radioPayNow.isSelected = false
                }
                if(item.isVerify == false){
                    radioPayNow.isSelected = false
                }
         
                radioPayNow.tag = stt - 1
                listRadioVoucher.append(radioPayNow)
                let line = UIView()
                line.frame = CGRect(x: radioPayNow.frame.origin.x + radioPayNow.frame.size.width, y: 0, width: 1, height: voucher.frame.size.height)
                line.backgroundColor = UIColor.white
                voucher.addSubview(line)
                
                let lbVoucher = UILabel(frame: CGRect(x: line.frame.origin.x + line.frame.size.width, y: 0, width: (voucher.frame.size.width - (voucher.frame.size.height * 2))/2 - Common.Size(s: 5), height: voucher.frame.size.height))
                if(item.is_used == 2){
                    //hide voucher
                    lbVoucher.text = "\(item.VC_code.maxLength(length: 4))....."
                    radioPayNow.isUserInteractionEnabled = false
                }else{
                    lbVoucher.text = "\(item.VC_code)"
                }
                lbVoucher.textColor = UIColor.black
                lbVoucher.textAlignment = .left
                lbVoucher.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
                voucher.addSubview(lbVoucher)
                
                let lbPrice = UILabel(frame: CGRect(x: lbVoucher.frame.origin.x + lbVoucher.frame.size.width, y: 0, width: (voucher.frame.size.width - (voucher.frame.size.height * 2))/2 - Common.Size(s: 10), height: voucher.frame.size.height))
                lbPrice.text = "\(Common.convertCurrencyFloat(value: item.GiaTriVC))"
                lbPrice.textColor = UIColor.red
                lbPrice.textAlignment = .right
                lbPrice.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
                voucher.addSubview(lbPrice)
                
                var iconDelete = UIImageView()
                iconDelete = UIImageView(frame: CGRect(x: lbPrice.frame.origin.x + lbPrice.frame.size.width + Common.Size(s: 10), y: voucher.frame.size.height/2 - (voucher.frame.size.height * 2/3)/2, width: voucher.frame.size.height, height: voucher.frame.size.height * 2/3))
                iconDelete.contentMode = .scaleAspectFit
                iconDelete.image = #imageLiteral(resourceName: "delete_red")
                voucher.addSubview(iconDelete)
                iconDelete.tag = stt - 1
                let tapDetete = UITapGestureRecognizer(target: self, action: #selector(deleteTapped(tapGestureRecognizer:)))
                iconDelete.isUserInteractionEnabled = true
                iconDelete.addGestureRecognizer(tapDetete)
                
                yValue = yValue + voucher.frame.size.height + 1
                stt = stt + 1
            }
            listVoucherView.frame.size.height = yValue
            boxVoucherView.frame.origin.y = listVoucherView.frame.size.height + listVoucherView.frame.origin.y + Common.Size(s: 10)
            bodyViewVoucher.frame.size.height = boxVoucherView.frame.size.height + boxVoucherView.frame.origin.y + Common.Size(s: 10)
            payViewVoucher.frame.size.height = bodyViewVoucher.frame.size.height + bodyViewVoucher.frame.origin.y
            payViewDeposit.frame.origin.y = payViewVoucher.frame.size.height + payViewVoucher.frame.origin.y
            payView.frame.size.height = payViewDeposit.frame.size.height + payViewDeposit.frame.origin.y
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: payView.frame.size.height + payView.frame.origin.y + Common.Size(s: 10))
            updatePrice()
        }else{
            listVoucherView.frame.origin.y = 0
            listVoucherView.frame.size.height = 0
            boxVoucherView.frame.origin.y = listVoucherView.frame.size.height + listVoucherView.frame.origin.y + Common.Size(s: 10)
            bodyViewVoucher.frame.size.height = boxVoucherView.frame.size.height + boxVoucherView.frame.origin.y + Common.Size(s: 10)
            payViewVoucher.frame.size.height = bodyViewVoucher.frame.size.height + bodyViewVoucher.frame.origin.y
            payViewDeposit.frame.origin.y = payViewVoucher.frame.size.height + payViewVoucher.frame.origin.y
            payView.frame.size.height = payViewDeposit.frame.size.height + payViewDeposit.frame.origin.y
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: payView.frame.size.height + payView.frame.origin.y + Common.Size(s: 10))
            updatePrice()
        }
    }

    fileprivate func createRadioButtonPayType(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center;
        radioButton.addTarget(self, action: #selector(PayViewControllerV2.logSelectedButtonPayType), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonPayType(_ radioButton : DLRadioButton) {
        var idx = -1
        let voucher = listVoucher[radioButton.tag]
        for i in 0..<listVoucherUse.count{
            if(voucher.VC_code == listVoucherUse[i].VC_code){
                idx = i
                break
            }
        }
        if(idx != -1){
            listVoucherUse.remove(at: idx)
            listVoucher[radioButton.tag].isSelect = false
            updateUIVoucher()
        }else{
            verifyVoucher(code:voucher.VC_code,index:radioButton.tag,isMore: false)
        }
    }
    @objc func deleteTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let pos: Int = tappedImage.tag
        var idx = -1
        let voucher = listVoucher[pos]
        for i in 0..<listVoucherUse.count{
            if(voucher.VC_code == listVoucherUse[i].VC_code){
                idx = i
                break
            }
        }
        if(listVoucherUse.count > 0){
            listVoucherUse.remove(at: idx)
        }

        listVoucher.remove(at: pos)
        updateUIVoucher()
    }
    func parseXMLProductVerifyVoucher()->String{
        var rs:String = "<line>"
        for item in Cache.carts {
            var totalPay:Float = 0.0
            var discountPay:Float = 0.0
            for it in self.itemsPromotion{
                if (it.TienGiam > 0 && item.product.sku == it.SanPham_Mua){
                    discountPay = discountPay + it.TienGiam
                }
            }
            let sum = ((item.product.price * Float(item.quantity)) - Float(item.discount))
            totalPay = totalPay + (sum - discountPay).rounded(.toNearestOrAwayFromZero)
            rs = rs + "<item ItemCode=\"\(item.product.sku)\" U_TMoney=\"\("\(String(format:"%.6f", totalPay))")\"/>"
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
    func parseXMLVoucherUse()->String{
        var rs:String = "<line>"
        for item in self.listVoucher {
            //            if(item.loai_VC != "M_S"){
            rs = rs + "<item VC_Code=\"\(item.VC_code)\" Price=\"\(item.GiaTriVC.cleanValue)\"/>"
            //            }
        }
        rs = rs + "</line>"
        print(rs)
        return rs
    }
}

