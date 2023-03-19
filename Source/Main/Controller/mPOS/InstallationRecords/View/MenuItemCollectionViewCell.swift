//
//  MenuItemCollectionViewCell.swift
//  fptshop
//
//  Created by Ngo Dang tan on 08/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class MenuItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var item: ItemApp? {
         didSet{configure()}
     }
    
    private let icon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    private let itemLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        label.textColor = UIColor(netHex: 0x6C6B6B)
        return label
    }()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(icon)
        addSubview(itemLabel)
        
        icon.frame = CGRect(x: contentView.frame.width/2 - (contentView.frame.height/2 - Common.Size(s: 10))/2, y: contentView.frame.height/2 - (contentView.frame.height/2 + Common.Size(s: 20))/2, width: contentView.frame.height/2 - Common.Size(s: 10), height: contentView.frame.height/2)
  
        itemLabel.frame = CGRect(x: 0, y: icon.frame.origin.y + icon.frame.size.height, width: contentView.frame.width, height: Common.Size(s: 20))
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configure(){
        guard let item = item else {return}
        let viewModel = MenuItemViewModel(item: item)
        icon.image = viewModel.icon
        itemLabel.text = viewModel.label
   
    }
    
}
