//
//  InputViewXacNhan.swift
//  NewmDelivery
//
//  Created by sumi on 3/26/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import Toaster
import UIKit
import NVActivityIndicatorView

class InputViewXacNhan: UIView {


    var inputViewXacNhanDelegate:InputViewXacNhanDelegate!
    
    var loadingView:NVActivityIndicatorView!
    
    
    
    var btnClose:UIButton!
    var labelTitle:UILabel!
    var edtNameProduct:UITextField!
    var contentView:UIView!
    
    var labelText:UILabel!
    var edtNameProduct2:UITextField!
    var labelText2:UILabel!
    
    
    var btnAdd:UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let textTitle = "Xác nhận xuất kho"
        let sizeTextTitle: CGSize = textTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize:  Common.Size(s:15))])
        labelTitle = UILabel(frame: CGRect(x: 20 , y: (UIScreen.main.bounds.size.height / 7) , width: UIScreen.main.bounds.size.width - 40 , height: sizeTextTitle.height * 2))
        labelTitle.textAlignment = .center
        
        labelTitle.backgroundColor = UIColor(netHex:0x007adf)
        labelTitle.textColor = UIColor(netHex:0xffffff)
        labelTitle.font = UIFont.boldSystemFont(ofSize:  Common.Size(s:15))
        labelTitle.text = textTitle
        
        
        btnClose = UIButton(frame: CGRect(x: labelTitle.frame.origin.x + labelTitle.bounds.width - labelTitle.bounds.width / 10, y: labelTitle.frame.origin.y , width: labelTitle.bounds.width / 10 , height: labelTitle.bounds.height));
        btnClose.backgroundColor = UIColor(netHex:0x007adf)
        btnClose.layer.cornerRadius = 1
        
        btnClose.setTitle("X",for: .normal)
        btnClose.setTitleColor(UIColor.white, for: .normal)
        
        
        labelText = UILabel(frame: CGRect(x: 40 , y: labelTitle.frame.origin.y + labelTitle.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width / 4 , height: Common.Size(s: 20)))
        labelText.textAlignment = .left
        labelText.textColor = UIColor(netHex:0x000000)
        labelText.font = UIFont.boldSystemFont(ofSize:  Common.Size(s:13))
        labelText.text = "Mã inside :"
        
        
        edtNameProduct = UITextField(frame: CGRect(x: labelText.frame.size.width + labelText.frame.origin.x , y: labelText.frame.origin.y , width: UIScreen.main.bounds.size.width / 2 , height:  Common.Size(s:20)));
        edtNameProduct.placeholder = ""
        edtNameProduct.textAlignment = .center
        edtNameProduct.font = UIFont.systemFont(ofSize:  Common.Size(s:18))
        edtNameProduct.borderStyle = UITextField.BorderStyle.roundedRect
        edtNameProduct.autocorrectionType = UITextAutocorrectionType.no
        edtNameProduct.keyboardType = UIKeyboardType.numberPad
        edtNameProduct.returnKeyType = UIReturnKeyType.done
        edtNameProduct.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtNameProduct.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtNameProduct.text = ""
        
        labelText2 = UILabel(frame: CGRect(x: 40 , y: edtNameProduct.frame.origin.y + edtNameProduct.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width / 4 , height: Common.Size(s: 20)))
        labelText2.textAlignment = .left
        labelText2.textColor = UIColor(netHex:0x000000)
        labelText2.font = UIFont.boldSystemFont(ofSize:  Common.Size(s:13))
        labelText2.text = "Mật khẩu :"
        
        
        
        
        
        
        edtNameProduct2 = UITextField(frame: CGRect(x: labelText2.frame.size.width + labelText2.frame.origin.x , y: labelText2.frame.origin.y , width: UIScreen.main.bounds.size.width / 2 , height:  Common.Size(s:20)));
        edtNameProduct2.placeholder = ""
        edtNameProduct2.textAlignment = .center
        edtNameProduct2.font = UIFont.systemFont(ofSize:  Common.Size(s:18))
        edtNameProduct2.borderStyle = UITextField.BorderStyle.roundedRect
        edtNameProduct2.autocorrectionType = UITextAutocorrectionType.no
        edtNameProduct2.keyboardType = UIKeyboardType.default
        edtNameProduct2.returnKeyType = UIReturnKeyType.done
        edtNameProduct2.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtNameProduct2.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtNameProduct2.text = ""
        edtNameProduct2.isSecureTextEntry = true
        
        
        
        
        
        
        btnAdd = UIButton(frame: CGRect(x: (UIScreen.main.bounds.size.width - (UIScreen.main.bounds.size.width - 40)  / 2 ) / 2 , y: edtNameProduct2.frame.origin.y + edtNameProduct.frame.size.height + 20 , width: (UIScreen.main.bounds.size.width - 40)  / 2  , height:Common.Size(s:30)));
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
        
        
        
        contentView = UIView(frame: CGRect(x: 20, y: (UIScreen.main.bounds.size.height / 7) , width: UIScreen.main.bounds.size.width - 40  , height: (edtNameProduct.bounds.size.height * 8 ) ));
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 10
        
        
        
        
        
        addSubview(contentView)
        addSubview(labelTitle)
        addSubview(edtNameProduct)
        addSubview(labelText)
        addSubview(edtNameProduct2)
        addSubview(labelText2)
        addSubview(btnAdd)
        
        
        
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
        
        if(edtNameProduct.text != "" || edtNameProduct2.text != "" )
        {
            inputViewXacNhanDelegate?.didClose(sender:
                self,mUser: "\(edtNameProduct.text!)",mPass:"\(edtNameProduct2.text!)")
        }
        else
        {
            Toast.init(text:"Vui lòng nhập mã").show()
        }
        
    }
    
    
    @objc func ClickClose()
    {
        inputViewXacNhanDelegate?.didCancel(sender:
            self)
    }
    
    
    
    
    
    
    
    
    
    
}


protocol InputViewXacNhanDelegate
{
    func didClose(sender: InputViewXacNhanDelegate,mUser:String,mPass:String)
    
    func didCancel(sender: InputViewXacNhanDelegate)
    
}





extension InputViewXacNhan: InputViewXacNhanDelegate
{
    
    func didClose(sender: InputViewXacNhanDelegate,mUser:String,mPass:String) {
        
    }
    
    func didCancel(sender: InputViewXacNhanDelegate) {
        
    }
    
}





















