//
//  FindDepositVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 09/02/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class FindDepositVC: BaseController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTxt: CustomTxt!
	private var listMaSpBH:[String] = []
	private var listNameSpBH:[String] = []
	private var listbrand:[String] = []
	private var listRole:[String] = []
    var dataDeposit: ShinhanChemeData?
    var listCart:[Cart] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerTableCell(ShinhanDepositCell.self)
    }
    
    func loadListInstallMent(mpos: String,docEntry:String) {
        self.showLoading()
        Provider.shared.shinhan.loadSchemeList(mposNum: mpos, docEntry: docEntry) { [weak self] result in
            self?.stopLoading()
            guard let self = self else {return}
            if result?.data?.status.first?.p_status == 1 {
                self.dataDeposit = result?.data
                self.tableView.reloadData()
            } else if result?.success == false {
                self.showAlert(result?.message ?? "")
            } else if result?.data?.status.first?.p_status == 0 {
                self.showAlert(result?.data?.status.first?.p_messagess ?? "")
            }
        } failure: { [weak self] error in
            self?.stopLoading()
            guard let self = self else {return}
            self.showAlert(error.localizedDescription)
        }

    }
    
    
    @IBAction func bypassAction(_ sender: Any) {
        let newViewController = SearchProductMiraeViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
//		ShinhanData.docEntry = 0
        Cache.infoCustomerMirae?.pre_docentry = "0"
        Cache.listDatCocMirae = []
        Cache.soTienCocMirae = 0
        Cache.itemsPromotionTempMirae.removeAll()
        Cache.cartsMirae.removeAll()
        Cache.listVoucherMirae = []
        ShinhanData.soMpos = ""
		ShinhanData.newDocEntry = 0
		ShinhanData.sotiencoc = 0
    }
    
    @IBAction func search(_ sender: Any) {
        self.view.endEditing(true)
        if searchTxt.text != "" {
            self.loadListInstallMent(mpos: searchTxt.text, docEntry: "\(ShinhanData.docEntry)")
        } else {
            self.showAlert("Vui lòng nhập số điện thoại hoặc số đơn hàng đặt cọc!")
        }
    }
}

extension FindDepositVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDeposit != nil ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(ShinhanDepositCell.self)
        if let header = dataDeposit?.header {
            guard indexPath.row < header.count else { return UITableViewCell() }
            cell.bindCell(details: dataDeposit?.details ?? [], header: header[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Cache.infoCustomerMirae?.pre_docentry = "\(dataDeposit?.header.first?.sOMPOS ?? 0)"
        Cache.soTienCocMirae = Float(dataDeposit?.header.first?.soTienCoc ?? 0)
//		ShinhanData.docEntry = dataDeposit?.header.first?.sOMPOS ?? 0
        ShinhanData.soMpos = "\(dataDeposit?.header.first?.sOMPOS ?? 0)"
		ShinhanData.newDocEntry = dataDeposit?.header.first?.sOMPOS ?? 0
        listCart.removeAll()
        for item in dataDeposit?.details ?? []{
            let pro = Product(model_id:"",id: item.iD, name: item.itemName, brandID: item.brandID, brandName: "", typeId: 0, typeName: "", sku: item.itemCode, price: Float(item.price), priceMarket: Float(item.priceMarket), priceBeforeTax: Float(item.priceBeforeTax), iconUrl: item.linkAnh, imageUrl: item.iconUrl, promotion: "", includeInfo: item.includeInfo, hightlightsDes: item.hightlightsDes, labelName: item.labelName, urlLabelPicture: item.iconUrl, isRecurring: false, manSerNum: item.manSerNum, bonusScopeBoom: item.bonusScopeBoom, qlSerial: item.qlSerial,inventory: item.inventory, LableProduct: item.lableProduct,p_matkinh:"",ecomColorValue:"",ecomColorName:"", ecom_itemname_web: "",price_special:0,price_online_pos: 0, price_online: 0, hotSticker: false, is_NK: false,is_ExtendedWar:false,skuBH:[],nameBH:[],brandGoiBH:[],isPickGoiBH:"",amountGoiBH:"",itemCodeGoiBH:"",itemNameGoiBH:"",priceSauKM: 0,role2:[])
            let cart = Cart(sku: item.itemCode, product: pro,quantity: 1,color:"",inStock: -1, imei: "",price: Float(item.price), priceBT: Float(item.priceBeforeTax), whsCode: "", discount: 0, reason: "", note: "", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")

            self.listCart.append(cart)
        }
        
        Cache.promotionsMirae.removeAll()
        Cache.groupMirae = []
        Cache.itemsPromotionMirae.removeAll()
        Cache.cartsMirae = self.listCart
        Cache.listDatCocMirae = self.listCart
//        ShinhanData.tientraTruoc = Float(dataDeposit?.header.first?.soTienCoc ?? 0)
        ShinhanData.sotiencoc = Float(dataDeposit?.header.first?.soTienCoc ?? 0)
		self.fetchMaSpBHBySku()
    }
	private func canBuyWarrenty(model_id:String,sku:String) {
		ProgressView.shared.show()
		ProductAPIManager.product_detais_by_model_id(model_id: model_id, sku: sku,handler: {[weak self] (success , error) in
			ProgressView.shared.hide()
			guard let self = self,let cart = success.first else {return}
			if(success.count > 0){
				let newViewController = CartMiraeViewController()
				if cart.product.is_ExtendedWar  {
					guard let cart = Cache.cartsMirae.first else { return }
					cart.product.skuBH = self.listMaSpBH
					cart.product.nameBH = self.listNameSpBH
					cart.product.brandGoiBH = self.listbrand
					cart.product.role2 = self.listRole
					cart.product.is_ExtendedWar = true

				}else {
					self.showAlert("Lỗi")
				}

				self.navigationController?.pushViewController(newViewController, animated: true)
			}else{
				let when = DispatchTime.now() + 0.5
				DispatchQueue.main.asyncAfter(deadline: when) {

					self.showAlert("Lấy chi tiết sản phẩm thất bại")
				}
			}
		})
	}
	private func fetchMaSpBHBySku(){
		if  Cache.cartsMirae.count == 0 {
			self.listMaSpBH = []
			self.listNameSpBH = []
			self.listbrand = []
			self.listRole = []
		}
		ProductAPIManager.get_listSpBH_detais(sku:Cache.cartsMirae.first?.sku ?? "",handler: { [weak self](result , error) in
			guard let self = self else {return}
			if error == "" {
				var listMaSP:[String] = []
				var listNameSP:[String] = []
				var listbrandSP:[String] = []
				var listRoleSP:[String] = []
				for item in result {
					listMaSP.append(item.masp ?? "")
					listNameSP.append(item.nameSP ?? "")
					listbrandSP.append(item.brand ?? "")
					listRoleSP.append(item.role2 ?? "")
				}
				print("listRole \(listRoleSP)")
				self.listMaSpBH = listMaSP
				self.listNameSpBH = listNameSP
				self.listbrand = listbrandSP
				self.listRole = listRoleSP

				listMaSP.removeAll()
				listNameSP.removeAll()
				listbrandSP.removeAll()
				listRoleSP.removeAll()
				self.canBuyWarrenty(model_id:"\( Cache.cartsMirae.first?.product.id ?? 0)", sku: Cache.cartsMirae.first?.sku ?? "")
			}
		})
	}

}
