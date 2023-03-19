//
//  BuyExtendWarViewController.swift
//  fptshop
//
//  Created by Sang Truong on 2/18/22.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
class ItemInsertGoiBH: NSObject {
    var indexPath: Int
    var arrInndex:[IndexPath]
    init(indexPath:Int,arrIndex:[IndexPath]) {
        self.indexPath = indexPath
        self.arrInndex = arrIndex
    }
}
struct GoiBHInsertAt {
    static var listInsert:[ItemInsertGoiBH] = []
    static var CartAtIndex0:[Cart] = []
    static var carts:[Cart] = []
}
class BuyExtendWarViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
 
    //MARK: - Properties
    var tableView: UITableView  =   UITableView()
    var itemsMenu: NSMutableArray!
    var promotions: [String:NSMutableArray] = [:]
    var group: [String]!
    var isFromSearch = true
    var tracocItem: CustomerTraCoc?
    var indexPathInser:Int = 0
    var listInsertGoiBH:[Int] = []
    var goiBHSelected:NSMutableArray!
    var storedOffsets = [Int: CGFloat]()
    var countUpInsert:Int = 0
	var isCartMirae:Bool = false
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //left menu icon
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        self.view.backgroundColor = UIColor(netHex: 0xEAEAEA)
        self.navigationItem.title = "Gói Bảo Hành"
        navigationController?.navigationBar.isTranslucent = false
        group = [String]()
        let sum = Cache.carts.count
		if isCartMirae  {
			itemsMenu = NSMutableArray()
			itemsMenu.addObjects(from: Cache.cartsMirae)
			setupTableView()
		}else if(sum > 0 ){
            itemsMenu = NSMutableArray()
            itemsMenu.addObjects(from: Cache.carts)
            updateTotal()
			setupTableView()
		}
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
    // MARK: - Selectors
    @objc func handleBack(){
        insertGoiBHSelected()
    }
    @objc func payAction(_ sender:UITapGestureRecognizer){
        insertGoiBHSelected()
    }
    
    //MARK: Helpers
	private func setupTableView(){
		tableView.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - Common.Size(s: 80) - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(ItemBuyExtendedCell.self, forCellReuseIdentifier: "ItemBuyExtendedCell")
		tableView.tableFooterView = UIView()
		tableView.backgroundColor = UIColor(netHex: 0xEAEAEA)
		tableView.separatorStyle = .none
		self.view.addSubview(tableView)
		let btNext = UIButton()
		btNext.layer.cornerRadius = 5
		btNext.setTitle("OK",for: .normal)
		btNext.titleLabel?.font = UIFont.systemFont(ofSize: Common.Size(s: 16))
		btNext.backgroundColor = UIColor.init(netHex: 0xD0021B)
		view.addSubview(btNext)
		btNext.snp.makeConstraints({(make) in
			make.left.equalTo(view.snp.left).offset(10)
			make.right.equalTo(view.snp.right).offset(-10)
			make.bottom.equalTo(view.snp.bottom).offset(-10)
			make.height.equalTo(50)
		})
		btNext.addTarget(self, action:#selector(self.payAction), for: .touchUpInside)
	}
    private func insertGoiBHSelected(){
		if isCartMirae {
			insertItemWarantyMirae()
		}else {
			insertItemWaranty()
		}

        
    }
	private func insertItemWarantyMirae(){
		for item in GoiBHInsertAt.listInsert{
			if item.arrInndex.count == 1 {
					// item.indexPath la vi tri insert goi bh
				let itemNameBH = Cache.cartsMirae[item.indexPath + countUpInsert - 1].product.nameBH[item.arrInndex[0].row]
				let itemCodeBH =  Cache.cartsMirae[item.indexPath + countUpInsert - 1].product.skuBH[item.arrInndex[0].row]
				let itemBrandName = Cache.cartsMirae[item.indexPath + countUpInsert - 1].product.brandGoiBH[item.arrInndex[0].row]
				let itemRoleBH = Cache.cartsMirae[item.indexPath + countUpInsert - 1].product.role2

				let pro = Product(model_id: "", id: 0, name: itemNameBH, brandID: 0, brandName: itemBrandName, typeId: 0, typeName: "Goi1", sku: itemCodeBH, price: 0, priceMarket: 0, priceBeforeTax: 0, iconUrl: "", imageUrl: "", promotion: "", includeInfo: "", hightlightsDes: "", labelName: "", urlLabelPicture: "", isRecurring: false, manSerNum: "", bonusScopeBoom: "", qlSerial: "", inventory: 0, LableProduct: "", p_matkinh: "", ecomColorValue: "", ecomColorName: "", ecom_itemname_web: "", price_special: 0, price_online_pos: 0, price_online: 0, hotSticker: false, is_NK: false, is_ExtendedWar: false, skuBH: [], nameBH: [],brandGoiBH:[], isPickGoiBH: "Picked", amountGoiBH: "true", itemCodeGoiBH: itemCodeBH, itemNameGoiBH: itemNameBH ,priceSauKM: 0,role2: itemRoleBH)

				let cart = Cart(sku: itemCodeBH, product: pro,quantity: 1,color:"#ffffff",inStock:-1, imei: "N/A",price: 0, priceBT: 0, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
				if  Cache.cartsMirae[item.indexPath + countUpInsert - 1].product.typeName == "Goi1" {
					Cache.cartsMirae[item.indexPath + countUpInsert - 1] = cart
					Cache.cartsMirae[item.indexPath + countUpInsert - 1].product.amountGoiBH = "1"
				}else {
					Cache.cartsMirae[item.indexPath + countUpInsert - 1].product.amountGoiBH = "1"
					Cache.cartsMirae.insert(cart, at: item.indexPath + countUpInsert)
					countUpInsert += 1
				}

			}
			else if item.arrInndex.count == 2{
				for (index,_) in item.arrInndex.enumerated(){
						//đã chọn mua 2 gói bh
						//item.indexPath = vi tri goi bh

					let itemNameBH2 = Cache.cartsMirae[item.indexPath + countUpInsert - 1 - index].product.nameBH[item.arrInndex[index].row]
					let itemCodeBH2 =  Cache.cartsMirae[item.indexPath + countUpInsert - 1 - index].product.skuBH[item.arrInndex[index].row]
					let itemBrandName =  Cache.cartsMirae[item.indexPath + countUpInsert - 1 - index].product.brandGoiBH[item.arrInndex[index].row]
					let itemRoleBH2 = Cache.cartsMirae[item.indexPath + countUpInsert - 1 ].product.role2


					let pro2 = Product(model_id: "", id: 0, name: itemNameBH2, brandID: 0, brandName: itemBrandName, typeId: 0, typeName: "Goi\(index + 1)", sku: itemCodeBH2, price: 0, priceMarket: 0, priceBeforeTax: 0, iconUrl: "", imageUrl: "", promotion: "", includeInfo: "", hightlightsDes: "", labelName: "", urlLabelPicture: "", isRecurring: false, manSerNum: "", bonusScopeBoom: "", qlSerial: "", inventory: 0, LableProduct: "", p_matkinh: "", ecomColorValue: "", ecomColorName: "", ecom_itemname_web: "", price_special: 0, price_online_pos: 0, price_online: 0, hotSticker: false, is_NK: false, is_ExtendedWar: false, skuBH: [], nameBH: [],brandGoiBH:[], isPickGoiBH: "Picked", amountGoiBH: "true", itemCodeGoiBH: itemCodeBH2, itemNameGoiBH: itemNameBH2 ,priceSauKM: 0,role2: itemRoleBH2)

					let cart2 = Cart(sku: itemCodeBH2, product: pro2,quantity: 1,color:"#ffffff",inStock:-1, imei: "N/A",price: 0, priceBT: 0, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")

					switch index {
						case 0:
							if  Cache.cartsMirae[item.indexPath + countUpInsert ].product.typeName == "Goi1" {
								Cache.cartsMirae[item.indexPath + countUpInsert ] = cart2
								Cache.cartsMirae[item.indexPath + countUpInsert ].product.amountGoiBH = "1"

							}else {
								Cache.cartsMirae[item.indexPath + countUpInsert - 1].product.amountGoiBH = "1"
								Cache.cartsMirae.insert(cart2, at: item.indexPath + countUpInsert)
								countUpInsert += 1
							}
						case 1:
							if  Cache.cartsMirae[item.indexPath + countUpInsert - index].product.typeName == "Goi2" {
								Cache.cartsMirae[item.indexPath + countUpInsert - index] = cart2
								Cache.cartsMirae[item.indexPath + countUpInsert - index].product.amountGoiBH = "2"
							}else {
								Cache.cartsMirae[item.indexPath + countUpInsert - index - 1].product.amountGoiBH = "2"
								Cache.cartsMirae.insert(cart2, at: item.indexPath + countUpInsert )
								countUpInsert += 1
							}
						default:
							return
					}

				}
			}
		}
		countUpInsert = 0
		var count:Int = 0
		for (index,item) in Cache.cartsMirae.enumerated() {

			if item.product.isPickGoiBH == "isPick" && item.product.itemCodeGoiBH == "" {
				if index == 1 {
					for item in GoiBHInsertAt.listInsert{
						item.indexPath -= 1
						break
					}
				}
					//xoa goi bh chua pick
				Cache.cartsMirae.remove(at: index + count)
				count -= 1
			}

		}

		count = 0
		GoiBHInsertAt.listInsert.removeAll()
		navigationController?.popViewController(animated: true)
	}
	private func insertItemWaranty(){
		for item in GoiBHInsertAt.listInsert{
			if item.arrInndex.count == 1 {
					// item.indexPath la vi tri insert goi bh
				let itemNameBH = Cache.carts[item.indexPath + countUpInsert - 1].product.nameBH[item.arrInndex[0].row]
				let itemCodeBH =  Cache.carts[item.indexPath + countUpInsert - 1].product.skuBH[item.arrInndex[0].row]
				let itemBrandName = Cache.carts[item.indexPath + countUpInsert - 1].product.brandGoiBH[item.arrInndex[0].row]
				let itemRoleBH = Cache.carts[item.indexPath + countUpInsert - 1].product.role2

				let pro = Product(model_id: "", id: 0, name: itemNameBH, brandID: 0, brandName: itemBrandName, typeId: 0, typeName: "Goi1", sku: itemCodeBH, price: 0, priceMarket: 0, priceBeforeTax: 0, iconUrl: "", imageUrl: "", promotion: "", includeInfo: "", hightlightsDes: "", labelName: "", urlLabelPicture: "", isRecurring: false, manSerNum: "", bonusScopeBoom: "", qlSerial: "", inventory: 0, LableProduct: "", p_matkinh: "", ecomColorValue: "", ecomColorName: "", ecom_itemname_web: "", price_special: 0, price_online_pos: 0, price_online: 0, hotSticker: false, is_NK: false, is_ExtendedWar: false, skuBH: [], nameBH: [],brandGoiBH:[], isPickGoiBH: "Picked", amountGoiBH: "true", itemCodeGoiBH: itemCodeBH, itemNameGoiBH: itemNameBH ,priceSauKM: 0,role2: itemRoleBH)

				let cart = Cart(sku: itemCodeBH, product: pro,quantity: 1,color:"#ffffff",inStock:-1, imei: "N/A",price: 0, priceBT: 0, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
				if  Cache.carts[item.indexPath + countUpInsert - 1].product.typeName == "Goi1" {
					Cache.carts[item.indexPath + countUpInsert - 1] = cart
					Cache.carts[item.indexPath + countUpInsert - 1].product.amountGoiBH = "1"
				}else {
					Cache.carts[item.indexPath + countUpInsert - 1].product.amountGoiBH = "1"
					Cache.carts.insert(cart, at: item.indexPath + countUpInsert)
					countUpInsert += 1
				}

			}
			else if item.arrInndex.count == 2{
				for (index,_) in item.arrInndex.enumerated(){
						//đã chọn mua 2 gói bh
						//item.indexPath = vi tri goi bh

					let itemNameBH2 = Cache.carts[item.indexPath + countUpInsert - 1 - index].product.nameBH[item.arrInndex[index].row]
					let itemCodeBH2 =  Cache.carts[item.indexPath + countUpInsert - 1 - index].product.skuBH[item.arrInndex[index].row]
					let itemBrandName =  Cache.carts[item.indexPath + countUpInsert - 1 - index].product.brandGoiBH[item.arrInndex[index].row]
					let itemRoleBH2 = Cache.carts[item.indexPath + countUpInsert - 1 ].product.role2


					let pro2 = Product(model_id: "", id: 0, name: itemNameBH2, brandID: 0, brandName: itemBrandName, typeId: 0, typeName: "Goi\(index + 1)", sku: itemCodeBH2, price: 0, priceMarket: 0, priceBeforeTax: 0, iconUrl: "", imageUrl: "", promotion: "", includeInfo: "", hightlightsDes: "", labelName: "", urlLabelPicture: "", isRecurring: false, manSerNum: "", bonusScopeBoom: "", qlSerial: "", inventory: 0, LableProduct: "", p_matkinh: "", ecomColorValue: "", ecomColorName: "", ecom_itemname_web: "", price_special: 0, price_online_pos: 0, price_online: 0, hotSticker: false, is_NK: false, is_ExtendedWar: false, skuBH: [], nameBH: [],brandGoiBH:[], isPickGoiBH: "Picked", amountGoiBH: "true", itemCodeGoiBH: itemCodeBH2, itemNameGoiBH: itemNameBH2 ,priceSauKM: 0,role2: itemRoleBH2)

					let cart2 = Cart(sku: itemCodeBH2, product: pro2,quantity: 1,color:"#ffffff",inStock:-1, imei: "N/A",price: 0, priceBT: 0, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")

					switch index {
						case 0:
							if  Cache.carts[item.indexPath + countUpInsert ].product.typeName == "Goi1" {
								Cache.carts[item.indexPath + countUpInsert ] = cart2
								Cache.carts[item.indexPath + countUpInsert ].product.amountGoiBH = "1"

							}else {
								Cache.carts[item.indexPath + countUpInsert - 1].product.amountGoiBH = "1"
								Cache.carts.insert(cart2, at: item.indexPath + countUpInsert)
								countUpInsert += 1
							}
						case 1:
							if  Cache.carts[item.indexPath + countUpInsert - index].product.typeName == "Goi2" {
								Cache.carts[item.indexPath + countUpInsert - index] = cart2
								Cache.carts[item.indexPath + countUpInsert - index].product.amountGoiBH = "2"
							}else {
								Cache.carts[item.indexPath + countUpInsert - index - 1].product.amountGoiBH = "2"
								Cache.carts.insert(cart2, at: item.indexPath + countUpInsert )
								countUpInsert += 1
							}
						default:
							return
					}


				}
			}
		}
		countUpInsert = 0
		var count:Int = 0
		for (index,item) in Cache.carts.enumerated() {

			if item.product.isPickGoiBH == "isPick" && item.product.itemCodeGoiBH == "" {
				if index == 1 {
					for item in GoiBHInsertAt.listInsert{
						item.indexPath -= 1
						break
					}
				}
					//xoa goi bh chua pick
				Cache.carts.remove(at: index + count)
				count -= 1
			}

		}

		count = 0
		GoiBHInsertAt.listInsert.removeAll()
		navigationController?.popViewController(animated: true)
	}
    
 
    @objc func updateTotalNotification(notification:Notification) -> Void {
        print("Catch notification")
        tableView.reloadData()
        //        updateTotal()
        
    }
    func updateTotal(){
        var sum: Float = 0
        for item in Cache.carts {
            sum = sum + Float(item.quantity) * item.product.price
        }
        
    }
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
		if self.isCartMirae {
			return Cache.cartsMirae.count
		}else {
			return itemsMenu.count
		}
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemBuyExtendedCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemBuyExtendedCell")
        var item:Cart?
        //height Collectionview
		if isCartMirae {
			item = Cache.cartsMirae[indexPath.row]
			var heightClv:CGFloat = 0
			if item?.product.is_ExtendedWar ?? false && item?.product.amountGoiBH == ""{
				if Cache.cartsMirae[indexPath.row].product.isPickGoiBH == "isPick" {
					let heightClview = item?.product.skuBH.count
					if heightClview == 1 || heightClview == 2 {
						heightClv =  Common.heightWidthCLV + 2
					}
					else {
						if ((heightClview ?? 0) / 2 != 0 && (heightClview ?? 0) % 2 != 0) {
							heightClv = CGFloat((((heightClview ?? 0) / 2) + 1)) * Common.heightWidthCLV
						}else {
							heightClv = CGFloat(((heightClview ?? 0) / 2)) * Common.heightWidthCLV
						}
					}
				}
			}
			cell.setup(cart: Cache.cartsMirae[indexPath.row] ,pos:indexPath.row,heightClv:heightClv,isCartMirae:true)
			cell.selectionStyle = .none
			cell.viewController = self
			return cell
		}else {
			item = itemsMenu.object(at: indexPath.row) as? Cart
			var heightClv:CGFloat = 0
			if item?.product.is_ExtendedWar ?? false && item?.product.amountGoiBH == ""{
				if Cache.carts[indexPath.row].product.isPickGoiBH == "isPick" {
					let heightClview = item?.product.skuBH.count
					if heightClview == 1 || heightClview == 2 {
						heightClv =  Common.heightWidthCLV + 2
					}
					else {
						if ((heightClview ?? 0) / 2 != 0 && (heightClview ?? 0) % 2 != 0) {
							heightClv = CGFloat((((heightClview ?? 0) / 2) + 1)) * Common.heightWidthCLV
						}else {
							heightClv = CGFloat(((heightClview ?? 0) / 2)) * Common.heightWidthCLV
						}
					}
				}
			}
			cell.setup(cart: itemsMenu[indexPath.row] as! Cart,pos:indexPath.row,heightClv:heightClv, isCartMirae: false)
			cell.selectionStyle = .none
			cell.viewController = self
			return cell
		}

	}

	var data :[Cart] = []
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
		if isCartMirae {
			//FIXME: tính lại height
			let item:Cart = itemsMenu.object(at: indexPath.row) as! Cart
				//co ban goi bh
			if item.replacementAccessoriesLabel == "" {
				if item.product.is_ExtendedWar {
					if Cache.cartsMirae[indexPath.row].product.isPickGoiBH == "isPick" {
						let heightClv = item.product.skuBH.count
						if heightClv == 1 || heightClv == 2 {
							return Common.heightWidthCLV + 30
						}else {
							let newHeight = heightClv / 2
							if heightClv % 2 == 0 {
								return (Common.heightWidthCLV * CGFloat(newHeight)) + CGFloat((heightClv * 10)) + 10
							}else {
								return Common.heightWidthCLV + (Common.heightWidthCLV * CGFloat(newHeight)) + CGFloat((heightClv * 10)) + 10
							}

						}
					}else {
						return Common.Size(s:CGFloat( 140))
					}
				}
				else {
					return Common.Size(s: 140)
				}}
			return Common.Size(s: 160)
		}else {
			let item:Cart = itemsMenu.object(at: indexPath.row) as! Cart
				//co ban goi bh
			if item.replacementAccessoriesLabel == "" {
				if item.product.is_ExtendedWar {
					if Cache.carts[indexPath.row].product.isPickGoiBH == "isPick" {
						let heightClv = item.product.skuBH.count
						if heightClv == 1 || heightClv == 2 {
							return Common.heightWidthCLV + 30
						}else {
							let newHeight = heightClv / 2
							if heightClv % 2 == 0 {
								return (Common.heightWidthCLV * CGFloat(newHeight)) + CGFloat((heightClv * 10)) + 10
							}else {
								return Common.heightWidthCLV + (Common.heightWidthCLV * CGFloat(newHeight)) + CGFloat((heightClv * 10)) + 10
							}

						}
					}else {
						return Common.Size(s:CGFloat( 140))
					}
				}
				else {
					return Common.Size(s: 140)
				}}
			return Common.Size(s: 160)
		}
		return Common.Size(s: 160)
	}
}

// MARK: - UICollectionViewDataSource
extension ItemBuyExtendedCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataRow?.product.skuBH.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let newData:[String] = dataRow[indexPath.row] as! [String]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemBaoHanhnCollectionViewCell", for: indexPath) as! itemBaoHanhnCollectionViewCell
        cell.setupCell(dataMaSp: (dataRow!.product.skuBH[indexPath.row] ),dataNameSP: (dataRow!.product.nameBH[indexPath.row] ),brand:dataRow!.product.brandGoiBH[indexPath.row] )
        return cell
    }
  
}

