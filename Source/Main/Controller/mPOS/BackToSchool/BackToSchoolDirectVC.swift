//
//  BackToSchoolDirectVC.swift
//  fptshop
//
//  Created by Sang Trương on 14/06/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

enum typeStuden {
	case hssv
	case tsv
	case polyTtechnic
}
class BackToSchoolDirectVC: BaseController {

    @IBOutlet weak var ghtnImg: UIImageView!
    @IBOutlet weak var ghtsImg: UIImageView!
    @IBOutlet weak var preCMNDImg: UIImageView!
    @IBOutlet weak var backCMNDImg: UIImageView!
    @IBOutlet weak var cardStudentImg: UIImageView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var birthdayTxt: UITextField!
    @IBOutlet weak var cmndNumberTxt: UITextField!
    @IBOutlet weak var titlePhoneLabel: UILabel!
    @IBOutlet weak var sdtTxt: UITextField!
    @IBOutlet weak var commitedImg: UIImageView!
    @IBOutlet weak var cmndView: UIView!
    @IBOutlet weak var paperRelateView: UIView!
    @IBOutlet weak var titlePaperLabel: UILabel!
    @IBOutlet weak var shipTypeView: UIView!
    @IBOutlet weak var noteLabel: UILabel!


    @IBOutlet weak var pointView: UIView!
    @IBOutlet weak var studentNumberLbl: UILabel!
    @IBOutlet weak var avarageScoreLbl: UILabel!
    @IBOutlet weak var mathLbl: UILabel!
    @IBOutlet weak var physicLbl: UILabel!
    @IBOutlet weak var vanlbl: UILabel!
    @IBOutlet weak var hoahoclbl: UILabel!
    @IBOutlet weak var ngoainguLbl: UILabel!
    @IBOutlet weak var sinhoclbl: UILabel!
    @IBOutlet weak var sulbl: UILabel!
    @IBOutlet weak var dialbl: UILabel!
    @IBOutlet weak var gdcdlbl: UILabel!

