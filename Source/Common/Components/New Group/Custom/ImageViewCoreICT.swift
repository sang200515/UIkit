//
//  ImageViewCoreICT.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 20/10/2022.
//

import UIKit

protocol ImageViewCoreICTDelegate:AnyObject {
    func imagePicker(index:Int)
}

class ImageViewCoreICT : UIImageView {
    
    weak var delegate:ImageViewCoreICTDelegate?
//
//    var imageSet:UIImage? {
//        didSet {
//            self.image = imageSet
//            if self.image == UIImage(named: "UploadPhotoICON"){
//                _border.strokeColor = UIColor.darkGray.cgColor
//                self.contentMode = .center
//            }else {
//                self.contentMode = .scaleAspectFit
//                _border.strokeColor = UIColor.clear.cgColor
//            }
//        }
//    }
//
    override var image: UIImage? {
        didSet {
            self.contentMode = .scaleAspectFit
            _border.strokeColor = UIColor.clear.cgColor
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
        self.delegate?.imagePicker(index: self.tag)
    }
    
    let _border = CAShapeLayer()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    func setup() {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.selectedTapped))
        self.addGestureRecognizer(tap)
        self.contentMode = .center
        self.backgroundColor = .lightGray.withAlphaComponent(0.5)
        self.layer.cornerRadius = 5
        self.contentMode = .center
        self.backgroundColor = .white
        self.image = UIImage(named: "CameraICONCORE")
        self.contentMode = .center
        _border.lineWidth = 3
        _border.strokeColor = UIColor.darkGray.cgColor
        _border.fillColor = nil
        _border.lineDashPattern = [10, 10]
        self.layer.addSublayer(_border)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius:5).cgPath
        _border.frame = self.bounds
    }
}
