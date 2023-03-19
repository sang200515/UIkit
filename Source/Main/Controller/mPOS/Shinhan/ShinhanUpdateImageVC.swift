//
//  ShinhanUpdateImageVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 10/02/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import SwiftUI

class ShinhanUpdateImageVC: BaseController, RadioCustomDelegate {
    
    @IBOutlet weak var khoanVayListView: ListImageView!
    @IBOutlet weak var infoThueBaoView: ImageFrameCustom!
    @IBOutlet weak var chandungView: ImageFrameCustom!
    @IBOutlet weak var gplxRadio: RadioCustom!
    @IBOutlet weak var shkRadio: RadioCustom!
    @IBOutlet weak var shkStack: UIStackView!
    @IBOutlet weak var shkImgView1: ImageFrameCustom!
    @IBOutlet weak var shkImgView2: ImageFrameCustom!
    @IBOutlet weak var gplxView: ImageFrameCustom!
    @IBOutlet weak var cmndView: ImageFrameCustom!
    @IBOutlet weak var stackKhoanVay: UIStackView!
    
    var detailOrder: ShinhanOrderDetail?
    var idCard = ""
    var trackingID = ""
    var onSuccess: (()->Void)?
    var isFromUpdateLoan = false
    var paperType = 3 // 3 gplx 4 SHK
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoThueBaoView.controller = self
        infoThueBaoView.delegate = self
        chandungView.controller = self
        chandungView.delegate = self
        gplxView.controller = self
        gplxView.delegate = self
        cmndView.controller = self
        cmndView.delegate = self
        khoanVayListView.controller = self
        khoanVayListView.delegate = self
        shkRadio.delegate = self
        gplxRadio.delegate = self
        shkImgView1.controller = self
        shkImgView2.controller = self
        shkImgView1.delegate = self
        shkImgView2.delegate = self
        stackKhoanVay.isHidden = !(detailOrder?.button?.viewCustomerInfoBtn ?? false)
        idCard = detailOrder?.customer?.idCard ?? ""
        trackingID = detailOrder?.customer?.trackingId ?? ""
        onClickRadio(radioView: UIView(), tag: paperType)
    }
    
    func uploadImage(docID: String,idCard: String,base64: String,trackingID: String,isLeft: Bool = false,index: Int = 0) {
        self.showLoading()
        Provider.shared.shinhan.uploadimage(docID: docID, idCard: idCard, trackingID: trackingID, base64: base64) {[weak self] result in
            guard let self = self else {return}
            self.stopLoading()
            if !(result?.success ?? false) {
                self.showAlert(result?.message ?? "")
                if docID == "1" {
                    self.chandungView.setdefault(isLeft: true)
                } else if docID == "2" {
                    self.cmndView.setdefault(isLeft: true)
                } else if docID == "3" {
                    self.cmndView.setdefault(isLeft: false)
                } else if docID == "9" {
                    self.gplxView.setdefault(isLeft: true)
                } else if docID == "13" {
                    self.gplxView.setdefault(isLeft: false)
                } else if docID == "12" {
                    self.infoThueBaoView.setdefault(isLeft: true)
                } else if docID == "4" {
                    if index == 0 {
                        self.shkImgView1.setdefault(isLeft: isLeft)
                    } else {
                        self.shkImgView2.setdefault(isLeft: isLeft)
                    }
                }
            }
        } failure: { [weak self] error in
            guard let self = self else {return}
            self.stopLoading()
            self.showAlert(error.localizedDescription)
        }
    }
    
    func validate() -> Bool {
        let isListupload = khoanVayListView.isUploadedAtLeastOneImage()
        let isCmnd = cmndView.isUploadedAtleastOneImage()
        let isGplx = gplxView.isUploadedAtleastOneImage()
        let isChanDung = chandungView.isUploadedAtleastOneImage()
        let infoPhone = infoThueBaoView.isUploadedAtleastOneImage()
        if isListupload || isCmnd || isGplx || isChanDung || infoPhone {
            return true
        }
        return false
    }
    
    func updateImg(type: Int,completeHandle:@escaping (String,Bool)->Void) {
        Provider.shared.shinhan.reuploadImage(trackingID: self.trackingID,type: type, success: { [weak self] result in
            completeHandle(result?.message ?? "",result?.success ?? false)
        }, failure: { [weak self] error in
            completeHandle(error.localizedDescription,false)
        })
    }
    
    @IBAction func onUpdateImage() {
        
        let typeFromLoanFlow = 3
        let typeSendToNTG = 1
        let typeTypeUpdateLoanBtn = 2
        
        if isFromUpdateLoan {
            self.updateImg(type: typeFromLoanFlow) { (message, success) in
                self.showAlertOneButton(title: "Thông báo", with: message, titleButton: "OK") {
                    if success {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
        } else {
            self.showPopUpTwoButtons(message: self.detailOrder?.button?.updateLoanInfo ?? "", title: "THÔNG BÁO", title1: "GỬI SANG NTG", title2: "CẬP NHẬT KHOẢN VAY") {
                self.updateImg(type: typeSendToNTG) { (message, success) in
                    self.showAlertOneButton(title: "Thông báo", with: message, titleButton: "OK") {
                        if success {
                            if let onSuccess = self.onSuccess {
                                onSuccess()
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }
            } handleButtonTwo: {
                self.updateImg(type: typeTypeUpdateLoanBtn) { (message, success) in
                    self.showAlertOneButton(title: "Thông báo", with: message, titleButton: "OK") {
                        if success {
                            let vc = DetailShinhanOrder()
                            vc.type = .updateLoan
                            vc.detailOrder = self.detailOrder
                            vc.docEntry = ShinhanData.docEntry
                            ShinhanData.resetShinhanData()
                            ShinhanData.docEntry = vc.docEntry
                            ShinhanData.tientraTruoc = self.detailOrder?.payment?.downPayment ?? 0
                            ShinhanData.IS_RUNNING = true
                            ShinhanData.detailorDerHistory = self.detailOrder
                            ShinhanData.updateFromImageVC = true
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }
                
            }
        }
    }
    
    
}

extension ShinhanUpdateImageVC: ListImageViewDelegate, ImageFrameCustomDelegate {
    func didPickImage(_ view: ImageFrameCustom, image: UIImage, isLeft: Bool) {
        let idCard = detailOrder?.customer?.idCard ?? ""
        let trackingID = detailOrder?.customer?.trackingId ?? ""
        if let imageData:NSData = image.jpegData(compressionQuality: 0.1) as NSData?{
            let base64Str = imageData.base64EncodedString(options: .endLineWithLineFeed)
            DispatchQueue.main.async {
                if view == self.cmndView {
                    if isLeft {
                        self.uploadImage(docID: "2", idCard: idCard, base64: base64Str, trackingID: trackingID)
                    } else {
                        self.uploadImage(docID: "3", idCard: idCard, base64: base64Str, trackingID: trackingID)
                    }
                } else if view == self.gplxView {
                    if isLeft {
                        self.uploadImage(docID: "9", idCard: idCard, base64: base64Str, trackingID: trackingID,isLeft:isLeft)
                    } else {
                        self.uploadImage(docID: "13", idCard: idCard, base64: base64Str, trackingID: trackingID,isLeft:isLeft)
                    }
                } else if view == self.chandungView {
                    self.uploadImage(docID: "1", idCard: idCard, base64: base64Str, trackingID: trackingID)
                } else if view == self.infoThueBaoView {
                    self.uploadImage(docID: "12", idCard: idCard, base64: base64Str, trackingID: trackingID)
                }  else if view == self.shkImgView1 {
                    self.uploadImage(docID: "4", idCard: idCard, base64: base64Str, trackingID: trackingID,isLeft: isLeft,index: 0)
                } else if view == self.shkImgView2 {
                    self.uploadImage(docID: "4", idCard: idCard, base64: base64Str, trackingID: trackingID,isLeft: isLeft,index: 1)
                }
            }
        }
    }
    
    func didPickImage(image: UIImage, number: Int) { // list Image
        var docID = "10"
        switch number {
        case 0:
            docID = "10"
        case 1:
            docID = "14"
        case 2:
            docID = "15"
        case 3:
            docID = "16"
        case 4:
            docID = "17"
        default: break
        }
        if let imageData:NSData = image.jpegData(compressionQuality: 0.1) as NSData?{
            let base64Str = imageData.base64EncodedString(options: .endLineWithLineFeed)
            ProgressView.shared.show()
            Provider.shared.shinhan.uploadimage(docID: docID, idCard: self.idCard, trackingID: trackingID, base64: base64Str, success: {[weak self] result in
                guard let self = self else {return}
                ProgressView.shared.hide()
                if !(result?.success ?? false) {
                    self.khoanVayListView.setDefault(numberImg: number)
                    self.showAlert(result?.message ?? "")
                }
            }, failure: {[weak self] error in
                guard let self = self else {return}
                ProgressView.shared.hide()
                self.showAlert(error.localizedDescription)
            })
            
        }
        
    }
    
    func onClickRadio(radioView: UIView, tag: Int) {
        if tag == 3 || tag == 4 {
            paperType = tag
            gplxRadio.setSelect(isSelect: tag == 3)
            shkRadio.setSelect(isSelect: tag == 4)
            gplxView.isHidden = paperType == 4
            shkStack.isHidden = paperType == 3
        }
    }
}
