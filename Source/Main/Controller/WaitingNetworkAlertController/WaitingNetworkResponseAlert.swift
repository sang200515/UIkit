//
//  ƯaitingNetworkResponseAlert.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 06/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import UIKit;

class WaitingNetworkResponseAlert: UIViewController {
    static let nc = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    class func PresentWaitingAlert(parentVC: UIViewController){
        let newViewController = LoadingViewController();
        newViewController.content = "Đang lấy dữ liệu, bạn đợi xíu nhé"
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        parentVC.navigationController?.present(newViewController, animated: true, completion: nil);
    }
    
    class func PresentWaitingAlert(parentVC: UIViewController, completion: @escaping() -> Void){
        let newViewController = LoadingViewController();
        newViewController.content = "Đang lấy dữ liệu, bạn đợi xíu nhé"
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        parentVC.navigationController?.present(newViewController, animated: true, completion: completion)
    }
    
    class func PresentWaitingAlertWithContent(parentVC: UIViewController,content: String , completion: @escaping() -> Void){
        let newViewController = LoadingViewController();
        newViewController.content = content
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        parentVC.navigationController?.present(newViewController, animated: true, completion: completion)
    }
    
    class func DismissWaitingAlert(completion: @escaping() -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.nc.post(name: Notification.Name("dismissLoading"), object: nil);
            completion();
        }
    }
    
    class func DismissWaitingAlert(){
        self.nc.post(name: Notification.Name("dismissLoading"), object: nil);
    }
    
    class func DismissWaitingAlertWithTime(timeWaiting: Double, completion: @escaping() -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + timeWaiting) {
            self.nc.post(name: Notification.Name("dismissLoading"), object: nil);
            completion();
        }
    }
    
}
