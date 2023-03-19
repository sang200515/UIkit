//
//  ContentViolationHeader.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/31/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol ContentViolationHeaderDelegate {
    func toggleSection(header: ContentViolationHeader, section: Int)
    func toggleShowTutorial()
}

class ContentViolationHeader: UITableViewHeaderFooterView {
    var delegate: ContentViolationHeaderDelegate?
    var section: Int!
    var isRotate: Bool?
    let vTitle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.COLORS.main_color_white
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Constants.COLORS.text_gray.cgColor
        return view
    }()
    
    let vImageIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_next_right"))
        return imageView
    }()
    
    let btnShowTutorial: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Constants.COLORS.light_green
        return button
    }()
    
    let btnExpandable: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        return button
    }()
    
    let lbTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.textColor = Constants.COLORS.bold_green
        label.text = "Nội dung kiểm tra: "
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        btnExpandable.addTarget(self, action: #selector(selectHeaderAction(button:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func selectHeaderAction(button: UIButton) {
        button.tag = section
        delegate?.toggleSection(header: self, section: button.tag)
    }
    
    func customInit(title: String, section: Int, delegate: ContentViolationHeaderDelegate) {
        self.lbTitle.text = title
        self.section = section
        self.delegate = delegate
    }
    
    func enableShowTutorial(_ enable: Bool) {
        self.btnShowTutorial.isEnabled = enable
    }
    
    func rotateImage() {
        if isRotate ?? false {
            self.vImageIcon.image = self.vImageIcon.image?.rotate(radians: -.pi / 2)
        } else {
            self.vImageIcon.rotate(degrees: 90)
        }
    }
    
    @objc private func showTutorialToggle(button: UIButton) {
        delegate?.toggleShowTutorial()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(vTitle)
        vTitle.fill()
        self.vTitle.addSubview(btnExpandable)
        btnExpandable.fill()
        vTitle.addSubview(vImageIcon)
        vImageIcon.myCustomAnchor(top: nil, leading: vTitle.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: vTitle.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 20, heightConstant: 20)
        
        vTitle.addSubview(lbTitle)
        lbTitle.myCustomAnchor(top: nil, leading: vImageIcon.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: vTitle.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        vTitle.addSubview(btnShowTutorial)
        vTitle.bringSubviewToFront(btnShowTutorial)
        btnShowTutorial.myCustomAnchor(top: nil, leading: nil, trailing: self.vTitle.trailingAnchor, bottom: nil, centerX: nil, centerY: vTitle.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 100, heightConstant: 30)
        btnShowTutorial.setTitle("Hướng dẫn", for: .normal)
        btnShowTutorial.setTitleColor(.white, for: .normal)
        btnShowTutorial.makeCorner(corner: 15)
        btnShowTutorial.addTarget(self, action: #selector(showTutorialToggle(button:)), for: .touchUpInside)
        self.contentView.backgroundColor = .white
    }
}
