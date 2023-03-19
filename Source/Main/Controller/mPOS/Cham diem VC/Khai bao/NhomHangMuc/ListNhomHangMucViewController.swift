//
//  ListNhomHangMucViewController.swift
//  fptshop
//
//  Created by Apple on 5/31/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListNhomHangMucViewController: UIViewController {
    
    var tableView: UITableView!
    var headerView: UIView!
    var listNhomHangMuc:[NhomHangMuc] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NHÓM HẠNG MỤC CHẤM ĐIỂM"
        
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
        
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 20, height: 20)))
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: viewRightNav)
        let btnAdd = UIButton.init(type: .custom)
        btnAdd.setImage(#imageLiteral(resourceName: "add-1"), for: UIControl.State.normal)
        btnAdd.imageView?.contentMode = .scaleAspectFit
        btnAdd.addTarget(self, action: #selector(addNhomHangMucChamDiem), for: UIControl.Event.touchUpInside)
        btnAdd.frame = CGRect(x: 0, y: 0, width: Common.Size(s: 20), height: Common.Size(s: 20))
        viewRightNav.addSubview(btnAdd)
        
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Common.Size(s:40)))
        headerView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        self.view.addSubview(headerView)
        
        let lbHeaderText = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: headerView.frame.width - Common.Size(s: 30), height: headerView.frame.height))
        lbHeaderText.text = "DANH SÁCH HẠNG MỤC CHẤM ĐIỂM"
        headerView.addSubview(lbHeaderText)
        
        self.listNhomHangMuc.removeAll()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Score_GetGroupItem(handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
                        for item in results {
                            self.listNhomHangMuc.append(item)
                        }
                    } else {
                        debugPrint("khong lay duoc list nhom hang muc")
                    }
                    self.setUpTableView()
                }
            })
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if tableView != nil {
            tableView.removeFromSuperview()
        }
        self.listNhomHangMuc.removeAll()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Score_GetGroupItem(handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
                        for item in results {
                            self.listNhomHangMuc.append(item)
                        }
                    } else {
                        debugPrint("khong lay duoc list nhom hang muc")
                    }
                    self.setUpTableView()
                }
            })
        }
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: headerView.frame.origin.y + headerView.frame.height, width: self.view.frame.width, height: self.view.frame.height - headerView.frame.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ChamDiemItemCell.self, forCellReuseIdentifier: "chamDiemItemCell")
        self.view.addSubview(tableView)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addNhomHangMucChamDiem() {
        debugPrint("addNhomHangMucChamDiem")
        let newViewController = CreateNhomHangMucViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}


extension ListNhomHangMucViewController: UITableViewDelegate, UITableViewDataSource, ChamDiemItemCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNhomHangMuc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ChamDiemItemCell = tableView.dequeueReusableCell(withIdentifier: "chamDiemItemCell", for: indexPath) as! ChamDiemItemCell
        let nhomHangMuc = listNhomHangMuc[indexPath.row]
        cell.setUpCell()
        cell.title.text = "\(indexPath.row + 1).  \(nhomHangMuc.GroupName)"
        cell.itemID = nhomHangMuc.GroupID
        cell.itemType = 2
        cell.delegate = self
        
        if (indexPath.row % 2) == 0 {
            cell.backgroundColor = UIColor.white
        } else {
            cell.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nhomHangMuc = listNhomHangMuc[indexPath.row]
        let newViewController = CreateNhomHangMucViewController()
        newViewController.nhomHangMucItem = nhomHangMuc
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func didDeleteItem(ID: Int, Type: Int) {
        debugPrint("deleteItem_ id: \(ID), type: \(Type)")
        
        let alertVC = UIAlertController(title: "Thông báo", message: "Bạn chắc chắn muốn xoá mục này!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (_) in
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.Score_InActiveOGC(ID: ID, Type: Type, handler: { (results, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if results.count > 0 {
                            if results[0].Result == 1 {
                                let alertVC = UIAlertController(title: "Thông báo", message: "\(results[0].Message)", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                    self.listNhomHangMuc.removeAll()
                                    MPOSAPIManager.Score_GetGroupItem(handler: { (results, err) in
                                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                                            if results.count > 0 {
                                                for item in results {
                                                    self.listNhomHangMuc.append(item)
                                                }
                                            } else {
                                                debugPrint("khong lay duoc list nhom hang muc")
                                            }
                                            self.tableView.reloadData()
                                        }
                                    })
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
        let cancelAction = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
        alertVC.addAction(action)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }
}
