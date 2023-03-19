//
//  ConfirmPopupViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 26/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import DropDown
import DLRadioButton
protocol  ConfirmPopupDelegate {
    func handleSendRequest(note: String)
}
class ConfirmPopupViewController: UIViewController,UITextFieldDelegate
{
    var viewBox: UIView!
    var delegate: ConfirmPopupDelegate?
    var tfName, tfPhone,tfTax,tfAddress,tfProduct:UITextField!
    var dropDown = DropDown()
    var viewReason1: UIView!
    var viewReason2: UIView!
    
    var radioDeposit:DLRadioButton!
    var radioGuarantee:DLRadioButton!
    var heightReason1: CGFloat = 0
    var heightReason2: CGFloat = 0
    var indexSelect: Int = 0
    var tfNote,tfSONumber: UITextField!
    var ycdcNum: String = ""
    let loadingIndicator = UIActivityIndicatorView()
    var btnSend: UIView!
    var overView = UIView()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        viewBox = UIView(frame: CGRect(x: width/20, y: height/2 - 325/2, width: width * 18/20, height: 325))
        viewBox.backgroundColor = .white
        viewBox.layer.cornerRadius = 10
        self.view.addSubview(viewBox)
        
        let titleInvoice = UILabel(frame: CGRect(x: 0, y: 0, width: viewBox.frame.size.width, height: Common.Size(s: 40)))
        titleInvoice.textAlignment = .center
        titleInvoice.text = "LÝ DO GỬI YC"
        titleInvoice.font = UIFont.boldSystemFont(ofSize: 18)
        viewBox.addSubview(titleInvoice)
        
        let viewBoxLineHeader = UIView(frame: CGRect(x: 0, y: titleInvoice.frame.size.height + titleInvoice.frame.origin.y, width: viewBox.frame.size.width, height: 0.5))
        viewBoxLineHeader.backgroundColor = .lightGray
        viewBox.addSubview(viewBoxLineHeader)
        
        
        let titleReason = UILabel(frame: CGRect(x: Common.Size(s: 10), y: viewBoxLineHeader.frame.origin.y + viewBoxLineHeader.frame.size.height +  Common.Size(s: 10), width: viewBox.frame.size.width/5 - Common.Size(s: 10), height: Common.Size(s: 30)))
        titleReason.textAlignment = .left
        titleReason.text = "Lý do:"
        titleReason.font = UIFont.systemFont(ofSize: 14)
        viewBox.addSubview(titleReason)
        
        
        tfProduct = UITextField(frame: CGRect(x: titleReason.frame.origin.x + titleReason.frame.size.width, y: titleReason.frame.origin.y, width: viewBox.frame.size.width * 4/5 - Common.Size(s: 10), height: Common.Size(s: 30)))
        tfProduct.placeholder = "Chọn lý do"
        tfProduct.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        tfProduct.borderStyle = UITextField.BorderStyle.roundedRect
        tfProduct.autocorrectionType = UITextAutocorrectionType.no
        tfProduct.keyboardType = UIKeyboardType.default
        tfProduct.returnKeyType = UIReturnKeyType.done
        tfProduct.clearButtonMode = UITextField.ViewMode.whileEditing
        tfProduct.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        viewBox.addSubview(tfProduct)
        tfProduct.delegate = self
        
        tfProduct.rightViewMode = .always
        let searchImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let searchImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        searchImageView.image = #imageLiteral(resourceName: "down_arrow_ic")
        searchImageViewWrapper.addSubview(searchImageView)
        tfProduct.rightView = searchImageViewWrapper
        
        let tapSearchProduct = UITapGestureRecognizer(target: self, action: #selector(self.searchProduct))
        tfProduct.addGestureRecognizer(tapSearchProduct)
        tfProduct.isUserInteractionEnabled = true
        
        DropDown.setupDefaultAppearance()
        dropDown.anchorView = tfProduct
      
        viewBox.addSubview(dropDown)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            tfProduct.text = item
            if(index == 0){
                viewReason1.frame.size.height = heightReason1
                viewReason2.frame.size.height = 0
                radioDeposit.isSelected = true
                radioGuarantee.isSelected = false
                tfSONumber.layer.borderColor = UIColor.clear.cgColor
                tfSONumber.borderStyle = UITextField.BorderStyle.roundedRect
            }else{
                viewReason2.frame.size.height = heightReason2
                viewReason1.frame.size.height = 0
                viewReason2.frame.origin.y = viewReason1.frame.size.height + viewReason1.frame.origin.y
                tfNote.layer.borderColor = UIColor.clear.cgColor
                tfNote.borderStyle = UITextField.BorderStyle.roundedRect
            }
            indexSelect = index
        }
        dropDown.dataSource = ["Do SO cọc/phiếu bảo hành", "Khác"]
        dropDown.selectRow(0)
        indexSelect = 0
        tfProduct.text =  dropDown.dataSource[0]
        
