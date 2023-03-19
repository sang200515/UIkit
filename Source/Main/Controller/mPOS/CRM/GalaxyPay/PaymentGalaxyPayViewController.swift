//
//  PaymentGalaxyPayViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 9/17/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Toaster
import PopupDialog
class PaymentGalaxyPayViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewPayment:UIView!
    private let viewFooter: UIView = {
         let viewFooter = UIView()
     
   
         return viewFooter
     }()
    private var imgTienMat:UIImageView!
    private var imgThe:UIImageView!
    private var isThe = false
    private var isTienMat = true
    private var tfCash:UITextField!
    private var tfCard:UITextField!
    private var lblFeeValue:UILabel!
    private var phiCatheAmount:Double = 0
    private var lbSoTienThanhToanValue:UILabel!
    var itemThe:CardTypeFromPOSResult?
    var itemOffer: GalaxyPlayOffer?
    var itemGoiCuocGalaxy:InfoCustomerGalaxyPlay?
    private var lbTitleCard:UILabel!
    private var lbTitleCash:UILabel!
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.title = "Thanh toán"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
        
        view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        
        
        let label = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label.text = "HÌNH THỨC THANH TOÁN"
        label.textColor = UIColor(netHex:0x00955E)
        label.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        view.addSubview(label)
        
        viewPayment = UIView(frame: CGRect(x: 0, y: label.frame.size.height + label.frame.origin.y, width: view.frame.size.width, height: view.frame.size.height))
        viewPayment.backgroundColor = .white
        view.addSubview(viewPayment)
        
        imgTienMat = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s:10), width: Common.Size(s: 20), height: Common.Size(s: 20)))
        imgTienMat.image = #imageLiteral(resourceName: "check-1")
        imgTienMat.contentMode = .scaleAspectFit
        imgTienMat.tag = 1
        viewPayment.addSubview(imgTienMat)
        
        let tapTienMat = UITapGestureRecognizer(target: self, action: #selector(chooseTypePayment(sender:)))
        imgTienMat.isUserInteractionEnabled = true
        imgTienMat.addGestureRecognizer(tapTienMat)
        
        let lbTienMatCheck = UILabel(frame: CGRect(x: imgTienMat.frame.origin.x + imgTienMat.frame.width + Common.Size(s: 5), y: imgTienMat.frame.origin.y, width: (viewPayment.frame.size.width/2) - Common.Size(s: 35), height: Common.Size(s: 20)))
        lbTienMatCheck.text = "Tiền mặt"
        lbTienMatCheck.textColor = UIColor.black
        lbTienMatCheck.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewPayment.addSubview(lbTienMatCheck)
        
        imgThe = UIImageView(frame: CGRect(x: lbTienMatCheck.frame.origin.x + lbTienMatCheck.frame.width, y: lbTienMatCheck.frame.origin.y, width: Common.Size(s: 20), height: Common.Size(s: 20)))
        imgThe.image = #imageLiteral(resourceName: "check-2")
        imgThe.contentMode = .scaleAspectFit
        imgThe.tag = 2
        viewPayment.addSubview(imgThe)
        
        let tapThe = UITapGestureRecognizer(target: self, action: #selector(chooseTypePayment(sender:)))
        imgThe.isUserInteractionEnabled = true
        imgThe.addGestureRecognizer(tapThe)
        
        let lbTheCheck = UILabel(frame: CGRect(x: imgThe.frame.origin.x + imgThe.frame.width + Common.Size(s: 5), y: imgThe.frame.origin.y, width: (viewPayment.frame.size.width/2) - Common.Size(s: 35), height: Common.Size(s: 20)))
        lbTheCheck.text = "Thẻ"
        lbTheCheck.textColor = UIColor.black
        lbTheCheck.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewPayment.addSubview(lbTheCheck)
        
        
        lbTitleCash = Common.tileLabel(x: Common.Size(s:15), y: lbTheCheck.frame.size.height + lbTheCheck.frame.origin.y + Common.Size(s:20), width: viewPayment.frame.width/3 - Common.Size(s: 12), height: Common.Size(s:30), title: "Tiền mặt", fontSize: 14)
        viewPayment.addSubview(lbTitleCash)
        
        tfCash = Common.inputTextTextField(x: lbTitleCash.frame.origin.x + lbTitleCash.frame.width, y:lbTitleCash.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30) - lbTitleCash.frame.width, height: Common.Size(s: 30), placeholder: "", fontSize: 13, isNumber: true)
        tfCash.addTarget(self, action: #selector(textFieldDidChangeMoneyTienMat(_:)), for: .editingDidEnd)
        tfCash.text = Common.convertCurrencyDoubleV2(value: itemOffer?.price ?? 0)
        tfCash.isUserInteractionEnabled = false
        viewPayment.addSubview(tfCash)
        
        
        lbTitleCard = Common.tileLabel(x: Common.Size(s:15), y: tfCash.frame.size.height + tfCash.frame.origin.y + Common.Size(s:10), width: viewPayment.frame.width/3 - Common.Size(s: 12), height: Common.Size(s:30), title: "Thẻ", fontSize: 14)
        lbTitleCard.isHidden = true
        viewPayment.addSubview(lbTitleCard)
        
        tfCard = Common.inputTextTextField(x: lbTitleCard.frame.origin.x + lbTitleCard.frame.width, y: lbTitleCard.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30) - lbTitleCash.frame.width, height: Common.Size(s: 30), placeholder: "", fontSize: 13, isNumber: true)
        tfCard.addTarget(self, action: #selector(textFieldDidChangeMoneyTienThe(_:)), for: .editingDidEnd)
        tfCard.isHidden = true
        viewPayment.addSubview(tfCard)
        
        
        self.view.addSubview(viewFooter)
        viewFooter.anchor(left:view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 12,paddingRight: 12)
        viewFooter.setDimensions(width: self.view.frame.width, height: Common.Size(s:100))
        
        
        let lblFee = UILabel(frame: CGRect(x: 0, y: Common.Size(s: 10), width: view.frame.size.width, height: Common.Size(s: 20)))
        lblFee.text = "Phí cà thẻ"
        lblFee.textColor = UIColor.black
        lblFee.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewFooter.addSubview(lblFee)
        
        lblFeeValue = UILabel(frame: CGRect(x: 0, y: Common.Size(s: 10), width: view.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lblFeeValue.text = "0"
        lblFeeValue.textColor = .black
        lblFeeValue.textAlignment = .right
        lblFeeValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
        viewFooter.addSubview(lblFeeValue)
        
        let lbSoTienThanhToan = Common.tileLabel(x: 0, y: lblFee.frame.size.height + lblFee.frame.origin.y + Common.Size(s: 10), width: view.frame.size.width, height: Common.Size(s: 20), title: "Số tiền thanh toán",fontSize: Common.Size(s:13))
        viewFooter.addSubview(lbSoTienThanhToan)
        

        
        lbSoTienThanhToanValue = Common.tileLabel(x: 0, y: lbSoTienThanhToan.frame.origin.y,width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s: 20), title: "\(Common.convertCurrencyDoubleV2(value: itemOffer?.price ?? 0))", fontSize:  Common.Size(s: 13), isBoldStyle: true)
        lbSoTienThanhToanValue.textAlignment = .right
        lbSoTienThanhToanValue.textColor = .red
        viewFooter.addSubview(lbSoTienThanhToanValue)
        
        
        let btSave = Common.buttonAction(x:0,y: lbSoTienThanhToan.frame.size.height + lbSoTienThanhToan.frame.origin.y + Common.Size(s: 10), width: view.frame.size.width - Common.Size(s:27), height: Common.Size(s:40), title: "Hoàn tất")
        btSave.addTarget(self, action: #selector(handlePay), for: .touchUpInside)
        viewFooter.addSubview(btSave)
        
        
        
        
        
    }
    
    // MARK: - API
    
    func fetchSaveAPI(){
        
        var cashNum = (tfCash.text ?? "0").replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        cashNum = cashNum.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        var credictNum = (tfCard.text ?? "0").replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        credictNum = credictNum.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        
        let xmlCredict = "<item Totalcash=\"0\" Totalcardcredit=\"\(credictNum)\" Numcard=\"\" IDBankCard=\"\(self.itemThe?.Value ?? 0)\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" cardfee=\"\(self.itemThe?.PercentFee ?? 0)\" namecard=\"\(self.itemThe?.Text ?? "")\" totalcardfee=\"\(Int(self.phiCatheAmount))\" />"
        
        let xmlCash = "<item Totalcash=\"\(cashNum)\" Totalcardcredit=\"0\" Numcard=\"\" IDBankCard=\"\" Numvoucher=\"\" TotalVoucher=\"0\" Namevoucher=\"\" />"
        let xmlString = "<line>" + xmlCredict + xmlCash + "</line>"
        
        if isThe && isTienMat {
            if Int(credictNum) ?? 0 <= 0 {
                Toast.init(text: "Bạn đang chọn phương thức thanh toán thẻ và tiền mặt. Số tiền thanh toán thẻ phải lớn hơn 0 !").show()
                return
            }
            if Int(cashNum) ?? 0 <= 0 {
                Toast.init(text: "Bạn đang chọn phương thức thanh toán thẻ và tiền mặt. Số tiền thanh toán tiền mặt phải lớn hơn 0 !").show()
                
                return
            }
        }
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            CRMAPIManager.Galaxy_order_insert(xmlstringpay: xmlString.toBase64(),
                                              price_cost: "\(self.itemOffer?.price_cost ?? 0)",
                                              price: "\(self.itemOffer?.price ?? 0)",
            phonenumber: self.itemGoiCuocGalaxy?.phone ?? "",
            productcode: "\(self.itemOffer?.productcode_frt ?? "")",
            productname: "\(self.itemOffer?.name ?? "")",
            magoiNCC: "\(self.itemOffer?.id ?? "")",
            startdate: self.itemOffer?.startAt ?? "",
            enddate: self.itemOffer?.endAt ?? "",
            mota_goi: "\(self.itemOffer?.description ?? "")") { (result,message, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if(result?.p_status == 1){
                            self.showDialog(message: result?.p_messages ?? "LOAD API ERROR !")
                            return
                        }
                        
                        let alert = UIAlertController(title: "Thông báo", message: result?.p_messages ?? "Load API ERROR", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                            let controller = DetailGalaxyPayViewController()
                            controller.phone = self.itemGoiCuocGalaxy?.phone
                            controller.resultInsertGalaxyPay = result
                            self.navigationController?.pushViewController(controller, animated: true)
                        })
                        self.present(alert, animated: true)
                    } else {
                        
                        self.showDialog(message: err)
                    }
                }
            }
        }
    }
    
    
    // MARK: - Selectors
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func handlePay(){
       
        let popup = PopupDialog(title: "Xác nhận thanh toán", message: "Bạn có muốn thanh toán giao dịch này không ?", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        let buttonOne = CancelButton(title: "Không thanh toán") {
            
            
            self.dismiss(animated: false, completion: nil)
            
        }
        let buttonTwo = DefaultButton(title: "Đồng ý thanh toán"){
            self.fetchSaveAPI()
            self.dismiss(animated: false, completion: nil)
        }
        popup.addButtons([buttonOne,buttonTwo])
        self.present(popup, animated: true, completion: nil)
        
    }
    @objc func chooseTypePayment(sender:UITapGestureRecognizer) {
        let view = sender.view!
        if view.tag == 1 { // tiền mặt
            self.isTienMat = !self.isTienMat
            self.updateUIWhenCheckHTThanhToan()
        }
        
        if view.tag == 2 { // thẻ
            if self.isThe {
                self.isThe = false
                self.imgThe.image = #imageLiteral(resourceName: "check-1")
                self.updateUIWhenCheckHTThanhToan()
            } else {
                let vc = ListCardViewController()
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }


    @objc func textFieldDidChangeMoneyTienMat(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
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
            self.tfCard.text = str
            //self.lblTienMat.text = "Tiền mặt: \(str)"
            let money = self.itemOffer?.price ?? 0
            str = str.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            str = str.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            self.tfCard.text = Common.convertCurrencyV2(value: Int(money) - Int(str)!)
            
    
        }else{
            textField.text = ""
            self.tfCash.text = ""
            self.tfCard.text = "\(Common.convertCurrencyDoubleV2(value: itemOffer?.price ?? 0))"
       
        }
        
    }
    @objc func textFieldDidChangeMoneyTienThe(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
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
            self.tfCash.text = str
            let money = itemOffer?.price ?? 0
            str = str.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            str = str.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            self.tfCash.text = Common.convertCurrencyV2(value: Int(money) - Int(str)!)
            
        }else{
            textField.text = ""
            self.tfCash.text = "\(Common.convertCurrencyDoubleV2(value: itemOffer?.price ?? 0))"
            
        }
        
    }

    // MARK: - Helpers

    func updateTotalPrice(cardPercentFee: Double) {
        let moneyCuoc = itemOffer?.price ?? 0
        self.phiCatheAmount = (moneyCuoc * cardPercentFee) / 100
        let total = moneyCuoc + phiCatheAmount
        
        self.lblFeeValue.text = "\(Common.convertCurrencyDouble(value: phiCatheAmount))đ"
        self.lbSoTienThanhToanValue.text = "\(Common.convertCurrencyDouble(value: total))đ"
    }
    func updateUIWhenCheckHTThanhToan() {
        //----------tien mat
        if isTienMat { // tick tien mat
            self.imgTienMat.image = #imageLiteral(resourceName: "check-1")
            tfCash.isUserInteractionEnabled = true
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.tfCash.isHidden = false
                self.lbTitleCash.isHidden = false
                if self.isThe {
                    self.tfCard.isUserInteractionEnabled = true
                }
                
                
            }
      
            
            
        } else {
            self.imgTienMat.image = #imageLiteral(resourceName: "check-2")
            
        }
        
        //------------the
        if isThe { // tick thẻ
            tfCard.isUserInteractionEnabled = false
            lbTitleCard.isHidden = false
            tfCard.isHidden = false
            tfCash.text = ""
            tfCash.isHidden = true
            lbTitleCash.isHidden = true
            tfCard.text = "\(Common.convertCurrencyDoubleV2(value: itemOffer?.price ?? 0))"
        } else {
            
        }
        
    }
    
    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    
    
}
    // MARK: - ListCardViewControllerDelegate

extension PaymentGalaxyPayViewController: ListCardViewControllerDelegate {
    func returnCard(item: CardTypeFromPOSResult, ind: Int) {
        self.itemThe = item
        self.updateTotalPrice(cardPercentFee: item.PercentFee)
        self.isThe = true
        self.imgThe.image = #imageLiteral(resourceName: "check-1")
        
        self.isTienMat = false
        self.imgTienMat.image = #imageLiteral(resourceName: "check-2")
        
        //self.updateInputMoney()
    
        self.updateUIWhenCheckHTThanhToan()
    }
    
    func returnClose() {
        self.isThe = false
        self.imgThe.image = #imageLiteral(resourceName: "check-2")
        lbTitleCard.isHidden = true
        tfCard.text = ""
        tfCard.isHidden = true
        tfCash.text = "\(Common.convertCurrencyDoubleV2(value: itemOffer?.price ?? 0))"
        tfCash.isUserInteractionEnabled = false
        phiCatheAmount = 0
        self.lblFeeValue.text = "0đ"
        self.lbSoTienThanhToanValue.text = "\(Common.convertCurrencyDoubleV2(value: itemOffer?.price ?? 0))đ"
        
    }
}
