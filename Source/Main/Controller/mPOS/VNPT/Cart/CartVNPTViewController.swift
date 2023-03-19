//
//  CartViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/28/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

import ActionSheetPicker_3_0
class CartVNPTViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView  =   UITableView()
    var itemsMenu: NSMutableArray!
    var lbTotalValue: UILabel!
    var promotions: [String:NSMutableArray] = [:]
    var group: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Giỏ hàng"
        navigationController?.navigationBar.isTranslucent = false
        group = [String]()
        let sum = Cache.cartsVNPT.count
        if(sum > 0){
            
            let btRightIcon = UIButton.init(type: .custom)
            btRightIcon.setImage(#imageLiteral(resourceName: "home"), for: UIControl.State.normal)
            btRightIcon.imageView?.contentMode = .scaleAspectFit
            btRightIcon.addTarget(self, action: #selector(CartVNPTViewController.actionHome), for: UIControl.Event.touchUpInside)
            btRightIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
            let barRight = UIBarButtonItem(customView: btRightIcon)
            
            
            let btDeleteIcon = UIButton.init(type: .custom)
            btDeleteIcon.setImage(#imageLiteral(resourceName: "Delete"), for: UIControl.State.normal)
            btDeleteIcon.imageView?.contentMode = .scaleAspectFit
            btDeleteIcon.addTarget(self, action: #selector(CartVNPTViewController.actionDelete), for: UIControl.Event.touchUpInside)
            btDeleteIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
            let barDelete = UIBarButtonItem(customView: btDeleteIcon)
            self.navigationItem.rightBarButtonItems = [barDelete,barRight]
            
            
            itemsMenu = NSMutableArray()
            itemsMenu.addObjects(from: Cache.cartsVNPT)
            tableView.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - Common.Size(s: 80) - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(ItemCartVNPTTableViewCell.self, forCellReuseIdentifier: "ItemCartVNPTTableViewCell")
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = UIColor(netHex: 0xEAEAEA)
            tableView.separatorStyle = .none
            self.view.addSubview(tableView)
            
            let footer = UIView()
            footer.frame = CGRect(x: 0, y:self.view.frame.size.height - Common.Size(s: 80) - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) , width: self.view.frame.size.width, height: Common.Size(s: 80))
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
            
            let btNext = UIButton(frame: CGRect(x: lbTotal.frame.origin.x, y: footer.frame.size.height - footer.frame.size.height/2 - Common.Size(s: 5), width: lbTotal.frame.size.width, height: footer.frame.size.height/2 - Common.Size(s: 5)))
            btNext.layer.cornerRadius = 5
            btNext.setTitle("TIẾP TỤC",for: .normal)
            btNext.titleLabel?.font = UIFont.systemFont(ofSize: Common.Size(s: 16))
            btNext.backgroundColor = UIColor.init(netHex: 0xD0021B)
            footer.addSubview(btNext)
            btNext.addTarget(self, action:#selector(self.payAction), for: .touchUpInside)
            
            lbTotalValue = UILabel(frame: lbTotal.frame)
            lbTotalValue.textAlignment = .right
            lbTotalValue.textColor = UIColor(netHex:0xD0021B)
            lbTotalValue.font = UIFont.boldSystemFont(ofSize: 20)
            footer.addSubview(lbTotalValue)
            updateTotal()
            
        }else{
            
            var logo : UIImageView
            logo  = UIImageView(frame:CGRect(x: self.view.frame.size.width/2 - Common.Size(s:25), y: self.view.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50)));
            logo.image = UIImage(named:"Cancel File-100")
            logo.contentMode = .scaleAspectFit
            self.view.addSubview(logo)
            
            let productNotFound = "Không có sản phẩm trong giỏ hàng"
            let lbNotFound = UILabel(frame: CGRect(x: 0, y: logo.frame.origin.y + logo.frame.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width, height: Common.Size(s:22)))
            lbNotFound.textAlignment = .center
            lbNotFound.textColor = UIColor.lightGray
            lbNotFound.font = UIFont.systemFont(ofSize: Common.Size(s:15))
            lbNotFound.text = productNotFound
            self.view.addSubview(lbNotFound)
            
        }
    }
    @objc func actionHome(){
        _ = self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func actionDelete() {
        let alert = UIAlertController(title: "XOÁ GIỎ HÀNG", message: "Bạn muốn xoá TẤT CẢ sản phẩm hiện có trong giỏ hàng?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Xoá tất cả", style: .destructive) { _ in
            Cache.cartsVNPT.removeAll()
            
            Cache.itemsPromotion.removeAll()
            Cache.cartsVNPT = []
        
            _ = self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    @objc func payAction(_ sender:UITapGestureRecognizer){
        
        var isHaveSimBook:Bool = false
        for item in Cache.cartsVNPT{
            
            if(item.product.labelName == "Y"){
                if(item.quantity > 1){
                    isHaveSimBook = true
                }
            }
        }
        if(isHaveSimBook == true){
            let alert = UIAlertController(title: "Thông báo", message: "Giỏ hàng chỉ được mua một sản phẩm gói cước!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        
        Cache.promotionsVNPT.removeAll()
        Cache.groupVNPT = []
        Cache.itemsPromotionVNPT.removeAll()
        self.promotions.removeAll()
        self.group.removeAll()
        
        let newViewController = PaymentVNPTViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func popupDelete() {
        
        let alert = UIAlertController(title: "HẾT HÀNG", message: "Bạn muốn xoá các sản phẩm hết hàng?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Xoá tất cả", style: .destructive) { _ in
            var ide = -1
            for item2 in Cache.cartsVNPT{
                ide = ide + 1
                if(item2.inStock == 0){
                    Cache.cartsVNPT.remove(at: ide)
                }
            }
            self.tableView.reloadData()
            self.updateTotal()
            if (Cache.cartsVNPT.count <= 0){
                
                Cache.itemsPromotion.removeAll()
                Cache.cartsVNPT = []
         
                _ = self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            }
        })
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //notification center
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(updateTotalNotification), name: Notification.Name("updateTotal"), object: nil)
        tableView.reloadData()
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("Catch notification viewDidDisappear")
        NotificationCenter.default.removeObserver(self, name: Notification.Name("updateTotal"), object: nil);
    }
    @objc func updateTotalNotification(notification:Notification) -> Void {
        print("Catch notification")
        tableView.reloadData()
        updateTotal()
        
    }
    func updateTotal(){
        var sum: Float = 0
        for item in Cache.cartsVNPT {
            sum = sum + Float(item.quantity) * item.product.price
        }
        lbTotalValue.text = Common.convertCurrencyFloat(value: sum)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemsMenu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemCartVNPTTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemCartVNPTTableViewCell")
        let item:Cart = itemsMenu.object(at: indexPath.row) as! Cart
        cell.setup(cart: item,pos:indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let item:Cart = itemsMenu.object(at: indexPath.row) as! Cart
        //        if (item.product.qlSerial == "Y"){
        //            let newViewController = LoadingViewController()
        //            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        //            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        //            self.present(newViewController, animated: true, completion: nil)
        //
        //
        //
        //        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            if(Cache.cartsVNPT[indexPath.row].sku == "00503355"){
                Cache.phoneNumberBookSim = ""
            }
            Cache.cartsVNPT.remove(at: indexPath.row)
            
            itemsMenu.removeObject(at: indexPath.row)
            tableView.reloadData()
            //            tableView.deleteRows(at: [indexPath], with: .fade)
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("updateTotal"), object: nil)
            
            if (Cache.cartsVNPT.count <= 0){
                Cache.itemsPromotionVNPT.removeAll()
                Cache.cartsVNPT = []
              
                _ = self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:110);
    }
    
    
}

class ItemCartVNPTTableViewCell: UITableViewCell {
    
    var title: UILabel!
    var iconImage:UIImageView!
    var price: UILabel!
    var control: UIView!
    var iconMinus:UIImageView!
    var iconPlus:UIImageView!
    var quantity: UILabel!
    var productColor: UIView!
    var inStock: UILabel!
    var notInStock: UILabel!
    var imei: UILabel!
    var viewNumber:UIView!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        iconImage = UIImageView(frame: CGRect(x: Common.Size(s:5), y:  Common.Size(s:5),width:Common.Size(s:90), height:  Common.Size(s:90)))
        iconImage.contentMode = UIView.ContentMode.scaleAspectFit
        contentView.addSubview(iconImage)
        title = UILabel()
        title.textColor = UIColor.black
        title.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(title)
        
        price = UILabel()
        price.textColor = UIColor(netHex:0xD0021B)
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        contentView.addSubview(price)
        
        control = UIView()
        contentView.addSubview(control)
        viewNumber = UIView()
        control.addSubview(viewNumber)
        viewNumber.layer.borderWidth = 0.5
        viewNumber.layer.borderColor = UIColor.gray.cgColor
        
        iconMinus = UIImageView()
        iconMinus.contentMode = UIView.ContentMode.scaleAspectFit
        iconMinus.image = #imageLiteral(resourceName: "Minus")
        
        control.addSubview(iconMinus)
        iconPlus = UIImageView()
        iconPlus.contentMode = UIView.ContentMode.scaleAspectFit
        iconPlus.image = #imageLiteral(resourceName: "Plus")
        control.addSubview(iconPlus)
        
        quantity = UILabel()
        quantity.textColor = UIColor.gray
        quantity.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        quantity.textAlignment = .center
        quantity.layer.borderWidth = 0.5
        quantity.layer.borderColor = UIColor.gray.cgColor
        control.addSubview(quantity)
        
        
        
        
        //color
        productColor = UIView()
        productColor.backgroundColor = .white
        control.addSubview(productColor)
        
        inStock = UILabel()
        inStock.textColor = UIColor(netHex:0xEF4A40)
        inStock.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        inStock.textAlignment = .center
        control.addSubview(inStock)
        inStock.isHidden = true
        
        notInStock = UILabel()
        notInStock.textColor = UIColor.white
        notInStock.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        notInStock.textAlignment = .center
        notInStock.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        contentView.addSubview(notInStock)
        notInStock.isHidden = true
        
        imei = UILabel()
        imei.textColor = UIColor.gray
        imei.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        control.addSubview(imei)
    }
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += Common.Size(s: 2)
            frame.size.height -= 2 * Common.Size(s: 2)
            super.frame = frame
        }
    }
    
    func setup(cart:Cart,pos:Int){
        
//        let nameProduc = "\(cart.product.sku)-\(cart.product.name)"
        let nameProduc = "\(cart.sku)-\(cart.product.name)"
        let sizeTitle = nameProduc.height(withConstrainedWidth: UIScreen.main.bounds.size.width - (iconImage.frame.origin.x + iconImage.frame.size.width + Common.Size(s:12)), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
        
        title.frame = CGRect(x:iconImage.frame.origin.x + iconImage.frame.size.width + Common.Size(s:10),y:iconImage.frame.origin.y + Common.Size(s:5) ,width: UIScreen.main.bounds.size.width - (iconImage.frame.origin.x + iconImage.frame.size.width + Common.Size(s:12)) ,height: sizeTitle)
        title.text = nameProduc
        title.numberOfLines = 2
        title.sizeToFit()
        
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = "\(cart.product.iconUrl)".addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            let url = URL(string: "\(escapedString)")!
            iconImage.kf.setImage(with: url,
                                  placeholder: nil,
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil,
                                  completionHandler: nil)
        }
        
        
        let priceValue = cart.product.price * Float(cart.quantity)
        let priceText = Common.convertCurrencyFloat(value: priceValue)
        price.text = priceText
        
        price.frame = CGRect(x:title.frame.origin.x,y:title.frame.origin.y + title.frame.size.height,width: title.frame.size.width  ,height: priceText.height(withConstrainedWidth: title.frame.size.width, font: UIFont.boldSystemFont(ofSize: Common.Size(s:18))))
        
        control.frame = CGRect(x: price.frame.origin.x, y: Common.Size(s:100) - Common.Size(s:30), width:  UIScreen.main.bounds.size.width - (iconImage.frame.origin.x + iconImage.frame.size.width + Common.Size(s:12)), height: Common.Size(s:25))
        
        if (cart.product.qlSerial == "N"){
            
            
            
            
            iconMinus.frame =  CGRect(x: 0, y: control.frame.size.height/4, width: control.frame.size.height, height: control.frame.size.height/2)
            
            quantity.frame = CGRect(x: iconMinus.frame.origin.x + iconMinus.frame.size.width, y: 0, width: iconMinus.frame.size.width, height: control.frame.size.height)
            
            quantity.text = "\(cart.quantity)"
            
            iconPlus.frame =  CGRect(x: quantity.frame.origin.x + quantity.frame.size.width, y: iconMinus.frame.origin.y, width: iconMinus.frame.size.width, height: iconMinus.frame.size.height)
            
            viewNumber.frame =  CGRect(x: 0, y: 0, width: iconPlus.frame.size.width + iconPlus.frame.origin.x, height: control.frame.size.height)
            
            productColor.frame = CGRect(x: control.frame.size.width - iconPlus.frame.size.width - Common.Size(s:10), y: iconMinus.frame.origin.y + Common.Size(s:5)/2, width: iconPlus.frame.size.width - Common.Size(s:5), height:iconPlus.frame.size.height - Common.Size(s:5))
            
            let shadowView = UIView(frame: CGRect(x:0, y:0,width: productColor.frame.width,height: productColor.frame.width))
            shadowView.layer.shadowColor = UIColor.red.cgColor
            shadowView.layer.shadowOffset = .zero
            shadowView.layer.shadowOpacity = 0.5
            shadowView.layer.shadowRadius = 5
            let view = UIView(frame: shadowView.bounds)
            view.backgroundColor = cart.color.hexColor
            view.layer.cornerRadius = 10.0
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 0.5
            view.layer.cornerRadius = view.frame.size.width/2
            view.clipsToBounds = true
            shadowView.addSubview(view)
            productColor.addSubview(shadowView)
            
            iconMinus.tag = pos
            let tapMinus = UITapGestureRecognizer(target: self, action: #selector(minusTapped(tapGestureRecognizer:)))
            iconMinus.isUserInteractionEnabled = true
            iconMinus.addGestureRecognizer(tapMinus)
            
            iconPlus.tag = pos
            let tapPlus = UITapGestureRecognizer(target: self, action: #selector(plusTapped(tapGestureRecognizer:)))
            iconPlus.isUserInteractionEnabled = true
            iconPlus.addGestureRecognizer(tapPlus)
            
            if (cart.inStock >= 0){
                inStock.isHidden = false
                notInStock.isHidden = false
                inStock.frame = CGRect(x:iconPlus.frame.origin.x + iconPlus.frame.size.width,y:0,width: productColor.frame.origin.x -  iconPlus.frame.origin.x - iconPlus.frame.size.width,height: iconPlus.frame.size.height)
                inStock.text = "Tồn kho: \(cart.inStock)"
                
                notInStock.frame = iconImage.frame
                notInStock.text = "Hết hàng"
            }
        }else{
            productColor.frame = CGRect(x: control.frame.size.width - control.frame.size.height - Common.Size(s:10), y:  Common.Size(s:5)/2, width: control.frame.size.height - Common.Size(s:5), height:control.frame.size.height - Common.Size(s:5))
            
            let shadowView = UIView(frame: CGRect(x:0, y:0,width: productColor.frame.width,height: productColor.frame.width))
            shadowView.layer.shadowColor = UIColor.red.cgColor
            shadowView.layer.shadowOffset = .zero
            shadowView.layer.shadowOpacity = 0.5
            shadowView.layer.shadowRadius = 5
            let view = UIView(frame: shadowView.bounds)
            view.backgroundColor = cart.color.hexColor
            view.layer.cornerRadius = 10.0
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 0.5
            view.layer.cornerRadius = view.frame.size.width/2
            view.clipsToBounds = true
            shadowView.addSubview(view)
            productColor.addSubview(shadowView)
            
            imei.frame = CGRect(x: 0, y: 0, width: productColor.frame.origin.x - Common.Size(s:5), height: control.frame.size.height)
            
            imei.text = "IMEI: \(cart.imei)"
            
            if (cart.inStock >= 0){
                inStock.isHidden = false
                notInStock.isHidden = false
                inStock.frame = CGRect(x:iconPlus.frame.origin.x + iconPlus.frame.size.width,y:0,width: productColor.frame.origin.x -  iconPlus.frame.origin.x - iconPlus.frame.size.width,height: iconPlus.frame.size.height)
                inStock.text = "Tồn kho: \(cart.inStock)"
                
                notInStock.frame = iconImage.frame
                notInStock.text = "Hết hàng"
            }
        }
    }
    
    func showImei(result:[Imei]){
        
    }
    @objc func minusTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let pos: Int = tappedImage.tag
        let quantityValue = Cache.carts[pos].quantity
        if (quantityValue > 1){
            Cache.cartsVNPT[pos].quantity = quantityValue - 1
            let item = Cache.cartsVNPT[pos]
            quantity.text = "\(item.quantity)"
            let priceValue = item.product.price * Float(item.quantity)
            let priceText = Common.convertCurrencyFloat(value: priceValue)
            price.text = priceText
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("updateTotal"), object: nil)
        }
    }
    @objc func plusTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let pos: Int = tappedImage.tag
        let quantityValue = Cache.cartsVNPT[pos].quantity
        Cache.cartsVNPT[pos].quantity = quantityValue + 1
        let item = Cache.cartsVNPT[pos]
        quantity.text = "\(item.quantity)"
        let priceValue = item.product.price * Float(item.quantity)
        let priceText = Common.convertCurrencyFloat(value: priceValue)
        price.text = priceText
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("updateTotal"), object: nil)
        
    }
    
}
