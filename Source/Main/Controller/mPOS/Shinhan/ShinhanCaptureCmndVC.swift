//
//  ShinhanCaptureCmndVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 06/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ShinhanCaptureCmndVC: UIViewController {

    @IBOutlet weak var mattruocImageview: ImageFrameCustom!
    @IBOutlet weak var matsauImageview: ImageFrameCustom!
    
    
    var fontCmnd:ShinhanFontBase?
    var behindCmnd:ShinhanBehindBase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mattruocImageview.controller = self
        mattruocImageview.delegate = self
        mattruocImageview.hiddenRight = true
        matsauImageview.controller = self
        matsauImageview.hiddenRight = true
        matsauImageview.delegate = self
    }
    
    func validate() -> Bool{
        guard let _ = mattruocImageview.resultLeftImg.image else {
            self.showAlert("Bạn vui lòng chụp đủ 2 mặt CMND/CCCD!")
            return false
        }
        
        guard let _ = matsauImageview.resultLeftImg.image else {
            self.showAlert("Bạn vui lòng chụp đủ 2 mặt CMND/CCCD!")
            return false
        }
        return true
    }
    
    func loading(isShow: Bool) {
        let nc = NotificationCenter.default
        if isShow {
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra thông tin..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
        } else {
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
        }
    }
    
    @IBAction func onContinue(_ sender: Any) {
        if validate() {
            let vc = ShinhanInfoCustomerVC()
            ShinhanData.fontCmnd = fontCmnd
            ShinhanData.behindCmnd = behindCmnd
            vc.inforFontCmnd = fontCmnd
            vc.inforBehindCmnd = behindCmnd
            vc.mattruocImage = mattruocImageview.resultLeftImg.image
            vc.matsauImage = matsauImageview.resultLeftImg.image
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func detechFontCmnd(base64: String) {
        loading(isShow: true)
        Provider.shared.shinhan.detechCmndFont(base64: base64, success: {[weak self] result in
            guard let self = self else {return}
            self.loading(isShow: false)
            if result?.success ?? false {
                self.fontCmnd = result
            } else {
                self.mattruocImageview.setdefault(isLeft: true)
                self.showAlert("Không bóc tách được thông tin. Vui lòng chụp rõ ảnh CMND/CCCD!")
            }
        }, failure: { [weak self] error in
            guard let self = self else {return}
            self.loading(isShow: false)
            self.showAlert(error.localizedDescription)
            self.mattruocImageview.setdefault(isLeft: true)
        })
    }
    
    func detechBehindCmnd(base64: String) {
        self.loading(isShow: true)
        Provider.shared.shinhan.detechCmndBehind(base64: base64, success: {[weak self] result in
            guard let self = self else {return}
            self.loading(isShow: false)
            if result?.success ?? false {
                self.behindCmnd = result
            } else {
                self.matsauImageview.setdefault(isLeft: true)
                self.showAlert("Không bóc tách được thông tin. Vui lòng chụp rõ ảnh CMND/CCCD!")
            }
        }, failure: { [weak self] error in
            guard let self = self else {return}
            self.loading(isShow: false)
            self.showAlert(error.localizedDescription)
            self.matsauImageview.setdefault(isLeft: true)
        })
    }
    
}


extension ShinhanCaptureCmndVC: ImageFrameCustomDelegate {
    func didPickImage(_ view: ImageFrameCustom, image: UIImage, isLeft: Bool) {
        if view == mattruocImageview {
            if let imageData:NSData = image.jpegData(compressionQuality: Common.resizeImageScanCMND) as NSData?{
                let base64Str = imageData.base64EncodedString(options: .endLineWithLineFeed)
                self.detechFontCmnd(base64: base64Str)
            }
        } else {
            if let imageData:NSData = image.jpegData(compressionQuality: Common.resizeImageScanCMND) as NSData?{
                let base64Str = imageData.base64EncodedString(options: .endLineWithLineFeed)
                self.detechBehindCmnd(base64: base64Str)
            }
        }
    }
}
