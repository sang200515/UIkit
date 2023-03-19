//
//  TableViewControllerXib.swift
//  fptshop
//
//  Created by Sang Trương on 26/08/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class TableViewControllerXib: UITableView {

    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }



    override func layoutSubviews() {
        super.layoutSubviews()

    }


}
