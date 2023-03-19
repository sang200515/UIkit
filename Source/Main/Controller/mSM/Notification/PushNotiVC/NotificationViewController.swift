//
//  NotificationViewController.swift
//  TestMoya
//
//  Created by Trần Thành Phương Đăng on 5/21/18.
//  Copyright © 2018 fpt. All rights reserved.
//

import UIKit;
import Foundation;
import DZNEmptyDataSet;

class NotificationViewController: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    @IBOutlet weak var notificationView: UITableView!;
    var notificationList: [CallLog] = [];
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.SetupView();
    }
    
    private func SetupView(){
        let username = Cache.user?.UserName;
        let notificationCallLog = mSMApiManager.GetNotification(username: username!);
        
        if((notificationCallLog.Data!.count) > 0 && notificationCallLog.Error == ""){
            self.notificationList = notificationCallLog.Data!;
            notificationView.reloadData();
        }
        
        notificationView.emptyDataSetSource = self;
        notificationView.emptyDataSetDelegate = self;
        notificationView.tableFooterView = UIView();
    }
    
    //Setup empty table view if no notification received
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title = "Hiện tại không có thông báo nào";
        let attributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)];
        return NSAttributedString(string: title, attributes: attributes);
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let description = "Khi có thông báo từ hệ thống, \nnó sẽ được hiển thị ở đây";
        let attributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)];
        return NSAttributedString(string: description, attributes: attributes);
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "notificationEmptyIcon.png");
    }
}
