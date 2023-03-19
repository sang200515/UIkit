//
//  ContainerContentSendView.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/30/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol ContainerContentSendViewDelegate {
    func sendAction()
    func outputContentResponse(_ content: String)
}

class ContainerContentSendView: BaseView {
    var delegate: ContainerContentSendViewDelegate?
    private var labelCountCharacters: UILabel!
    private var lengthCharacter: Int = 0
    private var placeholderLabel: UILabel!
    
    override func setupViews() {
        super.setupViews()
        createTextView()
    }
    
    private func createTextView() {
        let buttonSend = UIButton(type: .system)
        buttonSend.setTitle("Gửi", for: .normal)
        buttonSend.backgroundColor = Constants.COLORS.bold_green
        buttonSend.setTitleColor(.white, for: .normal)
        buttonSend.setBorder(color: .lightGray, borderWidth: 0.5, corner: 8)
        
        let textView = UITextView()
        textView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        labelCountCharacters = UILabel()
        labelCountCharacters.frame = CGRect(x: 0, y: 0, width: 100, height: 22)
        
        self.addSubview(textView)
        textView.setBorder(color: Constants.COLORS.text_gray, borderWidth: 0.5, corner: 15)
        // use auto layout to set my textview frame...kinda
        textView.translatesAutoresizingMaskIntoConstraints = false
        [
            textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            textView.heightAnchor.constraint(equalToConstant: 50)
            ].forEach{ $0.isActive = true }
        
        textView.font = UIFont.regularFontOfSize(ofSize: 14)
        self.addSubview(buttonSend)
        buttonSend.translatesAutoresizingMaskIntoConstraints = false
        [
            buttonSend.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            buttonSend.leadingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 8),
            buttonSend.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            buttonSend.widthAnchor.constraint(equalToConstant: 80),
            buttonSend.heightAnchor.constraint(equalToConstant: 40),
            ].forEach{$0.isActive = true}
        buttonSend.addTarget(self, action: #selector(sendToggle), for: .touchUpInside)
        self.addSubview(labelCountCharacters)
        labelCountCharacters.myCustomAnchor(top: textView.bottomAnchor, leading: textView.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 100, heightConstant: 30)
        labelCountCharacters.loadWith(text: "\(lengthCharacter)/1000", textColor: Constants.COLORS.main_red_my_info, font: UIFont.regularFontOfSize(ofSize: 12), textAlignment: .left)
        textView.delegate = self
        textView.isScrollEnabled = false
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "Nhập nội dung phản hồi"
        placeholderLabel.font = UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_13)
        placeholderLabel.sizeToFit()
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 6, y: (textView.font?.pointSize)! / 2)
        placeholderLabel.textColor = Constants.COLORS.text_gray
        placeholderLabel.isHidden = !textView.text.isEmpty
        textViewDidChange(textView)
    }
    
    @objc private func sendToggle(_ button: UIButton) {
        delegate?.sendAction()
    }
}

extension ContainerContentSendView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        delegate?.outputContentResponse(textView.text ?? "")
        print(textView.text ?? "")
        let size = CGSize(width: self.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        labelCountCharacters.loadWith(text: "\(textView.text.length)/1000", textColor: Constants.COLORS.main_red_my_info, font: UIFont.regularFontOfSize(ofSize: 12), textAlignment: .left)
        placeholderLabel.isHidden = !textView.text.isEmpty
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = textView.text ?? ""
        guard let stringLength =  Range(range, in: currentText) else { return false }
        let updateText = currentText.replacingCharacters(in: stringLength, with: text)
        return updateText.length <= 1000
    }
}