// MARK: - UICollectionViewDelegate
extension ItemBuyExtendedCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		
        if self.lastIndexActive != indexPath {
            if itemIselected.count < 2 {
                let cell = collectionView.cellForItem(at: indexPath) as! itemBaoHanhnCollectionViewCell
                cell.imageCheck.image = UIImage(named: "check-1")
                itemIselected.append(indexPath)
                //print("\(itemIselected)" + "lastIndexActive1")
            }
            else if itemIselected.count == 2{
                let cell = collectionView.cellForItem(at: indexPath) as! itemBaoHanhnCollectionViewCell
                cell.imageCheck.image = UIImage(named: "check-1")
                itemIselected.append(indexPath)
                
                let cell1 = collectionView.cellForItem(at: self.itemIselected[0]) as? itemBaoHanhnCollectionViewCell
                cell1?.imageCheck.image = UIImage(named: "check-2")
                cell1?.imageCheck.layer.masksToBounds = true
                itemIselected.remove(at: 0)
                if itemIselected.count == 2 && lastIndexActive.row == indexPath.row && indexPath.row == itemIselected[1].row {
                    itemIselected.remove(at: 1)
                    itemIselected.append(indexPath)
                }
                //                print("\(itemIselected)" + "lastIndexActive2")
                self.lastIndexActive = itemIselected[0]
                //                print("\(itemIselected)" + "lastIndexActive3")
                var value:[IndexPath] = []
                for item in itemIselected {
                    value.append(item)
                }
                if value.count == 2 {
                    if value[0] == value[1] {
                        itemIselected.remove(at: 0)
                    }
                }
            }
        }
        //        print("\(itemIselected)" + "lastIndexActive4")
        
        
        if itemIselected.count == 2 {
            //xét các trường jợp được mua
            guard let viewController = viewController else { return }
            let valuebrand1:String = (dataRow!.product.brandGoiBH[itemIselected[0].row] )
            let valuebrand2:String = (dataRow!.product.brandGoiBH[itemIselected[1].row] )
            
            let valueRole1:String = (dataRow!.product.role2[itemIselected[0].row] )
            let valueRole2:String = (dataRow!.product.role2[itemIselected[1].row] )
            //chỉ mua được samsung
            if valueRole1 == "2" && valueRole2 == "2"  && indexPath != lastIndexActive{
                let cell = collectionView.cellForItem(at: self.itemIselected[0]) as! itemBaoHanhnCollectionViewCell
                cell.imageCheck.image = UIImage(named: "check-2")
                cell.imageCheck.layer.masksToBounds = true
                let cell2 = collectionView.cellForItem(at: self.itemIselected[1]) as! itemBaoHanhnCollectionViewCell
                cell2.imageCheck.image = UIImage(named: "check-2")
                cell2.imageCheck.layer.masksToBounds = true
                itemIselected.removeAll()
                GoiBHInsertAt.listInsert.removeAll()
                lastIndexActive = [1 ,0]
                let alert = UIAlertController(title: "Thông báo", message: "Không được mua 2 gói bảo hành vàng cùng lúc.Vui lòng chọn lại gói bảo hành", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                    
                }))
                
                // show the alert
                viewController.present(alert, animated: true)
                
            }
            if valuebrand1 == "2" && valuebrand2 == "2"{
                let cell = collectionView.cellForItem(at: self.itemIselected[0]) as! itemBaoHanhnCollectionViewCell
                cell.imageCheck.image = UIImage(named: "check-2")
                cell.imageCheck.layer.masksToBounds = true
                let cell2 = collectionView.cellForItem(at: self.itemIselected[1]) as! itemBaoHanhnCollectionViewCell
                cell2.imageCheck.image = UIImage(named: "check-2")
                cell2.imageCheck.layer.masksToBounds = true
                itemIselected.removeAll()
                lastIndexActive = [1 ,0]
                GoiBHInsertAt.listInsert.removeAll()
                let alert = UIAlertController(title: "Thông báo", message: "Bạn chỉ có thể mua được 1 gói bảo hành Sam Sung.Vui lòng chọn lại gói bảo hành", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in }))
                
                // show the alert
                viewController.present(alert, animated: true)

            }
            
            if valuebrand1 != valuebrand2{
                let cell = collectionView.cellForItem(at: self.itemIselected[0]) as! itemBaoHanhnCollectionViewCell
                cell.imageCheck.image = UIImage(named: "check-2")
                cell.imageCheck.layer.masksToBounds = true
                let cell2 = collectionView.cellForItem(at: self.itemIselected[1]) as! itemBaoHanhnCollectionViewCell
                cell2.imageCheck.image = UIImage(named: "check-2")
                cell2.imageCheck.layer.masksToBounds = true
                itemIselected.removeAll()
                GoiBHInsertAt.listInsert.removeAll()
                lastIndexActive = [1 ,0]
                let alert = UIAlertController(title: "Thông báo", message: "Bạn không thể mua 2 gói bảo hành Boltech và Sam Sung cùng lúc.Vui lòng chọn lại gói bảo hành", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in }))
                
                // show the alert
                viewController.present(alert, animated: true)
            }
            
        }
#if DEBUG
        print("item selected \(itemIselected)")
#endif
        
        
        //xac dinh xem da chon goi bh nao cho handleback
        if GoiBHInsertAt.listInsert.count == 0 {
            let item = ItemInsertGoiBH(indexPath: indexPathCart, arrIndex: itemIselected)
            GoiBHInsertAt.listInsert.append(item)
        }else {
            
            var isReplace:Bool = false
            for item in GoiBHInsertAt.listInsert{
                if item.indexPath == indexPathCart {
                    item.arrInndex = itemIselected
                    isReplace = true
                    break
                }
            }
            if isReplace {
                
            }else {
                isReplace = true
                let item = ItemInsertGoiBH(indexPath: indexPathCart, arrIndex: itemIselected)
                GoiBHInsertAt.listInsert.append(item)
            }
            
            
        }
        
        
    }
}
