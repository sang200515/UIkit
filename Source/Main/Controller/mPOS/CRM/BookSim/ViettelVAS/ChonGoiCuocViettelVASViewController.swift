//
//  ChonGoiCuocViettelVASViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 3/16/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ChonGoiCuocViettelVASViewController: UIViewController {
    var sdtRegister = ""
    var tableView: UITableView!
    var cellHeight: CGFloat = 0
    var listGoiCuocCollect = [ViettelVASGoiCuoc_products]()
    var listProductViettelVAS_MainInfo = [ViettelVAS_Product]()
    var providerId = ""
    var typeGoiCuoc = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Đăng ký"
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.view.backgroundColor = .white
        
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
        
        let lbSdt = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 8), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbSdt.text = "Số điện thoại"
        lbSdt.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lbSdt)
        
        let lbSdtText = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSdt.frame.origin.y + lbSdt.frame.height, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        lbSdtText.text = "  \(self.sdtRegister)"
        lbSdtText.font = UIFont.systemFont(ofSize: 15)
        lbSdtText.layer.cornerRadius = 8
        lbSdtText.layer.borderWidth = 0.5
        lbSdtText.layer.borderColor = UIColor.lightGray.cgColor
        self.view.addSubview(lbSdtText)
        
        let viewTTGoiCuoc = UIView(frame: CGRect(x: 0, y: lbSdtText.frame.origin.y + lbSdtText.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: Common.Size(s: 40)))
        viewTTGoiCuoc.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        self.view.addSubview(viewTTGoiCuoc)
        
        let lbTTGoiCuoc = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: viewTTGoiCuoc.frame.width - Common.Size(s: 30), height: viewTTGoiCuoc.frame.height))
        lbTTGoiCuoc.text = "THÔNG TIN GÓI CƯỚC"
        lbTTGoiCuoc.font = UIFont.boldSystemFont(ofSize: 14)
        lbTTGoiCuoc.textColor = UIColor(netHex: 0x59B581)
        viewTTGoiCuoc.addSubview(lbTTGoiCuoc)
        
        let tableViewHeight:CGFloat = self.view.frame.height - (self.self.navigationController?.navigationBar.frame.height ?? 0) - UIApplication.shared.statusBarFrame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: viewTTGoiCuoc.frame.origin.y + viewTTGoiCuoc.frame.height + Common.Size(s: 5), width: self.view.frame.width, height: tableViewHeight - viewTTGoiCuoc.frame.origin.y - viewTTGoiCuoc.frame.height - Common.Size(s: 60)))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(ViettelVASGoiCuocCell.self, forCellReuseIdentifier: "viettelVASGoiCuocCell")
        tableView.tableFooterView = UIView()
        
        let btnGetOTP = UIButton(frame: CGRect(x: Common.Size(s: 15), y: self.view.frame.height - (self.self.navigationController?.navigationBar.frame.height ?? 0) - UIApplication.shared.statusBarFrame.height - Common.Size(s: 50), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnGetOTP.setTitle("Lấy OTP", for: .normal)
        btnGetOTP.setTitleColor(UIColor.white, for: .normal)
        btnGetOTP.layer.cornerRadius = 8
        btnGetOTP.backgroundColor = UIColor(netHex: 0x59B581)
        btnGetOTP.addTarget(self, action: #selector(handleGetOTP), for: .touchUpInside)
        self.view.addSubview(btnGetOTP)
        
    }
    
    @objc func handleBack(){
        navigationController?.popViewController(animated: true)
    }
    @objc func handleGetOTP(){
        let itemGoiCuoc = self.listGoiCuocCollect.first(where: {$0.isChooseGoiCuoc == true})
        if itemGoiCuoc == nil {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa chọn gói cước!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            CRMAPIManager.ViettelVAS_GetOTP(providerId: "\(self.providerId)", sdt: self.sdtRegister, productType: self.typeGoiCuoc, productCode: "\(itemGoiCuoc?.mCode ?? "")") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs != nil {
                            if rs?.integrationInfo.returnedCode == "200" {
                                let alert = UIAlertController(title: "Thông báo", message: "Lấy OTP thành công!", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default) { (_) in
                                    let vc = VASPaymentVC()
                                    vc.itemGoiCuocChoose = itemGoiCuoc
                                    vc.sdt = self.sdtRegister
                                    vc.listProductViettelVAS_MainInfo = self.listProductViettelVAS_MainInfo
                                    vc.integrationInfo = rs?.integrationInfo
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                let alert = UIAlertController(title: "Thông báo", message: "Lấy OTP thất bại!", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alert.addAction(action)
                                self.present(alert, animated: true, completion: nil)
                            }
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Lấy OTP thất bại!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

extension ChonGoiCuocViettelVASViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGoiCuocCollect.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ViettelVASGoiCuocCell = tableView.dequeueReusableCell(withIdentifier: "viettelVASGoiCuocCell", for: indexPath) as! ViettelVASGoiCuocCell
        let item = listGoiCuocCollect[indexPath.row]
        cell.selectionStyle = .none
        cell.item = item
        cell.setUpCell()
        cell.delegate = self
        self.cellHeight = cell.estimateCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

extension ChonGoiCuocViettelVASViewController: ViettelVASGoiCuocCellDelegate {
    func didSelectGoiCuocViettelVAS(item: ViettelVASGoiCuoc_products) {
        if item.isChooseGoiCuoc {
            item.isChooseGoiCuoc = !item.isChooseGoiCuoc
        } else {
            for i in listGoiCuocCollect {
                i.isChooseGoiCuoc = false
            }
            item.isChooseGoiCuoc = true
        }
        self.tableView.reloadData()
    }
}

class ViettelVASGoiCuocCell: UITableViewCell {
    
    var imgChooseGC: UIImageView!
    var estimateCell:CGFloat = 0
    var item: ViettelVASGoiCuoc_products?
    weak var delegate: ViettelVASGoiCuocCellDelegate?
    
    func setUpCell() {
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = .white
        
        let viewContent = UIView(frame: CGRect(x: Common.Size(s: 10), y: Common.Size(s: 5), width: self.frame.width - Common.Size(s: 20), height: self.frame.height))
        viewContent.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        viewContent.layer.cornerRadius = 8
        self.addSubview(viewContent)
        
        let tapChooseGC = UITapGestureRecognizer(target: self, action: #selector(chooseGoiCuocViettelVAS))
        viewContent.isUserInteractionEnabled = true
        viewContent.addGestureRecognizer(tapChooseGC)
        
        let lbTenGoiCuoc = UILabel(frame: CGRect(x: Common.Size(s: 8), y: 0, width: viewContent.frame.width - Common.Size(s: 16) - Common.Size(s: 30), height: Common.Size(s: 25)))
        lbTenGoiCuoc.text = item?.subName
        lbTenGoiCuoc.font = UIFont.boldSystemFont(ofSize: 15)
        viewContent.addSubview(lbTenGoiCuoc)
        
        imgChooseGC = UIImageView(frame: CGRect(x: lbTenGoiCuoc.frame.origin.x + lbTenGoiCuoc.frame.width + Common.Size(s: 3), y: Common.Size(s: 5), width: Common.Size(s: 20), height: Common.Size(s: 20)))
        imgChooseGC.image = #imageLiteral(resourceName: "check-booksim")
        imgChooseGC.contentMode = .scaleToFill
        viewContent.addSubview(imgChooseGC)
        
        if item?.isChooseGoiCuoc == false {
            imgChooseGC.isHidden = true
        } else {
            imgChooseGC.isHidden = false
        }
        let imgX = UIImageView(frame: CGRect(x: Common.Size(s: 8), y: lbTenGoiCuoc.frame.origin.y + lbTenGoiCuoc.frame.height + Common.Size(s: 2), width: Common.Size(s: 12), height: Common.Size(s: 12)))
        imgX.image = #imageLiteral(resourceName: "data-booksim")
        imgX.contentMode = .scaleToFill
        viewContent.addSubview(imgX)
        
        let lbDecs = UILabel(frame: CGRect(x: imgX.frame.origin.x + imgX.frame.width + Common.Size(s: 3), y: imgX.frame.origin.y - Common.Size(s: 2), width: viewContent.frame.width - Common.Size(s: 16) - Common.Size(s: 18), height: Common.Size(s: 20)))
        lbDecs.text = "\(item?.desc ?? "")"
        lbDecs.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbDecs)
        
        let lbDecsHeight:CGFloat = lbDecs.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbDecs.optimalHeight + Common.Size(s: 5))
        lbDecs.numberOfLines = 0
        lbDecs.frame = CGRect(x: lbDecs.frame.origin.x, y: lbDecs.frame.origin.y, width: lbDecs.frame.width, height: lbDecsHeight)
        
        let lbGia = UILabel(frame: CGRect(x: lbDecs.frame.origin.x, y: lbDecs.frame.origin.y + lbDecs.frame.height, width: lbDecs.frame.width, height: Common.Size(s: 25)))
        lbGia.text = "Giá: \(Common.convertCurrencyDouble(value: item?.price ?? 0))đ"
        lbGia.font = UIFont.boldSystemFont(ofSize: 14)
        lbGia.textColor = .red
        viewContent.addSubview(lbGia)
        
        viewContent.frame = CGRect(x: viewContent.frame.origin.x, y: viewContent.frame.origin.y, width: viewContent.frame.width, height: lbGia.frame.origin.y + lbGia.frame.height)
        
        estimateCell = viewContent.frame.origin.y + viewContent.frame.height + Common.Size(s: 5)
    }
    
    @objc func chooseGoiCuocViettelVAS() {
//        debugPrint("tap choose goi cuoc")
        self.delegate?.didSelectGoiCuocViettelVAS(item: item ?? ViettelVASGoiCuoc_products(status: 0, system_type: 0, priority: 0, remain: 0, price: 0, offered: false, mCode: "", prepaid_code: "", postpaid_code: "", type: "", name: "", desc: "", product_group: "", vtfreeType: "", isChooseGoiCuoc: false))
    }
}

protocol ViettelVASGoiCuocCellDelegate: AnyObject {
    func didSelectGoiCuocViettelVAS(item: ViettelVASGoiCuoc_products)
}