        viewReason1 = UIView(frame: CGRect(x: Common.Size(s: 10), y: tfProduct.frame.origin.y + tfProduct.frame.size.height +  Common.Size(s: 10), width: viewBox.frame.size.width - Common.Size(s: 20), height: 100))
        viewReason1.backgroundColor = .white
        viewReason1.clipsToBounds = true
        viewBox.addSubview(viewReason1)
        
        radioDeposit = createRadioButton(CGRect(x: 0, y: 0 , width: viewReason1.frame.size.width/2, height: Common.Size(s: 20)), title: "Số SO đặt cọc", color: UIColor(netHex:0x00955E))
        viewReason1.addSubview(radioDeposit)
        radioDeposit.isSelected = true
        
        radioGuarantee = createRadioButton(CGRect(x: viewReason1.frame.size.width/2, y: 0 , width: viewReason1.frame.size.width/2, height: Common.Size(s: 20)), title: "Số phiếu BH", color: UIColor(netHex:0x00955E))
        viewReason1.addSubview(radioGuarantee)
        
        tfSONumber = UITextField(frame: CGRect(x: 0, y: radioDeposit.frame.origin.y + radioDeposit.frame.size.height + Common.Size(s: 5), width: viewReason1.frame.size.width, height: Common.Size(s: 30)))
        tfSONumber.placeholder = "Nhập số phiếu"
        tfSONumber.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        tfSONumber.borderStyle = UITextField.BorderStyle.roundedRect
        tfSONumber.autocorrectionType = UITextAutocorrectionType.no
        tfSONumber.keyboardType = UIKeyboardType.default
        tfSONumber.returnKeyType = UIReturnKeyType.done
        tfSONumber.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSONumber.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        viewReason1.addSubview(tfSONumber)
        tfSONumber.delegate = self
        
        let titleNote = UILabel(frame: CGRect(x: tfSONumber.frame.origin.x, y: tfSONumber.frame.origin.y + tfSONumber.frame.size.height +  Common.Size(s: 5), width: tfSONumber.frame.size.width, height: Common.Size(s: 15)))
        titleNote.textAlignment = .left
        titleNote.text = "* Các số SO và BH cách nhau bằng dấu phẩy. Ví dụ: 123,456"
        titleNote.font = UIFont.italicSystemFont(ofSize: 12)
        titleNote.numberOfLines = 2
        viewReason1.addSubview(titleNote)
        viewReason1.frame.size.height = titleNote.frame.origin.y + titleNote.frame.size.height
        heightReason1 = viewReason1.frame.size.height
        
        viewReason2 = UIView(frame: CGRect(x: Common.Size(s: 10), y: viewReason1.frame.origin.y + viewReason1.frame.size.height, width: viewBox.frame.size.width - Common.Size(s: 20), height: 100))
        viewReason2.backgroundColor = .white
        viewReason2.clipsToBounds = true
        viewBox.addSubview(viewReason2)
        
        tfNote = UITextField(frame: CGRect(x: 0, y: 0, width: viewReason1.frame.size.width, height: Common.Size(s: 30)))
        tfNote.placeholder = "Nhập ghi chú"
        tfNote.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        tfNote.borderStyle = UITextField.BorderStyle.roundedRect
        tfNote.autocorrectionType = UITextAutocorrectionType.no
        tfNote.keyboardType = UIKeyboardType.default
        tfNote.returnKeyType = UIReturnKeyType.done
        tfNote.clearButtonMode = UITextField.ViewMode.whileEditing
        tfNote.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        viewReason2.addSubview(tfNote)
        tfNote.delegate = self
        viewReason2.frame.size.height = tfNote.frame.size.height + tfNote.frame.origin.y
        heightReason2 = viewReason2.frame.size.height
        viewReason2.frame.size.height = 0

