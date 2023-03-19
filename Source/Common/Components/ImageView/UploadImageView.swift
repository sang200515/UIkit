//
//  UploadImageView.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 13/05/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol UploadImageViewDelegate:AnyObject {
    func selectedTapped(tag:Int)
}

class UploadImageView: UIImageView {

    weak var delegate:UploadImageViewDelegate?
    
    var imageSet:UIImage? {
        didSet {
            self.image = imageSet
            if self.image == UIImage(named: "UploadPhotoICON"){
                _border.strokeColor = UIColor.darkGray.cgColor
                self.contentMode = .center
            }else {
                self.contentMode = .scaleAspectFit
                _border.strokeColor = UIColor.clear.cgColor
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {

        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
 
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return CGSize(width: myViewWidth, height: scaledHeight)
        }

        return CGSize(width: -1.0, height: -1.0)
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func selectedTapped(){
        self.delegate?.selectedTapped(tag: self.tag)
    }
    
    let _border = CAShapeLayer()
    
    init() {
        super.init(frame: .zero)
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.selectedTapped))
        self.addGestureRecognizer(tap)
        setup()
    }
    
    func setup() {
        self.contentMode = .center
        self.backgroundColor = .lightGray.withAlphaComponent(0.5)
        self.layer.cornerRadius = 5
        self.contentMode = .center
        self.backgroundColor = .lightGray
        self.image = UIImage(named: "UploadPhotoICON")
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
