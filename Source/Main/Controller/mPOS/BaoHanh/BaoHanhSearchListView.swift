//
//  BaoHanhSearchListView.swift
//  mPOS
//
//  Created by sumi on 12/15/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit

class BaoHanhSearchListView: UIView {
    
    var tableViewSearchBaoHanh: UITableView  =   UITableView()
    var scrollView:UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        tableViewSearchBaoHanh.frame = CGRect(x: 0, y: 0 , width: UIScreen.main.bounds.size.width  , height: UIScreen.main.bounds.size.height  - (0.0 + UIApplication.shared.statusBarFrame.height));
        tableViewSearchBaoHanh.tableFooterView = UIView()
        tableViewSearchBaoHanh.backgroundColor = UIColor(netHex:0xffffff)
        
        addSubview(scrollView)
        scrollView.addSubview(tableViewSearchBaoHanh)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
}

