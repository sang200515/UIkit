//
//  AddImagePopUp.swift
//  fptshop
//
//  Created by Ngoc Bao on 08/02/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class AddImagePopUp: UIViewController,ListImageViewDelegate {

    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var listImage: ListImageView!
    
    var isCreate = true
    var idCard = ""
    var trackingID = ""
    var descriptionLbl: String = ""
    var onContinue: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listImage.controller = self
        listImage.delegate = self
        blurView.alpha = 0.6
        self.descriptionLabel.text = descriptionLbl
        listImage.firstImage.image = ShinhanData.imageChungtu1 != nil ? ShinhanData.imageChungtu1 : listImage.defaultImg
        listImage.secondImage.image = ShinhanData.imageChungtu2 != nil ? ShinhanData.imageChungtu2 : listImage.defaultImg
        listImage.thirdImage.image = ShinhanData.imageChungtu3 != nil ? ShinhanData.imageChungtu3 : listImage.defaultImg
        listImage.fourImage.image = ShinhanData.imageChungtu4 != nil ? ShinhanData.imageChungtu4 : listImage.defaultImg
        listImage.fiveImage.image = ShinhanData.imageChungtu5 != nil ? ShinhanData.imageChungtu5 : listImage.defaultImg
    }

    @IBAction func onClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onOK(_ sender: Any) {
        if listImage.isUploadedImage() {
            self.dismiss(animated: true) {
                if let onContinue = self.onContinue {
                    onContinue()
                }
            }
        } else {
            self.showAlert("Bạn cần upload ít nhất một ảnh!")
        }
    }
    
    
    func didPickImage(image: UIImage, number: Int) {
        var docID = "10"
        switch number {
        case 0:
            docID = "10"
            ShinhanData.imageChungtu1 = image
        case 1:
            docID = "14"
            ShinhanData.imageChungtu2 = image
        case 2:
            docID = "15"
            ShinhanData.imageChungtu3 = image
        case 3:
            docID = "16"
            ShinhanData.imageChungtu4 = image
        case 4:
            docID = "17"
            ShinhanData.imageChungtu5 = image
        default: break
        }
        if let imageData:NSData = image.jpegData(compressionQuality: 0.1) as NSData?{
            let base64Str = imageData.base64EncodedString(options: .endLineWithLineFeed)
            if isCreate {
                ProgressView.shared.show()
                Provider.shared.shinhan.uploadimage(docID: docID, idCard: idCard, trackingID: trackingID, base64: base64Str, success: {[weak self] result in
                    guard let self = self else {return}
                    ProgressView.shared.hide()
                    if !(result?.success ?? false) {
                        self.listImage.setDefault(numberImg: number)
                        self.showAlert(result?.message ?? "")
                    }
                }, failure: {[weak self] error in
                    guard let self = self else {return}
                    ProgressView.shared.hide()
                    self.showAlert(error.localizedDescription)
                })
            }
        }
    }
}
