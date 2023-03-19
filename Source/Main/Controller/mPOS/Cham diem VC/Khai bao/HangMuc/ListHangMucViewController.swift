//
//  ListHangMucViewController.swift
//  fptshop
//
//  Created by Apple on 5/31/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ListHangMucViewController: UIViewController {
    
    var tableView: UITableView!
    var headerView: UIView!
    var listNhomHangMuc:[NhomHangMuc] = []
    var listContentNhomHangMuc:[ContentNhomHangMuc] = []
    var listExpandItem:[ExpandItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "DANH SÁCH CHẤM ĐIỂM"
        
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
        btnAdd.addTarget(self, action: #selector(addHangMucChamDiem), for: UIControl.Event.touchUpInside)
        btnAdd.frame = CGRect(x: 0, y: 0, width: Common.Size(s: 20), height: Common.Size(s: 20))
        viewRightNav.addSubview(btnAdd)
        
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Common.Size(s:40)))
        headerView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        self.view.addSubview(headerView)
        
        let lbHeaderText = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: headerView.frame.width - Common.Size(s: 30), height: headerView.frame.height))
        lbHeaderText.text = "DANH SÁCH HẠNG MỤC CHẤM ĐIỂM"
        headerView.addSubview(lbHeaderText)
        
        self.listContentNhomHangMuc.removeAll()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Score_GetContentGroupItem(handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
                        for item in results {
                            self.listContentNhomHangMuc.append(item)
                        }
                        self.initListExpandItem(listItem: results)
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
        self.listContentNhomHangMuc.removeAll()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Score_GetContentGroupItem(handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
                        for item in results {
                            self.listContentNhomHangMuc.append(item)
                        }
                        self.initListExpandItem(listItem: results)
                    } else {
                        debugPrint("khong lay duoc list nhom hang muc")
                    }
                    self.setUpTableView()
                }
            })
        }
    }
    
    func initListExpandItem(listItem:[ContentNhomHangMuc]) {
        self.listExpandItem.removeAll()
        for item in listItem {
            //            self.listExpandItem.append(ExpandItem(isExpand: true, item: item))
            self.listExpandItem.append(ExpandItem(isExpand: false, item: item))
        }
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: headerView.frame.origin.y + headerView.frame.height, width: self.view.frame.width, height: self.view.frame.height - headerView.frame.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ChamDiemItemCell.self, forCellReuseIdentifier: "chamDiemItemCell")
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
    }
    
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addHangMucChamDiem() {
        let newViewController = CreateHangMucViewControllerV2()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}


extension ListHangMucViewController: UITableViewDelegate, UITableViewDataSource, ChamDiemItemCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listExpandItem.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let item = listContentNhomHangMuc[section]
        
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Common.Size(s: 40)))
        headerView.delegate = self
        headerView.secIndex = section
        headerView.lbTitle.text = " \(section + 1).  \(item.GroupName)(\(item.Count))"
        
        if (section % 2) == 0 {
            headerView.backgroundColor = UIColor.white
        } else {
            headerView.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Common.Size(s: 40)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if !(listExpandItem[section].isExpand){
        //            return 0
        //        }
        //        return listExpandItem[section].item.ListContent.count
        
        if !(listExpandItem[section].isExpand){
            return 0
        } else {
            return listExpandItem[section].item.ListContent.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ChamDiemItemCell = tableView.dequeueReusableCell(withIdentifier: "chamDiemItemCell", for: indexPath) as! ChamDiemItemCell
        
        let item = listExpandItem[indexPath.section].item.ListContent[indexPath.row]
        cell.setUpCell()
        cell.title.text = "\(indexPath.section + 1).\(indexPath.row + 1).  \(item.ContentName)"
        cell.itemID = item.ContentID
        cell.itemType = 3
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
        let item = listExpandItem[indexPath.section].item.ListContent[indexPath.row]
        let newViewController = CreateHangMucViewControllerV2()
        newViewController.contentHangMucItem = item
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
                                    self.listContentNhomHangMuc.removeAll()
                                    self.listExpandItem.removeAll()
                                    WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                                        MPOSAPIManager.Score_GetContentGroupItem(handler: { (results, err) in
                                            WaitingNetworkResponseAlert.DismissWaitingAlert {
                                                if results.count > 0 {
                                                    for item in results {
                                                        self.listContentNhomHangMuc.append(item)
                                                    }
                                                    self.initListExpandItem(listItem: results)
                                                } else {
                                                    debugPrint("khong lay duoc list nhom hang muc")
                                                }
                                                self.tableView.reloadData()
                                            }
                                        })
                                    }
                                    
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

extension ListHangMucViewController:HeaderViewDelegate {
    func clickHeader(inx: Int) {
        let section = inx
        debugPrint("section:\(section)_ btnTag:\(inx)")
        var indexPaths = [IndexPath]()
        
        for row in listExpandItem[section].item.ListContent.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        listExpandItem[section].isExpand = !listExpandItem[section].isExpand
        let isExpand = listExpandItem[section].isExpand
        
        if isExpand {
            tableView.insertRows(at: indexPaths, with: UITableView.RowAnimation.fade)
        } else {
            tableView.deleteRows(at: indexPaths, with: UITableView.RowAnimation.fade)
        }
    }
}


protocol HeaderViewDelegate: AnyObject {
    func clickHeader(inx:Int)
}

class HeaderView: UIView {
    var lbTitle: UILabel!
    var secIndex:Int?
    var delegate:HeaderViewDelegate?
    var btnExpand: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lbTitle = UILabel(frame: CGRect(x: Common.Size(s: 10), y: 0, width: self.frame.width - Common.Size(s: 50), height: self.frame.height - Common.Size(s: 1)))
        lbTitle.font = UIFont.systemFont(ofSize: 14)
        lbTitle.textColor = UIColor.black
        self.addSubview(lbTitle)
        
        btnExpand = UIButton(frame: CGRect(x: lbTitle.frame.origin.x + lbTitle.frame.width + Common.Size(s: 10), y: self.frame.height/2 - Common.Size(s: 7), width: Common.Size(s: 15), height: Common.Size(s: 15)))
        btnExpand.setImage(#imageLiteral(resourceName: "ArrowDown-1"), for: .normal)
        btnExpand.addTarget(self, action: #selector(clickBtnExpand), for: .touchUpInside)
        self.addSubview(btnExpand)
        
        let line = UIView(frame: CGRect(x: 0, y: self.frame.height - Common.Size(s: 1), width: self.frame.width, height: Common.Size(s: 1)))
        line.backgroundColor = UIColor.lightGray
        self.addSubview(line)
    }
    
    @objc func clickBtnExpand() {
        if let indx = secIndex {
            self.delegate?.clickHeader(inx: indx)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct ExpandItem {
    var isExpand:Bool
    var item:ContentNhomHangMuc
}

