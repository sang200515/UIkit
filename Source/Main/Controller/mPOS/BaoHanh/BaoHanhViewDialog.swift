//
//  BaoHanhViewDialog.swift
//  mPOS
//
//  Created by sumi on 1/12/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit

class BaoHanhViewDialog: UIView {
    var contentView:UIView!
    var labelTitle:UILabel!
    var labelString:UILabel!
    var btnClose:UIButton!
    var baoHanhViewDialogDelegate:BaoHanhViewDialogDelegate!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        let textTitle = "Thông báo"
        let sizeTextTitle: CGSize = textTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize:  Common.Size(s:15))])
        labelTitle = UILabel(frame: CGRect(x: 20 , y: (UIScreen.main.bounds.size.height / 8) , width: UIScreen.main.bounds.size.width - 40 , height: sizeTextTitle.height * 3))
        labelTitle.textAlignment = .center
        
        labelTitle.backgroundColor = UIColor(netHex:0x00b25d)
        labelTitle.textColor = UIColor(netHex:0xffffff)
        labelTitle.font = UIFont.boldSystemFont(ofSize:  Common.Size(s:15))
        labelTitle.text = textTitle
        
        
        btnClose = UIButton(frame: CGRect(x: labelTitle.frame.origin.x + labelTitle.bounds.width - labelTitle.bounds.width / 9, y: labelTitle.frame.origin.y , width: labelTitle.bounds.width / 9 , height: labelTitle.bounds.height));
        btnClose.backgroundColor = UIColor(netHex:0x00b25d)
        btnClose.layer.cornerRadius = 1
        
        btnClose.setTitle("X",for: .normal)
        btnClose.setTitleColor(UIColor.white, for: .normal)
        
        
        
        contentView = UIView(frame: CGRect(x: 20 , y: labelTitle.frame.size.height + labelTitle.frame.origin.y - 20, width: UIScreen.main.bounds.size.width - 40 , height: 300 ))
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 10
        
        
        
        let string = "Shop hoàn tất hồ sơ bảo hiểm VIP cho KH \n1. Photo 2 mặt CMND của chính KH \n2. In hóa đơn mua hàng từ hệ thống \n3. Điền form bảo hiểm VIP (down load tại đây)  \n4. Mời KH gọi lên tổng đài Bảo hiểm VIP Samsung theo số \"1800577717-19006727 \" trong vòng 48h (phải đúng KH gọi thì mới được tiếp nhận Bảo hiểm VIP) \nShop gửi kèm toàn bộ hồ sơ #1, 2, 3 theo máy khi gửi đi Bảo hành." as NSString
        
        let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16.0)])
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)]
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: "Shop hoàn tất hồ sơ bảo hiểm VIP cho KH"))
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: "Shop gửi kèm toàn bộ hồ sơ #1, 2, 3 theo máy khi gửi đi Bảo hành."))
        
        
        
        
        //        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIFontWeightBold, range: NSRange(location:11,length: (textString.characters.count - 11)))
        
        
        
        labelString = UILabel(frame: CGRect(x: 10 , y: 0 , width: contentView.frame.size.width - 20 , height: contentView.frame.size.height ))
        labelString.textAlignment = .left
        labelString.lineBreakMode = .byWordWrapping
        labelString.numberOfLines = 0
        //labelString.backgroundColor = UIColor(netHex:0xffffff)
        labelString.textColor = UIColor(netHex:0x000000)
        labelString.font = UIFont.systemFont(ofSize:  Common.Size(s:15))
        //labelString.text = textString
        labelString.attributedText = attributedString
        
        
        addSubview(contentView)
        addSubview(labelTitle)
        addSubview(btnClose)
        contentView.addSubview(labelString)
        btnClose.addTarget(self, action: #selector(BaoHanhViewDialog.ClickClose), for: UIControl.Event.touchDown)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    @objc func ClickClose()
    {
        print("closeeeeeee")
        baoHanhViewDialogDelegate?.didClose(sender:
            self)
    }
    
}


protocol BaoHanhViewDialogDelegate
{
    func didClose(sender: BaoHanhViewDialogDelegate)
    
    
    
}





extension BaoHanhViewDialog: BaoHanhViewDialogDelegate
{
    
    func didClose(sender: BaoHanhViewDialogDelegate) {
        
    }
    
    
    
}


