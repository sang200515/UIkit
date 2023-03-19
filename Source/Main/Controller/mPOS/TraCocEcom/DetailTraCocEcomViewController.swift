//
//  DetailTraCocViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 11/4/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import DLRadioButton
class DetailTraCocEcomViewController: UIViewController {
    
    // MARK: - Properties
    
    
    var scrollView:UIScrollView!
    var tfPhoneNumber:SkyFloatingLabelTextFieldWithIcon!
    var tfUserName:SkyFloatingLabelTextFieldWithIcon!
    var tfUserAddress:SkyFloatingLabelTextFieldWithIcon!
    var tfUserEmail:SkyFloatingLabelTextFieldWithIcon!
    var tfUserBirthday:SkyFloatingLabelTextFieldWithIcon!
    var tfInterestRate:UITextField!
    var tfPrepay:UITextField!
    //    var tfVoucher:UITextField!
    
    var taskNotes: UITextView!
    var placeholderLabel : UILabel!
    
    var radioAtTheCounter:DLRadioButton!
    var radioInstallment:DLRadioButton!
    var radioDeposit:DLRadioButton!
    var radioPayNow:DLRadioButton!
    var radioPayNotNow:DLRadioButton!
    var radioMan:DLRadioButton!
    var radioWoman:DLRadioButton!
    
    var radioPayInstallmentCom:DLRadioButton!
    var radioPayInstallmentCard:DLRadioButton!
    
    
    var lbPayType:UILabel!
    
    
    
    var viewInfoDetail: UIView!
    
    
    var viewToshibaPoint:UIView!
    var viewBelowToshibaPoint:UIView!
    
    var viewInstallmentCard:UIView!
    var viewInstallmentCom:UIView!
    
    var viewFull:UIView!
    
    var radioTGYes:DLRadioButton!
    var radioTGNo :DLRadioButton!
    var listLbDiscount:[UILabel] = []
    var discountPay:Float = 0.0
    var lbPayValue,lbDiscountValue:UILabel!
    var groupSKU: [String] = []
    
    //--
    
    var radioTGSSYes:DLRadioButton!
    var radioTGSSNo :DLRadioButton!
    
    var radioDHDUYes:DLRadioButton!
    var radioDHDUNo :DLRadioButton!
    
    var tableViewVoucherNoPrice: UITableView = UITableView()
    var cellHeight:CGFloat = 0
    private var tracoc:TraCoc
    private var itemtraCoc:CustomerTraCoc
    private var lbPriceOnlineValue:UILabel!
    private var totalPay:Float = 0
    private var totalDiscount:Float = 0
 
