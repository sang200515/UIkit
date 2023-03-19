//
//  ProductSearchCollectionCell.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/7/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
class ProductSearchCollectionCell: UICollectionViewCell {
    var iconImage:UIImageView!
    var title:UILabel!
    var price:UILabel!
    var bonus:UILabel!
    var hotSticker:UIImageView!
    var tempHangNhapKhau:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setup(item:Product){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: self.frame.size.width, height:  self.frame.size.width - Common.Size(s:20)))
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = item.imageUrl.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
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
        
        let heightTitel = item.name.height(withConstrainedWidth: self.frame.size.width - Common.Size(s:4), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
        
        title = UILabel(frame: CGRect(x: Common.Size(s:2), y: iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s:5), width: self.frame.size.width - Common.Size(s:4), height: heightTitel))
        title.textAlignment = .center
        title.textColor = UIColor.lightGray
        title.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        title.text = item.name
        title.numberOfLines = 3
        title.sizeToFit()
        title.frame.origin.x = self.frame.size.width/2 -  title.frame.size.width/2
        addSubview(title)
        price = UILabel(frame: CGRect(x: Common.Size(s:2), y: title.frame.size.height + title.frame.origin.y, width: self.frame.size.width - Common.Size(s:4), height: Common.Size(s:14)))
        price.textAlignment = .center
        price.textColor = UIColor(netHex:0xEF4A40)
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        price.text = Common.convertCurrencyFloat(value: item.price)
        price.numberOfLines = 1
        addSubview(price)
        
        bonus = UILabel(frame: CGRect(x: 2, y: price.frame.size.height + price.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:12)))
        bonus.textAlignment = .center
        bonus.textColor = UIColor(netHex:0x47B054)
        bonus.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        bonus.text = "Sku: \(item.sku)"
        bonus.numberOfLines = 1
        addSubview(bonus)
        if(item.hotSticker){
           hotSticker = UIImageView()
			iconImage.addSubview(hotSticker)
			hotSticker.image = UIImage(named: "ic_hot3")
			hotSticker.snp.makeConstraints { make in
				make.left.equalToSuperview().offset(15)
				make.bottom.equalToSuperview()
				make.height.equalTo(30)
				make.width.equalTo(UIScreen.main.bounds.width * 0.25)
			}
			hotSticker.contentMode = .scaleToFill
        }
        if(item.is_NK){
          
            tempHangNhapKhau = UIImageView(frame: CGRect(x: self.frame.size.width/5, y: 10, width: Common.Size(s:45), height: Common.Size(s:30)))
            tempHangNhapKhau.image = UIImage(named: "icNhapKhau")
            tempHangNhapKhau.frame.origin.x = self.frame.size.width/100
          addSubview(tempHangNhapKhau)
        }
        
    }
    func setupOld(item:ProductOld){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: self.frame.size.width, height:  self.frame.size.width - Common.Size(s:20)))
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        
        if let escapedString = item.IconUrl.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            let url = URL(string: "\(escapedString)")!
            iconImage.kf.setImage(with: url,
                                  placeholder: nil,
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil,
                                  completionHandler: nil)
        }
        
        let heightTitel = item.Name.height(withConstrainedWidth: self.frame.size.width - Common.Size(s:4), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
        
        title = UILabel(frame: CGRect(x: Common.Size(s:2), y: iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s:5), width: self.frame.size.width - Common.Size(s:4), height: heightTitel))
        title.textAlignment = .center
        title.textColor = UIColor.lightGray
        title.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        title.text = item.Name
        title.numberOfLines = 3
        title.sizeToFit()
        title.frame.origin.x = self.frame.size.width/2 -  title.frame.size.width/2
        addSubview(title)
        price = UILabel(frame: CGRect(x: Common.Size(s:2), y: title.frame.size.height + title.frame.origin.y, width: self.frame.size.width - Common.Size(s:4), height: Common.Size(s:14)))
        price.textAlignment = .center
        price.textColor = UIColor(netHex:0xEF4A40)
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        price.text = Common.convertCurrencyFloat(value: item.Price)
        price.numberOfLines = 1
        addSubview(price)
        
        bonus = UILabel(frame: CGRect(x: 2, y: price.frame.size.height + price.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:12)))
        bonus.textAlignment = .center
        bonus.textColor = UIColor(netHex:0x47B054)
        bonus.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        bonus.text = "\(item.Sku)"
        bonus.numberOfLines = 1
        addSubview(bonus)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
