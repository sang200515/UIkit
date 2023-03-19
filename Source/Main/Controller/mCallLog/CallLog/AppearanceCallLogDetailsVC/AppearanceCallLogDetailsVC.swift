//
//  CallLogDetailsViewController.swift
//  mCallLog_v2
//
//  Created by Trần Thành Phương Đăng on 27/09/18.
//  Copyright © 2018 vn.com.fptshop. All rights reserved.
//

import UIKit;

class AppearanceCallLogDetailsVC: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var approvation: Int = 1;
    
    @IBOutlet weak var tbxRequestId: UILabel!
    @IBOutlet weak var tbxRequestDateTime: UILabel!
    @IBOutlet weak var tbxRequestFrom: UILabel!
    @IBOutlet weak var tbxRequestTo: UILabel!
    @IBOutlet weak var tbxRequestTitle: UILabel!
    @IBOutlet weak var tbxPackageId: UILabel!
    @IBOutlet weak var tbxContractId: UILabel!
    @IBOutlet weak var tbxExportDate: UILabel!
    @IBOutlet weak var tbxProductId: UILabel!
    @IBOutlet weak var tbxProductName: UILabel!
    @IBOutlet weak var tbxProductImei: UILabel!
    @IBOutlet weak var tbxProductQuantity: UILabel!
    @IBOutlet weak var tbxFeeCriteria: UILabel!
    @IBOutlet weak var imgvDefectiveProduct: UIImageView!
    @IBOutlet weak var imgvPackageAppearance: UIImageView!
    @IBOutlet weak var tbxRequestDescription: UITextView!
    @IBOutlet weak var btnSendResponse: UIButton!
    @IBOutlet weak var lblNewestComment: UILabel!
    @IBOutlet weak var emptyView: UIView!
    
    var imgViewType: Int!;
    let imgPicker = UIImagePickerController();
    var callLog: CallLog!;
    var defectiveImgPath: String!;
    var productBoxImgPath: String!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.bringSubviewToFront(emptyView);
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        self.navigationItem.title = "Duyệt thẩm mỹ";
        
        tbxRequestDescription.layer.borderColor = UIColor.lightGray.cgColor;
        tbxRequestDescription.delegate = self;
        
        imgPicker.delegate = self;
        
        imgvDefectiveProduct.isUserInteractionEnabled = true;
        imgvPackageAppearance.isUserInteractionEnabled = true;
        
        let defectiveProductImgvAction = UITapGestureRecognizer(target: self, action: #selector(self.imgvDefectiveProductTapped));
        let productPackageImgvAction = UITapGestureRecognizer(target: self, action: #selector(self.imgvProductPackageTapped));
        
        imgvPackageAppearance.addGestureRecognizer(productPackageImgvAction);
        imgvDefectiveProduct.addGestureRecognizer(defectiveProductImgvAction);
        
        self.SetupView();
    }
    
    @IBAction func SendResponse(_ sender: Any) {
        let username = (Cache.user?.UserName)!;
        let token = (Cache.user?.Token)!;
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            
            if(self.tbxRequestDescription.text != "Nhập nội dung trao đổi"){
                let response = mCallLogApiManager.PostCallLogUpdate(callLogId: "\(self.callLog.RequestID!)", username: username, message: self.tbxRequestDescription.text!, approvation: 3, token: token).Data;
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    
                    if(response != nil){
                        if(response!.StatusCode == 1){
                            let alertDialog = UIAlertController(title: "Thông báo", message: "Gửi trao đổi thành công!", preferredStyle: .alert)
                            alertDialog.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { _ in
                                alertDialog.dismiss(animated: true, completion: nil);
                                self.navigationController?.popViewController(animated: true);
                            }))
                            self.present(alertDialog, animated: true, completion: nil);
                        }
                        else{
                            let alertDialog = UIAlertController(title: "Thông báo", message: "Gửi trao đổi không thành công!", preferredStyle: .alert)
                            alertDialog.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { _ in
                                alertDialog.dismiss(animated: true, completion: nil);
                            }))
                            self.present(alertDialog, animated: true, completion: nil);
                        }
                    }
                    else{
                        self.ShowUserLoginOtherDevice();
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
    
    func textViewDidBeginEditing(_ textView: UITextView){
        if(textView.text! == "Nhập nội dung trao đổi"){
            textView.text = "";
            textView.textColor = UIColor.darkGray;
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            textView.resignFirstResponder();
        }
        return true;
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if(imgViewType == 1){
            var chosenImage = UIImage()
            chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage //2
            self.imgvDefectiveProduct.contentMode = .scaleAspectFit //3
            self.imgvDefectiveProduct.image = chosenImage //4
            dismiss(animated:true, completion: nil) //5
        }
        else if(imgViewType == 2){
            var chosenImage = UIImage()
            chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage //2
            self.imgvPackageAppearance.contentMode = .scaleAspectFit //3
            self.imgvPackageAppearance.image = chosenImage //4
            dismiss(animated:true, completion: nil) //5
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil);
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
    
    func SetupView(){
        let username = (Cache.user?.UserName)!;
        let token = (Cache.user?.Token)!;
        var data: [AppearanceCallLog]?;
        
        self.navigationItem.title = "\(callLog.RequestID!)";
        
        let acceptButton = UIBarButtonItem(image: UIImage(named: "ic_checked.png"), style: .plain, target: self, action: #selector(self.SendApprove));
        acceptButton.tintColor = UIColor(netHex: 0xffffff);
        
        self.navigationItem.rightBarButtonItem = acceptButton;
        
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            data = mCallLogApiManager.GetAppearanceCallLogDetails(requestId: "\(self.callLog!.RequestID!)", username: username, token: token).Data;
            
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                self.emptyView.isHidden = true;
                if(data != nil){
                    if (data!.count > 0){
//                        let formattedDate = Common.GetDateStringFrom(jsonStr: self.callLog.CreateDateTime!);
                        
                        self.tbxRequestId.text! = "\(data![0].Request_Id!)";
                        self.tbxRequestDateTime.text! = "\(self.callLog.CreateDateTime ?? "")";
                        self.tbxRequestFrom.text! = "Từ: \(self.callLog.EmployeeName!)";
                        self.tbxRequestTo.text! = "Đến: \(self.callLog.AssignToUserCode!)";
                        self.tbxRequestTitle.text! = "\(self.callLog.RequestTitle!)";
                        self.tbxPackageId.text! = "\(data![0].RequestDetail_SoDonHang!)"
                        self.tbxContractId.text! = "\(data![0].RequestDetail_SoHD!)";
                        self.tbxExportDate.text! = "\(data![0].RequestDetail_NgayXuat!)";
                        self.tbxProductId.text! = "\(data![0].RequestDetail_MaSanPham!)";
                        self.tbxProductName.text! = "\(data![0].RequestDetail_TenSanPham!)";
                        self.tbxProductImei.text! = "\(data![0].RequestDetail_Imei!)"
                        self.tbxProductQuantity.text! = "\(data![0].RequestDetail_SoLuong!)";
                        self.tbxFeeCriteria.text! = "\(data![0].RequestDetail_TieuChiTinhPhi!)";
                        self.imgvDefectiveProduct.getImg(from: "\(data![0].RequestDetail_HinhAnhMayLoi ?? "")");
                        self.imgvPackageAppearance.getImg(from: "\(data![0].RequestDetail_HinhAnhVoHop ?? "")");
                        if(!"\(self.callLog.CommentLast ?? "")".isEmpty){
                            self.tbxRequestDescription.textColor = UIColor.black;
                            self.lblNewestComment.text! = self.callLog.CommentLast!;
                        }
                    }
                }
                else{
                    self.ShowUserLoginOtherDevice();
                }
            }
        }
    }
    
    func PostChangingStep(urlDefectiveProduct: String, urlPackageImg: String){
        var response: [CallLogUpdateResult]?;
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            
            let username = (Cache.user?.UserName)!;
            //        let token = (Cache.mCallLogToken);
            let token = (Cache.user?.Token)!;
            response = mCallLogApiManager.PostChangingStep(requestId: "\(self.callLog!.RequestID!)", message: self.tbxRequestDescription.text!, updatedBy: username, urlDefectiveProductImg: urlDefectiveProduct, urlPackageImg: urlPackageImg, username: username, token: token).Data;
            
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if(response != nil){
                    if(response![0].StatusCode! == 1){
                        let alertDialog = UIAlertController(title: "Thông báo", message: "Gửi trao đổi thành công!", preferredStyle: .alert)
                        alertDialog.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { _ in
                            self.dismiss(animated: true, completion: nil);
                        }))
                        self.present(alertDialog, animated: true, completion: nil);
                    }
                    else{
                        let alertDialog = UIAlertController(title: "Thông báo", message: "Gửi trao đổi không thành công!", preferredStyle: .alert)
                        alertDialog.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { _ in
                            alertDialog.dismiss(animated: true, completion: nil);
                        }))
                        self.present(alertDialog, animated: true, completion: nil);
                    }
                }
                else{
                    self.ShowUserLoginOtherDevice();
                }
            }
        }
    }
    
    func UploadImgToServer(defectiveImg: UIImage, productBoxImg: UIImage){
        let username = (Cache.user?.UserName)!;
        let date = Date();
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "dd-MM-yyyy_HH-mm-ss";
        let defectiveImgName = "\(username)_\(dateFormatter.string(from: date)).jpg";
        let productBoxImgName = "\(username)_\(dateFormatter.string(from: date.addingTimeInterval(60.0))).jpg";
        //Convert image to Base64 String
        let imageData = defectiveImg.jpegData(compressionQuality: 0.5)! as NSData;
        let encodedImg = imageData.base64EncodedString(options: .lineLength64Characters);
        let productBoxImgData = productBoxImg.jpegData(compressionQuality: 0.5)! as NSData;
        let productBoxEncodedImg = productBoxImgData.base64EncodedString(options: .lineLength64Characters);
        let defectiveResult = mCallLogApiManager.UploadImage(fileName: defectiveImgName, encodedImg: encodedImg, username: username).Data;
        let productBoxResult = mCallLogApiManager.UploadImage(fileName: productBoxImgName, encodedImg: productBoxEncodedImg, username: username).Data;
        
        if(defectiveResult != nil && productBoxResult != nil){
            if(defectiveResult!.Result == 1 && productBoxResult!.Result == 1){
                self.defectiveImgPath = defectiveResult!.FilePath!;
                self.productBoxImgPath = productBoxResult!.FilePath!;
            }
        }
    }
    
    func OpenImgOptionMenu(){
        _ = CameraHandler(delegate_: self);
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let takePhoto = UIAlertAction(title: "Chụp ảnh", style: .default) { (alert : UIAlertAction!) in
            self.OpenCamera(imgPicker: self.imgPicker);
        }
        let sharePhoto = UIAlertAction(title: "Chọn ảnh có sẵn", style: .default) { (alert : UIAlertAction!) in
            self.OpenImgLibrary(imgPicker: self.imgPicker)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @objc func SendApprove(){
        var data: [CallLogUpdateResult]?;
        let username = (Cache.user?.UserName)!;
        let token = (Cache.user?.Token)!;
        let defectiveImgData = self.imgvDefectiveProduct.image?.pngData();
        let productBoxImgData = self.imgvPackageAppearance.image?.pngData();
        let defaultImgData = UIImage(named: "1508044")?.pngData();
        
        if(defectiveImgData == defaultImgData || productBoxImgData == defaultImgData){
            let alertVC = UIAlertController(title: "Thông báo", message: "Bạn chưa chọn đủ 2 hình\n Vui lòng kiểm tra lại", preferredStyle: .alert);
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                alertVC.dismiss(animated: true, completion: nil);
            });
            
            alertVC.addAction(okAction);
            self.present(alertVC, animated: true, completion: nil);
        }
            
        else{
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
                
                self.UploadImgToServer(defectiveImg: self.imgvDefectiveProduct.image!, productBoxImg: self.imgvPackageAppearance.image!);

                data = mCallLogApiManager.PostChangingStep(requestId: "\(self.callLog!.RequestID!)", message: self.tbxRequestDescription.text!, updatedBy: username, urlDefectiveProductImg: self.defectiveImgPath, urlPackageImg: self.productBoxImgPath, username: username, token: token).Data;
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if(data != nil){
                        if(data![0].StatusCode! == 1){
                            let alertViewController = UIAlertController(title: "Thông báo", message: "Bạn đã duyệt CallLog thành công!", preferredStyle: .alert);
                            let alertOkAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                                alertViewController.dismiss(animated: true, completion: nil);
                                self.navigationController?.popViewController(animated: true);
                            })
                            alertViewController.addAction(alertOkAction);
                            self.present(alertViewController, animated: true, completion: nil);
                        }
                        else{
                            let alertViewController = UIAlertController(title: "Thông báo", message: data![0].Message!, preferredStyle: .alert);
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
    }
    
    @objc func imgvDefectiveProductTapped(){
        self.imgViewType = 1;
        OpenImgOptionMenu();
    }
    
    @objc func imgvProductPackageTapped(){
        self.imgViewType = 2;
        OpenImgOptionMenu();
    }
    
    private func OpenCamera(imgPicker: UIImagePickerController){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imgPicker.allowsEditing = false
            imgPicker.sourceType = .camera
            imgPicker.cameraCaptureMode = .photo
            imgPicker.modalPresentationStyle = .fullScreen
            present(imgPicker,animated: true,completion: nil)
        }
        else {
            let alertVC = UIAlertController(title: "Lỗi", message: "Thiết bị không có camera", preferredStyle: .alert);
            let okAction = UIAlertAction(title: "OK", style:.default, handler: nil);
            alertVC.addAction(okAction);
            present(alertVC, animated: true, completion: nil);
        }
    }
    
    private func OpenImgLibrary(imgPicker: UIImagePickerController){
        imgPicker.allowsEditing = false
        imgPicker.sourceType = .photoLibrary
        imgPicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imgPicker.modalPresentationStyle = .popover
        present(imgPicker, animated: true, completion: nil)
    }
    
    private func ShowUserLoginOtherDevice(){
        let alertVC = UIAlertController(title: "Thông báo", message: "User đã đăng nhập trên thiết bị khác. \nVui lòng kiểm tra lại", preferredStyle: .alert);
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            alertVC.dismiss(animated: true, completion: nil);
        });
        
        alertVC.addAction(okAction);
        self.present(alertVC, animated: true, completion: nil);
    }
}
