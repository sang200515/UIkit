    //
    //  ShinhanInfoCustomerVC.swift
    //  fptshop
    //
    //  Created by Ngoc Bao on 03/12/2021.
    //  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
    //

import Alamofire
import DropDown
import Kingfisher
import UIKit
import Toaster

class ShinhanInfoCustomerVC: BaseController {

    @IBOutlet weak var contenScrollView: UIView!
    @IBOutlet var lisStacks: [UIStackView]!
        //MARK: stack info
    @IBOutlet weak var headerInfo: HeaderInfo!
    @IBOutlet weak var stackInfo: UIStackView!
    @IBOutlet weak var femaleRadio: RadioCustom!
    @IBOutlet weak var maleRadio: RadioCustom!
    @IBOutlet weak var nameView: CustomTxt!
    @IBOutlet weak var birthView: CustomTxt!
    @IBOutlet weak var cmndView: CustomTxt!
    @IBOutlet weak var noiCapView: CustomTxt!
    @IBOutlet weak var ngaycapView: CustomTxt!
    @IBOutlet weak var ngayhetHanView: CustomTxt!
    @IBOutlet weak var phoneView: CustomTxt!
    @IBOutlet weak var mailView: CustomTxt!

        //MARK: stack thuong tru
    @IBOutlet weak var headerThuongtru: HeaderInfo!
    @IBOutlet weak var stackThuongtru: UIStackView!
    @IBOutlet weak var cityTTView: CustomTxt!
    @IBOutlet weak var townTTView: CustomTxt!
    @IBOutlet weak var xaTTView: CustomTxt!
    @IBOutlet weak var sonhaTTView: CustomTxt!
    @IBOutlet weak var tenDuongTTView: CustomTxt!

        //MARK: stack tam tru
    @IBOutlet weak var headerTamtru: HeaderInfo!
    @IBOutlet weak var stackTamtru: UIStackView!
    @IBOutlet weak var stackInsideTamtru: UIStackView!
    @IBOutlet weak var tamtruRadio: RadioCustom!
    @IBOutlet weak var cityTamtruView: CustomTxt!
    @IBOutlet weak var townTamtruView: CustomTxt!
    @IBOutlet weak var xaTamtruView: CustomTxt!
    @IBOutlet weak var sonhaTamtruView: CustomTxt!
    @IBOutlet weak var tenduongTamtruView: CustomTxt!

        //MARK: stack congviec
    @IBOutlet weak var headerJob: HeaderInfo!
    @IBOutlet weak var stackJob: UIStackView!
    @IBOutlet weak var ctyView: CustomTxt!
    @IBOutlet weak var thunhapView: CustomTxt!
    @IBOutlet weak var thanhtoanView: CustomTxt!


    @IBOutlet weak var headerMaNoiBo: HeaderInfo!
    @IBOutlet weak var maNoiBoView: CustomTxt!

    //MARK: stack nguoi lien he

    @IBOutlet weak var headerContacUser: HeaderInfo!
    @IBOutlet weak var stackcontactUser: UIStackView!
    @IBOutlet weak var userThamChieu1: CustomTxt!
    @IBOutlet weak var usermqhView1: CustomTxt!
    @IBOutlet weak var phoneContact1: CustomTxt!
    @IBOutlet weak var userThamChieu2: CustomTxt!
    @IBOutlet weak var usermqhView2: CustomTxt!
    @IBOutlet weak var phoneContact2: CustomTxt!

        //MARK: stack hinh anh
    @IBOutlet weak var headerHinhanh: HeaderInfo!
    @IBOutlet weak var headerGPLX: HeaderInfo!
    @IBOutlet weak var stackHinhanh: UIStackView!
    @IBOutlet weak var stackGplxSHK: UIStackView!
    @IBOutlet weak var cmndImmgView: ImageFrameCustom!
    @IBOutlet weak var gplxImmgView: ImageFrameCustom!
    @IBOutlet weak var userImageView: ImageFrameCustom!
    @IBOutlet weak var infoPhoneView: ImageFrameCustom!
    @IBOutlet weak var contractTxtView: CustomTxt!
    @IBOutlet weak var contractImageView: ImageFrameCustom!
    @IBOutlet weak var gplxRadio: RadioCustom!
    @IBOutlet weak var shkRadio: RadioCustom!
    @IBOutlet weak var shkStack: UIStackView!
    @IBOutlet weak var shkImgView1: ImageFrameCustom!
    @IBOutlet weak var shkImgView2: ImageFrameCustom!

    @IBOutlet weak var bottomBUtton: UIButton!

    var gender = -1  // 0 male 1 female
    var paperType = 3  // 3 gplx 4 SHK
    var isFamiliarTT = false
    var inforFontCmnd: ShinhanFontBase?
    var inforBehindCmnd: ShinhanBehindBase?
    var inforData: ShinhanBeforeCreateBase?
    var mattruocImage: UIImage?
    var matsauImage: UIImage?
    var selectedNoiCap: ShinhanCity?
    var selectedCityTT: ShinhanCity?
    var selectedCityTamtru: ShinhanCity?
    var selectedTownTT: ShinhanCity?
    var selectedTownTamtru: ShinhanCity?
    var selectedXaTT: ShinhanCity?
    var selectedXaTamtru: ShinhanCity?
    var listCity: [ShinhanCity] = []
    var listRelationShip: [ShinhanCity] = []
    var listPaymentDate: [ShinhanPaymentDate] = []
    var listDistrict: [ShinhanCity] = []
    var listWard: [ShinhanCity] = []
    var selectedMqh1: ShinhanCity?
    var selectedMqh2: ShinhanCity?
    var selectedPaymentDate: ShinhanPaymentDate?
    var docEntry = 0
    var isInfoHistory = false
    let dropDownMenu = DropDown()

        //core tra gop
    var countUpload:Int = 0
    var isCore: Bool = false
    var detailDataMapping: MasterDataInstallMent?
        //    private func getMasterDataInstallMent() {
        //        CoreInstallMentData.shared.searchID = "100"
        //        Provider.shared.coreInstallmentService.getMasterDataInstallMent(
        //            idCard: CoreInstallMentData.shared.idCard,
        //            success: { [weak self] result in
        //                guard let self = self else { return }
        //                print(result)
        //                CoreInstallMentData.shared.infoCustomerMapping = result
        //            },
        //            failure: { [weak self] error in
        //                guard let self = self else { return }
        //                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        //            })
        //    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerMaNoiBo.arrowImg.isHidden = true
        lisStacks.forEach { stack in
            stack.isHidden = false
        }
        headerInfo.delegate = self
        maleRadio.delegate = self
        femaleRadio.delegate = self
        cmndView.keyboard = .numberPad
        phoneView.keyboard = .phonePad

