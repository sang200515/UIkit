//
//  SoHoKhauCell.swift
//  QuickCode
//
//  Created by Sang Trương on 19/07/2022.
//

import Kingfisher
import UIKit

class SoHoKhauCell: UITableViewCell {
	var flow: String = ""
	var onCaptureImage: ((UIImage, Int) -> Void)?
	var indexPath = 0

	@IBOutlet weak var imgSoHoKhau: ImageFrameCustom!
	var controller: UIViewController?
	override func awakeFromNib() {
		super.awakeFromNib()

	}
    override func prepareForReuse() {
        if flow == "edit"{
            super.prepareForReuse()

            imgSoHoKhau.resultLeftImg.kf.cancelDownloadTask()
            imgSoHoKhau.resultLeftImg.kf.setImage(with: URL(string: ""))
            imgSoHoKhau.leftImage.image = UIImage(named: "ic_camera_new")
            imgSoHoKhau.desLeft = "Bấm vào đây để chụp ảnh"
        }else if flow == "create" {
            super.prepareForReuse()
            imgSoHoKhau.resultLeftImg.kf.cancelDownloadTask()
            imgSoHoKhau.resultLeftImg.kf.setImage(with: URL(string: ""))
            imgSoHoKhau.leftImage.image = UIImage(named: "ic_camera_new")
            imgSoHoKhau.desLeft = "Bấm vào đây để chụp ảnh"
            if CoreInstallMentData.shared.listSHKImage[indexPath]["urlImage"] as? String == "" {
                imgSoHoKhau.leftImage.image = UIImage(named: "ic_camera_new")
                imgSoHoKhau.desLeft = "Bấm vào đây để chụp ảnh"

            }

        }
    }
	func bindCell(mainController: UIViewController, index: Int, flow: String) {
        imgSoHoKhau.resultLeftImg.isHidden = true
		imgSoHoKhau.title = "trang \(index + 1 )"
		imgSoHoKhau.controller = mainController
		imgSoHoKhau.delegate = self
		indexPath = index
		self.flow = flow
		controller = mainController
        let item = CoreInstallMentData.shared.listSHKImage[index]
        if item["urlImage"] as? String != ""{
            imgSoHoKhau.resultLeftImg.isHidden = false
            self.setImage(imageFrameCustom: self.imgSoHoKhau)
            let url = URL(string: "\(item["urlImage"] ?? "")")
            self.imgSoHoKhau.resultLeftImg.kf.indicatorType = .activity

            self.imgSoHoKhau.isUserInteractionEnabled = false

            self.imgSoHoKhau.resultLeftImg.kf.setImage(
                with: url, placeholder: UIImage(named: ""),
                options: [
                    .transition(.fade(1)),
                    .cacheOriginalImage,
                ],
                progressBlock: nil
            ) { [weak self] result in
                guard let self = self else { return }
                self.imgSoHoKhau.isUserInteractionEnabled = true
                switch result {
                    case .success(let image):
                        self.setImage(imageFrameCustom: self.imgSoHoKhau)
                    case .failure(let error):
                        print(error)


                }
            }
        }
	}
	func bindCellEdit(itemEdit: [String: Any], mainController: UIViewController, index: Int, flow: String) {
        imgSoHoKhau.resultLeftImg.isHidden = true

		imgSoHoKhau.title = "trang \(index + 1 )"
		imgSoHoKhau.controller = mainController
		imgSoHoKhau.delegate = self
		indexPath = index
		self.flow = flow
		controller = mainController
		if itemEdit["urlImage"] as? String == "" {
		} else {
            self.imgSoHoKhau.resultLeftImg.isHidden = false
            self.setImage(imageFrameCustom: self.imgSoHoKhau)
			let url = URL(string: "\(itemEdit["urlImage"] ?? "")")
            self.imgSoHoKhau.resultLeftImg.kf.indicatorType = .activity
            self.imgSoHoKhau.isUserInteractionEnabled = false
			self.imgSoHoKhau.resultLeftImg.kf.setImage(
				with: url, placeholder: UIImage(named: ""),
				options: [
					.transition(.fade(1)),
					.cacheOriginalImage,
				],
				progressBlock: nil
			) { [weak self] result in
				guard let self = self else { return }
                self.imgSoHoKhau.isUserInteractionEnabled = true
				switch result {
				case .success(let image):
					self.setImage(imageFrameCustom: self.imgSoHoKhau)
				case .failure(let error):
//					mainController.showAlertOneButton(
//						title: "Thông báo", with: error.errorDescription ?? "",
//						titleButton: "OK")
                        print(error)


				}
			}
		}

	}
	private func setImage(imageFrameCustom: ImageFrameCustom) {
		imageFrameCustom.leftPlaceholderView.isHidden = true
		imageFrameCustom.leftResultView.isHidden = false
		imageFrameCustom.resultLeftImg.layer.masksToBounds = true
	}

