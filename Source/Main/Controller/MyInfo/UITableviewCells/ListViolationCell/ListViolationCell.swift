//
//  ListViolationCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/28/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListViolationCell: BaseTableCell {
    
    let vHeaderContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.1)
        return view
    }()
    
    let lbTItleNumberPunish: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 12)
        label.textColor = Constants.COLORS.text_gray
        return label
    }()
    
    let lbValueUnitEachPunish: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 12)
        label.textColor = Constants.COLORS.main_red_my_info
        return label
    }()
    
    let lbNameRecord: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.mediumCustomFont(ofSize: 12)
        label.textColor = Constants.COLORS.text_gray
        label.text = "Ghi nhận: "
        return label
    }()
    
    let lbTitleProcessingLevel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.mediumCustomFont(ofSize: 12)
        label.textColor = Constants.COLORS.text_gray
        label.text = "Mức độ xử lý: "
        return label
    }()
    
    let lbTitleDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.mediumCustomFont(ofSize: 12)
        label.textColor = Constants.COLORS.text_gray
        label.text = "Ngày"
        return label
    }()
    
    let lbStatus: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.mediumCustomFont(ofSize: 12)
        label.textColor = Constants.COLORS.text_gray
        label.text = "Trạng thái"
        return label
    }()

    let lbValueNameRecord: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 12)
        label.textColor = Constants.COLORS.black_main
        label.textAlignment = .left
        return label
    }()
    
    let lbValueProcesscingLevel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 12)
        label.textColor = Constants.COLORS.text_gray
        label.textAlignment = .left
        return label
    }()

    let lbValueDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.mediumCustomFont(ofSize: 12)
        label.textColor = Constants.COLORS.text_gray
        label.textAlignment = .left
        return label
    }()
    
    let lbValueStatus: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: Constants.TextSizes.size_12)
        label.textColor = Constants.COLORS.light_green
        label.textAlignment = .left
        return label
    }()

    
    override func setupCell() {
        super.setupCell()
        self.contentView.addSubview(vHeaderContainer)
        vHeaderContainer.myCustomAnchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 8, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 35)
        
        vHeaderContainer.addSubview(lbTItleNumberPunish)
        lbTItleNumberPunish.myCustomAnchor(top: nil, leading: vHeaderContainer.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: vHeaderContainer.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 4, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vHeaderContainer.addSubview(lbValueUnitEachPunish)
        lbValueUnitEachPunish.myCustomAnchor(top: nil, leading: lbTItleNumberPunish.trailingAnchor, trailing: vHeaderContainer.trailingAnchor, bottom: nil, centerX: nil, centerY: vHeaderContainer.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 100, trailingConstant: 4, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        setupStackView()
    }
    
    fileprivate func setupStackView() {
        
        lbNameRecord.widthAnchor.constraint(equalToConstant: 100).isActive = true
        let stackViewRecord = UIStackView(arrangedSubviews: [lbNameRecord, lbValueNameRecord])
        stackViewRecord.axis = .horizontal
        stackViewRecord.spacing = 10
        stackViewRecord.distribution = .fill
        
        lbTitleProcessingLevel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        let stackViewProcessingLevel = UIStackView(arrangedSubviews: [lbTitleProcessingLevel, lbValueProcesscingLevel])
        stackViewProcessingLevel.axis = .horizontal
        stackViewProcessingLevel.spacing = 10
        stackViewProcessingLevel.distribution = .fill
        
        lbTitleDate.widthAnchor.constraint(equalToConstant: 100).isActive = true
        let stackViewDate = UIStackView(arrangedSubviews: [lbTitleDate, lbValueDate])
        stackViewDate.axis = .horizontal
        stackViewDate.spacing = 10
        stackViewDate.distribution = .fill

        lbStatus.widthAnchor.constraint(equalToConstant: 100).isActive = true
        let stackViewStatus = UIStackView(arrangedSubviews: [lbStatus, lbValueStatus])
        stackViewStatus.axis = .horizontal
        stackViewStatus.spacing = 10
        stackViewStatus.distribution = .fill
        
        let mainStackView = UIStackView(arrangedSubviews: [stackViewRecord, stackViewProcessingLevel, stackViewDate, stackViewStatus])
        mainStackView.axis = .vertical
        mainStackView.spacing = 2
        mainStackView.distribution = .fillEqually
        
        self.contentView.addSubview(mainStackView)
        mainStackView.myCustomAnchor(top: vHeaderContainer.bottomAnchor, leading: vHeaderContainer.leadingAnchor, trailing: vHeaderContainer.trailingAnchor, bottom: contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 0, trailingConstant: 0, bottomConstant: 4, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func getDataViolationItem(_ data: ViolationDetailItem) {
        lbTItleNumberPunish.text = "\(data.soPhieu ?? 0)"
        lbValueUnitEachPunish.text = data.soTienPhat
        lbValueNameRecord.text = data.ghiNhan
        lbValueProcesscingLevel.text = data.mucDoXuLy
        lbValueDate.text = data.ngay
        lbValueStatus.text = data.trangThai
    }
    
}
