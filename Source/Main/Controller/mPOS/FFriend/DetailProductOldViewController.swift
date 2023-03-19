//
//  DetailProductOldViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/13/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ActionSheetPicker_3_0
import PopupDialog
import UIKit
import MIBadgeButton_Swift
class DetailProductOldViewController: UIViewController{
    var product:ProductOld!
    var scrollView:UIScrollView!
    
    var barCart : UIBarButtonItem!
    var btCartIcon:MIBadgeButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chi tiết"
        self.view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(DetailProductOldViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        btCartIcon  = MIBadgeButton.init(type: .custom)
        btCartIcon.setImage(#imageLiteral(resourceName: "cart"), for: UIControl.State.normal)
        btCartIcon.imageView?.contentMode = .scaleAspectFit
        btCartIcon.addTarget(self, action: #selector(actionCart), for: UIControl.Event.touchUpInside)
        btCartIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barCart = UIBarButtonItem(customView: btCartIcon)
        self.navigationItem.rightBarButtonItems = [barCart]
        
        
        //view product
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 2)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let headerProduct = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.width * 2/3))
        headerProduct.backgroundColor = UIColor.white
        scrollView.addSubview(headerProduct)
        
        //name
        let productName = "\(product.Name)"
        
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
        lbSku.text = "(No.\(product.Sku))"
        headerProduct.addSubview(lbSku)
        
