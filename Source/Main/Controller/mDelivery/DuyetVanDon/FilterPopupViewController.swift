//
//  FilterPopupViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 02/07/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ActionSheetPicker_3_0
import DropDown
class FilterPopupViewController: UIViewController,UITextFieldDelegate
{
    var viewBox: UIView!
    var heightNavigation: CGFloat = 0
    var fromDateView: CustomViewDate!
    var valueToDate: String = ""
    var valueFromDate: String = ""
    var fromField,toField: UITextField!
    var dropDown = DropDown()
    var listNhaVanChuyen: [NhaVanChuyen] = []
    var selectNhaVanChuyen:NhaVanChuyen?
    
    let btnPending = UIButton()
    let btnApproved = UIButton()
    let btnReject = UIButton()
    
    //Trạng thái C: Đã Duyet, K: Từ chối duyệt, N: Chưa duyệt
    var arrayStatus: [String] = ["N","C","K"]
    var arrayBtnStatus: [UIButton] = []
    var selectStatus: String = ""
    let shopReView = CustomViewDate()
    let shopExView = CustomViewDate()
    var selectShopRe: ItemShop?
    var selectShopEx: ItemShop?
    
    var filter: ((String,String,String,String,String,String) -> (Void))?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let viewBoxDimiss = UIView(frame: CGRect(x:0, y: 0, width:  width/3, height: height))
        viewBoxDimiss.backgroundColor = .clear
        self.view.addSubview(viewBoxDimiss)
        
        viewBox = UIView(frame: CGRect(x: width/3, y: 0, width:  width * 2/3, height: height))
        viewBox.backgroundColor = .white
        self.view.addSubview(viewBox)
        
        print("heightNavigation \(heightNavigation)")
        
        let header = UIView()
//        header.backgroundColor = .red
        viewBox.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.leftAnchor.constraint(equalTo: self.viewBox.leftAnchor).isActive = true
        header.topAnchor.constraint(equalTo: self.viewBox.topAnchor).isActive = true
        header.rightAnchor.constraint(equalTo: self.viewBox.rightAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: heightNavigation).isActive = true
        
