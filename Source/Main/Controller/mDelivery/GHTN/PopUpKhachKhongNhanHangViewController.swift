//
//  PopUpKhachKhongNhanHangViewController.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 11/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol PopUpKhachKhongNhanHangViewControllerDelegate : AnyObject {
    func xacNhanHandle(content:String)
}

class PopUpKhachKhongNhanHangViewController : UIViewController {
    
    weak var delegate:PopUpKhachKhongNhanHangViewControllerDelegate?
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Lý Do Khách Không Nhận Hàng"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    let lydoLabel:UILabel = {
        let label = UILabel()
        label.text = "Lý do:"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        return label
    }()
    
    let contentTextView:UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.textColor = .lightGray
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 0.5
        textView.font = .systemFont(ofSize: 15)
        textView.clipsToBounds = true
        textView.text = "Nhập lý do"
        return textView
    }()
    
    let xacNhanButton:UIButton = {
        let button = UIButton()
        button.setTitle("Xác nhận", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.addTarget(self, action: #selector(xacNhanHandle), for: .touchUpInside)
        button.setTitleColor(UIColor.mainGreen, for: .normal)
        return button
    }()
    
    let viewBackGround:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.layoutView()
        self.configureTextView()
    }
    
    private func configureTextView(){
        self.contentTextView.delegate = self
    }
    
    private func  layoutView(){
        self.view.addSubview(self.contentTextView)
        self.view.addSubview(self.lydoLabel)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.xacNhanButton)
        self.view.addSubview(self.viewBackGround)
        
        self.contentTextView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(355)
            make.height.equalTo(100)
        }
        self.lydoLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.contentTextView)
            make.bottom.equalTo(self.contentTextView.snp.top).offset(-10)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.lydoLabel.snp.top).offset(-10)
            make.leading.trailing.equalTo(self.contentTextView)
        }
        self.xacNhanButton.snp.makeConstraints { make in
            make.top.equalTo(self.contentTextView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.contentTextView)
            make.height.equalTo(40)
        }
        self.viewBackGround.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.top).offset(-15)
            make.leading.equalTo(self.titleLabel).offset(-15)
            make.trailing.equalTo(self.titleLabel).offset(15)
            make.bottom.equalTo(self.xacNhanButton.snp.bottom).offset(5)
        }
        self.view.insertSubview(self.viewBackGround, at: 0)
    }
    
    @objc private func xacNhanHandle(){
        if self.contentTextView.text == "" {
            AlertManager.shared.alertWithViewController(title: "Thông Báo", message: "Vui lòng nhập nội dung trước khi xác nhận", titleButton: "OK", viewController: self) {
                
            }
            return
        }
        self.dismiss(animated: true) {
            self.delegate?.xacNhanHandle(content: self.contentTextView.text ?? "")
        }
    }
}

extension PopUpKhachKhongNhanHangViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Nhập lý do" {
            textView.text = ""
            textView.textColor = .darkGray
        }
    }
}
