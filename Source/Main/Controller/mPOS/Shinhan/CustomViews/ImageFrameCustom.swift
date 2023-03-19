//
//  ImageFrameCustom.swift
//  IOSStoryborad
//
//  Created by Ngoc Bao on 06/12/2021.
//

import UIKit


// hidden title height  = 150
// title height += 20
// if subtitle height += 40
// bottom des height += 30
protocol ImageFrameCustomDelegate {
    func didPickImage(_ view: ImageFrameCustom,image: UIImage,isLeft: Bool)
}
@IBDesignable
class ImageFrameCustom: UIView {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var leftDescription: UILabel!
    
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var rightDescriplabel: UILabel!
    @IBOutlet weak var stackRightImg: UIStackView!
    
    @IBOutlet weak var resultLeftImg: UIImageView!
    @IBOutlet weak var resultRightImg: UIImageView!
    @IBOutlet weak var leftResultView: UIView!
    @IBOutlet weak var leftPlaceholderView: UIView!
    @IBOutlet weak var rightResultView: UIView!
    @IBOutlet weak var RightPlaceholderView: UIView!
    
    var imagePicker = UIImagePickerController()
    var controller: UIViewController!
    var selectedTag = 0
    var delegate: ImageFrameCustomDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func commonInit(){
        let bundle = Bundle(for: ImageFrameCustom.self)
        bundle.loadNibNamed("ImageFrameCustom", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBInspectable
    var title: String = "" {
        didSet {
            if !title.isEmpty {
                titleLabel.text = title
            }
        }
    }
    
    @IBInspectable
    var subTitle: String = "" {
        didSet {
            if !subTitle.isEmpty {
                subTitleLabel.isHidden = false
                subTitleLabel.text = subTitle
            }
        }
    }
    
    @IBInspectable
    var hiddenRight: Bool = false {
        didSet {
            if hiddenRight {
                stackRightImg.isHidden = true
            } else {
                stackRightImg.isHidden = false
            }
        }
    }
    
    @IBInspectable
    var allowSelectLibrary: Bool = false

    @IBInspectable
    var allowOpenCamera: Bool = false

    @IBInspectable
    var desLeft: String = "" {
        didSet {
            if !desLeft.isEmpty {
                leftDescription.isHidden = false
                leftDescription.text = desLeft
            }
        }
    }
    
    @IBInspectable
    var desRight: String = "" {
        didSet {
            if !desRight.isEmpty {
                rightDescriplabel.isHidden = false
                rightDescriplabel.text = desRight
            }
        }
    }
    
    @IBInspectable
    var hiddenTitle: Bool = false {
        didSet {
            titleLabel.isHidden = hiddenTitle
        }
    }
    
    
    @IBInspectable
    var placeHolderImg: UIImage? = nil {
        didSet {
            if placeHolderImg != nil {
                leftImage.image = placeHolderImg
                rightImage.image = placeHolderImg
            }
        }
    }
    
    func isUploadedAtleastOneImage() -> Bool {
        if resultLeftImg.image != nil || resultRightImg.image != nil {
            return true
        }
        return false
    }
    
    func openCamera(){
        let alrt  = UIAlertController(title: self.titleLabel.text?.replace("(*)", withString: "").trim() ?? "Chụp ảnh", message: "", preferredStyle: .actionSheet)
        
        let detail = UIAlertAction(title: "Xem ảnh", style: .default) { (action) in
            let popup = DetailImageVC()
            popup.detail = self.selectedTag == 0 ? self.resultLeftImg.image : self.resultRightImg.image
            popup.modalPresentationStyle = .overCurrentContext
            popup.modalTransitionStyle = .crossDissolve
            self.controller.present(popup, animated: true, completion: nil)
        }
        
        let action = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.openCamera(islibrary: false)
        }
        let library = UIAlertAction(title: "Thư viện", style: .default) { (action) in
            self.openCamera(islibrary: true)
        }
        let action3 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        if (selectedTag == 0 && (self.resultLeftImg.image != self.placeHolderImg && self.resultLeftImg.image != nil)) || (selectedTag == 1 && self.resultRightImg.image != self.placeHolderImg && self.resultRightImg.image != nil) {
            alrt.addAction(detail)
        }
        if (selectedTag == 0) && (self.resultLeftImg.image != self.placeHolderImg) && (self.resultLeftImg.image != nil) {
//            alrt.addAction(action)
            if allowOpenCamera {
                alrt.addAction(action)
            }
        } else if (selectedTag == 1) && (self.resultRightImg.image != self.placeHolderImg) && (self.resultRightImg.image != nil) {
            if allowOpenCamera {
                alrt.addAction(action)
            }
        }else {

            alrt.addAction(action)
        }
        if allowSelectLibrary {
            alrt.addAction(library)
        }
        alrt.addAction(action3)
        self.controller.present(alrt, animated: true, completion: nil)
    }
    func setdefault(isLeft: Bool) {
        if isLeft {
            leftPlaceholderView.isHidden = false
            leftResultView.isHidden = true
            resultLeftImg.image = nil
        } else {
            RightPlaceholderView.isHidden = false
            rightResultView.isHidden = true
            resultRightImg.image = nil
        }
    }
    
    func openCamera(islibrary: Bool) {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = islibrary ? UIImagePickerController.SourceType.photoLibrary : UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            self.controller.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.controller.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        selectedTag = sender.tag
        openCamera()
    }
    
    func setimage(image: UIImage, isleft: Bool) {
        if isleft {
            leftPlaceholderView.isHidden = true
            leftResultView.isHidden = false
            resultLeftImg.layer.masksToBounds = true
            resultLeftImg.image = image
        } else {
            RightPlaceholderView.isHidden = true
            rightResultView.isHidden = false
            resultRightImg.layer.masksToBounds = true
            resultRightImg.image = image
        }
    }
    
    
}

extension ImageFrameCustom: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        if selectedTag == 0 {
           setimage(image: image, isleft: true)
           delegate?.didPickImage(self, image: image, isLeft: true)
        } else {
            setimage(image: image, isleft: false)
            delegate?.didPickImage(self, image: image, isLeft: false)
        }
    }
}
