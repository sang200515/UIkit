//
//  UpdateSimHistoryViewController.swift
//  fptshop
//
//  Created by Apple on 4/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog

class UpdateSimHistoryViewController: UIViewController ,UITextFieldDelegate {
    
    //    var scrollView:UIScrollView!
    var tfPhone:UITextField!
    var btnCheck:UIButton!
    var tableView: UITableView!
    var cellHeight:CGFloat = 0
    var listSimHistory: [SimHistoryItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LỊCH SỬ THAY SIM"
        
        self.view.backgroundColor = UIColor.white
        
        //set up barButtonItem
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        
        let lbTextPhone =  UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: self.view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhone.textAlignment = .left
        lbTextPhone.textColor = UIColor.black
        lbTextPhone.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhone.text = "Số thuê bao hoặc Serial"
        self.view.addSubview(lbTextPhone)
        
        tfPhone = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhone.frame.origin.y + lbTextPhone.frame.size.height + Common.Size(s:5), width: self.view.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)));
        //        tfPhone.placeholder = ""
        tfPhone.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhone.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhone.autocorrectionType = UITextAutocorrectionType.no
        tfPhone.keyboardType = UIKeyboardType.numberPad
        tfPhone.returnKeyType = UIReturnKeyType.done
        tfPhone.clearButtonMode = UITextField.ViewMode.whileEditing;
        tfPhone.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhone.delegate = self
        self.view.addSubview(tfPhone)
        
        
        btnCheck = UIButton()
        btnCheck.frame = CGRect(x: tfPhone.frame.origin.x, y: tfPhone.frame.origin.y + tfPhone.frame.size.height + Common.Size(s:15), width: self.view.frame.size.width - Common.Size(s:30),height: Common.Size(s:40))
        btnCheck.backgroundColor = UIColor(red: 34/255, green: 134/255, blue: 70/255, alpha: 1)
        btnCheck.setTitle("TÌM KIẾM", for: .normal)
        btnCheck.addTarget(self, action: #selector(actionCheckHistory), for: .touchUpInside)
        btnCheck.layer.borderWidth = 0.5
        btnCheck.layer.borderColor = UIColor.white.cgColor
        btnCheck.layer.cornerRadius = 3
        self.view.addSubview(btnCheck)
        btnCheck.clipsToBounds = true
        
        tableView = UITableView(frame: CGRect(x: 0, y: btnCheck.frame.origin.y + btnCheck.frame.height + Common.Size(s: 20), width: self.view.frame.width, height: self.view.frame.height - (btnCheck.frame.origin.y + btnCheck.frame.height + Common.Size(s: 20))))
        self.view.addSubview(tableView)
        tableView.register(ESimHistoryCell.self, forCellReuseIdentifier: "eSimHistoryCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func actionCheckHistory(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.VTGetChangeSimHistory(fromdate: "", toDate: "",UserName: "\(Cache.user?.UserName ?? "")", ShopCode: "\(Cache.user?.ShopCode ?? "")", IsdnOrSerial: self.tfPhone.text ?? "", handler: { (results, message) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    
                    self.listSimHistory = results
                    
                    if message.count <= 0 {
                        if(results.count <= 0){
                            TableViewHelper.EmptyMessage(message: "Không có dữ liệu.\n:/", viewController: self.tableView)
                        }else{
                            TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                        }
                        self.tableView.reloadData()
                    } else {
                        let alertVC = UIAlertController(title: "Thông báo", message: "\(message)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default) { (_) in
                            self.tableView.reloadData()
                        }
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                }
            })
        }
    }
}

