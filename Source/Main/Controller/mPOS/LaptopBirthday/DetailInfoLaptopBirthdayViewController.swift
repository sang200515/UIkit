//
//  DetailInfoLaptopBirthdayViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 11/12/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DLRadioButton
import Presentr

class DetailInfoLaptopBirthdayViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var radioCMND:DLRadioButton!
    var radioCanCuoc:DLRadioButton!
    var imgViewCMNDMatTruoc: UIView!
    var imgViewCMNDMatSau: UIView!
    
    var tfTenKH: UITextField!
    var tfNgaySinh: UITextField!
    var tfSoCMND: UITextField!
    var tfPhone: UITextField!
    var btnSave: UIButton!
    
    var imagePicker = UIImagePickerController()
    var posImageUpload: Int = 0
    var typeChooseCMND = 1
    var urlImgMatTruoc = ""
    var urlImgMatSau = ""
    var itemCMNDDetect: InfoCustomerByImageIDCard?
    var isCheck : Bool = false
    var imgCheckCamKet: UIImageView!
    let presenter: Presentr = {
        let dynamicType = PresentationType.dynamic(center: ModalCenterPosition.center)
        let customPresenter = Presentr(presentationType: dynamicType)
        customPresenter.backgroundOpacity = 0.3
        customPresenter.roundCorners = true
        customPresenter.dismissOnSwipe = false
        customPresenter.dismissAnimated = false
//        customPresenter.backgroundTap = .noAction
        return customPresenter
    }()
    
    private let calendar: AVCalendarViewController = AVCalendarViewController.calendar
    private var selectedDate: AVDate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let viewChooseCMND = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewChooseCMND.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewChooseCMND)
        
        let lbChooseCMND = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewChooseCMND.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbChooseCMND.text = "CHỌN LOẠI GIẤY TỜ"
        lbChooseCMND.font = UIFont.boldSystemFont(ofSize: 15)
        lbChooseCMND.textColor = UIColor(netHex: 0x109e59)
        viewChooseCMND.addSubview(lbChooseCMND)
        
        radioCMND = createRadioButton(CGRect(x: Common.Size(s: 15), y:viewChooseCMND.frame.origin.y + viewChooseCMND.frame.size.height + Common.Size(s: 10) , width: (scrollView.frame.width - Common.Size(s:30))/2, height: Common.Size(s:15)), title: "CMND", color: UIColor(netHex: 0x109e59));
        radioCMND.isSelected = true
        scrollView.addSubview(radioCMND)
        
        radioCanCuoc = createRadioButton(CGRect(x: radioCMND.frame.origin.x + radioCMND.frame.size.width ,y:radioCMND.frame.origin.y, width: radioCMND.frame.size.width, height: radioCMND.frame.size.height), title: "Căn cước", color: UIColor(netHex: 0x109e59));
        scrollView.addSubview(radioCanCuoc)
        
        let viewCustomerImage = UIView(frame: CGRect(x: 0, y: radioCanCuoc.frame.origin.y + radioCanCuoc.frame.size.height + Common.Size(s:10), width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewCustomerImage.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewCustomerImage)
        
        let lbCustomerImage = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewCustomerImage.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbCustomerImage.text = "HÌNH ẢNH CMND/CĂN CƯỚC KHÁCH HÀNG"
        lbCustomerImage.font = UIFont.boldSystemFont(ofSize: 15)
        lbCustomerImage.textColor = UIColor(netHex: 0x109e59)
        viewCustomerImage.addSubview(lbCustomerImage)
        
        let lbCMNDMatTruoc = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewCustomerImage.frame.origin.y + viewCustomerImage.frame.size.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbCMNDMatTruoc.text = "Mặt trước CMND/Căn cước"
        lbCMNDMatTruoc.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbCMNDMatTruoc)
        
        imgViewCMNDMatTruoc = UIView(frame: CGRect(x: Common.Size(s:15), y: lbCMNDMatTruoc.frame.origin.y + lbCMNDMatTruoc.frame.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:150)))
        imgViewCMNDMatTruoc.backgroundColor = .white
        imgViewCMNDMatTruoc.layer.borderColor = UIColor.lightGray.cgColor
        imgViewCMNDMatTruoc.layer.borderWidth = 1
        imgViewCMNDMatTruoc.tag = 1
        scrollView.addSubview(imgViewCMNDMatTruoc)
        
        let imgPhotoCMNDMatTruoc = UIImageView(frame: CGRect(x: 0, y: 0, width: imgViewCMNDMatTruoc.frame.width, height: imgViewCMNDMatTruoc.frame.height))
        imgPhotoCMNDMatTruoc.image = #imageLiteral(resourceName: "UploadImage")
        imgPhotoCMNDMatTruoc.contentMode = .scaleAspectFit
        imgViewCMNDMatTruoc.addSubview(imgPhotoCMNDMatTruoc)
        
        let tapCMNDMatTruoc = UITapGestureRecognizer(target: self, action: #selector(tapShowImage(sender:)))
        imgViewCMNDMatTruoc.isUserInteractionEnabled = true
        imgViewCMNDMatTruoc.addGestureRecognizer(tapCMNDMatTruoc)
     
        let lbCMNDMatSau = UILabel(frame: CGRect(x: Common.Size(s: 15), y: imgViewCMNDMatTruoc.frame.origin.y + imgViewCMNDMatTruoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbCMNDMatSau.text = "Mặt sau CMND/Căn cước"
        lbCMNDMatSau.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbCMNDMatSau)
        
        imgViewCMNDMatSau = UIView(frame: CGRect(x: Common.Size(s:15), y: lbCMNDMatSau.frame.origin.y + lbCMNDMatSau.frame.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:150)))
        imgViewCMNDMatSau.backgroundColor = .white
        imgViewCMNDMatSau.layer.borderColor = UIColor.lightGray.cgColor
        imgViewCMNDMatSau.layer.borderWidth = 1
        imgViewCMNDMatSau.tag = 2
        scrollView.addSubview(imgViewCMNDMatSau)
        
        let imgPhotoCMNDMatSau = UIImageView(frame: CGRect(x: 0, y: 0, width: imgViewCMNDMatSau.frame.width, height: imgViewCMNDMatSau.frame.height))
        imgPhotoCMNDMatSau.image = #imageLiteral(resourceName: "UploadImage")
        imgPhotoCMNDMatSau.contentMode = .scaleAspectFit
        imgViewCMNDMatSau.addSubview(imgPhotoCMNDMatSau)
        
        let tapCMNDMatSau = UITapGestureRecognizer(target: self, action: #selector(tapShowImage(sender:)))
        imgViewCMNDMatSau.isUserInteractionEnabled = true
        imgViewCMNDMatSau.addGestureRecognizer(tapCMNDMatSau)
        
        let viewCustomerInfo = UIView(frame: CGRect(x: 0, y: imgViewCMNDMatSau.frame.origin.y + imgViewCMNDMatSau.frame.height + Common.Size(s: 10), width: scrollView.frame.width, height: Common.Size(s: 40)))
        viewCustomerInfo.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        scrollView.addSubview(viewCustomerInfo)
        
        let lbCustomerInfo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewCustomerInfo.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lbCustomerInfo.text = "THÔNG TIN KHÁCH HÀNG"
        lbCustomerInfo.font = UIFont.boldSystemFont(ofSize: 15)
        lbCustomerInfo.textColor = UIColor(netHex: 0x109e59)
        viewCustomerInfo.addSubview(lbCustomerInfo)
        
        tfTenKH = UITextField(frame: CGRect(x: Common.Size(s: 15), y: viewCustomerInfo.frame.origin.y + viewCustomerInfo.frame.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:35)))
        tfTenKH.borderStyle = .roundedRect
        tfTenKH.placeholder = "Tên khách hàng"
        tfTenKH.font = UIFont.systemFont(ofSize: 14)
        tfTenKH.addLeftIconTextfield(img: #imageLiteral(resourceName: "user100"))
        scrollView.addSubview(tfTenKH)
        
        tfNgaySinh = UITextField(frame: CGRect(x: Common.Size(s: 15), y: tfTenKH.frame.origin.y + tfTenKH.frame.height + Common.Size(s:8), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:35)))
        tfNgaySinh.borderStyle = .roundedRect
        tfNgaySinh.placeholder = "Ngày sinh"
        tfNgaySinh.font = UIFont.systemFont(ofSize: 14)
        tfNgaySinh.addLeftIconTextfield(img: #imageLiteral(resourceName: "calendar100"))
//        tfNgaySinh.isEnabled = false
        scrollView.addSubview(tfNgaySinh)
        
        let tapShowCalendar = UITapGestureRecognizer(target: self, action: #selector(showCalendar1))
        tfNgaySinh.isUserInteractionEnabled = true
        tfNgaySinh.addGestureRecognizer(tapShowCalendar)
        
        tfSoCMND = UITextField(frame: CGRect(x: Common.Size(s: 15), y: tfNgaySinh.frame.origin.y + tfNgaySinh.frame.height + Common.Size(s:8), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:35)))
        tfSoCMND.borderStyle = .roundedRect
        tfSoCMND.placeholder = "Số CMND/Căn cước"
        tfSoCMND.font = UIFont.systemFont(ofSize: 14)
        tfSoCMND.keyboardType = .numberPad
        tfSoCMND.addLeftIconTextfield(img: #imageLiteral(resourceName: "idcard100"))
        scrollView.addSubview(tfSoCMND)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s: 15), y: tfSoCMND.frame.origin.y + tfSoCMND.frame.height + Common.Size(s:8), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:35)))
        tfPhone.borderStyle = .roundedRect
        tfPhone.placeholder = "Số điện thoại khách hàng"
        tfPhone.font = UIFont.systemFont(ofSize: 14)
        tfPhone.keyboardType = .numberPad
        tfPhone.addLeftIconTextfield(img: #imageLiteral(resourceName: "cellphone100"))
        scrollView.addSubview(tfPhone)
        
        let camKetView = UIView(frame: CGRect(x: Common.Size(s:15), y: tfPhone.frame.origin.y + tfPhone.frame.height + Common.Size(s: 15), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:35)))
        scrollView.addSubview(camKetView)
        
        let lbCamKet = UILabel(frame: CGRect(x: Common.Size(s:35), y: 0, width: camKetView.frame.width - Common.Size(s:35) - Common.Size(s:15), height: Common.Size(s:20)))
        lbCamKet.text = "Shop cam kết thông tin khách hàng hoàn toàn chính xác và chính chủ !!!"
        lbCamKet.font = UIFont(name:"Trebuchet MS",size:16)
        camKetView.addSubview(lbCamKet)
        
        let lbcamKetHeight = lbCamKet.optimalHeight < Common.Size(s:20) ? Common.Size(s:20) : lbCamKet.optimalHeight
        lbCamKet.numberOfLines = 0
        lbCamKet.frame = CGRect(x: lbCamKet.frame.origin.x, y: lbCamKet.frame.origin.y, width: lbCamKet.frame.width, height: lbcamKetHeight)
        
        camKetView.frame = CGRect(x: camKetView.frame.origin.x, y: camKetView.frame.origin.y, width: camKetView.frame.width, height: lbcamKetHeight)
        
        imgCheckCamKet = UIImageView(frame: CGRect(x: 0, y: camKetView.frame.height/2 - Common.Size(s:10), width: Common.Size(s:20), height: Common.Size(s:20)))
        imgCheckCamKet.image = #imageLiteral(resourceName: "check-2-1")
        camKetView.addSubview(imgCheckCamKet)
        
        let tapCheckCamKet = UITapGestureRecognizer(target: self, action: #selector(checkCamKet))
        imgCheckCamKet.isUserInteractionEnabled = true
        imgCheckCamKet.addGestureRecognizer(tapCheckCamKet)
        
        btnSave = UIButton(frame: CGRect(x: Common.Size(s:15), y: camKetView.frame.origin.y + camKetView.frame.height + Common.Size(s:25), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:40)))
        btnSave.layer.cornerRadius = 5
        btnSave.backgroundColor = UIColor(red: 76/255, green: 162/255, blue: 113/255, alpha: 1)
        btnSave.setTitle("LƯU", for: .normal)
        btnSave.addTarget(self, action: #selector(saveInfoBirthday), for: .touchUpInside)
        scrollView.addSubview(btnSave)
        
        scrollViewHeight = btnSave.frame.origin.y + btnSave.frame.height + ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) + Common.Size(s:30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    fileprivate func createRadioButton(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:12));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(UIColor.black, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        return radioButton;
    }
    
    @objc fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioCMND.isSelected = false
            radioCanCuoc.isSelected = false
            switch temp {
            case "CMND":
                radioCMND.isSelected = true
                radioCanCuoc.isSelected = false
                self.typeChooseCMND = 1
                break
            case "Căn cước":
                radioCMND.isSelected = false
                radioCanCuoc.isSelected = true
                self.typeChooseCMND = 2
                break
            default:
                break
            }
        }
    }
    
    @objc func checkCamKet() {
        isCheck = !isCheck
        imgCheckCamKet.image = isCheck ? #imageLiteral(resourceName: "check-1-1") : #imageLiteral(resourceName: "check-2-1")
    }

    @objc func tapShowImage(sender: UIGestureRecognizer) {
        let view = sender.view ?? UIView()
        debugPrint("tagImg_: \(view.tag)")
        self.posImageUpload = view.tag
        self.openCamera()
    }
    
    @objc func showCalendar1() {
        calendar.dateStyleComponents = CalendarComponentStyle(backgroundColor: UIColor(netHex: 0x594166),
                                                              textColor: .white,
                                                              highlightColor: UIColor(netHex: 0x7ec0c4).withAlphaComponent(0.5))
        calendar.yearStyleComponents = CalendarComponentStyle(backgroundColor: UIColor(netHex: 0x594166),
                                                              textColor: .black, highlightColor: .white)
        calendar.monthStyleComponents = CalendarComponentStyle(backgroundColor: UIColor(netHex: 0x2f3c5f),
                                                               textColor: .black,
                                                               highlightColor: UIColor.white)
        calendar.subscriber = { [weak self] (date) in guard let checkedSelf = self else { return }
            if date != nil {
                checkedSelf.selectedDate = date
                let selectedDate = Date(timeIntervalSince1970: TimeInterval(date?.doubleVal ?? 0))
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let str = dateFormatter.string(from: selectedDate)
                self?.tfNgaySinh.text = str
            }
        }
        calendar.preSelectedDate = selectedDate
        self.present(calendar, animated: false, completion: nil)
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
    
    func detectCMNDInfoMatTruoc(strBase64: String) {
        WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang xử lý...") {
            MPOSAPIManager.GetinfoCustomerByImageIDCard(Image_CMND: strBase64, NhaMang: "", Type: "1") { (rs, err) in
                if err.count <= 0 {
                    if rs.count > 0 {
                        self.itemCMNDDetect = rs[0]
                        
                        self.tfTenKH.text = rs[0].FullName
                        self.tfNgaySinh.text = rs[0].Birthday
                        self.tfSoCMND.text = rs[0].CMND
                        
                        let cmndNum = (self.tfSoCMND.text == "") ? "0" : self.tfSoCMND.text
                        self.uploadImage(strBase64: "\(strBase64)", cmndNumber: "\(cmndNum ?? "0")", typeCMNDFace: 1)
                    }
                } else {
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        let alert = UIAlertController(title: "Thông báo", message: "Error detect Cmnd: \(err)", preferredStyle: UIAlertController.Style.alert)
                        let action = UIAlertAction(title: "OK", style: .default) { (_) in
                            let cmndNum = (self.tfSoCMND.text == "") ? "0" : self.tfSoCMND.text
                            self.uploadImage(strBase64: "\(strBase64)", cmndNumber: "\(cmndNum ?? "0")", typeCMNDFace: 1)
                        }
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
            }
        }
    }
    
    func uploadImage(strBase64: String, cmndNumber: String, typeCMNDFace: Int) {
        var fileName = ""
        if typeCMNDFace == 1 { //cmnd mặt trước
            fileName = "MT_\(cmndNumber).jpg"
        } else {
            fileName = "MS_\(cmndNumber).jpg"
        }
        
        debugPrint("fileName: \(fileName)")
        CRMAPIManager.uploadImageUrl(strBase64: strBase64, filename: fileName) { (url, msg, err) in
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if err.count <= 0 {
                    if !(url.isEmpty) {
                        if typeCMNDFace == 1 {
                            self.urlImgMatTruoc = url
                        } else {
                            self.urlImgMatSau = url
                        }
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "upload image thất bại!")", preferredStyle: UIAlertController.Style.alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func saveInfoBirthday() {
        
        if self.urlImgMatTruoc.isEmpty {
            let alert = UIAlertController(title: "Thông báo", message: "Url CMND mặt trước null", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        if self.urlImgMatSau.isEmpty {
            let alert = UIAlertController(title: "Thông báo", message: "Url CMND mặt sau null", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let tenKH = tfTenKH.text, !tenKH.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Tên khách hàng không được trống!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard let cmndNum = tfSoCMND.text, !cmndNum.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "CMND không được trống!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        guard let ngaySinh = tfNgaySinh.text, !ngaySinh.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Ngày sinh không được trống!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard let sdt = tfPhone.text, !sdt.isEmpty else {
            let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại không được trống!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard sdt.count == 10, (sdt.isNumber() == true) else {
            let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại không hợp lệ!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if isCheck == false {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn phải nhấn chọn ô cam kết trước khi lưu thông tin!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        } else {
         
            WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang lưu thông tin...") {
                CRMAPIManager.sp_FRT_Voucher_Birthday_Create(phonenumber: "\(sdt)", idcard: cmndNum, fullname: tenKH, birthday_ocr: "\(self.itemCMNDDetect?.Birthday ?? "")", birthday: "\(ngaySinh)", address: "\(self.itemCMNDDetect?.Address ?? "")", url_mattruoc: self.urlImgMatTruoc, url_matsau: self.urlImgMatSau, typecard: "\(self.typeChooseCMND)", idcard_ocr: "\(self.itemCMNDDetect?.CMND ?? "")") { (rsCode, msg, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if err.count <= 0 {
                            if rsCode == 1 {
                                let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "Lưu thông tin thành công!")", preferredStyle: UIAlertController.Style.alert)
                                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                    self.navigationController?.popViewController(animated: true)
                                }
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "Lưu thông tin thất bại!")", preferredStyle: UIAlertController.Style.alert)
                                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            }
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
}


extension DetailInfoLaptopBirthdayViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        picker.dismiss(animated: true, completion: nil)
        
        switch self.posImageUpload {
        case 1:
            let strbase64MatTruoc = self.setImage(image: image, viewContent: self.imgViewCMNDMatTruoc)
            self.detectCMNDInfoMatTruoc(strBase64: strbase64MatTruoc)
            break
        case 2:
            let strbase64MatSau = self.setImage(image: image, viewContent: self.imgViewCMNDMatSau)
            let cmndNum = (self.tfSoCMND.text == "") ? "0" : self.tfSoCMND.text
            
            WaitingNetworkResponseAlert.PresentWaitingAlertWithContent(parentVC: self, content: "Đang xử lý...") {
                self.uploadImage(strBase64: strbase64MatSau, cmndNumber: "\(cmndNum ?? "0")", typeCMNDFace: 2)
            }
            break
        default:
            break
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
//extension DetailInfoLaptopBirthdayViewController: CalendarViewControllerDelegate {
//    func getDate(dateString: String) {
//        let strFormat = dateString.replace("-", withString: "/")
//        tfNgaySinh.text = strFormat
//    }
//}
