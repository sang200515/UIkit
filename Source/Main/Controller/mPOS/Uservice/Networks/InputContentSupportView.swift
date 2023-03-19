//
//  InputContentSupportView.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/15/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol InputContentSupportViewDelegate {
    func outputContent(_ content: String)
}

class InputContentSupportView: BaseView {
    
    private var placeholderLabel: UILabel!
    
    let lbTitle: UILabel = {
       let label = UILabel()
        label.font = UIFont.regularFont(size: Constants.TextSizes.size_13)
        label.text = "Nội dung cần hỗ trợ: "
        label.textColor = .black
        return label
    }()
    
    var inputContentSupportViewDelegate: InputContentSupportViewDelegate?
    
    override func setupViews() {
        super.setupViews()
        createTextView()
    }
    
    private func createTextView() {
        let textView = UITextView()
        textView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        
        self.addSubview(lbTitle)
        self.lbTitle.myCustomAnchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 1, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.addSubview(textView)
        textView.setBorder(color: Constants.COLORS.text_gray, borderWidth: 0.5, corner: 8)
        // use auto layout to set my textview frame...kinda
        textView.translatesAutoresizingMaskIntoConstraints = false
        [
            textView.topAnchor.constraint(equalTo: self.lbTitle.bottomAnchor, constant: 4),
            textView.leadingAnchor.constraint(equalTo: self.lbTitle.leadingAnchor, constant: 0),
            textView.trailingAnchor.constraint(equalTo: self.lbTitle.trailingAnchor, constant: 0),
            textView.heightAnchor.constraint(equalToConstant: 80)
            ].forEach{ $0.isActive = true }
        
        textView.font = UIFont.regularFont(size: Constants.TextSizes.size_14)
        
        textView.delegate = self
        textView.isScrollEnabled = false
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "Nhập nội dung cần hỗ trợ vào"
        placeholderLabel.font = UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_13)
        placeholderLabel.sizeToFit()
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 6, y: (textView.font?.pointSize)! / 2)
        placeholderLabel.textColor = Constants.COLORS.text_gray
        placeholderLabel.isHidden = !textView.text.isEmpty
        textViewDidChange(textView)
    }
}

extension InputContentSupportView : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        inputContentSupportViewDelegate?.outputContent(textView.text ?? "")
        print(textView.text ?? "")
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
