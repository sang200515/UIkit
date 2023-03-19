//
//  ChamDiemShopDetailVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 05/10/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown
import DLRadioButton
import Toaster
import Kingfisher

class ChamDiemShopDetailVC: UIViewController {

    @IBOutlet weak var tfShopName:UITextField!
    @IBOutlet weak var tfHangMuc:UITextField!
    @IBOutlet weak var tfDoiTuongChiuTrachNhiem:UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var shopInfoItem:ShopInfo?
    
    var listContentNhomHangMuc:[ContentNhomHangMuc] = []
    var listDoiTuongName:[String] = []
    var listHangMucName:[String] = []
    var selectedHangMuc:ContentNhomHangMuc?
    var selectedDoiTuong:DoiTuongChamDiem?
    var listImageContent:[ImageContent] = []
    var listExpandItem:[ExpandRowDetailChamDiemItem] = []
    
    var imagePicker = UIImagePickerController()
    var lastImg: UIImage!
    var lastSelectedIndex:IndexPath?
    var arrImgThucTe: [UIImage] = []
    var arrDienGiaiLoi: [String] = []
    var arrRadioType:[Int] = []
    
    let dropHangMuc = DropDown()
    let dropDoiTuong = DropDown()
    
    lazy var dropDownMenus: [DropDown] = {
        return [
            self.dropHangMuc,
            self.dropDoiTuong
        ]
    }()
    
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
       
