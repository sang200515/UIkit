//
//  DetailProductNewMiraeViewController.swift
//  fptshop
//
//  Created by tan on 5/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import MIBadgeButton_Swift
import ActionSheetPicker_3_0
import SnapKit
class DetailProductNewMiraeViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK: - Properties
    
    var INDEX:Int = 1
    
    var sku : String!
    var model_id:String!
    var loading:NVActivityIndicatorView!
    var loadingView:UIView!
    var scrollView:UIScrollView!
    
    var product:ProductBySku!
    var indexYBasic:CGFloat = 0
    var indexYBasicTemp:CGFloat = 0
    var viewInfoBasic:UIView!
    var lbInfoBasicMore:UILabel!
    var viewAccessories:UIView!
    var collectionView: UICollectionView!
    var productColor:UIView!
    var barCart : UIBarButtonItem!
    var btCartIcon:MIBadgeButton!
    private var lbNotFound:UILabel!
    private var logo : UIImageView!
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let sum = Cache.cartsMirae.count
        if(sum > 0){
            btCartIcon.badgeString = "\(sum)"
            btCartIcon.badgeTextColor = UIColor.white
            btCartIcon.badgeEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 0, right: 12)
        }else{
            btCartIcon.badgeString = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.blue
        self.title = "Chi tiết"
        
        navigationController?.navigationBar.isTranslucent = false
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(DetailProductNewMiraeViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        btCartIcon  = MIBadgeButton.init(type: .custom)
        btCartIcon.setImage(#imageLiteral(resourceName: "cart"), for: UIControl.State.normal)
        btCartIcon.imageView?.contentMode = .scaleAspectFit
        btCartIcon.addTarget(self, action: #selector(DetailProductNewMiraeViewController.actionCart), for: UIControl.Event.touchUpInside)
        btCartIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        let barCart = UIBarButtonItem(customView: btCartIcon)
        self.navigationItem.rightBarButtonItems = [barCart]
        
        self.view.backgroundColor = UIColor.white
        
        loadingView  = UIView(frame: self.view.frame)
        loadingView.backgroundColor = UIColor.white
        self.view.addSubview(loadingView)
        
        //loading
        let frameLoading = CGRect(x: loadingView.frame.size.width/2 - Common.Size(s:25), y:loadingView.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50))
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor(netHex:0x47B054)
        loading = NVActivityIndicatorView(frame: frameLoading,
                                          type: .ballClipRotateMultiple)
        loading.startAnimating()
        loadingView.addSubview(loading)
        
  
        logo  = UIImageView(frame:CGRect(x: loadingView.frame.size.width/2 - Common.Size(s:25), y: loadingView.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50)));
        logo.image = UIImage(named:"Cancel File-100")
        logo.contentMode = .scaleAspectFit
        loadingView.addSubview(logo)
        
        
        let productNotFound = "Không tìm thấy sản phẩm"
        lbNotFound = UILabel(frame: CGRect(x: 0, y: logo.frame.origin.y + logo.frame.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width, height: Common.Size(s:22)))
        lbNotFound.textAlignment = .center
        lbNotFound.textColor = UIColor.lightGray
        lbNotFound.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        lbNotFound.text = productNotFound
        loadingView.addSubview(lbNotFound)
        lbNotFound.isHidden = true
        logo.isHidden = true
        
        // call service
        if(model_id != ""){
            fetchProductByModelIdAPI()
        }else{
            fetchProductBySkuAPI()
        }
		fetchMaSpBHBySku()

    }
    
    // MARK: - API
    
    func fetchProductBySkuAPI(){
        ProductAPIManager.product_detais_by_sku(sku: "\(sku!)",handler: {[weak self] (success , error) in
            guard let self = self else {return}
            //
            //            if(Cache.indexScreenShow == self.INDEX){
            if(success.count > 0){
                
                if(success[0].product.qlSerial == "N"){
                    Cache.product = success[0]
                    var color:String = ""
                    for item in success[0].variant {
                        if (success[0].product.sku == item.sku){
                            color = item.colorValue
                            success[0].product.priceBeforeTax = item.priceBeforeTax
                        }
                    }
                    var check:Bool = false
                    for item in Cache.cartsMirae {
                        if (item.sku == success[0].product.sku){
                            item.quantity = item.quantity + 1
                            check = true
                        }
                    }
                    if (check == false){
                        let cart = Cart(sku: success[0].product.sku, product: success[0].product,quantity: 1,color:color,inStock:-1, imei: "", price: success[0].product.price, priceBT: success[0].product.priceBeforeTax, whsCode: "", discount: 0, reason: "", note: "", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                        Cache.cartsMirae.append(cart)
                    }
                    let newViewController = CartMiraeViewController()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                    
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("updateHome"), object: nil)
                    }
                    
                    
                }else{
                    
                    self.loading.stopAnimating()
                    self.loadingView.isHidden = true
                    self.fetchPromotionDetailAPI(product: success[0])
                    
                    self.loading.stopAnimating()
                    self.lbNotFound.text = "Ứng dụng chưa hỗ trợ sản phẩm này"
                    self.logo.isHidden = true
                    self.lbNotFound.isHidden = true
                }
                
            }else{
                self.loading.stopAnimating()
                self.logo.isHidden = false
                self.lbNotFound.isHidden = false
            }
            //            }
        })
    }
    
    func fetchProductByModelIdAPI(){
        ProductAPIManager.product_detais_by_model_id(model_id: "\(model_id!)", sku: sku,handler: {[weak self] (success , error) in
            guard let self = self else {return}
            //
            //            if(Cache.indexScreenShow == self.INDEX){
            if(success.count > 0){
                
                if(success[0].product.qlSerial == "N"){
                    Cache.product = success[0]
                    var color:String = ""
                    for item in success[0].variant {
                        if (success[0].product.sku == item.sku){
                            color = item.colorValue
                            success[0].product.priceBeforeTax = item.priceBeforeTax
                        }
                    }
                    var check:Bool = false
                    for item in Cache.cartsMirae {
                        if (item.sku == success[0].product.sku){
                            item.quantity = item.quantity + 1
                            check = true
                        }
                    }
                    if (check == false){
                        let cart = Cart(sku: success[0].product.sku, product: success[0].product,quantity: 1,color:color,inStock:-1, imei: "", price: success[0].product.price, priceBT: success[0].product.priceBeforeTax, whsCode: "", discount: 0, reason: "", note: "", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                        Cache.cartsMirae.append(cart)
                    }
                    let newViewController = CartMiraeViewController()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                    
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("updateHome"), object: nil)
                    }
                    
                    
                }else{
                    
                    self.loading.stopAnimating()
                    self.loadingView.isHidden = true
                    self.fetchPromotionDetailAPI(product: success[0])
                    
                    self.loading.stopAnimating()
                    self.lbNotFound.text = "Ứng dụng chưa hỗ trợ sản phẩm này"
                    self.logo.isHidden = true
                    self.lbNotFound.isHidden = true
                }
                
            }else{
                self.loading.stopAnimating()
                self.logo.isHidden = false
                self.lbNotFound.isHidden = false
            }
            //            }
        })
    }
    
    func fetchPromotionDetailAPI(product:ProductBySku){
        ProductAPIManager.get_promotions_detais(sku: product.product.sku,handler: { [weak self](detail , error) in
            guard let self = self else {return}
            if error == "" {
                product.product.promotion = detail
                self.loadProduct(product: product)
            }else{
                product.product.promotion = ""
                self.loadProduct(product: product)
            }
            
            
        })
    }
    
    // MARK: - Selectors
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func actionHome(){
        _ = self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func actionOpenMenuLeft() {
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func actionCart() {
        let newViewController = CartMiraeViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }

    // MARK: - Helpers
    
    func loadProduct(product:ProductBySku) {
        self.product = product
        self.indexYBasic = 0
        //view product
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 2)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let headerProduct = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.width * 2/3))
        headerProduct.backgroundColor = UIColor.white
        scrollView.addSubview(headerProduct)
        
        //name
        let productName = "\(product.product.name)"
        
        let sizeProductName = productName.height(withConstrainedWidth: headerProduct.frame.size.width - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:20)))
        
        let lbProductName = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: headerProduct.frame.size.width - Common.Size(s:10), height: sizeProductName))
        lbProductName.textAlignment = .center
        lbProductName.textColor = UIColor(netHex:0x47B054)
        lbProductName.font = UIFont.boldSystemFont(ofSize: Common.Size(s:20))
        lbProductName.text = productName
        lbProductName.numberOfLines = 3;
        // lbProductName.sizeToFit()
        headerProduct.addSubview(lbProductName)
        //no
        let lbSku = UILabel(frame: CGRect(x: 0, y: lbProductName.frame.origin.y + lbProductName.frame.size.height + Common.Size(s:5), width: headerProduct.frame.size.width, height: Common.Size(s:12)))
        lbSku.textAlignment = .center
        lbSku.textColor = UIColor.lightGray
        lbSku.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSku.text = "(No.\(product.product.sku))"
        headerProduct.addSubview(lbSku)
        
        //image
        var imageProduct : UIImageView
        imageProduct  = UIImageView(frame:CGRect(x: 0, y: lbSku.frame.origin.y + lbSku.frame.size.height + 5, width: scrollView.frame.size.width/2, height: scrollView.frame.size.width/2));
        imageProduct.contentMode = .scaleAspectFit
        headerProduct.addSubview(imageProduct)

		if  product.product.hotSticker{
			let hotSticker = UIImageView()
			imageProduct.addSubview(hotSticker)
			hotSticker.image = UIImage(named: "ic_hot3")
			hotSticker.snp.makeConstraints { make in
				make.left.equalToSuperview()
				make.bottom.equalToSuperview()
				}
		}

        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = product.product.imageUrl.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
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
        
        
        let headerLine = UIView(frame: CGRect(x: imageProduct.frame.origin.x + imageProduct.frame.size.width, y:imageProduct.frame.origin.y + imageProduct.frame.size.height/6, width: 0.5, height: imageProduct.frame.size.height * 2/3))
        headerLine.backgroundColor = UIColor(netHex:0x47B054)
        headerProduct.addSubview(headerLine)
        
        //name
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        let productPrice = "\(fmt.string(for: product.product.price)!)đ"
        let sizeProductPrice: CGSize = productName.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:22))])
        let lbProductPrice = UILabel(frame: CGRect(x: headerLine.frame.origin.x + Common.Size(s:5) , y: headerLine.frame.origin.y, width: headerProduct.frame.size.width / 2 - Common.Size(s:10), height: sizeProductPrice.height))
        lbProductPrice.textAlignment = .center
        lbProductPrice.textColor = UIColor.red
        lbProductPrice.font = UIFont.boldSystemFont(ofSize: Common.Size(s:22))
        lbProductPrice.text = productPrice
        lbProductPrice.numberOfLines = 3;
        headerProduct.addSubview(lbProductPrice)
        
        
        //color
        if (product.variant.count <= 4 ){
            productColor = UIView(frame: CGRect(x: headerLine.frame.origin.x + 1, y: lbProductPrice.frame.origin.y + lbProductPrice.frame.size.height + Common.Size(s:5), width: headerProduct.frame.size.width/2, height: (headerProduct.frame.size.width/8) * 1.4))
            productColor.backgroundColor = .white
        }else if (product.variant.count > 4){
            productColor = UIView(frame: CGRect(x: headerLine.frame.origin.x + 1, y: lbProductPrice.frame.origin.y + lbProductPrice.frame.size.height + Common.Size(s:5), width: headerProduct.frame.size.width/2, height: (headerProduct.frame.size.width/8) * 1.4  * 2))
            productColor.backgroundColor = .white
        }else if (product.variant.count > 8){
            productColor = UIView(frame: CGRect(x: headerLine.frame.origin.x + 1, y: lbProductPrice.frame.origin.y + lbProductPrice.frame.size.height + Common.Size(s:5) , width: headerProduct.frame.size.width/2, height: (headerProduct.frame.size.width/8) * 1.4 * 3))
            productColor.backgroundColor = .white
        }
        headerProduct.addSubview(productColor)
        
        var xSizeColor: CGFloat = Common.Size(s:2)
        var ySizeColor: CGFloat = 0
        var ySizeHeightColor: CGFloat = 0
        var ySizeWidthColor: CGFloat = 0
        var ySizeHeightLineColor: CGFloat = 0
        let lineColor = UIView()
        var countColor: Int = 0
        for item in product.variant {
            countColor = countColor + 1
            if (countColor == 5) {
                countColor = 0
                ySizeColor = ySizeColor + ySizeHeightColor + Common.Size(s:2)
                xSizeColor = Common.Size(s:2)
            }
            let itemColor = UIView()
            itemColor.backgroundColor = .white
            let sizeWidth: CGFloat = (productColor.frame.size.width - Common.Size(s:10))/4
            itemColor.frame = CGRect(x:xSizeColor ,y: ySizeColor ,width: sizeWidth ,height: sizeWidth * 1.4)
            xSizeColor = itemColor.frame.origin.x + itemColor.frame.size.width + Common.Size(s:2)
            lineColor.addSubview(itemColor)
            ySizeColor = itemColor.frame.origin.y
            ySizeHeightColor = itemColor.frame.size.height
            
            if (xSizeColor > ySizeWidthColor){
                ySizeWidthColor = xSizeColor
            }
            if (ySizeColor > ySizeHeightLineColor){
                ySizeHeightLineColor = ySizeColor
            }
            
            let colorView = UIView()
            let shadowView = UIView(frame: CGRect(x:0, y:0,width: Common.Size(s:25),height: Common.Size(s:25)))
            shadowView.layer.shadowColor = UIColor.red.cgColor
            shadowView.layer.shadowOffset = .zero
            shadowView.layer.shadowOpacity = 0.5
            shadowView.layer.shadowRadius = 5
            let view = UIView(frame: shadowView.bounds)
            view.backgroundColor = item.colorValue.hexColor
            view.layer.cornerRadius = 10.0
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 0.5
            view.layer.cornerRadius = view.frame.size.width/2
            view.clipsToBounds = true
            shadowView.addSubview(view)
            colorView.addSubview(shadowView)
            colorView.frame  = CGRect(x:itemColor.frame.size.width/2 - Common.Size(s:25)/2 ,y: 0,width: Common.Size(s:25),height: Common.Size(s:25))
            itemColor.addSubview(colorView)
            
            let num : UILabel = UILabel(frame: CGRect(x:0,y: colorView.frame.size.height + colorView.frame.origin.y,width: itemColor.frame.size.width,height: itemColor.frame.size.height - (colorView.frame.size.height + colorView.frame.origin.y)))
            
            num.textColor = .gray
            num.textAlignment = .center
            num.font = UIFont.systemFont(ofSize: Common.Size(s:11))
            itemColor.addSubview(num)
            
            MPOSAPIManager.checkInventory(shopCode: "\(Cache.user!.ShopCode)", itemCode: item.sku, handler: { (results, err) in
                if(results.count > 0){
                    num.text = "(\(results[0].SL))"
                }else{
                    num.text = "(0)"
                }
            })
        }
        lineColor.frame = CGRect(x:productColor.frame.size.width/2 - ySizeWidthColor/2 ,y: 0,width: xSizeColor ,height: productColor.frame.size.height)
        
        productColor.addSubview(lineColor)
        
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: headerLine.frame.origin.x + Common.Size(s:5), y: productColor.frame.origin.y + productColor.frame.size.height, width: headerProduct.frame.size.width / 2 - Common.Size(s:10), height: (headerProduct.frame.size.width / 2 - Common.Size(s:10)) * 0.25)
        btPay.backgroundColor = UIColor(netHex:0xEF4A40)
        btPay.setTitle("Mua ngay", for: .normal)
        btPay.addTarget(self, action: #selector(cartAction(_:)), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        
        headerProduct.addSubview(btPay)
        
        let lbBonus = UILabel(frame: CGRect(x: btPay.frame.origin.x, y: btPay.frame.origin.y + btPay.frame.size.height + Common.Size(s:10), width: btPay.frame.size.width, height: Common.Size(s:12)))
        lbBonus.textAlignment = .center
        lbBonus.textColor = UIColor.lightGray
        lbBonus.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbBonus.text = "(\(product.product.bonusScopeBoom))"
        headerProduct.addSubview(lbBonus)
        
        headerProduct.frame.size.height = lbBonus.frame.size.height + lbBonus.frame.origin.y + Common.Size(s:10)
        
        
        let viewInfoPromotion = UIView(frame: CGRect(x: Common.Size(s:5), y: headerProduct.frame.size.height + headerProduct.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:10), height: scrollView.frame.size.width * 2/3))
        viewInfoPromotion.backgroundColor = UIColor.white
        viewInfoPromotion.layer.borderWidth = 0.5
        viewInfoPromotion.layer.borderColor = UIColor(netHex:0x47B054).cgColor
        viewInfoPromotion.layer.cornerRadius = 3.0
        scrollView.addSubview(viewInfoPromotion)
        
        let lbInfoPromotion = UILabel(frame: CGRect(x: 0, y: 0, width: viewInfoPromotion.frame.size.width, height: Common.Size(s:30)))
        lbInfoPromotion.textAlignment = .left
        lbInfoPromotion.textColor = UIColor.white
        lbInfoPromotion.backgroundColor = UIColor(netHex:0x47B054)
        lbInfoPromotion.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbInfoPromotion.text = " Thông tin khuyến mãi"
        viewInfoPromotion.addSubview(lbInfoPromotion)
        
        let proText = "<font size=\"4\">\(product.product.promotion)</font>".htmlToString
        
        let sizeTitle = proText.height(withConstrainedWidth: viewInfoPromotion.frame.size.width - Common.Size(s:20), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
        
        let lbPromotion = UILabel(frame: CGRect(x: Common.Size(s:5), y: lbInfoPromotion.frame.size.height + lbInfoPromotion.frame.origin.y + Common.Size(s:5), width: viewInfoPromotion.frame.size.width - Common.Size(s:10), height: sizeTitle))
        lbPromotion.textAlignment = .left
        lbPromotion.textColor = UIColor.black
        lbPromotion.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPromotion.numberOfLines = 50
        viewInfoPromotion.addSubview(lbPromotion)
        
        lbPromotion.attributedText = "<font size=\"4\">\(product.product.promotion)</font>".htmlToAttributedString
        lbPromotion.sizeToFit()
        let tapInfoPromotion = UITapGestureRecognizer(target: self, action: #selector(handleShowPromos))
        viewInfoPromotion.isUserInteractionEnabled = true
        viewInfoPromotion.addGestureRecognizer(tapInfoPromotion)
        viewInfoPromotion.frame.size.height = lbPromotion.frame.origin.y + lbPromotion.frame.size.height  + Common.Size(s:5)
        
        ///
        var indexYDes = viewInfoPromotion.frame.size.height + viewInfoPromotion.frame.origin.y + Common.Size(s:10)
        if (product.product.hightlightsDes.count > 0){
            let viewInfoDes = UIView(frame: CGRect(x: 5, y: indexYDes, width: scrollView.frame.size.width - Common.Size(s:10), height: 0))
            viewInfoDes.backgroundColor = UIColor.white
            viewInfoDes.layer.borderWidth = 0.5
            viewInfoDes.layer.borderColor = UIColor(netHex:0x47B054).cgColor
            viewInfoDes.layer.cornerRadius = 3.0
            scrollView.addSubview(viewInfoDes)
            
            let lbInfoDes = UILabel(frame: CGRect(x: 0, y: 0, width: viewInfoPromotion.frame.size.width, height: Common.Size(s:30)))
            lbInfoDes.textAlignment = .left
            lbInfoDes.textColor = UIColor.white
            lbInfoDes.backgroundColor = UIColor(netHex:0x47B054)
            lbInfoDes.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbInfoDes.text = " Điểm nổi bật"
            viewInfoDes.addSubview(lbInfoDes)
            
            
            let sizeDes =  "\(product.product.hightlightsDes.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))".height(withConstrainedWidth: viewInfoPromotion.frame.size.width - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbDes = UILabel(frame: CGRect(x: Common.Size(s:5), y: lbInfoDes.frame.size.height + lbInfoDes.frame.origin.y + Common.Size(s:5), width: viewInfoDes.frame.size.width - Common.Size(s:10), height: sizeDes))
            lbDes.textAlignment = .left
            lbDes.textColor = UIColor.black
            lbDes.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbDes.numberOfLines = 20
            viewInfoDes.addSubview(lbDes)
            lbDes.text = product.product.hightlightsDes.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            lbDes.sizeToFit()
            viewInfoDes.frame.size.height = lbDes.frame.origin.y + lbDes.frame.size.height + Common.Size(s:5)
            
            indexYDes = viewInfoDes.frame.size.height + viewInfoDes.frame.origin.y + Common.Size(s:10)
        }
        //
        viewInfoBasic = UIView(frame: CGRect(x: Common.Size(s:5), y: indexYDes, width: scrollView.frame.size.width - Common.Size(s:10), height: scrollView.frame.size.width * 2/3))
        viewInfoBasic.backgroundColor = UIColor.white
        viewInfoBasic.layer.borderWidth = 0.5
        viewInfoBasic.layer.borderColor = UIColor(netHex:0x47B054).cgColor
        viewInfoBasic.layer.cornerRadius = 3.0
        scrollView.addSubview(viewInfoBasic)
        
        let lbInfoBasic = UILabel(frame: CGRect(x: 0, y: 0, width: viewInfoBasic.frame.size.width, height: Common.Size(s:30)))
        lbInfoBasic.textAlignment = .left
        lbInfoBasic.textColor = UIColor.white
        lbInfoBasic.backgroundColor = UIColor(netHex:0x47B054)
        lbInfoBasic.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbInfoBasic.text = " Thông số cơ bản"
        viewInfoBasic.addSubview(lbInfoBasic)
        
        lbInfoBasicMore = UILabel(frame: CGRect(x: lbInfoBasic.frame.size.width/2, y: 0, width: lbInfoBasic.frame.size.width/2 - Common.Size(s:10), height: lbInfoBasic.frame.size.height))
        lbInfoBasicMore.textAlignment = .right
        lbInfoBasicMore.textColor = UIColor.white
        lbInfoBasicMore.backgroundColor = UIColor(netHex:0x47B054)
        lbInfoBasicMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Hiện chi tiết", attributes: underlineAttribute)
        lbInfoBasicMore.attributedText = underlineAttributedString
        viewInfoBasic.addSubview(lbInfoBasicMore)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailProductNewMiraeViewController.tapShowDetail))
        lbInfoBasicMore.isUserInteractionEnabled = true
        lbInfoBasicMore.addGestureRecognizer(tap)
        
        indexYBasic = lbInfoBasic.frame.size.height + lbInfoBasic.frame.origin.y
        
        for item in product.atrribute {
            if (item.group == "Thông số cơ bản"){
                
                for atrribute in item.attributes {
                    
                    let viewInfoBasicRow = UIView(frame: CGRect(x: 0, y: indexYBasic, width: lbInfoBasic.frame.size.width, height: 50))
                    viewInfoBasicRow.backgroundColor = UIColor.white
                    viewInfoBasic.addSubview(viewInfoBasicRow)
                    
                    let viewInfoBasicLine = UIView(frame: CGRect(x: viewInfoBasicRow.frame.size.width * 3/10, y: 0, width: 0.5, height: viewInfoBasicRow.frame.size.height))
                    viewInfoBasicLine.backgroundColor = UIColor(netHex:0x47B054)
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
                    viewInfoBasicLineHeader.backgroundColor = UIColor(netHex:0x47B054)
                    viewInfoBasicRow.addSubview(viewInfoBasicLineHeader)
                    
                    indexYBasic = viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y
                }
                break
            }
            
        }
        
        indexYBasicTemp = indexYBasic
        viewInfoBasic.frame.size.height = indexYBasic
        
        //
        if(product.accessories.count > 0){
            
            viewAccessories = UIView(frame: CGRect(x: Common.Size(s:5), y: viewInfoBasic.frame.size.height + viewInfoBasic.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:10), height: scrollView.frame.size.width * 3/4))
            viewAccessories.backgroundColor = UIColor.white
            viewAccessories.layer.borderWidth = 0.5
            viewAccessories.layer.borderColor = UIColor(netHex:0x47B054).cgColor
            viewAccessories.layer.cornerRadius = 3.0
            scrollView.addSubview(viewAccessories)
            
            let lbAccessories = UILabel(frame: CGRect(x: 0, y: 0, width: viewInfoPromotion.frame.size.width, height: Common.Size(s:30)))
            lbAccessories.textAlignment = .left
            lbAccessories.textColor = UIColor.white
            lbAccessories.backgroundColor = UIColor(netHex:0x47B054)
            lbAccessories.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbAccessories.text = " Phụ kiện tương thích"
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
            collectionView.register(ProductAccessorieCell.self, forCellWithReuseIdentifier: "ProductAccessorieCell")
            collectionView.backgroundColor = UIColor.white
            viewAccessories.addSubview(collectionView)
            
        }else{
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBasic.frame.origin.y + viewInfoBasic.frame.size.height + Common.Size(s:20))
        }
    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let size = (viewAccessories.frame.size.width - 10)/2
    //        return CGSize(width: size, height: size * 1.3);
    //
    //    }
    @objc func handleShowPromos(){
        let myVC = PopupPromostionViewController()
        myVC.content = "<font size=\"4\">\(product.product.promotion)</font>"
        let navController = UINavigationController(rootViewController: myVC)
        self.navigationController?.present(navController, animated:true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.accessories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductAccessorieCell", for: indexPath) as! ProductAccessorieCell
        let item:Product = product.accessories[indexPath.row]
        //        let iconImage:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height:  cell.frame.size.width))
        //        iconImage.image = Image(named: "demo")
        //        iconImage.contentMode = .scaleAspectFit
        //        cell.addSubview(iconImage)
        //        print( "\(cell.frame.size.height).  \(viewAccessories.frame.size.height - 10)")
        cell.setup(item: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item:Product = product.accessories[indexPath.row]
        let newViewController = DetailAccessoriesMiraeViewController()
        newViewController.product = item
        self.navigationController?.pushViewController(newViewController, animated: true)
        print("You selected cell #\(item.name)")
    }
    @objc func tapShowDetail(sender:UITapGestureRecognizer) {
        print("tap working")
        if (indexYBasicTemp == indexYBasic){
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: "Ẩn chi tiết", attributes: underlineAttribute)
            lbInfoBasicMore.attributedText = underlineAttributedString
            for item in product.atrribute {
                if (item.group != "Thông số cơ bản"){
                    let lbInfoBasic = UILabel(frame: CGRect(x: 0, y: indexYBasic, width: viewInfoBasic.frame.size.width, height: Common.Size(s:30)))
                    lbInfoBasic.textAlignment = .left
                    lbInfoBasic.textColor = UIColor.white
                    lbInfoBasic.backgroundColor = UIColor(netHex:0x47B054)
                    lbInfoBasic.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
                    lbInfoBasic.text = " \(item.group)"
                    viewInfoBasic.addSubview(lbInfoBasic)
                    indexYBasic = lbInfoBasic.frame.size.height + lbInfoBasic.frame.origin.y
                    
                    for atrribute in item.attributes {
                        
                        let viewInfoBasicRow = UIView(frame: CGRect(x: 0, y: indexYBasic, width: lbInfoBasic.frame.size.width, height: Common.Size(s:50)))
                        viewInfoBasicRow.backgroundColor = UIColor.white
                        viewInfoBasic.addSubview(viewInfoBasicRow)
                        
                        let viewInfoBasicLine = UIView(frame: CGRect(x: viewInfoBasicRow.frame.size.width * 3/10, y: 0, width: 0.5, height: viewInfoBasicRow.frame.size.height))
                        viewInfoBasicLine.backgroundColor = UIColor(netHex:0x47B054)
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
                        viewInfoBasicLineHeader.backgroundColor = UIColor(netHex:0x47B054)
                        viewInfoBasicRow.addSubview(viewInfoBasicLineHeader)
                        
                        indexYBasic = viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y
                    }
                    
                }
            }
            
        }else{
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            let underlineAttributedString = NSAttributedString(string: "Hiện chi tiết", attributes: underlineAttribute)
            lbInfoBasicMore.attributedText = underlineAttributedString
            indexYBasic = indexYBasicTemp
        }
        viewInfoBasic.frame.size.height = indexYBasic
        viewInfoBasic.clipsToBounds = true
        if(viewAccessories != nil){
            viewAccessories.frame.origin.y = viewInfoBasic.frame.size.height + viewInfoBasic.frame.origin.y + Common.Size(s:10)
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewAccessories.frame.origin.y + viewAccessories.frame.size.height + Common.Size(s:20))
            
        }else{
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBasic.frame.origin.y + viewInfoBasic.frame.size.height + Common.Size(s:20))
        }
    }
	var listMaSpBH:[String] = []
	var listNameSpBH:[String] = []
	var listbrand:[String] = []
	var listRole:[String] = []

	func fetchMaSpBHBySku(){
		if  Cache.cartsMirae.count == 0 {
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
    @objc func cartAction(_ sender:UITapGestureRecognizer){
        if (self.product.product.qlSerial == "Y"){
            var arrColor:[String] = []
            for item in self.product.variant {
                arrColor.append(item.colorName)
            }
            if (arrColor.count == 1){
                let sku = self.product.variant[0].sku
                let colorProduct = self.product.variant[0].colorValue
                let priceBeforeTax = self.product.variant[0].priceBeforeTax
                let price = self.product.variant[0].price
                let product = self.product.product.copy() as! Product
                
                product.sku = sku
                product.price = price
                product.priceBeforeTax = priceBeforeTax
				if product.is_ExtendedWar{
					product.skuBH = self.listMaSpBH
					product.nameBH = self.listNameSpBH
					product.brandGoiBH = self.listbrand
					product.role2 = self.listRole
				}
                let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0, reason: "", note: "", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                Cache.cartsMirae.append(cart)
                Cache.itemsPromotionMirae.removeAll()
                
                let newViewController = CartMiraeViewController()
                self.navigationController?.pushViewController(newViewController, animated: true)
                
            }else{
                ActionSheetStringPicker.show(withTitle: "Chọn màu sản phẩm", rows: arrColor, initialSelection: 0, doneBlock: {
                    picker, value, index in
                    
                    let sku = self.product.variant[value].sku
                    let colorProduct = self.product.variant[value].colorValue
                    let priceBeforeTax = self.product.variant[value].priceBeforeTax
                    let price = self.product.variant[value].price
                    let product = self.product.product.copy() as! Product
                    
                    product.sku = sku
                    product.price = price
                    product.priceBeforeTax = priceBeforeTax
					if product.is_ExtendedWar {
						if product.amountGoiBH == "1" || product.amountGoiBH == "2"{
						}else {
							self.product.product.amountGoiBH = ""
						}
						product.skuBH = self.listMaSpBH
						product.nameBH = self.listNameSpBH
						product.brandGoiBH = self.listbrand
						product.role2 = self.listRole

					}
                    let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0, reason: "", note: "", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                    Cache.cartsMirae.append(cart)
                    Cache.itemsPromotionMirae.removeAll()
                    let newViewController = CartMiraeViewController()
                    self.navigationController?.pushViewController(newViewController, animated: true)
                    return
                }, cancel: { ActionStringCancelBlock in
                    return
                }, origin: self.view)
                
            }
            
        }else{
            // da chuuyen san phu kien
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
