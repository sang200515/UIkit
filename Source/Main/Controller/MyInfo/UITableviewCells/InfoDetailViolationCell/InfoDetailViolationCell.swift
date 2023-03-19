//
//  InfoDetailViolationCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/31/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class InfoDetailViolationCell: BaseTableCell {

    let lbCreateDate: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.regularFontOfSize(ofSize: 13)
        label.backgroundColor = Constants.COLORS.main_yellow_my_info
        label.textAlignment = .center
        return label
    }()
    
    let lbStatus: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.regularFontOfSize(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    let lbProcedure: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.bold_green
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let lbTitleProcessingLevel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "Mức độ xử lý: "
        label.textAlignment = .left
        return label
    }()
    
    let lbTitleNumberOfRepetition: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .left
        label.text = "Số lần lặp: "
        return label
    }()
    
    let lbTitleFinesAndAdditionWork: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "Số tiền phạt + phạt thêm: "
        label.textAlignment = .left
        return label
    }()
    
    let lbTitlePercentMinusINC: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "% trừ INC: "
        label.textAlignment = .left
        return label
    }()
    
    let lbTitleMonth: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "Tháng: "
        label.textAlignment = .left
        return label
    }()
    
    let lbTitleWhoRecorded: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.text = "Người ghi nhận: "
        label.textAlignment = .left
        return label
    }()
    
    let lbValueProcessingLevel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    let lbValueReprtition: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    let lbValueFinesAndAdditionWork: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.main_red_my_info
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    let lbValuePercentMinusINC: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.main_red_my_info
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    let lbValueMonth: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    let lbValueWhoRecorded: UILabel = {
        let label = UILabel()
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.mediumCustomFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    override func setupCell() {
        super.setupCell()
        self.layer.borderWidth = 0.5
        self.layer.borderColor = Constants.COLORS.text_gray.cgColor
        self.addSubview(lbCreateDate)
        lbCreateDate.myCustomAnchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 8, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 30)
        self.lbCreateDate.makeCorner(corner: 15)
        self.lbCreateDate.widthAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        
        self.addSubview(lbStatus)
        lbStatus.myCustomAnchor(top: nil, leading: nil, trailing: self.trailingAnchor, bottom: nil, centerX: nil, centerY: lbCreateDate.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        self.addSubview(lbProcedure)
        lbProcedure.myCustomAnchor(top: lbCreateDate.bottomAnchor, leading: lbCreateDate.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        setupStackView()
    }
    
    func setupStackView() {
        let stackViewProcesscingLevel = UIStackView(arrangedSubviews: [lbTitleProcessingLevel, lbValueProcessingLevel])
        stackViewProcesscingLevel.distribution = .fillEqually
        stackViewProcesscingLevel.axis = .horizontal
        stackViewProcesscingLevel.spacing = 8
        
        let stackViewReprtition = UIStackView(arrangedSubviews: [lbTitleNumberOfRepetition, lbValueReprtition])
        stackViewReprtition.distribution = .fillEqually
        stackViewReprtition.axis = .horizontal
        stackViewReprtition.spacing = 8
        
        let stackViewFinesAndAdditionWork = UIStackView(arrangedSubviews: [lbTitleFinesAndAdditionWork, lbValueFinesAndAdditionWork])
        stackViewFinesAndAdditionWork.distribution = .fillEqually
        stackViewFinesAndAdditionWork.axis = .horizontal
        stackViewFinesAndAdditionWork.spacing = 8
        
        let stackViewPercentMinusINC = UIStackView(arrangedSubviews: [lbTitlePercentMinusINC, lbValuePercentMinusINC])
        stackViewReprtition.distribution = .fillEqually
        stackViewReprtition.axis = .horizontal
        stackViewReprtition.spacing = 8
        
        let stackViewMonth = UIStackView(arrangedSubviews: [lbTitleMonth, lbValueMonth])
        stackViewReprtition.distribution = .fillEqually
        stackViewReprtition.axis = .horizontal
        stackViewReprtition.spacing = 8
        
        let stackViewWhoRecorded = UIStackView(arrangedSubviews: [lbTitleWhoRecorded, lbValueWhoRecorded])
        stackViewReprtition.distribution = .fillEqually
        stackViewReprtition.axis = .horizontal
        stackViewReprtition.spacing = 8
        
        let stackMainView = UIStackView(arrangedSubviews: [stackViewProcesscingLevel, stackViewReprtition, stackViewFinesAndAdditionWork, stackViewPercentMinusINC, stackViewMonth, stackViewWhoRecorded])
        stackMainView.distribution = .fill
        stackMainView.axis = .vertical
        stackMainView.spacing = 4
        
        self.addSubview(stackMainView)
        stackMainView.myCustomAnchor(top: lbProcedure.bottomAnchor, leading: lbProcedure.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 0, trailingConstant: 8, bottomConstant: 4, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func getDataViolationDetail(_ item: InfoViolationItem) {
        self.lbCreateDate.text = item.ngayTao
        self.lbStatus.text = item.trangThai
        self.lbProcedure.text = item.quyTrinh
        self.lbValueProcessingLevel.text = item.mucDoXuLy
        self.lbValueReprtition.text = "\(item.soLanLap ?? 0)"
        self.lbValueFinesAndAdditionWork.text = item.soTienPhatCongPhatThem
        self.lbValuePercentMinusINC.text = item.phanTramTruINC
        self.lbValueMonth.text = item.thang
        self.lbValueWhoRecorded.text = item.nguoiGhiNhan
    }
}
