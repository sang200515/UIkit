//
//  TabCompareViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/29/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
class TabCompareViewController: UIViewController {
    var productBySku: ProductBySku!
    var scrollView:UIScrollView!
    //    var loading:NVActivityIndicatorView!
    //    var loadingView:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "So sánh"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        productBySku  = Cache.product
        
        let newViewController = LoadingViewController()
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        
        loadTab()
    }
    func loadTab(){
        let nc = NotificationCenter.default
        self.view.subviews.forEach({ $0.removeFromSuperview() })
        //view product
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - UIApplication.shared.statusBarFrame.height - ((navigationController?.navigationBar.frame.size.height)!)))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        if ( Cache.compareProduct != nil){
            if(Cache.compareProduct!.model_id != ""){
                ProductAPIManager.product_detais_by_model_id(model_id: "\(Cache.compareProduct!.model_id)", sku: Cache.compareProduct!.sku, handler: { [weak self](result, err) in
                    guard let self = self else {return}
                    if (err.count > 0 ){
                        let when = DispatchTime.now() + 1
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            var logo : UIImageView
                            logo  = UIImageView(frame:CGRect(x: self.scrollView.frame.size.width/2 - Common.Size(s:25), y: self.scrollView.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50)));
                            logo.image = UIImage(named:"Cancel File-100")
                            logo.contentMode = .scaleAspectFit
                            self.scrollView.addSubview(logo)
                            
                            let productNotFound = "Bạn chưa chọn sản phẩm so sánh"
                            let lbNotFound = UILabel(frame: CGRect(x: 0, y: logo.frame.origin.y + logo.frame.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width, height: Common.Size(s:22)))
                            lbNotFound.textAlignment = .center
                            lbNotFound.textColor = UIColor.lightGray
                            lbNotFound.font = UIFont.systemFont(ofSize: Common.Size(s:15))
                            lbNotFound.text = productNotFound
                            self.scrollView.addSubview(lbNotFound)
                        }
                    }else{
                        let when = DispatchTime.now() + 1
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            self.loadProduct(product:result[0])
                        }
                    }
                })
            }else{
                ProductAPIManager.product_detais_by_sku(sku: "\(Cache.compareProduct!.sku)", handler: { [weak self](result, err) in
                    guard let self = self else {return}
                    if (err.count > 0 ){
                        let when = DispatchTime.now() + 1
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            var logo : UIImageView
                            logo  = UIImageView(frame:CGRect(x: self.scrollView.frame.size.width/2 - Common.Size(s:25), y: self.scrollView.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50)));
                            logo.image = UIImage(named:"Cancel File-100")
                            logo.contentMode = .scaleAspectFit
                            self.scrollView.addSubview(logo)
                            
                            let productNotFound = "Bạn chưa chọn sản phẩm so sánh"
                            let lbNotFound = UILabel(frame: CGRect(x: 0, y: logo.frame.origin.y + logo.frame.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width, height: Common.Size(s:22)))
                            lbNotFound.textAlignment = .center
                            lbNotFound.textColor = UIColor.lightGray
                            lbNotFound.font = UIFont.systemFont(ofSize: Common.Size(s:15))
                            lbNotFound.text = productNotFound
                            self.scrollView.addSubview(lbNotFound)
                        }
                    }else{
                        let when = DispatchTime.now() + 1
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            self.loadProduct(product:result[0])
                        }
                    }
                })
            }
 
        }else{
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                var logo : UIImageView
                logo  = UIImageView(frame:CGRect(x: self.scrollView.frame.size.width/2 - Common.Size(s:25), y: self.scrollView.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50)));
                logo.image = UIImage(named:"Cancel File-100")
                logo.contentMode = .scaleAspectFit
                self.scrollView.addSubview(logo)
                
                let productNotFound = "Bạn chưa chọn sản phẩm so sánh"
                let lbNotFound = UILabel(frame: CGRect(x: 0, y: logo.frame.origin.y + logo.frame.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width, height: Common.Size(s:22)))
                lbNotFound.textAlignment = .center
                lbNotFound.textColor = UIColor.lightGray
                lbNotFound.font = UIFont.systemFont(ofSize: Common.Size(s:15))
                lbNotFound.text = productNotFound
                self.scrollView.addSubview(lbNotFound)
            }
        }}
    func loadProduct(product:ProductBySku) {
        //let product:ProductBySku = Cache.compare!
        let headerLine = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width/2, y:0, width: 0.5, height: scrollView.frame.size.height * 2))
        headerLine.backgroundColor = UIColor.gray
        scrollView.addSubview(headerLine)
        
        var imageProduct1 : UIImageView
        imageProduct1  = UIImageView(frame:CGRect(x: 0, y: Common.Size(s:5), width: UIScreen.main.bounds.size.width/2 - 0.25, height: UIScreen.main.bounds.size.width/2));
        imageProduct1.contentMode = .scaleAspectFit
        scrollView.addSubview(imageProduct1)
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = productBySku.product.imageUrl.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            if(escapedString != ""){
                let url = URL(string: "\(escapedString)")!
                imageProduct1.kf.setImage(with: url,
                                          placeholder: nil,
                                          options: [.transition(.fade(1))],
                                          progressBlock: nil,
                                          completionHandler: nil)
            }
            
        }
        let sizeProductName1 = productBySku.product.name.height(withConstrainedWidth: headerLine.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:16)))
        
        let lbProductName1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: imageProduct1.frame.origin.y + imageProduct1.frame.size.height + Common.Size(s:5), width:headerLine.frame.origin.x - Common.Size(s:10), height: sizeProductName1))
        lbProductName1.textAlignment = .center
        lbProductName1.textColor = UIColor.black
        lbProductName1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbProductName1.text = productBySku.product.name
        lbProductName1.numberOfLines = 3;
        // lbProductName.sizeToFit()
        scrollView.addSubview(lbProductName1)
        //price
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        let productPrice1 = "\(fmt.string(for: productBySku.product.price)!)đ"
        let sizeProductPrice1 = productPrice1.height(withConstrainedWidth: headerLine.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:16)))
        let lbProductPrice1 = UILabel(frame: CGRect(x: Common.Size(s:5) , y: lbProductName1.frame.origin.y + lbProductName1.frame.size.height +  Common.Size(s:5) , width: lbProductName1.frame.size.width, height: sizeProductPrice1))
        lbProductPrice1.textAlignment = .center
        lbProductPrice1.textColor = UIColor.red
        lbProductPrice1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbProductPrice1.text = productPrice1
        lbProductPrice1.numberOfLines = 3;
        scrollView.addSubview(lbProductPrice1)
        
        //2
        var imageProduct2 : UIImageView
        imageProduct2  = UIImageView(frame:CGRect(x: headerLine.frame.origin.x + 0.25, y: Common.Size(s:5), width: UIScreen.main.bounds.size.width/2, height: UIScreen.main.bounds.size.width/2));
        imageProduct2.contentMode = .scaleAspectFit
        scrollView.addSubview(imageProduct2)
        
        
        if let escapedString = product.product.imageUrl.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            if(escapedString != ""){
                let url = URL(string: "\(escapedString)")!
                imageProduct2.kf.setImage(with: url,
                                          placeholder: nil,
                                          options: [.transition(.fade(1))],
                                          progressBlock: nil,
                                          completionHandler: nil)
            }
      
            
        }
        
        let sizeProductName2 = product.product.name.height(withConstrainedWidth: headerLine.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:16)))
        
        let lbProductName2 = UILabel(frame: CGRect(x: headerLine.frame.origin.x + Common.Size(s:5), y: imageProduct2.frame.origin.y + imageProduct2.frame.size.height + Common.Size(s:5), width:headerLine.frame.origin.x - Common.Size(s:10), height: sizeProductName2))
        lbProductName2.textAlignment = .center
        lbProductName2.textColor = UIColor.black
        lbProductName2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbProductName2.text = product.product.name
        lbProductName2.numberOfLines = 3;
        // lbProductName.sizeToFit()
        scrollView.addSubview(lbProductName2)
        
        let productPrice2 = "\(fmt.string(for: product.product.price)!)đ"
        let sizeProductPrice2 = productPrice2.height(withConstrainedWidth: headerLine.frame.origin.x - Common.Size(s:10), font: UIFont.boldSystemFont(ofSize: Common.Size(s:16)))
        let lbProductPrice2 = UILabel(frame: CGRect(x: headerLine.frame.origin.x + Common.Size(s:5) , y: lbProductName2.frame.origin.y + lbProductName2.frame.size.height +  Common.Size(s:5) , width: lbProductName2.frame.size.width, height: sizeProductPrice2))
        lbProductPrice2.textAlignment = .center
        lbProductPrice2.textColor = UIColor.red
        lbProductPrice2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbProductPrice2.text = productPrice2
        lbProductPrice2.numberOfLines = 3;
        scrollView.addSubview(lbProductPrice2)
        var indexYPrice:CGFloat = 0.0
        if ((lbProductPrice1.frame.origin.y + lbProductPrice1.frame.size.height) > (lbProductPrice2.frame.origin.y + lbProductPrice2.frame.size.height)){
            indexYPrice = lbProductPrice1.frame.origin.y + lbProductPrice1.frame.size.height + Common.Size(s:10)
        }else{
            indexYPrice = lbProductPrice2.frame.origin.y + lbProductPrice2.frame.size.height + Common.Size(s:10)
        }
        
        let lbInfoPromotion = UILabel(frame: CGRect(x: 0, y: indexYPrice, width: scrollView.frame.size.width, height: Common.Size(s:35)))
        lbInfoPromotion.textAlignment = .center
        lbInfoPromotion.textColor = UIColor.white
        lbInfoPromotion.backgroundColor = UIColor(netHex:0x04AB6E)
        lbInfoPromotion.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbInfoPromotion.text = "Thông tin khuyến mãi"
        scrollView.addSubview(lbInfoPromotion)
        
        let sizePromotion1 = "\(productBySku.product.promotion.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))".height(withConstrainedWidth: headerLine.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
        
        let lbPromotion1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: lbInfoPromotion.frame.size.height + lbInfoPromotion.frame.origin.y + Common.Size(s:5), width: headerLine.frame.origin.x - Common.Size(s:10), height: sizePromotion1))
        lbPromotion1.textAlignment = .left
        lbPromotion1.textColor = UIColor.black
        lbPromotion1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPromotion1.numberOfLines = 50
        scrollView.addSubview(lbPromotion1)
        
        lbPromotion1.text = productBySku.product.promotion.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        lbPromotion1.sizeToFit()
        
        //
        let sizePromotion2 = "\(product.product.promotion.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))".height(withConstrainedWidth: headerLine.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
        
        let lbPromotion2 = UILabel(frame: CGRect(x:headerLine.frame.origin.x + Common.Size(s:5), y: lbInfoPromotion.frame.size.height + lbInfoPromotion.frame.origin.y + Common.Size(s:5), width: headerLine.frame.origin.x - Common.Size(s:10), height: sizePromotion2))
        lbPromotion2.textAlignment = .left
        lbPromotion2.textColor = UIColor.black
        lbPromotion2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPromotion2.numberOfLines = 50
        scrollView.addSubview(lbPromotion2)
        
        lbPromotion2.text = product.product.promotion.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        lbPromotion2.sizeToFit()
        
        var indexYPromotion:CGFloat = 0.0
        if ((lbPromotion1.frame.origin.y + lbPromotion1.frame.size.height) > (lbPromotion2.frame.origin.y + lbPromotion2.frame.size.height)){
            indexYPromotion = lbPromotion1.frame.origin.y + lbPromotion1.frame.size.height + Common.Size(s:10)
            lbPromotion2.frame.size.height = lbPromotion1.frame.size.height
        }else{
            indexYPromotion = lbPromotion2.frame.origin.y + lbPromotion2.frame.size.height + Common.Size(s:10)
            lbPromotion1.frame.size.height = lbPromotion2.frame.size.height
        }
        
        let lbInfoDes = UILabel(frame: CGRect(x: 0, y: indexYPromotion, width: scrollView.frame.size.width, height: Common.Size(s:35)))
        lbInfoDes.textAlignment = .center
        lbInfoDes.textColor = UIColor.white
        lbInfoDes.backgroundColor = UIColor(netHex:0x04AB6E)
        lbInfoDes.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbInfoDes.text = "Điểm nổi bật"
        scrollView.addSubview(lbInfoDes)
        
        let sizeDes1 =  "\(productBySku.product.hightlightsDes.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))".height(withConstrainedWidth: headerLine.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
        
        let lbDes1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: lbInfoDes.frame.size.height + lbInfoDes.frame.origin.y + Common.Size(s:5), width: headerLine.frame.origin.x - Common.Size(s:10), height: sizeDes1))
        lbDes1.textAlignment = .left
        lbDes1.textColor = UIColor.black
        lbDes1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbDes1.numberOfLines = 20
        scrollView.addSubview(lbDes1)
        lbDes1.text = productBySku.product.hightlightsDes.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        lbDes1.sizeToFit()
        
        //
        let sizeDes2 =  "\(product.product.hightlightsDes.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))".height(withConstrainedWidth: headerLine.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
        
        let lbDes2 = UILabel(frame: CGRect(x: headerLine.frame.origin.x + Common.Size(s:5), y: lbInfoDes.frame.size.height + lbInfoDes.frame.origin.y + Common.Size(s:5), width: headerLine.frame.origin.x - Common.Size(s:10), height: sizeDes2))
        lbDes2.textAlignment = .left
        lbDes2.textColor = UIColor.black
        lbDes2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbDes2.numberOfLines = 20
        scrollView.addSubview(lbDes2)
        lbDes2.text = product.product.hightlightsDes.stripHTML().stringByDecodingHTMLEntities.replace(target: "\t", withString:"- ").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        lbDes2.sizeToFit()
        
        var indexYInfoDes:CGFloat = 0.0
        if ((lbDes1.frame.origin.y + lbDes1.frame.size.height) > (lbDes2.frame.origin.y + lbDes2.frame.size.height)){
            indexYInfoDes = lbDes1.frame.origin.y + lbDes1.frame.size.height + Common.Size(s:10)
            lbDes2.frame.size.height = lbDes1.frame.size.height
        }else{
            indexYInfoDes = lbDes2.frame.origin.y + lbDes2.frame.size.height + Common.Size(s:10)
            lbDes1.frame.size.height = lbDes2.frame.size.height
        }
        
        self.productBySku.atrribute = self.productBySku.atrribute.sorted(by: { $0.group.lowercased() < $1.group.lowercased() })
         product.atrribute = product.atrribute.sorted(by: { $0.group.lowercased() < $1.group.lowercased() })
        if self.productBySku.atrribute.count > 0 {
            for index in 0...(self.productBySku.atrribute.count - 1){
                let item1 = self.productBySku.atrribute[index]
                if(product.atrribute.count - 1 > index){
                    let item2 = product.atrribute[index]
                    
                    let lbInfoBasic = UILabel(frame: CGRect(x: 0, y: indexYInfoDes, width: scrollView.frame.size.width, height: Common.Size(s:30)))
                    lbInfoBasic.textAlignment = .center
                    lbInfoBasic.textColor = UIColor.darkGray
                    lbInfoBasic.backgroundColor = UIColor(netHex: 0xEAEAEA)
                    lbInfoBasic.font = UIFont.systemFont(ofSize: Common.Size(s:16))
                    lbInfoBasic.text = "\(item1.group)"
                    scrollView.addSubview(lbInfoBasic)
                    
                    let lbBasicRow = UILabel(frame: CGRect(x: Common.Size(s:5), y: lbInfoBasic.frame.origin.y + lbInfoBasic.frame.size.height + Common.Size(s:10), width: headerLine.frame.origin.x - Common.Size(s:10), height: 0))
                    lbBasicRow.textAlignment = .center
                    lbBasicRow.textColor = UIColor.black
                    lbBasicRow.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                    lbBasicRow.numberOfLines = 4
                    scrollView.addSubview(lbBasicRow)
                    
                    
                    let lbBasicRow2 = UILabel(frame: CGRect(x: headerLine.frame.origin.x + Common.Size(s:5), y: lbInfoBasic.frame.origin.y + lbInfoBasic.frame.size.height + Common.Size(s:10), width: headerLine.frame.origin.x - Common.Size(s:10), height: 0))
                    lbBasicRow2.textAlignment = .center
                    lbBasicRow2.textColor = UIColor.black
                    lbBasicRow2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                    
                    lbBasicRow2.numberOfLines = 4
                    scrollView.addSubview(lbBasicRow2)
                    for itemAttributes1 in item1.attributes{
                        
                        let heightLb = "\(itemAttributes1.value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))".height(withConstrainedWidth: headerLine.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
                        lbBasicRow.frame.size.height = heightLb
                        
                        
                        lbBasicRow.text = "\(itemAttributes1.value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))"
                        
                    }
                    
                    
                    //
                    for itemAttributes2 in item2.attributes{
                        let heightLb2 = "\(itemAttributes2.value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))".height(withConstrainedWidth: headerLine.frame.origin.x - Common.Size(s:10), font: UIFont.systemFont(ofSize: Common.Size(s:12)))
                        
                        lbBasicRow2.frame.size.height = heightLb2
                        lbBasicRow2.text = "\(itemAttributes2.value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))"
                    }
                    
                    
                    
                    if ((lbBasicRow.frame.origin.y + lbBasicRow.frame.size.height) > (lbBasicRow2.frame.origin.y + lbBasicRow2.frame.size.height)){
                        indexYInfoDes = lbBasicRow.frame.size.height +  lbBasicRow.frame.origin.y + Common.Size(s:10)
                        lbBasicRow2.frame.size.height = lbBasicRow.frame.size.height
                    }else{
                        indexYInfoDes = lbBasicRow2.frame.size.height +  lbBasicRow2.frame.origin.y + Common.Size(s:10)
                        lbBasicRow.frame.size.height = lbBasicRow2.frame.size.height
                    }
                }
                
                
            }
        }
   
     
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: indexYInfoDes + Common.Size(s:10))
        headerLine.frame.size.height = indexYInfoDes + Common.Size(s:10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

