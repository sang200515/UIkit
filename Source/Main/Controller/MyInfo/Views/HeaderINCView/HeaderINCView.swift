//
//  HeaderINCView.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/24/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HeaderINCView: BaseView {
    
    let lbTitleTotalINC: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_14)
        label.text = "Tổng INC:"
        return label
    }()
    
    let lbTitleDetails: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_14)
        label.text = "Chi tiết:"
        return label
    }()
    
    let lbValueTotalINC: UILabel = {
       let label = UILabel()
        label.textColor = Constants.COLORS.main_red_my_info
        label.font = UIFont.boldSystemFont(ofSize: Constants.TextSizes.size_16)
        label.text = ""
        return label
    }()
    
    let vGradient: UIView = {
        let view = UIView()
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        vGradient.layer.sublayers?.first?.frame = vGradient.bounds
        
    }
    
    override func setupViews() {
        super.setupViews()
        setupGradientView()
        self.addSubview(lbTitleTotalINC)
        lbTitleTotalINC.myCustomAnchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 10, leadingConstant: 10, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.addSubview(lbTitleDetails)
        lbTitleDetails.myCustomAnchor(top: lbTitleTotalINC.bottomAnchor, leading: lbTitleTotalINC.leadingAnchor, trailing: lbTitleTotalINC.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 0, trailingConstant: 0, bottomConstant: 10, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.addSubview(lbValueTotalINC)
        lbValueTotalINC.myCustomAnchor(top: nil, leading: nil, trailing: self.trailingAnchor, bottom: nil, centerX: nil, centerY: lbTitleTotalINC.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    fileprivate func setupGradientView() {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = [Constants.COLORS.light_green.cgColor, Constants.COLORS.bold_green.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        vGradient.layer.addSublayer(gradientLayer)
        self.addSubview(vGradient)
        vGradient.myCustomAnchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func getData(_ valueTotalINC: String) {
        lbValueTotalINC.text = valueTotalINC
    }

}
