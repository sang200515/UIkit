//
//  HuyHopDongMiraeViewController.swift
//  fptshop
//
//  Created by tan on 6/9/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class HuyHopDongMiraeViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate {
    var scrollView:UIScrollView!
    var tfLyDoHuy:SearchTextField!
    var tfGhiChu:UITextView!
    var history:HistoryOrderByUser?
    var listReason:[ReasonCancelMirae] = []
    var selectReason:String = ""
    override func viewDidLoad() {
        self.title = "Nhập lý do huỷ"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(HuyHopDongMiraeViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let lbLyDo = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbLyDo.textAlignment = .left
        lbLyDo.textColor = UIColor.black
        lbLyDo.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbLyDo.text = "Lý do huỷ"
        scrollView.addSubview(lbLyDo)
        
        
        
        //
        tfLyDoHuy = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lbLyDo.frame.origin.y + lbLyDo.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30) , height:Common.Size(s:40)));
        tfLyDoHuy.placeholder = "Chọn lý do huỷ"
        tfLyDoHuy.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfLyDoHuy.borderStyle = UITextField.BorderStyle.roundedRect
        tfLyDoHuy.autocorrectionType = UITextAutocorrectionType.no
        tfLyDoHuy.keyboardType = UIKeyboardType.default
        tfLyDoHuy.returnKeyType = UIReturnKeyType.done
        tfLyDoHuy.clearButtonMode = UITextField.ViewMode.whileEditing
        tfLyDoHuy.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfLyDoHuy.delegate = self
        
        scrollView.addSubview(tfLyDoHuy)
        
        // Start visible - Default: false
        tfLyDoHuy.startVisible = true
        tfLyDoHuy.theme.bgColor = UIColor.white
        tfLyDoHuy.theme.fontColor = UIColor.black
        tfLyDoHuy.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfLyDoHuy.theme.cellHeight = Common.Size(s:40)
        tfLyDoHuy.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        tfLyDoHuy.leftViewMode = UITextField.ViewMode.always
        
        tfLyDoHuy.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfLyDoHuy.text = item.title
            let obj =  self.listReason.filter{ $0.Name == "\(item.title)" }.first
            if let obj = obj?.ID {
                self.selectReason = "\(obj)"
            }
            
        }
        //
        
        let lbGhiChu = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfLyDoHuy.frame.origin.y + tfLyDoHuy.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbGhiChu.textAlignment = .left
        lbGhiChu.textColor = UIColor.black
        lbGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbGhiChu.text = "Ghi chú"
        scrollView.addSubview(lbGhiChu)
        
        
        tfGhiChu = UITextView(frame: CGRect(x:  Common.Size(s:15) , y: lbGhiChu.frame.origin.y  + lbGhiChu.frame.size.height + Common.Size(s:10), width: tfLyDoHuy.frame.size.width, height: tfLyDoHuy.frame.size.height * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        tfGhiChu.layer.borderWidth = 0.5
        tfGhiChu.layer.borderColor = borderColor.cgColor
        tfGhiChu.layer.cornerRadius = 5.0
        tfGhiChu.delegate = self
        tfGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        scrollView.addSubview(tfGhiChu)
        
        let btXacNhan = UIButton()
        btXacNhan.frame = CGRect(x: Common.Size(s:15), y: tfGhiChu.frame.origin.y + tfGhiChu.frame.size.height + Common.Size(s:10), width: tfLyDoHuy.frame.size.width, height: tfLyDoHuy.frame.size.height * 1.1)
        btXacNhan.backgroundColor = UIColor(netHex:0x00955E)
        btXacNhan.setTitle("Xác Nhận", for: .normal)
        btXacNhan.addTarget(self, action: #selector(actionXacNhan), for: .touchUpInside)
        btXacNhan.layer.borderWidth = 0.5
        btXacNhan.layer.borderColor = UIColor.white.cgColor
        btXacNhan.layer.cornerRadius = 5.0
        scrollView.addSubview(btXacNhan)
        
        
        MPOSAPIManager.mpos_FRT_SP_mirae_loadreasoncance() {[weak self] (results, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    self.listReason = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Name)
                    }
                    self.tfLyDoHuy.filterStrings(list)
                    
                    
                }else{
                    
                }
            }
            
            
        }
        
    }
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func actionXacNhan(){
        //
        // Prepare the popup
        let title = "CHÚ Ý"
        let message = "Bạn có muốn huỷ hợp đồng!"
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        
        // Create first button
        let buttonOne = CancelButton(title: "Cancel") {
            
        }
        let buttonTwo = DefaultButton(title: "OK"){
            if(self.selectReason == "" || self.tfLyDoHuy.text! == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng chọn lý do huỷ !", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    self.tfLyDoHuy.becomeFirstResponder()
                })
                self.present(alert, animated: true)
                
                return
            }
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang huỷ hợp đồng..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            
            MPOSAPIManager.mpos_FRT_SP_mirae_cance_hopdong(IDMPOS:"\(self.history!.Docentry)",reason: "\(self.selectReason)",note:self.tfGhiChu.text!,processId_Mirae:"\(self.history!.processId_Mirae)") { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        let alert = UIAlertController(title: "Thông báo", message: results[0].p_messagess, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            _ = self.navigationController?.popToRootViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                            let nc = NotificationCenter.default
                            nc.post(name: Notification.Name("SearchCMNDMirae"), object: nil)
                        })
                        self.present(alert, animated: true)
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                }
            }
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonTwo,buttonOne])
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
        //
        
        
        
        
        
    }
}
