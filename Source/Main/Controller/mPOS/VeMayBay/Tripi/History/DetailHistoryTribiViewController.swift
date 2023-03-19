//
//  DetailHistoryTribiViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 1/7/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import Presentr

class DetailHistoryTribiViewController: UIViewController {
    var scrollView:UIScrollView!
    var detailTribi:DetailFlightTribi?
    var viewTTBayDi:UIView!
    var viewTTBayVe:UIView!
    var viewTTNTT:UIView!
    var viewTTHK:UIView!
    var btConfirm: UIButton!
    var listHistoryTripi: [HistoryFlightTribi] = []
    
    let presenter: Presentr = {
        let dynamicType = PresentationType.dynamic(center: ModalCenterPosition.center)
        let customPresenter = Presentr(presentationType: dynamicType)
        customPresenter.backgroundOpacity = 0.3
        customPresenter.roundCorners = true
        customPresenter.dismissOnSwipe = false
        customPresenter.dismissAnimated = false
        //        customPresenter.backgroundTap = .noAction
        return customPresenter
    }()
    
    override func viewDidLoad() {
        self.title = "Chi tiết: SOMPOS \(self.detailTribi!.SoMPOS)"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(DetailHistoryTribiViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        self.setUpView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name("didCancelCalllogTripi"), object: nil)
    }
    
