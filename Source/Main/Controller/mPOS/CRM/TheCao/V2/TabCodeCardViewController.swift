//
//  TabCodeCardViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/20/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class TabCodeCardViewController: UIViewController,UITextFieldDelegate{
    var parentNavigationController : UINavigationController?
    var lbTotalValue: UILabel!
    var scrollView:UIScrollView!
    var telecomView:UIView!
    var priceView:UIView!
    var quantilyView:UIView!
    var phoneView:UIView!
    var tfPhoneNumber:UITextField!
    
    var control: UIView!
    var iconMinus:UIImageView!
    var iconPlus:UIImageView!
    var quantity: UILabel!
    var viewNumber: UIView!
    
    var collectionView: UICollectionView!
    var collectionViewPrice: UICollectionView!
    var telecom: [String:[GetPayCodeListResult]] = [:]
    
    var bottomTelecomView:UIView!
    var bottomPriceView:UIView!
    
    var listTelecom:[ItemTelecom] = []
    var listPrice:[ItemPrice] = []
    var quantityValue:Int = 1
    var isFullTelecom:Bool = false
    var listTelecomFull:[ItemTelecom] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.initNavigationBar()
        self.title = "Mã thẻ"
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        quantityValue = 1
        isFullTelecom = false
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - Common.Size(s: 40) - Common.Size(s: 80) - ((parentNavigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let footer = UIView()
        footer.frame = CGRect(x: 0, y:self.view.frame.size.height - Common.Size(s: 40) - Common.Size(s: 80) - ((parentNavigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) , width: self.view.frame.size.width, height: Common.Size(s: 80))
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
        
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "CHỌN NHÀ MẠNG"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        telecomView = UIView()
        telecomView.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        telecomView.backgroundColor = UIColor.white
        scrollView.addSubview(telecomView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
        layout.itemSize = CGSize(width: 111, height: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.telecomView.frame.width, height: self.telecomView.frame.height), collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(ItemTelecomCollectionViewCell.self, forCellWithReuseIdentifier: "ItemTelecomCollectionViewCell")
        telecomView.addSubview(collectionView)
        collectionView.isScrollEnabled = false
        
        bottomTelecomView = UIView()
        
        bottomTelecomView.frame = CGRect(x: 0, y:telecomView.frame.origin.y + telecomView.frame.size.height, width: scrollView.frame.size.width, height: 0)
        bottomTelecomView.backgroundColor = UIColor.clear
        bottomTelecomView.clipsToBounds = true
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
        
        bottomPriceView = UIView()
        bottomPriceView.frame = CGRect(x: 0, y: priceView.frame.origin.y + priceView.frame.size.height, width: scrollView.frame.size.width, height: 0)
        bottomPriceView.backgroundColor = UIColor.clear
        bottomTelecomView.addSubview(bottomPriceView)
        
        quantilyView = UIView()
        quantilyView.frame = CGRect(x: 0, y: Common.Size(s: 10), width: scrollView.frame.size.width, height: Common.Size(s: 40))
        quantilyView.backgroundColor = UIColor.white
        bottomPriceView.addSubview(quantilyView)
        
        let lbQuantily = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: quantilyView.frame.size.width/3 - Common.Size(s: 15), height: quantilyView.frame.size.height))
        lbQuantily.textAlignment = .left
        lbQuantily.textColor = UIColor.black
        lbQuantily.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbQuantily.text = "Số lượng"
        quantilyView.addSubview(lbQuantily)
        
        control = UIView()
        quantilyView.addSubview(control)
        viewNumber = UIView()
        control.addSubview(viewNumber)
        
        iconMinus = UIImageView()
        iconMinus.contentMode = UIView.ContentMode.scaleAspectFit
        iconMinus.image = #imageLiteral(resourceName: "DeleteQuantity")
        
        control.addSubview(iconMinus)
        iconPlus = UIImageView()
        iconPlus.contentMode = UIView.ContentMode.scaleAspectFit
        iconPlus.image = #imageLiteral(resourceName: "AddQuantity")
        control.addSubview(iconPlus)
        
        let tapMinus = UITapGestureRecognizer(target: self, action: #selector(minusTapped(tapGestureRecognizer:)))
        iconMinus.isUserInteractionEnabled = true
        iconMinus.addGestureRecognizer(tapMinus)
        
        let tapPlus = UITapGestureRecognizer(target: self, action: #selector(plusTapped(tapGestureRecognizer:)))
        iconPlus.isUserInteractionEnabled = true
        iconPlus.addGestureRecognizer(tapPlus)
        
        
        quantity = UILabel()
        quantity.textColor = UIColor.gray
        quantity.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        quantity.textAlignment = .center
        control.addSubview(quantity)
        
        control.frame = CGRect(x: quantilyView.frame.size.width - Common.Size(s: 100) - Common.Size(s: 15), y: Common.Size(s:7.5), width: Common.Size(s: 100), height: Common.Size(s:25))
        
        iconMinus.frame =  CGRect(x: 0, y: 0, width: control.frame.size.height, height: control.frame.size.height)
        
        quantity.frame = CGRect(x: iconMinus.frame.origin.x + iconMinus.frame.size.width, y: 0, width: Common.Size(s:40), height: control.frame.size.height)
        
        quantity.text = "\(quantityValue)"
        
        iconPlus.frame =  CGRect(x: quantity.frame.origin.x + quantity.frame.size.width, y: iconMinus.frame.origin.y, width: iconMinus.frame.size.width, height: iconMinus.frame.size.height)
        
        phoneView = UIView()
        phoneView.frame = CGRect(x: 0, y:quantilyView.frame.origin.y + quantilyView.frame.size.height + Common.Size(s: 10), width: scrollView.frame.size.width, height: Common.Size(s: 50))
        phoneView.backgroundColor = UIColor.white
        bottomPriceView.addSubview(phoneView)
        
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
        
        bottomPriceView.frame.size.height = phoneView.frame.origin.y + phoneView.frame.size.height
        
//        bottomTelecomView.frame.size.height = bottomPriceView.frame.origin.y + bottomPriceView.frame.size.height
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: bottomTelecomView.frame.size.height + bottomTelecomView.frame.origin.y + Common.Size(s: 20))
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.parentNavigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.GetPayCodeList(shopCode: "\(Cache.user!.ShopCode)", userCode: "\(Cache.user!.UserName)"){ (results,err) in
            
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if results.count > 0
                {
                    for item in results {
                        if var val:[GetPayCodeListResult] = self.telecom[item.TelecomName] {
                            val.append(item)
                            self.telecom.updateValue(val, forKey: item.TelecomName)
                        } else {
                            var arr: [GetPayCodeListResult] = []
                            arr.append(item)
                            self.telecom.updateValue(arr, forKey: item.TelecomName)
                        }
                    }
                    self.initUI()
                }
            }
            
        }
    }
    func initUI(){
        listTelecomFull.removeAll()
        listTelecom.removeAll()
        quantityValue = 1
        for key in telecom.keys {
            if let item:[GetPayCodeListResult] = telecom[key] {
                if(item.count > 0){
                    let it = item[0]
                    let obj = ItemTelecom(id: it.ID, name: "\(it.TelecomName)", isSelect: false)
                    listTelecomFull.append(obj)
                }
            }
        }
        let itemMore = ItemTelecom(id: -1, name: "", isSelect: false)
        listTelecomFull =  listTelecomFull.sorted(by: { $0.id > $1.id })
        listTelecomFull.append(itemMore)
        
        var sizeHeightTelecom:CGFloat = 0
        if(!isFullTelecom){
            var count:Int = 0
            for item in listTelecomFull{
                if(count < 4){
                    listTelecom.append(item)
                }
                count = count + 1
            }
            listTelecom.append(itemMore)
            let size = listTelecom.count/5
            if(listTelecom.count % 5 == 0){
                sizeHeightTelecom = CGFloat(size) * (UIScreen.main.bounds.size.width/5)
            }else{
                sizeHeightTelecom = CGFloat(size + 1) * (UIScreen.main.bounds.size.width/5)
            }
        }else{
            let size = listTelecomFull.count/5
            if(listTelecomFull.count % 5 == 0){
                sizeHeightTelecom = CGFloat(size) * (UIScreen.main.bounds.size.width/5)
            }else{
                sizeHeightTelecom = CGFloat(size + 1) * (UIScreen.main.bounds.size.width/5)
            }
        }
        collectionView.reloadData()
        telecomView.frame.size.height = sizeHeightTelecom
        collectionView.frame.size.height = sizeHeightTelecom
        bottomTelecomView.frame.origin.y = telecomView.frame.origin.y + telecomView.frame.size.height
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: bottomTelecomView.frame.size.height + bottomTelecomView.frame.origin.y + Common.Size(s: 20) + Common.Size(s: 40) + Common.Size(s: 80) + ((parentNavigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        
        //------
        if(!isFullTelecom){
//            listTelecom[0].isSelect = true
//            initUI2(key: listTelecom[0].name)
        }else{
//            listTelecomFull[0].isSelect = true
//            initUI2(key: listTelecomFull[0].name)
        }
        
    }
    
    func initUI2(key:String){
        listPrice.removeAll()
        if let val:[GetPayCodeListResult] = self.telecom[key] {
            var count:Int = 0
            for item in val {
                var isSelect:Bool = false
                if(count == 0){
                    isSelect = true
                }
                listPrice.append(ItemPrice(ID: "\(item.ID)", PriceCard: item.PriceCard, TelecomName: item.TelecomName, TypeNCC: item.TypeNCC, TelecomCode: item.TelecomCode, Price: item.Price, isSelect: isSelect))
                count = count + 1
            }
        }
        collectionViewPrice.reloadData()
        var sizeHeightTelecom:CGFloat = 0
        let size = listPrice.count/3
        if(listPrice.count % 3 == 0){
            sizeHeightTelecom = CGFloat(size) * ((self.view.frame.size.width - Common.Size(s: 10))/3) * 0.5
        }else{
            sizeHeightTelecom = CGFloat(size + 1) * ((self.view.frame.size.width - Common.Size(s: 10))/3) * 0.5
        }
        priceView.frame.size.height = sizeHeightTelecom + Common.Size(s: 10)
        
        collectionViewPrice.frame.size.height = sizeHeightTelecom
        bottomPriceView.frame.origin.y = priceView.frame.origin.y + priceView.frame.size.height
        bottomTelecomView.frame.size.height = bottomPriceView.frame.origin.y + bottomPriceView.frame.size.height
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: bottomTelecomView.frame.size.height + bottomTelecomView.frame.origin.y + Common.Size(s: 10))
        updatePrice()
    }
    
    @objc func minusTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if (quantityValue > 1){
            quantityValue = quantityValue - 1
            quantity.text = "\(quantityValue)"
            updatePrice()
        }
    }
    @objc func plusTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        quantityValue = quantityValue + 1
        quantity.text = "\(quantityValue)"
        updatePrice()
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
            let sum = quantityValue * itemPrice!.Price
             self.quantity.text = "\(quantityValue)"
            self.lbTotalValue.text = "\(Common.convertCurrency(value: sum))"
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
            vc.type = 0
            vc.itemPrice = itemPrice
            vc.quantityValue = quantityValue
            vc.parentNavigationController = parentNavigationController
            vc.phone = phone
            parentNavigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension TabCodeCardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView != self.collectionViewPrice){
            if(!isFullTelecom){
                return listTelecom.count
            }else{
                return listTelecomFull.count
            }
        }else{
            return listPrice.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView != self.collectionViewPrice){
            if(!isFullTelecom){
                let it = listTelecom[indexPath.item]
                if(it.id != -1){
                    for i in 0..<listTelecom.count{
                        listTelecom[i].isSelect = false
                    }
                    listTelecom[indexPath.item].isSelect = true
                    self.collectionView.reloadData()
                    initUI2(key: "\(listTelecom[indexPath.item].name)")
                }else{
                    isFullTelecom = !isFullTelecom
                    initUI()
                }
            }else{
                let it = listTelecomFull[indexPath.item]
                if(it.id != -1){
                    for i in 0..<listTelecomFull.count{
                        listTelecomFull[i].isSelect = false
                    }
                    listTelecomFull[indexPath.item].isSelect = true
                    self.collectionView.reloadData()
                    initUI2(key: "\(listTelecomFull[indexPath.item].name)")
                    
                }else{
                    isFullTelecom = !isFullTelecom
                    initUI()
                }
            }
            
        }else{
            for i in 0..<listPrice.count{
                listPrice[i].isSelect = false
            }
            listPrice[indexPath.item].isSelect = true
            self.collectionViewPrice.reloadData()
            updatePrice()
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView != self.collectionViewPrice){
            
            if(!isFullTelecom){
                let coCell: ItemTelecomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemTelecomCollectionViewCell", for: indexPath) as! ItemTelecomCollectionViewCell
                let item = listTelecom[indexPath.item]
                coCell.setUpCollectionViewCell(item: item,isFullTelecom: isFullTelecom)
                return coCell
            }else{
                let coCell: ItemTelecomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemTelecomCollectionViewCell", for: indexPath) as! ItemTelecomCollectionViewCell
                let item = listTelecomFull[indexPath.item]
                coCell.setUpCollectionViewCell(item: item,isFullTelecom: isFullTelecom)
                return coCell
            }
        }else{
            let coCell: ItemPriceCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemPriceCollectionViewCell", for: indexPath) as! ItemPriceCollectionViewCell
            let item = listPrice[indexPath.item]
            coCell.setUpCollectionViewCell(item: item)
            return coCell
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if(collectionView != self.collectionViewPrice){
            let size = CGSize(width: self.view.frame.size.width/5, height: self.view.frame.size.width/5)
            return size
        }else{
            let size = CGSize(width: (self.view.frame.size.width - Common.Size(s: 10))/3, height: ((self.view.frame.size.width - Common.Size(s: 10))/3) * 0.5)
            return size
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if(collectionView != self.collectionViewPrice){
            return 0
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if(collectionView != self.collectionViewPrice){
            return 0
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if(collectionView != self.collectionViewPrice){
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
class ItemTelecomCollectionViewCell: UICollectionViewCell {
    
    var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setUpCollectionViewCell(item: ItemTelecom,isFullTelecom:Bool) {
        self.subviews.forEach({ $0.removeFromSuperview() })
        contentView.backgroundColor = UIColor.white
        
        let footer = UIView()
        footer.frame = CGRect(x: contentView.frame.width/2 - (contentView.frame.width * 8/10)/2, y: contentView.frame.height/2 - (contentView.frame.width * 8/10)/2, width: contentView.frame.width * 8/10, height: contentView.frame.width * 8/10)
        footer.backgroundColor = UIColor.white
        self.addSubview(footer)
        
        footer.layer.borderWidth = 1
        footer.layer.masksToBounds = false
        footer.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        footer.layer.cornerRadius = footer.frame.height/2
        footer.clipsToBounds = true
        
        if(item.isSelect){
            footer.layer.borderWidth = 2
            footer.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
        }
        
        icon = UIImageView()
        icon = UIImageView(frame: CGRect(x: footer.frame.width/2 - (footer.frame.width * 8/10)/2, y: footer.frame.width/2 - (footer.frame.width * 8/10)/2, width: footer.frame.width * 8/10, height: footer.frame.width * 8/10))
        icon.contentMode = .scaleAspectFit
        footer.addSubview(icon)
        if let img = UIImage(named: "\(item.name)") {
            icon.image = img
        }else{
            
        }
        if(item.id == -1){
            icon.frame = CGRect(x: footer.frame.width/2 - footer.frame.width/4, y: footer.frame.width/2 - footer.frame.width/4, width: footer.frame.width/2, height: footer.frame.width/2)
            if(!isFullTelecom){
                if let img = UIImage(named: "ItemMore") {
                    icon.image = img
                }
            }else{
                if let img = UIImage(named: "ItemClose") {
                    icon.image = img
                }
            }
            
        }
    }
    
}
class ItemPriceCollectionViewCell: UICollectionViewCell {
    
    var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setUpCollectionViewCell(item: ItemPrice) {
        self.subviews.forEach({ $0.removeFromSuperview() })
        contentView.backgroundColor = UIColor.red
        
        let footer = UIView()
        footer.frame = CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: contentView.frame.width - Common.Size(s: 10), height: contentView.frame.height - Common.Size(s: 10))
        footer.backgroundColor = UIColor.white
        footer.layer.masksToBounds = false
        footer.layer.cornerRadius = 10
        footer.layer.borderWidth = 1
        footer.layer.masksToBounds = false
        footer.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        footer.clipsToBounds = true
        self.addSubview(footer)
        
        let lbTotal = UILabel(frame: CGRect(x: 0, y: 0, width: footer.frame.size.width, height: footer.frame.size.height))
        lbTotal.textAlignment = .center
        lbTotal.textColor = UIColor.black
        lbTotal.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbTotal.text = "\(Common.convertCurrencyV2(value: item.PriceCard))"
        footer.addSubview(lbTotal)
        if(item.isSelect){
            footer.backgroundColor = UIColor(netHex: 0x00955E)
            lbTotal.textColor = .white
            footer.layer.borderColor = UIColor.white.cgColor
        }
    }
}
