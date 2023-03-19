//
//  PopAlertCreateIPScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/9/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

@objc protocol PopAlerCreateIPScreenDelegate {
    func tappedOk()
}

class PopAlertCreateIPScreen: BaseController {
    
    var popAlertCreateIPScreenDelegate: PopAlerCreateIPScreenDelegate?
    
    fileprivate var actionOk : (() -> ())?
    fileprivate var actionCancel: (() -> ())?
    
    let vMainContainer: UIView = {
        let view = UIView()
        view.makeCorner(corner: 8)
        view.backgroundColor = .white
        return view
    }()
    
    let vHeader: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.COLORS.bold_green
        return view
    }()
    
    let lbHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: Constants.TextSizes.size_13)
        label.text = "Thông báo"
        label.textColor = .white
        return label
    }()
    
    let btnClosePopup: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "Close"), for: .normal)
        return button
    }()
    
    let btnCancel: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.COLORS.bold_green
        button.setTitle("Huỷ", for: .normal)
        button.setTitleColor(Constants.COLORS.main_color_white, for: .normal)
        button.makeCorner(corner: 8)
        return button
    }()
    
    let lbDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.textColor = .black
        return label
    }()
    
    let btnOk: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.COLORS.bold_green
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(Constants.COLORS.main_color_white, for: .normal)
        button.makeCorner(corner: 8)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        self.view.backgroundColor = Constants.COLORS.black_main.withAlphaComponent(0.7)
        
        self.view.addSubview(vMainContainer)
        vMainContainer.myCustomAnchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, centerX: nil, centerY: view.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 40, trailingConstant: 40, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        let heightConstraint = NSLayoutConstraint(
                item: vMainContainer,
                attribute: .height,
                relatedBy: .greaterThanOrEqual,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1.0,
                constant: 150
        )
        vMainContainer.addConstraints([heightConstraint])
        
        vMainContainer.addSubview(vHeader)
        vHeader.myCustomAnchor(top: vMainContainer.topAnchor, leading: vMainContainer.leadingAnchor, trailing: vMainContainer.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 40)
        
        vHeader.addSubview(lbHeader)
        lbHeader.myCustomAnchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: vHeader.centerXAnchor, centerY: vHeader.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 100, heightConstant: 0)
        
        vHeader.addSubview(btnClosePopup)
        btnClosePopup.myCustomAnchor(top: nil, leading: nil, trailing: vHeader.trailingAnchor, bottom: nil, centerX: nil, centerY: lbHeader.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 20, heightConstant: 20)
        btnClosePopup.addTarget(self, action: #selector(tapCloseButton(_:)), for: .touchUpInside)
        
        vMainContainer.addSubview(lbDescription)
        lbDescription.myCustomAnchor(top: vHeader.bottomAnchor, leading: self.vMainContainer.leadingAnchor, trailing: self.vMainContainer.trailingAnchor, bottom: nil, centerX: vMainContainer.centerXAnchor, centerY: nil, width: nil, height: nil, topConstant: 8, leadingConstant: 8, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        let stackViewButton = UIStackView(arrangedSubviews: [btnCancel, btnOk])
        stackViewButton.axis = .horizontal
        stackViewButton.distribution = .fillEqually
        stackViewButton.spacing = 10
        
        vMainContainer.addSubview(stackViewButton)
        stackViewButton.myAnchorWithUIEdgeInsets(top: lbDescription.bottomAnchor, leading: vMainContainer.leadingAnchor, bottom: vMainContainer.bottomAnchor, trailing: vMainContainer.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16), size: CGSize(width: 0, height: 35))
        btnOk.addTarget(self, action: #selector(tapOkButton(_:)), for: .touchUpInside)
        
        btnCancel.addTarget(self, action: #selector(tapCancelButton(_:)), for: .touchUpInside)
        
        
    }
    
    @objc private func tapCloseButton(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func tapOkButton(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
        if let action = actionOk {
            action()
        }
        self.popAlertCreateIPScreenDelegate?.tappedOk()
    }
    
    @objc private func tapCancelButton(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
        if let action = actionCancel {
            action()
        }
    }
    
    func loadDescriptionResponse(_ message: String) {
        self.lbDescription.text = message
    }
    
    func loadDescriptionHTML(_ description: String) {
        let converted = description.htmlAttributed(using: UIFont.systemFont(ofSize: 11), color: Constants.COLORS.black_main)
        self.lbDescription.attributedText = converted
    }
    
    func setupUI(_ titleButtonOk: String?, titleButtonCancel: String?, isShowButtonOk: Bool? = false, isShowButtonCancel: Bool? = false, title: String? = nil) {
        btnOk.setTitle(titleButtonOk, for: .normal)
        btnOk.isHidden = isShowButtonOk ?? false
        btnCancel.isHidden = isShowButtonCancel ?? false
        btnCancel.setTitle(titleButtonCancel, for: .normal)
        btnClosePopup.isHidden = true
        lbHeader.text = title
    }
    
    func actionOkTapped(action: (() -> ())?) {
        self.actionOk = action
    }
    
    func actionCancelTapped(action: (()->())?) {
        self.actionCancel = action
    }
}
