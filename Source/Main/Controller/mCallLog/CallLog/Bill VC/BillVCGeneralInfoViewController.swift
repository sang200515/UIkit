//
//  BillVCGeneralInfoViewController.swift
//  fptshop
//
//  Created by Apple on 5/7/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class BillVCGeneralInfoViewController: UIViewController {

    
    var lbTitle: UILabel!
    var tfCC: UITextField!
    var tableView: UITableView!
    var btnCreateCallog: UIButton!
    var cellHeigt:CGFloat = 0
    var titleBill = ""
    var codeCCString = ""
    
    var listNearAddress:[BillLoadDiaChiNhan] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "BILL VẬN CHUYỂN"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationItem.hidesBackButton = true
        let backView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:30), height: Common.Size(s:50))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: backView)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        backView.addSubview(btBackIcon)
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            mCallLogApiManager.Bill__LoadDiaChiNhanGanDay(handler: { (results, err) in
                    if results.count > 0 {
                        for item in results {
                            self.listNearAddress.append(item)
                        }
                    } else {
                        debugPrint("Không lấy được diachiNhan gan day!)")
                }
                
                let listTitle = mCallLogApiManager.Bill__LoadTitle().Data ?? []
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if listTitle.count > 0 {
                        self.titleBill = listTitle[0].Title ?? ""
                    }
                    self.setUpView()
                }
            })
        }
        
    }
    
    @objc func loadListDiaChiGanDay() {
        self.listNearAddress.removeAll()
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            
            mCallLogApiManager.Bill__LoadDiaChiNhanGanDay(handler: { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if results.count > 0 {
                        for item in results {
                            self.listNearAddress.append(item)
                        }
                    } else {
                        debugPrint("Không lấy được diachiNhan gan day!)")
                    }
                    if self.tableView != nil {
                        self.tableView.reloadData()
                    }
                }
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
        self.loadListDiaChiGanDay()
    }
    
    
    func setUpView() {
        
        
        let senderView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Common.Size(s: 35)))
        senderView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        self.view.addSubview(senderView)
        
        let lbSendInfo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: senderView.frame.width - Common.Size(s: 30), height: senderView.frame.height))
        lbSendInfo.text = "THÔNG TIN GỬI"
        lbSendInfo.textColor = UIColor.black
        lbSendInfo.font = UIFont.systemFont(ofSize: 15)
        senderView.addSubview(lbSendInfo)
        
        let lbTieuDe = UILabel(frame: CGRect(x: Common.Size(s: 15), y: senderView.frame.height + Common.Size(s: 10), width: senderView.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbTieuDe.text = "Tiêu đề:"
        lbTieuDe.textColor = UIColor.lightGray
        lbTieuDe.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(lbTieuDe)

        lbTitle = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTieuDe.frame.origin.y + lbTieuDe.frame.height + Common.Size(s: 5), width: senderView.frame.width - Common.Size(s: 30), height: Common.Size(s: 30)))
        lbTitle.text = " \(titleBill)"
        lbTitle.textColor = UIColor.black
        lbTitle.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
        lbTitle.font = UIFont.systemFont(ofSize: 13)
        lbTitle.layer.cornerRadius = 5
        lbTitle.layer.borderColor = UIColor.lightText.cgColor
        lbTitle.layer.borderWidth = 1
        self.view.addSubview(lbTitle)
        
        lbTitle.numberOfLines = 0
        let lbTitleHeight:CGFloat = lbTitle.optimalHeight < Common.Size(s: 30) ? Common.Size(s: 30): lbTitle.optimalHeight

        let lbCC = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTitle.frame.origin.y + lbTitleHeight + Common.Size(s: 10), width: senderView.frame.width - Common.Size(s: 30), height: Common.Size(s: 15)))
        lbCC.text = "CC:"
        lbCC.textColor = UIColor.lightGray
        lbCC.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(lbCC)

        tfCC = UITextField(frame: CGRect(x: Common.Size(s: 15), y: lbCC.frame.origin.y + lbCC.frame.height + Common.Size(s: 5), width: senderView.frame.width - Common.Size(s: 30), height: Common.Size(s: 30)))
        tfCC.borderStyle = .roundedRect
        tfCC.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(tfCC)
        
        let tapShowCC = UITapGestureRecognizer(target: self, action: #selector(showListUserCC))
        tfCC.isUserInteractionEnabled = true
        tfCC.addGestureRecognizer(tapShowCC)
        
        let arrowImgView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let arrowImg = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
        arrowImg.image = #imageLiteral(resourceName: "ArrowDown-1")
        arrowImgView.addSubview(arrowImg)
        tfCC.rightViewMode = .always
        tfCC.rightView = arrowImgView

        let nearAddressView = UIView(frame: CGRect(x: 0, y: tfCC.frame.origin.y + tfCC.frame.height + Common.Size(s: 15), width: self.view.frame.width, height: Common.Size(s: 35)))
        nearAddressView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        self.view.addSubview(nearAddressView)

        let lbNearAddressTitle = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: nearAddressView.frame.width - Common.Size(s: 30), height: nearAddressView.frame.height))
        lbNearAddressTitle.text = "ĐỊA CHỈ NHẬN GẦN ĐÂY"
        lbNearAddressTitle.textColor = UIColor.black
        lbNearAddressTitle.font = UIFont.systemFont(ofSize: 15)
        nearAddressView.addSubview(lbNearAddressTitle)


        btnCreateCallog = UIButton(frame: CGRect(x: Common.Size(s: 15), y: self.view.frame.height - Common.Size(s: 65), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnCreateCallog.setTitle("TẠO YÊU CẦU", for: .normal)
        btnCreateCallog.layer.cornerRadius = 5
        btnCreateCallog.backgroundColor = UIColor(red: 34/255, green: 134/255, blue: 70/255, alpha: 1)
        self.view.addSubview(btnCreateCallog)
        btnCreateCallog.addTarget(self, action: #selector(createCallog), for: .touchUpInside)


        let tableViewHeight: CGFloat = self.view.frame.height - (nearAddressView.frame.origin.y + nearAddressView.frame.height) - Common.Size(s: 75)
        tableView = UITableView(frame: CGRect(x: 0, y: nearAddressView.frame.origin.y + nearAddressView.frame.height, width: self.view.frame.width, height: tableViewHeight))
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NearAddressCell.self, forCellReuseIdentifier: "nearAddressCell")
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        
        if self.listNearAddress.count == 0 {
            let emptyView = UIView(frame: CGRect(x: self.tableView.frame.origin.x, y: self.tableView.frame.origin.y, width: self.tableView.frame.width, height: self.tableView.frame.height))
            emptyView.backgroundColor = UIColor.white
            tableView.tableFooterView = emptyView
            
            let lbEmpty = UILabel()
            lbEmpty.center = emptyView.center
            lbEmpty.text = "Không có danh sách địa chỉ nhận gần đây!"
            lbEmpty.textAlignment = .center
            emptyView.addSubview(lbEmpty)
        }
        
        let line = UIView(frame: CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y + tableView.frame.height, width: tableView.frame.width, height: Common.Size(s: 1)))
        line.backgroundColor = UIColor.lightText
        self.view.addSubview(line)
        
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func showListUserCC() {
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let listCC = mCallLogApiManager.Bill__LoadCC().Data ?? []
            
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if listCC.count > 0 {
                    let listUserCCVc = ListUserCCViewController()
                    listUserCCVc.listCC = listCC
                    self.navigationController?.pushViewController(listUserCCVc, animated: true)
                    listUserCCVc.delegate = self
                } else {
                    self.showAlert(title: "Thông báo", message: "Không lấy được danh sách CC!")
                }
            }
        }
    }

    @objc func createCallog() {
        let newViewController = DetailBillInfoViewControllerV2()
        newViewController.callogTitle = self.titleBill
        newViewController.arrayCCCode = self.codeCCString
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension BillVCGeneralInfoViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNearAddress.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NearAddressCell = tableView.dequeueReusableCell(withIdentifier: "nearAddressCell") as! NearAddressCell
        let addressReceiverItem = self.listNearAddress[indexPath.row]
        cell.setUpCell(item: addressReceiverItem)
        self.cellHeigt = cell.estimateCellHeight
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeigt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addressReceiverItem = self.listNearAddress[indexPath.row]
        let newViewController = DetailBillInfoViewControllerV2()
        newViewController.receiverObj = addressReceiverItem
        newViewController.callogTitle = self.titleBill
        newViewController.arrayCCCode = self.codeCCString
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}


