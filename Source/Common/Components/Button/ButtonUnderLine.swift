//
//  ButtonUnderLine.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 13/05/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ButtonUnderLine:UIButton {
    
    var isSelect:Bool? {
        didSet {
            self.addBottomBorder(with: isSelect ?? false ? .mainGreen : .white, andWidth: 2)
            self.setTitleColor(isSelect ?? false ? .mainGreen : .lightGray, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonClicked(sender: UIButton) {
        
    }
}
