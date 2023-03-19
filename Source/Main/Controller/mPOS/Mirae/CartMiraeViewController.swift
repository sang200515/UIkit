//
//  CartMiraeViewController.swift
//  fptshop
//
//  Created by tan on 5/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import PopupDialog
import ActionSheetPicker_3_0
class CartMiraeViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView  =   UITableView()
    var itemsMenu: [Cart] = []
    var lbTotalValue: UILabel!
    var promotionsMirae: [String:NSMutableArray] = [:]
    var groupMirae: [String]!
	private var listMaSpBH:[String] = []
	private var listNameSpBH:[String] = []
	private var listbrand:[String] = []
	private var listRole:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Giỏ hàng"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(CartMiraeViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        let btSearchIcon = UIButton.init(type: .custom)
        btSearchIcon.setImage(#imageLiteral(resourceName: "search-booksim"), for: UIControl.State.normal)
        btSearchIcon.imageView?.contentMode = .scaleAspectFit
        btSearchIcon.addTarget(self, action: #selector(CartMiraeViewController.actionSearchProduct), for: UIControl.Event.touchUpInside)
        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
        let barSearch = UIBarButtonItem(customView: btSearchIcon)
        self.navigationItem.rightBarButtonItems = [barSearch]
        
        groupMirae = [String]()
        let sum = Cache.cartsMirae.count
        if(sum > 0){
            
            let btDeleteIcon = UIButton.init(type: .custom)
            btDeleteIcon.setImage(#imageLiteral(resourceName: "Delete"), for: UIControl.State.normal)
            btDeleteIcon.imageView?.contentMode = .scaleAspectFit
            btDeleteIcon.addTarget(self, action: #selector(CartMiraeViewController.actionDelete), for: UIControl.Event.touchUpInside)
            btDeleteIcon.frame = CGRect(x: 0, y: 0, width: 40, height: 25)
            let barDelete = UIBarButtonItem(customView: btDeleteIcon)
            self.navigationItem.rightBarButtonItems = [barSearch,barDelete]
            
            
            itemsMenu = []
            itemsMenu = Cache.cartsMirae
            tableView.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(ItemCartMiraeTableViewCell.self, forCellReuseIdentifier: "ItemCartMiraeTableViewCell")
            tableView.tableFooterView = UIView()
            tableView.backgroundColor = UIColor.white
            self.view.addSubview(tableView)
            navigationController?.navigationBar.isTranslucent = false
            let footer = UIView()
            footer.frame = CGRect(x: 0, y:self.view.frame.size.height - Common.Size(s:44) - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height), width: self.view.frame.size.width, height: Common.Size(s:44))
            footer.backgroundColor = UIColor(netHex:0x47B054)
            self.view.addSubview(footer)
            // - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
            
            let footerTotal = UIView()
            footerTotal.frame = CGRect(x: 0, y:0, width: footer.frame.size.width * 6.5/10, height: footer.frame.size.height)
            footer.addSubview(footerTotal)
            
            let totalText = "Tổng tiền thanh toán"
            let sizeLbTotal: CGSize = totalText.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:14))])
            let lbTotal = UILabel(frame: CGRect(x: 0, y: Common.Size(s:5), width: footerTotal.frame.size.width, height: sizeLbTotal.height))
            lbTotal.textAlignment = .center
            lbTotal.textColor = UIColor.white
            lbTotal.font = UIFont.systemFont(ofSize: Common.Size(s:14))
            lbTotal.text = totalText
            footerTotal.addSubview(lbTotal)
            
            lbTotalValue = UILabel(frame: CGRect(x: 0, y: lbTotal.frame.origin.y + lbTotal.frame.size.height, width: footerTotal.frame.size.width, height: footerTotal.frame.size.height - (lbTotal.frame.origin.y + lbTotal.frame.size.height)))
            lbTotalValue.textAlignment = .center
            lbTotalValue.textColor = UIColor(netHex:0xEF4A40)
            lbTotalValue.font = UIFont.boldSystemFont(ofSize: 20)
            footerTotal.addSubview(lbTotalValue)
            updateTotal()
            
            let footerLine = UIView()
            footerLine.frame = CGRect(x: footerTotal.frame.origin.x + footerTotal.frame.size.width, y:footer.frame.size.height * 2/10, width: 1, height: footer.frame.size.height * 6/10)
            footerLine.backgroundColor = .white
            footer.addSubview(footerLine)
            
            let footerPay = UIView()
            footerPay.frame = CGRect(x: footerTotal.frame.origin.x + footerTotal.frame.size.width, y:0, width: footer.frame.size.width - (footerTotal.frame.origin.x + footerTotal.frame.size.width), height: footer.frame.size.height)
            footerPay.backgroundColor = UIColor(netHex:0xEF4A40)
            footer.addSubview(footerPay)
            
            let lbPay = UILabel(frame: CGRect(x: 0, y: 0, width: footerPay.frame.size.width, height: footerPay.frame.size.height))
            lbPay.textAlignment = .center
            lbPay.textColor = UIColor.white
            lbPay.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
            lbPay.text = "Tiếp tục"
            footerPay.addSubview(lbPay)
            
            let payAction = UITapGestureRecognizer(target: self, action:  #selector (self.payAction (_:)))
            footerPay.addGestureRecognizer(payAction)
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
    @objc func actionOpenMenuLeft() {
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func actionSearchProduct(){
        let newViewController = SearchProductMiraeViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func actionDelete() {
        if(Cache.listDatCocMirae.count > 0){
            let alert = UIAlertController(title: "Thông báo", message: "Bạn không được xoá sản phẩm đặt cọc!!!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.present(alert, animated: true)
            return
        }
        print("actionDelete")
        
        // Prepare the popup
        let title = "XOÁ GIỎ HÀNG"
        let message = "Bạn muốn xoá TẤT CẢ sản phẩm hiện có trong giỏ hàng?"
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        
        // Create first button
        let buttonOne = CancelButton(title: "Huỷ bỏ") {
            
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "Xoá tất cả") {
            Cache.cartsMirae.removeAll()
            
            Cache.itemsPromotionMirae.removeAll()
            Cache.cartsMirae = []
            _ = self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: true, completion: nil)
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func payAction(_ sender:UITapGestureRecognizer){
        

        //        if(Cache.typeOrder == "09"){
        //        }else{
        //            let newViewController = PaymentPayDirectlyFFriendViewController()
        //            self.navigationController?.pushViewController(newViewController, animated: true)
        //        }


		let indexCart = Cache.cartsMirae.count - 1
		var listItemInsert:[Int] = []
		for(index,item) in Cache.cartsMirae.enumerated(){
			if item.product.is_ExtendedWar {
				if item.product.amountGoiBH == "" {
					listItemInsert.append(index)
				}
			}
		}
		if listItemInsert.count > 0 {
			for index in listItemInsert {
				let listMaGoiBH = Cache.cartsMirae[index].product.skuBH
				let listNameGoiBH = Cache.cartsMirae[index].product.nameBH
				let listbrandGoiBH = Cache.cartsMirae[index].product.brandGoiBH
				let listRoleGoiBH = Cache.cartsMirae[index].product.role2
					//bat buoc mua goi bh
				let alert = UIAlertController(title: "Thông báo", message: "Khách hàng có đồng ý mua sản phẩm bảo hành không?", preferredStyle: .alert)
				let ok = UIAlertAction(title: "Có", style: .default, handler: { action in
					let pro2 = Product(model_id: "", id: 0, name: "", brandID: 0, brandName: "", typeId: 0, typeName: "", sku: "", price: 0, priceMarket: 0, priceBeforeTax: 0, iconUrl: "", imageUrl: "", promotion: "", includeInfo: "", hightlightsDes: "", labelName: "", urlLabelPicture: "", isRecurring: false, manSerNum: "", bonusScopeBoom: "", qlSerial: "", inventory: 0, LableProduct: "", p_matkinh: "", ecomColorValue: "", ecomColorName: "", ecom_itemname_web: "", price_special: 0, price_online_pos: 0, price_online: 0, hotSticker: false, is_NK: false, is_ExtendedWar: true, skuBH: listMaGoiBH, nameBH: listNameGoiBH,brandGoiBH:listbrandGoiBH, isPickGoiBH: "isPick", amountGoiBH: "", itemCodeGoiBH: "", itemNameGoiBH: "" ,priceSauKM: 0,role2: listRoleGoiBH)

					let cart2 = Cart(sku: Cache.cartsMirae[index].sku, product: pro2,quantity: 1,color:"#ffffff",inStock:-1, imei: "N/A",price: 0, priceBT: 0, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")

					var countUp:Int = 0


					if index == 0 {
						Cache.cartsMirae.insert(cart2, at: index + 1 + countUp)
						countUp += 1
					}else {
						Cache.cartsMirae.insert(cart2, at: index + 1 + countUp)
						countUp += 1
					}
					countUp = 0
					listItemInsert.removeAll()
					let vc = BuyExtendWarViewController()
					vc.isCartMirae = true
					self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
					self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
					listItemInsert = []
					self.navigationController?.pushViewController(vc, animated: true)
				})
				let cancel = UIAlertAction(title: "Không", style: .destructive, handler: { action in
					self.resetCart()
				})
				alert.addAction(cancel)
				alert.addAction(ok)
				self.present(alert, animated: true)
				break



			}
		}else if Cache.cartsMirae[indexCart].product.is_ExtendedWar == false || Cache.cartsMirae[indexCart].product.amountGoiBH == "true"  {
			self.resetCart()

		}else {
			self.resetCart()

		}
        
    }
	private func resetCart(){
		Cache.promotionsMirae.removeAll()
		Cache.groupMirae = []
		Cache.itemsPromotionMirae.removeAll()
		self.promotionsMirae.removeAll()
		self.groupMirae.removeAll()
			//FIXME: làm bảo hành từ đây
		if ShinhanData.IS_RUNNING {
			let vc = DetailShinhanOrder()
			vc.type = .detailCreate
			self.navigationController?.pushViewController(vc, animated: true)
		} else {
			let vc = ThongTinDonHangMiraeRouter().configureVIPERThongTinDonHangMirae()
			self.navigationController?.pushViewController(vc, animated: true)
				//            let newViewController = PaymentMiraeViewController()
				//            self.navigationController?.pushViewController(newViewController, animated: true)
		}
	}
    func popupDelete() {
        // Prepare the popup
        let title = "HẾT HÀNG"
        let message = "Bạn muốn xoá các sản phẩm hết hàng?"
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        
        // Create first button
        let buttonOne = CancelButton(title: "Trở lại") {
            
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "Xoá") {
            var ide = -1
            for item2 in Cache.cartsMirae{
                ide = ide + 1
                if(item2.inStock == 0){
                    Cache.cartsMirae.remove(at: ide)
                }
            }
            self.tableView.reloadData()
            self.updateTotal()
            if (Cache.cartsMirae.count <= 0){
                Cache.cartsMirae.removeAll()
                Cache.itemsPromotionMirae.removeAll()
                Cache.cartsMirae = []
                _ = self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //notification center
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(updateTotalNotification), name: Notification.Name("updateTotal"), object: nil)
		itemsMenu = Cache.cartsMirae
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
        for item in Cache.cartsMirae {
            sum = sum + Float(item.quantity) * item.product.price
        }
        lbTotalValue.text = Common.convertCurrencyFloat(value: sum)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Cache.cartsMirae.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemCartMiraeTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemCartMiraeTableViewCell")
        let item:Cart = Cache.cartsMirae[indexPath.row]
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
            let item:Cart = Cache.cartsMirae[indexPath.row]
            var checkDatCoc:Bool = false
            if(Cache.listDatCocMirae.count > 0){
                for itemDatCoc in Cache.listDatCocMirae{
                    if(itemDatCoc.sku == item.sku){
                        checkDatCoc = true
                    }
                }
            }
            if(checkDatCoc == true){
                let alert = UIAlertController(title: "Thông báo", message: "Bạn không được xoá sản phẩm đặt cọc!!!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    
                })
                self.present(alert, animated: true)
            }else{
                
                // handle delete (by removing the data from your array and updating the tableview)
//                Cache.cartsMirae.remove(at: indexPath.row)
//                itemsMenu.remove(at: indexPath.row)
				if Cache.cartsMirae[indexPath.row].product.amountGoiBH == "1" &&  Cache.cartsMirae.count > 1{
					GoiBHInsertAt.listInsert.removeAll()
					Cache.cartsMirae.remove(at: indexPath.row + 1)
					Cache.cartsMirae.remove(at: indexPath.row)
				} else if Cache.cartsMirae[indexPath.row].product.amountGoiBH == "2" {
					GoiBHInsertAt.listInsert.removeAll()
					Cache.cartsMirae.remove(at: indexPath.row + 2)
					Cache.cartsMirae.remove(at: indexPath.row + 1)
					Cache.cartsMirae.remove(at: indexPath.row)
				}else if Cache.cartsMirae[indexPath.row].product.typeName == "Goi2"  {
					Cache.cartsMirae[indexPath.row - 2].product.amountGoiBH = "1"
					Cache.cartsMirae.remove(at: indexPath.row)
					GoiBHInsertAt.listInsert.removeAll()
				}
				else if Cache.cartsMirae[indexPath.row].product.typeName == "Goi1"{
					if Cache.cartsMirae[indexPath.row - 1].product.amountGoiBH == "2" {
						GoiBHInsertAt.listInsert.removeAll()
						Cache.cartsMirae[indexPath.row - 1].product.amountGoiBH = "1"
						Cache.cartsMirae[indexPath.row + 1].product.typeName = "Goi1"
						Cache.cartsMirae.remove(at: indexPath.row)
					}
					else {
						Cache.cartsMirae[indexPath.row - 1].product.amountGoiBH = ""
						Cache.cartsMirae.remove(at: indexPath.row)
					}
				} else {
					Cache.cartsMirae.remove(at: indexPath.row)

				}
                tableView.reloadData()
                //            tableView.deleteRows(at: [indexPath], with: .fade)
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name("updateTotal"), object: nil)
                
                if (Cache.cartsMirae.count <= 0){
                    Cache.cartsMirae.removeAll()
                    Cache.itemsPromotionMirae.removeAll()
                    Cache.cartsMirae = []
                    _ = self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            }
      
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:100);
    }
    
}
class ItemCartMiraeTableViewCell: UITableViewCell {
    
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
        title.textColor = UIColor.gray
        title.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(title)
        
        price = UILabel()
        price.textColor = UIColor(netHex:0xEF4A40)
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        contentView.addSubview(price)
        
        control = UIView()
        contentView.addSubview(control)
        
        iconMinus = UIImageView()
        iconMinus.contentMode = UIView.ContentMode.scaleAspectFit
        iconMinus.image = #imageLiteral(resourceName: "Minus")
        
        control.addSubview(iconMinus)
        iconPlus = UIImageView()
        iconPlus.contentMode = UIView.ContentMode.scaleAspectFit
        iconPlus.image = #imageLiteral(resourceName: "Plus")
        control.addSubview(iconPlus)
        
        quantity = UILabel()
        quantity.textColor = UIColor(netHex:0x47B054)
        quantity.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        quantity.textAlignment = .center
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
    
    
    func setup(cart:Cart,pos:Int){
        
        let nameProduc = "\(cart.product.sku)-\(cart.product.name)"
        let sizeTitle = nameProduc.height(withConstrainedWidth: UIScreen.main.bounds.size.width - (iconImage.frame.origin.x + iconImage.frame.size.width + Common.Size(s:12)), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
        
        title.frame = CGRect(x:iconImage.frame.origin.x + iconImage.frame.size.width + Common.Size(s:10),y:iconImage.frame.origin.y + Common.Size(s:5) ,width: UIScreen.main.bounds.size.width - (iconImage.frame.origin.x + iconImage.frame.size.width + Common.Size(s:12)) ,height: sizeTitle)
        title.text = nameProduc
        title.numberOfLines = 2
        title.sizeToFit()
        
		if  cart.product.hotSticker{
			let hotSticker = UIImageView()
			iconImage.addSubview(hotSticker)
			hotSticker.image = UIImage(named: "ic_hot3")
			hotSticker.snp.makeConstraints { make in
				make.left.equalToSuperview()
				make.bottom.equalToSuperview()
//				make.width.equalTo((iconImage.frame.size.width * 0.5))
				
			}

		}
		if cart.product.amountGoiBH == "true" && cart.product.is_ExtendedWar == false{
			if cart.product.brandName == "1" {
				iconImage.image = UIImage(named: "icbaohanh")
			} else if cart.product.brandName == "2" {
				iconImage.image = UIImage(named: "icBoltech")
			}
		}
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        if(cart.product.iconUrl != ""){
            if let escapedString = "\(cart.product.iconUrl)".addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                print(escapedString)
                let url = URL(string: "\(escapedString)")!
                iconImage.kf.setImage(with: url,
                                      placeholder: nil,
                                      options: [.transition(.fade(1))],
                                      progressBlock: nil,
                                      completionHandler: nil)
            }
        }
      
        
        
        let priceValue = cart.product.price * Float(cart.quantity)
        let priceText = Common.convertCurrencyFloat(value: priceValue)
        price.text = priceText
        
        price.frame = CGRect(x:title.frame.origin.x,y:title.frame.origin.y + title.frame.size.height,width: title.frame.size.width  ,height: priceText.height(withConstrainedWidth: title.frame.size.width, font: UIFont.boldSystemFont(ofSize: Common.Size(s:18))))
        
        control.frame = CGRect(x: price.frame.origin.x, y: Common.Size(s:100) - Common.Size(s:30), width:  UIScreen.main.bounds.size.width - (iconImage.frame.origin.x + iconImage.frame.size.width + Common.Size(s:12)), height: Common.Size(s:25))
        
        if (cart.product.qlSerial == "N"){
            
            iconMinus.frame =  CGRect(x: 0, y: 0, width: control.frame.size.height, height: control.frame.size.height)
            
            quantity.frame = CGRect(x: iconMinus.frame.origin.x + iconMinus.frame.size.width + Common.Size(s:5), y: iconMinus.frame.origin.y, width: iconMinus.frame.size.width, height: control.frame.size.height)
            
            quantity.text = "\(cart.quantity)"
            
            iconPlus.frame =  CGRect(x: quantity.frame.origin.x + quantity.frame.size.width + Common.Size(s:5), y: iconMinus.frame.origin.y, width: iconMinus.frame.size.width, height: iconMinus.frame.size.height)
            
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
        let quantityValue = Cache.cartsMirae[pos].quantity
        if (quantityValue > 1){
            Cache.cartsMirae[pos].quantity = quantityValue - 1
            let item = Cache.cartsMirae[pos]
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
        let quantityValue = Cache.cartsMirae[pos].quantity
        Cache.cartsMirae[pos].quantity = quantityValue + 1
        let item = Cache.cartsMirae[pos]
        quantity.text = "\(item.quantity)"
        let priceValue = item.product.price * Float(item.quantity)
        let priceText = Common.convertCurrencyFloat(value: priceValue)
        price.text = priceText
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("updateTotal"), object: nil)
        
    }
    
}
