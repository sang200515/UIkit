//
//  InfoCustomer.swift
//  QuickCode
//
//  Created by Sang Trương on 14/07/2022.
//

import Kingfisher
import UIKit

class InfoCustomer: BaseViewController, ImageFrameCustomDelegate {
    func didPickImage(_ view: ImageFrameCustom, image: UIImage, isLeft: Bool) {

    }


    @IBOutlet weak var chanDungImageView: UIImageView!
    @IBOutlet weak var thueBaoImageView: UIImageView!
    var resultImageChanDung:UIImage?
    var resultImageThuebao:UIImage?

	private var fullAddress: String = ""
	var itemDetail: CreateCustomerModel?
	var itemTableVew: [CreateRefPersons]?
    var listImageSHK : [String] = []
	//MARK: - thông tin cá nhân
	@IBOutlet weak var tfTen: UILabel!
	@IBOutlet weak var tfGioiTinh: UILabel!
	@IBOutlet weak var tfSdt: UILabel!
	@IBOutlet weak var tfNgayThangNam: UILabel!
	@IBOutlet weak var tfEmail: UILabel!
	@IBOutlet weak var lblDiaChi: UILabel!
    @IBOutlet weak var diaChiTamTruLabel: UILabel!
    
    @IBOutlet weak var tfCMND: UILabel!
	@IBOutlet weak var tfNgayCap: UILabel!
	@IBOutlet weak var tfNgayHetHan: UILabel!
	@IBOutlet weak var tfNoiCap: UILabel!

	//MARK: - công ty
	@IBOutlet weak var tfChucVu: UITextField!
	@IBOutlet weak var tfLuong: UITextField!
	@IBOutlet weak var tfSdtCty: UITextField!
	@IBOutlet weak var tfDiaChiCty: UILabel!

	//MARK: - Người liên hệ
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var heightTableViiew: NSLayoutConstraint!
	@IBOutlet weak var tfTenNguoiLienHe: UITextField!
	@IBOutlet weak var tfMoiQuanHe: UITextField!
	@IBOutlet weak var tfSdtNguoiLienHe: UITextField!
	@IBOutlet weak var tfDiaChiNguoiLienHe: UITextField!

	//MARK: - GPLX
	@IBOutlet weak var tfSoGPLX: UITextField!
	@IBOutlet weak var tfNgayCapGPLX: UITextField!
	@IBOutlet weak var tfNoiCapGPLX: UITextField!

	//MARK: - sổ hộ khẩu
	@IBOutlet weak var tfSoSHK: UITextField!
	@IBOutlet weak var tfTenChuHo: UITextField!
	@IBOutlet weak var tfDiaChiThuongTruSHK: UILabel!

    @IBOutlet weak var gplxView: UIStackView!
    @IBOutlet weak var shkView: UIView!
    @IBOutlet weak var frontCMND: ImageFrameCustom!
    @IBOutlet weak var backCMND: ImageFrameCustom!
    @IBOutlet weak var backGPLX: ImageFrameCustom!
    @IBOutlet weak var frontGPLX: ImageFrameCustom!

