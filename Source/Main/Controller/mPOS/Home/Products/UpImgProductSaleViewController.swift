//
//  UpImgProductSaleViewController.swift
//  fptshop
//
//  Created by Apple on 8/26/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

protocol UpImgProductSaleViewControllerDelegate: AnyObject {
    func getListURLImg(arrURLImg: [String])
}

class UpImgProductSaleViewController: UIViewController {
    
    var btnUpImg: UIButton!
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var tableView:UITableView!
    var imagePicker = UIImagePickerController()
    var lastImg: UIImage!
    var lastSelectedIndex:IndexPath?
    var btnUploadImg: UIButton!
    var itemCart: Cart?
    var listStrbase64 = [String]()
    var phoneNumber = ""
    
    weak var delegate:UpImgProductSaleViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Thêm hình"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isTranslucent = false
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        for _ in 0..<itemCart!.quantity {
            listStrbase64.append("")
        }
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: Common.Size(s: 10), width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: CGFloat(itemCart?.quantity ?? 0) * Common.Size(s: 180)))
        tableView.register(UpImgProductSaleCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        scrollView.addSubview(tableView)
        
        btnUploadImg = UIButton(frame: CGRect(x: Common.Size(s: 15), y: tableView.frame.origin.y + tableView.frame.height + Common.Size(s: 15), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnUploadImg.setTitle("UPLOAD HÌNH ẢNH", for: .normal)
        btnUploadImg.backgroundColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        btnUploadImg.layer.cornerRadius = 5
        scrollView.addSubview(btnUploadImg)
        btnUploadImg.addTarget(self, action: #selector(actionUploadImg), for: .touchUpInside)
        
        scrollViewHeight = btnUploadImg.frame.origin.y + btnUploadImg.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func actionUploadImg() {
        var isFullImg = true
        if listStrbase64.count > 0 {
            for str in listStrbase64 {
                if str == "" {
                    isFullImg = false
                    self.showAlert(title: "Thông báo", message: "Bạn chưa up đủ hình!")
                }
            }
            
            if isFullImg {
                let strFullBase64 = self.listStrbase64.joined(separator: ",")
                WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                    MPOSAPIManager.mpos_FRT_UploadImage_Warranty(PhoneNumber: self.phoneNumber, Images: strFullBase64, handler: { [weak self](arrUrl, message, err) in
                        guard let self = self else {return}
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            if arrUrl.count > 0 {
                                
                                let alertVC = UIAlertController(title: "Thông báo", message: "\(message)", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                    //self.itemCart?.listURLImg = arrUrl
                                    for item in Cache.carts{
                                        if self.itemCart?.sku == item.sku{
                                            item.listURLImg = arrUrl
                                        }
                                    }
                                    self.navigationController?.popViewController(animated: true)
                                })
                                alertVC.addAction(action)
                                self.present(alertVC, animated: true, completion: nil)
                                
                                
                            } else {
                                self.showAlert(title: "Thông báo", message: "\(message)")
                            }
                        }
                    })
                }
            }
        }
    }
    
    func resizeImageWidth(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }

}

extension UpImgProductSaleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCart?.quantity ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UpImgProductSaleCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UpImgProductSaleCell
        
        cell.setUpCell()
        cell.lbTitle.text = "Hình \(indexPath.row + 1)"
        
        if self.lastImg != nil {
            
            let heightImage:CGFloat = Common.Size(s: 120)
            cell.imgView.frame = CGRect(x: cell.imgView.frame.origin.x, y: cell.imgView.frame.origin.y, width: cell.imgView.frame.width, height: heightImage)
            cell.imgView.image = self.lastImg
            cell.imgView.contentMode = .scaleAspectFit
            
            let img:UIImage = self.resizeImageWidth(image: cell.imgView.image!,newWidth: Common.resizeImageWith)!
            let imageData:NSData = (img.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
            cell.strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
            
            debugPrint("strBase64: \(cell.strBase64)")
            self.listStrbase64[indexPath.row] = cell.strBase64
            
        } else {
            cell.imgView.image = #imageLiteral(resourceName: "Hinhanh")
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.lastSelectedIndex = indexPath
        thisIsTheFunctionWeAreCalling()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Common.Size(s: 180)
    }
    
}


extension UpImgProductSaleViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
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
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        // image is our desired image
        //        self.setImage(image: image)
        
        picker.dismiss(animated: true, completion: nil)
        self.lastImg = UIImage()
        self.lastImg = image
        self.tableView.reloadRows(at: [self.lastSelectedIndex!], with: UITableView.RowAnimation.automatic)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Open the camera
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.navigationBar.barTintColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}

class UpImgProductSaleCell: UITableViewCell {
    var lbTitle: UILabel!
    var imgView: UIImageView!
    var strBase64 = ""
    var estimateCellHeight: CGFloat = 0
    
    func setUpCell(){
        self.subviews.forEach({$0.removeFromSuperview()})
        
        lbTitle = UILabel(frame: CGRect(x: Common.Size(s: 20), y: Common.Size(s: 5), width: self.frame.width - Common.Size(s: 40), height: Common.Size(s: 20)))
        lbTitle.textAlignment = .center
        lbTitle.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbTitle)
        
        imgView = UIImageView(frame: CGRect(x: Common.Size(s: 20), y: lbTitle.frame.origin.y + lbTitle.frame.height + Common.Size(s: 5), width: lbTitle.frame.width, height: Common.Size(s: 120)))
        imgView.image = #imageLiteral(resourceName: "Hinhanh")
        imgView.contentMode = .scaleAspectFit
        self.addSubview(imgView)
        
    }
}