       setUpTableView()
       WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
           mSMApiManager.GetShopInfo { (rs, err) in
               WaitingNetworkResponseAlert.DismissWaitingAlert {
                   if err.count <= 0 {
                       if rs.count <= 0 {
//                            Toast.init(text: "Sai IP Shop. Vui lòng sử dụng Wifi Shop để chấm điểm!").show()
                           let alert = UIAlertController(title: "Thông báo", message: "Sai IP Shop. Vui lòng sử dụng Wifi Shop để chấm điểm!", preferredStyle: .alert)
                           let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                           alert.addAction(action)
                           self.present(alert, animated: true, completion: nil)
                       } else {
                           self.shopInfoItem = rs[0]
                           self.tfShopName.placeholder = self.shopInfoItem?.ShopName ?? ""
                           self.tfShopName.font = UIFont.systemFont(ofSize: 14)
                           self.tfShopName.borderStyle = .roundedRect
                           self.tfShopName.isEnabled = false
                       }
                       self.listContentNhomHangMuc.removeAll()
                       self.listHangMucName.removeAll()
                       self.listDoiTuongName.removeAll()
                       WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                           MPOSAPIManager.Score_GetContentGroupItem(handler: { (results, err) in
                               WaitingNetworkResponseAlert.DismissWaitingAlert {
                                   if results.count > 0 {
                                       for item in results {
                                           self.listContentNhomHangMuc.append(item)
                                       }
                                       for i in self.listContentNhomHangMuc {
                                           self.listHangMucName.append(i.GroupName)
                                       }
                                       
                                       if self.listContentNhomHangMuc.count > 0 {
                                           self.selectedHangMuc = self.listContentNhomHangMuc[0]
                                           
                                           if (self.selectedHangMuc?.ListObject.count)! > 0 {
                                               self.selectedDoiTuong = self.selectedHangMuc?.ListObject[0]
                                               //set up listDoiTuongName
                                               for item in self.selectedHangMuc?.ListObject ?? [] {
                                                   self.listDoiTuongName.append(item.ObjectName)
                                               }
                                           }
                                       }
                                       self.tfHangMuc.text = self.selectedHangMuc?.GroupName ?? ""
                                       self.tfDoiTuongChiuTrachNhiem.text = self.selectedDoiTuong?.ObjectName ?? ""
                                       DispatchQueue.main.async {
                                           self.getImageListContent()
                                       }
                                       
                                   } else {
                                       let alert = UIAlertController(title: "Thông báo", message: "Lấy danh sách nhóm hạng mục thất bại!", preferredStyle: UIAlertController.Style.alert)
                                       let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                       alert.addAction(action)
                                       self.present(alert, animated: true, completion: nil)
                                   }
                               }
                           })
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
       let tapShowDropHangMuc = UITapGestureRecognizer(target: self, action: #selector(showDropHangMuc))
       tfHangMuc.isUserInteractionEnabled = true
       tfHangMuc.addGestureRecognizer(tapShowDropHangMuc)
       let tapShowDropDoiTuong = UITapGestureRecognizer(target: self, action: #selector(showDropDoiTuong))
       tfDoiTuongChiuTrachNhiem.isUserInteractionEnabled = true
       tfDoiTuongChiuTrachNhiem.addGestureRecognizer(tapShowDropDoiTuong)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initListExpandDetailChamDiemItem(listItem:[ImageContent]) {
        self.listExpandItem.removeAll()
        self.arrImgThucTe.removeAll()
        self.arrDienGiaiLoi.removeAll()
        self.arrRadioType.removeAll()
        for item in listItem {
            let newItem = item
            newItem.radioType = "1"
            self.listExpandItem.append(ExpandRowDetailChamDiemItem(isExpand: true, item: item))
            self.arrImgThucTe.append(#imageLiteral(resourceName: "Hinhanh"))
            self.arrDienGiaiLoi.append("")
        }
        
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.tableFooterView?.isHidden = true
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ChamdiemCell", bundle: nil), forCellReuseIdentifier: "ChamdiemCell")
        tableView.isScrollEnabled = false
        let nib = UINib(nibName: "HeaderChamdiem", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "HeaderChamdiem")
    }
    
    func getImageListContent() {
        guard let hangMuc = self.tfHangMuc.text, !hangMuc.isEmpty else {
            showAlert(title: "Thông báo", message: "Bạn chưa nhập hạng mục!")
            return
        }
        
        guard let doiTuong = self.tfDoiTuongChiuTrachNhiem.text, !doiTuong.isEmpty else {
            showAlert(title: "Thông báo", message: "Bạn chưa nhập đối tượng chịu trách nhiệm!")
            return
        }
        
        self.listImageContent.removeAll()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Score_GetImageListContent(GroupID: self.selectedHangMuc?.GroupID ?? 0, ObjectID: self.selectedDoiTuong?.ObjectID ?? 0, handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    
                    if results.count > 0 {
                        for item in results {
                            self.listImageContent.append(item)
                        }
                        self.initListExpandDetailChamDiemItem(listItem: self.listImageContent)
                    } else {
                        debugPrint("khong lay duoc list imgContent")
                    }
                    self.reloadTableView()
                }
            })
        }
        
    }
    
    func reloadTableView() {
        let expandedItem = self.listImageContent.count > 0 ? listExpandItem.filter({$0.isExpand}).count : 0
        let headerHeight: CGFloat = CGFloat(self.listImageContent.count * 65)
        tableViewHeight.constant = CGFloat(expandedItem * 535) + headerHeight
        self.tableView.reloadData()
    }
    
    @objc func confirm() {
        var arrContent = [String]()
        arrContent.removeAll()
        for itemExpand in listExpandItem {
            
            if itemExpand.item.urlImgThucTe.contains(".jpg") == false {
                self.showAlert(title: "Thông báo", message: "Bạn chưa cung cấp đủ hình ảnh thực tế!")
                return
            }
            
            if itemExpand.item.radioType == "" {
                self.showAlert(title: "Thông báo", message: "Bạn chưa chọn mục chấm điểm Đúng/Sai!")
                return
            }
            
            if itemExpand.item.dienGiaiLoi == "" {
                self.showAlert(title: "Thông báo", message: "Bạn chưa nhập ghi chú!")
                return
            }
            
            //            "<line><item U_ContenID=\"1\" U_UrlImage=\"ssss\"  U_Point=\"\" U_ContentBody=\"Test Create phiếu chấm điểm\"/><item U_ContenID=\"2\" U_UrlImage=\"2 - Image\"  U_Point=\"1\" U_ContentBody=\"30870010\"/></line>"
            arrContent.append("<item U_ContenID=\"\(itemExpand.item.ContentID)\" U_UrlImage=\"\(itemExpand.item.urlImgThucTe)\"  U_Point=\"\(itemExpand.item.radioType)\" U_ContentBody=\"\(itemExpand.item.dienGiaiLoi)\"/>")
        }
        
        let strContent = arrContent.joined(separator: "")
        let submitContent = "<line>\(strContent)</line>"
        debugPrint("submitContent: \(submitContent)")
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Score_CreateRequestScore(ObjectID: self.selectedDoiTuong?.ObjectID ?? 0, ShopCode: self.shopInfoItem?.ShopCode ?? "", GroupID: self.selectedHangMuc?.GroupID ?? 0, Content: submitContent.toBase64(), handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
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
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func showDropHangMuc() {
        self.dropHangMuc.show()
        SetupDropMenus()
    }
    
    @objc func showDropDoiTuong() {
        self.dropDoiTuong.show()
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
        dropDoiTuong.anchorView = tfDoiTuongChiuTrachNhiem
        DropDown.startListeningToKeyboard();
        
        //Setup datasources
        dropHangMuc.dataSource = listHangMucName;
        dropHangMuc.selectRow(0);
        
        dropDoiTuong.dataSource = listDoiTuongName;
        dropDoiTuong.selectRow(0);
        
        dropHangMuc.selectionAction = { [weak self] (index, item) in
            self?.listContentNhomHangMuc.forEach{
                if($0.GroupName == item){
                    self?.selectedHangMuc = $0
                    self?.tfHangMuc.text = " \($0.GroupName)"
                }
            }
            self?.listDoiTuongName.removeAll()
            for item in self?.selectedHangMuc?.ListObject ?? [] {
                self?.listDoiTuongName.append(item.ObjectName)
            }
            self?.lastImg = nil
            if (self?.selectedHangMuc?.ListObject.count)! > 0 {
                self?.selectedDoiTuong = self?.selectedHangMuc?.ListObject[0]
            }
          
            self?.tfDoiTuongChiuTrachNhiem.text = " \(self?.selectedDoiTuong?.ObjectName ?? "")"
            self?.getImageListContent()
        }
        
        dropDoiTuong.selectionAction = { [weak self] (index, item) in
            self?.selectedHangMuc?.ListObject.forEach{
                if($0.ObjectName == item){
                    self?.selectedDoiTuong = $0
                    self?.tfDoiTuongChiuTrachNhiem.text = " \($0.ObjectName)"
                }
            }
            self?.lastImg = nil
            self?.getImageListContent()
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

    @IBAction func onConfrim() {
        confirm()
    }
}

extension ChamDiemShopDetailVC: DetailChamDiemCellDelagate {
    func updatePoint(at indexpath: IndexPath, radioType: Int) {
        listExpandItem[indexpath.section].item.radioType = "\(radioType)"
        tableView.reloadData()
    }
    
    func updateTvDienGiaiLoi(at indexpath: IndexPath, text: String) {
        let cell:ChamdiemCell = tableView.cellForRow(at: indexpath) as! ChamdiemCell
        cell.tvDienGiaiLoiText.text = text
        self.arrDienGiaiLoi[indexpath.section] = text
        tableView.reloadData()
    }
    
    
    func showCamera(at indexpath: IndexPath) {
        self.lastSelectedIndex = indexpath
        self.openCamera()
        //        self.thisIsTheFunctionWeAreCalling()
    }
}

extension ChamDiemShopDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return listImageContent.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let itemExpand = listExpandItem[section]
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderChamdiem") as! HeaderChamdiem
        header.lblTitle.text = " \(section + 1). \(itemExpand.item.ContentName)"
        header.button.setTitle("", for: .normal)
        header.onheader = {
            debugPrint("section:\(section)")
            let indexPath = IndexPath(row: 0, section: section)
            
            self.listExpandItem[section].isExpand = !self.listExpandItem[section].isExpand
            let isExpand = self.listExpandItem[section].isExpand
            
            if isExpand {
                tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                tableView.reloadData()
            } else {
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                tableView.reloadData()
            }
            self.reloadTableView()
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listExpandItem[section].isExpand {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChamdiemCell", for: indexPath) as! ChamdiemCell
        let item = listExpandItem[indexPath.section].item
        cell.cellIndexPath = indexPath
        cell.setUpCell(item: item)
        cell.selectionStyle = .none
        cell.delegate = self
        if arrImgThucTe[indexPath.section] != #imageLiteral(resourceName: "Hinhanh") {
            cell.imgViewHinhThucTe.image = arrImgThucTe[indexPath.section]
        } else {
            cell.imgViewHinhThucTe.image = #imageLiteral(resourceName: "Hinhanh")
        }
        if cell.imgViewHinhThucTe.image == #imageLiteral(resourceName: "Hinhanh") {
            if self.lastImg != nil {

                let heightImage:CGFloat = Common.Size(s: 120)
                cell.imgViewHinhThucTe.frame = CGRect(x: cell.imgViewHinhThucTe.frame.origin.x, y: cell.imgViewHinhThucTe.frame.origin.y, width: cell.imgViewHinhThucTe.frame.width, height: heightImage)
                cell.imgViewHinhThucTe.image = self.lastImg
                cell.imgViewHinhThucTe.contentMode = .scaleAspectFit
                self.arrImgThucTe[indexPath.section] = self.lastImg

                self.lastImg = nil
                let img:UIImage = self.resizeImageWidth(image: self.arrImgThucTe[indexPath.section],newWidth: Common.resizeImageWith)!
                let imageData:NSData = (img.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                cell.strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)

                debugPrint("strBase64: \(cell.strBase64)")
                WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                    MPOSAPIManager.Score_UploadImage(Base64String: cell.strBase64, handler: { (resultCode, msg, urlImg, err) in
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            if resultCode == 1 {
                                debugPrint("urlImg: \(urlImg)")
                                cell.urlImgThucTe = urlImg
                                item.urlImgThucTe = urlImg
                            } else {
                                self.showAlert(title: "Thông báo", message: msg)
                            }
                        }
                    })
                }
            } else {
                cell.imgViewHinhThucTe.image = #imageLiteral(resourceName: "Hinhanh")
            }
        }
        
        
        //set img
        if arrImgThucTe[indexPath.section] != #imageLiteral(resourceName: "Hinhanh") {
            cell.imgViewHinhThucTe.image = arrImgThucTe[indexPath.section]
        }
        
        //set textdien giai loi
        cell.tvDienGiaiLoiText.text = self.arrDienGiaiLoi[indexPath.section]
        item.dienGiaiLoi = cell.tvDienGiaiLoiText.text
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 535
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}



extension ChamDiemShopDetailVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
