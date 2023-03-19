//
//  DetailProductSubsidyViewController.swift
//  mPOS
//
//  Created by MinhDH on 4/24/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import PopupDialog
import UIKit
import ActionSheetPicker_3_0
import Toaster
class DetailProductSubsidyViewController: UIViewController,UITextFieldDelegate{
    
    var productSubSidy:ItemCodeSubSidy!
    var product:ProductBySku!
    var ssd: SSDGoiCuoc!
    
    var indexYBasic:CGFloat = 0
    var indexYBasicTemp:CGFloat = 0
    var viewInfoBasic:UIView!
    var lbInfoBasicMore:UILabel!
    var viewAccessories:UIView!
    var collectionView: UICollectionView!
    var productColor:UIView!
    var scrollView:UIScrollView!
    var money:Float = 0
    var sumMoney:Float = 0
    override func viewDidLoad() {
        self.title = "Chi tiết sản phẩm"
        self.view.backgroundColor = UIColor.white
        
        let btRightIcon = UIButton.init(type: .custom)
        btRightIcon.setImage(#imageLiteral(resourceName: "home"), for: UIControl.State.normal)
        btRightIcon.imageView?.contentMode = .scaleAspectFit
        btRightIcon.addTarget(self, action: #selector(DetailProductSubsidyViewController.actionHome), for: UIControl.Event.touchUpInside)
        btRightIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        let barRight = UIBarButtonItem(customView: btRightIcon)
        self.navigationItem.rightBarButtonItem = barRight
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        // call service
        ProductAPIManager.product_detais_by_sku(sku: "\(productSubSidy.ItemCode)",handler: { (success , error) in
            
            if(error.count <= 0){
                MPOSAPIManager.mpos_sp_Get_ThongTinSSD_from_itemcode_goicuoc(MaSPMay: "\(self.productSubSidy.ItemCode)", MaSPGoiCuoc: "\(self.ssd.MaSP)", SoTienChiTieu: self.money, GiaMay: self.productSubSidy.Price, handler: { (results, err) in
                    
                    if(err.count <= 0){
                        if(results.count > 0){
                            MPOSAPIManager.sp_mpos_FRT_SP_SSD_SoSanhGoiSSD_GoiThuong(GiaMay: "\(String(format: "%.6f", self.productSubSidy.Price))", MaSP_goicuoc: "\(self.ssd.MaSP)") { (resultsAA, err) in
                                if(err.count <= 0){
                                    let when = DispatchTime.now() + 1
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                        self.loadProduct(product: success[0],info:results[0],SoSanhSSD: resultsAA)
                                    }
                                }else{
                                    let when = DispatchTime.now() + 1
                                    DispatchQueue.main.asyncAfter(deadline: when) {
                                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                        let popup = PopupDialog(title: "THÔNG BÁO", message: "Không tìm thấy thông tin Subsidy!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                            print("Completed")
                                        }
                                        let buttonOne = CancelButton(title: "OK") {
                                            _ = self.navigationController?.popViewController(animated: true)
                                            self.dismiss(animated: true, completion: nil)
                                        }
                                        popup.addButtons([buttonOne])
                                        self.present(popup, animated: true, completion: nil)
                                    }
                                }
                            }
                        }else{
                            let when = DispatchTime.now() + 1
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                let popup = PopupDialog(title: "THÔNG BÁO", message: "Không tìm thấy thông tin Subsidy!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let buttonOne = CancelButton(title: "OK") {
                                    _ = self.navigationController?.popViewController(animated: true)
                                    self.dismiss(animated: true, completion: nil)
                                }
                                popup.addButtons([buttonOne])
                                self.present(popup, animated: true, completion: nil)
                            }
                        }
                    }else{
                        let when = DispatchTime.now() + 1
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            let popup = PopupDialog(title: "THÔNG BÁO", message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                _ = self.navigationController?.popViewController(animated: true)
                                self.dismiss(animated: true, completion: nil)
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    }
                })
            }else{
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    let popup = PopupDialog(title: "THÔNG BÁO", message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        _ = self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
                
            }
        })
        
    }
    func loadProduct(product:ProductBySku,info:ThongTinSSD,SoSanhSSD:[SoSanhGoiSSD]) {
        self.product = product
        self.indexYBasic = 0
        //view product
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y:0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 2)
        scrollView.backgroundColor = UIColor.white
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
        lbProductName.textColor = UIColor(netHex:0xb8462e)
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
        lbSku.text = "No.\(product.product.sku)"
        headerProduct.addSubview(lbSku)
        
        let lbBonus = UILabel(frame: CGRect(x: lbSku.frame.origin.x, y: lbSku.frame.origin.y + lbSku.frame.size.height + Common.Size(s:5), width: lbSku.frame.size.width, height: Common.Size(s:12)))
        lbBonus.textAlignment = .center
        lbBonus.textColor =  UIColor(netHex:0x47B054)
        lbBonus.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbBonus.text = "(\(product.product.bonusScopeBoom))"
        headerProduct.addSubview(lbBonus)
        
        //image
        var imageProduct : UIImageView
        imageProduct  = UIImageView(frame:CGRect(x: 0, y: lbBonus.frame.origin.y + lbBonus.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width/2, height: scrollView.frame.size.width/2));
        imageProduct.contentMode = .scaleAspectFit
        headerProduct.addSubview(imageProduct)
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = product.product.iconUrl.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
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
        
        
        
        let priceOld = UILabel(frame: CGRect(x: headerLine.frame.origin.x + Common.Size(s:5), y: imageProduct.frame.origin.y, width: headerProduct.frame.size.width / 2 - Common.Size(s:10), height: Common.Size(s:14)))
        priceOld.textAlignment = .center
        priceOld.textColor = UIColor.darkGray
        priceOld.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: Common.convertCurrencyFloat(value: productSubSidy.Price))
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        priceOld.attributedText =  attributeString
        priceOld.numberOfLines = 1
        headerProduct.addSubview(priceOld)
        
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        let productPrice = "\(fmt.string(for:productSubSidy.TienSauTroGia)!)đ"
        let sizeProductPrice: CGSize = productName.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Common.Size(s:22))])
        let lbProductPrice = UILabel(frame: CGRect(x: headerLine.frame.origin.x + Common.Size(s:5) , y: priceOld.frame.origin.y + priceOld.frame.size.height + Common.Size(s:5), width: headerProduct.frame.size.width / 2 - Common.Size(s:10), height: sizeProductPrice.height))
        lbProductPrice.textAlignment = .center
        lbProductPrice.textColor = UIColor.red
        lbProductPrice.font = UIFont.boldSystemFont(ofSize: Common.Size(s:22))
        lbProductPrice.text = productPrice
        lbProductPrice.numberOfLines = 3;
        headerProduct.addSubview(lbProductPrice)
        
        let priceSubString = UILabel(frame: CGRect(x: headerLine.frame.origin.x + Common.Size(s:5), y: lbProductPrice.frame.origin.y + lbProductPrice.frame.size.height + Common.Size(s:5), width: headerProduct.frame.size.width / 2 - Common.Size(s:10), height: Common.Size(s:10)))
        priceSubString.textAlignment = .center
        priceSubString.textColor = UIColor.darkGray
        priceSubString.font = UIFont.italicSystemFont(ofSize: Common.Size(s:10))
        priceSubString.text = "Trợ giá: \(Common.convertCurrencyFloat(value: productSubSidy.SoTienTroGia))"
        priceSubString.numberOfLines = 1
        headerProduct.addSubview(priceSubString)
        
        //color
        if (product.variant.count <= 4 ){
            productColor = UIView(frame: CGRect(x: headerLine.frame.origin.x + 1, y: priceSubString.frame.origin.y + lbProductPrice.frame.size.height + Common.Size(s:5), width: headerProduct.frame.size.width/2, height: (headerProduct.frame.size.width/8) * 1.4))
            productColor.backgroundColor = .white
        }else if (product.variant.count > 4){
            productColor = UIView(frame: CGRect(x: headerLine.frame.origin.x + 1, y: priceSubString.frame.origin.y + lbProductPrice.frame.size.height + Common.Size(s:5), width: headerProduct.frame.size.width/2, height: (headerProduct.frame.size.width/8) * 1.4  * 2))
            productColor.backgroundColor = .white
        }else if (product.variant.count > 8){
            productColor = UIView(frame: CGRect(x: headerLine.frame.origin.x + 1, y: priceSubString.frame.origin.y + lbProductPrice.frame.size.height + Common.Size(s:5) , width: headerProduct.frame.size.width/2, height: (headerProduct.frame.size.width/8) * 1.4 * 3))
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
        btPay.clipsToBounds = true
        headerProduct.addSubview(btPay)
        //        headerProduct.backgroundColor = .red
        
        headerProduct.frame.size.height = imageProduct.frame.size.height + imageProduct.frame.origin.y + Common.Size(s:10)
        
        if (imageProduct.frame.size.height + imageProduct.frame.origin.y) < (btPay.frame.size.height + btPay.frame.origin.y) {
            
            headerProduct.frame.size.height = btPay.frame.size.height + btPay.frame.origin.y + Common.Size(s:10)
        }
        
        
        let lbViewSSD = UILabel(frame: CGRect(x: headerProduct.frame.size.width/2 - headerProduct.frame.size.width * 2/6, y: headerProduct.frame.origin.y + headerProduct.frame.size.height + Common.Size(s:10), width: headerProduct.frame.size.width * 2/3, height: Common.Size(s: 30)))
        lbViewSSD.textAlignment = .center
        lbViewSSD.textColor = UIColor.white
        lbViewSSD.layer.cornerRadius = 15
        lbViewSSD.backgroundColor = UIColor(netHex:0x467dcd)
        lbViewSSD.font = UIFont.italicSystemFont(ofSize: Common.Size(s: 13))
        //        lbViewSSD.text = "Xem chi tiết gói cước \(ssd.TenGoiCuoc)"
        lbViewSSD.numberOfLines = 1
        lbViewSSD.clipsToBounds = true
        scrollView.addSubview(lbViewSSD)
        
        lbViewSSD.attributedText = Common.attributedText(withString: "Xem chi tiết gói cước \(ssd.TenGoiCuoc)", boldString: "\(ssd.TenGoiCuoc)", font: UIFont.systemFont(ofSize: Common.Size(s:13)))
        
        let tapViewSSD = UITapGestureRecognizer(target: self, action: #selector(DetailProductSubsidyViewController.functionViewSSD))
        lbViewSSD.isUserInteractionEnabled = true
        lbViewSSD.addGestureRecognizer(tapViewSSD)
        
        
        let lbInfo = UILabel(frame: CGRect(x: Common.Size(s:5), y: lbViewSSD.frame.size.height + lbViewSSD.frame.origin.y + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:10) , height: Common.Size(s:20)))
        lbInfo.textAlignment = .left
        lbInfo.textColor = UIColor.black
        lbInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbInfo.text = "So sánh mua hàng:"
        scrollView.addSubview(lbInfo)
        
        let viewInfoPromotion = UIView(frame: CGRect(x: Common.Size(s:5), y: lbInfo.frame.size.height + lbInfo.frame.origin.y + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:10), height: scrollView.frame.size.width * 2/3))
        viewInfoPromotion.backgroundColor = UIColor.white
        viewInfoPromotion.layer.borderWidth = Common.Size(s:1)
        viewInfoPromotion.layer.borderColor = UIColor(netHex:0x018d11).cgColor
        viewInfoPromotion.layer.cornerRadius = 3.0
        scrollView.addSubview(viewInfoPromotion)
        
        
        let viewInfoRowHeader = UIView(frame: CGRect(x: 0, y: 0, width: viewInfoPromotion.frame.size.width, height: Common.Size(s:30)))
        viewInfoRowHeader.backgroundColor = UIColor(netHex:0x47b053)
        viewInfoPromotion.addSubview(viewInfoRowHeader)
        
        let viewLine1 = UIView(frame: CGRect(x:(viewInfoRowHeader.frame.size.width * 3 / 10), y: 0 ,width: Common.Size(s:1), height: Common.Size(s:100)))
        viewLine1.backgroundColor = UIColor(netHex:0x018d11)
        viewInfoPromotion.addSubview(viewLine1)
        
        //
        let lbInfoHeaderC2 = UILabel(frame: CGRect(x: viewLine1.frame.origin.x, y: 0, width: (viewInfoRowHeader.frame.size.width * 3.5 / 10), height: viewInfoRowHeader.frame.size.height))
        lbInfoHeaderC2.textAlignment = .center
        lbInfoHeaderC2.textColor = UIColor.white
        lbInfoHeaderC2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbInfoHeaderC2.text = "Thông thường"
        viewInfoRowHeader.addSubview(lbInfoHeaderC2)
        
        let lbInfoR1C1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: viewInfoRowHeader.frame.size.height + viewInfoRowHeader.frame.origin.y, width: (viewInfoRowHeader.frame.size.width * 3 / 10) - Common.Size(s:10), height: viewInfoRowHeader.frame.size.height))
        lbInfoR1C1.textAlignment = .left
        lbInfoR1C1.textColor = UIColor.black
        lbInfoR1C1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbInfoR1C1.text = "Tiền máy"
        viewInfoPromotion.addSubview(lbInfoR1C1)
        
        let viewLine3 = UIView(frame: CGRect(x:0, y: lbInfoR1C1.frame.size.height + lbInfoR1C1.frame.origin.y ,width: viewInfoRowHeader.frame.size.width, height: Common.Size(s:0.8)))
        viewLine3.backgroundColor = UIColor(netHex:0x018d11)
        viewInfoPromotion.addSubview(viewLine3)
        
        let lbInfoR2C1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: viewLine3.frame.size.height + viewLine3.frame.origin.y, width: (viewInfoRowHeader.frame.size.width * 3 / 10) - Common.Size(s:10), height: viewInfoRowHeader.frame.size.height))
        lbInfoR2C1.textAlignment = .left
        lbInfoR2C1.textColor = UIColor.black
        lbInfoR2C1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbInfoR2C1.text = "Tiền trợ giá"
        viewInfoPromotion.addSubview(lbInfoR2C1)
        
        let viewLine4 = UIView(frame: CGRect(x:0, y: lbInfoR2C1.frame.size.height + lbInfoR2C1.frame.origin.y ,width: viewInfoRowHeader.frame.size.width, height: Common.Size(s:1)))
        viewLine4.backgroundColor = UIColor(netHex:0x018d11)
        viewInfoPromotion.addSubview(viewLine4)
        
        let lbInfoR3C1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: viewLine4.frame.size.height + viewLine4.frame.origin.y, width: (viewInfoRowHeader.frame.size.width * 3 / 10) - Common.Size(s:10), height: viewInfoRowHeader.frame.size.height * 1.5))
        lbInfoR3C1.textAlignment = .left
        lbInfoR3C1.textColor = UIColor.black
        lbInfoR3C1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbInfoR3C1.text = "Tiền cước trong 1 năm"
        lbInfoR3C1.numberOfLines = 2
        viewInfoPromotion.addSubview(lbInfoR3C1)
        
        let viewLine5 = UIView(frame: CGRect(x:0, y: lbInfoR3C1.frame.size.height + lbInfoR3C1.frame.origin.y ,width: viewInfoRowHeader.frame.size.width, height: Common.Size(s:0.8)))
        viewLine5.backgroundColor = UIColor(netHex:0x018d11)
        viewInfoPromotion.addSubview(viewLine5)
        
        let lbInfoR4C1 = UILabel(frame: CGRect(x: Common.Size(s:5), y: viewLine5.frame.size.height + viewLine5.frame.origin.y, width: (viewInfoRowHeader.frame.size.width * 3 / 10) - Common.Size(s:10), height: viewInfoRowHeader.frame.size.height * 1.5))
        lbInfoR4C1.textAlignment = .left
        lbInfoR4C1.textColor = UIColor.black
        lbInfoR4C1.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbInfoR4C1.text = "Tổng chi trong 1 năm"
        lbInfoR4C1.numberOfLines = 2
        viewInfoPromotion.addSubview(lbInfoR4C1)
        
        let viewLine6 = UIView(frame: CGRect(x:0, y: lbInfoR4C1.frame.size.height + lbInfoR4C1.frame.origin.y ,width: viewInfoRowHeader.frame.size.width, height: Common.Size(s:0.8)))
        viewLine6.backgroundColor = UIColor(netHex:0x018d11)
        viewInfoPromotion.addSubview(viewLine6)
        
        
        
        
        let viewLine2 = UIView(frame: CGRect(x:viewInfoRowHeader.frame.size.width * 6.5 / 10, y: 0 ,width: Common.Size(s:1), height: Common.Size(s:100)))
        viewLine2.backgroundColor = UIColor(netHex:0x018d11)
        viewInfoPromotion.addSubview(viewLine2)
        
        let lbInfoHeaderC3 = UILabel(frame: CGRect(x: viewLine2.frame.origin.x, y: 0, width: (viewInfoRowHeader.frame.size.width * 3.5 / 10), height: viewInfoRowHeader.frame.size.height))
        lbInfoHeaderC3.textAlignment = .center
        lbInfoHeaderC3.textColor = UIColor.white
        lbInfoHeaderC3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbInfoHeaderC3.text = "Subsidy"
        viewInfoRowHeader.addSubview(lbInfoHeaderC3)
        
        let lbValueR1C2 = UILabel(frame: CGRect(x: viewLine1.frame.size.width + viewLine1.frame.origin.x + Common.Size(s:5), y: lbInfoR1C1.frame.origin.y, width: (viewInfoRowHeader.frame.size.width * 3.5 / 10) - Common.Size(s:10), height: viewInfoRowHeader.frame.size.height))
        lbValueR1C2.textAlignment = .center
        lbValueR1C2.textColor = UIColor.black
        lbValueR1C2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbValueR1C2.text = "\(Common.convertCurrencyFloat(value: productSubSidy.Price))"
        viewInfoPromotion.addSubview(lbValueR1C2)
        
        let lbValueR1C3 = UILabel(frame: CGRect(x: viewLine2.frame.size.width + viewLine2.frame.origin.x + Common.Size(s:5), y: lbInfoR1C1.frame.origin.y, width: (viewInfoRowHeader.frame.size.width * 3.5 / 10) - Common.Size(s:10), height: viewInfoRowHeader.frame.size.height))
        lbValueR1C3.textAlignment = .center
        lbValueR1C3.textColor = UIColor.black
        lbValueR1C3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbValueR1C3.text = "\(Common.convertCurrencyFloat(value: productSubSidy.Price))"
        viewInfoPromotion.addSubview(lbValueR1C3)
        
        
        
        //r2
        let lbValueR2C2 = UILabel(frame: CGRect(x: viewLine1.frame.size.width + viewLine1.frame.origin.x + Common.Size(s:5), y: viewLine3.frame.origin.y + viewLine3.frame.size.height, width: (viewInfoRowHeader.frame.size.width * 3.5 / 10) - Common.Size(s:10), height: viewInfoRowHeader.frame.size.height))
        lbValueR2C2.textAlignment = .center
        lbValueR2C2.textColor = UIColor.black
        lbValueR2C2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbValueR2C2.text = "\(Common.convertCurrency(value: 0))"
        viewInfoPromotion.addSubview(lbValueR2C2)
        
        let lbValueR2C3 = UILabel(frame: CGRect(x: viewLine2.frame.size.width + viewLine2.frame.origin.x + Common.Size(s:5), y: lbValueR2C2.frame.origin.y, width: (viewInfoRowHeader.frame.size.width * 3.5 / 10) - Common.Size(s:10), height: viewInfoRowHeader.frame.size.height))
        lbValueR2C3.textAlignment = .center
        lbValueR2C3.textColor = UIColor.red
        lbValueR2C3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbValueR2C3.text = "\(Common.convertCurrencyFloat(value: productSubSidy.SoTienTroGia))"
        viewInfoPromotion.addSubview(lbValueR2C3)
        
        //r3
        let lbValueR3C2L1 = UILabel(frame: CGRect(x: viewLine1.frame.size.width + viewLine1.frame.origin.x + Common.Size(s:5), y: viewLine4.frame.origin.y + viewLine4.frame.size.height, width: (viewInfoRowHeader.frame.size.width * 3.5 / 10) - Common.Size(s:10), height: (viewInfoRowHeader.frame.size.height * 1.5)/2))
        lbValueR3C2L1.textAlignment = .center
        lbValueR3C2L1.textColor = UIColor.black
        lbValueR3C2L1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbValueR3C2L1.text = "\(info.SoTien1NamText)"
        viewInfoPromotion.addSubview(lbValueR3C2L1)
        
        let lbValueR3C3L1 = UILabel(frame: CGRect(x: viewLine2.frame.size.width + viewLine2.frame.origin.x + Common.Size(s:5), y: lbValueR3C2L1.frame.origin.y, width: (viewInfoRowHeader.frame.size.width * 3.5 / 10) - Common.Size(s:10), height: lbValueR3C2L1.frame.size.height))
        lbValueR3C3L1.textAlignment = .center
        lbValueR3C3L1.textColor = UIColor.black
        lbValueR3C3L1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbValueR3C3L1.text = "\(info.SoTien1NamTextSub)"
        viewInfoPromotion.addSubview(lbValueR3C3L1)
        
        let lbValueR3C2L2 = UILabel(frame: CGRect(x: viewLine1.frame.size.width + viewLine1.frame.origin.x + Common.Size(s:5), y: lbValueR3C2L1.frame.origin.y + lbValueR3C2L1.frame.size.height, width: (viewInfoRowHeader.frame.size.width * 3.5 / 10) - Common.Size(s:10), height: lbValueR3C2L1.frame.size.height))
        lbValueR3C2L2.textAlignment = .center
        lbValueR3C2L2.textColor = UIColor.black
        lbValueR3C2L2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbValueR3C2L2.text = "\(Common.convertCurrencyFloat(value: info.SoTien1Nam))"
        viewInfoPromotion.addSubview(lbValueR3C2L2)
        
        let lbValueR3C3L2 = UILabel(frame: CGRect(x: viewLine2.frame.size.width + viewLine2.frame.origin.x + Common.Size(s:5), y: lbValueR3C2L2.frame.origin.y, width: (viewInfoRowHeader.frame.size.width * 3.5 / 10) - Common.Size(s:10), height: lbValueR3C2L1.frame.size.height))
        lbValueR3C3L2.textAlignment = .center
        lbValueR3C3L2.textColor = UIColor.black
        lbValueR3C3L2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbValueR3C3L2.text = "\(Common.convertCurrencyFloat(value:  info.SoTien1NamSub))"
        viewInfoPromotion.addSubview(lbValueR3C3L2)
        
        //r4
        let lbValueR4C2 = UILabel(frame: CGRect(x: viewLine1.frame.size.width + viewLine1.frame.origin.x + Common.Size(s:5), y: viewLine5.frame.origin.y + viewLine5.frame.size.height, width: (viewInfoRowHeader.frame.size.width * 3.5 / 10) - Common.Size(s:10), height: viewInfoRowHeader.frame.size.height * 1.5))
        lbValueR4C2.textAlignment = .center
        lbValueR4C2.textColor = UIColor.black
        lbValueR4C2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbValueR4C2.text = "\(Common.convertCurrencyFloat(value: (info.Tong1namchitieu)))"
        viewInfoPromotion.addSubview(lbValueR4C2)
        
        let lbValueR4C3 = UILabel(frame: CGRect(x: viewLine2.frame.size.width + viewLine2.frame.origin.x + Common.Size(s:5), y: lbValueR4C2.frame.origin.y, width: (viewInfoRowHeader.frame.size.width * 3.5 / 10) - Common.Size(s:10), height: viewInfoRowHeader.frame.size.height * 1.5))
        lbValueR4C3.textAlignment = .center
        lbValueR4C3.textColor = UIColor.red
        lbValueR4C3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbValueR4C3.text = "\(Common.convertCurrencyFloat(value:  (info.Tong1namssd)))"
        viewInfoPromotion.addSubview(lbValueR4C3)
        
        let lbInfoR5C0 = UILabel(frame: CGRect(x: viewLine6.frame.origin.x, y: viewLine6.frame.size.height + viewLine6.frame.origin.y, width: viewInfoRowHeader.frame.size.width, height: viewInfoRowHeader.frame.size.height))
        lbInfoR5C0.textAlignment = .center
        lbInfoR5C0.textColor = UIColor.red
        lbInfoR5C0.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        //        lbInfoR5C0.text = "Tiết kiệm được \(Common.convertCurrencyFloat(value:  (info.Tong1namchitieu - info.Tong1namssd))) khi mua gói Subsidy"
        //        lbInfoR5C0.attributedText = Common.attributedText(withString:  "Tiết kiệm được \(Common.convertCurrencyFloat(value:  (info.Tong1namchitieu - info.Tong1namssd))) khi mua gói Subsidy", boldString: "\(Common.convertCurrencyFloat(value:  (info.Tong1namchitieu - info.Tong1namssd)))", font: UIFont.systemFont(ofSize: Common.Size(s:13)))
        lbInfoR5C0.numberOfLines = 2
        viewInfoPromotion.addSubview(lbInfoR5C0)
        
        let attrStr = try! NSAttributedString(
            data: "\(info.TongChenhLech)".data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
        lbInfoR5C0.attributedText = attrStr
        let sizeF = lbInfoR5C0.sizeThatFits(lbInfoR5C0.frame.size)
        lbInfoR5C0.frame.size.height = sizeF.height
        
        
        sumMoney = info.Tong1namchitieu - info.Tong1namssd
        
        viewLine2.frame.size.height = lbValueR4C3.frame.size.height + lbValueR4C3.frame.origin.y
        viewLine1.frame.size.height = lbValueR4C3.frame.size.height + lbValueR4C3.frame.origin.y
        viewInfoPromotion.frame.size.height = lbInfoR5C0.frame.size.height + lbInfoR5C0.frame.origin.y
        
        //view product
        let scrollViewSoSanh = UIScrollView(frame: CGRect(x: viewInfoPromotion.frame.origin.x, y:viewInfoPromotion.frame.size.height + viewInfoPromotion.frame.origin.y + Common.Size(s:10), width: viewInfoPromotion.frame.size.width, height: self.view.frame.size.height/4))
        scrollViewSoSanh.contentSize = CGSize(width:UIScreen.main.bounds.size.width - Common.Size(s: 10), height: self.view.frame.size.height/4)
        scrollViewSoSanh.backgroundColor = UIColor.white
        scrollViewSoSanh.layer.borderWidth = 1
        scrollViewSoSanh.layer.borderColor = UIColor(netHex:0x018d11).cgColor
        scrollViewSoSanh.layer.cornerRadius = 3.0
        self.scrollView.addSubview(scrollViewSoSanh)
        if(SoSanhSSD.count > 0){
            let viewLineHeader = UIView(frame: CGRect(x: 0, y: 0, width: scrollViewSoSanh.frame.size.width/3, height: Common.Size(s: 30)))
            viewLineHeader.backgroundColor = UIColor.white
            scrollViewSoSanh.addSubview(viewLineHeader)
            
            let arrHeader:[String] = ["","Tiền máy","Tiền trợ gía","Tiền cước trong 1 năm","Tổng chi trong 1 năm","Data ngày","Data tháng","Thoại nội mạng","Thoại ngoại mạng","SMS"]
            var yHeader: CGFloat = 0
            for item in arrHeader {
                let lbInfoHeader = UILabel(frame: CGRect(x: 0, y: yHeader, width: scrollViewSoSanh.frame.size.width/3 , height: Common.Size(s: 35)))
                lbInfoHeader.textAlignment = .center
                lbInfoHeader.textColor = UIColor.black
                lbInfoHeader.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                lbInfoHeader.text = item
                lbInfoHeader.numberOfLines = 2
                viewLineHeader.addSubview(lbInfoHeader)
                if(yHeader == 0){
                    lbInfoHeader.backgroundColor = UIColor(netHex:0x47b053)
                }
                
                let viewLine1 = UIView(frame: CGRect(x:0, y: lbInfoHeader.frame.origin.y + lbInfoHeader.frame.size.height ,width: lbInfoHeader.frame.size.width, height: 1))
                viewLine1.backgroundColor = UIColor(netHex:0x018d11)
                viewLineHeader.addSubview(viewLine1)
                
                yHeader = viewLine1.frame.size.height + viewLine1.frame.origin.y
            }
            viewLineHeader.frame.size.height = yHeader
            scrollViewSoSanh.contentSize = CGSize(width:UIScreen.main.bounds.size.width - Common.Size(s: 10), height: yHeader)
            scrollViewSoSanh.frame.size.height = yHeader
            
            var xHeaderValue:CGFloat = scrollViewSoSanh.frame.size.width/3
            for item in SoSanhSSD {
                let viewLine1 = UIView(frame: CGRect(x:xHeaderValue, y: 0 ,width: 1, height: viewLineHeader.frame.size.height))
                viewLine1.backgroundColor = UIColor(netHex:0x018d11)
                var heightView = scrollViewSoSanh.frame.size.width/3
                scrollViewSoSanh.addSubview(viewLine1)
                if(SoSanhSSD.count == 1){
                    heightView = scrollViewSoSanh.frame.size.width * 2/3
                }
                let lineView = UIView(frame: CGRect(x: viewLine1.frame.size.width + viewLine1.frame.origin.x, y: 0, width: heightView, height: viewLineHeader.frame.size.height))
                lineView.backgroundColor = .white
                scrollViewSoSanh.addSubview(lineView)
                xHeaderValue = lineView.frame.origin.x + lineView.frame.size.width
                
                let lbInfo1 = UILabel(frame: CGRect(x: 0, y: 0, width: lineView.frame.size.width, height: Common.Size(s: 35)))
                lbInfo1.textAlignment = .center
                lbInfo1.textColor = UIColor.white
                lbInfo1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
                lbInfo1.text = item.Goicuoc
                lbInfo1.numberOfLines = 2
                lbInfo1.backgroundColor = UIColor(netHex:0x47b053)
                lineView.addSubview(lbInfo1)
                
                let viewLine2 = UIView(frame: CGRect(x:0, y: lbInfo1.frame.origin.y + lbInfo1.frame.size.height,width: lineView.frame.size.width, height: 1))
                viewLine2.backgroundColor = UIColor(netHex:0x018d11)
                lineView.addSubview(viewLine2)
                
                //--
                let lbInfo2 = UILabel(frame: CGRect(x: 0, y: viewLine2.frame.origin.y + viewLine2.frame.size.height, width: lineView.frame.size.width, height: lbInfo1.frame.size.height))
                lbInfo2.textAlignment = .center
                lbInfo2.textColor = UIColor.black
                lbInfo2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                lbInfo2.text = item.GiaMay
                lbInfo2.numberOfLines = 2
                lineView.addSubview(lbInfo2)
                
                let viewLine3 = UIView(frame: CGRect(x:0, y: lbInfo2.frame.origin.y + lbInfo2.frame.size.height,width: lineView.frame.size.width, height: 1))
                viewLine3.backgroundColor = UIColor(netHex:0x018d11)
                lineView.addSubview(viewLine3)
                //--
                let lbInfo3 = UILabel(frame: CGRect(x: 0, y: viewLine3.frame.origin.y + viewLine3.frame.size.height, width: lbInfo2.frame.size.width, height: lbInfo2.frame.size.height))
                lbInfo3.textAlignment = .center
                lbInfo3.textColor = UIColor.red
                lbInfo3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
                lbInfo3.text = item.Trogia
                lbInfo3.numberOfLines = 2
                lineView.addSubview(lbInfo3)
                
                let viewLine4 = UIView(frame: CGRect(x:0, y: lbInfo3.frame.origin.y + lbInfo3.frame.size.height ,width: lineView.frame.size.width, height: 1))
                viewLine4.backgroundColor = UIColor(netHex:0x018d11)
                lineView.addSubview(viewLine4)
                
                //--
                let lbInfo4 = UILabel(frame: CGRect(x: 0, y: viewLine4.frame.origin.y + viewLine4.frame.size.height, width: lineView.frame.size.width, height: lbInfo2.frame.size.height))
                lbInfo4.textAlignment = .center
                lbInfo4.textColor = UIColor.black
                lbInfo4.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
                lbInfo4.text = item.Tiencuocnam
                lbInfo4.numberOfLines = 2
                lineView.addSubview(lbInfo4)
                
                let viewLine5 = UIView(frame: CGRect(x:0, y: lbInfo4.frame.origin.y + lbInfo4.frame.size.height ,width: lineView.frame.size.width, height: 1))
                viewLine5.backgroundColor = UIColor(netHex:0x018d11)
                lineView.addSubview(viewLine5)
                //--
                let lbInfo5 = UILabel(frame: CGRect(x: 0, y: viewLine5.frame.origin.y + viewLine5.frame.size.height, width: lineView.frame.size.width , height: lbInfo2.frame.size.height))
                lbInfo5.textAlignment = .center
                lbInfo5.textColor = UIColor.red
                lbInfo5.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
                lbInfo5.text = item.TongChi
                lbInfo5.numberOfLines = 2
                lineView.addSubview(lbInfo5)
                
                let viewLine6 = UIView(frame: CGRect(x:0, y: lbInfo5.frame.origin.y + lbInfo5.frame.size.height ,width: lineView.frame.size.width, height: 1))
                viewLine6.backgroundColor = UIColor(netHex:0x018d11)
                lineView.addSubview(viewLine6)
                //--
                let lbInfo6 = UILabel(frame: CGRect(x: 0, y: viewLine6.frame.origin.y + viewLine6.frame.size.height, width: lineView.frame.size.width , height: lbInfo2.frame.size.height))
                lbInfo6.textAlignment = .center
                lbInfo6.textColor = UIColor.black
                lbInfo6.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
                lbInfo6.text = item.Datangay
                lbInfo6.numberOfLines = 2
                lineView.addSubview(lbInfo6)
                
                let viewLine7 = UIView(frame: CGRect(x:0, y: lbInfo6.frame.origin.y + lbInfo6.frame.size.height ,width: lineView.frame.size.width, height: 1))
                viewLine7.backgroundColor = UIColor(netHex:0x018d11)
                lineView.addSubview(viewLine7)
                //--
                let lbInfo7 = UILabel(frame: CGRect(x: 0, y: viewLine7.frame.origin.y + viewLine7.frame.size.height, width: lineView.frame.size.width , height: lbInfo2.frame.size.height))
                lbInfo7.textAlignment = .center
                lbInfo7.textColor = UIColor.red
                lbInfo7.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
                lbInfo7.text = item.Datathang
                lbInfo7.numberOfLines = 2
                lineView.addSubview(lbInfo7)
                
                let viewLine8 = UIView(frame: CGRect(x:0, y: lbInfo7.frame.origin.y + lbInfo7.frame.size.height ,width: lineView.frame.size.width, height: 1))
                viewLine8.backgroundColor = UIColor(netHex:0x018d11)
                lineView.addSubview(viewLine8)
                //--
                let lbInfo8 = UILabel(frame: CGRect(x: 0, y: viewLine8.frame.origin.y + viewLine8.frame.size.height, width: lineView.frame.size.width , height: lbInfo2.frame.size.height))
                lbInfo8.textAlignment = .center
                lbInfo8.textColor = UIColor.black
                lbInfo8.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                lbInfo8.text = item.Thoainoimang
                lbInfo8.numberOfLines = 2
                lineView.addSubview(lbInfo8)
                
                let viewLine9 = UIView(frame: CGRect(x:0, y: lbInfo8.frame.origin.y + lbInfo8.frame.size.height ,width: lineView.frame.size.width, height: 1))
                viewLine9.backgroundColor = UIColor(netHex:0x018d11)
                lineView.addSubview(viewLine9)
                //--
                let lbInfo9 = UILabel(frame: CGRect(x: 0, y: viewLine9.frame.origin.y + viewLine9.frame.size.height, width: scrollViewSoSanh.frame.size.width/3 , height: lbInfo2.frame.size.height))
                lbInfo9.textAlignment = .center
                lbInfo9.textColor = UIColor.black
                lbInfo9.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                lbInfo9.text = item.Thoaingoaimang
                lbInfo9.numberOfLines = 2
                lineView.addSubview(lbInfo9)
                
                let viewLine10 = UIView(frame: CGRect(x:0, y:  lbInfo9.frame.origin.y + lbInfo9.frame.size.height ,width: lineView.frame.size.width, height: 1))
                viewLine10.backgroundColor = UIColor(netHex:0x018d11)
                lineView.addSubview(viewLine10)
                //--
                let lbInfo10 = UILabel(frame: CGRect(x: 0, y: viewLine10.frame.origin.y + viewLine10.frame.size.height, width: lineView.frame.size.width , height: lbInfo2.frame.size.height))
                lbInfo10.textAlignment = .center
                lbInfo10.textColor = UIColor.black
                lbInfo10.font = UIFont.systemFont(ofSize: Common.Size(s:12))
                lbInfo10.text = item.SMS
                lbInfo10.numberOfLines = 2
                lineView.addSubview(lbInfo10)
                
            }
            scrollViewSoSanh.contentSize = CGSize(width:xHeaderValue, height: yHeader)
        }else{
            scrollViewSoSanh.clipsToBounds = true
            scrollViewSoSanh.frame.size.height = 0
        }
        
        ///
        var indexYDes = scrollViewSoSanh.frame.size.height + scrollViewSoSanh.frame.origin.y + Common.Size(s:10)
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailProductSubsidyViewController.tapShowDetail))
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
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewInfoBasic.frame.origin.y + viewInfoBasic.frame.size.height + Common.Size(s:20))
        
    }
    
    @objc func functionViewSSD(sender:UITapGestureRecognizer) {
        let viewController = DetailPackageSubidyViewController()
        viewController.ssd = ssd
        viewController.money = money
        viewController.itemCodeSubSidy = productSubSidy
        viewController.sumMoney = sumMoney
        viewController.product = product
        self.navigationController?.pushViewController(viewController, animated: true)
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
    @objc func actionHome(){
        _ = self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = false
        self.title = "Chi tiết sản phẩm"
    }
    
    @objc func cartAction(_ sender:UITapGestureRecognizer){
        navigationController?.navigationBar.isTranslucent = true
        if (self.product.product.qlSerial == "Y"){
            var arrColor:[String] = []
            for item in self.product.variant {
                arrColor.append(item.colorName)
            }
            if (arrColor.count == 1){
                //                let sku = self.product.variant[0].sku
                //                let colorProduct = self.product.variant[0].colorValue
                //                let priceBeforeTax = self.product.variant[0].priceBeforeTax
                //                let price = self.product.variant[0].price
                //                let product = self.product.product.copy() as! Product
                //
                //                product.sku = sku
                //                product.price = price
                //                product.priceBeforeTax = priceBeforeTax
                
                //                let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "")
                //                Cache.carts.append(cart)
                //                Cache.itemsPromotion.removeAll()
                //
                //                let newViewController = CartViewController()
                //                self.navigationController?.pushViewController(newViewController, animated: true)
                loadSim(value:0)
                
            }else{
                ActionSheetStringPicker.show(withTitle: "Chọn màu sản phẩm", rows: arrColor, initialSelection: 0, doneBlock: {
                    picker, value, index in
                    self.loadSim(value:value)
                    
                    return
                }, cancel: { ActionStringCancelBlock in
                    return
                }, origin: self.view)
                
            }
            
        }else{
            // da chuuyen san phu kien
        }
        
    }
    func loadSim(value:Int){
        let sku = self.product.variant[value].sku
        let colorProduct = self.product.variant[value].colorValue
        let priceBeforeTax = self.product.variant[value].priceBeforeTax
        let price = self.product.variant[value].price
        let product = self.product.product.copy() as! Product
        
        product.sku = sku
        product.price = price
        product.priceBeforeTax = priceBeforeTax
        
        MPOSAPIManager.sp_mpos_SSD_MSP_SIM_10_11_for_MPOS(MSPGoiCuoc: "\(self.ssd.MaSP)", MSPMay: sku, handler: { (results, error) in
            if(error.count <= 0){
                if(results.count > 0){
                    let alert = UIAlertController(title: "Chú ý", message: "Bạn vui lòng chọn đầu số", preferredStyle: UIAlertController.Style.alert)
                    
                    for item in results {
                        alert.addAction(UIAlertAction(title: "\(item.ItemName)", style: UIAlertAction.Style.default, handler:{ action in
                            print("AAA \(item.ItemCode)")
                            
                            ProductAPIManager.product_detais_by_sku(sku: "\(self.ssd.MaSP)", handler: { (pruductRS, err) in
                                if(err.count <= 0){
                                    if(pruductRS.count > 0){
                                        ProductAPIManager.product_detais_by_sku(sku: "\(item.ItemCode)", handler: { (pruductSim, errSim) in
                                            if(errSim.count <= 0){
                                                if(pruductSim.count > 0){
                                                    let skuSim = pruductSim[0].variant[0].sku
                                                    let colorProductSim = pruductSim[0].variant[0].colorValue
                                                    let priceBeforeTaxSim = pruductSim[0].variant[0].priceBeforeTax
                                                    let priceSim = pruductSim[0].variant[0].price
                                                    let productSim = pruductSim[0].product.copy() as! Product
                                                    
                                                    let cart2 = Cart(sku: skuSim, product: productSim,quantity: 1,color:colorProductSim,inStock:-1, imei: "N/A",price: priceSim, priceBT: priceBeforeTaxSim, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                                    Cache.carts.append(cart2)
                                                    
                                                    let skuItem = pruductRS[0].variant[0].sku
                                                    let colorProductItem = pruductRS[0].variant[0].colorValue
                                                    let priceBeforeTaxItem = pruductRS[0].variant[0].priceBeforeTax
                                                    let priceItem = pruductRS[0].variant[0].price
                                                    let productItem = pruductRS[0].product.copy() as! Product
                                                    
                                                    let cart = Cart(sku: skuItem, product: productItem,quantity: 1,color:colorProductItem,inStock:-1, imei: "N/A",price: priceItem, priceBT: priceBeforeTaxItem, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                                    Cache.carts.append(cart)
                                                    
                                                    let cart1 = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                                    Cache.carts.append(cart1)
                                                    Cache.itemsPromotion.removeAll()
                                                    let newViewController = CartViewController()
                                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                                }
                                            }
                                        })
                                    }else{
                                        Toast(text: "Không tìm thấy mã sản phẩm \(self.ssd.MaSP)").show()
                                    }
                                }else{
                                    Toast(text: err).show()
                                }
                            })
                        })
                        )
                    }
                    //                                alert.addAction(UIAlertAction(title: "Huỷ", style: UIAlertActionStyle.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    ProductAPIManager.product_detais_by_sku(sku: "\(self.ssd.MaSP)", handler: { (pruductRS, err) in
                        if(err.count <= 0){
                            if(pruductRS.count > 0){
                                let skuItem = pruductRS[0].variant[0].sku
                                let colorProductItem = pruductRS[0].variant[0].colorValue
                                let priceBeforeTaxItem = pruductRS[0].variant[0].priceBeforeTax
                                let priceItem = pruductRS[0].variant[0].price
                                let productItem = pruductRS[0].product.copy() as! Product
                                
                                let cart = Cart(sku: skuItem, product: productItem,quantity: 1,color:colorProductItem,inStock:-1, imei: "N/A",price: priceItem, priceBT: priceBeforeTaxItem, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                Cache.carts.append(cart)
                                
                                let cart1 = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                                Cache.carts.append(cart1)
                                Cache.itemsPromotion.removeAll()
                                let newViewController = CartViewController()
                                self.navigationController?.pushViewController(newViewController, animated: true)
                            }else{
                                Toast(text: "Không tìm thấy mã sản phẩm \(self.ssd.MaSP)").show()
                            }
                        }else{
                            Toast(text: err).show()
                        }
                    })
                }
            }else{
                Toast(text: error).show()
            }
        })
    }
}
