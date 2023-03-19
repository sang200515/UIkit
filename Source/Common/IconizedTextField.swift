//
//  CustomizedTextField.swift
//  TestMoya
//
//  Created by Trần Thành Phương Đăng on 5/16/18.
//  Copyright © 2018 fpt. All rights reserved.
//

import Foundation;
import UIKit;

@IBDesignable
class IconizedTextField: UITextField {
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds);
        textRect.origin.x += leftPadding;
        return textRect;
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView();
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0;
    
    @IBInspectable var borderThickness: CGFloat = 1{
        didSet{
            updateView();
        }
    }
    
    @IBInspectable var placeholderColor: UIColor = UIColor.white {
        didSet {
            updateView();
        }
    }
    
    @IBInspectable var isBottomBorder:Bool = false{
        didSet{
            updateView();
        }
    }
    
    @IBInspectable var imageTintColor:UIColor = UIColor.white{
        didSet{
            updateView();
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0 {
        didSet{
            updateView();
        }
    };
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always;
            let imageView = UIImageView(frame: CGRect(x: 0, y: self.frame.maxY, width: 17 + rightPadding, height: 17));
            imageView.contentMode = .scaleAspectFit;
            imageView.image = image;
            imageView.tintColor = imageTintColor;
            leftView = imageView;
        } else {
            leftViewMode = UITextField.ViewMode.never;
            leftView = nil;
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: placeholderColor]);
        
        //Handle Bottom Border
        if isBottomBorder{
            let border = CALayer();
            border.borderColor = imageTintColor.cgColor;
            border.frame = CGRect(x: 0, y: self.frame.size.height - borderThickness, width:  UIScreen.main.bounds.width, height: self.frame.size.height);
            
            border.borderWidth = borderThickness;
            self.layer.addSublayer(border);
            self.layer.masksToBounds = true;
        }
    }
}
