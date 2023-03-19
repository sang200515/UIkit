//
//  TabProductViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Kingfisher
import QuartzCore
import StringExtensionHTML
import ActionSheetPicker_3_0
class TabProductVNPTViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var INDEX:Int = 1
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
    
    var listSPTraGopAll:[SPTraGop] = []
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
        
        let nc = NotificationCenter.default
        // call service
        if(Cache.model_id != "0"){
            ProductAPIManager.product_detais_by_model_id(model_id: "\(Cache.model_id)", sku: Cache.sku,handler: { (success , error) in
                if(Cache.indexScreenShow == self.INDEX){
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
                            for item in Cache.carts {
                                if (item.sku == success[0].product.sku){
                                    item.quantity = item.quantity + 1
                                    check = true
                                }
                            }
                            if (check == false){
                                let cart = Cart(sku: success[0].product.sku, product: success[0].product,quantity: 1,color:color,inStock:-1, imei: "", price: success[0].product.price, priceBT: success[0].product.priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                Cache.carts.append(cart)
                            }
                            
                            let when = DispatchTime.now() + 1
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                let newViewController = CartViewController()
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                let nc = NotificationCenter.default
                                nc.post(name: Notification.Name("updateHome"), object: nil)
                            }
                        }else{
                            Cache.product = success[0]
                            Cache.segment = success[0].segment
                            Cache.segmentSku = success[0].product.sku
                            MPOSAPIManager.FRT_SP_mpos_loadSPTraGop(MaSP: "\(self.sku!)", DonGia: "\(String(format: "%.6f", success[0].product.price))", handler: { (results, err) in
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
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
                                    self.loadProduct(product: success[0],listSPTraGop:self.listSPTraGop)
                                }
                            })
                        }
                        
                    }else{
                        
                        
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        }
                    }
                    
                }
            })
        }else{
            ProductAPIManager.product_detais_by_sku(sku: "\(sku!)",handler: { (success , error) in
                  if(Cache.indexScreenShow == self.INDEX){
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
                              for item in Cache.carts {
                                  if (item.sku == success[0].product.sku){
                                      item.quantity = item.quantity + 1
                                      check = true
                                  }
                              }
                              if (check == false){
                                  let cart = Cart(sku: success[0].product.sku, product: success[0].product,quantity: 1,color:color,inStock:-1, imei: "", price: success[0].product.price, priceBT: success[0].product.priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                  Cache.carts.append(cart)
                              }
                              
                              let when = DispatchTime.now() + 1
                              DispatchQueue.main.asyncAfter(deadline: when) {
                                  nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                  let newViewController = CartViewController()
                                  self.navigationController?.pushViewController(newViewController, animated: true)
                              }
                              DispatchQueue.main.asyncAfter(deadline: when) {
                                  let nc = NotificationCenter.default
                                  nc.post(name: Notification.Name("updateHome"), object: nil)
                              }
                          }else{
                              Cache.product = success[0]
                              Cache.segment = success[0].segment
                              Cache.segmentSku = success[0].product.sku
                              MPOSAPIManager.FRT_SP_mpos_loadSPTraGop(MaSP: "\(self.sku!)", DonGia: "\(String(format: "%.6f", success[0].product.price))", handler: { (results, err) in
                                  let when = DispatchTime.now() + 0.5
                                  DispatchQueue.main.asyncAfter(deadline: when) {
                                      nc.post(name: Notification.Name("dismissLoading"), object: nil)
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
                                      self.loadProduct(product: success[0],listSPTraGop:self.listSPTraGop)
                                  }
                              })
                          }
                          
                      }else{
                          
                          
                          let when = DispatchTime.now() + 0.5
                          DispatchQueue.main.asyncAfter(deadline: when) {
                              nc.post(name: Notification.Name("dismissLoading"), object: nil)
                          }
                      }
                      
                  }
              })
        }
  
    }
    @objc
    func tapSelectSameProduct(sender:UITapGestureRecognizer) {
        let tag = sender.view!.tag
        
        let item:SPTraGop = sameProducts[tag]
        Cache.sku = item.ItemCode
        let newViewController = DetailProductVNPTViewController()
        
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
        
        let headerProduct = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.width * 2/3))
        headerProduct.backgroundColor = UIColor.white
        scrollView.addSubview(headerProduct)
        
        //name
        let productName = "\(product.product.name)"
        
        let sizeProductName = productName.height(withConstrainedWidth: headerProduct.frame.size.width - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:20)))
        
        let lbProductName = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: headerProduct.frame.size.width - Common.Size(s:10), height: sizeProductName))
        lbProductName.textAlignment = .center
        lbProductName.textColor = UIColor(netHex:0xD0021B)
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
        
        let headerLine = UIView(frame: CGRect(x: imageProduct.frame.origin.x + imageProduct.frame.size.width, y:imageProduct.frame.origin.y + imageProduct.frame.size.height/6, width: 0.5, height: imageProduct.frame.size.height * 2/3))
        headerLine.backgroundColor = UIColor.clear
        headerProduct.addSubview(headerLine)
        
        //name
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        let productPrice = "\(fmt.string(for: product.product.price)!)đ"
        let sizeProductPrice: CGSize = productName.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:22))])
        let lbProductPrice = UILabel(frame: CGRect(x: headerLine.frame.origin.x + Common.Size(s:5) , y: headerLine.frame.origin.y, width: headerProduct.frame.size.width / 2 - Common.Size(s:10), height: sizeProductPrice.height))
        lbProductPrice.textAlignment = .center
        lbProductPrice.textColor = UIColor(netHex:0xD0021B)
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
        
        let viewInfoPromotion = UIView(frame: CGRect(x: 0, y: headerProduct.frame.size.height + headerProduct.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width, height: scrollView.frame.size.width * 2/3))
        viewInfoPromotion.backgroundColor = UIColor.white
        scrollView.addSubview(viewInfoPromotion)
        
        let lbInfoPromotion = UILabel(frame: CGRect(x: Common.Size(s:10), y: 0, width: viewInfoPromotion.frame.size.width -  Common.Size(s:20), height: Common.Size(s:35)))
        lbInfoPromotion.textAlignment = .left
        lbInfoPromotion.textColor = UIColor(netHex:0x04AB6E)
        lbInfoPromotion.backgroundColor = UIColor.white
        lbInfoPromotion.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbInfoPromotion.text = "Thông tin khuyến mãi"
        viewInfoPromotion.addSubview(lbInfoPromotion)
        let proText = "<font size=\"4\">\(product.product.promotion)</font>".htmlToString
        
        let sizeTitle = proText.height(withConstrainedWidth: viewInfoPromotion.frame.size.width - Common.Size(s:20), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
        
        let lbPromotion = UILabel(frame: CGRect(x: Common.Size(s:10), y: lbInfoPromotion.frame.size.height + lbInfoPromotion.frame.origin.y, width: viewInfoPromotion.frame.size.width - Common.Size(s:20), height: sizeTitle))
        lbPromotion.textAlignment = .left
        lbPromotion.textColor = UIColor.black
        lbPromotion.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPromotion.numberOfLines = 50
        viewInfoPromotion.addSubview(lbPromotion)
        
        lbPromotion.attributedText = "<font size=\"4\">\(product.product.promotion)</font>".htmlToAttributedString
        lbPromotion.sizeToFit()
        viewInfoPromotion.frame.size.height = lbPromotion.frame.origin.y + lbPromotion.frame.size.height  + Common.Size(s:10)
        let tapInfoPromotion = UITapGestureRecognizer(target: self, action: #selector(TabProductVNPTViewController.tapShowPromos))
        viewInfoPromotion.isUserInteractionEnabled = true
        viewInfoPromotion.addGestureRecognizer(tapInfoPromotion)
        
        
        let viewInfoSameProduct = UIView(frame: CGRect(x:  0, y: viewInfoPromotion.frame.size.height + viewInfoPromotion.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width, height: 0))
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
            
            let tapSameProduct = UITapGestureRecognizer(target: self, action: #selector(TabProductVNPTViewController.tapShowMoreProduct))
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
        var indexYDes = viewInfoSameProduct.frame.size.height + viewInfoSameProduct.frame.origin.y + Common.Size(s:10)
        if (product.product.hightlightsDes.count > 0){
            let viewInfoDes = UIView(frame: CGRect(x: 0, y: indexYDes, width: viewInfoPromotion.frame.size.width, height: 0))
            viewInfoDes.backgroundColor = UIColor.white
            scrollView.addSubview(viewInfoDes)
            
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
            collectionView.register(ProductAccessorieCell2.self, forCellWithReuseIdentifier: "ProductAccessorieCell2")
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.accessories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductAccessorieCell3", for: indexPath) as! ProductAccessorieCell3
        let item:Product = product.accessories[indexPath.row]
        //        let iconImage:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height:  cell.frame.size.width))
        //        iconImage.image = Image(named: "demo")
        //        iconImage.contentMode = .scaleAspectFit
        //        cell.addSubview(iconImage)
        //        print( "\(cell.frame.size.height).  \(viewAccessories.frame.size.height - 10)")
        cell.setup(item: item)
        return cell
    }
    @objc func tapShowMoreProduct(sender:UITapGestureRecognizer){
        let vc = MoreProductViewController()
        vc.listSPTraGopAll = listSPTraGopAll
        vc.product = self.product
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item:Product = product.accessories[indexPath.row]
        let newViewController = DetailAccessoriesVNPTViewController()
        newViewController.product = item
        self.navigationController?.pushViewController(newViewController, animated: true)
        print("You selected cell #\(item.name)")
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
                
                let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                Cache.cartsVNPT.append(cart)
                Cache.itemsPromotionVNPT.removeAll()
                
                let newViewController = CartVNPTViewController()
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
                    
                    let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                    Cache.cartsVNPT.append(cart)
                    Cache.itemsPromotionVNPT.removeAll()
                    let newViewController = CartVNPTViewController()
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
    override func viewWillAppear(_ animated: Bool) {
        Cache.indexScreenShow = self.INDEX
        if (self.product != nil) {
            Cache.product = self.product
        }
        if(!isLoading){
            isLoading = true
            let newViewController = LoadingViewController()
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
class ProductAccessorieCell3: UICollectionViewCell {
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
            let url = URL(string: "\(escapedString)")!
            iconImage.kf.setImage(with: url,
                                  placeholder: nil,
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil,
                                  completionHandler: nil)
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

