//
//  HistoryUserviceTableViewCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/17/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HistoryUserviceTableViewCell: BaseTableCell {

    let lbNumberTicket: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.bold_green
        label.font = UIFont.semiboldFont(size: Constants.TextSizes.size_13)
        label.text = "Ticket: 789654"
        return label
    }()
    
    let lbDateTimeCreate: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.thinFontOfSize(ofSize: Constants.TextSizes.size_12)
        label.text = "15/07/2020-15:30"
        return label
    }()
    
    let lbTitleTicket: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.mediumFont(size: Constants.TextSizes.size_14)
        return label
    }()
    
    let lbTitlePersonRequest: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.regularFont(size: Constants.TextSizes.size_13)
        label.text = "Người yêu cầu: "
        return label
    }()
    
    let lbTitlePersonSolved: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.regularFont(size: Constants.TextSizes.size_13)
        label.text = "Người xử lý: "
        return label
    }()
    
    let lbTitleStatus: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.regularFont(size: Constants.TextSizes.size_13)
        label.text = "Trạng thái: "
        return label
    }()
    
    let lbTitleTypeTicket: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.regularFont(size: Constants.TextSizes.size_13)
        label.text = "Loại ticket: "
        return label
    }()
    
    let lbValueNamePersonRequest: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.regularFont(size: Constants.TextSizes.size_13)
        label.textAlignment = .right
        return label
    }()
    
    let lbValueNamePersonSolved: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.regularFont(size: Constants.TextSizes.size_13)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .right
        return label
    }()
    
    let lbValueStatus: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.light_green
        label.font = UIFont.regularFont(size: Constants.TextSizes.size_13)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .right
        return label
    }()
    
    let lbValueTypeTicket: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.light_green
        label.font = UIFont.regularFont(size: Constants.TextSizes.size_13)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .right
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
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
    
    override func setupCell() {
        super.setupCell()
        self.contentView.addSubview(vMainContainer)
        vMainContainer.myCustomAnchor(top: self.contentView.topAnchor, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, bottom: self.contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 4, trailingConstant: 4, bottomConstant: 12, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vMainContainer.addSubview(vMainCorner)
        vMainCorner.fill()
        
        vMainCorner.addSubview(lbNumberTicket)
        lbNumberTicket.myAnchorWithUIEdgeInsets(top: vMainContainer.topAnchor, leading: vMainCorner.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 4, left: 6, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
        vMainCorner.addSubview(lbDateTimeCreate)
        lbDateTimeCreate.myAnchorWithUIEdgeInsets(top: vMainCorner.topAnchor, leading: lbNumberTicket.trailingAnchor, bottom: nil, trailing: vMainCorner.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 20, bottom: 0, right: 4), size: CGSize(width: 0, height: 0))
        
        vMainCorner.addSubview(lineView)
        lineView.myAnchorWithUIEdgeInsets(top: lbNumberTicket.bottomAnchor, leading: vMainCorner.leadingAnchor, bottom: nil, trailing: vMainCorner.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        
        vMainCorner.addSubview(lbTitleTicket)
        lbTitleTicket.myAnchorWithUIEdgeInsets(top: lineView.bottomAnchor, leading: lbNumberTicket.leadingAnchor, bottom: nil, trailing: vMainCorner.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 8), size: CGSize(width: 0, height: 0))
        
        setupStackView()
        
    }
    
    func setupStackView() {
        let stackViewPersonRequest = UIStackView(arrangedSubviews: [lbTitlePersonRequest, lbValueNamePersonRequest])
        stackViewPersonRequest.distribution = .fillEqually
        stackViewPersonRequest.axis = .horizontal
        stackViewPersonRequest.spacing = 8
        
        let stackViewPersonSolved = UIStackView(arrangedSubviews: [lbTitlePersonSolved, lbValueNamePersonSolved])
        stackViewPersonSolved.distribution = .fillEqually
        stackViewPersonSolved.axis = .horizontal
        stackViewPersonSolved.spacing = 8
        
        let stackViewStatus = UIStackView(arrangedSubviews: [lbTitleStatus, lbValueStatus])
        stackViewStatus.distribution = .fillEqually
        stackViewStatus.axis = .horizontal
        stackViewStatus.spacing = 8
        
        let stackViewTypeTicket = UIStackView(arrangedSubviews: [lbTitleTypeTicket, lbValueTypeTicket])
        stackViewTypeTicket.distribution = .fillEqually
        stackViewTypeTicket.axis = .horizontal
        stackViewTypeTicket.spacing = 8
        
        let stackMainView = UIStackView(arrangedSubviews: [stackViewPersonRequest, stackViewPersonSolved, stackViewStatus, stackViewTypeTicket])
        stackMainView.distribution = .fill
        stackMainView.axis = .vertical
        stackMainView.spacing = 4
        
        self.vMainCorner.addSubview(stackMainView)
        stackMainView.myAnchorWithUIEdgeInsets(top: lbTitleTicket.bottomAnchor, leading: vMainCorner.leadingAnchor, bottom: vMainCorner.bottomAnchor, trailing: vMainCorner.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 6, bottom: 8, right: 4), size: CGSize(width: 0, height: 0))
    }
    
    func convertToString(dateString: String, formatIn : String, formatOut : String) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = formatIn
        guard let date = dateFormater.date(from: dateString) else {return ""}
        
        dateFormater.dateFormat = formatOut
        let timeStr = dateFormater.string(from: date)
        return timeStr
    }
    
    func loadCell(_ item: HistoryUserviceTickeData) {
        guard let timeCreate = item.createdTime else {return}
        let dateFormate = convertToString(dateString: timeCreate, formatIn: "yyyy-MM-dd HH:mm:ss", formatOut: "dd/MM/yyyy-HH:mm")
        
        self.lbNumberTicket.text = "Ticket: \(item.id ?? 0)"
        self.lbDateTimeCreate.text = dateFormate
        self.lbTitleTicket.text = item.title
        self.lbValueNamePersonRequest.text = item.ticketOwner
        self.lbValueNamePersonSolved.text = item.ticketOwnerDisplay
        self.lbValueStatus.text = item.status
        self.lbValueTypeTicket.text = item.service
    }
    
}
