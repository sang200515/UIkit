//
//  CreateHangMucViewController.swift
//  fptshop
//
//  Created by Apple on 6/10/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown
import Kingfisher

class CreateHangMucViewControllerV2: UIViewController {
    
    var scrollView: UIScrollView!
    var tfHangMucText: UITextField!
    var tfNDKiemTraText: UITextField!
    var tfDoiTuongChamText: UITextField!
    var tvDienGiaiLoiText: UITextView!
    var imgViewHinhMau: UIImageView!
    var btnConfirm: UIButton!
    var lbHinhMau: UILabel!
    var scrollViewHeight: CGFloat = 0
    var lbDoiTuongCham: UILabel!
    var lbDienGiaiLoi: UILabel!
    
    //---
    var tableView: UITableView!
    var isChooseObject = false
    var tableviewHeightEstimate:CGFloat = Common.Size(s: 50)
    var listObjectChoose:[DoiTuongChamDiem] = []
    ////-------
    
    var listNhomHangMuc:[NhomHangMuc] = []
    var listObject:[DoiTuongChamDiem] = []
    var listNhomHangMucName:[String] = []
    var arrObjectOfHangMuc:[DoiTuongChamDiem] = []
    
    let dropHangMuc = DropDown()
    var selectedHangMuc: NhomHangMuc!
    var selectedDoiTuong: DoiTuongChamDiem!
    var strBase64ImgMau = ""
    var imagePicker = UIImagePickerController()
    var contentHangMucItem:ContentHangMuc?
    
