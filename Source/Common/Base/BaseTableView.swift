//
//  BaseTableView.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 13/05/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit

protocol BaseUITableViewDelegate:class {
    func pullToRefreshTableView()
}

class BaseTableView: UITableView {

    private var refreshControls:UIRefreshControl?

    weak var baseUITableViewDelegate:BaseUITableViewDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
        BaseTableViewHelper.shared.EmptyMessage(message: "Không có dữ liệu", tableview: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func configureRefreshControl(){
        self.refreshControls = UIRefreshControl()
        self.refreshControls?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.refreshControls?.addTarget(self, action: #selector(pullToRefreshHandler), for: .valueChanged)
        self.refreshControl = self.refreshControls
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func pullToRefreshHandler(){
        self.baseUITableViewDelegate?.pullToRefreshTableView()
    }
}

class BaseTableViewHelper {
    
    static let shared = BaseTableViewHelper()
    
    private init() {
        
    }
    
    func EmptyMessage(message:String, tableview:UITableView) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: tableview.bounds.size.width, height: tableview.bounds.size.height))
        let view = EmptyView(frame: rect)
        view.textLabel.text = message
        
        tableview.backgroundView = view
        tableview.separatorStyle = .none
    }
}

class EmptyView: UIView {
    
    let textLabel:BaseLabel = {
        let label = BaseLabel()
        return label
    }()
    
    private let logoImageView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "EmptyPageICON")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.textLabel)
        self.textLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        self.addSubview(self.logoImageView)
        self.logoImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.textLabel.snp.top).offset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(72)
            make.width.equalTo(72)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
