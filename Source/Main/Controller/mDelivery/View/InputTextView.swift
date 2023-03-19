//
//  InputTextView.swift
//  NewmDelivery
//
//  Created by sumi on 3/26/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import Toaster
import UIKit
import NVActivityIndicatorView

class InputTextView: UIView {

    var inputTextViewDelegate:InputTextViewDelegate!
    
    var loadingView:NVActivityIndicatorView!
    
   
    
    var btnClose:UIButton!
    var labelTitle:UILabel!
    var edtNameProduct:UITextField!
    var contentView:UIView!
    
    var labelText:UILabel!
    
    
    
    var btnAdd:UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let textTitle = "Hủy đơn hàng"
        let sizeTextTitle: CGSize = textTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize:  Common.Size(s:15))])
        labelTitle = UILabel(frame: CGRect(x: 20 , y: (UIScreen.main.bounds.size.height / 7) , width: UIScreen.main.bounds.size.width - 40 , height: sizeTextTitle.height * 2))
        labelTitle.textAlignment = .center
        
        labelTitle.backgroundColor = UIColor(netHex:0x007adf)
        labelTitle.textColor = UIColor(netHex:0xffffff)
        labelTitle.font = UIFont.boldSystemFont(ofSize:  Common.Size(s:15))
        labelTitle.text = textTitle
        
        labelText = UILabel(frame: CGRect(x: 40 , y: labelTitle.frame.origin.y + labelTitle.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - 40 , height: Common.Size(s: 11)))
        labelText.textAlignment = .left
        labelText.textColor = UIColor(netHex:0x000000)
        labelText.font = UIFont.boldSystemFont(ofSize:  Common.Size(s:13))
        labelText.text = "Lý do hủy đơn :"
        
        
        
        btnClose = UIButton(frame: CGRect(x: labelTitle.frame.origin.x + labelTitle.bounds.width - labelTitle.bounds.width / 10, y: labelTitle.frame.origin.y , width: labelTitle.bounds.width / 10 , height: labelTitle.bounds.height));
        btnClose.backgroundColor = UIColor(netHex:0x007adf)
        btnClose.layer.cornerRadius = 1
        
        btnClose.setTitle("X",for: .normal)
        btnClose.setTitleColor(UIColor.white, for: .normal)
        
        
        edtNameProduct = UITextField(frame: CGRect(x: (UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width * 3 / 4) / 2, y: labelText.frame.origin.y + labelText.frame.size.height + 10, width: UIScreen.main.bounds.size.width * 3 / 4 , height:  Common.Size(s:120)));
        edtNameProduct.placeholder = ""
        edtNameProduct.textAlignment = .center
        edtNameProduct.font = UIFont.systemFont(ofSize:  Common.Size(s:18))
        edtNameProduct.borderStyle = UITextField.BorderStyle.roundedRect
        edtNameProduct.autocorrectionType = UITextAutocorrectionType.no
        edtNameProduct.keyboardType = UIKeyboardType.default
        edtNameProduct.returnKeyType = UIReturnKeyType.done
        edtNameProduct.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtNameProduct.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtNameProduct.text = ""
        
        
        
        
        
        
        
        
        
        btnAdd = UIButton(frame: CGRect(x: (UIScreen.main.bounds.size.width - (UIScreen.main.bounds.size.width - 40)  / 2 ) / 2 , y: edtNameProduct.frame.origin.y + edtNameProduct.frame.size.height + 20 , width: (UIScreen.main.bounds.size.width - 40)  / 2  , height:Common.Size(s:30)));
        btnAdd.backgroundColor = UIColor(netHex:0x0372d8)
        //btnAdd.layer.cornerRadius = 10
        btnAdd.layer.borderWidth = 1
        btnAdd.layer.borderColor = UIColor(netHex:0xffffff).cgColor
        
        
        btnAdd.setTitle("Xác Nhận",for: .normal)
        btnAdd.setTitleColor(UIColor.white, for: .normal)
        btnAdd.titleLabel!.font =  UIFont(name: "Helvetica", size: 16)
        
        let frameLoading = CGRect(x: (UIScreen.main.bounds.size.width - Common.Size(s:50)) / 2, y:(UIScreen.main.bounds.size.height - Common.Size(s:50)) / 2 + 100, width: Common.Size(s:50), height: Common.Size(s:50))
        loadingView = NVActivityIndicatorView(frame: frameLoading,
                                              type: .ballClipRotateMultiple)
        
        
        
        contentView = UIView(frame: CGRect(x: 20, y: (UIScreen.main.bounds.size.height / 7) , width: UIScreen.main.bounds.size.width - 40  , height: (edtNameProduct.bounds.size.height * 2 ) ));
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 10
        
        
        
        
        
        addSubview(contentView)
        addSubview(labelTitle)
        addSubview(edtNameProduct)
        addSubview(labelText)
        
        addSubview(btnAdd)
        
        
        
        addSubview(btnClose)
        addSubview(loadingView)
        
        
        btnAdd.addTarget(self, action: #selector(InputTextView.clickAdd), for: UIControl.Event.touchDown)
        
        
        btnClose.addTarget(self, action: #selector(InputTextView.ClickClose), for: UIControl.Event.touchDown)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    
    @objc func clickAdd()
    {
        
        if(edtNameProduct.text != "")
        {
            inputTextViewDelegate?.didClose(sender:
                self,mReason: edtNameProduct.text! )
        }
        else
        {
            Toast.init(text:"Vui lòng nhập mã").show()
        }
        
    }
    
    
    @objc func ClickClose()
    {
        inputTextViewDelegate?.didCancel(sender:
            self)
    }
    
    
    
    
    
    
    
    
    
    
}


protocol InputTextViewDelegate
{
    func didClose(sender: InputTextViewDelegate,mReason:String)
    
    func didCancel(sender: InputTextViewDelegate)
    
}





extension InputTextView: InputTextViewDelegate
{
    
    func didClose(sender: InputTextViewDelegate,mReason:String) {
        
    }
    
    func didCancel(sender: InputTextViewDelegate) {
        
    }
    
}
