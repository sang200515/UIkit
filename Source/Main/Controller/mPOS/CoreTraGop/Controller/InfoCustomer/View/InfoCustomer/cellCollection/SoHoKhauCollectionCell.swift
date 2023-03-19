//
//  SoHoKhauCollectionCell.swift
//  QuickCode
//
//  Created by Sang Trương on 24/07/2022.
//

import UIKit
import Kingfisher
class SoHoKhauCollectionCell: UICollectionViewCell, ImageFrameCustomDelegate {
    func didPickImage(_ view: ImageFrameCustom, image: UIImage, isLeft: Bool) {

    }
    var viewController:UIViewController?
    @IBOutlet weak var contentImage: ImageFrameCustom!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindCell(item:String,controller:UIViewController,index:Int){
        contentImage.controller = controller
        viewController = controller
        self.setImage(imageFrameCustom: self.contentImage)
        let url = URL(string: item )
        self.contentImage.resultLeftImg.kf.indicatorType = .activity
        self.contentImage.isUserInteractionEnabled = false

        let r = ImageResource(downloadURL: url ?? URL(fileURLWithPath: ""), cacheKey: item)

        self.contentImage.resultLeftImg.kf.setImage(
            with: r, placeholder: UIImage(named: ""),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage,
            ],
            progressBlock: nil
        ) { [weak self] result in
            guard let self = self else { return }
            self.contentImage.isUserInteractionEnabled = true
            switch result {
                case .success(let image):
                    self.setImage(imageFrameCustom: self.contentImage)
                case .failure(let error):
//                    self.viewController?.showAlertOneButton(
//                        title: "Thông báo", with: error.errorDescription ?? "",
//                        titleButton: "OK")
                    print(error)

            }
        }

        contentImage.delegate = controller as? ImageFrameCustomDelegate
        contentImage.title = "trang \(index)"
        CoreInstallMentData.shared.listSHKImageCache[index] = contentImage.resultLeftImg.image ?? UIImage()

    }
    private func setImage(imageFrameCustom: ImageFrameCustom) {
        imageFrameCustom.leftPlaceholderView.isHidden = true
        imageFrameCustom.leftResultView.isHidden = false
        imageFrameCustom.resultLeftImg.layer.masksToBounds = true
    }
}
