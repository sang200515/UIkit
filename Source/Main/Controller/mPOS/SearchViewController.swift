//
//  SearchViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/7/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
import Foundation
import UIKit
import MIBadgeButton_Swift
import AVFoundation
import PopupDialog
import Toaster
public protocol SearchDelegate:AnyObject {
    func searchScanSuccess(text: String)
    func searchActionCart()
    func pushView(_ product:Product)
    func pushViewOld(_ product:ProductOld)
}

class SearchViewController: YNSearchViewController, YNSearchDelegate{
    func ynCategoryButtonClose() {
        self.navigationController?.popViewController(animated: false)
    }
    var btCartIcon:MIBadgeButton!
    var searchField: UITextField!
    weak var delegateSearchView:SearchDelegate?
    var isFFriend:Bool = false
    let ynSearch = YNSearch()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let demoCategories = ["iPhone Xs Max", "Samsung S20+", "Note 20", "iPhone 11"]
        
        
        
        ynSearch.setCategories(value: demoCategories)
        ynSearch.setConditionCheckStock(value: 1)
        self.ynSearchinit()
        
        self.delegate = self
        //        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.setYNCategoryButtonType(type: .colorful)
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(SearchViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        searchField = UITextField(frame: CGRect(x: 30, y: 20, width: width, height: 35))
        searchField.placeholder = "Nhập sp?"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 5
        searchField.tintColor = .black
        UITextField.appearance(whenContainedInInstancesOf: [type(of: searchField)]).tintColor = .black
        searchField.leftViewMode = .always
        let searchImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let searchImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        let search = UIImage(named: "search", in: Bundle(for: YNSearch.self), compatibleWith: nil)
        searchImageView.image = search
        searchImageViewWrapper.addSubview(searchImageView)
        searchField.leftView = searchImageViewWrapper
        
        if(!Cache.searchOld){
            searchField.rightViewMode = .always
            let searchImageRight = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
            let searchImageViewRight = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
            let scan = UIImage(named: "scan_barcode")
            searchImageViewRight.image = scan
            searchImageRight.addSubview(searchImageViewRight)
            searchField.rightView = searchImageRight
            let gestureSearchImageRight = UITapGestureRecognizer(target: self, action:  #selector(self.actionScan))
            searchImageRight.addGestureRecognizer(gestureSearchImageRight)
        }
        self.navigationItem.titleView = searchField
        searchField.delegate = self
        searchField.clearButtonMode = UITextField.ViewMode.whileEditing
        searchField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingChanged)
        //---
        //---
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
       
        btCartIcon = MIBadgeButton.init(type: .custom)
        btCartIcon.setImage(#imageLiteral(resourceName: "Filter"), for: UIControl.State.normal)
        btCartIcon.imageView?.contentMode = .scaleAspectFit
        btCartIcon.addTarget(self, action: #selector(handleShowPopUpFilterSearch), for: UIControl.Event.touchUpInside)
        btCartIcon.frame = CGRect(x: -5, y: 0, width: 50, height: 45)
        viewRightNav.addSubview(btCartIcon)
        let barButtonCart = UIBarButtonItem(customView: viewRightNav)
        //---
        let viewSwitch = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 50)))
  
        let switchCheckStock = UISwitch(frame: CGRect(x: 0, y: 8, width: 30, height: 10))

        switchCheckStock.onTintColor = .orange
        switchCheckStock.isOn = true // or false
        switchCheckStock.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        switchCheckStock.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        viewSwitch.addSubview(switchCheckStock)
        let switch_display = UIBarButtonItem(customView: viewSwitch)
        
