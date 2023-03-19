//
//  TimKiemDonHangHangMireaViewController.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class TimKiemDonHangHangMireaViewController: BaseVC<TimKiemDonHangMireaView> {
   
    //MARK:- Properties
    var presenter: TimKiemDonHangHangMireaPresenter?
	private var listMaSpBH:[String] = []
	private var listNameSpBH:[String] = []
	private var listbrand:[String] = []
	private var listRole:[String] = []

    //MARK:- Create ComponentUI
    

    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TÌM ĐƠN CỌC"
        self.configureButton()
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(self.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
    }
    
    @objc func actionBack() {
        for vc in self.navigationController?.viewControllers ?? [] {
            if vc is ListInstallentViewController {
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    
    deinit {
        print("Denit TimKiemDonHangHangMireaViewController is Success")
    }
    
    //MARK:- Configure
    private func configureButton(){
        self.mainView.tableView.dataSource = self
        self.mainView.tableView.delegate = self
        self.mainView.cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        self.mainView.searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
    }
    
    //MARK:- Actions
    @objc private func cancelTapped(){
        Cache.listDatCocMirae = []
        Cache.soTienCocMirae = 0
        Cache.itemsPromotionTempMirae.removeAll()
        Cache.cartsMirae.removeAll()
        Cache.listVoucherMirae = []
        Cache.infoKHMirae?.soTienTraTruoc = 0
        Cache.infoKHMirae?.soTienCoc = 0 
        let newViewController = SearchProductMiraeViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc private func searchTapped(){
        self.presenter?.timKiemDonHang(soPOS: self.mainView.searchText.textField.text ?? "")
    }
    
}

extension TimKiemDonHangHangMireaViewController : TimKiemDonHangHangMireaPresenterToViewProtocol {
    
    func didOutPutSuccess() {
        DispatchQueue.main.async {
            self.mainView.tableView.reloadData()
        }
    }
    
    func outPutFailed(error: String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo", message: error, titleButton: "Đồng ý", viewController: self) {
            
        }
    }
    
    func showLoading(message: String) {
        self.startLoading(message: message)
    }
    
    func hideLoading() {
        self.stopLoading()
    }
}

extension TimKiemDonHangHangMireaViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.model.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Common.TraGopMirae.identifierTableViewCell.timKiemDonHang, for: indexPath) as! TimKiemDonHangMireaTableViewCell
        cell.model = self.presenter?.model[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showLoading(message: "")
        guard let userCode = UserDefaults.standard.getUsernameEmployee() else {return}
        ApiRequestMirae.request(.loadChiTietDonHangCoc(userCode: userCode, shopCode: Cache.user?.ShopCode ?? "", partnerId: "\(PARTNERID)", appDocEntry: "\(Cache.infoKHMirae?.appDocEntry ?? 0)", soPOS: "\(self.presenter?.model[indexPath.row].soPos ?? 0)"), TimKiemDonHangHangMireaEntity.ChiTietDonHangCocModel.self) { [weak self] response in
			guard let self = self else { return }
            switch response {
            case .success(let modelData):
                if modelData.success == true {
                    if let model = modelData.data {
                        Cache.infoKHMirae?.soPOS = "\(model.header?.soPos ?? 0)"
                        Cache.infoKHMirae?.soMPOS = "\(model.header?.soMpos ?? 0)"
                        Cache.soTienCocMirae = Float(model.header?.soTienCoc ?? 0)
                        var modelCart:[Cart] = []
                        let pro = Product(model_id:"",
                                          id: model.details?.id ?? 0,
                                          name: model.details?.itemName ?? "",
                                          brandID:  model.details?.brandID ?? 0,
                                          brandName: "", typeId: 0,
                                          typeName: "",
                                          sku:  model.details?.itemCode ?? "",
                                          price: Float( model.details?.price ?? 0),
                                          priceMarket: Float( model.details?.priceMarket ?? 0),
                                          priceBeforeTax: Float( model.details?.priceBeforeTax ?? 0),
                                          iconUrl:  model.details?.linkAnh ?? "",
                                          imageUrl:  model.details?.iconURL ?? "",
                                          promotion: "",
                                          includeInfo:  model.details?.includeInfo ?? "",
                                          hightlightsDes:  model.details?.hightlightsDES ?? "",
                                          labelName:  model.details?.labelName ?? "",
                                          urlLabelPicture: model.details?.iconURL ?? "",
                                          isRecurring: false,
                                          manSerNum:  model.details?.manSerNum ?? "",
                                          bonusScopeBoom:  model.details?.bonusScopeBoom ?? "",
                                          qlSerial:  model.details?.qlSerial ?? "",inventory:  model.details?.inventory ?? 0, LableProduct:  model.details?.lableProduct ?? "",p_matkinh:"",ecomColorValue:"",ecomColorName:"", ecom_itemname_web: "",price_special:0,price_online_pos: 0, price_online: 0, hotSticker: false, is_NK: false,is_ExtendedWar:false,skuBH:[],nameBH:[],brandGoiBH:[],isPickGoiBH:"",amountGoiBH:"",itemCodeGoiBH:"",itemNameGoiBH:"",priceSauKM: 0,role2:[])
                        let cart = Cart(sku:  model.details?.itemCode ?? "", product: pro,quantity: 1,color:"",inStock: -1, imei: "",price: Float( model.details?.price ?? 0), priceBT: Float( model.details?.priceBeforeTax ?? 0), whsCode: "", discount: 0, reason: "", note: "", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")

                        modelCart.append(cart)
                        ShinhanData.IS_RUNNING = false
                        Cache.promotionsMirae.removeAll()
                        Cache.groupMirae = []
                        Cache.itemsPromotionMirae.removeAll()
                        Cache.cartsMirae = modelCart
                        Cache.listDatCocMirae = modelCart
//                        Cache.infoKHMirae?.soTienTraTruoc = Float(model.header?.soTienCoc ?? 0)
                        Cache.infoKHMirae?.soTienCoc = Float(model.header?.soTienCoc ?? 0)
//						if canBuyWarrenty(model_id: model.first?.id ?? "", sku: model.first?.sku ?? ""){
//							Cache.cartsMirae.first.is_ExtendedWar = true
//							let newViewController = CartMiraeViewController()
//							self.navigationController?.pushViewController(newViewController, animated: true)
//						}else {
//							let newViewController = CartMiraeViewController()
//							self.navigationController?.pushViewController(newViewController, animated: true)
//						}
						self.fetchMaSpBHBySku()

                    }
                }else {
                    self.outPutFailed(error: modelData.message ?? "")
                }
            case .failure(_):
                self.outPutFailed(error: "Lấy thông tin đơn hàng cọc không thành công")
            }
            self.hideLoading()
        }
    }
	private func canBuyWarrenty(model_id:String,sku:String) {
		ProductAPIManager.product_detais_by_model_id(model_id: model_id, sku: sku,handler: {[weak self] (success , error) in
			guard let self = self,let cart = success.first else {return}
			self.hideLoading()
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
					self.hideLoading()
					self.showAlert("Lấy chi tiết sản phẩm thất bại")
				}
			}
		})
	}
	func fetchMaSpBHBySku(){
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
