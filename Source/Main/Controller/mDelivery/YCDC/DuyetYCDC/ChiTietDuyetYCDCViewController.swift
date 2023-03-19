//
//  ChiTietDuyetYCDCViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 23/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class ChiTietDuyetYCDCViewController: UIViewController {
    
    var headerItem: BodyYCDC?
    var footerView: UIView!
    var parentNavigationController: UINavigationController?
    var list:[DetailYCDC] = []
    var tableView: UITableView!
    var onCancelYCDC: ((Bool) -> (Void))?
    var safeArea: UILayoutGuide!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(self.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        self.title = "Số YCĐC: \(headerItem!.docEntry)"
     

        //footer
        footerView = UIView()
        footerView.backgroundColor = .white
        footerView.clipsToBounds = true
        self.view.addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        if(headerItem!.statusCode == "O" || headerItem!.statusCode == "D"){
            footerView.heightAnchor.constraint(equalToConstant: Common.Size(s: 40)).isActive = true
        }else{
            footerView.heightAnchor.constraint(equalToConstant: Common.Size(s: 0)).isActive = true
        }
        footerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        footerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        footerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        let leftView = UIView()
        leftView.backgroundColor = .white
        leftView.translatesAutoresizingMaskIntoConstraints = false
        let btnSend = UIButton()
        btnSend.translatesAutoresizingMaskIntoConstraints = false
        btnSend.setTitle("Duyệt", for: .normal)
        btnSend.backgroundColor = UIColor(netHex:0x00955E)
        btnSend.setTitleColor(.white, for: .normal)
        btnSend.layer.cornerRadius = 10
        leftView.addSubview(btnSend)
        let tapSendRequest = UITapGestureRecognizer(target: self, action: #selector(self.sendRequest))
        btnSend.addGestureRecognizer(tapSendRequest)
        btnSend.isUserInteractionEnabled = true
        btnSend.centerYAnchor.constraint(equalTo: leftView.centerYAnchor).isActive = true
        btnSend.centerXAnchor.constraint(equalTo: leftView.centerXAnchor).isActive = true
        btnSend.heightAnchor.constraint(equalTo: leftView.heightAnchor, multiplier: 2/3).isActive = true
        btnSend.widthAnchor.constraint(equalTo: leftView.widthAnchor, multiplier: 2/3).isActive = true
        
        
      
        
        let rightView = UIView()
        rightView.backgroundColor = .white
        rightView.translatesAutoresizingMaskIntoConstraints = false
        
        let btnCancel = UIButton()
        btnCancel.translatesAutoresizingMaskIntoConstraints = false
        btnCancel.setTitle("Hủy", for: .normal)
        btnCancel.backgroundColor = UIColor.red
        btnCancel.setTitleColor(.white, for: .normal)
        btnCancel.layer.cornerRadius = 10
        rightView.addSubview(btnCancel)
        let tapCancelRequest = UITapGestureRecognizer(target: self, action: #selector(self.cancelRequest))
        btnCancel.addGestureRecognizer(tapCancelRequest)
        btnCancel.isUserInteractionEnabled = true
        btnCancel.centerYAnchor.constraint(equalTo: rightView.centerYAnchor).isActive = true
        btnCancel.centerXAnchor.constraint(equalTo: rightView.centerXAnchor).isActive = true
        btnCancel.heightAnchor.constraint(equalTo: rightView.heightAnchor, multiplier: 2/3).isActive = true
        btnCancel.widthAnchor.constraint(equalTo: rightView.widthAnchor, multiplier: 2/3).isActive = true
        
        var arr: [UIView] = []
        if(headerItem!.statusCode == "O"){
            arr = [leftView,rightView]
        }else if(headerItem!.statusCode == "D"){
            btnCancel.widthAnchor.constraint(equalTo: rightView.widthAnchor, multiplier: 2/6).isActive = true
            arr =  [rightView]
        }
        let stackView = UIStackView(arrangedSubviews: arr)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        footerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: footerView.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: footerView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: footerView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: footerView.bottomAnchor).isActive = true


        
        tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.register(DetailYCDCCell.self, forCellReuseIdentifier: "DetailYCDCCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = UIColor(netHex: 0xEEEEEE)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.tableFooterView = UIView()

        APIManager.detailYCDC(soYCDC: "\(headerItem!.docEntry)") { (results) in
            self.list.append(contentsOf: results)
            self.tableView.reloadData()
        }
    
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func btnWithImage(image: UIImage, title: String, color: UIColor) -> UIView
    {
        let btnCancel = UIView()
        btnCancel.backgroundColor = color
        btnCancel.layer.cornerRadius = 10
        let icBtn = UIImageView(frame: CGRect(x: btnCancel.frame.size.height/4, y: btnCancel.frame.size.height/4, width: btnCancel.frame.size.height/2, height: btnCancel.frame.size.height/2))
        icBtn.image = image
        icBtn.contentMode = .scaleAspectFit
        icBtn.tintColor = .white
        btnCancel.addSubview(icBtn)
        
        let lbBtn = UILabel(frame: CGRect(x: icBtn.frame.size.width
                                            + icBtn.frame.origin.x, y: 0, width: btnCancel.frame.size.width - (icBtn.frame.size.width + icBtn.frame.origin.x + btnCancel.frame.size.height/4), height: btnCancel.frame.size.height))
        lbBtn.textAlignment = .center
        lbBtn.textColor = UIColor.white
        lbBtn.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbBtn.text = title
        btnCancel.addSubview(lbBtn)
        return btnCancel
    }
    @objc func sendRequest(){
        var body: [HeaderRequestApproledYCDC] = []
        for item in self.list {
            let itm = HeaderRequestApproledYCDC(itemCode: item.u_ItmCod, whscode: item.u_WhsCodeEx, quantity: Int(Double(item.u_Qutity) ?? 0), quantity_Ap: item.quantity_Ap)
            body.append(itm)
        }
        let request = RequestApproledYCDC(user: "\(Cache.user!.UserName)", shopCode: "\(Cache.user!.ShopCode)", soYCDC: "\(headerItem!.docEntry)", os: "2", details: body)
        
        let newViewController = LoadingViewController();
        newViewController.content = "Đang duyệt YCDC..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.parentNavigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        APIManager.approledYCDC(param: request) { (result, message, erro) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(result == "200"){
                    self.showAlertOneButton(title: "Thông báo", with: "\(message!)", titleButton: "OK") {
                        self.actionBack()
                    }
                }else{
                    self.showAlertOneButton(title: "Thông báo", with: "\(message!)", titleButton: "OK")
                }
            }
        }
    }
    @objc func cancelRequest(){
        
        let newViewController = LoadingViewController();
        newViewController.content = "Đang hủy YCDC..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.parentNavigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        APIManager.cancelYCDC(soYCDC:  "\(headerItem!.docEntry)", remark: "") { (result, message, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(result == "200"){
                    self.showAlertOneButton(title: "Thông báo", with: "\(message!)", titleButton: "OK") {
//                        self.onCancelYCDC?(true)
                        self.actionBack()
                    }
                }else{
                    self.showAlertOneButton(title: "Thông báo", with: "Có lỗi xẩy ra khi hủy YCDC!", titleButton: "OK")
                }
            }
        }
    }
}
extension ChiTietDuyetYCDCViewController: UITableViewDelegate, UITableViewDataSource,DetailDuyetYCDCCellDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DetailDuyetYCDCCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "DetailDuyetYCDCCell")
        cell.selectionStyle = .none
        cell.delegate = self
        cell.setUpCell(item: list[indexPath.row],index:indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Common.Size(s: 140)
    }
    
    func didUpdateAmount(index: Int, value: Int) {
        let val = Int(Double(list[index].u_Qutity) ?? 0)
        print("AA \(index) \(value) \(val)")
        if(list.count > 0){
            if(0 <= value && value <= val){
                list[index].quantity_Ap = value
            }
        }
        tableView.reloadData()
    }
    
}
protocol DetailDuyetYCDCCellDelegate: AnyObject {
    func didUpdateAmount(index: Int, value: Int)
}
class DetailDuyetYCDCCell: UITableViewCell {
    
