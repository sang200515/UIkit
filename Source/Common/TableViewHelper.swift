//
//  TableViewHelper.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/18/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit

class TableViewHelper {
    
    class func EmptyMessage(message:String, viewController:UITableView) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: viewController.frame.size.width, height: viewController.frame.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: Common.Size(s: 12))
        messageLabel.sizeToFit()
        viewController.backgroundView = messageLabel;
        //        viewController.separatorStyle = .none;
    }
    class func removeEmptyMessage(viewController:UITableView) {
        viewController.backgroundView = .none;
    }
}
