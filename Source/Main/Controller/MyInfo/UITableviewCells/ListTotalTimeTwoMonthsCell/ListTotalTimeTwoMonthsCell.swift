//
//  ListTotalTimeTwoMonthsCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/23/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListTotalTimeTwoMonthsCell: BaseTableCell {
    
    let imageCalendar: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "calendarIC")
        return imageView
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.COLORS.text_gray
        return view
    }()
    
    let lbMonth: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_13)
        label.text = "Tháng 7"
        label.textAlignment = .center
        label.makeCorner(corner: 20)
        label.backgroundColor = Constants.COLORS.bold_green
        return label
    }()
    
    let vContainerContent: UIView = {
        let view = UIView()
        view.myCustomDropShadow()
        view.backgroundColor = .white
        return view
    }()
    
    let lbTitleStandardLaborTime: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.mediumCustomFont(ofSize: Constants.TextSizes.size_13)
        label.text = "Giờ công chuẩn:"
        return label
    }()
    
    let lbTitleTotalApprovedHours: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.mediumCustomFont(ofSize: Constants.TextSizes.size_13)
        label.text = "Tổng giờ công được duyệt:"
        return label
    }()
    
    let lbValueStandardLaborTime: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.main_orange_my_info
        label.font = UIFont.mediumCustomFont(ofSize: Constants.TextSizes.size_13)
        label.text = "208"
        return label
    }()
    
    let lbValueTotalApprovedHours: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.main_blue_my_info
        label.font = UIFont.mediumCustomFont(ofSize: Constants.TextSizes.size_13)
        label.text = "72"
        return label
    }()
    
    
    override func setupCell() {
        super.setupCell()
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(imageCalendar)
        imageCalendar.myCustomAnchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 10, leadingConstant: 16, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 20, heightConstant: 20)
        
        self.contentView.addSubview(lineView)
        lineView.myCustomAnchor(top: imageCalendar.bottomAnchor, leading: nil, trailing: nil, bottom: contentView.bottomAnchor, centerX: imageCalendar.centerXAnchor, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 0, trailingConstant: 0, bottomConstant: 2, centerXConstant: 0, centerYConstant: 0, widthConstant: 1, heightConstant: 0)
        
        self.contentView.addSubview(lbMonth)
        lbMonth.myCustomAnchor(top: nil, leading: imageCalendar.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: imageCalendar.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 8, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 100, heightConstant: 40)
        
        self.contentView.addSubview(vContainerContent)
        vContainerContent.myCustomAnchor(top: lbMonth.bottomAnchor, leading: lbMonth.leadingAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 8, leadingConstant: 0, trailingConstant: 4, bottomConstant: 4, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 80)
        
        vContainerContent.addSubview(lbTitleStandardLaborTime)
        lbTitleStandardLaborTime.myCustomAnchor(top: vContainerContent.topAnchor, leading: vContainerContent.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 8, leadingConstant: 10, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vContainerContent.addSubview(lbTitleTotalApprovedHours)
        lbTitleTotalApprovedHours.myCustomAnchor(top: lbTitleStandardLaborTime.bottomAnchor, leading: lbTitleStandardLaborTime.leadingAnchor, trailing: nil, bottom: vContainerContent.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 8, leadingConstant: 0, trailingConstant: 0, bottomConstant: 8, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vContainerContent.addSubview(lbValueStandardLaborTime)
        lbValueStandardLaborTime.myCustomAnchor(top: nil, leading: lbTitleStandardLaborTime.trailingAnchor, trailing: vContainerContent.trailingAnchor, bottom: nil, centerX: nil, centerY: lbTitleStandardLaborTime.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 20, trailingConstant: 10, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vContainerContent.addSubview(lbValueTotalApprovedHours)
        lbValueTotalApprovedHours.myCustomAnchor(top: nil, leading: lbValueStandardLaborTime.leadingAnchor, trailing: lbValueStandardLaborTime.trailingAnchor, bottom: nil, centerX: nil, centerY: lbTitleTotalApprovedHours.centerYAnchor, width: nil, height: nil, topConstant: 10, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func getListTotalTimeData(_ month: String, standardLaborTime: String, totalApprovedTime: String) {
        self.lbMonth.text = "Tháng \(month)"
        self.lbValueStandardLaborTime.text = standardLaborTime
        self.lbValueTotalApprovedHours.text = totalApprovedTime
    }
}
