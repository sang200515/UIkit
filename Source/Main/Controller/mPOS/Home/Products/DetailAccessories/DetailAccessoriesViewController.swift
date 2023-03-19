//
//  DetailAccessoriesViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import MIBadgeButton_Swift
import ActionSheetPicker_3_0
import Toaster
class DetailAccessoriesViewController: UIViewController{
    
    var INDEX:Int = 2
    
    var product:Product!
    var productBySku:ProductBySku!
    var viewInfoBasic:UIView!
    
    var scrollView:UIScrollView!
    
    var indexYBasic:CGFloat = 0
    var indexYBasicTemp:CGFloat = 0
    var btCartIcon:MIBadgeButton!
    var productColor:UIView!
    var customAlert = PopUpPickColorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Phụ kiện"
        self.view.backgroundColor = .white
                navigationController?.navigationBar.isTranslucent = false
        //right scan bar code
        
        let btRightIcon = UIButton.init(type: .custom)
        btRightIcon.setImage(#imageLiteral(resourceName: "home"), for: UIControl.State.normal)
        btRightIcon.imageView?.contentMode = .scaleAspectFit
        btRightIcon.addTarget(self, action: #selector(DetailAccessoriesViewController.actionHome), for: UIControl.Event.touchUpInside)
        btRightIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        let barRight = UIBarButtonItem(customView: btRightIcon)
        //        self.navigationItem.rightBarButtonItem = barRight
        
        btCartIcon  = MIBadgeButton.init(type: .custom)
        btCartIcon.setImage(#imageLiteral(resourceName: "cart"), for: UIControl.State.normal)
        btCartIcon.imageView?.contentMode = .scaleAspectFit
        btCartIcon.addTarget(self, action: #selector(DetailAccessoriesViewController.actionCart), for: UIControl.Event.touchUpInside)
        btCartIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        let barCart = UIBarButtonItem(customView: btCartIcon)
        self.navigationItem.rightBarButtonItems = [barCart,barRight]

        
        let newViewController = LoadingViewController()
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
           let nc = NotificationCenter.default
        // call service
        if(product.model_id != ""){
            ProductAPIManager.product_detais_by_model_id(model_id: "\(product.model_id)", sku: product.sku,handler: { (success , error) in
                
                if(Cache.indexScreenShow == self.INDEX){
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        
                        if(success.count > 0){
                            self.loadProduct(product: success[0])
                            self.productBySku = success[0]
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: error, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                                self.navigationController?.popViewController(animated: true)
                            })
                            self.present(alert, animated: true)
                        }
                    }
                }
            })
        }else{
            ProductAPIManager.product_detais_by_sku(sku: "\(product.sku)",handler: { (success , error) in
                
                if(Cache.indexScreenShow == self.INDEX){
                    let when = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        
                        if(success.count > 0){
                            self.loadProduct(product: success[0])
                            self.productBySku = success[0]
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: error, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                                self.navigationController?.popViewController(animated: true)
                            })
                            self.present(alert, animated: true)
                        }
                    }
                }
            })
        }

        
        
    }
    func loadProduct(product:ProductBySku) {
        
        //view product
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 2)
        scrollView.backgroundColor = UIColor(netHex: 0xEAEAEA)
        self.view.addSubview(scrollView)
        //(navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
        
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
        imageProduct  = UIImageView(frame:CGRect(x: 0, y: lbSku.frame.origin.y + lbSku.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width/2, height: scrollView.frame.size.width/2));
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
        lbProductPrice.textColor = UIColor(netHex: 0xD0021B)
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
        
        let lbBonus = UILabel(frame: CGRect(x: imageProduct.frame.origin.x, y: imageProduct.frame.origin.y + imageProduct.frame.size.height + Common.Size(s:5), width: imageProduct.frame.size.width, height: Common.Size(s:12)))
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
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(DetailAccessoriesViewController.tapShowCheckInStock))
        lbCheckInStock.isUserInteractionEnabled = true
        lbCheckInStock.addGestureRecognizer(tap2)
        
        headerProduct.frame.size.height = lbCheckInStock.frame.size.height + lbCheckInStock.frame.origin.y + Common.Size(s:10)
        
        //        var indexYPro = headerProduct.frame.size.height + headerProduct.frame.origin.y
        let viewInfoPromotion = UIView(frame: CGRect(x: 0, y: headerProduct.frame.size.height + headerProduct.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width, height: 0))
        viewInfoPromotion.backgroundColor = UIColor.white
        scrollView.addSubview(viewInfoPromotion)
        
        let promotionText = "\(product.product.promotion.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))"
        
        if (promotionText.count > 0){
            
            let lbInfoPromotion = UILabel(frame: CGRect(x: Common.Size(s: 10), y: 0, width: viewInfoPromotion.frame.size.width - Common.Size(s: 20), height: Common.Size(s:35)))
            lbInfoPromotion.textAlignment = .left
            lbInfoPromotion.textColor =  UIColor(netHex:0x04AB6E)
            lbInfoPromotion.backgroundColor = UIColor.white
            lbInfoPromotion.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbInfoPromotion.text = "Thông tin khuyến mãi"
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
            let viewInfoDes = UIView(frame: CGRect(x: 0, y: indexYDes, width: scrollView.frame.size.width, height: 0))
            viewInfoDes.backgroundColor = UIColor.white
            scrollView.addSubview(viewInfoDes)
            
            let lbInfoDes = UILabel(frame: CGRect(x: Common.Size(s: 10), y: 0, width: viewInfoPromotion.frame.size.width - Common.Size(s: 20), height: Common.Size(s:25)))
            lbInfoDes.textAlignment = .left
            lbInfoDes.textColor = UIColor(netHex:0x04AB6E)
            lbInfoDes.backgroundColor = UIColor.white
            lbInfoDes.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbInfoDes.text = "Điểm nổi bật"
            viewInfoDes.addSubview(lbInfoDes)
            
            
            let sizeDes =  "\(product.product.hightlightsDes.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))".height(withConstrainedWidth: viewInfoPromotion.frame.size.width - Common.Size(s:20), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbDes = UILabel(frame: CGRect(x: Common.Size(s:10), y: lbInfoDes.frame.size.height + lbInfoDes.frame.origin.y, width: viewInfoPromotion.frame.size.width - Common.Size(s:20), height: sizeDes))
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
        viewInfoBasic = UIView(frame: CGRect(x: 0, y: indexYDes, width: scrollView.frame.size.width, height: 0))
        viewInfoBasic.backgroundColor = UIColor.white
        scrollView.addSubview(viewInfoBasic)
        
        if (product.atrribute.count > 0){
            
            let lbInfoBasic = UILabel(frame: CGRect(x: Common.Size(s: 10), y: 0, width: viewInfoBasic.frame.size.width - Common.Size(s: 20), height: Common.Size(s:35)))
            lbInfoBasic.textAlignment = .left
            lbInfoBasic.textColor = UIColor(netHex:0x04AB6E)
            lbInfoBasic.backgroundColor = UIColor.white
            lbInfoBasic.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbInfoBasic.text = "Thông số"
            viewInfoBasic.addSubview(lbInfoBasic)
            
            indexYBasic = lbInfoBasic.frame.size.height + lbInfoBasic.frame.origin.y
            
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
//                var indxGroup:Int = 0
//                for atrribute in item.attributes {
//
//                    let viewInfoBasicRow = UIView(frame: CGRect(x: Common.Size(s: 10), y: indexYBasic, width: lbInfoBasic.frame.size.width, height: 50))
//                    viewInfoBasic.addSubview(viewInfoBasicRow)
//                    if indxGroup % 2 != 0 {
//                        viewInfoBasicRow.backgroundColor  = UIColor(white: 242/255.0, alpha: 1.0)
//                    } else {
//                        viewInfoBasicRow.backgroundColor = UIColor.white
//                    }
//
//                    let viewInfoBasicLine = UIView(frame: CGRect(x: viewInfoBasicRow.frame.size.width * 3/10, y: 0, width: 0.5, height: viewInfoBasicRow.frame.size.height))
//                    viewInfoBasicLine.backgroundColor = UIColor.clear
//                    viewInfoBasicRow.addSubview(viewInfoBasicLine)
//
//
//                    let heightLb = "\(atrribute.name)".height(withConstrainedWidth: viewInfoBasicLine.frame.origin.x - 10, font: UIFont.systemFont(ofSize: Common.Size(s:13)))
//
//                    let lbBasicRow = UILabel(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicLine.frame.origin.x - Common.Size(s:10), height: heightLb))
//                    lbBasicRow.textAlignment = .left
//                    lbBasicRow.textColor = UIColor.black
//                    lbBasicRow.font = UIFont.systemFont(ofSize: Common.Size(s:13))
//                    lbBasicRow.text = "\(atrribute.name)"
//                    lbBasicRow.numberOfLines = 10
//                    viewInfoBasicRow.addSubview(lbBasicRow)
//
//                    let heightValue = "\(atrribute.value)".height(withConstrainedWidth: viewInfoBasicRow.frame.size.width - viewInfoBasicLine.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:13)))
//
//                    let lbBasicValue = UILabel(frame: CGRect(x:viewInfoBasicLine.frame.origin.x + Common.Size(s:5), y: Common.Size(s:10), width: viewInfoBasicRow.frame.size.width - viewInfoBasicLine.frame.origin.x - Common.Size(s:10), height: heightValue))
//                    lbBasicValue.textAlignment = .left
//                    lbBasicValue.textColor = UIColor.black
//                    lbBasicValue.font = UIFont.systemFont(ofSize: Common.Size(s:13))
//                    lbBasicValue.text = "\(atrribute.value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))"
//                    lbBasicValue.numberOfLines = 10
//                    viewInfoBasicRow.addSubview(lbBasicValue)
//
//                    if (heightLb > heightValue){
//                        lbBasicValue.frame.size.height = heightLb
//                        viewInfoBasicRow.frame.size.height = lbBasicRow.frame.origin.y + lbBasicRow.frame.size.height + Common.Size(s:10)
//                    }else{
//                        lbBasicRow.frame.size.height = heightValue
//                        viewInfoBasicRow.frame.size.height = lbBasicValue.frame.origin.y + lbBasicValue.frame.size.height + Common.Size(s:10)
//                    }
//                    viewInfoBasicLine.frame.size.height = viewInfoBasicRow.frame.size.height
//                    let viewInfoBasicLineHeader = UIView(frame: CGRect(x: 0, y: 0, width: viewInfoBasicRow.frame.size.width, height: 0.5))
//                    viewInfoBasicLineHeader.backgroundColor = UIColor.clear
//                    viewInfoBasicRow.addSubview(viewInfoBasicLineHeader)
//
//                    indexYBasic = viewInfoBasicRow.frame.size.height + viewInfoBasicRow.frame.origin.y
//                              indxGroup = indxGroup + 1
//                }
//                break
            }
            
        }
        viewInfoBasic.frame.size.height = indexYBasic
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBasic.frame.origin.y + viewInfoBasic.frame.size.height + Common.Size(s:20))
    }
    @objc func tapShowCheckInStock(sender:UITapGestureRecognizer) {
        var listSku = ""
        for item in productBySku.variant {
            if(listSku == ""){
                listSku = "\(item.sku)"
            }else{
                listSku = "\(listSku),\(item.sku)"
            }
        }
        print("You selected cell \(listSku)")
        let newViewController = ShopInventoryViewController()
        newViewController.listSku = listSku
        newViewController.productName = "\(productBySku.product.name)"
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func cartAction(_ sender:UITapGestureRecognizer){
        if(Cache.user!.type_shop != 0){
            
        }else{
            if(productBySku.product.sku == Common.skuKHTT){
                Toast.init(text: "Bạn không thể thêm sản phẩm này vào giỏ hàng!").show()
                return
            }
        }
        
        var isCheckHaveSim = false // kiem tra gio hang da add sp goi cuoc hay chua
        for item in Cache.carts {
            if(item.product.labelName == "Y"){
                if(productBySku.product.labelName == "Y"){
                    isCheckHaveSim = true
                }
                
            }
            
        }
        if(isCheckHaveSim == true){
            Toast.init(text: "Giỏ hàng chỉ được mua một sản phẩm gói cước !").show()
            return
        }

        
        //
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            ProductAPIManager.mpos_FRT_SP_innovation_MDMH_Sim(itemcode:self.productBySku.product.sku,handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if(err.count <= 0){
                        var arrColor:[String] = []
                        if(self.productBySku.variant.count > 0){
                            for item in self.productBySku.variant {
                                arrColor.append(item.colorName)
                            }
                        }else{
                            arrColor.append(self.productBySku.product.ecomColorName)
                        }
                        
                        if (arrColor.count == 1){
                            if(self.productBySku.variant.count > 0){
                                let sku = self.productBySku.variant[0].sku
                                let colorProduct = self.productBySku.variant[0].colorValue
                                let priceBeforeTax = self.productBySku.variant[0].priceBeforeTax
                                let price = self.productBySku.variant[0].price
                                let product = self.productBySku.product.copy() as! Product
                                product.brandName = results[0].Brandname
                                product.labelName = results[0].p_sim
                                
                                
                                var check:Bool = false
                                
                                for item in Cache.carts {
                                    if(item.product.labelName == "Y"){
                                        isCheckHaveSim = true
                                    }
                                    if (item.sku == sku){
                                        item.quantity = item.quantity + 1
                                        check = true
                                    }
                                }
                                
                                if (check == false){
                                    let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                    Cache.carts.append(cart)
                                }
                                let newViewController = CartViewController()
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }else{
                                let sku = self.productBySku.product.sku
                                let colorProduct = self.productBySku.product.ecomColorValue
                                let priceBeforeTax = self.productBySku.product.priceBeforeTax
                                let price = self.productBySku.product.price
                                let product = self.productBySku.product.copy() as! Product
                                product.brandName = results[0].Brandname
                                product.labelName = results[0].p_sim
                                
                                var check:Bool = false
                                
                                for item in Cache.carts {
                                    if(item.product.labelName == "Y"){
                                        isCheckHaveSim = true
                                    }
                                    if (item.sku == sku){
                                        item.quantity = item.quantity + 1
                                        check = true
                                    }
                                }
                                
                                if (check == false){
                                    let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                    Cache.carts.append(cart)
                                }
                                let newViewController = CartViewController()
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }
                            
                        }else{
                   
                            self.customAlert = PopUpPickColorView()
                            self.customAlert.showAlert(with: "Chọn màu sản phẩm", on: self,productView: self.productBySku,mdmhSimView:results[0],isAccessoriesView:false)
                        }
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                    
                }
                
            })
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let sum = Cache.carts.count
        Cache.indexScreenShow = self.INDEX
        if(sum > 0){
            btCartIcon.badgeString = "\(sum)"
            btCartIcon.badgeTextColor = UIColor.white
            btCartIcon.badgeEdgeInsets = UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 5)
        }else{
            btCartIcon.badgeString = ""
        }
    }
    @objc func actionCart() {
        let newViewController = CartViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func actionHome(){
        _ = self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

extension DetailAccessoriesViewController: PopUpPickColorViewDelegate{
    func reloadbtCardIcon() {
        let sum = Cache.carts.count
        if(sum > 0){
            self.btCartIcon.badgeString = "\(sum)"
            self.btCartIcon.badgeTextColor = UIColor.white
            self.btCartIcon.badgeEdgeInsets = UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 5)
        }else{
            self.btCartIcon.badgeString = ""
        }
        //            Toast(text: "Đã thêm sản phẩm vào giỏ hàng").show()
        let newViewController = CartViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}

