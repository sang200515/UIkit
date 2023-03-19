//
//  NonPriorCallLogDetailsViewController.swift
//  mCallLog_v2
//
//  Created by Trần Thành Phương Đăng on 04/10/18.
//  Copyright © 2018 vn.com.fptshop. All rights reserved.
//

import UIKit;

class NonPriorCallLogDetailsVC: UIViewController, UITextViewDelegate {
    
    var callLog: CallLog!;
    
    @IBOutlet weak var tbxRequestId: UILabel!
    @IBOutlet weak var tbxRequestDate: UILabel!
    @IBOutlet weak var tbxSender: UILabel!
    @IBOutlet weak var tbxReceiver: UILabel!
    @IBOutlet weak var tbxRequestTitle: UILabel!
    @IBOutlet weak var tbxRequestAmount: UILabel!
    @IBOutlet weak var tbxReceiveShop: UILabel!
    @IBOutlet weak var tbxProductId: UILabel!
    @IBOutlet weak var tbxProductName: UILabel!
    @IBOutlet weak var tbxProductNameTitle: UILabel!
    @IBOutlet weak var tbxRemainQuantity: UILabel!
    @IBOutlet weak var tbxTransferRequestId: UILabel!
    @IBOutlet weak var tbxImportStorageId: UILabel!
    @IBOutlet weak var tbxExportStorageId: UILabel!
    @IBOutlet weak var tbxExportShopId: UILabel!
    @IBOutlet weak var tbxTotalFee2Weeks: UILabel!
    @IBOutlet weak var tbxTotalFeeRequest: UILabel!
    @IBOutlet weak var tbxComment: UITextView!
    @IBOutlet weak var btnSendRequest: UIButton!
    @IBOutlet weak var lblNewestComment: UILabel!
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.bringSubviewToFront(emptyView);
        
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
    
    func SetupView(){
        self.navigationItem.title = "\(callLog.RequestID!)";
//        let formattedDate = Common.GetDateStringFrom(jsonStr: callLog.CreateDateTime!)
        let callLogDescriptionDetails = CallLogDescriptionDetails.ParseStringToModel(fromStr: callLog.RequestDesc!);
        
        self.tbxRequestId.text! = "\(callLog.RequestID!)";
//        self.tbxRequestDate.text! = "\(formattedDate)";
        self.tbxRequestDate.text = "\(callLog.CreateDateTime ?? "")"
        self.tbxSender.text! = "Từ: \(callLog.EmployeeName!)";
        self.tbxReceiver.text! = "Đến: \(callLog.AssignToUserCode!)";
        self.tbxRequestTitle.text! = "\(callLog.RequestTitle!)";
        self.tbxRequestAmount.text! = "\(callLogDescriptionDetails.RequestAmount!)";
        self.tbxReceiveShop.text! = "\(callLogDescriptionDetails.ReceivingShop!)";
        self.tbxProductName.text! = "\(callLogDescriptionDetails.ProductName!)";
        self.tbxProductId.text! = "\(callLogDescriptionDetails.ProductId!)";
        self.tbxRemainQuantity.text! = "\(callLogDescriptionDetails.RemainAmount!)";
        self.tbxTransferRequestId.text! = "\(callLogDescriptionDetails.RequestNumber!)";
        self.tbxImportStorageId.text! = "\(callLogDescriptionDetails.ReceiveStorageId!)";
        self.tbxExportStorageId.text! = "\(callLogDescriptionDetails.ExportStorageId!)";
        self.tbxExportShopId.text! = "\(callLogDescriptionDetails.ExportShopName!)";
        self.tbxTotalFee2Weeks.text! = "0";
        self.tbxTotalFeeRequest.text! = "0";
        if(!(callLog.CommentLast ?? "").isEmpty){
            self.tbxComment.textColor = UIColor.black;
            self.lblNewestComment.text! = "\(callLog.CommentLast!)";
        }
        self.emptyView.isHidden = true;
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
        
            if(self.tbxComment.text != "Nhập nội dung trao đổi"){
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
            let alertVC = UIAlertController(title: "Thông báo", message: "Bạn phải nhập yêu cầu trao đổi!", preferredStyle: .alert);
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                alertVC.dismiss(animated: true, completion: nil);
            });
            alertVC.addAction(okAction);
            
            self.present(alertVC, animated: true, completion: nil);
        }
    }
    }
    
    @objc func SendApprove(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
        
        let username = (Cache.user?.UserName)!;
//        let token = (Cache.mCallLogToken);
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
