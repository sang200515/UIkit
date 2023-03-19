//
//  ListImageView.swift
//  fptshop
//
//  Created by Ngoc Bao on 09/02/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol ListImageViewDelegate {
    func didPickImage(image: UIImage, number: Int)
}

class ListImageView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var fourImage: UIImageView!
    @IBOutlet weak var fiveImage: UIImageView!

    
    var imagePicker = UIImagePickerController()
    var controller: UIViewController!
    var delegate: ListImageViewDelegate?
    var selectedTag = 0
    let defaultImg = UIImage(named: "ic_add_new")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func commonInit(){
        let bundle = Bundle(for: ListImageView.self)
        bundle.loadNibNamed("ListImageView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBInspectable
    var placeHolderImg: UIImage? = nil {
        didSet {
            if placeHolderImg != nil {
                firstImage.image = placeHolderImg
                secondImage.image = placeHolderImg
                thirdImage.image = placeHolderImg
                fourImage.image = placeHolderImg
                fiveImage.image = placeHolderImg
            }
        }
    }
    
    func isUploadedImage() -> Bool {
        if firstImage.image == defaultImg &&  secondImage.image == defaultImg && thirdImage.image == defaultImg && fourImage.image == defaultImg && fiveImage.image == defaultImg {
            return false
        }
        return true
            
    }
    
    func isUploadedAtLeastOneImage() -> Bool {
        if firstImage.image != placeHolderImg || secondImage.image != placeHolderImg || thirdImage.image != placeHolderImg || fourImage.image != placeHolderImg || fiveImage.image != placeHolderImg {
            return true
        }
        return false
            
    }
    
    func setDefault(numberImg: Int) {
        switch numberImg {
        case 0:
            firstImage.image = defaultImg
        case 1:
            secondImage.image = defaultImg
        case 2:
            thirdImage.image = defaultImg
        case 3:
            fourImage.image = defaultImg
        case 4:
            fiveImage.image = defaultImg
        default:
            break
            
        }
    }
    
    @IBAction func onclickAdd(_ sender: UIButton) {
        selectedTag = sender.tag
        openCamera()
    }
    
    func openCamera(){
        let alrt  = UIAlertController(title: "Ảnh CMND/CCCD", message: "", preferredStyle: .actionSheet)
        
        let detail = UIAlertAction(title: "Xem ảnh", style: .default) { (action) in
            let popup = DetailImageVC()
            switch self.selectedTag {
            case 0:
                popup.detail = self.firstImage.image
            case 1:
                popup.detail = self.secondImage.image
            case 2:
                popup.detail = self.thirdImage.image
            case 3:
                popup.detail = self.fourImage.image
            case 4:
                popup.detail = self.fiveImage.image
            default:
                break
            }
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
        if (selectedTag == 0 && self.firstImage.image != self.placeHolderImg) || (selectedTag == 1 && self.secondImage.image != self.placeHolderImg) || (selectedTag == 2 && self.thirdImage.image != self.placeHolderImg) || (selectedTag == 3 && self.fourImage.image != self.placeHolderImg) || (selectedTag == 4 && self.fiveImage.image != self.placeHolderImg){
            alrt.addAction(detail)
        }
        alrt.addAction(action)
        alrt.addAction(library)
        alrt.addAction(action3)
        self.controller.present(alrt, animated: true, completion: nil)
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
    
}

extension ListImageView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        delegate?.didPickImage(image: image, number: selectedTag)
        if selectedTag == 0 {
            firstImage.image = image
        } else if selectedTag == 1 {
            secondImage.image = image
        } else if selectedTag == 2 {
            thirdImage.image = image
        } else if selectedTag == 3 {
            fourImage.image = image
        } else if selectedTag == 4 {
            fiveImage.image = image
        }
    }
}
