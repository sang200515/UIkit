//
//  DuyetLoiDOAViewController.swift
//  fptshop
//
//  Created by Apple on 7/19/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DuyetLoiDOAViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var lbImgMayLoi: UILabel!
    var lbImgVoHopKemMay: UILabel!
    
    var mayLoiView: UIView!
    var voHopVaMayView: UIView!
    var imgViewMayLoi: UIImageView!
    var imgViewVoHopVaMay: UIImageView!
    var strBase64MayLoi = ""
    var strBase64VoHopVaMay = ""
    var urlStrMayLoi = ""
    var urlStrVoHopVaMay = ""
    
    var traoDoiView:UIView!
    var btnSendRequest: UIButton!
    var tvNDTraoDoi: UITextView!
    
    var imagePicker = UIImagePickerController()
    var posImageUpload:Int = -1
    var callog:CallLog?
    
    var duyetLoiDOADetailItem:DOA_LoadDetailResult?
    var newestConversation: DOA_LoadConvResult?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(self.callog?.RequestID ?? 0)"
        self.view.backgroundColor = UIColor.white
        
        let backView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:50))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: backView)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        backView.addSubview(btBackIcon)
        
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let rs = mCallLogApiManager.DuyetLoiDOA_213_LoadDetail(p_RequestId: "\(self.callog?.RequestID ?? 0)").Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if rs.count > 0 {
                    self.duyetLoiDOADetailItem = rs[0]
                }
                WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                    let convResults = mCallLogApiManager.DuyetLoiDOA_213_LoadConv(p_RequestId: "\(self.callog?.RequestID ?? 0)").Data ?? []
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if convResults.count > 0 {
                            self.newestConversation = convResults[0]
                        }
                        self.setUpView()
                    }
                }
            }
        }
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let sendInfoView = UIScrollView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s:40)))
        sendInfoView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        scrollView.addSubview(sendInfoView)
        
        let lbSendInfo = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: sendInfoView.frame.width - Common.Size(s:30), height: sendInfoView.frame.height))
        lbSendInfo.text = "THÔNG TIN GỬI"
        sendInfoView.addSubview(lbSendInfo)
        
        let lbMaCalllog = UILabel(frame: CGRect(x: Common.Size(s:15), y: sendInfoView.frame.origin.y + sendInfoView.frame.height + Common.Size(s: 10), width: scrollView.frame.width/3 - Common.Size(s:15), height: Common.Size(s:20)))
        lbMaCalllog.text = "Mã Calllog:"
        lbMaCalllog.textColor = .lightGray
        lbMaCalllog.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbMaCalllog)
        
        let lbMaCalllogNum = UILabel(frame: CGRect(x: lbMaCalllog.frame.origin.x + lbMaCalllog.frame.width, y: lbMaCalllog.frame.origin.y, width: scrollView.frame.width/3 - Common.Size(s:15), height: Common.Size(s:20)))
        lbMaCalllogNum.text = "\(self.duyetLoiDOADetailItem?.Request_ID ?? 0)"
        lbMaCalllogNum.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbMaCalllogNum)
        
        let lbSendDate = UILabel(frame: CGRect(x: lbMaCalllog.frame.origin.x + lbMaCalllog.frame.width + lbMaCalllogNum.frame.width, y: lbMaCalllog.frame.origin.y, width: scrollView.frame.width - lbMaCalllog.frame.width - lbMaCalllogNum.frame.width - Common.Size(s:30), height: Common.Size(s:20)))
