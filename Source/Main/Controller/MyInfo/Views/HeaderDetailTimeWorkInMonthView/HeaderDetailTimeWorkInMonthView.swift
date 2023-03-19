//
//  HeaderDetailTimeWorkInMonthView.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HeaderDetailTimeWorkInMonthView: BaseView {
    
    private var datas: [DonGiaGioCong]?
    
    let vContainerTitleTimeWorkInMonth: UIView = {
        let view = UIView()
        return view
    }()
    
    let tableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        return tableView
    }()
    
    let vImageBackGround: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "bg_container_date_work")
        return imageView
    }()
    
    let vGradientContainerDetailTimeWorkInMonth: UIView = {
        let view = UIView()
        return view
    }()
    
    let lbTitleMonth: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.TextSizes.size_14)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        self.addSubview(vContainerTitleTimeWorkInMonth)
        vContainerTitleTimeWorkInMonth.myCustomAnchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: nil, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 10, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 100, heightConstant: 100)
        setupGradientView()
        vContainerTitleTimeWorkInMonth.addSubview(vImageBackGround)
        vImageBackGround.myCustomAnchor(top: vContainerTitleTimeWorkInMonth.topAnchor, leading: vContainerTitleTimeWorkInMonth.leadingAnchor, trailing: vContainerTitleTimeWorkInMonth.trailingAnchor, bottom: vContainerTitleTimeWorkInMonth.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vContainerTitleTimeWorkInMonth.addSubview(lbTitleMonth)
        lbTitleMonth.myCustomAnchor(top: nil, leading: nil, trailing: nil, bottom: nil, centerX: vContainerTitleTimeWorkInMonth.centerXAnchor, centerY: vContainerTitleTimeWorkInMonth.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        tableView.dataSource = self
        tableView.register(ListValueUnitPerHourCell.self, forCellReuseIdentifier: ListValueUnitPerHourCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        vGradientContainerDetailTimeWorkInMonth.layer.sublayers?.first?.frame = vGradientContainerDetailTimeWorkInMonth.bounds
    }
    
    func getDataDetailTimeWorkInMonth(_ datas: [DonGiaGioCong], _ month: String, year: String) {
        self.datas = datas
        lbTitleMonth.text = "Tháng \(month) \n \(year)"
        tableView.reloadData()
    }
    
    fileprivate func setupGradientView() {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = [Constants.COLORS.bold_green.cgColor, Constants.COLORS.light_green.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        vGradientContainerDetailTimeWorkInMonth.layer.addSublayer(gradientLayer)
        self.addSubview(vGradientContainerDetailTimeWorkInMonth)
        vGradientContainerDetailTimeWorkInMonth.myCustomAnchor(top: self.vContainerTitleTimeWorkInMonth.topAnchor, leading: self.vContainerTitleTimeWorkInMonth.trailingAnchor, trailing: self.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 6, leadingConstant: -11, trailingConstant: 0, bottomConstant: 10, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vGradientContainerDetailTimeWorkInMonth.addSubview(tableView)
        tableView.myCustomAnchor(top: self.vGradientContainerDetailTimeWorkInMonth.topAnchor, leading: self.vGradientContainerDetailTimeWorkInMonth.leadingAnchor, trailing: self.vGradientContainerDetailTimeWorkInMonth.trailingAnchor, bottom: self.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 8, leadingConstant: -14, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
    }
    
}

extension HeaderDetailTimeWorkInMonthView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = datas {
            return items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListValueUnitPerHourCell.identifier, for: indexPath) as? ListValueUnitPerHourCell else {return UITableViewCell()}
        
        if let items = datas {
            let item = items[indexPath.row]
            cell.getDataDetailUnitPerHour(item.title ?? "", value: item.value ?? "")
        }
        cell.backgroundView = UIView()
        cell.selectedBackgroundView = UIView()
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
}

