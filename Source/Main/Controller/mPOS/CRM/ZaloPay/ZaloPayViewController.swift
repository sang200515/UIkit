//
//  ZaloPayViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 28/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class ZaloPayViewController: UIViewController {
    
    var productSOM: ProductSOM?
    var providerSOM: ProviderSOM?
    
    let bodyInfo: String = "Để thuận tiện và tránh đi lại nhiều trong mùa dịch, anh/chị hướng dẫn khách hàng nạp tiền Zalo Pay có giá trị từ 300K trở lên nhé, quy định này được áp dụng từ ngày 13/04 đến khi có thông báo mới"
    let bodyTips: String = "Hiện tại FPTShop đã có bán VÉ MÁY BAY, Anh/chị nắm thông tin để tư vấn cho khách hàng nhé"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "NẠP TIỀN ZALO PAY"
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(self.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        let lbTextInfoZaloPay = UILabel()
        lbTextInfoZaloPay.text = "Thông báo dịch vụ nạp tiền Zalo Pay"
        lbTextInfoZaloPay.textColor = .red
        lbTextInfoZaloPay.backgroundColor = .clear
        lbTextInfoZaloPay.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        self.view.addSubview(lbTextInfoZaloPay)
        lbTextInfoZaloPay.translatesAutoresizingMaskIntoConstraints = false
        lbTextInfoZaloPay.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: Common.Size(s: 20)).isActive = true
        lbTextInfoZaloPay.topAnchor.constraint(equalTo: self.view.topAnchor,constant: Common.Size(s: 20)).isActive = true
        lbTextInfoZaloPay.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: Common.Size(s: -20)).isActive = true
        
        let lbTextInfoZaloPayBody = UILabel()
        lbTextInfoZaloPayBody.textColor = .black
        lbTextInfoZaloPayBody.backgroundColor = .clear
        lbTextInfoZaloPayBody.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        self.view.addSubview(lbTextInfoZaloPayBody)
        lbTextInfoZaloPayBody.translatesAutoresizingMaskIntoConstraints = false
        lbTextInfoZaloPayBody.leftAnchor.constraint(equalTo: lbTextInfoZaloPay.leftAnchor).isActive = true
        lbTextInfoZaloPayBody.topAnchor.constraint(equalTo: lbTextInfoZaloPay.bottomAnchor,constant: Common.Size(s: 15)).isActive = true
        lbTextInfoZaloPayBody.rightAnchor.constraint(equalTo: lbTextInfoZaloPay.rightAnchor).isActive = true
        
        let myMutableString = NSMutableAttributedString(string: bodyInfo, attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: Common.Size(s: 12))])
         myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:113,length:4))
        myMutableString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: Common.Size(s: 12)), range: NSRange(location:113,length:4))
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:165,length:5))
        myMutableString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: Common.Size(s: 12)), range: NSRange(location:165,length:5))
        lbTextInfoZaloPayBody.attributedText = myMutableString
        lbTextInfoZaloPayBody.numberOfLines = 10
        
        let lbTextInfoTips = UILabel()
        lbTextInfoTips.textColor = .black
        lbTextInfoTips.backgroundColor = .clear
        lbTextInfoTips.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        self.view.addSubview(lbTextInfoTips)
        lbTextInfoTips.translatesAutoresizingMaskIntoConstraints = false
        lbTextInfoTips.leftAnchor.constraint(equalTo: lbTextInfoZaloPayBody.leftAnchor).isActive = true
        lbTextInfoTips.topAnchor.constraint(equalTo: lbTextInfoZaloPayBody.bottomAnchor,constant: Common.Size(s: 15)).isActive = true
        lbTextInfoTips.rightAnchor.constraint(equalTo: lbTextInfoZaloPayBody.rightAnchor).isActive = true
        lbTextInfoTips.numberOfLines = 5
        let myTips = NSMutableAttributedString(string: bodyTips, attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: Common.Size(s: 12))])
        myTips.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:27,length:10))
        myTips.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: Common.Size(s: 12)), range: NSRange(location:27,length:10))
        lbTextInfoTips.attributedText = myTips
      
        
        
        let viewPayMoney = UIView()
        viewPayMoney.backgroundColor = .white
        viewPayMoney.layer.borderWidth = 1
        viewPayMoney.layer.borderColor = UIColor(netHex:0x00955E).cgColor
        viewPayMoney.layer.cornerRadius = 10
        viewPayMoney.clipsToBounds = true
        self.view.addSubview(viewPayMoney)
        viewPayMoney.translatesAutoresizingMaskIntoConstraints = false
        
        viewPayMoney.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        viewPayMoney.topAnchor.constraint(equalTo: lbTextInfoTips.bottomAnchor,constant: Common.Size(s: 30)).isActive = true
        viewPayMoney.widthAnchor.constraint(equalToConstant: Common.Size(s: 100)).isActive = true
        viewPayMoney.heightAnchor.constraint(equalToConstant: Common.Size(s: 100)).isActive = true
        let tapViewPayMoney = UITapGestureRecognizer(target: self, action: #selector(self.tapViewPayMoney))
        viewPayMoney.addGestureRecognizer(tapViewPayMoney)
        viewPayMoney.isUserInteractionEnabled = true
        
        let icPay = UIImageView()
        icPay.image = #imageLiteral(resourceName: "zalo_pay_pay")
        icPay.contentMode = .scaleAspectFit
        icPay.tintColor = UIColor(netHex:0x00955E)
        viewPayMoney.addSubview(icPay)
        icPay.translatesAutoresizingMaskIntoConstraints = false
        icPay.widthAnchor.constraint(equalTo: viewPayMoney.widthAnchor, multiplier: 1/2.5).isActive = true
        icPay.centerXAnchor.constraint(equalTo: viewPayMoney.centerXAnchor).isActive = true
        icPay.heightAnchor.constraint(equalTo: viewPayMoney.heightAnchor, multiplier: 2/3).isActive = true
        
        let lbPayMoney = UILabel()
        lbPayMoney.text = "Nạp tiền"
        lbPayMoney.textAlignment = .center
        lbPayMoney.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 11))
        lbPayMoney.textColor = UIColor(netHex:0x00955E)
        viewPayMoney.addSubview(lbPayMoney)
        lbPayMoney.translatesAutoresizingMaskIntoConstraints = false
        lbPayMoney.topAnchor.constraint(equalTo: icPay.bottomAnchor).isActive = true
        lbPayMoney.leftAnchor.constraint(equalTo: viewPayMoney.leftAnchor).isActive = true
        lbPayMoney.rightAnchor.constraint(equalTo: viewPayMoney.rightAnchor).isActive = true
        
        
 
        let viewHistory = UIView()
        viewHistory.backgroundColor = .white
        viewHistory.layer.borderWidth = 1
        viewHistory.layer.borderColor = UIColor(netHex:0x00955E).cgColor
        viewHistory.layer.cornerRadius = 10
        viewHistory.clipsToBounds = true
        self.view.addSubview(viewHistory)
        
        viewHistory.translatesAutoresizingMaskIntoConstraints = false
        viewHistory.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        viewHistory.topAnchor.constraint(equalTo: viewPayMoney.bottomAnchor,constant: Common.Size(s: 15)).isActive = true
        viewHistory.widthAnchor.constraint(equalToConstant: Common.Size(s: 100)).isActive = true
        viewHistory.heightAnchor.constraint(equalToConstant: Common.Size(s: 100)).isActive = true

        let tapViewHistory = UITapGestureRecognizer(target: self, action: #selector(self.tapViewHistory))
        viewHistory.addGestureRecognizer(tapViewHistory)
        viewHistory.isUserInteractionEnabled = true
        
        let icHistory = UIImageView()
        icHistory.image = #imageLiteral(resourceName: "zalo_pay_history")
        icHistory.contentMode = .scaleAspectFit
        icHistory.tintColor = UIColor(netHex:0x00955E)
        viewHistory.addSubview(icHistory)
        icHistory.translatesAutoresizingMaskIntoConstraints = false
        icHistory.widthAnchor.constraint(equalTo: viewHistory.widthAnchor, multiplier: 1/2.5).isActive = true
        icHistory.centerXAnchor.constraint(equalTo: viewHistory.centerXAnchor).isActive = true
        icHistory.heightAnchor.constraint(equalTo: viewHistory.heightAnchor, multiplier: 2/3).isActive = true
        
        let lbHistory = UILabel()
        lbHistory.text = "Lịch sử giao dịch"
        lbHistory.textAlignment = .center
        lbHistory.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 11))
        lbHistory.textColor = UIColor(netHex:0x00955E)
        viewHistory.addSubview(lbHistory)
        lbHistory.translatesAutoresizingMaskIntoConstraints = false
        lbHistory.topAnchor.constraint(equalTo: icHistory.bottomAnchor).isActive = true
        lbHistory.leftAnchor.constraint(equalTo: viewHistory.leftAnchor).isActive = true
        lbHistory.rightAnchor.constraint(equalTo: viewHistory.rightAnchor).isActive = true
        
        loadCategory()
    }
    func loadCategory(){
        let newViewController = LoadingViewController();
        newViewController.content = "Đang lấy thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        ZaloPayServiceImpl.getCategories(params: RequestCategoryZaloPay(Ids: "6421ee90-8d9b-4fb0-a17c-1645b7682ba5", warehouseCode: "\(Cache.user!.ShopCode)", _includeDetails: "true", _sort: "orderno")) { categories in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if let categories = categories {
                    if(categories.items.count > 0){
                        let products = categories.items[0].products
                        if(products.count > 0){
                            let product = products[0]
                            self.productSOM = product
                            ZaloPayServiceImpl.getInfoProvider(id: product.defaultProviderId) { provider in
                                if let provider = provider {
                                    self.providerSOM = provider
                                }
                            }
                            
                        }else{
                            self.showPopUp("Dịch vụ đang bảo trì,tạm thời shop chưa sử dụng được!", "Thông báo", buttonTitle: "Trở về") {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }else{
                        self.showPopUp("Dịch vụ đang bảo trì,tạm thời shop chưa sử dụng được!", "Thông báo", buttonTitle: "Trở về") {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }else{
                    self.showPopUp("Dịch vụ đang bảo trì,tạm thời shop chưa sử dụng được!", "Thông báo", buttonTitle: "Trở về") {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
//    func loadData(){
        //6ad10071-1ca5-43fd-a80c-d4f2307e1b3c hardcode ZaloPay
//        ZaloPayServiceImpl.getInfoProduct(id: "6ad10071-1ca5-43fd-a80c-d4f2307e1b3c") { product in
//            if let product = product {
//                self.productSOM = product
//                ZaloPayServiceImpl.getInfoProvider(id: product.defaultProviderId) { provider in
//                    if let provider = provider {
//                        self.providerSOM = provider
//                    }
//                }
//            }
//        }
//    }
    @objc func tapViewPayMoney()
    {
        if(self.productSOM != nil && self.providerSOM != nil){
            let newViewController = CreateZaloPayViewController()
            newViewController.productSOM = self.productSOM
            newViewController.providerSOM = self.providerSOM
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    @objc func tapViewHistory()
    {
        let newViewController = HistoryZaloPayViewController()
        newViewController.productSOM = self.productSOM
        newViewController.providerSOM = self.providerSOM
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