    var studentInfoItem:StudentBTSInfo?
    var detectIDcard: DetectIDCard?
    var tracocItem: CustomerTraCoc?
    var isFromSearch = true
    var idBTS = 0
    var imagePicker = UIImagePickerController()
    var selectedType = 0
    var shipTipe = ""
    var isNewStudent = false
	var isPolytecnic:Bool = false
    var base64PreImg = ""
    var urlPreImg = ""
    var base64BackImg = ""
    var urlBackImg = ""
    var base64OtherImg = ""
    var urlOtherImg = ""
    var phone = ""
    let datePicker = UIDatePicker()
    var isFromModule:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        self.title = isNewStudent ? "ct dành cho tsv tuyển thẳng".uppercased() : "ct dành cho tsv tuyển thẳng".uppercased()
		if isPolytecnic {
			self.title = "Ưu đãi sinh viên FPT Polytechnic"
            self.titlePaperLabel.text = "Hình ảnh thẻ sinh viên FPT Polytechnic"
            self.titlePhoneLabel.text = "Số điện thoại"
            self.shipTypeView.isHidden = true
            self.shipTipe = "0"
		}
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        pointView.isHidden = !isNewStudent
        let btLeftIcon = UIButton.init(type: .custom)
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backAction), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
        if isFromModule {
            sdtTxt.isUserInteractionEnabled = true
        }else {
            sdtTxt.isUserInteractionEnabled = false
        }
        sdtTxt.text = phone

        // add gesture
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(showActionSheet1))
        preCMNDImg.isUserInteractionEnabled = true
        preCMNDImg.addGestureRecognizer(gesture1)

        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(showActionSheet2))
        backCMNDImg.isUserInteractionEnabled = true
        backCMNDImg.addGestureRecognizer(gesture2)

        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(showActionSheet3))
        cardStudentImg.isUserInteractionEnabled = true
        cardStudentImg.addGestureRecognizer(gesture3)
        let shiptype = UserDefaults.standard.string(forKey: "BTSShiptype") ?? ""
        if !isFromSearch {
            if shiptype == "3" || shiptype == "2" {
                shipTypeView.isUserInteractionEnabled = false
                let newType = shiptype == "3" ? 1 : 0
                let newBtn = UIButton()
                newBtn.tag = newType
                deliveyType(newBtn)
            }
            noteLabel.text = "Ghi chú thông tin Sinh viên:\n\(tracocItem?.u_Desc ?? "")"
            nameTxt.text = tracocItem?.u_UCode
        } else {
            noteLabel.isHidden = true
        }


        if isNewStudent {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.BackToSchool_LoadThongTinKHBySBD(SoBaoDanh: self.idBTS , handler: {[weak self] (success, errorMsg, result, err) in
                    guard let strongSelf = self else {return}
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if success == "1" {
                            if result != nil {
                                if result?.Result == 1 || result?.Result == 2 {
                                    strongSelf.studentInfoItem = result
                                    guard let info = strongSelf.studentInfoItem else { return }
                                    strongSelf.studentNumberLbl.text = info.SoBaoDanh
                                    strongSelf.avarageScoreLbl.text = info.DiemTrungBinh

                                    for subject in info.DiemTungMon {
                                        switch subject.TenMH.lowercased() {
                                        case "toan":
                                            strongSelf.mathLbl.text = subject.Diem
                                        case "van":
                                            strongSelf.vanlbl.text = subject.Diem
                                        case "ly":
                                            strongSelf.physicLbl.text = subject.Diem
                                        case "hoa":
                                            strongSelf.hoahoclbl.text = subject.Diem
                                        case "sinh":
                                            strongSelf.sinhoclbl.text = subject.Diem
                                        case "ngoaingu":
                                            strongSelf.ngoainguLbl.text = subject.Diem
                                        case "su":
                                            strongSelf.sulbl.text = subject.Diem
                                        case "dia":
                                            strongSelf.dialbl.text = subject.Diem
                                        case "gdcd":
                                            strongSelf.gdcdlbl.text = subject.Diem
                                        default:
                                            break
                                        }
                                    }
                                } else {
                                    strongSelf.showPopUp(errorMsg, "Thông báo", buttonTitle: "Đồng ý")
                                }

                            } else {
                                debugPrint("Không lấy được data")
                            }
                        } else {
                            strongSelf.showPopUp(errorMsg, "Thông báo", buttonTitle: "Đồng ý")
                        }
                    }
                })
            }

        }
        if shipTipe == "0" {
            self.nameTxt.isUserInteractionEnabled = false
            self.birthdayTxt.isUserInteractionEnabled = false
            self.cmndNumberTxt.isUserInteractionEnabled = false
        }else{
            self.nameTxt.isUserInteractionEnabled = true
            self.birthdayTxt.isUserInteractionEnabled = true
            self.cmndNumberTxt.isUserInteractionEnabled = true
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if shipTipe == "0" {
            self.nameTxt.isUserInteractionEnabled = false
            self.birthdayTxt.isUserInteractionEnabled = false
            self.cmndNumberTxt.isUserInteractionEnabled = false
        }else{
            self.nameTxt.isUserInteractionEnabled = true
            self.birthdayTxt.isUserInteractionEnabled = true
            self.cmndNumberTxt.isUserInteractionEnabled = true
        }
    }

    func saveInfoSt() {
        let saveInfo = "\(nameTxt.text ?? ""),\(birthdayTxt.text ?? "")"
        UserDefaults.standard.setValue(saveInfo, forKey: "BtsStudentInfo")
    }

    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        } else {
            // Fallback on earlier versions
        }
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)

        birthdayTxt.inputAccessoryView = toolbar
        birthdayTxt.inputView = datePicker

    }

    @objc func donedatePicker(){

        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        birthdayTxt.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    @objc func showActionSheet1(){
        openCamera(with: 1)
    }
    @objc func showActionSheet2(){
        openCamera(with: 2)
    }
    @objc func showActionSheet3(){
        openCamera(with: 3)
    }

    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

    func openCamera(with tag: Int){
        selectedType = tag
        let alrt  = UIAlertController(title: "Ảnh CMND/CCCD", message: "", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.openCamera(islibrary: false)
        }
        let _ = UIAlertAction(title: "Thư viện", style: .default) { (action) in
            self.openCamera(islibrary: true)
        }
        let action3 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alrt.addAction(action)
        alrt.addAction(action3)
        self.present(alrt, animated: true, completion: nil)
    }

    func openCamera(islibrary: Bool) {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = islibrary ? UIImagePickerController.SourceType.photoLibrary : UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }


    func didChangeSelect(with Img: UIImageView, isSelect: Bool) {
        Img.image = UIImage(named: isSelect ? "mdi_check_circle_gr_2" : "mdi_check_circle_gr")
    }

    func setImage(image:UIImage) -> String {
        let imageData:NSData = image.jpegData(compressionQuality: 0.7)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
        return strBase64
    }

    func isValidateOK() -> Bool{
        let isShipTypeOK = self.shipTipe != ""
        if !isShipTypeOK {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn phải chọn hình thức giao hàng", titleButton: "Đồng ý")
            return false
        }

        if shipTipe == "0" {
            let isPreImgOK = self.base64PreImg != ""
            if !isPreImgOK {
                self.showAlertOneButton(title: "Thông báo", with: "Bạn phải upload ảnh mặt trước CMND hoặc CCCD", titleButton: "Đồng ý")
                return false
            }

            let isBackOK = self.base64BackImg != ""
            if !isBackOK {
                self.showAlertOneButton(title: "Thông báo", with: "Bạn phải upload ảnh mặt sau CMND hoặc CCCD", titleButton: "Đồng ý")
                return false
            }

            let isOtherOK = self.base64OtherImg != ""
            if !isOtherOK {
                self.showAlertOneButton(title: "Thông báo", with: "Bạn phải upload ảnh chụp giấy tờ liên quan", titleButton: "Đồng ý")
                return false
            }
        }


        guard let name = nameTxt.text, !name.isEmpty else {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn phải nhập tên HS/SV", titleButton: "Đồng ý")
            return false
        }

        guard let birth = birthdayTxt.text, !birth.isEmpty else {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn phải nhập ngày tháng năm sinh", titleButton: "Đồng ý")
            return false
        }

        guard let cmnds = cmndNumberTxt.text, !cmnds.isEmpty else {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn phải nhập số CMND/CCCD", titleButton: "Đồng ý")
            return false
        }

        guard let sdt = sdtTxt.text, !sdt.isEmpty else {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn phải nhập số điện thoại HS/SV", titleButton: "Đồng ý")
            return false
        }

        let iscommittedOK = commitedImg.image == UIImage(named: "mdi_check_circle_gr_2")
        if !iscommittedOK {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn chưa click chọn cam kết", titleButton: "Đồng ý")
            return false
        }

        return true
    }

    func uploadImage(idBTS: Int) {
        let newPreUrl = shipTipe == "1" ? "" : self.urlPreImg
        let backUrl = shipTipe == "1" ? "" : self.urlBackImg
        let otherUrl = shipTipe == "1" ? "" : self.urlOtherImg
        MPOSAPIManager.BackToSchool_UpdateHinhAnh(ID_BackToSchool: idBTS, SBD: "", Url_CMND_MT: newPreUrl, Url_CMND_MS: backUrl, Url_GiayBaoDuThi: otherUrl, handler: { [weak self] (success, errorMsg, mData, err) in
            guard let strongSelf = self else {return}
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if success == "1" {
                    needReload = true
                    let alertVC = UIAlertController(title: "Thông báo", message: errorMsg, preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        self?.saveInfoSt()
                        for controller in (self?.navigationController!.viewControllers)! as Array {
                            if controller.isKind(of: PaymentViewController.self) {
                                _ = self?.navigationController?.popToViewController(controller, animated: true)
                            }
                        }
                    })
                    alertVC.addAction(action)
                    strongSelf.present(alertVC, animated: true, completion: nil)
                } else {
                    strongSelf.showAlertOneButton(title: "Thông báo", with: errorMsg, titleButton: "Đồng ý")
                }
            }
        })

    }

    @IBAction func deliveyType(_ sender: UIButton) {
        //tag = 0 : tai shop| = 1  tai nha
        shipTipe = "\(sender.tag)"
        switch sender.tag {
        case 0:
            self.nameTxt.isUserInteractionEnabled = false
            self.birthdayTxt.isUserInteractionEnabled = false
            self.cmndNumberTxt.isUserInteractionEnabled = false
            self.nameTxt.text = ""
            self.birthdayTxt.text = ""
            self.cmndNumberTxt.text = ""
        case 1:
            self.nameTxt.isUserInteractionEnabled = true
            self.birthdayTxt.isUserInteractionEnabled = true
            self.cmndNumberTxt.isUserInteractionEnabled = true
        default:
            return
        }
        didChangeSelect(with: ghtnImg, isSelect: sender.tag == 1)
        didChangeSelect(with: ghtsImg, isSelect: sender.tag == 0)
        if !isFromSearch {
            noteLabel.isHidden = sender.tag == 1 ? false : true
        }
        cmndView.isHidden = sender.tag == 1
        paperRelateView.isHidden = sender.tag == 1
    }

    @IBAction func onCommitedAction(_ sender: Any) {
        if commitedImg.image == UIImage(named: "mdi_check_circle_gr_2") {
            commitedImg.image = UIImage(named: "mdi_check_circle_gr")
        } else {
            commitedImg.image = UIImage(named: "mdi_check_circle_gr_2")
        }
    }

    @IBAction func onConfirm(_ sender: Any) {
        if !isValidateOK() {return}
        let newtype = shipTipe == "0" ? "2" : "3"
        guard let user = UserDefaults.standard.getUsernameEmployee() else {return}
        if isNewStudent {
            let newPreUrl = shipTipe == "1" ? "" : self.urlPreImg
            let backUrl = shipTipe == "1" ? "" : self.urlBackImg
            let otherUrl = shipTipe == "1" ? "" : self.urlOtherImg
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.BackToSchool_UpdateThongTinKhachHang(ID_BackToSchool: self.idBTS, SBD: self.studentInfoItem?.SoBaoDanh ?? "", HoTen: self.nameTxt.text ?? "", CMND: self.cmndNumberTxt.text ?? "", SDT: self.sdtTxt.text ?? "", NgaySinh: 0,birthDay: self.birthdayTxt.text ?? "",shipType: newtype, handler: {[weak self] (success, errorMsg, mData, err) in
                    guard let self = self else {return}
                    if success == "1" {
                        //thanh cong
                        MPOSAPIManager.BackToSchool_UpdateHinhAnh(ID_BackToSchool: self.idBTS, SBD: self.studentInfoItem?.SoBaoDanh ?? "", Url_CMND_MT: newPreUrl, Url_CMND_MS: backUrl, Url_GiayBaoDuThi: otherUrl, handler: { [weak self] (success, errorMsg, mData, err) in
                            guard let strongSelf = self else {return}
                            WaitingNetworkResponseAlert.DismissWaitingAlert {
                                if success == "1" {
                                    needReload = true
                                    let alertVC = UIAlertController(title: "Thông báo", message: errorMsg, preferredStyle: .alert)
                                    let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                        self?.saveInfoSt()
                                        for controller in (self?.navigationController!.viewControllers)! as Array {
                                            if controller.isKind(of: PaymentViewController.self) {
                                                _ = self?.navigationController?.popToViewController(controller, animated: true)
                                            }
                                        }
                                    })
                                    alertVC.addAction(action)
                                    strongSelf.present(alertVC, animated: true, completion: nil)
                                } else {
                                    strongSelf.showAlertOneButton(title: "Thông báo", with: errorMsg, titleButton: "Đồng ý")
                                }
                            }
                        })
                    } else {
                        WaitingNetworkResponseAlert.DismissWaitingAlert {}
                        self.showAlertOneButton(title: "Thông báo", with: errorMsg, titleButton: "Đồng ý")
                    }
                })
            }
        } else {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
				MPOSAPIManager.backToSchool_InsertDataStudentFPT(name: self.nameTxt.text ?? "", identity: self.cmndNumberTxt.text ?? "", phoneNumber: self.sdtTxt.text ?? "", user: user, type: self.isPolytecnic ? 5 : 4 ,birthday: self.birthdayTxt.text ?? "",shipType: newtype) {[weak self] (success, mErr, result, err) in
                    guard let strongSelf = self else {return}
                    if let success = success {
                        if success {
                            if let data = result {
                                if data.result == 1 {
                                    self?.uploadImage(idBTS: result?.idBackToSchool ?? 0)
                                } else {
                                    WaitingNetworkResponseAlert.DismissWaitingAlert {}
                                    strongSelf.showAlertOneButton(title: "Thông báo", with: data.msg ?? "", titleButton: "Đồng ý") {
                                    }
                                }
                            }

                        } else {
                            WaitingNetworkResponseAlert.DismissWaitingAlert {}
                            strongSelf.showAlertOneButton(title: "Thông báo", with: mErr ?? "", titleButton: "Đồng ý") {
                            }
                        }
                    }
                }
            }
        }
    }

}

