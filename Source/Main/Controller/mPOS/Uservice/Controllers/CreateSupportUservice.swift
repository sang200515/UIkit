//
//  CreateSupportUservice.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/14/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class CreateSupportUservice: BaseController {
    
    let stackView = UIStackView()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    let vListGroupFeatures: InputTextFieldView = {
        let view = InputTextFieldView()
        return view
    }()
    
    let vListFeatures: InputTextFieldView = {
        let view = InputTextFieldView()
        return view
    }()
    
    let vInputContentSupport: InputContentSupportView = {
        let view = InputContentSupportView()
        return view
    }()
    
    let collectionView: DynamicCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = DynamicCollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        return cv
    }()
    
    let lbTitleUploadFileImage: UILabel = {
        let label = UILabel()
        label.font = UIFont.regularFontOfSize(ofSize: Constants.TextSizes.size_13)
        label.textColor = .black
        label.text = "Hình ảnh/File đính kèm:"
        return label
    }()
    
    let btnUploadMoreFile: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    let btnCreateTickerUservice: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Constants.COLORS.bold_green
        button.setTitle("TIẾP TỤC", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.makeCorner(corner: 8)
        return button
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let buttonAttribute: [NSAttributedString.Key: Any] = [
        .font: UIFont.italicSystemFont(ofSize: 13),
        .foregroundColor: UIColor.blue,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
    
    private let heightInputTextField: CGFloat = 70.0
    private var listFeatureUservice : [ListFeatureItemPDatum]?
    private var listNameGroupFeatureAfterFiltered: [ListFeatureItemPDatum]?
    private var listNameFeatureAfterFiltered: [ListFeatureItemPDatum]?
    fileprivate var listImage: [UIImage?] = []
    private var filename: String?
    private var formatFile: String?
    private var baseStr64: String = ""
    var heightCollectionViewConstraint: NSLayoutConstraint!
    private var tempPickerImage: [ItemPickerImage] = [ItemPickerImage(nameImage: "img_upload_Image")]
    private var listFileDinhKem: [String] = []
    private var contentSupport: String?
    private var nameListGroupFeatrue: String?
    private var nameListFeature: String?
    
    override func setupViews() {
        super.setupViews()
        self.title = "Hỗ trợ người dùng 87333"
        
        self.view.addSubview(btnCreateTickerUservice)
        btnCreateTickerUservice.myCustomAnchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 8, trailingConstant: 8, bottomConstant: 16, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 40)
        btnCreateTickerUservice.addTarget(self, action: #selector(touchCreateTicket(_:)), for: .touchUpInside)
        
        self.view.addSubview(scrollView)
        // constrain the scroll view to 0-pts on each side
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: btnCreateTickerUservice.topAnchor, constant: -8).isActive = true
        
        scrollView.addSubview(contentView)
        self.contentView.widthAnchor.constraint(equalToConstant: self.view.bounds.size.width).isActive = true
        contentView.myCustomAnchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, bottom: scrollView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //Add and setup stack view
        self.contentView.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.spacing = 10
        
        //constrain stack view to contentView
        stackView.myCustomAnchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 8, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vListGroupFeatures.loadType_listGroupFeatures()
        let heightvListGroup = vListGroupFeatures.heightAnchor.constraint(equalToConstant: heightInputTextField)
        heightvListGroup.isActive = true
        stackView.addArrangedSubview(vListGroupFeatures)
        vListGroupFeatures.inputTextFieldViewDelegate = self
        
        vListFeatures.loadType_features()
        vListFeatures.inputTextFieldViewDelegate = self
        let heightvListFeature = vListFeatures.heightAnchor.constraint(equalToConstant: heightInputTextField)
        heightvListFeature.isActive = true
        stackView.addArrangedSubview(vListFeatures)
        vListFeatures.tfInput.isUserInteractionEnabled = false
        
        vInputContentSupport.inputContentSupportViewDelegate = self
        self.vInputContentSupport.heightAnchor.constraint(equalToConstant: 120).isActive = true
        stackView.addArrangedSubview(vInputContentSupport)
        
        let attributedString = NSMutableAttributedString(string: "Upload thêm file", attributes: buttonAttribute)
        btnUploadMoreFile.setAttributedTitle(attributedString, for: .normal)
        btnUploadMoreFile.addTarget(self, action: #selector(touchAddMoreImage(_:)), for: .touchUpInside)
        
        let vCotainerTitleAddImage = UIView()
        vCotainerTitleAddImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.addArrangedSubview(vCotainerTitleAddImage)
        vCotainerTitleAddImage.addSubview(lbTitleUploadFileImage)
        lbTitleUploadFileImage.myCustomAnchor(top: nil, leading: vListGroupFeatures.leadingAnchor, trailing: self.vListGroupFeatures.trailingAnchor, bottom: nil, centerX: nil, centerY: vCotainerTitleAddImage.centerYAnchor, width: nil, height: nil, topConstant: 8, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        vCotainerTitleAddImage.addSubview(btnUploadMoreFile)
        btnUploadMoreFile.myCustomAnchor(top: nil, leading: nil, trailing: self.vListGroupFeatures.trailingAnchor, bottom: nil, centerX: nil, centerY: vCotainerTitleAddImage.centerYAnchor, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        let heightCollectionView = collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        heightCollectionView.priority = UILayoutPriority(rawValue: 1.0)
        heightCollectionView.isActive = true
        stackView.addArrangedSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RequestImageUserviceCollectionViewCell.self, forCellWithReuseIdentifier: RequestImageUserviceCollectionViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        
    }
    
    override func getData() {
        super.getData()
        getListGroupFeatureUservice()
    }
    
    func loadListImage(image: UIImage) {
        self.listImage.append(image)
        self.collectionView.reloadData()
        viewDidLayoutSubviews()
    }
    
    private func getListGroupFeatureUservice() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            UserviceAPIManager.shared.getListGroupFeatures(completion: {[weak self] (result) in
                guard let strongSelf = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if result.count > 0 {
                        strongSelf.listFeatureUservice = result
                        let dups = strongSelf.listFeatureUservice?.filterDuplicates(includeElement: { (firstItem, secondItem) -> Bool in
                            firstItem.tenNhomChucNang == secondItem.tenNhomChucNang
                        })
                        strongSelf.listNameGroupFeatureAfterFiltered = dups
                        
                    } else {
                        strongSelf.showAlertOneButton(title: "Thông báo Uservice", with: "Không có dữ liệu", titleButton: "Đồng ý")
                    }
                }
            }) { (error) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    self.showAlertOneButton(title: "Thông báo Uservice", with: error, titleButton: "Đồng ý")
                }
            }
        }
        
    }
    
    private func touchAddImage() {
        ImageManager.share.thisIsTheFunctionWeAreCalling(uiView: self)
        ImageManager.share.imageManagerDelegate = self
    }
    
    @objc fileprivate func touchAddMoreImage(_ sender: UIButton) {
        if listImage.count > 4 {
            showAlert(title: "Thông báo Uservice", message: "Chỉ được upload tối đa 5 hình")
        } else {
            touchAddImage()
        }
    }
    
    @objc fileprivate func touchCreateTicket(_ sender: UIButton) {
        guard let tfGroupFeatures = vListGroupFeatures.tfInput.text else {return}
        guard let tfListFeature = vListFeatures.tfInput.text else {return}
        if !tfGroupFeatures.isEmpty && !tfListFeature.isEmpty && contentSupport != nil {
            createTicketSupport()
        } else {
            showPopUp("Vui lòng điền đầy đủ các thông tin", "Thông báo hỗ trợ người dùng 87333", buttonTitle: "Đồng ý")
        }
    }
    
    fileprivate func uploadImage(_ filename: String, _ extensionFile: String, base64: String) {
        guard let user = Cache.user else {return}
        let email = user.Email
        let emailAfterPlist = email.split{$0 == "@"}.map(String.init)
        let name = emailAfterPlist[0]
        guard let token = UserDefaults.standard.getMyInfoToken() else {return}
        
        let params: [String:Any] = [
            "email": name,
            "token": token,
            "fileName": filename,
            "extension_file": extensionFile,
            "content": base64
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                UserviceAPIManager.shared.uploadFileImage(params: params, completion: { [weak self](item, msg) in
                    guard let strongSelf = self else {return}
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        strongSelf.showAlert(title: "Thông báo upload file", message: msg)
                        strongSelf.listFileDinhKem.append(item.fileInfoFileID ?? "")
                        printLog(function: #function, json: strongSelf.listFileDinhKem)
                    }
                    
                }) { (err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        self.showAlert(title: "Thông báo upload file", message: err)
                    }
                }
            }
        }
        
    }
    
    fileprivate func createTicketSupport() {
        guard let user = Cache.user else {return}
        let email = user.Email
        let emailAfterPlist = email.split{$0 == "@"}.map(String.init)
        let name = emailAfterPlist[0]
//        guard let token = UserDefaults.standard.getMyInfoToken() else {return}
        let listFileDinhKemJoined = listFileDinhKem.joined(separator: ",")
//        let shopCode = user.ShopCode
//        let userInside = user.UserName
//        let jobTitle = user.JobTitleName
//        let phoneNumber = user.phonenumber
//        let shopName = user.ShopName
        let date = getDateTimeNow()
        
        let params: [String:Any] = [            
            "email": name,
            "token": name,
            "processKey": "HoTroNguoiDung87333",
            "title": "Hỗ Trợ Nguời Dùng 87333 - \(date)",
            "ticketOwner": name,
            "informedUsers": name,
            "values": "<item><line Name=\"NguoiYeuCauHoTro\" Value=\"\(name)\" /><line Name=\"NhomChucNang\" Value=\"\(nameListGroupFeatrue ?? "")\" /><line Name=\"ChucNang\" Value=\"\(nameListFeature ?? "")\" /><line Name=\"NoiDungCanHoTro\" Value=\"\(contentSupport ?? "")\" /><line Name=\"ListFileDinhKem\" Value=\"\(listFileDinhKemJoined)\" /></item>",
            "fromSystem": "mPOS"
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                UserviceAPIManager.shared.createTicketIPItem(params: params, completion: {[weak self] (result) in
                    guard let strongSelf = self else {return}
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        strongSelf.showPopUp(result, "Thông báo tạo ticket Hỗ trợ người dùng 87333", buttonTitle: "Đồng ý") {
                            strongSelf.navigationController?.popViewController(animated: true)
                        }
                    }
                }) {[weak self] (err) in
                    guard let strongSelf = self else {return}
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        strongSelf.showPopUp(err, "Thông báo tạo ticket Hỗ trợ người dùng 87333", buttonTitle: "Đồng ý") {
                            strongSelf.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
    
    fileprivate func getDateTimeNow() -> String {
        let date = Date.today()
        return date.toString(dateFormat: "dd/mm/YYYY")
    }
    
    private func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    private func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
}

extension CreateSupportUservice: ImageManagerDelegate {
    func imageManagerDelegate_didSeclectedImage(image: Data?) {
        
    }
    
    func imageManagerDelegate_faliToSelectedImage(errorMsg: String?) {
        
    }
    
    func imageManagerDelegate_didSelectedImages(images: [UIImage]) {
        
    }
    
    func imageManagerDelegate_didSelectedImage(images: UIImage, fileName: String, format: String) {
        let imageResize: UIImage = self.resizeImage(image: images,newWidth: Common.resizeImageWith)!
        let imageData: NSData = (imageResize.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
        self.baseStr64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
        self.loadListImage(image: images)
        self.filename = fileName
        self.formatFile = format
        
        self.uploadImage(self.filename ?? "", self.formatFile ?? "", base64: self.baseStr64)
    }
    
    func ImageManagerDelegate_cancelPickerImage() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension CreateSupportUservice: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listImage.isEmpty {
            return tempPickerImage.count
        } else {
            return listImage.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RequestImageUserviceCollectionViewCell.identifier, for: indexPath) as! RequestImageUserviceCollectionViewCell
        
        if listImage.isEmpty {
            let itemPicker = tempPickerImage[indexPath.item]
            cell.loadImage(image: UIImage.init(named: itemPicker.nameImage))
            cell.isUserInteractionEnabled = true
            
        } else {
            let image = listImage[indexPath.item]
            cell.loadImage(image: image)
            cell.isUserInteractionEnabled = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bound = collectionView.bounds
        return CGSize(width: bound.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if listImage.isEmpty {
            touchAddImage()
        }
    }
    
}

extension CreateSupportUservice: InputTextFieldViewDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == self.vListGroupFeatures.tfInput, let list = self.listNameGroupFeatureAfterFiltered, list.count > 0 {
            self.view.endEditing(true)
            let listFeatureGroupName = list.map ({ (item) -> String in
                item.tenNhomChucNang
            })
            ActionSheetStringPicker.show(withTitle: "", rows: listFeatureGroupName, initialSelection: 0, doneBlock: { (picker, index, value) in
                if let item = self.listNameGroupFeatureAfterFiltered?[index] {
                    self.vListGroupFeatures.tfInput.text = item.tenNhomChucNang
                    self.nameListGroupFeatrue = self.vListGroupFeatures.tfInput.text
                    let listFeatureName = self.listFeatureUservice?.filter{$0.tenNhomChucNang == self.vListGroupFeatures.tfInput.text}
                    self.listNameFeatureAfterFiltered = listFeatureName
                    self.vListFeatures.tfInput.isUserInteractionEnabled = true
                }
            }, cancel: { (picker) in
                // Do nothing here
            }, origin: self.vListGroupFeatures)
            return false
        }
        
        if textField == self.vListFeatures.tfInput, let listNameFeature = self.listNameFeatureAfterFiltered, listNameFeature.count > 0 {
            self.view.endEditing(true)
            let listName = listNameFeature.map ({ (item) -> String in
                item.chucNang
            })
            ActionSheetStringPicker.show(withTitle: "", rows: listName, initialSelection: 0, doneBlock: { (picker, index, value) in
                if let item = self.listNameFeatureAfterFiltered?[index] {
                    self.vListFeatures.tfInput.text = item.chucNang
                    self.nameListFeature = self.vListFeatures.tfInput.text
                }
            }, cancel: { (picker) in
                // Do nothing here
            }, origin: self.vListFeatures)
            return false
        }
        return true
    }
}

extension CreateSupportUservice: InputContentSupportViewDelegate {
    func outputContent(_ content: String) {
        self.contentSupport = content
    }
}

struct ItemPickerImage {
    let nameImage: String
}
