//
//  AppearanceCell.swift
//  fptshop
//
//  Created by Ngo Dang tan on 09/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DLRadioButton

class AppearanceCell: UITableViewCell {
    
    // MARK: - Properties
    var itemDataInstallLaptop: ItemDataInstallLaptop? {
        didSet {
            configure()
        }
    }
    
    var config: DataInstallLaptopConfiguration!

    

    
    private var radCheck: DLRadioButton = {
        let rad = DLRadioButton()
        rad.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        rad.setTitle("", for: UIControl.State())
        rad.setTitleColor(.black, for: UIControl.State())
        rad.iconColor = .black
        rad.isIconSquare = true
        rad.indicatorColor = .black
        rad.titleLabel?.numberOfLines = 0
        rad.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        rad.addTarget(self, action: #selector(handleCheck), for: UIControl.Event.touchUpInside)
        return rad
    }()
    
    
    
    
    // MARK: - Lifecycle
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        addSubview(radCheck)
        radCheck.anchor(top: contentView.topAnchor, left: contentView.leftAnchor,bottom: contentView.bottomAnchor, right: contentView.rightAnchor,paddingTop: 12,paddingLeft: 12,paddingRight: 12)
        radCheck.setDimensions(width: contentView.frame.width, height: Common.standardHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleCheck(){
        
    }
    
    // MARK: - Helpers
    func configure(){
        guard let item = itemDataInstallLaptop else {return}
        radCheck.setTitle(item.name, for: .normal)
        radCheck.isSelected = item.isSelected == true ? true : false
    }
    
    
}