    var lblName = UILabel()
    var lblTextWhsRec = UILabel()
    var lblWhsRec = UILabel()
    var lblTextWhsEx = UILabel()
    var lblWhsEx = UILabel()
    var lblTextAmount = UILabel()
    var lblAmount = UILabel()
    var lblTextValueAmount = UILabel()
    var tfAmount = UITextField()
    
    var viewCell = UIView()
    var line = UIView()
    var lblNum = UILabel()
    weak var delegate: DetailDuyetYCDCCellDelegate?
    func setUpCell(item: DetailYCDC, index: Int){
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = .clear
        viewCell.frame =  CGRect(x: Common.Size(s: 5), y: Common.Size(s: 2.5), width: UIScreen.main.bounds.width - Common.Size(s: 10), height: Common.Size(s: 135))
        viewCell.backgroundColor = .white
        viewCell.layer.cornerRadius = 5
        self.contentView.addSubview(viewCell)
        
        lblNum.frame =  CGRect(x: Common.Size(s: 10), y: Common.Size(s: 10), width: Common.Size(s: 25), height: Common.Size(s: 25))
        lblNum.text = "\(item.lineId)"
        lblNum.textColor = .white
        lblNum.font = UIFont.boldSystemFont(ofSize: 20)
        lblNum.backgroundColor = UIColor(netHex:0x00955E)
        lblNum.numberOfLines = 1
        lblNum.textAlignment = .center
        lblNum.layer.cornerRadius = lblNum.frame.size.height/2
        lblNum.clipsToBounds = true
        viewCell.addSubview(lblNum)
    
        lblName.frame =  CGRect(x: lblNum.frame.origin.x + lblNum.frame.size.width + Common.Size(s: 5), y: Common.Size(s: 5), width: viewCell.frame.size.width - (lblNum.frame.origin.x + lblNum.frame.size.width + Common.Size(s: 10)), height: Common.Size(s: 30))
        lblName.text = "\(item.u_ItmCod) - \(item.u_ItmNam)".uppercased()
        lblName.textColor = UIColor(netHex:0x00955E)
        lblName.font = UIFont.boldSystemFont(ofSize: 14)
        lblName.numberOfLines = 2
        viewCell.addSubview(lblName)
        
        lblTextWhsRec.frame =  CGRect(x: Common.Size(s: 10), y: lblNum.frame.origin.y + lblNum.frame.size.height + Common.Size(s: 5), width: viewCell.frame.size.width/3.5, height: Common.Size(s: 15))
        lblTextWhsRec.text = "Kho xin:"
        lblTextWhsRec.textColor = UIColor.black
        lblTextWhsRec.textAlignment = .left
        lblTextWhsRec.font = UIFont.systemFont(ofSize: 15)
        viewCell.addSubview(lblTextWhsRec)
        
        lblWhsRec.frame =  CGRect(x: lblTextWhsRec.frame.origin.x + lblTextWhsRec.frame.size.width, y: lblTextWhsRec.frame.origin.y , width: viewCell.frame.size.width - (lblTextWhsRec.frame.origin.x + lblTextWhsRec.frame.size.width + Common.Size(s: 10)), height: Common.Size(s: 15))
        lblWhsRec.text = "\(item.u_WhsRec)"
        lblWhsRec.textColor = UIColor.black
        lblWhsRec.textAlignment = .left
        lblWhsRec.font = UIFont.boldSystemFont(ofSize: 15)
        viewCell.addSubview(lblWhsRec)
        
        lblTextWhsEx.frame =  CGRect(x: lblTextWhsRec.frame.origin.x, y: lblTextWhsRec.frame.origin.y + lblTextWhsRec.frame.size.height + Common.Size(s: 5), width: lblTextWhsRec.frame.size.width, height: lblTextWhsRec.frame.size.height)
        lblTextWhsEx.text = "Kho xuất:"
        lblTextWhsEx.textColor = UIColor.black
        lblTextWhsEx.textAlignment = .left
        lblTextWhsEx.font = UIFont.systemFont(ofSize: 15)
        viewCell.addSubview(lblTextWhsEx)
        
        lblWhsEx.frame =  CGRect(x: lblTextWhsEx.frame.origin.x + lblTextWhsEx.frame.size.width, y: lblTextWhsEx.frame.origin.y , width: viewCell.frame.size.width - (lblTextWhsEx.frame.origin.x + lblTextWhsEx.frame.size.width + Common.Size(s: 10)), height: Common.Size(s: 15))
        lblWhsEx.text = "\(item.u_WhsEx)"
        lblWhsEx.textColor = UIColor.black
        lblWhsEx.textAlignment = .left
        lblWhsEx.font = UIFont.boldSystemFont(ofSize: 15)
        viewCell.addSubview(lblWhsEx)
        
        lblTextAmount.frame =  CGRect(x: lblTextWhsEx.frame.origin.x, y: lblTextWhsEx.frame.origin.y + lblTextWhsEx.frame.size.height + Common.Size(s: 5), width: lblTextWhsEx.frame.size.width, height: lblTextWhsEx.frame.size.height)
        lblTextAmount.text = "Số lượng xin:"
        lblTextAmount.textColor = UIColor.black
        lblTextAmount.textAlignment = .left
        lblTextAmount.font = UIFont.systemFont(ofSize: 15)
        viewCell.addSubview(lblTextAmount)
        
        lblAmount.frame =  CGRect(x: lblTextAmount.frame.origin.x + lblTextAmount.frame.size.width, y: lblTextAmount.frame.origin.y , width: viewCell.frame.size.width - (lblTextAmount.frame.origin.x + lblTextAmount.frame.size.width + Common.Size(s: 10)), height: Common.Size(s: 15))
        lblAmount.text = "\(Int(Double(item.u_Qutity) ?? 0))"
        lblAmount.textColor = UIColor.black
        lblAmount.textAlignment = .left
        lblAmount.font = UIFont.boldSystemFont(ofSize: 15)
        viewCell.addSubview(lblAmount)
        
        lblTextValueAmount.frame =  CGRect(x: lblTextAmount.frame.origin.x, y: lblTextAmount.frame.origin.y + lblTextAmount.frame.size.height + Common.Size(s: 10), width: lblTextAmount.frame.size.width, height: lblTextAmount.frame.size.height)
        lblTextValueAmount.text = "Số lượng cho:"
        lblTextValueAmount.textColor = UIColor.black
        lblTextValueAmount.textAlignment = .left
        lblTextValueAmount.font = UIFont.systemFont(ofSize: 15)
        viewCell.addSubview(lblTextValueAmount)
        
        tfAmount.frame =  CGRect(x: lblTextValueAmount.frame.origin.x + lblTextValueAmount.frame.size.width, y: lblTextAmount.frame.origin.y + lblTextAmount.frame.size.height + Common.Size(s: 5) , width: Common.Size(s: 25) * 3, height: Common.Size(s: 25))
        tfAmount.text = "\(item.quantity_Ap)"
        tfAmount.placeholder = "Số lượng"
        tfAmount.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        tfAmount.borderStyle = UITextField.BorderStyle.roundedRect
        tfAmount.autocorrectionType = UITextAutocorrectionType.no
        tfAmount.keyboardType = UIKeyboardType.numberPad
        tfAmount.returnKeyType = UIReturnKeyType.done
        tfAmount.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfAmount.textAlignment = .center
        viewCell.addSubview(tfAmount)
        tfAmount.tag = index
        tfAmount.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                                    for: .editingChanged)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        let getTag = textField.tag
        let valueString = textField.text ?? "0"
        if(valueString != ""){
            delegate?.didUpdateAmount(index: getTag, value: Int(valueString) ?? 0)
        }
        
    }
}

