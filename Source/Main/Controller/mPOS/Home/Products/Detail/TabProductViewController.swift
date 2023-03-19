//
//  TabProductViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
import UIKit
import Foundation
import Kingfisher
import QuartzCore
import StringExtensionHTML
import ActionSheetPicker_3_0
import NVActivityIndicatorView
import SnapKit
private let reuseIdentifierColor = "ItemColorCollectionViewCell"
private let reuseIdentifierProductAccessorie = "ProductAccessorieCell"
class TabProductViewController: UIViewController {
    
    // MARK: - Properties
    
    
    var sku : String!
    var scrollView:UIScrollView!
    var product:ProductBySku!
    var indexYBasic:CGFloat = 0
    var indexYBasicTemp:CGFloat = 0
    var viewInfoBasic:UIView!
    var lbInfoBasicMore:UILabel!
    var viewAccessories:UIView!
    var collectionView: UICollectionView!
    var productColor:UIView!
    var sameProducts:[SPTraGop] = []
    var isLoading:Bool = false
    var listSPTraGop:[SPTraGop] = []
    var replacementAccessories: [Variant] = []
    var replacementAccessoriesLabel: String = ""
    
    var listSPTraGopAll:[SPTraGop] = []
    var lstPMHThayThePKEcom:[PMHThayThePKEcom] = []
    private var collectionColorView: UICollectionView!
    private var headerLine:UIView!
    private var lbProductPrice:UILabel!
    private var headerProduct:UIView!
    private var lbProductName:UILabel!
    private var lbSku:UILabel!
    private var viewInfoPromotion:UIView!
    //
    private var viewTitleProduct:UIView!
    private var viewInfoPMH:UIView!
    private var viewInfoSameProduct:UIView!
    private var viewInfoDes:UIView!
    private var lbPromotion:UILabel!
    private var lbReplacementAccessories: UILabel!
    private var viewReplacementAccessories: UIView!
    private var replacementAccessoriesCollectionView: UICollectionView!
    private var imageProduct : UIImageView!
    private var lbProductPricePromotion:UILabel!
    private var lbProductPriceOnline:UILabel!
    private var lbProductPriceSpecial:UILabel!
    private var loading:NVActivityIndicatorView!
    private var hotSticker:UIImageView!
    private var is_NK:UIImageView!
    // MARK: - Lifecycle
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if (self.product != nil) {
            Cache.product = self.product
        }
        let frameLoading = CGRect(x: view.frame.size.width/2 - Common.Size(s:25), y:view.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50))
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor(netHex:0x00955E)
        loading = NVActivityIndicatorView(frame: frameLoading,
                                          type: .ballPulseSync)
        view.addSubview(loading)
        if(!isLoading){
            isLoading = true
            
            loading.startAnimating()
            
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "Sản phẩm"
        //        navigationController?.navigationBar.isTranslucent = false
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        isLoading = false
        sku = Cache.sku
        
        
        // call service
        if(Cache.model_id != ""){
            fetchProductByModelIdAPI()
        } else {
            fetchProductBySku()
        }
    }
    
    // MARK: - API
    
    func fetchProductByModelIdAPI(){
        ProductAPIManager.product_detais_by_model_id(model_id: "\(Cache.model_id)", sku: Cache.sku,handler: {[weak self] (success , error) in
            guard let self = self else {return}
            if(success.count > 0){
                Cache.product = success[0]
                Cache.segment = success[0].segment
                Cache.segmentSku = success[0].product.sku
                let variant = Cache.product!.variant.first(where: { $0.colorValue == Cache.product!.product.ecomColorValue })
                variant?.isSelected = true
                
                self.replacementAccessories = variant?.replacementAccessories?.variants ?? []
                self.replacementAccessoriesLabel = variant?.replacementAccessories?.text ?? ""
                self.fetchFRT_SP_mpos_loadSPTraGopAPI(price: success[0].product.price)
            }else{
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.loading.stopAnimating()
                }
            }
        })
    }
    
    func fetchProductBySku(){
        ProductAPIManager.product_detais_by_sku(sku: "\(sku!)",handler: { [weak self](success , error) in
            guard let self = self else {return}
            if(success.count > 0){
                Cache.product = success[0]
                Cache.segment = success[0].segment
                Cache.segmentSku = success[0].product.sku
                let variant = Cache.product!.variant.first(where: { $0.colorValue == Cache.product!.product.ecomColorValue })
                variant?.isSelected = true
                
                self.replacementAccessories = variant?.replacementAccessories?.variants ?? []
                self.replacementAccessoriesLabel = variant?.replacementAccessories?.text ?? ""
                self.fetchFRT_SP_mpos_loadSPTraGopAPI(price: success[0].product.price)
                
            }else{
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.loading.stopAnimating()
                }
            }
        })
    }
    
    func fetchFRT_SP_mpos_loadSPTraGopAPI(price:Float){
        MPOSAPIManager.FRT_SP_mpos_loadSPTraGop(MaSP: "\(self.sku ?? "")", DonGia: "\(String(format: "%.6f", price))", handler: { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.loading.stopAnimating()
                self.sameProducts = results
                if(results.count > 2){
                    self.listSPTraGopAll = results
                    for item in results {
                        self.listSPTraGop.append(item)
                        if(self.listSPTraGop.count == 2){
                            break
                        }
                    }
                }else{
                    self.listSPTraGop = results
                }
                self.fetchPMHThayThePK_ecomAPI()
            }
        })
    }
    func fetchPMHThayThePK_ecomAPI(){
        MPOSAPIManager.mpos_FRT_SP_list_PMHThayThePK_ecom(itemcode: "\(self.sku!)", handler: { [weak self](results, err) in
            guard let self = self else {return}
            if(results.count > 0){
                self.lstPMHThayThePKEcom = results
                self.fetchPromotionDetailAPI(product: Cache.product!,listSPTraGop:self.listSPTraGop)
            }else{
                self.fetchPromotionDetailAPI(product: Cache.product!,listSPTraGop:self.listSPTraGop)
            }
        })
    }
    
    func fetchPromotionDetailAPI(product:ProductBySku,listSPTraGop:[SPTraGop]){
        ProductAPIManager.get_promotions_detais(sku: product.product.sku,handler: { [weak self](detail , error) in
            guard let self = self else {return}
            if error == "" {
                product.product.promotion = detail
                self.loadProduct(product: product,listSPTraGop:listSPTraGop)
            }else{
                product.product.promotion = ""
                self.loadProduct(product: product,listSPTraGop:listSPTraGop)
            }
            
            
        })
    }
    private var listMaSpBH:[String] = []
    private var listNameSpBH:[String] = []
    private var listbrand:[String] = []
    private var listRole:[String] = []

    func fetchMaSpBHBySku(){
        if  Cache.carts.count == 0 {
            self.listMaSpBH = []
            self.listNameSpBH = []
            self.listbrand = []
            self.listRole = []
        }
        ProductAPIManager.get_listSpBH_detais(sku:self.sku,handler: { [weak self](result , error) in
            guard let self = self else {return}
            if error == "" {
                var listMaSP:[String] = []
                var listNameSP:[String] = []
                var listbrandSP:[String] = []
                var listRoleSP:[String] = []
                for item in result {
                    listMaSP.append(item.masp ?? "")
                    listNameSP.append(item.nameSP ?? "")
                    listbrandSP.append(item.brand ?? "")
                    listRoleSP.append(item.role2 ?? "")
                 

                }
                print("listRole \(listRoleSP)")
                self.listMaSpBH = listMaSP
                self.listNameSpBH = listNameSP
                self.listbrand = listbrandSP
                self.listRole = listRoleSP

                listMaSP.removeAll()
                listNameSP.removeAll()
                listbrandSP.removeAll()
                listRoleSP.removeAll()

            }
        })
    }
    func fetchPromotionDetailWhenChangeColorAPI(with variant:Variant){
        ProductAPIManager.get_promotions_detais(sku: variant.sku, handler: { [weak self](detail , error) in
            guard let self = self else {return}
            if error == "" {
                self.configurePromotionDetail(with: detail)
                self.reloadUI()
            }else{
                self.configurePromotionDetail(with: "")
                self.reloadUI()
            }
        })
    }
    
    
    func fetchMpos_FRT_SP_innovation_MDMH_SimAPI(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            ProductAPIManager.mpos_FRT_SP_innovation_MDMH_Sim(itemcode:self.product.product.sku,handler: { [weak self](results, err) in
                guard let self = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if(err.count <= 0){
                        if self.product.product.qlSerial == "Y" {
                            if self.product.product.is_ExtendedWar{
                                if self.product.product.amountGoiBH == "1" || self.product.product.amountGoiBH == "2"{
                                  
                                }else {
                                    self.product.product.amountGoiBH = ""
                                }
                                self.product.product.skuBH = self.listMaSpBH
                                self.product.product.nameBH = self.listNameSpBH
                                self.product.product.brandGoiBH = self.listbrand
                                self.product.product.role2 = self.listRole
                            }
                         
                            self.product.product.brandName = results[0].Brandname
                            self.product.product.labelName = results[0].p_sim
                            self.product.product.p_matkinh = results[0].p_matkinh
                            
                            let cart = Cart(sku: self.product.product.sku, product: self.product.product,quantity: 1,color:self.product.product.ecomColorValue,inStock:-1, imei: "N/A",price: self.product.product.price, priceBT: self.product.product.priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: self.replacementAccessoriesLabel)
            
                            let product1 = self.product.product.copy() as! Product
                            product1.amountGoiBH = ""
                            let cart2 = Cart(sku: self.product.product.sku, product: product1,quantity: 1,color:self.product.product.ecomColorValue,inStock:-1, imei: "N/A",price: self.product.product.price, priceBT: self.product.product.priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: self.replacementAccessoriesLabel)

                            if GoiBHInsertAt.CartAtIndex0.count == 0 {
                                GoiBHInsertAt.CartAtIndex0.append(cart2)
                            }
                            
                            if GoiBHInsertAt.CartAtIndex0.count == 1 && Cache.carts.count > 0 {
//                                GoiBHInsertAt.CartAtIndex0[0].product.amountGoiBH = ""
//                                GoiBHInsertAt.CartAtIndex0[0].product.amountGoiBH = ""
                                Cache.carts.append(GoiBHInsertAt.CartAtIndex0[0])
                                Cache.carts[Cache.carts.count - 1].product.amountGoiBH = ""
                                GoiBHInsertAt.CartAtIndex0.removeAll()
                            }else {
                                Cache.carts.append(cart)
                                Cache.carts[Cache.carts.count - 1].product.amountGoiBH = ""

                                GoiBHInsertAt.CartAtIndex0.removeAll()
                            }

                            self.listMaSpBH = []
                            self.listNameSpBH =  []
                            self.listbrand = []
                            self.listRole = []

                            Cache.itemsPromotion.removeAll()
                            let newViewController = CartViewController()
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }else{
                            //phu kien
                            if self.product.product.is_ExtendedWar {
                                if self.product.product.amountGoiBH == "1" || self.product.product.amountGoiBH == "2"{
                                  
                                }else {
                                    self.product.product.amountGoiBH = ""
                                }
                                self.product.product.skuBH = self.listMaSpBH
                                self.product.product.nameBH = self.listNameSpBH
                                self.product.product.brandGoiBH = self.listbrand
                                self.product.product.role2 = self.listRole

                            }
                    
                            self.product.product.brandName = results[0].Brandname
                            self.product.product.labelName = results[0].p_sim
                            self.product.product.p_matkinh = results[0].p_matkinh
                            var isCheckHaveSim = false // kiem tra gio hang da add sp goi cuoc hay chua
                            for item in Cache.carts {
                                if(item.product.labelName == "Y"){
                                    if(self.product.product.labelName == "Y"){
                                        isCheckHaveSim = true
                                    }
                                    
                                }
                                
                            }
                            if(isCheckHaveSim == true){
                                
                                self.showPopUp("Giỏ hàng chỉ được mua một sản phẩm gói cước !", "Thông báo", buttonTitle: "OK")
                                return
                            }
                            
                            
                            var check:Bool = false
                            
                            for item in Cache.carts {
                                if(item.product.labelName == "Y"){
                                    isCheckHaveSim = true
                                }
                                if (item.sku == self.sku){
                                    item.quantity = item.quantity + 1
                                    check = true
                                }
                            }
                            if results[0].p_MDMH == 3 {
                                self.product.product.id = results[0].p_MDMH
                            }
                            
                            if (check == false){
                                let cart = Cart(sku: self.product.product.sku, product: self.product.product,quantity: 1,color:self.product.product.ecomColorValue,inStock:-1, imei: "",price: self.product.product.price, priceBT: self.product.product.priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                Cache.carts.append(cart)
                                self.listMaSpBH = []
                                self.listNameSpBH =  []
                                self.listbrand = []
                                self.listRole = []
                                Cache.carts[Cache.carts.count - 1].product.amountGoiBH = ""

                            }

                            let newViewController = CartViewController()
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        }
                        
                        
                    }else{
                        self.showPopUp(err, "Thông báo", buttonTitle: "Đồng ý")
                    }
                    
                }
                
            })
            
        }
    }
    
    // MARK: - Selectors
    
    
    
    @objc
    func tapSelectSameProduct(sender:UITapGestureRecognizer) {
        let tag = sender.view!.tag
        
        let item:SPTraGop = sameProducts[tag]
        Cache.sku = item.ItemCode
        Cache.model_id = item.model_id
        let newViewController = DetailProductViewController()
        
        newViewController.isCompare = false
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func loadProduct(product:ProductBySku,listSPTraGop:[SPTraGop]) {
        self.product = product
        self.indexYBasic = 0
        //view product
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 2)
        scrollView.backgroundColor = UIColor(netHex: 0xEAEAEA)
        self.view.addSubview(scrollView)
        //        CGFloat((navigationController?.navigationBar.frame.size.height)!) + CGFloat(UIApplication.shared.statusBarFrame.height)
        //(CGFloat((navigationController?.navigationBar.frame.size.height)!) + CGFloat(UIApplication.shared.statusBarFrame.height))
        
        
        
        //name
        
        viewTitleProduct = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.width * 2/3))
        viewTitleProduct.backgroundColor = UIColor.white
        scrollView.addSubview(viewTitleProduct)
        
        let productName = "\(product.product.name)"
        
        let sizeProductName = productName.height(withConstrainedWidth: viewTitleProduct.frame.size.width - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:20)))
        
        lbProductName = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: viewTitleProduct.frame.size.width - Common.Size(s:10), height: sizeProductName))
        lbProductName.textAlignment = .center
        lbProductName.textColor = UIColor(netHex:0xD0021B)
        lbProductName.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
        lbProductName.text = productName
        lbProductName.numberOfLines = 3;
        // lbProductName.sizeToFit()
        viewTitleProduct.addSubview(lbProductName)
        viewTitleProduct.frame.size.height = lbProductName.frame.size.height + lbProductName.frame.origin.y
        
        headerProduct = UIView(frame: CGRect(x: 0, y: viewTitleProduct.frame.size.height + viewTitleProduct.frame.origin.y, width: scrollView.frame.size.width, height: scrollView.frame.size.width * 2/3))
        headerProduct.backgroundColor = UIColor.white
        scrollView.addSubview(headerProduct)
        //no
        lbSku = UILabel(frame: CGRect(x: 0, y: Common.Size(s:5), width: headerProduct.frame.size.width, height: Common.Size(s:12)))
        lbSku.textAlignment = .center
        lbSku.textColor = UIColor.lightGray
        lbSku.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSku.text = "(No.\(product.product.sku))"
        headerProduct.addSubview(lbSku)
        
        //image
        
        imageProduct  = UIImageView(frame:CGRect(x: 0, y: lbSku.frame.origin.y + lbSku.frame.size.height + 5, width: scrollView.frame.size.width/2 - 20, height: scrollView.frame.size.width/2 - 20));
        imageProduct.contentMode = .scaleAspectFit
        headerProduct.addSubview(imageProduct)
        
        configureImageProduct(with: product.product.imageUrl)
      
        //hot Sticker
        if  product.product.hotSticker{
			hotSticker = UIImageView()
			imageProduct.addSubview(hotSticker)
			hotSticker.image = UIImage(named: "ic_hot3")
			hotSticker.snp.makeConstraints { make in
				make.left.equalToSuperview()
				make.bottom.equalToSuperview()
				make.height.equalTo(30)
				make.width.equalTo(UIScreen.main.bounds.width * 0.25)
			}
			hotSticker.contentMode = .scaleToFill
        }
        //is_NK
        if  product.product.is_NK{
            
            is_NK = UIImageView(frame: CGRect(x: imageProduct.frame.size.width/5, y: 15, width: Common.Size(s:45), height: Common.Size(s:30)))
            is_NK.image = UIImage(named: "icNhapKhau")
            is_NK.frame.origin.x = imageProduct.frame.size.width/100
            imageProduct.addSubview(is_NK)
        }
        if(product.product.LableProduct != ""){
            let laiSuat = UILabel(frame: CGRect(x: imageProduct.frame.size.width/2, y: imageProduct.frame.origin.y + Common.Size(s:2), width: imageProduct.frame.size.width/2, height: Common.Size(s:20)))
            laiSuat.textAlignment = .center
            laiSuat.textColor = .white
            laiSuat.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            
            laiSuat.text = "\(product.product.LableProduct)"
            
            laiSuat.layer.cornerRadius = 5
            laiSuat.numberOfLines = 1
            laiSuat.backgroundColor = .red
            laiSuat.clipsToBounds = true
            
            headerProduct.addSubview(laiSuat)
            
        }
        
        headerLine = UIView(frame: CGRect(x: imageProduct.frame.origin.x + imageProduct.frame.size.width, y:imageProduct.frame.origin.y + imageProduct.frame.size.height/8, width: 0.5, height: imageProduct.frame.size.height * 2/3))
        headerLine.backgroundColor = UIColor.clear
        headerProduct.addSubview(headerLine)
        
        //name
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        
        
        
        lbProductPricePromotion = UILabel(frame: CGRect(x: headerLine.frame.origin.x - 5, y: headerLine.frame.origin.y, width: headerProduct.frame.size.width  , height: 0))
        lbProductPricePromotion.textAlignment = .left
        lbProductPricePromotion.textColor = UIColor(netHex:0xD0021B)
        lbProductPricePromotion.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        
        lbProductPricePromotion.numberOfLines = 3;
        headerProduct.addSubview(lbProductPricePromotion)
        
        
        
        
        
        lbProductPriceOnline = UILabel(frame: CGRect(x: headerLine.frame.origin.x - 1, y: headerLine.frame.origin.y, width: headerProduct.frame.size.width  , height: 0))
        lbProductPriceOnline.textAlignment = .left
        lbProductPriceOnline.textColor = UIColor(netHex:0xD0021B)
        lbProductPriceOnline.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        
        lbProductPriceOnline.numberOfLines = 3;
        headerProduct.addSubview(lbProductPriceOnline)
        
        
        
        
        lbProductPriceSpecial = UILabel(frame: CGRect(x: headerLine.frame.origin.x - 7 , y: headerLine.frame.origin.y , width: headerProduct.frame.size.width   , height: 0))
        lbProductPriceSpecial.textAlignment = .left
        lbProductPriceSpecial.textColor = UIColor(netHex:0xD0021B)
        
        lbProductPriceSpecial.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        
        lbProductPriceSpecial.numberOfLines = 3;
        headerProduct.addSubview(lbProductPriceSpecial)
        
        
        
        
        
        let lbProductPriceMarket = UILabel(frame: CGRect(x: headerLine.frame.origin.x - 5, y: lbProductPriceSpecial.frame.size.height + lbProductPriceSpecial.frame.origin.y, width: headerProduct.frame.size.width / 2 - Common.Size(s:5)  , height: 0))
        lbProductPriceMarket.textAlignment = .center
        lbProductPriceMarket.textColor = UIColor(netHex:0xD0021B)
        lbProductPriceMarket.font = UIFont.boldSystemFont(ofSize: Common.Size(s:22))
        
        lbProductPriceMarket.numberOfLines = 3;
        headerProduct.addSubview(lbProductPriceMarket)
        
        
        let sizeProductPrice: CGSize = productName.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:15))])
        lbProductPrice = UILabel(frame: CGRect(x: headerLine.frame.origin.x - 5 , y: headerLine.frame.origin.y + Common.Size(s:16), width: headerProduct.frame.size.width / 2 - Common.Size(s:5), height: sizeProductPrice.height))
        lbProductPrice.textAlignment = .center
        lbProductPrice.textColor =  UIColor(netHex:0x04AB6E)
        lbProductPrice.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        
        lbProductPrice.numberOfLines = 3;
        headerProduct.addSubview(lbProductPrice)
        configurePriceSpecial(with: product.product.sku)
        let objPrice =  product.variant.filter{ $0.sku == "\(product.product.sku)" }.first
        if(product.variant.count > 0){
            
            if(objPrice?.PriceOnlinePOS == 0.0 && objPrice?.PriceSpecial == 0.0){
                if(objPrice!.priceMarket != product.product.price){
                    
                    let productPriceMarket = "\(fmt.string(for: objPrice!.priceMarket)!)đ"
                    let sizeProductPriceMarket: CGSize = productPriceMarket.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:22))])
                    lbProductPriceMarket.frame.size.height = sizeProductPriceMarket.height
                    lbProductPriceMarket.text = productPriceMarket
                    
                    
                    let productPrice = "\(fmt.string(for: product.product.price)!)đ"
                    let sizeProductPrice: CGSize = productName.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:22))])
                    lbProductPrice.frame.origin.x = headerLine.frame.origin.x + Common.Size(s:5)
                    lbProductPrice.frame.origin.y = lbProductPriceMarket.frame.size.height + lbProductPriceMarket.frame.origin.y
                    lbProductPrice.frame.size.height = sizeProductPrice.height
                    
                    lbProductPrice.textColor =  UIColor(netHex:0x04AB6E)
                    lbProductPrice.text = productPrice
                    lbProductPrice.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
                    
                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: productPrice)
                    attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                    lbProductPrice.attributedText =  attributeString
                }else{
                    headerLine.frame.origin.y = imageProduct.frame.origin.y + imageProduct.frame.size.height/6
                    let productPrice = "\(fmt.string(for: product.product.price)!)đ"
                    let sizeProductPrice: CGSize = productName.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:22))])
                    lbProductPrice.frame.origin.x = headerLine.frame.origin.x + Common.Size(s:5)
                    lbProductPrice.frame.size.height = sizeProductPrice.height
                    lbProductPrice.textColor = UIColor(netHex:0x04AB6E)
                    //lbProductPrice.textColor =  UIColor(netHex:0xD0021B)
                    lbProductPrice.text = productPrice
                    
                    lbProductPrice.font = UIFont.boldSystemFont(ofSize: Common.Size(s:22))
                }
                
            }
        }
        
        
        //color
        if (product.variant.count <= 4 ){
            let height = (headerProduct.frame.size.width/8) * 1.6
            configureUICollectionView(height: height)
            
        }else if (product.variant.count > 4){
            let height = (headerProduct.frame.size.width/8) * 1.6  * 2
            configureUICollectionView(height: height)
            
        }else if (product.variant.count > 8){
            let height = (headerProduct.frame.size.width/8) * 1.6 * 3
            configureUICollectionView(height: height)
            
        }
        headerProduct.addSubview(collectionColorView)
        
        
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: headerLine.frame.origin.x + Common.Size(s:5), y: collectionColorView.frame.origin.y + collectionColorView.frame.size.height, width: headerProduct.frame.size.width / 2 - Common.Size(s:10), height: (headerProduct.frame.size.width / 2 - Common.Size(s:10)) * 0.25)
        btPay.backgroundColor = UIColor(netHex:0xD0021B)
        btPay.setTitle("Mua ngay", for: .normal)
        btPay.addTarget(self, action: #selector(cartAction(_:)), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        
        headerProduct.addSubview(btPay)
        //        headerProduct.backgroundColor = .red
        
        let lbBonus = UILabel(frame: CGRect(x: imageProduct.frame.origin.x, y: imageProduct.frame.origin.y + imageProduct.frame.size.height + Common.Size(s:10), width: imageProduct.frame.size.width, height: Common.Size(s:12)))
        lbBonus.textAlignment = .center
        lbBonus.textColor = UIColor.lightGray
        lbBonus.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbBonus.text = "(\(product.product.bonusScopeBoom))"
        headerProduct.addSubview(lbBonus)
        
        let lbCheckInStock = UILabel(frame: CGRect(x: btPay.frame.origin.x, y: btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s: 5), width: btPay.frame.size.width, height: btPay.frame.size.height/2))
        lbCheckInStock.textAlignment = .center
        lbCheckInStock.textColor = UIColor(netHex:0x04AB6E)
        lbCheckInStock.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute2 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString2 = NSAttributedString(string: "Tồn kho shop khác", attributes: underlineAttribute2)
        lbCheckInStock.attributedText = underlineAttributedString2
        headerProduct.addSubview(lbCheckInStock)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(TabProductViewController.tapShowCheckInStock))
        lbCheckInStock.isUserInteractionEnabled = true
        lbCheckInStock.addGestureRecognizer(tap2)
        
        //        headerProduct.frame.size.height = lbCheckInStock.frame.size.height + lbCheckInStock.frame.origin.y + Common.Size(s:10)
        
        //
        let lbCheckListImeiBook = UILabel(frame: CGRect(x: btPay.frame.origin.x, y: lbCheckInStock.frame.origin.y + lbCheckInStock.frame.size.height + Common.Size(s: 5), width: btPay.frame.size.width, height: btPay.frame.size.height/2))
        lbCheckListImeiBook.textAlignment = .center
        lbCheckListImeiBook.textColor = UIColor(netHex:0x1B4888)
        lbCheckListImeiBook.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        let underlineAttribute3 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString3 = NSAttributedString(string: "Xem danh sách IMEI", attributes: underlineAttribute3)
        lbCheckListImeiBook.attributedText = underlineAttributedString3
        headerProduct.addSubview(lbCheckListImeiBook)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(TabProductViewController.tapShowListImeiBook))
        lbCheckListImeiBook.isUserInteractionEnabled = true
        lbCheckListImeiBook.addGestureRecognizer(tap3)
        
        headerProduct.frame.size.height = lbCheckListImeiBook.frame.size.height + lbCheckListImeiBook.frame.origin.y + Common.Size(s:10)
        
        
        //
        
        viewInfoPromotion = UIView(frame: CGRect(x: 0, y: headerProduct.frame.size.height + headerProduct.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width, height: scrollView.frame.size.width * 2/3))
        viewInfoPromotion.backgroundColor = UIColor.white
        scrollView.addSubview(viewInfoPromotion)
        
        let lbInfoPromotion = UILabel(frame: CGRect(x: Common.Size(s:10), y: 0, width: viewInfoPromotion.frame.size.width -  Common.Size(s:20), height: Common.Size(s:35)))
        lbInfoPromotion.textAlignment = .left
        lbInfoPromotion.textColor = UIColor(netHex:0x04AB6E)
        lbInfoPromotion.backgroundColor = UIColor.white
        lbInfoPromotion.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbInfoPromotion.text = "Thông tin khuyến mãi"
        viewInfoPromotion.addSubview(lbInfoPromotion)
        
        
        lbPromotion = UILabel(frame: CGRect(x: Common.Size(s:10), y: lbInfoPromotion.frame.size.height + lbInfoPromotion.frame.origin.y, width: viewInfoPromotion.frame.size.width - Common.Size(s:20), height: 0))
        lbPromotion.textAlignment = .left
        lbPromotion.textColor = UIColor.black
        lbPromotion.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPromotion.numberOfLines = 50
        viewInfoPromotion.addSubview(lbPromotion)
        
        configurePromotionDetail(with: product.product.promotion)
        let tapInfoPromotion = UITapGestureRecognizer(target: self, action: #selector(TabProductViewController.tapShowPromos))
        viewInfoPromotion.isUserInteractionEnabled = true
        viewInfoPromotion.addGestureRecognizer(tapInfoPromotion)
        //
        
        viewInfoPMH = UIView(frame: CGRect(x: 0, y: viewInfoPromotion.frame.size.height + viewInfoPromotion.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width, height: 0))
        viewInfoPMH.backgroundColor = UIColor.white
        viewInfoPMH.clipsToBounds = true
        scrollView.addSubview(viewInfoPMH)
        if(self.lstPMHThayThePKEcom.count > 0){
            
            
            
            let lbInfoPMH = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s:10), width: viewInfoPromotion.frame.size.width -  Common.Size(s:10), height: Common.Size(s:20)))
            lbInfoPMH.textAlignment = .left
            lbInfoPMH.textColor = UIColor(netHex:0x04AB6E)
            
            lbInfoPMH.numberOfLines = 0
            lbInfoPMH.clipsToBounds = true
            lbInfoPMH.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
            lbInfoPMH.text = "PMH 120% THAY THẾ KHUYẾN MÃI HOTSALE"
            viewInfoPMH.addSubview(lbInfoPMH)
            
            let lbPMHText = UILabel(frame: CGRect(x: Common.Size(s:10), y: lbInfoPMH.frame.size.height + lbInfoPMH.frame.origin.y + Common.Size(s:10), width: viewInfoPromotion.frame.size.width -  Common.Size(s:10), height: Common.Size(s:20)))
            lbPMHText.textAlignment = .left
            lbPMHText.textColor = .red
            
            lbPMHText.clipsToBounds = true
            lbPMHText.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbPMHText.text = "PMH thay thế giá trị"
            viewInfoPMH.addSubview(lbPMHText)
            
            let lbPMHValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:lbPMHText.frame.origin.y , width: viewInfoPromotion.frame.size.width -  Common.Size(s:30), height: Common.Size(s:20)))
            lbPMHValue.textAlignment = .right
            lbPMHValue.textColor = .red
            
            lbPMHValue.clipsToBounds = true
            lbPMHValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbPMHValue.text = "\(Common.convertCurrencyV2(value: lstPMHThayThePKEcom[0].GiaMua))đ"
            viewInfoPMH.addSubview(lbPMHValue)
            
            let line0 = UIView(frame: CGRect(x: 0, y:lbPMHText.frame.size.height + lbPMHText.frame.origin.y + Common.Size(s:10), width: viewInfoPMH.frame.size.width , height: 1))
            line0.backgroundColor = UIColor(netHex:0x47B054)
            viewInfoPMH.addSubview(line0)
            
            let lbComboPMHText = UILabel(frame: CGRect(x: Common.Size(s:10), y: line0.frame.size.height + line0.frame.origin.y + Common.Size(s:10), width: viewInfoPromotion.frame.size.width -  Common.Size(s:10), height: Common.Size(s:20)))
            lbComboPMHText.textAlignment = .center
            lbComboPMHText.textColor = .red
            
            lbComboPMHText.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbComboPMHText.text = "Combo PHỤ KIỆN GỢI Ý"
            viewInfoPMH.addSubview(lbComboPMHText)
            
            let line1 = UIView(frame: CGRect(x: viewInfoPMH.frame.size.width * 2/3, y:lbComboPMHText.frame.origin.y + lbComboPMHText.frame.size.height + Common.Size(s:10), width: 1, height: Common.Size(s:1)))
            line1.backgroundColor = UIColor(netHex:0x47B054)
            line1.clipsToBounds = true
            viewInfoPMH.addSubview(line1)
            
            let line2 = UIView(frame: CGRect(x: 0, y:line1.frame.origin.y + line1.frame.size.height, width: viewInfoPMH.frame.size.width, height: 1))
            line2.backgroundColor = UIColor(netHex:0x47B054)
            viewInfoPMH.addSubview(line2)
            var indexY = line2.frame.origin.y
            var indexHeight: CGFloat = line2.frame.origin.y + line2.frame.size.height
            var num = 0
            for item in lstPMHThayThePKEcom{
                
                
                num = num + 1
                
                let soViewLine = UIView()
                viewInfoPMH.addSubview(soViewLine)
                soViewLine.frame = CGRect(x: 0, y: indexY, width: viewInfoPMH.frame.size.width, height: 50)
                let line3 = UIView(frame: CGRect(x: line1.frame.origin.x, y:0, width: 1, height: soViewLine.frame.size.height))
                line3.backgroundColor = UIColor(netHex:0x47B054)
                soViewLine.addSubview(line3)
                
                
                let lbSttValue = UILabel(frame: CGRect(x: line3.frame.origin.x + Common.Size(s:5), y: Common.Size(s:15), width: viewInfoPMH.frame.size.width - line3.frame.origin.x, height: Common.Size(s:15)))
                lbSttValue.textAlignment = .center
                lbSttValue.textColor = UIColor.black
                
                lbSttValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                lbSttValue.text = "\(Common.convertCurrencyV2(value: item.GiaPKSauGiam))đ"
                soViewLine.addSubview(lbSttValue)
                
                
                
                let line4 = UIView(frame: CGRect(x: 0, y:0, width: viewInfoPMH.frame.size.width , height: 1))
                line4.backgroundColor = UIColor(netHex:0x47B054)
                soViewLine.addSubview(line4)
                
                
                
                let nameProduct = "\(item.TenSP)"
                let sizeNameProduct = nameProduct.height(withConstrainedWidth: viewInfoPMH.frame.size.width , font: UIFont.systemFont(ofSize: Common.Size(s:14)))
                let lbNameProduct = UILabel(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: line1.frame.origin.x , height: sizeNameProduct + Common.Size(s:15)))
                lbNameProduct.textAlignment = .left
                lbNameProduct.textColor = UIColor.black
                lbNameProduct.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                lbNameProduct.text = nameProduct
                lbNameProduct.numberOfLines = 3
                soViewLine.addSubview(lbNameProduct)
                
                
                
                
                
                soViewLine.frame = CGRect(x: soViewLine.frame.origin.x, y: soViewLine.frame.origin.y, width: soViewLine.frame.size.width, height: lbNameProduct.frame.origin.y + lbNameProduct.frame.size.height + Common.Size(s:5))
                line3.frame.size.height = soViewLine.frame.size.height + Common.Size(s: 2)
                
                indexHeight = indexHeight + soViewLine.frame.size.height
                indexY = indexY + soViewLine.frame.size.height + soViewLine.frame.origin.x
                
                
                soViewLine.tag = num - 1
                
            }
            let line5 = UIView(frame: CGRect(x: 0, y:indexHeight , width: viewInfoPMH.frame.size.width , height: 1))
            line5.backgroundColor = UIColor(netHex:0x47B054)
            viewInfoPMH.addSubview(line5)
            
            let lbPMHKHTTText = UILabel(frame: CGRect(x: Common.Size(s:10), y: line5.frame.size.height + line5.frame.origin.y + Common.Size(s:10), width: viewInfoPromotion.frame.size.width -  Common.Size(s:10), height: Common.Size(s:20)))
            lbPMHKHTTText.textAlignment = .left
            lbPMHKHTTText.textColor = .red
            
            lbPMHKHTTText.clipsToBounds = true
            lbPMHKHTTText.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbPMHKHTTText.text = "KH thanh toán"
            viewInfoPMH.addSubview(lbPMHKHTTText)
            
            let lbPMHKHTTValue = UILabel(frame: CGRect(x: Common.Size(s:10), y:lbPMHKHTTText.frame.origin.y , width: viewInfoPromotion.frame.size.width -  Common.Size(s:30), height: Common.Size(s:20)))
            lbPMHKHTTValue.textAlignment = .right
            lbPMHKHTTValue.textColor = .red
            
            lbPMHKHTTValue.clipsToBounds = true
            lbPMHKHTTValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            lbPMHKHTTValue.text = "\(Common.convertCurrencyV2(value: lstPMHThayThePKEcom[0].GiaKhTra)) đ"
            viewInfoPMH.addSubview(lbPMHKHTTValue)
            
            viewInfoPMH.frame.size.height = lbPMHKHTTText.frame.size.height + lbPMHKHTTText.frame.origin.y + Common.Size(s: 5)
        }else{
            
            viewInfoPMH.frame.size.height = 0
        }
        
        
        
        
        //
        
        
        
        viewInfoSameProduct = UIView(frame: CGRect(x:  0, y: viewInfoPMH.frame.size.height + viewInfoPMH.frame.origin.y , width: scrollView.frame.size.width, height: 0))
        viewInfoSameProduct.backgroundColor = UIColor.white
        scrollView.addSubview(viewInfoSameProduct)
        
        let lbInfoSameProduct = UILabel(frame: CGRect(x: Common.Size(s:10), y: 0, width: viewInfoPromotion.frame.size.width -  Common.Size(s:20), height: Common.Size(s:35)))
        lbInfoSameProduct.textAlignment = .left
        lbInfoSameProduct.textColor = UIColor(netHex:0xD0021B)
        lbInfoSameProduct.backgroundColor = UIColor.white
        lbInfoSameProduct.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbInfoSameProduct.text = "SẢN PHẨM TƯ VẤN LÊN ĐỜI"
        viewInfoSameProduct.addSubview(lbInfoSameProduct)
        
        if(listSPTraGopAll.count > 0){
            let lbSameProductMore = UILabel(frame: CGRect(x: viewInfoSameProduct.frame.size.width/2, y: 0, width: viewInfoSameProduct.frame.size.width/2 - Common.Size(s:10), height: lbInfoSameProduct.frame.size.height))
            lbSameProductMore.textAlignment = .right
            lbSameProductMore.textColor = UIColor(netHex:0x04AB6E)
            lbSameProductMore.backgroundColor = UIColor.clear
            lbSameProductMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
            
            let underlineAttributeMore = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedStringMore = NSAttributedString(string: "Xem thêm", attributes: underlineAttributeMore)
            lbSameProductMore.attributedText = underlineAttributedStringMore
            viewInfoSameProduct.addSubview(lbSameProductMore)
            
            let tapSameProduct = UITapGestureRecognizer(target: self, action: #selector(TabProductViewController.tapShowMoreProduct))
            viewInfoSameProduct.isUserInteractionEnabled = true
            viewInfoSameProduct.addGestureRecognizer(tapSameProduct)
        }
        
        if(listSPTraGop.count <= 0){
            viewInfoSameProduct.clipsToBounds = true
            viewInfoSameProduct.frame.size.height = 0
        }else{
            var xItem:CGFloat = Common.Size(s: 10)
            var yItem:CGFloat = lbInfoSameProduct.frame.size.height + lbInfoSameProduct.frame.origin.y
            var count:Int = 0
            var heightItem:CGFloat = 0.0
            for item in listSPTraGop {
                let viewItemProduct = UIView(frame: CGRect(x: xItem, y: yItem, width: ((scrollView.frame.size.width - Common.Size(s:10)) - Common.Size(s:10))/2, height: scrollView.frame.size.width * 0.9))
                if(product.product.typeId == 3){
                    viewItemProduct.frame.size.height = scrollView.frame.size.width
                }
                //                viewItemProduct.backgroundColor = UIColor.red
                viewItemProduct.tag = count
                viewInfoSameProduct.addSubview(viewItemProduct)
                let tapSelectSameProduct = UITapGestureRecognizer(target: self, action: #selector(TabProductViewController.tapSelectSameProduct))
                viewItemProduct.isUserInteractionEnabled = true
                viewItemProduct.addGestureRecognizer(tapSelectSameProduct)
                
                //----
                let iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: viewItemProduct.frame.size.width, height:  viewItemProduct.frame.size.width - Common.Size(s:20)))
                iconImage.contentMode = .scaleAspectFit
                viewItemProduct.addSubview(iconImage)
                //                iconImage.backgroundColor = .red
                let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
                
                if let escapedString = item.ImageUrl.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                    print(escapedString)
                    let url = URL(string: "\(escapedString)")!
                    iconImage.kf.setImage(with: url,
                                          placeholder: nil,
                                          options: [.transition(.fade(1))],
                                          progressBlock: nil,
                                          completionHandler: nil)
                }
                
                let laiSuat = UILabel(frame: CGRect(x: viewItemProduct.frame.size.width/2, y: Common.Size(s:2), width: viewItemProduct.frame.size.width/2, height: Common.Size(s:16)))
                laiSuat.textAlignment = .center
                laiSuat.textColor = .white
                laiSuat.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
                if(item.LaiSuat == 0){
                    laiSuat.text = "Trả góp 0%"
                }else{
                    laiSuat.text = "Trả góp \(item.LaiSuat)%"
                }
                laiSuat.layer.cornerRadius = 3.0
                laiSuat.numberOfLines = 1
                laiSuat.backgroundColor = .red
                laiSuat.clipsToBounds = true
                
                viewItemProduct.addSubview(laiSuat)
                
                let heightTitel = item.TenSanPham.height(withConstrainedWidth: viewItemProduct.frame.size.width - Common.Size(s:4), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
                
                let title = UILabel(frame: CGRect(x: Common.Size(s:2), y: iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s:5), width: viewItemProduct.frame.size.width - Common.Size(s:4), height: heightTitel))
                title.textAlignment = .center
                title.textColor = UIColor.black
                title.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
                title.text = item.TenSanPham
                title.numberOfLines = 3
                viewItemProduct.addSubview(title)
                
                let num : UILabel = UILabel(frame: CGRect(x:0,y: title.frame.size.height + title.frame.origin.y,width: viewItemProduct.frame.size.width,height:Common.Size(s:11)))
                num.textColor = .gray
                num.textAlignment = .center
                num.font = UIFont.systemFont(ofSize: Common.Size(s:11))
                viewItemProduct.addSubview(num)
                num.text = "\(item.DiemThuong) (\(item.SL))"
                
                let price = UILabel(frame: CGRect(x: Common.Size(s:2), y: num.frame.size.height + num.frame.origin.y + Common.Size(s:4), width: viewItemProduct.frame.size.width - 4, height: Common.Size(s:14)))
                price.textAlignment = .center
                price.textColor = UIColor(netHex:0xEF4A40)
                price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
                price.text = Common.convertCurrencyFloat(value: Float(item.Price)!)
                price.numberOfLines = 1
                viewItemProduct.addSubview(price)
                
                let docentry = UILabel(frame: CGRect(x: Common.Size(s:2), y: price.frame.size.height + price.frame.origin.y + Common.Size(s:4), width: viewItemProduct.frame.size.width - 4, height: Common.Size(s:14)))
                docentry.textAlignment = .center
                docentry.textColor = UIColor(netHex:0x47B054)
                docentry.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
                docentry.text = "\(item.docentry)"
                docentry.numberOfLines = 1
                viewItemProduct.addSubview(docentry)
                
                let soTienTraTruoc = UILabel(frame: CGRect(x: Common.Size(s:2), y: docentry.frame.size.height + docentry.frame.origin.y + Common.Size(s:2), width: viewItemProduct.frame.size.width - 4, height: Common.Size(s:13)))
                soTienTraTruoc.textAlignment = .center
                soTienTraTruoc.textColor = UIColor.orange
                soTienTraTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                soTienTraTruoc.text = "Trả trước \(Common.convertCurrencyFloat(value: Float(item.SoTienTraTruoc)))"
                soTienTraTruoc.numberOfLines = 1
                viewItemProduct.addSubview(soTienTraTruoc)
                
                let kyHan = UILabel(frame: CGRect(x: Common.Size(s:2), y: soTienTraTruoc.frame.size.height + soTienTraTruoc.frame.origin.y + Common.Size(s:2), width: viewItemProduct.frame.size.width - 4, height: Common.Size(s:13)))
                kyHan.textAlignment = .center
                kyHan.textColor = UIColor.darkGray
                kyHan.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                kyHan.text = "Kỳ hạn \(item.KyHan) tháng"
                kyHan.numberOfLines = 1
                viewItemProduct.addSubview(kyHan)
                
                let btCompare = UIButton()
                btCompare.tag = count
                btCompare.frame = CGRect(x: viewItemProduct.frame.size.width / 4, y: kyHan.frame.origin.y + kyHan.frame.size.height + Common.Size(s: 5), width: viewItemProduct.frame.size.width / 2, height: viewItemProduct.frame.size.width / 5)
                btCompare.backgroundColor = UIColor(netHex:0x04AB6E)
                btCompare.setTitle("So sánh", for: .normal)
                btCompare.addTarget(self, action: #selector(tapSelectCompare), for: .touchUpInside)
                btCompare.layer.borderWidth = 0.5
                btCompare.layer.borderColor = UIColor.white.cgColor
                btCompare.layer.cornerRadius = 5.0
                viewItemProduct.addSubview(btCompare)
                //----
                
                if(count == 0){
                    xItem = viewItemProduct.frame.origin.x + viewItemProduct.frame.size.width + Common.Size(s:5)
                }else if(count == 1){
                    xItem = Common.Size(s: 10)
                    yItem = viewItemProduct.frame.size.height + viewItemProduct.frame.origin.y
                    
                }else if(count == 2){
                    xItem = viewItemProduct.frame.origin.x + viewItemProduct.frame.size.width + Common.Size(s:5)
                }else{
                    //                       heightItem = viewItemProduct.frame.size.height + viewItemProduct.frame.origin.y
                }
                if(heightItem < viewItemProduct.frame.size.height + viewItemProduct.frame.origin.y){
                    heightItem = viewItemProduct.frame.size.height + viewItemProduct.frame.origin.y
                }
                count = count + 1
            }
            viewInfoSameProduct.frame.size.height = heightItem
        }
        
        ///
        viewReplacementAccessories = UIView(frame: CGRect(x: 0, y: viewInfoSameProduct.frame.size.height + viewInfoSameProduct.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width, height: scrollView.frame.size.width * 3/4))
        viewReplacementAccessories.backgroundColor = UIColor.white
        scrollView.addSubview(viewReplacementAccessories)
        
        lbReplacementAccessories = UILabel(frame: CGRect(x: Common.Size(s:10), y: 0, width: viewReplacementAccessories.frame.size.width - Common.Size(s:20), height: Common.Size(s:35)))
        lbReplacementAccessories.textAlignment = .left
        lbReplacementAccessories.textColor = UIColor(netHex:0x04AB6E)
        lbReplacementAccessories.backgroundColor = UIColor.white
        lbReplacementAccessories.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbReplacementAccessories.text = " \(replacementAccessoriesLabel)"
        viewReplacementAccessories.addSubview(lbReplacementAccessories)
        
        // Do any additional setup after loading the view, typically from a nib.
        let replacementAccessoriesLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        replacementAccessoriesLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        replacementAccessoriesLayout.sectionInset = UIEdgeInsets(top: Common.Size(s:5)/2, left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        replacementAccessoriesLayout.itemSize = CGSize(width: (viewReplacementAccessories.frame.size.width - Common.Size(s:10))/2, height: viewReplacementAccessories.frame.size.height - (lbReplacementAccessories.frame.origin.y + lbReplacementAccessories.frame.size.height) - Common.Size(s:10))
        replacementAccessoriesLayout.minimumInteritemSpacing = 0;
        replacementAccessoriesLayout.minimumLineSpacing = Common.Size(s:5)/2
        replacementAccessoriesCollectionView = UICollectionView(frame: CGRect(x: 0, y: lbReplacementAccessories.frame.origin.y + lbReplacementAccessories.frame.size.height + 5, width: viewReplacementAccessories.frame.size.width, height: viewReplacementAccessories.frame.size.height - (lbReplacementAccessories.frame.origin.y + lbReplacementAccessories.frame.size.height) - Common.Size(s:10)), collectionViewLayout: replacementAccessoriesLayout)
        replacementAccessoriesCollectionView.dataSource = self
        replacementAccessoriesCollectionView.delegate = self
        replacementAccessoriesCollectionView.showsHorizontalScrollIndicator = false
        replacementAccessoriesCollectionView.register(ProductAccessorieCell.self, forCellWithReuseIdentifier: reuseIdentifierProductAccessorie)
        replacementAccessoriesCollectionView.backgroundColor = UIColor.white
        viewReplacementAccessories.addSubview(replacementAccessoriesCollectionView)
        
        if replacementAccessories.count > 0 {
            viewReplacementAccessories.frame = CGRect(x: 0, y: viewInfoSameProduct.frame.size.height + viewInfoSameProduct.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width, height: scrollView.frame.size.width * 3/4)
            lbReplacementAccessories.frame = CGRect(x: Common.Size(s:10), y: 0, width: viewReplacementAccessories.frame.size.width - Common.Size(s:20), height: Common.Size(s:35))
            replacementAccessoriesCollectionView.frame = CGRect(x: 0, y: lbReplacementAccessories.frame.origin.y + lbReplacementAccessories.frame.size.height + 5, width: viewReplacementAccessories.frame.size.width, height: viewReplacementAccessories.frame.size.height - (lbReplacementAccessories.frame.origin.y + lbReplacementAccessories.frame.size.height) - Common.Size(s:10))
            replacementAccessoriesCollectionView.reloadData()
        } else {
            viewReplacementAccessories.frame = CGRect(x: 0, y: viewInfoSameProduct.frame.size.height + viewInfoSameProduct.frame.origin.y, width: scrollView.frame.size.width, height: 0)
            lbReplacementAccessories.frame = CGRect(x: Common.Size(s:10), y: 0, width: viewReplacementAccessories.frame.size.width - Common.Size(s:20), height: 0)
            replacementAccessoriesCollectionView.frame = CGRect(x: 0, y: lbReplacementAccessories.frame.origin.y + lbReplacementAccessories.frame.size.height + 5, width: viewReplacementAccessories.frame.size.width, height: 0)
        }
        ///
        var indexYDes = viewReplacementAccessories.frame.size.height + viewReplacementAccessories.frame.origin.y + Common.Size(s:10)
        viewInfoDes = UIView(frame: CGRect(x: 0, y: indexYDes, width: viewInfoPromotion.frame.size.width, height: 0))
        viewInfoDes.backgroundColor = UIColor.white
        scrollView.addSubview(viewInfoDes)
        if (product.product.hightlightsDes.count > 0){
            
            
            let lbInfoDes = UILabel(frame: CGRect(x: Common.Size(s: 10), y: 0, width: viewInfoPromotion.frame.size.width , height: Common.Size(s:30)))
            lbInfoDes.textAlignment = .left
            lbInfoDes.textColor = UIColor(netHex:0x04AB6E)
            lbInfoDes.backgroundColor = UIColor.white
            lbInfoDes.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbInfoDes.text = "Điểm nổi bật"
            viewInfoDes.addSubview(lbInfoDes)
            let proText2 = "<font size=\"4\">\(product.product.hightlightsDes)</font>".htmlToString
            let sizeDes =  proText2.height(withConstrainedWidth: viewInfoPromotion.frame.size.width - Common.Size(s:20), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbDes = UILabel(frame: CGRect(x: Common.Size(s:10), y: lbInfoDes.frame.size.height + lbInfoDes.frame.origin.y, width: viewInfoDes.frame.size.width - Common.Size(s:20), height: sizeDes))
            lbDes.textAlignment = .left
            lbDes.textColor = UIColor.black
            lbDes.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbDes.numberOfLines = 20
            viewInfoDes.addSubview(lbDes)
            lbDes.attributedText = "<font size=\"4\">\(product.product.hightlightsDes)</font>".htmlToAttributedString
            lbDes.sizeToFit()
            viewInfoDes.frame.size.height = lbDes.frame.origin.y + lbDes.frame.size.height + Common.Size(s:5)
            
            indexYDes = viewInfoDes.frame.size.height + viewInfoDes.frame.origin.y + Common.Size(s:10)
        }
        //
        viewInfoBasic = UIView(frame: CGRect(x: 0, y: indexYDes, width: viewInfoPromotion.frame.size.width, height: scrollView.frame.size.width * 2/3))
        viewInfoBasic.backgroundColor = UIColor.white
        scrollView.addSubview(viewInfoBasic)
        
        let lbInfoBasic = UILabel(frame: CGRect(x: Common.Size(s: 10), y: 0, width: viewInfoBasic.frame.size.width - Common.Size(s: 20), height: Common.Size(s:35)))
        lbInfoBasic.textAlignment = .left
        lbInfoBasic.textColor = UIColor(netHex:0x04AB6E)
        lbInfoBasic.backgroundColor = UIColor.white
        lbInfoBasic.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbInfoBasic.text = "Thông số cơ bản"
        viewInfoBasic.addSubview(lbInfoBasic)
        
        lbInfoBasicMore = UILabel(frame: CGRect(x: viewInfoBasic.frame.size.width/2, y: 0, width: lbInfoBasic.frame.size.width/2 - Common.Size(s:10), height: lbInfoBasic.frame.size.height))
        lbInfoBasicMore.textAlignment = .right
        lbInfoBasicMore.textColor = UIColor(netHex:0x04AB6E)
        lbInfoBasicMore.backgroundColor = UIColor.white
        lbInfoBasicMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Hiện chi tiết", attributes: underlineAttribute)
        lbInfoBasicMore.attributedText = underlineAttributedString
        viewInfoBasic.addSubview(lbInfoBasicMore)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(TabProductViewController.tapShowDetail))
        lbInfoBasicMore.isUserInteractionEnabled = true
        lbInfoBasicMore.addGestureRecognizer(tap)
        
        indexYBasic = lbInfoBasic.frame.size.height + lbInfoBasic.frame.origin.y
        
        for item in product.atrribute {
            if (item.group == "Thông số cơ bản"){
                
                var indxGroup:Int = 0
                for atrribute in item.attributes {
                    
                    let viewInfoBasicRow = UIView(frame: CGRect(x: Common.Size(s:10), y: indexYBasic, width: viewInfoBasic.frame.size.width - Common.Size(s: 20), height: 50))
                    
                    viewInfoBasic.addSubview(viewInfoBasicRow)
                    
                    if indxGroup % 2 != 0 {
                        viewInfoBasicRow.backgroundColor  = UIColor(white: 242/255.0, alpha: 1.0)
                    } else {
                        viewInfoBasicRow.backgroundColor = UIColor.white
                    }
                    
                    let viewInfoBasicLine = UIView(frame: CGRect(x: viewInfoBasicRow.frame.size.width * 3/10, y: 0, width: 0.5, height: viewInfoBasicRow.frame.size.height))
                    viewInfoBasicLine.backgroundColor = UIColor.clear
                    viewInfoBasicRow.addSubview(viewInfoBasicLine)
                    
                    
                    let heightLb = "\(atrribute.name)".height(withConstrainedWidth: viewInfoBasicLine.frame.origin.x - 10, font: UIFont.systemFont(ofSize: Common.Size(s:13)))
                    
                    let lbBasicRow = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicLine.frame.origin.x - Common.Size(s:10), height: heightLb))
                    lbBasicRow.textAlignment = .left
                    lbBasicRow.textColor = UIColor.black
                    lbBasicRow.font = UIFont.systemFont(ofSize: Common.Size(s:13))
                    lbBasicRow.text = "\(atrribute.name)"
                    lbBasicRow.numberOfLines = 4
                    viewInfoBasicRow.addSubview(lbBasicRow)
                    
                    let heightValue = "\(atrribute.value)".height(withConstrainedWidth: viewInfoBasicRow.frame.size.width - viewInfoBasicLine.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:13)))
                    
                    let lbBasicValue = UILabel(frame: CGRect(x:viewInfoBasicLine.frame.origin.x + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow.frame.size.width - viewInfoBasicLine.frame.origin.x - Common.Size(s:10), height: heightValue))
                    lbBasicValue.textAlignment = .left
                    lbBasicValue.textColor = UIColor.black
                    lbBasicValue.font = UIFont.systemFont(ofSize: Common.Size(s:13))
                    lbBasicValue.text = "\(atrribute.value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))"
                    lbBasicValue.numberOfLines = 10
                    viewInfoBasicRow.addSubview(lbBasicValue)
                    
                    if (heightLb > heightValue){
                        viewInfoBasicRow.frame.size.height = lbBasicRow.frame.origin.y + lbBasicRow.frame.size.height + Common.Size(s:10)
                    }else{
                        viewInfoBasicRow.frame.size.height = lbBasicValue.frame.origin.y + lbBasicValue.frame.size.height + Common.Size(s:10)
                    }
                    viewInfoBasicLine.frame.size.height = viewInfoBasicRow.frame.size.height
                    let viewInfoBasicLineHeader = UIView(frame: CGRect(x: 0, y: 0, width: viewInfoBasicRow.frame.size.width, height: 0.5))
                    viewInfoBasicLineHeader.backgroundColor = UIColor.clear
                    viewInfoBasicRow.addSubview(viewInfoBasicLineHeader)
                    
                    indexYBasic = viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y
                    
                    indxGroup = indxGroup + 1
                }
                break
            }
            
        }
        
        indexYBasicTemp = indexYBasic
        viewInfoBasic.frame.size.height = indexYBasic
        
        //
        if(product.accessories.count > 0){
            
            viewAccessories = UIView(frame: CGRect(x: 0, y: viewInfoBasic.frame.size.height + viewInfoBasic.frame.origin.y + Common.Size(s:10), width: viewInfoBasic.frame.size.width , height: scrollView.frame.size.width * 3/4))
            viewAccessories.backgroundColor = UIColor.white
            scrollView.addSubview(viewAccessories)
            
            let lbAccessories = UILabel(frame: CGRect(x: Common.Size(s:10), y: 0, width: viewInfoPromotion.frame.size.width, height: Common.Size(s:35)))
            lbAccessories.textAlignment = .left
            lbAccessories.textColor = UIColor(netHex:0x04AB6E)
            lbAccessories.backgroundColor = UIColor.white
            lbAccessories.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbAccessories.text = "Phụ kiện tương thích"
            viewAccessories.addSubview(lbAccessories)
            
            
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewAccessories.frame.origin.y + viewAccessories.frame.size.height + Common.Size(s:20))
            
            
            //view
            // Do any additional setup after loading the view, typically from a nib.
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            layout.sectionInset = UIEdgeInsets(top: Common.Size(s:5)/2, left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
            
            layout.itemSize = CGSize(width: (viewAccessories.frame.size.width - Common.Size(s:10))/2, height: viewAccessories.frame.size.height - (lbAccessories.frame.origin.y + lbAccessories.frame.size.height) - Common.Size(s:10))
            layout.minimumInteritemSpacing = 0;
            layout.minimumLineSpacing = Common.Size(s:5)/2
            collectionView = UICollectionView(frame: CGRect(x: 0, y: lbAccessories.frame.origin.y + lbAccessories.frame.size.height + 5, width: viewAccessories.frame.size.width, height: viewAccessories.frame.size.height - (lbAccessories.frame.origin.y + lbAccessories.frame.size.height) - Common.Size(s:10)), collectionViewLayout: layout)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(ProductAccessorieCell.self, forCellWithReuseIdentifier: reuseIdentifierProductAccessorie)
            collectionView.backgroundColor = UIColor.white
            viewAccessories.addSubview(collectionView)
            
        }else{
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBasic.frame.origin.y + viewInfoBasic.frame.size.height + Common.Size(s:20))
        }
    }
    
    
    @objc func tapShowMoreProduct(sender:UITapGestureRecognizer){
        let vc = MoreProductViewController()
        vc.listSPTraGopAll = listSPTraGopAll
        vc.product = self.product
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapShowPromos(sender:UITapGestureRecognizer) {
        let myVC = PopupPromostionViewController()
        myVC.content = "<font size=\"4\">\(product.product.promotion)</font>"
        let navController = UINavigationController(rootViewController: myVC)
        self.navigationController?.present(navController, animated:true, completion: nil)
    }
    @objc func tapShowCheckInStock(sender:UITapGestureRecognizer) {
        var listSku = ""
        for item in product.variant {
            if(listSku == ""){
                listSku = "\(item.sku)"
            }else{
                listSku = "\(listSku),\(item.sku)"
            }
        }
        print("You selected cell \(listSku)")
        let newViewController = ShopInventoryViewController()
        newViewController.listSku = listSku
        newViewController.productName = "\(product.product.name)"
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    @objc func tapShowListImeiBook(){
        let newViewController = ImeiBookViewController()
        newViewController.sku = self.product.product.sku
        
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    
    @objc func tapShowDetail(sender:UITapGestureRecognizer) {
        print("tap working")
        if (indexYBasicTemp == indexYBasic){
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: "Ẩn chi tiết", attributes: underlineAttribute)
            lbInfoBasicMore.attributedText = underlineAttributedString
            for item in product.atrribute {
                if (item.group != "Thông số cơ bản"){
                    let lbInfoBasic = UILabel(frame: CGRect(x: Common.Size(s: 10), y: indexYBasic, width: viewInfoBasic.frame.size.width, height: Common.Size(s:35)))
                    lbInfoBasic.textAlignment = .left
                    lbInfoBasic.textColor = UIColor(netHex:0x04AB6E)
                    lbInfoBasic.backgroundColor = UIColor.white
                    lbInfoBasic.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                    lbInfoBasic.text = " \(item.group)"
                    viewInfoBasic.addSubview(lbInfoBasic)
                    indexYBasic = lbInfoBasic.frame.size.height + lbInfoBasic.frame.origin.y
                    var indxGroup:Int = 0
                    for atrribute in item.attributes {
                        
                        let viewInfoBasicRow = UIView(frame: CGRect(x: Common.Size(s:10), y: indexYBasic, width: viewInfoBasic.frame.size.width - Common.Size(s: 20), height: 50))
                        
                        viewInfoBasic.addSubview(viewInfoBasicRow)
                        
                        
                        if indxGroup % 2 != 0 {
                            viewInfoBasicRow.backgroundColor  = UIColor(white: 242/255.0, alpha: 1.0)
                        } else {
                            viewInfoBasicRow.backgroundColor = UIColor.white
                        }
                        
                        
                        let viewInfoBasicLine = UIView(frame: CGRect(x: viewInfoBasicRow.frame.size.width * 3/10, y: 0, width: 0.5, height: viewInfoBasicRow.frame.size.height))
                        viewInfoBasicLine.backgroundColor = UIColor.clear
                        viewInfoBasicRow.addSubview(viewInfoBasicLine)
                        
                        
                        let heightLb = "\(atrribute.name)".height(withConstrainedWidth: viewInfoBasicLine.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:13)))
                        
                        let lbBasicRow = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicLine.frame.origin.x - Common.Size(s:10), height: heightLb))
                        lbBasicRow.textAlignment = .left
                        lbBasicRow.textColor = UIColor.black
                        lbBasicRow.font = UIFont.systemFont(ofSize: Common.Size(s:13))
                        lbBasicRow.text = "\(atrribute.name)"
                        lbBasicRow.numberOfLines = 4
                        viewInfoBasicRow.addSubview(lbBasicRow)
                        
                        var heightValue = "\(atrribute.value)".height(withConstrainedWidth: viewInfoBasicRow.frame.size.width - viewInfoBasicLine.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:13)))
                        if (heightLb > heightValue){
                            heightValue = heightLb
                        }
                        
                        let lbBasicValue = UILabel(frame: CGRect(x:viewInfoBasicLine.frame.origin.x + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow.frame.size.width - viewInfoBasicLine.frame.origin.x - Common.Size(s:10), height: heightValue))
                        lbBasicValue.textAlignment = .left
                        lbBasicValue.textColor = UIColor.black
                        lbBasicValue.font = UIFont.systemFont(ofSize: Common.Size(s:13))
                        lbBasicValue.text = "\(atrribute.value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))"
                        lbBasicValue.numberOfLines = 10
                        viewInfoBasicRow.addSubview(lbBasicValue)
                        
                        if (heightLb > heightValue){
                            viewInfoBasicRow.frame.size.height = lbBasicRow.frame.origin.y + lbBasicRow.frame.size.height + Common.Size(s:10)
                        }else{
                            viewInfoBasicRow.frame.size.height = lbBasicValue.frame.origin.y + lbBasicValue.frame.size.height + Common.Size(s:10)
                        }
                        viewInfoBasicLine.frame.size.height = viewInfoBasicRow.frame.size.height
                        let viewInfoBasicLineHeader = UIView(frame: CGRect(x: 0, y: 0, width: viewInfoBasicRow.frame.size.width, height: 0.5))
                        viewInfoBasicLineHeader.backgroundColor = UIColor.clear
                        viewInfoBasicRow.addSubview(viewInfoBasicLineHeader)
                        
                        indexYBasic = viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y
                        indxGroup = indxGroup + 1
                    }
                    
                }
            }
            
        }else{
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: "Hiện chi tiết", attributes: underlineAttribute)
            lbInfoBasicMore.attributedText = underlineAttributedString
            indexYBasic = indexYBasicTemp
        }
        viewInfoBasic.frame.size.height = indexYBasic + Common.Size(s: 10)
        viewInfoBasic.clipsToBounds = true
        if(viewAccessories != nil){
            viewAccessories.frame.origin.y = viewInfoBasic.frame.size.height + viewInfoBasic.frame.origin.y + Common.Size(s:10)
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewAccessories.frame.origin.y + viewAccessories.frame.size.height + Common.Size(s:20))
            
        }else{
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBasic.frame.origin.y + viewInfoBasic.frame.size.height + Common.Size(s:20))
        }
    }
    @objc func tapSelectCompare(sender:UIButton) {
        let tag = sender.tag
        let item = listSPTraGop[tag]
        if(self.product.product.typeId == 3){
            let vc = CompareProductsLaptopViewController()
            vc.product = self.product
            vc.productCompare = item
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = CompareProductsViewController()
            vc.product = self.product
            vc.productCompare = item
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    @objc func cartAction(_ sender:UITapGestureRecognizer){
        
        if product.variant.count > 1 {
            if product.variant.filter({ $0.isSelected == true}).first != nil{
                fetchMpos_FRT_SP_innovation_MDMH_SimAPI()
                fetchMaSpBHBySku()
            }else{
                showPopUp("Bạn vui lòng chọn Màu sản phẩm trong danh sách đang có", "Thông báo", buttonTitle: "OK")
            }
        }else{
            fetchMpos_FRT_SP_innovation_MDMH_SimAPI()
            fetchMaSpBHBySku()
        }
        
        
        
        
    }
    
    // MARK: - Helpers
    func configureUICollectionView(height:CGFloat){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:10), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        //layout.itemSize = CGSize(width: (view.frame.size.width - Common.Size(s:10))/10, height: (view.frame.size.width - Common.Size(s:10))/2 * 1.4)
        layout.itemSize = CGSize(width: (view.frame.size.width - Common.Size(s:10))/10, height: (Common.Size(s:65))/2 * 1.4)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = Common.Size(s:5)/2
        collectionColorView = UICollectionView(frame: CGRect(x: headerLine.frame.origin.x + 1, y: lbProductPrice.frame.origin.y + lbProductPrice.frame.size.height + Common.Size(s:5), width: headerProduct.frame.size.width/2, height: height), collectionViewLayout: layout)
        collectionColorView.showsHorizontalScrollIndicator = false
        collectionColorView.register(ItemColorCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifierColor)
        collectionColorView.backgroundColor = UIColor.white
        collectionColorView.dataSource = self
        collectionColorView.delegate = self
        
    }
    func reloadUI(){
        headerProduct.frame.origin.y = viewTitleProduct.frame.size.height + viewTitleProduct.frame.origin.y
        viewInfoPromotion.frame.origin.y =  headerProduct.frame.size.height + headerProduct.frame.origin.y + Common.Size(s:10)
        viewInfoPMH.frame.origin.y = viewInfoPromotion.frame.size.height + viewInfoPromotion.frame.origin.y + Common.Size(s:10)
        viewInfoSameProduct.frame.origin.y = viewInfoPMH.frame.size.height + viewInfoPMH.frame.origin.y
        
        if replacementAccessories.count > 0 {
            viewReplacementAccessories.frame = CGRect(x: 0, y: viewInfoSameProduct.frame.size.height + viewInfoSameProduct.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width, height: scrollView.frame.size.width * 3/4)
            lbReplacementAccessories.frame = CGRect(x: Common.Size(s:10), y: 0, width: viewReplacementAccessories.frame.size.width - Common.Size(s:20), height: Common.Size(s:35))
            replacementAccessoriesCollectionView.frame = CGRect(x: 0, y: lbReplacementAccessories.frame.origin.y + lbReplacementAccessories.frame.size.height + 5, width: viewReplacementAccessories.frame.size.width, height: viewReplacementAccessories.frame.size.height - (lbReplacementAccessories.frame.origin.y + lbReplacementAccessories.frame.size.height) - Common.Size(s:10))
            replacementAccessoriesCollectionView.reloadData()
        } else {
            viewReplacementAccessories.frame = CGRect(x: 0, y: viewInfoSameProduct.frame.size.height + viewInfoSameProduct.frame.origin.y, width: scrollView.frame.size.width, height: 0)
            lbReplacementAccessories.frame = CGRect(x: Common.Size(s:10), y: 0, width: viewReplacementAccessories.frame.size.width - Common.Size(s:20), height: 0)
            replacementAccessoriesCollectionView.frame = CGRect(x: 0, y: lbReplacementAccessories.frame.origin.y + lbReplacementAccessories.frame.size.height + 5, width: viewReplacementAccessories.frame.size.width, height: 0)
        }
        
        viewInfoDes.frame.origin.y = viewReplacementAccessories.frame.size.height + viewReplacementAccessories.frame.origin.y + Common.Size(s: 10)
        var indexYDes = viewReplacementAccessories.frame.size.height + viewReplacementAccessories.frame.origin.y + Common.Size(s:10)
        if (product.product.hightlightsDes.count > 0){
            
            indexYDes = viewInfoDes.frame.size.height + viewInfoDes.frame.origin.y + Common.Size(s:10)
        }
        viewInfoBasic.frame.origin.y = indexYDes
        if(product.accessories.count > 0){
            
            viewAccessories.frame.origin.y = viewInfoBasic.frame.size.height + viewInfoBasic.frame.origin.y + Common.Size(s:10)
            
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewAccessories.frame.origin.y + viewAccessories.frame.size.height + Common.Size(s:20))
            
        }else{
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBasic.frame.origin.y + viewInfoBasic.frame.size.height + Common.Size(s:20))
        }
    }
    
    func configurePromotionDetail(with detail:String){
        let proText = "<font size=\"4\">\(detail)</font>".htmlToString
        
        let sizeTitle = proText.height(withConstrainedWidth: self.viewInfoPromotion.frame.size.width - Common.Size(s:20), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
        
        self.lbPromotion.frame.size.height = sizeTitle
        
        self.lbPromotion.attributedText = "<font size=\"4\">\(detail)</font>".htmlToAttributedString
        self.lbPromotion.sizeToFit()
        self.viewInfoPromotion.frame.size.height = self.lbPromotion.frame.origin.y + self.lbPromotion.frame.size.height  + Common.Size(s:10)
    }
    
    func configureImageProduct(with url:String){
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = url.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            if(escapedString != ""){
                let url = URL(string: "\(escapedString)")!
                imageProduct.kf.setImage(with: url,
                                         placeholder: nil,
                                         options: [.transition(.fade(1))],
                                         progressBlock: nil,
                                         completionHandler: nil)
            }
            
        }
    }
    func configurePriceSpecial(with sku:String){
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        let objPrice =  product.variant.filter{ $0.sku == "\(sku)" }.first
        if product != nil {
            if(product.variant.count > 0){
                
                
                if(objPrice?.price_online ?? 0.0 > 0.0 && objPrice?.price_online != objPrice?.price){
                    
                    lbProductPricePromotion.isHidden = false
                    let productPricePromotion = "Giá khuyến mãi \(fmt.string(for: objPrice!.price_online)!)đ"
                    let sizeProductPricePromotion: CGSize = productPricePromotion.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:12))])
                    lbProductPricePromotion.frame.size.height = sizeProductPricePromotion.height
                    lbProductPricePromotion.text = productPricePromotion
                    
                }else{
                    lbProductPricePromotion.isHidden = true
                }
                
                if(objPrice?.PriceOnlinePOS ?? 0.0 > 0.0 && objPrice?.PriceOnlinePOS != objPrice?.price){
                    
                    lbProductPricePromotion.isHidden = true
                    lbProductPriceOnline.isHidden = false
                    let productPriceOnline = "Giá Online \(fmt.string(for: objPrice!.PriceOnlinePOS)!)đ"
                    let sizeProductPriceOnline: CGSize = productPriceOnline.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:13))])
                    lbProductPriceOnline.frame.size.height = sizeProductPriceOnline.height
                    lbProductPriceOnline.text = productPriceOnline
                    
                }else{
                    lbProductPriceOnline.isHidden = true
                }
                
                if(objPrice?.PriceSpecial ?? 0.0 > 0.0 && objPrice?.PriceSpecial != objPrice?.price){ //uu tien lay gia dac biet if 2 gia > 0.0
                    
                    lbProductPricePromotion.isHidden = true
                    lbProductPriceOnline.isHidden = true
                    lbProductPriceSpecial.isHidden = false
                    let productPriceSpecial = "Giá đặc biệt \(fmt.string(for: objPrice!.PriceSpecial)!)đ"
                    let sizeProductPriceSpecial: CGSize = productPriceSpecial.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:13))])
                    lbProductPriceSpecial.frame.size.height = sizeProductPriceSpecial.height
                    lbProductPriceSpecial.text = productPriceSpecial
                }else{
                    lbProductPriceSpecial.isHidden = true
                }
                
                let productPrice = "Giá thường \(fmt.string(for: objPrice?.price ?? 0)!)đ"
                lbProductPrice.text = productPrice
            }
        }
        
    }
    
    
    
}
// MARK: - UICollectionViewDataSource
extension TabProductViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionColorView {
            return product.variant.count
        } else if collectionView == replacementAccessoriesCollectionView {
            return replacementAccessories.count
        } else {
            return product.accessories.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionColorView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierColor, for: indexPath) as! ItemColorCollectionViewCell
            let item:Variant = product.variant[indexPath.row]
            cell.setup(item: item)
            return cell
        } else if collectionView == replacementAccessoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierProductAccessorie, for: indexPath) as! ProductAccessorieCell
            let item: Variant = replacementAccessories[indexPath.row]
            cell.setupVariant(item: item)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierProductAccessorie, for: indexPath) as! ProductAccessorieCell
            let item:Product = product.accessories[indexPath.row]
            cell.setup(item: item)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionColorView {
            for item in product.variant {
                if item == product.variant[indexPath.row] {
                    item.isSelected = true
                }else{
                    item.isSelected = false
                }
            }
            let productName = product.variant[indexPath.row].name
            
            let sizeProductName = productName.height(withConstrainedWidth: viewTitleProduct.frame.size.width - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:20)))
            lbProductName.frame.size.height = sizeProductName
            lbProductName.text = productName
            lbSku.text = "(No.\(product.variant[indexPath.row].sku))"
            
            collectionView.reloadData()
            viewTitleProduct.frame.size.height = lbProductName.frame.size.height + lbProductName.frame.origin.y
            
            replacementAccessories = product.variant[indexPath.row].replacementAccessories?.variants ?? []
            replacementAccessoriesLabel = product.variant[indexPath.row].replacementAccessories?.text ?? ""
            
            fetchPromotionDetailWhenChangeColorAPI(with: product.variant[indexPath.row])
            configureImageProduct(with: product.variant[indexPath.row].ecom_image_url)
            configurePriceSpecial(with: product.variant[indexPath.row].sku)
            //
            let sku = self.product.variant[indexPath.row].sku
            let colorProduct = self.product.variant[indexPath.row].colorValue
            let priceBeforeTax = self.product.variant[indexPath.row].priceBeforeTax
            let price = self.product.variant[indexPath.row].price
            
            product.product.name = productName
            product.product.sku = sku
            product.product.price = price
            product.product.priceBeforeTax = priceBeforeTax
            product.product.ecomColorValue = colorProduct
            //
        } else if collectionView == replacementAccessoriesCollectionView {
            let item: Variant = replacementAccessories[indexPath.row]
            Cache.sku = item.sku
            Cache.model_id = item.model_id
            
            let newViewController = DetailProductViewController()
//            newViewController.product = item
            self.navigationController?.pushViewController(newViewController, animated: true)
            print("You selected cell #\(item.name)")
        } else {
            let item:Product = product.accessories[indexPath.row]
            let newViewController = DetailProductViewController()
            newViewController.product = item
            self.navigationController?.pushViewController(newViewController, animated: true)
            print("You selected cell #\(item.name)")
        }
        
    }
}
// MARK: - UICollectionViewCell
class ItemColorCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties ItemColorCollectionViewCell
    var iconImage:UIImageView!
    var title:UILabel!
    var price:UILabel!
    var bonus:UILabel!
    var num:UILabel!
    // MARK: - Init ItemColorCollectionViewCell
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    // MARK: API ItemColorCollectionViewCell
    func fetchGetStockAPI(sku:String){
        ProductAPIManager.get_stock(itemCode: sku, handler: { [weak self](tonkho, err) in
            guard let self = self else {return}
            if(err == ""){
                self.num.text = "(\(tonkho))"
            }else{
                self.num.text = "(0)"
            }
        })
    }
    
    func setup(item:Variant){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        
        let shadowView = UIView(frame: CGRect(x: Common.Size(s:5), y: 0, width: Common.Size(s: 25), height: Common.Size(s: 25)))
        
        shadowView.layer.shadowOffset = .zero
        
        
        
        
        let view = UIView(frame: shadowView.bounds)
        view.backgroundColor = item.colorValue.hexColor
        view.layer.cornerRadius = 10.0
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = view.frame.size.width/2
        view.clipsToBounds = true
        shadowView.addSubview(view)
        
        
        addSubview(shadowView)
        
        num = UILabel(frame: CGRect(x:Common.Size(s: 5),y: shadowView.frame.size.height + shadowView.frame.origin.y + 7 ,width: 30,height: 12))
        
        num.textColor = .gray
        num.textAlignment = .center
        num.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        addSubview(num)
        fetchGetStockAPI(sku: item.sku)
        
        
        if item.isSelected{
            shadowView.layer.shadowColor = UIColor.orange.cgColor
            shadowView.layer.shadowOpacity = 3
            shadowView.layer.shadowRadius = 9
        }else{
            shadowView.layer.shadowOpacity = 0.5
            shadowView.layer.shadowRadius = 5
            shadowView.layer.shadowColor = UIColor.red.cgColor
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - ProductAccessorieCell
class ProductAccessorieCell: UICollectionViewCell {
    var iconImage:UIImageView!
    var title:UILabel!
    var price:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setup(item:Product){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: self.frame.size.width, height:  self.frame.size.width - Common.Size(s:20)))
        //        iconImage.image = Image(named: "demo")
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        //iconImage.backgroundColor = .red
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        
        if let escapedString = item.iconUrl.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            if escapedString != "" {
                let url = URL(string: "\(escapedString)")!
                iconImage.kf.setImage(with: url,
                                      placeholder: nil,
                                      options: [.transition(.fade(1))],
                                      progressBlock: nil,
                                      completionHandler: nil)
            }
            
        }
        
        
        let heightTitel = item.name.height(withConstrainedWidth: self.frame.size.width - Common.Size(s:4), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
        
        title = UILabel(frame: CGRect(x: Common.Size(s:2), y: iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s:5), width: self.frame.size.width - Common.Size(s:4), height: heightTitel))
        title.textAlignment = .center
        title.textColor = UIColor.lightGray
        title.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        title.text = item.name
        title.numberOfLines = 2
        title.sizeToFit()
        addSubview(title)
        price = UILabel(frame: CGRect(x: Common.Size(s:2), y: title.frame.size.height + title.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:14)))
        price.textAlignment = .center
        price.textColor = UIColor(netHex:0xEF4A40)
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        price.text = Common.convertCurrencyFloat(value: item.price)
        price.numberOfLines = 1
        addSubview(price)
        
    }
    
    func setupVariant(item:Variant){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: self.frame.size.width, height:  self.frame.size.width - Common.Size(s:20)))
        //        iconImage.image = Image(named: "demo")
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        //iconImage.backgroundColor = .red
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        
        if let escapedString = item.ecom_image_url.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            if escapedString != "" {
                let url = URL(string: "\(escapedString)")!
                iconImage.kf.setImage(with: url,
                                      placeholder: nil,
                                      options: [.transition(.fade(1))],
                                      progressBlock: nil,
                                      completionHandler: nil)
            }
            
        }
        
        
        let heightTitel = item.name.height(withConstrainedWidth: self.frame.size.width - Common.Size(s:4), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
        
        title = UILabel(frame: CGRect(x: Common.Size(s:2), y: iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s:5), width: self.frame.size.width - Common.Size(s:4), height: heightTitel))
        title.textAlignment = .center
        title.textColor = UIColor.lightGray
        title.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        title.text = item.name
        title.numberOfLines = 2
        title.sizeToFit()
        addSubview(title)
        price = UILabel(frame: CGRect(x: Common.Size(s:2), y: title.frame.size.height + title.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:14)))
        price.textAlignment = .center
        price.textColor = UIColor(netHex:0xEF4A40)
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        price.text = Common.convertCurrencyFloat(value: item.price)
        price.numberOfLines = 1
        addSubview(price)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

