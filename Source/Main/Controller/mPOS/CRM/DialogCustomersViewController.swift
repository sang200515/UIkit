//
//  DialogCustomersViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
protocol DialogCustomersDelegate: NSObjectProtocol {
    
    func selectCustomerViettel(client:ClientViettel,inputSim:InputSimViettel)
    func cancelCustomerViettel()
    func createCustomerViettel(inputSim:InputSimViettel)
    
}
class DialogCustomersViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate{
    
    var scrollView:UIScrollView!
    var boxViewLogin:UIView!
    var tfBarcode:UITextField!
    var taskNotes: UITextView!
    var placeholderLabel : UILabel!
    
    var listSession:[ClientViettel]?
    var inputSim:InputSimViettel?
    var delegate:DialogCustomersDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        /*-*/
        
        /*-*/
        boxViewLogin = UIView(frame:CGRect(x: Common.Size(s:20), y: UIScreen.main.bounds.size.height/2 - Common.Size(s:200)/2, width: UIScreen.main.bounds.size.width - Common.Size(s:40) , height: Common.Size(s:200)))
        boxViewLogin.backgroundColor = .white
        self.view.addSubview(boxViewLogin)
        
        let lbTitleName =  UILabel(frame:CGRect(x:0,y: 0 ,width: boxViewLogin.frame.size.width ,height: Common.Size(s:40)))
        lbTitleName.backgroundColor = UIColor(netHex:0x47B054)
        lbTitleName.textColor = UIColor.white
        lbTitleName.numberOfLines = 1
        lbTitleName.text = "Chọn CMND kích hoạt"
        lbTitleName.textAlignment = .center
        lbTitleName.font = UIFont.boldSystemFont(ofSize: Common.Size(s:18))
        boxViewLogin.addSubview(lbTitleName)
        
        scrollView = UIScrollView(frame: CGRect(x:0,y:lbTitleName.frame.size.height + lbTitleName.frame.origin.y,width:boxViewLogin.frame.size.width,height:0))
        scrollView.contentSize = CGSize(width:boxViewLogin.frame.size.width, height: 0)
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.showsHorizontalScrollIndicator = false
        //        scrollView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        boxViewLogin.addSubview(scrollView)
        boxViewLogin.backgroundColor = UIColor.white
        
        var yCell:CGFloat = 0
        var sizeScroll:CGFloat = 0
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd/MM/yyyy"
        
        for index in 0..<listSession!.count{
            
            let item = listSession![index]
            
            let cell = UIView(frame:CGRect(x: 0, y: yCell, width: boxViewLogin.frame.size.width, height:0))
            scrollView.addSubview(cell)
            cell.backgroundColor = UIColor.white
            cell.tag = index
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            
            cell.addGestureRecognizer(tap)
            
            cell.isUserInteractionEnabled = true
            
            let lbTitle =  UILabel(frame:CGRect(x:Common.Size(s:5),y: Common.Size(s:3) ,width: boxViewLogin.frame.size.width -  Common.Size(s:10) ,height: Common.Size(s:16)))
            lbTitle.textColor = .black
            lbTitle.numberOfLines = 1
            lbTitle.text = "CMND: \(item.custIdNo)"
            lbTitle.textAlignment = .left
            lbTitle.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
            cell.addSubview(lbTitle)
            
            let fullcustIssueDate = item.custIssueDate.components(separatedBy: "T")
            let custIssueDate = fullcustIssueDate[0]
            
            var dateIssueDate = ""
            if(custIssueDate != ""){
                let issueDate =  dateFormatter.date(from: custIssueDate)
                dateIssueDate = dateFormatter2.string(from: issueDate!)
            }
            
            let lbIssueDate =  UILabel(frame:CGRect(x:Common.Size(s:5),y: lbTitle.frame.size.height + lbTitle.frame.origin.y ,width: boxViewLogin.frame.size.width -  Common.Size(s:10) ,height: Common.Size(s:16)))
            lbIssueDate.textColor = .black
            lbIssueDate.numberOfLines = 1
            lbIssueDate.text = "Ngày cấp: \(dateIssueDate)"
            lbIssueDate.textAlignment = .left
            lbIssueDate.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            cell.addSubview(lbIssueDate)
            
            let lbIssuePlace =  UILabel(frame:CGRect(x:Common.Size(s:5),y: lbIssueDate.frame.size.height + lbIssueDate.frame.origin.y ,width: boxViewLogin.frame.size.width -  Common.Size(s:10) ,height: Common.Size(s:16)))
            lbIssuePlace.textColor = .black
            lbIssuePlace.numberOfLines = 1
            lbIssuePlace.text = "Nơi cấp: \(item.custIssuePlace)"
            lbIssuePlace.textAlignment = .left
            lbIssuePlace.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            cell.addSubview(lbIssuePlace)
            
            let fullNameArr = item.custBirthday.components(separatedBy: "T")
            let date1 = fullNameArr[0]
            var dateBirthday = ""
            if(date1 != ""){
                let birthday =  dateFormatter.date(from: date1)
                dateBirthday = dateFormatter2.string(from: birthday!)
            }
            let lbBirthday =  UILabel(frame:CGRect(x:Common.Size(s:5),y: lbIssuePlace.frame.size.height + lbIssuePlace.frame.origin.y ,width: boxViewLogin.frame.size.width -  Common.Size(s:10) ,height: Common.Size(s:16)))
            lbBirthday.textColor = .black
            lbBirthday.numberOfLines = 1
            lbBirthday.text = "Ngày sinh: \(dateBirthday)"
            lbBirthday.textAlignment = .left
            lbBirthday.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            cell.addSubview(lbBirthday)
            
            let lbAddress =  UILabel(frame:CGRect(x:Common.Size(s:5),y: lbBirthday.frame.size.height + lbBirthday.frame.origin.y ,width: boxViewLogin.frame.size.width -  Common.Size(s:10) ,height: Common.Size(s:16)))
            lbAddress.textColor = .black
            lbAddress.numberOfLines = 1
            lbAddress.text = "Đ/c: \(item.custAddress)"
            lbAddress.textAlignment = .left
            lbAddress.font = UIFont.systemFont(ofSize: Common.Size(s:12))
            cell.addSubview(lbAddress)
            
            let line = UIView(frame:CGRect(x: 0, y: lbAddress.frame.size.height + lbAddress.frame.origin.y  + Common.Size(s: 5), width: boxViewLogin.frame.size.width, height: Common.Size(s:0.5)))
            line.backgroundColor =  UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            cell.addSubview(line)
            
            cell.frame.size.height = line.frame.size.height + line.frame.origin.y
            
            yCell = yCell + cell.frame.size.height;
            
            if(index < 3){
                sizeScroll = yCell
                scrollView.frame.size.height = sizeScroll
            }
        }
        scrollView.contentSize = CGSize(width:boxViewLogin.frame.size.width, height: yCell)
        boxViewLogin.layer.cornerRadius = 5
        