extension BackToSchoolDirectVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }

        switch selectedType {
        case 1:
            self.urlPreImg = ""
            base64PreImg =  self.setImage(image: image)
            preCMNDImg.image = image
            let group = DispatchGroup()
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                group.enter()
                MPOSAPIManager.mpos_DetectIDCard(Image_CMND:"\(self.base64PreImg)") {[weak self] (result,err) in
                    group.leave()
                    guard let self = self else {return}
                    if(err.count <= 0){
                        if self.shipTipe != "0" {
                            self.nameTxt.isUserInteractionEnabled = result != nil ? false : true
                            self.birthdayTxt.isUserInteractionEnabled = result != nil ? false : true
                            self.cmndNumberTxt.isUserInteractionEnabled = result != nil ? false : true
                        }
                        if(result != nil){
                            self.nameTxt.text = result?.FullName
                            self.birthdayTxt.text = result?.BirthDay
                            self.cmndNumberTxt.text = result?.IdCard
                            self.detectIDcard = result
                        }
                    }
                    else {
                        self.showAlertOneButton(title: "Lỗi", with: err, titleButton: "OK")

                    }
                }

                group.notify(queue: DispatchQueue.main) {
                    MPOSAPIManager.BackToSchool_UploadImage(base64: self.base64PreImg, cmnd: self.cmndNumberTxt.text ?? "" , type: "1", handler: {[weak self] (success, errorMsg, mData, err) in
                        WaitingNetworkResponseAlert.DismissWaitingAlert {}
                        if success == "1" {
                            self?.urlPreImg = mData
                        } else {
                            self?.urlPreImg = ""
                            self?.base64PreImg =  ""
                            self?.preCMNDImg.image = UIImage(named: "AddImage51")
                            self?.showAlertOneButton(title: "Thông báo", with: errorMsg != "" ? errorMsg : err, titleButton: "Đồng ý")
                        }
                    })
                }

            }

        case 2:
            self.urlBackImg = ""
            base64BackImg =  self.setImage(image: image)
            backCMNDImg.image = image
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.BackToSchool_UploadImage(base64: self.base64BackImg, cmnd: self.cmndNumberTxt.text ?? "" , type: "2", handler: {[weak self] (success, errorMsg, mData, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {}
                    if success == "1" {
                        self?.urlBackImg = mData
                    } else {
                        self?.urlBackImg = ""
                        self?.base64BackImg =  ""
                        self?.backCMNDImg.image = UIImage(named: "AddImage51")
                        self?.showAlertOneButton(title: "Thông báo", with: errorMsg != "" ? errorMsg : err, titleButton: "Đồng ý")
                    }

                })
            }
        case 3:
            self.urlOtherImg = ""
            base64OtherImg =  self.setImage(image: image)
            cardStudentImg.image = image
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.BackToSchool_UploadImage(base64: self.base64OtherImg, cmnd: self.cmndNumberTxt.text ?? "" , type: "3", handler: { [weak self] (success, errorMsg, mData, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {}
                    if success == "1" {
                        self?.urlOtherImg = mData
                    } else {
                        self?.urlOtherImg = ""
                        self?.base64OtherImg =  ""
                        self?.cardStudentImg.image = UIImage(named: "AddImage51")
                        self?.showAlertOneButton(title: "Thông báo", with: errorMsg != "" ? errorMsg : err, titleButton: "Đồng ý")
                    }
                })
            }
        default:
            break
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
