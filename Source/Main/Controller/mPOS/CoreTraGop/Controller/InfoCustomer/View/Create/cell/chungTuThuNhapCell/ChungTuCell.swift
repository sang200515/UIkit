//
//  ChungTuCell.swift
//  QuickCode
//
//  Created by Sang Trương on 19/07/2022.
//

import UIKit

class ChungTuCell: UITableViewCell {

	var onCaptureImage: ((UIImage, Int) -> Void)?
	var indexPath = 0

	@IBOutlet weak var ChungTuView: ImageFrameCustom!
	override func awakeFromNib() {
		super.awakeFromNib()

	}

	func bindCell(mainController: UIViewController, i: Int) {
		ChungTuView.controller = mainController
		ChungTuView.delegate = self
		ChungTuView.hiddenRight = true
		ChungTuView.title = "Ảnh \( i + 1)"
		indexPath = i

	}
	@objc func selectImageIcon() {
		if let capture = onCaptureImage {
			capture(ChungTuView.resultLeftImg.image!, indexPath)
		}
	}
	 func uploadPhoto(fileName: String, image: UIImage) {
                   let parameters =
         [
            "fileType": fileName,
            "idCard": CoreInstallMentData.shared.idCard,
         ] as [String: Any]  //O
         ProgressView.shared.show()
         MultiPartService.uploadPhoto(
            media: image, params: parameters, fileName: fileName,
            handler: { result, errer in
                CoreInstallMentData.shared.listChungTuImage.append((self.addItemUpload(
                    fileName: Common.PrefixUploadImage + (result.fileName ?? ""),
                    fileType: result.fileType ?? "", urlImage: result.urlImage ?? "")))

                ProgressView.shared.hide()
            })
        print( CoreInstallMentData.shared.listChungTuImage)

	}
    private func addItemUpload(fileName: String, fileType: String,urlImage:String) -> [String: Any] {
		var detail = [String: Any]()
		detail["fileType"] = fileType
		detail["fileName"] = fileName
        detail["urlImage"] = urlImage
		return detail
	}

}

extension ChungTuCell: ImageFrameCustomDelegate {
	func didPickImage(_ view: ImageFrameCustom, image: UIImage, isLeft: Bool) {
		if view == ChungTuView {
			print("oke")
			uploadPhoto(fileName: "PROOF_OF_INCOME\(indexPath + 1)", image: ChungTuView.leftImage.image!)
		} else {
			print("ok2e")

		}
	}
}
