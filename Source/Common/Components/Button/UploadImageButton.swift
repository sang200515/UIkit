//
//  UploadImageButton.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 13/05/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class UploadImageButton: UIButton {
    
    var imageSet:UIImage? {
        didSet {
            self.setImage(imageSet, for: .normal)
            if self.imageView?.image == UIImage(named: "UploadPhotoICON"){
                _border.strokeColor = UIColor.darkGray.cgColor
                self.imageView?.contentMode = .center
                self.backgroundColor = .lightGray.withAlphaComponent(0.1)
            }else {
                self.backgroundColor = .clear
                self.imageView?.contentMode = .scaleAspectFit
                _border.strokeColor = UIColor.clear.cgColor
            }
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let _border = CAShapeLayer()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    func setup() {
        self.contentMode = .center
        self.layer.cornerRadius = 5
        self.contentMode = .center
        self.backgroundColor = .lightGray
        self.setImage(UIImage(named: "UploadPhotoICON"), for: .normal)
        _border.lineWidth = 2
        _border.strokeColor = UIColor.darkGray.cgColor
        _border.fillColor = nil
        _border.lineDashPattern = [4, 4]
        self.layer.addSublayer(_border)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius:5).cgPath
        _border.frame = self.bounds
    }
    
}
