//
//  DetailUserInfoView.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/16/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DetailUserInfoView: BaseView {
    
    // MARK: - PROPERTIES
    let lbTitleWorkTime: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        label.text = "Thời gian gắn bó với FRT"
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.boldSystemFont(ofSize: Constants.TextSizes.size_14)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lbTitleTotalValueMonthAgo: UILabel = {
        let label = UILabel()
        label.text = "Tổng thu nhập tháng trước"
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.boldSystemFont(ofSize: Constants.TextSizes.size_14)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lbTitleTotalReward: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 40))
        label.text = "Tổng thưởng"
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.boldSystemFont(ofSize: Constants.TextSizes.size_14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lbUnitDateWorkTime: UILabel = {
        let label = UILabel()
        label.text = "Ngày"
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.mediumCustomFont(ofSize: Constants.TextSizes.size_13)
        label.textAlignment = .center
        return label
    }()
    
    let lbUnitCurrencyValueMonthAgo: UILabel = {
        let label = UILabel()
        label.text = "VNĐ"
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.mediumCustomFont(ofSize: Constants.TextSizes.size_13)
        label.textAlignment = .center
        return label
    }()
    
    let lbUnitCurrencyValueRewards: UILabel = {
        let label = UILabel()
        label.text = "VNĐ"
        label.textColor = Constants.COLORS.black_main
        label.font = UIFont.mediumCustomFont(ofSize: Constants.TextSizes.size_13)
        label.textAlignment = .center
        return label
    }()
    
    let lbValueWorkTime: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = Constants.COLORS.main_red_my_info
        label.font = UIFont.boldCustomFont(ofSize: Constants.TextSizes.size_18)
        label.textAlignment = .center
        return label
    }()
    
    let lbValueTotalValueMonthAgo: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = Constants.COLORS.main_red_my_info
        label.font = UIFont.boldCustomFont(ofSize: Constants.TextSizes.size_18)
        label.textAlignment = .center
        return label
    }()
    
    let lbValueTotalReward: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = Constants.COLORS.main_red_my_info
        label.font = UIFont.boldCustomFont(ofSize: Constants.TextSizes.size_18)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()
    
    let vGradient: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - FUNCTIONS
    override func setupViews() {
        super.setupViews()
        setupGradientView()
        setupUerInfo()
    }
    
    fileprivate func setupGradientView() {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = [Constants.COLORS.bold_green.cgColor, Constants.COLORS.light_green.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        vGradient.layer.addSublayer(gradientLayer)
        self.addSubview(vGradient)
        vGradient.myCustomAnchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        vGradient.layer.sublayers?.first?.frame = vGradient.bounds
        
    }
    
    func getData(_ employeeInfo: EmployeeInfoElement) {
        lbValueWorkTime.text = employeeInfo.ngayGanBo
        lbValueTotalValueMonthAgo.text = employeeInfo.tongThuNhap
        lbValueTotalReward.text = employeeInfo.tongThuong
        
    }
    
    fileprivate func setupUerInfo(){
        let stackViewWorkTime = UIStackView(arrangedSubviews: [lbTitleWorkTime, lbValueWorkTime, lbUnitDateWorkTime])
        stackViewWorkTime.axis = .vertical
        stackViewWorkTime.spacing = 4
        stackViewWorkTime.distribution = .fill
        stackViewWorkTime.backgroundColor = .clear
        
        let stackViewTotalAMonth = UIStackView(arrangedSubviews: [lbTitleTotalValueMonthAgo, lbValueTotalValueMonthAgo, lbUnitCurrencyValueMonthAgo])
        stackViewTotalAMonth.axis = .vertical
        stackViewTotalAMonth.spacing = 4
        stackViewTotalAMonth.distribution = .fill
        stackViewTotalAMonth.backgroundColor = .clear
        
        let stackViewRewards = UIStackView(arrangedSubviews: [lbTitleTotalReward, lbValueTotalReward, lbUnitCurrencyValueRewards])
        stackViewRewards.axis = .vertical
        stackViewRewards.spacing = 4
        stackViewRewards.distribution = .fill
        stackViewTotalAMonth.backgroundColor = .clear
        
        let stackViewMainContainer = UIStackView(arrangedSubviews: [stackViewWorkTime, stackViewTotalAMonth, stackViewRewards])
        stackViewMainContainer.axis = .horizontal
        stackViewMainContainer.spacing = 30
        stackViewMainContainer.distribution = .fillEqually
        stackViewMainContainer.backgroundColor = .clear
        
        self.addSubview(stackViewMainContainer)
        self.bringSubviewToFront(stackViewMainContainer)
        stackViewMainContainer.myCustomAnchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 80)
    }
}
