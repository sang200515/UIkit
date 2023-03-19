//
//  ViewTabDaNhan.swift
//  NewmDelivery
//
//  Created by sumi on 3/23/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit

class ViewTabDaNhan: UIView {
    var tableViewMainDaNhan: UITableView  =   UITableView()
    var scrollView:UIScrollView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
         let navigationHeight:CGFloat = 0
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        tableViewMainDaNhan.frame = CGRect(x: 0, y: 0 , width: UIScreen.main.bounds.size.width  , height: UIScreen.main.bounds.size.height  - (navigationHeight + UIApplication.shared.statusBarFrame.height));
        tableViewMainDaNhan.tableFooterView = UIView()
        tableViewMainDaNhan.backgroundColor = UIColor(netHex:0xffffff)
        
        addSubview(scrollView)
        scrollView.addSubview(tableViewMainDaNhan)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }

}