//        lbSendDate.text = Common.GetDateStringFromV2(jsonStr: "\(self.duyetLoiDOADetailItem?.TimeCreate ?? "")")
        lbSendDate.text = "\(self.duyetLoiDOADetailItem?.TimeCreate ?? "")"
        lbSendDate.textAlignment = .right
        lbSendDate.font = UIFont.systemFont(ofSize: 12)
        scrollView.addSubview(lbSendDate)
        
        let lbFrom = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbMaCalllogNum.frame.origin.y + lbMaCalllogNum.frame.height + Common.Size(s: 5), width: lbMaCalllog.frame.width, height: Common.Size(s:20)))
        lbFrom.text = "Từ:"
        lbFrom.textColor = .lightGray
        lbFrom.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbFrom)
        
        let lbFromAddress = UILabel(frame: CGRect(x: lbFrom.frame.origin.x + lbFrom.frame.width, y: lbFrom.frame.origin.y, width: scrollView.frame.width - lbFrom.frame.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbFromAddress.text = "\(self.duyetLoiDOADetailItem?.Sender ?? "")"
        lbFromAddress.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbFromAddress)
        
        let lbFromAddressHeight:CGFloat = lbFromAddress.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : lbFromAddress.optimalHeight
        lbFromAddress.numberOfLines = 0
        lbFromAddress.frame = CGRect(x: lbFromAddress.frame.origin.x, y: lbFromAddress.frame.origin.y, width: lbFromAddress.frame.width, height: lbFromAddressHeight)
        
        let receiveInfoView = UIScrollView(frame: CGRect(x: 0, y: lbFromAddress.frame.origin.y + lbFromAddressHeight + Common.Size(s: 10), width: scrollView.frame.width, height: Common.Size(s:40)))
        receiveInfoView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        scrollView.addSubview(receiveInfoView)
        
        let lbReceiveInfo = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: receiveInfoView.frame.width - Common.Size(s:30), height: receiveInfoView.frame.height))
        lbReceiveInfo.text = "THÔNG TIN NHẬN"
        receiveInfoView.addSubview(lbReceiveInfo)
        
        let lbTo = UILabel(frame: CGRect(x: Common.Size(s:15), y: receiveInfoView.frame.origin.y + receiveInfoView.frame.height + Common.Size(s: 15), width: lbMaCalllog.frame.width, height: Common.Size(s:20)))
        lbTo.text = "Đến:"
        lbTo.textColor = .lightGray
        lbTo.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbTo)
        
        let lbToAddress = UILabel(frame: CGRect(x: lbTo.frame.origin.x + lbTo.frame.width, y: lbTo.frame.origin.y, width: lbFromAddress.frame.width, height: Common.Size(s:20)))
        lbToAddress.text = "\(self.duyetLoiDOADetailItem?.Assigner ?? "")"
        lbToAddress.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbToAddress)
        
        let lbToAddressHeight:CGFloat = lbToAddress.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : lbToAddress.optimalHeight
        lbToAddress.numberOfLines = 0
        lbToAddress.frame = CGRect(x: lbToAddress.frame.origin.x, y: lbToAddress.frame.origin.y, width: lbToAddress.frame.width, height: lbToAddressHeight)
        
        let lbSoDH = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbToAddress.frame.origin.y + lbToAddressHeight + Common.Size(s: 5), width: lbMaCalllog.frame.width, height: Common.Size(s:20)))
        lbSoDH.text = "Số ĐH:"
        lbSoDH.textColor = .lightGray
        lbSoDH.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSoDH)
        
        let lbSoDHValue = UILabel(frame: CGRect(x: lbSoDH.frame.origin.x + lbSoDH.frame.width, y: lbSoDH.frame.origin.y, width: lbFromAddress.frame.width, height: Common.Size(s:20)))
        lbSoDHValue.text = "\(self.duyetLoiDOADetailItem?.SoDonHang ?? "")"
        lbSoDHValue.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSoDHValue)
        
        let lbSoHD = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbSoDHValue.frame.origin.y + lbSoDHValue.frame.height + Common.Size(s: 5), width: lbMaCalllog.frame.width, height: Common.Size(s:20)))
        lbSoHD.text = "Số HĐ:"
        lbSoHD.textColor = .lightGray
        lbSoHD.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSoHD)
        
        let lbSoHoaDonValue = UILabel(frame: CGRect(x: lbSoHD.frame.origin.x + lbSoHD.frame.width, y: lbSoHD.frame.origin.y, width: lbFromAddress.frame.width, height: Common.Size(s:20)))
        lbSoHoaDonValue.text = "\(self.duyetLoiDOADetailItem?.SoHoaDon ?? "")"
        lbSoHoaDonValue.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSoHoaDonValue)
        
        let lbNgayXuat = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbSoHoaDonValue.frame.origin.y + lbSoHoaDonValue.frame.height + Common.Size(s: 5), width: lbMaCalllog.frame.width, height: Common.Size(s:20)))
        lbNgayXuat.text = "Ngày xuất:"
        lbNgayXuat.textColor = .lightGray
        lbNgayXuat.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNgayXuat)
        
        let lbNgayXuatValue = UILabel(frame: CGRect(x: lbNgayXuat.frame.origin.x + lbNgayXuat.frame.width, y: lbNgayXuat.frame.origin.y, width: lbFromAddress.frame.width, height: Common.Size(s:20)))
