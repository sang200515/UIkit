//
//  ListDetailTimeWorkInMonthCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/28/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListDetailTimeWorkInMonthCell: BaseTableCell {
    
    let lbDetailDate: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.text_gray
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.text = "22/07/2020"
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let vCorner: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let vContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let lbShiftName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        return label
    }()
    
    let lbWorkHourApprove: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.text_gray
        label.font = UIFont.mediumCustomFont(ofSize: 12)
        return label
    }()
    
    let lbTimeKeeping: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.text_gray
        label.font = UIFont.mediumCustomFont(ofSize: 12)
        return label
    }()
    
    let lbApprovedWorkingTime: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.regularFontOfSize(ofSize: 12)
        label.text = "Giờ công được duyệt"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let lbValueApproveTime: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.bold_green
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let lbValueApprovedTimeIn: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.text_gray
        label.font = UIFont.mediumCustomFont(ofSize: 12)
        return label
    }()
    
    let lbValueApprovedTimeOut: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.text_gray
        label.font = UIFont.mediumCustomFont(ofSize: 12)
        return label
    }()

    
    override func setupCell() {
        super.setupCell()
        self.contentView.addSubview(lbDetailDate)
        lbDetailDate.myCustomAnchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 16, leadingConstant: 2, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 75, heightConstant: 20)
        
        self.contentView.addSubview(vContainer)
        vContainer.myCustomAnchor(top: contentView.topAnchor, leading: lbDetailDate.trailingAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 12, leadingConstant: 16, trailingConstant: 2, bottomConstant: 2, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.vContainer.addSubview(vCorner)
        vCorner.fill()
        
        self.vCorner.addSubview(lbShiftName)
        lbShiftName.myCustomAnchor(top: vCorner.topAnchor, leading: vCorner.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 2, leadingConstant: 8, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.vCorner.addSubview(lbTimeKeeping)
        lbTimeKeeping.myCustomAnchor(top: lbShiftName.bottomAnchor, leading: lbShiftName.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 2, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.vCorner.addSubview(lbWorkHourApprove)
        lbWorkHourApprove.myCustomAnchor(top: lbTimeKeeping.bottomAnchor, leading: lbShiftName.leadingAnchor, trailing: nil, bottom: vCorner.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 2, leadingConstant: 0, trailingConstant: 0, bottomConstant: 2, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        setupStackViewValuesApprovedTime()
        
        self.vCorner.addSubview(lbApprovedWorkingTime)
        lbApprovedWorkingTime.myCustomAnchor(top: vCorner.topAnchor, leading: lbShiftName.trailingAnchor, trailing: vCorner.trailingAnchor, bottom: nil, centerX: nil, centerY: lbShiftName.centerYAnchor, width: nil, height: nil, topConstant: 4, leadingConstant: 20, trailingConstant: 2, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 80, heightConstant: 0)
        
        self.vCorner.addSubview(lbValueApproveTime)
        lbValueApproveTime.myCustomAnchor(top: lbApprovedWorkingTime.bottomAnchor, leading: nil, trailing: nil, bottom: vCorner.bottomAnchor, centerX: lbApprovedWorkingTime.centerXAnchor, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 0, trailingConstant: 0, bottomConstant: 4, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        vContainer.myCustomDropShadow()
        vCorner.layer.cornerRadius = 8.0
        vCorner.layer.masksToBounds = true
    }
    
    func setupStackViewValuesApprovedTime() {
        let stackView = UIStackView(arrangedSubviews: [lbValueApprovedTimeIn, lbValueApprovedTimeOut])
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        
        vCorner.addSubview(stackView)
        stackView.myCustomAnchor(top: nil, leading: lbWorkHourApprove.trailingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: lbWorkHourApprove.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 10, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func getDataDetailTimeWorkInMonth(_ data: GioCongDuyet) {
        lbDetailDate.text = data.ngay
        lbShiftName.text = "Tên ca: \(data.tenCa ?? "")"
        lbTimeKeeping.text = "Chấm công: "
        lbWorkHourApprove.text = "Duyệt công: "
        lbValueApprovedTimeIn.text = data.duyetGioVao
        lbValueApprovedTimeOut.text = data.duyetGioRa
        lbValueApproveTime.text = data.soGioCongDuocDuyet
        
    }
    
}
