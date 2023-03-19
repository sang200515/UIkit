//
//  AlertManager.swift
//  Fpharmacy
//
//  Created by DungTV1991 on 5/20/21.
//  Copyright © 2021 DungTV1991. All rights reserved.
//

import UIKit
import PopupDialog
import RxCocoa
import RxSwift

class AlertManager {
    static let shared = AlertManager()
    private init(){
        
    }
    
    func alertWithViewController( title:String,
                                  message:String,
                                  titleButton:String,
                                  viewController:UIViewController,
                                  completion : @escaping () -> Void
    ) {
        
        let popup = PopupDialog(title: title, message: message, image: nil)
        let buttonOne = CancelButton(title: "OK") {
            completion()
        }
        popup.addButton(buttonOne)
        viewController.present(popup, animated: true, completion: nil)
    }
    
    func alertWithRootViewController( title:String,
                                      message:String,
                                      titleButton:String,
                                      completion: @escaping () -> Void
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: titleButton, style: UIAlertAction.Style.default) {
            UIAlertAction in
            completion()
        }
        alertController.addAction(okAction)
        var keyWindow: UIWindow?
        DispatchQueue.main.async {
            if #available(iOS 13, *) {
                keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
            }else {
                keyWindow = UIApplication.shared.keyWindow
            }
            keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlertMultiOption(title: String, message: String, options: String...,viewController:UIViewController,buttonAlignment:NSLayoutConstraint.Axis, completion: @escaping (Int) -> Void) {
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: buttonAlignment,
                                transitionStyle: .zoomIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: true,
                                hideStatusBar: false)
        for (index, option) in options.enumerated() {
            let buttonOne = CancelButton(title: option) {
                completion(index)
            }
            popup.addButton(buttonOne)
            
        }
        viewController.present(popup, animated: true, completion: nil)
    }
    
    func alertCoreICT(title:String,
                      message:String = "",
                      colorTitle:UIColor,
                      colorButtons:UIColor...,
                      placeholder:String?,
                      buttons:String...,
                      isTextField:Bool = false,
                      key:Int = 1,
                      isNumber:Bool = false,
                      self:UIViewController,
                      completion: @escaping (String?,Int) -> Void){
        
        let attributedString = NSAttributedString(string: title, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15,weight: .semibold),
            NSAttributedString.Key.foregroundColor : colorTitle
        ])
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.setValue(attributedString, forKey: "attributedTitle")
        
        if isTextField {
            alert.addTextField { (textField) in
                textField.placeholder = placeholder
                textField.keyboardType = isNumber ? .numberPad : .asciiCapable
            }
        }

        for i in 0..<buttons.count {
            let action = UIAlertAction(title: buttons[i],
                                          style: .default,
                                          handler: { [weak alert] (_) in
                if isTextField && key == i {
                    let textField = alert?.textFields?[0].text ?? ""
                    completion(textField, i)
                }
                completion(nil, i)
            })
            action.setValue(colorButtons[i], forKey: "titleTextColor")
            alert.addAction(action)
        }

        self.present(alert, animated: true, completion: nil)
    }
    
}


