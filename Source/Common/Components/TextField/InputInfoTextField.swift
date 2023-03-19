//
//  InputInfoTextField.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 18/04/2022.
//

import UIKit

protocol InputInfoTextFieldDelegate:AnyObject {
    func didSelected(index:Int)
}

class InputInfoTextField : UIView {
 
    var styleTextField:UITextField.BorderStyle?{
        didSet {
            self.textField.borderStyle = styleTextField ?? .none
        }
    }
    
    var hideLineView:Bool? {
        didSet {
            self.lineView.isHidden = hideLineView ?? false
        }
    }
    
    var titleTextField:String? {
        didSet {
            self.titleLabel.text = titleTextField
        }
    }
    
    var colorText:UIColor? {
        didSet {
            self.textField.textColor = colorText
        }
    }
    
    var placeHolder:String? {
        didSet {
            self.textField.placeholder = placeHolder
        }
    }
        
    var colorLineView:UIColor? {
        didSet {
            self.lineView.backgroundColor = colorLineView
        }
    }
    
    var iconImage:UIImage? {
        didSet {
            self.iconRight.image = iconImage
        }
    }
    
    var isSelected:Bool? = false {
        didSet {
            if isSelected ?? false {
                self.viewSelected.isHidden = false
                self.addAction()
            }
        }
    }
    
    var isDate:Bool? = false {
        didSet {
            if isDate ?? false {
                self.viewSelected.isHidden = false
                self.iconRight.isHidden = true
                self.addAction()
            }
        }
    }
    
    var styleKeyboard:UIKeyboardType? {
        didSet {
            self.textField.keyboardType = self.styleKeyboard ?? UIKeyboardType.alphabet
        }
    }
    
    var isCurrency:Bool? {
        didSet {
            self.textField.isHidden = true
            self.currencyTextField.isHidden = false
        }
    }
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    let textField:UITextField = {
        let textField = UITextField()
        textField.textColor = .darkGray
        textField.font = .systemFont(ofSize: 15)
        return textField
    }()
    
    let currencyTextField:CurrencyTextField = {
        let textField = CurrencyTextField()
        textField.textColor = .darkGray
        textField.isHidden = true
        textField.font = .systemFont(ofSize: 15)
        return textField
    }()
    
    private let lineView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let iconRight:UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let viewSelected:UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    weak var delegate:InputInfoTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView(){
        self.addSubview(self.titleLabel)
        self.addSubview(self.textField)
        self.addSubview(self.currencyTextField)
        self.addSubview(self.iconRight)
        self.addSubview(self.lineView)
        self.addSubview(self.viewSelected)
    }
    
    private func autoLayout(){
        self.titleLabel.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(10)
            make.height.greaterThanOrEqualTo(18)
        }
        self.textField.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        self.currencyTextField.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.textField)
        }
        self.iconRight.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalTo(self.textField)
            make.height.width.equalTo(15)
        }
        self.lineView.snp.makeConstraints { make in
            make.bottom.equalTo(self.textField.snp.bottom).offset(1)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        self.viewSelected.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalTo(self.textField)
        }
    }
    
    private func addAction(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.selectedTapped))
        self.viewSelected.addGestureRecognizer(gesture)
    }
    
    @objc private func selectedTapped(){
        self.delegate?.didSelected(index: self.tag)
    }
}
