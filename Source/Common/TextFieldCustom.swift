//
//  TextFieldCustom.swift
//  fptshop
//
//  Created by Ngoc Bao on 05/10/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TextFieldCustom: UITextField {
    var delegateButton: TextFieldCustomDelegate?
    let datePicker = UIDatePicker()
    
    @IBInspectable
    var rightAction: Bool = false { // true: handle delegate click right img txt,false nothing
        didSet{
            let gesture = UITapGestureRecognizer(target: self, action: #selector(onclickRightBtn))
            self.rightView?.addGestureRecognizer(gesture)
        }
    }
    
    @IBInspectable
    var isDate: Bool = false { // true: select date , false: txt normal
        didSet {
            showDatePicker()
        }
    }
    
    @IBInspectable
    var rightImg: UIImage? = nil { // set right image
        didSet {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 15))
            imageView.contentMode = .scaleAspectFit
            imageView.image = rightImg
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: imageView.frame.width + 5, height: imageView.frame.height))
            paddingView.addSubview(imageView)
            self.rightViewMode = .always
            self.rightView = paddingView
            self.sendSubviewToBack(paddingView)
        }
    }
    
    @IBInspectable
    var leftImg: UIImage? = nil { // set left image
        didSet {
            guard let img = leftImg else {return}
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 15))
            imageView.contentMode = .scaleAspectFit
            imageView.image = img
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: imageView.frame.width + 5, height: imageView.frame.height))
            paddingView.addSubview(imageView)
            self.rightViewMode = .always
            self.leftView = paddingView
            self.sendSubviewToBack(paddingView)
        }
    }
    
    @IBInspectable
    var isButton: Bool = false { // true: add button on surface txt, click button has delegate, false: nothing
        didSet {
            if isButton {
                let newbutton = UIButton(frame: self.bounds)
                newbutton.backgroundColor = .clear
                newbutton.addTarget(self, action: #selector(onclickButton), for: .touchUpInside)
                self.addSubview(newbutton)
                self.bringSubviewToFront(newbutton)
            }
        }
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
       //ToolBar
       let toolbar = UIToolbar()
       toolbar.sizeToFit()
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        self.inputAccessoryView = toolbar
        self.inputView = datePicker
     }
    
    @objc func donedatePicker(){
       self.endEditing(true)
       let formatter = DateFormatter()
       formatter.dateFormat = "dd/MM/yyyy"
       self.text = formatter.string(from: datePicker.date)
        if isDate {
            delegateButton?.doneDatePicker!(tag: self.tag,value: self.text ?? "")
        }
     }
    
    @objc func onclickButton() {
        delegateButton?.onClickButton(tag: self.tag)
    }
    @objc func onclickRightBtn() {
        if rightAction {
            delegateButton?.onRightTxt!(tag: self.tag)
        }
    }
    
    @objc func cancelDatePicker(){
        self.endEditing(true)
        if isDate {
            delegateButton?.cancelDatePicker!(tag: self.tag)
        }
    }
}
@objc protocol TextFieldCustomDelegate {
    func onClickButton(tag: Int)
    @objc optional func onRightTxt(tag:Int)
    @objc optional func doneDatePicker(tag:Int,value: String)
    @objc optional func cancelDatePicker(tag:Int)
}