class NearAddressCell: UITableViewCell {
    
    var lbShopReceiveText: UILabel!
    var lbAddressReceiveText: UILabel!
    
    var estimateCellHeight: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    func setUpCell(item: BillLoadDiaChiNhan) {
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let lblShop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: (self.frame.width - Common.Size(s: 15))/3, height: Common.Size(s: 15)))
        lblShop.text = "Shop/PB Nhận:"
        lblShop.font = UIFont.systemFont(ofSize: 13)
        lblShop.textColor = UIColor.lightGray
        self.addSubview(lblShop)
        
        lbShopReceiveText = UILabel(frame: CGRect(x: Common.Size(s: 15) + lblShop.frame.width + Common.Size(s: 5), y: lblShop.frame.origin.y, width: self.frame.width - Common.Size(s: 15) - lblShop.frame.width - Common.Size(s: 15), height: Common.Size(s: 15)))
        lbShopReceiveText.font = UIFont.boldSystemFont(ofSize: 13)
        lbShopReceiveText.text = "\(item.OrganizationHierachyName )"
        self.addSubview(lbShopReceiveText)
        
        //
        let lblAddress = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbShopReceiveText.frame.origin.y + lbShopReceiveText.frame.height + Common.Size(s: 5), width: lblShop.frame.width, height: Common.Size(s: 15)))
        lblAddress.text = "Địa chỉ nhận:"
        lblAddress.font = UIFont.systemFont(ofSize: 13)
        lblAddress.textColor = UIColor.lightGray
        self.addSubview(lblAddress)
        
        lbAddressReceiveText = UILabel(frame: CGRect(x: lbShopReceiveText.frame.origin.x, y: lblAddress.frame.origin.y, width: lbShopReceiveText.frame.width, height: Common.Size(s: 15)))
        lbAddressReceiveText.text = "\(item.Address )"
        lbAddressReceiveText.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lbAddressReceiveText)
        
        lbAddressReceiveText.frame = CGRect(x: lbAddressReceiveText.frame.origin.x, y: lbAddressReceiveText.frame.origin.y, width: lbAddressReceiveText.frame.width, height: lbAddressReceiveText.optimalHeight)
        lbAddressReceiveText.numberOfLines = 0
        let lbAddressReceiveTextHeight = lbAddressReceiveText.optimalHeight < Common.Size(s: 15) ? Common.Size(s: 15) : lbAddressReceiveText.optimalHeight
        
        estimateCellHeight = lbAddressReceiveText.frame.origin.y + lbAddressReceiveTextHeight + Common.Size(s: 15)
    }
    
}

extension BillVCGeneralInfoViewController: ListUserCCViewControllerDelegate {
    func getListCC(ccString: String, codeCCString: String) {
        self.tfCC.text = ccString
        self.codeCCString = codeCCString
        
        self.navigationController?.navigationBar.isTranslucent = true
    }
}





