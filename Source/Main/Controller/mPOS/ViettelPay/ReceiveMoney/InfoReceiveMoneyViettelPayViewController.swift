//
//  InfoReceiveMoneyViettelPayViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 6/24/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
//import EPSignature
class InfoReceiveMoneyViettelPayViewController: UIViewController,EPSignatureDelegate{
    var scrollView:UIScrollView!
    
    var infoTransactionView:UIView!
    var infoSendView:UIView!
    var infoReceiveView:UIView!
    var detail:InitTransferDetail?
    var btSaiThongTin:UIButton!
    var btConfirm:UIButton!
    var manhantien:String?
    var receiver_id_number:String?
    var base64cmndt:String?
    var base64cmnds:String?
    var receiver_address:String?
    var imgViewSignature: UIImageView!
    var viewImageSign:UIView!
    var viewSign:UIView!
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.blue
        self.title = "Chi tiết GD nhận tiền"
        self.initNavigationBar()
        self.view.backgroundColor = .white
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(InfoReceiveMoneyViettelPayViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN GIAO DỊCH"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        infoTransactionView = UIView()
        infoTransactionView.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        infoTransactionView.backgroundColor = UIColor.white
        scrollView.addSubview(infoTransactionView)
        
//        let lbTextMPOS = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: (scrollView.frame.size.width - Common.Size(s:30))/3, height: Common.Size(s:14)))
//        lbTextMPOS.textAlignment = .left
//        lbTextMPOS.textColor = UIColor.gray
//        lbTextMPOS.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbTextMPOS.text = "Số mPOS:"
//        infoTransactionView.addSubview(lbTextMPOS)
//
//        let lbValueMPOS = UILabel(frame: CGRect(x: lbTextMPOS.frame.origin.x + lbTextMPOS.frame.size.width, y: lbTextMPOS.frame.origin.y, width: (scrollView.frame.size.width - Common.Size(s:30)) * 2/3, height: Common.Size(s:14)))
//        lbValueMPOS.textAlignment = .left
//        lbValueMPOS.textColor = UIColor.black
//        lbValueMPOS.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbValueMPOS.text = "\(self.detail!.docentry)"
//        infoTransactionView.addSubview(lbValueMPOS)
        
        let lbTextVTPay = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: (scrollView.frame.size.width - Common.Size(s:30))/3, height: Common.Size(s:14)))
        lbTextVTPay.textAlignment = .left
        lbTextVTPay.textColor = UIColor.gray
        lbTextVTPay.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextVTPay.text = "Số GD VTPay:"
        infoTransactionView.addSubview(lbTextVTPay)
        
        let lbValueVTPay = UILabel(frame: CGRect(x: lbTextVTPay.frame.origin.x + lbTextVTPay.frame.size.width, y: lbTextVTPay.frame.origin.y, width: (scrollView.frame.size.width - Common.Size(s:30)) * 2/3, height: Common.Size(s:14)))
        lbValueVTPay.textAlignment = .left
        lbValueVTPay.textColor = UIColor.black
        lbValueVTPay.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbValueVTPay.text = "\(self.detail!.trans_id_viettel)"
        infoTransactionView.addSubview(lbValueVTPay)
        
