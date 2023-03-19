//
//  InputTextViewChangeTime.swift
//  NewmDelivery
//
//  Created by sumi on 4/2/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import Toaster
import NVActivityIndicatorView

class InputTextViewChangeTime: UIView {

    var inputTextViewChangeTimeDelegate:InputTextViewChangeTimeDelegate!
    
    var loadingView:NVActivityIndicatorView!
      let datePicker = UIDatePicker()
    
     var imageTenKH: UIImageView!
    var btnClose:UIButton!
    var labelTitle:UILabel!
    var edtNameProduct:UITextField!
    var contentView:UIView!
    
    var labelText:UILabel!
    var labelThoiGianGiao:UILabel!
    var edtThoiGianGiaoHang:UITextField!
    
    
    var btnAdd:UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let textTitle = "Khách đổi giờ"
        let sizeTextTitle: CGSize = textTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize:  Common.Size(s:15))])
        labelTitle = UILabel(frame: CGRect(x: 20 , y: (UIScreen.main.bounds.size.height / 7) , width: UIScreen.main.bounds.size.width - 40 , height: sizeTextTitle.height * 2))
        labelTitle.textAlignment = .center
        
        labelTitle.backgroundColor = UIColor(netHex:0x007adf)
        labelTitle.textColor = UIColor(netHex:0xffffff)
        labelTitle.font = UIFont.boldSystemFont(ofSize:  Common.Size(s:15))
        labelTitle.text = textTitle
        
        
        
        
        
        /////////
        labelThoiGianGiao = UILabel(frame: CGRect(x: 40 , y: labelTitle.frame.origin.y + labelTitle.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - 40 , height: Common.Size(s: 11)))
        labelThoiGianGiao.textAlignment = .left
        labelThoiGianGiao.textColor = UIColor.black
        labelThoiGianGiao.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelThoiGianGiao.text = "Thời gian giao hàng"
        
        
        edtThoiGianGiaoHang = UITextField(frame: CGRect(x: (UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width * 3 / 4) / 2, y: labelThoiGianGiao.frame.origin.y + labelThoiGianGiao.frame.size.height + 10, width: UIScreen.main.bounds.size.width * 3 / 4, height:  Common.Size(s:40)));
        edtThoiGianGiaoHang.placeholder = ""
        edtThoiGianGiaoHang.textAlignment = .center
        edtThoiGianGiaoHang.font = UIFont.systemFont(ofSize:  Common.Size(s:13))
        edtThoiGianGiaoHang.borderStyle = UITextField.BorderStyle.roundedRect
        edtThoiGianGiaoHang.autocorrectionType = UITextAutocorrectionType.no
        edtThoiGianGiaoHang.keyboardType = UIKeyboardType.default
        edtThoiGianGiaoHang.returnKeyType = UIReturnKeyType.done
        edtThoiGianGiaoHang.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtThoiGianGiaoHang.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        let mDate = Date()
        let mFormatter = DateFormatter()
        
        mFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        edtThoiGianGiaoHang.text = mFormatter.string(from: mDate)
        
//        mFormatter.dateFormat = "dd/MM/yyyy hh:mm"
//        let mResult = mFormatter.string(from: mDate)
//        edtThoiGianGiaoHang.text = "\(mResult)"
        
        
        
        edtThoiGianGiaoHang.rightViewMode = UITextField.ViewMode.always
        imageTenKH = UIImageView(frame: CGRect(x: edtThoiGianGiaoHang.frame.size.height/4, y: edtThoiGianGiaoHang.frame.size.height/4, width: edtThoiGianGiaoHang.frame.size.height/2, height: edtThoiGianGiaoHang.frame.size.height/2))
        imageTenKH.image = UIImage(named: "calendarIC")
        
        imageTenKH.contentMode = UIView.ContentMode.scaleAspectFit
        let rightViewTenKH = UIView()
        rightViewTenKH.addSubview(imageTenKH)
        rightViewTenKH.frame = CGRect(x: 0, y: 0, width: edtThoiGianGiaoHang.frame.size.height, height: edtThoiGianGiaoHang.frame.size.height)
        edtThoiGianGiaoHang.rightView = rightViewTenKH
        
        ////////
        
        
        
        
        labelText = UILabel(frame: CGRect(x: 40 , y: edtThoiGianGiaoHang.frame.origin.y + edtThoiGianGiaoHang.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - 40 , height: Common.Size(s: 11)))
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
        addSubview(labelThoiGianGiao)
        addSubview(edtThoiGianGiaoHang)
        
        
        
        addSubview(btnClose)
        addSubview(loadingView)
        
        
        btnAdd.addTarget(self, action: #selector(clickAdd), for: UIControl.Event.touchDown)
        
        
        btnClose.addTarget(self, action: #selector(ClickClose), for: UIControl.Event.touchDown)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(imageGetDate(tapGestureRecognizer:)))
        imageTenKH.isUserInteractionEnabled = true
        imageTenKH.addGestureRecognizer(tapGestureRecognizer3)
        
        
        
    }
    
    @objc func CancelDatePicker()
    {
         endEditing(true)
    }
    
    
    @objc func imageGetDate(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("asdsadsa)")
        
        //Formate Date
        
        datePicker.datePickerMode = .dateAndTime
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(DoneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(CancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        // add toolbar to textField
        edtThoiGianGiaoHang.inputAccessoryView = toolbar
        // add datepicker to textField
        edtThoiGianGiaoHang.inputView = datePicker
        edtThoiGianGiaoHang.becomeFirstResponder()
    }
    @objc func DoneDatePicker()
    {
        print("asdsadsa\(datePicker.date)")
        let dateFormatter = DateFormatter()
        
     
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        edtThoiGianGiaoHang.text = dateFormatter.string(from: datePicker.date)
        endEditing(true)
    }
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    
    @objc func clickAdd()
    {
        
        if(edtNameProduct.text != "")
        {
            inputTextViewChangeTimeDelegate?.didClose(sender:
                self,mTime: "\(edtThoiGianGiaoHang.text!)",mReasonChangeTime:"\(edtNameProduct.text!)")
        }
        else
        {
            Toast.init(text:"Vui lòng nhập mã").show()
        }
        
    }
    
    
    @objc func ClickClose()
    {
        inputTextViewChangeTimeDelegate?.didCancel(sender:
            self)
    }
    
    
    
    
    
    
    
    
    
    
}


protocol InputTextViewChangeTimeDelegate
{
    func didClose(sender: InputTextViewChangeTimeDelegate,mTime:String,mReasonChangeTime:String)
    
    func didCancel(sender: InputTextViewChangeTimeDelegate)
    
}





extension InputTextViewChangeTime: InputTextViewChangeTimeDelegate
{
    
    func didClose(sender: InputTextViewChangeTimeDelegate,mTime:String,mReasonChangeTime:String){
        
    }
    
    func didCancel(sender: InputTextViewChangeTimeDelegate) {
        
    }
    
}






















