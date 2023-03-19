//
//  InputTextFieldView.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/15/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

@objc protocol InputTextFieldViewDelegate {
    @objc optional func textFieldDidBeginEditing(_ textField: UITextField)
    @objc optional func textFieldDidEndEditing(_ textField: UITextField)
    @objc optional func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    @objc optional func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
}

class InputTextFieldView: BaseView {
    
    let lbTitle: UILabel = {
       let label = UILabel()
        label.font = UIFont.regularFont(size: Constants.TextSizes.size_13)
        label.textColor = Constants.COLORS.black_main
        return label
    }()
    
    let tfInput: UITextField = {
       let tf = UITextField()
        tf.font = UIFont.regularFont(size: Constants.TextSizes.size_13)
        tf.setBorder(color: Constants.COLORS.bg_gray_popup, borderWidth: 1, corner: 8)
        return tf
    }()
    
    var isPickerView: Bool = false {
        didSet {
            self.showDropDownRightView(isShow: isPickerView)
        }
    }
    
    weak var inputTextFieldViewDelegate : InputTextFieldViewDelegate?
    
    override func setupViews() {
        super.setupViews()
        
        self.addSubview(lbTitle)
        lbTitle.myCustomAnchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 1, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        tfInput.leftView = paddingView
        tfInput.leftViewMode = .always
        
        tfInput.delegate = self
        self.addSubview(tfInput)
        tfInput.myCustomAnchor(top: lbTitle.bottomAnchor, leading: lbTitle.leadingAnchor, trailing: lbTitle.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 40)
        
        let arrowImgView1 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg1 = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg1.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView1.addSubview(arrowImg1)
        tfInput.rightView = arrowImgView1
        tfInput.rightViewMode = UITextField.ViewMode.never
    }
    
    func loadType_listGroupFeatures() {
        self.tfInput.placeholder = "Nhóm chức năng"
        self.tfInput.keyboardType = .default
        self.tfInput.autocorrectionType = .no
        self.tfInput.autocapitalizationType = .none
        lbTitle.text = "Nhóm chức năng:"
        isPickerView = true
    }
    
    func loadType_features() {
        self.tfInput.placeholder = "Chức năng"
        self.tfInput.keyboardType = .default
        self.tfInput.autocorrectionType = .no
        self.tfInput.autocapitalizationType = .none
        lbTitle.text = "Chức năng: "
        isPickerView = true
    }
    
    func loadNameCustomerFollowZalo() {
        self.tfInput.keyboardType = .default
        self.tfInput.autocorrectionType = .no
        self.tfInput.autocapitalizationType = .none
        lbTitle.text = "Tên khách hàng "
        isPickerView = false
    }
    
    func loadPhoneNumberCustomerFollowZalo() {
        self.tfInput.keyboardType = .phonePad
        self.tfInput.autocorrectionType = .no
        self.tfInput.autocapitalizationType = .none
        lbTitle.text = "Số điện thoại"
        isPickerView = false
    }
    
    private func showDropDownRightView (isShow : Bool) {
        tfInput.rightViewMode = isShow == true ? UITextField.ViewMode.always : UITextField.ViewMode.never
    }
    
    func getTextInput() -> String {
        return tfInput.text ?? ""
    }
    
}

extension InputTextFieldView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.inputTextFieldViewDelegate?.textFieldDidBeginEditing?(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.inputTextFieldViewDelegate?.textFieldDidBeginEditing?(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.inputTextFieldViewDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.inputTextFieldViewDelegate?.textFieldShouldBeginEditing?(textField) ?? true
    }
}
