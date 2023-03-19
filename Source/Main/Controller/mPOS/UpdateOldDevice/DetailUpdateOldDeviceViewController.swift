//
//  DetailUpdateOldDeviceViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 4/20/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog
import DropDown

class DetailUpdateOldDeviceViewController: UIViewController {
    
    var itemMayCuEcom: MayCuECom?
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var tfDeviceStatus: UITextField!
    var btnUpdate: UIButton!
    var bottomView: UIView!
    var arrImg = [ItemMayCuEcomImage]()
    var viewContentImg:UIView!
    var arrViewContentImgPhoto = [UIView]()
    
    var imagePicker = UIImagePickerController()
    var posImageUpload:Int = -1
    
    var listColor = [ColorMayCu]()
    var listColorName = [String]()
    var listOrtherAccessories = [AccessoryMayCuEcom]()
    var listOrtherAccessoriesIDChoosed = [String]()
    var listShortDescription = ["Trầy xước ít", "Trầy xước nhiều", "Không trầy xước"]
    let dropColor = DropDown()
    let dropDeviceStatus = DropDown()
    var selectedColor:ColorMayCu?
    var selectedDeviceStatus = ""
    var mayCuEcomDetailItem: MayCuEcomDetail?
    var listImgPhoToTemp = [MayCuEcomDetail_Image]()
    var arrImgCheckView = [UIImageView]()
    var parentNavigationController : UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(itemMayCuEcom?.ItemName ?? "")"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        let acc1 = AccessoryMayCuEcom(id: "1", name: "Hộp máy", isCheck: false)
        let acc2 = AccessoryMayCuEcom(id: "2", name: "Pin", isCheck: false)
        let acc3 = AccessoryMayCuEcom(id: "3", name: "Sạc", isCheck: false)
        let acc4 = AccessoryMayCuEcom(id: "4", name: "Cáp USB", isCheck: false)
        let acc5 = AccessoryMayCuEcom(id: "5", name: "Tai nghe", isCheck: false)
        let acc6 = AccessoryMayCuEcom(id: "6", name: "Sạc Adapter", isCheck: false)
        let acc7 = AccessoryMayCuEcom(id: "7", name: "Không có phụ kiện", isCheck: false)
        let acc8 = AccessoryMayCuEcom(id: "8", name: "Không có sạc", isCheck: false)
        let acc9 = AccessoryMayCuEcom(id: "9", name: "Không tai nghe", isCheck: false)
        let acc10 = AccessoryMayCuEcom(id: "10", name: "Không USB OTG", isCheck: false)
        let acc11 = AccessoryMayCuEcom(id: "11", name: "Không hộp", isCheck: false)
        
        listOrtherAccessories.append(acc1)
        listOrtherAccessories.append(acc2)
        listOrtherAccessories.append(acc3)
        listOrtherAccessories.append(acc4)
        listOrtherAccessories.append(acc5)
        listOrtherAccessories.append(acc6)
        listOrtherAccessories.append(acc7)
        listOrtherAccessories.append(acc8)
        listOrtherAccessories.append(acc9)
        listOrtherAccessories.append(acc10)
        listOrtherAccessories.append(acc11)
        