        headerTamtru.delegate = self

        headerThuongtru.delegate = self
        tamtruRadio.delegate = self

        headerJob.delegate = self
        headerMaNoiBo.delegate = self
        maNoiBoView.delegateTextfield = self

        headerContacUser.delegate = self
        phoneContact1.keyboard = .phonePad
        phoneContact2.keyboard = .phonePad

        headerHinhanh.delegate = self
        headerGPLX.delegate = self
        shkRadio.delegate = self
        gplxRadio.delegate = self
        cmndImmgView.controller = self
        cmndImmgView.delegate = self
        gplxImmgView.controller = self
        gplxImmgView.delegate = self
        userImageView.controller = self
        userImageView.delegate = self
        infoPhoneView.controller = self
        infoPhoneView.delegate = self
        shkImgView1.controller = self
        shkImgView2.controller = self
        shkImgView1.delegate = self
        shkImgView2.delegate = self
        contractTxtView.delegateTextfield = self
        contractImageView.controller = self
        noiCapView.delegateTextfield = self
        cityTTView.delegateTextfield = self
        townTTView.delegateTextfield = self
        xaTTView.delegateTextfield = self
        cityTamtruView.delegateTextfield = self
        townTamtruView.delegateTextfield = self
        xaTamtruView.delegateTextfield = self
        usermqhView1.delegateTextfield = self
        usermqhView2.delegateTextfield = self
        thanhtoanView.delegateTextfield = self
        thunhapView.keyboard = .numberPad
        bindData()
        if isInfoHistory {
            lisStacks[5].isHidden = true
            stackInfo.isUserInteractionEnabled = false
            stackJob.isUserInteractionEnabled = false
            stackTamtru.isUserInteractionEnabled = false
            stackThuongtru.isUserInteractionEnabled = false
            stackcontactUser.isUserInteractionEnabled = false
            bottomBUtton.isHidden = true
        }

    }

    @objc func setupDrop() {
        dropDownMenu.anchorView = thanhtoanView
        dropDownMenu.bottomOffset = CGPoint(x: 0, y: (dropDownMenu.anchorView?.plainView.bounds.height)! + 10)
        dropDownMenu.dataSource = self.listPaymentDate.map({ $0.paymentDate })
        dropDownMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dropDownMenu.selectionAction = { [weak self] (index, item) in
            let filter = self?.listPaymentDate.filter({ $0.paymentDate == item })
            self?.selectedPaymentDate = filter?.first
            self?.thanhtoanView.textfield.text = item
        }
        dropDownMenu.show()
    }
    @objc func setupDropMaNoiBo() {
        dropDownMenu.anchorView = maNoiBoView
        dropDownMenu.bottomOffset = CGPoint(x: 0,y:(dropDownMenu.anchorView?.plainView.bounds.height)! + 10)
        dropDownMenu.dataSource =  ["0","1"]
        dropDownMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dropDownMenu.selectionAction = { [weak self] (index, item) in
            self?.maNoiBoView.textfield.text = item
            ShinhanDataLocal.share.iternalCode = item
        }
        dropDownMenu.show()
    }
    
    private func bindData() {
        if !isInfoHistory {
            if isCore == false {
                cmndImmgView.setimage(image: mattruocImage!, isleft: true)
                cmndImmgView.setimage(image: matsauImage!, isleft: false)
            }


            
//            gender = (inforFontCmnd?.data.first?.gender ?? 0) - 1
//            onClickRadio(radioView: UIView(),tag: gender)
            nameView.textfield.text = inforFontCmnd?.data.first?.fullName ?? ""
            birthView.textfield.text = inforFontCmnd?.data.first?.birthday ?? ""
            cmndView.textfield.text = inforFontCmnd?.data.first?.cMND ?? ""
            ngaycapView.textfield.text = inforBehindCmnd?.data.first?.issue_date ?? ""
        }
        loadDataApi()
    }

    func loadDataApi() {
        let concurrentQueue = DispatchQueue(label: "concurrent.queue", attributes: .concurrent)

        concurrentQueue.async {
            DispatchQueue.main.async {
                self.loadInforCustomer()
            }
        }

        if !isInfoHistory {
            concurrentQueue.async {
                DispatchQueue.main.async {
                    self.loadCity()
                }
            }
            concurrentQueue.async {
                DispatchQueue.main.async {
                    self.loadRelationship()
                }
            }
            concurrentQueue.async {
                DispatchQueue.main.async {
                    self.loadPaymentDate()
                }
            }

            concurrentQueue.async {
                DispatchQueue.main.async {
                    if let imageData: NSData = self.mattruocImage?.jpegData(
                        compressionQuality: Common.resizeImageScanCMND) as NSData?
                    {
                        let base64Str = imageData.base64EncodedString(
                            options: .endLineWithLineFeed)
                        self.uploadImage(
                            docID: "2", idCard: self.inforFontCmnd?.data.first?.cMND ?? "",
                            base64: base64Str, trackingID: "")
                    }
                }
            }

            concurrentQueue.async {
                DispatchQueue.main.async {
                    if let imageData: NSData = self.matsauImage?.jpegData(
                        compressionQuality: Common.resizeImageScanCMND) as NSData?
                    {
                        let base64Str = imageData.base64EncodedString(
                            options: .endLineWithLineFeed)
                        self.uploadImage(
                            docID: "3", idCard: self.inforFontCmnd?.data.first?.cMND ?? "",
                            base64: base64Str, trackingID: "")
                    }
                }
            }
        }
    }

    func loadInforCustomer() {
        Provider.shared.shinhan.loadInfoCustomer(
            docEntry: isInfoHistory ? docEntry : 0, loadType: isInfoHistory ? 0 : 1,
            id: isInfoHistory ? "" : inforFontCmnd?.data.first?.cMND ?? ""
        ) { [weak self] result in
            guard let self = self else { return }
            if result?.success ?? false {
                self.inforData = result
                ShinhanData.infoUser = result?.data
                if let new = result, new.data != nil {
                    self.bindUI(info: new)
                } else {
                    self.bindCmndeDefault()
                }
            } else {
                self.showAlertOneButton(
                    title: "Thông báo", with: result?.message ?? "", titleButton: "OK",
                    handleOk: {
                        self.navigationController?.popViewController(animated: true)
                    })
            }
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlert(error.localizedDescription)
        }

    }

    func bindUI(info: ShinhanBeforeCreateBase) {
        maNoiBoView.textfield.text = info.data?.InternalCode
        birthView.textfield.text = info.data?.personalLoan?.dateOfBirth
        cmndView.textfield.text = info.data?.personalLoan?.idCard
        nameView.textfield.text = info.data?.personalLoan?.fullName ?? ""
        gender = info.data?.personalLoan?.gender == false ? 0 : 1
        onClickRadio(radioView: UIView(), tag: gender)
        onClickRadio(radioView: UIView(), tag: paperType)
        noiCapView.searchTxt.text = info.data?.personalLoan?.idCardCityDesc ?? ""
        self.selectedNoiCap = ShinhanCity(
            id: info.data?.personalLoan?.idCardCityCode ?? "",
            value: info.data?.personalLoan?.idCardCityDesc ?? "")
        ngaycapView.textfield.text = info.data?.personalLoan?.idCardDateIssued ?? ""
        ngayhetHanView.textfield.text = info.data?.personalLoan?.idCardDateExpiration ?? ""
        phoneView.textfield.text = info.data?.personalLoan?.phone ?? ""
        mailView.textfield.text = info.data?.personalLoan?.email ?? ""

        cityTTView.searchTxt.text = info.data?.permanentAddress?.cityDesc
        selectedCityTT = ShinhanCity(
            id: info.data?.permanentAddress?.cityCode ?? "",
            value: info.data?.permanentAddress?.cityDesc ?? "")
        townTTView.searchTxt.text = info.data?.permanentAddress?.districtName ?? ""
        selectedTownTT = ShinhanCity(
            id: info.data?.permanentAddress?.districtCode ?? "",
            value: info.data?.permanentAddress?.districtName ?? "")
        xaTTView.searchTxt.text = info.data?.permanentAddress?.wardName ?? ""
        selectedXaTT = ShinhanCity(
            id: info.data?.permanentAddress?.wardCode ?? "",
            value: info.data?.permanentAddress?.wardName ?? "")
        sonhaTTView.textfield.text = info.data?.permanentAddress?.houseNo ?? ""
        tenDuongTTView.textfield.text = info.data?.permanentAddress?.street ?? ""

        if info.data?.residenceAddress?.samePerResAddress ?? false {
            onClickRadio(radioView: UIView(), tag: 2)

            cityTamtruView.searchTxt.text = info.data?.permanentAddress?.cityDesc
            selectedCityTamtru = ShinhanCity(
                id: info.data?.permanentAddress?.cityCode ?? "",
                value: info.data?.permanentAddress?.cityDesc ?? "")
            townTamtruView.searchTxt.text = info.data?.permanentAddress?.districtName ?? ""
            selectedTownTamtru = ShinhanCity(
                id: info.data?.permanentAddress?.districtCode ?? "",
                value: info.data?.permanentAddress?.districtName ?? "")
            xaTamtruView.searchTxt.text = info.data?.permanentAddress?.wardName ?? ""
            selectedXaTamtru = ShinhanCity(
                id: info.data?.permanentAddress?.wardCode ?? "",
                value: info.data?.permanentAddress?.wardName ?? "")
            sonhaTamtruView.textfield.text = info.data?.permanentAddress?.houseNo ?? ""
            tenduongTamtruView.textfield.text = info.data?.permanentAddress?.street ?? ""
        } else {
            cityTamtruView.searchTxt.text = info.data?.residenceAddress?.cityDesc
            selectedCityTamtru = ShinhanCity(
                id: info.data?.residenceAddress?.cityCode ?? "",
                value: info.data?.residenceAddress?.cityDesc ?? "")
            townTamtruView.searchTxt.text = info.data?.residenceAddress?.districtName ?? ""
            selectedTownTamtru = ShinhanCity(
                id: info.data?.residenceAddress?.districtCode ?? "",
                value: info.data?.residenceAddress?.districtName ?? "")
            xaTamtruView.searchTxt.text = info.data?.residenceAddress?.wardName ?? ""
            selectedXaTamtru = ShinhanCity(
                id: info.data?.residenceAddress?.wardCode ?? "",
                value: info.data?.residenceAddress?.wardName ?? "")
            sonhaTamtruView.textfield.text = info.data?.residenceAddress?.houseNo ?? ""
            tenduongTamtruView.textfield.text = info.data?.residenceAddress?.street ?? ""
        }

        userThamChieu1.textfield.text = info.data?.refPerson1?.fullName
        usermqhView1.searchTxt.text = info.data?.refPerson1?.relationshipDes
        phoneContact1.textfield.text = info.data?.refPerson1?.phone
        selectedMqh1 = ShinhanCity(
            id: info.data?.refPerson1?.relationshipCode ?? "",
            value: info.data?.refPerson1?.relationshipDes ?? "")

        userThamChieu2.textfield.text = info.data?.refPerson2?.fullName
        usermqhView2.searchTxt.text = info.data?.refPerson2?.relationshipDes
        phoneContact2.textfield.text = info.data?.refPerson2?.phone
        selectedMqh2 = ShinhanCity(
            id: info.data?.refPerson2?.relationshipCode ?? "",
            value: info.data?.refPerson2?.relationshipCode ?? "")

        ctyView.textfield.text = info.data?.workInfo?.companyName ?? ""
        thunhapView.textfield.text = Common.convertCurrencyV2(
            value: Int(info.data?.workInfo?.income ?? "0") ?? 0)
        thanhtoanView.textfield.text = info.data?.workInfo?.firstPaymentDate ?? ""

    }
    func bindCmndeDefault() {
        if isCore {
//            self.showAlert("Bạn vui lòng chờ 15-30s để tất cả ảnh được tải xuống hoàn tất nhé!")
            Toast.init(text: "Bạn vui lòng chờ 15-30s để tất cả ảnh được tải xuống hoàn tất nhé!").show()
            ShinhanData.IS_RUNNING = true
            print(detailDataMapping)
//            Common.convertDateToStringWith(dateString: detailDataMapping?.birthDate ?? "", formatIn: "yyyy-MM-dd", formatOut: "dd/MM/yyyy")
            ShinhanData.cmndType = detailDataMapping?.idCardType ?? -1
            birthView.textfield.text = Common.convertDateToStringWith(dateString: detailDataMapping?.birthDate ?? "", formatIn: "yyyy-MM-dd", formatOut: "dd/MM/yyyy")
            cmndView.textfield.text = detailDataMapping?.idCard
            nameView.textfield.text = detailDataMapping?.fullName
            gender = detailDataMapping?.gender == 0 ? 0 : 1
            if gender == 0 {
                maleRadio.setSelect(isSelect: false)
                femaleRadio.setSelect(isSelect: true)
            }else {
                femaleRadio.setSelect(isSelect: false)
                maleRadio.setSelect(isSelect: true)
            }
            if detailDataMapping?.relatedDocType == "DL" {
                paperType = 3
                onClickRadio(radioView: UIView(), tag: 3)

            }else {
                paperType = 4
                onClickRadio(radioView: UIView(), tag: 4)
            }

//            gender = detailDataMapping?.gender ?? -1
//            onClickRadio(radioView: UIView(), tag: gender)
            onClickRadio(radioView: UIView(), tag: paperType)
            noiCapView.searchTxt.text = detailDataMapping?.idCardIssued?.idCardIssuedBy ?? ""
            self.selectedNoiCap = ShinhanCity(
                id: detailDataMapping?.idCardIssued?.insHouseIdCardIssuedBy?.shinhanCode ?? "",
                value: detailDataMapping?.idCardIssued?.idCardIssuedBy ?? "")
            ngaycapView.textfield.text =  Common.convertDateToStringWith(dateString: detailDataMapping?.idCardIssuedDate ?? "", formatIn: "yyyy-MM-dd", formatOut: "dd/MM/yyyy")


            ngayhetHanView.textfield.text = Common.convertDateToStringWith(dateString: detailDataMapping?.idCardIssuedExpiration ?? "", formatIn: "yyyy-MM-dd", formatOut: "dd/MM/yyyy")

            phoneView.textfield.text = detailDataMapping?.phone
            mailView.textfield.text = detailDataMapping?.email

            selectedCityTT = ShinhanCity(
                id: detailDataMapping?.addresses?[0].insHouseProvice?.shinhanCode ?? "",
                value: detailDataMapping?.addresses?[0].provinceName ?? "")
            selectedTownTT = ShinhanCity(
                id: detailDataMapping?.addresses?[0].insHouseDistrict?.shinhanCode ?? "",
                value: detailDataMapping?.addresses?[0].districtName ?? "")
            selectedXaTT = ShinhanCity(
                id: detailDataMapping?.addresses?[0].insHouseWard?.shinhanCode  ?? "",
                value: detailDataMapping?.addresses?[0].wardName ?? "")
            cityTTView.searchTxt.text = detailDataMapping?.addresses?[0].provinceName ?? ""
            townTTView.searchTxt.text = detailDataMapping?.addresses?[0].districtName ?? ""
            xaTTView.searchTxt.text = detailDataMapping?.addresses?[0].wardName ?? ""
            sonhaTTView.textfield.text = detailDataMapping?.addresses?[0].houseNo
            tenDuongTTView.textfield.text = detailDataMapping?.addresses?[0].street

            cityTamtruView.searchTxt.text = detailDataMapping?.addresses?[1].provinceName ?? ""
            townTamtruView.searchTxt.text = detailDataMapping?.addresses?[1].districtName ?? ""
            xaTamtruView.searchTxt.text = detailDataMapping?.addresses?[1].wardName ?? ""
            selectedCityTamtru = ShinhanCity(
                id: detailDataMapping?.addresses?[1].insHouseProvice?.shinhanCode ?? "",
                value: detailDataMapping?.addresses?[1].provinceName ?? "")
            selectedTownTamtru = ShinhanCity(
                id: detailDataMapping?.addresses?[1].insHouseDistrict?.shinhanCode ?? "",
                value: detailDataMapping?.addresses?[1].districtName ?? "")
            selectedXaTamtru = ShinhanCity(
                id: detailDataMapping?.addresses?[1].insHouseWard?.shinhanCode ?? "",
                value: detailDataMapping?.addresses?[1].wardName ?? "")
            sonhaTamtruView.textfield.text = detailDataMapping?.addresses?[1].houseNo
            tenduongTamtruView.textfield.text = detailDataMapping?.addresses?[1].street

            userThamChieu1.textfield.text = detailDataMapping?.refPersons?[0].fullName
            usermqhView1.searchTxt.text = detailDataMapping?.refPersons?[0].relationshipName
            phoneContact1.textfield.text = detailDataMapping?.refPersons?[0].phone
            selectedMqh1 = ShinhanCity(
                id: detailDataMapping?.refPersons?[0].insHouseRefPerson?.shinhanCode ?? "",
                value: detailDataMapping?.refPersons?[0].relationshipName ?? "")

            userThamChieu2.textfield.text = detailDataMapping?.refPersons?[1].fullName
            usermqhView2.searchTxt.text = detailDataMapping?.refPersons?[1].relationshipName
            phoneContact2.textfield.text = detailDataMapping?.refPersons?[1].phone
            selectedMqh2 = ShinhanCity(
                id: detailDataMapping?.refPersons?[1].insHouseRefPerson?.shinhanCode ?? "",
                value: detailDataMapping?.refPersons?[1].relationshipName ?? "")

            ctyView.textfield.text = detailDataMapping?.company?.companyName
            thunhapView.textfield.text = Common.convertCurrencyV2(value: Int(detailDataMapping?.company?.income ?? 0))
//            thanhtoanView.textfield.text = "Vui lòng chọn ngày thanh toán"

            uploadImageCore()

        } else {
            birthView.textfield.text = inforFontCmnd?.data.first?.birthday
            cmndView.textfield.text = inforFontCmnd?.data.first?.cMND
            nameView.textfield.text = inforFontCmnd?.data.first?.fullName
            gender = inforFontCmnd?.data.first?.gender ?? 0
        }

            //        onClickRadio(radioView: UIView(), tag: gender)
    }
    private func uploadImageCore(){
        guard let listFile = detailDataMapping?.uploadFiles else { return }
        if countUpload == listFile.count  { return }


        downLoadIMage(url: listFile[countUpload].urlImage ?? "")
    }
    private func downLoadIMage(url: String) {
        AF.request( url,method: .get).response{ response in

            switch response.result {
                case .success(let responseData):
                    let imageView = UIImage(data: responseData!, scale: 1)
                        //                    self.myImageView.image = UIImage(data: responseData!, scale:1)
                    if let imageData: NSData = imageView?.jpegData(compressionQuality: 0.1) as NSData? {
                        let base64Str = imageData.base64EncodedString(options: .lineLength64Characters)
                        var docID:String = ""
                        if self.detailDataMapping?.uploadFiles?[self.countUpload].fileType == "SELFIE" { docID = "1" }
                        if self.detailDataMapping?.uploadFiles?[self.countUpload].fileType == "IdCardFront" { docID = "2" }
                        if self.detailDataMapping?.uploadFiles?[self.countUpload].fileType == "IdCardBack" { docID = "3" }
                        if self.detailDataMapping?.uploadFiles?[self.countUpload].fileType == "DLFront" { docID = "9" }
                        if self.detailDataMapping?.uploadFiles?[self.countUpload].fileType == "DLBack" { docID = "13" }
                        if self.detailDataMapping?.uploadFiles?[self.countUpload].fileType == "SIM_CARD_OWNER" { docID = "12" }

                        if self.detailDataMapping?.uploadFiles?[self.countUpload].fileType == "FB1" { docID = "4" }
                        if self.detailDataMapping?.uploadFiles?[self.countUpload].fileType == "FB2" { docID = "4" }
                        if self.detailDataMapping?.uploadFiles?[self.countUpload].fileType == "FB3" { docID = "4" }
                        var index:Int = 0
                        var isLeft:Bool = false
                        if self.detailDataMapping?.uploadFiles?[self.countUpload].fileType == "FB1" {
                            isLeft = true
                        }else if self.detailDataMapping?.uploadFiles?[self.countUpload].fileType == "FB2" {
                            isLeft = false
                        }else if self.detailDataMapping?.uploadFiles?[self.countUpload].fileType == "FB3" {
                            index = 1
                        }else {
                            index = 0
                            isLeft = true
                        }
                        if docID != ""  {
                            self.uploadImage(docID: docID, idCard: self.detailDataMapping?.idCard ?? "", base64: base64Str, trackingID: "", isLeft: isLeft,index: index)
                        }

                    }
                case .failure(let error):
                    print("error--->",error)
            }
        }

    }

    func loadPaymentDate() {
        Provider.shared.shinhan.loadPayemntDate { [weak self] result in
            guard let self = self else { return }
            self.listPaymentDate = result?.data ?? []
            self.dropDownMenu.dataSource = result?.lisString ?? []
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlert(error.localizedDescription)
        }

    }

    func loadCity() {
        Provider.shared.shinhan.loadCity(
            success: { [weak self] result in
                guard let self = self else { return }
                self.listCity = result?.data ?? []
                self.noiCapView.filterString = result?.lisString ?? []
                self.cityTTView.filterString = result?.lisString ?? []
                self.cityTamtruView.filterString = result?.lisString ?? []

            },
            failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlert(error.localizedDescription)
            })
    }

    func loadRelationship() {
        Provider.shared.shinhan.loadRelationship(
            success: { [weak self] result in
                guard let self = self else { return }
                self.listRelationShip = result?.data ?? []
                self.usermqhView1.filterString = result?.lisString ?? []
                self.usermqhView2.filterString = result?.lisString ?? []
            },
            failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlert(error.localizedDescription)
            })
    }

    func loadDistrict(cityCode: String, isTT: Bool) {
        Provider.shared.shinhan.loadDistricts(cityCode: cityCode) { [weak self] result in
            guard let self = self else { return }
            self.listDistrict = result?.data ?? []
            if isTT {
                self.townTTView.filterString = result?.lisString ?? []
                self.townTTView.searchTxt.becomeFirstResponder()
            } else {
                self.townTamtruView.filterString = result?.lisString ?? []
                self.townTamtruView.searchTxt.becomeFirstResponder()
            }
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlert(error.localizedDescription)
        }

    }

    func loadWard(districtCode: String, isTT: Bool) {
        Provider.shared.shinhan.loadWawrds(districtCode: districtCode) { [weak self] result in
            guard let self = self else { return }
            self.listWard = result?.data ?? []
            if isTT {
                self.xaTTView.filterString = result?.lisString ?? []
                self.xaTTView.searchTxt.becomeFirstResponder()
            } else {
                self.xaTamtruView.filterString = result?.lisString ?? []
                self.xaTamtruView.searchTxt.becomeFirstResponder()
            }
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlert(error.localizedDescription)
        }

    }

    func uploadImage(
        docID: String, idCard: String, base64: String, trackingID: String, isLeft: Bool = false, index: Int = 0
    ) {
        self.showLoading()
        Provider.shared.shinhan.uploadimage(
            docID: docID, idCard: idCard, trackingID: trackingID, base64: base64
        ) { [weak self] result in
            guard let self = self else { return }
            self.stopLoading()
            if !(result?.success ?? false) {
                self.showAlert(result?.message ?? "")
                if docID == "1" {
                    self.userImageView.setdefault(isLeft: true)
                } else if docID == "2" {
                    self.cmndImmgView.setdefault(isLeft: true)
                } else if docID == "3" {
                    self.cmndImmgView.setdefault(isLeft: false)
                } else if docID == "9" {
                    self.gplxImmgView.setdefault(isLeft: true)
                } else if docID == "13" {
                    self.gplxImmgView.setdefault(isLeft: false)
                } else if docID == "12" {
                    self.infoPhoneView.setdefault(isLeft: true)
                } else if docID == "4" {
                    if index == 0 {
                        self.shkImgView1.setdefault(isLeft: isLeft)
                    } else {
                        self.shkImgView2.setdefault(isLeft: isLeft)
                    }
                }

            }else {
                if self.isCore {
                    let dataDecoded : Data = Data(base64Encoded: base64, options: .ignoreUnknownCharacters)!
                    let imageResult = UIImage(data: dataDecoded)

                    if docID == "1" {
                        self.userImageView.setimage(image: imageResult!, isleft: true)
                    } else if docID == "2" {
                            //                        self.cmndImmgView.setdefault(isLeft: true)
                        self.cmndImmgView.setimage(image: imageResult!, isleft: true)
                    } else if docID == "3" {
                        self.cmndImmgView.setimage(image: imageResult!, isleft: false)
                    } else if docID == "9" {
                        self.gplxImmgView.setimage(image: imageResult!, isleft: true)
                    } else if docID == "13" {
                        self.gplxImmgView.setimage(image: imageResult!, isleft: false)
                    } else if docID == "12" {
                        self.infoPhoneView.setimage(image: imageResult!, isleft: true)
                    } else if docID == "4" {
                        if index == 0 {
                            self.shkImgView1.setimage(image: imageResult!, isleft: isLeft)
                        } else {
                            self.shkImgView2.setimage(image: imageResult!, isleft: true)
                        }
                    }
                    self.countUpload += 1
                    self.uploadImageCore()
                }
            }
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.stopLoading()
            self.showAlert(error.localizedDescription)
        }
    }

    @IBAction func onCreate() {
        if validate() {
            if isCore {
                if gender == 0 {
                    gender = 1
                }else if gender == 1{
                    gender = 0
                }
            }
            let personal = ShinhanPersonalLoan(
                fullName: nameView.text, gender: gender == 1 ? true : false,
                dateOfBirth: birthView.text, idCard: cmndView.text,
                idCardCityCode: self.selectedNoiCap?.id ?? "",
                idCardCityDesc: self.selectedNoiCap?.value ?? "", idCardDateIssued: ngaycapView.text,
                idCardDateExpiration: ngayhetHanView.text, phone: phoneView.text, email: mailView.text,
                idCardType: ShinhanData.cmndType)

            let thuongtru = ShinhanPermanentAddress(
                houseNo: sonhaTTView.text, street: tenDuongTTView.text,
                cityCode: self.selectedCityTT?.id ?? "", cityDesc: self.selectedCityTT?.value ?? "",
                districtCode: self.selectedTownTT?.id ?? "",
                districtName: self.selectedTownTT?.value ?? "", wardCode: self.selectedXaTT?.id ?? "",
                wardName: self.selectedXaTT?.value ?? "")

            let tamtru = ShinhanResidenceAddress(
                samePerResAddress: isFamiliarTT,
                houseNo: isFamiliarTT ? sonhaTTView.text : sonhaTamtruView.text,
                street: isFamiliarTT ? tenDuongTTView.text : tenduongTamtruView.text,
                cityCode: isFamiliarTT
                ? self.selectedCityTT?.id ?? "" : self.selectedCityTamtru?.id ?? "",
                cityDesc: isFamiliarTT
                ? self.selectedCityTT?.value ?? "" : self.selectedCityTamtru?.value ?? "",
                districtCode: isFamiliarTT
                ? self.selectedTownTT?.id ?? "" : self.selectedTownTamtru?.id ?? "",
                districtName: isFamiliarTT
                ? self.selectedTownTT?.value ?? "" : self.selectedTownTamtru?.value ?? "",
                wardCode: isFamiliarTT ? self.selectedXaTT?.id ?? "" : self.selectedXaTamtru?.id ?? "",
                wardName: isFamiliarTT
                ? self.selectedXaTT?.value ?? "" : self.selectedXaTamtru?.value ?? "")

            let newperson1 = ShinhanRefPerson(
                fullName: userThamChieu1.text, relationshipCode: selectedMqh1?.id ?? "",
                relationshipDes: selectedMqh1?.value ?? "", phone: phoneContact1.text)

            let newperson2 = ShinhanRefPerson(
                fullName: userThamChieu2.text, relationshipCode: selectedMqh2?.id ?? "",
                relationshipDes: selectedMqh2?.value ?? "", phone: phoneContact2.text)

            let jobInfo = ShinhanWorkInfo(
                income: thunhapView.text.replace(",", withString: "").replace(".", withString: "")
                    .trim(), companyName: ctyView.text, firstPaymentDate: thanhtoanView.text)

            ShinhanData.inforCustomer = ShinhanExistingApp(
                personal: personal, permanentAddress: thuongtru, residenceAddress: tamtru,
                refPerson1: newperson1, refPerson2: newperson2, workInfo: jobInfo)

            Provider.shared.shinhan.saveApplication(
                personalLoan: personal.toJSONString()?.convertToDictionary() ?? [:],
                permanentAddress: thuongtru.toJSONString()?.convertToDictionary() ?? [:],
                residenceAddress: tamtru.toJSONString()?.convertToDictionary() ?? [:],
                refPerson1: newperson1.toJSONString()?.convertToDictionary() ?? [:],
                person2: newperson2.toJSONString()?.convertToDictionary() ?? [:],
                workinfor: jobInfo.toJSONString()?.convertToDictionary() ?? [:]
            ) { [weak self] result in
                guard let self = self else { return }
                self.showPopUp(result?.message ?? "", "Thông báo", buttonTitle: "OK") {
                    if result?.success ?? false {
//                        ShinhanData.newDocEntry = result?.docEntry ?? 0
						ShinhanData.docEntry = result?.docEntry ?? 0
                        let vc = FindDepositVC()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            } failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlert(error.localizedDescription)
            }

        }
    }

    func validate() -> Bool {
        if gender == -1 {
            self.showAlert("Bạn vui lòng chọn giới tính")
            return false
        }
        if nameView.text == "" {
            self.showAlert("Bạn vui lòng nhập thông tin tên khách hàng")
            return false
        }
        if birthView.text == "" {
            self.showAlert("Bạn vui lòng chọn ngày tháng năm sinh")
            return false
        }

        if birthView.text == "" {
            self.showAlert("Bạn vui lòng chọn ngày tháng năm sinh")
            return false
        }

        if ngaycapView.text == "" {
            self.showAlert("Bạn vui lòng chọn ngày cấp")
            return false
        }

        if ngayhetHanView.text == "" && ShinhanData.cmndType != 0 {
            self.showAlert("Bạn vui lòng chọn ngày hết hạn")
            return false
        }

        if self.selectedNoiCap == nil {
            self.showAlert("Bạn vui lòng chọn nơi cấp")
            return false
        }

        if phoneView.text == "" {
            self.showAlert("Bạn vui lòng nhập số điện thoại")
            return false
        }
        if phoneView.text.first != "0" {
            self.showAlert("Bạn vui lòng nhập số điện thoại đúng định dạng bắt đầu bằng số 0")
            return false
        }
        if phoneView.text.count != 10 {
            self.showAlert("Bạn vui lòng nhập số điện thoại đúng định dạng 10 số")
            return false
        }

            //        if mailView.text == "" {
            //            self.showAlert("Bạn vui lòng nhập thông tin email")
            //            return false
            //        }

        if !Common.isValidEmail(mailView.text) && mailView.text != "" {
            self.showAlert("Bạn vui lòng nhập thông tin email đúng định dạng")
            return false
        }

        if self.selectedCityTT == nil {
            self.showAlert("Bạn vui lòng chọn thông tin Thành phố/Tỉnh ở mục địa chỉ thường trú")
            return false
        }
        if self.selectedTownTT == nil {
            self.showAlert("Bạn vui lòng chọn thông tin Quận/Huyện ở mục địa chỉ thường trú")
            return false
        }

        if self.selectedTownTT == nil {
            self.showAlert("Bạn vui lòng chọn thông tin Quận/Huyện ở mục địa chỉ thường trú")
            return false
        }

        if self.selectedXaTT == nil {
            self.showAlert("Bạn vui lòng nhập thông tin Phường/Xã ở mục địa chỉ thường trú")
            return false
        }

            //        if sonhaTTView.text == "" {
            //            self.showAlert("Bạn vui lòng nhập thông tin Số nhà ở mục địa chỉ thường trú")
            //            return false
            //        }

        if tenDuongTTView.text == "" {
            self.showAlert("Bạn vui lòng nhập thông tin Tên đường ở mục địa chỉ thường trú")
            return false

        }

        if !isFamiliarTT {
            if self.selectedCityTamtru == nil {
                self.showAlert("Bạn vui lòng chọn thông tin Thành phố/Tỉnh ở mục địa chỉ tạm trú")
                return false
            }
            if self.selectedTownTamtru == nil {
                self.showAlert("Bạn vui lòng chọn thông tin Quận/Huyện ở mục địa chỉ tạm trú")
                return false
            }

            if self.selectedTownTamtru == nil {
                self.showAlert("Bạn vui lòng chọn thông tin Quận/Huyện ở mục địa chỉ tạm trú")
                return false
            }

            if self.selectedXaTamtru == nil {
                self.showAlert("Bạn vui lòng nhập thông tin Phường/Xã ở mục địa chỉ tạm trú")
                return false
            }

            if tenduongTamtruView.text == "" {
                self.showAlert("Bạn vui lòng nhập thông tin Tên đường ở mục địa chỉ tạm trú")
                return false

            }
        }
        if userThamChieu1.text == "" {
            self.showAlert("Bạn vui lòng nhập thông tin người tham chiếu 1")
            return false
        }

        if selectedMqh1 == nil {
            self.showAlert("Bạn vui lòng chọn thông tin mối quan hệ người tham chiếu 1")
            return false
        }

        if phoneContact1.text == "" {
            self.showAlert("Bạn vui lòng nhập thông tin số điện thoại người tham chiếu 1")
            return false
        }
        if phoneContact1.text.first != "0" {
            self.showAlert(
                "Bạn vui lòng nhập số điện thoại người tham chiếu 1 đúng định dạng bắt đầu bằng số 0")
            return false
        }
        if phoneContact1.text.count != 10 {
            self.showAlert("Bạn vui lòng nhập số điện thoại người tham chiếu 1 đúng định dạng 10 số")
            return false
        }

        if userThamChieu2.text == "" {
            self.showAlert("Bạn vui lòng nhập thông tin người tham chiếu 2")
            return false
        }

        if selectedMqh2 == nil {
            self.showAlert("Bạn vui lòng chọn thông tin mối quan hệ người tham chiếu 2")
            return false
        }

        if phoneContact2.text == "" {
            self.showAlert("Bạn vui lòng nhập thông tin số điện thoại người tham chiếu 1")
            return false
        }
        if phoneContact2.text.first != "0" {
            self.showAlert(
                "Bạn vui lòng nhập số điện thoại người tham chiếu 1 đúng định dạng bắt đầu bằng số 0")
            return false
        }
        if phoneContact2.text.count != 10 {
            self.showAlert("Bạn vui lòng nhập số điện thoại người tham chiếu 1 đúng định dạng 10 số")
            return false
        }

        if ctyView.text == "" {
            self.showAlert("Bạn vui lòng nhập thông tin Công ty")
            return false
        }

        if thunhapView.text == "" {
            self.showAlert("Bạn vui lòng nhập thông tin Thu nhập")
            return false
        }

        if thanhtoanView.text == "" {
            self.showAlert("Bạn vui lòng nhập thông tin ngày thanh toán đầu tiên")
            return false
        }
        if maNoiBoView.text == "" {
            self.showAlert("Bạn vui lòng chọn mã nội bộ")
            return false
        }
        if thanhtoanView.text == "" {
            self.showAlert("Bạn vui lòng nhập thông tin ngày thanh toán đầu tiên")
            return false
        }

        if cmndImmgView.resultLeftImg.image == nil {
            self.showAlert("Bạn vui lòng chụp ảnh  CMND/CCCD mặt trước")
            return false
        }
        if cmndImmgView.resultRightImg.image == nil {
            self.showAlert("Bạn vui lòng chụp ảnh  CMND/CCCD mặt sau")
            return false
        }

        if paperType == 3 {  // gplx
            if gplxImmgView.resultLeftImg.image == nil {
                self.showAlert("Bạn vui lòng chụp ảnh  GIẤY PHÉP LÁI XE mặt trước")
                return false
            }

            if gplxImmgView.resultRightImg.image == nil {
                self.showAlert("Bạn vui lòng chụp ảnh  GIẤY PHÉP LÁI XE mặt sau")
                return false
            }
        } else {  // shk
            if shkImgView1.resultLeftImg.image == nil {
                self.showAlert("Bạn vui lòng chụp ảnh SỔ HỘ KHẨU TRANG ĐẦU")
                return false
            }

            if shkImgView1.resultRightImg.image == nil {
                self.showAlert("Bạn vui lòng chụp ảnh SỔ HỘ KHẨU TRANG CUỐI")
                return false
            }

            if shkImgView2.resultLeftImg.image == nil {
                self.showAlert("Bạn vui lòng chụp ảnh SỔ HỘ KHẨU TRANG THÔNG TIN CÁ NHÂN")
                return false
            }
        }


        if userImageView.resultLeftImg.image == nil {
            self.showAlert("Bạn vui lòng chụp ảnh  CHÂN DUNG KHÁCH HÀNG")
            return false
        }

        if infoPhoneView.resultLeftImg.image == nil {
            self.showAlert("Bạn vui lòng chụp ảnh  THÔNG TIN THUÊ BAO")
            return false
        }
        return true
    }
}

