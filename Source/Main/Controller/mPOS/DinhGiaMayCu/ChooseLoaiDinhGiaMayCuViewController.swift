//
//  ChooseLoaiDinhGiaMayCuViewController.swift
//  fptshop
//
//  Created by tan on 9/9/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class ChooseLoaiDinhGiaMayCuViewController: UIViewController,UITextFieldDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var tfLoai:SearchTextField!
    var product:ThuMuaMayCuList?
    var collectionView: UICollectionView!
    var listTinhTrang:[LoaiDinhGiaMayCu] = []
    var idLoai:String = ""
    var items:[MayDinhGia] = []
    var viewUI:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sản phẩm lên đời"
        //navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(ChooseLoaiDinhGiaMayCuViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        viewUI = UIView(frame: UIScreen.main.bounds)
        
        viewUI.backgroundColor = UIColor.white
        self.view.addSubview(viewUI)
        
        let lbTextSP = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: self.view.frame.size.width - Common.Size(s:30), height: Common.Size(s:35)))
        lbTextSP.textAlignment = .left
        lbTextSP.textColor = UIColor.black
        lbTextSP.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSP.numberOfLines = 0
        lbTextSP.text = "Máy cũ của bạn là \(product!.Name)"
  
        viewUI.addSubview(lbTextSP)
        
        tfLoai = SearchTextField(frame: CGRect(x: lbTextSP.frame.origin.x, y: lbTextSP.frame.origin.y + lbTextSP.frame.size.height + Common.Size(s:10), width: self.view.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tfLoai.placeholder = "Chọn tình trạng máy"
        tfLoai.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfLoai.borderStyle = UITextField.BorderStyle.roundedRect
        tfLoai.autocorrectionType = UITextAutocorrectionType.no
        tfLoai.keyboardType = UIKeyboardType.default
        tfLoai.returnKeyType = UIReturnKeyType.done
        tfLoai.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfLoai.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfLoai.delegate = self
        self.view.addSubview(tfLoai)
        
        tfLoai.startVisible = true
        tfLoai.theme.bgColor = UIColor.white
        tfLoai.theme.fontColor = UIColor.black
        tfLoai.theme.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfLoai.theme.cellHeight = Common.Size(s:40)
        tfLoai.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:13))]
        
        tfLoai.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfLoai.text = item.title
            self.tfLoai.resignFirstResponder()
            let obj =  self.listTinhTrang.filter{ $0.Name == "\(item.title)" }.first
            if let id = obj?.Code {
                self.idLoai = "\(id)"
            }
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra thông tin..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            
            MPOSAPIManager.mpos_FRT_SP_ThuMuaMC_get_list_detail(ItemCode:"\(self.product!.Itemcode)",p_loai:"\(self.idLoai)") { (result, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        self.items.removeAll()
                        self.items = result
                        self.collectionView.reloadData()
                        
                        
                        
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                }
            }
        }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:10), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        layout.itemSize = CGSize(width: (self.view.frame.size.width - Common.Size(s:10))/2, height: (self.view.frame.size.width - Common.Size(s:10))/2 * 1.4)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = Common.Size(s:5)/2
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: tfLoai.frame.size.height + tfLoai.frame.origin.y + Common.Size(s:10), width: self.view.frame.size.width, height: self.view.frame.size.height - CGFloat((self.tabBarController?.tabBar.frame.size.height)!) - UIApplication.shared.statusBarFrame.height - lbTextSP.frame.size.height - tfLoai.frame.size.height - Common.Size(s:20)), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductOldToNewCollectionCell.self, forCellWithReuseIdentifier: "ProductOldToNewCollectionCell")
        collectionView.backgroundColor = UIColor.white
        viewUI.addSubview(collectionView)
        
   
        
        MPOSAPIManager.mpos_FRT_SP_ThuMuaMC_get_list_Loai(ItemCode: self.product!.Itemcode) { (results, err) in
      
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    var listCom: [String] = []
                    self.listTinhTrang = results
                    for item in results {
                        listCom.append("\(item.Name)")
                    }
                    self.tfLoai.filterStrings(listCom)
                }else{
                    let title = "THÔNG BÁO"
                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
                
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductOldToNewCollectionCell", for: indexPath) as! ProductOldToNewCollectionCell
        let item:MayDinhGia = items[indexPath.row]
        cell.setup(item: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item:MayDinhGia = items[indexPath.row]
        Cache.sku = item.Itemcode
        let newViewController = DetailProductViewController()
        //            newViewController.product = item
        newViewController.isCompare = false
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
}
class ProductOldToNewCollectionCell: UICollectionViewCell {
    var iconImage:UIImageView!
    var title:UILabel!
    var priceOld:UILabel!
    var price:UILabel!
    var bounus:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setup(item:MayDinhGia){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: self.frame.size.width, height:  self.frame.size.width - Common.Size(s:20)))
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if(item.UrlPicture != ""){
            if let escapedString = item.UrlPicture.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                    print(escapedString)
                    let url = URL(string: "\(escapedString)")!
                    iconImage.kf.setImage(with: url,
                                          placeholder: nil,
                                          options: [.transition(.fade(1))],
                                          progressBlock: nil,
                                          completionHandler: nil)
                }
        }
    
        
        let heightTitel = item.Name.height(withConstrainedWidth: self.frame.size.width - 4, font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
        
        title = UILabel(frame: CGRect(x: 2, y: iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s:5), width: self.frame.size.width - 4, height: heightTitel))
        title.textAlignment = .center
        title.textColor = UIColor.lightGray
        title.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        title.text = item.Name
        title.numberOfLines = 2
        title.sizeToFit()
        title.frame.origin.x = self.frame.size.width/2 -  title.frame.size.width/2
        addSubview(title)
        //
        bounus = UILabel(frame: CGRect(x: 2, y: title.frame.size.height + title.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:14)))
        bounus.textAlignment = .center
        bounus.textColor = UIColor(netHex:0x04AB6E)
        bounus.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        bounus.text = "Mã SP: \(item.Itemcode)"
        bounus.numberOfLines = 1
        addSubview(bounus)
        //
        priceOld = UILabel(frame: CGRect(x: 2, y: bounus.frame.size.height + bounus.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:14)))
        priceOld.textAlignment = .center
        priceOld.textColor = UIColor.lightGray
        priceOld.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: Common.convertCurrencyFloat(value: item.GiaHienTai))
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        priceOld.attributedText =  attributeString
        priceOld.numberOfLines = 1
        addSubview(priceOld)
        
        price = UILabel(frame: CGRect(x: 2, y: priceOld.frame.size.height + priceOld.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:14)))
        price.textAlignment = .center
        price.textColor = UIColor(netHex:0xEF4A40)
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        price.text = Common.convertCurrencyFloat(value: item.GiaSauThuMua)
        price.numberOfLines = 1
        addSubview(price)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