//        let lbTextSO = UILabel(frame: CGRect(x: lbTextVTPay.frame.origin.x, y: lbTextVTPay.frame.size.height + lbTextVTPay.frame.origin.y + Common.Size(s:10), width: lbTextVTPay.frame.size.width, height: lbTextVTPay.frame.size.height))
//        lbTextSO.textAlignment = .left
//        lbTextSO.textColor = UIColor.gray
//        lbTextSO.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbTextSO.text = "Số phiếu:"
//        infoTransactionView.addSubview(lbTextSO)
//
//        let lbValueSO = UILabel(frame: CGRect(x: lbTextSO.frame.origin.x + lbTextSO.frame.size.width, y: lbTextSO.frame.origin.y, width: lbValueMPOS.frame.size.width, height: lbValueMPOS.frame.size.height))
//        lbValueSO.textAlignment = .left
//        lbValueSO.textColor = UIColor.black
//        lbValueSO.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbValueSO.text = "\(self.detail!.docentry)"
//        infoTransactionView.addSubview(lbValueSO)
        
        let lbTextMoney = UILabel(frame: CGRect(x: lbTextVTPay.frame.origin.x, y: lbTextVTPay.frame.size.height + lbTextVTPay.frame.origin.y + Common.Size(s:10), width: lbTextVTPay.frame.size.width, height: lbTextVTPay.frame.size.height))
        lbTextMoney.textAlignment = .left
        lbTextMoney.textColor = UIColor.gray
        lbTextMoney.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextMoney.text = "Số tiền:"
        infoTransactionView.addSubview(lbTextMoney)
        
        let lbValueMoney = UILabel(frame: CGRect(x: lbTextMoney.frame.origin.x + lbTextMoney.frame.size.width, y: lbTextMoney.frame.origin.y, width: lbValueVTPay.frame.size.width, height: lbValueVTPay.frame.size.height))
        lbValueMoney.textAlignment = .left
        lbValueMoney.textColor = UIColor.black
        lbValueMoney.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        lbValueMoney.text = "\(Common.convertCurrency(value: self.detail!.amount))"
        infoTransactionView.addSubview(lbValueMoney)

        let lbTextType = UILabel(frame: CGRect(x: lbTextMoney.frame.origin.x, y: lbTextMoney.frame.size.height + lbTextMoney.frame.origin.y + Common.Size(s:10), width: lbTextMoney.frame.size.width, height: lbTextMoney.frame.size.height))
        lbTextType.textAlignment = .left
        lbTextType.textColor = UIColor.gray
        lbTextType.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextType.text = "Loại giao dịch:"
        infoTransactionView.addSubview(lbTextType)
        
        let lbValueType = UILabel(frame: CGRect(x: lbTextType.frame.origin.x + lbTextType.frame.size.width, y: lbTextType.frame.origin.y, width: lbValueVTPay.frame.size.width, height: lbValueVTPay.frame.size.height))
        lbValueType.textAlignment = .left
        lbValueType.textColor = UIColor.black
        lbValueType.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbValueType.text = "Chuyển tiền CMND"
        infoTransactionView.addSubview(lbValueType)
        
        let lbTextDate = UILabel(frame: CGRect(x: lbTextType.frame.origin.x, y: lbTextType.frame.size.height + lbTextType.frame.origin.y + Common.Size(s:10), width: lbTextType.frame.size.width, height: lbTextType.frame.size.height))
        lbTextDate.textAlignment = .left
        lbTextDate.textColor = UIColor.gray
        lbTextDate.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextDate.text = "Ngày giao dịch:"
        infoTransactionView.addSubview(lbTextDate)
        
        let lbValueDate = UILabel(frame: CGRect(x: lbTextDate.frame.origin.x + lbTextDate.frame.size.width, y: lbTextDate.frame.origin.y, width: lbValueVTPay.frame.size.width, height: lbValueVTPay.frame.size.height))
        lbValueDate.textAlignment = .left
        lbValueDate.textColor = UIColor.black
        lbValueDate.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbValueDate.text = "\(self.detail!.NgayGiaoDich)"
        infoTransactionView.addSubview(lbValueDate)
        
        infoTransactionView.frame.size.height = lbTextDate.frame.size.height + lbTextDate.frame.origin.y + Common.Size(s: 10)
        
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: infoTransactionView.frame.size.height + infoTransactionView.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "THÔNG TIN NGƯỜI CHUYỂN"
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
        infoSendView = UIView()
        infoSendView.frame = CGRect(x: 0, y:label2.frame.origin.y + label2.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        infoSendView.backgroundColor = UIColor.white
        scrollView.addSubview(infoSendView)
        
        let lbTextSendName = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: (scrollView.frame.size.width - Common.Size(s:30))/3, height: Common.Size(s:14)))
        lbTextSendName.textAlignment = .left
        lbTextSendName.textColor = UIColor.gray
        lbTextSendName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSendName.text = "Tên KH chuyển:"
        infoSendView.addSubview(lbTextSendName)
        
        let lbValueSendName = UILabel(frame: CGRect(x: lbTextSendName.frame.origin.x + lbTextSendName.frame.size.width, y: lbTextSendName.frame.origin.y, width: (scrollView.frame.size.width - Common.Size(s:30)) * 2/3, height: Common.Size(s:14)))
        lbValueSendName.textAlignment = .left
        lbValueSendName.textColor = UIColor.black
        lbValueSendName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbValueSendName.text = "\(self.detail!.sender_name)"
        infoSendView.addSubview(lbValueSendName)
        
        let lbTextSendPhone = UILabel(frame: CGRect(x: lbTextSendName.frame.origin.x, y: lbTextSendName.frame.size.height + lbTextSendName.frame.origin.y + Common.Size(s:10), width: lbTextSendName.frame.size.width, height: lbTextSendName.frame.size.height))
        lbTextSendPhone.textAlignment = .left
        lbTextSendPhone.textColor = UIColor.gray
        lbTextSendPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSendPhone.text = "Số điện thoại:"
        infoSendView.addSubview(lbTextSendPhone)
        
        let lbValueSendPhone = UILabel(frame: CGRect(x: lbTextSendPhone.frame.origin.x + lbTextSendPhone.frame.size.width, y: lbTextSendPhone.frame.origin.y, width: lbValueSendName.frame.size.width, height: lbValueSendName.frame.size.height))
        lbValueSendPhone.textAlignment = .left
        lbValueSendPhone.textColor = UIColor.black
        lbValueSendPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbValueSendPhone.text = "\(self.detail!.sender_msisdn)"
        infoSendView.addSubview(lbValueSendPhone)
        infoSendView.frame.size.height = lbValueSendPhone.frame.size.height + lbValueSendPhone.frame.origin.y + Common.Size(s: 10)
        