extension ShinhanInfoCustomerVC: RadioCustomDelegate, HeaderInfoDelegate, CustomTxtDelegate {

    func onClickHeader(headerView: UIView) {
        switch headerView.tag {
            case 0:
                self.stackInfo.isHidden = !self.headerInfo.isExpand
                break
            case 1:
                self.stackTamtru.isHidden = !self.headerTamtru.isExpand
                break
            case 2:
                self.stackThuongtru.isHidden = !self.headerThuongtru.isExpand
                break
            case 3:
                self.stackJob.isHidden = !self.headerJob.isExpand
                break
            case 4:
                self.stackcontactUser.isHidden = !self.headerContacUser.isExpand
                break
            case 5:
                self.stackHinhanh.isHidden = !self.headerHinhanh.isExpand
                break
            case 6:
                self.stackGplxSHK.isHidden = !self.headerGPLX.isExpand
            default:
                break
        }
    }

    func onClickRadio(radioView: UIView, tag: Int) {
        if tag == 0 || tag == 1 {
            gender = radioView.tag
            maleRadio.setSelect(isSelect: radioView.tag == 0)
            femaleRadio.setSelect(isSelect: radioView.tag == 1)
        } else if tag == 2 {
            isFamiliarTT = !isFamiliarTT
            tamtruRadio.setSelect(isSelect: isFamiliarTT)
            stackInsideTamtru.isHidden = isFamiliarTT
        } else if tag == 3 || tag == 4 {
            paperType = tag
            gplxRadio.setSelect(isSelect: tag == 3)
            shkRadio.setSelect(isSelect: tag == 4)
            gplxImmgView.isHidden = paperType == 4
            shkStack.isHidden = paperType == 3
        }
    }