	@objc func selectImageIcon() {
		if let capture = onCaptureImage {
			capture(imgSoHoKhau.resultLeftImg.image!, indexPath)
		}
	}
	private func uploadPhoto(fileName: String, image: UIImage, ischeck: Bool) {
		var idCard = ""
		if flow == "edit" {
			idCard = CoreInstallMentData.shared.editIdCard
		} else {
			idCard = CoreInstallMentData.shared.idCard
		}
		let parameters =
			[
				"fileType": fileName,
				"idCard": idCard,
			] as [String: Any]  //O

		loading(isShow: true)
		MultiPartService.uploadPhoto(
			media: image, params: parameters, fileName: fileName,
			handler: { [weak self] result, errer in
				guard let self = self else { return }
                self.loading(isShow: false)
                if result.fileType == nil {
                    self.controller?.showAlertOneButton(title: "Thông báo", with: errer , titleButton: "OK")
                }else {
                    if self.flow == "create" {
                        CoreInstallMentData.shared.listSHKImage[self.indexPath] = self.addItemUpload(
                            fileName: result.fileName ?? "", fileType: result.fileType ?? "",
                            urlImage: result.urlImage ?? "")
                    } else {
                        CoreInstallMentData.shared.editListSHKImage[self.indexPath] =
                        self.addItemUpload(
                            fileName: result.fileName ?? "",
                            fileType: result.fileType ?? "",
                            urlImage: result.urlImage ?? "")
                    }
                }
				

			})

	}
	private func addItemUpload(fileName: String, fileType: String, urlImage: String) -> [String: Any] {
		var detail = [String: Any]()
		detail["fileType"] = fileType
		detail["fileName"] = fileName
		detail["urlImage"] = urlImage

		return detail
	}
	func loading(isShow: Bool) {
		let nc = NotificationCenter.default
		if isShow {
			let newViewController = LoadingViewController()
			newViewController.content = "Đang cập nhât thông tin..."
			newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
			newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
			controller?.navigationController?.present(newViewController, animated: true, completion: nil)
		} else {
			nc.post(name: Notification.Name("dismissLoading"), object: nil)
		}
	}

}

extension SoHoKhauCell: ImageFrameCustomDelegate {
	func didPickImage(_ view: ImageFrameCustom, image: UIImage, isLeft: Bool) {
		print(image.debugDescription)
		if view == imgSoHoKhau {
			print("oke")
            imgSoHoKhau.resultLeftImg.isHidden = false
			uploadPhoto(
				fileName: "FB\(indexPath + 1)", image: imgSoHoKhau.resultLeftImg.image!, ischeck: false)
            imgSoHoKhau.leftImage.image = view.resultLeftImg.image
		} else {
			print("ok2e")

		}
	}
}
struct MyIndicator: Indicator {
    let view: UIView = UIView()

    func startAnimatingView() { view.isHidden = false }
    func stopAnimatingView() { view.isHidden = true }

    init() {
        view.backgroundColor = .red
    }
}
