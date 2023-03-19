//
//  ChooseResponseView.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/30/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

@objc protocol ChooseResponseViewDelegate {
    @objc func RatingItemViewDelegate_rating(atIndex: Int)
}


class ChooseResponseView: BaseView {
    
    private var tapGesture = UITapGestureRecognizer()
    private let seclectedColor = Constants.COLORS.light_green
    private let unselectedColor = Constants.COLORS.text_gray
    var chooseResponseViewDelegate: ChooseResponseViewDelegate?
    private var image: UIImage = UIImage.init(named: "ic_face_not_happy")!
    var index: Int = 0
    
    let lbTitleStatus: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 11)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var vState: UIView!
    
    let vImageResponse: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    var isSelected: Bool = false {
        didSet {
            self.setViewState(isSelected: self.isSelected)
            lbTitleStatus.textColor = isSelected ? Constants.COLORS.main_red_my_info : Constants.COLORS.main_color_white
        }
    }
    
    override func setupViews() {
        super.setupViews()
        setupView()
        
    }
    
    func setViewState(isSelected: Bool = false) {
        self.vState.makeColor(color: isSelected ? Constants.COLORS.light_green : Constants.COLORS.text_gray)
        self.vState.makeCorner(corner: 8.0)
        self.vState.setBorder(color: isSelected ? Constants.COLORS.light_green : Constants.COLORS.text_gray, borderWidth: Constants.Values.border_width, corner: vState.frame.height / 2)
        self.vImageResponse.alpha = isSelected ? 1 : 0.5
    }
    
    private func setupView() {
        self.vState = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        vState.layer.cornerRadius = vState.frame.height / 2

        self.addSubview(vState)
        self.vState.myCustomAnchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        vState.setBorder(color: Constants.COLORS.text_gray, borderWidth: Constants.Values.border_width, corner: vState.frame.height / 2)
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(ratingTouch(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        vState.addGestureRecognizer(tapGesture)
        vState.isUserInteractionEnabled = true
        vState.backgroundColor = Constants.COLORS.text_gray
        
        self.vState.addSubview(vImageResponse)
        vImageResponse.myCustomAnchor(top: nil, leading: vState.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: vState.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 30, heightConstant: 30)
        
        self.vState.addSubview(lbTitleStatus)
        lbTitleStatus.myCustomAnchor(top: nil, leading: vImageResponse.trailingAnchor, trailing: vState.trailingAnchor, bottom: nil, centerX: nil, centerY: vImageResponse.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 4, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        self.vImageResponse.alpha = isSelected ? 1 : 0.5
        self.vImageResponse.image = image
    }
    
    func setTitleStatus(_ title: String) {
        lbTitleStatus.loadWith(text: title, textColor: Constants.COLORS.main_color_white, font: UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_11), textAlignment: .center)
    }
    
    
    func getViewIndex() -> Int {
        return index
    }
    
    @objc func ratingTouch(_ sender: UITapGestureRecognizer) {
        chooseResponseViewDelegate?.RatingItemViewDelegate_rating(atIndex: index)
    }
    
}