        let lblStockLable = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 12, height: 20)))
        lblStockLable.font = UIFont.systemFont(ofSize: 15)
        lblStockLable.textColor = .white
        lblStockLable.text = "Tồn kho"
        let lblStock = UIBarButtonItem(customView: lblStockLable)
        self.navigationItem.rightBarButtonItems  = [barButtonCart,switch_display,lblStock]
    }
    // MARK: - UITextFieldDelegate
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        textField.endEditing(true)
        if !text.isEmpty {
            searchAction(key: text,isClickKey:false)
        }
        return true
    }
    @objc func actionCart() {
        self.navigationController?.popViewController(animated: false)
        delegateSearchView?.searchActionCart()
    }
    @objc func handleShowPopUpFilterSearch(){
        showFilterPopUp()
    }
    @objc func actionScan() {
        let viewController = ScanCodeViewController()
        viewController.scanSuccess = { text in
            self.delegateSearchView?.searchScanSuccess(text: text)
            self.navigationController?.popViewController(animated: false)
        }
        self.present(viewController, animated: false, completion: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let sum = Cache.carts.count
//        if(sum > 0){
//            btCartIcon.badgeString = "\(sum)"
//            btCartIcon.badgeTextColor = UIColor.white
//            btCartIcon.badgeEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 0, right: 12)
//        }else{
//            btCartIcon.badgeString = ""
//        }
        
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ynSearchListViewDidScroll() {
        self.ynSearchTextfieldView.ynSearchTextField.endEditing(true)
    }
    
    
    func ynSearchHistoryButtonClicked(text: String) {
        self.pushViewController(text: text)
        print(text)
    }
    
    func ynCategoryButtonClicked(text: String) {
        self.pushViewController(text: text)
        
        print(text)
    }
    
    func ynSearchListViewClicked(key: String) {
        self.pushViewController(text: key)
        print(key)
    }
    
    func ynSearchListViewClicked(object: Any) {
        print(object)
    }
    
    public override func pushView(_ product: Product) {
        print("\(product.name)")
        
        
        if(!isFFriend){
            Cache.sku = product.sku
            Cache.model_id = product.model_id
            let newViewController = DetailProductViewController()
            newViewController.product = product
            newViewController.isCompare = false
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            self.navigationController?.popViewController(animated: false)
            delegateSearchView?.pushView(product)
        }
    }
    
    public override func pushViewOld(_ product: ProductOld) {
        self.navigationController?.popViewController(animated: false)
        delegateSearchView?.pushViewOld(product)
    }
    public override func pushViewSO(_ item: PhoneNumberSearch,type: Int) {
        debugPrint("AAAAAAA \(item.CardName)")
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin đơn hàng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        let giaSim:Float = item.GiaSim
        if(item.LoaiDH == "01"){
            Cache.orderType = 1
        }
        if(item.LoaiDH == "02"){
            Cache.orderType = 2
        }
        if(item.LoaiDH == "03"){
            Cache.orderType = 3
        }
        MPOSAPIManager.mpos_FRT_SP_LoadSO_mpos_pre(docentry: "\(item.SOMPOS)", type: type) { (result, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(result != nil){
                        Cache.carts.removeAll()
                        Cache.itemsPromotion.removeAll()
                        
                        Cache.phone = result!.headers[0].LicTradNum
                        Cache.name = result!.headers[0].CardName
                        Cache.SO_POS = result!.headers[0].SO_POS
                        Cache.genderType = result!.headers[0].gender
                        Cache.vlBirthday = result!.headers[0].Birthday
                        Cache.email = result!.headers[0].Mail
                        Cache.address = result!.headers[0].Address
                        
                        Cache.NumberContract = result!.headers[0].NumberContract
                        Cache.period = result!.headers[0].period
                        Cache.IdentityCard = result!.headers[0].IdentityCard
                        Cache.IDFinancier = result!.headers[0].IDFinancier
                        Cache.LaiSuat = result!.headers[0].LaiSuat
                        Cache.SoTienTraTruocCache = result!.headers[0].SoTienTraTruoc
                        Cache.DocEntryEcomCache = result!.headers[0].DocEntry
                        Cache.phoneNumberBookSim = result!.headers[0].SDT_SSD
                        
                        if(result!.detailSPs.count > 0){
                            for item in result!.detailSPs{
                                ProductAPIManager.product_detais_by_sku(sku: item.ItemCode,handler: { (success , error) in
                                    if(success.count > 0){
                                        var product1:ProductBySku!
                                        product1 = success[0]
                                        let sku = product1.product.sku
                                        let colorProduct = product1.variant[0].colorValue
                                        let priceBeforeTax = product1.variant[0].priceBeforeTax
                                        var price:Float = 0
                                        if(item.ItemCode == "00503355"){
                                            price = giaSim
                                        }else{
                                            price = product1.variant[0].price
                                        }
                                        let product = product1.product.copy() as! Product
                                        product.sku = sku
                                        product.price = price
                                        product.priceBeforeTax = priceBeforeTax
                                        
                                        if(item.U_Imei != ""){

                                            let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: item.U_Imei,price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0, reason: "", note: "", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                            
                                            Cache.carts.append(cart)
                                            Cache.itemsPromotion.removeAll()
                                            
                                        }else{

                                            let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0, reason: "", note: "", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                            
                                            Cache.carts.append(cart)
                                            Cache.itemsPromotion.removeAll()
                                            
                                        }
                                        if(Cache.carts.count == result!.detailSPs.count){
                                            let newViewController = CartViewController()
                                            self.navigationController?.pushViewController(newViewController, animated: true)
                                        }
                                    }else{
                                        
                                    }
                                })
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
    func pushViewController(text:String) {
        self.searchAction(key: text,isClickKey: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    @IBAction func switchToggled(_ sender: UISwitch) {
        if sender.isOn {
            ynSearch.setConditionCheckStock(value: 1)
            
        }
        else{
            ynSearch.setConditionCheckStock(value: 0)
          
        }
        fetchGet_parameter_after_searchAPI()
       
    }
}