        let viewFooter = UIView(frame: CGRect(x: 0 , y: scrollView.frame.origin.y  + scrollView.frame.size.height, width: boxViewLogin.frame.size.width, height: Common.Size(s:41)))
        viewFooter.backgroundColor = UIColor(netHex:0x47B054)
        boxViewLogin.addSubview(viewFooter)
        boxViewLogin.frame.size.height = viewFooter.frame.size.height + viewFooter.frame.origin.y
        boxViewLogin.frame.origin.y = self.view.frame.size.height/2 - boxViewLogin.frame.size.height/2
        
        let lbTitleCancel =  UILabel(frame:CGRect(x:viewFooter.frame.size.width * 2/3,y: 0 ,width: viewFooter.frame.size.width / 3,height: Common.Size(s:40)))
        lbTitleCancel.backgroundColor = UIColor.white
        lbTitleCancel.textColor = UIColor.darkGray
        lbTitleCancel.numberOfLines = 1
        lbTitleCancel.text = "Huỷ"
        lbTitleCancel.textAlignment = .center
        lbTitleCancel.font = UIFont.systemFont(ofSize: Common.Size(s:18))
        viewFooter.addSubview(lbTitleCancel)
        
        let lbTitleCreate =  UILabel(frame:CGRect(x:0,y: 0 ,width: viewFooter.frame.size.width * 2/3,height: Common.Size(s:40)))
        lbTitleCreate.backgroundColor = UIColor.white
        lbTitleCreate.textColor = UIColor.darkGray
        lbTitleCreate.numberOfLines = 1
        lbTitleCreate.text = "Tạo mới"
        lbTitleCreate.textAlignment = .center
        lbTitleCreate.font = UIFont.systemFont(ofSize: Common.Size(s:18))
        viewFooter.addSubview(lbTitleCreate)
        
        let tapCancel = UITapGestureRecognizer(target: self, action: #selector(DialogCustomersViewController.actionCancel))
        lbTitleCancel.isUserInteractionEnabled = true
        lbTitleCancel.addGestureRecognizer(tapCancel)
        
        let tapCreate = UITapGestureRecognizer(target: self, action: #selector(DialogCustomersViewController.actionCreate))
        lbTitleCreate.isUserInteractionEnabled = true
        lbTitleCreate.addGestureRecognizer(tapCreate)
        
    }
    @objc func actionCreate(sender:UITapGestureRecognizer) {
        delegate?.createCustomerViettel(inputSim:self.inputSim!)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func actionCancel(sender:UITapGestureRecognizer) {
        delegate?.cancelCustomerViettel()
        self.dismiss(animated: true, completion: nil)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let button = sender.view {
            let item = listSession![button.tag]
            delegate?.selectCustomerViettel(client:item,inputSim:self.inputSim!)
            self.dismiss(animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

