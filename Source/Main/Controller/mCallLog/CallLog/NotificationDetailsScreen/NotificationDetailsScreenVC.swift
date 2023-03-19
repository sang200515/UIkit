//
//  NonPriorCallLogDetailsViewController.swift
//  mCallLog_v2
//
//  Created by Trần Thành Phương Đăng on 04/10/18.
//  Copyright © 2018 vn.com.fptshop. All rights reserved.
//

import UIKit;

class NotificationDetailsScreenVC: UIViewController {
    
    var callLog: CallLog!;
    
    @IBOutlet weak var tbxRequestId: UILabel!
    @IBOutlet weak var tbxRequestDate: UILabel!
    @IBOutlet weak var tbxSender: UILabel!
    @IBOutlet weak var tbxReceiver: UILabel!
    @IBOutlet weak var tbxRequestTitle: UILabel!
    @IBOutlet weak var lblRequestDescription: UILabel!
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.bringSubviewToFront(emptyView);
        
        let rejectButton = UIBarButtonItem(image: UIImage(named: "ic_deny.png"), style: .plain, target: self, action: #selector(self.SendNotApprove));
        rejectButton.tintColor = UIColor(netHex: 0xD94747);
        
        self.navigationItem.rightBarButtonItem = rejectButton;
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        SetupView();
    }
    
    func SetupView(){
        self.navigationItem.title = "\(callLog.RequestID!)";
//        let formattedDate = Common.GetDateStringFrom(jsonStr: callLog.CreateDateTime!)
        var callLogDescriptionDetails = callLog.RequestDesc!.replace("</p>", withString: "\n\n");
        callLogDescriptionDetails = callLogDescriptionDetails.replace("<p>", withString: "");
        
        self.lblRequestDescription.text! = callLogDescriptionDetails;
        self.tbxRequestId.text! = "\(callLog.RequestID!)";
//        self.tbxRequestDate.text! = "\(formattedDate)";
        self.tbxRequestDate.text = "\(callLog.CreateDateTime ?? "")"
        self.tbxSender.text! = "Từ: \(callLog.EmployeeName!)";
        self.tbxReceiver.text! = "Đến: \(callLog.AssignToUserCode!)";
        self.tbxRequestTitle.text! = "\(callLog.RequestTitle!)";
        self.emptyView.isHidden = true;
    }
    
    @objc func SendNotApprove(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mCallLogApiManager.PostCallLogUpdate(callLogId: "\(self.callLog!.RequestID!)", username: username, message: "Từ chối", approvation: 0, token: token).Data;
            
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if(data != nil){
                    if(data!.StatusCode! == 1){
                        let alertViewController = UIAlertController(title: "Thông báo", message: "Bạn đã xoá thông báo!", preferredStyle: .alert);
                        let alertOkAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                            alertViewController.dismiss(animated: true, completion: nil);
                            self.navigationController?.popViewController(animated: true);
                        })
                        alertViewController.addAction(alertOkAction);
                        self.present(alertViewController, animated: true, completion: nil);
                    }
                    else{
                        let alertViewController = UIAlertController(title: "Thông báo", message: data!.Message!, preferredStyle: .alert);
                        let alertOkAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                            alertViewController.dismiss(animated: true, completion: nil);
                        })
                        alertViewController.addAction(alertOkAction);
                        self.present(alertViewController, animated: true, completion: nil);
                    }
                }
                else{
                    self.ShowUserLoginOtherDevice();
                }
            }
        }
    }
    
    private func ShowUserLoginOtherDevice(){
        let alertVC = UIAlertController(title: "Thông báo", message: "User đã đăng nhập trên thiết bị khác. \nVui lòng kiểm tra lại", preferredStyle: .alert);
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            alertVC.dismiss(animated: true, completion: nil);
        });
        
        alertVC.addAction(okAction);
        self.present(alertVC, animated: true, completion: nil);
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        if(self.view.frame.origin.y >= 0){
            self.view.frame.origin.y -= 165;
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        if(self.view.frame.origin.y < 0){
            self.view.frame.origin.y += 165;
        }
    }
}
