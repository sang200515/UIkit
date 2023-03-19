//
//  NonPriorCallLogDetailsViewController.swift
//  mCallLog_v2
//
//  Created by Trần Thành Phương Đăng on 04/10/18.
//  Copyright © 2018 vn.com.fptshop. All rights reserved.
//

import UIKit;

class GenericCallLogScreenVC: UIViewController, UITextViewDelegate {
    
    var callLog: CallLog!;
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tbxRequestId: UILabel!
    @IBOutlet weak var tbxRequestDate: UILabel!
    @IBOutlet weak var tbxSender: UILabel!
    @IBOutlet weak var tbxReceiver: UILabel!
    @IBOutlet weak var tbxRequestTitle: UILabel!
    @IBOutlet weak var tbxComment: UITextView!
    @IBOutlet weak var btnSendRequest: UIButton!
    @IBOutlet weak var lblRequestDescription: UILabel!
    @IBOutlet weak var lblNewestComment: UILabel!
    @IBOutlet weak var lblCommentTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let acceptButton = UIBarButtonItem(image: UIImage(named: "ic_checked.png"), style: .plain, target: self, action: #selector(self.SendApprove));
        acceptButton.tintColor = UIColor(netHex: 0xffffff);
        let rejectButton = UIBarButtonItem(image: UIImage(named: "ic_deny.png"), style: .plain, target: self, action: #selector(self.SendNotApprove));
        rejectButton.tintColor = UIColor(netHex: 0xD94747);
        
        self.navigationItem.rightBarButtonItems = [rejectButton, acceptButton];
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        tbxComment.delegate = self;
        SetupView();
    }
    
    override func viewWillLayoutSubviews() {
        var text = self.lblRequestDescription.text!;
        text = FormatDescriptionString(thisText: text);
        self.SetViewSizeFitText(text: text);
        self.lblRequestDescription.text! = text;
    }
    
    func SetupView(){
        self.navigationItem.title = "\(callLog.RequestID!)";
//        let formattedDate = Common.GetDateStringFrom(jsonStr: callLog.CreateDateTime!)
        
        let callLogDescriptionDetails = callLog.RequestDesc!.replace("@@", withString: "\n");
        
        self.lblRequestDescription.text! = callLogDescriptionDetails;
        self.tbxRequestId.text! = "\(callLog.RequestID!)";
//        self.tbxRequestDate.text! = "\(formattedDate)";
        self.tbxRequestDate.text = "\(callLog.CreateDateTime ?? "")"
        self.tbxSender.text! = "Từ: \(callLog.EmployeeName!)";
        self.tbxReceiver.text! = "Đến: \(callLog.AssignToUserCode!)";
        self.tbxRequestTitle.text! = "\(callLog.RequestTitle!)";
        if(!(callLog.CommentLast ?? "").isEmpty){
            self.tbxComment.textColor = UIColor.black;
            self.lblNewestComment.text! = "\(callLog.CommentLast!)";
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.text! == "Nhập nội dung trao đổi"){
            textView.text = "";
            textView.textColor = UIColor.darkGray;
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView.text! == "Nhập nội dung trao đổi" || textView.text!.isEmpty == true){
            textView.text = "Nhập nội dung trao đổi";
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            textView.resignFirstResponder();
        }
        return true;
    }
    
    @IBAction func SendRequest(_ sender: Any) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            
            if(self.tbxComment.text! != "Nhập nội dung trao đổi" && self.tbxComment.text! != ""){
                let data = mCallLogApiManager.PostCallLogUpdate(callLogId: "\(self.callLog.RequestID!)", username: username, message: "\(self.tbxComment.text!)", approvation: 3, token: token).Data;
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if(data != nil){
                        if(data!.StatusCode! == 1){
                            let alertVC = UIAlertController(title: "Thông báo", message: "Gửi yêu cầu thành công", preferredStyle: .alert);
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                alertVC.dismiss(animated: true, completion: nil);
                                self.navigationController?.popViewController(animated: true);
                            });
                            alertVC.addAction(okAction);
                            
                            self.present(alertVC, animated: true, completion: nil);
                        }
                        else{
                            let alertVC = UIAlertController(title: "Thông báo", message: "Gửi yêu cầu không thành công", preferredStyle: .alert);
                            let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                alertVC.dismiss(animated: true, completion: nil);
                            });
                            alertVC.addAction(okAction);
                            
