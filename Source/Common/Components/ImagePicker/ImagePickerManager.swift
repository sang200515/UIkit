//
//  ImagePicker.swift
//  BaoCaoHinhAnhTrungBay
//
//  Created by Trần Văn Dũng on 09/07/2021.
//

import Foundation
import UIKit

class ImagePickerManager: NSObject, UINavigationControllerDelegate {
    
    var picker = UIImagePickerController()
    var alert : UIAlertController?
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?
    
    override init(){
        super.init()
        self.alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        self.alert?.addAction(cameraAction)
        self.alert?.addAction(galleryAction)
        self.alert?.addAction(cancelAction)
    }
    
    func pickImage(isCamera:Bool?,_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        DispatchQueue.main.async {
            self.pickImageCallback = callback
            self.viewController = viewController
            self.alert?.popoverPresentationController?.sourceView = self.viewController!.view
            switch isCamera {
            case true:
                self.openCamera()
            case false :
                self.openGallery()
            case nil:
                guard let alert = self.alert else {
                    return
                }
                viewController.present(alert, animated: true, completion: nil)
            default:
                break
            }
        }
    }
    func openCamera(){
        guard let alert = alert else {
            return
        }
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
                return controller
            }()
            viewController?.present(alertController, animated: true)
        }
    }
    func openGallery(){
        guard let alert = alert else {
            return
        }
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }
    
    deinit {
        print("ImagePickerManager is Denit Success")
    }
    
}

extension ImagePickerManager : UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        self.pickImageCallback?(image)
        self.alert = nil
    }
    
}
