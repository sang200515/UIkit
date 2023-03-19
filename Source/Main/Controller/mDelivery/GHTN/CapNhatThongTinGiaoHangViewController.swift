//
//  CapNhatThongTinGiaoHangViewController.swift
//  NewmDelivery
//
//  Created by sumi on 3/26/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import GooglePlacePicker
import GooglePlaces
import GoogleMaps
import Toaster

protocol CapNhatThongTinGiaoHangViewControllerDelegate:AnyObject {
    func updateListGHTN()
}

class CapNhatThongTinGiaoHangViewController: UIViewController  ,GMSMapViewDelegate, UITextFieldDelegate {
    
    var mTimeGiao:String?
    var companyButton: SearchTextField!
    let datePicker = UIDatePicker()
    var imageTenKH: UIImageView!
    var labelDiaChi:UILabel!
    var edtDiaChi:UITextField!
    var noteLabel:UILabel!
    var labelThoiGianGiao:UILabel!
    var edtThoiGianGiaoHang:UITextField!
    var scrollView:UIScrollView!
    var btnXacNhan:UIButton!
    weak var delegate:CapNhatThongTinGiaoHangViewControllerDelegate?
    var labelLyDoThayDoi:UILabel!
    
    var mTypeCheckPush:Bool = false
    
    var mObjectData:GetSOByUserResult?
    var mOldDiaChi:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        initView()
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(imageGetDate(tapGestureRecognizer:)))
        imageGetDate(tapGestureRecognizer: tapGestureRecognizer3)
        imageTenKH.isUserInteractionEnabled = true
        imageTenKH.addGestureRecognizer(tapGestureRecognizer3)
        
        self.edtDiaChi.delegate = self
        self.btnXacNhan.addTarget(self, action: #selector(self.ClickXacNhan), for: .touchUpInside)
        
        let listCom: [String] = ["Shop không giao kịp","Khách hàng thay đổi"]
        self.companyButton.filterStrings(listCom)
        self.edtDiaChi.text = "\((mObjectData?.U_AdrDel)!)"
        self.mOldDiaChi = self.edtDiaChi.text!
        
        self.companyButton.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            
            self.companyButton.text = item.title
            self.view.endEditing(true)
            
        }
        if(mTimeGiao != "nil")
        {
            edtThoiGianGiaoHang.text = mObjectData?.DeliveryDateTime
        }
    }
    
    
    @objc func CancelDatePicker()
    {
        view.endEditing(true)
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        let acController = GMSAutocompleteViewController()
//
//        acController.tableCellBackgroundColor = UIColor.lightGray
//
//
//        acController.delegate = self
//        self.present(acController, animated: true, completion: nil)
//    }
    
    @objc func DoneDatePicker()
    {
        print("asdsadsa\(datePicker.date)")
        let dateFormatter = DateFormatter()
        let dateFormatterSave = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy hh:mm"
        
        dateFormatterSave.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        
        
        
        edtThoiGianGiaoHang.text = dateFormatterSave.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }
    
    @objc func ClickXacNhan()
    {
        if(self.edtDiaChi.text != "" && self.edtThoiGianGiaoHang.text != "" && self.companyButton.text != "")
        {
            if(self.companyButton.text == "Shop không giao kịp" || self.companyButton.text == "Khách hàng thay đổi")
            {
                /* 1 => push 0=> k push */
                let formattedString = (self.edtDiaChi.text)!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                let formattedString2 = self.mObjectData?.EmpName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                _ = (self.edtThoiGianGiaoHang.text)!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                let formattedString4 = (self.companyButton.text)!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                if(self.mOldDiaChi != self.edtDiaChi.text)
                {
                    self.getDataSetSO_Info(docNum :"\((self.mObjectData?.ID)!)", userName :"\(self.mObjectData?.UserName ?? "")", empName : "\(formattedString2!)" , bookDate :"\((self.mObjectData?.BookDate)!)", whConfirmed :"\((self.mObjectData?.WHConfirmed)!)", whDate :"\((self.mObjectData?.WHDate)!)", rejectReason :"\((self.mObjectData?.RejectReason)!)", rejectDate :"\((self.mObjectData?.RejectDate)!)", paymentType :"\((self.mObjectData?.PaymentType)!)", paymentAmount :"\((self.mObjectData?.U_PaidMoney)!)", paymentDistance :"" , finishLatitude :"\((self.mObjectData?.FinishLatitude)!)", finishLongitude :"\((self.mObjectData?.FinishLongitude)!)", finishTime :"\((self.mObjectData?.FinishTime)!)", paidConfirmed :"\((self.mObjectData?.PaidConfirmed)!)", paidDate :"\((self.mObjectData?.PaidDate)!)", orderStatus :"\((self.mObjectData?.OrderStatus)!)", u_addDel :"\(formattedString!)", u_dateDe :"\((self.edtThoiGianGiaoHang.text)!)", u_paidMoney :"\((self.mObjectData?.U_PaidMoney)!)", rowVersion :"\((self.mObjectData?.RowVersion)!)", Is_PushSMS: "0",U_AdrDel_New_Reason:"", U_DateDe_New_Reason:"\(formattedString4!)")
                }
                else
                {
                    if(self.companyButton.text == "Shop không giao kịp")
                    {
                        let alertController = UIAlertController(title: "Thông báo", message: "Khi cập nhật lại thời gian giao hàng mới, hệ thống sẽ gửi SMS cho khách hàng. Bạn vui lòng kiểm tra kĩ trước khi bấm xác nhận !", preferredStyle: .alert)
                        
                        // Create the actions
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            
                            var mTypePush:String = "0"
                            if(self.companyButton.text == "Shop không giao kịp" )
                            {
                                mTypePush = "1"
                            }
                            else
                            {
                                mTypePush = "0"
                            }
                            let formattedString4 = (self.companyButton.text)!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//                            self.getDataSetSO_Info(docNum :"\((self.mObjectData?.ID)!)", userName :"\(Cache.user!.UserName)", empName : "\(formattedString2!)" , bookDate :"\((self.mObjectData?.BookDate)!)", whConfirmed :"\((self.mObjectData?.WHConfirmed)!)", whDate :"\((self.mObjectData?.WHDate)!)", rejectReason :"\((self.mObjectData?.RejectReason)!)", rejectDate :"\((self.mObjectData?.RejectDate)!)", paymentType :"\((self.mObjectData?.PaymentType)!)", paymentAmount :"\((self.mObjectData?.U_PaidMoney)!)", paymentDistance :"" , finishLatitude :"\((self.mObjectData?.FinishLatitude)!)", finishLongitude :"\((self.mObjectData?.FinishLongitude)!)", finishTime :"\((self.mObjectData?.FinishTime)!)", paidConfirmed :"\((self.mObjectData?.PaidConfirmed)!)", paidDate :"\((self.mObjectData?.PaidDate)!)", orderStatus :"\((self.mObjectData?.OrderStatus)!)", u_addDel :"\(formattedString!)", u_dateDe :"\((self.edtThoiGianGiaoHang.text)!)", u_paidMoney :"\((self.mObjectData?.U_PaidMoney)!)", rowVersion :"\((self.mObjectData?.RowVersion)!)", Is_PushSMS: "\(mTypePush)",U_AdrDel_New_Reason:"", U_DateDe_New_Reason:"\(self.companyButton.text!)")
                              self.getDataSetSO_Info(docNum :"\((self.mObjectData?.ID)!)", userName :"\(Cache.user!.UserName)", empName : "\(formattedString2!)" , bookDate :"\((self.mObjectData?.BookDate)!)", whConfirmed :"\((self.mObjectData?.WHConfirmed)!)", whDate :"\((self.mObjectData?.WHDate)!)", rejectReason :"\((self.mObjectData?.RejectReason)!)", rejectDate :"\((self.mObjectData?.RejectDate)!)", paymentType :"\((self.mObjectData?.PaymentType)!)", paymentAmount :"\((self.mObjectData?.U_PaidMoney)!)", paymentDistance :"" , finishLatitude :"\((self.mObjectData?.FinishLatitude)!)", finishLongitude :"\((self.mObjectData?.FinishLongitude)!)", finishTime :"\((self.mObjectData?.FinishTime)!)", paidConfirmed :"\((self.mObjectData?.PaidConfirmed)!)", paidDate :"\((self.mObjectData?.PaidDate)!)", orderStatus :"\((self.mObjectData?.OrderStatus)!)", u_addDel :"\(formattedString!)", u_dateDe :"\((self.edtThoiGianGiaoHang.text)!)", u_paidMoney :"\((self.mObjectData?.U_PaidMoney)!)", rowVersion :"\((self.mObjectData?.RowVersion)!)", Is_PushSMS: "\(mTypePush)",U_AdrDel_New_Reason:"", U_DateDe_New_Reason:"\(formattedString4!)")
                        }
                        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                            UIAlertAction in
                            NSLog("Cancel Pressed")
                        }
                        
                        // Add the actions
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                    }
                    else
                    {
                        self.getDataSetSO_Info(docNum :"\((self.mObjectData?.ID)!)", userName :"\(Cache.user!.UserName)", empName : "\(formattedString2!)" , bookDate :"\((self.mObjectData?.BookDate)!)", whConfirmed :"\((self.mObjectData?.WHConfirmed)!)", whDate :"\((self.mObjectData?.WHDate)!)", rejectReason :"\((self.mObjectData?.RejectReason)!)", rejectDate :"\((self.mObjectData?.RejectDate)!)", paymentType :"\((self.mObjectData?.PaymentType)!)", paymentAmount :"\((self.mObjectData?.U_PaidMoney)!)", paymentDistance :"" , finishLatitude :"\((self.mObjectData?.FinishLatitude)!)", finishLongitude :"\((self.mObjectData?.FinishLongitude)!)", finishTime :"\((self.mObjectData?.FinishTime)!)", paidConfirmed :"\((self.mObjectData?.PaidConfirmed)!)", paidDate :"\((self.mObjectData?.PaidDate)!)", orderStatus :"\((self.mObjectData?.OrderStatus)!)", u_addDel :"\(formattedString!)", u_dateDe :"\((self.edtThoiGianGiaoHang.text)!)", u_paidMoney :"\((self.mObjectData?.U_PaidMoney)!)", rowVersion :"\((self.mObjectData?.RowVersion)!)", Is_PushSMS: "0",U_AdrDel_New_Reason:"", U_DateDe_New_Reason:"\(String(describing: self.companyButton.text))")
                    }
                    
                }
                
            }
            else
            {
                let alertController = UIAlertController(title: "Thông báo", message: "Vui Lòng chọn 1 trong 2 lý do thay đổi!", preferredStyle: .alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                }
                // Add the actions
                alertController.addAction(okAction)
                
                // Present the controller
                self.present(alertController, animated: true, completion: nil)
            }
        }else{
            if(self.edtDiaChi.text == ""){
                let alertController = UIAlertController(title: "Thông báo", message: "Vui Lòng nhập địa chỉ giao hàng!", preferredStyle: .alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                }
                // Add the actions
                alertController.addAction(okAction)
                
                // Present the controller
                self.present(alertController, animated: true, completion: nil)
            }
            if(self.edtThoiGianGiaoHang.text == ""){
                let alertController = UIAlertController(title: "Thông báo", message: "Vui Lòng chọn thời gian giao hàng!", preferredStyle: .alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                }
                // Add the actions
                alertController.addAction(okAction)
                
                // Present the controller
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        
        
        
        
        
        
        
        
        
    }
    
    func getDataSetSO_Info(docNum :String, userName :String, empName :String , bookDate :String, whConfirmed :String, whDate :String, rejectReason :String, rejectDate :String, paymentType :String, paymentAmount :String, paymentDistance :String , finishLatitude :String, finishLongitude :String, finishTime :String, paidConfirmed :String, paidDate :String, orderStatus :String, u_addDel :String, u_dateDe :String, u_paidMoney :String, rowVersion :String,Is_PushSMS:String,U_AdrDel_New_Reason:String, U_DateDe_New_Reason:String)
    {
        MDeliveryAPIService.GetDataSetSOInfo(docNum :docNum, userName :userName, empName :empName , bookDate :bookDate, whConfirmed :whConfirmed, whDate :whDate, rejectReason :rejectReason, rejectDate :rejectDate, paymentType :paymentType, paymentAmount :paymentAmount, paymentDistance :paymentDistance , finishLatitude :finishLatitude, finishLongitude :finishLongitude, finishTime :finishTime, paidConfirmed :paidConfirmed, paidDate :paidDate, orderStatus :orderStatus, u_addDel :u_addDel, u_dateDe :u_dateDe, u_paidMoney :u_paidMoney, rowVersion :rowVersion,Is_PushSMS:Is_PushSMS,U_AdrDel_New_Reason:U_AdrDel_New_Reason, U_DateDe_New_Reason:U_DateDe_New_Reason){ (error: Error?, success: Bool, result: ConfirmThuKhoResult!) in
            if success
            {
                if(result != nil )
                {
                    Toast(text: "\(result.Descriptionn)").show()
                    
//                    let newViewController = GHTNViewController()
//                    self.navigationController?.pushViewController(newViewController, animated: true)
                    self.navigationController?.popViewController(animated: true)
                    self.delegate?.updateListGHTN()
                    
                }
                
            }
            else
            {
                
            }
        }
    }
    
    
    //    @objc func imageGetDate(tapGestureRecognizer: UITapGestureRecognizer)
    //    {
    //        print("asdsadsa)")
    //        edtThoiGianGiaoHang.becomeFirstResponder()
    //        //Formate Date
    //
    //        datePicker.datePickerMode = .dateAndTime
    //        //ToolBar
    //        let toolbar = UIToolbar();
    //        toolbar.sizeToFit()
    //        //done button & cancel button
    //        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(DoneDatePicker))
    //        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    //        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.bordered, target: self, action: #selector(CancelDatePicker))
    //        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
    //        // add toolbar to textField
    //        edtThoiGianGiaoHang.inputAccessoryView = toolbar
    //        // add datepicker to textField
    //        edtThoiGianGiaoHang.inputView = datePicker
    //        edtThoiGianGiaoHang.becomeFirstResponder()
    //    }
    @objc func imageGetDate(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("asdsadsa)")
        
        //Formate Date
        
        datePicker.datePickerMode = .dateAndTime
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(DoneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(CancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        // add toolbar to textField
        edtThoiGianGiaoHang.inputAccessoryView = toolbar
        // add datepicker to textField
        edtThoiGianGiaoHang.inputView = datePicker
    }
    //    @objc func DoneDatePicker()
    //    {
    //        print("asdsadsa\(datePicker.date)")
    //        var dateFormatter = DateFormatter()
    //
    //
    //
    //        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    //        edtThoiGianGiaoHang.text = dateFormatter.string(from: datePicker.date)
    //        endEditing(true)
    //    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func initView()
    {
        scrollView = UIScrollView(frame: CGRect(x: 0,y: 0 ,width:UIScreen.main.bounds.size.width , height:  UIScreen.main.bounds.size.height - Common.Size(s:50) - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) ))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        let strTitleNgMua = "Địa chỉ giao hàng "
        labelDiaChi = UILabel(frame: CGRect(x: Common.Size(s:20), y: Common.Size(s: 10) , width: UIScreen.main.bounds.size.width , height: Common.Size(s:13)))
        labelDiaChi.textAlignment = .left
        labelDiaChi.textColor = UIColor.black
        labelDiaChi.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelDiaChi.text = strTitleNgMua
        
        
        edtDiaChi = UITextField(frame: CGRect(x: (UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width * 6 / 7) / 2, y: labelDiaChi.frame.origin.y + labelDiaChi.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width * 6 / 7 , height:  Common.Size(s:40)));
        edtDiaChi.placeholder = ""
        edtDiaChi.textAlignment = .center
        edtDiaChi.font = UIFont.systemFont(ofSize:  Common.Size(s:13))
        edtDiaChi.borderStyle = UITextField.BorderStyle.roundedRect
        edtDiaChi.autocorrectionType = UITextAutocorrectionType.no
        edtDiaChi.keyboardType = UIKeyboardType.default
        edtDiaChi.returnKeyType = UIReturnKeyType.done
        edtDiaChi.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtDiaChi.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtDiaChi.text = "245 sư vạn hạnh p9 q10 tp hồ chí minh"
        
        noteLabel = UILabel(frame: CGRect(x: Common.Size(s:20), y: edtDiaChi.frame.size.height + edtDiaChi.frame.origin.y, width: edtDiaChi.frame.size.width , height: 70))
        noteLabel.textAlignment = .left
        noteLabel.numberOfLines = 0
        noteLabel.textColor = UIColor.red
        noteLabel.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        noteLabel.text = "Note: Nhập đúng số nhà, tên đường, phường/xã, Tỉnh/TP. Ví Dụ: 137 Tân Lập 2, Phường Hiệp Phú, Quận 9, Tp.HCM"
        
        
        labelThoiGianGiao = UILabel(frame: CGRect(x: Common.Size(s:20), y: noteLabel.frame.size.height + noteLabel.frame.origin.y   + Common.Size(s:10) , width: UIScreen.main.bounds.size.width , height: Common.Size(s:20)))
        labelThoiGianGiao.textAlignment = .left
        labelThoiGianGiao.textColor = UIColor.black
        labelThoiGianGiao.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelThoiGianGiao.text = "Thời gian giao hàng"
        
        
        edtThoiGianGiaoHang = UITextField(frame: CGRect(x: (UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width * 6 / 7) / 2, y: labelThoiGianGiao.frame.origin.y + labelThoiGianGiao.frame.size.height  + Common.Size(s:10), width: UIScreen.main.bounds.size.width * 6 / 7 , height:  Common.Size(s:40)));
        edtThoiGianGiaoHang.placeholder = ""
        edtThoiGianGiaoHang.textAlignment = .center
        edtThoiGianGiaoHang.font = UIFont.systemFont(ofSize:  Common.Size(s:13))
        edtThoiGianGiaoHang.borderStyle = UITextField.BorderStyle.roundedRect
        edtThoiGianGiaoHang.autocorrectionType = UITextAutocorrectionType.no
        edtThoiGianGiaoHang.keyboardType = UIKeyboardType.default
        edtThoiGianGiaoHang.returnKeyType = UIReturnKeyType.done
        edtThoiGianGiaoHang.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtThoiGianGiaoHang.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        let mDate = Date()
        let mFormatter = DateFormatter()
        
        mFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        
        
        
        edtThoiGianGiaoHang.text = mFormatter.string(from: mDate)
        
        
        
        
        
        edtThoiGianGiaoHang.rightViewMode = UITextField.ViewMode.always
        imageTenKH = UIImageView(frame: CGRect(x: edtThoiGianGiaoHang.frame.size.height/4, y: edtThoiGianGiaoHang.frame.size.height/4, width: edtThoiGianGiaoHang.frame.size.height/2, height: edtThoiGianGiaoHang.frame.size.height/2))
        imageTenKH.image = UIImage(named: "calendarIC")
        
        imageTenKH.contentMode = UIView.ContentMode.scaleAspectFit
        let rightViewTenKH = UIView()
        rightViewTenKH.addSubview(imageTenKH)
        rightViewTenKH.frame = CGRect(x: 0, y: 0, width: edtThoiGianGiaoHang.frame.size.height, height: edtThoiGianGiaoHang.frame.size.height)
        edtThoiGianGiaoHang.rightView = rightViewTenKH
        
        
        
        labelLyDoThayDoi = UILabel(frame: CGRect(x: Common.Size(s:20), y: edtThoiGianGiaoHang.frame.size.height + edtThoiGianGiaoHang.frame.origin.y   + Common.Size(s:10) , width: UIScreen.main.bounds.size.width , height: Common.Size(s:13)))
        labelLyDoThayDoi.textAlignment = .left
        labelLyDoThayDoi.textColor = UIColor.black
        labelLyDoThayDoi.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelLyDoThayDoi.text = "Lý do thay đổi thời gian giao"
        
        companyButton = SearchTextField(frame: CGRect(x: edtThoiGianGiaoHang.frame.origin.x , y: labelLyDoThayDoi.frame.origin.y + labelLyDoThayDoi.frame.size.height + Common.Size(s:5), width: labelLyDoThayDoi.frame.size.width - Common.Size(s:40) , height: Common.Size(s:30) ));
        companyButton.placeholder = "Shop không giao kịp"
        companyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton.text = "Shop không giao kịp"
        companyButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        companyButton.autocorrectionType = UITextAutocorrectionType.no
        companyButton.keyboardType = UIKeyboardType.default
        companyButton.returnKeyType = UIReturnKeyType.done
        companyButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        companyButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        companyButton.startVisible = true
        companyButton.theme.bgColor = UIColor.white
        companyButton.theme.fontColor = UIColor.black
        companyButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.theme.cellHeight = Common.Size(s:40)
        
        
        btnXacNhan = UIButton(frame: CGRect(x: (UIScreen.main.bounds.size.width - (UIScreen.main.bounds.size.width * 6 / 7)) / 2, y: companyButton.frame.origin.y + companyButton.bounds.size.height + Common.Size(s: 10)  , width: UIScreen.main.bounds.size.width * 6 / 7 , height: Common.Size(s:40)));
        btnXacNhan.backgroundColor = UIColor(netHex:0x107add)
        btnXacNhan.layer.cornerRadius = 10
        btnXacNhan.layer.borderWidth = 1
        btnXacNhan.layer.borderColor = UIColor.white.cgColor
        btnXacNhan.setTitle("Xác nhận",for: .normal)
        btnXacNhan.setTitleColor(UIColor(netHex:0xffffff), for: .normal)
        
        self.view.addSubview(scrollView)
        
        self.scrollView.addSubview(labelDiaChi)
        self.scrollView.addSubview(edtDiaChi)
        self.scrollView.addSubview(noteLabel)
        self.scrollView.addSubview(labelThoiGianGiao)
        self.scrollView.addSubview(edtThoiGianGiaoHang)
        self.scrollView.addSubview(btnXacNhan)
        
        self.scrollView.addSubview(labelLyDoThayDoi)
        self.scrollView.addSubview(companyButton)
    }
    
}



extension CapNhatThongTinGiaoHangViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Place name: \(String(describing: place.name))")
        print("Place address: \(place.formattedAddress ?? "null")")
        self.edtDiaChi.text = place.formattedAddress
        print("Place attributions: \(String(describing: place.attributions))")
        
        self.dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        //        print("Error: \(error.description)")
        self.dismiss(animated: true, completion: nil)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        self.dismiss(animated: true, completion: nil)
    }
}