                            self.present(alertVC, animated: true, completion: nil);
                        }
                    }
                    else{
                        let alertVC = UIAlertController(title: "Thông báo", message: "User đã đăng nhập trên thiết bị khác.\nVui lòng kiểm tra lại", preferredStyle: .alert);
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                            alertVC.dismiss(animated: true, completion: nil);
                        });
                        
                        alertVC.addAction(okAction);
                        self.present(alertVC, animated: true, completion: nil);
                    }
                }
            }
            else{
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    let alertVC = UIAlertController(title: "Thông báo", message: "Bạn phải nhập yêu cầu trao đổi!", preferredStyle: .alert);
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                        alertVC.dismiss(animated: true, completion: nil);
                    });
                    alertVC.addAction(okAction);
                    
                    self.present(alertVC, animated: true, completion: nil);
                }
            }
        }
    }
    
    @objc func SendApprove(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            
            var _: Int = 1;
            let data = mCallLogApiManager.PostCallLogUpdate(callLogId: "\(self.callLog.RequestID!)", username: username, message: "Duyệt", approvation: 1, token: token).Data;
            
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if(data != nil){
                    if(data!.StatusCode! == 1){
                        let alertViewController = UIAlertController(title: "Thông báo", message: "Bạn đã duyệt CallLog thành công!", preferredStyle: .alert);
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
    
    @objc func SendNotApprove(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            
            let username = (Cache.user?.UserName)!;
            let token = (Cache.user?.Token)!;
            let data = mCallLogApiManager.PostCallLogUpdate(callLogId: "\(self.callLog!.RequestID!)", username: username, message: "Từ chối", approvation: 0, token: token).Data;
            
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if(data != nil){
                    if(data!.StatusCode! == 1){
                        let alertViewController = UIAlertController(title: "Thông báo", message: "Bạn đã từ chối CallLog thành công!", preferredStyle: .alert);
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
    
    private func SetViewSizeFitText(text: String) {
        var contentRect = CGRect.zero;
        
        print(self.lblRequestDescription.frame.height);
        
        let contentSize = (text as NSString).size(withAttributes: [NSAttributedString.Key.font: self.lblRequestDescription.font as Any]);
        let contentExceedHeight = contentSize.height - self.lblRequestDescription.frame.height;
        self.lblRequestDescription.frame = CGRect(x: self.lblRequestDescription.frame.minX, y: self.lblRequestDescription.frame.minY, width: self.lblRequestDescription.frame.width, height: contentSize.height + (contentSize.height - contentExceedHeight));
        print(self.lblRequestDescription.frame.height);
        
        lblCommentTitle.frame = CGRect(x: self.lblCommentTitle.frame.minX, y: 16 + self.lblCommentTitle.frame.minY + self.lblRequestDescription.frame.height, width: self.lblCommentTitle.frame.width, height: self.lblCommentTitle.frame.height);
        lblNewestComment.frame = CGRect(x: self.lblNewestComment.frame.minX, y: 8 + self.lblCommentTitle.frame.maxY, width: self.lblNewestComment.frame.width, height: self.lblNewestComment.frame.height);
        tbxComment.frame = CGRect(x: self.tbxComment.frame.minX, y: 8 + self.lblNewestComment.frame.maxY, width: self.tbxComment.frame.width, height: self.tbxComment.frame.height);
        btnSendRequest.frame = CGRect(x: self.btnSendRequest.frame.minX, y: 8 + self.tbxComment.frame.maxY, width: self.btnSendRequest.frame.width, height: self.btnSendRequest.frame.height);
        
        for view in contentView.subviews{
            contentRect = contentRect.union(view.frame);
        }
        
        contentRect.size.height += 20;
        scrollView.contentSize = contentRect.size;
    }
    
    private func FormatDescriptionString(thisText: String) -> String{
        var text: String = thisText;
        if(text.contains("Gửi yêu cầu phê duyệt đơn hàng công nợ")){
            text = text.replace("SO", withString: "\nSO");
        }
        if(text.contains("Tổng tiền xin của YCDC")){
            text = thisText.replace("- Tổng tiền xin trong 2 tuần là:", withString: "\n  Tổng tiền xin trong 2 tuần là: ");
            text = text.replace("Tổng tiền xin của YCDC", withString: "\n  Tổng tiền xin của YCDC");
            text = text.replace("Lý do", withString: "\n  Lý do");
            text = text.replace("- Số SO", withString: "\n  Số SO");
            text = text.replace("- Số phiếu BH", withString: "\n  Số phiếu BH");
            text = text.replace("- Khác", withString: "\n  Khác");
            text = text.replace("Số lượng yêu cầu", withString: "\nSố lượng yêu cầu");
        }
        return text;
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