    func onClickButton(txt: CustomTxt, tag: Int) {
        if txt == thanhtoanView {
            self.setupDrop()
        }
        if txt == maNoiBoView {
            self.setupDropMaNoiBo()
        }
    }

    func didSelectItemtxt(txt: CustomTxt, tag: Int, value: String) {
        self.view.endEditing(true)
        if txt == noiCapView {
            let filter = self.listCity.filter({ $0.value == value })
            self.selectedNoiCap = filter.first
        } else if txt == cityTTView {
            let filter = self.listCity.filter({ $0.value == value })
            self.selectedCityTT = filter.first

            self.loadDistrict(cityCode: self.selectedCityTT?.id ?? "", isTT: true)

            self.selectedTownTT = nil
            self.townTTView.searchTxt.text = ""
            self.xaTTView.searchTxt.text = ""
            self.selectedXaTT = nil
        } else if txt == townTTView {
            let filter = self.listDistrict.filter({ $0.value == value })
            self.selectedTownTT = filter.first
            self.loadWard(districtCode: selectedTownTT?.id ?? "", isTT: true)
            self.selectedXaTT = nil
            self.xaTTView.searchTxt.text = ""
        } else if txt == xaTTView {
            let filter = self.listWard.filter({ $0.value == value })
            self.selectedXaTT = filter.first
        } else if txt == cityTamtruView {
            let filter = self.listCity.filter({ $0.value == value })
            self.selectedCityTamtru = filter.first

            self.loadDistrict(cityCode: self.selectedCityTamtru?.id ?? "", isTT: false)

            self.selectedTownTamtru = nil
            self.townTamtruView.searchTxt.text = ""
            self.xaTamtruView.searchTxt.text = ""
            self.selectedXaTamtru = nil
        } else if txt == townTamtruView {
            let filter = self.listDistrict.filter({ $0.value == value })
            self.selectedTownTamtru = filter.first
            self.loadWard(districtCode: selectedTownTamtru?.id ?? "", isTT: false)
            self.selectedXaTamtru = nil
            self.xaTamtruView.searchTxt.text = ""
        } else if txt == xaTamtruView {
            let filter = self.listWard.filter({ $0.value == value })
            self.selectedXaTamtru = filter.first
        } else if txt == usermqhView1 {
            let filter = self.listRelationShip.filter({ $0.value == value })
            self.selectedMqh1 = filter.first
        } else if txt == usermqhView2 {
            let filter = self.listRelationShip.filter({ $0.value == value })
            self.selectedMqh2 = filter.first
        }
    }