//        let lbTextSendCMND = UILabel(frame: CGRect(x: lbTextSendPhone.frame.origin.x, y: lbTextSendPhone.frame.size.height + lbTextSendPhone.frame.origin.y + Common.Size(s:10), width: lbTextSendPhone.frame.size.width, height: lbTextSendPhone.frame.size.height))
//        lbTextSendCMND.textAlignment = .left
//        lbTextSendCMND.textColor = UIColor.gray
//        lbTextSendCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbTextSendCMND.text = "CMND:"
//        infoSendView.addSubview(lbTextSendCMND)
//
//        let lbValueSendCMND = UILabel(frame: CGRect(x: lbTextSendCMND.frame.origin.x + lbTextSendCMND.frame.size.width, y: lbTextSendCMND.frame.origin.y, width: lbValueSendPhone.frame.size.width, height: lbValueSendPhone.frame.size.height))
//        lbValueSendCMND.textAlignment = .left
//        lbValueSendCMND.textColor = UIColor.black
//        lbValueSendCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbValueSendCMND.text = "301"
//        infoSendView.addSubview(lbValueSendCMND)
//        infoSendView.frame.size.height = lbTextSendCMND.frame.size.height + lbTextSendCMND.frame.origin.y + Common.Size(s: 10)
        
        let label3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: infoSendView.frame.size.height + infoSendView.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label3.text = "THÔNG TIN NGƯỜI NHẬN"
        label3.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label3)
        
        infoReceiveView = UIView()
        infoReceiveView.frame = CGRect(x: 0, y:label3.frame.origin.y + label3.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        infoReceiveView.backgroundColor = UIColor.white
        scrollView.addSubview(infoReceiveView)
        
        let lbTextReceiveName = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: (scrollView.frame.size.width - Common.Size(s:30))/3, height: Common.Size(s:14)))
        lbTextReceiveName.textAlignment = .left
        lbTextReceiveName.textColor = UIColor.gray
        lbTextReceiveName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextReceiveName.text = "Tên KH chuyển:"
        infoReceiveView.addSubview(lbTextReceiveName)
        
        let lbValueReceiveName = UILabel(frame: CGRect(x: lbTextReceiveName.frame.origin.x + lbTextReceiveName.frame.size.width, y: lbTextReceiveName.frame.origin.y, width: (scrollView.frame.size.width - Common.Size(s:30)) * 2/3, height: Common.Size(s:14)))
        lbValueReceiveName.textAlignment = .left
        lbValueReceiveName.textColor = UIColor.black
        lbValueReceiveName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbValueReceiveName.text = "\(self.detail!.receiver_name)"
        infoReceiveView.addSubview(lbValueReceiveName)
        
        let lbTextReceivePhone = UILabel(frame: CGRect(x: lbTextReceiveName.frame.origin.x, y: lbTextReceiveName.frame.size.height + lbTextReceiveName.frame.origin.y + Common.Size(s:10), width: lbTextReceiveName.frame.size.width, height: lbTextReceiveName.frame.size.height))
        lbTextReceivePhone.textAlignment = .left
        lbTextReceivePhone.textColor = UIColor.gray
        lbTextReceivePhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextReceivePhone.text = "Số điện thoại:"
        infoReceiveView.addSubview(lbTextReceivePhone)
        
        let lbValueReceivePhone = UILabel(frame: CGRect(x: lbTextReceivePhone.frame.origin.x + lbTextReceivePhone.frame.size.width, y: lbTextReceivePhone.frame.origin.y, width: lbValueReceiveName.frame.size.width, height: lbValueReceiveName.frame.size.height))
        lbValueReceivePhone.textAlignment = .left
        lbValueReceivePhone.textColor = UIColor.black
        lbValueReceivePhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbValueReceivePhone.text = "\(self.detail!.receiver_msisdn)"
        infoReceiveView.addSubview(lbValueReceivePhone)
        
        let lbTextReceiveCMND = UILabel(frame: CGRect(x: lbTextReceivePhone.frame.origin.x, y: lbTextReceivePhone.frame.size.height + lbTextReceivePhone.frame.origin.y + Common.Size(s:10), width: lbTextReceivePhone.frame.size.width, height: Common.Size(s:14)))
        lbTextReceiveCMND.textAlignment = .left
        lbTextReceiveCMND.textColor = UIColor.gray
        lbTextReceiveCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextReceiveCMND.text = "CMND:"
        infoReceiveView.addSubview(lbTextReceiveCMND)
        
        let lbValueReceiveCMND = UILabel(frame: CGRect(x: lbTextReceiveCMND.frame.origin.x + lbTextReceiveCMND.frame.size.width, y: lbTextReceiveCMND.frame.origin.y, width: lbValueReceivePhone.frame.size.width, height: lbValueReceivePhone.frame.size.height))
        lbValueReceiveCMND.textAlignment = .left
        lbValueReceiveCMND.textColor = UIColor.black
        lbValueReceiveCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbValueReceiveCMND.text = "\(self.receiver_id_number!)"
        infoReceiveView.addSubview(lbValueReceiveCMND)
        
