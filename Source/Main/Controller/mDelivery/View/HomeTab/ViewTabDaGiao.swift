//
//  ViewTabDaGiao.swift
//  NewmDelivery
//
//  Created by sumi on 3/30/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit

class ViewTabDaGiao: UIView {
    var tableViewMainDaGiao: UITableView  =   UITableView()
    var scrollView:UIScrollView!
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let navigationHeight:CGFloat = 0
        
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        tableViewMainDaGiao.frame = CGRect(x: 0, y: 0 , width: UIScreen.main.bounds.size.width  , height: UIScreen.main.bounds.size.height  - (navigationHeight + UIApplication.shared.statusBarFrame.height));
        tableViewMainDaGiao.tableFooterView = UIView()
        tableViewMainDaGiao.backgroundColor = UIColor(netHex:0xffffff)
        
        addSubview(scrollView)
        scrollView.addSubview(tableViewMainDaGiao)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }


}
