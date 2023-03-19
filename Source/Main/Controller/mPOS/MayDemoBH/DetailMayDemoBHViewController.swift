//
//  DetailMayDemoBHViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 5/12/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DetailMayDemoBHViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var parentNavigationController : UINavigationController?
    var itemProductDemo: ProductDemoBH?
    var listError = [ErrorItemMayDemoBH]()
    var arrImgCheckView = [UIImageView]()
    var listImg = [ImageMayDemoBH]()
    var listImgThucTe = [ImageMayDemoBH]()
    var viewContentImg:UIView!
    var arrViewContentImgPhoto = [UIView]()
    var imagePicker = UIImagePickerController()
    var posImageUpload:Int = -1
    var listErrorIDChoosed = [String]()
    var listErrorNameChoosed = [String]()
    var arrImg = [ItemMayDemoBHImage]()
    var btnUpdate: UIButton!
    var numOfImgThucTe:Int = 0
    var isMayDemo = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(self.itemProductDemo?.item_name ?? "Cập nhật sản phẩm Demo")"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Products_Demo_Warrant_Product_Type_ImageAndError(type_item: "\(self.itemProductDemo?.type_item ?? "")") { (rsImg, rsErr, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        self.listError = rsErr
                        self.listImg = rsImg
                        for itemHinhMau in rsImg {
                            self.arrImg.append(ItemMayDemoBHImage(imgMau: itemHinhMau, imgThucTe: ""))
                        }
                        self.getDetail()
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func getDetail() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Products_Demo_Warranty_Product_GetDetailsItem(id: "\(self.itemProductDemo?.id ?? 0)") { (rsImgThucTe, listIDError, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        self.itemProductDemo?.listIDError = listIDError
                        if rsImgThucTe.count > 0 {
                            self.listImgThucTe = rsImgThucTe
                            if rsImgThucTe.count < self.arrImg.count {
                                self.numOfImgThucTe = self.arrImg.count - rsImgThucTe.count
                                for _ in 0..<self.numOfImgThucTe { // tạo đủ sl img trường hợp thiếu ảnh thực tế
                                    self.listImgThucTe.append(ImageMayDemoBH(type_image: 0, label: "", urlimage: "", urlDetailImgThucTe: ""))
                                }
                            }
                        }
                        self.setUpView()
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func setUpView() {
        //update list error check
        let listErrID = self.itemProductDemo?.listIDError ?? ""
        if !(listErrID.isEmpty) {
            self.listErrorIDChoosed = listErrID.components(separatedBy: ",")
            if self.listErrorIDChoosed.count > 0 {
                for err in self.listError {
                    for errCheck in self.listErrorIDChoosed {
                        if err.code == errCheck {
                            err.isCheck = true
                        }
                    }
                }
            }
        }
        
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let updateImageView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s: 40)))
        updateImageView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        scrollView.addSubview(updateImageView)
        
        let lbUpdateImageTitle = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: updateImageView.frame.width - Common.Size(s: 30), height: updateImageView.frame.height))
        lbUpdateImageTitle.text = "HÌNH ẢNH SẢN PHẨM"
        lbUpdateImageTitle.font = UIFont.systemFont(ofSize: 15)
        updateImageView.addSubview(lbUpdateImageTitle)
        
        //imgview
        let imgWidth = (scrollView.frame.width - Common.Size(s: 20))/2
        let imgHeight = imgWidth - Common.Size(s: 30)
        
        viewContentImg = UIView(frame: CGRect(x: 0, y: updateImageView.frame.origin.y + updateImageView.frame.height + Common.Size(s: 15), width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewContentImg.backgroundColor = .white
        scrollView.addSubview(viewContentImg)
        
        self.arrViewContentImgPhoto.removeAll()
        for i in 0..<self.arrImg.count {
            let itemImg = self.arrImg[i].imgMau
            
            let viewHinhMau = UIView(frame: CGRect(x: 0, y: (CGFloat(i) * (imgHeight + Common.Size(s: 35))), width: scrollView.frame.width, height: imgHeight + Common.Size(s: 35)))
            viewHinhMau.backgroundColor = .white
            viewContentImg.addSubview(viewHinhMau)
            
            let lbImgTitle = UILabel(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 20), height: Common.Size(s: 20)))
            lbImgTitle.text = "\(i + 1). \(itemImg.label)"
            lbImgTitle.font = UIFont.systemFont(ofSize: 15)
            viewHinhMau.addSubview(lbImgTitle)
            
            //hinh mau
            let imgMau = UIImageView(frame: CGRect(x: Common.Size(s: 10), y: lbImgTitle.frame.origin.y + lbImgTitle.frame.height + Common.Size(s: 5), width: imgWidth, height: imgHeight))
            Common.encodeURLImg(urlString: "\(itemImg.urlimage)", imgView: imgMau)
            viewHinhMau.addSubview(imgMau)
            
            //hinh chup
            let imgViewPhoto = UIView(frame: CGRect(x: imgMau.frame.origin.x + imgMau.frame.width + Common.Size(s: 5), y: imgMau.frame.origin.y, width: imgWidth, height: imgHeight))
            imgViewPhoto.backgroundColor = .white
            imgViewPhoto.layer.borderColor = UIColor.lightGray.cgColor
            imgViewPhoto.layer.borderWidth = 1
            imgViewPhoto.tag = i + 1
            viewHinhMau.addSubview(imgViewPhoto)
            
            let imgPhoto = UIImageView(frame: CGRect(x: 0, y: 0, width: imgViewPhoto.frame.width, height: imgViewPhoto.frame.height))
            imgPhoto.image = #imageLiteral(resourceName: "UploadImage")
            imgPhoto.contentMode = .scaleAspectFit
            imgViewPhoto.addSubview(imgPhoto)
            
            let tapTakePhoto = UITapGestureRecognizer(target: self, action: #selector(takeImg(_:)))
            imgViewPhoto.isUserInteractionEnabled = true
            imgViewPhoto.addGestureRecognizer(tapTakePhoto)
            
            //update img da cap nhat
            if self.listImgThucTe.count > 0 {
                let itemImgThucTe = self.listImgThucTe[i]
                Common.encodeURLImg(urlString: "\(itemImgThucTe.urlDetailImgThucTe)", imgView: imgPhoto)
            }
            
            self.arrViewContentImgPhoto.append(imgViewPhoto)
        }
        
        let viewContentImgHeight:CGFloat = CGFloat((self.listImg.count)) * (imgHeight + Common.Size(s: 35))
        viewContentImg.frame = CGRect(x: viewContentImg.frame.origin.x, y: viewContentImg.frame.origin.y, width: viewContentImg.frame.width, height: viewContentImgHeight)
        
        //loai loi
        let errorView = UIView(frame: CGRect(x: 0, y: viewContentImg.frame.origin.y + viewContentImgHeight, width: scrollView.frame.width, height: Common.Size(s: 40)))
        errorView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        scrollView.addSubview(errorView)

        let lbErrorViewTitle = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: errorView.frame.width - Common.Size(s: 30), height: errorView.frame.height))
        lbErrorViewTitle.text = "LOẠI LỖI"
        lbErrorViewTitle.font = UIFont.systemFont(ofSize: 15)
        errorView.addSubview(lbErrorViewTitle)

        let detailErrorView = UIView(frame: CGRect(x: 0, y: errorView.frame.origin.y + errorView.frame.height, width: scrollView.frame.width, height: Common.Size(s:40)))
        scrollView.addSubview(detailErrorView)
        
        var xPoint: CGFloat = 0
        var yPoint: CGFloat = 0
        
        self.arrImgCheckView.removeAll()
        for i in 1...self.listError.count {
            let item = self.listError[i - 1]

            if i % 2 != 0 {//trái
                let n:Int = i/2
                xPoint = Common.Size(s:15)
                yPoint = Common.Size(s:30) * CGFloat(n + 1)

            } else { //phải
                xPoint = detailErrorView.frame.width/2 + Common.Size(s:7)
                yPoint = Common.Size(s:30) * CGFloat(i/2)
            }

            let itemView = UIView(frame: CGRect(x: xPoint, y: yPoint, width: (detailErrorView.frame.width - Common.Size(s:15))/2, height: Common.Size(s:30)))
            detailErrorView.addSubview(itemView)

            let imgCheck = UIImageView(frame: CGRect(x: 0, y: itemView.frame.height/2 - Common.Size(s: 10), width: Common.Size(s:20), height: Common.Size(s:20)))
            itemView.addSubview(imgCheck)
            
            if item.isCheck {
                imgCheck.image = #imageLiteral(resourceName: "check-1-1")
            } else {
                imgCheck.image = #imageLiteral(resourceName: "check-2-1")
            }
            self.arrImgCheckView.append(imgCheck)
            imgCheck.tag = i
            let tapCheckError = UITapGestureRecognizer(target: self, action: #selector(chooseErrorType(_:)))
            imgCheck.isUserInteractionEnabled = true
            imgCheck.addGestureRecognizer(tapCheckError)
            

            let lbErrorNameX:CGFloat = imgCheck.frame.origin.x + imgCheck.frame.width + Common.Size(s: 5)
            let lbErrorName = UILabel(frame: CGRect(x: lbErrorNameX, y: imgCheck.frame.origin.y, width: itemView.frame.width - lbErrorNameX, height: Common.Size(s:20)))
            lbErrorName.text = "\(item.label)"
            lbErrorName.font = UIFont.systemFont(ofSize: 14)
            itemView.addSubview(lbErrorName)
        }
        let detailErrorViewHeight:CGFloat = ((CGFloat((listError.count)/2) + 1) * Common.Size(s:30)) + Common.Size(s:15)

        detailErrorView.frame = CGRect(x: detailErrorView.frame.origin.x, y: detailErrorView.frame.origin.y, width: detailErrorView.frame.width, height: detailErrorViewHeight)
        
        btnUpdate = UIButton(frame: CGRect(x: Common.Size(s:15), y: detailErrorView.frame.origin.y +  detailErrorViewHeight + Common.Size(s:30), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:40)))
        btnUpdate.layer.cornerRadius = 5
        btnUpdate.backgroundColor = UIColor(red: 76/255, green: 162/255, blue: 113/255, alpha: 1)
        btnUpdate.setTitle("CẬP NHẬT", for: .normal)
        btnUpdate.addTarget(self, action: #selector(update), for: .touchUpInside)
        scrollView.addSubview(btnUpdate)
        
        if (self.itemProductDemo?.warranty_code == "") {
            if self.listErrorIDChoosed.contains("1") || (self.listErrorIDChoosed.count == 0) {
                self.btnUpdate.setTitle("CẬP NHẬT", for: .normal)
            } else {
                self.btnUpdate.setTitle("TẠO PHIẾU BẢO HÀNH", for: .normal)
            }
        } else { // dat tao phieu bao hanh
            if (self.itemProductDemo?.status_code == "C") { // da cap nhat
                self.btnUpdate.isHidden = true
            }
        }
        
        scrollViewHeight = btnUpdate.frame.origin.y + btnUpdate.frame.height + ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) + Common.Size(s:30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    @objc func takeImg(_ sender: UITapGestureRecognizer) {
        let view:UIView = sender.view!
        let tag = view.tag
        debugPrint("img_\(tag)")
        self.posImageUpload = tag
        self.openCamera()
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name.init("didEnter_mayDemoBH"), object: nil)
    }

    @objc func chooseErrorType(_ sender: UITapGestureRecognizer) {
        let imgView:UIImageView = sender.view! as! UIImageView
        let item = self.listError[imgView.tag - 1]
        item.isCheck = !item.isCheck
        
        if item.isCheck {
            if item.code == "1" { // khôg lỗi
                self.btnUpdate.setTitle("CẬP NHẬT", for: .normal)
                for i in 0..<self.listError.count {
                    self.listError[i].isCheck = false
                    self.arrImgCheckView[i].image = #imageLiteral(resourceName: "check-2-1")
                }
                self.listErrorIDChoosed.removeAll()
                item.isCheck = true
                let indexItemNoError = self.listError.firstIndex(of: item) ?? 0
                self.arrImgCheckView[indexItemNoError].image = #imageLiteral(resourceName: "check-1-1")
                self.listErrorIDChoosed.append(item.code)
            } else {
                //remove item 1 /khôg lỗi
                self.btnUpdate.setTitle("TẠO PHIẾU BẢO HÀNH", for: .normal)
                imgView.image = #imageLiteral(resourceName: "check-1-1")
                self.listError[0].isCheck = false
                self.arrImgCheckView[0].image = #imageLiteral(resourceName: "check-2-1")
                if self.listErrorIDChoosed.count > 0 {
                    self.listErrorIDChoosed.removeAll(where: {$0 == "1"})
                    self.listErrorIDChoosed.removeAll(where: {$0 == "\(item.code)"})
                    self.listErrorIDChoosed.append(item.code)
                } else {
                    self.listErrorIDChoosed.append(item.code)
                }
            }
        } else {
            imgView.image = #imageLiteral(resourceName: "check-2-1")
            if self.listErrorIDChoosed.count > 0 {
                self.listErrorIDChoosed.removeAll(where: {$0 == "\(item.code)"})
            }
        }
    }
    
    func setImage(image:UIImage, viewContent: UIView) -> String {
        viewContent.subviews.forEach { $0.removeFromSuperview() }
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: viewContent.frame.width, height: viewContent.frame.height))
        imgView.contentMode = .scaleAspectFit
        imgView.image = image
        viewContent.addSubview(imgView)
        let imageData:NSData = image.jpegData(compressionQuality: 0.7)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
        return strBase64
    }
    
    func updateImgThucTe(strBase64: String, indexImg: Int) {
        let newViewController = LoadingViewController()
        newViewController.content = "Đang xử lý ảnh..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        
        MPOSAPIManager.Products_Demo_Upload_Image_May_Demo(itemcode: "\(self.itemProductDemo?.item_code ?? "")", base64: strBase64, type_image: "\(self.arrImg[indexImg].imgMau.type_image)") { (success, urlString, err) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            NotificationCenter.default.post(name: Notification.Name("dismissLoading"), object: nil)
                if err.count <= 0 {
                    if success {
                        self.arrImg[indexImg].imgThucTe = urlString
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "Upload ảnh thất bại!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func update() {
        for item in self.arrImg {
            if item.imgThucTe.isEmpty {
                let alert = UIAlertController(title: "Thông báo", message: "Bạn phải cập nhật tất cả hình ảnh!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        
        if self.listErrorIDChoosed.count == 0 {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa chọn lỗi cho sản phẩm!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        } else {
            self.listErrorNameChoosed.removeAll()
            for item in self.listError {
                for errID in self.listErrorIDChoosed {
                    if item.code == errID {
                        self.listErrorNameChoosed.append(item.label)
                    }
                }
            }
        }
        
        var str = ""
        for item in self.arrImg {
            str = str + "<item " + "type_image=" + "\"\(item.imgMau.type_image)\"" + " url_image=" + "\"\(item.imgThucTe)\"" + "/>"
        }
        let xmlString = "<line>" + str + "</line>"
        let listErrString = self.listErrorIDChoosed.joined(separator: ",")
        let listErrName = self.listErrorNameChoosed.joined(separator: ", ")
        
        if self.listErrorIDChoosed.contains("1") { // neu check không lỗi => update
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.Products_Demo_Warranty_Update(id: "\(self.itemProductDemo?.id ?? 0)", xmlimage: xmlString, list_type_error: listErrString, warranty_code: "") { (rsCode, msg, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if err.count <= 0 {
                            if rsCode == 1{
                                let alert = UIAlertController(title: "Thông báo", message: "\(msg)", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                    self.parentNavigationController?.popViewController(animated: true)
                                }
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                let alert = UIAlertController(title: "Thông báo", message: "\(msg)", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            }
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        } else { // tick chọn những lỗi khác => chuyen qua tao phieu bao hanh
            let vc = BaoHanhTaoPhieuMainController()
            vc.itemMayDemo = self.itemProductDemo
            vc.isMayDemo = true
            vc.listErrorIDMayDemoString = listErrString
            vc.errorNameMayDemoBH = listErrName
            vc.xmlImgMayDemo = xmlString
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension DetailMayDemoBHViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
        
        picker.dismiss(animated: true, completion: nil)
        let strBase64 = self.setImage(image: image, viewContent: self.arrViewContentImgPhoto[posImageUpload - 1])
        self.updateImgThucTe(strBase64: strBase64, indexImg: posImageUpload - 1)
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

class ItemMayDemoBHImage {
    var imgMau: ImageMayDemoBH
    var imgThucTe: String
    
    init(imgMau: ImageMayDemoBH, imgThucTe: String) {
        self.imgMau = imgMau
        self.imgThucTe = imgThucTe
    }
}