extension UpdateSimHistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSimHistory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ESimHistoryCell = tableView.dequeueReusableCell(withIdentifier: "eSimHistoryCell", for: indexPath) as! ESimHistoryCell

        let simHistory = listSimHistory[indexPath.row]
        cell.setUpCell(item: simHistory)
        cellHeight = cell.estimateCellHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let simHistory = listSimHistory[indexPath.row]
        if simHistory.LoaiSim == "ESIM" {
            self.getQRcode(phoneNumber: simHistory.Phonenumber, SOMPOS: "", SeriSim: simHistory.SeriSim_New)
        }
    }
    
    func getQRcode(phoneNumber:String,SOMPOS:String,SeriSim:String){
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.sp_mpos_FRT_SP_ESIM_getqrcode(SDT:
            phoneNumber,SOMPOS: SOMPOS,SeriSim: SeriSim) { (results, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    
                    if (err.count <= 0){
                        if results.count > 0 {
                            results[0].sdt = phoneNumber
                            let newViewController = QRCodeEsimViettelViewController()
                            newViewController.esimQRCode = results[0]
                            newViewController.isFromHistory = true
                            self.navigationController?.pushViewController(newViewController, animated: true)
                        } else {
                            let popup = PopupDialog(title: "Thông báo", message: "API Error\nGet QRCode Esim Fail!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                            }
                            let buttonOne = CancelButton(title: "OK") {}
                            popup.addButtons([buttonOne])
                            self.present(popup, animated: true, completion: nil)
                        }
                        
                    }else{
                        
                        let popup = PopupDialog(title: "Thông báo", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false) {
                            
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
}

class ESimHistoryCell: UITableViewCell {
    
    var lblPhoneNumber: UILabel!
    var lblNhaMangName: UILabel!
    var lblSimType: UILabel!
    var lblSerialNumber: UILabel!
    var lblUserName: UILabel!
    var lblShopName: UILabel!
    
    var estimateCellHeight: CGFloat = 0
    
//    override func awakeFromNib() {
//        super.awakeFromNib();
//    }
    
    func setUpCell(item: SimHistoryItem) {
        self.subviews.forEach({$0.removeFromSuperview()})
        
        let lblPhone = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 8), width: (self.frame.width - Common.Size(s: 15))/3, height: Common.Size(s: 15)))
        lblPhone.text = "Số thuê bao:"
        lblPhone.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        lblPhone.textColor = UIColor.lightGray
        self.addSubview(lblPhone)
        
        lblPhoneNumber = UILabel(frame: CGRect(x: lblPhone.frame.origin.x + lblPhone.frame.width, y: lblPhone.frame.origin.y, width: self.frame.width/3 - Common.Size(s: 5), height: Common.Size(s: 15)))
        lblPhoneNumber.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        lblPhoneNumber.text = "\(item.Phonenumber)"
        self.addSubview(lblPhoneNumber)
        
        let lbDate = UILabel(frame: CGRect(x: lblPhoneNumber.frame.origin.x + lblPhoneNumber.frame.width, y: lblPhone.frame.origin.y, width: self.frame.width - (lblPhoneNumber.frame.origin.x + lblPhoneNumber.frame.width) - Common.Size(s: 15), height: Common.Size(s: 15)))
        lbDate.font = UIFont.systemFont(ofSize: Common.Size(s: 10))
        lbDate.textColor = UIColor.lightGray
        lbDate.text = "\(item.NgayThaySim)"
        self.addSubview(lbDate)
        //
        let lblNhaMang = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblPhoneNumber.frame.origin.y + lblPhoneNumber.frame.height + Common.Size(s: 5), width: lblPhone.frame.width, height: Common.Size(s: 15)))
        lblNhaMang.text = "Nhà mạng:"
        lblNhaMang.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        lblNhaMang.textColor = UIColor.lightGray
        self.addSubview(lblNhaMang)
        
        lblNhaMangName = UILabel(frame: CGRect(x: lblPhoneNumber.frame.origin.x, y: lblNhaMang.frame.origin.y, width: self.frame.width - (lblNhaMang.frame.origin.x + lblNhaMang.frame.width) - Common.Size(s: 30) , height: Common.Size(s: 15)))
        lblNhaMangName.text = "\(item.Provider)"
        lblNhaMangName.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        self.addSubview(lblNhaMangName)
        //
        let lblLoaiSim = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblNhaMangName.frame.origin.y + lblNhaMangName.frame.height + Common.Size(s: 5), width: lblNhaMang.frame.width, height: Common.Size(s: 15)))
        lblLoaiSim.text = "Loại Sim:"
        lblLoaiSim.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        lblLoaiSim.textColor = UIColor.lightGray
        self.addSubview(lblLoaiSim)
        
        lblSimType = UILabel(frame: CGRect(x: lblPhoneNumber.frame.origin.x, y: lblLoaiSim.frame.origin.y, width: lblNhaMangName.frame.width, height: Common.Size(s: 15)))
        lblSimType.text = "\(item.LoaiSim)"
        lblSimType.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        self.addSubview(lblSimType)
        //
        let lblSoSerial = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblSimType.frame.origin.y + lblSimType.frame.height + Common.Size(s: 5), width: lblLoaiSim.frame.width, height: Common.Size(s: 15)))
        lblSoSerial.text = "Số serial/ESIM:"
        lblSoSerial.textColor = UIColor.lightGray
        lblSoSerial.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        self.addSubview(lblSoSerial)
        
        lblSerialNumber = UILabel(frame: CGRect(x: lblPhoneNumber.frame.origin.x, y: lblSoSerial.frame.origin.y, width: lblNhaMangName.frame.width, height: Common.Size(s: 15)))
        lblSerialNumber.text = "\(item.SeriSim_New)"
        lblSerialNumber.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        self.addSubview(lblSerialNumber)
        //
        let lblTenKh = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblSerialNumber.frame.origin.y + lblSerialNumber.frame.height + Common.Size(s: 5), width: lblSoSerial.frame.width, height: Common.Size(s: 15)))
        lblTenKh.text = "Tên khách hàng:"
        lblTenKh.textColor = UIColor.lightGray
        lblTenKh.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        self.addSubview(lblTenKh)
        
        lblUserName = UILabel(frame: CGRect(x: lblPhoneNumber.frame.origin.x, y: lblTenKh.frame.origin.y, width: lblNhaMangName.frame.width, height: Common.Size(s: 15)))
        lblUserName.text = "\(item.FullName)"
        lblUserName.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        self.addSubview(lblUserName)
        
        //
        let lblShop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblUserName.frame.origin.y + lblUserName.frame.height + Common.Size(s: 5), width: lblTenKh.frame.width, height: Common.Size(s: 15)))
        lblShop.text = "Shop:"
        lblShop.textColor = UIColor.lightGray
        lblShop.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        self.addSubview(lblShop)
        
        lblShopName = UILabel(frame: CGRect(x: lblPhoneNumber.frame.origin.x, y: lblShop.frame.origin.y, width: lblNhaMangName.frame.width, height: Common.Size(s: 15)))
        lblShopName.font = UIFont.systemFont(ofSize: Common.Size(s: 12))
        lblShopName.text = "\(Cache.user?.ShopName ?? "")"
        lblShopName.frame = CGRect(x: lblShopName.frame.origin.x, y: lblShopName.frame.origin.y, width: lblShopName.frame.width, height: lblShopName.optimalHeight)
        lblShopName.numberOfLines = 0
        self.addSubview(lblShopName)
        
        let lblShopNameHeight: CGFloat = lblShopName.optimalHeight < Common.Size(s: 15) ? Common.Size(s: 15) : (lblShopName.optimalHeight + Common.Size(s: 5))
        lblShopName.numberOfLines = 0
        lblShopName.frame = CGRect(x: lblShopName.frame.origin.x, y: lblShopName.frame.origin.y, width: lblShopName.frame.width, height: lblShopNameHeight)
        
        estimateCellHeight = lblShopName.frame.origin.y + lblShopName.optimalHeight + Common.Size(s: 15)
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated);
//    }
}

