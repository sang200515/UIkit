//
//  DetailContentErrorViewController.swift
//  fptshop
//
//  Created by Apple on 6/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown

protocol DetailContentErrorViewControllerDelegate: AnyObject {
    func updateHistoryImgKhacPhuc(detailID:Int, urlImg: String)
}

class DetailContentErrorViewController: UIViewController {
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var tfShopName:UITextField!
    var tfHangMuc:UITextField!
    var tfNDKiemTraText:UITextField!
    var tvDienGiaiLoiText:UITextView!
    var lbHinhAnhGhiNhan:UILabel!
    var imgViewHinhAnhGhiNhan: UIImageView!
    var lbHinhAnhKhacPhuc:UILabel!
    var imgViewHinhAnhKhacPhuc: UIImageView!
    var btnSave: UIButton!
    var imagePicker = UIImagePickerController()
    
    var listContentNhomHangMuc:[ContentNhomHangMuc] = []
    var scoreErrorItem: ScoreError?
    var detailScoreError:DetailScoreError?
    var listContentValue:[String] = []
    var listHangMucName:[String] = []
    var selectedHangMuc:ContentNhomHangMuc!
    var selectedContent:ContentHangMuc!
    var strBase64ImgKhacPhuc = ""
    
    let dropHangMuc = DropDown()
    let dropContent = DropDown()
    
    lazy var dropDownMenus: [DropDown] = {
        return [
            self.dropHangMuc,
            self.dropContent
        ]
    }()
    
