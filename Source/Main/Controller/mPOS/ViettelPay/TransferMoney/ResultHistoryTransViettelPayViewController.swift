//
//  ResultHistoryTransViettelPayViewController.swift
//  fptshop
//
//  Created by tan on 6/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class ResultHistoryTransViettelPayViewController: UIViewController {
    
    var scrollView:UIScrollView!
    
    var viewTTGD:UIView!
    var viewNTT:UIView!
    var viewTTNC:UIView!
    var viewTTNN:UIView!
    var transferDetail:TransferDetails?
    var btHuyGD:UIButton!
    var btLayMaGD:UIButton!
     var barRight: UIBarButtonItem!
    override func viewDidLoad() {
        self.title = "Chi tiết GD chuyển tiền"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(ResultHistoryTransViettelPayViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        
        let btRightIcon = UIButton.init(type: .custom)
        btRightIcon.setImage(#imageLiteral(resourceName: "CapNhatMenuViettelPay"), for: UIControl.State.normal)
        btRightIcon.imageView?.contentMode = .scaleAspectFit
        btRightIcon.addTarget(self, action: #selector(ResultHistoryTransViettelPayViewController.actionUpdate), for: UIControl.Event.touchUpInside)
        btRightIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barRight = UIBarButtonItem(customView: btRightIcon)
        
        
        
        self.navigationItem.rightBarButtonItems = [barRight]
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.clipsToBounds = true
        self.view.addSubview(scrollView)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN GIAO DỊCH"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        viewTTGD = UIView()
        viewTTGD.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewTTGD.backgroundColor = UIColor.white
        scrollView.addSubview(viewTTGD)
        
        let lbSoMPOS =  UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10) , width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSoMPOS.textAlignment = .left
        lbSoMPOS.textColor = UIColor.black
        lbSoMPOS.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoMPOS.text = "Số MPOS: \(self.transferDetail!.docentry)"
        viewTTGD.addSubview(lbSoMPOS)
        
        let lbSoGDVnPay =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbSoMPOS.frame.origin.y + lbSoMPOS.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSoGDVnPay.textAlignment = .left
        lbSoGDVnPay.textColor = UIColor.black
        lbSoGDVnPay.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoGDVnPay.text = "Số GD VTPAY: \(self.transferDetail!.trans_id_viettel)"
        viewTTGD.addSubview(lbSoGDVnPay)
        
        let lbSoPhieu =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbSoGDVnPay.frame.origin.y + lbSoGDVnPay.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSoPhieu.textAlignment = .left
        lbSoPhieu.textColor = UIColor.black
        lbSoPhieu.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoPhieu.text = "Số Phiếu: \(self.transferDetail!.billcode)"
        viewTTGD.addSubview(lbSoPhieu)
        
        let lbHTNhanTien =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbSoPhieu.frame.origin.y + lbSoPhieu.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHTNhanTien.textAlignment = .left
        lbHTNhanTien.textColor = UIColor.black
        lbHTNhanTien.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHTNhanTien.text = "HT nhận tiền: \(self.transferDetail!.transfer_typeName)"
        viewTTGD.addSubview(lbHTNhanTien)
        
        let lbHTChuyenTien =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbHTNhanTien.frame.origin.y + lbHTNhanTien.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHTChuyenTien.textAlignment = .left
        lbHTChuyenTien.textColor = UIColor.black
        lbHTChuyenTien.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHTChuyenTien.text = "HT chuyển tiền: \(self.transferDetail!.transfer_formName)"
        viewTTGD.addSubview(lbHTChuyenTien)
        
        let lbNgayGiaoDich =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbHTChuyenTien.frame.origin.y + lbHTChuyenTien.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbNgayGiaoDich.textAlignment = .left
        lbNgayGiaoDich.textColor = UIColor.black
        lbNgayGiaoDich.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbNgayGiaoDich.text = "Ngày Giao Dịch: \(self.transferDetail!.NgayGiaoDich)"
        viewTTGD.addSubview(lbNgayGiaoDich)
        
        let lbSoTien =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbNgayGiaoDich.frame.origin.y + lbNgayGiaoDich.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSoTien.textAlignment = .left
        lbSoTien.textColor = UIColor.black
        lbSoTien.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        lbSoTien.text = "Số tiền: \(Common.convertCurrency(value: self.transferDetail!.amount))"
        viewTTGD.addSubview(lbSoTien)
        
        let lbPhiGiaoDich =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbSoTien.frame.origin.y + lbSoTien.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbPhiGiaoDich.textAlignment = .left
        lbPhiGiaoDich.textColor = UIColor.black
        lbPhiGiaoDich.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbPhiGiaoDich.text = "Phí Giao Dịch: \(Common.convertCurrency(value: self.transferDetail!.cust_fee))"
        viewTTGD.addSubview(lbPhiGiaoDich)
        
        let lbTongTien =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbPhiGiaoDich.frame.origin.y + lbPhiGiaoDich.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTongTien.textAlignment = .left
        lbTongTien.textColor = UIColor.black
        lbTongTien.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        let tongtien = self.transferDetail!.cust_fee + self.transferDetail!.amount
        lbTongTien.text = "Tổng tiền: \(Common.convertCurrency(value: tongtien))"
        viewTTGD.addSubview(lbTongTien)
        
        let lbTrangThai =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTongTien.frame.origin.y + lbTongTien.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTrangThai.textAlignment = .left
        lbTrangThai.textColor = UIColor.black
        lbTrangThai.font = UIFont.boldSystemFont(ofSize: 12)
        lbTrangThai.text = "Trạng thái: \(self.transferDetail!.trangthai)"
        viewTTGD.addSubview(lbTrangThai)
        if(self.transferDetail!.trangthai == "Đã gửi"){
            lbTrangThai.textColor = UIColor.init(netHex: 0x3399CC)
        }else{
            lbTrangThai.textColor = .red
        }
        
   
        
        viewTTGD.frame.size.height = lbTrangThai.frame.origin.y + lbTrangThai.frame.size.height + Common.Size(s: 10)
        
        

        
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTTGD.frame.origin.y + viewTTGD.frame.size.height , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "THÔNG TIN NGƯỜI CHUYỂN"
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
        viewTTNC = UIView()
        viewTTNC.frame = CGRect(x: 0, y:label2.frame.origin.y + label2.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewTTNC.backgroundColor = UIColor.white
        scrollView.addSubview(viewTTNC)
        
        let lbHoTenTTNC =  UILabel(frame: CGRect(x: Common.Size(s:15), y:  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHoTenTTNC.textAlignment = .left
        lbHoTenTTNC.textColor = UIColor.black
        lbHoTenTTNC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHoTenTTNC.text = "Họ tên KH chuyển: \(self.transferDetail!.sender_name)"
        viewTTNC.addSubview(lbHoTenTTNC)
        
        
        let lbPhoneTTNC =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbHoTenTTNC.frame.origin.y + lbHoTenTTNC.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbPhoneTTNC.textAlignment = .left
        lbPhoneTTNC.textColor = UIColor.black
        lbPhoneTTNC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPhoneTTNC.text = "Số điện thoại: \(self.transferDetail!.sender_msisdn)"
        viewTTNC.addSubview(lbPhoneTTNC)
        
        let lbCMNDTTNC =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbPhoneTTNC.frame.origin.y + lbPhoneTTNC.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbCMNDTTNC.textAlignment = .left
        lbCMNDTTNC.textColor = UIColor.black
        lbCMNDTTNC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTTNC.text = "CMND: \(self.transferDetail!.sender_id_number)"
        viewTTNC.addSubview(lbCMNDTTNC)
        self.viewTTNC.frame.size.height = lbCMNDTTNC.frame.origin.y + lbCMNDTTNC.frame.size.height + Common.Size(s:10)
        
        let label4 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTTNC.frame.origin.y + viewTTNC.frame.size.height , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label4.text = "THÔNG TIN NGƯỜI NHẬN"
        label4.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label4)
        
        viewTTNN = UIView()
        viewTTNN.frame = CGRect(x: 0, y:label4.frame.origin.y + label4.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewTTNN.backgroundColor = UIColor.white
        scrollView.addSubview(viewTTNN)
        
        
        let lbHoTenTTNN =  UILabel(frame: CGRect(x: Common.Size(s:15), y:  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHoTenTTNN.textAlignment = .left
        lbHoTenTTNN.textColor = UIColor.black
        lbHoTenTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHoTenTTNN.text = "Họ tên KH nhận: \(self.transferDetail!.receiver_name)"
        viewTTNN.addSubview(lbHoTenTTNN)
        
        let lbPhoneTTNN =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbHoTenTTNN.frame.origin.y + lbHoTenTTNN.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbPhoneTTNN.textAlignment = .left
        lbPhoneTTNN.textColor = UIColor.black
        lbPhoneTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbPhoneTTNN.text = "Số điện thoại: \(self.transferDetail!.receiver_msisdn)"
        viewTTNN.addSubview(lbPhoneTTNN)
        
        
        
        let lbCMNDTTNN =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbPhoneTTNN.frame.origin.y + lbPhoneTTNN.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbCMNDTTNN.textAlignment = .left
        lbCMNDTTNN.textColor = UIColor.black
        lbCMNDTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTTNN.text = "CMND: \(self.transferDetail!.receiver_id_number)"
        viewTTNN.addSubview(lbCMNDTTNN)
        
        let lbDiaChiTTNN =  UILabel(frame: CGRect(x: Common.Size(s:15), y: lbCMNDTTNN.frame.origin.y + lbCMNDTTNN.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbDiaChiTTNN.textAlignment = .left
        lbDiaChiTTNN.textColor = UIColor.black
        lbDiaChiTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbDiaChiTTNN.text = "Địa chỉ: \(self.transferDetail!.receiver_address)"
        viewTTNN.addSubview(lbDiaChiTTNN)
        viewTTNN.frame.size.height = lbDiaChiTTNN.frame.size.height + lbDiaChiTTNN.frame.origin.y + Common.Size(s:10)
        
        btHuyGD = UIButton()
        btHuyGD.frame = CGRect(x: Common.Size(s:15), y: viewTTNN.frame.size.height + viewTTNN.frame.origin.y  , width: lbDiaChiTTNN.frame.size.width, height: Common.Size(s:35) * 1.2)
        btHuyGD.backgroundColor = UIColor.red
        btHuyGD.setTitle("HUỶ GIAO DỊCH", for: .normal)
        btHuyGD.addTarget(self, action: #selector(actionHuy), for: .touchUpInside)
        btHuyGD.layer.borderWidth = 0.5
        btHuyGD.layer.borderColor = UIColor.white.cgColor
        btHuyGD.layer.cornerRadius = 3
        scrollView.addSubview(btHuyGD)
        
        btLayMaGD = UIButton()
        btLayMaGD.frame = CGRect(x: Common.Size(s:15), y: btHuyGD.frame.size.height + btHuyGD.frame.origin.y + Common.Size(s: 10) , width: lbDiaChiTTNN.frame.size.width, height: 0)
        btLayMaGD.backgroundColor = UIColor(netHex:0x00955E)
        btLayMaGD.setTitle("LẤY LẠI MÃ NHẬN TIỀN", for: .normal)
       // btLayMaGD.addTarget(self, action: #selector(actionLayMa), for: .touchUpInside)
        btLayMaGD.layer.borderWidth = 0.5
        btLayMaGD.clipsToBounds = true
        btLayMaGD.layer.borderColor = UIColor.white.cgColor
        btLayMaGD.layer.cornerRadius = 3
        scrollView.addSubview(btLayMaGD)
        
        
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btHuyGD.frame.origin.y + btHuyGD.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:45))
        
    }
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func actionUpdate(){
        
        let newViewController = UpdateTransferMoneyViettelPayViewController()
        newViewController.transferDetail = self.transferDetail
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func actionHuy(){
        
        let newViewController = RejectTransferMoneyViettelPayViewController()
        newViewController.transferDetail = self.transferDetail!
        self.navigationController?.pushViewController(newViewController, animated: true)
        

        

        
//        let dateFormatter : DateFormatter = DateFormatter()
//
//        dateFormatter.dateFormat = "yyyyMMddHHmmss"
//
//        let date = Date()
//
//        let dateString = dateFormatter.string(from: date)
//
//
//
//
//        let newViewController = LoadingViewController()
//        newViewController.content = "Đang xác nhận thông tin  ..."
//        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.navigationController?.present(newViewController, animated: true, completion: nil)
//        let nc = NotificationCenter.default
//
//
//        MPOSAPIManager.confirmDelivery(order_id:"frt-confirmdelivery-\(dateString)",trans_id:dateString,confirm_code:confirmCode,doc_entry: "\(self.transferDetail!.docentry)") { (results, err) in
//            let when = DispatchTime.now() + 0.5
//            DispatchQueue.main.asyncAfter(deadline: when) {
//                nc.post(name: Notification.Name("dismissLoading"), object: nil)
//                if(err.count <= 0){
//
//                    let alert = UIAlertController(title: "Thông báo", message: results.error_msg, preferredStyle: .alert)
//
//                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//                        _ = self.navigationController?.popToRootViewController(animated: true)
//                        self.dismiss(animated: true, completion: nil)
//                        let nc = NotificationCenter.default
//                        nc.post(name: Notification.Name("viettelPayView"), object: nil)
//                    })
//                    self.present(alert, animated: true)
//
//                }else{
//                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
//
//                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                    })
//                    self.present(alert, animated: true)
//                }
//            }
//        }
        
    }

     @objc func actionLayMa(){
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
 
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy lại mã nhận tiền ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.resetReceiptCodeEx(order_id:"frt-resetreceiptcode-\(dateString)",trans_id: "",trans_date:dateString) { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)

                if(err.count <= 0){

                    let title = "Thông báo"
                    
                    
                    let popup = PopupDialog(title: title, message: "\(results.service_code)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                        
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)




                }else{
                    let title = "Thông báo"


                    let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {

                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)

                }
            }
        }
        
    }
}
