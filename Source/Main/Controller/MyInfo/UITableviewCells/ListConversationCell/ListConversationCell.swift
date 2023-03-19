//
//  ListConversationCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/30/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListConversationCell: BaseTableCell {
    
    let lbNameUser: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 14)
        return label
    }()
    
    let lbContent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regularFontOfSize(ofSize: 12)
        label.textColor = Constants.COLORS.black_main
        label.numberOfLines = 0
        return label
    }()
    
    let lbDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: Constants.TextSizes.size_12)
        label.textColor = Constants.COLORS.text_gray
        return label
    }()
    
    let vMainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.myCustomDropShadow()
        return view
    }()
    
    let vMainCorner: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.COLORS.main_color_white
        view.makeCorner(corner: Constants.Values.view_corner)
        return view
    }()
    
    let vLine: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.COLORS.text_gray
        return view
    }()
    
    override func setupCell() {
        super.setupCell()
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(vLine)
        vLine.myCustomAnchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: nil, bottom: contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 16, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 1.5, heightConstant: 0)
        
        self.contentView.addSubview(vMainContainer)
        vMainContainer.myCustomAnchor(top: contentView.topAnchor, leading: vLine.trailingAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 8, trailingConstant: 4, bottomConstant: 4, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.vMainContainer.addSubview(vMainCorner)
        vMainCorner.fill()
        
        vMainCorner.addSubview(lbNameUser)
        lbNameUser.myCustomAnchor(top: vMainCorner.topAnchor, leading: vMainCorner.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 8, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vMainCorner.addSubview(lbDate)
        lbDate.myCustomAnchor(top: nil, leading: lbNameUser.trailingAnchor, trailing: vMainCorner.trailingAnchor, bottom: nil, centerX: nil, centerY: lbNameUser.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 20, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vMainContainer.addSubview(lbContent)
        lbContent.myCustomAnchor(top: lbNameUser.bottomAnchor, leading: vMainCorner.leadingAnchor, trailing: vMainCorner.trailingAnchor, bottom: vMainCorner.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 12, trailingConstant: 8, bottomConstant: 8, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func getDataConversation(_ conversations: Conversations) {
        let type = conversations.type
        switch type {
        case 1:
            lbNameUser.loadWith(text: conversations.empCodeName, textColor: Constants.COLORS.bold_green, font: nil, textAlignment: .left)
        default:
            lbNameUser.loadWith(text: conversations.empCodeName, textColor: Constants.COLORS.main_orange_my_info, font: nil, textAlignment: .left)
        }
        lbContent.attributedText = conversations.noiDung?.htmlAttributed(using: UIFont.regularFontOfSize(ofSize: 12), color: Constants.COLORS.black_main)
        lbDate.text = conversations.ngay
    }
    
    
}
