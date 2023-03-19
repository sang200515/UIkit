//
//  TextFieldCoreICT.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 17/10/2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol TextFieldCoreICTDelegate:AnyObject {
    func actionButton()
}

class TextFieldCoreICT : UIView {
    
    let bag = DisposeBag()
    weak var delegate:TextFieldCoreICTDelegate?
    
    var isShowButton:Bool = false {
        didSet {
            self.iconButton.isHidden = !self.isShowButton
            if self.isShowButton == true {
                self.iconButton.rx.tap.subscribe { [weak self] _ in
                    self?.actionButton()
                }
                .disposed(by: self.bag)
            }
        }
    }
    
    var titleString:String? {
        didSet {
            self.titleLabel.text = self.titleString ?? ""
        }
    }
    
    var typeKeyBoard:UIKeyboardType? {
        didSet {
            self.textField.keyboardType = self.typeKeyBoard ?? .alphabet
        }
    }
    
    var placeholder:String? {
        didSet {
            self.textField.placeholder = self.placeholder ?? ""
        }
    }
    
    var text:String? {
        didSet {
            self.textField.text = self.text
        }
    }
    
    var isRequeied:Bool = false {
        didSet {
            self.requiedLabel.isHidden = !(self.isRequeied)
        }
    }
    
    var isDisableField:Bool = false {
        didSet {
            self.textField.isEnabled = !self.isDisableField
            self.textField.backgroundColor = (self.isDisableField) ? UIColor(hexString: "E8E8E8") : .white
        }
    }
    
    lazy var iconButton:UIButton = {
        let button = UIButton()
        button.isHidden = !self.isShowButton
        button.setImage(UIImage(named: "scanCOREICT"), for: .normal)
        return button
    }()
    
     lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var requiedLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .red
        label.text = "(*)"
        return label
    }()
    
    lazy var textField : UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 15)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        
    }
    
    private func addView(){
        self.addSubview(self.titleLabel)
        self.addSubview(self.requiedLabel)
        self.addSubview(self.textField)
        self.addSubview(self.iconButton)
        self.layoutView()
    }
    
    private func layoutView(){
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        self.requiedLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.titleLabel.snp.trailing)
            make.top.equalTo(self.titleLabel)
        }
        self.textField.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        self.iconButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.textField)
            make.centerY.equalTo(self.textField)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func actionButton(){
        self.delegate?.actionButton()
    }
    
}
