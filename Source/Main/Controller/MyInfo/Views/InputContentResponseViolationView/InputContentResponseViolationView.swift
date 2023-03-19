//
//  InputContentResponseViolationView.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/30/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

@objc protocol InputContentResponseViolationViewDelegate {
    func getOutput(_ output: String)
}

class InputContentResponseViolationView: BaseView {
    
    weak var delegate: InputContentResponseViolationViewDelegate?
    private var placeholderLabel: UILabel!
    private var textViewRatingSubmit: UITextView!
    private var labelTitle: UILabel!
    private var labelCountCharacters: UILabel!
    private var lineView: UIView!
    private var lengthCharacter: Int = 0
    private var containerView: UIView!
    
    override func setupViews() {
        super.setupViews()
        setupView()
    }
    
    private func setupView() {
        
        // Init
        containerView = UIView()
        textViewRatingSubmit = UITextView()
        labelTitle = UILabel()
        labelCountCharacters = UILabel()
        lineView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: 245, height: 100)
        labelCountCharacters.frame = CGRect(x: 0, y: 0, width: 100, height: 22)
        labelTitle.frame = CGRect(x: 0, y: 0, width: 100, height: 22)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        textViewRatingSubmit.translatesAutoresizingMaskIntoConstraints = false
        labelCountCharacters.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = .clear
        self.addSubview(containerView)
        containerView.myAnchorWithUIEdgeInsets(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        containerView.makeCorner(corner: Constants.Values.view_corner)
        
        
        // Title
        labelTitle.backgroundColor = .clear
        labelTitle.loadWith(text: "Nội dung: ", textColor: Constants.COLORS.text_gray, font: UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_12), textAlignment: .left)
        containerView.addSubview(labelTitle)
        labelTitle.myCustomAnchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 6, leadingConstant: 8, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        labelTitle.isHidden = true
        
        // Input content
        textViewRatingSubmit.textColor = Constants.COLORS.black_main
        textViewRatingSubmit.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        textViewRatingSubmit.backgroundColor = .clear
        containerView.addSubview(textViewRatingSubmit)
        textViewRatingSubmit.myCustomAnchor(top: containerView.topAnchor, leading: labelTitle.leadingAnchor, trailing: containerView.trailingAnchor, bottom: containerView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 10, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 80)
        
        textViewRatingSubmit.font = UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_13)
        textViewRatingSubmit.delegate = self
        textViewRatingSubmit.isScrollEnabled = true
        //        textViewRatingSubmit.returnKeyType = .done
        //        textViewRatingSubmit.backgroundColor = Constants.Colors.bg_input_enter_code
        
        // Counter label
        self.addSubview(labelCountCharacters)
        labelCountCharacters.myCustomAnchor(top: containerView.bottomAnchor, leading: nil, trailing: containerView.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        labelCountCharacters.loadWith(text: "\(lengthCharacter)/1000", textColor: Constants.COLORS.main_red_my_info, font: UIFont.regularFontOfSize(ofSize: 12), textAlignment: .left)
        
        // Placeholder input
        placeholderLabel = UILabel()
        placeholderLabel.text = "Nhập nội dung phản hồi"
        placeholderLabel.font = UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_16)
        placeholderLabel.sizeToFit()
        textViewRatingSubmit.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 6, y: (textViewRatingSubmit.font?.pointSize)! / 2)
        placeholderLabel.textColor = Constants.COLORS.text_gray
        placeholderLabel.isHidden = !textViewRatingSubmit.text.isEmpty
    }
}

extension InputContentResponseViolationView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        //        Estimate textview height when input chacraters
//        let size = CGSize(width: self.frame.width, height: .infinity)
//        let estimateSize = textView.sizeThatFits(size)
//        textView.constraints.forEach { (contraint) in
//            if contraint.firstAttribute == .height {
//                contraint.constant = estimateSize.height
//            }
//        }
        
        labelCountCharacters.loadWith(text: "\(textView.text.length)/1000", textColor: Constants.COLORS.main_red_my_info, font: UIFont.regularFontOfSize(ofSize: 12), textAlignment: .left)
        placeholderLabel.isHidden = !textViewRatingSubmit.text.isEmpty
        self.labelTitle.isHidden  = textViewRatingSubmit.text.isEmpty
        UIView.animate(withDuration: 0.35, delay: 0.0, options: .curveEaseOut, animations: {
            self.labelTitle.isHidden  = self.textViewRatingSubmit.text.isEmpty
        })
        delegate?.getOutput(textView.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //        if text == "\n" {
        //            textView.resignFirstResponder()
        //            return false
        //        }
        
        let currentText = textView.text ?? ""
        guard let stringLength =  Range(range, in: currentText) else { return false }
        let updateText = currentText.replacingCharacters(in: stringLength, with: text)
        return updateText.length <= 1000
    }
    
}
