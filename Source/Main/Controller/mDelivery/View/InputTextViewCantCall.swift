//
//  InputTextViewCantCall.swift
//  NewmDelivery
//
//  Created by sumi on 4/2/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import Toaster
import NVActivityIndicatorView

class InputTextViewCantCall: UIView {
    
    var inputTextViewCantCallDelegate:InputTextViewCantCallDelegate!
    
    var loadingView:NVActivityIndicatorView!

    var btnClose:UIButton!
    var labelTitle:UILabel!
    var edtNameProduct:UITextField!
    var contentView:UIView!
    
    var labelText:UILabel!
    
    
    var labelInside:UILabel!
    var labelPass:UILabel!
    var edtNameInside:UITextField!
    var edtNamePasst:UITextField!
    
    var btnAdd:UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let textTitle = "Không gọi được"
        let sizeTextTitle: CGSize = textTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize:  Common.Size(s:15))])
        labelTitle = UILabel(frame: CGRect(x: 20 , y: (UIScreen.main.bounds.size.height / 7) , width: UIScreen.main.bounds.size.width - 40 , height: sizeTextTitle.height * 2))
        labelTitle.textAlignment = .center
        
        labelTitle.backgroundColor = UIColor(netHex:0x007adf)
        labelTitle.textColor = UIColor(netHex:0xffffff)
        labelTitle.font = UIFont.boldSystemFont(ofSize:  Common.Size(s:15))
        labelTitle.text = textTitle
        
        
        
        
        
        /* */
        
        
        labelInside = UILabel(frame: CGRect(x: 40 , y: labelTitle.frame.origin.y + labelTitle.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width / 4 , height: Common.Size(s: 20)))
        labelInside.textAlignment = .left
        labelInside.textColor = UIColor(netHex:0x000000)
        labelInside.font = UIFont.boldSystemFont(ofSize:  Common.Size(s:13))
        labelInside.text = "Mã inside :"
        
        
        
        
        
        
        edtNameInside = UITextField(frame: CGRect(x: (UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width * 3 / 4) / 2 , y: labelInside.frame.origin.y + labelInside.frame.size.height + Common.Size(s: 10), width: UIScreen.main.bounds.size.width * 3 / 4  , height:  Common.Size(s:20)));
        edtNameInside.placeholder = ""
        edtNameInside.textAlignment = .center
        edtNameInside.font = UIFont.systemFont(ofSize:  Common.Size(s:18))
        edtNameInside.borderStyle = UITextField.BorderStyle.roundedRect
        edtNameInside.autocorrectionType = UITextAutocorrectionType.no
        edtNameInside.keyboardType = UIKeyboardType.numberPad
        edtNameInside.returnKeyType = UIReturnKeyType.done
        edtNameInside.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtNameInside.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtNameInside.text = ""
        
        labelPass = UILabel(frame: CGRect(x: 40 , y: edtNameInside.frame.origin.y + edtNameInside.frame.size.height + Common.Size(s: 10), width: UIScreen.main.bounds.size.width / 4 , height: Common.Size(s: 20)))
        labelPass.textAlignment = .left
        labelPass.textColor = UIColor(netHex:0x000000)
        labelPass.font = UIFont.boldSystemFont(ofSize:  Common.Size(s:13))
        labelPass.text = "Mật khẩu :"
        
        
        
        
        
        
        edtNamePasst = UITextField(frame: CGRect(x: (UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width * 3 / 4) / 2 , y: labelPass.frame.origin.y + labelPass.frame.size.height + 10 , width: UIScreen.main.bounds.size.width * 3 / 4  , height:  Common.Size(s:20)));
        edtNamePasst.placeholder = ""
        edtNamePasst.textAlignment = .center
        edtNamePasst.font = UIFont.systemFont(ofSize:  Common.Size(s:18))
        edtNamePasst.borderStyle = UITextField.BorderStyle.roundedRect
        edtNamePasst.autocorrectionType = UITextAutocorrectionType.no
        edtNamePasst.keyboardType = UIKeyboardType.default
        edtNamePasst.returnKeyType = UIReturnKeyType.done
        edtNamePasst.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtNamePasst.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtNamePasst.text = ""
        edtNamePasst.isSecureTextEntry = true
        
        
        
        /* */
        
        
        
        
        labelText = UILabel(frame: CGRect(x: 40 , y: edtNamePasst.frame.origin.y + edtNamePasst.frame.size.height + Common.Size(s: 10), width: UIScreen.main.bounds.size.width - 40 , height: Common.Size(s: 11)))
        labelText.textAlignment = .left
        labelText.textColor = UIColor(netHex:0x000000)
        labelText.font = UIFont.boldSystemFont(ofSize:  Common.Size(s:13))
        labelText.text = "Ghi chú :"
        
        
        
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
        
        
        
        contentView = UIView(frame: CGRect(x: 20, y: (UIScreen.main.bounds.size.height / 7) , width: UIScreen.main.bounds.size.width - 40  , height: (edtNameProduct.bounds.size.height * 3 ) ));
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 10
        
        
        
        
        
        addSubview(contentView)
        addSubview(labelTitle)
        addSubview(edtNameProduct)
        addSubview(labelText)
        
        addSubview(btnAdd)
        
        addSubview(edtNamePasst)
        addSubview(edtNameInside)
        addSubview(labelInside)
        addSubview(labelPass)
        
        addSubview(btnClose)
        addSubview(loadingView)
        
        
        btnAdd.addTarget(self, action: #selector(clickAdd), for: UIControl.Event.touchDown)

        btnClose.addTarget(self, action: #selector(ClickClose), for: UIControl.Event.touchDown)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    
    @objc func clickAdd()
    {
        
        if(edtNameProduct.text != "")
        {
            inputTextViewCantCallDelegate?.didClose(sender:
                self,mInside:"\(edtNameInside.text!)",mPass:"\(edtNamePasst.text!)",mString:"\(edtNameProduct.text!)")
        }
        else
        {
            Toast.init(text: "Vui lòng nhập mã").show()
        }
        
    }
    @objc func ClickClose()
    {
        inputTextViewCantCallDelegate?.didCancel(sender:
            self)
    }
}


protocol InputTextViewCantCallDelegate
{
    func didClose(sender: InputTextViewCantCallDelegate,mInside:String,mPass:String,mString:String)
    
    func didCancel(sender: InputTextViewCantCallDelegate)
    
}





extension InputTextViewCantCall: InputTextViewCantCallDelegate
{
    
    func didClose(sender: InputTextViewCantCallDelegate,mInside:String,mPass:String,mString:String) {
        
    }
    
    func didCancel(sender: InputTextViewCantCallDelegate) {
        
    }
    
}
