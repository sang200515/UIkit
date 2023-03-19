//
//  DetailAccessoriesFFriendViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/13/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import MIBadgeButton_Swift
import ActionSheetPicker_3_0
class DetailAccessoriesFFriendViewController: UIViewController{
    
    var INDEX:Int = 2
    
    var product:Product!
    var productBySku:ProductBySku!
    var viewInfoBasic:UIView!
    
    var scrollView:UIScrollView!
    
    var indexYBasic:CGFloat = 0
    var indexYBasicTemp:CGFloat = 0
    var btCartIcon:MIBadgeButton!
    var productColor:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Phụ kiện"
        self.view.backgroundColor = .white
              navigationController?.navigationBar.isTranslucent = false
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(DetailAccessoriesFFriendViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        btCartIcon  = MIBadgeButton.init(type: .custom)
        btCartIcon.setImage(#imageLiteral(resourceName: "cart"), for: UIControl.State.normal)
        btCartIcon.imageView?.contentMode = .scaleAspectFit
        btCartIcon.addTarget(self, action: #selector(DetailAccessoriesFFriendViewController.actionCart), for: UIControl.Event.touchUpInside)
        btCartIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        let barCart = UIBarButtonItem(customView: btCartIcon)
        self.navigationItem.rightBarButtonItems = [barCart]
        
        
        // call service
        if(product.model_id != ""){
            ProductAPIManager.product_detais_by_model_id(model_id: "\(product.model_id)", sku: product.sku,handler: {[weak self] (success , error) in
                guard let self = self else {return}
                
                if(success.count > 0){
                    self.loadProduct(product: success[0])
                    self.productBySku = success[0]
                   
                    
                }else{

                }
            })
        }else{
            ProductAPIManager.product_detais_by_sku(sku: "\(product.sku)",handler: { [weak self](success , error) in
                guard let self = self else {return}
                
                if(success.count > 0){
                    self.loadProduct(product: success[0])
                    self.productBySku = success[0]
                   
                    
                }else{

                }
            })
        }

        
        
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func actionOpenMenuLeft() {
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    func loadProduct(product:ProductBySku) {
        
        //view product
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
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
        imageProduct  = UIImageView(frame:CGRect(x: 0, y: lbSku.frame.origin.y + lbSku.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width/2, height: scrollView.frame.size.width/2));
        imageProduct.contentMode = .scaleAspectFit
        headerProduct.addSubview(imageProduct)
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = product.product.iconUrl.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            if escapedString != "" {
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
        
        //        var indexYPro = headerProduct.frame.size.height + headerProduct.frame.origin.y
        let viewInfoPromotion = UIView(frame: CGRect(x: Common.Size(s:5), y: headerProduct.frame.size.height + headerProduct.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:10), height: 0))
        viewInfoPromotion.backgroundColor = UIColor.white
        viewInfoPromotion.layer.borderWidth = 0.5
        viewInfoPromotion.layer.borderColor = UIColor(netHex:0x47B054).cgColor
        viewInfoPromotion.layer.cornerRadius = 3.0
        scrollView.addSubview(viewInfoPromotion)
        
        let promotionText = "\(product.product.promotion.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))"
        
        if (promotionText.count > 0){
            
            let lbInfoPromotion = UILabel(frame: CGRect(x: 0, y: 0, width: viewInfoPromotion.frame.size.width, height: Common.Size(s:30)))
            lbInfoPromotion.textAlignment = .left
            lbInfoPromotion.textColor = UIColor.white
            lbInfoPromotion.backgroundColor = UIColor(netHex:0x47B054)
            lbInfoPromotion.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbInfoPromotion.text = " Thông tin khuyến mãi"
            viewInfoPromotion.addSubview(lbInfoPromotion)
            
            let sizeTitle = "\(promotionText)".height(withConstrainedWidth: viewInfoPromotion.frame.size.width - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbPromotion = UILabel(frame: CGRect(x: Common.Size(s:5), y: lbInfoPromotion.frame.size.height + lbInfoPromotion.frame.origin.y + Common.Size(s:5), width: viewInfoPromotion.frame.size.width - Common.Size(s:10), height: sizeTitle))
            lbPromotion.textAlignment = .left
            lbPromotion.textColor = UIColor.black
            lbPromotion.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbPromotion.numberOfLines = 50
            viewInfoPromotion.addSubview(lbPromotion)
            
            lbPromotion.text = "\(promotionText)"
            lbPromotion.sizeToFit()
            viewInfoPromotion.frame.size.height = lbPromotion.frame.origin.y + lbPromotion.frame.size.height  + Common.Size(s:5)
            
        }
        //        indexYPro = viewInfoPromotion.frame.size.height + viewInfoPromotion.frame.origin.y
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
        viewInfoBasic = UIView(frame: CGRect(x: Common.Size(s:5), y: indexYDes, width: scrollView.frame.size.width - Common.Size(s:10), height: 0))
        viewInfoBasic.backgroundColor = UIColor.white
        viewInfoBasic.layer.borderWidth = 0.5
        viewInfoBasic.layer.borderColor = UIColor(netHex:0x47B054).cgColor
        viewInfoBasic.layer.cornerRadius = 3.0
        scrollView.addSubview(viewInfoBasic)
        
        if (product.atrribute.count > 0){
            
            let lbInfoBasic = UILabel(frame: CGRect(x: 0, y: 0, width: viewInfoBasic.frame.size.width, height: Common.Size(s:30)))
            lbInfoBasic.textAlignment = .left
            lbInfoBasic.textColor = UIColor.white
            lbInfoBasic.backgroundColor = UIColor(netHex:0x47B054)
            lbInfoBasic.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbInfoBasic.text = " Thông số cơ bản"
            viewInfoBasic.addSubview(lbInfoBasic)
            
            indexYBasic = lbInfoBasic.frame.size.height + lbInfoBasic.frame.origin.y
            
            for item in product.atrribute {
                
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
                    lbBasicRow.numberOfLines = 10
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
                        lbBasicValue.frame.size.height = heightLb
                        viewInfoBasicRow.frame.size.height = lbBasicRow.frame.origin.y + lbBasicRow.frame.size.height + Common.Size(s:10)
                    }else{
                        lbBasicRow.frame.size.height = heightValue
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
        viewInfoBasic.frame.size.height = indexYBasic
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBasic.frame.origin.y + viewInfoBasic.frame.size.height + Common.Size(s:20))
    }
    @objc func cartAction(_ sender:UITapGestureRecognizer){
        
        var arrColor:[String] = []
        for item in self.productBySku.variant {
            arrColor.append(item.colorName)
        }
        if (arrColor.count == 1){
            let sku = self.productBySku.variant[0].sku
            let colorProduct = self.productBySku.variant[0].colorValue
            let priceBeforeTax = self.productBySku.variant[0].priceBeforeTax
            let price = self.productBySku.variant[0].price
            let product = self.productBySku.product.copy() as! Product
            
            var check:Bool = false
            for item in Cache.cartsFF {
                if (item.sku == sku){
                    item.quantity = item.quantity + 1
                    check = true
                }
            }
            if (check == false){
                let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                Cache.cartsFF.append(cart)
            }
            let newViewController = CartFFriendViewController()
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
            ActionSheetStringPicker.show(withTitle: "Chọn màu sản phẩm", rows: arrColor, initialSelection: 0, doneBlock: {
                picker, value, index in
                
                let sku = self.productBySku.variant[value].sku
                let colorProduct = self.productBySku.variant[value].colorValue
                let priceBeforeTax = self.productBySku.variant[value].priceBeforeTax
                let price = self.productBySku.variant[value].price
                let product = self.productBySku.product.copy() as! Product
                
                var check:Bool = false
                for item in Cache.cartsFF {
                    if (item.sku == sku){
                        item.quantity = item.quantity + 1
                        check = true
                    }
                }
                if (check == false){
                    let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                    Cache.cartsFF.append(cart)
                }
                let sum = Cache.cartsFF.count
                if(sum > 0){
                    self.btCartIcon.badgeString = "\(sum)"
                    self.btCartIcon.badgeTextColor = UIColor.white
                    self.btCartIcon.badgeEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 0, right: 12)
                }else{
                    self.btCartIcon.badgeString = ""
                }
                //            Toast(text: "Đã thêm sản phẩm vào giỏ hàng").show()
                let newViewController = CartFFriendViewController()
                self.navigationController?.pushViewController(newViewController, animated: true)
                return
            }, cancel: { ActionStringCancelBlock in
                return
            }, origin: self.view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let sum = Cache.cartsFF.count
        if(sum > 0){
            btCartIcon.badgeString = "\(sum)"
            btCartIcon.badgeTextColor = UIColor.white
            btCartIcon.badgeEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 0, right: 12)
        }else{
            btCartIcon.badgeString = ""
        }
    }
    @objc func actionCart() {
        let newViewController = CartFFriendViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func actionHome(){
        _ = self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