    @IBOutlet weak var collectionViewSHK: UICollectionView!
    override func viewDidLoad() {
		super.viewDidLoad()
        self.title = "Thông tin khách hàng"
		tableView.dataSource = self
		tableView.delegate = self
        chanDungImageView.isHidden = true
        thueBaoImageView.isHidden = true
//        collectionViewSHK.dataSource = self
//        collectionViewSHK.delegate = self
//        collectionViewSHK.scroll
        frontCMND.controller = self
        backCMND.controller = self
        backCMND.delegate = self

        frontGPLX.controller = self
        backGPLX.controller = self
        frontCMND.delegate = self
        frontGPLX.delegate = self
        backGPLX.delegate = self
		tableView.registerTableCell(InForCustomerCell.self)
        collectionViewSHK.registerCollectionCell(SoHoKhauCollectionCell.self)

        if frontGPLX.resultLeftImg.image == nil {
            frontGPLX.isUserInteractionEnabled = false
            frontCMND.resultLeftImg.image = UIImage()
        }
        if backGPLX.resultLeftImg.image == nil {
            backGPLX.isUserInteractionEnabled = false
            backGPLX.resultLeftImg.image = UIImage()
        }

	}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadInfoCustomer(id: "\(CoreInstallMentData.shared.editID)")
    }
    
    @IBAction func accepOnclicked(_ sender: Any) {
let vc = ListInstallentViewController()
        vc.flowSearch = true
        vc.idCard = itemDetail?.idCard ?? ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(vc, animated: true)
    }
        //MARK: - selector
    @IBAction func edirInfoAction(_ sender: Any) {
            // tag = 0 :;thong kh , 1:hong tin cty  , 2:nguoi lien he , 3 giay to
        switch (sender as AnyObject).tag {
            case 0:
                let vc = DetailCreateCustomer()
                preparareParamForEditFlow()
                vc.flow = "edit"
                vc.titleNav = "Cập nhật thông tin"
                vc.itemDetail = itemDetail
                self.navigationController?.navigationBar.tintColor = .white
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = CreateInfoCompany()
                preparareParamForEditFlow()
                vc.flow = "edit"
                vc.titleNav = "Cập nhật thông tin"
                vc.currentString = "\(itemDetail?.company?.income ?? 0)"
                vc.itemDetail = itemDetail
                CoreInstallMentData.shared.editDiachiCty = itemDetail?.company?.companyAddress ?? ""
                CoreInstallMentData.shared.editInCome = Int(itemDetail?.company?.income ?? 0)
                self.navigationController?.navigationBar.tintColor = .white
                self.navigationController?.pushViewController(vc, animated: true)
            case 2:
                let vc = CreateRelateCustomer()
                preparareParamForEditFlow()
                vc.itemDetail = itemDetail
                vc.flow = "edit"
                vc.titleNav = "Cập nhật thông tin"
                self.navigationController?.navigationBar.tintColor = .white
                self.navigationController?.pushViewController(vc, animated: true)
            case 3:
                let vc = CreateRelateProfile()
                preparareParamForEditFlow()
                vc.itemDetail = itemDetail

                vc.flow = "edit"
                vc.titleNav = "Cập nhật thông tin"
                self.navigationController?.navigationBar.tintColor = .white
                self.navigationController?.pushViewController(vc, animated: true)
            default: return
        }
    }

    func loading(isShow: Bool) {
        let nc = NotificationCenter.default
        if isShow {
            let newViewController = LoadingViewController()
            newViewController.content = "Đang kiểm tra thông tin..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
        } else {
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
        }
    }
	//MARK: - API
	private func loadInfoCustomer(id: String) {
        
        Provider.shared.createCustomerAPIService.loadInfoCustomer(
			id: id,
			success: { [weak self] (result) in
				guard let self = self, let response = result else { return }
                
                if response.error != nil {
                    
                    if response.error?.code == "InstallmentAPI:00400" {
                        self.showAlertOneButton(title: "Thông báo", with: response.error?.details ?? "", titleButton: "OK")
                    }else {
                        self.showAlertOneButton(title: "Thông báo", with: response.error?.message ?? "", titleButton: "OK")
                    }
                    
                    return
                }
                
                self.listImageSHK = []
                CoreInstallMentData.shared.listSHKImageCache = []
                self.itemDetail = response
                self.reloadData()
                self.stopLoading()
                if response.alertMessages?.count ?? 0 > 0 {
                    var message:String = ""
                    response.alertMessages?.forEach({ mess in
                        message += "\(mess). "
                    })
                    self.showAlertOneButton(title: "Thông báo", with: message, titleButton: "OK")
                }
                
                
                
			},
			failure: { [weak self] error in
				guard let self = self else { return }
                self.loading(isShow: false)
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})
	}

    private func setImage(imageFrameCustom: ImageFrameCustom) {
        imageFrameCustom.leftPlaceholderView.isHidden = true
        imageFrameCustom.leftResultView.isHidden = false
        imageFrameCustom.resultLeftImg.layer.masksToBounds = true
    }


	private func reloadData() {
		guard let listFile = itemDetail?.uploadFiles else { return }
		print(listFile)
        if itemDetail?.relatedDocType == "DL" {
            shkView.isHidden = true
            gplxView.isHidden = false
        }else {
            shkView.isHidden = false
            gplxView.isHidden = true
        }
		for i in listFile {
			if i.fileType == "IdCardFront" {
                self.setImage(imageFrameCustom: self.frontCMND)
                let url = URL(string: i.urlImage ?? "")
                self.frontCMND.resultLeftImg.kf.indicatorType = .activity
                self.frontCMND.isUserInteractionEnabled = false
//                let processor = DownsamplingImageProcessor(size: self.frontCMND.resultLeftImg.bounds.size)
                self.frontCMND.resultLeftImg.kf.setImage(
                    with: url, placeholder: UIImage(named: ""),
                    options: [
                        .transition(.fade(1)),
                        .cacheOriginalImage,
                    ],
                    progressBlock: nil
                ) { [weak self] result in
                    guard let self = self else { return }
                    self.frontCMND.isUserInteractionEnabled = true
                    switch result {
                        case .success(let image):
                            self.setImage(imageFrameCustom: self.frontCMND)
                        case .failure(let error):
//                            self.showAlertOneButton(
//                                title: "Thông báo", with: error.errorDescription ?? "",
//                                titleButton: "OK")
                            print(error)

                    }
                }
			}else if i.fileType == "IdCardBack" {
                self.setImage(imageFrameCustom: self.backCMND)
                let url = URL(string: i.urlImage ?? "")
                self.backCMND.resultLeftImg.kf.indicatorType = .activity
                self.backCMND.isUserInteractionEnabled = false
                    //                let processor = DownsamplingImageProcessor(size: self.frontCMND.resultLeftImg.bounds.size)
                self.backCMND.resultLeftImg.kf.setImage(
                    with: url, placeholder: UIImage(named: ""),
                    options: [
                        .transition(.fade(1)),
                        .cacheOriginalImage,
                    ],
                    progressBlock: nil
                ) { [weak self] result in
                    guard let self = self else { return }
                    self.backCMND.isUserInteractionEnabled = true
                    switch result {
                        case .success(let image):
                            self.setImage(imageFrameCustom: self.backCMND)
                        case .failure(let error):
//                            self.showAlertOneButton(
//                                title: "Thông báo", with: error.errorDescription ?? "",
//                                titleButton: "OK")
                            print(error)

                    }
                }
			}else if i.fileType == "DLFront" {
                self.backGPLX.isUserInteractionEnabled = false
                self.setImage(imageFrameCustom: self.backGPLX)
                let url = URL(string: i.urlImage ?? "")
                self.backGPLX.resultLeftImg.kf.indicatorType = .activity
                self.backGPLX.isUserInteractionEnabled = false
                    //                let processor = DownsamplingImageProcessor(size: self.frontCMND.resultLeftImg.bounds.size)
                self.backGPLX.resultLeftImg.kf.setImage(
                    with: url, placeholder: UIImage(named: ""),
                    options: [
                        .transition(.fade(1)),
                        .cacheOriginalImage,
                    ],
                    progressBlock: nil
                ) { [weak self] result in
                    guard let self = self else { return }
                    self.backGPLX.isUserInteractionEnabled = true
                    switch result {
                        case .success(let image):
                            self.setImage(imageFrameCustom: self.backGPLX)
                        case .failure(let error):
//                            self.showAlertOneButton(
//                                title: "Thông báo", with: error.errorDescription ?? "",
//                                titleButton: "OK")
                            print(error)

                    }
                }
//                backGPLX.isUserInteractionEnabled = true
			}else if i.fileType == "DLBack" {
                self.frontGPLX.isUserInteractionEnabled = false
                self.setImage(imageFrameCustom: self.frontGPLX)
                let url = URL(string: i.urlImage ?? "")
                self.frontGPLX.resultLeftImg.kf.indicatorType = .activity
                self.frontGPLX.isUserInteractionEnabled = false
                self.frontGPLX.resultLeftImg.kf.setImage(
                    with: url, placeholder: UIImage(named: ""),
                    options: [
                        .transition(.fade(1)),
                        .cacheOriginalImage,
                    ],
                    progressBlock: nil
                ) { [weak self] result in
                    guard let self = self else { return }
                    self.frontGPLX.isUserInteractionEnabled = true
                    switch result {
                        case .success(let image):
                            self.setImage(imageFrameCustom: self.frontGPLX)
                        case .failure(let error):
//                            self.showAlertOneButton(
//                                title: "Thông báo", with: error.errorDescription ?? "",
//                                titleButton: "OK")
                            print(error)

                    }
                }
            }else if i.fileType == "SELFIE"{
//                chanDungImageView.downloadedFrom(link:i.urlImage ?? "")
//                chanDungImageView.image = chanDungImageView.image ?? UIImage()
            }else if i.fileType == "SIM_CARD_OWNER"{
//                thueBaoImageView.downloadedFrom(link:i.urlImage ?? "")
//                thueBaoImageView.image = thueBaoImageView.image ?? UIImage()
            }else {
                listImageSHK.append(i.urlImage ?? "")
                CoreInstallMentData.shared.listSHKImageCache.append(UIImage())
            }

		}
        if listImageSHK.count == 0 {
            collectionViewSHK.isHidden = true
        }else {
            collectionViewSHK.isHidden = false
            collectionViewSHK.reloadData()
        }


		tfTen.text = itemDetail?.fullName
        tfGioiTinh.text = itemDetail?.gender == 0 ? "Nữ" : "Nam"
		tfSdt.text = itemDetail?.phone
		tfNgayThangNam.text = itemDetail?.birthDate
		tfEmail.text = itemDetail?.email

		lblDiaChi.text = "\(itemDetail?.addresses?[0].fullAddress ?? "")"
        self.diaChiTamTruLabel.text = itemDetail?.addresses?[1].fullAddress ?? ""
		tfCMND.text = itemDetail?.idCard
		tfNgayCap.text = itemDetail?.idCardIssuedDate ?? ""

		tfEmail.text = itemDetail?.email
        tfNgayHetHan.text = itemDetail?.idCardIssuedExpiration ?? ""

		tfNoiCap.text = itemDetail?.idCardIssuedBy
		tfChucVu.text = itemDetail?.company?.position
        tfLuong.text = Common.convertCurrencyFloat(value: itemDetail?.company?.income ?? 0)
        tfSdtCty.text = itemDetail?.company?.companyPhone
		tfDiaChiCty.text = itemDetail?.company?.companyAddress
        tfDiaChiCty.isUserInteractionEnabled = false
		itemTableVew = itemDetail?.refPersons
		heightTableViiew.constant = CGFloat((itemDetail?.refPersons?.count ?? 0) * 120)
		tableView.reloadData()
		tableView.backgroundColor = .red
		//        tfTenNguoiLienHe.text = item.
		//        tfMoiQuanHe.text = item.
		//        tfSdtNguoiLienHe.text = item.
		//        tfDiaChiNguoiLienHe.text = item.

		tfSoGPLX.text = itemDetail?.relatedDocument?.drivingLicNum
		tfNgayCapGPLX.text = itemDetail?.relatedDocument?.drivingLicNumDate

		tfNoiCapGPLX.text = itemDetail?.relatedDocument?.drivingLicNumBy
		tfSoSHK.text = itemDetail?.relatedDocument?.houseBookNum
		tfTenChuHo.text = itemDetail?.relatedDocument?.houseBookName
		tfDiaChiThuongTruSHK.text = itemDetail?.relatedDocument?.houseBookAddress
	}

}

