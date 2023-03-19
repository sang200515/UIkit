//
//  ComboPKViewController.swift
//  fptshop
//
//  Created by tan on 3/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
class ComboPKViewController: UIViewController,UITextFieldDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var scrollView:UIView!
    var barSearchRight : UIBarButtonItem!
    var tfInputGia:UITextField!
    var btSearch:UIButton!
    var priceData:Int = 0
    var viewThongTin:UIView!
    var collectionView: UICollectionView!
    var lstSanPham:[SanPhamGoiYComboPK] = []
    
    var thongTinTuVan:ThongTuVanComboPK?
    var lblSoTienKHTraThemValue:UILabel!
    var lblSoTienCanMuaThemValue:UILabel!
    var lblThanhTienSauKMValue:UILabel!
    var lblThanhTienTruocKMValue:UILabel!
    var lblHint:UILabel!
    var lblSoTienKHTraThem:UILabel!
    
    override func viewDidLoad() {
        self.title = "Combo PK"
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x47B054)
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        

        scrollView  = UIView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - 44-(UIApplication.shared.statusBarFrame.height + 0.0)))
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let lblInputGia = UILabel(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblInputGia.textAlignment = .left
        lblInputGia.textColor = UIColor.black
        lblInputGia.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblInputGia.text = "Nhập giá sản phẩm"
        scrollView.addSubview(lblInputGia)
        
        tfInputGia = UITextField(frame: CGRect(x: Common.Size(s: 10), y: lblInputGia.frame.origin.y + lblInputGia.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:40)))
        tfInputGia.placeholder = ""
        tfInputGia.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        tfInputGia.borderStyle = UITextField.BorderStyle.roundedRect
        tfInputGia.autocorrectionType = UITextAutocorrectionType.no
        tfInputGia.keyboardType = UIKeyboardType.numberPad
        tfInputGia.returnKeyType = UIReturnKeyType.done
        tfInputGia.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfInputGia.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfInputGia.delegate = self
        tfInputGia.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
        
        tfInputGia.placeholder = "Vui lòng nhập giá sản phẩm"
        scrollView.addSubview(tfInputGia)
        
        btSearch = UIButton()
        btSearch.frame = CGRect(x: tfInputGia.frame.origin.x, y: tfInputGia.frame.origin.y + tfInputGia.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 40))
        btSearch.backgroundColor = UIColor.red
        btSearch.setTitle("Xem tư vấn", for: .normal)
        btSearch.addTarget(self, action: #selector(actionSearch), for: .touchUpInside)
        btSearch.layer.borderWidth = 0.5
        btSearch.layer.borderColor = UIColor.white.cgColor
        btSearch.layer.cornerRadius = 3
        scrollView.addSubview(btSearch)
        btSearch.clipsToBounds = true
        
        viewThongTin = UIView(frame: CGRect(x: Common.Size(s: 10), y: btSearch.frame.origin.y + btSearch.frame.size.height + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height:  scrollView.frame.size.height))
        viewThongTin.isHidden = true
        scrollView.addSubview(viewThongTin)
        
        
        
        let lblThongTinTuVan = UILabel(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:35)))
        lblThongTinTuVan.textAlignment = .left
        lblThongTinTuVan.textColor = UIColor(netHex:0x04AB6E)
        lblThongTinTuVan.backgroundColor = UIColor.white
        lblThongTinTuVan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lblThongTinTuVan.text = "Thông Tin Tư Vấn"
        viewThongTin.addSubview(lblThongTinTuVan)
        
        lblHint = UILabel(frame: CGRect(x: 0, y: lblThongTinTuVan.frame.origin.y + lblThongTinTuVan.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:35)))
        lblHint.textAlignment = .left
        lblHint.textColor = UIColor.black
        lblHint.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        
        lblHint.numberOfLines = 0
        lblHint.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        lblHint.minimumScaleFactor = 0.8
        
        viewThongTin.addSubview(lblHint)
        
        let lblSoTienCanMuaThem = UILabel(frame: CGRect(x: 0, y: lblHint.frame.origin.y + lblHint.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSoTienCanMuaThem.textAlignment = .left
        lblSoTienCanMuaThem.textColor = UIColor.black
        lblSoTienCanMuaThem.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSoTienCanMuaThem.text = "Số tiền mua thêm 4 món nữa:"
        viewThongTin.addSubview(lblSoTienCanMuaThem)
        
        lblSoTienCanMuaThemValue = UILabel(frame: CGRect(x: 0, y: lblHint.frame.origin.y + lblHint.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSoTienCanMuaThemValue.textAlignment = .right
        lblSoTienCanMuaThemValue.textColor = UIColor.black
        lblSoTienCanMuaThemValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        
        viewThongTin.addSubview(lblSoTienCanMuaThemValue)
        
        let lblThanhTienTruocKM = UILabel(frame: CGRect(x: 0, y: lblSoTienCanMuaThem.frame.origin.y + lblSoTienCanMuaThem.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblThanhTienTruocKM.textAlignment = .left
        lblThanhTienTruocKM.textColor = UIColor.black
        lblThanhTienTruocKM.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblThanhTienTruocKM.text = "Tổng đơn hàng chưa giảm:"
        viewThongTin.addSubview(lblThanhTienTruocKM)
        
        lblThanhTienTruocKMValue = UILabel(frame: CGRect(x:0, y: lblSoTienCanMuaThem.frame.origin.y + lblSoTienCanMuaThem.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblThanhTienTruocKMValue.textAlignment = .right
        lblThanhTienTruocKMValue.textColor = UIColor.black
        lblThanhTienTruocKMValue.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        
        viewThongTin.addSubview(lblThanhTienTruocKMValue)
        
        
        lblSoTienKHTraThem = UILabel(frame: CGRect(x: 0, y: lblThanhTienTruocKMValue.frame.origin.y + lblThanhTienTruocKMValue.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSoTienKHTraThem.textAlignment = .left
        lblSoTienKHTraThem.textColor = UIColor.blue
        lblSoTienKHTraThem.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSoTienKHTraThem.text = "Số tiền KH Thanh Toán:"
        viewThongTin.addSubview(lblSoTienKHTraThem)
        
        lblSoTienKHTraThemValue = UILabel(frame: CGRect(x: 0, y: lblThanhTienTruocKMValue.frame.origin.y + lblThanhTienTruocKMValue.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSoTienKHTraThemValue.textAlignment = .right
        lblSoTienKHTraThemValue.textColor = UIColor.blue
        lblSoTienKHTraThemValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        
        viewThongTin.addSubview(lblSoTienKHTraThemValue)
        
        
        
        
        
        let lblSanPhamGoiY = UILabel(frame: CGRect(x: 0, y: lblSoTienKHTraThemValue.frame.origin.y + lblSoTienKHTraThemValue.frame.size.height , width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:35)))
        lblSanPhamGoiY.textAlignment = .left
        lblSanPhamGoiY.textColor = UIColor(netHex:0x04AB6E)
        lblSanPhamGoiY.backgroundColor = UIColor.white
        lblSanPhamGoiY.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lblSanPhamGoiY.text = "Sản Phẩm Gợi Ý:"
        viewThongTin.addSubview(lblSanPhamGoiY)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:5)/2, left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        layout.itemSize = CGSize(width: (viewThongTin.frame.size.width - Common.Size(s:10))/2, height: viewThongTin.frame.size.height - (lblSanPhamGoiY.frame.origin.y + lblSanPhamGoiY.frame.size.height) - Common.Size(s:10))
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = Common.Size(s:5)/2
        collectionView = UICollectionView(frame: CGRect(x: 0, y: lblSanPhamGoiY.frame.origin.y + lblSanPhamGoiY.frame.size.height + 15, width: viewThongTin.frame.size.width, height: viewThongTin.frame.size.height - (lblSanPhamGoiY.frame.origin.y + lblSanPhamGoiY.frame.size.height) - Common.Size(s:10)), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductAccessorieCell2.self, forCellWithReuseIdentifier: "ProductAccessorieCell2")
        collectionView.backgroundColor = UIColor.white
        viewThongTin.addSubview(collectionView)
        
        
        
        
        self.getPrice()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.lstSanPham.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductAccessorieCell2", for: indexPath) as! ProductAccessorieCell2
        let item:SanPhamGoiYComboPK = self.lstSanPham[indexPath.row]
        //        let iconImage:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height:  cell.frame.size.width))
        //        iconImage.image = Image(named: "demo")
        //        iconImage.contentMode = .scaleAspectFit
        //        cell.addSubview(iconImage)
        //        print( "\(cell.frame.size.height).  \(viewAccessories.frame.size.height - 10)")
        cell.setup(item: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item:SanPhamGoiYComboPK = self.lstSanPham[indexPath.row]
        let product:Product = Product(model_id:"",id: 0, name: "", brandID: 0, brandName: "", typeId: 0, typeName: "", sku: "", price: 0, priceMarket: 0, priceBeforeTax: 0, iconUrl: "", imageUrl: "", promotion: "", includeInfo: "", hightlightsDes: "", labelName: "", urlLabelPicture: "", isRecurring: true, manSerNum: "", bonusScopeBoom: "",qlSerial: "",inventory: 0,LableProduct:"",p_matkinh:"",ecomColorValue:"",ecomColorName:"", ecom_itemname_web: "",price_special:0,price_online_pos: 0, price_online: 0, hotSticker: false, is_NK: false, is_ExtendedWar: false,skuBH: [],nameBH: [],brandGoiBH:[],isPickGoiBH:"",amountGoiBH:"",itemCodeGoiBH: "",itemNameGoiBH: "",priceSauKM: 0,role2:[])
        product.name = item.Name
        product.iconUrl = item.UrlPicture
        product.price = Float(item.price)
        product.sku = item.Sku
        product.inventory = item.tonKho
        
        let newViewController = DetailProductViewController()
        newViewController.product = product
        self.navigationController?.pushViewController(newViewController, animated: true)
        print("You selected cell #\(item.Name)")
    }
    
    @objc func backButton(){
        self.navigationController?.popViewController(animated: true)
        
    }
    @objc func textFieldDidChangeMoney(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s).\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
            self.tfInputGia.text = str
        }else{
            textField.text = ""
            self.tfInputGia.text = ""
        }
        
    }
    @objc func textFieldDidChangeMoney2(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s).\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
            
        }else{
            textField.text = ""
            
        }
        
    }
    @objc func actionSearch(){
        self.tfInputGia.resignFirstResponder()
        var money = tfInputGia.text!
        money = money.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        if(money.isEmpty){
          
            self.showAlert(title: "Thông báo", message: "Vui lòng nhập giá tiền !!!")
            return
        }

        if(Int(money)! < self.priceData){
            self.showInputDialog2(title: "Nhập số tiền cần mua thêm đủ 4 món",
                                  subtitle: "Vui lòng nhập số tiền",
                                  actionTitle: "Xác nhận",
                                  cancelTitle: "Cancel",
                                  inputPlaceholder: "số tiền",
                                  inputKeyboardType: UIKeyboardType.numberPad, actionHandler:
                                    { (input:String?) in
                                        
                                        
                                        if(input == ""){
                                            
                                            self.showAlert(title: "Thông báo", message: "Vui lòng nhập số tiền !!!")
                                            return
                                        }
                                        
                                        self.getSanPhamGoiY(money: money, moneyInput: input!.replacingOccurrences(of: ".", with: "", options: .literal, range: nil))
                                    })
        }else{
            self.getSanPhamGoiY(money: money, moneyInput: "0")
        }
        
    }
    func getPrice(){
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.sp_mpos_FRT_SP_comboPK_fix_Price() { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.priceData = results!
                    
                    
                    
                    
                }else{
            
                    self.showAlert(title: "Thông báo", message: err)
                }
            }
        }
    }
    
    func getSanPhamGoiY(money:String,moneyInput:String){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin combo PK..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.sp_mpos_FRT_SP_comboPK_calculator(price:money,priceadd:moneyInput, xmllistsp: "") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.viewThongTin.isHidden = false
                    self.lstSanPham = (results?.sanPhamGoiYs)!
                    
                    self.lblSoTienCanMuaThemValue.text = Common.convertCurrencyV2(value: results!.thongtinTV[0].ThanhTienMuaThem)
                    self.lblThanhTienTruocKMValue.text = "\(Common.convertCurrencyV2(value: results!.thongtinTV[0].ThanhTienTruocKM))"
                    //                    self.lblThanhTienSauKMValue.text = "\(Common.convertCurrencyV2(value: results!.thongtinTV[0].ThanhTienSauKM))"
                    self.lblSoTienKHTraThemValue.text = "\(Common.convertCurrencyV2(value: results!.thongtinTV[0].ThanhTienSauKM))"
                    //                    self.lblHint.text = "Anh chị ơi anh chị chỉ cần bù \(self.lblSoTienKHTraThemValue.text!) để mình có \(self.lblSoTienCanMuaThemValue.text!) mua PK"
                    
                    let number = 4
                    let strNumber: NSString = "Anh chị ơi anh chị chỉ cần bù \(Common.convertCurrencyV2(value: results!.thongtinTV[0].SoTienTraThem)) để mình có \(self.lblSoTienCanMuaThemValue.text!) mua \(number) món PK" as NSString // you must set your
                    let range = (strNumber).range(of: "\(Common.convertCurrencyV2(value: results!.thongtinTV[0].SoTienTraThem))")
                    let range2 = (strNumber).range(of: "\(self.lblSoTienCanMuaThemValue.text!)")
                    let range3 = (strNumber).range(of: "\(number)")
                    let attribute = NSMutableAttributedString.init(string: strNumber as String)
                    attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
                    attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range2)
                    attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range3)
                    self.lblHint.attributedText = attribute
                    
                    //                    let str:NSString = "Số tiền KH Thanh Toán:"
                    //                    let range4 = (strNumber).range(of: "KH Thanh Toán")
                    //                    let attribute2 = NSMutableAttributedString.init(string: str as String)
                    //                    attribute2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue , range: range4)
                    //                    self.lblSoTienKHTraThem.attributedText = attribute2
                    self.collectionView.reloadData()
                    
                    
                }else{
                
                    self.showAlert(title: "Thông báo", message: err)
                }
            }
        }
    }
    
    func showInputDialog2(title:String? = nil,
                          subtitle:String? = nil,
                          actionTitle:String? = "Add",
                          cancelTitle:String? = "Cancel",
                          inputPlaceholder:String? = nil,
                          inputKeyboardType:UIKeyboardType = UIKeyboardType.numberPad,
                          cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                          actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
            textField.isSecureTextEntry = false
            textField.addTarget(self, action: #selector(self.textFieldDidChangeMoney2(_:)), for: .editingChanged)
        }
        
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}
class ProductAccessorieCell2: UICollectionViewCell {
    var iconImage:UIImageView!
    var title:UILabel!
    var price:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setup(item:SanPhamGoiYComboPK){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: self.frame.size.width, height:  self.frame.size.width - Common.Size(s:20)))
        //        iconImage.image = Image(named: "demo")
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        //iconImage.backgroundColor = .red
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = item.UrlPicture.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            let url = URL(string: "\(escapedString)")!
            iconImage.kf.setImage(with: url,
                                  placeholder: nil,
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil,
                                  completionHandler: nil)
        }
        
        let heightTitel = item.Name.height(withConstrainedWidth: self.frame.size.width - Common.Size(s:4), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
        
        title = UILabel(frame: CGRect(x: Common.Size(s:2), y: iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s:5), width: self.frame.size.width - Common.Size(s:4), height: heightTitel))
        title.textAlignment = .center
        title.textColor = UIColor.lightGray
        title.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        title.text = item.Name
        title.numberOfLines = 2
        title.sizeToFit()
        addSubview(title)
        price = UILabel(frame: CGRect(x: Common.Size(s:2), y: title.frame.size.height + title.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:14)))
        price.textAlignment = .center
        price.textColor = UIColor(netHex:0xEF4A40)
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        price.text = Common.convertCurrencyV2(value: item.price)
        price.numberOfLines = 1
        addSubview(price)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
