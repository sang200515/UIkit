//
//  MoreInfoInstallCell.swift
//  fptshop
//
//  Created by Ngo Dang tan on 11/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class MoreInfoInstallCell: UITableViewCell {

    // MARK: - Properties
    private let imgCheck: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "􀆅")
        return imageView
    }()
    
    private let label: UILabel = {
       let label = UILabel()
        return label
    }()
    var item: String? {
        didSet {
            configure()
        }
    }
    
    
    // MARK: - Lifecycle
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [imgCheck,label])
        stack.axis = .horizontal
        stack.spacing = 12
        
        contentView.addSubview(stack)
        contentView.centerY(inView: contentView)
        contentView.anchor(left: contentView.leftAnchor,paddingLeft: 16)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Helpers
    func configure(){
        label.text = item
    }
    

}
