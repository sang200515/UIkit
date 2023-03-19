//
//  DuyetHanMucTheCaoViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 2/18/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DuyetHanMucTheCaoViewController: UIViewController, UITextViewDelegate {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var callLog:CallLog?
    var conversationItem:TypeId_226_GetConv?
    var tvNhapNDTraoDoi: UITextView!
    var btnSendRequest: UIButton!
    var tfHanMucMoiValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(self.callLog?.RequestID ?? 0)"
        self.view.backgroundColor = UIColor.white
        
        let acceptButton = UIBarButtonItem(image: UIImage(named: "ic_checked.png"), style: .plain, target: self, action: #selector(self.SendApprove));
        acceptButton.tintColor = UIColor(netHex: 0xffffff);
        let rejectButton = UIBarButtonItem(image: UIImage(named: "ic_deny.png"), style: .plain, target: self, action: #selector(self.SendNotApprove));
        rejectButton.tintColor = UIColor(netHex: 0xD94747);
        self.navigationItem.rightBarButtonItems = [rejectButton, acceptButton];
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let listConv = mCallLogApiManager.DuyetHanMucTheCao_TypeId_226_GetConv(p_RequestId: "\(self.callLog?.RequestID ?? 0)").Data ?? []
            if listConv.count > 0 {
                self.conversationItem = listConv[0]
            }
            let listDetail = mCallLogApiManager.DuyetHanMucTheCao_TypeId_226_GetDetail(p_RequestId: "\(self.callLog?.RequestID ?? 0)").Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if listDetail.count > 0 {
                    self.setUpView(item: listDetail[0])
                }
            }
        }
    }
    
    func setUpView(item:TypeId_226_GetDetail) {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lbFrom = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30) , height: Common.Size(s: 20)))
        lbFrom.text = "Từ: \(item.Sender)"
        lbFrom.setLabel(str1: "Từ: ", str2: "\(item.Sender)")
        scrollView.addSubview(lbFrom)
        
        let lbTo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbFrom.frame.origin.y + lbFrom.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30) , height: Common.Size(s: 20)))
        lbTo.text = "Đến: \(item.Assigner)"
        lbTo.setLabel(str1: "Đến: ", str2: "\(item.Assigner)")
        scrollView.addSubview(lbTo)
        
        let line = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbTo.frame.origin.y + lbTo.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30) , height: Common.Size(s: 1)))
        line.backgroundColor = UIColor.lightGray
        scrollView.addSubview(line)
        
        let lbHeaderText = UILabel(frame: CGRect(x: Common.Size(s: 15), y: line.frame.origin.y + line.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30) , height: Common.Size(s: 20)))
        lbHeaderText.text = "\(item.Title)"
        lbHeaderText.font = UIFont.boldSystemFont(ofSize: 15)
        scrollView.addSubview(lbHeaderText)
        
        let lbHeaderTextHeight:CGFloat = lbHeaderText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbHeaderText.optimalHeight
        lbHeaderText.numberOfLines = 0
        lbHeaderText.frame = CGRect(x: lbHeaderText.frame.origin.x, y: lbHeaderText.frame.origin.y, width: lbHeaderText.frame.width, height: lbHeaderTextHeight)
        
        let lbNgayTao = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbHeaderText.frame.origin.y + lbHeaderTextHeight + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30) , height: Common.Size(s: 20)))
        lbNgayTao.text = "Ngày tạo: \(item.TimeCreate)"
        lbNgayTao.font = UIFont.boldSystemFont(ofSize: 15)
        scrollView.addSubview(lbNgayTao)
        
        let lbNoiDung = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNgayTao.frame.origin.y + lbNgayTao.frame.height + Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30) , height: Common.Size(s: 20)))
        lbNoiDung.text = "Nội dung:"
        lbNoiDung.font = UIFont.boldSystemFont(ofSize: 15)
        scrollView.addSubview(lbNoiDung)
        
        let lbNoiDungText = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNoiDung.frame.origin.y + lbNoiDung.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30) , height: Common.Size(s: 20)))
        lbNoiDungText.text = "\(item.NoiDung)"
        lbNoiDungText.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNoiDungText)
        
        let lbNoiDungTextHeight:CGFloat = lbNoiDungText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbNoiDungText.optimalHeight
        lbNoiDungText.numberOfLines = 0
        lbNoiDungText.frame = CGRect(x: lbNoiDungText.frame.origin.x, y: lbNoiDungText.frame.origin.y, width: lbNoiDungText.frame.width, height: lbNoiDungTextHeight)
        
        let lbHanMucHienTaiCuaShop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNoiDungText.frame.origin.y + lbNoiDungTextHeight + Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30) , height: Common.Size(s: 20)))
        lbHanMucHienTaiCuaShop.text = "Hạn mức hiện tại: \(item.CurrentLimit)"
        lbHanMucHienTaiCuaShop.setLabel(str1: "Hạn mức hiện tại: ", str2: "\(item.CurrentLimit)")
        scrollView.addSubview(lbHanMucHienTaiCuaShop)
        
        let lbHanMucDuocPhepDuyet = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbHanMucHienTaiCuaShop.frame.origin.y + lbHanMucHienTaiCuaShop.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30) , height: Common.Size(s: 20)))
        lbHanMucDuocPhepDuyet.text = "Hạn mức được phép duyệt: \(item.Hanmucduocphepduyet)"
        lbHanMucDuocPhepDuyet.setLabel(str1: "Hạn mức được phép duyệt: ", str2: "\(item.Hanmucduocphepduyet)")
        scrollView.addSubview(lbHanMucDuocPhepDuyet)
        
        let lbSoTienShopCanDuyet = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbHanMucDuocPhepDuyet.frame.origin.y + lbHanMucDuocPhepDuyet.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30) , height: Common.Size(s: 20)))
        lbSoTienShopCanDuyet.text = "Số tiền shop cần duyệt: \(item.Sotienshopcanduyet)"
        lbSoTienShopCanDuyet.setLabel(str1: "Số tiền shop cần duyệt: ", str2: "\(item.Sotienshopcanduyet)")
        scrollView.addSubview(lbSoTienShopCanDuyet)
        
        let lbHanMucMoi = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSoTienShopCanDuyet.frame.origin.y + lbSoTienShopCanDuyet.frame.height + Common.Size(s: 10), width: (scrollView.frame.width - Common.Size(s: 30))/3, height: Common.Size(s: 20)))
        lbHanMucMoi.text = "Hạn mức mới:"
        lbHanMucMoi.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbHanMucMoi)
        
        tfHanMucMoiValue = UITextField(frame: CGRect(x: lbHanMucMoi.frame.origin.x + lbHanMucMoi.frame.width, y: lbHanMucMoi.frame.origin.y, width: (scrollView.frame.width - Common.Size(s: 30)) * 2/3 , height: Common.Size(s: 35)))
        tfHanMucMoiValue.borderStyle = .roundedRect
        tfHanMucMoiValue.placeholder = "Nhập hạn mức mới"
        tfHanMucMoiValue.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        tfHanMucMoiValue.autocorrectionType = UITextAutocorrectionType.no
        tfHanMucMoiValue.keyboardType = UIKeyboardType.numberPad
        tfHanMucMoiValue.returnKeyType = UIReturnKeyType.done
        tfHanMucMoiValue.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfHanMucMoiValue.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHanMucMoiValue.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        scrollView.addSubview(tfHanMucMoiValue)
        
        
        let viewNDTraoDoi = UIView(frame: CGRect(x: 0, y: tfHanMucMoiValue.frame.origin.y + tfHanMucMoiValue.frame.height + Common.Size(s: 15), width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewNDTraoDoi.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        scrollView.addSubview(viewNDTraoDoi)
        
        let lbNDTraoDoi = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewNDTraoDoi.frame.width - Common.Size(s: 30), height: viewNDTraoDoi.frame.height))
        lbNDTraoDoi.text = "NỘI DUNG TRAO ĐỔI"
        lbNoiDung.font = UIFont.systemFont(ofSize: 15)
        viewNDTraoDoi.addSubview(lbNDTraoDoi)
        
        let lbNDTraoDoiMoiNhat = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewNDTraoDoi.frame.origin.y + viewNDTraoDoi.frame.height + Common.Size(s: 10), width: viewNDTraoDoi.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbNDTraoDoiMoiNhat.text = "Nội dung trao đổi mới nhất: "
        lbNDTraoDoiMoiNhat.font = UIFont.boldSystemFont(ofSize: 14)
        lbNDTraoDoiMoiNhat.textColor = UIColor.lightGray
        scrollView.addSubview(lbNDTraoDoiMoiNhat)
        
        let lbNDTraoDoiMoiNhatText = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNDTraoDoiMoiNhat.frame.origin.y + lbNDTraoDoiMoiNhat.frame.height + Common.Size(s: 5), width: viewNDTraoDoi.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbNDTraoDoiMoiNhatText.text = "\(conversationItem?.EmployeeName ?? "")-\(conversationItem?.TimeCreate_Format ?? ""): \(conversationItem?.Message ?? "")"
        lbNDTraoDoiMoiNhatText.setLabel(str1: "\(conversationItem?.EmployeeName ?? "")-\(conversationItem?.TimeCreate_Format ?? ""): ", str2: "\(conversationItem?.Message ?? "")")
        scrollView.addSubview(lbNDTraoDoiMoiNhatText)
        
        let lbNDTraoDoiMoiNhatTextHeight:CGFloat = lbNDTraoDoiMoiNhatText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbNDTraoDoiMoiNhatText.optimalHeight
        lbNDTraoDoiMoiNhatText.numberOfLines = 0
        lbNDTraoDoiMoiNhatText.frame = CGRect(x: lbNDTraoDoiMoiNhatText.frame.origin.x, y: lbNDTraoDoiMoiNhatText.frame.origin.y, width: lbNDTraoDoiMoiNhatText.frame.width, height: lbNDTraoDoiMoiNhatTextHeight)
        
        tvNhapNDTraoDoi = UITextView(frame: CGRect(x: Common.Size(s: 15), y: lbNDTraoDoiMoiNhatText.frame.origin.y + lbNDTraoDoiMoiNhatTextHeight + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 120)))
        tvNhapNDTraoDoi.layer.cornerRadius = 5
        tvNhapNDTraoDoi.layer.borderWidth = 1
        tvNhapNDTraoDoi.layer.borderColor = UIColor.lightGray.cgColor
        tvNhapNDTraoDoi.text = "Nhập nội dung trao đổi"
        tvNhapNDTraoDoi.textColor = .darkGray
        tvNhapNDTraoDoi.delegate = self
        scrollView.addSubview(tvNhapNDTraoDoi)
        
        btnSendRequest = UIButton(frame: CGRect(x: Common.Size(s: 15), y: tvNhapNDTraoDoi.frame.origin.y + tvNhapNDTraoDoi.frame.height + Common.Size(s: 20), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 45)))
        btnSendRequest.setTitle("GỬI PHẢN HỒI", for: .normal)
        btnSendRequest.backgroundColor = UIColor(netHex:0x00955E)
        btnSendRequest.layer.cornerRadius = 5
        btnSendRequest.addTarget(self, action: #selector(sendCalllogRequest), for: .touchUpInside)
        scrollView.addSubview(btnSendRequest)
    
        scrollViewHeight = btnSendRequest.frame.origin.y + btnSendRequest.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func SendApprove() {
        guard let newLimit = tfHanMucMoiValue.text, !newLimit.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập hạn mức mới!")
            return
        }
        let newLimitNumber = newLimit.replacingOccurrences(of: ",", with: "")
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let rs = mCallLogApiManager.DuyetHanMucTheCao_TypeId_226_DuyetHanMuc(p_RequestId: "\(self.callLog?.RequestID ?? 0)", NewLimit: newLimitNumber, StatusConfirm: "1").Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if rs.count > 0 {
                    if rs[0].Result == 1 {
                        let alertVC = UIAlertController(title: "Thông báo", message: "\(rs[0].Message ?? "Hoàn tất Calllog thành công!")", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default) { (_) in
                            self.navigationController?.popViewController(animated: true)
                        }
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    } else {
                        self.showAlert(title: "Thông báo", message: "\(rs[0].Message ?? "Duyệt thất bại!")")
                    }
                } else {
                    self.showAlert(title: "Thông báo", message: "LOAD API ERR")
                }
            }
        }
    }
    
    @objc func SendNotApprove() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let rs = mCallLogApiManager.DuyetHanMucTheCao_TypeId_226_DuyetHanMuc(p_RequestId: "\(self.callLog?.RequestID ?? 0)", NewLimit: self.tfHanMucMoiValue.text ?? "0", StatusConfirm: "0").Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if rs.count > 0 {
                    if rs[0].Result == 1 {
                        let alertVC = UIAlertController(title: "Thông báo", message: "\(rs[0].Message ?? "Hoàn tất Calllog thành công!")", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default) { (_) in
                            self.navigationController?.popViewController(animated: true)
                        }
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    } else {
                        self.showAlert(title: "Thông báo", message: "\(rs[0].Message ?? "Duyệt thất bại!")")
                    }
                } else {
                    self.showAlert(title: "Thông báo", message: "LOAD API ERR")
                }
            }
        }
    }
    
    @objc func sendCalllogRequest() {
        var ndTraoDoiText = self.tvNhapNDTraoDoi.text
        if ndTraoDoiText == "Nhập nội dung trao đổi" {
            ndTraoDoiText = ""
        }
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let rs = mCallLogApiManager.DuyetHanMucTheCao_TypeId_226_PushConv(p_RequestId: "\(self.callLog?.RequestID ?? 0)", Message: ndTraoDoiText!).Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if rs.count > 0 {
                    if rs[0].Result == 1 {
                        let alertVC = UIAlertController(title: "Thông báo", message: "\(rs[0].Msg ?? "Gửi Trao đổi Thành công!")", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default) { (_) in
                            self.navigationController?.popViewController(animated: true)
                        }
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    } else {
                        self.showAlert(title: "Thông báo", message: "\(rs[0].Msg ?? "Gửi Trao đổi thất bại!")")
                    }
                } else {
                    self.showAlert(title: "Thông báo", message: "LOAD API ERR")
                }
            }
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
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s),\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
        }else{
            textField.text = ""
        }
    }
}