extension InfoCustomer: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemTableVew?.count ?? 0
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 120

	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueTableCell(InForCustomerCell.self)
		cell.bindCell(item: (itemTableVew?[indexPath.row])!, index: indexPath.row)
		return cell
	}
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}

}
extension InfoCustomer: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImageSHK.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueCollectionCell(SoHoKhauCollectionCell.self, indexPath: indexPath)
        cell.bindCell(item: listImageSHK[indexPath.row], controller: self,index: indexPath.row)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 91, height: 85)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension InfoCustomer {
    private func preparareParamForEditFlow(){
        CoreInstallMentData.shared.editFirstName = itemDetail?.firstName ?? ""
        CoreInstallMentData.shared.editMiddleName = itemDetail?.middleName ?? ""
        CoreInstallMentData.shared.editLastName = itemDetail?.lastName ?? ""
        CoreInstallMentData.shared.editIdCard = itemDetail?.idCard ?? ""
        CoreInstallMentData.shared.editIdCardType = itemDetail?.idCardType ?? 0
        CoreInstallMentData.shared.editEmail = itemDetail?.email ?? ""
        CoreInstallMentData.shared.editBirthDate = itemDetail?.birthDate ?? ""
        CoreInstallMentData.shared.editIdCardIssuedBy = itemDetail?.idCardIssuedBy ?? ""
        CoreInstallMentData.shared.editIdCardIssuedByCode = itemDetail?.idCardIssuedByCode ?? ""
        CoreInstallMentData.shared.editIdCardIssuedDate = itemDetail?.idCardIssuedDate ?? ""
        CoreInstallMentData.shared.editIdCardIssuedExpiration = itemDetail?.idCardIssuedExpiration ?? ""
        CoreInstallMentData.shared.editPhone = itemDetail?.phone ?? ""
        CoreInstallMentData.shared.editGender = itemDetail?.gender ?? 0

        CoreInstallMentData.shared.editID = itemDetail?.id ?? 0
        CoreInstallMentData.shared.editrelatedDocumentType = itemDetail?.relatedDocType ?? ""

        CoreInstallMentData.shared.editCompanyDetail =  saveDataLocalCompany()
        CoreInstallMentData.shared.editItemNguoiLienHe1 =  itemRefPerson1()
        CoreInstallMentData.shared.editItemNguoiLienHe2 =  itemRefPerson2()
        CoreInstallMentData.shared.editItemListNguoiLienHe = [CoreInstallMentData.shared.editItemNguoiLienHe1,CoreInstallMentData.shared.editItemNguoiLienHe2]
        CoreInstallMentData.shared.ediItemDocument =  itemDocument()
        CoreInstallMentData.shared.editItemDiaChiTT =  addItemDiaChi(addressType: 0) 
        CoreInstallMentData.shared.editItemDiaChiTamTru = addItemDiaChi(addressType: 1)
        CoreInstallMentData.shared.editfullAddressCompany = itemDetail?.company?.companyAddress ?? ""

            //image
        guard let list = itemDetail?.uploadFiles else { return }
        CoreInstallMentData.shared.editListSHKImage.removeAll()
        for item in list {
            if item.fileType == "IdCardFront"{
                CoreInstallMentData.shared.editPathIDCardFront = addEditUploadImage(fileName: item.fileName ?? "", fileType: item.fileType ?? "", urlImage: item.urlImage ?? "")
            }else if item.fileType == "IdCardBack"{
                CoreInstallMentData.shared.editPathIDCardBack = addEditUploadImage(fileName: item.fileName ?? "", fileType: item.fileType ?? "", urlImage: item.urlImage ?? "")
            }else if item.fileType == "SELFIE"{
                CoreInstallMentData.shared.editPathChanDung = addEditUploadImage(fileName: item.fileName ?? "", fileType: item.fileType ?? "", urlImage: item.urlImage ?? "")
            }else if item.fileType == "SIM_CARD_OWNER"{
                CoreInstallMentData.shared.editPathIDThueBao = addEditUploadImage(fileName: item.fileName ?? "", fileType: item.fileType ?? "", urlImage: item.urlImage ?? "")
            }else if item.fileType == "DLFront"{
                CoreInstallMentData.shared.editPathIDDLFront =  addEditUploadImage(fileName: item.fileName ?? "", fileType: item.fileType ?? "", urlImage: item.urlImage ?? "")
            }else if item.fileType == "DLBack"{
                CoreInstallMentData.shared.editPathIDDLBack =  addEditUploadImage(fileName: item.fileName ?? "", fileType: item.fileType ?? "", urlImage: item.urlImage ?? "")
            }else {
                CoreInstallMentData.shared.editListSHKImage.append(addEditUploadImage(fileName: item.fileName ?? "", fileType: item.fileType ?? "", urlImage: item.urlImage ?? ""))
            }
        }
        if CoreInstallMentData.shared.editListSHKImage.count == 0 {
            CoreInstallMentData.shared.editListSHKImage.append(contentsOf: [ addEditUploadImage(fileName: "", fileType: "", urlImage: ""), addEditUploadImage(fileName: "", fileType: "", urlImage: ""), addEditUploadImage(fileName: "", fileType: "", urlImage: "") ])
        }
    }


    private func saveDataLocalCompany() -> [String: Any] {
        var detail = [String: Any]()
        detail["companyName"] = itemDetail?.company?.companyName ?? ""
        detail["companyAddress"] = itemDetail?.company?.companyAddress
        detail["position"] = itemDetail?.company?.position
        detail["income"] = itemDetail?.company?.income
        detail["workYear"] = itemDetail?.company?.workYear
        detail["workMonth"] = itemDetail?.company?.workMonth
        detail["companyPhone"] = itemDetail?.company?.companyPhone
        return detail
    }
    private func itemRefPerson1() -> [String: Any] {
        var detail = [String: Any]()
        detail["fullName"] = itemDetail?.refPersons?[0].fullName
        detail["relationshipCode"] = itemDetail?.refPersons?[0].relationshipCode
        detail["relationshipName"] = itemDetail?.refPersons?[0].relationshipName //sua lai
        detail["personNum"] = itemDetail?.refPersons?[0].personNum
        detail["phone"] = itemDetail?.refPersons?[0].phone
        return detail
    }
    private func itemRefPerson2() -> [String: Any] {
        var detail = [String: Any]()
        detail["fullName"] = itemDetail?.refPersons?[1].fullName
        detail["relationshipCode"] = itemDetail?.refPersons?[1].relationshipCode
        detail["relationshipName"] = itemDetail?.refPersons?[1].relationshipName//sua lai
        detail["personNum"] = itemDetail?.refPersons?[1].personNum
        detail["phone"] = itemDetail?.refPersons?[1].phone
        return detail
    }
    private func itemDocument() -> [String:Any]{
        var detail = [String:Any]()
        detail["drivingLicNum"] =  itemDetail?.relatedDocument?.drivingLicNum ?? ""
        detail["drivingLicNumDate"] =  itemDetail?.relatedDocument?.drivingLicNumDate ?? ""
        detail["drivingLicNumBy"] =  itemDetail?.relatedDocument?.drivingLicNumBy ?? ""
        detail["houseBookNum"] =  itemDetail?.relatedDocument?.houseBookNum ?? ""
        detail["houseBookName"] =  itemDetail?.relatedDocument?.houseBookName ?? ""
        detail["houseBookAddress"] =  itemDetail?.relatedDocument?.houseBookAddress ?? ""
        return detail
    }
    private func addEditUploadImage(fileName:String,fileType:String,urlImage:String) -> [String:Any]{
        var detail = [String:Any]()
        detail["fileType"] = fileType
        detail["fileName"] = fileName
        detail["urlImage"] = urlImage
        return detail
    }
    private func addItemDiaChi(addressType:Int) -> [String: Any] {
        var detail = [String: Any]()
        detail["provinceCode"] = itemDetail?.addresses?[addressType].provinceCode ?? ""
        detail["provinceName"] = itemDetail?.addresses?[addressType].provinceName ?? ""
        detail["districtCode"] = itemDetail?.addresses?[addressType].districtCode ?? ""
        detail["districtName"] = itemDetail?.addresses?[addressType].districtName ?? ""
        detail["wardCode"] = itemDetail?.addresses?[addressType].wardCode ?? ""
        detail["wardName"] = itemDetail?.addresses?[addressType].wardName ?? ""
        detail["street"] = itemDetail?.addresses?[addressType].street ?? ""
        detail["houseNo"] = itemDetail?.addresses?[addressType].houseNo ?? ""
        detail["addressType"] = itemDetail?.addresses?[addressType].addressType ?? ""
        detail["fullAddress"] = itemDetail?.addresses?[addressType].fullAddress ?? ""
        return detail
    }

}