        //image
        var imageProduct : UIImageView
        imageProduct  = UIImageView(frame:CGRect(x: 0, y: lbSku.frame.origin.y + lbSku.frame.size.height + 5, width: scrollView.frame.size.width/2, height: scrollView.frame.size.width/2));
        imageProduct.contentMode = .scaleAspectFit
        headerProduct.addSubview(imageProduct)
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = product.IconUrl.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            let url = URL(string: "\(escapedString)")!
            imageProduct.kf.setImage(with: url,
                                     placeholder: nil,
                                     options: [.transition(.fade(1))],
                                     progressBlock: nil,
                                     completionHandler: nil)
        }
        
        
        let headerLine = UIView(frame: CGRect(x: imageProduct.frame.origin.x + imageProduct.frame.size.width, y:imageProduct.frame.origin.y + imageProduct.frame.size.height/6, width: 0.5, height: imageProduct.frame.size.height * 2/3))
        headerLine.backgroundColor = UIColor(netHex:0x47B054)
        headerProduct.addSubview(headerLine)
        
        //name
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        let productPrice = "\(fmt.string(for: product.Price)!)đ"
        let sizeProductPrice: CGSize = productName.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:22))])
        let lbProductPrice = UILabel(frame: CGRect(x: headerLine.frame.origin.x + Common.Size(s:5) , y: headerLine.frame.origin.y, width: headerProduct.frame.size.width / 2 - Common.Size(s:10), height: sizeProductPrice.height))
        lbProductPrice.textAlignment = .center
        lbProductPrice.textColor = UIColor.red
        lbProductPrice.font = UIFont.boldSystemFont(ofSize: Common.Size(s:22))
        lbProductPrice.text = productPrice
        lbProductPrice.numberOfLines = 3;
        headerProduct.addSubview(lbProductPrice)
        
        let productOldPrice = "\(fmt.string(for: product.OldPrice)!)đ"
        let sizeProductOldPrice: CGSize = productName.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:22))])
        let lbProductOldPrice = UILabel(frame: CGRect(x: headerLine.frame.origin.x + Common.Size(s:5) , y: lbProductPrice.frame.origin.y + lbProductPrice.frame.size.height + Common.Size(s:5), width: headerProduct.frame.size.width / 2 - Common.Size(s:10), height: sizeProductOldPrice.height))
        lbProductOldPrice.textAlignment = .center
        lbProductOldPrice.textColor = UIColor.gray
        lbProductOldPrice.font = UIFont.systemFont(ofSize: Common.Size(s:22))
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: productOldPrice)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        lbProductOldPrice.attributedText =  attributeString
        lbProductOldPrice.numberOfLines = 3;
        headerProduct.addSubview(lbProductOldPrice)
        
        let savingPrice = "Tiết kiệm: \(fmt.string(for: (product.OldPrice - product.Price))!)đ"
        let sizeSavingPrice: CGSize = productName.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:12))])
        let lbSavingPrice = UILabel(frame: CGRect(x: headerLine.frame.origin.x + Common.Size(s:5) , y: lbProductOldPrice.frame.origin.y + lbProductOldPrice.frame.size.height + Common.Size(s:5), width: headerProduct.frame.size.width / 2 - Common.Size(s:10), height: sizeSavingPrice.height))
        lbSavingPrice.textAlignment = .center
        lbSavingPrice.textColor = UIColor(netHex:0x47B054)
        lbSavingPrice.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSavingPrice.text = savingPrice
        lbSavingPrice.numberOfLines = 3;
        headerProduct.addSubview(lbSavingPrice)
        
        let btPay = UIButton()
        btPay.frame = CGRect(x: headerLine.frame.origin.x + Common.Size(s:5), y: lbSavingPrice.frame.origin.y + lbSavingPrice.frame.size.height + Common.Size(s:5), width: headerProduct.frame.size.width / 2 - Common.Size(s:10), height: (headerProduct.frame.size.width / 2 - Common.Size(s:10)) * 0.25)
        btPay.backgroundColor = UIColor(netHex:0xEF4A40)
        btPay.setTitle("Mua ngay", for: .normal)
        btPay.addTarget(self, action: #selector(cartAction(_:)), for: .touchUpInside)
        btPay.layer.borderWidth = 0.5
        btPay.layer.borderColor = UIColor.white.cgColor
        btPay.layer.cornerRadius = 5.0
        
        headerProduct.addSubview(btPay)
        headerProduct.frame.size.height = imageProduct.frame.size.height + imageProduct.frame.origin.y + Common.Size(s:10)
        //
        let viewStatusDes = UIView(frame: CGRect(x: Common.Size(s:5), y: headerProduct.frame.size.height + headerProduct.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:10), height: 0))
        viewStatusDes.backgroundColor = UIColor.white
        viewStatusDes.layer.borderWidth = 0.5
        viewStatusDes.layer.borderColor = UIColor(netHex:0x47B054).cgColor
        viewStatusDes.layer.cornerRadius = 3.0
        scrollView.addSubview(viewStatusDes)
        
        let statusText = "\(product.StatusDescription.replace(target: "<ul><li>", withString:"- ").replace(target: "</li></ul>", withString:"").replace(target: "<li>", withString:"- ").replace(target: "</li>", withString:"\r\n"))"
        if (statusText.count > 0){
            
            let lbInfoPromotion = UILabel(frame: CGRect(x: 0, y: 0, width: viewStatusDes.frame.size.width, height: Common.Size(s:30)))
            lbInfoPromotion.textAlignment = .left
            lbInfoPromotion.textColor = UIColor.white
            lbInfoPromotion.backgroundColor = UIColor(netHex:0x47B054)
            lbInfoPromotion.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbInfoPromotion.text = " Trình trạng thực tế"
            viewStatusDes.addSubview(lbInfoPromotion)
            
            let sizeStatus = "\(statusText)".height(withConstrainedWidth: viewStatusDes.frame.size.width - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbStatusDes = UILabel(frame: CGRect(x: Common.Size(s:5), y: lbInfoPromotion.frame.size.height + lbInfoPromotion.frame.origin.y + Common.Size(s:5), width: viewStatusDes.frame.size.width - Common.Size(s:10), height: sizeStatus))
            lbStatusDes.textAlignment = .left
            lbStatusDes.textColor = UIColor.black
            lbStatusDes.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbStatusDes.numberOfLines = 50
            viewStatusDes.addSubview(lbStatusDes)
            
            lbStatusDes.text = "\(statusText)"
            lbStatusDes.sizeToFit()
            viewStatusDes.frame.size.height = lbStatusDes.frame.origin.y + lbStatusDes.frame.size.height  + Common.Size(s:5)
        }
        var indexYDes = viewStatusDes.frame.size.height + viewStatusDes.frame.origin.y + Common.Size(s:10)
        if (product.HightlightsDes.count > 0){
            let viewInfoDes = UIView(frame: CGRect(x: 5, y: indexYDes, width: scrollView.frame.size.width - Common.Size(s:10), height: 0))
            viewInfoDes.backgroundColor = UIColor.white
            viewInfoDes.layer.borderWidth = 0.5
            viewInfoDes.layer.borderColor = UIColor(netHex:0x47B054).cgColor
            viewInfoDes.layer.cornerRadius = 3.0
            scrollView.addSubview(viewInfoDes)
            
            let lbInfoDes = UILabel(frame: CGRect(x: 0, y: 0, width: viewStatusDes.frame.size.width, height: Common.Size(s:30)))
            lbInfoDes.textAlignment = .left
            lbInfoDes.textColor = UIColor.white
            lbInfoDes.backgroundColor = UIColor(netHex:0x47B054)
            lbInfoDes.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbInfoDes.text = " Điểm nổi bật"
            viewInfoDes.addSubview(lbInfoDes)
            
            
            let sizeDes =  "\(product.HightlightsDes.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))".height(withConstrainedWidth: viewStatusDes.frame.size.width - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
            
            let lbDes = UILabel(frame: CGRect(x: Common.Size(s:5), y: lbInfoDes.frame.size.height + lbInfoDes.frame.origin.y + Common.Size(s:5), width: viewInfoDes.frame.size.width - Common.Size(s:10), height: sizeDes))
            lbDes.textAlignment = .left
            lbDes.textColor = UIColor.black
            lbDes.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            lbDes.numberOfLines = 20
            viewInfoDes.addSubview(lbDes)
            lbDes.text = product.HightlightsDes.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            lbDes.sizeToFit()
            viewInfoDes.frame.size.height = lbDes.frame.origin.y + lbDes.frame.size.height + Common.Size(s:5)
            
            indexYDes = viewInfoDes.frame.size.height + viewInfoDes.frame.origin.y + Common.Size(s:10)
        }
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: indexYDes + Common.Size(s:20))
        
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func actionOpenMenuLeft() {
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func actionCart() {
        let newViewController = CartFFriendViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let sum = Cache.cartsFF.count
        if(sum > 0){
            btCartIcon.badgeString = "\(sum)"
            btCartIcon.badgeTextColor = UIColor.white
            btCartIcon.badgeEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 0, right: 12)
        }else{
            btCartIcon.badgeString = ""
        }
    }
    @objc func cartAction(_ sender:UITapGestureRecognizer){
        let pro = Product(model_id: "",id: self.product.ID, name: self.product.Name, brandID: self.product.BrandID, brandName: self.product.BrandName, typeId: self.product.TypeID, typeName: self.product.TypeName, sku: self.product.Sku, price: self.product.Price, priceMarket: 0, priceBeforeTax: 0, iconUrl: self.product.IconUrl, imageUrl: self.product.ImageUrl, promotion: "", includeInfo: "", hightlightsDes: self.product.HightlightsDes, labelName: self.product.LabelName, urlLabelPicture: self.product.UrlLabelPicture, isRecurring: true, manSerNum: self.product.ManSerNum, bonusScopeBoom: "", qlSerial: "Y",inventory:0, LableProduct: "",p_matkinh:"",ecomColorValue:"",ecomColorName:"", ecom_itemname_web: "",price_special: 0,price_online_pos: 0, price_online: 0, hotSticker: false, is_NK: false, is_ExtendedWar: false,skuBH: [],nameBH: [],brandGoiBH:[],isPickGoiBH:"",amountGoiBH:"",itemCodeGoiBH: "",itemNameGoiBH: "" ,priceSauKM: 0,role2: [])
        let cart = Cart(sku: self.product.Sku, product: pro,quantity: 1,color:"#ffffff",inStock:-1, imei: "N/A",price: self.product.Price, priceBT: 0, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
        Cache.cartsFF.append(cart)
        Cache.itemsPromotionFF.removeAll()
        let newViewController = CartFFriendViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

