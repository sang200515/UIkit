//
//  UIViewController+Extension.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog

extension UIViewController {
    
    func showPopUpCustom(title: String? = nil, titleButtonOk: String? = nil, titleButtonCancel: String? = nil, message: String? = nil, actionButtonOk: (()->())?, actionButtonCancel: (()->())?, isHideButtonOk: Bool? = nil, isHideButtonCancel: Bool? = nil) {
        let vc = PopAlertCreateIPScreen()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.setupUI(titleButtonOk, titleButtonCancel: titleButtonCancel, isShowButtonOk: isHideButtonOk, isShowButtonCancel: isHideButtonCancel, title: title)
        
        vc.actionCancelTapped {
            if let action = actionButtonCancel {
                action()
            }
        }
        
        vc.actionOkTapped {
            if let action = actionButtonOk {
                action()
            }
        }
        if let description = message {
            vc.loadDescriptionHTML(description)
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func showPopUpTwoButtons(message: String,title:String, title1: String,title2: String, handleButtonOne: (() -> Void)? = nil,handleButtonTwo: (() -> Void)? = nil) {
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
        }
        let buttonOne = DefaultButton(title: title1) {
            if let act = handleButtonOne {
                act()
            }
        }
        let buttonTwo = DefaultButton(title: title2) {
            if let act = handleButtonTwo {
                act()
            }
        }
        buttonOne.titleFont = UIFont.systemFont(ofSize: 12)
        buttonTwo.titleFont = UIFont.systemFont(ofSize: 12)
        popup.addButtons([buttonOne,buttonTwo])
        self.present(popup, animated: true, completion: nil)
    }
    
    func showPopUp(_ message: String, _ title: String, buttonTitle: String, handleOk: (() -> Void)? = nil) {
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
        }
        let buttonOne = CancelButton(title: buttonTitle) {
            if let act = handleOk {
                act()
            }
        }
        popup.addButtons([buttonOne])
        self.present(popup, animated: true, completion: nil)
    }
    
    func showAlertOneButton(title: String, with message: String, titleButton: String, handleOk: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: titleButton, style: .cancel, handler: { (action) in
            if let act = handleOk {
                act()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertTwoButton(title: String, with message: String, titleButtonOne: String, titleButtonTwo: String, handleButtonOne: (() -> Void)? = nil, handleButtonTwo: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: titleButtonOne, style: UIAlertAction.Style.default, handler: { (_) in
            handleButtonOne?()
        }))
        alert.addAction(UIAlertAction(title: titleButtonTwo, style: UIAlertAction.Style.destructive, handler: { (_) in
            handleButtonTwo?()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func showAlertWithTitleColor(colorTitle:UIColor,titleAlert: String, with message: String, titleButton: String, handleOk: (() -> Void)? = nil) {
        let attributedString = NSAttributedString(string: titleAlert, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15,weight: .bold),
            NSAttributedString.Key.foregroundColor : colorTitle
        ])

        let alert = UIAlertController(title: "", message: message,  preferredStyle: .alert)

        alert.setValue(attributedString, forKey: "attributedTitle")

        alert.addAction(UIAlertAction(title: titleButton, style: .cancel, handler: { (action) in
            if let act = handleOk {
                act()
            }
        }))

        present(alert, animated: true, completion: nil)
    }
    
    func showAlertMultiOption(title: String, message: String, options: String...,buttonAlignment:NSLayoutConstraint.Axis, completion: @escaping (Int) -> Void) {
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: buttonAlignment,
                                transitionStyle: .zoomIn,
                                tapGestureDismissal: false,
                                panGestureDismissal: false,
                                hideStatusBar: false)
        for (index, option) in options.enumerated() {
            let buttonOne = CancelButton(title: option) {
                completion(index)
            }
            popup.addButton(buttonOne)
            
        }
        self.present(popup, animated: true, completion: nil)
    }

    
    @discardableResult
    func customActivityIndicatory(_ viewContainer: UIView, startAnimate:Bool? = true) -> UIActivityIndicatorView {
        let mainContainer: UIView? = UIView(frame: viewContainer.frame)
        mainContainer?.center = viewContainer.center
        mainContainer?.backgroundColor = .clear
        mainContainer?.alpha = 0.5
        mainContainer?.tag = 789456123
        mainContainer?.isUserInteractionEnabled = true
        
        let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))
        viewBackgroundLoading.center = viewContainer.center
        viewBackgroundLoading.backgroundColor = Constants.COLORS.black_main
        viewBackgroundLoading.alpha = 0.5
        viewBackgroundLoading.clipsToBounds = true
        viewBackgroundLoading.layer.cornerRadius = 15
        
        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
        activityIndicatorView.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
        if startAnimate!{
            viewBackgroundLoading.addSubview(activityIndicatorView)
            mainContainer?.addSubview(viewBackgroundLoading)
            viewContainer.addSubview(mainContainer!)
            activityIndicatorView.startAnimating()
        }else{
            for subview in viewContainer.subviews{
                if subview.tag == 789456123{
                    subview.removeFromSuperview()
                }
            }
        }
        return activityIndicatorView
    }
}
