//
//  CustomTxt.swift
//  IOSStoryborad
//
//  Created by Ngoc Bao on 03/12/2021.
//

import UIKit

@objc protocol CustomTxtDelegate {
    @objc optional func onClickButton(txt: CustomTxt,tag: Int)
    @objc optional func onRightTxt(tag:Int)
    @objc optional func doneDatePicker(tag:Int,value: String)
    @objc optional func cancelDatePicker(tag:Int)
    @objc optional func didSelectItemtxt(txt: CustomTxt, tag:Int, value: String)
    @objc optional func txtDidChange(txt: CustomTxt,value: String)
    @objc optional func searchTxtChnage(txt: CustomTxt,value: String)
}

// set height = 60
// if hidden title height = 43

@IBDesignable
class CustomTxt: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet var textfield: UITextField!
    @IBOutlet var searchTxt: SearchTextField!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var rightImageSearch: UIImageView!
    @IBOutlet var rightViewImgSearch: UIView!
    @IBOutlet var stackSerchImage: UIStackView!
    
    var delegateTextfield: CustomTxtDelegate?
    let datePicker = UIDatePicker()
    var text: String {
        return textfield.text ?? ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func commonInit(){
        let bundle = Bundle(for: CustomTxt.self)
        bundle.loadNibNamed("CustomTxt", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        initSearchTxt()
    }
    
//    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        if action == #selector(copy(_:)) || action == #selector(paste(_:)) {
//            return false
//        }
//
//        return true
//    }
    
    func initSearchTxt() {
        searchTxt.placeholder = placeHolder
        searchTxt.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        searchTxt.borderStyle = UITextField.BorderStyle.none
        searchTxt.autocorrectionType = UITextAutocorrectionType.no
        searchTxt.keyboardType = UIKeyboardType.default
        searchTxt.returnKeyType = UIReturnKeyType.done
        searchTxt.clearButtonMode = UITextField.ViewMode.whileEditing
        searchTxt.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        // Start visible - Default: false
        searchTxt.startVisible = true
        searchTxt.theme.bgColor = UIColor.white
        searchTxt.theme.fontColor = UIColor.black
        searchTxt.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        searchTxt.theme.cellHeight = Common.Size(s:40)
        searchTxt.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        searchTxt.leftViewMode = UITextField.ViewMode.always
        searchTxt.itemSelectionHandler = { filteredResults, itemPosition in
            //Just in case you need the item position
            if   itemPosition <= (filteredResults.count - 1) {
                let item = filteredResults[itemPosition]
                
                self.searchTxt.text = item.title
                if let del = self.delegateTextfield {
                    del.didSelectItemtxt!(txt: self, tag: self.textfield.tag, value: item.title)
                }
            }
        }
        searchTxt.addTarget(self, action: #selector(searchTxtChange(_:)), for: .editingChanged)
    }
    
    var filterString: [String] = [] {
        didSet {
            searchTxt.filterStrings(filterString)
        }
    }
    
    @IBInspectable
    var isSearch: Bool = false { // = true if txt is search txt
        didSet {
            textfield.isHidden = isSearch
            stackSerchImage.isHidden = !isSearch
        }
    }
    
    @IBInspectable
    var isDate: Bool = false { // true: select date , false: txt normal
        didSet {
            if isDate {
                showDatePicker()
            }
        }
    }
    
    @IBInspectable
    var title: String = "" {
        didSet {
            if !title.isEmpty {
                titleLabel.text = title
            }
        }
    }
    
    @IBInspectable
    var hiddenTitle: Bool = false {
        didSet {
            titleLabel.isHidden = hiddenTitle
        }
    }
    
    @IBInspectable
    var placeHolder: String = "" {
        didSet {
            if !placeHolder.isEmpty {
                textfield.placeholder = placeHolder
            }
        }
    }
    
    
    @IBInspectable
    var keyboard: UIKeyboardType = .default {
        didSet {
            textfield.keyboardType = keyboard
        }
    }
    
    

    @IBInspectable
    var rightAction: Bool = false { // true: handle delegate click right img txt,false nothing
        didSet{
            let gesture = UITapGestureRecognizer(target: self, action: #selector(onclickRightBtn))
            self.textfield.rightView?.addGestureRecognizer(gesture)
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
            self.textfield.rightViewMode = .always
            self.textfield.rightView = paddingView
            self.textfield.sendSubviewToBack(paddingView)
            rightViewImgSearch.isHidden =  rightImg != nil ? false : true
            rightImageSearch.image = rightImg
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
    
    @IBInspectable
    var isMoneyTxt: Bool = false { // true: add button on surface txt, click button has delegate, false: nothing
        didSet {
            if isMoneyTxt {
                textfield.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
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
        self.textfield.inputAccessoryView = toolbar
        self.textfield.inputView = datePicker
     }
    
    @objc func donedatePicker(){
       self.endEditing(true)
       let formatter = DateFormatter()
       formatter.dateFormat = "dd/MM/yyyy"
        self.textfield.text = formatter.string(from: datePicker.date)
        if isDate {
            delegateTextfield?.doneDatePicker!(tag: self.textfield.tag,value: self.textfield.text ?? "")
        }
     }
    
    @objc func textFieldDidChangeMoney(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s).\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
            self.textfield.text = str
        }else{
            textField.text = ""
            self.textfield.text = ""
        }
        delegateTextfield?.txtDidChange!(txt: self, value: self.textfield.text ?? "")
    }
    @objc func searchTxtChange(_ textField: UITextField) {
        let text:String = textField.text ?? ""
        delegateTextfield?.searchTxtChnage!(txt: self, value: text)
    }
    
    @objc func onclickButton() {
        delegateTextfield?.onClickButton!(txt:self, tag: self.textfield.tag)
    }
    @objc func onclickRightBtn() {
        if rightAction {
            delegateTextfield?.onRightTxt!(tag: self.textfield.tag)
        }
    }
    
    @objc func cancelDatePicker(){
        self.endEditing(true)
        if isDate {
            delegateTextfield?.cancelDatePicker!(tag: self.tag)
        }
    }
    
    
}

