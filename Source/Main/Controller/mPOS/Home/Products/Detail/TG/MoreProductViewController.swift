//
//  MoreProductViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 5/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Kingfisher
import QuartzCore
import PopupDialog
class MoreProductViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var collectionView: UICollectionView!
    var scrollView:UIScrollView!
    var listSPTraGopAll:[SPTraGop] = []
    var product:ProductBySku!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = UIColor.white
        self.title = "Sản phẩm lên đời"
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(MoreProductViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        self.view.backgroundColor = UIColor.white
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:10), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        var heightCell:CGFloat = 1.8
        if(product.product.typeId == 3){
            heightCell = 2.15
        }
        layout.itemSize = CGSize(width: (self.view.frame.size.width - Common.Size(s:10))/2, height: (self.view.frame.size.width - Common.Size(s:10))/2 * heightCell)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = Common.Size(s:5)/2
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - UIApplication.shared.statusBarFrame.height), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MoreProductCollectionCell.self, forCellWithReuseIdentifier: "MoreProductCollectionCell")
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSPTraGopAll.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreProductCollectionCell", for: indexPath) as! MoreProductCollectionCell
        let item:SPTraGop = listSPTraGopAll[indexPath.row]
        cell.setup(item: item)
        cell.btCompare.tag = indexPath.row
        cell.btCompare.addTarget(self, action: #selector(tapSelectCompare), for: .touchUpInside)
        return cell
    }
    @objc func tapSelectCompare(sender:UIButton) {
        let tag = sender.tag
        let item = listSPTraGopAll[tag]
        if(self.product.product.typeId == 3){
            let vc = CompareProductsLaptopViewController()
            vc.product = self.product
            vc.productCompare = item
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = CompareProductsViewController()
            vc.product = self.product
            vc.productCompare = item
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item:SPTraGop = listSPTraGopAll[indexPath.row]
        Cache.sku = item.ItemCode
        let newViewController = DetailProductViewController()
        newViewController.isCompare = false
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
class MoreProductCollectionCell: UICollectionViewCell {
    var btCompare: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setup(item:SPTraGop){
        self.subviews.forEach { $0.removeFromSuperview() }
        let viewItemProduct = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        addSubview(viewItemProduct)
        
        //----
        let iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: viewItemProduct.frame.size.width, height:  viewItemProduct.frame.size.width - Common.Size(s:20)))
        iconImage.contentMode = .scaleAspectFit
        viewItemProduct.addSubview(iconImage)
        //                iconImage.backgroundColor = .red
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
        
        let laiSuat = UILabel(frame: CGRect(x: viewItemProduct.frame.size.width/2, y: Common.Size(s:2), width: viewItemProduct.frame.size.width/2, height: Common.Size(s:16)))
        laiSuat.textAlignment = .center
        laiSuat.textColor = .white
        laiSuat.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        if(item.LaiSuat == 0){
            laiSuat.text = "Trả góp 0%"
        }else{
            laiSuat.text = "Trả góp \(item.LaiSuat)%"
        }
        laiSuat.layer.cornerRadius = 3.0
        laiSuat.numberOfLines = 1
        laiSuat.backgroundColor = .red
        laiSuat.clipsToBounds = true
        
        viewItemProduct.addSubview(laiSuat)
        
        let heightTitel = item.TenSanPham.height(withConstrainedWidth: viewItemProduct.frame.size.width - Common.Size(s:4), font: UIFont.systemFont(ofSize: Common.Size(s:14)))
        
        let title = UILabel(frame: CGRect(x: Common.Size(s:2), y: iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s:5), width: viewItemProduct.frame.size.width - Common.Size(s:4), height: heightTitel))
        title.textAlignment = .center
        title.textColor = UIColor.black
        title.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        title.text = item.TenSanPham
        title.numberOfLines = 3
        viewItemProduct.addSubview(title)
        
        let num : UILabel = UILabel(frame: CGRect(x:0,y: title.frame.size.height + title.frame.origin.y,width: viewItemProduct.frame.size.width,height:Common.Size(s:11)))
        num.textColor = .gray
        num.textAlignment = .center
        num.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        viewItemProduct.addSubview(num)
        num.text = "\(item.DiemThuong) (\(item.SL))"
        
        let price = UILabel(frame: CGRect(x: Common.Size(s:2), y: num.frame.size.height + num.frame.origin.y + Common.Size(s:4), width: viewItemProduct.frame.size.width - 4, height: Common.Size(s:14)))
        price.textAlignment = .center
        price.textColor = UIColor(netHex:0xEF4A40)
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        price.text = Common.convertCurrencyFloat(value: Float(item.Price)!)
        price.numberOfLines = 1
        viewItemProduct.addSubview(price)
        
        let docentry = UILabel(frame: CGRect(x: Common.Size(s:2), y: price.frame.size.height + price.frame.origin.y + Common.Size(s:4), width: viewItemProduct.frame.size.width - 4, height: Common.Size(s:14)))
        docentry.textAlignment = .center
        docentry.textColor = UIColor(netHex:0x47B054)
        docentry.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        docentry.text = "\(item.docentry)"
        docentry.numberOfLines = 1
        viewItemProduct.addSubview(docentry)
        
        let soTienTraTruoc = UILabel(frame: CGRect(x: Common.Size(s:2), y: docentry.frame.size.height + docentry.frame.origin.y + Common.Size(s:2), width: viewItemProduct.frame.size.width - 4, height: Common.Size(s:13)))
        soTienTraTruoc.textAlignment = .center
        soTienTraTruoc.textColor = UIColor.orange
        soTienTraTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        soTienTraTruoc.text = "Trả trước \(Common.convertCurrencyFloat(value: Float(item.SoTienTraTruoc)))"
        soTienTraTruoc.numberOfLines = 1
        viewItemProduct.addSubview(soTienTraTruoc)
        
        let kyHan = UILabel(frame: CGRect(x: Common.Size(s:2), y: soTienTraTruoc.frame.size.height + soTienTraTruoc.frame.origin.y + Common.Size(s:2), width: viewItemProduct.frame.size.width - 4, height: Common.Size(s:13)))
        kyHan.textAlignment = .center
        kyHan.textColor = UIColor.darkGray
        kyHan.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        kyHan.text = "Kỳ hạn \(item.KyHan) tháng"
        kyHan.numberOfLines = 1
        viewItemProduct.addSubview(kyHan)
        
        btCompare = UIButton()
        //        btCompare.tag = count
        btCompare.frame = CGRect(x: viewItemProduct.frame.size.width / 4, y: kyHan.frame.origin.y + kyHan.frame.size.height + Common.Size(s: 5), width: viewItemProduct.frame.size.width / 2, height: viewItemProduct.frame.size.width / 5)
        btCompare.backgroundColor = UIColor(netHex:0x04AB6E)
        btCompare.setTitle("So sánh", for: .normal)
        btCompare.layer.borderWidth = 0.5
        btCompare.layer.borderColor = UIColor.white.cgColor
        btCompare.layer.cornerRadius = 5.0
        viewItemProduct.addSubview(btCompare)
        //----
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
