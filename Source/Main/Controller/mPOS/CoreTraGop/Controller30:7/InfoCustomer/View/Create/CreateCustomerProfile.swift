//
//  CreateCustomerProfile.swift
//  QuickCode
//
//  Created by Sang Trương on 14/07/2022.
//

import UIKit
import SwiftyJSON
import SkyFloatingLabelTextField
class CreateCustomerProfile: UIViewController, ImageFrameCustomDelegate {
    var infoCustmer:DetechCMNDModel?
//
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var frontIDCard: ImageFrameCustom!
	@IBOutlet weak var backIDCard: ImageFrameCustom!
	override func viewDidLoad() {
		super.viewDidLoad()
		frontIDCard.controller = self
		frontIDCard.delegate = self
		frontIDCard.hiddenRight = true
		backIDCard.controller = self
		backIDCard.hiddenRight = true
		backIDCard.delegate = self

	}
	//MARK: - API call
    private func addItemUpload(fileName:String,fileType:String) -> [String:Any]{
        var detail = [String:Any]()
        detail["fileType"] = fileType
        detail["fileName"] = fileName
        return detail
    }

    private func detechCMNDN(){
        guard let frontImage = frontIDCard.resultLeftImg.image else { return }
        guard let backImage = backIDCard.resultLeftImg.image else { return }
        let imgData = frontImage.jpegData(compressionQuality: 0.5)!
        let backImg = backImage.jpegData(compressionQuality: 0.5)!
        let parameters = [
            "IdCardFront": imgData,
            "IdCardBack": backImg,
        ]

        loading(isShow: true)

        MultiPartService.detechCMND(media: frontImage,media2: backImage, params: parameters, fileName: "abc", handler: {  [weak self ] result,error in
            guard let self = self else { return }
            if result.idCard == nil {
                self.loading(isShow: false)
                self.showAlertOneButton(title: "Thông báo", with: error, titleButton: "OK")
            }else {
                let vc = DetailCreateCustomer()
                vc.flow = "create"
                CoreInstallMentData.shared.frontImageIDCard = self.frontIDCard.resultLeftImg.image
                CoreInstallMentData.shared.backImageIDCard = self.backIDCard.resultLeftImg.image

                CoreInstallMentData.shared.customerInforFromDetechCMND = self.infoCustmer
                CoreInstallMentData.shared.firstName = self.infoCustmer?.firstName ?? ""
                CoreInstallMentData.shared.middleName = self.infoCustmer?.middleName ?? ""
                CoreInstallMentData.shared.lastName = self.infoCustmer?.lastName ?? ""
                CoreInstallMentData.shared.birthDate = result.birthDate ?? ""
                CoreInstallMentData.shared.idCard = result.idCard ?? ""
                CoreInstallMentData.shared.idCardIssuedBy = result.idCardIssuedBy ?? ""
                CoreInstallMentData.shared.idCardIssuedByCode = result.idCardIssuedByCode ?? ""
                CoreInstallMentData.shared.idCardIssuedDate = result.idCardIssuedDate ?? ""
                CoreInstallMentData.shared.idCardIssuedExpiration = result.idCardIssuedExpiration ?? ""
                CoreInstallMentData.shared.customerInforFromDetechCMND = result

                print( CoreInstallMentData.shared.filePath)
                DispatchQueue.global(qos: .default).async {
                    let dispatchGroup = DispatchGroup()
                    dispatchGroup.enter()
                    DispatchQueue.main.async {
                        self.uploadPhoto(fileName: "IdCardFront", image: frontImage, isFront: true,idcard: result.idCard ?? "")
                        self.uploadPhoto(fileName: "IdCardBack", image: backImage, isFront: false,idcard: result.idCard ?? "")
                    }
                    dispatchGroup.leave()
                    dispatchGroup.wait()
                    DispatchQueue.main.async {
                        self.loading(isShow: false)
                        vc.modelFromDetech = result
                        self.navigationController?.navigationBar.tintColor = .white
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            self.infoCustmer = result



                


        })

    }

    private func uploadPhoto(fileName:String,image:UIImage,isFront:Bool,idcard:String){
        //true = front else == back
        let parameters = [
            "fileType": fileName,
            "idCard": idcard,
        ] as [String : Any] //O
        MultiPartService.uploadPhoto(media: image, params: parameters, fileName: fileName, handler: { result,errer  in
//            print(result)
            if isFront {
                CoreInstallMentData.shared.pathCMNDfront = self.addItemUpload(fileName: Common.PrefixUploadImage + (result.fileName ?? "") , fileType:  (result.fileType ?? "") )
            }else{
                CoreInstallMentData.shared.pathCMNDBack = self.addItemUpload(fileName: Common.PrefixUploadImage + (result.fileName ?? "") , fileType:   (result.fileType ?? "") )
            }

            print(CoreInstallMentData.shared.pathCMNDfront)
            print(CoreInstallMentData.shared.pathCMNDBack)
            self.loading(isShow: false)
        })
    }
	//MARK: - Selector
	@IBAction func onClickContinue(_ sender: Any) {
		guard validateInputs() else { return }
        detechCMNDN()

	}
	//MARK: - Helpers
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

	private func validateInputs() -> Bool {
		guard frontIDCard.leftPlaceholderView.isHidden == true else {
			showAlertOneButton(
				title: "Thông báo", with: "Bạn vui lòng chụp ảnh CMND mặt trước", titleButton: "OK")
			return false
		}
		guard backIDCard.leftPlaceholderView.isHidden == true else {
			showAlertOneButton(
				title: "Thông báo", with: "Bạn vui lòng chụp ảnh CMND mặt sau", titleButton: "OK")
			return false
		}
		return true
	}
}
extension CreateCustomerProfile {
	func didPickImage(_ view: ImageFrameCustom, image: UIImage, isLeft: Bool) {

	}
}
