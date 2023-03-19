//
//  TabTopupCardViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/20/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class TabTopupCardViewController: UIViewController,UITextFieldDelegate{
    var parentNavigationController : UINavigationController?
    var scrollView:UIScrollView!
    var lbTotalValue: UILabel!
    var phoneView:UIView!
    var tfPhoneNumber:UITextField!
    var bottomTelecomView:UIView!
    var priceView:UIView!
    var listPrice:[ItemPrice] = []
    var collectionViewPrice: UICollectionView!
    var is_Mobifone_Msale = false
    var mobifone_phone = ""
    var mobifoneMsale_Package: MobifoneMsalePackage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        self.title = "Topup"
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - Common.Size(s: 40) - Common.Size(s: 80) - ((parentNavigationController?.navigationBar.frame.size.height ?? 0) + UIApplication.shared.statusBarFrame.height)))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let footer = UIView()
        footer.frame = CGRect(x: 0, y:self.view.frame.size.height - Common.Size(s: 40) - Common.Size(s: 80) - ((parentNavigationController?.navigationBar.frame.size.height ?? 0) + UIApplication.shared.statusBarFrame.height) , width: self.view.frame.size.width, height: Common.Size(s: 80))
        footer.backgroundColor = UIColor.white
        footer.layer.shadowColor = UIColor.gray.cgColor
        footer.layer.shadowOffset =  CGSize(width: 0, height: -1)
        footer.layer.shadowOpacity = 0.5
        self.view.addSubview(footer)
        
        let lbTotal = UILabel(frame: CGRect(x: Common.Size(s: 20), y: 0, width: footer.frame.size.width - Common.Size(s: 40), height: footer.frame.size.height/2 - Common.Size(s: 5)))
        lbTotal.textAlignment = .left
        lbTotal.textColor = UIColor.black
        lbTotal.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTotal.text = "Tổng tiền"
        footer.addSubview(lbTotal)
        
        lbTotalValue = UILabel(frame: lbTotal.frame)
        lbTotalValue.textAlignment = .right
        lbTotalValue.textColor = UIColor(netHex:0xD0021B)
        lbTotalValue.font = UIFont.boldSystemFont(ofSize: 20)
        footer.addSubview(lbTotalValue)
        lbTotalValue.text = "0đ"
        
        let btNext = UIButton(frame: CGRect(x: lbTotal.frame.origin.x, y: footer.frame.size.height - footer.frame.size.height/2 - Common.Size(s: 5), width: lbTotal.frame.size.width, height: footer.frame.size.height/2 - Common.Size(s: 5)))
        btNext.layer.cornerRadius = 5
        btNext.setTitle("TIẾP TỤC",for: .normal)
        btNext.titleLabel?.font = UIFont.systemFont(ofSize: Common.Size(s: 16))
        btNext.backgroundColor = UIColor.init(netHex:0x00955E)
        footer.addSubview(btNext)
        btNext.addTarget(self, action:#selector(self.payAction), for: .touchUpInside)
        
        phoneView = UIView()
        phoneView.frame = CGRect(x: 0, y: Common.Size(s: 10), width: scrollView.frame.size.width, height: Common.Size(s: 50))
        phoneView.backgroundColor = UIColor.white
        scrollView.addSubview(phoneView)
        
        let lbPhone = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: phoneView.frame.size.width/3 - Common.Size(s: 15), height: phoneView.frame.size.height))
        lbPhone.textAlignment = .left
        lbPhone.textColor = UIColor.black
        lbPhone.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbPhone.text = "Số điện thoại"
        phoneView.addSubview(lbPhone)
        
        tfPhoneNumber = UITextField(frame: CGRect(x: lbPhone.frame.origin.x + lbPhone.frame.size.width, y: Common.Size(s:10), width: phoneView.frame.size.width * 2/3 - Common.Size(s: 15) , height: Common.Size(s:30)))
        tfPhoneNumber.placeholder = ""
        tfPhoneNumber.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfPhoneNumber.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhoneNumber.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneNumber.keyboardType = UIKeyboardType.numberPad
        tfPhoneNumber.returnKeyType = UIReturnKeyType.done
        tfPhoneNumber.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhoneNumber.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneNumber.delegate = self
        phoneView.addSubview(tfPhoneNumber)
           tfPhoneNumber.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        bottomTelecomView = UIView()
        bottomTelecomView.frame = CGRect(x: 0, y: phoneView.frame.origin.y + phoneView.frame.size.height, width: scrollView.frame.size.width, height: 0)
        bottomTelecomView.backgroundColor = UIColor.clear
        scrollView.addSubview(bottomTelecomView)
        
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "CHỌN MỆNH GIÁ"
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        bottomTelecomView.addSubview(label2)
        
        priceView = UIView()
        priceView.frame = CGRect(x: 0, y:label2.frame.origin.y + label2.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        priceView.backgroundColor = UIColor.white
        bottomTelecomView.addSubview(priceView)
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout2.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
        layout2.itemSize = CGSize(width: 111, height: 10)
        layout2.minimumInteritemSpacing = 0
        layout2.minimumLineSpacing = 0
        collectionViewPrice = UICollectionView(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: self.priceView.frame.width - Common.Size(s: 10), height: self.priceView.frame.height), collectionViewLayout: layout2)
        collectionViewPrice.delegate = self
        collectionViewPrice.dataSource = self
        collectionViewPrice.backgroundColor = .white
        collectionViewPrice.register(ItemPriceCollectionViewCell.self, forCellWithReuseIdentifier: "ItemPriceCollectionViewCell")
        priceView.addSubview(collectionViewPrice)
        collectionViewPrice.isScrollEnabled = false
        
        bottomTelecomView.frame.size.height = 0
        bottomTelecomView.clipsToBounds = true
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: bottomTelecomView.frame.size.height + bottomTelecomView.frame.origin.y + Common.Size(s: 10))
        
        if is_Mobifone_Msale {
            tfPhoneNumber.text = self.mobifone_phone
            tfPhoneNumber.isEnabled = false
            collectionViewPrice.allowsSelection = false
            if !(self.mobifone_phone.isEmpty) {
                self.getListTopup_MobifoneMsale()
            } else {
                let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại không hợp lệ!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
            }
            
        } else {
            debugPrint("aaabb")
        }
    }
    
    func getListTopup_MobifoneMsale() {
        self.listPrice.removeAll()
        CRMAPIManager.Mobifone_GetlistTopup(phoneNumber: self.mobifone_phone) { (results, err) in
            if err.count <= 0 {
                var count:Int = 0
                for item in results {
                    var isSelect:Bool = false
                    if (Double(item.PriceCard) == (self.mobifoneMsale_Package?.price_topup ?? 0)) {
                        isSelect = true
                    }
                    self.listPrice.append(ItemPrice(ID: "", PriceCard: item.PriceCard, TelecomName: item.TelecomName, TypeNCC: item.TypeNCC, TelecomCode: item.Telecomcode, Price: item.Price, isSelect: isSelect))
                    count = count + 1
                }
                
                self.collectionViewPrice.reloadData()
                var sizeHeightTelecom:CGFloat = 0
                let size = self.listPrice.count/3
                if(self.listPrice.count % 3 == 0){
                    sizeHeightTelecom = CGFloat(size) * ((self.view.frame.size.width - Common.Size(s: 10))/3) * 0.5
                }else{
                    sizeHeightTelecom = CGFloat(size + 1) * ((self.view.frame.size.width - Common.Size(s: 10))/3) * 0.5
                }
                self.priceView.frame.size.height = sizeHeightTelecom + Common.Size(s: 10)
                
                self.collectionViewPrice.frame.size.height = sizeHeightTelecom
                self.bottomTelecomView.frame.size.height = self.priceView.frame.size.height + self.priceView.frame.origin.y
                
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.bottomTelecomView.frame.size.height + self.bottomTelecomView.frame.origin.y + Common.Size(s: 10))
                self.updatePrice()
                
            } else {
                let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let phone = textField.text!
        if(!phone.isEmpty){
            if (phone.hasPrefix("01") && phone.count == 11){
                
            }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
                
            }else{
                let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại không hợp lệ!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
            MPOSAPIManager.GetTopUpList(phoneNumber: "\(phone)", shopCode: "\(Cache.user!.ShopCode)", userCode: "\(Cache.user!.UserName)") { (results, err) in
                self.listPrice.removeAll()
                
                var count:Int = 0
                for item in results {
                    var isSelect:Bool = false
                    if(count == 0){
                        isSelect = true
                    }
                    self.listPrice.append(ItemPrice(ID: "", PriceCard: item.PriceCard, TelecomName: item.TelecomName, TypeNCC: item.TypeNCC, TelecomCode: item.Telecomcode, Price: item.Price, isSelect: isSelect))
                    count = count + 1
                }
                
                self.collectionViewPrice.reloadData()
                var sizeHeightTelecom:CGFloat = 0
                let size = self.listPrice.count/3
                if(self.listPrice.count % 3 == 0){
                    sizeHeightTelecom = CGFloat(size) * ((self.view.frame.size.width - Common.Size(s: 10))/3) * 0.5
                }else{
                    sizeHeightTelecom = CGFloat(size + 1) * ((self.view.frame.size.width - Common.Size(s: 10))/3) * 0.5
                }
                self.priceView.frame.size.height = sizeHeightTelecom + Common.Size(s: 10)
                
                self.collectionViewPrice.frame.size.height = sizeHeightTelecom
                self.bottomTelecomView.frame.size.height = self.priceView.frame.size.height + self.priceView.frame.origin.y
                
                self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.bottomTelecomView.frame.size.height + self.bottomTelecomView.frame.origin.y + Common.Size(s: 10))
                self.updatePrice()
            }
        }
    }
    func updatePrice(){
        var itemPrice:ItemPrice? = nil
        for item in listPrice {
            if(item.isSelect){
                itemPrice = item
                break
            }
        }
        if(itemPrice != nil){
            self.lbTotalValue.text = "\(Common.convertCurrency(value: itemPrice!.Price))"
        }
    }
    @objc func payAction(_ sender:UITapGestureRecognizer){
        let phone = tfPhoneNumber.text!
        if(!phone.isEmpty){
            if (phone.hasPrefix("01") && phone.count == 11){
                
            }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
                
            }else{
                let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại không hợp lệ!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
        }
        var itemPrice:ItemPrice? = nil
        for item in listPrice {
            if(item.isSelect){
                itemPrice = item
                break
            }
        }
        if(itemPrice != nil){
            let vc = DetailCardViewController()
            vc.type = 1
            vc.itemPrice = itemPrice
            vc.parentNavigationController = parentNavigationController
            vc.phone = phone
            vc.isTopUp = true
            parentNavigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension TabTopupCardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPrice.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<listPrice.count{
            listPrice[i].isSelect = false
        }
        listPrice[indexPath.item].isSelect = true
        self.collectionViewPrice.reloadData()
        updatePrice()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let coCell: ItemPriceCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemPriceCollectionViewCell", for: indexPath) as! ItemPriceCollectionViewCell
            let item = listPrice[indexPath.item]
            coCell.setUpCollectionViewCell(item: item)
            return coCell
     
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{

            let size = CGSize(width: (self.view.frame.size.width - Common.Size(s: 10))/3, height: ((self.view.frame.size.width - Common.Size(s: 10))/3) * 0.5)
            return size
     
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
            return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

            return 0
 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  
    }
}