        self.arrImg.removeAll()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.mpos_FRT_MayCuEcom_GetHinhMau(itemcode: "\(self.itemMayCuEcom?.Sku ?? "")") { (rsHinhMau, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rsHinhMau.count > 0 {
                            for itemHinhMau in rsHinhMau {
                                self.arrImg.append(ItemMayCuEcomImage(imgMau: itemHinhMau, imgThucTe: ""))
                            }
                            if self.itemMayCuEcom?.StatusCode == 2 {//da cap nhat
                                self.getDetailMayCuEcom()
                            } else {
                                self.setUpView()
                            }
                        } else {
                            let popup = PopupDialog(title: "Thông báo", message: "Không có danh sách hình mẫu!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    } else {
                        let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func getDetailMayCuEcom() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.MayCuEcom_GetItemDetail(Id: "\(self.itemMayCuEcom?.ID ?? 0)") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        self.mayCuEcomDetailItem = rs
                        self.setUpView()
                    } else {
                        let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func setUpView() {
        if self.itemMayCuEcom?.StatusCode == 2 { //da cap nhat
            //update Description
            for item in self.listShortDescription {
                if item == self.mayCuEcomDetailItem?.ShortDescription {
                    self.selectedDeviceStatus = item
                }
            }
        } else {
            self.selectedDeviceStatus = self.listShortDescription[0]
        }
        // up hình đã cập nhật
        let listImgMayCu = self.mayCuEcomDetailItem?.listImage ?? []
        var list = listImgMayCu.sorted(by: {$0.DisplayOrder < $1.DisplayOrder})
        
        if self.itemMayCuEcom?.StatusCode == 2 { //da cap nhat
            //remove phần tử displayorder == typeimg hình chụp
            if list.count > 1 {
                list.removeAll(where: {($0.DisplayOrder == 1) && ($0.TypeImage == 1)})
            }
            // update số lượng hình chụp còn thiếu (== sl hình mẫu)
            //map displayorder hình chụp với type-img hình mẫu
            for i in self.arrImg {
                listImgPhoToTemp.append(MayCuEcomDetail_Image(TypeImage: i.imgMau.typeimage, NameDescription: "", PictureID: "0", PictureUrl: "", DisplayOrder: i.imgMau.typeimage))
            }
        
            if list.count <= self.arrImg.count {
                for item in self.arrImg {
                    let indexTemp = item.imgMau.typeimage - 1
                    //check trong list có displayorder đó k
                    if list.contains(where: {$0.DisplayOrder == item.imgMau.typeimage}) {
                        let itemDisplay = list.first(where: {$0.DisplayOrder == item.imgMau.typeimage})
                        listImgPhoToTemp[indexTemp] = itemDisplay!
                    } else {
                        if indexTemp == 0 {
                            listImgPhoToTemp[indexTemp] = MayCuEcomDetail_Image(TypeImage: 0, NameDescription: "", PictureID: "0", PictureUrl: "", DisplayOrder: item.imgMau.typeimage)
                        } else {
                            listImgPhoToTemp[indexTemp] = MayCuEcomDetail_Image(TypeImage: 1, NameDescription: "", PictureID: "0", PictureUrl: "", DisplayOrder: item.imgMau.typeimage)
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
            
            if self.itemMayCuEcom?.StatusCode == 2 {
                if listImgPhoToTemp.count > 0 {
                    Common.encodeURLImg(urlString: "\(listImgPhoToTemp[i].PictureUrl)", imgView: imgPhoto)
                }
            } else {
                imgPhoto.image = #imageLiteral(resourceName: "UploadImage")
            }
            self.arrViewContentImgPhoto.append(imgViewPhoto)
        }
        
        let viewContentImgHeight:CGFloat = CGFloat((self.arrImg.count)) * (imgHeight + Common.Size(s: 35))
        viewContentImg.frame = CGRect(x: viewContentImg.frame.origin.x, y: viewContentImg.frame.origin.y, width: viewContentImg.frame.width, height: viewContentImgHeight)
        
        //bottom view
        bottomView = UIView(frame: CGRect(x: 0, y: viewContentImg.frame.origin.y + viewContentImgHeight + Common.Size(s: 15), width: scrollView.frame.width, height: Common.Size(s: 40)))
        bottomView.backgroundColor = UIColor.white
        scrollView.addSubview(bottomView)

        //tinh trang may
        let deviceStatusTView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s: 40)))
        deviceStatusTView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        bottomView.addSubview(deviceStatusTView)

        let lbDeviceStatusTitle = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: deviceStatusTView.frame.width - Common.Size(s: 30), height: deviceStatusTView.frame.height))
        lbDeviceStatusTitle.text = "TÌNH TRẠNG MÁY"
        lbDeviceStatusTitle.font = UIFont.systemFont(ofSize: 15)
        deviceStatusTView.addSubview(lbDeviceStatusTitle)

        tfDeviceStatus = UITextField(frame: CGRect(x: Common.Size(s: 15), y: deviceStatusTView.frame.origin.y + deviceStatusTView.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfDeviceStatus.font = UIFont.systemFont(ofSize: 14)
        tfDeviceStatus.borderStyle = .roundedRect
        tfDeviceStatus.text = self.selectedDeviceStatus
        bottomView.addSubview(tfDeviceStatus)

        let tapShowDropDeviceStatus = UITapGestureRecognizer(target: self, action: #selector(showDropDeviceStatus))
        tfDeviceStatus.isUserInteractionEnabled = true
        tfDeviceStatus.addGestureRecognizer(tapShowDropDeviceStatus)

        let arrowImgView2 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg2 = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg2.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView2.addSubview(arrowImg2)
        tfDeviceStatus.rightViewMode = .always
        tfDeviceStatus.rightView = arrowImgView2

        //phu kien khac
        let ortherAccessoriesView = UIView(frame: CGRect(x: 0, y: tfDeviceStatus.frame.origin.y + tfDeviceStatus.frame.height + Common.Size(s: 15), width: scrollView.frame.width, height: Common.Size(s: 40)))
        ortherAccessoriesView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        bottomView.addSubview(ortherAccessoriesView)

        let lbOrtherAccessoriesTitle = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: ortherAccessoriesView.frame.width - Common.Size(s: 30), height: ortherAccessoriesView.frame.height))
        lbOrtherAccessoriesTitle.text = "PHỤ KIỆN KHÁC"
        lbOrtherAccessoriesTitle.font = UIFont.systemFont(ofSize: 15)
        ortherAccessoriesView.addSubview(lbOrtherAccessoriesTitle)

        let detailAccessoriesView = UIView(frame: CGRect(x: 0, y: ortherAccessoriesView.frame.origin.y + ortherAccessoriesView.frame.height, width: scrollView.frame.width, height: Common.Size(s:40)))
        bottomView.addSubview(detailAccessoriesView)
        
        if self.mayCuEcomDetailItem != nil {
            self.listOrtherAccessoriesIDChoosed = self.mayCuEcomDetailItem!.Accessories.components(separatedBy: ",")
            for item in self.listOrtherAccessories {
                for id in self.listOrtherAccessoriesIDChoosed {
                    if id == item.id {
                        item.isCheck = true
                    }
                }
            }
        }
        var xPoint: CGFloat = 0
        var yPoint: CGFloat = 0

        self.arrImgCheckView.removeAll()
        for i in 1...self.listOrtherAccessories.count {
            let item = self.listOrtherAccessories[i - 1]

            if i % 2 != 0 {//trái
                let n:Int = i/2
                xPoint = Common.Size(s:15)
                yPoint = Common.Size(s:30) * CGFloat(n + 1)

            } else { //phải
                xPoint = detailAccessoriesView.frame.width/2 + Common.Size(s:7)
                yPoint = Common.Size(s:30) * CGFloat(i/2)
            }

            let itemView = UIView(frame: CGRect(x: xPoint, y: yPoint, width: (detailAccessoriesView.frame.width - Common.Size(s:15))/2, height: Common.Size(s:30)))
            detailAccessoriesView.addSubview(itemView)

            let imgCheck = UIImageView(frame: CGRect(x: 0, y: itemView.frame.height/2 - Common.Size(s: 10), width: Common.Size(s:20), height: Common.Size(s:20)))
            itemView.addSubview(imgCheck)
            
            if item.isCheck {
                imgCheck.image = #imageLiteral(resourceName: "check-1-1")
            } else {
                imgCheck.image = #imageLiteral(resourceName: "check-2-1")
            }
            self.arrImgCheckView.append(imgCheck)
            imgCheck.tag = i
            let tapCheckAccessories = UITapGestureRecognizer(target: self, action: #selector(chooseAccessories(_:)))
            imgCheck.isUserInteractionEnabled = true
            imgCheck.addGestureRecognizer(tapCheckAccessories)
            

            let lbAccessoriesNameX:CGFloat = imgCheck.frame.origin.x + imgCheck.frame.width + Common.Size(s: 5)
            let lbAccessoriesName = UILabel(frame: CGRect(x: lbAccessoriesNameX, y: imgCheck.frame.origin.y, width: itemView.frame.width - lbAccessoriesNameX, height: Common.Size(s:20)))
            lbAccessoriesName.text = "\(item.name)"
            lbAccessoriesName.font = UIFont.systemFont(ofSize: 14)
            itemView.addSubview(lbAccessoriesName)
        }
        let detailAccessoriesViewHeight:CGFloat = ((CGFloat((listOrtherAccessories.count)/2) + 1) * Common.Size(s:30)) + Common.Size(s:15)

        detailAccessoriesView.frame = CGRect(x: detailAccessoriesView.frame.origin.x, y: detailAccessoriesView.frame.origin.y, width: detailAccessoriesView.frame.width, height: detailAccessoriesViewHeight)
        
        btnUpdate = UIButton(frame: CGRect(x: Common.Size(s:15), y: detailAccessoriesView.frame.origin.y +  detailAccessoriesViewHeight + Common.Size(s:30), width: scrollView.frame.width - Common.Size(s:30), height: Common.Size(s:40)))
        btnUpdate.layer.cornerRadius = 5
        btnUpdate.backgroundColor = UIColor(red: 76/255, green: 162/255, blue: 113/255, alpha: 1)
        btnUpdate.setTitle("CẬP NHẬT", for: .normal)
        btnUpdate.addTarget(self, action: #selector(update), for: .touchUpInside)
        bottomView.addSubview(btnUpdate)
        
        bottomView.frame = CGRect(x: bottomView.frame.origin.x, y: bottomView.frame.origin.y, width: bottomView.frame.width, height: btnUpdate.frame.origin.y + btnUpdate.frame.height)
        
        scrollViewHeight = bottomView.frame.origin.y + bottomView.frame.height + ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) + Common.Size(s:30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    @objc func takeImg(_ sender: UITapGestureRecognizer) {
        let view:UIView = sender.view!
        let tag = view.tag
        debugPrint("img_\(tag)")
        self.posImageUpload = tag
        self.openCamera()
    }
    
    @objc func showDropDeviceStatus() {
        self.dropDeviceStatus.show()
        DropDown.setupDefaultAppearance()
        dropDeviceStatus.cellNib = UINib(nibName: "DropDownCell", bundle: Bundle(for: DropDownCell.self))
        dropDeviceStatus.customCellConfiguration = nil
        dropDeviceStatus.dismissMode = .onTap
        dropDeviceStatus.direction = .any
        
        dropDeviceStatus.anchorView = tfDeviceStatus
        DropDown.startListeningToKeyboard();
        
        //Setup datasources
        dropDeviceStatus.dataSource = listShortDescription
        dropDeviceStatus.selectRow(0)
        
        dropDeviceStatus.selectionAction = { [weak self] (index, item) in
            self?.listShortDescription.forEach{
                if($0 == item){
                    self?.selectedDeviceStatus = $0
                    self?.tfDeviceStatus.text = " \($0)"
                }
            }
        }
    }
    
    func updateImgThucTe(strBase64: String, indexImg: Int) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.mpos_FRT_MayCuEcom_UploadImage(base64: strBase64) { (fileImgName, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if !fileImgName.isEmpty {
                            self.arrImg[indexImg].imgThucTe = fileImgName
                        } else {
                            let popup = PopupDialog(title: "Thông báo", message: "File-image-name is null!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    } else {
                        let popup = PopupDialog(title: "Thông báo", message: "\(err)\n \(self.arrImg[indexImg].imgMau.label)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            }
        }
    }
        
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name.init("didEnter_mayCuEcom"), object: nil)
    }
    
    @objc func chooseAccessories(_ sender: UITapGestureRecognizer) {
        let imgView:UIImageView = sender.view! as! UIImageView
        let item = self.listOrtherAccessories[imgView.tag - 1]
        item.isCheck = !item.isCheck
        
        if item.isCheck {
            if item.id == "7" { // khôg có phụ kiện
                for i in 0..<self.listOrtherAccessories.count {
                    self.listOrtherAccessories[i].isCheck = false
                    self.arrImgCheckView[i].image = #imageLiteral(resourceName: "check-2-1")
                }
                self.listOrtherAccessoriesIDChoosed.removeAll()
                item.isCheck = true
                let index7 = self.listOrtherAccessories.firstIndex(of: item) ?? 0
                self.arrImgCheckView[index7].image = #imageLiteral(resourceName: "check-1-1")
                self.listOrtherAccessoriesIDChoosed.append(item.id)
            } else {
                //remove item 7
                imgView.image = #imageLiteral(resourceName: "check-1-1")
                self.listOrtherAccessories[6].isCheck = false
                self.arrImgCheckView[6].image = #imageLiteral(resourceName: "check-2-1")
                if self.listOrtherAccessoriesIDChoosed.count > 0 {
                    self.listOrtherAccessoriesIDChoosed.removeAll(where: {$0 == "7"})
                    self.listOrtherAccessoriesIDChoosed.removeAll(where: {$0 == "\(item.id)"})
                    self.listOrtherAccessoriesIDChoosed.append(item.id)
                } else {
                    self.listOrtherAccessoriesIDChoosed.append(item.id)
                }
            }
        } else {
            imgView.image = #imageLiteral(resourceName: "check-2-1")
            if self.listOrtherAccessoriesIDChoosed.count > 0 {
                self.listOrtherAccessoriesIDChoosed.removeAll(where: {$0 == "\(item.id)"})
            }
        }
    }
    
    @objc func update() {
        let strID = self.listOrtherAccessoriesIDChoosed.joined(separator: ",")
        debugPrint("strID = \(strID)")
        
        guard !strID.isEmpty else {
            let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa chọn phụ kiện!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        
        guard let productID = self.itemMayCuEcom?.ID, productID != 0 else {
            let popup = PopupDialog(title: "Thông báo", message: "ID sản phẩm không được rỗng!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        
        guard let sku = self.itemMayCuEcom?.Sku, !sku.isEmpty else {
            let popup = PopupDialog(title: "Thông báo", message: "Sku sản phẩm không được rỗng!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
            return
        }
        
        if self.itemMayCuEcom?.StatusCode == 1 { // chưa cập nhật
            for item in self.arrImg {
                if (item.imgThucTe.isEmpty) && (item.imgMau.isupload == 1) {
                    let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa cung cấp hình ảnh \(item.imgMau.label)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                        print("Completed")
                    }
                    let buttonOne = CancelButton(title: "OK") {
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    return
                }
            }
        }
        
        var strImg = ""
        for i in 0..<self.arrImg.count {
            let item = self.arrImg[i]
            if i == 0 {
                if !(item.imgThucTe.isEmpty) {
                    strImg = strImg + ("<item>" + "<TypeImage>\(0)</TypeImage>" + "<DisplayOrder>\(item.imgMau.typeimage)</DisplayOrder>" + "<Image>\(item.imgThucTe)</Image>" + "</item>")
                }
            } else {
                if !(item.imgThucTe.isEmpty) {
                    strImg = strImg + ("<item>" + "<TypeImage>\(1)</TypeImage>" + "<DisplayOrder>\(item.imgMau.typeimage)</DisplayOrder>" + "<Image>\(item.imgThucTe)</Image>" + "</item>")
                }
            }
        }
        let xmlImg = "<line>\(strImg)</line>"
        debugPrint("xmlImg: \(xmlImg)")
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.MayCu_Ecom_Update(Id: "\(productID)", Sku: "\(sku)", Accessories: "\(strID)", ShortDescription: self.tfDeviceStatus.text ?? "", xmlistImage: "\(xmlImg)") { (rsCode, message, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rsCode == 1 { //thanh cong
                            let popup = PopupDialog(title: "Thông báo", message: "\(message)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                                self.navigationController?.popViewController(animated: true)
                                NotificationCenter.default.post(name: NSNotification.Name.init("didEnter_mayCuEcom"), object: nil)
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        } else {
                            let popup = PopupDialog(title: "Thông báo", message: "\(message)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                print("Completed")
                            }
                            let buttonOne = CancelButton(title: "OK") {
                            }
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                    } else {
                        let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func setImage(image:UIImage, viewContent: UIView) -> String {
        viewContent.subviews.forEach { $0.removeFromSuperview() }
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: viewContent.frame.width, height: viewContent.frame.height))
        imgView.contentMode = .scaleAspectFit
        imgView.image = image
        viewContent.addSubview(imgView)
        let imgRotate = Common.rotateCameraImageToProperOrientation(imageSource: image, maxResolution: CGFloat(image.cgImage?.width ?? 1000))
        let imageData:NSData = imgRotate!.jpegData(compressionQuality: 0.7)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
        return strBase64
    }
}

extension DetailUpdateOldDeviceViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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

class ItemMayCuEcomImage {
    var imgMau: HinhMauMayCu
    var imgThucTe: String
    
    init(imgMau: HinhMauMayCu, imgThucTe: String) {
        self.imgMau = imgMau
        self.imgThucTe = imgThucTe
    }
}
