//
//  ItemBuyExtendedCell.swift
//  fptshop
//
//  Created by Sang Trương on 17/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

class ItemBuyExtendedCell: UITableViewCell {
    var selectedPRoduct:UILabel!
    var selectedPRoductSub:UILabel!
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
    var accessoriesLabel: UILabel!
    var didPressAccessories: (() -> Void)?
    var heightCLV:CGFloat = 0
    var dataRow: Cart?
    var indexPathCart:Int = 0
    var lastIndexActive:IndexPath = [1 ,0]
    var itemIselected:[IndexPath] = []
    weak var viewController: UIViewController? = nil
    
    private var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        layout.estimatedItemSize = CGSize(width: Common.heightWidthCLV , height: Common.heightWidthCLV)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var isAccessoriesLbl = false
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectedPRoduct = UILabel()
        contentView.addSubview(selectedPRoduct)
        selectedPRoduct.snp.makeConstraints({(make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(200)
        })
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
        
        accessoriesLabel = UILabel()
        accessoriesLabel.textColor = UIColor(netHex:0x1B4888)
        accessoriesLabel.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        accessoriesLabel.textAlignment = .right
        
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
    var sttGoiBH:Int = 0
	func setup(cart:Cart,pos:Int,heightClv:CGFloat,isCartMirae:Bool){
        if cart.product.isPickGoiBH == "isPick" {
            self.dataRow = cart
            self.indexPathCart = pos
        }
        if cart.product.is_ExtendedWar{
            sttGoiBH = pos + 1
        }
        if dataRow?.product.isPickGoiBH == "isPick"  {
            self.setUp2(cart: cart, pos: pos,heightClv:heightClv)
		}else if isCartMirae{
			self.setupCell(cart: cart, pos: pos)
		} else{
            self.setupCell(cart: cart, pos: pos)
        }
        
    }
    func setupCell(cart:Cart,pos:Int){
        
        if cart.product.is_ExtendedWar {
            iconImage = UIImageView(frame: CGRect(x: Common.Size(s:5), y:  Common.Size(s:15),width:Common.Size(s:90), height:  Common.Size(s:90)))
            iconImage.contentMode = UIView.ContentMode.scaleAspectFit
            contentView.addSubview(iconImage)
            selectedPRoduct = UILabel()
            contentView.addSubview(selectedPRoduct)
            selectedPRoduct.textColor = .gray
            selectedPRoduct.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
            selectedPRoduct.text = "Sản phẩm chọn mua \(sttGoiBH)"
            selectedPRoduct.snp.makeConstraints({(make) in
                make.bottom.equalTo(iconImage.snp.top)
                make.left.equalTo(contentView.snp.left).offset(10)
                make.height.equalTo(20)
                make.width.equalTo(200)
            })
        }
        
        
        let nameProduc = "\(cart.sku)-\(cart.product.name)"
        let sizeTitle = nameProduc.height(withConstrainedWidth: UIScreen.main.bounds.size.width - (iconImage.frame.origin.x + iconImage.frame.size.width + Common.Size(s:12)), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
        
        title.frame = CGRect(x:iconImage.frame.origin.x + iconImage.frame.size.width + Common.Size(s:10),y:iconImage.frame.origin.y + Common.Size(s:5) ,width: UIScreen.main.bounds.size.width - (iconImage.frame.origin.x + iconImage.frame.size.width + Common.Size(s:12)) ,height: sizeTitle)
        title.text = nameProduc
        title.numberOfLines = 2
        title.sizeToFit()
        
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if(cart.product.amountGoiBH == "true" && cart.product.is_ExtendedWar == false){
            if cart.product.brandName == "1" {
                iconImage.image = UIImage(named: "icbaohanh")
            } else if cart.product.brandName == "2" {
                iconImage.image = UIImage(named: "icBoltech")
            }
            iconImage.frame = CGRect(x: Common.Size(s:5), y:  Common.Size(s:20),width:Common.Size(s:90), height:  Common.Size(s:90))
            sttGoiBH += 2
            selectedPRoduct.text = "Sản phẩm chọn mua \(pos  + 1)"
            selectedPRoduct.textColor = .gray
            selectedPRoduct.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
            selectedPRoduct.snp.makeConstraints({(make) in
                make.bottom.equalTo(iconImage.snp.top)
                make.left.equalTo(contentView.snp.left).offset(10)
                make.height.equalTo(20)
                make.width.equalTo(200)
            })
            title.frame = CGRect(x:iconImage.frame.origin.x + iconImage.frame.size.width + Common.Size(s:10),y:iconImage.frame.origin.y + Common.Size(s:5) ,width: UIScreen.main.bounds.size.width - (iconImage.frame.origin.x + iconImage.frame.size.width + Common.Size(s:12)) ,height: sizeTitle)
            productColor.isHidden = true
            imei.isHidden = true
        }else {
            if let escapedString = "\(cart.product.imageUrl)".addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                print(escapedString)
                if(escapedString != ""){
                    let url = URL(string: "\(escapedString)")!
                    iconImage.kf.setImage(with: url,
                                          placeholder: nil,
                                          options: [.transition(.fade(1))],
                                          progressBlock: nil,
                                          completionHandler: nil)
                }
                
            }
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
            
            if cart.replacementAccessoriesLabel.isEmpty {
                accessoriesLabel.isHidden = true
            } else {
                contentView.addSubview(accessoriesLabel)
                accessoriesLabel.isHidden = false
                accessoriesLabel.frame = CGRect(x: UIScreen.main.bounds.width - Common.Size(s: 150) - Common.Size(s: 10), y: control.frame.origin.y + 35 + control.frame.height + Common.Size(s: 5), width: Common.Size(s: 150), height: Common.Size(s: 25))
                let underline = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
                let underlineAttributedString = NSAttributedString(string: cart.replacementAccessoriesLabel, attributes: underline)
                accessoriesLabel.attributedText = underlineAttributedString
                let accessoriesTap = UITapGestureRecognizer(target: self, action: #selector(accessoriesTapped(tapGestureRecognizer:)))
                accessoriesLabel.isUserInteractionEnabled = true
                accessoriesLabel.addGestureRecognizer(accessoriesTap)
            }
        }
    }
    func setUp2(cart:Cart,pos:Int,heightClv:CGFloat) {
        self.dataRow = cart
        self.indexPathCart = pos
        self.heightCLV = heightClv
        if cart.replacementAccessoriesLabel[pos] != "" {
            self.isAccessoriesLbl = true
        }
        self.isAccessoriesLbl = cart.replacementAccessoriesLabel[pos] != ""
        selectedPRoduct = UILabel()
        selectedPRoduct.textColor = .gray
        selectedPRoduct.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: Common.heightWidthCLV , height: Common.heightWidthCLV)
        
        if isAccessoriesLbl {
            collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: heightCLV + 20),collectionViewLayout: layout)
            contentView.addSubview(collectionView)
            collectionView.snp.makeConstraints({(make) in
                let estimateCellheight:CGFloat = CGFloat(cart.product.skuBH.count * 6)
                make.left.equalToSuperview().offset(2)
                make.right.equalToSuperview().offset(-2)
                make.top.equalToSuperview().offset(25)
                make.height.equalTo(heightCLV + estimateCellheight)
            })
            
        }else {
            collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: heightCLV ),collectionViewLayout: layout)
            contentView.addSubview(collectionView)
            collectionView.snp.makeConstraints({(make) in
                let estimateCellheight:CGFloat = CGFloat(cart.product.skuBH.count * 6)
                make.left.equalToSuperview().offset(2)
                make.right.equalToSuperview().offset(-2)
                make.top.equalToSuperview().offset(25)
                make.height.equalTo(heightCLV + estimateCellheight)
                
            })
            
        }
        
        //            self.collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .white
        self.collectionView.register(itemBaoHanhnCollectionViewCell.self, forCellWithReuseIdentifier: "itemBaoHanhnCollectionViewCell")
        contentView.addSubview(collectionView)
        //        self.collectionView.backgroundColor = .blue
        contentView.isUserInteractionEnabled = true
        self.collectionView.reloadData()
        
        selectedPRoductSub = UILabel()
        selectedPRoductSub.textColor = .gray
        selectedPRoductSub.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        
        contentView.addSubview(selectedPRoductSub)
        selectedPRoductSub.snp.makeConstraints({(make) in
            make.top.equalToSuperview()
            make.left.equalTo(contentView.snp.left).offset(10)
            make.height.equalTo(30)
            make.right.equalToSuperview()
        })
        selectedPRoductSub.text =  "Gói bảo hành kèm theo sản phẩm \(sttGoiBH - 1)"
        
    }
//    @objc func didSelectGoiBH(_ sender: Any) {
//       if let select  = onSelectImei {
//           select()
//       }
//   }
    func showImei(result:[Imei]){
        
    }
    @objc func accessoriesTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        didPressAccessories?()
    }
    @objc func minusTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let pos: Int = tappedImage.tag
        let quantityValue = Cache.carts[pos].quantity
        if (quantityValue > 1){
            Cache.carts[pos].quantity = quantityValue - 1
            let item = Cache.carts[pos]
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
        let quantityValue = Cache.carts[pos].quantity
        Cache.carts[pos].quantity = quantityValue + 1
        let item = Cache.carts[pos]
        quantity.text = "\(item.quantity)"
        let priceValue = item.product.price * Float(item.quantity)
        let priceText = Common.convertCurrencyFloat(value: priceValue)
        price.text = priceText
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("updateTotal"), object: nil)
        
    }
    
}