    weak var delegate:DetailContentErrorViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "CHẤM ĐIỂM SHOP"
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        self.setUpView()
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        
        let lbShop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbShop.text = "Shop:"
        lbShop.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbShop)
        
        tfShopName = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbShop.frame.origin.y + lbShop.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfShopName.placeholder = "\(scoreErrorItem?.ShopName ?? "")"
        tfShopName.font = UIFont.systemFont(ofSize: 14)
        tfShopName.borderStyle = .roundedRect
        tfShopName.isEnabled = false
        scrollView.addSubview(tfShopName)
        
        let lbHangMuc = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfShopName.frame.origin.y + tfShopName.frame.height + Common.Size(s: 10), width: lbShop.frame.width, height: Common.Size(s: 20)))
        lbHangMuc.text = "Hạng mục:"
        lbHangMuc.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbHangMuc)
        
        tfHangMuc = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbHangMuc.frame.origin.y + lbHangMuc.frame.height + Common.Size(s: 5), width: tfShopName.frame.width, height: Common.Size(s: 35)))
        //        tfHangMuc.placeholder = "Nhập hạng mục"
        tfHangMuc.font = UIFont.systemFont(ofSize: 14)
        tfHangMuc.borderStyle = .roundedRect
        tfHangMuc.text = self.detailScoreError?.GroupName ?? ""
        tfHangMuc.isEnabled = false
        scrollView.addSubview(tfHangMuc)
        
        
        let lbNDKiemtra = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfHangMuc.frame.origin.y + tfHangMuc.frame.height + Common.Size(s: 10), width: lbShop.frame.width, height: Common.Size(s: 20)))
        lbNDKiemtra.text = "Nội dung kiểm tra:"
        lbNDKiemtra.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNDKiemtra)
        
        tfNDKiemTraText = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbNDKiemtra.frame.origin.y + lbNDKiemtra.frame.height + Common.Size(s: 5), width: tfShopName.frame.width, height: Common.Size(s: 35)))
        //        tfNDKiemTraText.placeholder = "Nhập nội dung kiểm tra"
        tfNDKiemTraText.font = UIFont.systemFont(ofSize: 14)
        tfNDKiemTraText.borderStyle = .roundedRect
        tfNDKiemTraText.text = self.detailScoreError?.ContentName ?? ""
        tfNDKiemTraText.isEnabled = false
        scrollView.addSubview(tfNDKiemTraText)
        
        
        let lbDienGiaiLoi = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfNDKiemTraText.frame.origin.y + tfNDKiemTraText.frame.height + Common.Size(s: 10), width: lbShop.frame.width, height: Common.Size(s: 20)))
        lbDienGiaiLoi.text = "Ghi chú:"
        lbDienGiaiLoi.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbDienGiaiLoi)
        
        tvDienGiaiLoiText = UITextView(frame: CGRect(x: Common.Size(s: 15), y: lbDienGiaiLoi.frame.origin.y + lbDienGiaiLoi.frame.height + Common.Size(s: 5), width: tfNDKiemTraText.frame.width, height: Common.Size(s: 70)))
        tvDienGiaiLoiText.font = UIFont.systemFont(ofSize: 14)
        tvDienGiaiLoiText.layer.cornerRadius = 5
        tvDienGiaiLoiText.layer.borderColor = UIColor.lightGray.cgColor
        tvDienGiaiLoiText.layer.borderWidth = 1
        tvDienGiaiLoiText.text = self.detailScoreError?.Content ?? ""
        tvDienGiaiLoiText.isEditable = false
        scrollView.addSubview(tvDienGiaiLoiText)
        
        //hinh anh ghi nhan
        lbHinhAnhGhiNhan = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tvDienGiaiLoiText.frame.origin.y + tvDienGiaiLoiText.frame.height + Common.Size(s: 10), width: lbShop.frame.width, height: Common.Size(s: 20)))
        lbHinhAnhGhiNhan.text = "Hình ảnh ghi nhận:"
        lbHinhAnhGhiNhan.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbHinhAnhGhiNhan)
        
        imgViewHinhAnhGhiNhan = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: lbHinhAnhGhiNhan.frame.origin.y + lbHinhAnhGhiNhan.frame.height + Common.Size(s: 10), width: lbShop.frame.width, height: Common.Size(s: 120)))
        //        imgViewHinhAnhGhiNhan.image = #imageLiteral(resourceName: "Hinhanh")
        imgViewHinhAnhGhiNhan.layer.borderWidth = 1
        imgViewHinhAnhGhiNhan.layer.borderColor = UIColor.lightGray.cgColor
        scrollView.addSubview(imgViewHinhAnhGhiNhan)
        
        
        //hinh anh khac phuc
        lbHinhAnhKhacPhuc = UILabel(frame: CGRect(x: Common.Size(s: 15), y: imgViewHinhAnhGhiNhan.frame.origin.y + imgViewHinhAnhGhiNhan.frame.height + Common.Size(s: 10), width: lbShop.frame.width, height: Common.Size(s: 20)))
        lbHinhAnhKhacPhuc.text = "Hình ảnh khắc phục:"
        lbHinhAnhKhacPhuc.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbHinhAnhKhacPhuc)
        
        imgViewHinhAnhKhacPhuc = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: lbHinhAnhKhacPhuc.frame.origin.y + lbHinhAnhKhacPhuc.frame.height + Common.Size(s: 10), width: lbShop.frame.width, height: Common.Size(s: 120)))
        imgViewHinhAnhGhiNhan.image = #imageLiteral(resourceName: "Hinhanh")
        imgViewHinhAnhKhacPhuc.layer.borderWidth = 1
        imgViewHinhAnhKhacPhuc.layer.borderColor = UIColor.lightGray.cgColor
        scrollView.addSubview(imgViewHinhAnhKhacPhuc)
        
        let tapTakePhoto = UITapGestureRecognizer(target: self, action: #selector(takePhoto))
        imgViewHinhAnhKhacPhuc.isUserInteractionEnabled = true
        imgViewHinhAnhKhacPhuc.addGestureRecognizer(tapTakePhoto)
        
        btnSave = UIButton(frame: CGRect(x: Common.Size(s: 15), y: imgViewHinhAnhKhacPhuc.frame.origin.y + imgViewHinhAnhKhacPhuc.frame.height + Common.Size(s: 40), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnSave.setTitle("LƯU", for: .normal)
        btnSave.titleLabel?.textColor = UIColor.white
        btnSave.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btnSave.layer.cornerRadius = 5
        btnSave.backgroundColor = UIColor(red: 34/255, green: 134/255, blue: 70/255, alpha: 1)
        scrollView.addSubview(btnSave)
        btnSave.addTarget(self, action: #selector(saveImgRequest), for: .touchUpInside)
        
        scrollViewHeight = btnSave.frame.origin.y + btnSave.frame.height + Common.Size(s: 100)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        //set url img

        guard let urlImgFailed = URL(string: "\(detailScoreError?.UrlImgFailed ?? "")") else {
            imgViewHinhAnhGhiNhan.image = #imageLiteral(resourceName: "Hinhanh")
            return
        }
        let data1 = try? Data(contentsOf: urlImgFailed)
        if let imageDataGhiNhan = data1 {
            let imageGhiNhan = UIImage(data: imageDataGhiNhan)
            imgViewHinhAnhGhiNhan.image = imageGhiNhan
        }
        //hinh anh khac phuc

//        var urlImgCompleteString = ""
//        if detailScoreError?.UrlImgComplete.contains(Config.manager.chamDiemUrlImgComplete) == false {
//            urlImgCompleteString = "\(Config.manager.chamDiemUrlImgComplete!)/\(detailScoreError?.UrlImgComplete ?? "")"
//        }
        guard let urlImgComplete = URL(string: "\(detailScoreError?.UrlImgComplete ?? "")") else {
            imgViewHinhAnhKhacPhuc.image = #imageLiteral(resourceName: "Hinhanh")
            return
        }
        let data2 = try? Data(contentsOf: urlImgComplete)
        if let imageDataKhacPhuc = data2 {
            let imageKhacPhuc = UIImage(data: imageDataKhacPhuc)
            imgViewHinhAnhKhacPhuc.image = imageKhacPhuc
        }
        
        ///check JobTitle
        
        if (Cache.user?.JobTitle == "00375") || (Cache.user?.JobTitle == "00701") || (Cache.user?.JobTitle == "00358") || (Cache.user?.JobTitle == "00292") {
            btnSave.isHidden = true
        } else {
            btnSave.isHidden = false
            
            /////
            if self.detailScoreError?.Status == "Chưa up hình" {
                
                imgViewHinhAnhKhacPhuc.image = #imageLiteral(resourceName: "Hinhanh")
                scrollViewHeight = btnSave.frame.origin.y + btnSave.frame.height + Common.Size(s: 100)
                scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
            } else {
                scrollViewHeight = imgViewHinhAnhKhacPhuc.frame.origin.y + imgViewHinhAnhKhacPhuc.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 100)
                scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
                
            }
        }
    }
    
    func setImage(image:UIImage){
        let heightImage:CGFloat = Common.Size(s: 120)
        imgViewHinhAnhKhacPhuc.removeFromSuperview()
        imgViewHinhAnhKhacPhuc = UIImageView(frame: CGRect(x: 0, y: lbHinhAnhKhacPhuc.frame.origin.y + lbHinhAnhKhacPhuc.frame.height + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: heightImage))
        imgViewHinhAnhKhacPhuc.contentMode = .scaleAspectFit
        imgViewHinhAnhKhacPhuc.image = image
        scrollView.addSubview(imgViewHinhAnhKhacPhuc)
        
        let tapTakePhoto = UITapGestureRecognizer(target: self, action: #selector(takePhoto))
        imgViewHinhAnhKhacPhuc.isUserInteractionEnabled = true
        imgViewHinhAnhKhacPhuc.addGestureRecognizer(tapTakePhoto)
        
        btnSave.frame = CGRect(x: btnSave.frame.origin.x, y: imgViewHinhAnhKhacPhuc.frame.origin.y + imgViewHinhAnhKhacPhuc.frame.height + Common.Size(s: 40), width: btnSave.frame.width, height: btnSave.frame.height)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btnSave.frame.origin.y + btnSave.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 40))
        
        let imgHinhAnhKhacPhuc:UIImage = self.resizeImageWidth(image: imgViewHinhAnhKhacPhuc.image!,newWidth: Common.resizeImageWith)!
        let imageData:NSData = (imgHinhAnhKhacPhuc.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
        self.strBase64ImgKhacPhuc = imageData.base64EncodedString(options: .endLineWithLineFeed)
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
    
    
    @objc func showDropHangMuc() {
        self.dropHangMuc.show()
        SetupDropMenus()
    }
    
    @objc func showNDKiemTra() {
        self.dropContent.show()
        SetupDropMenus()
    }
    
    func SetupDropMenus(){
        DropDown.setupDefaultAppearance();
        
        dropDownMenus.forEach {
            $0.cellNib = UINib(nibName: "DropDownCell", bundle: Bundle(for: DropDownCell.self));
            $0.customCellConfiguration = nil;
        }
        
        dropDownMenus.forEach { $0.dismissMode = .onTap; }
        dropDownMenus.forEach { $0.direction = .any; }
        
        //Setup DropMenu anchor point
        dropHangMuc.anchorView = tfHangMuc;
        dropContent.anchorView = tfNDKiemTraText
        DropDown.startListeningToKeyboard();
        
        //Setup datasources
        dropHangMuc.dataSource = listHangMucName;
        dropHangMuc.selectRow(0);
        
        dropContent.dataSource = listContentValue;
        dropContent.selectRow(0);
        
        dropHangMuc.selectionAction = { [weak self] (index, item) in
            self?.listContentNhomHangMuc.forEach{
                if($0.GroupName == item){
                    self?.selectedHangMuc = $0
                    self?.tfHangMuc.text = " \($0.GroupName)"
                }
            }
            self?.listContentValue.removeAll()
            for item in self?.selectedHangMuc.ListContent ?? [] {
                self?.listContentValue.append(item.ContentName)
            }
        }
        
        dropContent.selectionAction = { [weak self] (index, item) in
            self?.selectedHangMuc.ListContent.forEach{
                if($0.ContentName == item){
                    self?.selectedContent = $0
                    self?.tfNDKiemTraText.text = " \($0.ContentName)"
                }
            }
        }
        
    }
    
    @objc func takePhoto() {
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc func saveImgRequest(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Score_UploadImage(Base64String: self.strBase64ImgKhacPhuc, handler: { (resultCode, msg, urlImg, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if resultCode == 1 {
                        debugPrint("urlImg: \(urlImg)")
                        self.delegate?.updateHistoryImgKhacPhuc(detailID: self.detailScoreError?.DetailID ?? 0, urlImg: urlImg)
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        self.showAlert(title: "Thông báo", message: msg)
                    }
                }
            })
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension DetailContentErrorViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
        self.setImage(image: image)
        picker.dismiss(animated: true, completion: nil)
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
