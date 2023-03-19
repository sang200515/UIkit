//
//  ThyHoSearchView.swift
//  mPOS
//
//  Created by sumi on 11/22/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import UIKit

class ThuHoSearchView: UIView {
    var tableViewSearchTenKH: UITableView  =   UITableView()
    var scrollView:UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        tableViewSearchTenKH.frame = CGRect(x: 0, y: 0 , width: UIScreen.main.bounds.size.width  , height: UIScreen.main.bounds.size.height  - (UIApplication.shared.statusBarFrame.height));
        tableViewSearchTenKH.tableFooterView = UIView()
        tableViewSearchTenKH.backgroundColor = UIColor(netHex:0xffffff)
        
        addSubview(scrollView)
        scrollView.addSubview(tableViewSearchTenKH)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
}