    lazy var dropDownMenus: [DropDown] = {
        return [
            self.dropHangMuc
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "KHAI BÁO NỘI DUNG CHẤM"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:30), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        ProgressView.shared.show()
            MPOSAPIManager.Score_GetGroupItem(handler: { (results, err) in
                    if results.count > 0 {
                        for item in results {
                            self.listNhomHangMuc.append(item)
                        }
                        for itemNhomHangMuc in self.listNhomHangMuc {
                            self.listNhomHangMucName.append(itemNhomHangMuc.GroupName)
                        }
                    } else {
                        debugPrint("khong lay duoc list nhom hang muc")
                    }
                    
                    MPOSAPIManager.Score_GetListObject(handler: { (results, err) in
                        ProgressView.shared.hide()
                            if results.count > 0 {
                                for item in results {
                                    self.listObject.append(item)
                                }
                            } else {
                                debugPrint("khong lay duoc list doi tuong")
                            }
                            self.setUpView()
                    })
                
            })
        
    }
    
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lbHangMuc = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbHangMuc.text = "Hạng mục:"
        lbHangMuc.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbHangMuc)
        
        tfHangMucText = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbHangMuc.frame.origin.y + lbHangMuc.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfHangMucText.placeholder = "Nhập tên  hạng mục"
        tfHangMucText.font = UIFont.systemFont(ofSize: 14)
        tfHangMucText.borderStyle = .roundedRect
        scrollView.addSubview(tfHangMucText)
        
        let tapShowDropHangMuc = UITapGestureRecognizer(target: self, action: #selector(showDropHangMuc))
        tfHangMucText.isUserInteractionEnabled = true
        tfHangMucText.addGestureRecognizer(tapShowDropHangMuc)
        
        let arrowImgView1 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg1 = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg1.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView1.addSubview(arrowImg1)
        tfHangMucText.rightViewMode = .always
        tfHangMucText.rightView = arrowImgView1
        
        let lbNDKiemTra = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfHangMucText.frame.origin.y + tfHangMucText.frame.height + Common.Size(s: 10), width: lbHangMuc.frame.width, height: Common.Size(s: 20)))
        lbNDKiemTra.text = "Nội dung kiểm tra:"
        lbNDKiemTra.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNDKiemTra)
        
        tfNDKiemTraText = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbNDKiemTra.frame.origin.y + lbNDKiemTra.frame.height + Common.Size(s: 5), width: tfHangMucText.frame.width, height: Common.Size(s: 35)))
        tfNDKiemTraText.placeholder = "Nhập nội dung kiểm tra"
        tfNDKiemTraText.font = UIFont.systemFont(ofSize: 14)
        tfNDKiemTraText.borderStyle = .roundedRect
        scrollView.addSubview(tfNDKiemTraText)
        
        lbDoiTuongCham = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfNDKiemTraText.frame.origin.y + tfNDKiemTraText.frame.height + Common.Size(s: 10), width: lbHangMuc.frame.width, height: Common.Size(s: 20)))
        lbDoiTuongCham.text = "Đối tượng chấm:"
        lbDoiTuongCham.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbDoiTuongCham)
        
        
        //setup tableview doi tuong
        self.setUpTableView()
        
        //        lbDienGiaiLoi = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfDoiTuongChamText.frame.origin.y + tfDoiTuongChamText.frame.height + Common.Size(s: 10), width: lbHangMuc.frame.width, height: Common.Size(s: 20)))
        lbDienGiaiLoi = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tableView.frame.origin.y + tableView.frame.height + Common.Size(s: 10), width: lbHangMuc.frame.width, height: Common.Size(s: 20)))
        lbDienGiaiLoi.text = "Ghi chú:"
        lbDienGiaiLoi.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbDienGiaiLoi)
        
        tvDienGiaiLoiText = UITextView(frame: CGRect(x: Common.Size(s: 15), y: lbDienGiaiLoi.frame.origin.y + lbDienGiaiLoi.frame.height + Common.Size(s: 5), width: lbHangMuc.frame.width, height: Common.Size(s: 70)))
        tvDienGiaiLoiText.font = UIFont.systemFont(ofSize: 14)
        tvDienGiaiLoiText.layer.cornerRadius = 5
        tvDienGiaiLoiText.layer.borderColor = UIColor.lightGray.cgColor
        tvDienGiaiLoiText.layer.borderWidth = 1
        scrollView.addSubview(tvDienGiaiLoiText)
        
        lbHinhMau = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tvDienGiaiLoiText.frame.origin.y + tvDienGiaiLoiText.frame.height + Common.Size(s: 10), width: lbHangMuc.frame.width, height: Common.Size(s: 20)))
        lbHinhMau.text = "Hình mẫu:"
        lbHinhMau.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbHinhMau)
        
        imgViewHinhMau = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: lbHinhMau.frame.origin.y + lbHinhMau.frame.height + Common.Size(s: 10), width: lbHangMuc.frame.width, height: Common.Size(s: 120)))
        imgViewHinhMau.image = #imageLiteral(resourceName: "Hinhanh")
        scrollView.addSubview(imgViewHinhMau)
        
        let tapTakePhoto = UITapGestureRecognizer(target: self, action: #selector(takePhoto))
        imgViewHinhMau.isUserInteractionEnabled = true
        imgViewHinhMau.addGestureRecognizer(tapTakePhoto)
        
        btnConfirm = UIButton(frame: CGRect(x: Common.Size(s: 15), y: imgViewHinhMau.frame.origin.y + imgViewHinhMau.frame.height + Common.Size(s: 40), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnConfirm.setTitle("XÁC NHẬN", for: .normal)
        btnConfirm.titleLabel?.textColor = UIColor.white
        btnConfirm.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btnConfirm.layer.cornerRadius = 5
        btnConfirm.backgroundColor = UIColor(red: 34/255, green: 134/255, blue: 70/255, alpha: 1)
        scrollView.addSubview(btnConfirm)
        btnConfirm.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        
        scrollViewHeight = btnConfirm.frame.origin.y + btnConfirm.frame.height + Common.Size(s: 100)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        if self.contentHangMucItem != nil {
            for i in self.listNhomHangMuc {
                if i.GroupID == contentHangMucItem?.GroupID ?? 0 {
                    self.tfHangMucText.text = i.GroupName
                    self.selectedHangMuc = i
                    
                    //set up list object
                    self.arrObjectOfHangMuc.removeAll()
                    let arrObjectID = i.ListObjectScore.components(separatedBy: ",")
                    for id in arrObjectID {
                        for item in self.listObject {
                            if item.ObjectID == Int(id) {
                                self.arrObjectOfHangMuc.append(item)
                            }
                        }
                    }
                    
                    self.setUpTableView()
                }
            }
            
            //select object
            let arrObjString:[String] = contentHangMucItem?.ObjectID.components(separatedBy: ",") ?? []
            self.listObjectChoose.removeAll()
            for i in arrObjString {
                for j in arrObjectOfHangMuc {
                    if j.ObjectID == Int(i) {
                        self.listObjectChoose.append(j)
                    }
                }
            }
            tableView.reloadData()
            
            tfNDKiemTraText.text = contentHangMucItem?.ContentName ?? ""
            tvDienGiaiLoiText.text = contentHangMucItem?.Content ?? ""
            
            if contentHangMucItem?.UrlImage.contains(".jpg") == false {
                imgViewHinhMau.image = #imageLiteral(resourceName: "Hinhanh")
            } else {
                //set url img
                guard let urlImg = URL(string: "\(contentHangMucItem?.UrlImage ?? "")") else {
                    imgViewHinhMau.image = #imageLiteral(resourceName: "Hinhanh")
                    return
                }
                
                imgViewHinhMau.kf.setImage(
                    with: urlImg,
                    placeholder: UIImage(named: "Hinhanh"),
                    options: [])
                {
                    result in
                    switch result {
                    case .success(_):
                        let image = self.imgViewHinhMau.image
                        self.setImage(image: image ?? UIImage())
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                }
            }
            
        }
        
        //        let tapTakePhoto = UITapGestureRecognizer(target: self, action: #selector(takePhoto))
        //        imgViewHinhMau.isUserInteractionEnabled = true
        //        imgViewHinhMau.addGestureRecognizer(tapTakePhoto)
        
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    func setUpTableView() {
        
        if tableView != nil {
            tableView.removeFromSuperview()
            
            //set up tableview
            self.tableviewHeightEstimate = Common.Size(s: 30) * CGFloat(arrObjectOfHangMuc.count)
            
            tableView = UITableView(frame: CGRect(x: 0, y: lbDoiTuongCham.frame.origin.y + lbDoiTuongCham.frame.height + Common.Size(s: 5), width: scrollView.frame.width, height: self.tableviewHeightEstimate))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.isScrollEnabled = false
            tableView.allowsSelection = false
            tableView.register(ItemCheckCell.self, forCellReuseIdentifier: "itemCheckCell")
            scrollView.addSubview(tableView)
            
            //update UI bottom
            lbDienGiaiLoi.frame = CGRect(x: lbDienGiaiLoi.frame.origin.x, y: tableView.frame.origin.y + tableView.frame.height + Common.Size(s: 15), width: lbDienGiaiLoi.frame.width, height: lbDienGiaiLoi.frame.height)
            
            tvDienGiaiLoiText.frame = CGRect(x: tvDienGiaiLoiText.frame.origin.x, y: lbDienGiaiLoi.frame.origin.y + lbDienGiaiLoi.frame.height + Common.Size(s: 5), width: tvDienGiaiLoiText.frame.width, height: tvDienGiaiLoiText.frame.height)
            
            lbHinhMau.frame = CGRect(x: lbHinhMau.frame.origin.x, y: tvDienGiaiLoiText.frame.origin.y + tvDienGiaiLoiText.frame.height + Common.Size(s: 10), width: lbHinhMau.frame.width, height: lbHinhMau.frame.height)
            
            imgViewHinhMau.frame = CGRect(x: imgViewHinhMau.frame.origin.x, y: lbHinhMau.frame.origin.y + lbHinhMau.frame.height + Common.Size(s: 10), width: imgViewHinhMau.frame.width, height: imgViewHinhMau.frame.height)
            
            btnConfirm.frame = CGRect(x: btnConfirm.frame.origin.x, y: imgViewHinhMau.frame.origin.y + imgViewHinhMau.frame.height + Common.Size(s: 20), width: btnConfirm.frame.width, height: btnConfirm.frame.height)
            
            scrollViewHeight = btnConfirm.frame.origin.y + btnConfirm.frame.height + Common.Size(s: 100)
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        } else {
            
            //set up tableview
            self.tableviewHeightEstimate = Common.Size(s: 30) * CGFloat(arrObjectOfHangMuc.count)
            
            tableView = UITableView(frame: CGRect(x: 0, y: lbDoiTuongCham.frame.origin.y + lbDoiTuongCham.frame.height + Common.Size(s: 5), width: scrollView.frame.width, height: self.tableviewHeightEstimate))
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.isScrollEnabled = false
            tableView.allowsSelection = false
            tableView.register(ItemCheckCell.self, forCellReuseIdentifier: "itemCheckCell")
            scrollView.addSubview(tableView)
        }
    }
    
    @objc func showDropHangMuc() {
        debugPrint("showDropHangMuc")
        self.dropHangMuc.show()
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
        dropHangMuc.anchorView = tfHangMucText;
        DropDown.startListeningToKeyboard();
        
        //Setup datasources
        dropHangMuc.dataSource = listNhomHangMucName;
        //        dropHangMuc.selectRow(0);
        
        dropHangMuc.selectionAction = { [weak self] (index, item) in
            self?.listNhomHangMuc.forEach{
                if($0.GroupName == item){
                    self?.selectedHangMuc = $0
                    self?.tfHangMucText.text = " \($0.GroupName)"
                    
                    //set up list object
                    self?.arrObjectOfHangMuc.removeAll()
                    let arrObjectID = $0.ListObjectScore.components(separatedBy: ",")
                    for id in arrObjectID {
                        for item in self?.listObject ?? [] {
                            if item.ObjectID == Int(id) {
                                self?.arrObjectOfHangMuc.append(item)
                            }
                        }
                    }
                    
                    self?.setUpTableView()
                }
            }
        }
    }
    
    @objc func takePhoto(){
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc func confirm() {
        var arrObjectChooseID: [String] = []
        guard let hangMuc = self.tfHangMucText.text, !hangMuc.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn hạng mục!")
            return
        }
        
        //        guard let doiTuong = self.tfDoiTuongChamText.text, !doiTuong.isEmpty else {
        //            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn đối tượng chịu trách nhiệm!")
        //            return
        //        }
        if self.listObjectChoose.count > 0 {
            arrObjectChooseID.removeAll()
            for item in self.listObjectChoose {
                arrObjectChooseID.append("\(item.ObjectID)")
            }
        } else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa chọn đối tượng chịu trách nhiệm!")
            return
        }
        
        guard let noiDungKiemTra = self.tfNDKiemTraText.text, !noiDungKiemTra.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập nội dung kiểm tra!")
            return
        }
        
        guard let dienGiaiViPham = self.tvDienGiaiLoiText.text, !dienGiaiViPham.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập ghi chú!")
            return
        }
        
        if imgViewHinhMau.image == #imageLiteral(resourceName: "Hinhanh") {
            self.strBase64ImgMau = ""
            self.showAlert(title: "Thông báo", message: "Bạn chưa cung cấp hình mẫu!")
            return
        }
        
        if self.contentHangMucItem == nil {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.Score_CreateContentScore(GroupID: self.selectedHangMuc.GroupID, ContentName: noiDungKiemTra, ObjectID: arrObjectChooseID.joined(separator: ","), ContentBody: dienGiaiViPham, Base64String: self.strBase64ImgMau, handler: { (results, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if results.count > 0{
                            if results[0].Result == 1 {
                                let alertVC = UIAlertController(title: "Thông báo", message: "\(results[0].Message)", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                    self.navigationController?.popViewController(animated: true)
                                })
                                alertVC.addAction(action)
                                self.present(alertVC, animated: true, completion: nil)
                            } else {
                                self.showAlert(title: "Thông báo", message: "\(results[0].Message)")
                            }
                        } else {
                            self.showAlert(title: "Thông báo", message: "\(err)")
                        }
                    }
                })
            }
        } else {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.Score_UpdateContentScore(GroupID: self.selectedHangMuc.GroupID, ContentName: noiDungKiemTra, ObjectID: arrObjectChooseID.joined(separator: ","), ContentBody: dienGiaiViPham, Base64String: self.strBase64ImgMau, ContentID: self.contentHangMucItem?.ContentID ?? 0, handler: { (results, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if results.count > 0{
                            if results[0].Result == 1 {
                                let alertVC = UIAlertController(title: "Thông báo", message: "\(results[0].Message)", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                    self.navigationController?.popViewController(animated: true)
                                })
                                alertVC.addAction(action)
                                self.present(alertVC, animated: true, completion: nil)
                            } else {
                                self.showAlert(title: "Thông báo", message: "\(results[0].Message)")
                            }
                        } else {
                            self.showAlert(title: "Thông báo", message: "\(err)")
                        }
                    }
                })
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func setImage(image:UIImage){
        let heightImage:CGFloat = Common.Size(s: 120)
        //        viewImageCMNDTruoc.subviews.forEach { $0.removeFromSuperview() }
        imgViewHinhMau.removeFromSuperview()
        imgViewHinhMau = UIImageView(frame: CGRect(x: 0, y: lbHinhMau.frame.origin.y + lbHinhMau.frame.height + Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s:30), height: heightImage))
        imgViewHinhMau.contentMode = .scaleAspectFit
        imgViewHinhMau.image = image
        scrollView.addSubview(imgViewHinhMau)
        
        btnConfirm.frame = CGRect(x: btnConfirm.frame.origin.x, y: imgViewHinhMau.frame.origin.y + imgViewHinhMau.frame.height + Common.Size(s: 40), width: btnConfirm.frame.width, height: btnConfirm.frame.height)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btnConfirm.frame.origin.y + btnConfirm.frame.size.height + (navigationController?.navigationBar.frame.size.height ?? 0) + UIApplication.shared.statusBarFrame.height + Common.Size(s: 40))
        
        if let imageMau = imgViewHinhMau.image {
            let imgMau:UIImage = self.resizeImageWidth(image: imageMau,newWidth: Common.resizeImageWith) ?? UIImage()
            let imageData:NSData = (imgMau.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData? ?? NSData())
            self.strBase64ImgMau = imageData.base64EncodedString(options: .endLineWithLineFeed)
        }
        
        let tapTakePhoto = UITapGestureRecognizer(target: self, action: #selector(takePhoto))
        imgViewHinhMau.isUserInteractionEnabled = true
        imgViewHinhMau.addGestureRecognizer(tapTakePhoto)
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
}

extension CreateHangMucViewControllerV2: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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

extension CreateHangMucViewControllerV2: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrObjectOfHangMuc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ItemCheckCell = tableView.dequeueReusableCell(withIdentifier: "itemCheckCell", for: indexPath) as! ItemCheckCell
        let doiTuong = arrObjectOfHangMuc[indexPath.row]
        let list = listObjectChoose.filter({$0.ObjectID == doiTuong.ObjectID})
        if list.count > 0 {
            cell.imgCheck.image = #imageLiteral(resourceName: "check-1")
        }
        cell.objectItem = doiTuong
        cell.setUpCell()
        cell.lbName.text = "\(doiTuong.ObjectName)"
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Common.Size(s: 30)
    }
}

extension CreateHangMucViewControllerV2:ItemCheckCellDelegate {
    func didChooseObject(objectItem: DoiTuongChamDiem, isCheck: Bool) {
        if isCheck {
            if self.listObjectChoose.contains(objectItem) == false {
                self.listObjectChoose.append(objectItem)
            }
        } else {
            if listObjectChoose.count > 0 {
                if self.listObjectChoose.contains(objectItem) == true {
                    listObjectChoose.removeEqualItems(item: objectItem)
                }
            }
        }
    }
}