    func searchTxtChnage(txt: CustomTxt, value: String) {
        if txt == noiCapView {
            self.selectedNoiCap = nil
        } else if txt == cityTTView {
            self.selectedCityTT = nil
        } else if txt == townTTView {
            self.selectedTownTT = nil
        } else if txt == xaTTView {
            self.selectedXaTT = nil
        } else if txt == cityTamtruView {
            self.selectedCityTamtru = nil
        } else if txt == townTamtruView {
            self.selectedTownTamtru = nil
        } else if txt == xaTamtruView {
            self.selectedXaTamtru = nil
        } else if txt == usermqhView1 {
            self.selectedMqh1 = nil
        } else if txt == usermqhView2 {
            self.selectedMqh2 = nil
        }
    }
}

extension ShinhanInfoCustomerVC: ImageFrameCustomDelegate {
    func didPickImage(_ view: ImageFrameCustom, image: UIImage, isLeft: Bool) {
        if let imageData: NSData = image.jpegData(compressionQuality: 0.1) as NSData? {
            let base64Str = imageData.base64EncodedString(options: .endLineWithLineFeed)
            DispatchQueue.main.async {
                if view == self.cmndImmgView {
                    if let imageData: NSData = image.jpegData(
                        compressionQuality: Common.resizeImageScanCMND) as NSData?
                    {
                        let base64Str = imageData.base64EncodedString(
                            options: .endLineWithLineFeed)
                        if isLeft {
                            self.cmndImmgView.resultLeftImg.image = image
                            self.uploadImage(
                                docID: "2",
                                idCard: self.inforFontCmnd?.data.first?.cMND ?? "",
                                base64: base64Str, trackingID: "")
                        } else {
                            self.cmndImmgView.resultRightImg.image = image
                            self.uploadImage(
                                docID: "3",
                                idCard: self.inforFontCmnd?.data.first?.cMND ?? "",
                                base64: base64Str, trackingID: "")
                        }
                    }
                } else if view == self.gplxImmgView {
                    if isLeft {
                        self.uploadImage(
                            docID: "9", idCard: self.inforFontCmnd?.data.first?.cMND ?? "",
                            base64: base64Str, trackingID: "", isLeft: isLeft)
                    } else {
                        self.uploadImage(
                            docID: "13", idCard: self.inforFontCmnd?.data.first?.cMND ?? "",
                            base64: base64Str, trackingID: "", isLeft: isLeft)
                    }
                } else if view == self.userImageView {
                    self.uploadImage(
                        docID: "1", idCard: self.inforFontCmnd?.data.first?.cMND ?? "",
                        base64: base64Str, trackingID: "")
                } else if view == self.infoPhoneView {
                    self.uploadImage(
                        docID: "12", idCard: self.inforFontCmnd?.data.first?.cMND ?? "",
                        base64: base64Str, trackingID: "")
                } else if view == self.shkImgView1 {
                    self.uploadImage(
                        docID: "4", idCard: self.inforFontCmnd?.data.first?.cMND ?? "",
                        base64: base64Str, trackingID: "", isLeft: isLeft, index: 0)
                } else if view == self.shkImgView2 {
                    self.uploadImage(
                        docID: "4", idCard: self.inforFontCmnd?.data.first?.cMND ?? "",
                        base64: base64Str, trackingID: "", isLeft: isLeft, index: 1)
                }
            }
        }
    }
}