        loadingIndicator.frame = CGRect(x: viewBox.frame.size.width/2 - 25, y: viewReason2.frame.size.height + viewReason2.frame.origin.y + Common.Size(s: 5), width: 50, height: 0)
        loadingIndicator.color = UIColor(netHex:0x00955E)
        loadingIndicator.clipsToBounds = true
        viewBox.addSubview(loadingIndicator)
        btnSend = Common.btnWithImage(image: #imageLiteral(resourceName: "ic-send"), title: "Gửi YC", color: UIColor(netHex:0x00955E), cgRect: CGRect(x: viewBox.frame.size.width/2 - viewBox.frame.size.width/6, y: loadingIndicator.frame.size.height + loadingIndicator.frame.origin.y + Common.Size(s: 5), width: viewBox.frame.size.width/3, height: Common.Size(s: 30)))
        viewBox.addSubview(btnSend)
        let tapSendRequest = UITapGestureRecognizer(target: self, action: #selector(self.sendRequest))
        btnSend.addGestureRecognizer(tapSendRequest)
        btnSend.isUserInteractionEnabled = true
        
        viewBox.frame.size.height = btnSend.frame.size.height + btnSend.frame.origin.y  + Common.Size(s: 10)
        
        overView.frame = viewBox.frame
        overView.frame.size.height = 0
        overView.backgroundColor = .clear
        overView.clipsToBounds = true
        self.view.addSubview(overView)
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.closeDialog))
        self.view.addGestureRecognizer(gesture)
    }
    @objc func sendRequest(){
        var note:String = ""
        var soNum:String = ""
        var bhNum:String = ""
        if(indexSelect == 0){
            let so:String = tfSONumber.text ?? ""
            if(so != ""){
                tfSONumber.layer.borderColor = UIColor.clear.cgColor
                tfSONumber.borderStyle = UITextField.BorderStyle.roundedRect
                if(radioDeposit.isSelected){
                    note = "Số SO đặt cọc: \(so)"
                    soNum = so
                    bhNum = ""
                }else{
                    note = "Số phiếu BH: \(so)"
                    bhNum = so
                    soNum = ""
                }
            }else{
                tfSONumber.layer.borderColor = UIColor.red.cgColor
                tfSONumber.layer.borderWidth = 1
            }
        }else{
            note = tfNote.text ?? ""
            if(note != ""){
                tfNote.borderStyle = UITextField.BorderStyle.roundedRect
            }else{
                tfNote.layer.borderColor = UIColor.red.cgColor
                tfNote.layer.borderWidth = 1
            }
        }
        if(note != ""){
            loadingView(isShow:true)
            APIManager.checkSOBH(soNum: "\(soNum)", soPhieuBH: "\(bhNum)", soycdc: "\(ycdcNum)", noiDung: "\(note)") { result, message, err in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.loadingView(isShow:false)
                    if(result == "200"){
                        let alert = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
                        let okaction = UIAlertAction(title: "OK", style: .default) { (action) in
                            self.delegate?.handleSendRequest(note: self.ycdcNum)
                            self.dismiss(animated: true, completion: nil)
                        }
                        alert.addAction(okaction)
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        self.tfNote.layer.borderColor = UIColor.red.cgColor
                        self.tfNote.layer.borderWidth = 1
                        self.tfSONumber.layer.borderColor = UIColor.red.cgColor
                        self.tfSONumber.layer.borderWidth = 1
                        self.tfNote.text = ""
                        self.tfSONumber.text = ""
                        self.showAlert(message:message ?? "")
                    }
                }
            }
        }
    }
    func showAlert(message: String){
        let alert = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let okaction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadingView(isShow: Bool){
        if(isShow){
            loadingIndicator.frame.size.height = 50
            loadingIndicator.startAnimating()
            btnSend.frame.origin.y = loadingIndicator.frame.size.height + loadingIndicator.frame.origin.y + Common.Size(s: 5)
            viewBox.frame.size.height = btnSend.frame.size.height + btnSend.frame.origin.y  + Common.Size(s: 10)
            overView.frame = viewBox.frame
        }else{
            loadingIndicator.frame.size.height = 0
            loadingIndicator.startAnimating()
            btnSend.frame.origin.y = loadingIndicator.frame.size.height + loadingIndicator.frame.origin.y + Common.Size(s: 5)
            viewBox.frame.size.height = btnSend.frame.size.height + btnSend.frame.origin.y  + Common.Size(s: 10)
            overView.frame = viewBox.frame
            overView.frame.size.height = 0
        }
    }
    fileprivate func createRadioButton(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 13)
        radioButton.setTitle(title, for: UIControl.State())
        radioButton.setTitleColor(.black, for: UIControl.State())
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(self.logSelectedButton), for: UIControl.Event.touchUpInside);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButton(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioDeposit.isSelected = false
            radioGuarantee.isSelected = false
            tfSONumber.layer.borderColor = UIColor.clear.cgColor
            tfNote.layer.borderColor = UIColor.clear.cgColor
            tfSONumber.borderStyle = UITextField.BorderStyle.roundedRect
            tfNote.borderStyle = UITextField.BorderStyle.roundedRect
            switch temp {
            case "Số SO đặt cọc":
                radioDeposit.isSelected = true
                break
            case "Số phiếu BH" :
                radioGuarantee.isSelected = true
                break
            default:
                break
            }
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(tfProduct == textField){
            return false
        }
        return true
    }
    @objc func searchProduct()
    {
        dropDown.show()
    }
    @objc func closeDialog(sender : UITapGestureRecognizer) {
        if(overView.frame.size.height == 0){
            self.dismiss(animated: true, completion: nil)
            self.view.endEditing(true)
        }
    }
}
