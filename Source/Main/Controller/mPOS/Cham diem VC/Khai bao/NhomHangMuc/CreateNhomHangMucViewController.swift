//
//  CreateNhomHangMucViewController.swift
//  fptshop
//
//  Created by Apple on 5/31/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CreateNhomHangMucViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var tfHangMucNameText: UITextField!
    var tableView: UITableView!
    var btnConfirm: UIButton!
    
    var scrollViewHeight: CGFloat = 0
    var isChooseObject = false
    var tableviewHeightEstimate:CGFloat = 0
    var listObject:[DoiTuongChamDiem] = []
    var listObjectChoose:[DoiTuongChamDiem] = []
    var nhomHangMucItem:NhomHangMuc?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "KHAI BÁO NHÓM HẠNG MỤC"
        
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
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Score_GetListObject(handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
                        for item in results {
                            self.listObject.append(item)
                        }
                    } else {
                        debugPrint("khong lay duoc list doi tuong")
                    }
                    self.setUpView()
                }
                
            })
        }
    }
    
    func setUpView() {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lbTenNhomHangMuc = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbTenNhomHangMuc.text = "Tên nhóm hạng mục:"
        lbTenNhomHangMuc.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbTenNhomHangMuc)
        
        tfHangMucNameText = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbTenNhomHangMuc.frame.origin.y + lbTenNhomHangMuc.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        tfHangMucNameText.placeholder = "Nhập tên nhóm hạng mục"
        tfHangMucNameText.font = UIFont.systemFont(ofSize: 14)
        tfHangMucNameText.borderStyle = .roundedRect
        scrollView.addSubview(tfHangMucNameText)
        
        let lbListDoiTuong = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfHangMucNameText.frame.origin.y + tfHangMucNameText.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbListDoiTuong.text = "Đối tượng được chấm:"
        lbListDoiTuong.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbListDoiTuong)
        
        let lbListDoiTuongHeight:CGFloat = lbListDoiTuong.frame.origin.y + lbListDoiTuong.frame.height
        
        
        self.tableviewHeightEstimate = Common.Size(s: 30) * CGFloat(listObject.count)
        
        tableView = UITableView(frame: CGRect(x: 0, y: lbListDoiTuongHeight + Common.Size(s: 10), width: self.view.frame.width, height: self.tableviewHeightEstimate))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.register(ItemCheckCell.self, forCellReuseIdentifier: "itemCheckCell")
        scrollView.addSubview(tableView)
        
        
        btnConfirm = UIButton(frame: CGRect(x: Common.Size(s: 15), y: scrollView.frame.height - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height) - Common.Size(s: 65), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnConfirm.setTitle("XÁC NHẬN", for: .normal)
        btnConfirm.titleLabel?.textColor = UIColor.white
        btnConfirm.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btnConfirm.layer.cornerRadius = 5
        btnConfirm.backgroundColor = UIColor(red: 34/255, green: 134/255, blue: 70/255, alpha: 1)
        scrollView.addSubview(btnConfirm)
        btnConfirm.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        
        let tableViewHeight:CGFloat = self.view.frame.height - lbListDoiTuongHeight - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height) - Common.Size(s: 65)
        if tableviewHeightEstimate > tableViewHeight {
            
            btnConfirm.frame = CGRect(x: btnConfirm.frame.origin.x, y: tableView.frame.origin.y + tableView.frame.height + Common.Size(s: 15), width: btnConfirm.frame.width, height: btnConfirm.frame.height)
        } else {
            btnConfirm.frame = CGRect(x: btnConfirm.frame.origin.x, y: scrollView.frame.height - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height) - Common.Size(s: 65), width: btnConfirm.frame.width, height: btnConfirm.frame.height)
        }
        
        scrollViewHeight = btnConfirm.frame.origin.y + btnConfirm.frame.height + Common.Size(s: 50)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        if self.nhomHangMucItem != nil {
            self.listObjectChoose.removeAll()
            tfHangMucNameText.text = nhomHangMucItem?.GroupName ?? ""
            
            let arrObjectID = nhomHangMucItem?.ListObjectScore.components(separatedBy: ",") ?? []
            for objcID in arrObjectID {
                for item in self.listObject {
                    if item.ObjectID == Int(objcID) {
                        self.listObjectChoose.append(item)
                    }
                }
            }
        }
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func confirm(){
        var str:[String] = []
        for item in listObjectChoose {
            str.append("\(item.ObjectID)")
        }
        let strListObject = str.joined(separator: ",")
        debugPrint(strListObject)
        
        guard let nhomHangMucName = self.tfHangMucNameText.text, !nhomHangMucName.isEmpty else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập tên nhóm hạng mục!")
            return
        }
        
        if self.nhomHangMucItem == nil {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.Score_CreateGroupItem(GroupName: nhomHangMucName, ListObject: strListObject, handler: { (results, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if results.count > 0 {
                            if results[0].Result == 1 {
                                let alertVC = UIAlertController(title: "Thông báo", message: "\(results[0].Message)", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                    //                                    for vc in self.navigationController?.viewControllers ?? [] {
                                    //                                        if vc is KhaiBaoViewController {
                                    //                                            self.navigationController?.popToViewController(vc, animated: true)
                                    //                                        }
                                    //                                    }
                                    self.navigationController?.popViewController(animated: true)
                                })
                                alertVC.addAction(action)
                                self.present(alertVC, animated: true, completion: nil)
                            } else {
                                self.showAlert(title: "Thông báo", message: "\(results[0].Message)")
                            }
                        } else {
                            self.showAlert(title: "Thông báo", message: err)
                        }
                    }
                })
            }
        } else {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.Score_UpdateGroupItem(GroupName: nhomHangMucName, ListObject: strListObject, GroupId: self.nhomHangMucItem?.GroupID ?? 0, handler: { (results, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if results.count > 0 {
                            if results[0].Result == 1 {
                                let alertVC = UIAlertController(title: "Thông báo", message: "\(results[0].Message)", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                    //                                    for vc in self.navigationController?.viewControllers ?? [] {
                                    //                                        if vc is KhaiBaoViewController {
                                    //                                            self.navigationController?.popToViewController(vc, animated: true)
                                    //                                        }
                                    //                                    }
                                    self.navigationController?.popViewController(animated: true)
                                })
                                alertVC.addAction(action)
                                self.present(alertVC, animated: true, completion: nil)
                            } else {
                                self.showAlert(title: "Thông báo", message: "\(results[0].Message)")
                            }
                        } else {
                            self.showAlert(title: "Thông báo", message: err)
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
}

extension CreateNhomHangMucViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ItemCheckCell = tableView.dequeueReusableCell(withIdentifier: "itemCheckCell", for: indexPath) as! ItemCheckCell
        let doiTuong = listObject[indexPath.row]
        cell.objectItem = doiTuong
        cell.setUpCell()
        cell.lbName.text = "\(doiTuong.ObjectName)"
        cell.delegate = self
        
        if self.nhomHangMucItem != nil {
            for item in listObjectChoose {
                if item.ObjectID == doiTuong.ObjectID {
                    cell.imgCheck.image = #imageLiteral(resourceName: "check-1")
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Common.Size(s: 30)
    }
}

extension CreateNhomHangMucViewController:ItemCheckCellDelegate {
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

//---------------------------------------------------------------------------

protocol ItemCheckCellDelegate: AnyObject {
    func didChooseObject(objectItem:DoiTuongChamDiem, isCheck: Bool)
}

class ItemCheckCell: UITableViewCell {
    var imgCheck = UIImageView(image: #imageLiteral(resourceName: "check-2-1"))
    var lbName: UILabel!
    var isCheck : Bool = false {
        didSet {
            self.imgCheck.image = UIImage(named: isCheck ? "check-1-1" : "check-2-1")
        }
    }
    
    var objectItem:DoiTuongChamDiem?
    weak var delegate: ItemCheckCellDelegate?
    
    func setUpCell(){
        self.subviews.forEach({$0.removeFromSuperview()})
        imgCheck.frame = CGRect(x: Common.Size(s: 15), y: self.frame.height/2 - Common.Size(s: 7), width: Common.Size(s: 15), height: Common.Size(s: 15))
        self.addSubview(imgCheck)
        
        let tapChangeImgCheck = UITapGestureRecognizer(target: self, action: #selector(changeImgCheck))
        imgCheck.isUserInteractionEnabled = true
        imgCheck.addGestureRecognizer(tapChangeImgCheck)
        
        lbName = UILabel(frame: CGRect(x: imgCheck.frame.origin.x + imgCheck.frame.width + Common.Size(s: 10), y: 0, width: self.frame.width - (imgCheck.frame.width + Common.Size(s: 10)) - Common.Size(s: 30), height: self.frame.height))
        lbName.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbName)
        
    }
    
    @objc func changeImgCheck() {
        isCheck = !isCheck
        self.delegate?.didChooseObject(objectItem: objectItem!, isCheck: isCheck)
        
    }
}
