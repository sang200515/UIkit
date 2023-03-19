//
//  CheckDepositSOPOSViewController.swift
//  fptshop
//
//  Created by tan on 8/15/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class InputEcomNumFFViewController: UIViewController,UITextFieldDelegate {
    
    var tfInput:UITextField!
    var btClose:UIButton!
    var btOK:UIButton!
    var scrollView:UIScrollView!
    var viewHeader:UIView!

    var lblSOPOS:UILabel!
    var lblSOMPOS:UILabel!
    var lblEcom:UILabel!
    var lblHoTen:UILabel!
    var lblSDT:UILabel!
    var lblTenSP:UILabel!
    var lblGiaSP:UILabel!
    var lblCreateDate:UILabel!
    var lblSoTienCoc:UILabel!
   
    var skuList:String = ""
    var totalPay:Float = 0.0
    var listCart:[Cart] = []
    var heightViewHeader:CGFloat = 0.0
    var barClose : UIBarButtonItem!
    
    var ocfdFFriend:OCRDFFriend?
    var typeOrder:Int?
    //    newViewController.ocfdFFriend = self.ocfdFFriend
    //                          newViewController.typeOrder = 0
    override func viewDidLoad() {
        self.title = "Nhập số đơn hàng Ecom"
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x00955E)


        
        let btPlusIcon = UIButton.init(type: .custom)
        btPlusIcon.setImage(#imageLiteral(resourceName: "Close"), for: UIControl.State.normal)
        btPlusIcon.imageView?.contentMode = .scaleAspectFit
        btPlusIcon.addTarget(self, action: #selector(InputEcomNumFFViewController.backButton), for: UIControl.Event.touchUpInside)
        btPlusIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barClose = UIBarButtonItem(customView: btPlusIcon)
        self.navigationItem.leftBarButtonItems = [barClose]
        
        let newBackButton = UIBarButtonItem(title: "Bỏ qua->", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.actionSkip(sender:)))
        self.navigationItem.rightBarButtonItem = newBackButton
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.clipsToBounds = true
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = .white
        self.view.addSubview(scrollView)
        
        let lblTitle = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTitle.textAlignment = .left
        lblTitle.textColor = UIColor.black
        lblTitle.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTitle.text = "Nhập số đơn hàng Ecom"
        scrollView.addSubview(lblTitle)
        
        tfInput = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblTitle.frame.origin.y + lblTitle.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:70) , height: Common.Size(s:40)));
        tfInput.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfInput.borderStyle = UITextField.BorderStyle.roundedRect
        tfInput.autocorrectionType = UITextAutocorrectionType.no
        tfInput.keyboardType = UIKeyboardType.numberPad
        tfInput.returnKeyType = UIReturnKeyType.done
        tfInput.clearButtonMode = UITextField.ViewMode.whileEditing
        tfInput.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfInput.delegate = self
        scrollView.addSubview(tfInput)
        tfInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        
        let btnScan = UIImageView(frame:CGRect(x: tfInput.frame.size.width + tfInput.frame.origin.x + Common.Size(s: 10) , y:  tfInput.frame.origin.y, width: Common.Size(s:25), height: tfInput.frame.size.height));
        btnScan.image = #imageLiteral(resourceName: "MaGD")
        btnScan.contentMode = .scaleAspectFit
        scrollView.addSubview(btnScan)
        
        let tapScan = UITapGestureRecognizer(target: self, action: #selector(actionScan(_:)))
        btnScan.isUserInteractionEnabled = true
        btnScan.addGestureRecognizer(tapScan)
        
        btOK = UIButton()
        btOK.frame = CGRect(x: Common.Size(s:15), y: tfInput.frame.origin.y + tfInput.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: 0)
        btOK.backgroundColor = UIColor(netHex:0x00955E)
        btOK.setTitle("Đồng Ý", for: .normal)
        btOK.isEnabled = false
        btOK.addTarget(self, action: #selector(actionAddCart), for: .touchUpInside)
        btOK.layer.borderWidth = 0.5
        btOK.layer.borderColor = UIColor.white.cgColor
        btOK.layer.cornerRadius = 5.0
        scrollView.addSubview(btOK)
        
        viewHeader = UIView()
        viewHeader.frame = CGRect(x: 0, y:btOK.frame.origin.y + btOK.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewHeader.backgroundColor = UIColor.white
        viewHeader.clipsToBounds = true
        scrollView.addSubview(viewHeader)
        
        let label3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y:Common.Size(s:10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label3.text = "THÔNG TIN SẢN PHẨM"
        label3.font = UIFont.systemFont(ofSize: Common.Size(s: 16))
        viewHeader.addSubview(label3)
        

        
   
        
        lblEcom = UILabel(frame: CGRect(x: Common.Size(s:15), y:label3.frame.size.height + label3.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblEcom.textAlignment = .left
        lblEcom.textColor = UIColor.black
        lblEcom.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lblEcom.text = "Số ECOM"
        viewHeader.addSubview(lblEcom)
        
   
        
        lblHoTen = UILabel(frame: CGRect(x: Common.Size(s:15), y:lblEcom.frame.size.height + lblEcom.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblHoTen.textAlignment = .left
        lblHoTen.textColor = UIColor.black
        lblHoTen.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lblHoTen.text = "Họ Tên"
        viewHeader.addSubview(lblHoTen)

        
        lblSDT = UILabel(frame: CGRect(x: Common.Size(s:15), y:lblHoTen.frame.size.height + lblHoTen.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSDT.textAlignment = .left
        lblSDT.textColor = UIColor.red
        lblSDT.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lblSDT.text = "SĐT"
        viewHeader.addSubview(lblSDT)
        
        

        
        lblCreateDate = UILabel(frame: CGRect(x: Common.Size(s:15), y: lblSDT.frame.origin.y + lblSDT.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblCreateDate.textAlignment = .left
        lblCreateDate.textColor = UIColor.black
        lblCreateDate.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lblCreateDate.text = "Ngày Tạo"
        viewHeader.addSubview(lblCreateDate)
        
        lblTenSP = UILabel(frame: CGRect(x: Common.Size(s:15), y: lblCreateDate.frame.origin.y + lblCreateDate.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTenSP.textAlignment = .left
        lblTenSP.textColor = UIColor.black
        lblTenSP.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        viewHeader.addSubview(lblTenSP)
        
        
        lblSoTienCoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: lblTenSP.frame.origin.y + lblTenSP.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSoTienCoc.textAlignment = .left
        lblSoTienCoc.textColor = UIColor.red
        lblSoTienCoc.font = UIFont.systemFont(ofSize: Common.Size(s:14))
       viewHeader.addSubview(lblSoTienCoc)
    
        viewHeader.frame.size.height = lblSoTienCoc.frame.size.height + lblSoTienCoc.frame.origin.y
        self.heightViewHeader = viewHeader.frame.size.height
         viewHeader.frame.size.height = 0
    

        
        
        
        
    }
    
    @objc func backButton(){
//        navigationController?.popViewController(animated: false)
//        dismiss(animated: false, completion: nil)
        
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (textField == tfInput){
            self.actionnCheck()
        }
    }
    @objc func actionSkip(sender: UIBarButtonItem){
        self.tfInput.resignFirstResponder()
        let newViewController = SearchProductFFriendViewController()
        newViewController.ocfdFFriend = self.ocfdFFriend
       // newViewController.typeOrder = self.typeOrder!
        self.navigationController?.pushViewController(newViewController, animated: true)
        Cache.itemsPromotionTempFF.removeAll()
        Cache.cartsFF.removeAll()
        Cache.depositEcomNumFF = ""
        
    }
    @objc func actionAddCart(){
         self.tfInput.resignFirstResponder()
        Cache.promotionsFF.removeAll()
        Cache.groupFF = []
        Cache.itemsPromotionFF.removeAll()
        Cache.cartsFF = self.listCart
       

        //        if(Cache.typeOrder == "09"){
        let newViewController = CartFFriendViewController()
        newViewController.typeOrder = self.typeOrder!
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func actionnCheck(){
        if(self.tfInput.text! == ""){
            let title = "THÔNG BÁO"
            let popup = PopupDialog(title: title, message: "Vui lòng nhập số đơn hàng !!!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                self.tfInput.becomeFirstResponder()
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        self.tfInput.resignFirstResponder()
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra số đơn hàng ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_FRT_SP_Ecom_FFriend_load_SOEcom(EcomNum: self.tfInput.text! , CMND: "\(self.ocfdFFriend!.CMND)") { (status,header,detail,err) in
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    if(status.count > 0){
                        if(status[0].p_status == 1){
                            if(header.count > 0){
                                self.viewHeader.frame.origin.y = self.btOK.frame.size.height + self.btOK.frame.origin.y + Common.Size(s:10)
                                self.viewHeader.frame.size.height = self.heightViewHeader
                                self.lblHoTen.text = "Tên KH: \(header[0].Cardname)"
                                self.lblSDT.text = "SĐT: \(header[0].SDT)"
                                self.lblCreateDate.text = "Ngày Tạo: \(header[0].CreateDate)"
                                self.lblEcom.text = "Số Ecom: \(header[0].EcomNum)"
                                self.lblSoTienCoc.text = "Tổng tiền: \(Common.convertCurrencyFloat(number: header[0].Doctotal)) VNĐ"
                                Cache.depositEcomNumFF = "\(header[0].EcomNum)"
                            
                            }
                            if(detail.count > 0){
                                self.btOK.frame.size.height = self.tfInput.frame.size.height * 1.1
                                self.btOK.isEnabled = true
                                self.viewHeader.frame.origin.y = self.btOK.frame.size.height + self.btOK.frame.origin.y + Common.Size(s:10)
                        
                                self.listCart.removeAll()
                                self.lblTenSP.text = "Sản Phẩm: \(detail[0].ItemName)"
                                //self.lblGiaSP.text = "Giá: \(Common.convertCurrencyFloat(number: detail[0].Price)) VNĐ"
                           
                                
                                for item in detail{
                                    let pro = Product(model_id: "", id: item.ID, name: item.ItemName, brandID: item.BrandID, brandName: "", typeId: 0, typeName: "", sku: item.ItemCode, price: item.Price, priceMarket: item.PriceMarket, priceBeforeTax: item.PriceBeforeTax, iconUrl: item.linkAnh, imageUrl: item.iconUrl, promotion: "", includeInfo: item.IncludeInfo, hightlightsDes: item.HightlightsDes, labelName: item.LabelName, urlLabelPicture: item.iconUrl, isRecurring: false, manSerNum: item.ManSerNum, bonusScopeBoom: item.BonusScopeBoom, qlSerial: item.qlSerial,inventory: item.inventory, LableProduct: item.LableProduct,p_matkinh:"",ecomColorValue:"",ecomColorName:"", ecom_itemname_web: "",price_special: 0,price_online_pos: 0, price_online: 0, hotSticker: false, is_NK: false, is_ExtendedWar: false,skuBH: [],nameBH: [],brandGoiBH:[],isPickGoiBH:"",amountGoiBH:"",itemCodeGoiBH: "",itemNameGoiBH: "" ,priceSauKM: 0,role2: [])
                                    let cart = Cart(sku: item.ItemCode, product: pro,quantity: 1,color:"",inStock: -1, imei: "",price: item.Price, priceBT: item.PriceBeforeTax, whsCode: "", discount: 0, reason: "", note: "", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                    
                                    self.listCart.append(cart)
                                }
                                
                                
                                
                                
                                //        if(skuList.count >= 1){
                                //            skuList =  skuList.dropLast
                                //        }
                           
                                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.viewHeader.frame.origin.y + self.viewHeader.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
                                
                            }else{
                                self.btOK.frame.size.height = 0
                                self.btOK.isEnabled = false
                                self.viewHeader.frame.origin.y = self.btOK.frame.size.height + self.btOK.frame.origin.y + Common.Size(s:10)
                                self.viewHeader.frame.size.height = 0
                    
                                
                            }
                            
                            
                        }else{
                            let title = "THÔNG BÁO"
                            let popup = PopupDialog(title: title, message: status[0].p_messagess, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                self.btOK.frame.size.height = 0
                                self.btOK.isEnabled = false
                                self.viewHeader.frame.origin.y = self.btOK.frame.size.height + self.btOK.frame.origin.y + Common.Size(s:10)
                                self.viewHeader.frame.size.height = 0
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }
                    
                    
                    
                }else{
                    let title = "THÔNG BÁO"
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
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
    @objc func actionScan(_: UITapGestureRecognizer){

        self.actionnCheck()
    }
}
