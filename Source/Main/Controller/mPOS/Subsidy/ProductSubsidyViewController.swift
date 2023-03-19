//
//  ProductSubsidyViewController.swift
//  mPOS
//
//  Created by MinhDH on 4/24/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class ProductSubsidyViewController: UIViewController,UITextFieldDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var ssd: SSDGoiCuoc!
    
    var collectionView: UICollectionView!
    var products: [ItemCodeSubSidy] = []
    var money:Float = 0
    override func viewDidLoad() {
        self.title = "Tư vấn Subsidy"
        self.view.backgroundColor = UIColor.white
        
        let viewHeader = UIView(frame:CGRect(x:0,y:0,width:UIScreen.main.bounds.size.width,height:Common.Size(s: 40)))
        viewHeader.backgroundColor = .white
        self.view.addSubview(viewHeader)
        
        let lbUserInfo = UILabel(frame: CGRect(x: 0, y: 0, width: viewHeader.frame.size.width , height: viewHeader.frame.size.height))
        lbUserInfo.textAlignment = .center
        lbUserInfo.textColor = UIColor(netHex:0x47B054)
        lbUserInfo.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        lbUserInfo.text = "Các máy đi kèm gói \(ssd.TenGoiCuoc)"
        viewHeader.addSubview(lbUserInfo)
        
        let ssdViewLine = UIView(frame:CGRect(x:0,y:lbUserInfo.frame.size.height + lbUserInfo.frame.origin.y - Common.Size(s: 0.5),width: viewHeader.frame.size.width,height:Common.Size(s: 0.5)))
        ssdViewLine.backgroundColor = .gray
        viewHeader.addSubview(ssdViewLine)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:10), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        layout.itemSize = CGSize(width: (self.view.frame.size.width - Common.Size(s:10))/2, height: (self.view.frame.size.width - Common.Size(s:10))/2 * 1.6)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = Common.Size(s:5)/2
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: viewHeader.frame.size.height + viewHeader.frame.origin.y, width: self.view.frame.size.width, height: self.view.frame.size.height - viewHeader.frame.size.height -  ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductSubsidyCollectionCell.self, forCellWithReuseIdentifier: "ProductSubsidyCollectionCell")
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.sp_mpos_GetList_ItemCodeSubSidy(maSPSubsidy: "\(ssd.MaSP)") { (results, error) in
            
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(error.count <= 0){
                    self.products = results
                    self.collectionView.reloadData()
                }else{
                    let popup = PopupDialog(title: "THÔNG BÁO", message: error, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        _ = self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductSubsidyCollectionCell", for: indexPath) as! ProductSubsidyCollectionCell
        let item:ItemCodeSubSidy = products[indexPath.row]
        cell.setup(item: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item:ItemCodeSubSidy = products[indexPath.row]
        let newViewController = DetailProductSubsidyViewController()
        newViewController.productSubSidy = item
        newViewController.ssd = ssd
        newViewController.money = money
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.title = ""
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Tư vấn Subsidy"
    }
}

class ProductSubsidyCollectionCell: UICollectionViewCell {
    var iconImage:UIImageView!
    var title:UILabel!
    var sku:UILabel!
    var bonus:UILabel!
    var priceOld:UILabel!
    var price:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setup(item:ItemCodeSubSidy){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: self.frame.size.width, height:  self.frame.size.width - Common.Size(s:20)))
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = item.ImageUrl.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            let url = URL(string: "\(escapedString)")!
            iconImage.kf.setImage(with: url,
                                  placeholder: nil,
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil,
                                  completionHandler: nil)
        }
        
        let heightTitel = item.ItemName.height(withConstrainedWidth: self.frame.size.width - 4, font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
        
        title = UILabel(frame: CGRect(x: 2, y: iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s:5), width: self.frame.size.width - 4, height: heightTitel))
        title.textAlignment = .center
        title.textColor = UIColor.black
        title.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        title.text = item.ItemName
        title.numberOfLines = 3
        title.sizeToFit()
        title.frame.origin.x = self.frame.size.width/2 -  title.frame.size.width/2
        addSubview(title)
        
        
        sku = UILabel(frame: CGRect(x: 2, y: title.frame.size.height + title.frame.origin.y + Common.Size(s: 2), width: self.frame.size.width - 4, height: Common.Size(s:12)))
        sku.textAlignment = .center
        sku.textColor = UIColor.lightGray
        sku.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        sku.text = "No.\(item.ItemCode)"
        sku.numberOfLines = 1
        addSubview(sku)
        
        bonus = UILabel(frame: CGRect(x: 2, y: sku.frame.size.height + sku.frame.origin.y + Common.Size(s: 2), width: self.frame.size.width - 4, height: Common.Size(s:13)))
        bonus.textAlignment = .center
        bonus.textColor =  UIColor(netHex:0x47B054)
        bonus.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        bonus.text = "\(item.BonusScopeBoom)"
        bonus.numberOfLines = 1
        addSubview(bonus)
        
        priceOld = UILabel(frame: CGRect(x: 2, y: bonus.frame.size.height + bonus.frame.origin.y + Common.Size(s: 2), width: self.frame.size.width - 4, height: Common.Size(s:12)))
        priceOld.textAlignment = .center
        priceOld.textColor = UIColor.lightGray
        priceOld.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: Common.convertCurrencyFloat(value: item.Price))
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        priceOld.attributedText =  attributeString
        priceOld.numberOfLines = 1
        addSubview(priceOld)
        
        price = UILabel(frame: CGRect(x: 2, y: priceOld.frame.size.height + priceOld.frame.origin.y + Common.Size(s: 2), width: self.frame.size.width - 4, height: Common.Size(s:16)))
        price.textAlignment = .center
        price.textColor = UIColor(netHex:0xEF4A40)
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        price.text = Common.convertCurrencyFloat(value: item.TienSauTroGia)
        price.numberOfLines = 1
        addSubview(price)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


