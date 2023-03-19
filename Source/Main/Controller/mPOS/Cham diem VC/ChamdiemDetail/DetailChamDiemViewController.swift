//
//  DetailChamDiemViewController.swift
//  fptshop
//
//  Created by Apple on 6/13/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DropDown
import DLRadioButton
import Toaster
import Kingfisher

class DetailChamDiemViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var cellHeight:CGFloat = Common.Size(s: 50)
    var tfShopName:UITextField!
    var tfHangMuc:UITextField!
    var tfDoiTuongChiuTrachNhiem:UITextField!
    var tableView: UITableView!
    var contentView: UIView!
    var btnConfirm: UIButton!
    var lbDoiTuong: UILabel!
    var tableViewHeight:CGFloat = 0
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
    var isFirstSetTableViewHeight = true
    
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
                                        
                                        DispatchQueue.main.async {
                                            self.setUpView()
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
    }
    
    func initListExpandDetailChamDiemItem(listItem:[ImageContent]) {
        self.listExpandItem.removeAll()
        self.arrImgThucTe.removeAll()
        self.arrDienGiaiLoi.removeAll()
        self.arrRadioType.removeAll()
        for item in listItem {
            self.listExpandItem.append(ExpandRowDetailChamDiemItem(isExpand: true, item: item))
            self.arrImgThucTe.append(#imageLiteral(resourceName: "Hinhanh"))
            self.arrDienGiaiLoi.append("")
            self.arrRadioType.append(1)
        }
        
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: contentView.frame.origin.y + contentView.frame.height, width: self.view.frame.width, height: 40))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(DetailChamDiemCell.self, forCellReuseIdentifier: "detailChamDiemCell")
        tableView.isScrollEnabled = false
        scrollView.addSubview(tableView)
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
        if self.tableView != nil {
            self.tableView.removeFromSuperview()
        }

        let expandedItem = self.listImageContent.count > 0 ? listExpandItem.filter({$0.isExpand}).count : 0
        tableViewHeight = CGFloat(expandedItem * 500) + CGFloat(Common.Size(s: 40) * CGFloat(self.listImageContent.count)) + ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        tableView = UITableView(frame: CGRect(x: 0, y: contentView.frame.origin.y + contentView.frame.height, width: self.view.frame.width, height: tableViewHeight))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(DetailChamDiemCell.self, forCellReuseIdentifier: "detailChamDiemCell")
        tableView.isScrollEnabled = false
        scrollView.addSubview(tableView)
        
        self.lbDoiTuong.frame = CGRect(x: self.lbDoiTuong.frame.origin.x, y: self.tableView.frame.origin.y + self.tableView.frame.height + Common.Size(s: 15), width: self.lbDoiTuong.frame.width, height: self.lbDoiTuong.frame.height)
        
        self.tfDoiTuongChiuTrachNhiem.frame = CGRect(x: self.tfDoiTuongChiuTrachNhiem.frame.origin.x, y: self.lbDoiTuong.frame.origin.y + self.lbDoiTuong.frame.height + Common.Size(s: 15), width: self.tfDoiTuongChiuTrachNhiem.frame.width, height: self.tfDoiTuongChiuTrachNhiem.frame.height)
        
        self.btnConfirm.frame = CGRect(x: self.btnConfirm.frame.origin.x, y: self.tfDoiTuongChiuTrachNhiem.frame.origin.y + self.tfDoiTuongChiuTrachNhiem.frame.height + Common.Size(s: 15), width: self.btnConfirm.frame.width, height: self.btnConfirm.frame.height)
        
        self.scrollViewHeight = self.btnConfirm.frame.origin.y + self.btnConfirm.frame.height + Common.Size(s: 50)
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollViewHeight)
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
        //        tfShopName.placeholder = "\(Cache.user?.ShopName ?? "")"
        tfShopName.placeholder = self.shopInfoItem?.ShopName ?? ""
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
        tfHangMuc.text = self.selectedHangMuc?.GroupName ?? ""
        scrollView.addSubview(tfHangMuc)
        
        let tapShowDropHangMuc = UITapGestureRecognizer(target: self, action: #selector(showDropHangMuc))
        tfHangMuc.isUserInteractionEnabled = true
        tfHangMuc.addGestureRecognizer(tapShowDropHangMuc)
        
        let arrowImgView1 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg1 = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg1.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView1.addSubview(arrowImg1)
        tfHangMuc.rightViewMode = .always
        tfHangMuc.rightView = arrowImgView1
        
        contentView = UIView(frame: CGRect(x: 0, y: tfHangMuc.frame.origin.y + tfHangMuc.frame.height + Common.Size(s: 10), width: scrollView.frame.width, height: Common.Size(s: 40)))
        contentView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        scrollView.addSubview(contentView)
        
        let lbContent = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: contentView.frame.width - Common.Size(s: 30), height: contentView.frame.height))
        lbContent.text = "NỘI DUNG CHẤM ĐIỂM"
        contentView.addSubview(lbContent)
        
        self.setUpTableView()
        
        lbDoiTuong = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tableView.frame.origin.y + tableView.frame.height + Common.Size(s: 10), width: lbShop.frame.width, height: Common.Size(s: 20)))
        lbDoiTuong.text = "Đối tượng chịu trách nhiệm:"
        lbDoiTuong.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbDoiTuong)
        
        tfDoiTuongChiuTrachNhiem = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbDoiTuong.frame.origin.y + lbDoiTuong.frame.height + Common.Size(s: 5), width: tfShopName.frame.width, height: Common.Size(s: 35)))
        //        tfDoiTuongChiuTrachNhiem.placeholder = "Nhập đối tượng"
        tfDoiTuongChiuTrachNhiem.font = UIFont.systemFont(ofSize: 14)
        tfDoiTuongChiuTrachNhiem.borderStyle = .roundedRect
        tfDoiTuongChiuTrachNhiem.text = self.selectedDoiTuong?.ObjectName ?? ""
        scrollView.addSubview(tfDoiTuongChiuTrachNhiem)
        
        let tapShowDropDoiTuong = UITapGestureRecognizer(target: self, action: #selector(showDropDoiTuong))
        tfDoiTuongChiuTrachNhiem.isUserInteractionEnabled = true
        tfDoiTuongChiuTrachNhiem.addGestureRecognizer(tapShowDropDoiTuong)
        
        let arrowImgView2 = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg2 = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg2.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView2.addSubview(arrowImg2)
        tfDoiTuongChiuTrachNhiem.rightViewMode = .always
        tfDoiTuongChiuTrachNhiem.rightView = arrowImgView2
        
        btnConfirm = UIButton(frame: CGRect(x: Common.Size(s: 15), y: tfDoiTuongChiuTrachNhiem.frame.origin.y + tfDoiTuongChiuTrachNhiem.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnConfirm.setTitle("XÁC NHẬN", for: .normal)
        btnConfirm.titleLabel?.textColor = UIColor.white
        btnConfirm.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btnConfirm.layer.cornerRadius = 5
        btnConfirm.backgroundColor = UIColor(red: 34/255, green: 134/255, blue: 70/255, alpha: 1)
        scrollView.addSubview(btnConfirm)
        btnConfirm.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        
        scrollViewHeight = btnConfirm.frame.origin.y + btnConfirm.frame.height + Common.Size(s: 100)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
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
}

extension DetailChamDiemViewController: DetailChamDiemCellDelagate {
    func updatePoint(at indexpath: IndexPath, radioType: Int) {
        self.arrRadioType[indexpath.section] = radioType
        tableView.reloadData()
    }
    
    func updateTvDienGiaiLoi(at indexpath: IndexPath, text: String) {
        let cell:DetailChamDiemCell = tableView.cellForRow(at: indexpath) as! DetailChamDiemCell
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

extension DetailChamDiemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return listImageContent.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let itemExpand = listExpandItem[section]
        
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Common.Size(s: 40)))
        headerView.delegate = self
        headerView.secIndex = section
        headerView.lbTitle.text = " \(section + 1). \(itemExpand.item.ContentName)"
        
        if (section % 2) == 0 {
            headerView.backgroundColor = UIColor.white
        } else {
            headerView.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !(listExpandItem[section].isExpand){
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DetailChamDiemCell = tableView.dequeueReusableCell(withIdentifier: "detailChamDiemCell", for: indexPath) as! DetailChamDiemCell
        let item = listExpandItem[indexPath.section].item
        cell.cellIndexPath = indexPath
        cell.setUpCell(item: item)
        cell.selectionStyle = .none
        self.cellHeight = cell.estimateCellHeight
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
        
        //set radioType
        cell.radioType = self.arrRadioType[indexPath.section]
        if cell.radioType == 1 {
            item.radioType = "1"
            Cache.radioType = 1
            cell.radioTrue.isSelected = true
        } else if cell.radioType == 2 {
            item.radioType = "2"
            Cache.radioType = 2
            cell.radioFalse.isSelected = true
        } else {
            item.radioType = ""
            Cache.radioType = 0
            cell.radioFalse.isSelected = false
            cell.radioFalse.isSelected = false
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
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Common.Size(s: 40)
    }
}

extension DetailChamDiemViewController:HeaderViewDelegate {
    func clickHeader(inx: Int) {
        let section = inx
        debugPrint("section:\(section)_ btnTag:\(inx)")
        let indexPath = IndexPath(row: 0, section: inx)
        
        listExpandItem[section].isExpand = !listExpandItem[section].isExpand
        let isExpand = listExpandItem[section].isExpand
        
        if isExpand {
            tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            tableView.reloadData()
        } else {
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            tableView.reloadData()
        }
        reloadTableView()
    }
}



extension DetailChamDiemViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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

//--------------------------------------------------------------------
protocol DetailChamDiemCellDelagate: AnyObject {
    func showCamera(at indexpath:IndexPath)
    func updatePoint(at indexpath:IndexPath, radioType:Int)
    func updateTvDienGiaiLoi(at indexpath:IndexPath, text:String)
}

class DetailChamDiemCell: UITableViewCell, UITextViewDelegate {
    
    var imgViewHinhMau: UIImageView!
    var imgViewHinhThucTe: UIImageView!
    var tvDienGiaiLoiText: UITextView!
    
    var radioTrue:DLRadioButton!
    var radioFalse:DLRadioButton!
    var radioType:Int = 1
    var estimateCellHeight: CGFloat = 0
    var cellIndexPath:IndexPath?
    var strBase64 = ""
    var urlImgThucTe = ""
    
    var delegate:DetailChamDiemCellDelagate?
    
    func setUpCell(item:ImageContent) {
        self.subviews.forEach({$0.removeFromSuperview()})
        let lbHinhMau = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: self.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbHinhMau.text = "Hình mẫu"
        lbHinhMau.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbHinhMau)
        
        imgViewHinhMau = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: lbHinhMau.frame.origin.y + lbHinhMau.frame.height + Common.Size(s: 5), width: self.frame.width - Common.Size(s: 30), height: Common.Size(s: 120)))
        imgViewHinhMau.layer.borderColor = UIColor.lightGray.cgColor
        imgViewHinhMau.layer.borderWidth = 1
        imgViewHinhMau.image = #imageLiteral(resourceName: "Hinhanh")
        self.addSubview(imgViewHinhMau)
        
        //set url img
        guard let urlImg = URL(string: "\(item.UrlImageSample)") else {
            imgViewHinhMau.image = #imageLiteral(resourceName: "Hinhanh")
            return
        } 
        
        imgViewHinhMau.kf.indicatorType = .activity
        imgViewHinhMau.kf.setImage(with: urlImg)
//        let data = try? Data(contentsOf: urlImg)
//        if let imageData = data {
//            let image = UIImage(data: imageData)
//            imgViewHinhMau.image = image
//        }
        
        let lbHinhThucTe = UILabel(frame: CGRect(x: Common.Size(s: 15), y: imgViewHinhMau.frame.origin.y + imgViewHinhMau.frame.height + Common.Size(s: 10), width: self.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbHinhThucTe.text = "Hình thực tế"
        lbHinhThucTe.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbHinhThucTe)
        
        imgViewHinhThucTe = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: lbHinhThucTe.frame.origin.y + lbHinhThucTe.frame.height + Common.Size(s: 5), width: self.frame.width - Common.Size(s: 30), height: Common.Size(s: 120)))
        imgViewHinhThucTe.layer.borderColor = UIColor.lightGray.cgColor
        imgViewHinhThucTe.layer.borderWidth = 1
        imgViewHinhThucTe.image = #imageLiteral(resourceName: "Hinhanh")
        self.addSubview(imgViewHinhThucTe)
        
        let tapTakePhoto = UITapGestureRecognizer(target: self, action: #selector(takePhoto))
        imgViewHinhThucTe.isUserInteractionEnabled = true
        imgViewHinhThucTe.addGestureRecognizer(tapTakePhoto)
        
        let lbChamDiem = UILabel(frame: CGRect(x: Common.Size(s: 15), y: imgViewHinhThucTe.frame.origin.y + imgViewHinhThucTe.frame.height + Common.Size(s: 10), width: self.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbChamDiem.text = "Chấm điểm"
        lbChamDiem.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbChamDiem)
        
        radioTrue = createRadioButtonGender(CGRect(x: lbChamDiem.frame.origin.x, y:lbChamDiem.frame.origin.y + lbChamDiem.frame.size.height + Common.Size(s:5) , width: lbChamDiem.frame.size.width/3, height: Common.Size(s:15)), title: "Đúng", color: UIColor.black);
        self.addSubview(radioTrue)
        
        radioFalse = createRadioButtonGender(CGRect(x: radioTrue.frame.origin.x + radioTrue.frame.size.width ,y:radioTrue.frame.origin.y, width: radioTrue.frame.size.width, height: radioTrue.frame.size.height), title: "Sai", color: UIColor.black);
        self.addSubview(radioFalse)
        
        
        let lbDienGiaiLoi = UILabel(frame: CGRect(x: Common.Size(s: 15), y: radioFalse.frame.origin.y + radioFalse.frame.height + Common.Size(s: 10), width: self.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbDienGiaiLoi.text = "Ghi chú"
        lbDienGiaiLoi.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbDienGiaiLoi)
        
        tvDienGiaiLoiText = UITextView(frame: CGRect(x: Common.Size(s: 15), y: lbDienGiaiLoi.frame.origin.y + lbDienGiaiLoi.frame.height + Common.Size(s: 5), width: self.frame.width - Common.Size(s: 30), height: Common.Size(s: 70)))
        tvDienGiaiLoiText.font = UIFont.systemFont(ofSize: 14)
        tvDienGiaiLoiText.layer.cornerRadius = 5
        tvDienGiaiLoiText.layer.borderColor = UIColor.lightGray.cgColor
        tvDienGiaiLoiText.layer.borderWidth = 1
        tvDienGiaiLoiText.returnKeyType = .done
        tvDienGiaiLoiText.delegate = self
        self.addSubview(tvDienGiaiLoiText)
        
        estimateCellHeight = tvDienGiaiLoiText.frame.origin.y + tvDienGiaiLoiText.frame.height + Common.Size(s: 30)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            tvDienGiaiLoiText.text = textView.text
            debugPrint("tvDienGiaiLoiText.text: \(tvDienGiaiLoiText.text ?? "")")
            self.delegate?.updateTvDienGiaiLoi(at: cellIndexPath!, text: tvDienGiaiLoiText.text)
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        tvDienGiaiLoiText.text = textView.text
        debugPrint("tvDienGiaiLoiText.text: \(tvDienGiaiLoiText.text ?? "")")
        self.delegate?.updateTvDienGiaiLoi(at: cellIndexPath!, text: tvDienGiaiLoiText.text)
    }
    
    
    
    @objc func takePhoto(){
        self.delegate?.showCamera(at: cellIndexPath!)
    }
    
    fileprivate func createRadioButtonGender(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:12));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.addSubview(radioButton);
        
        return radioButton;
    }
    
    @objc fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioTrue.isSelected = false
            radioFalse.isSelected = false
            switch temp {
            case "Đúng":
                radioType = 1
                Cache.radioType = 1
                radioTrue.isSelected = true
                break
            case "Sai":
                radioType = 2
                Cache.radioType = 2
                radioFalse.isSelected = true
                break
            default:
                radioType = 0
                Cache.radioType = 0
                break
            }
            
            self.delegate?.updatePoint(at: cellIndexPath!, radioType: radioType)
        }
    }
}

struct ExpandRowDetailChamDiemItem {
    var isExpand:Bool
    var item:ImageContent
}
