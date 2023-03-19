//
//  ImageManager.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/16/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Photos

protocol ImageManagerDelegate: AnyObject {
    func imageManagerDelegate_didSeclectedImage(image: Data?)
    func imageManagerDelegate_faliToSelectedImage(errorMsg: String?)
    func imageManagerDelegate_didSelectedImages(images: [UIImage])
    func imageManagerDelegate_didSelectedImage(images: UIImage, fileName: String, format: String)
    func ImageManagerDelegate_cancelPickerImage()
}

class ImageManager: NSObject {
    static let share = ImageManager()
    var imagePicker = UIImagePickerController()
    weak var imageManagerDelegate: ImageManagerDelegate?
    
    func thisIsTheFunctionWeAreCalling(uiView: UIViewController) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera(uiView: uiView)
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary(uiView: uiView)
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            //            alert.popoverPresentationController?.sourceView = sender
            //            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        uiView.present(alert, animated: true, completion: nil)
    }
    
    public func saveImage(imageName: String, image: UIImage) {
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }
            
        }
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
        
    }
    
    public func getImagePathFromDiskWith(fileName: String) -> URL? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            return imageUrl
        }
        
        return nil
    }
    
    public func loadImageFromDiskWith(fileName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
            
        }
        
        return nil
    }
    
}

extension ImageManager: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedFileName = ""
        guard let image = info[.originalImage] as? UIImage else {
            imageManagerDelegate?.imageManagerDelegate_faliToSelectedImage(errorMsg: "Không có hình ảnh")
            return
        }
        if (picker.sourceType == UIImagePickerController.SourceType.camera) {
            
            let imageName = UUID().uuidString
            ImageManager.share.saveImage(imageName: imageName, image: image)
            let urlImage = ImageManager.share.getImagePathFromDiskWith(fileName: imageName)
            printLog(function: #function, json: urlImage)
            ImageManager.share.imageManagerDelegate?.imageManagerDelegate_didSelectedImage(images: image, fileName: "\(imageName).jpeg", format: "jpeg")
            
        } else if (picker.sourceType == UIImagePickerController.SourceType.photoLibrary) {
            if #available(iOS 11.0, *) {
                if let imageUrl = info[.imageURL] as? URL {
                    selectedFileName = imageUrl.lastPathComponent
                    printLog(function: #function, json: imageUrl)
                    printLog(function: #function, json: selectedFileName)
                    ImageManager.share.imageManagerDelegate?.imageManagerDelegate_didSelectedImage(images: image, fileName: selectedFileName, format: "jpeg")
                    
                }
            } else {
                if let imageURL = info[.referenceURL] as? URL {
                    let result = PHAsset.fetchAssets(withALAssetURLs: [imageURL], options: nil)
                    if let firstObject = result.firstObject {
                        let assetResources = PHAssetResource.assetResources(for: firstObject)
                        guard let fileName = assetResources.first?.originalFilename else { return }
                        selectedFileName = fileName
                        printLog(function: #function, json: imageURL)
                        printLog(function: #function, json: selectedFileName)
                        
                        ImageManager.share.imageManagerDelegate?.imageManagerDelegate_didSelectedImage(images: image, fileName: selectedFileName, format: "jpeg")
                    }
                }
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        imageManagerDelegate?.ImageManagerDelegate_cancelPickerImage()
    }
    
    //MARK: - Open the camera
    func openCamera(uiView: UIViewController){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            uiView.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            uiView.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    
    func openGallary(uiView: UIViewController){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.navigationBar.barTintColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        uiView.present(imagePicker, animated: true, completion: nil)
    }
}