        let lbSearch = UILabel()
        header.addSubview(lbSearch)
        lbSearch.translatesAutoresizingMaskIntoConstraints = false
        lbSearch.leftAnchor.constraint(equalTo: header.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        lbSearch.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        lbSearch.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        lbSearch.text = "Tìm kiếm"
        lbSearch.textColor = UIColor.black
        lbSearch.font = UIFont.boldSystemFont(ofSize: 25)
        
        let lbFrom = UILabel()
        lbFrom.text = "Từ ngày:"
        lbFrom.textColor = UIColor.black
        lbFrom.font = UIFont.boldSystemFont(ofSize: 14)
        viewBox.addSubview(lbFrom)
        lbFrom.translatesAutoresizingMaskIntoConstraints = false
        lbFrom.leftAnchor.constraint(equalTo: header.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        lbFrom.topAnchor.constraint(equalTo: header.bottomAnchor,constant: Common.Size(s: 10)).isActive = true
        lbFrom.widthAnchor.constraint(equalTo: viewBox.widthAnchor, multiplier: 1/3.5).isActive = true
        lbFrom.heightAnchor.constraint(equalToConstant: Common.Size(s: 25)).isActive = true
        
        fromField = UITextField()
        fromField.placeholder = "Từ ngày"
        fromField.backgroundColor = .white
        fromField.layer.cornerRadius = 5
        fromField.layer.borderWidth = 0.5
        fromField.layer.borderColor = UIColor.lightGray.cgColor
        fromField.delegate = self
        fromField.leftViewMode = .always
        
        let timeImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let timeImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        timeImageView.image = #imageLiteral(resourceName: "birthday")
        timeImageViewWrapper.addSubview(timeImageView)
        fromField.leftView = timeImageViewWrapper
        
        viewBox.addSubview(fromField)
        fromField.translatesAutoresizingMaskIntoConstraints = false
        fromField.leftAnchor.constraint(equalTo: lbFrom.rightAnchor).isActive = true
        fromField.topAnchor.constraint(equalTo: lbFrom.topAnchor).isActive = true
        fromField.rightAnchor.constraint(equalTo: viewBox.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        fromField.heightAnchor.constraint(equalToConstant: Common.Size(s: 25)).isActive = true
        
        let tapFromField = UITapGestureRecognizer(target: self, action: #selector(self.tapFromField))
        fromField.addGestureRecognizer(tapFromField)
        fromField.isUserInteractionEnabled = true
        
        let lbTo = UILabel()
        lbTo.text = "Đến ngày:"
        lbTo.textColor = UIColor.black
        lbTo.font = UIFont.boldSystemFont(ofSize: 14)
        viewBox.addSubview(lbTo)
        lbTo.translatesAutoresizingMaskIntoConstraints = false
        lbTo.leftAnchor.constraint(equalTo: lbFrom.leftAnchor).isActive = true
        lbTo.topAnchor.constraint(equalTo: lbFrom.bottomAnchor,constant: Common.Size(s: 10)).isActive = true
        lbTo.widthAnchor.constraint(equalTo: lbFrom.widthAnchor).isActive = true
        lbTo.heightAnchor.constraint(equalTo: lbFrom.heightAnchor).isActive = true
        
        toField = UITextField()
        toField.placeholder = "Đến ngày"
        toField.backgroundColor = .white
        toField.layer.cornerRadius = 5
        toField.layer.borderWidth = 0.5
        toField.layer.borderColor = UIColor.lightGray.cgColor
        toField.delegate = self
        let timeToImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let timeToImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        timeToImageView.image = #imageLiteral(resourceName: "birthday")
        timeToImageViewWrapper.addSubview(timeToImageView)
        
        toField.leftViewMode = .always
        toField.leftView = timeToImageViewWrapper
        viewBox.addSubview(toField)
        toField.translatesAutoresizingMaskIntoConstraints = false
        toField.leftAnchor.constraint(equalTo: fromField.leftAnchor).isActive = true
        toField.topAnchor.constraint(equalTo: lbTo.topAnchor).isActive = true
        toField.rightAnchor.constraint(equalTo: fromField.rightAnchor).isActive = true
        toField.heightAnchor.constraint(equalTo: fromField.heightAnchor).isActive = true
        let tapToField = UITapGestureRecognizer(target: self, action: #selector(self.tapToField))
        toField.addGestureRecognizer(tapToField)
        toField.isUserInteractionEnabled = true
        
        
        let lbTransporters = UILabel()
        lbTransporters.text = "Nhà vận chuyển:"
        lbTransporters.textColor = UIColor.black
        lbTransporters.font = UIFont.boldSystemFont(ofSize: 14)
        viewBox.addSubview(lbTransporters)
        lbTransporters.translatesAutoresizingMaskIntoConstraints = false
        lbTransporters.leftAnchor.constraint(equalTo: lbTo.leftAnchor).isActive = true
        lbTransporters.topAnchor.constraint(equalTo: lbTo.bottomAnchor, constant: Common.Size(s: 10)).isActive = true
        lbTransporters.rightAnchor.constraint(equalTo: fromField.rightAnchor).isActive = true
        
        
        fromDateView = CustomViewDate()
        fromDateView.date.text = " Chọn nhà vận chuyển"
        fromDateView.date.textAlignment = .left
        viewBox.addSubview(fromDateView)
        fromDateView.translatesAutoresizingMaskIntoConstraints = false
        fromDateView.leftAnchor.constraint(equalTo: lbTo.leftAnchor).isActive = true
        fromDateView.topAnchor.constraint(equalTo: lbTransporters.bottomAnchor,constant: Common.Size(s: 10)).isActive = true
        fromDateView.heightAnchor.constraint(equalToConstant: Common.Size(s: 25)).isActive = true
        fromDateView.rightAnchor.constraint(equalTo: fromField.rightAnchor).isActive = true
        
        let tapFromDate = UITapGestureRecognizer(target: self, action: #selector(self.searchNVC))
        fromDateView.addGestureRecognizer(tapFromDate)
        fromDateView.isUserInteractionEnabled = true
        
        DropDown.setupDefaultAppearance()
        dropDown.anchorView = fromDateView
        viewBox.addSubview(dropDown)
        
        
        let lbStatus = UILabel()
        lbStatus.text = "Trạng thái:"
        lbStatus.textColor = UIColor.black
        lbStatus.font = UIFont.boldSystemFont(ofSize: 14)
        viewBox.addSubview(lbStatus)
        lbStatus.translatesAutoresizingMaskIntoConstraints = false
        lbStatus.leftAnchor.constraint(equalTo: lbFrom.leftAnchor).isActive = true
        lbStatus.topAnchor.constraint(equalTo: fromDateView.bottomAnchor,constant: Common.Size(s: 10)).isActive = true
        lbStatus.rightAnchor.constraint(equalTo: fromField.rightAnchor).isActive = true
        
        
        let status1View = UIView()
        status1View.translatesAutoresizingMaskIntoConstraints = false
        
       
        btnPending.translatesAutoresizingMaskIntoConstraints = false
        status1View.addSubview(btnPending)
        btnPending.setTitle("Chờ duyệt", for: .normal)
        btnPending.backgroundColor = .white
        btnPending.setTitleColor(UIColor(netHex:0x00955E), for: .normal)
        btnPending.layer.borderWidth = 1
        btnPending.layer.borderColor =  UIColor(netHex:0x00955E).cgColor
        btnPending.layer.cornerRadius = 10
        btnPending.topAnchor.constraint(equalTo: status1View.topAnchor).isActive = true
        btnPending.leftAnchor.constraint(equalTo: status1View.leftAnchor).isActive = true
        btnPending.heightAnchor.constraint(equalTo: status1View.heightAnchor).isActive = true
        btnPending.rightAnchor.constraint(equalTo: status1View.rightAnchor,constant: Common.Size(s: -2.5)).isActive = true
        btnPending.tag = 1
        btnPending.addTarget(self, action: #selector(status1Action), for: .touchUpInside)
        arrayBtnStatus.append(btnPending)
        let status2View = UIView()
        status2View.translatesAutoresizingMaskIntoConstraints = false
        
       
        btnApproved.translatesAutoresizingMaskIntoConstraints = false
        status2View.addSubview(btnApproved)
        btnApproved.setTitle("Đã duyệt", for: .normal)
        btnApproved.backgroundColor = .white
        btnApproved.setTitleColor(UIColor(netHex:0x00955E), for: .normal)
        btnApproved.layer.borderWidth = 1
        btnApproved.layer.borderColor =  UIColor(netHex:0x00955E).cgColor
        btnApproved.layer.cornerRadius = 10
        btnApproved.topAnchor.constraint(equalTo: status2View.topAnchor).isActive = true
        btnApproved.leftAnchor.constraint(equalTo: status2View.leftAnchor,constant: Common.Size(s: 2.5)).isActive = true
        btnApproved.heightAnchor.constraint(equalTo: status2View.heightAnchor).isActive = true
        btnApproved.rightAnchor.constraint(equalTo: status2View.rightAnchor).isActive = true
        btnApproved.tag = 2
        btnApproved.addTarget(self, action: #selector(status2Action), for: .touchUpInside)
        arrayBtnStatus.append(btnApproved)
        let status3View = UIView()
        status3View.translatesAutoresizingMaskIntoConstraints = false
      
        btnReject.translatesAutoresizingMaskIntoConstraints = false
        status3View.addSubview(btnReject)
        btnReject.setTitle("Từ chối", for: .normal)
        btnReject.backgroundColor = .white
        btnReject.setTitleColor(UIColor(netHex:0x00955E), for: .normal)
        btnReject.layer.borderWidth = 1
        btnReject.layer.borderColor =  UIColor(netHex:0x00955E).cgColor
        
        btnReject.layer.cornerRadius = 10
        btnReject.topAnchor.constraint(equalTo: status3View.topAnchor).isActive = true
        btnReject.leftAnchor.constraint(equalTo: status3View.leftAnchor).isActive = true
        btnReject.heightAnchor.constraint(equalTo: status3View.heightAnchor).isActive = true
        btnReject.rightAnchor.constraint(equalTo: status3View.rightAnchor,constant: Common.Size(s: -2.5)).isActive = true
        btnReject.tag = 3
        btnReject.addTarget(self, action: #selector(status3Action), for: .touchUpInside)
        arrayBtnStatus.append(btnReject)
        let status4View = UIView()
        status4View.translatesAutoresizingMaskIntoConstraints = false
        
        let stackStatusView1 = UIStackView(arrangedSubviews: [status1View,status2View])
        stackStatusView1.axis = .horizontal
        stackStatusView1.distribution = .fillEqually
        viewBox.addSubview(stackStatusView1)
        stackStatusView1.translatesAutoresizingMaskIntoConstraints = false
        stackStatusView1.topAnchor.constraint(equalTo: lbStatus.bottomAnchor,constant: Common.Size(s: 10)).isActive = true
        stackStatusView1.leftAnchor.constraint(equalTo: viewBox.leftAnchor,constant: Common.Size(s: 10)).isActive = true
        stackStatusView1.heightAnchor.constraint(equalToConstant: Common.Size(s: 25)).isActive = true
        stackStatusView1.rightAnchor.constraint(equalTo: viewBox.rightAnchor,constant: Common.Size(s: -10)).isActive = true
        
        let stackStatusView2 = UIStackView(arrangedSubviews: [status3View,status4View])
        stackStatusView2.axis = .horizontal
        stackStatusView2.distribution = .fillEqually
        viewBox.addSubview(stackStatusView2)
        stackStatusView2.translatesAutoresizingMaskIntoConstraints = false
        stackStatusView2.topAnchor.constraint(equalTo: stackStatusView1.bottomAnchor,constant: Common.Size(s: 5)).isActive = true
        stackStatusView2.leftAnchor.constraint(equalTo: stackStatusView1.leftAnchor).isActive = true
        stackStatusView2.heightAnchor.constraint(equalTo: stackStatusView1.heightAnchor).isActive = true
        stackStatusView2.rightAnchor.constraint(equalTo: stackStatusView1.rightAnchor).isActive = true
        
        
        let lbShopEx = UILabel()
        lbShopEx.text = "Cửa hàng xuất:"
        lbShopEx.textColor = UIColor.black
        lbShopEx.font = UIFont.boldSystemFont(ofSize: 14)
        viewBox.addSubview(lbShopEx)
        lbShopEx.translatesAutoresizingMaskIntoConstraints = false
        lbShopEx.leftAnchor.constraint(equalTo: stackStatusView2.leftAnchor).isActive = true
        lbShopEx.topAnchor.constraint(equalTo: stackStatusView2.bottomAnchor,constant: Common.Size(s: 10)).isActive = true
        lbShopEx.rightAnchor.constraint(equalTo: stackStatusView2.rightAnchor).isActive = true
        
        
     
//        shopExView.date.text = " Chọn shop"
        shopExView.date.text = " \(Cache.user!.ShopName)"
        shopExView.date.textAlignment = .left
        viewBox.addSubview(shopExView)
        shopExView.translatesAutoresizingMaskIntoConstraints = false
        shopExView.leftAnchor.constraint(equalTo: lbShopEx.leftAnchor).isActive = true
        shopExView.topAnchor.constraint(equalTo: lbShopEx.bottomAnchor,constant: Common.Size(s: 10)).isActive = true
        shopExView.heightAnchor.constraint(equalToConstant: Common.Size(s: 25)).isActive = true
        shopExView.rightAnchor.constraint(equalTo: lbShopEx.rightAnchor).isActive = true
        
//        let tapSelectShopEx = UITapGestureRecognizer(target: self, action: #selector(self.tapSelectShopEx))
//        shopExView.addGestureRecognizer(tapSelectShopEx)
//        shopExView.isUserInteractionEnabled = true
        
        
        let lbShopRe = UILabel()
        lbShopRe.text = "Cửa hàng nhận:"
        lbShopRe.textColor = UIColor.black
        lbShopRe.font = UIFont.boldSystemFont(ofSize: 14)
        viewBox.addSubview(lbShopRe)
        lbShopRe.translatesAutoresizingMaskIntoConstraints = false
        lbShopRe.leftAnchor.constraint(equalTo: stackStatusView2.leftAnchor).isActive = true
        lbShopRe.topAnchor.constraint(equalTo: shopExView.bottomAnchor,constant: Common.Size(s: 10)).isActive = true
        lbShopRe.rightAnchor.constraint(equalTo: stackStatusView2.rightAnchor).isActive = true
        
        
        shopReView.date.text = " Chọn shop"
        shopReView.date.textAlignment = .left
        viewBox.addSubview(shopReView)
        shopReView.translatesAutoresizingMaskIntoConstraints = false
        shopReView.leftAnchor.constraint(equalTo: lbShopEx.leftAnchor).isActive = true
        shopReView.topAnchor.constraint(equalTo: lbShopRe.bottomAnchor,constant: Common.Size(s: 10)).isActive = true
        shopReView.heightAnchor.constraint(equalToConstant: Common.Size(s: 25)).isActive = true
        shopReView.rightAnchor.constraint(equalTo: lbShopEx.rightAnchor).isActive = true
        
        let tapSelectShopRe = UITapGestureRecognizer(target: self, action: #selector(self.tapSelectShopRe))
        shopReView.addGestureRecognizer(tapSelectShopRe)
        shopReView.isUserInteractionEnabled = true
        
        
        let btnSearch = UIButton()
        btnSearch.translatesAutoresizingMaskIntoConstraints = false
        viewBox.addSubview(btnSearch)
        btnSearch.setTitle("Tìm kiếm", for: .normal)
        btnSearch.backgroundColor = UIColor(netHex:0x00955E)
        btnSearch.setTitleColor(.white, for: .normal)
        btnSearch.layer.cornerRadius = 10
        btnSearch.topAnchor.constraint(equalTo: shopReView.bottomAnchor,constant: Common.Size(s: 20)).isActive = true
        btnSearch.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        btnSearch.widthAnchor.constraint(equalTo: viewBox.widthAnchor, multiplier: 1/2).isActive = true
        btnSearch.centerXAnchor.constraint(equalTo: viewBox.centerXAnchor).isActive = true
        btnSearch.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.closeDialog))
        viewBoxDimiss.addGestureRecognizer(gesture)
        
        APIManager.nhaVanChuyen() { (results) in
            var rs: [String] = ["Chọn nhà vận chuyển"]
            for i in 0..<results.count {
                rs.append(results[i].name)
            }
            self.dropDown.dataSource = rs
            self.listNhaVanChuyen = results
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.fromDateView.date.text = " \(item)"
            if(index > 0){
                self.selectNhaVanChuyen = listNhaVanChuyen[index - 1]
            }else{
                self.selectNhaVanChuyen = nil
            }
        }
    }
    @objc func tapSelectShopEx(){
        let newViewController = SearchShopViewController()
        newViewController.selectShop = { [weak self] (result) in
            self?.shopExView.date.text = " \(result.name)"
            self?.selectShopEx = result
        }
        self.present(newViewController, animated: false, completion: nil)
    }
    @objc func tapSelectShopRe(){
        let newViewController = SearchShopViewController()
        newViewController.selectShop = { [weak self] (result) in
            self?.shopReView.date.text = " \(result.name)"
            self?.selectShopRe = result
        }
        self.present(newViewController, animated: false, completion: nil)
    }
    @objc func searchAction(sender: UIButton!) {
        let nvc = selectNhaVanChuyen != nil ? selectNhaVanChuyen!.code : ""
//        let shopEx = selectShopEx != nil ? selectShopEx!.code : ""
        let shopEx = "\(Cache.user!.ShopCode)"
        let shopRe = selectShopRe != nil ? selectShopRe!.code : ""
        self.filter?(valueFromDate,valueToDate,nvc,selectStatus,shopRe,shopEx)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func status1Action(sender: UIButton!) {
        let tag = sender.tag
        actionStatus(tag: tag)
    }
    @objc func status2Action(sender: UIButton!) {
        let tag = sender.tag
        actionStatus(tag: tag)
    }
    @objc func status3Action(sender: UIButton!) {
        let tag = sender.tag
        actionStatus(tag: tag)
    }
    func actionStatus(tag: Int){
        selectStatus = arrayStatus[tag - 1]
        for i in 0..<arrayBtnStatus.count {
            if(tag == arrayBtnStatus[i].tag){
                arrayBtnStatus[i].backgroundColor = UIColor(netHex:0x00955E)
                arrayBtnStatus[i].setTitleColor(.white, for: .normal)
                arrayBtnStatus[i].layer.borderWidth = 1
                arrayBtnStatus[i].layer.borderColor =  UIColor(netHex:0x00955E).cgColor
            }else{
                arrayBtnStatus[i].backgroundColor = .white
                arrayBtnStatus[i].setTitleColor(UIColor(netHex:0x00955E), for: .normal)
                arrayBtnStatus[i].layer.borderWidth = 1
                arrayBtnStatus[i].layer.borderColor =  UIColor(netHex:0x00955E).cgColor
            }
        }
    }
    @objc func searchNVC()
    {
        dropDown.show()
    }
    @objc func closeDialog(sender : UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
        self.view.endEditing(true)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    @objc func tapFromField()
    {
        let datePicker = ActionSheetDatePicker(title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strDate = dateFormatter.string(from: value as! Date)
            self.fromField.text = "\(strDate)"
            self.valueFromDate = self.formatDate2(date: value as! Date)
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        datePicker?.maximumDate = Date()
        datePicker?.show()
    }
    @objc func tapToField()
    {
        let datePicker = ActionSheetDatePicker(title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(), doneBlock: {
            picker, value, index in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strDate = dateFormatter.string(from: value as! Date)
            self.toField.text = "\(strDate)"
            self.valueToDate = self.formatDate2(date: value as! Date)
            
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
        datePicker?.maximumDate = Date()
        datePicker?.show()
    }
    func formatDate2(date:Date) -> String{
        let deFormatter = DateFormatter()
        deFormatter.dateFormat = "yyyy-MM-dd"
        return deFormatter.string(from: date)
    }
}
