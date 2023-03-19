//
//  CustomSegmentControl.swift
//  fptshop
//
//  Created by DiemMy Le on 7/31/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol CustomSegmentControlDelegate:AnyObject {
    func change(to index:Int)
}

class CustomSegmentControl: UIView {
    var buttonTitles = [String]()
    var buttons: [UIButton] = [UIButton]()
    var selectorView: UIView!
    
    var selectorViewColor: UIColor = .red
    var selectorTextColor: UIColor = .red
    var unSelectorViewColor: UIColor = .lightGray
    var unSelectorTextColor: UIColor = .lightGray
    
    weak var delegate:CustomSegmentControlDelegate?
    
    public private(set) var selectedIndex : Int = 0
    
    convenience init(frame:CGRect,buttonTitle:[String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
        updateView()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }
    
    func setButtonTitles(buttonTitles:[String]) {
        self.buttonTitles = buttonTitles
        self.updateView()
    }
    
    func setIndex(index:Int) {
        buttons.forEach({ $0.setTitleColor(unSelectorTextColor, for: .normal) })
        buttons.forEach({$0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15); $0.setTitleColor(unSelectorTextColor, for: .normal)})
        
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        buttons.forEach({$0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15); $0.setTitleColor(selectorTextColor, for: .normal)})
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame.origin.x = selectorPosition
        }
    }
    
    @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(unSelectorTextColor, for: .normal)
            buttons.forEach({$0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15); $0.setTitleColor(unSelectorTextColor, for: .normal)})
            if btn == sender {
                let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                selectedIndex = buttonIndex
                delegate?.change(to: selectedIndex)
                UIView.animate(withDuration: 0.2) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
                buttons.forEach({$0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15); $0.setTitleColor(selectorTextColor, for: .normal)})
            }
        }
    }
}

//Configuration View
extension CustomSegmentControl {
    private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func configSelectorView() {
        let selectorWidth = self.frame.width / CGFloat(self.buttonTitles.count)
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: selectorWidth, height: 3))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
        
        self.bringSubviewToFront(selectorView)
    }
    
    private func createButton() {
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .custom)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(unSelectorTextColor, for: .normal)
            buttons.forEach({$0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15); $0.setTitleColor(unSelectorTextColor, for: .normal)})
            buttons.append(button)
            button.addTarget(self, action:#selector(CustomSegmentControl.buttonAction(sender:)), for: .touchUpInside)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        buttons.forEach({$0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15); $0.setTitleColor(selectorTextColor, for: .normal)})
    }
}