    @objc func reloadData() {
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.mpos_FRT_Flight_Tripi_GetDetailInfor(docentry: "\(self.detailTribi!.DocEntry)") { (results,err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.detailTribi = results[0]
                    if self.scrollView != nil {
                        self.scrollView.removeFromSuperview()
                    }
                    self.setUpView()
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }

    func setUpView(){
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN GIAO DỊCH (CHUYẾN BAY ĐI)" //Outbound
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        guard let jsonOutbound = self.convertToDictionary(text: self.detailTribi!.outbound) else { return }
        
        
        viewTTBayDi = UIView()
        viewTTBayDi.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewTTBayDi.backgroundColor = UIColor.white
        scrollView.addSubview(viewTTBayDi)
        
        let lbTuTTBayDi = UILabel(frame: CGRect(x: Common.Size(s: 15), y:  Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbTuTTBayDi.text = "Từ:"
        lbTuTTBayDi.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTBayDi.addSubview(lbTuTTBayDi)
        
        let lbTuValueBayDi = UILabel(frame: CGRect(x:0, y: lbTuTTBayDi.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbTuValueBayDi.text =  jsonOutbound["fromAirportName"] as? String
        lbTuValueBayDi.textAlignment = .right
        lbTuValueBayDi.textColor = UIColor(netHex:0x00955E)
        lbTuValueBayDi.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTBayDi.addSubview(lbTuValueBayDi)
        
        
        let lbDenBayDi = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTuTTBayDi.frame.origin.y + lbTuTTBayDi.frame.size.height + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbDenBayDi.text = "Đến:"
        lbDenBayDi.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTBayDi.addSubview(lbDenBayDi)
        
        let lbDenValueBayDi = UILabel(frame: CGRect(x:0, y: lbDenBayDi.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbDenValueBayDi.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbDenValueBayDi.textAlignment = .right
        lbDenValueBayDi.text = (jsonOutbound["toAirportName"] as! String)
        lbDenValueBayDi.textColor = UIColor(netHex:0x00955E)
        viewTTBayDi.addSubview(lbDenValueBayDi)
        
        let lbMaDatVeBayDi = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbDenBayDi.frame.origin.y + lbDenBayDi.frame.size.height + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbMaDatVeBayDi.text = "Mã đặt chỗ:"
        lbMaDatVeBayDi.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTBayDi.addSubview(lbMaDatVeBayDi)
        
        let lbMaDatVeBayDiValue = UILabel(frame: CGRect(x:0, y: lbMaDatVeBayDi.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbMaDatVeBayDiValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbMaDatVeBayDiValue.textAlignment = .right
        lbMaDatVeBayDiValue.text = self.detailTribi!.outboundPnrCode
        lbMaDatVeBayDiValue.textColor = .black
        viewTTBayDi.addSubview(lbMaDatVeBayDiValue)
        
        let lbSoHieuChuyenBayBD = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbMaDatVeBayDi.frame.origin.y + lbMaDatVeBayDi.frame.size.height + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbSoHieuChuyenBayBD.text = "Số hiệu chuyến bay:"
        lbSoHieuChuyenBayBD.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTBayDi.addSubview(lbSoHieuChuyenBayBD)
        
        let lbSoHieuChuyenBayBDValue = UILabel(frame: CGRect(x:0, y: lbSoHieuChuyenBayBD.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbSoHieuChuyenBayBDValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbSoHieuChuyenBayBDValue.textAlignment = .right
        lbSoHieuChuyenBayBDValue.textColor = .black
        lbSoHieuChuyenBayBDValue.text = (jsonOutbound["flightCode"] as! String)
        viewTTBayDi.addSubview(lbSoHieuChuyenBayBDValue)
        
        let lbHangBayDi = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSoHieuChuyenBayBD.frame.origin.y + lbSoHieuChuyenBayBD.frame.size.height + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbHangBayDi.text = "Hãng:"
        lbHangBayDi.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbHangBayDi.textAlignment = .left
        viewTTBayDi.addSubview(lbHangBayDi)
        
        let lbHangValueBayDi = UILabel(frame: CGRect(x: 0, y: lbHangBayDi.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbHangValueBayDi.text = jsonOutbound["airline"] as? String
        lbHangValueBayDi.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbHangValueBayDi.textAlignment = .right
        viewTTBayDi.addSubview(lbHangValueBayDi)
        
        viewTTBayDi.frame.size.height = lbHangBayDi.frame.origin.y + lbHangBayDi.frame.size.height + Common.Size(s: 10)
        
        
        let label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTTBayDi.frame.size.height + viewTTBayDi.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "THÔNG TIN GIAO DỊCH (CHUYẾN BAY VỀ)" //Inbound
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        label2.clipsToBounds = true
        scrollView.addSubview(label2)
        
        viewTTBayVe = UIView()
        viewTTBayVe.frame = CGRect(x: 0, y:label2.frame.origin.y + label2.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewTTBayVe.backgroundColor = UIColor.white
        viewTTBayVe.clipsToBounds = true
        scrollView.addSubview(viewTTBayVe)
        
        let lbTuTTBayVe = UILabel(frame: CGRect(x: Common.Size(s: 15), y:  Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbTuTTBayVe.text = "Từ:"
        lbTuTTBayVe.clipsToBounds = true
        lbTuTTBayVe.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTBayVe.addSubview(lbTuTTBayVe)
        
        let lbTuValueBayVe = UILabel(frame: CGRect(x:0, y: lbTuTTBayVe.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbTuValueBayVe.clipsToBounds = true
        lbTuValueBayVe.textAlignment = .right
        lbTuValueBayVe.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTBayVe.addSubview(lbTuValueBayVe)
        
        
        let lbDenBayVe = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTuTTBayDi.frame.origin.y + lbTuTTBayDi.frame.size.height + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbDenBayVe.text = "Đến:"
        lbDenBayVe.clipsToBounds = true
        lbDenBayVe.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTBayVe.addSubview(lbDenBayVe)
        
        let lbDenValueBayVe = UILabel(frame: CGRect(x:0, y: lbDenBayVe.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbDenValueBayVe.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbDenValueBayVe.textAlignment = .right
        lbDenValueBayVe.clipsToBounds = true
        viewTTBayVe.addSubview(lbDenValueBayVe)
        
        let lbMaDatVeBayVe = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbDenBayVe.frame.origin.y + lbDenBayVe.frame.size.height + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbMaDatVeBayVe.text = "Mã đặt chỗ:"
        lbMaDatVeBayVe.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTBayVe.addSubview(lbMaDatVeBayVe)
        
        let lbMaDatVeBayVeValue = UILabel(frame: CGRect(x:0, y: lbMaDatVeBayVe.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbMaDatVeBayVeValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbMaDatVeBayVeValue.textAlignment = .right
        lbMaDatVeBayVeValue.text = self.detailTribi!.inboundPnrCode
        lbMaDatVeBayVeValue.textColor = .black
        viewTTBayVe.addSubview(lbMaDatVeBayVeValue)
        
        
        let lbSoHieuChuyenBayBV = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbMaDatVeBayVe.frame.origin.y + lbMaDatVeBayVe.frame.size.height + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbSoHieuChuyenBayBV.text = "Số hiệu chuyến bay:"
        lbSoHieuChuyenBayBV.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTBayVe.addSubview(lbSoHieuChuyenBayBV)
        
        let lbSoHieuChuyenBayBVValue = UILabel(frame: CGRect(x:0, y: lbSoHieuChuyenBayBV.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbSoHieuChuyenBayBVValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbSoHieuChuyenBayBVValue.textAlignment = .right
        lbSoHieuChuyenBayBVValue.textColor = .black
        viewTTBayVe.addSubview(lbSoHieuChuyenBayBVValue)
        
        let lbHangBayVe = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSoHieuChuyenBayBV.frame.origin.y + lbSoHieuChuyenBayBV.frame.size.height + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbHangBayVe.text = "Hãng:"
        lbHangBayVe.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbHangBayVe.textAlignment = .left
        lbHangBayVe.clipsToBounds = true
        viewTTBayVe.addSubview(lbHangBayVe)
        
        let lbHangValueBayVe = UILabel(frame: CGRect(x: 0, y: lbHangBayVe.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbHangValueBayVe.clipsToBounds = true
        lbHangValueBayVe.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbHangValueBayVe.textAlignment = .right
        viewTTBayVe.addSubview(lbHangValueBayVe)
        
        viewTTBayVe.frame.size.height = lbHangBayVe.frame.size.height + lbHangBayVe.frame.origin.y + Common.Size(s: 10)
        
        
        
        if(self.detailTribi!.inbound != ""){
            let jsonInbound = self.convertToDictionary(text: self.detailTribi!.inbound)
            lbTuValueBayVe.text = jsonInbound!["fromAirportName"] as? String
            lbDenValueBayVe.text = jsonInbound!["toAirportName"] as? String
            lbHangValueBayVe.text = jsonInbound!["airline"] as? String
            lbSoHieuChuyenBayBVValue.text = jsonInbound!["flightCode"] as? String
        }else{
            viewTTBayVe.frame.size.height = 0
        }
        
        let label3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTTBayVe.frame.size.height + viewTTBayVe.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label3.text = "THÔNG TIN NGƯỜI THANH TOÁN"
        label3.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label3)
        
        
        viewTTNTT = UIView()
        viewTTNTT.frame = CGRect(x: 0, y:label3.frame.origin.y + label3.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewTTNTT.backgroundColor = UIColor.white
        scrollView.addSubview(viewTTNTT)
        
        let lbBookingID = UILabel(frame: CGRect(x: Common.Size(s: 15), y:  Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbBookingID.text = "Mã đơn hàng"
        lbBookingID.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTNTT.addSubview(lbBookingID)
        
        let lbBookingIDValue = UILabel(frame: CGRect(x:0, y: lbBookingID.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbBookingIDValue.text = "\(self.detailTribi!.bookingId)"
        lbBookingIDValue.textAlignment = .right
        lbBookingIDValue.textColor = .black
        lbBookingIDValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTNTT.addSubview(lbBookingIDValue)
        
        let lbNgayDat = UILabel(frame: CGRect(x: Common.Size(s: 15), y:lbBookingID.frame.origin.y + lbBookingID.frame.size.height +  Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbNgayDat.text = "Ngày đặt"
        lbNgayDat.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTNTT.addSubview(lbNgayDat)
        
        let lbNgayDatValue = UILabel(frame: CGRect(x:0, y: lbNgayDat.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        
        lbNgayDatValue.textAlignment = .right
        lbNgayDatValue.textColor = UIColor(netHex:0x00955E)
        lbNgayDatValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbNgayDatValue.text = "\(self.detailTribi!.bookedDate)"
        viewTTNTT.addSubview(lbNgayDatValue)
        
        let lbFullName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNgayDat.frame.size.height + lbNgayDat.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbFullName.text = "Họ Tên"
        lbFullName.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTNTT.addSubview(lbFullName)
        
        let lbFullNameValue = UILabel(frame: CGRect(x:0, y: lbFullName.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        
        lbFullNameValue.textAlignment = .right
        lbFullNameValue.textColor = .black
        lbFullNameValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbFullNameValue.text = self.detailTribi!.fullName
        viewTTNTT.addSubview(lbFullNameValue)
        
        let lbPhone = UILabel(frame: CGRect(x: Common.Size(s: 15), y:  lbFullName.frame.size.height + lbFullName.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbPhone.text = "Số điện thoại"
        lbPhone.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTNTT.addSubview(lbPhone)
        
        let lbPhoneValue = UILabel(frame: CGRect(x:0, y: lbPhone.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        
        lbPhoneValue.textAlignment = .right
        lbPhoneValue.textColor = .black
        lbPhoneValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbPhoneValue.text = self.detailTribi!.phone
        viewTTNTT.addSubview(lbPhoneValue)
        
        let lbEmail = UILabel(frame: CGRect(x: Common.Size(s: 15), y:  lbPhone.frame.size.height + lbPhone.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbEmail.text = "Email"
        lbEmail.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTNTT.addSubview(lbEmail)
        
        let lbEmailValue = UILabel(frame: CGRect(x:0, y: lbEmail.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        
        lbEmailValue.textAlignment = .right
        lbEmailValue.textColor = .black
        lbEmailValue.text = self.detailTribi!.email
        lbEmailValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTNTT.addSubview(lbEmailValue)
        
        let lbTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbEmail.frame.size.height + lbEmail.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 250), height: Common.Size(s: 15)))
        lbTrangThai.text = "Trạng thái"
        lbTrangThai.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTNTT.addSubview(lbTrangThai)
        
        let lbTrangThaiValue = UILabel(frame: CGRect(x:lbTrangThai.frame.size.width + lbTrangThai.frame.origin.x, y: lbTrangThai.frame.origin.y, width: self.view.frame.width - Common.Size(s: 100), height: Common.Size(s: 20)))
        
        lbTrangThaiValue.textAlignment = .right
        
        lbTrangThaiValue.textColor = UIColor(netHex:0x00955E)
        lbTrangThaiValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lbTrangThaiValue.text = self.detailTribi!.Status
        viewTTNTT.addSubview(lbTrangThaiValue)
        
        let lbTrangThaiValueHeight:CGFloat = lbTrangThaiValue.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbTrangThaiValue.optimalHeight
        lbTrangThaiValue.numberOfLines = 0
        lbTrangThaiValue.frame = CGRect(x: lbTrangThaiValue.frame.origin.x, y: lbTrangThaiValue.frame.origin.y, width: lbTrangThaiValue.frame.width, height: lbTrangThaiValueHeight)
        
        
        let TongTien = UILabel(frame: CGRect(x: Common.Size(s: 15), y:  lbTrangThaiValue.frame.origin.y + lbTrangThaiValue.frame.size.height + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        TongTien.text = "Tổng tiền"
        TongTien.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewTTNTT.addSubview(TongTien)
        
        let TongTienValue = UILabel(frame: CGRect(x:0, y: TongTien.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        
        TongTienValue.textAlignment = .right
        TongTienValue.textColor = .red
        TongTienValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        TongTienValue.text = self.detailTribi!.finalPriceFormatted
        viewTTNTT.addSubview(TongTienValue)
        viewTTNTT.frame.size.height = TongTien.frame.size.height + TongTien.frame.origin.y + Common.Size(s: 10)
        
        let label4 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTTNTT.frame.size.height + viewTTNTT.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label4.text = "THÔNG TIN HÀNH KHÁCH"
        label4.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label4)
        
        
        var indexY: CGFloat = Common.Size(s: 10)
        viewTTHK = UIView()
        viewTTHK.frame = CGRect(x: 0, y:label4.frame.origin.y + label4.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewTTHK.backgroundColor = UIColor.white
        scrollView.addSubview(viewTTHK)
        
        if(self.detailTribi!.guests != ""){
            let data = self.detailTribi!.guests.data(using: .utf8)!
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                {
                    print(jsonArray) // use the json here
                    for item in jsonArray{
                        let viewRow = UIView()
                        viewRow.frame = CGRect(x: 0, y: indexY , width: scrollView.frame.size.width, height: Common.Size(s: 300))
                        viewRow.backgroundColor = UIColor.white
                        viewTTHK.addSubview(viewRow)
                        
                        let lbFullNameTTHK = UILabel(frame: CGRect(x: Common.Size(s: 15), y:  Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
                        lbFullNameTTHK.text = "Họ Tên"
                        lbFullNameTTHK.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
                        lbFullNameTTHK.textColor = UIColor(netHex:0x00955E)
                        viewRow.addSubview(lbFullNameTTHK)
                        
                        let lbFullNameValueTTHK = UILabel(frame: CGRect(x:0, y: lbFullNameTTHK.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
                        
                        lbFullNameValueTTHK.textAlignment = .right
                        lbFullNameValueTTHK.textColor = .black
                        lbFullNameValueTTHK.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
                        lbFullNameValueTTHK.text = (item["fullName"] as! String)
                        lbFullNameValueTTHK.textColor = UIColor(netHex:0x00955E)
                        viewRow.addSubview(lbFullNameValueTTHK)
                        
                        let lbGenderTTHK = UILabel(frame: CGRect(x: Common.Size(s: 15), y:  lbFullNameTTHK.frame.size.height + lbFullNameTTHK.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
                        lbGenderTTHK.text = "Giới tính"
                        lbGenderTTHK.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
                        viewRow.addSubview(lbGenderTTHK)
                        
                        
                        let lbGenderTTHKValue = UILabel(frame: CGRect(x:0, y: lbGenderTTHK.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
                        
                        lbGenderTTHKValue.textAlignment = .right
                        lbGenderTTHKValue.textColor = .black
                        lbGenderTTHKValue.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
                        if((item["gender"] as! String) == "M"){
                            lbGenderTTHKValue.text = "Nam"
                        }else{
                            lbGenderTTHKValue.text = "Nữ"
                        }
                        
                        viewRow.addSubview(lbGenderTTHKValue)
                        
                        let lbNgaySinhTTHK = UILabel(frame: CGRect(x: Common.Size(s: 15), y:  lbGenderTTHK.frame.size.height + lbGenderTTHK.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
                        lbNgaySinhTTHK.text = "Ngày sinh"
                        lbNgaySinhTTHK.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
                        lbNgaySinhTTHK.textColor = UIColor(netHex:0x00955E)
                        viewRow.addSubview(lbNgaySinhTTHK)
                        
                        let lbNgaySinhValueTTHK = UILabel(frame: CGRect(x:0, y: lbNgaySinhTTHK.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
                        
                        lbNgaySinhValueTTHK.textAlignment = .right
                        lbNgaySinhValueTTHK.textColor = .black
                        lbNgaySinhValueTTHK.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
                        lbNgaySinhValueTTHK.text = (item["dob"] as! String)
                        lbNgaySinhValueTTHK.textColor = UIColor(netHex:0x00955E)
                        viewRow.addSubview(lbNgaySinhValueTTHK)
                        
                        
       
                        viewRow.frame.size.height = lbNgaySinhTTHK.frame.origin.y + lbNgaySinhTTHK.frame.size.height
                        indexY = viewRow.frame.origin.y + viewRow.frame.size.height
                        
                    }
                    self.viewTTHK.frame.size.height = indexY + Common.Size(s: 10)
                    
                    
                    let lblNote = UILabel(frame: CGRect(x: Common.Size(s: 10), y:  viewTTHK.frame.size.height + viewTTHK.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 30)))
                    lblNote.text = "Trước khi bấm “Xác nhận thanh toán và xuất vé”, đưa KH ra Kế toán để thanh toán tiền trước"
                    lblNote.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
                    lblNote.textColor = .red
                    
                    lblNote.lineBreakMode = .byWordWrapping
                    lblNote.numberOfLines = 0
                    lblNote.sizeToFit()
                    
                    
                    scrollView.addSubview(lblNote)
                    
                    
                    btConfirm = UIButton()
                    btConfirm.frame = CGRect(x: Common.Size(s:10), y:lblNote.frame.size.height + lblNote.frame.origin.y + Common.Size(s:20), width: scrollView.frame.size.width - Common.Size(s:20), height: Common.Size(s: 40) * 1.2)
                    btConfirm.backgroundColor = UIColor(netHex:0x00955E)
                    btConfirm.setTitle("Xác nhận thanh toán và xuất vé", for: .normal)
                    btConfirm.addTarget(self, action: #selector(actionConfirm), for: .touchUpInside)
                    btConfirm.layer.borderWidth = 0.5
                    btConfirm.layer.borderColor = UIColor.white.cgColor
                    btConfirm.layer.cornerRadius = 3
                    btConfirm.clipsToBounds = true
                    scrollView.addSubview(btConfirm)
                    if(self.detailTribi!.Isbutton == 0){
                        lblNote.frame.size.height = 0
                        btConfirm.frame.origin.y = lblNote.frame.size.height + lblNote.frame.origin.y
                        btConfirm.frame.size.height = 0
                    }
                    scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btConfirm.frame.origin.y + btConfirm.frame.size.height + Common.Size(s: 20 + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
                    
                } else {
                    print("bad json")
                }
            } catch let error as NSError {
                print(error)
            }
        }
        
        
        //add btn Huỷ Tripi
        let btnCancel = UIButton(frame: CGRect(x: Common.Size(s: 30), y: btConfirm.frame.size.height + btConfirm.frame.origin.y + Common.Size(s:15), width: scrollView.frame.width - Common.Size(s: 60), height: Common.Size(s: 40)))
        btnCancel.backgroundColor = UIColor(netHex:0x00955E)
        btnCancel.setTitle("Huỷ", for: .normal)
        btnCancel.layer.cornerRadius = 5
        btnCancel.addTarget(self, action: #selector(cancelTripi), for: .touchUpInside)
        scrollView.addSubview(btnCancel)
        
        let btnCalllogTripi = UIButton(frame: CGRect(x: Common.Size(s: 30), y: btnCancel.frame.size.height + btnCancel.frame.origin.y + Common.Size(s:10), width: scrollView.frame.width - Common.Size(s: 60), height: Common.Size(s: 40)))
        btnCalllogTripi.backgroundColor = UIColor(netHex:0x00955E)
        btnCalllogTripi.setTitle("Calllog", for: .normal)
        btnCalllogTripi.layer.cornerRadius = 5
        btnCalllogTripi.addTarget(self, action: #selector(showCalllogTripi), for: .touchUpInside)
        scrollView.addSubview(btnCalllogTripi)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btnCalllogTripi.frame.origin.y + btnCalllogTripi.frame.size.height + Common.Size(s: 20 + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        
        if self.detailTribi?.IsCalllog == 0 {
            btnCancel.isHidden = true
        } else {
            btnCancel.isHidden = false
        }

        if (self.detailTribi?.RequestID == "0") || ((self.detailTribi?.RequestID.isEmpty)!) {
            btnCalllogTripi.isHidden = true
        } else {
            btnCalllogTripi.isHidden = false
        }
        
        if btnCancel.isHidden == false {
            //hien nut huy
            btnCancel.frame = CGRect(x: Common.Size(s: 30), y: btConfirm.frame.size.height + btConfirm.frame.origin.y + Common.Size(s:15), width: scrollView.frame.width - Common.Size(s: 60), height: Common.Size(s: 40))
            if btnCalllogTripi.isHidden == false {
                btnCalllogTripi.frame = CGRect(x: Common.Size(s: 30), y: btnCancel.frame.size.height + btnCancel.frame.origin.y + Common.Size(s:15), width: scrollView.frame.width - Common.Size(s: 60), height: Common.Size(s: 40))
            }
        } else {
            //an nut huy
            if btnCalllogTripi.isHidden == false {
                btnCalllogTripi.frame = CGRect(x: Common.Size(s: 30), y: btConfirm.frame.size.height + btConfirm.frame.origin.y + Common.Size(s:15), width: scrollView.frame.width - Common.Size(s: 60), height: Common.Size(s: 40))
            }
        }
    }
    
    @objc func actionConfirm(){
        let popup = PopupDialog(title: "Thông báo", message: "Kiểm tra lại thông tin KH lần nữa, nếu sai thì bỏ giao dịch này tạo lại giao dịch mới chính xác. Nhấn ĐÓNG để kiểm tra lại thông tin.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        let button1 = DefaultButton(title: "OK"){
            let newViewController = LoadingViewController()
                newViewController.content = "Đang xác nhận thông tin vui lòng chờ..."
                newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                self.navigationController?.present(newViewController, animated: true, completion: nil)
                let nc = NotificationCenter.default
                
                
                MPOSAPIManager.mpos_FRT_Flight_Tripi_ConfirmBooking(DocEntry: "\(self.detailTribi!.DocEntry)", bookingId: "\(self.detailTribi!.bookingId)") { (result, err) in
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            if(result!.Result == 1){
                                let alert = UIAlertController(title: "Thông báo", message: result!.Message, preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                    let newViewController = HistoryTribiFlightViewController()
                                    self.navigationController?.pushViewController(newViewController, animated: true)
                                })
                                self.present(alert, animated: true)
                                
                                
                            }else{
                               
                                self.showDialog(message: result!.Message)
                            }
                        }else{
                           
                            self.showDialog(message: err)
                        }
                    }
                }
        }
        let button2 = CancelButton(title: "Đóng"){
            
        }
        popup.addButtons([button1,button2])
        self.present(popup, animated: true, completion: nil)
    
    }
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    @objc func cancelTripi() {
//         1-Hủy, 2- Đổi chặn, 3-Đổi chuyến , 4 - Tách code, 5 - Huỷ vé khứ hồi, 6 - dịch vụ thêm
        let vc = ChooseCancelTripiServiceViewController()
        vc.detailTribi = self.detailTribi
        vc.delegate = self
        self.customPresentViewController(presenter, viewController: vc, animated: true)
    }
    
    @objc func showCalllogTripi() {
        let vc = DetailCalllogTripiViewController()
        vc.requestID = self.detailTribi?.RequestID ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}

extension DetailHistoryTribiViewController: ChooseCancelTripiServiceViewControllerDelegate {
    func getCancelTripiServiceType(type: Int, typeName: String) {
        let vc = CancelCalllogTripiViewController()
        vc.detailTribi = self.detailTribi
        vc.calllogTripiType = type
        vc.cancelCalllogTripiTitle = typeName
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