//        lbNgayXuatValue.text = Common.GetDateStringFromV2(jsonStr: "\(self.duyetLoiDOADetailItem?.NgayXuat ?? "")")
        lbNgayXuatValue.text = "\(self.duyetLoiDOADetailItem?.NgayXuat ?? "")"
        lbNgayXuatValue.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNgayXuatValue)
        
        let lbSp = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbNgayXuatValue.frame.origin.y + lbNgayXuatValue.frame.height + Common.Size(s: 5), width: lbMaCalllog.frame.width, height: Common.Size(s:20)))
        lbSp.text = "Sản phẩm:"
        lbSp.textColor = .lightGray
        lbSp.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSp)
        
        let lbSpName = UILabel(frame: CGRect(x: lbSp.frame.origin.x + lbSp.frame.width, y: lbSp.frame.origin.y, width: lbFromAddress.frame.width, height: Common.Size(s:20)))
        lbSpName.text = "\(self.duyetLoiDOADetailItem?.MaSanPham ?? "") - \(self.duyetLoiDOADetailItem?.TenSanPham ?? "")"
        lbSpName.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSpName)
        
        let lbSpNameHeight:CGFloat = lbSpName.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : lbSpName.optimalHeight
        lbSpName.numberOfLines = 0
        lbSpName.frame = CGRect(x: lbSpName.frame.origin.x, y: lbSpName.frame.origin.y, width: lbSpName.frame.width, height: lbSpNameHeight)
        
        let lbGiaTriSP = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbSpName.frame.origin.y + lbSpNameHeight + Common.Size(s: 5), width: lbMaCalllog.frame.width, height: Common.Size(s:20)))
        lbGiaTriSP.text = "Giá trị SP:"
        lbGiaTriSP.textColor = .lightGray
        lbGiaTriSP.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbGiaTriSP)
        
        let lbGiaTriSPValue = UILabel(frame: CGRect(x: lbGiaTriSP.frame.origin.x + lbGiaTriSP.frame.width, y: lbGiaTriSP.frame.origin.y, width: lbFromAddress.frame.width, height: Common.Size(s:20)))
        lbGiaTriSPValue.text = "\(self.duyetLoiDOADetailItem?.GiaTriSanPham ?? "")đ"
        lbGiaTriSPValue.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbGiaTriSPValue)
        
        let lbImei = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbGiaTriSPValue.frame.origin.y + lbGiaTriSPValue.frame.height + Common.Size(s: 5), width: lbMaCalllog.frame.width, height: Common.Size(s:20)))
        lbImei.text = "IMEI:"
        lbImei.textColor = .lightGray
        lbImei.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbImei)
        
        let lbImeiNum = UILabel(frame: CGRect(x: lbImei.frame.origin.x + lbImei.frame.width, y: lbImei.frame.origin.y, width: lbFromAddress.frame.width, height: Common.Size(s:20)))
        lbImeiNum.text = "\(self.duyetLoiDOADetailItem?.Imei ?? "")"
        lbImeiNum.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbImeiNum)
        
        let lbSL = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbImeiNum.frame.origin.y + lbImeiNum.frame.height + Common.Size(s: 5), width: lbMaCalllog.frame.width, height: Common.Size(s:20)))
        lbSL.text = "Số lượng:"
        lbSL.textColor = .lightGray
        lbSL.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSL)
        
        let lbSLValue = UILabel(frame: CGRect(x: lbSL.frame.origin.x + lbSL.frame.width, y: lbSL.frame.origin.y, width: lbFromAddress.frame.width, height: Common.Size(s:20)))
        lbSLValue.text = "\(self.duyetLoiDOADetailItem?.SoLuong ?? 0)"
        lbSLValue.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSLValue)
        
        let lbTTMay = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbSLValue.frame.origin.y + lbSLValue.frame.height + Common.Size(s: 5), width: lbMaCalllog.frame.width, height: Common.Size(s:20)))
        lbTTMay.text = "TT Máy:"
        lbTTMay.textColor = .lightGray
        lbTTMay.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbTTMay)
        
        let lbTTMayValue = UILabel(frame: CGRect(x: lbTTMay.frame.origin.x + lbTTMay.frame.width, y: lbTTMay.frame.origin.y, width: lbFromAddress.frame.width, height: Common.Size(s:20)))
        lbTTMayValue.text = "\(self.duyetLoiDOADetailItem?.TinhTrangMay ?? "")"
        lbTTMayValue.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbTTMayValue)
        
        let lbTieuChiTinhPhi = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbTTMayValue.frame.origin.y + lbTTMayValue.frame.height + Common.Size(s: 5), width: lbMaCalllog.frame.width, height: Common.Size(s:40)))
        lbTieuChiTinhPhi.text = "Tiêu chí\ntính phí:"
        lbTieuChiTinhPhi.textColor = .lightGray
        lbTieuChiTinhPhi.lineBreakMode = .byWordWrapping
        lbTieuChiTinhPhi.numberOfLines = 0
        lbTieuChiTinhPhi.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbTieuChiTinhPhi)
        
        let lbTieuChiTinhPhiValue = UILabel(frame: CGRect(x: lbTieuChiTinhPhi.frame.origin.x + lbTieuChiTinhPhi.frame.width, y: lbTieuChiTinhPhi.frame.origin.y, width: lbFromAddress.frame.width, height: Common.Size(s:20)))
        lbTieuChiTinhPhiValue.text = "\(self.duyetLoiDOADetailItem?.TieuChiTinhPhi ?? "")"
        lbTieuChiTinhPhiValue.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbTieuChiTinhPhiValue)
        
        let lbTieuChiTinhPhiValueHeight:CGFloat = lbTieuChiTinhPhiValue.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : lbTieuChiTinhPhiValue.optimalHeight
        lbTieuChiTinhPhiValue.numberOfLines = 0
        lbTieuChiTinhPhiValue.frame = CGRect(x: lbTieuChiTinhPhiValue.frame.origin.x, y: lbTieuChiTinhPhiValue.frame.origin.y, width: lbTieuChiTinhPhiValue.frame.width, height: lbTieuChiTinhPhiValueHeight)
        
        let topSpace:CGFloat = lbTieuChiTinhPhiValueHeight < Common.Size(s:40) ? Common.Size(s:40) : lbTieuChiTinhPhiValueHeight
        
        let ImgAttackView = UIScrollView(frame: CGRect(x: 0, y: lbTieuChiTinhPhiValue.frame.origin.y + topSpace + Common.Size(s: 15), width: scrollView.frame.width, height: Common.Size(s:40)))
        ImgAttackView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        scrollView.addSubview(ImgAttackView)
        
        let lbImgAttackInfo = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: ImgAttackView.frame.width - Common.Size(s:30), height: ImgAttackView.frame.height))
        lbImgAttackInfo.text = "HÌNH ẢNH ĐÍNH KÈM"
        ImgAttackView.addSubview(lbImgAttackInfo)
        
        lbImgMayLoi = UILabel(frame: CGRect(x: Common.Size(s:15), y: ImgAttackView.frame.origin.y + ImgAttackView.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbImgMayLoi.text = "Ảnh máy lỗi:"
        lbImgMayLoi.textColor = .lightGray
        lbImgMayLoi.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbImgMayLoi)
        
        mayLoiView = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbImgMayLoi.frame.origin.y + lbImgMayLoi.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:150)))
        mayLoiView.layer.borderColor = UIColor.lightGray.cgColor
        mayLoiView.layer.borderWidth = 1
        scrollView.addSubview(mayLoiView)
        
        imgViewMayLoi = UIImageView(frame: CGRect(x: 0, y: 0, width: mayLoiView.frame.width, height: mayLoiView.frame.height))
        imgViewMayLoi.image = #imageLiteral(resourceName: "Hinhanh")
        imgViewMayLoi.contentMode = .scaleAspectFit
        mayLoiView.addSubview(imgViewMayLoi)
        
        let tapShowAnhMayLoi = UITapGestureRecognizer(target: self, action: #selector(takePhotoMayLoi))
        mayLoiView.isUserInteractionEnabled = true
        mayLoiView.addGestureRecognizer(tapShowAnhMayLoi)
        
        lbImgVoHopKemMay = UILabel(frame: CGRect(x: Common.Size(s:15), y: mayLoiView.frame.origin.y + mayLoiView.frame.height + Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbImgVoHopKemMay.text = "Hình ảnh vỏ hộp kèm máy:"
        lbImgVoHopKemMay.textColor = .lightGray
        lbImgVoHopKemMay.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbImgVoHopKemMay)
        
        voHopVaMayView = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbImgVoHopKemMay.frame.origin.y + lbImgVoHopKemMay.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:150)))
        voHopVaMayView.layer.borderColor = UIColor.lightGray.cgColor
        voHopVaMayView.layer.borderWidth = 1
        scrollView.addSubview(voHopVaMayView)
        
        imgViewVoHopVaMay = UIImageView(frame: CGRect(x: 0, y: 0, width: voHopVaMayView.frame.width, height: voHopVaMayView.frame.height))
        imgViewVoHopVaMay.image = #imageLiteral(resourceName: "Hinhanh")
        imgViewVoHopVaMay.contentMode = .scaleAspectFit
        voHopVaMayView.addSubview(imgViewVoHopVaMay)
        
        let tapShowAnhVoHopVaMay = UITapGestureRecognizer(target: self, action: #selector(takePhotoVoHopVaMay))
        voHopVaMayView.isUserInteractionEnabled = true
        voHopVaMayView.addGestureRecognizer(tapShowAnhVoHopVaMay)
        
        //trao doi view
        traoDoiView = UIScrollView(frame: CGRect(x: 0, y: voHopVaMayView.frame.origin.y + voHopVaMayView.frame.height + Common.Size(s: 15), width: scrollView.frame.width, height: Common.Size(s:40)))
        traoDoiView.backgroundColor = UIColor.white
        scrollView.addSubview(traoDoiView)
        
        let conversationView = UIScrollView(frame: CGRect(x: 0, y: 0, width: traoDoiView.frame.width, height: Common.Size(s:40)))
        conversationView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        traoDoiView.addSubview(conversationView)
        
        let lbconv = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: conversationView.frame.width - Common.Size(s:30), height: conversationView.frame.height))
        lbconv.text = "NỘI DUNG TRAO ĐỔI"
        conversationView.addSubview(lbconv)
        
        let lbNDTraoDoiNew = UILabel(frame: CGRect(x: Common.Size(s:15), y: conversationView.frame.origin.y + conversationView.frame.height + Common.Size(s:10), width: traoDoiView.frame.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbNDTraoDoiNew.text = "Nội dung trao đổi mới nhất:"
        lbNDTraoDoiNew.textColor = .lightGray
        lbNDTraoDoiNew.font = UIFont.systemFont(ofSize: 14)
        traoDoiView.addSubview(lbNDTraoDoiNew)
        
        let lbNDTraoDoiNewText = UILabel(frame: CGRect(x: Common.Size(s:15), y: lbNDTraoDoiNew.frame.origin.y + lbNDTraoDoiNew.frame.height + Common.Size(s:5), width: traoDoiView.frame.width - Common.Size(s:30), height: Common.Size(s:20)))
        lbNDTraoDoiNewText.textColor = .lightGray
        lbNDTraoDoiNewText.font = UIFont.systemFont(ofSize: 14)
        traoDoiView.addSubview(lbNDTraoDoiNewText)
        
        let attributedText = NSMutableAttributedString(string: "\(self.newestConversation?.EmployeeName ?? "")", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.black])
        
        attributedText.append(NSAttributedString(string: "\(self.newestConversation?.Message ?? "")".htmlToString, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black]))
        lbNDTraoDoiNewText.attributedText = attributedText
        
        let lbNDTraoDoiNewTextHeight:CGFloat = lbNDTraoDoiNewText.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : lbNDTraoDoiNewText.optimalHeight
        lbNDTraoDoiNewText.numberOfLines = 0
        lbNDTraoDoiNewText.frame = CGRect(x: lbNDTraoDoiNewText.frame.origin.x, y: lbNDTraoDoiNewText.frame.origin.y, width: lbNDTraoDoiNewText.frame.width, height: lbNDTraoDoiNewTextHeight)
        
        tvNDTraoDoi = UITextView(frame: CGRect(x: Common.Size(s:15), y: lbNDTraoDoiNewText.frame.origin.y + lbNDTraoDoiNewTextHeight + Common.Size(s:5), width: traoDoiView.frame.width - Common.Size(s:30), height: Common.Size(s:70)))
        tvNDTraoDoi.layer.cornerRadius = 5
        tvNDTraoDoi.layer.borderWidth = 1
        tvNDTraoDoi.layer.borderColor = UIColor.lightGray.cgColor
        tvNDTraoDoi.text = "Nhập nội dung trao đổi"
        tvNDTraoDoi.textColor = UIColor.lightGray
        tvNDTraoDoi.font = UIFont.systemFont(ofSize: 14)
        tvNDTraoDoi.delegate = self
        traoDoiView.addSubview(tvNDTraoDoi)
        
        traoDoiView.frame = CGRect(x: traoDoiView.frame.origin.x, y: traoDoiView.frame.origin.y, width: traoDoiView.frame.width, height: tvNDTraoDoi.frame.origin.y + tvNDTraoDoi.frame.height + Common.Size(s: 20))
        
        btnSendRequest = UIButton(frame: CGRect(x: Common.Size(s:15), y: traoDoiView.frame.origin.y + traoDoiView.frame.height + Common.Size(s:10), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:40)))
        btnSendRequest.backgroundColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        btnSendRequest.setTitle("GỬI PHẢN HỒI", for: .normal)
        btnSendRequest.layer.cornerRadius = 5
        scrollView.addSubview(btnSendRequest)
        btnSendRequest.addTarget(self, action: #selector(sendCLRequest), for: .touchUpInside)
        
        scrollViewHeight = btnSendRequest.frame.origin.y + btnSendRequest.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 15)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
    }
    
    @objc func sendCLRequest() {
        if imgViewMayLoi.image == #imageLiteral(resourceName: "Hinhanh") {
            self.showAlert(title: "Thông báo", message: "Bạn chưa up hình máy lỗi!")
        } else {
            guard !self.urlStrMayLoi.isEmpty else {
                self.showAlert(title: "Thông báo", message: "Lỗi up hình máy lỗi!")
                return
            }
        }
        
        if imgViewVoHopVaMay.image == #imageLiteral(resourceName: "Hinhanh") {
            self.showAlert(title: "Thông báo", message: "Bạn chưa up hình vỏ hộp kèm máy!")
        } else {
            guard !self.urlStrVoHopVaMay.isEmpty else {
                self.showAlert(title: "Thông báo", message: "Lỗi up hình vỏ hộp kèm máy!")
                return
            }
        }
        
        
        
        guard (self.tvNDTraoDoi.text != "") && (self.tvNDTraoDoi.text != "Nhập nội dung trao đổi") else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập nội dung trao đổi!")
            return
        }
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let rs = mCallLogApiManager.DuyetLoiDOA_213_SaveImgUrl(p_RequestId: "\(self.callog?.RequestID ?? 0)", p_Sender: "\(Cache.user?.UserName ?? "")", p_LinkImage1: self.urlStrMayLoi, p_LinkImage2: self.urlStrVoHopVaMay, p_Message: self.tvNDTraoDoi.text ?? "").Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if rs.count > 0 {
                    if rs[0].Result == 1 {
                        let alertVC = UIAlertController(title: "Thông báo", message: "\(rs[0].Note ?? "Duyệt thành công!")", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                            self.navigationController?.popViewController(animated: true)
                        })
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    } else {
                        self.showAlert(title: "Thông báo", message: "\(rs[0].Note ?? "DuyetLoiDOA_213_SaveImgUrl thất bại!")")
                    }
                } else {
                    self.showAlert(title: "Thông báo", message: "DuyetLoiDOA_213_SaveImgUrl thất bại!")
                }
            }
        }
    }
    
    @objc func takePhotoMayLoi() {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc func takePhotoVoHopVaMay() {
        self.posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    
    func setImgMayLoi(image: UIImage) {
        let heightImage:CGFloat = Common.Size(s: 150)
        mayLoiView.subviews.forEach { $0.removeFromSuperview() }
        imgViewMayLoi = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: heightImage))
        imgViewMayLoi.contentMode = .scaleAspectFit
        imgViewMayLoi.image = image
        mayLoiView.addSubview(imgViewMayLoi)
        
        mayLoiView.frame = CGRect(x: mayLoiView.frame.origin.x, y: lbImgMayLoi.frame.origin.y + lbImgMayLoi.frame.height + Common.Size(s: 5), width: mayLoiView.frame.width, height: Common.Size(s: 150))
        
        lbImgVoHopKemMay.frame = CGRect(x: lbImgVoHopKemMay.frame.origin.x, y: mayLoiView.frame.origin.y + mayLoiView.frame.height + Common.Size(s: 10), width: lbImgVoHopKemMay.frame.width, height:lbImgVoHopKemMay.frame.height)
        
        voHopVaMayView.frame = CGRect(x: voHopVaMayView.frame.origin.x, y: lbImgVoHopKemMay.frame.origin.y + lbImgVoHopKemMay.frame.height + Common.Size(s: 5), width: voHopVaMayView.frame.width, height:voHopVaMayView.frame.height)
        
        traoDoiView.frame = CGRect(x: traoDoiView.frame.origin.x, y: voHopVaMayView.frame.origin.y + voHopVaMayView.frame.height + Common.Size(s: 15), width: traoDoiView.frame.width, height:traoDoiView.frame.height)
        
        btnSendRequest.frame = CGRect(x: btnSendRequest.frame.origin.x, y: traoDoiView.frame.origin.y + traoDoiView.frame.height + Common.Size(s:10), width: btnSendRequest.frame.width, height:btnSendRequest.frame.height)
        
        
        scrollViewHeight = btnSendRequest.frame.origin.y + btnSendRequest.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 15)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        
        let imageMayLoiResize:UIImage = self.resizeImageWidth(image: imgViewMayLoi.image!,newWidth: Common.resizeImageWith)!
        let imageMayLoiData:NSData = (imageMayLoiResize.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
        self.strBase64MayLoi = imageMayLoiData.base64EncodedString(options: .endLineWithLineFeed)
        
        let imgName = "\(Cache.user?.UserName ?? "")_\(DateFormatter().string(from: Date())).jpg";
        let imgPathResult = mCallLogApiManager.UploadImage(fileName: imgName, encodedImg: self.strBase64MayLoi, username: "\(Cache.user?.UserName ?? "")").Data;
        if imgPathResult?.Result == 1 {
            if !(imgPathResult?.FilePath)!.isEmpty {
                self.urlStrMayLoi = (imgPathResult?.FilePath)!
            } else {
                self.showAlert(title: "Thông báo", message: "\(imgPathResult?.Message ?? "Up ảnh máy lỗi thất bại!")")
            }
        } else {
            self.showAlert(title: "Thông báo", message: "\(imgPathResult?.Message ?? "Up ảnh máy lỗi thất bại!")")
        }
    }
    
    func setImgVoHopVaMay(image: UIImage) {
        let heightImage:CGFloat = Common.Size(s: 150)
        voHopVaMayView.subviews.forEach { $0.removeFromSuperview() }
        imgViewVoHopVaMay = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: heightImage))
        imgViewVoHopVaMay.contentMode = .scaleAspectFit
        imgViewVoHopVaMay.image = image
        voHopVaMayView.addSubview(imgViewVoHopVaMay)
        
        voHopVaMayView.frame = CGRect(x: mayLoiView.frame.origin.x, y: lbImgVoHopKemMay.frame.origin.y + lbImgVoHopKemMay.frame.height + Common.Size(s: 5), width: voHopVaMayView.frame.width, height: Common.Size(s: 150))
        
        traoDoiView.frame = CGRect(x: traoDoiView.frame.origin.x, y: voHopVaMayView.frame.origin.y + voHopVaMayView.frame.height + Common.Size(s: 15), width: traoDoiView.frame.width, height:traoDoiView.frame.height)
        
        btnSendRequest.frame = CGRect(x: btnSendRequest.frame.origin.x, y: traoDoiView.frame.origin.y + traoDoiView.frame.height + Common.Size(s:10), width: btnSendRequest.frame.width, height:btnSendRequest.frame.height)
        
        
        scrollViewHeight = btnSendRequest.frame.origin.y + btnSendRequest.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 15)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        
        let imageVoHopVaMayResize:UIImage = self.resizeImageWidth(image: imgViewVoHopVaMay.image!,newWidth: Common.resizeImageWith)!
        let imageVoHopVaMayData:NSData = (imageVoHopVaMayResize.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
        self.strBase64VoHopVaMay = imageVoHopVaMayData.base64EncodedString(options: .endLineWithLineFeed)
        
        let imgName = "\(Cache.user?.UserName ?? "")_\(DateFormatter().string(from: Date())).jpg";
        let imgPathResult = mCallLogApiManager.UploadImage(fileName: imgName, encodedImg: self.strBase64VoHopVaMay, username: "\(Cache.user?.UserName ?? "")").Data;
        if imgPathResult?.Result == 1 {
            if !(imgPathResult?.FilePath)!.isEmpty {
                self.urlStrVoHopVaMay = (imgPathResult?.FilePath)!
            } else {
                self.showAlert(title: "Thông báo", message: "\(imgPathResult?.Message ?? "Up ảnh vỏ hộp kèm   thất bại!")")
            }
        } else {
            self.showAlert(title: "Thông báo", message: "\(imgPathResult?.Message ?? "Up ảnh vỏ hộp kèm máy thất bại!")")
        }
    }
    
    func resizeImageWidth(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }

}

extension DuyetLoiDOAViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            //            alert.popoverPresentationController?.sourceView = sender
            //            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        // image is our desired image
        if (self.posImageUpload == 1){
            self.setImgMayLoi(image: image)
        } else if (self.posImageUpload == 2 ){
            self.setImgVoHopVaMay(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Open the camera
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.navigationBar.barTintColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}

extension DuyetLoiDOAViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if self.tvNDTraoDoi.text == "Nhập nội dung trao đổi" {
            tvNDTraoDoi.text = ""
            tvNDTraoDoi.textColor = .black
        } else {
            tvNDTraoDoi.textColor = .black
        }
        
        scrollViewHeight = btnSendRequest.frame.origin.y + btnSendRequest.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 175)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if self.tvNDTraoDoi.text == "" {
            tvNDTraoDoi.text = "Nhập nội dung trao đổi"
            tvNDTraoDoi.textColor = .lightGray
        } else {
            tvNDTraoDoi.textColor = .black
        }
        scrollViewHeight = btnSendRequest.frame.origin.y + btnSendRequest.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 15)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        return true
    }
}
