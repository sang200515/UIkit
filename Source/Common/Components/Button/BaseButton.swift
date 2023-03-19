//
//  BaseButton.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 13/05/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class BaseButton : UIButton  {
    
    var title:String?{
        didSet {
            self.setTitle(self.title, for: .normal)
        }
    }
    
    override open var isEnabled: Bool {
        didSet {
            if self.isEnabled {
                self.alpha = 1.0
            }
            else {
                self.alpha = 0.5
            }
            //make sure button is updated
            self.layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        self.backgroundColor = .mainGreen
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