//
//        viewSign = UIView(frame: CGRect(x: Common.Size(s:20), y: lbValueReceiveCMND.frame.origin.y + lbValueReceiveCMND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:40), height: 0))
//        viewSign.clipsToBounds = true
//
//        infoReceiveView.addSubview(viewSign)
//
//        let lbTextSign = UILabel(frame: CGRect(x: 0, y: 0, width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: Common.Size(s:20)))
//        lbTextSign.textAlignment = .left
//        lbTextSign.textColor = UIColor(netHex:0x47B054)
//        lbTextSign.font = UIFont.systemFont(ofSize: Common.Size(s:18))
//        lbTextSign.text = "Chữ ký"
//        lbTextSign.sizeToFit()
//        viewSign.addSubview(lbTextSign)
//
//        viewImageSign = UIView(frame: CGRect(x:0, y: lbTextSign.frame.origin.y + lbTextSign.frame.size.height + Common.Size(s:5), width: viewSign.frame.size.width, height: Common.Size(s:60)))
//        viewImageSign.layer.borderWidth = 0.5
//        viewImageSign.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
//        viewImageSign.layer.cornerRadius = 3.0
//        viewSign.addSubview(viewImageSign)
//
//        let VS23 = viewImageSign.frame.size.height * 2/3
//        let xViewVS  = viewImageSign.frame.size.width/2 - VS23/2
//        let viewSignButton = UIImageView(frame: CGRect(x: xViewVS, y: 0, width: viewImageSign.frame.size.height * 2/3, height: viewImageSign.frame.size.height * 2/3))
//        viewSignButton.image = UIImage(named:"Sign Up-50")
//        viewSignButton.contentMode = .scaleAspectFit
//        viewImageSign.addSubview(viewSignButton)
//
//        let lbSignButton = UILabel(frame: CGRect(x: 0, y: viewSignButton.frame.size.height + viewSignButton.frame.origin.y, width: viewImageSign.frame.size.width, height: viewImageSign.frame.size.height/3))
//        lbSignButton.textAlignment = .center
//        lbSignButton.textColor = UIColor(netHex:0xc2c2c2)
//        lbSignButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbSignButton.text = "Thêm chữ ký"
//        viewImageSign.addSubview(lbSignButton)
//
//        viewSign.frame.size.height = viewImageSign.frame.origin.y + viewImageSign.frame.size.height
//
//        let tapShowSign = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSign))
//        viewSign.isUserInteractionEnabled = true
//        viewSign.addGestureRecognizer(tapShowSign)
        
        btSaiThongTin = UIButton()
        btSaiThongTin.frame = CGRect(x: lbTextReceiveCMND.frame.origin.x, y: lbValueReceiveCMND.frame.origin.y + lbValueReceiveCMND.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:180), height: Common.Size(s:40))
        btSaiThongTin.backgroundColor = UIColor(netHex:0xEF4A40)
        btSaiThongTin.addTarget(self, action: #selector(actionSaiInfo), for: .touchUpInside)
        btSaiThongTin.layer.borderWidth = 0.5
        btSaiThongTin.layer.borderColor = UIColor.white.cgColor
        btSaiThongTin.layer.cornerRadius = 5.0
        infoReceiveView.addSubview(btSaiThongTin)
        btSaiThongTin.setTitle("Sai thông tin", for: .normal)
        
        btConfirm = UIButton()
        btConfirm.frame = CGRect(x: btSaiThongTin.frame.origin.x + btSaiThongTin.frame.size.width, y: lbValueReceiveCMND.frame.origin.y + lbValueReceiveCMND.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width - Common.Size(s:180), height: Common.Size(s:40))
        btConfirm.backgroundColor = UIColor(netHex:0x00955E)
        btConfirm.addTarget(self, action: #selector(actionInitConfirm), for: .touchUpInside)
        btConfirm.layer.borderWidth = 0.5
        btConfirm.layer.borderColor = UIColor.white.cgColor
        btConfirm.layer.cornerRadius = 5.0
        infoReceiveView.addSubview(btConfirm)
        btConfirm.setTitle("Xác nhận thông tin", for: .normal)
        
        infoReceiveView.frame.size.height = btSaiThongTin.frame.origin.y + btSaiThongTin.frame.size.height
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: infoReceiveView.frame.origin.y + infoReceiveView.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:45))
        
    }
    @objc func actionBack(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)

    }
    
  
    
    @objc func actionInitConfirm(){
        
        let dateFormatter : DateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        
        let date = Date()
        
        let dateString = dateFormatter.string(from: date)
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang xác nhận thông tin  ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.initTransfer(trans_date: dateString,receiver_msisdn: self.detail!.receiver_msisdn,receiver_id_number: "\(self.receiver_id_number!)",receipt_code: "\(self.manhantien!)",amount: "\(self.detail!.amount)",image_cmtmt: "\(self.base64cmndt!)",image_cmtms: "\(self.base64cmnds!)",receiver_address:"\(self.receiver_address!)",image_pnt:"",init_type:"1") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
           
                    self.actionConfirm(confirmCode:results.confirm_code,order_id:results.order_id)
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
        

        

    }
    
    func actionConfirm(confirmCode:String,order_id:String){
        let dateFormatter : DateFormatter = DateFormatter()
   
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
      
        let date = Date()
 
        let dateString = dateFormatter.string(from: date)
    
        
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang xác nhận thông tin  ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.confirmDelivery(order_id:"frt-confirmdelivery-\(dateString)",trans_id:"\(self.detail!.trans_id_viettel)",confirm_code:confirmCode,doc_entry: "\(order_id)") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
                    let alert = UIAlertController(title: "Thông báo", message: results.error_msg, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        _ = self.navigationController?.popToRootViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("viettelPayView"), object: nil)
                    })
                    self.present(alert, animated: true)

                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    @objc func actionSaiInfo(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tapShowSign(sender:UITapGestureRecognizer) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
//        let nav = UINavigationController(rootViewController: signatureVC)
//        present(nav, animated: true, completion: nil)
         self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        
        let width = viewImageSign.frame.size.width - Common.Size(s:10)
        
        let sca:CGFloat = boundingRect.size.width / boundingRect.size.height
        let heightImage:CGFloat = width / sca
        
        viewImageSign.subviews.forEach { $0.removeFromSuperview() }
        imgViewSignature  = UIImageView(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: width, height: heightImage))
        //        imgViewSignature.backgroundColor = .red
        imgViewSignature.contentMode = .scaleAspectFit
        viewImageSign.addSubview(imgViewSignature)
        imgViewSignature.image = cropImage(image: signatureImage, toRect: boundingRect)
        
        viewImageSign.frame.size.height = imgViewSignature.frame.size.height + imgViewSignature.frame.origin.y + Common.Size(s:5)
        viewSign.frame.size.height = viewImageSign.frame.origin.y + viewImageSign.frame.size.height
        
        
        
        self.btSaiThongTin.frame.origin.y = self.viewSign.frame.size.height + self.viewSign.frame.origin.y + Common.Size(s:10)
        self.btConfirm.frame.origin.y = viewSign.frame.size.height + viewSign.frame.origin.y + Common.Size(s: 10)
        
        infoReceiveView.frame.size.height = btSaiThongTin.frame.origin.y + btSaiThongTin.frame.size.height
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: infoReceiveView.frame.origin.y + infoReceiveView.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:45))
        
        _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
    }
    
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage? {
        
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