    // MARK: - Lifecycle
    
    
    init(tracoc: TraCoc, itemTracoc: CustomerTraCoc){
        self.tracoc = tracoc
        self.itemtraCoc = itemTracoc
        super.init(nibName: nil, bundle:nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    
    
    // MARK: - API
    func fetchProductBySkuAndMDMHAPI(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            if self.tracoc.details.count > 0 {
                Cache.itemsPromotion.removeAll()
                Cache.carts.removeAll()
                let listProduct = self.tracoc.details.filter{$0.invntItem == "Y"}
                
                for i in 0..<listProduct.count {
                    ProductAPIManager.product_detais_by_sku(sku: listProduct[i].itemCode,handler: { [weak self](products , error) in
                        guard let self = self else {
                            return
                        }
                        
                        if(products.count > 0){
                            let product = products[0].product
                            ProductAPIManager.mpos_FRT_SP_innovation_MDMH_Sim(itemcode: product.sku,handler: {(resultsMDMH, err) in
                                WaitingNetworkResponseAlert.DismissWaitingAlert {
                                    if(err.count <= 0){
                                        
                                        Cache.phone = self.tracoc.headers[0].Phone
                                        Cache.name = self.tracoc.headers[0].cardName
                                        Cache.address = self.tracoc.headers[0].cusAddress
                                        Cache.email = self.tracoc.headers[0].e_Mail
                                        Cache.DocEntryEcomCache = Int(self.tracoc.headers[0].docNum) ?? 0
                                        Cache.type_so = 1
//                                        Cache.orderType = 1
                                        Cache.orderPayType = 2
                                        Cache.codePayment = Int(self.itemtraCoc.u_CrdCod) ?? 0
                                        var priceBT:Float = Float(listProduct[i].price) ?? 0
                                        let taxRate:Float = Float(listProduct[i].taxRate) ?? 0
                                        var priceAT:Float = priceBT + ( priceBT * taxRate/100 )
                                        
                                        priceBT.round(.toNearestOrEven)
                                        priceAT.round(.toNearestOrEven)
                                        
                                        
                                        product.name = listProduct[i].itemName
                                        product.sku = listProduct[i].itemCode
                                        product.price = Float(priceAT)
                                        product.priceBeforeTax = Float(priceBT)
                                        if !resultsMDMH.isEmpty {
                                            product.brandName = resultsMDMH[0].Brandname
                                            product.labelName = resultsMDMH[0].p_sim
                                            product.p_matkinh = resultsMDMH[0].p_matkinh
                                        }
                                        
                                     
                                        Cache.payOnlineEcom = Float(self.tracoc.headers[0].u_DownPay) ?? 0
                                        
                                        //
                                        
                                        let cart = Cart(sku: listProduct[i].itemCode, product: product,quantity: Int(listProduct[i].quantity) ?? 0,color:"",inStock:-1, imei: listProduct[i].serial != "" ? listProduct[i].serial : "N/A",price: product.price , priceBT: 0, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                        Cache.carts.append(cart)
                                        
                                        if i == listProduct.count - 1 {
                                            let newViewController = CartViewController()
                                            newViewController.tracocItem = self.itemtraCoc
                                            newViewController.isFromSearch = false
                                            newViewController.isTraCocEcom  = true
                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                        }
                                        
                                    }else{
                                        self.showPopUp(err, "Thông báo", buttonTitle: "Đồng ý")
                                    }
                                }
                                
                            })
                        }else{
                            WaitingNetworkResponseAlert.DismissWaitingAlert {
                                self.showPopUp(error != "" ? error : "Sản phẩm không tồn tại", "Thông báo", buttonTitle: "Đồng ý")
                            }
                        }
        
                    })
                    
                }
            }
        }
        
        
    }


    
    
    // MARK: - Selectors
    @objc func handleBuyNow(){
        fetchProductBySkuAndMDMHAPI()
        
        
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lbUserInfo = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: Common.Size(s:18)))
        lbUserInfo.textAlignment = .left
        lbUserInfo.textColor = UIColor(netHex:0x04AB6E)
        lbUserInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbUserInfo.text = "THÔNG TIN KHÁCH HÀNG"
        scrollView.addSubview(lbUserInfo)
        
        //input phone number
        tfPhoneNumber = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: Common.Size(s:20), y: lbUserInfo.frame.origin.y + lbUserInfo.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:40)), iconType: .image)
        
        tfPhoneNumber.placeholder = "Nhập số điện thoại"
        tfPhoneNumber.title = "Số điện thoại"
        tfPhoneNumber.iconImage = UIImage(named: "phone_number")
        tfPhoneNumber.tintColor = UIColor(netHex:0x04AB6E)
        tfPhoneNumber.lineColor = UIColor.gray
        tfPhoneNumber.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfPhoneNumber.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfPhoneNumber.lineHeight = 0.5
        tfPhoneNumber.selectedLineHeight = 0.5
        tfPhoneNumber.clearButtonMode = .whileEditing
        tfPhoneNumber.isUserInteractionEnabled = false
        tfPhoneNumber.text = tracoc.headers[0].Phone
        tfPhoneNumber.keyboardType = .numberPad
        scrollView.addSubview(tfPhoneNumber)
        
        //input name info
        tfUserName = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: tfPhoneNumber.frame.origin.x, y: tfPhoneNumber.frame.origin.y + tfPhoneNumber.frame.size.height + Common.Size(s:10), width: tfPhoneNumber.frame.size.width , height: tfPhoneNumber.frame.size.height ), iconType: .image);
        tfUserName.placeholder = "Nhập họ tên"
        tfUserName.title = "Tên khách hàng"
        tfUserName.iconImage = UIImage(named: "name")
        tfUserName.tintColor = UIColor(netHex:0x04AB6E)
        tfUserName.lineColor = UIColor.gray
        tfUserName.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfUserName.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfUserName.lineHeight = 0.5
        tfUserName.selectedLineHeight = 0.5
        tfUserName.clearButtonMode = .whileEditing
        tfUserName.isUserInteractionEnabled = false
        tfUserName.text = tracoc.headers[0].cardName
        scrollView.addSubview(tfUserName)
        
        //input address
        tfUserAddress = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: tfUserName.frame.origin.x, y: tfUserName.frame.origin.y + tfUserName.frame.size.height + Common.Size(s:10), width: tfUserName.frame.size.width , height: tfUserName.frame.size.height ), iconType: .image);
        tfUserAddress.placeholder = "Nhập địa chỉ"
        tfUserAddress.title = "Địa chỉ"
        tfUserAddress.iconImage = UIImage(named: "address")
        tfUserAddress.tintColor = UIColor(netHex:0x04AB6E)
        tfUserAddress.lineColor = UIColor.gray
        tfUserAddress.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfUserAddress.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfUserAddress.lineHeight = 0.5
        tfUserAddress.selectedLineHeight = 0.5
        tfUserAddress.clearButtonMode = .whileEditing
        tfUserAddress.isUserInteractionEnabled = false
        scrollView.addSubview(tfUserAddress)
        
        tfUserAddress.text = tracoc.headers[0].cusAddress
        
        //input email
        tfUserEmail = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: tfUserAddress.frame.origin.x, y: tfUserAddress.frame.origin.y + tfUserAddress.frame.size.height + Common.Size(s:10), width: tfUserAddress.frame.size.width , height: tfUserAddress.frame.size.height ), iconType: .image);
        tfUserEmail.placeholder = "Nhập email"
        tfUserEmail.title = "Email"
        tfUserEmail.iconImage = UIImage(named: "email")
        tfUserEmail.tintColor = UIColor(netHex:0x04AB6E)
        tfUserEmail.lineColor = UIColor.gray
        tfUserEmail.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfUserEmail.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfUserEmail.lineHeight = 0.5
        tfUserEmail.selectedLineHeight = 0.5
        tfUserEmail.clearButtonMode = .whileEditing
        tfUserEmail.isUserInteractionEnabled = false
        scrollView.addSubview(tfUserEmail)
        
        tfUserEmail.text = tracoc.headers[0].e_Mail
        
        //input email
        tfUserBirthday = SkyFloatingLabelTextFieldWithIcon(frame: CGRect(x: tfUserEmail.frame.origin.x, y: tfUserEmail.frame.origin.y + tfUserEmail.frame.size.height + Common.Size(s:10), width: tfUserAddress.frame.size.width , height: tfUserAddress.frame.size.height), iconType: .image);
        tfUserBirthday.placeholder = "Nhập ngày sinh"
        tfUserBirthday.title = "Ngày sinh"
        tfUserBirthday.iconImage = UIImage(named: "birthday")
        tfUserBirthday.tintColor = UIColor(netHex:0x04AB6E)
        tfUserBirthday.lineColor = UIColor.gray
        tfUserBirthday.selectedTitleColor = UIColor(netHex:0x04AB6E)
        tfUserBirthday.selectedLineColor = UIColor(netHex:0x04AB6E)
        tfUserBirthday.lineHeight = 0.5
        tfUserBirthday.selectedLineHeight = 0.5
        tfUserBirthday.clearButtonMode = .whileEditing
        tfUserBirthday.isUserInteractionEnabled = false
        scrollView.addSubview(tfUserBirthday)
        
        tfUserBirthday.text = tracoc.headers[0].birthday
        
        
        let lbGenderText = UILabel(frame: CGRect(x: tfUserBirthday.frame.origin.x, y: tfUserBirthday.frame.origin.y + tfUserBirthday.frame.size.height + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbGenderText.textAlignment = .left
        lbGenderText.textColor = UIColor.black
        lbGenderText.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbGenderText.text = "Giới tính"
        scrollView.addSubview(lbGenderText)
        
        radioMan = createRadioButtonGender(CGRect(x: lbGenderText.frame.origin.x,y:lbGenderText.frame.origin.y + lbGenderText.frame.size.height + Common.Size(s:5) , width: lbGenderText.frame.size.width/3, height: Common.Size(s:20)), title: "Nam", color: UIColor.black);
        scrollView.addSubview(radioMan)
        
        radioWoman = createRadioButtonGender(CGRect(x: radioMan.frame.origin.x + radioMan.frame.size.width ,y:radioMan.frame.origin.y, width: radioMan.frame.size.width, height: radioMan.frame.size.height), title: "Nữ", color: UIColor.black);
        scrollView.addSubview(radioWoman)
    
        radioMan.isSelected = true
        
        
        viewBelowToshibaPoint = UIView(frame: CGRect(x: 0, y: radioWoman.frame.origin.y + radioWoman.frame.size.height+Common.Size(s:20), width: scrollView.frame.size.width, height: Common.Size(s:40)))
        
        //tilte choose type
        let lbCartType = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: 0, width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbCartType.textAlignment = .left
        lbCartType.textColor = UIColor(netHex:0x04AB6E)
        lbCartType.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbCartType.text = "LOẠI ĐƠN HÀNG"
        //        scrollView.addSubview(lbCartType)
        
        viewBelowToshibaPoint.addSubview(lbCartType)
        
        radioAtTheCounter = createRadioButton(CGRect(x: lbCartType.frame.origin.x, y: lbCartType.frame.origin.y + lbCartType.frame.size.height+Common.Size(s:10), width: lbCartType.frame.size.width/3, height: Common.Size(s:20)), title: "Tại quầy", color: UIColor.black);
        //        scrollView.addSubview(radioAtTheCounter)
        radioAtTheCounter.isUserInteractionEnabled = false
        viewBelowToshibaPoint.addSubview(radioAtTheCounter)
        
        radioInstallment = createRadioButton(CGRect(x: radioAtTheCounter.frame.origin.x + radioAtTheCounter.frame.size.width, y: radioAtTheCounter.frame.origin.y , width: radioAtTheCounter.frame.size.width, height: radioAtTheCounter.frame.size.height), title: "Trả góp", color: UIColor.black);
        //        scrollView.addSubview(radioInstallment)
        radioInstallment.isUserInteractionEnabled = false
        viewBelowToshibaPoint.addSubview(radioInstallment)
        
        radioDeposit = createRadioButton(CGRect(x: radioInstallment.frame.origin.x + radioInstallment.frame.size.width, y: radioAtTheCounter.frame.origin.y , width: radioInstallment.frame.size.width, height: radioInstallment.frame.size.height), title: "Đặt cọc", color: UIColor.black);
        //        scrollView.addSubview(radioDeposit)
        radioDeposit.isUserInteractionEnabled = false
        viewBelowToshibaPoint.addSubview(radioDeposit)
        radioAtTheCounter.isSelected = true
        Cache.orderType = 1
        if tracoc.headers.first?.docType == "05" {
            radioAtTheCounter.isSelected = false
            radioDeposit.isSelected = true
            Cache.orderType  = 3
        }
        
       
        
        viewInfoDetail = UIView(frame: CGRect(x: 0, y: radioAtTheCounter.frame.origin.y  + radioAtTheCounter.frame.size.height, width: self.view.frame.size.width, height: 0))
        
        let lbTG = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: 0, width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbTG.textAlignment = .left
        lbTG.textColor = UIColor(netHex:0x04AB6E)
        lbTG.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbTG.text = "CT KH RỚT TRẢ GÓP"
        viewInfoDetail.addSubview(lbTG)
        
        radioTGYes = createRadioButtonPayTG(CGRect(x: radioAtTheCounter.frame.origin.x,y:lbTG.frame.origin.y + lbTG.frame.size.height + Common.Size(s:10) , width: lbTG.frame.size.width/2, height: radioAtTheCounter.frame.size.height), title: "Có", color: UIColor.black);
        radioTGYes.isUserInteractionEnabled = false
        viewInfoDetail.addSubview(radioTGYes)
        
        radioTGNo = createRadioButtonPayTG(CGRect(x: radioInstallment.frame.origin.x ,y:radioTGYes.frame.origin.y, width: radioTGYes.frame.size.width, height: radioTGYes.frame.size.height), title: "Không", color: UIColor.black)
        radioTGNo.isUserInteractionEnabled = false
        viewInfoDetail.addSubview(radioTGNo)
        radioTGNo.isSelected = true
        
        
        let lbTGSamsung = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: radioTGYes.frame.size.height + radioTGYes.frame.origin.y + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbTGSamsung.textAlignment = .left
        lbTGSamsung.textColor = UIColor(netHex:0x04AB6E)
        lbTGSamsung.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbTGSamsung.text = "TRẢ GÓP SAMSUNG"
        viewInfoDetail.addSubview(lbTGSamsung)
        
        radioTGSSYes = createRadioButtonPayTGSS(CGRect(x: radioAtTheCounter.frame.origin.x,y:lbTGSamsung.frame.origin.y + lbTGSamsung.frame.size.height + Common.Size(s:10) , width: lbTG.frame.size.width/2, height: radioAtTheCounter.frame.size.height), title: "Có", color: UIColor.black)
        radioTGSSYes.isUserInteractionEnabled = false
        viewInfoDetail.addSubview(radioTGSSYes)
        
        radioTGSSNo = createRadioButtonPayTGSS(CGRect(x: radioInstallment.frame.origin.x ,y:radioTGSSYes.frame.origin.y, width: radioTGYes.frame.size.width, height: radioTGYes.frame.size.height), title: "Không", color: UIColor.black)
        radioTGSSNo.isUserInteractionEnabled = false
        viewInfoDetail.addSubview(radioTGSSNo)
        radioTGSSNo.isSelected = true
        
        
        
        let lbDuAn = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: radioTGSSYes.frame.size.height + radioTGSSYes.frame.origin.y + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbDuAn.textAlignment = .left
        lbDuAn.textColor = UIColor(netHex:0x04AB6E)
        lbDuAn.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbDuAn.text = "ĐƠN HÀNG DỰ ÁN"
        viewInfoDetail.addSubview(lbDuAn)
        
        radioDHDUYes = createRadioButtonDHDuAn(CGRect(x: radioAtTheCounter.frame.origin.x,y:lbDuAn.frame.origin.y + lbDuAn.frame.size.height + Common.Size(s:10) , width: lbTG.frame.size.width/2, height: radioAtTheCounter.frame.size.height), title: "Có", color: UIColor.black);
        radioDHDUYes.isUserInteractionEnabled = false
        viewInfoDetail.addSubview(radioDHDUYes)
        
        radioDHDUNo = createRadioButtonDHDuAn(CGRect(x: radioInstallment.frame.origin.x ,y:radioDHDUYes.frame.origin.y, width: radioDHDUYes.frame.size.width, height: radioDHDUYes.frame.size.height), title: "Không", color: UIColor.black);
        radioDHDUNo.isUserInteractionEnabled = false
        viewInfoDetail.addSubview(radioDHDUNo)
        radioDHDUNo.isSelected = true
        
        
        
        //tilte choose type pay
        lbPayType = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: radioDHDUYes.frame.origin.y + radioDHDUYes.frame.size.height + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbPayType.textAlignment = .left
        lbPayType.textColor = UIColor(netHex:0x04AB6E)
        lbPayType.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbPayType.text = "LOẠI THANH TOÁN"
        viewInfoDetail.addSubview(lbPayType)
        
        radioPayNow = createRadioButtonPayType(CGRect(x: radioAtTheCounter.frame.origin.x,y:lbPayType.frame.origin.y + lbPayType.frame.size.height + Common.Size(s:10) , width: lbPayType.frame.size.width/2, height: radioAtTheCounter.frame.size.height), title: "Trực tiếp", color: UIColor.black);
        radioPayNow.isUserInteractionEnabled = false
        viewInfoDetail.addSubview(radioPayNow)
        
        radioPayNotNow = createRadioButtonPayType(CGRect(x: radioInstallment.frame.origin.x ,y:radioPayNow.frame.origin.y, width: radioPayNow.frame.size.width, height: radioPayNow.frame.size.height), title: "Khác", color: UIColor.black);
        radioPayNotNow.isUserInteractionEnabled = false
        viewInfoDetail.addSubview(radioPayNotNow)
        
        radioPayNotNow.isSelected = true
        
        
        
        
        viewFull = UIView(frame: CGRect(x:viewInfoDetail.frame.origin.x,y:radioPayNotNow.frame.origin.y  + radioPayNotNow.frame.size.height + Common.Size(s:20),width:viewInfoDetail.frame.width ,height:0))
        
        viewInfoDetail.addSubview(viewFull)
        
        let lbNotes = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: 0, width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbNotes.textAlignment = .left
        lbNotes.textColor = UIColor(netHex:0x04AB6E)
        lbNotes.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbNotes.text = "GHI CHÚ"
        viewFull.addSubview(lbNotes)
        
        taskNotes = UITextView(frame: CGRect(x: radioAtTheCounter.frame.origin.x , y: lbNotes.frame.origin.y  + lbNotes.frame.size.height + Common.Size(s:10), width: lbCartType.frame.size.width, height: tfUserEmail.frame.size.height * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        taskNotes.layer.borderWidth = 0.5
        taskNotes.layer.borderColor = borderColor.cgColor
        taskNotes.layer.cornerRadius = 5.0
        
        taskNotes.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        viewFull.addSubview(taskNotes)
        taskNotes.isUserInteractionEnabled = false
        placeholderLabel = UILabel()
        
        placeholderLabel.font = UIFont.systemFont(ofSize: (taskNotes.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        taskNotes.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (taskNotes.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !taskNotes.text.isEmpty
        
        
        let soViewPhone = UIView()
        viewFull.addSubview(soViewPhone)
        soViewPhone.frame = CGRect(x: taskNotes.frame.origin.x, y: taskNotes.frame.origin.y + taskNotes.frame.size.height + Common.Size(s:20), width: taskNotes.frame.size.width, height: 100)
        
        let lbSODetail = UILabel(frame: CGRect(x: 0, y: 0, width: soViewPhone.frame.size.width, height: Common.Size(s:18)))
        lbSODetail.textAlignment = .left
        lbSODetail.textColor = UIColor(netHex:0x04AB6E)
        lbSODetail.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbSODetail.text = "THÔNG TIN ĐƠN HÀNG"
        soViewPhone.addSubview(lbSODetail)
        
        let line1 = UIView(frame: CGRect(x: soViewPhone.frame.size.width * 1.3/10, y:lbSODetail.frame.origin.y + lbSODetail.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:25)))
        line1.backgroundColor = UIColor(netHex:0x04AB6E)
        soViewPhone.addSubview(line1)
        let line2 = UIView(frame: CGRect(x: 0, y:line1.frame.origin.y + line1.frame.size.height, width: soViewPhone.frame.size.width, height: 1))
        line2.backgroundColor = UIColor(netHex:0x04AB6E)
        soViewPhone.addSubview(line2)
        
        let lbStt = UILabel(frame: CGRect(x: 0, y: line1.frame.origin.y, width: line1.frame.origin.x, height: line1.frame.size.height))
        lbStt.textAlignment = .center
        lbStt.textColor = UIColor(netHex:0x04AB6E)
        lbStt.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbStt.text = "STT"
        soViewPhone.addSubview(lbStt)
        
        let lbInfo = UILabel(frame: CGRect(x: line1.frame.origin.x, y: line1.frame.origin.y, width: lbSODetail.frame.size.width - line1.frame.origin.x, height: line1.frame.size.height))
        lbInfo.textAlignment = .center
        lbInfo.textColor = UIColor(netHex:0x04AB6E)
        lbInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbInfo.text = "Sản phẩm"
        soViewPhone.addSubview(lbInfo)
        
        var indexY = line2.frame.origin.y
        var indexHeight: CGFloat = line2.frame.origin.y + line2.frame.size.height
        var num = 0
        
        
        
        for item in tracoc.details{
            
            
            //check hien lblChonThueBao
            if item.invntItem == "Y"{
                //
                num = num + 1
                
                
                let soViewLine = UIView()
                soViewPhone.addSubview(soViewLine)
                soViewLine.frame = CGRect(x: 0, y: indexY, width: soViewPhone.frame.size.width, height: 50)
                let line3 = UIView(frame: CGRect(x: line1.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
                line3.backgroundColor = UIColor(netHex:0x04AB6E)
                soViewLine.addSubview(line3)
                
                let nameProduct = "\(item.itemName)"
                let sizeNameProduct = nameProduct.height(withConstrainedWidth: soViewPhone.frame.size.width - line3.frame.origin.x, font: UIFont.systemFont(ofSize: Common.Size(s:14)))
                let lbNameProduct = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: 3, width: soViewPhone.frame.size.width - line3.frame.origin.x, height: sizeNameProduct))
                lbNameProduct.textAlignment = .left
                lbNameProduct.textColor = UIColor.black
                lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbNameProduct.text = nameProduct
                lbNameProduct.numberOfLines = 3
                soViewLine.addSubview(lbNameProduct)
                
                let line4 = UIView(frame: CGRect(x: line3.frame.origin.x, y:0, width: soViewPhone.frame.size.width - line3.frame.origin.x - 1, height: 1))
                line4.backgroundColor = UIColor(netHex:0x04AB6E)
                soViewLine.addSubview(line4)
                
                
                
                
                let lbImei = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x , y: lbNameProduct.frame.origin.y + lbNameProduct.frame.size.height + Common.Size(s:5), width: lbNameProduct.frame.size.width, height: Common.Size(s:14)))
                lbImei.textAlignment = .left
                lbImei.textColor = .black
                lbImei.font = UIFont.systemFont(ofSize: Common.Size(s:13))
                lbImei.text = "Imei: \(item.serial)"
                lbImei.numberOfLines = 1
                soViewLine.addSubview(lbImei)
                
                var priceBT:Float = Float(item.price) ?? 0
                let taxRate:Float = Float(item.taxRate) ?? 0
                var priceAT:Float = priceBT + ( priceBT * taxRate/100 )
                priceBT.round(.toNearestOrEven)
                priceAT.round(.toNearestOrEven)
                totalPay = totalPay + priceAT
                let lbPriceProduct = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x, y: lbImei.frame.origin.y + lbImei.frame.size.height + Common.Size(s:10), width: lbNameProduct.frame.size.width, height: Common.Size(s:14)))
                lbPriceProduct.textAlignment = .left
                lbPriceProduct.textColor = UIColor(netHex:0xEF4A40)
                lbPriceProduct.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbPriceProduct.text = "Giá: \(Common.convertCurrencyFloatV2(value: Float(priceAT)))đ"
                lbPriceProduct.numberOfLines = 1
                soViewLine.addSubview(lbPriceProduct)
                
                var vatDiscount:Float = Float(item.discount)! * (Float(item.taxRate)!/100)
                vatDiscount.round(.toNearestOrEven)
                var discountBT = Float(item.discount) ?? 0
                discountBT.round(.toNearestOrEven)
                let discountAT = vatDiscount + discountBT
                totalDiscount = totalDiscount + discountAT
                let lbPriceDiscount = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x, y: lbPriceProduct.frame.origin.y + lbPriceProduct.frame.size.height + Common.Size(s:10), width: lbNameProduct.frame.size.width, height: Common.Size(s:14)))
                lbPriceDiscount.textAlignment = .left
                lbPriceDiscount.textColor = UIColor(netHex:0xEF4A40)
                lbPriceDiscount.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbPriceDiscount.text = "Giảm Giá: \(Common.convertCurrencyFloatV2(value: Float(discountAT)))đ"
                lbPriceDiscount.numberOfLines = 1
                soViewLine.addSubview(lbPriceDiscount)
                
                let priceConLai:Float! = priceAT - discountAT
                let lbPriceTotal = UILabel(frame: CGRect(x: lbNameProduct.frame.origin.x, y: lbPriceDiscount.frame.origin.y + lbPriceDiscount.frame.size.height + Common.Size(s:10), width: lbNameProduct.frame.size.width, height: Common.Size(s:14)))
                lbPriceTotal.textAlignment = .left
                lbPriceTotal.textColor = UIColor(netHex:0xEF4A40)
                lbPriceTotal.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbPriceTotal.text = "Tiền còn lại: \(Common.convertCurrencyFloatV2(value: Float(priceConLai)))đ"
                lbPriceTotal.numberOfLines = 1
                soViewLine.addSubview(lbPriceTotal)
                
            
                
                let lbSttValue = UILabel(frame: CGRect(x: 0, y: 0, width: lbStt.frame.size.width, height: lbStt.frame.size.height))
                lbSttValue.textAlignment = .center
                lbSttValue.textColor = UIColor.black
                lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
                lbSttValue.text = "\(num)"
                soViewLine.addSubview(lbSttValue)
                
                soViewLine.frame = CGRect(x: soViewLine.frame.origin.x, y: soViewLine.frame.origin.y, width: soViewLine.frame.size.width, height: lbPriceTotal.frame.origin.y + lbPriceTotal.frame.size.height + Common.Size(s:5))
                
                
                line3.frame.size.height = soViewLine.frame.size.height
                
                indexHeight = indexHeight + soViewLine.frame.size.height
                indexY = indexY + soViewLine.frame.size.height + soViewLine.frame.origin.x
                
                
                soViewLine.tag = num - 1
            }
            
        }
        
        soViewPhone.frame.size.height = indexHeight
        
        let lbTotal = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: soViewPhone.frame.origin.y + soViewPhone.frame.size.height + Common.Size(s:20), width: tfUserEmail.frame.size.width, height: Common.Size(s:18)))
        lbTotal.textAlignment = .left
        lbTotal.textColor = UIColor(netHex:0x04AB6E)
        lbTotal.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbTotal.text = "THÔNG TIN THANH TOÁN"
        viewFull.addSubview(lbTotal)
        
        
        //        let totalPay = total()
        //        let discountPay = discount()
        
        let lbTotalText = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbTotalText.textAlignment = .left
        lbTotalText.textColor = UIColor.black
        lbTotalText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbTotalText.text = "Tổng đơn hàng:"
        viewFull.addSubview(lbTotalText)
        
        
        let lbTotalValue = UILabel(frame: CGRect(x: tfUserEmail.frame.origin.x, y: lbTotal.frame.origin.y + lbTotal.frame.size.height + Common.Size(s:10), width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbTotalValue.textAlignment = .right
        lbTotalValue.textColor = UIColor(netHex:0xEF4A40)
        lbTotalValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbTotalValue.text = Common.convertCurrencyFloat(value: Float(totalPay))
        viewFull.addSubview(lbTotalValue)
        
        let lbDiscountText = UILabel(frame: CGRect(x: lbTotalText.frame.origin.x, y: lbTotalText.frame.origin.y + lbTotalText.frame.size.height, width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbDiscountText.textAlignment = .left
        lbDiscountText.textColor = UIColor.black
        lbDiscountText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbDiscountText.text = "Giảm giá:"
        viewFull.addSubview(lbDiscountText)
        
        lbDiscountValue = UILabel(frame: CGRect(x: lbTotalValue.frame.origin.x, y: lbDiscountText.frame.origin.y , width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbDiscountValue.textAlignment = .right
        lbDiscountValue.textColor = UIColor(netHex:0xEF4A40)
        lbDiscountValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbDiscountValue.text = Common.convertCurrencyFloat(value: Float(totalDiscount))
        viewFull.addSubview(lbDiscountValue)
        
        
        let lbPriceOnlineText = UILabel(frame: CGRect(x: lbTotalText.frame.origin.x, y: lbDiscountText.frame.origin.y + lbDiscountText.frame.size.height, width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbPriceOnlineText.textAlignment = .left
        lbPriceOnlineText.textColor = UIColor.black
        lbPriceOnlineText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbPriceOnlineText.text = "Tiền Online:"
        viewFull.addSubview(lbPriceOnlineText)
        
        let totalOnline = Float(tracoc.headers[0].u_DownPay)!
        lbPriceOnlineValue = UILabel(frame: CGRect(x: lbPriceOnlineText.frame.origin.x, y: lbPriceOnlineText.frame.origin.y , width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbPriceOnlineValue.textAlignment = .right
        lbPriceOnlineValue.textColor = UIColor(netHex:0xEF4A40)
        lbPriceOnlineValue.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbPriceOnlineValue.text = Common.convertCurrencyFloat(value: Float(totalOnline))
        viewFull.addSubview(lbPriceOnlineValue)
        
        let lbPayText = UILabel(frame: CGRect(x: lbDiscountText.frame.origin.x, y: lbPriceOnlineText.frame.origin.y + lbPriceOnlineText.frame.size.height, width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbPayText.textAlignment = .left
        lbPayText.textColor = UIColor.black
        lbPayText.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        lbPayText.text = "Tổng thanh toán:"
        viewFull.addSubview(lbPayText)
        
        lbPayValue = UILabel(frame: CGRect(x: lbPayText.frame.origin.x, y: lbPayText.frame.origin.y , width: tfUserEmail.frame.size.width, height: Common.Size(s:25)))
        lbPayValue.textAlignment = .right
        lbPayValue.textColor = UIColor(netHex:0xEF4A40)
        lbPayValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
        lbPayValue.text = Common.convertCurrencyFloat(value: Float((totalPay - totalDiscount - totalOnline)))
        
        viewFull.addSubview(lbPayValue)
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: tfUserEmail.frame.origin.x, y: lbPayValue.frame.origin.y + lbPayValue.frame.size.height + Common.Size(s:20), width: tfUserEmail.frame.size.width, height: tfUserEmail.frame.size.height * 1.2)
        btPay.backgroundColor = UIColor(netHex:0xD0021B)
        btPay.setTitle("MUA NGAY", for: .normal)
        btPay.addTarget(self, action: #selector(handleBuyNow), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        
        viewFull.addSubview(btPay)
        viewFull.frame.size.height = btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s:20)
        viewInfoDetail.frame.size.height = viewFull.frame.origin.y + viewFull.frame.size.height
        //        scrollView.addSubview(viewInfoDetail)
        
        
        viewBelowToshibaPoint.addSubview(viewInfoDetail)
        viewBelowToshibaPoint.frame.size.height = viewInfoDetail.frame.size.height + viewInfoDetail.frame.origin.y + Common.Size(s: 5)
        scrollView.addSubview(viewBelowToshibaPoint)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewBelowToshibaPoint.frame.origin.y + viewBelowToshibaPoint.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        
        
        
    }
    
    
    fileprivate func createRadioButton(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    fileprivate func createRadioButtonPayType(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    fileprivate func createRadioButtonGender(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    
    
    fileprivate func createRadioButtonPayTG(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    
    
    
    fileprivate func createRadioButtonDHDuAn(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    
    fileprivate func createRadioButtonPayTGSS(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    
}

extension String {

    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }

}
