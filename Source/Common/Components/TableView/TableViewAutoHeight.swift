//
//  TableViewAutoHeight.swift
//  fptshop
//
//  Created by Trần Văn Dũng on 03/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class TableViewAutoHeight: UITableView {
    
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
    private var refreshControls:UIRefreshControl?

    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
        TableViewHelper.EmptyMessage(message: "Không có dữ liệu", viewController: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
